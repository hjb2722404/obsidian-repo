AngularJS中的依赖注入非常的有用，它同时也是我们能够轻松对组件进行测试的关键所在。在本文中我们将会解释AngularJS依赖注入系统是如何运行的。

Provider服务（$provide）
--------------------

$provide服务负责告诉Angular如何创造一个新的可注入的东西：即服务(service)。服务会被叫做provider的东西来定 义，你可以使用$provide来创建一个provider。你需要使用$provide中的provider方法来定义一个provider，同时你也 可以通过要求改服务被注入到一个应用的config函数中来获得$provide服务。下面是一个例子：

```null
app.config(function($provide) {
  $provide.provider('greeting', function() {
this.$get = function() {
  return function(name) {
alert("Hello, " + name);
  };
};
  });
});  
```

在上面的例子中我们为一个服务定义了一个叫做greeting的新provider；我么可以把一个叫做greeting的变量注入到任何可注入的 函数中（例如控制器，在后面会讲到）然后Angular就会调用这个provider的$get函数来返回这个服务的一个实例。在上面的例子中，被注入的 是一个函数，它接受一个叫做name的参数并且根据这个参数alert一条信息。我们可以像下面这样使用它：

```null
app.controller('MainController', function($scope, greeting) {
  $scope.onClick = function() {
greeting('Ford Prefect');
  };
}); 
```

现在有趣的事情来了。factory，service以及value全部都是用来定义一个providr的简写，它们提供了一种方式来定义一个provider而无需输入所有的复杂的代码。例如，你可以用下面的代码定义一个和前面完全相同的provider：

```null
app.config(function($provide) {
  $provide.factory('greeting', function() {
return function(name) {
  alert("Hello, " + name);
};
  });
});  
```

这非常的重要，所以一定要记住：在幕后，AngularJS实际上是在调用前面出现的代码（就是$provide.provider的版本）。从字 面上来说，这两种方法基本上没有差别。value方法也一样 – 如果我们需要从$get函数（也就是我们的factory函数）返回的值永远相同的话，我们可以使用value方法来编写更少的代码。例如如果我们的 greeting服务总是返回相同的函数，我们可以使用value来进行定义：

```null
app.config(function($provide) {
  $provide.value('greeting', function(name) {
alert("Hello, " + name);
  });
});  
```

再一次申明，以上两种方式的效果完全一样 – 只不过是代码的量不同而已。

现在你可能已经注意到了我们使用的烦人的

```null
app.config(function($provide){...})  
```

代码了。由于定义一个新的provider是如此的常用，AngularJS在模块对象上直接暴露了provider方法，以此来减少代码的输入量：

```null
var myMod = angular.module('myModule', []);

myMod.provider("greeting", ...);
myMod.factory("greeting", ...);
myMod.value("greeting", ...);  
```

上面的代码和前面`app.config(...)`这样啰嗦的写法完全相同。

除了上面提到的可以注入的东西之外，还有一个constant方法。基本上，它和value的用法一致。我们会在后面来讨论两者的不同点。

为了巩固前面的学习成果，下面所有的代码所做的都是同一件事情：

```null
myMod.provider('greeting', function() {
  this.$get = function() {
return function(name) {
  alert("Hello, " + name);
};
  };
});

myMod.factory('greeting', function() {
  return function(name) {
alert("Hello, " + name);
  };
});

myMod.value('greeting', function(name) {
  alert("Hello, " + name);
});  
```

注入器（$injector）
--------------

注入器负责从我们通过$provide创建的服务中创建注入的实例。只要你编写了一个带有可注入性的参数，你都能看到注入器是如何运行的。每一个 AngularJS应用都有唯一一个$injector，当应用启动的时候它被创造出来，你可以通过将$injector注入到任何可注入函数中来得到它 （$injector知道如何注入它自己！）。

一旦你拥有了$injector，你可以动过调用get函数来获得任何一个已经被定义过的服务的实例。例如：

```null
var greeting = $injector.get('greeting');
greeting('Ford Prefect');  
```

注入器同样也负责将服务注入到函数中；例如，你可以魔法般的将服务注入到任何函数中，只要你使用了注入器的invoke方法：

```null
var myFunction = function(greeting) {
  greeting('Ford Prefect');
};
$injector.invoke(myFunction);  
```

如果注入器只是创建一个服务的实例一次的话，那么它也没什么了不起的。它的厉害之处在于，他能够通过服务名称缓存从一个provider中返回的任何东西，当你下一次再使用这个服务时，你将会得到同一个对象。

因此，你可以通过调用$injector.invike将服务注入到任何函数中也是合情合理的了。包括：

*   控制器定义函数
*   指令定义函数
*   过滤器定义函数
*   provider中的$get方法（也就是factory函数）

由于constant和value总是返回一个静态值，它们不会通过注入器被调用，因此你不能在其中注入任何东西。

配置provider
----------

你可能会感到困惑：既然factorry和value能够节省那么多的代码，为什么还有人要使用provider。答案是provider允许我们 进行一些配置。在前面我们已经提到过当你通过provider（或者其他简写方法）创建一个服务时，你实际上创建了一个新的provider，它将定义你 的服务如何被创建。我们没有提到的是，这些provider可以被注入到config函数中，你可以和它们进行一些交互。

首先，AngularJS分两个阶段运行你的应用 – config阶段和run阶段。config阶段是你设置任何的provider的阶段。它也是你设置任何的指令，控制器，过滤器以及其它东西的阶段。在 run阶段，AngularJS会编译你的DOM并启动你的应用。

你可以在myMod.config和myMod.run中添加任何代码 – 这两个函数分别在两个阶段运行。正如我们看到的，这些函数都是可以被注入的 – 我们在第一个例子中注入了内建的$provide函数。然而，值得注意的是在config阶段，只有provider能被注入（只有两个例外 是$provide和$injector)。

例如，下面的代码就是错误的写法：

```null
myMod.config(function(greeting) {
 ```

但是你可以通过下面的方法注入provider：

```null
myMod.config(function(greetingProvider) {
 ```

有一个例外：constant，由于它们不能被改变，因此它不能被注入到config中（这就是它和value之间的不同之处）。它们只能通过名字被获取。

无论何时你为一个服务定义了一个provider，这个provider的名字都是serviceProvider。在这里service是服务的名字。现在我们可以使用provider的力量来做一些更复杂的事情了！

```null
myMod.provider('greeting', function() {
  var text = 'Hello, ';

  this.setText = function(value) {
     text = value;
  };

  this.$get = function() {
     return function(name) {
         alert(text + name);
     };
  };
});

myMod.config(function(greetingProvider) {
  greetingProvider.setText("Howdy there, ");
});

myMod.run(function(greeting) {
  greeting('Ford Prefect');
});
```

现在我们在provider中拥有了一个叫做setText的函数，我们可以使用它来自定义我们alert的内容；我们可以再config中访问这 个provider，调用setText方法并自定义我们的service。当我们最终运行我们的应用时，我们可以获取greeting服务，然后你会看 到我们自定义的行为起作用了。

控制器($controller)
----------------

控制器函数是可以被注入的，但是控制器本身是不能被注入到任何东西里面去的。这是因为控制器不是通过provider创建的。然而，有一个内建的 AngularJS服务叫做1$controller，它负责设置你的控制器。当你调用myMod.controller(…)时，你实际上是访问了这个 服务的provider，就像上面的例子一样。

例如，当你像下面一样定义了一个控制器时：

```null
myMod.controller('MainController', function($scope) {
 ```

你实际上做的是下面这件事：

```null
myMod.config(function($controllerProvider) {
  $controllerProvider.register('MainController', function($scope) {```

当Angular需要创建一个你的控制的实例时，它会使用$controller服务（它反过来会使用$injector来调用你的控制器以便它能够被注入依赖项）。

过滤器和指令
------

filter和directive和controller的运行方式相同；filter会使用一个叫做$filter的服务以及它的 provider $filterProvider，而directive使用一个叫做$compile的服务以及它的provider $compileProvidr。下面是相应的文档：

*   $filter: [http://docs.angularjs.org/api/ng.$filter](http://docs.angularjs.org/api/ng.$filter)
*   $filterProvider: [http://docs.angularjs.org/api/ng.$filterProvider](http://docs.angularjs.org/api/ng.$filterProvider)
*   $compile: [http://docs.angularjs.org/api/ng.$compile](http://docs.angularjs.org/api/ng.$compile)
*   $compileProvider: [http://docs.angularjs.org/api/ng.$compileProvider](http://docs.angularjs.org/api/ng.$compileProvider)

其中，myMod.filter和myMod.directive分别是这些服务的简写。

总结
--

总结一下，任何能够被$injector.invoke调用的函数都是能被注入的。包括，但不限于下面的这些：

*   控制器
*   指令
*   factory
*   过滤器
*   provider中的$get函数
*   provider函数
*   服务

provider创建的新服务都可以用来注入。包括：

*   constant
*   factory
*   provider
*   service
*   value

另外，内建的服务$controller和$filter也可以被注入，同时你也可以使用这些服务来获得新的过滤器和控制器。
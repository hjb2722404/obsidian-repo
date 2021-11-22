翻译：深入理解Angular 1.5 中的生命周期钩子 - Jocs的前端之路 - SegmentFault 思否

 [ ![2314227278-5997c78f45e52_big64](../_resources/6c26acd89d699eca716902b87b96d882.jpg)     **Jocs**](https://segmentfault.com/u/jocs)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='1'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='183' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  125

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='2'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='187' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/Jocs)

[![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-comment-alt-lines fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='comment-alt-lines' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='5'%3e%3cpath fill='currentColor' d='M448 0H64C28.7 0 0 28.7 0 64v288c0 35.3 28.7 64 64 64h96v84c0 7.1 5.8 12 12 12 2.4 0 4.9-.7 7.1-2.4L304 416h144c35.3 0 64-28.7 64-64V64c0-35.3-28.7-64-64-64zm16 352c0 8.8-7.2 16-16 16H288l-12.8 9.6L208 428v-60H64c-8.8 0-16-7.2-16-16V64c0-8.8 7.2-16 16-16h384c8.8 0 16 7.2 16 16v288zm-96-216H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h224c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16zm-96 96H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h128c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16z' data-evernote-id='198' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://segmentfault.com/a/1190000005868488#comment-area)

#   [翻译：深入理解Angular 1.5 中的生命周期钩子](https://segmentfault.com/a/1190000005868488)

[angularjs](https://segmentfault.com/t/angularjs)

 发布于 2016-07-04

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

文章翻译自：https://toddmotto.com/angular-1-5-lifecycle-hooks
讨论可以访问issue：https://github.com/Jocs/jocs.github.io/issues/3

生命周期钩子是一些简单的函数，这些函数会在Angular应用组件特定生命周期被调用。生命周期钩子在Angular 1.5版本被引入，通常与.component()方法一起使用，并在接下来的几个版本中演变，并包含了更多有用的钩子函数（受Angular 2的启发）。让我们深入研究这些钩子函数并实际使用它们吧。这些钩子函数所带来的作用以及为什么我们需要使用它们，对于我们深入理解通过组件架构的应用具有重要的意义。

在Angular v1.3.0+版本，我自己实现了`.component()` 方法，该方法深刻得洞悉了怎么去使用这些生命周期函数以及这些函数在组件中的作用，让我们开始研究它吧。

### [$onInit](https://toddmotto.com/angular-1-5-lifecycle-hooks#oninit)

什么是`$onInit` ？首先，他是Angular组件(译注：通过`.component()` 方法定义的组件)控制器中暴露出来的一个属性，我们可以把一个函数赋值给该属性：

	var myComponent = {
	  bindings: {},
	  controller: function () {
	    this.$onInit = function() {

	    };
	  }
	};

	angular
	  .module('app')
	  .component('myComponent', myComponent);

##### [Using $onInit](https://toddmotto.com/angular-1-5-lifecycle-hooks#using-oninit)

`$onInit` 生命周期钩子用作控制器的初始化工作，下面举个常用例子：

	var myComponent = {
	  ...
	  controller: function () {
	    this.foo = 'bar';
	    this.bar = 'foo';
	    this.fooBar = function () {

	    };
	  }
	};

注意上面的代码，我们把所有的属性直接赋值到了this上面，它们就像“浮在”控制器的各个角落。现在，让我们通过`$onInit` 来重写上面代码：

	var myComponent = {
	  ...
	  controller: function () {
	    this.$onInit = function () {
	      this.foo = 'bar';
	      this.bar = 'foo';
	    };
	    this.fooBar = function () {
	      console.log(this.foo); *// 'bar'*
	    };
	  }
	};

上面的数据明显地通过硬编码写入的，但是在实际的应用中，我们通常是通过`bindings: {}` 对象来把我们需要的数据传递到组件中，我们使用`$onInit` 来进行一些初始化工作，这样就把以前那些“浮在”控制器各处的初始化变量都集中起来了，`$onInit` 就像是控制器中的`constructor` ,包含了一些初始化信息。

对于`this.fooBar`函数呢？不要着急，该函数放在`$onInit`外面是完全能够访问到初始化数据的，比如当你调用`this.fooBar`的时候，函数会打印出`this.foo`的值，也就是在`$onInit`函数中定义的`'bar'`。因此所有你初始化的数据都正确地绑定到了控制器的`this` 上下文中。

##### [$onInit + “require”](https://toddmotto.com/angular-1-5-lifecycle-hooks#oninit--require)

因为这些生命周期钩子定义得如此优雅（不同的生命周期钩子都在组件的不同生命周期被调用），一个组件也可以从另外的组件中继承方法，甚至继承的方法在`$onInit` 钩子中就可以直接使用。

首先我们需要思考的是如何使用`require`，我写过另外一篇深入介绍[$onInit 和 require](https://toddmotto.com/on-init-require-object-syntax-angular-component/)的文章，但是在此我依然会简要介绍一些`require`的基本用法，随后将提供一个完整的实例。

让我们来看看`myComponent`的例子，在这儿`require`后面紧跟的是一个对象（只在`.component()`方法中require字段后面接对象），当`require`和`.directive()`结合使用的时候，require字段后面也可以跟数组或者字符串语法形式。

	var myComponent = {
	  ...
	  require: {
	    parent: '^^anotherComponent'
	  },
	  controller: function () {
	    this.$onInit = function () {
	      this.foo = 'bar';
	      this.bar = 'foo';
	    };
	    this.fooBar = function () {
	      console.log(this.foo); *// 'bar'*
	    };
	  }
	};

如上面的例子，`require`被设置为`^^anotherComponent`，`require`值前面`^^`表示自会在当前组件的父组件中搜寻`anotherComponent`控制器，（如果`require`值前面是`^`那么首先会在当前组件搜寻是否有该控制器，如果没有再在其父组件中搜寻）这样我们就可以在`$onInit`中使用任何当定在父组件中的方法了。

	var myComponent = {
	  ...
	  require: {
	    parent: '^^anotherComponent'
	  },
	  controller: function () {
	    this.$onInit = function () {
	      this.foo = 'bar';
	      this.bar = 'foo';
	      this.parent.sayHi();
	    };
	    this.fooBar = function () {
	      console.log(this.foo); *// 'bar'*
	    };
	  }
	};

注意，在Angular 1.5.6版本（见 [CHANGELOG](https://github.com/angular/angular.js/blob/master/CHANGELOG.md#156-arrow-stringification-2016-05-27)）中，如果require对象中属性名和require的控制器同名，那么就可以省略控制器名。这一特性并没有带来给功能带来很大的改变，我们可以如下使用它：

	var myComponent = {
	  ...
	  require: {
	    parent: '^^'
	  },
	  controller: function () {
	    ...
	  }
	};

正如你所见，我们完全省略了需要requre的控制器名而直接使用`^^`替代。完整写法`^^parent`就被省略为`^^`。需要谨记，在前面的一个例子中，我们只能使用`parent: '^^anotherComponent'`来表示我们需要使用另外一个组件中控制器中的方法（译者注：作者以上就是控制器和requre的属性名不相同时，不能够省略），最后，我们只需记住一点，如果我们想使用该条特性，那么被requre的控制器名必须和require的属性名同名。

##### [Real world $onInit + require](https://toddmotto.com/angular-1-5-lifecycle-hooks#real-world-oninit--require)

让我们使用`$onInit`和`require`来实现一个`tabs`组件，首先我们实现的组件大概如如下使用：

	<tabs>
	  <tab label="Tab 1">
	    Tab 1 contents!
	   </tab>
	   <tab label="Tab 2">
	    Tab 2 contents!
	   </tab>
	   <tab label="Tab 3">
	    Tab 3 contents!
	   </tab>
	</tabs>

这意味着我们需要两个组件，`tab`和`tabs`。我们将`transclude`所有的`tabs`子元素（就是所有`tab`模板中的`tabs`元素）然后通过`bindings`绑定的对象来获取`label`值。

首先，组件定义了每个组件都必须使用的一些属性：

	var tab = {
	  bindings: {},
	  require: {},
	  transclude: true,
	  template: ``,
	  controller: function () {}
	};

	var tabs = {
	  transclude: true,
	  template: ``,
	  controller: function () {}
	};

	angular
	  .module('app', [])
	  .component('tab', tab)
	  .component('tabs', tabs);

`tab`组件需要通过`bindings`绑定一些数据，同时在该组件中，我们使用了`require`,`transclude`和一个`template` ,最后是一个控制器`controller`。

`tabs`组件首先会`transclude`所有的元素到模板中，然后通过`controller`来对`tabs`进行管理。
让我们来实现`tab`组件的模板吧：

	var tab = {
	  ...
	  template: `
	    <div class="tabs__content" ng-if="$ctrl.tab.selected">
	      <div ng-transclude></div>
	    </div>
	  `,
	  ...
	};

对于`tab`组件而言，我们只在`$ctrl.tab.selected`为`true`的时候显示该组件，因此我们需要一些在控制器中添加一些逻辑来处理该需求。随后我们通过`transclude`来对`tab`组件中的内容填充。（这些内容就是展示在不同tab内的）

	var tabs = {
	  ...
	  template: `
	    <div class="tabs">
	      <ul class="tabs__list">
	        <li ng-repeat="tab in $ctrl.tabs">
	          <a href=""
	            ng-bind="tab.label"
	            ng-click="$ctrl.selectTab($index);"></a>
	        </li>
	      </ul>
	      <div class="tabs__content" ng-transclude></div>
	    </div>
	  `,
	  ...
	};

对于`tabs`组件，我们创建一个数组来展示`$ctrl.tabs`内容，并对每一个tab选项卡绑定click事件处理函数`$ctrl.selectTab()`，在调用该方法是传入当前`$index`。同时我们`transclude`所有的子节点（所有的`<tab>`元素）到`.tabs_content`容器中。

接下来让我们来处理`tab`组件的控制器，我们将创建一个`this.tab`属性，当然初始化该属性应该放在`$onInit`钩子函数中：

	var tab = {
	  bindings: {
	    label: '@'
	  },
	  ...
	  template: `
	    <div class="tabs__content" ng-if="$ctrl.tab.selected">
	      <div ng-transclude></div>
	    </div>
	  `,
	  controller: function () {
	    this.$onInit = function () {
	      this.tab = {
	        label: this.label,
	        selected: false
	      };
	    };
	  }
	  ...
	};

你可以看到我在控制器中使用了`this.label`，因为我们在组件中添加了`bindings: {label: '@'}`，这样我们就可以使用`this.label`来获取绑定到`<tab>`组件`label`属性上面的值了（字符串形式）。通过这样的绑定形式我们就可以把不同的值映射到不同的`tab`组件上。

接下来让我们来看看`tabs`组件控制器中的逻辑，这可能稍微有点复杂：

	var tabs = {
	  ...
	  template: `
	    <div class="tabs">
	      <ul class="tabs__list">
	        <li ng-repeat="tab in $ctrl.tabs">
	          <a href=""
	            ng-bind="tab.label"
	            ng-click="$ctrl.selectTab($index);"></a>
	        </li>
	      </ul>
	      <div class="tabs__content" ng-transclude></div>
	    </div>
	  `,
	  controller: function () {
	    this.$onInit = function () {
	      this.tabs = [];
	    };
	    this.addTab = function addTab(tab) {
	      this.tabs.push(tab);
	    };
	    this.selectTab = function selectTab(index) {
	      for (var i = 0; i < this.tabs.length; i++) {
	        this.tabs[i].selected = false;
	      }
	      this.tabs[index].selected = true;
	    };
	  },
	  ...
	};

我们在`$onInit`钩子处理函数中初始化`this.tabs = []`，我们已经知道`$onInit`用来初始化属性值，接下来我们定义了两个函数，`addTab`和`selectTab`。`addTab`函数我们会通过require传递到每一个子组件中，通过这种形式来告诉父组件子组件的存在，同时保存一份对每个tab的引用，这样我们就可以通过`ng-repeat`来遍历所有的tab选项卡，并且可以点击（通过`selectTab`）选择不同的选项卡。

接下来我们通过`tab`组件的`require`来将`addTab`方法委派到`tab`组件中使用。

	var tab = {
	  ...
	  require: {
	    tabs: '^^'
	  },
	  ...
	};

正如我们在文章关于`$onInit`和`require`部分提到，我们通过`^^`来只requre父组件控制器中的逻辑而不在自身组件中寻找这些方法。除此之外，当我们require的控制器名和requre对象中的属性名相同时我们还可以省略requre的控制器名字，这是版本1.5.6新增加的一个特性。关于这一新特性准备好了吗？在下面代码中，我们使用`tabs: '^^'`，我们有一个和require控制器同名的属性名`{tabs: ...}`，这样我们就可以在`$onInit`中使用`this.tabs`来调用父组件控制器中的方法了。

	var tab = {
	  ...
	  require: {
	    tabs: '^^'
	  },
	  controller: function () {
	    this.$onInit = function () {
	      this.tab = {
	        label: this.label,
	        selected: false
	      };
	      *// this.tabs === require: { tabs: '^^' }*
	      this.tabs.addTab(this.tab);
	    };
	  }
	  ...
	};

把所有代码放一起：

	var tab = {
	  bindings: {
	    label: '@'
	  },
	  require: {
	    tabs: '^^'
	  },
	  transclude: true,
	  template: `
	    <div class="tabs__content" ng-if="$ctrl.tab.selected">
	      <div ng-transclude></div>
	    </div>
	  `,
	  controller: function () {
	    this.$onInit = function () {
	      this.tab = {
	        label: this.label,
	        selected: false
	      };
	      this.tabs.addTab(this.tab);
	    };
	  }
	};

	var tabs = {
	  transclude: true,
	  controller: function () {
	    this.$onInit = function () {
	      this.tabs = [];
	    };
	    this.addTab = function addTab(tab) {
	      this.tabs.push(tab);
	    };
	    this.selectTab = function selectTab(index) {
	      for (var i = 0; i < this.tabs.length; i++) {
	        this.tabs[i].selected = false;
	      }
	      this.tabs[index].selected = true;
	    };
	  },
	  template: `
	    <div class="tabs">
	      <ul class="tabs__list">
	        <li ng-repeat="tab in $ctrl.tabs">
	          <a href=""
	            ng-bind="tab.label"
	            ng-click="$ctrl.selectTab($index);"></a>
	        </li>
	      </ul>
	      <div class="tabs__content" ng-transclude></div>
	    </div>
	  `
	};

点击选项卡相应内容就会呈现出来，当时，我们并没有设置一个初始化的展示的选项卡？这就是接下来`$postLink`要介绍的内容。

### [$postLink](https://toddmotto.com/angular-1-5-lifecycle-hooks#postlink)

我们已经知道，`compile`函数会返回一个`pre`和`post`‘链接函数’，如如下形式：

	function myDirective() {
	  restrict: 'E',
	  scope: { foo: '=' },
	  compile: function compile($element, $attrs) {
	    return {
	      pre: function preLink($scope, $element, $attrs) {
	        *// access to child elements that are NOT linked*
	      },
	      post: function postLink($scope, $element, $attrs) {
	        *// access to child elements that are linked*
	      }
	    };
	  }
	}

你也可能知道如下：

	function myDirective() {
	  restrict: 'E',
	  scope: { foo: '=' },
	  link: function postLink($scope, $element, $attrs) {
	    *// access to child elements that are linked*
	  }
	}

当我们只需要使用`postLink`函数的时候，上面两种形式效果是一样的。注意我们使用的`post: function)() {...}` - 这就是我们的主角。我已经在上面的代码中添加了一行注释“可以获取到已经链接的子元素”，上面的注释意味着在父指令的post 函数中，子元素的模板已经被编译并且已经被链接到特定的scope上。而通过`compile`和`pre`函数我们是无法获取到已经编译、链接后的子元素的。因此我们有一个生命周期钩子来帮我我们在编译的最后阶段（子元素已经被编译和链接）来处理一些相应逻辑。

##### [Using $postLink](https://toddmotto.com/angular-1-5-lifecycle-hooks#using-postlink)

`$postLink`给予了我们处理如上需求的可能，我们不需使用一些hack的范式就可以像如下形式一样使用`$postLink`钩子函数。

	var myComponent = {
	  ...
	  controller: function () {
	    this.$postLink = function () {
	      *// fire away...*
	    };
	  }
	};

我们已经知道，`$postLink`是在所有的子元素被链接后触发，接下来让我们来实现我们的`tabs`组件。

##### [Real world $postLink](https://toddmotto.com/angular-1-5-lifecycle-hooks#real-world-postlink)

我们可以通过`$postLink`函数来给我们的选项卡组件一个初始的选项卡。首先我们需要调整一下模板：

	<tabs selected="0">
	  <tab label="Tab 1">...</tab>
	  <tab label="Tab 2">...</tab>
	  <tab label="Tab 3">...</tab>
	</tabs>

现在我们就可以通过`bindings`获取到`selected`特性的值，然后用以初始化：

	var tabs = {
	  bindings: {
	    selected: '@'
	  },
	  ...
	  controller: function () {
	    this.$onInit = function () {
	      this.tabs = [];
	    };
	    this.addTab = function addTab(tab) {
	      this.tabs.push(tab);
	    };
	    this.selectTab = function selectTab(index) {
	      for (var i = 0; i < this.tabs.length; i++) {
	        this.tabs[i].selected = false;
	      }
	      this.tabs[index].selected = true;
	    };
	    this.$postLink = function () {
	      *// use `this.selected` passed down from bindings: {}*
	      *// a safer option would be to parseInt(this.selected, 10)*
	      *// to coerce to a Number to lookup the Array index, however*
	      *// this works just fine for the demo :)*
	      this.selectTab(this.selected || 0);
	    };
	  },
	  ...
	};

现在我们已经有一个生动的实例，通过`selected`属性来预先选择某一模板，在上面的例子中我们使用`selected=2`来预先选择第三个选项卡作为初始值。

##### [What $postLink is not](https://toddmotto.com/angular-1-5-lifecycle-hooks#what-postlink-is-not)

在`$postLink`函数中并不是一个好的地方用以处理DOM操作。在Angular生态圈外通过原生的事件绑定来为HTML/template扩展行为，Directive依然是最佳选择。不要仅仅将Directive（没有模板的指令）重写为component组件，这些都是不推荐的做法。

那么`$psotLint`存在的意义何在？你可能想在`$postLink`函数中进行DOM操作或者自定义的事件。其实，DOM操作和绑定事件最好使用一个带模板的指令来进行封装。正确地使用`$postLink`，你可以把你的疑问写在下面的评论中，我会很乐意的回复你的疑问。

### [$onChanges](https://toddmotto.com/angular-1-5-lifecycle-hooks#onchanges)

这是一个很大的部分(也是最重要的部分)，`$onChanges`将和Angular 1.5.x中的组件架构及单向数据流一起讨论。一条金玉良言：`$onChanges`在自身组件被改变但是却在父组件中发生的改变（译者注：其实作者这儿说得比较含糊，$onChange就是在单向数据绑定后，父组件向子组件传递的数据发生改变后会被调用）。当父组件中的一些属性发生改变后，通过`bindings: {}`就可以把这种变化传递到子组件中，这就是`$onChanges`的秘密所在。

##### [What calls $onChanges?](https://toddmotto.com/angular-1-5-lifecycle-hooks#what-calls-onchanges)

在以下情况下`$onChanges`会被调用，首先，在组件初始化的时候，组件初始化时会传递最初的`changes`对象，这样我们就可以直接获取到我们所需的数据了。第二种会被调用的场景就是只当单向数据绑定`<`he `@`（用于获取DOM特性值，这些值是通过父组件传递的）改变时会被调用。一旦`$onChanges`被调用，你将在`$onChanges`的参数中获取到一个变化对象，我们将在接下来的部分中详细讨论。

##### [Using $onChanges](https://toddmotto.com/angular-1-5-lifecycle-hooks#using-onchanges)

使用`$onChanges`相当简单，但是该生命周期钩子又通常被错误的使用或谈论，因此我们将在接下来的部分讨论`$onChanges`的使用，首先，我们声明了一个`childConpoment`组件。

	var childComponent = {
	  bindings: { user: '<' },
	  controller: function () {
	    this.$onChanges = function (changes) {
	      *// `changes` is a special instance of a constructor Object,*
	      *// it contains a hash of a change Object and*
	      *// also contains a function called `isFirstChange()`*
	      *// it's implemented in the source code using a constructor Object*
	      *// and prototype method to create the function `isFirstChange()`*
	    };
	  }
	};

	angular
	  .module('app')
	  .component('childComponent', childComponent);

注意，这儿`bindings`对象包含了一个值为`'<'`的`user`字段，该`‘<’`表示了单向数据流，这一点在我以前的 [文章](https://toddmotto.com/one-way-data-binding-in-angular-1-5/)已经提到过，单向数据流会导致`$onChanges`钩子被调用。

但是，正如上面提到，我们需要一个`parentComponent`组件来完成我的实例：

	var parentComponent = {
	  template: `
	    <div>
	      <child-component></child-component>
	    </div>
	  `
	};

	angular
	  .module('app')
	  .component('parentComponent', parentComponent);

需要注意的是：`<child-compoent></component>`组件在`<parent-component></parent-component>`组件中渲染，这就是为什么我们能够初始化一个带有数据的控制器，并且把这些数据传递给`childComponent`:

	var parentComponent = {
	  template: `
	    <div>
	      <a href="" ng-click="$ctrl.changeUser();">
	        Change user (this will call $onChanges in child)
	      </a>
	      <child-component
	          user="$ctrl.user">
	      </child-component>
	    </div>
	  `,
	  controller: function () {
	    this.$onInit = function () {
	        this.user = {
	          name: 'Todd Motto',
	        location: 'England, UK'
	      };
	    };
	    this.changeUser = function () {
	        this.user = {
	          name: 'Tom Delonge',
	        location: 'California, USA'
	      };
	    };
	  }
	};

再次，我们使用`$onInit`来定义一些初始化数据，把一个对象赋值给`this.user`。同时我们有`this.changeUser`函数，用来更新`this.user`的值，这个改变发生在父组件，但是会触发子组件中的`$onChange`钩子函数被调用，父组件的改变通过onChanges来通知子组件，这就是*o**n**C**h**a**n**g**e**s*来通知子组件，这就是onChanges的作用。

现在，让我们来看看`childComponent`组件：

	var childComponent = {
	  bindings: {
	    user: '<'
	  },
	  template: `
	    <div>
	      <pre>{{ $ctrl.user | json }}</pre>
	    </div>
	  `,
	  controller: function () {
	    this.$onChanges = function (changes) {
	      this.user = changes;
	    };
	  }
	};

这儿，我们使用`binding: {user: '<'}`，意味着我们可以通过`user`来接收来自父组件通过单向数据绑定传递的数据，我们在模板中通过`this.user`来展示数据的变化，（我通过使用`| json`过滤器来展示整个对象）

点击按钮来观察`childCompoent`通过`$onChanges`来传播的变化：“我并没有获取到变化？？”像上面的代码，我永远也获取不到，因为我们把整个变化对象都赋值给了`this.user`，让我们修改下上面的代码：

	var childComponent = {
	  ...
	  controller: function () {
	    this.$onChanges = function (changes) {
	      this.user = changes.user.currentValue;
	    };
	  }
	};

现在我们可以使用`user`属性来获取到从父组件传递下来的数据，通过`curentValue`来引用到该数据，也就是change对象上面的curentChange属性，尝试下上面的代码：

##### [Cloning “change” hashes for “immutable” bindings](https://toddmotto.com/angular-1-5-lifecycle-hooks#cloning-change-hashes-for-immutable-bindings)

现在我们已经从组件中获取到从单向数据绑定的数据，我们可以在深入的思考。虽然单项数据绑定并没有被Angular所`$watch`，但是我们是通过引用传递。这意味着子组件对象（特别注意，简单数据类型不是传递引用）属性的改变依然会影响到父组件的相同对象，这就和双向数据绑定的作用一样了，当然这是无意义的。这就是，我们可以通过设计。聪明的通过深拷贝来处理单向数据流传递下来的对象，来使得该对象成为“不可变对象”，也就是说传递下来的对象不会在子组件中被更改。

这个是一个fiddle例子（注意`user | json`）过滤器移到了父组件中（注意，父组件中的对象也随之更新了）
作为替换，我们可以使用 `angular.cocy()`来克隆传递下来的对象，这样就打破了JavaScript对象的“引用传递“：

	var childComponent = {
	  ...
	  controller: function () {
	    this.$onChanges = function (changes) {
	      this.user = angular.copy(changes.user.currentValue);
	    };
	  }
	};

做得更好，我们添加了`if`语句来检测对象的属性是否存在，这是一个很好的实践：

	var childComponent = {
	  ...
	  controller: function () {
	    this.$onChanges = function (changes) {
	      if (changes.user) {
	        this.user = angular.copy(changes.user.currentValue);
	      }
	    };
	  }
	};

甚至我们还可以再优化我们的代码，因为当父组件中数据发生变化，该变化会立即反应在`this.user`上面，随后我们通过深拷贝`changes.user.currentValue`对象，其实这两个对象是相同的，下面两种写法其实是在做同一件事。

	this.$onChanges = function (changes) {
	  if (changes.user) {
	    this.user = angular.copy(this.user);
	    this.user = angular.copy(changes.user.currentValue);
	  }
	};

我更偏向于的途径（使用`angular.copy(this.user)`）。
现在就开始尝试，通过深拷贝开复制从父组件传递下来的对象，然后赋值给子组件控制器相应属性。

感觉还不错吧？现在我们使用拷贝对象，我们可以任意改变对象而不用担心会影响到父组件（对不起，双向数据绑定真的不推荐了！）因此当我们更新数据后，通过事件来通知父组件，单向数据流并不是生命周期钩子的一部分，但是这`$onChanges`钩子被设计出来的意思所在。数据输入和事件输出（输入 = 数据， 输出 = 事件）,让我们使用它吧。

##### [One-way dataflow + events](https://toddmotto.com/angular-1-5-lifecycle-hooks#one-way-dataflow--events)

上面我们讨论了`bindings`和`$onChanges`已经覆盖了单向数据流，现在我们将添加事件来扩展这一单向数据流。

为了使数据能够回流到 `parentComponent`，我们需要委托一个函数作为事件的回调函数，然我们添加一个叫`updateUser`的函数，该函数需要一个`event`最为传递回来的参数，相信我，这样做将会很有意义。

	var parentComponent = {
	  ...
	  controller: function () {
	    ...
	    this.updateUser = function (event) {
	      this.user = event.user;
	    };
	  }
	};

从这我们可以看出，我们期待`event`是一个对象，并且带有一个`user`的属性，也就是从子组件传递回来的值，首先我们需要把该事件回调函数传递到子组件中：

	var parentComponent = {
	  template: `
	    <div>
	      ...
	      <child-component
	        user="$ctrl.user"
	        on-update="$ctrl.updateUser($event);">
	      </child-component>
	    </div>
	  `,
	  controller: function () {
	    ...
	    this.updateUser = function (event) {
	      this.user = event.user;
	    };
	  }
	};

注意我创建了一个带有`on-*`前缀的特性，当我们需要绑定一个事件（想想 onclick/onblur)的时候，这是一个最佳实践。
现在我们已经将该函数传递给了`<child-component>`，我们需要通过`bindings`来获取这一绑定的函数。

	var childComponent = {
	  bindings: {
	    user: '<',
	    onUpdate: '&' *// magic ingredients*
	  },
	  ...
	  controller: function () {
	    this.$onChanges = function (changes) {
	      if (changes.user) {
	        this.user = angular.copy(this.user);
	      }
	    };
	    *// now we can access this.onUpdate();*
	  }
	};

通过`&`,我们可以传递函数，所以我们通过`this.updateUser`字面量来把该函数从父组件传递到子组件，在子组件中更新的数据（通过在`$onChanges`中深拷贝从`bindings`对象中的属性）然后通过传递进来的回调函数来将更新后的数据传递回去，数据从父组件到子组件，然后通过事件回调将更新后的数据通知到父组件。

接下来，我们需要扩展我们的模板来时的用户可以更新深拷贝的数据：

	var childComponent = {
	  ...
	  template: `
	    <div>
	      <input type="text" ng-model="$ctrl.user.name">
	      <a href="" ng-click="$ctrl.saveUser();">Update</a>
	    </div>
	  `,
	  ...
	};

这意味着我们需要在控制器中添加`this.saveUser`方法，让我们添加它：

	var childComponent = {
	  ...
	  template: `
	    <div>
	      <input type="text" ng-model="$ctrl.user.name">
	      <a href="" ng-click="$ctrl.saveUser();">Update</a>
	    </div>
	  `,
	  controller: function () {
	    ...
	    this.saveUser = function () {

	    };
	  }
	};

尽管，当我们在子组件中"保存"的时候，这其实仅仅是父组件回调函数的一个封装，因此我们在子组件中直接调用父组件方法`this.updateUser`(该方法已经绑定到了子组件`onUpdate`属性上)

	var childComponent = {
	  ...
	  controller: function () {
	    ...
	    this.saveUser = function () {
	      *// function reference to "this.updateUser"*
	        this.onUpdate();
	    };
	  }
	};

好的，相信我，我们已经到了最后阶段，这也会使得事情变得更加有趣。相反我们并不是直接把`this.user`传递到回调函数中，而是构建了一个`$event`对象，这就像Angular 2一样（使用`EventEmitter`），这也提供了在模板中使用`$ctrl.updateUser($event)`来获取数据的一致性，这也就可以传递给子组件，`$event`参数在Angular中是真实存在的，你可以通过ng-submit等指令来使用它，你是否还记得如下函数：（译者注：上面这一段翻译需要推敲）

	this.updateUser = function (event) {
	  this.user = event.user;
	};

我们期待event对象带有一个user的属性，好吧，那就让我们来在子组件中`saveUser`方法中添加该属性：

	var childComponent = {
	  ...
	  controller: function () {
	    ...
	    this.saveUser = function () {
	      this.onUpdate({
	        $event: {
	          user: this.user
	        }
	      });
	    };
	  }
	};

上面的代码看上去有些怪异。也许有一点吧，但是他是始终一致的，当你使用十遍以后，你就再也不会停止使用它了。必要的我们需要在子组件中创建`this.saveUser`，然后在该方法中调用从父组件中通过`bindings`传递进来的`this.updateUsser`，接着我们传递给它event对象，来把我们更新后的数据返回给父组件：

尝试如上方式写代码吧：

这儿也有一个免费的教学视频，是我关于`$onChanges`和单向数据流教程的一部分，你可以从这获取到 [check it out here](https://courses.toddmotto.com/products/ultimate-angularjs-master).

##### [Is two-way binding through “=” syntax dead?](https://toddmotto.com/angular-1-5-lifecycle-hooks#is-two-way-binding-through--syntax-dead)

是的，单向数据绑定已经被认为是数据流的最佳方式，React,Angular 2 以及其他的类库都是用单向数据流，现在轮到Angualr 1了，虽然Angular 1加入单向数据流有些晚，但是依然很强大并将改变Angular 1.x应用开发方式。

![](https://toddmotto.com/img/posts/binding-dead.jpg)

##### [Using isFirstChange()](https://toddmotto.com/angular-1-5-lifecycle-hooks#using-isfirstchange)

`$onChanges`还有一个特性，在`changes`hash对象中，该对象其实是`SimpleChange`构造函数的一个实例，该构造函数原型对象上有一个`isFirstChange`方法。

	function SimpleChange(previous, current) {
	  this.previousValue = previous;
	  this.currentValue = current;
	}
	SimpleChange.prototype.isFirstChange = function () {
	  *// don't worry what _UNINITIALIZED_VALUE is :)*
	  return this.previousValue === _UNINITIALIZED_VALUE;
	};

这就是变化对象根据不同的绑定策略怎么被创造出来（通过 `new`关键字）（我以前实现过单向数据绑定，并享受这一过程）

你为什么会想着使用该方法呢？上面我们已经提到过，`$onChanges`会在组件的某给生命周期阶段被调用，不仅在父组件的数据改变时，（译者注：也在数据初始化的时候也会被调用）因此我们可以通过该方法（`isFirstChange`）来判断是非需要跳过初始化阶段，我们可以通过在改变对象的某属性上面调用`isFirstChange`方法来判断`$onChanges`是否是第一次被调用。

	this.$onChanges = function (changes) {
	  if (changes.user.isFirstChange()) {
	    console.log('First change...', changes);
	    return; *// Maybe? Do what you like.*
	  }
	  if (changes.user) {
	    this.user = angular.copy(this.user);
	  }
	};

Here’s [a JSFiddle](https://jsfiddle.net/toddmotto/wLjtL1Lr/) if you want to check the `console`.

### [$onDestroy](https://toddmotto.com/angular-1-5-lifecycle-hooks#ondestroy)

我们最后来讨论下最简单的一个生命周期钩子，`$onDestroy`：

	function SomeController($scope) {
	  $scope.$on('$destroy', function () {
	    *// destroy event*
	  });
	}

##### [Using $onDestroy](https://toddmotto.com/angular-1-5-lifecycle-hooks#using-ondestroy)

你可以猜想到该生命周期钩子怎么使用：

	var childComponent = {
	  bindings: {
	    user: '<'
	  },
	  controller: function () {
	    this.$onDestroy = function () {
	      *// component scope is destroyed*
	    };
	  }
	};

	angular
	  .module('app')
	  .component('childComponent', childComponent);

如果你使用了`$postLink`来设置了DOM事件监听函数或者其他非Angular原生的逻辑，在`$onDestroy`中你可以把这些事件监听或者非原生逻辑清理干净。

### [Conclusion](https://toddmotto.com/angular-1-5-lifecycle-hooks#conclusion)

Angular 1.x 应用开发者的的开发模式也随着单向数据流，生命周期事件及生命周期钩子函数的出现而改变，不久将来我将发布更多关于组件架构的文章。

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

阅读 8.3k  更新于 2016-07-05

本作品系 原创， [采用《署名-非商业性使用-禁止演绎 4.0 国际》许可协议](https://creativecommons.org/licenses/by-nc-nd/4.0/)

* * *

 [![2314227278-5997c78f45e52_big64](../_resources/6c26acd89d699eca716902b87b96d882.jpg)](https://segmentfault.com/u/jocs)

#####   [Jocs](https://segmentfault.com/u/jocs)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='16'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  125

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='17'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z'%3e%3c/path%3e%3c/svg%3e)](https://github.com/Jocs)
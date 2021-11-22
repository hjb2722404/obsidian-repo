跟我学AngularJs:Controller数据共享、继承、通信使用详解_Evankaka的专栏-CSDN博客_angularjs 继承

[![3_evankaka](../_resources/ecb54c8d12d2293741b1cc7888e7b098.png)](https://blog.csdn.net/Evankaka)

[(L)](https://blog.csdn.net/Evankaka)  [Evankaka](https://blog.csdn.net/Evankaka)  ![expert.png](../_resources/22daac0fc88bda45d071592cd08595a7.png)

码龄10年  [![nocErtification.png](../_resources/cc44893427cf71b0f457dc9be488e432.png)暂无认证](https://me.csdn.net/Evankaka?utm_source=14998968)

[一、controller基础与用法](https://blog.csdn.net/Evankaka/article/details/51097039#t0)
[二、controller继承](https://blog.csdn.net/Evankaka/article/details/51097039#t1)

[三、controller之间共享数据](https://blog.csdn.net/Evankaka/article/details/51097039#t2)

[四、controller之间通信](https://blog.csdn.net/Evankaka/article/details/51097039#t3)

[五、 对于controller层的一些建议](https://blog.csdn.net/Evankaka/article/details/51097039#t4)

# 跟我学AngularJs:Controller数据共享、继承、通信使用详解

![original.png](../_resources/8f19bb4e9750fc1d08da69d6a9ac56cd.png)

置顶  [Evankaka](https://me.csdn.net/Evankaka)  2016-04-11 08:58:45  ![articleReadEyes.png](../_resources/c4360f77d43b7f3fdc7b1e070f32dfd4.png)  16886  ![tobarCollect.png](../_resources/5dad7f82dd0d8ba01fecbf11a059a7cd.png)  收藏  1

分类专栏：  [AngularJs](https://blog.csdn.net/evankaka/category_6170743.html)  [跟我学AngularJs](https://blog.csdn.net/evankaka/category_9265688.html)

版权
           林炳文Evankaka原创作品。转载请注明出处http://blog.csdn.net/evankaka
         摘要：本文主讲了AngularJs中的Controller中数据共享、继承、通信的详细使用

本教程使用AngularJs版本：1.5.3
AngularJs GitHub: https://github.com/angular/angular.js/
AngularJs下载地址：https://angularjs.org/

# 一、controller基础与用法

          AngularJS中的controller中文名就是控制器，它是一个Javascript函数（类型/类），用来向视图的作用域（$scope）添加额外的功能。而且每个controller都有自己的scope， 同时也可以共享他们父controller的scope内的数据。

其能实现的功能如下：
（1）给作用域对象设置初始状态

你可以通过创建一个模型属性来设置初始作用域的初始状态。 比如:
1
var app = angular.module('myApp', []);
2
app.controller('myController', function($scope) {
3
$scope.inputValue = "林炳文Evankaka";
4
});
上面我们设置了一个inputValue，如果要在html页面中使用，就可以直接用{{inputValue}},如下：

<h1>您输入的内容为：{{inputValue}}</h1>
当然，你也可以将此数据双向绑定到一个input、select等，如下：

<input  type="text"  ng-model  =  "inputValue">

（2）给作用域对象增加行为

AngularJS作用域对象的行为是由作用域的方法来表示的。这些方法是可以在模板或者说视图中调用的。这些方法和应用模型交互，并且能改变模型。

如我们在模型那一章所说的，任何对象（或者原生的类型）被赋给作用域后就会变成模型。任何赋给作用域的方法，都能在模板或者说视图中被调用，并且能通过表达式或者ng事件指令调用。如下：

1
var app = angular.module('myApp', []);
2
app.controller('myController', function($scope) {
3
$scope.myClick = function(){
4
    alert("click");
5
}
6
});
然后页面上使用：

<button  ng-click=  "myClick()"  ></button>
这样就给button添加了一个点击事件

# 二、controller继承

这里说的继承一般说的是scope数据，这是因为子控制器的作用域将会原型继承父控制器的作用域。因此当你需要重用来自父控制器中的功能时，你所要做的就是在父作用域中添加相应的方法。这样一来，自控制器将会通过它的作用域的原型来获取父作用域中的所有方法。

如下实例：

1
<!DOCTYPE  html>
2
<html  lang="zh"  ng-app="myApp">
3
<head>
4
    <meta  charset="UTF-8">
5
    <title>AngularJS入门学习</title>
6
    <script  type="text/javascript"  src="./1.5.3/angular.min.js"></script>
7
</head>
8
<body>
9
<div  ng-controller  =  "parentCtrl">
10
      <p><input  type="text"  ng-model  =  "value1">请输入内容</p>
11
      <h1>您输入的内容为：{{value1}}</h1>
12
      <div  ng-controller  =  "childCtrl">
13
          <button  ng-click  =  "gerParentValue()"></button>
14
      </div>
15
    </div>
16

17
</body>
18
<script  type="text/javascript">
19
var  app = angular.module('myApp', []);*//获得整个angularJS影响的html元素*
20
app.controller('parentCtrl',function($scope){
21
$scope.value2 =  "我是林炳文";
22
});
23

24
app.controller('childCtrl',function($scope){
25
$scope.gerParentValue =  function()  {
26
    alert($scope.value1 + $scope.value2);
27
}
28
});
29
</script>
30
</html>

![20160408155017905](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231113409.gif)

这里需要注意的是childCtrl所在的DIV一定要放在parentCtrl所在的DIV里才会生效！而且如果你需要从父控制器中调用子控制器的方法，那么使用上面的代码会发生错误。

# 三、controller之间共享数据

(1)在父级controller中定义scope,子级共用

1
<!DOCTYPE  html>
2
<html  lang="zh"  ng-app="myApp">
3
<head>
4
<meta  charset="UTF-8">
5
<title>AngularJS入门学习</title>
6
<script  type="text/javascript"  src="./1.5.3/angular.min.js"></script>
7
</head>
8
<body>
9
<div  ng-controller="paretnCtrl">
10
<input  type="text"  ng-model="name"  />
11
<div  ng-controller="childCtrl1">
12
{{name}}
13
<button  ng-click="setName()">set name to jack jack jack</button>
14
</div>
15
<div  ng-controller="childCtrl2">
16
{{name}}
17
<button  ng-click="setName()">set name to tom tom tom</button>
18
</div>
19
</div>
20
</body>
21
<script  type="text/javascript">
22
var  app = angular.module('myApp', []);
23
app.controller('paretnCtrl',  function($scope,$timeout)  {
24
$scope.name =  "林炳文Evankaka";
25
});
26
app.controller('childCtrl1',  function($scope,$timeout)  {
27
$scope.setName =  function()  {
28
$scope.name =  "set name to jack jack jack";
29
};
30
});
31
app.controller('childCtrl2',  function($scope,$timeout)  {
32
$scope.setName =  function()  {
33
    $scope.name =  "set name to tom tom tom";
34
};
35
});
36
</script>
37
</html>

![20160408163522480](../_resources/78952f479a409a23965d41d3e0ae930b.png)

（2）将数据全局共享

angularjs自身有二种，设置全局变量的方法，在加上js的设置全局变量的方法，总共有三种。要实现的功能是，在ng-app中定义的全局变量，在不同的ng-controller里都可以使用。

通过var 直接定义global variable，这根纯js是一样的。
用angularjs value来设置全局变量 。
用angularjs constant来设置全局变量 。
下面是使用value的方式

1
<!DOCTYPE  html>
2
<html  lang="zh"  ng-app="myApp">
3
<head>
4
<meta  charset="UTF-8">
5
<title>AngularJS入门学习</title>
6
<script  type="text/javascript"  src="./1.5.3/angular.min.js"></script>
7
</head>
8
<body>
9
<div  ng-controller="childCtrl1">
10
{{name}}
11
<button  ng-click="setName()">set name to jack jack jack</button>
12
</div>
13
<div  ng-controller="childCtrl2">
14
{{name}}
15
<button  ng-click="setName()">set name to tom tom tom</button>
16
</div>
17
</body>
18
<script  type="text/javascript">
19
var  app = angular.module('myApp', []);
20
app.value('data',{'name':'我是林炳文'});
21
app.controller('childCtrl1',  function($scope,data)  {
22
    $scope.name = data.name;
23
$scope.setName =  function()  {
24
$scope.name =  "set name to jack jack jack";
25
};
26
});
27
app.controller('childCtrl2',  function($scope,data)  {
28
     $scope.name = data.name;
29
$scope.setName =  function()  {
30
    $scope.name =  "set name to tom tom tom";
31
};
32
});
33
</script>
34
</html>
![20160408164208376](../_resources/1c6df35075124f6241bee6efed2e014c.png)

（3）service依赖注入
angularjs最突出的特殊之一就是DI， 也就是注入， 利用service把需要共享的数据注入给需要的controller。这是最好的方法

1
<!DOCTYPE  html>
2
<html  lang="zh"  ng-app="myApp">
3
<head>
4
<meta  charset="UTF-8">
5
<title>AngularJS入门学习</title>
6
<script  type="text/javascript"  src="./1.5.3/angular.min.js"></script>
7
</head>
8
<body>
9
<div  ng-controller="childCtrl1">
10
{{name}}
11
<button  ng-click="setName()">set name to jack jack jack</button>
12
</div>
13
<div  ng-controller="childCtrl2">
14
{{name}}
15
<button  ng-click="setName()">set name to tom tom tom</button>
16
</div>
17
</body>
18
<script  type="text/javascript">
19
var  app = angular.module('myApp', []);
20
app.factory('dataService',  function()  {
21
var  service = {
22
name:'我是林炳文'
23
};
24
return  service;
25
});
26
app.controller('childCtrl1',  function($scope,dataService)  {
27
    $scope.name = dataService.name;
28
$scope.setName =  function()  {
29
$scope.name =  "set name to jack jack jack";
30
};
31
});
32
app.controller('childCtrl2',  function($scope,dataService)  {
33
     $scope.name = dataService.name;
34
$scope.setName =  function()  {
35
    $scope.name =  "set name to tom tom tom";
36
};
37
});
38
</script>
39
</html>
![20160408165128553](../_resources/39c195939f7e61c97d907225dd42ecaf.gif)

# 四、controller之间通信

 在一般情况下基于继承的方式已经足够满足大部分情况了，但是这种方式没有实现兄弟控制器之间的通信方式，所以引出了事件的方式。基于事件的方式中我们可以里面作用的$on,$emit,$boardcast这几个方式来实现，其中$on表示事件监听，$emit表示向父级以上的

作用域触发事件， $boardcast表示向子级以下的作用域广播事件。
**$emit只能向parent controller传递event与data**
**$broadcast只能向child controller传递event与data**
**$on用于接收event与data**
实例一：

1
<!DOCTYPE  html>
2
<html  lang="zh"  ng-app="myApp">
3
<head>
4
<meta  charset="UTF-8">
5
<title>AngularJS入门学习</title>
6
<script  type="text/javascript"  src="./1.5.3/angular.min.js"></script>
7
</head>
8
<body>
9
<div  ng-app="app"  ng-controller="parentCtr">
10
<div  ng-controller="childCtr1">childCtr1 name :
11
<input  ng-model="name"  type="text"  ng-change="change(name)"  />
12
</div>
13
<div  ng-controller="childCtr2">from childCtr1 name:
14
<input  ng-model="ctr1Name"  />
15
</div>
16
</div>
17
</body>
18
<script  type="text/javascript">
19
var  app = angular.module('myApp', []);
20
app.controller("parentCtr",function  ($scope)  {
21

$scope.$on("Ctr1NameChange",function  (event, msg)  {*//接收到来自子childCtr1的信息后再广播给所有子controller*

22
console.log("parent", msg);
23
$scope.$broadcast("Ctr1NameChangeFromParrent", msg);*//给所有子controller广播*
24
});
25
});
26
app.controller("childCtr1",  function  ($scope)  {
27
$scope.change =  function  (name)  {
28
console.log("childCtr1", name);
29
$scope.$emit("Ctr1NameChange", name);*//将信息传递给父controller*
30
};
31
}).controller("childCtr2",  function  ($scope)  {
32

$scope.$on("Ctr1NameChangeFromParrent",function  (event, msg)  {  *//监听来自父controller的信息*

33
console.log("childCtr2", msg);
34
$scope.ctr1Name = msg;
35
});
36
});
37
</script>
38
</html>
![20160408173431528](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231113451.gif)

实例二：

1
<!DOCTYPE  html>
2
<html  lang="zh"  ng-app="myApp">
3
<head>
4
<meta  charset="UTF-8">
5
<title>AngularJS入门学习</title>
6
<script  type="text/javascript"  src="./1.5.3/angular.min.js"></script>
7
</head>
8
<body>
9
<div  ng-controller="ParentCtrl">  *<!--父级-->*
10
<div  ng-controller="SelfCtrl">  *<!--自己-->*
11
<button  ng-click="click()">click me</button>
12
<div  ng-controller="ChildCtrl">
13

14
</div>  *<!--子级-->*
15
</div>
16
<div  ng-controller="BroCtrl">
17

18
</div>  *<!--平级-->*
19
</div>
20
</body>
21
<script  type="text/javascript">
22
var  app = angular.module('myApp', []);
23
app.controller('SelfCtrl',  function($scope)  {
24
$scope.click =  function ()  {
25
$scope.$broadcast('to-child',  'child');
26
$scope.$emit('to-parent',  'parent');
27
}
28
});
29

30
app.controller('ParentCtrl',  function($scope)  {
31
$scope.$on('to-parent',  function(event,data)  {
32
console.log('ParentCtrl', data);      *//父级能得到值*
33
});
34
$scope.$on('to-child',  function(event,data)  {
35
console.log('ParentCtrl', data);      *//子级得不到值*
36
});
37
});
38

39
app.controller('ChildCtrl',  function($scope){
40
$scope.$on('to-child',  function(event,data)  {
41
console.log('ChildCtrl', data);          *//子级能得到值*
42
});
43
$scope.$on('to-parent',  function(event,data)  {
44
console.log('ChildCtrl', data);          *//父级得不到值*
45
});
46
});
47

48
app.controller('BroCtrl',  function($scope){
49
$scope.$on('to-parent',  function(event,data)  {
50
console.log('BroCtrl', data);          *//平级得不到值*
51
});
52
$scope.$on('to-child',  function(event,data)  {
53
console.log('BroCtrl', data);          *//平级得不到值*
54
});
55
});
56
</script>
57
</html>
输出结果：

![20160408173644476](../_resources/46ccb3b6d7e3f666a4e08c9595c25756.png)

$emit和$broadcast可以传多个参数，$on也可以接收多个参数。

在$on的方法中的event事件参数，其对象的属性和方法如下

|     |     |
| --- | --- |
| 事件属性 | 目的  |
| event.targetScope | 发出或者传播原始事件的作用域 |
| event.currentScope | 目前正在处理的事件的作用域 |
| event.name | 事件名称 |
| event.stopPropagation() | 一个防止事件进一步传播(冒泡/捕获)的函数(这只适用于使用`$emit`发出的事件) |
| event.preventDefault() | 这个方法实际上不会做什么事，但是会设置`defaultPrevented`为true。直到事件监听器的实现者采取行动之前它才会检查`defaultPrevented`的值。 |
| event.defaultPrevented | 如果调用 |

# 五、 对于controller层的一些建议

1、controller层不要涉及到太多的业务逻辑，可以将公用的部分抽取到Service层
2、service层：主要负责数据交互和数据处理、处理一些业务领域上的逻辑；
3、controller层：主要负责初始化$scope的变量用于传递给view层，并且处理一些页面交互产生的逻辑;
4、当一个功能是设计远程API调用、数据集、业务领悟复杂逻辑、将会大量重复的运算方法时就可以考虑将代码以service形式注入controller层。
5、controller 里的 $scope 是唯一页面数据来源。不要直接修改 DOM。
6、controller 不要在全局范围

参考文章：
http://www.jianshu.com/p/1e1aaf0fd30a
http://cnodejs.org/topic/54dd47fa7939ece1281aa54f
http://www.html-js.com/article/1847
http://blog.51yip.com/jsjquery/1601.html

http://www.cnblogs.com/CraryPrimitiveMan/p/3679552.html?utm_source=tuicool&utm_medium=referral

http://www.cnblogs.com/whitewolf/archive/2013/04/16/3024843.html

[(L)](https://blog.csdn.net/qq_26222859)  [weiqing的博客](https://blog.csdn.net/qq_26222859)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 3074

[angular中的$](https://blog.csdn.net/qq_26222859/article/details/78191145)[controller](https://blog.csdn.net/qq_26222859/article/details/78191145)服务 [大家一般用angular的$](https://blog.csdn.net/qq_26222859/article/details/78191145)[controller](https://blog.csdn.net/qq_26222859/article/details/78191145)的时候都是用如下的方式：angular.module('app',[]) .[controller](https://blog.csdn.net/qq_26222859/article/details/78191145)('app[Controller](https://blog.csdn.net/qq_26222859/article/details/78191145)',function{})这样的方式是让angular自动去寻找程序的入口ng-app，然后自动解析依赖注入，并且声成实例。其实在angular内部执行过程如下//[使用](https://blog.csdn.net/qq_26222859/article/details/78191145)注射器加载应用var injec...

[(L)](https://blog.csdn.net/qq_36918222)  [Jack Tian的博客](https://blog.csdn.net/qq_36918222)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 349

[angular,不同的](https://blog.csdn.net/qq_36918222/article/details/78800059)[controller](https://blog.csdn.net/qq_36918222/article/details/78800059)间[通信](https://blog.csdn.net/qq_36918222/article/details/78800059)  [不同的](https://blog.csdn.net/qq_36918222/article/details/78800059)[controller](https://blog.csdn.net/qq_36918222/article/details/78800059)间[通信](https://blog.csdn.net/qq_36918222/article/details/78800059)，除了rootScope，还可以通过angular提供的$on,$emit,$broadcast等方法[通信](https://blog.csdn.net/qq_36918222/article/details/78800059)。在A [Controller](https://blog.csdn.net/qq_36918222/article/details/78800059)中$scope.getName= function(){ doSth……}$rootScope.$on('xxx',function(){ $scope.getName();});在B Controll

[![anonymous-User-img.png](../_resources/ebdf7b8d2d6a8248a39b7dcafdfcdc5f.png)](http://loadhtml/#)

[![3_weixin_43791269](../_resources/cbbf6ee496e75c03c7c7b1be6f53dec2.jpg)](https://me.csdn.net/weixin_43791269)

[(L)](https://me.csdn.net/weixin_43791269)[肖邦的无奈](https://me.csdn.net/weixin_43791269)**:**可以, 学习到了5月前

![](../_resources/895b98e96a4ba71d646477427a8e2645.png)

[(L)](https://blog.csdn.net/this_tall_people)  [青梅煮酒论英雄的博客](https://blog.csdn.net/this_tall_people)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 1452

[angular 之 控制器](https://blog.csdn.net/this_tall_people/article/details/74638441)  [controller](https://blog.csdn.net/this_tall_people/article/details/74638441)[详解](https://blog.csdn.net/this_tall_people/article/details/74638441)  [介绍](https://blog.csdn.net/this_tall_people/article/details/74638441)  [controller](https://blog.csdn.net/this_tall_people/article/details/74638441) 之前首先介绍下scope和scope 和 rootscope 的区别scope 和 $rootscope不管rootscope 还是 scope ，都是html 和 [controller](https://blog.csdn.net/this_tall_people/article/details/74638441) 之间的桥梁，数据绑定都是通过 他们来绑定的 简单来说，scope 相当于局部变量，rootscope 相当于全局变量，意思就是scope只针对单个的控制器，rootscope...

[(L)](https://blog.csdn.net/sinat_38529191)  [Drenched的博客](https://blog.csdn.net/sinat_38529191)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 8866

[(L)](https://blog.csdn.net/sinat_38529191/article/details/70917104)[AngularJS](https://blog.csdn.net/sinat_38529191/article/details/70917104)-控制器篇([controller](https://blog.csdn.net/sinat_38529191/article/details/70917104)) [今天公司突然停电了，临时回家，哈哈 莫名很兴奋。                                                              回家里已经把工作做完，今晚上一起看个电影啊  度过愉快的周末~说说今天的用的控制器  再出去耍 哈哈哈控制器什么是控制器？控制器是](https://blog.csdn.net/sinat_38529191/article/details/70917104)[AngularJS](https://blog.csdn.net/sinat_38529191/article/details/70917104)的核心之一，它的作用主要是对视图中的...

[(L)](https://blog.csdn.net/weixin_34309435/article/details/86054838)[AngularJS](https://blog.csdn.net/weixin_34309435/article/details/86054838)中控制器[继承](https://blog.csdn.net/weixin_34309435/article/details/86054838)_weixin_34309435的博客-CSDN博客

4-7

[本篇关注](https://blog.csdn.net/weixin_34309435/article/details/86054838)[AngularJS](https://blog.csdn.net/weixin_34309435/article/details/86054838)中的控制器[继承](https://blog.csdn.net/weixin_34309435/article/details/86054838),了解属性和方法是如何被[继承](https://blog.csdn.net/weixin_34309435/article/details/86054838)的。嵌套控制器中属性是如何被继

[(L)](https://blog.csdn.net/iteye_2698/article/details/82618621)[AngularJS](https://blog.csdn.net/iteye_2698/article/details/82618621)控制器的[继承](https://blog.csdn.net/iteye_2698/article/details/82618621)机制 - iteye_2698的博客 - CSDN博客

10-29

[{{ someBareValue }} Communicate](https://blog.csdn.net/iteye_2698/article/details/82618621)

[(L)](https://blog.csdn.net/chenqk_123)  [chenqk_123的专栏](https://blog.csdn.net/chenqk_123)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 933

[(L)](https://blog.csdn.net/chenqk_123/article/details/77892182)[angularjs](https://blog.csdn.net/chenqk_123/article/details/77892182)[数据共享](https://blog.csdn.net/chenqk_123/article/details/77892182)  [前面提到了](https://blog.csdn.net/chenqk_123/article/details/77892182)[angularjs](https://blog.csdn.net/chenqk_123/article/details/77892182)的每个应用是基于APP的，而每个功能模块属于一个module，每个module的一些增删改查等单项功能以及数据层都是依赖于$scope，每个$scope都有其独有的作用域，不同的功能模块对应着不同的作用域。不同模块之间的$scope是不可共享的，而在实际的项目中我们又会发现会有一些方法参数需要在多个功能模块module之间传递，需要被多个module之间共享，这就好比j...

[(L)](https://blog.csdn.net/jfkidear)  [jfkidear的专栏](https://blog.csdn.net/jfkidear)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 8439

[(L)](https://blog.csdn.net/jfkidear/article/details/48352247)[AngularJs](https://blog.csdn.net/jfkidear/article/details/48352247) 父子级[Controller](https://blog.csdn.net/jfkidear/article/details/48352247)传递数据 [(L)](https://blog.csdn.net/jfkidear/article/details/48352247)[AngularJs](https://blog.csdn.net/jfkidear/article/details/48352247) 父子级[Controller](https://blog.csdn.net/jfkidear/article/details/48352247)传递数据博客分类： js乔乐共享众观千象每天进步一点点学习永无止境[angularjs](https://blog.csdn.net/jfkidear/article/details/48352247) Html代码  div ng-[controller](https://blog.csdn.net/jfkidear/article/details/48352247)="MyAccountCtrl">       div ng-[controller](https://blog.csdn.net/jfkidear/article/details/48352247)="TransferCtrl">             ...

[(L)](https://blog.csdn.net/weixin_39654784/article/details/78287223)[angularjs](https://blog.csdn.net/weixin_39654784/article/details/78287223)1[继承](https://blog.csdn.net/weixin_39654784/article/details/78287223)问题_饮冰十年的博客-CSDN博客

1-6

[(L)](https://blog.csdn.net/weixin_39654784/article/details/78287223)[angularjs](https://blog.csdn.net/weixin_39654784/article/details/78287223)代码: (function () { var root =... 创建自己的[AngularJS](https://blog.csdn.net/weixin_39654784/article/details/78287223) - 作用域[继承](https://blog.csdn.net/weixin_39654784/article/details/78287223)(一) 阅读数 7499 作用域作用域[继承](https://blog.csdn.net/weixin_39654784/article/details/78287223)(一)Angular作用域[继承](https://blog.csdn.net/weixin_39654784/article/details/78287223)机制直接建立在Java...

[创建自己的](https://blog.csdn.net/fangjuanyuyue/article/details/51252243)[AngularJS](https://blog.csdn.net/fangjuanyuyue/article/details/51252243) - 作用域[继承](https://blog.csdn.net/fangjuanyuyue/article/details/51252243)(一) - fangjuanyuyu..._CSDN博客

9-30

[Angular作用域](https://blog.csdn.net/fangjuanyuyue/article/details/51252243)[继承](https://blog.csdn.net/fangjuanyuyue/article/details/51252243)机制直接建立在Javascript原型[继承](https://blog.csdn.net/fangjuanyuyue/article/details/51252243)基础上,并在其根部加入了一些内容。这意味着当你理解了Javascript原型链后,将对Angular作用域[继承](https://blog.csdn.net/fangjuanyuyue/article/details/51252243)有深入了解。 根作...

[(L)](https://blog.csdn.net/carcarrot)  [carcarrot的博客](https://blog.csdn.net/carcarrot)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 123

[MVC 过滤器](https://blog.csdn.net/carcarrot/article/details/99411983)[使用](https://blog.csdn.net/carcarrot/article/details/99411983) ActionFilterAttribute [在asp.net mvc 中 webapi 和 mvc 处理消息是两个不同的管道，Asp.net mvc 和 webapi 为我们提供的ActionFilterAttribute 拦截器，通过 重写OnActionExecuting，来 拦截action的请求消息，当执行OnActionExecuting完成以后才真正进入请求的action中，action运行完后又把控制权给......](https://blog.csdn.net/carcarrot/article/details/99411983)

[java spring的过滤器执的方法在conctroller方法之后执行](http://ask.csdn.net/questions/385100)
05-15

[(L)](http://ask.csdn.net/questions/385100)[图1:过滤范围 ![图片说明](https://img-ask.csdn.net/upload/201705/15/1494837216_447235.png) 图2:所有请求都会调用这个方法. ![图片说明](https://img-ask.csdn.net/upload/201705/15/1494837236_985155.png) 图3.状态码为504后进入ajax提示 ![图片说明](https://img-ask.csdn.net/upload/201705/15/1494837259_789544.png) 图4.测试方法 ![图片说明](https://img-ask.csdn.net/upload/201705/15/1494837268_358042.png) 图5. 图2的preHandler方法在请求conctroller之后执行, ![图片说明](https://img-ask.csdn.net/upload/201705/15/1494837277_135640.png) 那么问题来了! 如果session中的user为空,就会造成conctroll方法空指针空指针. 请问如何解决!](http://ask.csdn.net/questions/385100)

[(L)](https://blog.csdn.net/weixin_30408739/article/details/98387693)[angularJS](https://blog.csdn.net/weixin_30408739/article/details/98387693)指令--[继承](https://blog.csdn.net/weixin_30408739/article/details/98387693)父级指令的方法 - weixin_30408739的博客

12-8

[(十一)通过](https://blog.csdn.net/weixin_30408739/article/details/98387693)[angularjs](https://blog.csdn.net/weixin_30408739/article/details/98387693)的ng-repeat指令看scope的[继承](https://blog.csdn.net/weixin_30408739/article/details/98387693)关系 阅读数 3877 ng-[controller](https://blog.csdn.net/weixin_30408739/article/details/98387693)指令会创建一个新的作用域scope。我们可以[使用](https://blog.csdn.net/weixin_30408739/article/details/98387693)angular.element(domElement).scope(...

[(L)](https://blog.csdn.net/jaytalent/article/details/51166278)[AngularJS](https://blog.csdn.net/jaytalent/article/details/51166278) Scope [继承](https://blog.csdn.net/jaytalent/article/details/51166278)解析_JavaScript_冷月无声-CSDN博客

4-25

[(L)](https://blog.csdn.net/jaytalent/article/details/51166278)[AngularJS](https://blog.csdn.net/jaytalent/article/details/51166278)中scope之间的[继承](https://blog.csdn.net/jaytalent/article/details/51166278)关系[使用](https://blog.csdn.net/jaytalent/article/details/51166278)JavaScript的原型[继承](https://blog.csdn.net/jaytalent/article/details/51166278)方式实现。本文结合AnJavaScript

[(L)](https://blog.csdn.net/iteye_5563)  [iteye_5563的博客](https://blog.csdn.net/iteye_5563)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 256

[【](https://blog.csdn.net/iteye_5563/article/details/82675502)[AngularJS](https://blog.csdn.net/iteye_5563/article/details/82675502)】[controller](https://blog.csdn.net/iteye_5563/article/details/82675502)的[继承](https://blog.csdn.net/iteye_5563/article/details/82675502)  [谈到](https://blog.csdn.net/iteye_5563/article/details/82675502)[angularJS](https://blog.csdn.net/iteye_5563/article/details/82675502)  [controller](https://blog.csdn.net/iteye_5563/article/details/82675502)的[继承](https://blog.csdn.net/iteye_5563/article/details/82675502)，一般都会想到父子scope,对应的父子[controller](https://blog.csdn.net/iteye_5563/article/details/82675502)，才能做好[继承](https://blog.csdn.net/iteye_5563/article/details/82675502)。实践中有这样的一个场景，有2套页面，页面组件，风格大部分都一样，不同的可能是绑定的数据等稍有不同，如果简单copy一下html模板，controll的js文件，也能达到完成任务的效果，但是坏处是一份代码写了2边，如果万一要调整代码，还要改写2份，那[AngularJS](https://blog.csdn.net/iteye_5563/article/details/82675502)有没......

[(L)](https://blog.csdn.net/syasz)  [盛政(kisssy)的专栏](https://blog.csdn.net/syasz)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 1471

[一句话解释](https://blog.csdn.net/syasz/article/details/46682371)[AngularJS](https://blog.csdn.net/syasz/article/details/46682371)作用域的原型[继承](https://blog.csdn.net/syasz/article/details/46682371)问题 [原型](https://blog.csdn.net/syasz/article/details/46682371)[继承](https://blog.csdn.net/syasz/article/details/46682371)时对变量的赋值不会修改原型中的值，而是直接在当前scope中创建一个同名的属性；但如果是变量是对象，则不会创建。一句话，基本类型会重新创建变量，引用则不会。这就解释了  【[AngularJS](https://blog.csdn.net/syasz/article/details/46682371)中经常发生在双向绑定时（出现子作用域时，比如ng-repeat等情况），出现直接绑定字符串变量会不成功，但把这个字符串作为一个对象的属性时则绑定成功 】  这一问题。详细请参见：http...

[AnglarJS(六)](https://blog.csdn.net/houysx/article/details/80376166)[继承](https://blog.csdn.net/houysx/article/details/80376166)_[controller](https://blog.csdn.net/houysx/article/details/80376166),[AngularJS](https://blog.csdn.net/houysx/article/details/80376166),[继承](https://blog.csdn.net/houysx/article/details/80376166)_暖阳阳-CSDN博客

1-6

[我们通过](https://blog.csdn.net/houysx/article/details/80376166)[继承](https://blog.csdn.net/houysx/article/details/80376166)的方式来实现。 定义一个基本的控制器,作为父控制器,提供通用的...[AngularJS](https://blog.csdn.net/houysx/article/details/80376166)(九)面包屑导航 gl1366709:itcast? [AngularJS](https://blog.csdn.net/houysx/article/details/80376166)(九)面包屑导航 weixin...

[(L)](https://blog.csdn.net/csdnluolei/article/details/85011244)[AngularJS](https://blog.csdn.net/csdnluolei/article/details/85011244)-demo - 常用命令、内置服务、自定义服务、[继承](https://blog.csdn.net/csdnluolei/article/details/85011244) - Lei...

12-20

[(L)](https://blog.csdn.net/csdnluolei/article/details/85011244)[继承](https://blog.csdn.net/csdnluolei/article/details/85011244): my[Controller](https://blog.csdn.net/csdnluolei/article/details/85011244)  [继承](https://blog.csdn.net/csdnluolei/article/details/85011244) base[Controller](https://blog.csdn.net/csdnluolei/article/details/85011244) 表达式 {{ }} 实例: <!DOCTYPE html> [AngularJS](https://blog.csdn.net/csdnluolei/article/details/85011244)-demo -常用命令、内置服务、自定义服务、[继承](https://blog.csdn.net/csdnluolei/article/details/85011244)  [AngularJS](https://blog.csdn.net/csdnluolei/article/details/85011244)-demo ...

©️2020 CSDN  皮肤主题: 编程工作室  设计师: CSDN官方博客  [返回首页](https://blog.csdn.net/)

[关于我们](https://www.csdn.net/company/index.html#about)  [招聘](https://www.csdn.net/company/index.html#recruit)  [广告服务](https://www.csdn.net/company/index.html#advertisement)  [网站地图](https://www.csdn.net/gather/A)  ![](data:image/svg+xml,%3csvg width='16' height='16' xmlns='http://www.w3.org/2000/svg' data-evernote-id='4878' class='js-evernote-checked'%3e%3cpath d='M2.167 2h11.666C14.478 2 15 2.576 15 3.286v9.428c0 .71-.522 1.286-1.167 1.286H2.167C1.522 14 1 13.424 1 12.714V3.286C1 2.576 1.522 2 2.167 2zm-.164 3v1L8 10l6-4V5L8 9 2.003 5z' fill='%23999AAA' fill-rule='evenodd' data-evernote-id='4879' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  [(L)](https://blog.csdn.net/Evankaka/article/details/51097039mailto:webmaster@csdn.net)[kefu@csdn.net](https://blog.csdn.net/Evankaka/article/details/51097039mailto:webmaster@csdn.net)![](data:image/svg+xml,%3csvg t='1538012951761' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23083' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='4880' class='js-evernote-checked'%3e%3cdefs data-evernote-id='4881' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='4882' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M466.4934485 880.02006511C264.6019863 859.18313878 107.13744214 688.54706608 107.13744214 481.14947309 107.13744214 259.68965394 286.68049114 80.14660493 508.14031029 80.14660493s401.00286817 179.54304901 401.00286814 401.00286816v1.67343191C908.30646249 737.58941724 715.26799489 943.85339507 477.28978337 943.85339507c-31.71423369 0-62.61874229-3.67075386-92.38963569-10.60739903 30.09478346-11.01226158 56.84270313-29.63593923 81.5933008-53.22593095z m-205.13036267-398.87059202a246.77722444 246.77722444 0 0 0 493.5544489 0 30.85052691 30.85052691 0 0 0-61.70105383 0 185.07617062 185.07617062 0 0 1-370.15234125 0 30.85052691 30.85052691 0 0 0-61.70105382 0z' p-id='23084' fill='%23999AAA' data-evernote-id='4883' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  [(L)](http://bbs.csdn.net/forums/Service)[客服论坛](http://bbs.csdn.net/forums/Service)![](data:image/svg+xml,%3csvg t='1538013874294' width='17' height='17' style='' viewBox='0 0 1194 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23784' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='4884' class='js-evernote-checked'%3e%3cdefs data-evernote-id='4885' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='4886' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M1031.29689505 943.85339507h-863.70679012A71.98456279 71.98456279 0 0 1 95.60554212 871.86883228v-150.85178906c0-28.58329658 16.92325492-54.46750945 43.13135785-65.93861527l227.99160176-99.75813425c10.55341735-4.61543317 18.24580594-14.0082445 20.72896295-25.23643277l23.21211998-105.53417343a71.95757195 71.95757195 0 0 1 70.28414006-56.51881307h236.95255971c33.79252817 0 63.02360485 23.5090192 70.28414004 56.51881307l23.21211997 105.53417343c2.48315701 11.25517912 10.17554562 20.62099961 20.72896296 25.23643277l227.99160177 99.75813425a71.98456279 71.98456279 0 0 1 43.13135783 65.93861527v150.85178906A71.98456279 71.98456279 0 0 1 1031.26990421 943.85339507z m-431.85339506-143.94213475c143.94213474 0 143.94213474-48.34058941 143.94213474-107.96334876s-64.45411922-107.96334877-143.94213474-107.96334877c-79.51500637 0-143.94213474 48.34058941-143.94213475 107.96334877s0 107.96334877 143.94213475 107.96334876zM1103.254467 296.07330247v148.9894213a35.97878598 35.97878598 0 0 1-44.15700966 35.03410667l-143.94213473-33.57660146a36.0057768 36.0057768 0 0 1-27.80056231-35.03410668V296.1002933c-35.97878598-47.98970852-131.95820302-71.98456279-287.91126031-71.98456279S347.53801649 248.11058478 311.53223967 296.1002933v115.385829c0 16.73431906-11.52508749 31.25538946-27.80056233 35.03410668l-143.94213473 33.57660146A35.97878598 35.97878598 0 0 1 95.63253297 445.06272377V296.07330247C162.81272673 152.13116772 330.77670658 80.14660493 599.47049084 80.14660493s436.63077325 71.98456279 503.81096699 215.92669754z' p-id='23785' fill='%23999AAA' data-evernote-id='4887' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  400-660-0108  ![](data:image/svg+xml,%3csvg t='1538013544186' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23556' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='4888' class='js-evernote-checked'%3e%3cdefs data-evernote-id='4889' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='4890' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M902.60033922 650.96445566c-18.0718526-100.84369837-94.08399771-166.87723736-94.08399771-166.87723737 10.87530062-91.53186599-28.94715402-107.78733693-28.94715401-107.78733691C771.20003413 93.08221664 517.34798062 98.02553561 511.98620441 98.16348824 506.65661791 98.02553561 252.75857992 93.08221664 244.43541101 376.29988138c0 0-39.79946279 16.25547094-28.947154 107.78733691 0 0-75.98915247 66.03353901-94.0839977 166.87723737 0 0-9.63372291 170.35365477 86.84146124 20.85850523 0 0 21.70461757 56.79068296 61.50407954 107.78733692 0 0-71.1607951 23.19910867-65.11385185 83.46161052 0 0-2.43717093 67.16015592 151.93232126 62.56172014 0 0 108.5460788-8.0932473 141.10300432-52.14626271H526.33792324c32.57991817 44.05301539 141.10300431 52.1462627 141.10300431 52.14626271 154.3235077 4.59843579 151.95071457-62.56172013 151.95071457-62.56172014 6.00095876-60.26250183-65.11385185-83.46161053-65.11385185-83.46161052 39.77647014-50.99665395 61.4810877-107.78733693 61.4810877-107.78733692 96.45219231 149.49514952 86.84146124-20.85850523 86.84146125-20.85850523' p-id='23557' fill='%23999AAA' data-evernote-id='4891' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)[(L)](https://url.cn/5epoHIm?_type=wpa&qidian=true)[QQ客服（8:30-22:00）](https://url.cn/5epoHIm?_type=wpa&qidian=true)

[公安备案号 11010502030143](http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010502030143)  [京ICP备19004658号](http://beian.miit.gov.cn/publish/query/indexFirst.action)  [京网文〔2020〕1039-165号](https://csdnimg.cn/release/live_fe/culture_license.png)  [版权与免责声明](https://www.csdn.net/company/index.html#statement)  [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)  [网络110报警服务](http://www.cyberpolice.cn/)

[中国互联网举报中心](http://www.12377.cn/)  [家长监护](https://download.csdn.net/index.php/tutelage/)  [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)  [北京互联网违法和不良信息举报中心](http://www.bjjubao.org/)  ©1999-2020 北京创新乐知网络技术有限公司
angularjs $scope与this的区别，controller as vm有何含义？ - 听风是风 - 博客园

## [angularjs $scope与this的区别，controller as vm有何含义？](https://www.cnblogs.com/echolun/p/11708566.html)

![1213309-20191020222826869-1853877548.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173119.png)
** 壹 ❀ 引**

初学angularjs的同学对于$scope一定不会陌生，scope（作用域）是将view（视图）与model（模板）关联起来的桥梁，通过controller（控制器）对于model的数据操作，我们能轻易实现双向绑定，这是一个简单的例子：

<body ng-controller="myCtrl">  <input type="text" ng-model="name">  <div>{{name}}</div></body>

angular.module('myApp', [])
.controller('myCtrl', function ($scope) {
$scope.name = '听风是风';
});
![1213309-20191020192102882-2060099577.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173127.gif)
随着对于angularjs的深入学习，我们知道原来在angularjs版本1.2之后，数据除了绑定scope还能绑定this上，像这样：

<body ng-controller="myCtrl as vm">  <input type="text" ng-model="vm.name">  <div>{{vm.name}}</div></body>

angular.module('myApp', [])
.controller('myCtrl', function ($scope) { this.name = '大家好，我是听风是风';
});
![1213309-20191020193004856-15983355.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173131.gif)

从视觉角度来看，this好像也达到了scope的作用，那它两真的就等同吗？二者有什么区别呢？在第二个例子中，myCtrl as vm又是什么意思？本文就此展开探讨。

** 贰 ❀ controller as做了什么**

如果只是将数据绑定在this上，ng-controller不使用ctrl as的写法，你会发现this上的数据在视图中是无法被识别的。我们都知道控制器controller是一个构造函数，这里的controller as vm其实就是实例化了一个叫vm的实例而已，类似于这样：

[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
class myCtrl {
constructor() { this.name = '听风是风';
};
sayName() {
console.log(this.name);
}
}
let vm = new myCtrl();
vm.sayName() //听风是风
[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)

这也是为什么非得通过vm才能访问controller控制器中this属性的原因；另外，as vm的vm也只是一个实例名而已，随便你取什么名字都是OK的，并不是硬性要求。

** 叁 ❀ $scope与this有何区别**
**1.含义不同：**

每个控制器controller都有一个关联的$scope对象，控制器（构造函数）负责在其关联的作用域（$scope）上设置模型（model）属性和行为。而视图只能访问在此对象和父作用域对象（$scope）上定义的属性方法。

而this就有点不同，了解Javascript的同学都知道，this指向其实是一个不太确定的东西，在你不知道this直接调用者是谁，你也无法判断this指向谁，在angular中也是如此。

在angular中当你调用控制器的构造函数时，this就会指向控制器，比如前面我们提到ctrl as vm。而当你调用$scope上的方法时，this指向当前控制器的有效作用域。

<body ng-controller="myCtrl as vm">
<button ng-click="vm.demo1()">ctrl的this</button>
<button ng-click="demo2()">scope的this</button>
<button ng-click="demo3()">$scope中的this就是当前作用域</button>
</body>
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)
angular.module('myApp', [])
.controller('myCtrl', function ($scope) { this.demo1 = function () {
console.log(this);
};
$scope.demo2 = function () {
console.log(this);
};
$scope.demo3 = function () {
console.log(this === $scope);
};
});
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)

![1213309-20191020211215130-1494195673.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173142.gif)上述例子中，我们分别将方法绑定在this上与$scope上分别输出this，以及判断绑定在$scope时this是否等同于当前控制器的作用域，根据结果我们也验证了前面的结论，this可能等于当前scope，也可能不等于。

当然一般情况下，我们会认为this和$scope不是同一个东西，在我们使用ctrl as vm时，其实只是在$scope中添加了一个key名为vm的对象属性：

<body ng-controller="myCtrl as vm"></body>
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)
angular.module('myApp', [])
.controller('myCtrl', function ($scope) { this.name = '听风是风';
this.sayName = function () {
console.log(1);
};
console.log($scope);
});
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)
![1213309-20191020212406685-1833934804.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173150.png)

所以虽然this可能会等于$scope，但实例vm始终不会等于当前$scope，这点需要注意。另外一提的是在controller中常有使用let vm = this的做法，vm与this的关系也跟this指向有关，如下：

[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
angular.module('myApp', [])
.controller('myCtrl', function ($scope) {
let vm = this vm.demo1 = function () {
console.log(this === vm); // true };
$scope.demo3 = function () {

console.log(this === $scope); // true console.log(vm === $scope); // false console.log(vm, this); // {demo1: ƒ} ChildScope{...} };

});
[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
**2.作用范围不同**

如果说$scope已经能解决日常开发需求，那为何还要推出新的ctrl as vm的写法呢，其主要的一点，就是为了解决scope继承导致作用域混乱的问题。在下面的例子中，即使子作用域没有声明name属性，一样能继承来自父作用域的name：

[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)

<body ng-controller="parentCtrl">  <span>{{name}}</span>  <div ng-controller="childCtrl">  <span>{{name}}</span>  <span>{{age}}</span>  </div></body>

[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
angular.module('myApp', [])
.controller('parentCtrl', function ($scope) {
$scope.name = '听风是风';
})
.controller('childCtrl', function ($scope) {
$scope.age = 26;
});
[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
![1213309-20191020213250429-998075141.png](../_resources/962d3828e657d66de68ab8ae46242ddd.png)
在代码结构比较复杂的情况下，你往往很难区分这个name属性来自于哪里，而ctrl as正好解决了这个问题，下面的例子相较上方是不是看着更清晰呢：
[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)

<body ng-controller="parentCtrl as parent">  <span>{{parent.name}}</span>  <div ng-controller="childCtrl as child">  <span>{{parent.name}}</span>  <span>{{child.age}}</span>  </div></body>

[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
angular.module('myApp', [])
.controller('parentCtrl', function ($scope) { this.name = '听风是风';
})
.controller('childCtrl', function ($scope) { this.age = 26;
});
[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
** 肆 ❀ 使用this与$scope的坑**
在介绍完this与$scope的区别后，在日常开发中何时使用$scope与this也有些注意的地方，这里我列举两处大家可能会忽略的点：
**1.directive中scope属性为true时$scope与this表现不同**

我们都知道在自定义指令directive开发中，提供了一个scope属性，值分为false（不创建作用域），true与（创建作用域但不隔离）一个对象{}（创建隔离作用域）。

值为false的表现为，子会继承父作用域的属性，无论父子谁修改此属性，双方都会同步；
true的表现为，子会继承父作用域的属性，但只有修改父时子会同步，通过子修改此属性，父并不会改变。{}表示子创建隔离作用域，即子不会继承父任何属性。

上面三种情况的描述其实都是值绑定在$scope上的情况，如果值绑定在this上，scope值为false或{}时，$scope.name与this.name表现一致，唯独scope值为true时，如果你将值绑定在this上，修改子也会影响到父，直接看个例子：

[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)

<body ng-controller="myCtrl as vm"> scope: <input type="text" ng-model="name1"><br> this: <input type="text" ng-model="vm.name2">  <div echo></div></body>

[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
angular.module('myApp', [])
.controller('myCtrl', function ($scope) {
let vm = this $scope.name1 = '时间跳跃';
vm.name2 = '听风是风';
})
.directive('echo', function () { return {
restrict: 'EACM',
scope: true,
replace: true,

template: '<div>scope:<input type="text" ng-model="name1"></br>this:<input type="text" ng-model="vm.name2"></div>',

}
})
[![copycode.gif](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
![1213309-20191020215649467-1082119498.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173159.gif)

其实仔细一想，我们本来就是在设置directive的scope继承方式，this不符合这个规则也是情理之中，那为什么我们还能在子作用域使用父作用域中this的值呢，在子中输出一下$scope就明白了：

![1213309-20191020220252123-1158626750.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173203.png)
在子作用域中通过$parent访问父作用域，可以看到vm对象作为父作用域中的一条属性存在，子修改父属性，由于是继承来的属性，所以让父也发生了改变。
**2.directive中require只能访问controller中绑在this上的属性方法**

我们知道自定义指令的require属性能将其他指令的controller注入到自身，这样就可以直接使用其它指令controller中定义过的方法属性，但前提是这些方法属性是定义在this上，而非$scope上：

<body ng-controller="myCtrl as vm">  <div echo></div></body>
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)
angular.module('myApp', [])
.controller('myCtrl', function ($scope) {})
.directive('echo', function () { return {
restrict: 'EACM',
template: '<span><echo1></echo1></span>',
controller: function ($scope) {
$scope.name = '听风是风'; this.sayName = function (name) {
console.log('我的名字是' + name);
}
}
}
})
.directive('echo1', function () { return {
restrict: 'EACM',
require: '^echo',
link: function (scope, ele, attr, ctrl) {
console.log(ctrl);
}
}
})
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)
![1213309-20191020220912459-1681861538.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173211.png)

可以看到在指令echo1中link函数的第四个参数ctrl只能访问到sayName方法，导致这个情况的原因是在angularjs源码中，require所做的操作也是实例化了一个控制器实例，非this属性都无法添加到实例上，这一点也是在自定义指令开发中需要注意的。

** 伍 ❀ 总**

那么到这里，我们了解了ctrl as这种写法的含义，并且知道了angualrjs中$scope与this的区别，this可能与$scope相等，当使用ctrl as vm时，vm只是成为了$scope中的一条属性，所以vm与$scope永远不相等。

我们还了解了在自定义指令开发中，为scope与this添加值时会带来不同的影响，如果你对于angular 自定义指令开发有兴趣，欢迎阅读博主 [angularjs 一篇文章看懂自定义指令directive](https://www.cnblogs.com/echolun/p/11564103.html) 这篇文章。

另外我看了一眼文章配图中标志性的摩托车，才反应过来这是电影阿基拉的同人作品，里面的两个人物分别是男主金田正太郎与男二女友香织（男二帽子戴好..），这辆摩托在电影头号玩家中也有作为彩蛋出现，那么到这里，本文结束。

![1213309-20191021100129658-1323945302.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173214.jpg)
![1213309-20191021095956280-867884421.gif](../_resources/8842ee5e1d220506d276d1e9eedf8d07.gif)
** 参考**

['this' vs $scope in AngularJS controllers](https://stackoverflow.com/questions/11605917/this-vs-scope-in-angularjs-controllers)

[Angular路由中的controller常常有as vm, 有何作用?](https://segmentfault.com/q/1010000008883278)

[controller as引入的意义和方法?](https://www.jianshu.com/p/e088bf3661b1)

标签: [angularjs](https://www.cnblogs.com/echolun/tag/angularjs/)

 [好文要顶](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)  [关注我](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)  [收藏该文](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)  [![icon_weibo_24.png](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)  [![wechat.png](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)

 [![20200507225901.png](../_resources/d2583d1c51523637c6d05d483c6bcf73.png)](https://home.cnblogs.com/u/echolun/)

 [听风是风](https://home.cnblogs.com/u/echolun/)
 [关注 - 3](https://home.cnblogs.com/u/echolun/followees/)
 [粉丝 - 332](https://home.cnblogs.com/u/echolun/followers/)

 [+加关注](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)

 2

 0

 [«](https://www.cnblogs.com/echolun/p/11674869.html) 上一篇： [angularjs link compile与controller的区别详解，了解angular生命周期](https://www.cnblogs.com/echolun/p/11674869.html)

 [»](https://www.cnblogs.com/echolun/p/11720161.html) 下一篇： [JSON.parse解决Unexpected token ' in JSON at position 1报错](https://www.cnblogs.com/echolun/p/11720161.html)

posted on 2019-10-20 22:29 [听风是风](https://www.cnblogs.com/echolun/)  阅读(822)  评论(2) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=11708566) [收藏](angularjs%20$scope与this的区别，controller%20as%20vm有何含义？%20-%20听.md#)
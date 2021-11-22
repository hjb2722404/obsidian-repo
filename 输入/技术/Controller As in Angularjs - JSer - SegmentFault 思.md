Controller As in Angularjs - JSer - SegmentFault 思否

## Controller As

	    angular
	        .module('app', [])
	        .controller('DemoController', DemoController);
	
	    function DemoController() {
	        this.name = 'XL';
	        this.sayName = function() {
	            return this.name;
	        }
	    }
	
	    <div ng-controller='DemoController as vm'>
	        {{vm.name}}
	    </div>

在js部分书写控制器的时候，更像是在写构造函数，然后在`view层`实例化一个`ViewModule`。那么在`view`里面可以直接调用挂载在这个vm上的属性和方法。

这样的写法的好处就是避免在嵌套的`controller`里面使用`$parent`去获取父`controller`里面的方法或值。因为在**angular里面scope是基于原型进行继承的**。

	    <div ng-controller='parentController'>
	        {{name}}
	        <div ng-controller='childController'>
	            {{name}}
	        </div>
	    </div>
	
	    angular
	        .module('app')
	        .controller('parentController', parentController)
	        .controller('childController', childController);
	
	    *//都使用的推断式注入*
	    function parentController($scope) {
	        $scope.name = 'XL';
	    }
	    function childController($scope) {
	        $scope.name = 'xl';
	    }

最后在视图里面输出'XL', 'xl'。如果我要获取的是父控制器里面的属性值，那么我只能`$scope.$parent`去获取，嵌套的`controller`多了怎么办- -,使用`controller as`可以有效的避免这个问题.

如果使用这种`controller as`的写法的话，尽量避免在controller里面使用$scope,除非遇到`$emit,$broadcase，$on, $watch`。

	    <input ng-model='vm.title'>
	
	    function SomeController($scope, $log) {
	        var vm = this;
	        vm.title = 'Some Title';
	
	        $scope.$watch('vm.title', function(current, original) {
	            $log('vm.title was %s', original);
	            $log('vm.title is now %s', current);
	        });
	    }

## this vs $scope

	    angular
	        .module('app', [])
	        .controller('parentController', parentController);
	
	    function parentController($scope) {
	        this.sayName = function() {
	            console.log('this');
	        }
	    }
	    <div ng-controller='parentController as vm'>
	        <button ng-click='vm.sayName()'>BtnA</button>
	        <button ng-click='sayName()'>BtnB</button>
	    </div>

结果：

- 点击`BtnA`后能输出`'this'`,
- 点击`BtnB`后不输出任何东西。

事实上：

当书写`Controller`的时候，即在写`controller constructor`,使用`controller as`语法，当在`view`里面实例化`controller`后（vm），`this`便指向这个`实例化vm`，然后就可以在`view`里面调用`vm`所拥有的属性和方法。在本例中即`vm`所拥有的`sayName()`方法

如果

	    function parentController($scope) {
	        this.sayName = function() {
	            console.log('this');
	        }
	        $scope.sayName = function() {
	            console.log('$scope');
	        }
	    }

在`controller constructor`里面定义`$scope.sayName`方法，那么点击`BtnB`的时候可以输出`$scope`。
事实上：

注入`$scope`后，即提供了一个`model`，可以在这个`model`上面绑定属性和方法。那么在`view`里面声明的`controller`里面可以访问到。

综上，在`this`上面挂载的方法其实是在`controller constructor`上面挂载的方法，必须要通过`controller`实例去访问。**在scope上面挂载的方法是在模型上面挂载的，因为在directive的pre-link阶段(见下面的compile vs link)是将*s**c**o**p**e*上面挂载的方法是在模型上面挂载的，因为在*d**i**r**e**c**t**i**v**e*的*p**r**e*−*l**i**n**k*阶段(见下面的*c**o**m**p**i**l**e**v**s**l**i**n**k*)是将scope绑定到DOM上**，因此可以直接在`view层`访问绑定在`$scope`的方法。

除此之外,`this`和`$scope`另外一个区别就是指向的问题：

	    <div ng-controller='parentController' id='parentBox'>
	        <p ng-click='logThisAndScope()'>log 'this' and $scope</p> - parent scope
	        <div ng-controller='childController' id='childBox'>
	            <p ng-click='logThisAndScope()'>log 'this' and $scope</p> - child scope
	        </div>
	    </div>

然后仅仅在`parentController`上面挂载方法:

	    $scope.logThisAndScope = function() {
	        console.log(this, $scope);
	    }

首先因为`controller`嵌套同时是在`$scope`上面挂载方法，因此父元素和子元素点击都会输出`this`和`$scope`的内容，在这个实例当中`this`的指向是不同的，一个是`parentController`另外一个是`childController`，`$scope`的指向是一样的，同时指向的是绑定在id为parentBox的DOM内的$scope。

## The problem with controllerAs in Directives

当使用`controllerAs`语法的时候， `controller scope`事实上是绑定到了`controller`的`this对象`上面。但是在平时我们书写`directive`的时候会创建独立的作用域。

	    app.directive('someDirective', function() {
	        return {
	            scope: {
	                oneWay: '@',
	                twoWay: '=',
	                expr: '&'
	            }
	        }
	    })

接下来我们创建一个拥有独立作用域，有自己的控制器的`directive`。

	    app.directive('someDirective', function() {
	        return {
	            scope: {},
	            controller: function() {
	                this.name = 'Pascal';
	            },
	            controllerAs: 'ctrl',
	            template: '<div>{{ctrl.name}}</div>'
	        }
	    })

但是，如果这个`name`属性是一个可以和父作用域共享的呢？当然我们立马想到的是

	    app.directive('someDirective', function() {
	        return {
	            scope: {
	                name: '='
	            },
	            ....
	        }
	    })

如果外部的`name`属性发生变化并不会立即反应到内部的`controller`的`this对象`上。在1.2版本里面处理这种情况就是使用`$scope服务`上挂载的`$watch`方法去监听`name`属性的变化。

	    app.directive('someDirective', function() {
	        return {
	            scope: {
	                name: '='
	            },
	            controller: function($scope) {
	                this.name = 'Pascal';
	
	                $scope.$watch('name', function(newValue){
	                    this.name = newValue;
	                }.bind(this));
	                *//这个地方要注意this的指向*
	            }
	        }
	    })

## bindToController

1.3版本里面`directive`出现了一个新的配置对象`bindToController`，顾名思义`绑定到controller`上面，当`directive`使用独立作用域以及`controllerAs`语法的时候，而且`bindToController`这个值被设置为`true`的时候，**这个组件的属性都被绑定到controller上了而不是scope上面**。

这意味着，当controller被实例化后，独立作用域上绑定属性的初始值都可以通过this对象来访问到，未来这个属性的值发生变化后都能被检测的到。

	app.directive('someDirective', function () {
	     return {
	        scope: {
	             name: '='
	        },
	        controller: function () {
	            this.name = 'Pascal';
	        },
	        controllerAs: 'ctrl',
	        bindToController: true,
	        template: '<div>{{ctrl.name}}</div>'
	    };
	});

1.4版本的语法升级：

在1.3版本`bindToController`为`boolen`值，在1.4版本中为一个对象，即如果想将独立作用域上的值绑定到`controller`上面，可以直接在`bindToController`这个对象上进行配置。

	app.directive('someDirective', function () {
	    return {
	        scope: {},
	        bindToController: {
	            someObject: '=',
	            someString: '@',
	            someExpr: '&'
	        },
	        controller: function () {
	            this.name = 'Pascal';
	        },
	        controllerAs: 'ctrl',
	        template: '<div>{{ctrl.name}}{{ctrl.someObject}}</div>'
	    };
	});
	*//如果父作用域里面的someObject属性发生变化，会随时反应到这个directive的template里面。*

## complie vs link

Angularjs在处理`directive`时，取决于自身的`compile`和`link`参数定义的规则：
当定义`directive`的时候同时定义了`complie`,`pre-link`,`post-link`3个参数的时候

	    <level-one>
	        <level-two>
	            Hello {{XL}}
	            <level-three>
	                Hello {{Sugar}}
	            <level-three>
	        <level-two>
	    </level-one>
	    var app = angular.module('app', []);
	
	    function createDirective(name) {
	        return function() {
	            return {
	                restrict: 'E',
	                compile: function(tElem, tAttrs) {
	                    console.log(name + ': complie');
	                },
	                return {
	                    pre: function(scope, tElem, iAttrs) {
	                        console.log(name + ': pre link');
	                    },
	                    post: function(scope, tElem, iAttrs) {
	                        console.log(name + ': post link');
	                    }
	                }
	            }
	        }
	    }
	
	    app.directive('levelOne', createDirective('levelOne'));
	    app.directive('levelTwo', createDirective('levelTwo'));
	    app.directive('levelThree', createDirective('levelThree'))

结果：
![bVrDAN](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107181055.png)

angularjs**一开始compile所有原生指令和自定义指令，complile阶段还没有绑定scope.link阶段分为pre-link和post-link阶段**。

从结果看来`compile阶段`和`pre-link阶段`的顺序一样，但是`post-link执行顺序`正好相反。
修改代码:

	    function createDirective(name) {
	        return function() {
	            return {
	                restrict: 'E',
	                compile: function(tElem, tAttrs) {
	                    console.log(name + ': complie =>' + tElem.html());
	                },
	                return {
	                    pre: function(scope, iElem, iAttrs) {
	                        console.log(name + ': pre link =>' + iElem.html());
	                    },
	                    post: function(scope, iElem, iAttrs) {
	                        console.log(name + ': post link =>' + iElem.html());
	                    }
	                }
	            }
	        }
	    }

结果：
![bVrDAR](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107181100.png)

现在再看下输出的信息，特别是在`pre-link阶`段,虽然和`compile`一样输出元素的顺序是一样的，但是元素中出现了属性`class='ng-binding'`,事实上在compile阶段DOM元素仍然是最初html标记所创建的DOM元素,它是模板元素`(template element)`的实例元素`(instance element)`.**pre-link**阶段提供一个`scope`给这个实体,这个实体可以是`全新的scope`,`继承的scope`或者是`孤立的scope`，**取决于directive定义的scope属性**。

`post-link阶段`：当**实例元素初始化完成(compile阶段)**和**绑定scope(pre-link阶段)**完成后就可以进行**post-link（DOM）**操作。注意这个地方执行顺序是从子元素开始再到父元素的。即在`level-one`执行`post-link`阶段前确保`level-two.level-three`执行完毕。

	    compile阶段：
	    */*
	    *   @param tElem - 模板元素
	    *   @param tAttr - 模板元素的属性
	    */*
	    compile: function(tElem, tAttrs) {
	
	    }
	
	    pre-link阶段
	    */*
	    *   @param scope - 连接于此的实例的scope
	    *   @param iElem - 实例元素
	    *   @param iAttr - 实例元素的属性
	    */*
	    function (scope, iElem, iAttr) {
	
	    }
	
	    post-link阶段
	    */*
	    *   @param scope - 连接于此实例的scope
	    *   @param iElem - 实例元素
	    *   @param iAttr - 实例元素的属性
	    */*
	    function (scope, iElem, iAttr) {
	
	    }

## where to use compile or link?

之前的写法都是直接用`link`，默认进行了`compile`和`pre-link`的阶段，在`post-link`里面就可以直接使用绑定在实例上的`scope,ele,attrs`。

如果在你的程序里面不需要使用`scope`，不需要`$watch`其他的值,仅仅提供模板实例的话，可以直接使用`compile`。这个时候你是不能对DOM有任何操作的。

除此之外，如果你不需要实例元`iElem`，那么也可以不用link函数。

但当你同时书写`compile`和`link`函数`(pre-link或者post-link)`的时候，一定要在`compile`函数里面返回`link`函数，因为如果`compile`被定义的时候`link`属性被忽略了。

## 参考资料

- [bindToController](http://blog.thoughtram.io/angularjs/2015/01/02/exploring-angular-1.3-bindToController.html)
- [thisAndScope](http://stackoverflow.com/questions/11605917/this-vs-scope-in-angularjs-controllers/14168699#14168699)
- [the difference between compile and link](http://www.jvandemo.com/the-nitty-gritty-of-compile-and-link-functions-inside-angularjs-directives/#)
- [angularjs-style](https://github.com/johnpapa/angular-styleguide)
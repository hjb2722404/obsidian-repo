AngularJS API之$injector ---- 依赖注入 - xingoo - 博客园

#   [AngularJS API之$injector ---- 依赖注入](https://www.cnblogs.com/xing901022/p/4941166.html)

> 在AngularJS中也有依赖注入的概念，像spring中的依赖注入，但是又有所不同。Spring中使用构造注入或者设值注入的方式，还需要做一些额外的操作，但是angular中只需要在需要的地方声明一下即可，类似模块的引用，因此十分方便。

> 参考：[angular api doc] (> [http://docs.angularjs.cn/api/auto/service/$injector> )

## 推断式注入

这种注入方式，需要在保证参数名称与服务名称相同。如果代码要经过压缩等操作，就会导致注入失败。

	   app.controller("myCtrl1", function($scope,hello1,hello2){
			$scope.hello = function(){
				hello1.hello();
				hello2.hello();
			}
		});

## 标记式注入

这种注入方式，需要设置一个依赖数组，数组内是依赖的服务名字，在函数参数中，可以随意设置参数名称，但是必须保证顺序的一致性。

	var myCtrl2 = function($scope,hello1,hello2){
			$scope.hello = function(){
				hello1.hello();
				hello2.hello();
			}
		}
		myCtrl2.$injector = ['hello1','hello2'];
		app.controller("myCtrl2", myCtrl2);

## 内联式注入

这种注入方式直接传入两个参数，一个是名字，另一个是一个数组。这个数组的最后一个参数是真正的方法体，其他的都是依赖的目标，但是要保证与方法体的参数顺序一致（与标记注入一样）。

	app.controller("myCtrl3",['$scope','hello1','hello2',function($scope,hello1,hello2){
			$scope.hello = function(){
				hello1.hello();
				hello2.hello();
			}
		}]);

## $injector常用的方法

#### 在angular中，可以通过`angular.injector()`获得注入器。

	var $injector = angular.injector();

#### 通过`$injector.get('serviceName')`获得依赖的服务名字

	$injector.get('$scope')

#### 通过`$injector.annotate('xxx')`获得xxx的所有依赖项

	$injector.annotate(xxx)

## 样例代码

	<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script src="http://apps.bdimg.com/libs/angular.js/1.2.16/angular.min.js"></script>
	</head>
	<body ng-app="myApp">
		<div ng-controller="myCtrl1">
			<input type="button" ng-click="hello()" value="ctrl1"></input>
		</div>
		<div ng-controller="myCtrl2">
			<input type="button" ng-click="hello()" value="ctrl2"></input>
		</div>
		<div ng-controller="myCtrl3">
			<input type="button" ng-click="hello()" value="ctrl3"></input>
		</div>
		<script type="text/javascript">
		var app = angular.module("myApp",[]);
		app.factory("hello1",function(){
			return {
				hello:function(){
					console.log("hello1 service");
				}
			}
		});
		app.factory("hello2",function(){
			return {
				hello:function(){
					console.log("hello2 service");
				}
			}
		});

		var $injector = angular.injector();
		console.log(angular.equals($injector.get('$injector'),$injector));//true
		console.log(angular.equals($injector.invoke(function($injector) {return $injector;}),$injector));//true

		//inferred
		// $injector.invoke(function(serviceA){});
		app.controller("myCtrl1", function($scope,hello1,hello2){
			$scope.hello = function(){
				hello1.hello();
				hello2.hello();
			}
		});

		//annotated
		// function explicit(serviceA) {};
		// explicit.$inject = ['serviceA'];
		// $injector.invoke(explicit);
		var myCtrl2 = function($scope,hello1,hello2){
			$scope.hello = function(){
				hello1.hello();
				hello2.hello();
			}
		}
		myCtrl2.$injector = ['hello1','hello2'];
		app.controller("myCtrl2", myCtrl2);

		//inline
		app.controller("myCtrl3",['$scope','hello1','hello2',function($scope,hello1,hello2){
		// app.controller("myCtrl3",['$scope','hello1','hello2',function(a,b,c){
			// a.hello = function(){
			// 	b.hello();
			// 	c.hello();
			// }
			$scope.hello = function(){
				hello1.hello();
				hello2.hello();
			}
		}]);

		console.log($injector.annotate(myCtrl2));//["$scope","hello1","hello2"]
		</script>
	</body>
	</html>

作者：[xingoo](http://www.cnblogs.com/xing901022)
出处：http://www.cnblogs.com/xing901022

[本文版权归作者和博客园共有。欢迎转载，但必须保留此段声明，且在文章页面明显位置给出原文连接！]()

分类: [AngularJS](https://www.cnblogs.com/xing901022/category/658522.html)

标签: [AngularJS](https://www.cnblogs.com/xing901022/tag/AngularJS/), [injector](https://www.cnblogs.com/xing901022/tag/injector/)

 [好文要顶](AngularJS%20API之$injector%20----%20依赖注入%20-%20xingoo%20-%20博客园.md#)  [关注我](AngularJS%20API之$injector%20----%20依赖注入%20-%20xingoo%20-%20博客园.md#)  [收藏该文](AngularJS%20API之$injector%20----%20依赖注入%20-%20xingoo%20-%20博客园.md#)  [![icon_weibo_24.png](AngularJS%20API之$injector%20----%20依赖注入%20-%20xingoo%20-%20博客园.md#)  [![wechat.png](AngularJS%20API之$injector%20----%20依赖注入%20-%20xingoo%20-%20博客园.md#)

 [![20200726175626.png](../_resources/05e4292cf7d323734bfe0618ce6ae04a.png)](https://home.cnblogs.com/u/xing901022/)

 [xingoo](https://home.cnblogs.com/u/xing901022/)
 [关注 - 79](https://home.cnblogs.com/u/xing901022/followees/)
 [粉丝 - 3855](https://home.cnblogs.com/u/xing901022/followers/)

 [+加关注](AngularJS%20API之$injector%20----%20依赖注入%20-%20xingoo%20-%20博客园.md#)

 0

 0

 [«](https://www.cnblogs.com/xing901022/p/4937651.html) 上一篇： [AngularJS API之extend扩展对象](https://www.cnblogs.com/xing901022/p/4937651.html)

 [»](https://www.cnblogs.com/xing901022/p/4944043.html) 下一篇： [Elasticsearch聚合初探——metric篇](https://www.cnblogs.com/xing901022/p/4944043.html)

posted @ 2015-11-05 23:02 [xingoo](https://www.cnblogs.com/xing901022/)  阅读(19785)  评论(3) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=4941166) [收藏](AngularJS%20API之$injector%20----%20依赖注入%20-%20xingoo%20-%20博客园.md#)
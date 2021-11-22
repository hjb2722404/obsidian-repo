angular自定义指令中的transclusion以及自定义指令的嵌套 - 前端小札 - SegmentFault 思否

 [ ![user-64.png](../_resources/328f423f1e5df4bb6baab3ec84430d81.png)     **skycity**](https://segmentfault.com/u/skycity)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='1'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='172' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  118

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='2'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='176' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/skyroom)

[![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-comment-alt-lines fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='comment-alt-lines' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='5'%3e%3cpath fill='currentColor' d='M448 0H64C28.7 0 0 28.7 0 64v288c0 35.3 28.7 64 64 64h96v84c0 7.1 5.8 12 12 12 2.4 0 4.9-.7 7.1-2.4L304 416h144c35.3 0 64-28.7 64-64V64c0-35.3-28.7-64-64-64zm16 352c0 8.8-7.2 16-16 16H288l-12.8 9.6L208 428v-60H64c-8.8 0-16-7.2-16-16V64c0-8.8 7.2-16 16-16h384c8.8 0 16 7.2 16 16v288zm-96-216H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h224c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16zm-96 96H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h128c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16z' data-evernote-id='187' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://segmentfault.com/a/1190000007554744#comment-area)

#   [angular自定义指令中的transclusion以及自定义指令的嵌套](https://segmentfault.com/a/1190000007554744)

[javascript](https://segmentfault.com/t/javascript)[angularjs](https://segmentfault.com/t/angularjs)

 发布于 2016-11-21

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

## 初衷

写这篇文章的初衷有以下几点：
> 1.最近项目中需要用到ng的自定义指令，并且还涉及到自定义指令的嵌套。
> 2.百度和谷歌找到的答案都不尽人意。
所以想着自己写一篇得了。

## 事先声明

> 事先说明，鄙人刚入前端4月有余，属于新蛋一枚，也是初次写博客（第一次就这么献给sf了。），我尽自己最大的努力把我想表达的意思表达出来。好了，废话不多说，直接奔入主体。

## 前提

首先，还不知道ng自定义指令的童鞋请戳这篇文章。

[http://www.cnblogs.com/lvdaba...](http://www.cnblogs.com/lvdabao/p/3391634.html)

这篇文章分了上中下，三篇，讲ng自定义指令已经很详细了。
其次，还不知道ng自定义指令中的transclusion是啥玩意童鞋请戳这篇文章。

[http://www.html-js.com/articl...](http://www.html-js.com/article/Using-Angular-to-develop-web-application-completely-understand-AngularJS-transclusion)

这篇文章采用口语化的表达方式诙谐的讲述了何为transclusion。
好了，到这里，我们正式再次进入主题。

## transclusion的值

我们先创建一个app,代码如下

	var app=angular.module('myApp', []);
	app.controller("testController",function($scope){
	
	});

我们都知道transclusion是自定义指令的的配置项，它的值有以下几种情况：
> 1.boolean类型，也就是为true,或者false,当然，默认为false。
> 2.Object类型，可以是一个对象。
> 3.element类型，还可以是一个元素。（表示：我目前还没有玩过element。）

## transclusion为boolean时

好了，先来说说其值为boolean类型的时候吧。
创建一个自定义指令，设置其transclusion为true。代码如下：

	app.directive('popSelect',[function(){
	  return {
	    restrict: 'AE',
	    scope:{
	
	    },
	    transclude:true,
	    replace:true,
	    template:
	       '<div>'+
	          '<div>'+
	              '<input type="text" ng-model="input" ng-focus="hasDate=true"/>'+
	           '</div>'+
	           '<div ng-transclude></div>'+
	           '<div>这是popselect指令的内容</div>'+
	        '</div>',
	        link:function(scope, elem, attrs){
	
	        }
	    }
	}]);

大家应该有看到在template里面多了一个东西是'<div ng-transclude></div>'，看到就可以了，在这里留个悬念。
既然是自定义指令的嵌套，那好歹也要有两个指令吧，废话不多说，再创建一个指令，此指令作为儿子被别人嵌套，而上面那个嵌套别人的指令我们叫做父亲。代码如下：

	app.directive('childElem',[function(){
	    return {
	        restrict: 'AE',
	        replace:true,
	        template:'<div>'+
	                    '<div>这是child指令的内容</div>'+
	                 '</div>',
	        link:function(scope, elem, attrs){
	
	        }
	    }
	}])

父亲和儿子都创建完成了，那我们来看看html里面是怎么嵌套了。直接上代码：

	<pop-select>
	    <child-elem></child-elem>
	</pop-select>

没错，html就是这么简单就可以了，看看页面是啥效果：
![bVFQ2B](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173037.png)

看到没，儿子的template内容被嵌入进父亲的template（姑且认为是template吧），那么它被嵌入到父亲的template的哪里了呢，我们看看控制台。

![bVFQ3S](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173040.png)
大家有没有发现什么，上图红框中的位置是不是恰好就是父亲的template的'<div ng-transclude></div>'这句话所在位置呀。

`没错，只要你的指令中嵌套其他的指令，那么你在父亲的配置项中设置transclude:true，并且在template中你需要的地方加上'<div ng-transclude></div>'这句嵌套话，那么ng将自动把儿子的内容加入到'<div ng-transclude></div>'这个标签中来，请仔细看控制台红框的图片。`

现在大家自动transclude:true怎么用了吧。

## transclusion为object时

这里有人就要问了：你这是嵌套一个儿子啊，如果我家钱多，我土豪，我要生很多个儿子那怎么办？
那此时就要使用transclude的值为object了。废话不多说再次上代码。

	app.directive('parentDirective',[function(){
	  return {
	     restrict: 'AE',
	     transclude:{
	         'child1':"childElem",
	          'child2':"childElem2",
	           'child3':"childElem3"
	     },
	     replace:true,
	     template:
	       '<div>'+
	          '<div>'+
	             '<input type="text" ng-model="input" value="这是parant指令"/>'+
	          '</div>'+
	          '<div ng-transclude="child2"></div>'+
	          '<div ng-transclude="child3"></div>'+
	          '<div ng-transclude="child1"></div>'+
	       '</div>',
	        link:function(scope, elem, attrs){
	
	        }
	    }
	}]);

大家注意到这一次父亲的transclude是一个对象

	         {
	            'child1':"childElem",
	            'child2':"childElem2",
	            'child3':"childElem3"
	         }

在父亲的template中还有这样三句话：

	      '<div ng-transclude="child2"></div>'+
	      '<div ng-transclude="child3"></div>'+
	      '<div ng-transclude="child1"></div>'+

大家可能注意到这三句话中的child1，child2，child3怎么和父亲的transclude值中的三个属性child1，child2，child3一毛一样啊。猜猜呗，我想有人应该知道是怎么玩了。

那父亲的transclude值中的childElem，childElem2，childElem3这三个是啥玩意？别急嘛。这不，父亲还没有儿子吗？来，给他三个儿子。

首先是大儿子：

	app.directive('childElem',[function(){
	    return {
	        restrict: 'AE',
	        replace:true,
	        template:'<div>'+
	                    '<div>这是child指令的内容</div>'+
	                 '</div>',
	        link:function(scope, elem, attrs){
	
	        }
	    }
	}])

然后是二儿子：

	 app.directive('childElem2',[function(){
	    return {
	        restrict: 'AE',
	        replace:true,
	        template:'<div>'+
	                    '<div>这是childElem2指令的内容</div>'+
	                 '</div>',
	        link:function(scope, elem, attrs){
	
	        }
	    }
	}])

最后是三儿子：

	app.directive('childElem3',[function(){
	    return {
	        restrict: 'AE',
	        replace:true,
	        template:'<div>'+
	                    '<div>这是childElem3指令的内容</div>'+
	                 '</div>',
	        link:function(scope, elem, attrs){
	
	        }
	    }
	}])

儿子们到齐了，接下来就该html了。继续上代码：

	<parent-directive>
	    <child-elem></child-elem>
	    <child-elem2></child-elem2>
	    <child-elem3></child-elem3>
	</parent-directive>

那么页面效果是啥样子呢？看下图：
![bVFRs7](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173049.png)
看，三个的儿子的内容和父亲的内容都显示出来了。
让我们再看看控制台：
![bVFRtx](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173056.png)
三个红框中的内容就是三个儿子的template了。

`大家现在应该明白了吧，没错。当父亲的transclude是一个对象时，那么属性名就是你自己起的名字， 值就是你需要嵌入的儿子的名字。然后你再在父亲的template里面写上'<div ng-transclude="你起好的属性名字"></div>'，这样ng就能知道你是想把儿子嵌入到父亲的哪里了。`

好了，还没有不明白的么。如果不明白请看第二遍。哈哈、

## 全部示例代码

最后，附上本例中的全部代码。

	<!DOCTYPE html>
	<html ng-app="myApp">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	</head>
	<body ng-controller="testController">
	    <h1>嵌套一个指令</h1>
	       <pop-select>
	          <child-elem></child-elem>
	       </pop-select>
	
	    <h1>&nbsp;</h1>
	
	    <h1>嵌套多个指令</h1>
	       <parent-directive>
	           <child-elem></child-elem>
	           <child-elem2></child-elem2>
	           <child-elem3></child-elem3>
	       </parent-directive>
	</body>
	<script src="https://staticfile.qnssl.com/angular.js/1.5.0-rc.0/angular.min.js"></script>
	<script>
	   var app=angular.module('myApp', []);
	   app.controller("testController",function($scope){
	
	   });
	   app.directive('popSelect',[function(){
	      return {
	        restrict: 'AE',
	        scope:{
	
	        },
	        transclude:true,
	        replace:true,
	        template:'<div>'+
	                    '<div><input type="text" ng-model="input" ng-focus="hasDate=true"/></div>'+
	                    '<div ng-transclude></div>'+
	                    '<div>这是popselect指令的内容</div>'+
	                 '</div>',
	        link:function(scope, elem, attrs){
	
	        }
	    }
	}]);
	
	app.directive('childElem',[function(){
	    return {
	        restrict: 'AE',
	        replace:true,
	        template:'<div>'+
	                    '<div>这是child指令的内容</div>'+
	                 '</div>',
	        link:function(scope, elem, attrs){
	
	        }
	    }
	}])
	
	app.directive('parentDirective',[function(){
	  return {
	     restrict: 'AE',
	     transclude:{
	         'child1':"childElem",
	          'child2':"childElem2",
	           'child3':"childElem3"
	     },
	     replace:true,
	     template:
	       '<div>'+
	          '<div>'+
	             '<input type="text" ng-model="input" value="这是parant指令"/>'+
	          '</div>'+
	          '<div ng-transclude="child2"></div>'+
	          '<div ng-transclude="child3"></div>'+
	          '<div ng-transclude="child1"></div>'+
	       '</div>',
	        link:function(scope, elem, attrs){
	
	        }
	    }
	}]);
	app.directive('childElem2',[function(){
	    return {
	        restrict: 'AE',
	        replace:true,
	        template:'<div>'+
	                    '<div>这是childElem2指令的内容</div>'+
	                 '</div>',
	        link:function(scope, elem, attrs){
	
	        }
	    }
	}])
	
	app.directive('childElem3',[function(){
	    return {
	        restrict: 'AE',
	        replace:true,
	        template:'<div>'+
	                    '<div>这是childElem3指令的内容</div>'+
	                 '</div>',
	        link:function(scope, elem, attrs){
	
	        }
	    }
	}])
	</script>
	</html>

谢谢大家的耐心观看。

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

阅读 2.7k  更新于 2019-08-26

本作品系 原创， [采用《署名-非商业性使用-禁止演绎 4.0 国际》许可协议](https://creativecommons.org/licenses/by-nc-nd/4.0/)

* * *

 [![user-64.png](../_resources/328f423f1e5df4bb6baab3ec84430d81.png)](https://segmentfault.com/u/skycity)

#####   [skycity](https://segmentfault.com/u/skycity)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='17'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  118

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='18'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z'%3e%3c/path%3e%3c/svg%3e)](https://github.com/skyroom)
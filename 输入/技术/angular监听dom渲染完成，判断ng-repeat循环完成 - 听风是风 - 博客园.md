angular监听dom渲染完成，判断ng-repeat循环完成 - 听风是风 - 博客园

## [angular监听dom渲染完成，判断ng-repeat循环完成](https://www.cnblogs.com/echolun/p/10162133.html)

**一、前言**

最近做了一个图片懒加载的小插件，功能需要dom渲染完成后，好获取那些需要懒加载的dom元素。那么问题来了，如果只是感知静态的dom用ready，onload都可以，但项目用的angular，ng-repeat什么时候循环完，或者说angular自身的生命周期中dom渲染完成怎么知道，这里做个解决问题的记录。

**二、网上流传的解决方案**
**1.data-ng-init---无效**
大概意思是，给你需要监听的dom，比如body添加一个data-ng-init属性，绑定你需要在body加载完成后执行的方法。
<div data-ng-init = "load()"></div>$scope.load = function () { //dosomething};

我查了下资料，在stackoverflow中找到了相关介绍，data-ng-init本质是ng-init，只是在对于H5之前，ng写法会报错，为了解决这个错误而添加data前缀达到兼容的写法，所以本质还是ng-init。

> 在HTML5开始之后，像Visual Studio这样的代码编辑器突出显示'ng-'，这是无效的。> 但实际上它是有效的，所以有一种方法可以让代码编辑器通过在前面加上'data-ng- *'来理解AngularJS的属性是有效的。

> 因此，当在任何HTML5代码编辑器中使用前缀时，它不会强调属性并将它们视为有效。

> 这是'data- *'前缀的最初目的。-----> [> 点我跳转原回答](https://stackoverflow.com/questions/36027539/angular-js-difference-between-ng-init-and-data-ng-init)

那我们就改为ng-init测试下，当我执行ng-init中的代码时，是不是连angular自身的动态dom都加载完成了。
我将ng-init直接绑在了一个需要ng-repeat的ul上，当断点已经执行了我load方法
![1213309-20181222180248819-482222524.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173011.png)
我去看了此时的dom渲染情况
![1213309-20181222180326427-1835070038.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173015.png)
ul里面一个li都没有，空的，说明根本没解析完成啊，这个方法也就能感知下静态dom渲染，angular的无效，所以不符合我的要求，排除。
 **2.$viewContentLoaded事件---无效**
大量博客都说了这个方法，那看来是非常的有效啊，去官网查了下api，介绍少之又少
![1213309-20181222180932920-820849234.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173019.png)

英文不好，大概意思是，需要结合ng-view指令使用，只要ng-view指令范围的视图需要重新渲染，通过监听$viewContentLoaded，就能针对改变做你想做的操作了。

<div ng-view></div>

$scope.$on('$viewContentLoaded', function () { //dosomething});
测试了下，代码没执行，又去翻了下资料，怀疑是不是自己用错了，找到了一个关于使用的的特殊说明

> 当ngView内容被重新加载时，从ngView作用域上发布, 通过$emit将事件沿着作用域向上传播（子作用域到父作用域），也就是说你监听这个事件必须得在那个View的上层作用域。----> [> 点我查看原文](http://www.codes51.com/itwd/3700260.html)

也没错啊，将$on换成$watch还是没效，先不说有没有效，这东西只是说感知ng-view变化时执行，没说dom加载完成后执行，不是我要找的东西。排除在外。
**3.自定义指令，$last === true---有bug**

因为我做图片懒加载的要求是，在执行懒加载方法前这些img元素都已经渲染好了，我能抓到它们。而这些图片说到底就是通过ng-repeat渲染出来的，既然感知angular dom渲染完成无效，换种思路，能不能得知ng-repeat什么时候渲染完成呢？

通过自定义指令repeatFinish，监听ng-repeat状态。
[![copycode.gif](angular监听dom渲染完成，判断ng-repeat循环完成%20-%20听风是风%20-%20博客园.md#)
<ul>
<li ng-repeat="item in data track by $index" repeat-finish></li>
</ul>angular
.module("mainApp")

.directive('repeatFinish', [function () { //判断ng-repeat是否渲染完成的自定义指令，暂时没用到，以后可能会用  return {

restrict: 'EA',

link: function (scope, element, attr) { if(scope.$last === true) { //dosomething };

},
};
}]);
[![copycode.gif](angular监听dom渲染完成，判断ng-repeat循环完成%20-%20听风是风%20-%20博客园.md#)

在ng-repeat过程中，scope作用域中有一个$last的状态变量，当循环到最后一个元素时，它就会变成true，而这个方法是写在link中的，link是为dom绑定相关指令事件的，赶紧去测试下，打个断点

![1213309-20181222190118398-1857721466.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173023.png)

出问题了，我需要循环的数组其实有10条数据，理论上来说，一开始索引$index应该从0开始，但是这里却直接从1开始了，也就是第二条数据，假设我需要循环的数据一共就1条，link里面的函数直接就不触发了。

其次，因为我实际使用是在产品分类页中，点击不同产品分类，被循环的数据data其实是在改变的，有趣的是，假设A类产品有4条，B类产品有3条，由4条切换到3条的过程中，也不会触发link中的函数。

对于这种做法的问题，大概归纳为两点：
一是数据只有1条时监听不到，方法是通用的，谁知道你要遍历的数据有几条。

当需要repeat的数据是可变的，由多变少的过程不会触发，少变多的过程会触发，说到底还是有问题，用不了，有兴趣的同学可以写demo测试下，我暂时也解释不了为什么会这样。

**三、靠谱的解决方案**
功夫不负有心人，在简书的一篇文章中，找到了可行靠谱的方法，使用$timeout。
[![copycode.gif](angular监听dom渲染完成，判断ng-repeat循环完成%20-%20听风是风%20-%20博客园.md#)
<ul>
<li ng-repeat="item in data track by $index"></li>
</ul>$timeout(function () { //处理dom加载完成，或者repeat循环完成要做的事情},0);
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)

原理是什么呢，大家都知道，js的定时器其实也是异步的，$timeout其实只是angular为了能自动触发脏检测而封装的方法，同样也是异步。将你需要执行的方法放在$timeout中，它就会等到所有的dom渲染完成以及同步逻辑跑完最后执行，真的是让人眼前一亮！

**方案出处  [实现AngularJS渲染完毕后执行脚本](https://www.jianshu.com/p/5bb0acd5322a)**
**四、关于写博客的自我反应**

在我查解决方案的过程中，我确实是被一些博客弄的特别烦躁和恼火，文章内容全靠复制，代码自己不试验，比如谈到$viewContentLoaded几乎没有人提都没提这个东西是结合ng-view使用的，内容全是大同小异，怎么用也不说清楚，复制粘贴来的东西终究是别人的，那这篇博客的产出说到底浪费自己和读者的时间。这也提醒了我自己，对于以后的博客编写，涉及到代码相关的，一定亲自试验，保证可用。

学习不是一天两天，没有捷径，唯有积累。

标签: [angularjs](https://www.cnblogs.com/echolun/tag/angularjs/)

 [好文要顶](angular监听dom渲染完成，判断ng-repeat循环完成%20-%20听风是风%20-%20博客园.md#)  [关注我](angular监听dom渲染完成，判断ng-repeat循环完成%20-%20听风是风%20-%20博客园.md#)  [收藏该文](angular监听dom渲染完成，判断ng-repeat循环完成%20-%20听风是风%20-%20博客园.md#)  [![icon_weibo_24.png](angular监听dom渲染完成，判断ng-repeat循环完成%20-%20听风是风%20-%20博客园.md#)  [![wechat.png](angular监听dom渲染完成，判断ng-repeat循环完成%20-%20听风是风%20-%20博客园.md#)

 [![20200507225901.png](../_resources/d2583d1c51523637c6d05d483c6bcf73.png)](https://home.cnblogs.com/u/echolun/)

 [听风是风](https://home.cnblogs.com/u/echolun/)
 [关注 - 3](https://home.cnblogs.com/u/echolun/followees/)
 [粉丝 - 300](https://home.cnblogs.com/u/echolun/followers/)

 [+加关注](angular监听dom渲染完成，判断ng-repeat循环完成%20-%20听风是风%20-%20博客园.md#)

 1

 0

 [«](https://www.cnblogs.com/echolun/p/10146197.html) 上一篇： [JQ的offset().top与js的offsetTop区别详解](https://www.cnblogs.com/echolun/p/10146197.html)

 [»](https://www.cnblogs.com/echolun/p/10187245.html) 下一篇： [前端错误监控，sentry入门配置详细教程](https://www.cnblogs.com/echolun/p/10187245.html)

posted on 2018-12-22 19:14 [听风是风](https://www.cnblogs.com/echolun/)  阅读(1908)  评论(2) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=10162133) [收藏](angular监听dom渲染完成，判断ng-repeat循环完成%20-%20听风是风%20-%20博客园.md#)
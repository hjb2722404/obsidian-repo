Javascript定时器学习笔记 - 木的树 - 博客园

# [Javascript定时器学习笔记](https://www.cnblogs.com/dojo-lzz/p/4606448.html)

　　掌握定时器工作原理必知：**JavaScript引擎是单线程运行的,浏览器无论在什么时候都只且只有一个线程在运行JavaScript程序. **常言道：setTimeout和setInterval是伪线程。

　　Javascript是运行在单线程环境中的，在页面的声明周期中，不同时间可能有其他代码在控制Javascript进程，比如：包含在<script>元素中的代码、dom元素的事件处理程序、Ajax的回调函数。定时器仅仅是在未来的某个时刻将代码添加到**代码队列**中，执行时机是不能保证的。代码队列按照先进先出的原则在主进程空闲后将队列中的代码交给主线程运行。

　　![282345313771406.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143940.png)

　　在不同时间段内Javascript主进程处于不同状态，开始时执行页面中<script>元素内的代码，初始加载完成后，主进程进入空闲状态，这时候有dom元素产生click事件，事件处理代码被添加到代码队列中，代码队列发现Javascript主进程处于空闲状态，立即将队列中的第一个元素交给主进程执行。上图便是这一个过程的时间线。

　　**在Javascript中没有任何代码是立刻执行的，带一旦进程空闲则尽快执行。**例如，当某个按钮被按下时，事件处理函数会被添加到代码队列中。当接收到ajax响应时，回校函数的代码被添加到队列中。**而定时器对队列的工作方式是，当特定的事件过去后将代码加入到队列中。**设定一个150ms后执行的定时器不代表代码会在150ms之后执行，而是指代码会在150ms后加入到代码队列中。等到主进程空闲时并且该元素位于队列首位，其中的代码便会立即执行，看上去好像是在精确的时间点上执行了。实际上队列中的所有代码都要等到主进程空闲之后才能执行，而不管他们是怎额添加到队列中去的。

[![copycode.gif](Javascript定时器学习笔记%20-%20木的树%20-%20博客园.md#)
var ele = document.getElementById('btn');
ele.onclick = function(){
setTimeout(function(){
document.getElementById(message).style.backgroundColor = "red";
}, 255); var start = Date.now(); while(Date.now() - start < 300) {};
}
[![copycode.gif](Javascript定时器学习笔记%20-%20木的树%20-%20博客园.md#)

　　以上示例中，定时器在255ms事被插入到代码队列中，但Javascript主线程有300ms处于运行状态，那么定时器代码至少要在定时器设置之后的300ms后才会被执行。以下时间线代表了上面代码的执行过程。

![290009158615917.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143944.png)

　　**重复定时器setInterval**

　　为了确保定时器代码插入到队列总的最小间隔为指定时间。当使用setInterval()时，仅当没有该定时器的任何其他**代码实例**时，才能将定时器代码添加到代码队列中。假设没有这条原则，setInterval()创建的定时器确保了定时器代码能够规则的插入队列中。那么问题来了，假设Javascript主进程的运行时间非常长，那么setInterval的代码被多次添加到了代码队列中，等到主进程空闲时，定时器代码便会连续执行多次而之间不会有任何停顿。

　　但是这条规则同样也带来了两个问题：
1. 某些间隔会被跳过
2. 多个定时器的代码执行之间的间隔可能会比预期的小
[![copycode.gif](Javascript定时器学习笔记%20-%20木的树%20-%20博客园.md#)
var ele = document.getElementById('btn');
ele.onclick = function(){
setInterval(function(){

　　　　console.log('run interval'); var start = Date.now(); while(Date.now() - start < 350) {};

}, 200); var start = Date.now(); while(Date.now() - start < 300) {};
}
[![copycode.gif](Javascript定时器学习笔记%20-%20木的树%20-%20博客园.md#)

　　以上代码中，click事件处理程序中通过setInterval设置了一个200ms的时间间隔的重复定时器。从以上代码可以看出事件处理程序花了300ms多的时间完成，而定时器代码也花了300ms的时间，这个时候就会出现跳过间隔且连续两次运行定时器代码的情况。请看下图：

　　![290032396898473.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143949.png)

　　上图中，第一个定时器在205ms出添加到队列中的，但是直到过了300ms才能够执行。当执行定时器代码时，在405ms时有一个定时器代码实例被添加到等待队列中。在605ms处第一个定时器代码仍然在运行，同时在代码队列中已经有了另一个定时器的代码实例。所以在这个时间点上的定时器代码不会被添加到队列中。结果在205ms处添加的定时器代码执行完毕后，405ms处添加的定时器代码会立即执行。

　　所以在使用setInterval做动画时要注意两个问题：
1. 不能使用固定步长作为做动画，一定要使用百分比: 开始值 + (目标值 - 开始值) * （Date.now() - 开始时间）/ 时间区间
2. 如果主进程运行时间过长，会出现跳帧的现象
　　为了避免setInterval的两个缺点，可以使用链式setTimeout（）：
setTimeout(function(){ //其他处理 setTimeout(arguments.callee, interval);
}, interval);

 　　以上文章内容主要来自《Javascript高级程序设计》

您可以考虑给树发个小额微信红包以资鼓励![412020-20171216224224593-1205430224.png](../_resources/2576ceb0735879bac0f5b1897e31138d.png)

标签: [javascript](http://www.cnblogs.com/dojo-lzz/tag/javascript/)

 [好文要顶](Javascript定时器学习笔记%20-%20木的树%20-%20博客园.md#)  [关注我](Javascript定时器学习笔记%20-%20木的树%20-%20博客园.md#)  [收藏该文](Javascript定时器学习笔记%20-%20木的树%20-%20博客园.md#)  [![icon_weibo_24.png](Javascript定时器学习笔记%20-%20木的树%20-%20博客园.md#)  [![wechat.png](Javascript定时器学习笔记%20-%20木的树%20-%20博客园.md#)

 [![20160315154755.png](../_resources/6a44ce6a661231aa402d7d613a437796.jpg)](http://home.cnblogs.com/u/dojo-lzz/)

 [木的树](http://home.cnblogs.com/u/dojo-lzz/)
 [关注 - 7](http://home.cnblogs.com/u/dojo-lzz/followees)
 [粉丝 - 752](http://home.cnblogs.com/u/dojo-lzz/followers)

 [+加关注](Javascript定时器学习笔记%20-%20木的树%20-%20博客园.md#)

[«](http://www.cnblogs.com/dojo-lzz/p/4591446.html) 上一篇：[Web性能优化：What? Why? How?](http://www.cnblogs.com/dojo-lzz/p/4591446.html)

[»](http://www.cnblogs.com/dojo-lzz/p/4621627.html) 下一篇：[CSS：谈谈栅格布局](http://www.cnblogs.com/dojo-lzz/p/4621627.html)

posted @ 2015-06-29 00:44  [木的树](http://www.cnblogs.com/dojo-lzz/) 阅读(2058) 评论(9) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=4606448)  [收藏](http://www.cnblogs.com/dojo-lzz/p/4606448.html#)
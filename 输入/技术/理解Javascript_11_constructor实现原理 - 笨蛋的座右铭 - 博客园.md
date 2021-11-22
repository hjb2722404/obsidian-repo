理解Javascript_11_constructor实现原理 - 笨蛋的座右铭 - 博客园

# [理解Javascript_11_constructor实现原理](https://www.cnblogs.com/fool/archive/2010/10/16/1853126.html)

在理解了'对象模型'后,我们就可以看一下constructor属性是如何实现的.
**constructor是什么**
简单的理解,constructor指的就是对象的构造函数。请看如下示例：
1
2
3
4
5
6
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]

对于foo.constructor为Foo,我想应该很好理解，因为foo的构造函数为Foo。对于Foo、Object、Function的构造函数为Function,我想也没什么好争议的。（因为Foo,Object,Function都是函数对象，又因为所有的函数对象都是Function这个函数对象构造出来,所以它们的constructor为Function,详细请参考《js_函数对象》)

**Prototype与Constructor的关系**
1
2
[object Object]
[object Object]

在 JavaScript 中，每个函数都有名为“prototype”的属性，用于引用原型对象。此原型对象又有名为“constructor”的属性，它反过来引用函数本身。这是一种循环引用，如图：

![2010101615092176.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120617.gif)

**constructor属性来自何方**
我们来看一下Function构造String的构造过程：
![2010101716285514.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120620.png)

注：Function构造任何函数对象的过程都是一样的，所以说不管是String,Boolean,Number等内置对象，还是用户自定义对象,其构造过程都和上图一样。这里String只是一个代表而矣！

图中可以看出constructor是Function在创建函数对象时产生的，也正如'prototype与constructor的关系'中讲的那样，constructor是函数对象prototype链中的一个属性。即String=== String.prototype.constructor。

我还想用一段代码来证明一下,理论是正确的：
1
2
3
4
5
6
7
8
9
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]

[object Object]
[object Object]
[object Object]
到现在，你会发现这和前面《原型链的实现原理》中的默认prototype指向Object.prototype有冲突，显然当时的理论不是很全面。

**特别的Object**
用心的读者可能会提出这样一问题,你这一套理论并不能适用于Object。因为以下的代码和你上面的理论是冲突的：

1
2
[object Object]
[object Object]

真的是这样吗？不是！那我们来看一下特殊的Object是如何处理的：
![2010101716251570.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120623.png)

你会发现，这图的原理和上面一张图的原理是一样的。这就能正确解释Object.prototype.hasOwnProperty('isPrototypeOf')为true!

**constructor探究**
1
2
3
4
5
6
[object Object]

[object Object]

[object Object]
[object Object]
根据上一节的内容，你能正确的理解这段代码的结果吗？思考后，看一下其内存表示：

![2010101715300756.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120626.png)
这张图明确有表明了Function构造Animal和Person的过程。同时也显示了实例person与Person的关系。

再深入一点，代码如下：
1
2
3
4
5
6
7
[object Object]
[object Object]

[object Object]

[object Object]
[object Object]
这个时候，person的构造函数成了Animal，怎么解释？
![2010101715344413.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120630.png)

注：图中的虚线表示Person默认的prototype指向(只作参考的作用)。但是我们将Person.prototype指向了new Animal。
此时，Person的prototype指向的是Animal的实例，所以person的constructor为Animal这个构造函数。

结论：constructor的原理非常简单，就是在对象的原型链上寻找constructor属性。

注:如果你无法正确理解本文内容，请回顾前面章节的内容。

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_11_constructor实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_11_constructor实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_11_constructor实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_11_constructor实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_11_constructor实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_11_constructor实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)

 4

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/15/1851856.html) 上一篇： [理解Javascript_10_对象模型](https://www.cnblogs.com/fool/archive/2010/10/15/1851856.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/16/1853326.html) 下一篇： [理解Javascript_12_执行模型浅析](https://www.cnblogs.com/fool/archive/2010/10/16/1853326.html)

posted @ 2010-10-16 16:27 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(3963)  评论(21) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1853126) [收藏](理解Javascript_11_constructor实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)
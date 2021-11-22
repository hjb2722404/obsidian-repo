理解Javascript_07_理解instanceof实现原理 - 笨蛋的座右铭 - 博客园

# [理解Javascript_07_理解instanceof实现原理](https://www.cnblogs.com/fool/archive/2010/10/14/1850910.html)

在《[Javascript类型检测](http://www.cnblogs.com/fool/archive/2010/10/07/javascrpt.html)》一文中讲到了用instanceof来用做检测类型，让我们来回顾一下:

![2010101400182269.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120535.png)
 那么instanceof的这种行为到底是如何实现的呢,现在让我们揭开instanceof背后的迷雾。

**instanceof原理**
照惯例，我们先来看一段代码：
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
[object Object]
[object Object]

[object Object]
[object Object]

[object Object]
[object Object]
[object Object]

[object Object]
[object Object]
[object Object]
[object Object]

[object Object]
[object Object]
[object Object]
[object Object]

[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
让我们画一张内存图来分析一下：
![2010101400563279.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120538.png)
内存图比较复杂，解释一下：

程序本身是一个动态的概念，随着程序的执行，Dog.prototype会不断的改变。但是为了方便，我只画了一张图来表达这三次prototype引用的改变。在堆中，右边是函数对象的内存表示,中间的是函数对象的prototype属性的指向，左边的是函数对象创建的对象实例。其中函数对象指向prototype属性的指针上写了dog1,dog2,dog3分别对应Dog.prototype的三次引用改变。它们和栈中的dog1,dog2,dog3也有对应的关系。(注：关于函数对象将在后续博文中讲解)

来有一点要注意，就是dog3中函数对象的prototype属性为null,则函数对象实例dog3的内部[[prototype]]属性将指向Object.prototype,这一点在《[理解Javascript_06_理解对象的创建过程](http://www.cnblogs.com/fool/archive/2010/10/13/1850588.html)》已经讲解过了。

**结论**
根据代码运行结果和内存结构，推导出结论：

instanceof 检测一个对象A是不是另一个对象B的实例的原理是：查看对象B的prototype指向的对象是否在对象A的[[prototype]]链上。如果在，则返回true,如果不在则返回false。不过有一个特殊的情况，当对象B的prototype为null将会报错(类似于空指针异常)。

这里推荐一篇文章，来自于岁月如歌，也是关于instanceof原理的，角度不同，但有异曲同工之妙。
1
[object Object]

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_07_理解instanceof实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_07_理解instanceof实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_07_理解instanceof实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_07_理解instanceof实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_07_理解instanceof实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_07_理解instanceof实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)

 11

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/13/1850588.html) 上一篇： [理解Javascript_06_理解对象的创建过程](https://www.cnblogs.com/fool/archive/2010/10/13/1850588.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/14/1851017.html) 下一篇： [理解Javascript_08_函数对象](https://www.cnblogs.com/fool/archive/2010/10/14/1851017.html)

posted @ 2010-10-14 01:19 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(9147)  评论(6) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1850910) [收藏](理解Javascript_07_理解instanceof实现原理%20-%20笨蛋的座右铭%20-%20博客园.md#)
理解Javascript_01_理解内存分配 - 笨蛋的座右铭 - 博客园

# [理解Javascript_01_理解内存分配](https://www.cnblogs.com/fool/archive/2010/10/07/1845226.html)

　　在正式开始之前，我想先说两句，理解javascript系列博文是通过带领大家分析javascript执行时的内存分配情况，来解释javascript原理，具体会涵盖javascript预加载，闭包原理，面象对象，执行模型，对象模型...,文章的视角很特别，也非常深入，希望大家能接受这种形式，并提供宝贵意见。

**原始值和引用值**
在ECMAScript中，变量可以存放两种类型的值，即原始值和引用值。
原始值指的就是代表原始数据类型（基本数据类型）的值，即Undefined,Null,Number,String,Boolean类型所表示的值。
引用值指的就是复合数据类型的值，即Object,Function,Array,以及自定义对象,等等

**栈和堆**
与原始值与引用值对应存在两种结构的内存即栈和堆
栈是一种后进先出的数据结构，在javascript中可以通过Array来模拟栈的行为
1
2
3
4
5
[object Object]  [object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object]
我们来看一下，与之对应的内存图：
![2010100717230870.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120421.png)
原始值是存储在栈中的简单数据段，也就是说，他们的值直接存储在变量访问的位置。

堆是存放数据的基于散列算法的数据结构，在javascript中，引用值是存放在堆中的。
引用值是存储在堆中的对象，也就是说，存储在变量处的值(即指向对象的变量，存储在栈中）是一个指针，指向存储在堆中的实际对象.
例：var obj = new Object(); obj存储在栈中它指向于new Object()这个对象，而new Object()是存放在堆中的。

那为什么引用值要放在堆中，而原始值要放在栈中，不都是在内存中吗，为什么不放在一起呢?那接下来，让我们来探索问题的答案！

首先，我们来看一下代码：
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
[object Object]  [object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]

[object Object]  [object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]  [object Object][object Object]  [object Object]

[object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object]  [object Object][object Object]  [object Object][object Object][object Object]

 然后我们来看一下内存分析图：

 ![2010100718003596.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120426.png)

变量num,bol,str为基本数据类型，它们的值，直接存放在栈中，obj,person,arr为复合数据类型，他们的引用变量存储在栈中，指向于存储在堆中的实际对象。

由上图可知，我们无法直接操纵堆中的数据，也就是说我们无法直接操纵对象，但我们可以通过栈中对对象的引用来操作对象，就像我们通过遥控机操作电视机一样，区别在于这个电视机本身并没有控制按钮。

现在让我们来回答为什么引用值要放在堆中，而原始值要放在栈中的问题：
记住一句话：能量是守衡的，无非是时间换空间，空间换时间的问题

堆比栈大，栈比堆的运算速度快,对象是一个复杂的结构，并且可以自由扩展，如：数组可以无限扩充，对象可以自由添加属性。将他们放在堆中是为了不影响栈的效率。而是通过引用的方式查找到堆中的实际对象再进行操作。相对于简单数据类型而言，简单数据类型就比较稳定，并且它只占据很小的内存。不将简单数据类型放在堆是因为通过引用到堆中查找实际对象是要花费时间的，而这个综合成本远大于直接从栈中取得实际值的成本。所以简单数据类型的值直接存放在栈中。

总结：
程序很简单，但它是一切的根本，基础是最重要的，因为摩天大厦也是一块砖一块瓦的搭建起来的。
内存是程序执行的根本，搞懂了内存，就等于搞懂了一切。
心血之作，鼓励一下自已，加油！

参考：
JavaScript高级程序设计

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_01_理解内存分配%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_01_理解内存分配%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_01_理解内存分配%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_01_理解内存分配%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_01_理解内存分配%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_01_理解内存分配%20-%20笨蛋的座右铭%20-%20博客园.md#)

 38

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/07/javascrpt.html) 上一篇： [Javascript类型检测](https://www.cnblogs.com/fool/archive/2010/10/07/javascrpt.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/07/1845253.html) 下一篇： [理解Javascript_02_理解undefined和null](https://www.cnblogs.com/fool/archive/2010/10/07/1845253.html)

posted @ 2010-10-07 18:55 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(10991)  评论(43) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1845226) [收藏](理解Javascript_01_理解内存分配%20-%20笨蛋的座右铭%20-%20博客园.md#)
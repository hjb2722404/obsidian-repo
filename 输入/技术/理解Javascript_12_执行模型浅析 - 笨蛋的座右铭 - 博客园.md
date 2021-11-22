理解Javascript_12_执行模型浅析 - 笨蛋的座右铭 - 博客园

# [理解Javascript_12_执行模型浅析](https://www.cnblogs.com/fool/archive/2010/10/16/1853326.html)

　　大家有没有想过，一段javascript脚本从载入浏览器到显示执行都经过了哪些流程，其执行次序又是如何。本篇博文将引出'javascript执行模型'的概念，并带领大家理解javascript在执行时的处理机制。

**简单的开始**
简单的代码：
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
[object Object][object Object]  [object Object][object Object][object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]
上面代码段的运行顺序是：
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

对于step1中的'脚本段'指的是<script>... ...</script>标签中的内容，还包括外部引入的脚本文件，如<script src="xxx.js"></script>也被列是脚本段的范畴。那step2中的语法分析又是什么呢？简单的理解语法分析就是查看Javascript代码的语法结构是否正确。如:

1
2
3
4
5
6
[object Object][object Object]  [object Object]
[object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object][object Object]

很明显，代码无法通过语法分析，if这个条件语句的输写语法是错误的。step3和step4中的'执行环境'是指什么，全局执行环境和调用函数创建的执行环境有什么区别?执行环境内部又有哪些处理?... ...

注：下面的部分内容为原来《javascript提速_01_引用变量优化》一文中的前两节的完整版本。

**关于执行环境(Execution Context)**
所有 JavaScript 代码都是在一个执行环境中被执行的。它是一个概念，一种机制，用来完成JavaScript运行时作用域、生存期等方面的处理。

可执行的JavaScript代码分三种类型：
1. Global Code，即全局的、不在任何函数里面的代码，例如：一个js文件、嵌入在HTML页面中的js代码等。
2. Eval Code，即使用eval()函数动态执行的JS代码。
3. Function Code，即用户自定义函数中的函数体JS代码。
不同类型的JavaScript代码具有不同的Execution Context

在一个页面中，第一次载入JS代码时创建一个全局执行环境，当调用一个 JavaScript 函数时，该函数就会进入相应的执行环境。如果又调用了另外一个函数（或者递归地调用同一个函数），则又会创建一个新的执行环境，并且在函数调用期间执行过程都处于该环境中。当调用的函数返回后，执行过程会返回原始执行环境。因而，运行中的 JavaScript 代码就构成了一个执行环境栈。

让我们来看一个示例：
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
[object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]
![2010101622105252.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120638.png)
以上是程序从上到下执行时的执行环境栈情况图。

补充说明：
全局执行环境对应的是Global Code(全局代码)
Fn1执行环境、Fn2执行环境通称为函数执行环境对应的是Function Code(函数定义代码)

程序在进入每个执行环境的时候都会创建一个叫做Variable Object的对象。

针对于函数执行环境，函数对应的每一个参数、局部变量、内部方法都会在Variable Object上创建一个属性，属性名为变量名，属性值为变量值。针对于全局执行环境，具有相同的行为。但是要强调的一点是在全局执行环境中Varible Object就是Global Object,关于Global Object在《[理解Javascript_03_javascript全局观](http://www.cnblogs.com/fool/archive/2010/10/08/1846078.html)》中已经说明了，可以简单的理解为window对象。这也就解释了全局方法和全局变量为什么都是window对象的属性或方法的原因，请看如下代码：

1
2
3
4
5
6
[object Object]
[object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]
最后要说的是，Variable Object对象是一个内部对象，JS代码中无法直接访问。

**关于Scope/Scope Chain**

 在访问变量时，就必须存在一个可见性的问题，这就是Scope。更深入的说，当访问一个变量或调用一个函数时，JavaScript引擎将不同执行位置上的Variable Object按照规则构建一个链表，在访问一个变量时，先在链表的第一个Variable Object上查找，如果没有找到则继续在第二个Variable Object上查找，直到搜索结束。这也就形成了Scope Chain的概念。

![2010101700034040.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120641.png)

作用域链图，清楚的表达了执行环境与作用域的关系(一一对应的关系)，作用域与作用域之间的关系(链表结构，由上至下的关系)。

注：本文仅仅从全局角度的看待javascript执行模型，因此不够深入，具体执行细节，请参见后续博文。

参考：
1
2
3
[object Object]
[object Object]
[object Object]

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_12_执行模型浅析%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_12_执行模型浅析%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_12_执行模型浅析%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_12_执行模型浅析%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_12_执行模型浅析%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_12_执行模型浅析%20-%20笨蛋的座右铭%20-%20博客园.md#)

 4

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/16/1853126.html) 上一篇： [理解Javascript_11_constructor实现原理](https://www.cnblogs.com/fool/archive/2010/10/16/1853126.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/17/1853813.html) 下一篇： [超越Jquery_01_isPlainObject分析与重构](https://www.cnblogs.com/fool/archive/2010/10/17/1853813.html)

posted @ 2010-10-16 23:56 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(5513)  评论(4) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1853326) [收藏](理解Javascript_12_执行模型浅析%20-%20笨蛋的座右铭%20-%20博客园.md#)
理解Javascript_08_函数对象 - 笨蛋的座右铭 - 博客园

# [理解Javascript_08_函数对象](https://www.cnblogs.com/fool/archive/2010/10/14/1851017.html)

如果你无法理解博文在讲什么，请回顾前面的系列博文。文章比较深入，如有不对之处，望请指正，谢谢。

**函数对象**

首先，大家得明确一个概念：函数就是对象,代表函数的对象就是函数对象。既然是对象，那它又是被谁构造出来的呢？下面我们来看一段描述:JavaScript代码中定义函数，或者调用Function创建函数时，最终都会以类似这样的形式调用Function函数:var newFun=Function(funArgs, funBody); 。由此可知函数对象是由Function这个函数对象构造出来的。

注：Function对象本身也是一个函数，因此它也一个函数对象。关于Function的深入理解，请见后续博文。
正面我们来看一段代码：
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
[object Object]
[object Object]
[object Object][object Object]
[object Object]

[object Object]
[object Object]
[object Object][object Object]
[object Object]

[object Object]
[object Object]
通过上面的代码可知，函数func无非是由Function对象接收两个参数后构造出来的而矣！
注：关于定义方式一与定义方式二的区别，请见后续博文

**函数对象的创建过程**
函数对象详细创建步骤如下：
1. 创建一个build-in object对象fn
2. 将fn的内部[[Prototype]]设为Function.prototype
3. 设置内部的[[Call]]属性,它是内部实现的一个方法,处理函数调用的逻辑。（简单的理解为调用函数体）

4. 设置内部的[[Construct]]属性，它是内部实现的一个方法，处理逻辑参考对象创建过程。(简单的理解为创建对象《理解Javascript_06_理解对象的创建过程》一文)

5. 设置fn.length为funArgs.length，如果函数没有参数，则将fn.length设置为0
6. 使用new Object()同样的逻辑创建一个Object对象fnProto
7. 将fnProto.constructor设为fn
8. 将fn.prototype设为fnProto
9. 返回fn

步骤1跟步骤6的区别为，步骤1只是创建内部用来实现Object对象的数据结构(build-in object structure)，并完成内部必要的初始化工作，但它的[[Prototype]]、[[Call]]、[[Construct]]等属性应当为 null或者内部初始化值，即我们可以理解为不指向任何对象(对[[Prototype]]这样的属性而言)，或者不包含任何处理(对 [[Call]]、[[Construct]]这样的方法而言)。步骤6则将按照《理解Javascript_06_理解对象的创建过程》创建一个新的对象，它的 [[Prototype]]等被设置了。

从上面的处理步骤可以了解，任何时候我们定义一个函数，它的prototype是一个Object实例，这样默认情况下我们创建自定义函数的实例对象时，它们的Prototype链将指向Object.prototype。

注：Function一个特殊的地方，是它的[[Call]]和[[Construct]]处理逻辑一样。深层次的原因将在后续博文中介绍。
下面我们写一些用例脚本来测试一下上面的理论：
1
2
3
4
5
[object Object]
[object Object]
[object Object]

[object Object]
1
2
3
[object Object]
[object Object]
[object Object]
这个JS证明了步骤5的正确性。最后，还是来看一下函数对象的内存图,简单起见，内存图只描述了Animal的构造过程：
![2010101409535762.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120546.png)
来自于一个整体的分析图：
![2010101410172219.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120549.png)
图片本身已经能解释很多很多的问题了，结合前面instanceof原理，对象构造原理，原型链原理，自已去体会吧，我就不多说什么了。

其实上Function对象是一个很奇妙的对象，它与Object的关系更是扑朔迷离,我将在《理解Javascript_09_Function与Object》中解释这一切。

最后的声明：理论过于复杂，我不改保证其正确性。但经过多方的测试，还未发现理论与实际冲突的地方。

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_08_函数对象%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_08_函数对象%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_08_函数对象%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_08_函数对象%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_08_函数对象%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_08_函数对象%20-%20笨蛋的座右铭%20-%20博客园.md#)

 5

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/14/1850910.html) 上一篇： [理解Javascript_07_理解instanceof实现原理](https://www.cnblogs.com/fool/archive/2010/10/14/1850910.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/15/1851851.html) 下一篇： [理解Javascript_09_Function与Object](https://www.cnblogs.com/fool/archive/2010/10/15/1851851.html)

posted @ 2010-10-14 10:38 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(4169)  评论(12) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1851017) [收藏](理解Javascript_08_函数对象%20-%20笨蛋的座右铭%20-%20博客园.md#)
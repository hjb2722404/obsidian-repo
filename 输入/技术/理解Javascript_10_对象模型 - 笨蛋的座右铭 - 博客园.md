理解Javascript_10_对象模型 - 笨蛋的座右铭 - 博客园

# [理解Javascript_10_对象模型](https://www.cnblogs.com/fool/archive/2010/10/15/1851856.html)

什么都不想说，一段代码两张图，解释一切。注：在此之前请阅读前面的系列博文

**对象模型**
![2010101502424355.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120606.png)
图片来自于：http://www.cnblogs.com/riccc
红色虚线表示隐式Prototype链。

这张对象模型图中包含了太多东西，不少地方需要仔细体会，可以写些测试代码进行验证。彻底理解了这张图，对JavaScript语言的了解也就差不多了。下面是一些补充说明:

1. 图中有好几个地方提到build-in Function constructor，这是同一个对象，可以测试验证:
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
[object Object]
[object Object]

这说明了几个问题: Function指向系统内置的函数构造器(build-in Function constructor)；Function具有自举性；系统中所有函数都是由Function构造。

2. 左下角的obj1, obj2...objn范指用类似这样的代码创建的对象: function fn1(){}; var obj1=new fn1();这些对象没有本地constructor方法，但它们将从Prototype链上得到一个继承的constructor方法，即fn.prototype.constructor，从函数对象的构造过程可以知道，它就是fn本身了。

3.右下角的obj1, obj2...objn范指用类似这样的代码创建的对象: var obj1=new Object();或var obj1={};或var obj1=new Number(123);或obj1=/\w+/;等等。所以这些对象Prototype链的指向、从Prototype链继承而来的 constructor的值(指它们的constructor是build-in Number constructor还是build-in Object constructor等)等依赖于具体的对象类型。另外注意的是，var obj=new Object(123);这样创建的对象，它的类型仍然是Number，即同样需要根据参数值的类型来确定。同样它们也没有本地constructor，而是从Prototype链上获得继承的constructor方法，即build-in *** constructor，具体是哪一个由数据类型确定。

**示例代码**
1
2
3
4
5
6
7
8
[object Object]
[object Object]
[object Object]
[object Object]

[object Object]
[object Object]
[object Object]

**内存展现**

![2010101503072426.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120611.png)

你会发现，它和《理解Javascript_09_Function与Object》中的内存分析图是一样的，为什么呢？在《数据模型》中提到过，内置对象都可以看作是函数的派生类型，例如Number instanceof Function为true，Number instanceof Object为true。在这个意义上，可以将它们跟用户定义的函数等同看待。所以内置对象和自定义对象的创建流程是一样的。

在篇博文是在理解了《Function与Object》的基础上写的，因此要理解本文必须理解Function与Object的关系！

最后写一点感言：令人发狂的理论！

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_10_对象模型%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_10_对象模型%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_10_对象模型%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_10_对象模型%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_10_对象模型%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_10_对象模型%20-%20笨蛋的座右铭%20-%20博客园.md#)

 5

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/15/1851851.html) 上一篇： [理解Javascript_09_Function与Object](https://www.cnblogs.com/fool/archive/2010/10/15/1851851.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/16/1853126.html) 下一篇： [理解Javascript_11_constructor实现原理](https://www.cnblogs.com/fool/archive/2010/10/16/1853126.html)

posted @ 2010-10-15 03:13 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(4086)  评论(19) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1851856) [收藏](理解Javascript_10_对象模型%20-%20笨蛋的座右铭%20-%20博客园.md#)
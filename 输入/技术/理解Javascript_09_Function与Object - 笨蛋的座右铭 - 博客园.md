理解Javascript_09_Function与Object - 笨蛋的座右铭 - 博客园

# [理解Javascript_09_Function与Object](https://www.cnblogs.com/fool/archive/2010/10/15/1851851.html)

在《理解Javascript_08_函数对象》中讲解了很多函数对象的问题，同时也留下了许多疑问，今天让我们来解答部分问题。
注：理论过于深入，本人不改保证所有的理论都是正确的，但经过多方测试还未发现实际代码与理论冲突的问题。如有错误，望高人指点！

**Function**

　　首先回顾一下函数对象的概念，函数就是对象,代表函数的对象就是函数对象。所有的函数对象是被Function这个函数对象构造出来的。也就是说，Function是最顶层的构造器。它构造了系统中所有的对象，包括用户自定义对象，系统内置对象，甚至包括它自已。这也表明Function具有自举性(自已构造自己的能力)。这也间接决定了Function的[[call]]和[[constructor]]逻辑相同。

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
[object Object]
上面的代码解释了foo和其构造函数Foo和Foo的构造函数Function的关系。(具体原理请参见Function与Object的内存关系图)

**Object　**

　　对于Object它是最顶层的对象，所有的对象都将继承Object的原型，但是你也要明确的知道Object也是一个函数对象，所以说Object是被Function构造出来的。（关于Object并没有太多的理论）

**Function与Object**
这是本文的重点，非常重要！
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
你能理解这些答案吗？那恭喜你，Javascript语言的本质你已经理解了。
那么让我们来看一下Object与Function实际的关系吧：
![2010101501490224.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120557.png)
在你看图之前，请先阅读函数对象与instanceof原理两篇文章，要不然内存图很难理解。

在这，我对内存图做一点说明：在函数对象一文中提到了函数对象的构造过程，在本文中提到Function为自举性的，所以说函数对象Foo的构造过程和函数对象Function的构造过程是一样的。所以在图中给于高亮显示，我用'|'来分隔来表示它们的构造过程相同。根据instanceof的理论，和内存图，可以将上面的语句都推导出正确的结果。在此我们不一一讲述了，读者自已体会吧。

如果你不能理解这张复杂的内存图的话，可以看下面的说明图来帮助理解：
![2010101501362129.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120600.jpg)

 注：代码的实际执行流程并不完全像这张图上描述的那样，也就是说这张图是有问题的(可以说是错误的),它无法解释为什么Function instanceof Function 为true。 但是它易于理解Function与Object的关系。

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_09_Function与Object%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_09_Function与Object%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_09_Function与Object%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_09_Function与Object%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_09_Function与Object%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_09_Function与Object%20-%20笨蛋的座右铭%20-%20博客园.md#)

 9

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/14/1851017.html) 上一篇： [理解Javascript_08_函数对象](https://www.cnblogs.com/fool/archive/2010/10/14/1851017.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/15/1851856.html) 下一篇： [理解Javascript_10_对象模型](https://www.cnblogs.com/fool/archive/2010/10/15/1851856.html)

posted @ 2010-10-15 02:03 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(4341)  评论(18) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1851851) [收藏](理解Javascript_09_Function与Object%20-%20笨蛋的座右铭%20-%20博客园.md#)
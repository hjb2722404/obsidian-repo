理解Javascript_05_原型继承原理 - 笨蛋的座右铭 - 博客园

# [理解Javascript_05_原型继承原理](https://www.cnblogs.com/fool/archive/2010/10/13/1849734.html)

对于面向对象的基础语法在此我就不重复了，对面向对象不熟悉的朋友可以参看《使用面向对象的技术创建高级 Web 应用程序》一文。

**prototype与[[prototype]]**
在有面象对象基础的前提下，来看一段代码：
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
[object Object]
[object Object]  [object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object]

[object Object]  [object Object][object Object]  [object Object][object Object][object Object]

[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
其对应的简易内存分配结构图：
![2010101303391250.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120507.png)

现在让我们来解释一下这张内存图的来龙去脉：
首先明确一点[[prototype]]与prototype并不是同一个东西。

　　那先来看prototype,每一个函数对象都有一个显示的prototype属性,它代表了对象的原型，更明确的说是代表了由函数对象(构造函数)所创建出来的对象的原型。结合本例，Animal.prototype就是dog的原型，dog所引用的那个对象将从Animal.prototype所引用的对象那继承属性与方法。

　　每个对象都有一个名为[[Prototype]]的内部属性，指向于它所对应的原型对象。在本例中dog的[[prototype]]指向Animal.prototype，大家都知道，Animal.prototype也是一个对象，即然是一个对象，那它必然也有[[prototype]]属性指向于它所对应的原型对象，由此便构成了一种链表的结构，这就是原型链的概念。额外要说的是:不同的JS引擎实现者可以将内部[[Prototype]]属性命名为任何名字，并且设置它的可见性，前且只在JS引擎内部使用。虽然无法在JS代码中访问到内部[[Prototype]](FireFox中可以，名字为__proto__因为Mozilla将它公开了)，但可以使用对象的 isPrototypeOf()方法进行测试，注意这个方法会在整个Prototype链上进行判断。

注：关于函数对象的具体内容，将在后继的博文中讲解。

**属性访问原则**
使用obj.propName访问一个对象的属性时，按照下面的步骤进行处理(假设obj的内部[[Prototype]]属性名为__proto__):
1. 如果obj存在propName属性，返回属性的值，否则
2. 如果obj.__proto__为null，返回undefined，否则
3. 返回obj.__proto__.propName
调用对象的方法跟访问属性搜索过程一样，因为方法的函数对象就是对象的一个属性值。
提示: 上面步骤中隐含了一个递归过程，步骤3中obj.__proto__是另外一个对象，同样将采用1, 2, 3这样的步骤来搜索propName属性。
![2010101303004750.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120510.jpg)
这就是基于Prototype的继承和共享。其中object1的方法fn2来自object2，概念上即object2重写了object3的方法fn2。
JavaScript对象应当都通过prototype链关联起来，最顶层是Object，即对象都派生自Object类型。
结合是上面的理论，让我们再来看一个更加复杂的示例，他明确的解释了prototype、[[prototype]]、原型链以及属性访问的相关要点:
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
26
27
28
29
30
31
32
[object Object]
[object Object]  [object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object]

[object Object]  [object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]

[object Object][object Object]  [object Object]
[object Object][object Object][object Object]

[object Object][object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object]

[object Object]

[object Object]  [object Object][object Object]  [object Object][object Object][object Object]

[object Object][object Object]
[object Object][object Object]
[object Object][object Object]

[object Object][object Object]
[object Object][object Object]
根据上面的代码，你能画出相应的内存图吗？好，让我们来看一下：
![2010101304222762.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120515.png)
注：prototype的根为Object.prototype,对象Object.prototype的内部[[prototype]]属性为null.

其实，这里还有很多东西可以讲，但在其原理都在这张图上了，可试着调整一下代码的次序，如将Human.prototype.id = "Human";放在Human.prototype = new Animal();的前面，看一下运行结果，解释一下为什么之类的，你可以学到很多。

我发现，通过内存来展现程序内部运行细节真的是太完美了！

参考：
1
[object Object][object Object]

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_05_原型继承原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_05_原型继承原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_05_原型继承原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_05_原型继承原理%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_05_原型继承原理%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_05_原型继承原理%20-%20笨蛋的座右铭%20-%20博客园.md#)

 15

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/13/1849458.html) 上一篇： [理解Javascript_04_数据模型](https://www.cnblogs.com/fool/archive/2010/10/13/1849458.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/13/1850588.html) 下一篇： [理解Javascript_06_理解对象的创建过程](https://www.cnblogs.com/fool/archive/2010/10/13/1850588.html)

posted @ 2010-10-13 04:32 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(6261)  评论(20) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1849734) [收藏](理解Javascript_05_原型继承原理%20-%20笨蛋的座右铭%20-%20博客园.md#)
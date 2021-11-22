理解Javascript_06_理解对象的创建过程 - 笨蛋的座右铭 - 博客园

# [理解Javascript_06_理解对象的创建过程](https://www.cnblogs.com/fool/archive/2010/10/13/1850588.html)

在《[理解Javascript_05_原型继承原理](http://www.cnblogs.com/fool/archive/2010/10/13/1849734.html)》一文中已经详细的讲解了原型链的实现原理，大家都知道原型链是基于对象创建的（没有对象,哪来原型），那么今天就来解析一下对象的创建过程。

**简单的代码**
我们先来看一段简单的代码：
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
[object Object]  [object Object]
[object Object]

[object Object]
[object Object][object Object][object Object]
[object Object]

[object Object]  [object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]  [object Object][object Object]

[object Object]

[object Object][object Object]
[object Object][object Object]  [object Object][object Object]

[object Object]  [object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]  [object Object][object Object]

**复杂的理论**

JS中只有函数对象（函数）具备类的概念，因此创建一个对象，必须使用函数对象。函数对象内部有[[Construct]]方法和[[Call]]方法，[[Construct]]用于构造对象，[[Call]]用于函数调用，只有使用new操作符时才触发[[Construct]]逻辑。注：在本例中HumanCloning这个自定义函数是一个函数对象，那么请问Object,String,Number等本地对象是函数对象吗?答案是肯定的,这是因为本地对象都可以看作是函数的派生类型，在这个意义上，可以将它们跟用户定义的函数等同看待。(与《[理解Javascript_04_数据模型](http://www.cnblogs.com/fool/archive/2010/10/13/1849458.html)》中"内置数据类型"一节相呼应)

var obj=new Object(); 是使用内置的Object这个函数对象创建实例化对象obj。var obj={};和var obj=[];这种代码将由JS引擎触发Object和Array的构造过程。function fn(){}; var myObj=new fn();是使用用户定义的类型创建实例化对象。

注：关于函数对象的具体概念会在后续的文章中讲解，现在可以将"函数对象"简单的理解为"函数"的概念及可.

**内部的实现**

结合本例，函数对象为HumanCloning,函数对象创建的对象实例为clone01和clone02. 现在我们来看一下var clone01 = new HumanCloning();的实现细节(注：函数对象的[[Construct]]方法处理逻辑来负责实现对象的创建)：

1. 创建一个build-in object对象obj并初始化

2. 如果HumanCloning.prototype是Object类型，则将clone01的内部[[Prototype]]设置为HumanCloning.prototype，否则clone01的[[Prototype]]将为其初始化值(即Object.prototype)

3. 将clone01作为this，使用args参数调用HumanCloning的内部[[Call]]方法

    3.1 内部[[Call]]方法创建当前执行上下文(注：关于执行上下文，将在后续博文中讲解，在《[Javascript提速_01_引用变量优化](http://www.cnblogs.com/fool/archive/2010/10/12/1848373.html)》一文中已有部分讲解》)

    3.2 调用HumanCloning的函数体
    3.3 销毁当前的执行上下文
    3.4 返回HumanCloning函数体的返回值，如果HumanCloning的函数体没有返回值则返回undefined
4. 如果[[Call]]的返回值是Object类型，则返回这个值，否则返回obj
注意，如下代码为步骤1,步骤2和步骤3的代码解释：
1
2
3
4
[object Object]  [object Object]
[object Object]
[object Object]
[object Object]

注意步骤2中， prototype指对象显示的prototype属性，而[[Prototype]]则代表对象内部Prototype属性(隐式的)。构成对象Prototype链的是内部隐式的[[Prototype]]，而并非对象显示的prototype属性。显示的prototype只有在函数对象上才有意义，从上面的创建过程可以看到，函数的prototype被赋给派生对象隐式[[Prototype]]属性，这样根据Prototype规则，派生对象和函数的prototype对象之间才存在属性、方法的继承/共享关系。（即原型继承实现原理,正是《[理解Javascript_05_原型继承原理](http://www.cnblogs.com/fool/archive/2010/10/13/1849734.html)》的内容）

注意步骤3.4中描述，让我们来看一个来自于怿飞的问题:
![2010101320553396.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120525.png)
我想，现在回答这个问题，应该是易如反掌吧。
注：原文地址http://www.planabc.net/2008/02/20/javascript_new_function/

**内存分析**
![2010101321472354.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120528.png)

一张简易的内存图，并引入的函数对象的概念,同样也解释了上面代码（相对来说图不是很严谨，但易于理解）。在此也引出了一个问题，instanceof的实现原理,想必大家也看出了一些苗头，instanceof的判断依赖于原型链，具体实现细节，请参见后续博文。

**本地属性与继承属性**

对象通过隐式Prototype链能够实现属性和方法的继承，但prototype也是一个普通对象，就是说它是一个普通的实例化的对象，而不是纯粹抽象的数据结构描述。所以就有了这个本地属性与继承属性的问题。

首先看一下设置对象属性时的处理过程。JS定义了一组attribute，用来描述对象的属性property，以表明属性property是否可以在JavaScript代码中设值、被for in枚举等。

obj.propName=value的赋值语句处理步骤如下:
1. 如果propName的attribute设置为不能设值，则返回
2. 如果obj.propName不存在，则为obj创建一个属性，名称为propName
3. 将obj.propName的值设为value

可以看到，设值过程并不会考虑Prototype链，道理很明显，obj的内部[[Prototype]]是一个实例化的对象，它不仅仅向obj共享属性，还可能向其它对象共享属性，修改它可能影响其它对象。

我们来看一个示例：
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

[object Object]
[object Object][object Object]
[object Object]

[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
结果很明确，对象的属性无法修改其原型中的同名属性，而只会自身创建一个同名属性并为其赋值。

参考：
1
[object Object]

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_06_理解对象的创建过程%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_06_理解对象的创建过程%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_06_理解对象的创建过程%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_06_理解对象的创建过程%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_06_理解对象的创建过程%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_06_理解对象的创建过程%20-%20笨蛋的座右铭%20-%20博客园.md#)

 5

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/13/1849734.html) 上一篇： [理解Javascript_05_原型继承原理](https://www.cnblogs.com/fool/archive/2010/10/13/1849734.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/14/1850910.html) 下一篇： [理解Javascript_07_理解instanceof实现原理](https://www.cnblogs.com/fool/archive/2010/10/14/1850910.html)

posted @ 2010-10-13 21:48 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(4901)  评论(13) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1850588) [收藏](理解Javascript_06_理解对象的创建过程%20-%20笨蛋的座右铭%20-%20博客园.md#)
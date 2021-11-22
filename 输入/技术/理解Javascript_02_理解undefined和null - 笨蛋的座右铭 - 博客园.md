理解Javascript_02_理解undefined和null - 笨蛋的座右铭 - 博客园

# [理解Javascript_02_理解undefined和null](https://www.cnblogs.com/fool/archive/2010/10/07/1845253.html)

**来自普遍的回答:**

其实在 ECMAScript 的原始类型中，是有Undefined 和 Null 类型的。 这两种类型都分别对应了属于自己的唯一专用值，即undefined 和 null。

值 undefined 实际上是从值 null 派生来的，因此 ECMAScript 把它们定义为相等的，通过下列代码可以验证这一结论：
alert(undefined == null); //true

尽管这两个值相等，但它们的含义不同。

undefined 是声明了变量但未对其初始化时赋予该变量的值，null 则用于表示尚未存在的对象。如果函数或方法要返回的是对象，那么找不到该对象时，返回的通常是 null。

所以alert(undefined===null);//false

说实话，我没有看明白，为什么undefined会继承null，即然是继承那为什么undefined!==null,还有未初始化的变量与函数返回的对象不存在之间有什么区别，问题种种，让人很不信服。

**看看内存是怎么说的：**
Udefined代表没有赋值的基本数据类型。
Null代表没有赋值的引用数据类型。
我们来看一段代码：
1
2
3
4
5
6
7
8
[object Object]  [object Object]
[object Object]  [object Object]
[object Object]  [object Object][object Object][object Object][object Object]
[object Object]  [object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
再来看一下内存的情况：
![2010100720101043.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120432.png)
**解决第一个问题:为什么undefine继承自null**

在Javascript中，基本数据类型都有一个与其对应的引用数据类型，number Number,string String,boolean Boolean...,他们具有完全相同的行为,并且相互之间会产生自动拆箱与装箱的操作。在内存分析一文中已经讲述了基本数据类型放在栈内存中的意义，由此这们可以得出一个肤浅的结论：基本数据类型是对应引用数据类型的子类，只不过是为了提高效率，将其放在栈内存中而已，对应的Undefined代表无值的基本类型，Null代表无值的引用类型，那势必就可以推出undefined继承null。

**解决第二个问题：为什么undefined==null**
 推出来的答案undefined继承自null,内存告诉我们的答案他们都处于栈中
**解决第三个问题：为什么undefined!==null**
内存告诉我们，它们的意义确实是不一样的，老话一句：Udefined代表没有赋值的基本数据类型，Null代表没有赋值的引用数据类型。他们的内存图有很大的区别
**解决额外的问题：null是处理引用的，为什么null处在栈内存中，而不是堆内存中**
答案一样的简单，效率！有必要在栈中分配一块额外的内存去指向堆中的null吗！
**额外的收获：**
当我们要切断与对象的联系，但又并不想给变量赋于其他的值，那么我们可了置null,如var obj = new Object();obj=null;

**一些关于undefined和null的行为**
 null 参与数值运算时其值会自动转换为 0 ，因此，下列表达式计算后会得到正确的数值：
表达式：123 + null　　　　结果值：123
typeof null 返回object,因为null代表是无值的引用。

undefined是全局对象（window）的一个特殊属性，其值为Undefined类型的专用值undefined
undefined参与任何数值计算时，其结果一定是NaN。
 当声明的变量未初始化时，该变量的默认值是undefined，但是undefined并不同于未定义的值。Typeof运算符无法区分这两种值

因此对于变量是否存在的判断操作是通过if(typeof var == ‘undefined’){ //code here } 来进行判断的,这样既完全兼容**未定义****(undefined)**和**未初始化****(uninitialized)**两种情况的

哈哈，当你站在内存的高度的分析问题的时候，如此抽象的东西有了实际的表现，一切变得简单起来!

-----------------------------更新 2010/11/01 --------------------------------------------

**undefined与参数判断**
我们行来看一个简单的函数：

1
2
3
4
5
6
[object Object]  [object Object]

[object Object][object Object][object Object][object Object]  [object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object]
[object Object][object Object]
[object Object][object Object]  [object Object]
[object Object]

这个函数有问题吗？有，因为typeof返回undefined值有两种可能，一种是传进来的就是undefined,还有一种是没有传值。

1
2
[object Object][object Object]
[object Object][object Object]

很明显，bool(undefined)返回了不是我们所期望的false.怎么解决这个问题呢？

1
2
3
4
5
6
[object Object]  [object Object]
[object Object][object Object][object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]  [object Object][object Object]
[object Object]

我们通过arguments参数长度来判断是否传递了参数，从而区分函数传递的参数是undefined，还是根本不就没有传值！

[chyingp](http://www.cnblogs.com/chyingp/) [     ](http://space.cnblogs.com/msg/send/chyingp)

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_02_理解undefined和null%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_02_理解undefined和null%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_02_理解undefined和null%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_02_理解undefined和null%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_02_理解undefined和null%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_02_理解undefined和null%20-%20笨蛋的座右铭%20-%20博客园.md#)

 13

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/07/1845226.html) 上一篇： [理解Javascript_01_理解内存分配](https://www.cnblogs.com/fool/archive/2010/10/07/1845226.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/08/1846078.html) 下一篇： [理解Javascript_03_javascript全局观](https://www.cnblogs.com/fool/archive/2010/10/08/1846078.html)

posted @ 2010-10-07 20:41 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(5733)  评论(22) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1845253) [收藏](理解Javascript_02_理解undefined和null%20-%20笨蛋的座右铭%20-%20博客园.md#)
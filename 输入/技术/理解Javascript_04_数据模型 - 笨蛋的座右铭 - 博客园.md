理解Javascript_04_数据模型 - 笨蛋的座右铭 - 博客园

# [理解Javascript_04_数据模型](https://www.cnblogs.com/fool/archive/2010/10/13/1849458.html)

　　本文主要描述Javascript的数据模型，即对Javascript所支持的数据类型的一个全局概缆。文章比较的理论化，非常深入，因此不易理解，但务必对数据模型有一个映象，因为他是理解Javascript对象模型与Javascript执行模型的基础。

**基本的数据类型**
** 原始类型（简单数据类型、基本数据类型）**
Undefined类型： 表示声明了变量但未对其初始化时赋予该变量的值。undefined为Undefined类型下的唯一的一个值。
Null类型：用于表示尚未存在的对象。Null类型下也只有一个专用值null。
Boolean类型：有两个值true和false,主要用于条件判断，控制执行流程。
Number类型：代表数字（即包括32的整数，也包括64位的浮点数）
String类型：用于代表字符串。

注：关于undefined与null的关系，可以参见《[理解Javascript_02_理解undefined和null](http://www.cnblogs.com/fool/archive/2010/10/07/1845253.html)》一文。

**对象：**一个无序属性的集合，这些属性的值为简单数据类型、对象或者函数。注：这里对象并不特指全局对象Object.

**函数：**函数是对象的一种，实现上内部属性[[Class]]值为"Function"，表明它是函数类型，除了对象的内部属性方法外，还有 [[Construct]]、[[Call]]、[[Scope]]等内部属性。函数作为函数调用与构造器(使用new关键字创建实例对象)的处理机制不一样(Function对象除外)，内部方法[[Construct]]用于实现作为构造器的逻辑，方法[[Call]]实现作为函数调用的逻辑。同上，这里的函数并不特指全局对象Function。

注：关于函数与对象的关系可以引申出很多问题，现在可以不去深究函数实现内部的细节，这将在以后的文章中探讨。

注："基本的数据类型"与"基本数据类型"的概念不一样，"基本的数据类型"指的是最常用的数据类型，"基本数据类型"指的是原始类型(关于原始类型与引用类型的问题，具体可以参见《[理解Javascript_01_理解内存分配](http://www.cnblogs.com/fool/archive/2010/10/07/1845226.html)》一文)。

**内置数据类型(内置对象)**
Function: 函数类型的用户接口。
Object: 对象类型的用户接口。
Boolean, Number, String: 分别为这三种简单数值类型的对象包装器，对象包装在概念上有点类似C#/Java中的Box/Unbox。
Date, Array, RegExp: 可以把它们看作是几种内置的扩展数据类型。

首先，Function, Object, Boolean, Number, String, Date, Array, RegExp等都是JavaScript语言的内置对象，它们都可以看作是函数的派生类型，例如Number instanceof Function为true，Number instanceof Object为true。在这个意义上，可以将它们跟用户定义的函数等同看待。

其次，它们各自可以代表一种数据类型，由JS引擎用native code或内置的JS代码实现，是暴露给开发者对这些内置数据类型进行操作的接口。在这个意义上，它们都是一种抽象的概念，后面隐藏了具体的实现机制。

在每一个提到Number, Function等单词的地方，应该迅速的在思维中将它们实例化为上面的两种情况之一。

**数据类型实现模型描述**
![2010101222515756.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120457.png)
注：图片来源于http://www.cnblogs.com/riccc
Build-in *** data structure: 指JS内部用于实现***类型的数据结构，由宿主环境(浏览器)提供，这些结构我们基本上无法直接操作。

Build-in *** object: 指JS内置的Number, String, Boolean等这些对象，这是JS将内部实现的数据类型暴露给开发者使用的接口。

Build-in *** constructor: 指JS内置的一些构造器，用来构造相应类型的对象实例。它们被包装成函数对象暴露出来，例如我们可以使用下面的方法访问到这些函数对象:

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
[object Object]  [object Object][object Object]  [object Object]
[object Object]  [object Object][object Object]
[object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]  [object Object][object Object]
[object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
 关于"接口"的解释：简单的说，接口就是可以调用的方法。如：
1
2
3
4
5
6
7
8
[object Object]

[object Object]  [object Object][object Object]  [object Object][object Object][object Object]

[object Object]
[object Object]  [object Object]
[object Object][object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]

注：完全理解接口的概念需要有一定的强类型语言编程经验（java/c#)，因为本文已经够复杂了，就不再将问题复杂化了。所以对于接口的答案并不是很严谨，但已经够用了，望高人见谅。

**关于简单数据类型的对象化**
这是一个细微的地方，下面描述对于Boolean, String和Number这三种简单数值类型都适用，以Number为例说明。

JS规范要求: 使用var num1=123;这样的代码，直接返回基本数据类型，就是说返回的对象不是派生自Number和Object类型，用num1 instanceof Object测试为false；使用new关键字创建则返回Number类型，例如var num2=new Number(123); num2 instanceof Number为true。

将Number当作函数调用，返回结果会转换成简单数值类型。下面是测试代码:
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
[object Object]  [object Object][object Object]  [object Object][object Object]
[object Object][object Object]  [object Object][object Object]
[object Object][object Object]  [object Object][object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object][object Object]
[object Object][object Object]  [object Object][object Object]
[object Object]  [object Object][object Object]
[object Object][object Object]  [object Object][object Object]
[object Object][object Object]  [object Object][object Object]

结论：虽然我们得到了一个简单数值类型，但它看起来仍然是一个JS Object对象，具有Object以及相应类型的所有属性和方法，使用上基本没有差别，唯一不同之处是instanceof的测试结果。由此也就产生了一个概念"Literal Syntax"

**Literal Syntax**

在简单数据类型的对象化一节中，我们也看到了简单类型和其包装类型可以相互转换，并且两者之间的行为相同。但两者相比较，明显简单类型的定义更加轻量，因此我们可以用简单类型定义替换相应的包装类型定义。如：

1
2
3
[object Object][object Object]  [object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object]

其实这种类似于var i = 100;var b=true;var str='this is a string'这种定义方式就叫做Literal Syntax。难道就只有简单数据类型才有这种Literal Syntax的表示方法吗！不是的，复合数据类型同样有。

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
[object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]

[object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]

[object Object]
[object Object]  [object Object]
[object Object]
[object Object]
[object Object]
[object Object]
那函数呢！其实函数的定义已经是Literal Syntax的表示形式了。
在实际工作中，我们建议尽量采用Literal Syntax的形式定义变量，因为这样更简单，更高效。

**来自于"笨蛋"的建议**
虽然文章大部分都是参考的，但是里面也包含了我很多的体会，因此给出建议：
1.对于初学者而言，需要掌握"基础的数据类型"与"Literal Syntax"部分，其它部分有个映象即可。
2.文章确实非常深入,并不要求完全掌握，因为其内部涉及到了很多东西，包括对象模型与执行模型。这些内容将在以后的博文中探讨。

最后，祝大家有所收获，共同进步。

参考:
1
2
3
[object Object][object Object][object Object]
[object Object][object Object]
[object Object]

|     |     |
| --- | --- |
| 1   |     |

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_04_数据模型%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_04_数据模型%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_04_数据模型%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_04_数据模型%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_04_数据模型%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_04_数据模型%20-%20笨蛋的座右铭%20-%20博客园.md#)

 8

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/12/1848373.html) 上一篇： [Javascript提速_01_引用变量优化](https://www.cnblogs.com/fool/archive/2010/10/12/1848373.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/13/1849734.html) 下一篇： [理解Javascript_05_原型继承原理](https://www.cnblogs.com/fool/archive/2010/10/13/1849734.html)

posted @ 2010-10-13 00:17 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(4432)  评论(21) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1849458) [收藏](理解Javascript_04_数据模型%20-%20笨蛋的座右铭%20-%20博客园.md#)
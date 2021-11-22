理解Javascript_13_执行模型详解 - 笨蛋的座右铭 - 博客园

# [理解Javascript_13_执行模型详解](https://www.cnblogs.com/fool/archive/2010/10/19/1855266.html)

在《[理解Javascript_12_执行模型浅析](http://www.cnblogs.com/fool/archive/2010/10/16/1853326.html)》一文中,我们初步的了解了执行上下文与作用域的概念，那么这一篇将深入分析执行上下文的构建过程，了解执行上下文、函数对象、作用域三者之间的关系。

**函数执行环境**
简单的代码:
1
2
3
4
5
6
7
8
[object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]
[object Object]
[object Object]
当调用say方法时，第一步是创建其执行环境，在创建执行环境的过程中，会按照定义的先后顺序完成一系列操作:

1.首先会创建一个'活动对象'(Activation Object)。活动对象是规范中规定的另外一种机制。之所以称之为对象，是因为它拥有可访问的命名属性，但是它又不像正常对象那样具有原型（至少没有预定义的原型），而且不能通过 JavaScript 代码直接引用活动对象。

2.为函数调用创建执行环境的下一步是创建一个 `arguments` 对象，这是一个类似数组的对象，它以整数索引的数组成员一一对应地保存着调用函数时所传递的参数。这个对象也有 `length` 和 `callee` 属性（更深入的内容，请参见《[理解Javascript_14_函数形式参数与arguments](http://www.cnblogs.com/fool/archive/2010/10/19/1855261.html) 》）。然后，会为活动对象创建一个名为“arguments”的属性，该属性引用前面创建的 `arguments`对象。

3.接着，为执行环境分配作用域。作用域由对象列表（链）组成。(比较复杂，请参见：《理解Javascript_15_作用域分配与变量访问规则,再送个闭包》)

4.之后会发生由 ECMA 262 中所谓'活动对象'完成的'变量实例化'(Variable Instatiation)的过程。此时会将函数的形式参数创建为可变对象的命名属性，如果调用函数时传递的参数与形式参数一致，则将相应参数的值赋给这些命名属性（否则，会给命名属性赋 `undefined` 值）。对于定义的内部函数，会以其声明时所用名称为可变对象创建同名属性，而相应的内部函数则被创建为函数对象并指定给该属性。变量实例化的最后一步是将在函数内部声明的所有局部变量创建为可变对象的命名属性。**注：在这个过程中，除了实际参数有值外和函数定义外，其它都被'预解析'为undefined值.**

5.最后，要为使用 `this` 关键字而赋值。(此时的this指向的是全局对象，即window)

执行环境创建成功后，就进入第二步：在函数体内,从上到下执行代码。

1.当执行到var str='nobody say'会发生称之为'计算赋值表达式'的过程，此时，会将活动对象中key为str的值从undefined设置为'nobody say:'。

2.执行到this.name='笨蛋的座右铭'时，会为作为this的对象添加属性name，并赋值为'笨蛋的座右铭'.
3.然后是执行function innerMethod(){};最后执行'alert(str+msg),输出'nobody say:hello world'.

**function method(){}与var method = function(){}的区别**
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
12
[object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

[object Object]
为什么调用方法method01能正常运行，而调用方法method02却会报错呢？

　　首先，你要明确的知道method01为一个函数对象，而method02为一个变量，它指向于另一个函数对象。根据上一节的内容，在'活动对象'完成的'变量实例化'(Variable Instatiation)的过程中，对函数method01进行了正常的'预解析'，而对于变量method02解析为undefined值，当进入到执行代码的环节时，因为method02的调用在其计算函数表达式之前，因此将undefined当作方法调来用，必然会报错。解决方案比较简单，就是将var method02=function(){...}放到其method02()的调用之前就可以了或者是用函数声明的方式定义函数(function method(){...})。

注：计算函数表达式就是指程序执行到var method02 = function(){...}。method02此时真正指向一个函数对象。因为在'预解析'时，method02只被赋于了undefined.

**全局执行环境（《执行模型浅析》中已经讲过，不再深入)**

　　在一个页面中，第一次载入JS代码时创建一个全局执行环境，全局执行环境的作用域链实际上只由一个对象,即全局对象(window),在开始JavaScript代码的执行之前，引擎会创建好这个Scope Chain结构。全局执行环境也会有变量实例化的过程，它的内部函数就是涉及大部分 JavaScript 代码的、常规的顶级函数声明。而且，在变量实例化过程中全局对象就是可变对象，这就是为什么全局性声明的函数是全局对象属性的原因。全局性声明的变量同样如此全局执行环境会使用 `this` 对象来引用全局对象。

注：区别'函数执行环境'中的活动对象(Activation Object)和全局执行环境中的可变对象(Vriable Object),Variable Object也叫做Activation Object(因为有一些差异存在，所以规范中重新取一个名字以示区别，全局执行环境/Eval执行环境中叫Variable Object，函数执行环境中就叫做Activation Object)。

**Eval执行环境**

构建Eval执行环境时的可变对象(Variable Object)就是调用eval时当前执行上下文中的可变对象(Variable Object)。在全局执行环境中调用eval函数，它的可变对象(Variable Object)就是全局对象；在函数中调用eval，它的可变对象(Variable Object)就是函数的活动对象(Activation Object)。

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
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]
[object Object]
输出结果是:
arguments for function
variable in function
variable in eval
说明: eval调用中可以访问函数fn的参数、局部变量；在eval中定义的局部变量在函数fn中也可以访问，因为它们的Varible Object是同一个对象。
进入Eval Code执行时会创建一个新的Scope Chain，内容与当前执行上下文的Scope Chain完全一样。

**最后的实例**
代码如下：
1
2
3
4
5
6
7
[object Object]
[object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]
[object Object]
执行处理过程大致如下:

1. 初始化Global Object即window对象，Variable Object为window对象本身。创建Scope Chain对象，假设为scope_1，其中只包含window对象。

2. 扫描JS源代码(读入源代码、可能有词法语法分析过程)，从结果中可以得到定义的变量名、函数对象。按照扫描顺序:
   2.1 发现变量outerVar1，在window对象上添加outerVar1属性，值为undefined；

   2.2 发现函数fn1的定义，使用这个定义创建函数对象，传给创建过程的Scope Chain为scope_1。将结果添加到window的属性中，名字为fn1，值为返回的函数对象。注意fn1的内部[[Scope]]就是 scope_1。另外注意，创建过程并不会对函数体中的JS代码做特殊处理，可以理解为只是将函数体JS代码的扫描结果保存在函数对象的内部属性上，在函数执行时再做进一步处理。这对理解Function Code，尤其是嵌套函数定义中的Variable Instantiation很关键；

   2.3 发现变量outerVar2，在window对象上添加outerVar2属性，值为undefined；
3. 执行outerVar1赋值语句，赋值为"variable in global code"。
4. 执行函数fn1，得到返回值:

   4.1 创建Activation Object，假设为activation_1；创建一个新的Scope Chain，假设为scope_2，scope_2中第一个对象为activation_1，第二个对象为window对象(取自fn1的 [[Scope]]，即scope_1中的内容)；

   4.2 处理参数列表。在activation_1上设置属性arg1、arg2，值分别为10、20。创建arguments对象并进行设置，将arguments设置为activation_1的属性；

   4.3 对fn1的函数体执行类似步骤2的处理过程:
       4.3.1 发现变量innerVar1，在activation_1对象上添加innerVar1属性，值为undefine；

       4.3.2 发现函数fn2的定义，使用这个定义创建函数对象，传给创建过程的Scope Chain为scope_2(函数fn1的Scope Chain为当前执行上下文的内容)。将结果添加到activation_1的属性中，名字为fn2，值为返回的函数对象。注意fn2的内部 [[Scope]]就是scope_2；

   4.4 执行innerVar1赋值语句，赋值为"variable in function code"。
   4.5 执行fn2:

       4.5.1 创建Activation Object，假设为activation_2；创建一个新的Scope Chain，假设为scope_3，scope_3中第一个对象为activation_2，接下来的对象依次为activation_1、window 对象(取自fn2的[[Scope]]，即scope_2)；

       4.5.2 处理参数列表。因为fn2没有参数，所以只用创建arguments对象并设置为activation_2的属性。
       4.5.3 对fn2的函数体执行类似步骤2的处理过程，没有发现变量定义和函数声明。

       4.5.4 执行函数体。对任何一个变量引用，从scope_3上进行搜索，这个示例中，outerVar1将在window上找到；innerVar1、arg1、arg2将在activation_1上找到。

       4.5.5 丢弃scope_3、activation_2(指它们可以被垃圾回收了)。
       4.5.6 返回fn2的返回值。
   4.6 丢弃activation_1、scope_2。
   4.7 返回结果。
5. 将结果赋值给outerVar2。

参考：
1
2
[object Object]
[object Object]

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_13_执行模型详解%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_13_执行模型详解%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_13_执行模型详解%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_13_执行模型详解%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_13_执行模型详解%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_13_执行模型详解%20-%20笨蛋的座右铭%20-%20博客园.md#)

 4

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/19/1855265.html) 上一篇： [理解Javascript_15_作用域分配与变量访问规则,再送个闭包](https://www.cnblogs.com/fool/archive/2010/10/19/1855265.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/20/1856303.html) 下一篇： [笨蛋的厄运](https://www.cnblogs.com/fool/archive/2010/10/20/1856303.html)

posted @ 2010-10-19 05:13 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(6475)  评论(5) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1855266) [收藏](理解Javascript_13_执行模型详解%20-%20笨蛋的座右铭%20-%20博客园.md#)
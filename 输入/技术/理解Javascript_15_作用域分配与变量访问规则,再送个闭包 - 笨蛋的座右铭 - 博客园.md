理解Javascript_15_作用域分配与变量访问规则,再送个闭包 - 笨蛋的座右铭 - 博客园

# [理解Javascript_15_作用域分配与变量访问规则,再送个闭包](https://www.cnblogs.com/fool/archive/2010/10/19/1855265.html)

在阅读本博文之前，请先阅读《理解Javascript_13_执行模型详解》
在'执行模型详解'中讲到了关于作用域分配的问题，这一篇博文将详细的说明函数对象、作用域链与执行上下文的关系。

**作用域分配与变量访问规则**

　　在 ECMAScript 中，函数也是对象。函数对象在变量实例化过程中会根据函数声明来创建，或者是在计算函数表达式或调用 `Function` 构造函数时创建。(关于'函数对象'请见《[理解Javascript_08_函数对象](http://www.cnblogs.com/fool/archive/2010/10/14/1851017.html)》)。每个函数对象都有一个内部的 `[[scope]]` 属性，这个属性也由对象列表（链）组成。这个内部的[[scope]] 属性引用的就是创建它们的执行环境的作用域链，同时，当前执行环境的活动对象被添加到该对象列表的顶部。当我们在函数内部访问变量时，其实就是在作用域链上寻找变量的过程。

理论性太强了(总结死我了！)，还是让我们来看一段代码吧：
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
[object Object][object Object]  [object Object]
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
[object Object][object Object][object Object]
下图清晰的展现了上述代码的内存分配与作用域分配情况:
![2010101903461985.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120700.png)
下面来解释一下：
1.载入代码，创建全局执行环境，此时会在可变对象(window)中添加outer变量，其指向于函数对象outer,此时作用域链中只有window对象.
2.执行代码，当程序执行到outer()时，会在全局对象中寻找outer变量，成功调用。

3.创建outer的执行环境，此时会新创建一个活动对象，添加变量i，设置值为10,添加变量inner，指向于函数对象inner.并将活动对象压入作用域链中.并将函数对象outer的[[scope]]属性指向活动对象outer。此时作用域链为outer的活动对象+window.

4.执行代码，为 i 成功赋值。当程序执行到inner()时，会在函数对象outer的[[scope]]中寻找inner变量。找到后成功调用。

5.创建inner的执行环境，新建一个活动对象，添加变量j，赋值为100,并将该活动对象压入作用域链中，并函数对象inner的[[scope]]属性指向活动对象inner.此时作用域链为:inner的活动对象+outer的活动对象+全局对象.

6.执行代码为j赋值，当访问i、j时成功在作用域中找到对应的值并输出，而当访问变量adf时，没有在作用域中寻找到，访问出错。

注：通过内存图，我们会发现作用域链与prototype链是如此的相象。这说明了很多问题...(仁者见仁智者见智,自己探寻答案吧！)

**闭包原理**
在我们了解了作用域的问题之后，对于闭包这个问题已经很简单了。什么是闭包？闭包就是封闭了外部函数作用域中变量的内部函数。
我们来看一个典型的闭包运用：生成increment值
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
[object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

[object Object]
[object Object]
[object Object][object Object][object Object]

外层匿名函数返回的是一个内嵌函数，内嵌函数使用了外层匿名函数的局部变量id。照理外层匿名函数的局部变量在返回时就超出了作用域因此increment()调用无法使用才对。这就是闭包Closure，即函数调用返回了一个内嵌函数，而内嵌函数引用了外部函数的局部变量、参数等这些应当被关闭(Close)了的资源。这是怎么一回事呢？让我们来寻找答案：

![2010101904411936.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120703.png)

根据Scope Chain的理解可以解释，返回的内嵌函数已经持有了构造它时的Scope Chain，虽然outer返回导致这些对象超出了作用域、生存期范围，但JavaScript使用自动垃圾回收来释放对象内存: 按照规则定期检查，对象没有任何引用才被释放。因此上面的代码能够正确运行。

参考：
1
2
3
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object][object Object]

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_15_作用域分配与变量访问规则,再送个闭包%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_15_作用域分配与变量访问规则,再送个闭包%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_15_作用域分配与变量访问规则,再送个闭包%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_15_作用域分配与变量访问规则,再送个闭包%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_15_作用域分配与变量访问规则,再送个闭包%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_15_作用域分配与变量访问规则,再送个闭包%20-%20笨蛋的座右铭%20-%20博客园.md#)

 9

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/19/1855261.html) 上一篇： [理解Javascript_14_函数形式参数与arguments](https://www.cnblogs.com/fool/archive/2010/10/19/1855261.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/19/1855266.html) 下一篇： [理解Javascript_13_执行模型详解](https://www.cnblogs.com/fool/archive/2010/10/19/1855266.html)

posted @ 2010-10-19 04:42 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(4000)  评论(14) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1855265) [收藏](理解Javascript_15_作用域分配与变量访问规则,再送个闭包%20-%20笨蛋的座右铭%20-%20博客园.md#)
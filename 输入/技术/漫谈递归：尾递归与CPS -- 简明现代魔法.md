漫谈递归：尾递归与CPS -- 简明现代魔法

[首页](http://www.nowamagic.net/librarys/veda/)![](../_resources/5314c05b83b861dbb1140f2277562370.png)[计算机算法](http://www.nowamagic.net/librarys/veda/cate/Algorithm)![](../_resources/5314c05b83b861dbb1140f2277562370.png) [漫谈递归：尾递归与CPS](http://www.nowamagic.net/librarys/veda/detail/2331)

# [漫谈递归：尾递归与CPS](http://www.nowamagic.net/librarys/veda/detail/2331)

尾递归就是Continuation Passing Style
在 2012年10月14日 那天写的     已经有 9884 次阅读了
感谢 [参考或原文](http://www.nowamagic.net/librarys/veda/detail/2331)

服务器君一共花费了98.991 ms进行了3次数据库查询，努力地为您提供了这个页面。

试试阅读模式？希望听取您的建议

#### 复习下尾递归

与普通递归相比，由于尾递归的调用处于方法的最后，因此方法之前所积累下的各种状态对于递归调用结果已经没有任何意义，因此完全可以把本次方法中留在堆栈中的数据完全清除，把空间让给最后的递归调用。这样的优化便使得递归不会在调用堆栈上产生堆积，意味着即时是“无限”递归也不会让堆栈溢出。这便是尾递归的优势。

有些朋友可能已经想到了，尾递归的本质，其实是将递归方法中的需要的“所有状态”通过方法的参数传入下一次调用中。
在上一篇文章里，普通递归是这样的：
[object Object]
[object Object]
[object Object]
[object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]
而改造成尾递归，我们则需要提供两个累加器：
[object Object]

[object Object]  [object Object][object Object]  [object Object][object Object]  [object Object][object Object]  [object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]
于是在调用时，需要提供两个累加器的初始值：factorial_tail(n, 1, 1)

#### Continuation Passing Style的概念

说起Continuation，像我这样的大多数从C, Basic, Pascal起步的程序员可能都不清楚。但是这个概念在functional language 社区却好象是常识一样，很多人在讨论问题的时候总是假设你已经知道了continuation的基本概念，什么Call-CC什么的都不加解释就直接引用。于是，如果不知道continuation到底指的是什么，简直就无法理解他们在说什么。

所谓continuation，其实本来是一个函数调用机制。

我们熟悉的函数调用方法都是使用堆栈，采用Activation record或者叫Stack frame来记录从最顶层函数到当前函数的所有context。一个frame/record就是一个函数的局部上下文信息，包括所有的局部变量的值和SP, PC指针的值（通过静态分析，某些局部变量的信息是不必保存的，特殊的如尾调用的情况则不需要任何stack frame。不过，逻辑上，我们认为所有信息都被保存了）。函数的调用前往往伴随着一些push来保存context信息，函数退出时则是取消当前的record/frame，恢复上一个调用者的record/frame。

像pascal这样的支持嵌套函数的，则需要一个额外的指针来保存父函数的frame地址。不过，无论如何，在任何时候，系统保存的就是一个后入先出的堆栈，一个函数一旦退出，它的frame就被删除了。

Continuation则是另一种函数调用方式。它不采用堆栈来保存上下文，而是把这些信息保存在continuation record中。这些continuation record和堆栈的activation record的区别在于，它不采用后入先出的线性方式，所有record被组成一棵树（或者图），从一个函数调用另一个函数就等于给当前节点生成一个子节点，然后把系统寄存器移动到这个子节点。一个函数的退出等于从当前节点退回到父节点。

这些节点的删除是由garbage collection来管理。如果没有引用这个record，则它就是可以被删除的。
这样的调用方式和堆栈方式相比的好处在哪里呢？

最大的好处就是，它可以让你从任意一个节点跳到另一个节点。而不必遵循堆栈方式的一层一层的return方式。比如说，在当前的函数内，你只要有一个其它函数的节点信息，完全可以选择return到那个函数，而不是循规蹈矩地返回到自己的调用者。你也可以在一个函数的任何位置储存自己的上下文信息，然后，在以后某个适当的时刻，从其它的任何一个函数里面返回到自己现在的位置。

Scheme语言有一个CallCC (call with current continuation)的机制，也就是说：取得当前的continuation，传递给要call的这个函数，这个函数可以选择在适当的时候直接return到当前的continuation。

经典的应用有：exception，back-tracking算法, coroutine等。

应用continuation对付exception是很明显的，只要给可能抛出异常的函数一个外面try的地方的continuation record，这个函数就可以在需要的时候直接返回到try语句的地方。

Exception-handling也可以利用continuation。c++等语言普遍采用的是遇到exception就直接中止当前函数的策略，但是，还有一种策略是允许resume，也就是说，出现了异常之后，有可能异常处理模块修复了错误发生的地方然后选择恢复执行被异常中断了的代码。被异常中断的代码可以取得当前的continuation，传递给异常处理模块，这样当resume的时候可以直接跳到出现异常的地方。Back-tracking算法也可以用类似的方法，在某些地方保存当前的continuation，然后以后就可以从其它的函数跳回当前的语句。

Continuation机制的优化始终不是一个trivial的问题，实际上采取continuation的语言不多。而且，continuation调用方式依赖垃圾收集，也不是c/c++这类中低级的语言所愿意采用的。

不过，continuation的思想仍然是有其用武之地的。有一种设计的风格叫做[continuation-passing-style](http://www.nowamagic.net/librarys/veda/tag/CPS)。它的基本思想是：当需要返回某些数据的时候，不是直接把它当作函数的返回值，而是接受一个叫做continuation的参数，这个参数就是一个call-back函数, 它接受这个数据，并做需要做的事情。

举个例子：
[object Object]
[object Object]
[object Object]
[object Object]
把它变成continuation-passing-style, 则是：
[object Object]
[object Object]
f()函数不再返回x, 而是接受一个函数，然后把本来要返回的x传递给这个函数。

这个例子也许看上去有点莫名其妙：为什么这么做呢？对Haskell这样的语言，一个原因是：当函数根据不同的输入可能返回不同类型的值时，用返回值的话就必须设计一个额外的数据结构来处理这种不同的可能性。比如：

一个函数f(int)的返回值可能是一个int, 两个float或者三个complex，那么，我们可以这样设计我们的函数f:
[object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object]

这个函数接受一个整形参数，三个continuation回调用来处理三种不同的返回情况，最后返回这三个回调所返回的类型。
另一个原因：对模拟imperative风格的monad，可以在函数中间迅速返回（类似于C里面的return或者throw)

对于C++，我想，除了处理不同返回类型的问题，另一个应用可以是避免返回值的不必要拷贝。虽然c++现在有NRV优化，但是这个优化本身就很含混，各个编译器对NRV的实现也不同。C++中的拷贝构造很多时候是具有副作用的，作为程序员，不知道自己写的的副作用到底是否被执行了，被执行了几次，总不是一个舒服事。

而continuation-passing-style，不依赖于任何偏僻的语言特性，也不会引入任何的模棱两可，也许可以作为一个设计时的选择。举个例子, 对于字符串的拼接，如果使用continuation-passing-style如下：

[object Object]
[object Object][object Object][object Object]  [object Object]
[object Object]

[object Object]

[object Object]  [object Object][object Object]  [object Object][object Object]  [object Object]

[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]
我们就可以很安心地说，我们此处没有引入任何不必要的拷贝，不论什么编译器。

当然，continuation style的问题是，它不如直接返回值直观，类型系统也无法保证你确实调用了ret(s)。而且，它需要一个function object，c++又不支持lamda，定义很多trivial的functor也会让程序变得很难看。

利弊如何，还要自己权衡。

#### 尾递归与Continuation Passing Style

我觉得，[尾递归](http://www.nowamagic.net/librarys/veda/tag/%E5%B0%BE%E9%80%92%E5%BD%92)其实就是Continuation Passing Style.

Continuation其实就可以看作当前的运行栈。只是我们并不需要整个运行栈，所以，我们可以自己把需要重用的计算结果，都包装在多出来的一个context(contiunation)参数里面，传递下去。 最复杂的情况，这个context也不过是一个stack数据结构。

用例子来说明吧：
1头母牛，出生后第3年，就开始每年生1头母牛，按此规律，第n年时有多少头母牛。
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
Fibonacci数列：1,1,2,3,5,8,13,,21,34........
稍微将问题再变一下：
1头母牛，出生后第4年，就开始每年生1头母牛，按此规律，第n年时有多少头母牛。
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
Fibonacci数列：1, 1, 1, 2, 3, 4, 6, 9,13,19,28........
再将问题一般化，通用描述如下：
1头母牛，出生后第x年，就开始每年生1头母牛，按此规律，第n年时有多少头母牛。
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
递归解法仍然很自然：
[object Object]

[object Object]  [object Object][object Object]  [object Object][object Object]  [object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]

[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]

[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object]

下面把它改成Tail Recursion。这时候我们需要跟踪前k结果。不管怎么说，对于每一次执行，k还是一个固定数字。我们可以用一个k长度的数组来保存前k个中间结果，而不需要一个变长的stack结构。我们可以移动这个k长度的数组里面的数据，来存储当前需要用到的计算结果，参见move方法。（好像一个网络传输协议中的那个窗口概念一样）

[object Object]
[object Object][object Object][object Object]  [object Object]
[object Object]
[object Object]
[object Object]

[object Object][object Object][object Object][object Object]  [object Object][object Object]

[object Object]
[object Object][object Object][object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object]
[object Object]

[object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object][object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]
[object Object]

[object Object]

[object Object]  [object Object][object Object]  [object Object][object Object]  [object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object]
[object Object]

[object Object]

[object Object]  [object Object][object Object]  [object Object][object Object][object Object][object Object]  [object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]

[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]

[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]

[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object]
下面我们把它改成循环。关键步骤还是把middleResults作为循环体外部的变量。
[object Object]

[object Object]  [object Object][object Object]  [object Object][object Object]  [object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]

[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]

[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]

[object Object]
[object Object][object Object][object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]

[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object]

上述写法采用了最直观的写法，并不是最俭省的写法。比如，tail_recursive_fibonacci函数的currentStep参数可以省掉；循环解法里面的最后一次循环中，计算result后，可以直接break。

#### 延伸阅读

此文章所在专题列表如下：
1. [漫谈递归：递归的思想](http://www.nowamagic.net/librarys/veda/detail/2314)
2. [漫谈递归：递归需要满足的两个条件](http://www.nowamagic.net/librarys/veda/detail/2315)
3. [漫谈递归：字符串回文现象的递归判断](http://www.nowamagic.net/librarys/veda/detail/2316)
4. [漫谈递归：二分查找算法的递归实现](http://www.nowamagic.net/librarys/veda/detail/2317)
5. [漫谈递归：递归的效率问题](http://www.nowamagic.net/librarys/veda/detail/2321)
6. [漫谈递归：递归与循环](http://www.nowamagic.net/librarys/veda/detail/2322)
7. [漫谈递归：循环与迭代是一回事吗？](http://www.nowamagic.net/librarys/veda/detail/2324)
8. [递归计算过程与迭代计算过程](http://www.nowamagic.net/librarys/veda/detail/2280)
9. [漫谈递归：从斐波那契开始了解尾递归](http://www.nowamagic.net/librarys/veda/detail/2325)
10. [漫谈递归：尾递归与CPS](http://www.nowamagic.net/librarys/veda/detail/2331)

11. [漫谈递归：补充一些Continuation的知识](http://www.nowamagic.net/librarys/veda/detail/2332)

12. [漫谈递归：PHP里的尾递归及其优化](http://www.nowamagic.net/librarys/veda/detail/2334)
13. [漫谈递归：从汇编看尾递归的优化](http://www.nowamagic.net/librarys/veda/detail/2336)
[我喜欢]()
[我的收藏夹](http://www.nowamagic.net/librarys/topics/favorites/)

*...*![transparent.gif](../_resources/046c7604a84c0768ef44c7afc2dff647.gif)

[![transparent.gif](../_resources/046c7604a84c0768ef44c7afc2dff647.gif)](http://service.weibo.com/staticjs/weiboshare.html?url=http%3A%2F%2Fwww.nowamagic.net%2Flibrarys%2Fveda%2Fdetail%2F2331&type=2&count=1&appkey=&title=&pic=&ralateUid=2809746632&language=zh_cn&dpc=1#)

 不打个分吗？

- [20](http://www.nowamagic.net/librarys/veda/detail/2331#)

- [40](http://www.nowamagic.net/librarys/veda/detail/2331#)

- [60](http://www.nowamagic.net/librarys/veda/detail/2331#)

- [80](http://www.nowamagic.net/librarys/veda/detail/2331#)

- [100](http://www.nowamagic.net/librarys/veda/detail/2331#)

![](../_resources/f9ced49f0004971194ed035f3ffc554f.jpg)
转载随意，但请带上本文地址：
http://www.nowamagic.net/librarys/veda/detail/2331

**如果你认为这篇文章值得更多人阅读，欢迎使用下面的分享功能。**

分享到：[新浪微博](http://www.nowamagic.net/librarys/veda/detail/2331#)[腾讯微博](http://www.nowamagic.net/librarys/veda/detail/2331#)[QQ空间](http://www.nowamagic.net/librarys/veda/detail/2331#)[人人网](http://www.nowamagic.net/librarys/veda/detail/2331#)[豆瓣网](http://www.nowamagic.net/librarys/veda/detail/2331#)[一键分享](http://www.nowamagic.net/librarys/veda/detail/2331#)[2](http://www.nowamagic.net/librarys/veda/detail/2331#)

小提示：您可以按快捷键 Ctrl + D，或点此 [加入收藏](漫谈递归：尾递归与CPS%20--%20简明现代魔法.md#)。
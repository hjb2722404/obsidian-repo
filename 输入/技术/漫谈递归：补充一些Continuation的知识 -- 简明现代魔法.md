漫谈递归：补充一些Continuation的知识 -- 简明现代魔法

[首页](http://www.nowamagic.net/librarys/veda/)![](../_resources/5314c05b83b861dbb1140f2277562370.png)[计算机算法](http://www.nowamagic.net/librarys/veda/cate/Algorithm)![](../_resources/5314c05b83b861dbb1140f2277562370.png) [漫谈递归：补充一些Continuation的知识](http://www.nowamagic.net/librarys/veda/detail/2332)

# [漫谈递归：补充一些Continuation的知识](http://www.nowamagic.net/librarys/veda/detail/2332)

Continuation在函数式编程是非常自然的
在 2012年10月15日 那天写的     已经有 4816 次阅读了

感谢 [参考或原文](http://blog.zhaojie.me/2009/03/tail-recursion-and-continuation.html) blog.zhaojie.me

服务器君一共花费了81.029 ms进行了3次数据库查询，努力地为您提供了这个页面。

试试阅读模式？希望听取您的建议

#### 尾递归与Continuation的联系

前面谈了尾递归与Continuation，但是感觉还有些要补充下。

[Continuation](http://www.nowamagic.net/librarys/veda/tag/Continuation)是一种非常古老的程序结构，简单说来就是entire default future of a computation, 即对程序“接下来要做的事情”所进行的一种建模，即为“完成某件事情”之后“还需要做的事情”。而这种做法，也可以体现在尾递归构造中。

例如以下为阶乘方法的传统递归定义：
[object Object]
[object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object]

显然，这不是一个尾递归的方式，当然我们轻易将其转换为之前提到的尾递归调用方式。不过我们现在把它这样“理解”：每次计算n的阶乘时，其实是“先获取n - 1的阶乘”之后再“与n相乘并返回”，于是我们的FactorialRecursively方法可以改造成：

[object Object]
[object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object]
[object Object]

[object Object]
[object Object]
[object Object]

[object Object]  [object Object][object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]

FactorialContinuation方法的含义是“计算n的阶乘，并将结果传入continuation方法，并返回其调用结果”。于是，很容易得出，FactorialContinuation方法自身便是一个递归调用：

[object Object]

[object Object]  [object Object]  [object Object]  [object Object][object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]

FactorialContinuation方法的实现可以这样表述：“计算n的阶乘，并将结果传入continuation方法并返回”，也就是“计算n - 1的阶乘，并将结果与n相乘，再调用continuation方法”。为了实现“并将结果与n相乘，再调用continuation方法”这个逻辑，代码又构造了一个匿名方法，再次传入FactorialContinuation方法。当然，我们还需要为它补充递归的出口条件：

[object Object]

[object Object]  [object Object]  [object Object]  [object Object][object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]

很明显，FactorialContinuation实现了尾递归。如果要计算n的阶乘，我们需要如下调用FactorialContinuation方法，表示“计算10的阶乘，并将结果直接返回”：

[object Object]
[object Object]
再加深一下印象，大家是否能够理解以下计算“斐波那契”数列第n项值的写法？
[object Object]

[object Object]  [object Object]  [object Object]  [object Object][object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]

在函数式编程中，此类调用方式便形成了“Continuation Passing Style（CPS）”。由于C#的Lambda表达式能够轻松构成一个匿名方法，我们也可以在C#中实现这样的调用方式。您可能会想——汗，何必搞得这么复杂，计算阶乘和“斐波那契”数列不是一下子就能转换成尾递归形式的吗？不过，您试试看以下的例子呢？

对二叉树进行先序遍历（pre-order traversal）是典型的递归操作，假设有如下TreeNode类：
[object Object]
[object Object]  [object Object]  [object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]

[object Object]

[object Object][object Object]  [object Object]  [object Object][object Object]  [object Object]

[object Object]

[object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
[object Object]

[object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object]
于是我们来传统的先序遍历一下：
[object Object]
[object Object]  [object Object]  [object Object]  [object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object][object Object][object Object]
[object Object]

[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]

您能用“普通”的方式将它转换为尾递归调用吗？这里先后调用了两次PreOrderTraversal，这意味着必然有一次调用没法放在末尾。这时候便要利用到Continuation了：

[object Object]
[object Object]  [object Object]  [object Object]  [object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]

[object Object]
[object Object][object Object]
[object Object]

[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]

我们现在把每次递归调用都作为代码的最后一次操作，把接下来的操作使用Continuation包装起来，这样就实现了[尾递归](http://www.nowamagic.net/librarys/veda/tag/%E5%B0%BE%E9%80%92%E5%BD%92)，避免了堆栈数据的堆积。可见，虽然使用Continuation是一个略有些“诡异”的使用方式，但是在某些时候它也是必不可少的使用技巧。

#### Continuation的改进

看看刚才的先序遍历实现，您有没有发现一个有些奇怪的地方？
[object Object]
[object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]

关于最后一步，我们构造了一个匿名函数作为第二次PreOrderTraversal调用的Continuation，但是其内部直接调用了continuation参数——那么我们为什么不直接把它交给第二次调用呢？如下：

[object Object]
[object Object]
[object Object]
[object Object][object Object]

我们使用Continuation实现了尾递归，其实是把原本应该分配在栈上的信息丢到了托管堆上。每个匿名方法其实都是托管堆上的对象，虽然说这种生存周期短的对象不会对内存资源方面造成多大问题，但是尽可能减少此类对象，对于性能肯定是有帮助的。这里再举一个更为明显的例子，求二叉树的大小（Size）：

[object Object]

[object Object]  [object Object]  [object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]

GetSize方法使用了Continuation，它的理解方法是“获取root的大小，再将结果传入continuation，并返回其调用结果”。我们可以将其进行改写，减少Continuation方法的构造次数：

[object Object]

[object Object]  [object Object]  [object Object]  [object Object][object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]
[object Object]

GetSize2方法多了一个累加器参数，同时它的理解方式也有了变化：“将root的大小累加到acc上，再将结果传入continuation，并返回其调用结果”。也就是说GetSize2返回的其实是一个累加值，而并非是root参数的实际尺寸。当然，我们在调用时GetSize2时，只需将累加器置零便可：

[object Object]
[object Object]

#### 小结

在命令式编程中，我们解决一些问题往往可以使用循环来代替递归，这样便不会因为数据规模造成堆栈溢出。但是在函数式编程中，要实现“循环”的唯一方法便是“递归”，因此尾递归和CPS对于函数式编程的意义非常重大。在函数式语言中，continuation的引入是非常自然的过程，实际上任何程序都可以通过所谓的CPS(Continuation Passing Style)变换而转换为使用continuation结构。了解尾递归，对于编程思维也有很大帮助，因此大家不妨多加思考和练习，让这样的方式为自己所用。

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

[![transparent.gif](../_resources/046c7604a84c0768ef44c7afc2dff647.gif)](http://service.weibo.com/staticjs/weiboshare.html?url=http%3A%2F%2Fwww.nowamagic.net%2Flibrarys%2Fveda%2Fdetail%2F2332&type=2&count=1&appkey=&title=&pic=&ralateUid=2809746632&language=zh_cn&dpc=1#)

 不打个分吗？

- [20](http://www.nowamagic.net/librarys/veda/detail/2332#)

- [40](http://www.nowamagic.net/librarys/veda/detail/2332#)

- [60](http://www.nowamagic.net/librarys/veda/detail/2332#)

- [80](http://www.nowamagic.net/librarys/veda/detail/2332#)

- [100](http://www.nowamagic.net/librarys/veda/detail/2332#)

![](../_resources/f9ced49f0004971194ed035f3ffc554f.jpg)
转载随意，但请带上本文地址：
http://www.nowamagic.net/librarys/veda/detail/2332

**如果你认为这篇文章值得更多人阅读，欢迎使用下面的分享功能。**

分享到：[新浪微博](http://www.nowamagic.net/librarys/veda/detail/2332#)[腾讯微博](http://www.nowamagic.net/librarys/veda/detail/2332#)[QQ空间](http://www.nowamagic.net/librarys/veda/detail/2332#)[人人网](http://www.nowamagic.net/librarys/veda/detail/2332#)[豆瓣网](http://www.nowamagic.net/librarys/veda/detail/2332#)[一键分享](http://www.nowamagic.net/librarys/veda/detail/2332#)[0](http://www.nowamagic.net/librarys/veda/detail/2332#)

小提示：您可以按快捷键 Ctrl + D，或点此 [加入收藏](漫谈递归：补充一些Continuation的知识%20--%20简明现代魔法.md#)。
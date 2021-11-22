漫谈递归：PHP里的尾递归及其优化 -- 简明现代魔法

[首页](http://www.nowamagic.net/librarys/veda/)![](../_resources/5314c05b83b861dbb1140f2277562370.png)[计算机算法](http://www.nowamagic.net/librarys/veda/cate/Algorithm)![](../_resources/5314c05b83b861dbb1140f2277562370.png) [漫谈递归：PHP里的尾递归及其优化](http://www.nowamagic.net/librarys/veda/detail/2334)

# [漫谈递归：PHP里的尾递归及其优化](http://www.nowamagic.net/librarys/veda/detail/2334)

PHP编译器没有对尾递归进行优化
在 2012年10月17日 那天写的     已经有 9094 次阅读了
感谢 [参考或原文](http://huoding.com/2012/06/25/158) huoding.com

服务器君一共花费了94.940 ms进行了3次数据库查询，努力地为您提供了这个页面。

试试阅读模式？希望听取您的建议

不同的语言对尾递归的支持都有所不同，编译器的优化也不尽相同。我们之前看了C语言的[尾递归](http://www.nowamagic.net/librarys/veda/tag/%E5%B0%BE%E9%80%92%E5%BD%92)，那么在PHP里又是如何的呢？

#### PHP对尾递归没有优化效果

先来看下实验。
[object Object]
[object Object]
[object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]
[object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
如果安装了XDebug的话，可能会遇到如下错误：
[object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
这是XDebug的一个保护机制，可以通过max_nesting_level选项来设置。放开设置的话，程序还是能够正常运行的。
即便代码能正常运行，只要我们不断增大参数，程序迟早会报错：
[object Object]
[object Object]
为什么呢？简单点说就是递归造成了栈溢出。按照之前的思路，我们可以试下用尾递归来消除递归对栈的影响，提高程序的效率。
[object Object]
[object Object]
[object Object]

[object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object]  [object Object][object Object][object Object]

[object Object]
[object Object]
[object Object]

[object Object]

[object Object]
[object Object]
[object Object]
[object Object]
XDebug同样报错，并且程序的执行时间并没有明显变化。
[object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
事实证明，尾递归在php中是没有任何优化效果的。

#### PHP如何消除递归

先看看下面的源代码：
[object Object]
[object Object]
[object Object]

[object Object]  [object Object][object Object][object Object][object Object]  [object Object]

[object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
[object Object]
[object Object][object Object]  [object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]

[object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object]

[object Object][object Object]  [object Object][object Object]  [object Object][object Object]  [object Object][object Object][object Object]

[object Object]
[object Object][object Object]
[object Object]
[object Object]
[object Object]

[object Object]

[object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]

[object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]
[object Object][object Object]  [object Object][object Object][object Object]
[object Object]
[object Object][object Object]
[object Object]

[object Object]
[object Object][object Object]  [object Object][object Object]
[object Object]
[object Object]
[object Object]

[object Object]
[object Object][object Object][object Object][object Object][object Object]
[object Object]

[object Object]
[object Object]
现在XDebug不再警报效率问题了。

注意到trampoline()函数没？简单点说就是利用高阶函数消除递归。想更进一步了解 call_user_func_array，可以参看这篇文章：[PHP函数补完：call_user_func()与call_user_func_array()](http://www.nowamagic.net/librarys/veda/detail/1509)

还有很多别的方法可以用来规避递归引起的栈溢出问题，比如说Python中可以通过装饰器和异常来消灭尾调用，让人有一种别有洞天的感觉。

#### 小结

在C中的尾递归优化是gcc编译器做的。一般的线性递归修改成为尾递归最大的优势在于减少了递归调用栈的开销。从php那个例子就明显看出来递归开销对程序的影响。但是并不是所有语言都支持尾递归的，即使支持尾递归的语言也一般是在编译阶段对尾递归进行优化，比如C语言对尾递归的[优化](http://www.nowamagic.net/librarys/veda/tag/%E4%BC%98%E5%8C%96)。在使用尾递归对代码进行优化的时候，必须先了解这门语言对尾递归的支持。

在PHP里，除非能提升代码可读性，否则没有必要使用递归；迫不得已之时，最好考虑使用Tail Call或Trampoline等技术来规避潜在的栈溢出问题。

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

[![transparent.gif](../_resources/046c7604a84c0768ef44c7afc2dff647.gif)](http://service.weibo.com/staticjs/weiboshare.html?url=http%3A%2F%2Fwww.nowamagic.net%2Flibrarys%2Fveda%2Fdetail%2F2334&type=2&count=1&appkey=&title=&pic=&ralateUid=2809746632&language=zh_cn&dpc=1#)

 不打个分吗？

- [20](http://www.nowamagic.net/librarys/veda/detail/2334#)

- [40](http://www.nowamagic.net/librarys/veda/detail/2334#)

- [60](http://www.nowamagic.net/librarys/veda/detail/2334#)

- [80](http://www.nowamagic.net/librarys/veda/detail/2334#)

- [100](http://www.nowamagic.net/librarys/veda/detail/2334#)

![](../_resources/f9ced49f0004971194ed035f3ffc554f.jpg)
转载随意，但请带上本文地址：
http://www.nowamagic.net/librarys/veda/detail/2334

**如果你认为这篇文章值得更多人阅读，欢迎使用下面的分享功能。**

分享到：[新浪微博](http://www.nowamagic.net/librarys/veda/detail/2334#)[腾讯微博](http://www.nowamagic.net/librarys/veda/detail/2334#)[QQ空间](http://www.nowamagic.net/librarys/veda/detail/2334#)[人人网](http://www.nowamagic.net/librarys/veda/detail/2334#)[豆瓣网](http://www.nowamagic.net/librarys/veda/detail/2334#)[一键分享](http://www.nowamagic.net/librarys/veda/detail/2334#)[0](http://www.nowamagic.net/librarys/veda/detail/2334#)

小提示：您可以按快捷键 Ctrl + D，或点此 [加入收藏](漫谈递归：PHP里的尾递归及其优化%20--%20简明现代魔法.md#)。
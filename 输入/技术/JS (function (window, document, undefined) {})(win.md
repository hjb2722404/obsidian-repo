JS (function (window, document, undefined) {})(window, document)的真正含义 - Aaxuan - 博客园

#   [JS (function (window, document, undefined) {})(window, document)的真正含义](https://www.cnblogs.com/Aaxuan/p/8215014.html)

原文地址：[What (function (window, document, undefined) {})(window, document); really means](https://toddmotto.com/what-function-window-document-undefined-iife-really-means/)

按原文翻译

在这篇文章中，我们将探讨标题所暗示的内容，并解释自调用函数设置给我们带来了什么。
有趣的是，我被问到关于IIFE(即时调用的函数表达式)的很多，它采用以下设置:
(function (window, document, undefined) { // })(window, document);

那么为什么不写一篇关于它的文章呢? :-)

首先，这是一系列不同的事情。从顶部:
JavaScript具有函数作用域，因此首先创建了一些需要的“私有范围”。例如:
(function (window, document, undefined) { var name = 'Todd';
})(window, document);
console.log(name); //`name is not defined`，它在一个不同的范围内
Simple.

一个正常函数是这样的:
var logMyName = function (name) {
console.log(name);
};
logMyName('Todd');
我们可以选择调用它，在任何我们需要/想的位置。

“IIFE”之所以被创造出来是因为它们是直接调用的函数表达式。
这意味着它们在运行时被立即调用，
我们也不能再调用它们了，它们只运行一次:
var logMyName = (function (name) {
console.log(name); // Todd})('Todd');
这里的秘诀是，(我在前面的例子中给一个变量赋值):
(function () {
})();
多余的一对括号是必要的，因为这样不起作用:
function () {
}();

虽然可以通过一些技巧来欺骗JavaScript“使其工作”。
这样强制JavaScript解析器处理 ! 后面的代码：
!function () {
}();
还有其他的变体：
[![copycode.gif](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)
+function () {
}();-function () {
}();~function () {
}();
[![copycode.gif](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)

但我不会用它们。

请参阅@ mariusschulz分解JavaScript的IIFE语法，详细解释IIFE语法及其变体。
https://blog.mariusschulz.com/2016/01/13/disassembling-javascripts-iife-syntax

现在我们知道了它是如何运作的，我们可以将论证传递给我们的 IIFE:
(function (window) {
})(window);
它是如何工作的呢?
记住, (window); 是调用函数的地方，
我们通过窗口对象。
然后这个函数被传递到函数中，我也把它命名为window。
你可以认为这是毫无意义的，因为我们应该给它命名不同的东西，但是现在我们也将使用窗口。

我们还能做什么呢?把所有的东西都传过去!让我们通过文档对象:

(function (window, document) { // 我们通常需要 window 和 document })(window, document);

那么关于 `undefined` 呢？
在ECMAScript 3中，未定义的是可变的。
这意味着它的值可以被重新分配，比如undefined = true;
oh my! 幸运的是，在 ECMAScript 5 中的 ('use strict';)语法将会抛出一个错误告诉你你是一个白痴。
在此之前，我们开始保护自己的 IIFE:
(function (window, document, undefined) {
})(window, document);
也就是说，如果有人来做这件事，我们会没事的:
undefined = true;

(function (window, document, undefined) { // undefined 是一个局部未定义的变量})(window, document);

缩小局部变量是IIFE模式的神奇之处。
如果传入的是局部变量名，
所以我们可以随意的命名。
[![copycode.gif](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)
(function (window, document, undefined) {
console.log(window); // Object window})(window, document);
(function (a, b, c) {
console.log(a); // Object window})(window, document);
[![copycode.gif](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)
想象一下，你对函数库、window 和 document 的所有引用都很好地缩小了。
当然你不需要停下来，
我们也可以通过jQuery，或者在词汇范围内可以使用的方法:
[![copycode.gif](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)

(function ($, window, document, undefined) { // use $ to refer to jQuery  // $(document).addClass('test');})(jQuery, window, document);

(function (a, b, c, d) { // becomes  // a(c).addClass('test');})(jQuery, window, document);

[![copycode.gif](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)
这也意味着您不需要调用jQuery.noConflict();
或者任何东西作为$被分配到模块的本地。
了解范围和全局/局部变量如何工作将进一步帮助您。

还剩下一小段，不想看了，饿了。感觉好像被塞了一把JS的知识。
原因只是我想知道这样一段代码什么意思。
(function (angular) { 'use strict'; //do something })(window.angular);

* * *

转载请标明出处
作者：[AaXuan](http://www.cnblogs.com/Aaxuan/)
地址：[http://www.cnblogs.com/Aaxuan](http://www.cnblogs.com/Aaxuan/)

[![](https://i.creativecommons.org/l/by/3.0/88x31.png)](http://creativecommons.org/licenses/by/3.0/deed.zh)

本作品采用  [知识共享署名 3.0 未本地化版本许可协议](http://creativecommons.org/licenses/by/3.0/deed.zh)  进行许可。

 [好文要顶](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)  [关注我](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)  [收藏该文](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)  [![icon_weibo_24.png](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)  [![wechat.png](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)

 [![20161118102454.png](../_resources/8c79c631790608d907361f3c2b25f820.jpg)](https://home.cnblogs.com/u/Aaxuan/)

 [Aaxuan](https://home.cnblogs.com/u/Aaxuan/)
 [关注 - 155](https://home.cnblogs.com/u/Aaxuan/followees/)
 [粉丝 - 20](https://home.cnblogs.com/u/Aaxuan/followers/)

 [+加关注](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)

 [«](https://www.cnblogs.com/Aaxuan/p/7470866.html) 上一篇： [MySQL 语句分析](https://www.cnblogs.com/Aaxuan/p/7470866.html)

 [»](https://www.cnblogs.com/Aaxuan/p/8644278.html) 下一篇： [Git 入门使用](https://www.cnblogs.com/Aaxuan/p/8644278.html)

posted @ 2018-01-06 19:01 [Aaxuan](https://www.cnblogs.com/Aaxuan/)  阅读(2779)  评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=8215014) [收藏](JS%20(function%20(window,%20document,%20undefined)%20%7B%7D)(win.md#)
你不知道的JS（2）深入了解闭包 - 汕大小吴 - 博客园

#   [你不知道的JS（2）深入了解闭包](https://www.cnblogs.com/wuguanglin/p/closure.html)

很久之前就想写一篇关于闭包的博客了，但是总是担心写的不够完全、不够好，不管怎样，还是要把我理解的闭包和大家分享下，比较长，希望耐心看完。

### 定义

说实话，给闭包下一个定义是很困难的，原因在于javascript设计的时候并没有专门设计闭包这样一个规则，闭包是随着作用域链、函数可以作为一等公民这样的规则而诞生的。

尽管不能下一个很完美的定义，但是我们还是可以给闭包下一个尽量准确的定义。

**闭包：当函数可以记住并访问所在的词法作用域时，就产生了闭包，即使函数是在当前词法作用域之外执行。**
闭包是基于词法作用域书写代码时所产生的自然结果，你甚至不需要为了利用它们而有意识地创建闭包。闭包的创建和使用在你的代码中随处可见。

### 哪些是闭包？

来看下面这个例子1：
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
function foo() { var a = 2; function bar() {
console.log( a ); // 2 }
bar();
}
foo();
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
基于词法作用域的查找规则，函数bar() 可以访问外部作用域中的变量a（这个例子中的是一个RHS 引用查询）。
那么这个是闭包吗？**很遗憾不是，因为bar函数执行在其定义的词法作用域处。**

* * *

不过稍加修改后就是个闭包了，例子2：
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
function foo() { var a = 2; function bar() {
console.log( a );
} return bar;
}var baz = foo();
baz(); // 2 —— 朋友，这就是闭包的效果。
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
baz函数执行实际上只是通过不同的标识符引用调用了内部的函数bar()
bar()函数显然可以被正常执行，也就是**在自己定义的词法作用域以外的地方执行**。

根据作用域的规则，函数bar()函数能够访问foo()的内部作用域，因此foo()执行完后，其内部作用域并不会被回收，bar() 依然持有对该作用域的引用，而这个引用就叫作闭包。

这个函数在定义时的词法作用域以外的地方被调用。闭包使得函数可以继续访问定义时的词法作用域。
当然，无论使用何种方式对函数类型的值进行传递，当函数在别处被调用时都可以观察到闭包。

* * *

来看例子3：
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
function foo() { var a = 2; function baz() {
console.log( a ); // 2 }
bar( baz );
}function bar(fn) {
fn(); // 妈妈快看呀，这就是闭包！}
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
是的，这也是个闭包，**这里将baz传递出去了在bar()函数中执行，而不是在自己定义的词法作用域中执行，但是它却保留这对定义时词法作用域的引用**

* * *

再看例子4：
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
var fn;function foo() { var a = 2; function baz() {
console.log( a );
}
fn = baz; // 将baz 分配给全局变量}function bar() {
fn(); // 妈妈快看呀，这就是闭包！}
foo();
bar(); // 2
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
是的没错，这还是个闭包，**无论通过何种手段将内部函数传递到所在的词法作用域以外，它都会持有对原始定义作用域的引用，无论在何处执行这个函数都会使用闭包。**

* * *

那我们看一个难一点的例子5：
function wait(message) {
　　setTimeout( function timer() {
　　　　console.log( message );
　　}, 1000 );
}
wait( "Hello, closure!" );

这是闭包吗？答案是的，在这里我们**向setTimeOut传入timer()函数，并且timer函数可以访问wait的内部作用域**，保持着对wait内部作用域的引用，比如里面的message变量。

这时候你肯定会心生疑惑：不对呀？这在哪执行呢？不是说要在定义的词法作用域以外执行吗？
**传入的timer函数当然会被执行，只是内部引擎调用执行的**。

深入到引擎的内部原理中，内置的工具函数setTimeout(..) 持有对一个参数的引用，这个参数也许叫作fn 或者func，或者其他类似的名字。引擎会调用这个函数，在例子中就是内部的timer 函数，而词法作用域在这个过程中保持完整，time函数保持着对wait内部作用域的引用。

### IIFE（立即执行函数）是闭包吗？

例子6：
var a = 2;
(function IIFE() {
console.log( a );
})();
按照我们的定义来说，这不是闭包。
但是，**尽管IIFE 本身并不是观察闭包的恰当例子，但它的确创建了闭包，并且也是最常用来创建可以被封闭起来的闭包的工具。**
因此IIFE 的确同闭包息息相关，即使本身并不会真的使用闭包。

这也是为什么很难给闭包下定义的地方，因为如果从内存或者作用来看，IIFE创建了闭包（也就是在内存中创建了一块区域，这块区域保存着作用域链上作用域的引用，稍后可见例子9），或者说效果等同于创建了闭包。

而如果从闭包的定义来看，这却不是闭包。

* * *

我们来看例子7：
for (var i=1; i<=5; i++) {
　　setTimeout( function timer() {
　　　　console.log( i );
　　}, i*1000 );
}
大家都知道这段代码会输出五次6，为什么呢？

**因为setTimeOut()是异步函数，也就是等循环结束后才去执行setTimeOut()中的回调函数，而在for循环中，并不存在着块级作用域，也就是这个i声明在全局作用域中，并且自始至终只有一个i(因为var声明会变量声明提升，也就是其实只声明了一次)，而在for循环结束后，这个i的值是6。setTimeOut()中的回调函数timer()保持着对i的引用，但是5次timer()函数引用的只是同一个i，所以输出5次6。**

* * *

例子8：
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
for (var i=1; i<=5; i++) {
(function() {
setTimeout( function timer() {
console.log( i );
}, i*1000 );
})();
}
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)

这样有效果么？答案是没有的，虽然通过IIFE每次都创建了一个作用域，但是这个作用域是空的（也就是创建了一个空作用域），所以还会沿着词法作用域链去上一层找i，结果找到的还是全局作用域中的i，也就是只有一个i，还是会输出五次6。

* * *

所以我们需要这样改，来看例子9：
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
// 它需要有自己的变量，用来在每个迭代中储存i 的值：for (var i=1; i<=5; i++) {
(function() { var j = i;
setTimeout( function timer() {
console.log( j );
}, j*1000 );
})();
}// 行了！它能正常工作了！。// 可以对这段代码进行一些改进：for (var i=1; i<=5; i++) {
(function(j) {
setTimeout( function timer() {
console.log( j );
}, j*1000 );
})( i );
}//当然你也可以这样写for (var i=1; i<=5; i++) {
(function(i) {
setTimeout( function timer() {
console.log( i );
}, i*1000 );
})( i );
}
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)

**在迭代内使用IIFE 会为每个迭代都生成一个新的作用域，使得延迟函数的回调可以将新的作用域封闭在每个迭代内部，每个迭代中都会含有一个具有正确值的变量供我们访问。**

**好在ES6出来了let的解决方案，let并不会变量声明提升，并且具有块级作用域的效果，也就是这里会产生5个i的内存空间，被五个timer()函数引用着。**

例子10：
for (let i=1; i<=5; i++) {
　　setTimeout( function timer() {
　　　　console.log( i );
　　}, i*1000 );
}

### 关于闭包的垃圾回收

**问题1：闭包会造成内存泄漏吗？**
我们常说闭包会造成内存泄漏，这是真的吗？答案是不会的。

之所以之前一直说闭包会造成垃圾泄露是由于IE9 之前的版本对JavaScript 对象（标记清除）和COM 对象（引用计数）使用不同的垃圾收集方法。因此闭包在IE 的这些版本中会导致一些特殊的问题。具体来说，如果闭包的作用域链中保存着一个HTML 元素，那么就意味着该元素将无法被销毁

* * *

例子11：
function assignHandler(){ var element = document.getElementById("someElement");
element.onclick = function(){
alert(element.id);
};
}

以上代码创建了一个作为element 元素事件处理程序的闭包，而这个闭包则又创建了一个循环引用。由于匿名函数保存了一个对assignHandler()的活动对象的引用，因此就会导致无法减少element 的引用数。只要匿名函数存在，element 的引用数至少也是1，因此它所占用的内存就永远不会被回收。

解决办法就是把element.id 的一个副本保存在一个变量中，从而消除闭包中该变量的循环引用同时将element变量设为null。

* * *

例子12：
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)

function assignHandler(){ var element = document.getElementById("someElement"); var id = element.id;

element.onclick = function(){
alert(id);
};
element = null;
}
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)

**问题2：闭包中没有使用的变量会被回收吗？**
答案是会的。
来看例子13：
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
function foo() { var x = {}; var y = "whatever"; return  function bar() {
alert(y);
};
}var z = foo();
[![copycode.gif](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
在这里x没有被使用，那么x会被回收吗？答案是的。
理论上来说，bar函数保存着foo作用域中的引用，那么x不应该会被回收。但是现代javascript引擎是非常智能的，对这里进行了优化。

javascript引擎经过**逃逸分析**（分析函数调用关系，以判断变量是否“逃逸”出当前作用域范围）后判断出来x没有在闭包中使用到，那么它就会把x从堆中的作用域中移除出去。

一般是如何分析呢？很简单，如果闭包中没有引用到这个变量，并且没有使用 `eval` 或者 `new Function，那么javascript引擎可以知道闭包的内存中的作用域不需要这个变量x.`

具体测试可以看之前司徒正美的一篇文章：[JS闭包测试](http://www.cnblogs.com/rubylouvre/p/3345294.html)

或者可以看看stackoverflow上的一篇解答：[JavaScript Closures Concerning Unreferenced Variables](https://www.cnblogs.com/wuguanglin/p/JavaScript%20Closures%20Concerning%20Unreferenced%20Variables)

**问题3：闭包中函数里的变量是分配在堆中还是栈中？**
在简单的解释器实现里，函数里的变量是分配在堆而不是在栈上的。现代 JS 引擎当然就比较牛逼了，通过逃逸分析是可以知道哪些可以分配在栈上，哪些需要分配在堆上的。
也就是闭包中使用到的变量会分配在堆中，没有使用到的会分配在栈中（针对简单类型而言），以方便回收。
比如例子13的x，没有被闭包使用，不过是一个复杂类型，所以它在内存中是变量x存储在栈中，同时栈中x的值是堆中的对象{}的地址，大概是下面这样
【栈x】---->（堆{}）

例子13中的y，被闭包使用了，闭包的函数就基于原先的词法作用域单独在堆中分配了内存，也就是闭包保存在了堆，同时其使用的变量也随着闭包一起保存在堆，大概是下面这样。

（堆（闭包（y：“whatever”）））

好了，以上这就是我的个人理解了，如果有什么疑问或者建议欢迎讨论。

分类: [你不知道的JS](https://www.cnblogs.com/wuguanglin/category/1233330.html)

 [好文要顶](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)  [关注我](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)  [收藏该文](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)  [![icon_weibo_24.png](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)  [![wechat.png](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)

 [![20170321150049.png](../_resources/be99413fa658974dee5c51f5584301fc.jpg)](https://home.cnblogs.com/u/wuguanglin/)

 [汕大小吴](https://home.cnblogs.com/u/wuguanglin/)
 [关注 - 2](https://home.cnblogs.com/u/wuguanglin/followees/)
 [粉丝 - 76](https://home.cnblogs.com/u/wuguanglin/followers/)

 [+加关注](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)

 1

 [«](https://www.cnblogs.com/wuguanglin/p/code-interview.html) 上一篇： [JS版剑指offer](https://www.cnblogs.com/wuguanglin/p/code-interview.html)

 [»](https://www.cnblogs.com/wuguanglin/p/OS.html) 下一篇： [操作系统复习](https://www.cnblogs.com/wuguanglin/p/OS.html)

posted @ 2018-09-10 02:23 [汕大小吴](https://www.cnblogs.com/wuguanglin/)  阅读(1107)  评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=9616609) [收藏](你不知道的JS（2）深入了解闭包%20-%20汕大小吴%20-%20博客园.md#)
面试题目别有洞天 -> 从es6优雅解法，到降级polyfill，再到redux reducer迷之命名

# 面试题目别有洞天 -> 从es6优雅解法，到降级polyfill，再到redux reducer迷之命名

[[webp](../_resources/6e4c25303054e912f8a05bf165c92490.webp)](https://www.jianshu.com/u/452568260db5)

[LucasHC](https://www.jianshu.com/u/452568260db5)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='283'%3e%3cpath d='M751.144277 307.2l-123.016533-238.933333h159.778133a81.92 81.92 0 0 1 59.1872 25.258666l160.256 167.492267A27.306667 27.306667 0 0 1 987.620011 307.2h-236.475734z m270.506667 111.547733L640.927744 946.039467a27.306667 27.306667 0 0 1-48.128-24.234667L766.504277 375.466667h-56.388266l-170.5984 590.165333a27.306667 27.306667 0 0 1-52.462934 0.034133L315.500544 375.466667H259.112277l174.523734 545.5872a27.306667 27.306667 0 0 1-48.128 24.302933L5.160277 418.747733A27.306667 27.306667 0 0 1 27.346944 375.466667H999.464277a27.306667 27.306667 0 0 1 22.152534 43.281066zM18.301611 261.0176L178.557611 93.525333A81.92 81.92 0 0 1 237.744811 68.266667h159.744L274.506411 307.2H38.030677a27.306667 27.306667 0 0 1-19.729066-46.1824zM453.877077 68.266667h117.896534l122.9824 238.933333H330.894677l122.9824-238.933333z' data-evernote-id='166' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*0.2212017.03.09 18:19:42字数 1,893阅读 2,102

之前的[一篇文章：从一道面试题，到“我可能看了假源码”](https://www.jianshu.com/p/6958f99db769)讨论了bind方法的各种进阶Pollyfill，今天再分享一个有意思的题目。

从解这道题目出发，我会谈到数组的Reduce方法，ES6特性和Redux数据流框架中Reducer的命名等等。一道典型的题目，却如唐代诗人章碣《对月》诗中所云：“别有洞天三十六，水晶台殿冷层层。”

## 题目背景

完成一个'flatten'的函数，实现“拍平”一个多维数组为一维。示例如下：

	var testArr1 = [[0, 1], [2, 3], [4, 5]];
	var testArr2 = [0, [1, [2, [3, [4, [5]]]]]];
	flatten(testArr1) // [0, 1, 2, 3, 4, 5]
	flatten(testArr2) // [0, 1, 2, 3, 4, 5]
	1234

## 解法先睹为快

先看一眼比较优雅的ES6解法：

	const flatten = arr => arr.reduce((pre, val) => pre.concat(Array.isArray(val) ? flatten(val) : val), []);
	1

如果你看不明白，不要放弃。我会用ES5的思路“翻译”一下，相信你很快就能看懂。
如果你一眼能看明白，也建议继续往下读。因为会有“不一样”的知识点。

## 深入解读

第一个想到的念头肯定是递归，递归自然就想到递归的“尽头”，那就要判断数组某项元素是否还是数组类型。
好吧，我们开始动手实现一个方案，其实是上面解法的ES5版本：

	var flatten = function(array) {
	    return array.reduce(function(previous, val) {
	        if (Object.prototype.toString.call(val) !== '[object Array]') {
	            return (previous.push(val), previous);
	        }
	        return (Array.prototype.push.apply(previous, flatten(val)), previous);
	    }, []);
	};
	12345678

可能这样写，对于很多人来说，并不能完全理解。因为我们使用了较多JS高级用法。关键核心还用到了类似“函数式”思想的reduce方法。
千万不要灰心，继续往下看。

### return的到底是什么？

我们注意到上面的写法return使用了（）表达式。括号内容前半句是为了执行。这样写也许稍微晦涩难懂一些。请看下面的代码示例，你就会明白：

	function t() {
	    var a = 1;
	    return (a++, a);
	}
	t(); // 2
	12345

### Object.prototype.toString.call是什么？

Object.prototype.toString.call可以暂且认为是“功能最强大”的类型判断语句。在对数组类型进行判断时，需要格外小心，比如这样几个“陷阱”：

	var a = [];
	typeof a; // "object"
	a instanceof Array; // true;
	Object.prototype.toString.call(a); // "[object Array]"
	1234

### reduce方法到底做了什么？

现在到了最关键的地方。reduce方法是ES5引入，很多人使用它的场景并不多。但是了解他的特性却是必须的。遗憾的是，社区上对于它的内容似乎都不是“太重视”。“函数式“思想也让一些初学者望而却步。这里我简要进行“科普”，因为下面我要围绕它进行延伸：

reduce在英文中译为“减少; 缩小; 使还原; 使变弱”，MDN对方法直述为：“The reduce method applies a function against an accumulator and each value of the array (from left-to-right) to reduce it to a single value.”

我并不打算对他直接翻译，因为这样会变的更加晦涩难懂。
我们看他的使用语法：

	array1.reduce(callbackfn[, initialValue])
	1

参数分析：
1）array1：必需。
一个数组对象。即调用reduce方法的必须是一个数组类型。
2）callbackfn：必需。
一个接受最多四个参数的函数。对于数组中的每个元素，reduce方法都会调用 callbackfn 函数一次。
这个callback的4个参数为：

	accumulator // 上一次调用回调返回的值，或者是提供的初始值（initialValue）
	currentValue // 数组中正在处理的元素
	currentIndex // 数据中正在处理的元素索引，如果提供了initialValue ，从0开始；否则从1开始
	array // 调用reduce的数组
	1234

3)initialValue可选项。
其值用于第一次调用callback的第一个参数。如果此参数为空，则拿数组第一项来作为第一次调用callback的第一个参数。
比如，我们分析一个常用用法：

	[0,1,2,3,4].reduce(function(previous, item, currentIndex, array){
	  return previous + item;
	});
	// 10
	1234

这里并未提供reduce的第二个参数initialValue，所以从数组第一项开始进行回调函数的执行。并且每次回调函数执行完之后的结果，作为下一次的previous执行回调。

所以，上述代码便是一个累加器的实现。

## ES6写法

现在理解了Reduce函数，再结合ES6特性，使解法更加优雅：

	const flatten = arr => arr.reduce((pre, val) => pre.concat(Array.isArray(val) ? flatten(val) : val), []);
	1

这样写是不是太“函数式”了，但是思路跟之前解法完全一样。我只不过充分使用了箭头函数带来的便利。并且使用了更便捷的isArray对数组类型进行判断。这是开篇提到的解法，也是MDN最新版的实现。

## 如何实现一个reduce的pollyfill

现在明白了reduce的秘密，接下来我们需要充分发挥对JS的理解，来手动实现一个reduce函数。毕竟，reduce是ES5带来的数组新特性，在不使用ES5-shim的情况下，需要手动兼容。另外，其实reduce方法可以实现的逻辑，大多都能够使用循环来实现。但是了解这样一个优雅的方法，不管是在程序的可读性上，还是在设计理解层面上，还是很有必要的。

同样，在MDN上也有实现，但是我觉得下面的代码实现更加优雅和清晰：

	var reduce = function(arr, func, initialValue) {
	    var base = typeof initialValue === 'undefined' ? arr[0] : initialValue;
	    var startPoint = typeof initialValue === 'undefined' ? 1 : 0;
	    arr.slice(startPoint)
	        .forEach(function(val, index) {
	            base = func(base, val, index + startPoint, arr);
	        });
	    return base;
	};
	123456789

如果读者有不同实现思路，也欢迎与我讨论。

## ES5-shim的pollyfill

我也同样看了下ES5-shim里的pollyfill，跟我的思路基本完全一致。唯一有一点区别的地方在于我用了forEach迭代而ES5-shim使用的是简单for循环。

当然，数组的forEach方法也是ES5新增的。但我这里是为了用简单明了的思路，实现reduce方法，根本目的还是希望对reduce有一个全面透彻的了解。
如果您还不明白，我认为还是对于reduce方法没有掌握透彻。建议再梳理一遍。

## Redux中的reducer

明白了reduce函数，我们再来看一下Redux中的reducer和这个reduce有什么命名上的关联。

熟悉Redux数据流架构的同学理解reducer做了什么，关于这个纯函数的命名，在redux源码github仓库上也有一个[官方解释](https://link.jianshu.com/?t=https://github.com/reactjs/redux/blob/master/docs/basics/Reducers.md)：“It's called a reducer because it's the type of function you would pass to Array.prototype.reduce(reducer, ?initialValue)”，虽然是一笔带过，但是总结的恰到好处。

我详细说一下：Redux数据流里，reducers其实是根据之前的状态（previous state）和现有的action（current action）更新state（这个state可以理解为上文累加器的结果（accumulation））。每次redux reducer被执行时，state和action被传入，这个state根据action进行累加或者是“自身消减”（reduce，英文原意），进而返回最新的state。这符合一个典型reduce函数的用法：state -> action -> state.

## 总结

这篇文章对于如何优雅地“扁平化”一个多维数组进行了解法分析。并且对于秉承函数式编程思想的reduce方法进行了深入讨论，我们还实现了reduce的pollyfill。在充分理解的基础上，又简要延伸到redux数据架构里面reducer的命名。熟悉Redux的同学一定会有所感触。

最后希望对读者有所启发，也欢迎同我讨论。
PS：百度知识搜索部大前端继续招兵买马，高级工程师、实习生职位均有，有意向者火速联系。。。

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='796'%3e%3cpath d='M728.064 343.943529c-17.648941-2.891294-23.552-20.239059-26.503529-28.912941V104.026353C701.560471 46.200471 654.396235 0 595.425882 0c-53.007059 0-97.28 40.478118-106.134588 89.569882-29.997176 184.862118-138.541176 255.457882-217.630118 280.937412a26.142118 26.142118 0 0 0-18.130823 24.877177v560.067764c0 19.817412 16.022588 35.84 35.84 35.84h535.973647c56.018824-11.565176 94.328471-31.804235 120.892235-86.738823l120.832-416.105412c23.552-75.173647-14.757647-147.395765-100.231529-144.564706h-238.772706z m-571.813647 31.744H76.619294C35.358118 375.687529 0 410.383059 0 450.861176v462.426353c0 43.369412 32.406588 78.004706 76.619294 78.004706h79.631059c27.708235 0 50.115765-22.407529 50.115765-50.115764V425.863529a50.115765 50.115765 0 0 0-50.115765-50.115764z' data-evernote-id='160' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

8人点赞*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='64 64 896 896' focusable='false' class='js-evernote-checked' data-icon='right' width='1em' height='1em' fill='currentColor' aria-hidden='true' data-evernote-id='800'%3e%3cpath d='M765.7 486.8L314.9 134.7A7.97 7.97 0 0 0 302 141v77.3c0 4.9 2.3 9.6 6.1 12.6l360 281.1-360 281.1c-3.9 3-6.1 7.7-6.1 12.6V883c0 6.7 7.7 10.4 12.9 6.3l450.8-352.1a31.96 31.96 0 0 0 0-50.4z' data-evernote-id='801' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='805'%3e%3cpath d='M771.413333 668.728889c-18.773333 3.015111-25.031111 20.878222-28.16 29.866667v217.884444c0 59.733333-49.948444 107.52-112.412444 107.52a115.427556 115.427556 0 0 1-112.412445-92.558222c-31.857778-190.919111-146.830222-263.850667-230.627555-290.133334a27.420444 27.420444 0 0 1-19.228445-26.168888V37.944889C268.572444 17.066667 285.582222 0 306.631111 0h567.864889c59.335111 11.946667 99.953778 32.824889 128 89.543111l128.113778 429.909333c24.974222 77.653333-15.644444 152.291556-106.211556 149.276445H771.413333z m-605.866666-32.824889H81.180444C37.546667 635.904 0 600.064 0 558.250667V80.611556C0 35.84 34.360889 0 81.180444 0H165.546667c29.297778 0 53.077333 23.779556 53.077333 53.077333v529.749334a53.077333 53.077333 0 0 1-53.077333 53.077333z' data-evernote-id='139' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

[*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='810'%3e%3cpath d='M178.390055 120.591045C111.268624 120.591045 56.888889 174.401955 56.888889 240.556383V903.97778C56.888889 970.302855 111.097977 1024 178.390055 1024h545.731364c67.121431 0 121.558049-53.81091 121.558049-120.02222V240.613265c0-66.268192-54.209088-120.02222-121.558049-120.02222H178.390055z m455.117432 301.136319H269.06087a30.147761 30.147761 0 0 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z m303.18409 301.136318a30.318409 30.318409 0 0 1-30.375291-30.318409V180.317742c0-66.268192-53.81091-120.02222-121.330519-120.022219H329.697688a30.147761 30.147761 0 0 1 0-60.23864l454.946784 0.056882C885.326618 0.113765 967.009987 80.887013 967.009987 180.602155v511.943118a30.318409 30.318409 0 0 1-30.31841 30.318409z m-303.18409-120.47728H269.06087a30.147761 30.147761 0 1 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z' data-evernote-id='150' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*前端杂谈](https://www.jianshu.com/nb/9051203)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='816'%3e%3cpath d='M232.727273 579.87878833C271.28679 579.87878833 302.545455 548.62012233 302.545455 510.06060633 302.545455 471.50108933 271.28679 440.24242433 232.727273 440.24242433 194.167756 440.24242433 162.909091 471.50108933 162.909091 510.06060633 162.909091 548.62012233 194.167756 579.87878833 232.727273 579.87878833ZM512 579.87878833C550.559516 579.87878833 581.818182 548.62012233 581.818182 510.06060633 581.818182 471.50108933 550.559516 440.24242433 512 440.24242433 473.440484 440.24242433 442.181818 471.50108933 442.181818 510.06060633 442.181818 548.62012233 473.440484 579.87878833 512 579.87878833ZM791.272727 579.87878833C829.832243 579.87878833 861.090909 548.62012233 861.090909 510.06060633 861.090909 471.50108933 829.832243 440.24242433 791.272727 440.24242433 752.713211 440.24242433 721.454545 471.50108933 721.454545 510.06060633 721.454545 548.62012233 752.713211 579.87878833 791.272727 579.87878833Z' data-evernote-id='170' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

"如果想获得源码和demo，如果觉得我的文章对您有用，请随意赞赏！"

[![0](../_resources/fee9458c29cdccf10af7ec01155dc7f0.png)]()[![wechat-771371d5741b0c32cd805caeb48ad6c0.png](../_resources/771371d5741b0c32cd805caeb48ad6c0.png)]()共2人赞赏

[[webp](../_resources/1f1bbad0ca618d533cb358b1dc66888a.webp)](https://www.jianshu.com/u/452568260db5)

[LucasHC](https://www.jianshu.com/u/452568260db5)不会讲法语的二级运动员不是好前端工程师～
现就职于百度知识搜索部：主导并参与了多个产品线大型...
总资产215 (约18.37元)共写了14.3W字获得590个赞共608个粉丝
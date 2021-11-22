怎样阅读 ECMAScript 规范？_不挑食的程序员 - SegmentFault 思否

 [ ![1392292204-5daff24f151be_big64](../_resources/2fffc4f83caa69dfd62a4ea9bc3aed3a.png)     **Pines_Cheng**](https://segmentfault.com/u/pines_cheng)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='1'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='180' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  6k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='2'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='184' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/Pines-Cheng)

[![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-comment-alt-lines fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='comment-alt-lines' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='5'%3e%3cpath fill='currentColor' d='M448 0H64C28.7 0 0 28.7 0 64v288c0 35.3 28.7 64 64 64h96v84c0 7.1 5.8 12 12 12 2.4 0 4.9-.7 7.1-2.4L304 416h144c35.3 0 64-28.7 64-64V64c0-35.3-28.7-64-64-64zm16 352c0 8.8-7.2 16-16 16H288l-12.8 9.6L208 428v-60H64c-8.8 0-16-7.2-16-16V64c0-8.8 7.2-16 16-16h384c8.8 0 16 7.2 16 16v288zm-96-216H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h224c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16zm-96 96H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h128c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16z' data-evernote-id='195' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://segmentfault.com/a/1190000019240609#comment-area)

#   [怎样阅读 ECMAScript 规范？](https://segmentfault.com/a/1190000019240609)

[深入理解javascript系列](https://segmentfault.com/t/%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3javascript%E7%B3%BB%E5%88%97)[specifications](https://segmentfault.com/t/specifications)[ecmascript](https://segmentfault.com/t/ecmascript)[javascript](https://segmentfault.com/t/javascript)

 发布于 2019-05-20

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

> 翻译自：> [> How to Read the ECMAScript Specification](https://timothygu.me/es-howto/#navigating-the-spec)

Ecmascript 语言规范 `The ECMAScript Language specification`（又名：Javascript 规范 `the JavaScript specification` 或 `ECMA-262`）是学习 JavaScript 底层工作原理的非常好的资源。 然而，这是一个庞大的专业文本资料，咋一眼看过去，大家可能会感到迷茫、恐惧，满怀激情却无从下手。

## 前言

不管你是打算每天阅读一点 ECMAScript 规范，还是把它当成一个年度或者季度的目标，这篇文章旨在让你更轻松的开始阅读最权威的 JavaScript 语言参考资料。

### 为什么要阅读 ECMAScript 规范

Ecmascript 规范是所有 JavaScript 运行行为的权威来源，无论是在你的浏览器环境，还是在服务器环境（ Node.js ），还是在宇航服上[ NodeJS-NASA ] ，或在你的物联网设备上[ JOHNNY-FIVE ]。 所有 JavaScript 引擎的开发者都依赖于这个规范来确保他们各种天花乱坠的新特性能够其他 JavaScript 引擎一样，按预期工作。

Ecmascript 规范 绝不仅仅对 JavaScript 引擎开发者有用，它对普通的 JavaScript 编码人员也非常有用，而你只是没有意识到或者没有用到。

假设有一天你在工作中发现了下面这个奇怪的问题：

	> Array.prototype.push(42)
	 1
	> Array.prototype
	 [ 42 ]
	> Array.isArray(Array.prototype)
	 true
	> Set.prototype.add(42)
	 TypeError: Method Set.prototype.add called on incompatible receiver #<Set>
	     at Set.add (<anonymous>)
	> Set.prototype
	 Set {}

并且非常困惑为什么一个方法在它的原型上工作，但是另一个方法在它的原型上却不工作。 不幸的是，这种问题你 [Google 不到](https://www.google.com/search?q=array+prototype+push+on+prototype)， [Stack Overflow 可能也解决不了你的疑惑](https://stackoverflow.com/search?q=array+prototype+push+on+prototype)。

这个时候你就应该去阅读 Ecmascript 语言规范。

或者，您可能想知道臭名昭著的 [loose equality operator (==)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Equality_operators) 是如何工作的(这里松散地使用了单词 `"function"[ WAT ])。 作为一个勤奋好学的程序员，你在 MDN 上查找它 [paragraphs of explanation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Using_the_Equality_Operators)，却发现上面的解释让你一脸懵逼。

这个时候你就应该去阅读 Ecmascript 语言规范。

另一方面，我不建议初次接触 JavaScript 的开发人员阅读 ECMAScript 规范。 如果你是 JavaScript 的新手，那么就开开心心的玩玩 web 吧！ 开发一些 web 应用，或者一些基于 Javascript 的摄像头等。当你踩了足够多的 JavaScript 坑，或者 JavaScript 问题已经无法再限制你的开发能力的时候，你就可以考虑回到这个文档了。

好了，你现在已经知道，JavaScript 规范在帮助您理解语言或平台的复杂性方面非常有用。 但是 ECMAScript 规范究竟包含哪些东西呢？

### 什么属于 ECMAScript 规范，什么不属于

教科书对这个问题的回答是 "ECMAScript 规范中只包含语言特性" 但这并没有帮助，因为这就像是在说 "JavaScript 特性就是 JavaScript" 我不喜欢重言式[ XKCD-703]。

相反，我要做的是列出一些在 JavaScript 应用程序中常见的东西，并告诉你它们是否是一个语言特性。

| 特性  | 是否属于 |
| --- | --- |
| Syntax of syntactic elements (i.e., what a valid for..in loop looks like) | Y   |
| Semantics of syntactic elements (i.e., what typeof null, or { a: b } returns) | Y   |
| import a from 'a'; | ? [1] |
| Object, Array, Function, Number, Math, RegExp, Proxy, Map, Promise, ArrayBuffer, Uint8Array, ... | Y   |
| console, setTimeout(), setInterval(), clearTimeout(), clearInterval() | N [2] |
| Buffer, process, global* | N [3] |
| module, exports, require(), __dirname, __filename | N [4] |
| window, alert(), confirm(), the DOM (document, HTMLElement, addEventListener(), Worker, ...) | N [5] |

1. 规范指定了这些声明的语法以及它们的意思，但没有指定如何加载模块。

2. 这些东西可以在浏览器和 Node.js 中使用，但不是标准的。 对于 Node.js，它们有对应的 [Nodejs 文档](https://nodejs.org/api/globals.html#globals_global_objects)。 对于浏览器，`console`由 [Console 标准](https://console.spec.whatwg.org/) 定义，而其余部分由 [HTML 标准](https://html.spec.whatwg.org/multipage/) 指定。

3. 这些都是 Node.js 仅支持的全局变量，由 [Nodejs 文档](https://nodejs.org/api/globals.html#globals_global_objects) 定义。 * global 实际上有机会成为 ECMAScript 的一部分，并在浏览器中实现[ECMA-262-GLOBAL](https://github.com/tc39/proposal-global)。

4. 这些是仅包含 node.js 模块的"globals"，由 [其文档](https://nodejs.org/api/modules.html#modules_modules) 记录 / 指定。

5. 这些都是浏览器专用的东西。

### 在哪里查看 ECMAScript 规范？

当你在 [Google "ECMAScript specification"](https://www.google.com/search?q=ecmascript+specification)时，你会看到很多结果，都声称是合法的规范。 你应该读哪一本？

更有可能的是，在 `tc39.github.io/ecma262/` 上发布的规范正是您想要的 [ECMA-262](https://tc39.github.io/ecma262/)。

长话短说：

Ecmascript 语言规范是由一群来自不同背景的人开发的，他们被称为 ECMA 国际技术委员会39(或者他们更熟悉的名字 TC39[ TC39])。 TC39 在 `TC39.github.io` [ ECMA-262]维护 ECMAScript 语言的最新规范。

让事情变得复杂的是，每年 TC39都会选择一个时间点对规范进行快照，以便成为当年的 ECMAScript 语言标准，并附带一个版本号。 例如，ECMAScript 2018语言规范(ECMA-262，第9版)[ECMA-262-2018]()仅仅是2018年6月在 `tc39.github.io`[ ECMA-262]中看到的规范，放入归档库中，并进行适当地包裹和 PDFified 以供永久存档。

正因为如此，除非你希望你的 web 应用程序从 2018 年 6 月开始只能运行在放入 formaldehyde、适当包装和 PDFified 以便永久存档的浏览器上，否则你应该始终查看 `tc39.github.io` [ECMA-262]的最新规范。 但是，如果您希望(或者必须)支持旧版本的浏览器或 Node.js 版本，那么引用旧版本的规范可能会有所帮助。

> 注: iso/iec 也将 ECMAScript 语言标准发表为 iso/iec16262[ ISO-16262-2011]。 不过不用担心，因为这个标准的文本和 ECMA 国际出版的标准文本完全一样，唯一的区别是你必须支付 198 瑞士法郎。

### Navigating the spec 规范导航

Ecmascript 规范谈论了大量的内容。 尽管它的作者尽最大努力把它分割成小的逻辑块，它仍然是一个超级庞大的文本。
就我个人而言，我喜欢把规格分为五个部分:

- Conventions and basics 约定和基础 (什么是数字? 当规范说 `throw a TypeError exception` 是什么意思?)
- Grammar productions of the language 语言的语法结果 (如何编写 `for-in` 循环?)
- Static semantics of the language 语言的静态语义 (`var` 语句中如何确定变量名称?)
- Runtime semantics of the language 语言的运行时语义 (`for-in` 循环是如何执行的?)
- APIs (`String.prototype.substring()` 做什么?)

但规范不是这样组织的。 相反，它把第一个要点放在 [§5 Notational Conventions](https://tc39.github.io/ecma262/#sec-notational-conventions) 通过 [§9 Ordinary and Exotic Objects Behaviours](https://tc39.github.io/ecma262/#sec-ordinary-and-exotic-objects-behaviours)，接下来的三个以交叉的形式放在[§10 ECMAScript Language: Source Code](https://tc39.github.io/ecma262/#sec-ecmascript-language-source-code) 通过 [§15 ECMAScript Language: Scripts and Modules](https://tc39.github.io/ecma262/#sec-ecmascript-language-scripts-and-modules)，像：

> [> §13.6 The `if`>  Statement](https://tc39.github.io/ecma262/#sec-if-statement)>  Grammar productions

- > §13.6.1-6 Static semantics
- > §13.6.7 Runtime sematics

> [> §13.7 Iteration Statements](https://tc39.github.io/ecma262/#sec-iteration-statements)>  Grammar productions

	- §13.7.1 Shared static and runtime semantics
	
	- §13.7.2 The `do-while` Statement
	
	    - §13.7.2.1-5 Static semantics
	
	   - §13.7.2.6 Runtime semantics

> §13.7.3 The `while`>  Statement
> ...

而 APIs 则通过 [§18 The Global Object](https://tc39.github.io/ecma262/#sec-global-object) 通过 [§26 Reflection](https://tc39.github.io/ecma262/#sec-reflection) 扩展全局对象。

在这一点上，我想指出的是，**绝对没有人从上到下阅读规范**。 相反，只看与你要查找的内容相对应的部分，在该部分中只看您需要的内容。 试着确定你的具体问题涉及的五大部分中的哪一部分; 如果你无法确定哪一部分是相关的，问问自己这样一个问题："在什么时候(无论你想要确认什么)这个问题被评估了?" 这可能会有帮助。 不要担心，操作规范只会在实践中变得更容易。

## Runtime semantics 运行时语义

`Runtime semantics of The Language` 和 `APIs` 的运行时语义是规范中最重要的部分，通常是人们最关心的问题。

总的来说，在规范中阅读这些章节是非常简单的。 然而，该规范使用了大量的 shorthands，这些 shorthands 刚刚开始(至少对我来说)是相当讨厌的。 我将尝试解释其中的一些约定，然后将它们应用到一个通常的工作流程中，以弄清楚几件事情是如何工作的。

### Algorithm steps 算法步骤

Ecmascript 中的大多数 `runtime semantics` （运行时语义） 是由一系列 `algorithm steps` （算法步骤） 指定的，与伪代码没有什么不同，但形式精确得多。

> A sample set of algorithm steps are:
1. > Let a be 1.
2. > Let b be a+a.
3. > If b is 2, then
   
    1. > Hooray! Arithmetics isn’t broken.
4. > Else
   
    1. > Boo!

> 拓展阅读：> [> §5.2 Algorithm Conventions](https://tc39.github.io/ecma262/#sec-algorithm-conventions)

### Abstract operations 抽象操作

你有时会看到类似函数的东西在 spec 中被调用。 [Boolean()](https://tc39.github.io/ecma262/#sec-boolean-constructor-boolean-value) 函数的第一步是:

> 当使用参数值调用 Boolean 时，将执行以下步骤：

1. > Let b be > [> ToBoolean](https://tc39.github.io/ecma262/#sec-toboolean)> (value).

2. > ...

这个 `ToBoolean` 函数被称为 abstract operation (抽象操作)：它是抽象的，因为它实际上并没有作为一个函数暴露给 JavaScript 代码。 它只是一个 `notation spec writers` （符号规范作者）发明的，让他们不要写同样的东西一遍又一遍。

> 拓展阅读：> [> §5.2.1 Abstract Operations](https://tc39.github.io/ecma262/#sec-algorithm-conventions-abstract-operations)

### What is [[This]]

有时候，你可能会看到 [[Notation]] 被用作 "Let proto be obj.[[Prototype]]"。 这个符号在技术上可能意味着几个不同的东西，这取决于它出现的上下文，但是你可以理解，这个符号指的是一些不能通过 JavaScript 代码观察到的内部属性。

准确地说，它可以意味着三种不同的东西，我将用规范中的例子来说明它们。 不过，你可以暂时跳过它们。

#### A field of a Record

Ecmascript 规范使用术语 `Record` 来引用具有固定键集的 `key-value map` ——有点像 C 语言中的结构。 [Record](https://timothygu.me/es-howto/#record) 的每个 `key-value` 对称为 `field`。 因为 [Records](https://timothygu.me/es-howto/#record) 只能出现在规范中，而不能出现在实际的 JavaScript 代码中，所以使用 [`[[Notation]]`](https://timothygu.me/es-howto/#double-brackets-notation)来引用 [Record](https://timothygu.me/es-howto/#record) 的 [field](https://timothygu.me/es-howto/#record-field) 是有意义的。

> Notably, > [> Property Descriptors](https://tc39.github.io/ecma262/#sec-property-descriptor-specification-type)>  are also modeled as Records with fields [[Value]], [[Writable]], [[Get]], [[Set]], [[Enumerable]], and [[Configurable]]. The > [> IsDataDescriptor](https://tc39.github.io/ecma262/#sec-isdatadescriptor)>  abstract operation uses this notation extensively:

> When the abstract operation IsDataDescriptor is called with > [> Property Descriptor](https://tc39.github.io/ecma262/#sec-property-descriptor-specification-type)>  Desc, the following steps are taken:

1. > If Desc is undefined, return false.
2. > If both Desc.[[Value]] and Desc.[[Writable]] are absent, return false.
3. > Return true.

另一个 Records 的具体例子可以在下一节中找到, [§2.4 Completion Records; ? and !](https://timothygu.me/es-howto/#completion-records-and-shorthands)

> 拓展阅读: > [> §6.2.1 The List and Record Specification Types](https://tc39.github.io/ecma262/#sec-list-and-record-specification-type)

#### An internal slot of a JavaScript Object

Javascript 对象可能有所谓的 internal slots ，规范使用这些 internal slots 来保存数据。 像 Record 字段一样，这些 internal slots 也不能用 JavaScript 观察到，但是其中一些可能会通过特定于实现的工具(如 Google Chrome 的 DevTools)暴露出来。 因此，使用 `[[Notation]]` 来描述 internal slots 也是有意义的。

internal slots 的细节将在 §2.5 JavaScript Objects 中介绍。 现在，不要过于担心它们的用途，但请注意下面的例子。

> Most JavaScript Objects have an internal slot [[Prototype]] that refers to the Object they inherit from. The value of this internal slot is usually the value that Object.getPrototypeOf() returns. In the OrdinaryGetPrototypeOf abstract operation, the value of this internal slot is accessed:

> When the abstract operation OrdinaryGetPrototypeOf is called with Object O, the following steps are taken:

1. > Return O.[[Prototype]].

> 注意: Object 和 Record fields 的 Internal slots 在外观上是相同的，但是可以通过查看这个符号(点之前的部分)的先例来消除它们的歧义，无论它是 Object 还是 Record。 从周围的环境来看，这通常是相当明显的。

#### An internal method of a JavaScript Object

Javascript 对象也可能有所谓的 internal methods。 像 internal slots 一样，这些 internal methods 不能通过 JavaScript 直接观察到。 因此，使用 `[[Notation]]` 来描述 internal methods 也是有意义的。

internal methods 的细节将在 §2.5 JavaScript Objects 中介绍。 现在，不要过于担心它们的用途，但请注意下面的例子。

> All JavaScript functions have an internal method [[Call]] that runs that function. The Call abstract operation has the following step:

1. > Return ? F.[[Call]](V, argumentsList).

> where F is a JavaScript function object. In this case, the [[Call]] internal method of F is itself called with arguments V and argumentsList.

> 注意: [[[Notation]]的第三种意义可以通过看起来像一个函数调用来区分。

### Completion Records; ? and !

Ecmascript 规范中的每个运行时语义都显式或隐式地返回一个报告其结果的 `Completion Record`。 这个 `Completion Record` 是一个Record，有三个可能的领域:

- 一个 [[Type]] (normal, return, throw, break, 或 continue)
- 如果 [[Type]] 是正常的, return, or throw, 那么它也可以有 `[[Value]]` ("what’s returned/thrown")
- 如果[[Type]] 是中断或继续, 那么它可以选择带有一个称为 `[[Target]]` 的标签，由于运行时语义的原因，脚本执行 breaks from/continues

A `Completion Record` whose [[Type]] is `normal` is called a `normal completion`. Every `Completion Record` other than a `normal completion` is also known as an `abrupt completion`.

大多数情况下，您只需要处理 abrupt completions 的 `[[ Type ]]` 是 throw。 其他三种 abrupt completion 类型仅在查看如何评估特定语法元素时有用。 实际上，在内置函数的定义中，您永远不会看到任何其他类型，因为 break / continue / return 不跨函数边界工作。

> 拓展阅读：> [> §6.2.3 The Completion Record Specification Type](https://tc39.github.io/ecma262/#sec-completion-record-specification-type)

由于 Completion Records 的定义，JavaScript 中的细节(如冒泡错误，直到 `try-catch` 块)在规范中不存在。 事实上，错误(或更准确地说是 abrupt completions)是显式处理的。

没有任何缩写，对抽象操作的普通调用的规范文本可能会返回一个计算结果或抛出一个错误，它看起来像：
> 下面是一些调用抽象操作的步骤，这些步骤可以抛出 `without any shorthands`>  的操作：
1. > Let resultCompletionRecord be AbstractOp().
> Note: resultCompletionRecord is a Completion Record.

1. > If resultCompletionRecord is an abrupt completion, return resultCompletionRecord.

> 注意: 在这里，如果是 abrupt completion，则直接返回 resultCompletionRecord。 换句话说，会转发 AbstractOp 中抛出的错误，并终止其余的步骤。

1. > Let result be resultCompletionRecord.[[Value]].
> 注意: 在确保得到 normal completion 后，我们现在可以解构 Completion Record 以得到我们需要的计算的实际结果。
1. > result 就是我们需要的结果。 我们现在可以用它做更多的事情。
这可能会模糊地让你想起 C 语言中的手动错误处理:

	int result = abstractOp();              *// Step 1*
	if (result < 0)                         *// Step 2*
	  return result;                        *// Step 2 (continued)*
	                                        *// Step 3 is unneeded*
	*// func() succeeded; carrying on...     // Step 4*

但是为了减少这些繁琐的步骤，ECMAScript 规范的编辑器增加了一些缩写。 自 ES2016 以来，同样的规范文本可以用以下两种等价的方式编写:
> 下面的几个步骤可以调用一个抽象操作，这个操作可能会抛出 `ReturnIfAbrupt`> ：
1. > Let result be AbstractOp().
> 注意: 这里，就像前面例子中的步骤1一样，结果是一个 Completion Record.
1. > ReturnIfAbrupt(result).

> Note: 注意: `ReturnIfAbrupt`>  通过转发来处理任何可能出现的 abrupt completions，并自动将 result 解构到它的 `[[Value]]`

1. > result 就是我们需要的结果。 我们现在可以用它做更多的事情。
> 或者，更准确地说，用一个特殊的问号 `(?)`>  符号：
> 调用可能带有问号(?)的抽象操作的几个步骤 :
1. > Let result be ? AbstractOp().

> 注意：在这个 notation 中，我们根本不处理 `Completion Records`>  。 `?`>  shorthand 为我们处理了一切事情, 且 result 立马就可用

1. > result 就是我们需要的结果。 我们现在可以用它做更多的事情。

有时，如果我们知道对 AbstractOp 的特定调用永远不会返回一个 abrupt completion，那么它可以向读者传达更多关于 `spec’s intent`。 在这些情况下，一个 `exclamation mark (!)` 用于：

> A few steps that call an abstract operation that cannot ever throw with an exclamation mark (!):

> Let result be ! AbstractOp().

> Note: While ? forwards any errors we may have gotten, ! asserts that we never get any abrupt completions from this call, and it would be a bug in the specification if we did. Like the case with ?, we don’t deal with Completion Records at all. result is ready to use immediately after.

> result is the result we need. We can now do more things with it.

> 拓展阅读：> [>  §5.2.3.4 ReturnIfAbrupt Shorthands](https://tc39.github.io/ecma262/#sec-returnifabrupt-shorthands)

### JavaScript Objects

在 ECMAScript 中，每个 Object 都有一组内部方法，规范的其余部分调用这些方法来完成某些任务。 所有 object 都有的一些内部方法是:

- [[Get]], which gets a property on an Object (e.g. obj.prop)
- [[Set]], which sets a property on an Object (e.g. obj.prop = 42;)
- [[GetPrototypeOf]], which gets the Object’s prototype (i.e., Object.getPrototypeOf(obj))
- [[GetOwnProperty]], which gets the Property Descriptor of an own property of an Object (i.e., Object.getOwnPropertyDescriptor(obj, "prop"))
- [[Delete]], which deletes a property on an Object (e.g. delete obj.prop)

详尽的列表可在 [§6.1.7.2 Object Internal Methods and Internal Slots](https://tc39.github.io/ecma262/#sec-object-internal-methods-and-internal-slots) 中找到。

基于这个定义，function objects (or just "functions") 是简单的对象，它们附加了 [[Call]] 内部方法，可能还有[[ Construct ]]内部方法; 因此，它们也被称为 callable objects。

然后，规范将所有 Object 分为两类: `ordinary objects` 和 `exotic objects`。 你遇到的大多数对象都是 ordinary objects，这意味着它们所有的内部方法都是在 [§9.1 Ordinary Object Internal Methods and Internal Slots](https://tc39.github.io/ecma262/#sec-ordinary-object-internal-methods-and-internal-slots)。

然而，ECMAScript 规范还定义了一些 exotic objects，这些对象可以覆盖这些内部方法的默认实现。 对于允许外来对象执行的操作，有一定的最小限制，但是一般来说，过多的内部方法可以执行大量的特技操作，而不违反规范。

> Array 对象是这些 exotic objects 的一种。 使用 ordinary objects 可用的工具无法获取像 Array 对象的 length 属性的一些特殊语义。

> 其中之一是，设置 Array 对象的 length 属性可以从对象中删除属性，但 length 属性似乎只是一个普通的数据属性。 相比之下，`new Map().size`>  只是 `Map.prototype`>  上指定的 getter 函数，不具有类似于 `[].length`>  的属性。

	> const arr = [0, 1, 2, 3];
	> console.log(arr);
	[ 0, 1, 2, 3 ]
	> arr.length = 1;
	> console.log(arr);
	[ 0 ]
	> console.log(Object.getOwnPropertyDescriptor([], "length"));
	{ value: 1,
	  writable: true,
	  enumerable: false,
	  configurable: false }
	> console.log(Object.getOwnPropertyDescriptor(new Map(), "size"));
	undefined
	> console.log(Object.getOwnPropertyDescriptor(Map.prototype, "size"));
	{ get: [Function: get size],
	  set: undefined,
	  enumerable: false,
	  configurable: true }

这种行为是通过重写 `[[DefineOwnProperty]]` 内部方法来实现的。 详见 [§9.4.2 Array Exotic Objects](https://tc39.github.io/ecma262/#sec-array-exotic-objects)

* * *

Javascript 对象也可能有定义为包含特定类型值的 internal slots 。 我倾向于将 internal slots 视为甚至对 `Object.getOwnPropertySymbols()` 都隐藏的以符号命名的属性。ordinary objects 和 exotic objects 都允许有 internal slots。

在 `An internal slot of a JavaScript Object` 中, 我提到了大多数对象都具有的一个名为 `[[Prototype]]` 的 `internal slot` 。 (事实上，所有的 ordinary objects ，甚至一些 exotic objects ，比如 Array 对象都有它。) 但是我们也知道有一个叫`[[GetPrototypeOf]]` 的内部方法，我在上面简要描述过。 它们之间有什么区别吗？

这里的关键字是 `most`: 虽然大多数对象都有 `[[Prototype]]` internal slot，但所有对象都实现 `[[GetPrototypeOf]]` 内部方法。 值得注意的是，Proxy 对象没有它们自己的 `[[Prototype]]` ，而且它的 `[[GetPrototypeOf]]` 内部方法遵从已注册的处理程序或其目标的原型，存储在 Proxy 对象的 `[[ProxyTarget]]` 的 internal slot 中。

因此，在处理对象时，引用适当的 `internal method` 几乎总是一个好主意，而不是直接查看 `internal slot` 的值。

* * *

另一种思考 `Objects`, `internal methods` 和 `internal slots` 之间关系的方式是通过经典的 `object-oriented lens`。 "Object"类似于指定必须实现的几个 `internal methods` 的接口。 `ordinary objects` 提供了缺省实现，`exotic objects` 可以部分或全部覆盖。 另一方面，`internal slots` 似于 `Object` 的实例变量 —— Object 的实现细节。

所有这些关系都可以用下面的 UML 图来概括:
![1460000019240612](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107132138.png)

### 示例: String.prototype.substring()

现在我们已经很好地理解了规范是如何组织和编写的，让我们开始练习吧！
假设我现在有以下问题：
如果不运行代码，下面的代码片段返回什么？
`String.prototype.substring.call(undefined, 2, 4)`
这是一个相当棘手的问题。 似乎有两种看似合理的结果：

1. String.prototype.substring() 可以首先将 `undefined` 强制转换为 `"undefined"` 字符串，然后在该字符串的第二和第三个位置(即间隔 [2,4] )获取字符得到 `"de"`。

2. 另一方面，`String.prototype.substring()` 也可以合理地抛出一个错误，从而拒绝未定义的输入。

不幸的是，当 this 的值不是字符串时，[MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/substring#) 也没有真正提供任何关于函数运行的说明。

在阅读 algorithm steps 之前，让我们先想想我们知道什么。 我假设我们已经对 `str.substring()` 的通常工作方式有了基本的了解：即返回给定字符串的一部分。 我们现在真正不确定的是，在 `this` 值为 `undefined` 的情况下，它是如何运作的。 因此，我们将特别寻找解决 this 值的 `algorithm steps`。

幸运的是，[String.prototype.substring()](https://tc39.github.io/ecma262/#sec-string.prototype.substring) algorithm 的第一步专门处理这个值：

1. > Let O be ? > [> RequireObjectCoercible](https://tc39.github.io/ecma262/#sec-requireobjectcoercible)> (this value).

`？` shorthand 允许我们得出这样的结论: 在某些情况下，[RequireObjectCoercible](https://tc39.github.io/ecma262/#sec-requireobjectcoercible) 抽象操作实际上可能会抛出异常，因为否则 `！` 会被用来代替。 事实上，如果它抛出一个错误，它将与我们上面的第二个假设相对应！ 有了希望，我们可以通过单击超链接来了解 [RequireObjectCoercible](https://tc39.github.io/ecma262/#sec-requireobjectcoercible) 做了什么。

`Requireobjectforecble` 抽象操作有点奇怪。 与大多数抽象操作不同，它是通过表格而不是步骤来定义的：

| Argument Type | Result |
| --- | --- |
| Undefined 的 | Throw a TypeError exception |
| ... | ... |

不管怎样——在对应于 `Undefined` (我们传递给 `substring()` 的 this 值的类型)的行中，规范说 RequireObjectCoercible 应该抛出一个异常。 那是因为在 函数的定义中使用 `？` ，我们知道抛出的异常必须冒泡到函数的调用方。

这就是我们的答案: 给定的代码片段会抛出一个 `TypeError` 异常。
> 规范只指定了错误抛出的类型，而没有指定它包含的消息。 这意味着实现可以有不同的错误消息，甚至是本地化的错误消息。
> 例如，在谷歌的 v86.4(包含在谷歌 Chrome 64中)上，消息是：
`TypeError: String.prototype.substring called on null or undefined`
> 而 Mozilla Firefox 57.0提供了一些不那么有用的功能
`TypeError: can’t convert undefined to object`
> 与此同时，ChakraCore version 1.7.5.0(Microsoft Edge 中的 JavaScript 引擎)采用了 V8的路线并抛出
`TypeError: String.prototype.substring: 'this' is null or undefined`

### 示例: Boolean() 和 String() 会抛出异常吗?

在编写关键任务代码时，必须优先考虑异常处理。 因此，"某个内置函数会抛出异常吗?" 需要仔细琢磨。

在本例中，我们将尝试回答两个语言内置函数 `Boolean()` 和 `String()` 的问题。 我们将只关注对这些函数的直接调用，而不是 `new Boolean()` 和 `new String()` ——这是 [JavaScript 中最不受欢迎的特性](https://github.com/getify/You-Dont-Know-JS/blob/master/types%20%26%20grammar/ch3.md#object-wrapper-gotchas) 之一，也是几乎所有 JS 编程指南中最不鼓励的实践 [YDKJS](https://timothygu.me/es-howto/#biblio-ydkjs)。

在找到规范中的 [Boolean()](https://tc39.github.io/ecma262/#sec-boolean-constructor-boolean-value) 部分之后，我们看到算法似乎相当简短：

> 当使用参数值调用 Boolean 时，将执行以下步骤：

1. > Let b be > [> ToBoolean(value)](https://tc39.github.io/ecma262/#sec-toboolean)> .

2. > If NewTarget is undefined, return b.

3. > Let O be ? > [> OrdinaryCreateFromConstructor](https://tc39.github.io/ecma262/#sec-ordinarycreatefromconstructor)> (NewTarget, `"%BooleanPrototype%"`> , « [[BooleanData]] »).

4. > Set O.[[BooleanData]] to b.
5. > Return O.

但是从另一方面来说，这并不是完全简单的，在 [OrdinaryCreateFromConstructor](https://tc39.github.io/ecma262/#sec-ordinarycreatefromconstructor) 这里涉及到一些复杂的基本技巧。 更重要的是，有一个 `？` 步骤 3 中的简写，可能表明此函数在某些情况下可能抛出错误。 让我们仔细看看。

步骤1将 value (函数参数)转换为布尔值。 有趣的是，没有一个 `？` 或者 `！`这一步骤的 shorthand ，但通常没有 Completion Record shorthand 等同于 `！` . 因此，步骤 1 不能抛出异常。

第 2 步检查名为 [NewTarget](https://timothygu.me/es-howto/#abstract-opdef-newtarget) 的东西是否 undefined。 `Newtarget` 是在 ES2015 中首次添加的 [new.target](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new.target#) 元属性的 spec 等价物，它允许规范区分 `new Boolean()` 调用。 因为我们现在只关注对 `Boolean()` 的直接调用，所以我们知道 `NewTarget` 总是未定义的，并且算法总是直接返回 b，而不需要任何额外的处理。

因为调用不带 `new` 的 `Boolean()` 只能访问 `Boolean()` 算法中的前两个步骤，而这两个步骤都不能引发异常，所以我们得出结论: 无论输入是什么，`Boolean()` 都不会引发异常。

让我们把注意力转向 String () :
> 当使用参数值调用 String 时，将执行以下步骤:
1. > If no arguments were passed to this function invocation, let s be "".
2. > Else,

    1. > If NewTarget is undefined and > [> Type](https://tc39.github.io/ecma262/#sec-ecmascript-data-types-and-values)> (value) is Symbol, return > [> SymbolDescriptiveString](https://tc39.github.io/ecma262/#sec-symboldescriptivestring)> (value).

    2. > Let s be ? > [> ToString](https://tc39.github.io/ecma262/#sec-tostring)> (value).

3. > If NewTarget is undefined, return s.

4. > Return ? > [> StringCreate](https://tc39.github.io/ecma262/#sec-stringcreate)> (s, ? > [> GetPrototypeFromConstructor](https://tc39.github.io/ecma262/#sec-getprototypefromconstructor)> (NewTarget, `"%StringPrototype%"`> )).

根据我们使用 [Boolean()](https://tc39.github.io/ecma262/#sec-boolean-constructor-boolean-value) 函数进行同类分析的经验，我们知道对于我们的案例，[NewTarget](https://timothygu.me/es-howto/#abstract-opdef-newtarget) 总是未定义的，因此可以跳过最后一步。 我们还知道 [Type](https://timothygu.me/es-howto/#abstract-opdef-type) 和 [SymbolDescriptiveString](https://tc39.github.io/ecma262/#sec-symboldescriptivestring) 也是安全的，因为它们都不会处理 abrupt completions。 然而，还有一个关于 `？` 的问题吗？ 在调用 [ToString](https://timothygu.me/es-howto/#abstract-opdef-tostring) 抽象操作之前。 让我们仔细看看。

就像我们前面看到的 [RequireObjectCoercible](https://tc39.github.io/ecma262/#sec-requireobjectcoercible) 一样，[ToString](https://tc39.github.io/ecma262/#sec-tostring)(argument) 也是用一个表定义的：

| Argument Type | Result |
| --- | --- |
| Undefined | Return "undefined" |
| Null | Return "null" |
| Boolean | If argument is true, return "true" If argument is false, return "false" |
| Number | Return [NumberToString](https://tc39.github.io/ecma262/#sec-numbertostring)(argument) |
| String | Return argument |
| Symbol | Throw a TypeError exception |
| Object | Apply the following steps: 1. Let primValue be ? [ToPrimitive](https://tc39.github.io/ecma262/#sec-toprimitive)(argument, hint String) 2. Return ? [ToString](https://tc39.github.io/ecma262/#sec-tostring)(primValue) |

在 [String()](https://timothygu.me/es-howto/#abstract-opdef-tostring) 中调用 [ToString](https://timothygu.me/es-howto/#abstract-opdef-tostring) 时，value 可以是 `Symbol` 以外的任何值(在紧接着的步骤中过滤掉)。 然而，还有两个 `？` 对象行中的。 我们可以点击 [ToPrimitive](https://tc39.github.io/ecma262/#sec-toprimitive) 和 beyond 的链接，发现如果 value 是 Object，那么实际上有很多机会抛出错误:

所以对于 `String()` ，我们的结论是它从不为 `primitive values` 抛出异常，但可能为 Objects 抛出错误。
更多关于 String() throws 的例子如下：

	*// Spec stack trace:*
	*//   OrdinaryGet step 8.*
	*//   Ordinary Object’s [[Get]]() step 1.*
	*//   GetV step 3.*
	*//   GetMethod step 2.*
	*//   ToPrimitive step 2.d.*
	
	String({
	  get [Symbol.toPrimitive]() {
	    throw new Error("Breaking JavaScript");
	  }
	});
	*// Spec stack trace:*
	*//   GetMethod step 4.*
	*//   ToPrimitive step 2.d.*
	
	String({
	  get [Symbol.toPrimitive]() {
	    return "Breaking JavaScript";
	  }
	});
	*// Spec stack trace:*
	*//   ToPrimitive step 2.e.i.*
	
	String({
	  [Symbol.toPrimitive]() {
	    throw new Error("Breaking JavaScript");
	  }
	});
	*// Spec stack trace:*
	*//   ToPrimitive step 2.e.iii.*
	
	String({
	  [Symbol.toPrimitive]() {
	    return { "breaking": "JavaScript" };
	  }
	});
	*// Spec stack trace:*
	*//   OrdinaryToPrimitive step 5.b.i.*
	*//   ToPrimitive step 2.g.*
	
	String({
	  toString() {
	    throw new Error("Breaking JavaScript");
	  }
	});
	*// Spec stack trace:*
	*//   OrdinaryToPrimitive step 5.b.i.*
	*//   ToPrimitive step 2.g.*
	
	String({
	  valueOf() {
	    throw new Error("Breaking JavaScript");
	  }
	});
	*// Spec stack trace:*
	*//   OrdinaryToPrimitive step 6.*
	*//   ToPrimitive step 2.g.*
	
	String(Object.create(null));

### 示例：typeof operator

到目前为止，我们只分析了 API 函数，让我们尝试一些不同的东西。

> 未完待续 > [> https://github.com/TimothyGu/...](https://github.com/TimothyGu/es-howto/issues/2)

## 参考

- [How to Read the ECMAScript Specification](https://timothygu.me/es-howto/#navigating-the-spec)
- [ECMAScript® 2020 Language Specification](https://tc39.github.io/ecma262/)
- [JavaScript深入之从ECMAScript规范解读this](https://github.com/mqyqingfeng/Blog/issues/7)
- [读懂 ECMAScript 规格](http://www.ruanyifeng.com/blog/2015/11/ecmascript-specification.html)

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

阅读 1.3k  更新于 2019-06-03

本作品系 原创， [采用《署名-非商业性使用-禁止演绎 4.0 国际》许可协议](https://creativecommons.org/licenses/by-nc-nd/4.0/)

* * *

 [![1392292204-5daff24f151be_big64](../_resources/2fffc4f83caa69dfd62a4ea9bc3aed3a.png)](https://segmentfault.com/u/pines_cheng)

#####   [Pines_Cheng](https://segmentfault.com/u/pines_cheng)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='17'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  6k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='18'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z'%3e%3c/path%3e%3c/svg%3e)](https://github.com/Pines-Cheng)
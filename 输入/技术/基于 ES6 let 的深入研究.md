基于 ES6 let 的深入研究

# 基于 ES6 let 的深入研究

6 个月前

## 文章目的：讨论问题，引发思考，解决疑惑。此外拿捏不准的地方均有标注。

## **1. 前言**

文章并没有对 `let` 和 `const` 知识点进行重复说明，而是针对某些点，进行深入研究和探讨，发出疑问和思考。感觉 `let` 更像一个引子，通过它来接触“底层”。

主要思考问题：`let` 到底有没有变量提升？`{}` 是块级作用域吗？`let` 会“挟持” `()` 吗？ 值与内存，栈内存是否存在？
蛮多内容看起来跟主题 `let` 并没有太多关系，但都是我在研究过程中遇到的，还是有根线的。所以就都放上来了，希望对你有些帮助，我们一起来探讨这些问题。
> 主要阅读书籍：《深入理解ES6》《ES6标准入门（第3版）》《你不知道的JavaScript（上卷）》

## **2. 块级作用域**

## **2.1 作用域**

	<script type="text/javascript">
	    function a() {
	        var b = 0
	        c = 0 *// 没用var、let、const，则自动变为全局变量
	***    }
	    a()
	    console.log(window.a) *// function a() { ... }
	***    console.log(window.b) *// undefined
	***    console.log(window.c) *// 0
	***​
	    for(var d=0; d<2; d++) {
	        *// 如果已有该名称的变量存在于同一个作用域，则会忽略该声明
	***        var e = d
	    }
	    console.log(window.d) *// 2
	***    console.log(window.e) *// 1
	***</script>

解释：
① `function` 是**函数作用域**（b 并没有“逃离”函数a）；
② `for` 循环是普通块（d “逃离”了），`if` 也是；
③ 还有全局作用域，ES6 新增了块级作用域。

## **2.2 暂时性死区（TDZ）**

	var a = 0
	if(true) {
	    a = 1 *// ReferenceError： a is not defined
	***    let a = 2
	}

我读的这三本书，每一本都有一句话：“let 并不会发生变量提升”。
> 变量提升：无论你在哪里声明变量，都会被当作在当前作用域顶部声明。

> JavaScipt 代码在正确显示前，会进行编译和解释执行。在编译中会找到所有的声明，放在当前作用域顶部。比如 `var a = 2;`>  ，实际是 `var a;`>  和 `a = 2;`>  两部分，前者为编译阶段任务，后者为执行阶段任务。

> ① 先提升函数，再提升变量;
> ② 赋值和其他运行逻辑会留在原地，函数表达式不会被提升(实际为赋值操作)。
那么问题来了！
如果你并没有对 `let` 或 `const` 进行提升操作，请问你怎么会知道这是一个块级作用域？怎么会形成暂时性死区？

## **思考：let 到底有没有变量提升？**

在查找相关资料时，阅读了《[我用了两个月的时间才理解 let](https://zhuanlan.zhihu.com/p/28140450)》这篇文章，解释的蛮好，将总结贴一下：

* * *

下面的结论暂时保留观点，使用的名词也许会对大家造成困惑，具体请看评论区讨论。此问题更多在于语言设计，编译方面，过阵子会继续研究进行补充。-2019.04.17

* * *

> let 的「创建」过程被提升了，但是「初始化」没有提升。
> var 的「创建」和「初始化」都被提升了。（补充：「初始化」为 undefined）
> function 的「创建」「初始化」和「赋值」都被提升了。

下面是我截取并翻译的官方的相关说明：

> 以下名词在此> [> 页面](https://link.zhihu.com/?target=https%3A//www.cs.rit.edu/usr/local/pub/swm/lisp/HyperSpec/Body/26_glo_l.htm)> 有相关解释。

## **var 变量**

> 对于 `VariableEnvironment`>  和 `LexicalEnvironment`>  我并不是非常明白。目前的理解是后者是建立在前者的基础上。待赐教。

> 资料供参考：> [> ES6 Execution Contexts](https://link.zhihu.com/?target=http%3A//www.ecma-international.org/ecma-262/6.0/index.html%23sec-execution-contexts)>  与 > [> What's the difference between “LexicalEnvironment” and “VariableEnvironme" in spec](https://link.zhihu.com/?target=https%3A//stackoverflow.com/questions/40691226/whats-the-difference-between-lexicalenvironment-and-variableenvironment-in)

`var` 语句声明了范围为正在运行的执行上下文的 `VariableEnvironment` （**变量环境**）的变量。

`var` 变量在它们包含的 `LexicalEnvironment` （词法环境）被实例化时**创建**，并在创建时被**初始化**为 `undefined`。

在任何`VariableEnvironment` （变量环境）的范围内，一个普通的 `BindingIdentifier`（绑定标识符） 可能会出现在多个 `VariableDeclaration`（变量声明） 中，但这些声明只能共同定义一个变量。

一个由带有 `Initializer` （初始化）的 `VariableDeclaration` （变量声明）定义的变量，在这个 `VariableDeclaration` （变量声明）执行时，被**赋值**为其 `Initializer` （初始化）的 `AssignmentExpression` （赋值表达式）的值，而不是在创建变量时。

> [> Variable Statement](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/6.0/index.html%23sec-variable-statement)

> A `var`>  statement declares variables that are scoped to the > [> running execution context](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23running-execution-context)> 's VariableEnvironment.

> Var variables are created when their containing > [> Lexical Environment](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23sec-lexical-environments)>  is instantiated and are **> initialized**>  to undefined when **> created**> .

> Within the scope of any VariableEnvironment a common > [> BindingIdentifier](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-BindingIdentifier)>  may appear in more than one > [> VariableDeclaration](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-VariableDeclaration)>  but those declarations collectively define only one variable.

> A variable defined by a > [> VariableDeclaration](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-VariableDeclaration)>  with an > [> Initializer](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-Initializer)>  is **> assigned**>  the value of its > [> Initializer](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-Initializer)> 's > [> AssignmentExpression](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-AssignmentExpression)>  when the > [> VariableDeclaration](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-VariableDeclaration)>  is executed, not when the variable is created.

## **let 和 const 变量**

> 这里的 `is evaluated`>  我不是很明白，暂且翻译为被评估。
> 但根据官方文档的标题 "Runtime Semantics: Evaluation"，这应该是在运行时候的操作，那么也就是上面的文章的总结。
`let` 和 `const` 声明定义了范围为正在运行的执行上下文的 `LexicalEnvironment` （词法环境）的变量。

这些变量在它们包含的 `LexicalEnvironment` （词法环境）被实例化时**创建**，但在它们的 `LexicalBinding` （词法绑定）评估之前，可能无法以任何方式访问。

一个由带有 `Initializer` （初始化）的 `LexicalBinding` （词法绑定）定义的变量，在 `LexicalBinding` （词法绑定）评估时，被**赋值**为其 `Initializer` （初始化）的 `AssignmentExpression` （赋值表达式）的值，而不是在创建变量时。

如果 `let` 声明的 `LexicalBinding` （词法绑定）没有初始化，在 `LexicalBinding`（词法绑定）评估时，这个变量会被**赋值**为 `undefined`。

> [> Let and Const Declarations](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/6.0/index.html%23sec-let-and-const-declarations)

`let`>  and `const`>  declarations define variables that are scoped to the > [> running execution context](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23running-execution-context)> 's LexicalEnvironment.

> The variables are **> created**>  when their containing > [> Lexical Environment](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23sec-lexical-environments)>  is instantiated but may not be accessed in any way until the variable's > [> LexicalBinding](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-LexicalBinding)>  is evaluated.

> A variable defined by a > [> LexicalBinding](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-LexicalBinding)>  with an > [> Initializer](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-Initializer)>  is **> assigned**>  the value of its > [> Initializer](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-Initializer)> 's > [> AssignmentExpression](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-AssignmentExpression)>  when the > [> LexicalBinding](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-LexicalBinding)>  is evaluated, not when the variable is created.

> If a > [> LexicalBinding](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-LexicalBinding)>  in a `let`>  declaration does not have an > [> Initializer](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-Initializer)>  the variable is **> assigned**>  the value undefined when the > [> LexicalBinding](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/9.0/index.html%23prod-LexicalBinding)>  is evaluated.

## **思考：let x = x 后，再次 let x 依旧错误？**

上篇推荐文章最后提了一个问题："[如何理解 let x = x 报错之后，再次 let x 依然会报错？](https://link.zhihu.com/?target=https%3A//link.jianshu.com/%3Ft%3Dhttps%253A%252F%252Fwww.zhihu.com%252Fquestion%252F62966713) "

实验代码：

	var a = 0
	if(true) {
	    let a = a *//Uncaught ReferenceError: a is not defined
	***}
	​
	var a = 0
	if(true) {
	    let a = a
	    let a = 1 *//Uncaught SyntaxError: Identifier 'a' has already been declared
	***}

当只有一句 `let a = a` 时，会报错 `a` 没有定义，此时为执行错误；
有两句时，报错 `a` 已经被声明，此时为编译错误。
> 引擎会在解释 JavaScript 代码前对其编译，编译中会找到所有的声明，并用合适的作用域将它们关联起来。

> 仅 > [> SyntaxError](https://link.zhihu.com/?target=https%3A//www.ecma-international.org/ecma-262/6.0/index.html%23sec-native-error-types-used-in-this-standard-syntaxerror)>  是编译错误，其余均为执行错误。

## **2.3 {} **

## **对变量提升的影响**

`{}` 对于各个声明的变量提升，从以下示例代码的输出可以看出，影响是不同的。
① 对于 `var` ，没什么影响，似乎`{}` 是透明的；
② 对于 `let` 和 `const` ，也没什么影响，这就是它们该有的结果；

③ 对于 `function` ，有影响：`{}` 阻止了 `function` 的赋值提升！它如果在 `{}` 之内定义，则并不能提升到 `{}` 之前，但它依旧可以在 `{}` 之后访问到。

这些运行结果引发了我后面的疑问。

	*// 多层"{}"结果一样，没注释的均输出 undefined
	***console.log(typeof a)
	{
	    console.log(typeof a)
	    var a = 1
	    console.log(typeof a) *//number
	***}
	console.log(typeof a) *//number
	***​
	console.log(typeof a)
	{
	    *//console.log(typeof a) ReferenceError: a is not defined
	***    let a = 1 *// const 同理
	***    console.log(typeof a) *//number
	***}
	console.log(typeof a)
	​
	console.log(typeof f)
	{
	    console.log(typeof f) *//function
	***    function f() {
	        console.log(1)
	    }
	    console.log(typeof f) *//function
	***}
	console.log(typeof f) *//function
	*

## **思考：{} 是块级作用域吗？**

几乎目前我读到的 `ES6` 书籍，都谈到 `{}` 是块级作用域。
没错，在其他语言中，比如 `C`、`C++`、`Java` 中，`{}` 确实是块级作用域。

但是从上一小节的示例代码结果中，你也可以看到，在 `ES6` 中的 `{}`，并不完全等同于其他语言中的`{}`。比如 `function` 为什么可以在块级作用域之外可以访问？它不应该被摧毁了吗？

以及 `ES6`的块级作用域，是否是一个“伪”块级作用域？只是因为 `let` 和 `const` 声明的变量的作用域，造成了这种假象。
其实上述的结果是因为，代码没有运行在 `'use strict';` 下。

> [> 关于es6块级作用域内函数声明的问题](https://link.zhihu.com/?target=https%3A//segmentfault.com/q/1010000013515171)> ：在严格模式下，**> 函数声明**> 是有块作用域的。依旧会进行变量提升，提升至当前作用域头部。

> 推荐阅读：> [> ES6 Block](https://link.zhihu.com/?target=http%3A//www.ecma-international.org/ecma-262/6.0/index.html%23sec-block)>  ，与 > [> ES5 Block](https://link.zhihu.com/?target=http%3A//es5.github.io/%23x12.1)>  相比较增加了很多的内容。

	'use strict';
	{
	    f() *//1
	***    function f() {
	        console.log(1)
	    }
	    f() *//1
	***}
	*// f() ReferenceError: f is not defined
	*

从 `[ES6](https://link.zhihu.com/?target=http%3A//www.ecma-international.org/ecma-262/6.0/index.html%23sec-block)` 文档内新增的大量内容可以看到， 针对 `let` 、`const` 和 `function` 等等来讲，`{}` 确实是块级作用域。

> 应该还有 `class`> ？不过暂时没有研究`class`> ，就不写这个了。

## **2.4 for 循环中的 let**

在 `for` 循环，`let` 设置循环的部分，JavaScript 引擎会记住上一轮的值，每一轮都是新的值。

	for(var i=0; i<5; i++ ) {
	    var i = 1
	    console.log(i) *// 1，1，1···无限
	***}
	​
	for(var i=0; i<5; i++) {
	  let i = 1
	  console.log(i) *// 1，1，1，1，1
	***}
	​
	*// 编译错误，此时 let 和 var 是在同一个作用域？
	***for(let i=0; i<5; i++) {
	    var i = 1 *// SyntaxError: Identifier 'i' has already been declared
	***    console.log(i)
	}
	​
	*// let 是否会挟持"()"形成块级作用域？
	***for(let i=0; i<5; i++) {
	    let i = 1
	    console.log(i) *// 1，1，1，1，1
	***}

疑惑点：《ES6标准入门（第3版）》P18页写到“设置循环变量的那部分是一个父作用域，而循环体内部是一个单独的子作用域。”

## **思考：let 会”挟持“ () 吗？**

观察示例代码的第三个，属于编译错误，并考虑到 let 是不允许在同一个作用域声明同一个变量的，此时 let 和 var 应该是在同一个作用域。

参考其他示例代码的运行结果，按照我的理解：`let` “挟持”了最近的 `{}` 形成块级作用域，那么对于 `for` 循环而言，`let` 也会“挟持” `()` 形成块级作用域？

在阅读了 [The for Statement](https://link.zhihu.com/?target=http%3A//www.ecma-international.org/ecma-262/6.0/index.html%23sec-for-statement) 后，其实与 `()` 并没有太多关系，只是语法、词法设置，对于 `for` 的三种迭代语句，设置了不同的处理过程。

	IterationStatement :
	*// for(i = 0; i<2; i++) ..
	***for ( Expressionopt ; Expressionopt ; Expressionopt ) Statement
	*// for(var i = 0; i<2; i++) ..
	***for ( var VariableDeclarationList ; Expressionopt ; Expressionopt ) Statement
	*// ES6 新增： for(let i = 0; i<2; i++) ..
	***for ( LexicalDeclaration Expressionopt ; Expressionopt ) Statement

## **2.5 try/catch 不是块级作用域 **

	(function() {
	  try {
	    throw "test";
	  } catch(e) {
	    var e, x = 123
	    console.log(e) *//test
	***  }
	  console.log(x) *//123
	***  console.log(e) *//undefined
	***})()

> 思考来源：《> [> try-catch语句的“伪块作用域”](https://link.zhihu.com/?target=https%3A//www.web-tinker.com/article/20331.html)>  》

在《你不知道的JavaScript（上卷）》P31页 3.4.2 `try/catch` 章节中，写到“ES3 规范中规定 `try/catch` 的`catch` 分句会创建一个块作用域，其中声明的变量仅在 `catch` 内部有效。”

但上面的示例代码你也看到了，`catch` 中声明的 `x` 在外部依旧可访问（但是 `e` 不可以）。
该文章下面有一条对此的解释：
> catch 确实会对作用域链做一个小动作，这个小动作就是把 catch(e) 中的 e 单独放入一个作用域，然后把这个作用域加入作用域链的最前端。
我认为这条解释比较合理。

## **2.6 const 的“修改”**

`const` 不允许修改绑定，但如果绑定的是一个对象，则可以修改对象的值。

## **值**

JavaScript 包含两种类型的**值**：基本类型值和引用类型值。

基本类型值：`Undefined`、`Null`、`Boolean`、`Number`、`String`、`Symbol`，按**值**访问，存在**栈内存**中；

引用类型值：`Object`、`Array`、`Function`、`Data`、`RegExg` 等，按**引用**访问，存在**堆内存**中。

![](data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='504' height='356'></svg>)

堆栈内存
小知识点：
① Javascript 的变量**没有**类型，只有**值**才有。
② 所有引用类型的值**都是**  `Object` 的实例。
③ 当**复制**保存着某对象的变量时，操作的是对象的引用，而为对象**添加**属性时，操作的是实际的对象。

> 我的个人理解：`const a = 123`> ，就是说变量 `a`>  只能指向存 `123`>  这个值的内存位置，`a`>  的这个指向不能改变；如果声明的是一个对象，那么 `a`>  指向的是一个存放引用的位置，这个引用指向的内存并不受 `const`>  的控制。

## **思考： 栈内存是否真的存在？**

我目前认为，可以通过“栈内存”和“堆内存”来理解**值**，其中的“堆内存”是肯定存在的，但是因为**变量对象**，“栈内存”是否真的存在，有待商榷。
我倾向于数据都存放在“堆内存”中，“栈内存”只是为了便于理解出现的，是假想的，但目前没有找到权威的解释。
> 变量对象：每个执行环境中定义的所有变量和函数都保存在这个对象中。
> 执行环境：定义了变量或函数有权访问的其他数据，决定了它们各自的行为。
> 不知这里与 2.1 章节的 `VariableEnvironment`>  和 `LexicalEnvironment`>  是否有关。

> 推荐阅读：《> [> 前端基础进阶（一）：内存空间详细图解](https://link.zhihu.com/?target=https%3A//www.jianshu.com/p/996671d4dcc4)>  》、> [> web前端之路](https://link.zhihu.com/?target=https%3A//www.jianshu.com/c/5769e7b7c708)>

关于 JavaScript 的内存部分，疑惑颇多，望赐教。

## **3. 扩展**

在学习过程中遇到的一些小知识点。

## **3.1 引擎**

> 《你不知道的JavaScript（上卷）》“第一部分 作用域和闭包”，建议多读读这章关于引擎的部分，从编译的角度思考，比如 `var a = 2;`>  实际为两部分。

JavaScript 引擎：从头到尾负责整个 JavaScript 程序的编译及执行过程。
V8 引擎：直接将 JavaScript 代码编译成原生机器码。之后 node.js 出世。
引擎会在解释 JavaScript 代码前对其编译，编译中会找到所有的声明，并用合适的作用域将它们关联起来。

## **3.2 ()**

函数声明：`function`  **是**声明中的第一个词。
函数表达式：`function`  **不是**声明中的第一个词
IIFE：立即执行函数表达式，`(function test(){...})()` 或 `(function test(){...}())`

	function test(){...} *//函数声明
	***(function test(){...}) *//函数表达式
	***var test  = function test(){...} *//函数表达式
	***(function test(){...})() *//立即执行函数表达式
	***(function test(){...}()) *//立即执行函数表达式
	*

## **3.3 循环和闭包**

	for(var i=0; i<3; i++) {
	    setTimeout(function timer() {
	        console.log(i)
	    }, i*1000)
	}

① 会以每 1 秒的频率输出 3 次 3；
② 即使每个迭代中的 setTimeout 时间设置为 **0**，所有的回调函数还是会在循环结束后被执行；
③ 尽管在各个迭代中分别定义，但它们都被封闭在**同一个作用域**中，引用的是同一个 i。

## **3.4 值传递**

所有函数的参数都是**值**传递。
值传递：将实际参数复制一份传递到函数中。
引用传递：将实际参数**地址**复制一份传递到函数中。
> 重点在于理解什么是”值传递“。

> 《> [> javascript中所有函数参数都是按值传递](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/weiqinl/p/9497744.html)> 》

## **3.5 其他**

① `let` 在全局环境中声明的变量，存在于 `Scope` 作用域链上的名为 `Script` 的作用域中。

	<script type="text/javascript">
	    let a = 1;
	    console.log(a)
	</script>

> 《> [> 全局作用域中，用const和let声明的变量去哪了？](https://link.zhihu.com/?target=https%3A//juejin.im/post/5c0be11b6fb9a049df23e388)> 》

② `typeof` 运算符在没有 `let` 之前是百分之百安全的，因为即使一个变量没有被声明，结果也只是 `undefined`，而现在若是”提前“访问由 `let` 声明的变量，会出现 `ReferenceError`。

③《高程三》P75页：“至于 `with` 内部，则定义了一个名为 `url` 的变量，因而就成了函数执行环境的一部分，所以可以作为函数的值返回。”
此页内容并不能支撑”因而“这个转折。而其能返回的主要原因在于：
> with 语句块中作用域的”变量对象“是只读的，所以在它本层定义的标识符，不能存储到本层，而是存储到它的上一层作用域。

> 推荐阅读：《> [> javascript：with的用法以及延长作用域链](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/zz334396884/p/4951042.html)> 》

④《 [你不知道的JavaScript](https://link.zhihu.com/?target=https%3A//github.com/getify/You-Dont-Know-JS)》英文开源书籍

⑤《 [理解 ES6](https://link.zhihu.com/?target=https%3A//github.com/nzakas/understandinges6)》英文开源书籍

## **3.6 StackOverflow**

蛮多编程问题在这上面能得到更好的解决。如果访问过慢：[Replace Google CDN](https://link.zhihu.com/?target=https%3A//github.com/justjavac/ReplaceGoogleCDN)：

① 解压之后，选择 chrome / firfox 文件夹进行安装，否则会提示找不到程序清单；
② 可以设置此插件权限，在特定网站上，添加允许的网站；

③ 如果没有替换 CDN，会出现`Stack Overflow requires external JavaScript from another domain, which is blocked or failed to load.`，比如修改个人资料无法 `Save Profile`。

## **4. 最后**

难以相信在学习 `ES6` 的第一章节，花费了整整四天的时间，不过收获蛮多，也算不虚此行。大多都是“底层”的问题，与其他知识的交叉，不单单是 `ES6` 。

尚未解决的问题：
① `VariableEnvironment` 和 `LexicalEnvironment` 的区别；

> 2020.02.27 > [> [译] 理解 JavaScript 中的执行上下文和执行栈](https://link.zhihu.com/?target=https%3A//juejin.im/post/5ba32171f265da0ab719a6d7)>  这篇文章中解释了两者的区别，VariableEnvironment 是变量环境，同样也是词法环境，但只存储 var 的变量绑定，而 LexicalEnvironment 是词法环境，存储 let 和 const 的变量绑定。

② 栈内存是否真的存在？

如果你对文章内容含有任何想法，非常欢迎一起来探讨、赐教。

编辑于 03-12
[ECMAScript 2015](https://www.zhihu.com/topic/19651015)
[前端开发](https://www.zhihu.com/topic/19550901)
[JavaScript](https://www.zhihu.com/topic/19552521)
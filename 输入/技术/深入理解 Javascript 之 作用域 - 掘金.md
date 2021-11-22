深入理解 Javascript 之 作用域 - 掘金

## 深入理解 Javascript 之 作用域

> 所有的编程语言都有一个功能，那就是存储变量中的值。并且在这个变量声明之后可以进行访问和修改，而这个变量存在哪里？如何进行访问？这就需要用到作用域了。 作用域就是变量与函数的可访问范围，即作用域控制着变量与函数的可见性和生命周期。在`JavaScript`> 中，变量的作用域有全局作用域和局部作用域两种，局部作用域又称为函数作用域。

### 一、认识作用域

**全局作用域**

- 情况一： 程序最外层定义的函数或者变量

	var a = "tsrot";
	function hello(){
		alert(a);
	}
	function sayHello(){
		hello();
	}
	alert(a);     //能访问到tsrot
	hello();      //能访问到tsrot
	sayHello();   //能访问到hello函数，然后也能访问到tsrot

	复制代码

- 情况二： 所有末定义直接赋值的变量（不推荐）

	function hello(){
		a = "tsrot";
		var b = "hello tsrot";
	}
	alert(a);  //能访问到tsrot
	alert(b);  //error 不能访问
	复制代码

- 情况三： window对象的属性和方法

一般情况下，window对象的内置属性都拥有全局作用域，[例如window.name](http://xn--window-9v9ii49d.name/)、window.location、window.top等等。

**局部作用域（函数作用域）**

	// 局部作用域在函数内创建，在函数内可访问，函数外不可访问。

	function hello(){
		var a = "tsrot";
		alert(a);
	}
	hello(); //函数内可访问到tsrot
	alert(a); //error not defined

	复制代码

### 二、作用域链

了解作用域链之前我们要知道一下几个概念：

	- 变量和函数的声明
	- 函数的生命周期
	- Activetion Object（AO）、Variable Object（VO）

	复制代码

**(1) 变量的声明**
> 在js引擎处理代码的时候，首先要把变量和函数的声明提前进行预解析。然后再去执行别的代码。至于具体如何进行预处理的，我们之后进行深入学习。
变量声明：变量的声明只有一种方式，那就是用var关键字声明，直接赋值不是一种声明方式。这仅仅是在全局对象上创建了新的属性（而不是变量）。它们有一下区别：

- （1）因为它只是一种赋值，所以不会声明提前

	alert(a); // undefined
	alert(b); // error "b" is not defined
	b = 10; // 这里不会提前
	var a = 20;
	复制代码

- （2）直接赋值形式是在执行阶段创建

	alert(a); // undefined, 这个大家都知道
	b = 10;
	alert(b); // 10, 代码执行阶段创建

	var a = 20;
	alert(a); // 20, 代码执行阶段修改
	复制代码

- （3）变量不能删除（delete），属性可以删除

	a = 10;
	alert(window.a); // 10

	alert(delete a); // true

	alert(window.a); // undefined

	var b = 20;
	alert(window.b); // 20

	alert(delete b); // false

	alert(window.b); // 仍然为 20，因为变量是不能够删除的。

	复制代码

**(2) 函数声明：函数的声明有三种方式**

- （1）function name( ){ }直接创建方式

	function add(a,b){
		return a+b;
	}
	add(5,4);
	复制代码

- （2）new Funtion构建函数创建

	var add=new Function("a", "b", "return a+b;");
	add(4,5);
	复制代码

- （3）给变量赋值匿名函数方法创建

	var add = function(a,b){
		return a+b;
	}
	add(4,5);
	复制代码

后面两种方法，在声明前访问时，返回的都是一个undefined的变量。当然，在声明后访问它们都是一个function的函数。
> 注意：如果变量名和函数名声明时相同，函数优先声明。

	alert(x); // function
	var x = 10;
	alert(x); // 10

	x = 20;
	function x() {};

	alert(x); // 20
	复制代码

**(3) 函数的生命周期**

- 在函数创建阶段，JS解析引擎进行预解析，会将函数声明提前，同时将该函数放到全局作用域中或当前函数的上一级函数的局部作用域中。
- 在函数执行阶段，JS引擎会将当前函数的局部变量和内部函数进行声明提前，然后再执行业务代码，当函数执行完退出时，释放该函数的执行上下文，并注销该函数的局部变量。

**(4) 什么是AO、VO**

为了表示不同的运行环境，JavaScript中有一个执行上下文（Execution context，EC）的概念。也就是说，当JavaScript代码执行的时候，会进入不同的执行上下文，这些执行上下文就构成了一个执行上下文栈（Execution context stack，ECS）。

	var a = "global var";

	function foo(){
	    console.log(a);
	}

	function outerFunc(){
	    var b = "var in outerFunc";
	    console.log(b);

	    function innerFunc(){
	        var c = "var in innerFunc";
	        console.log(c);
	        foo();
	    }

	    innerFunc();
	}

	outerFunc()
	复制代码

代码首先进入Global Execution Context，然后依次进入outerFunc，innerFunc和foo的执行上下文，执行上下文栈就可以表示为：

[1](../_resources/c243410bba17a7fbbae55154aab7352d.webp)

对于每个`Execution Context`都有三个重要的属性，`变量对象（Variable object，VO）`，`作用域链（Scope chain）`和`this`。这三个属性跟代码运行的行为有很重要的关系，下面会一一介绍。

**变量对象（Variable object）**
变量对象是与执行上下文相关的数据作用域。它是一个与上下文相关的特殊对象，其中存储了在上下文中定义的变量和函数声明。也就是说，一般VO中会包含以下信息：

	变量 (var, Variable Declaration);
	函数声明 (Function Declaration, FD);
	函数的形参
	复制代码
	VO = {
	    a: 'global var',
	    foo: <function>
	    outerFunc: <function>
	}
	复制代码

注意，假如上面的例子代码中有下面两个语句，Global VO仍将不变

	(function bar(){}) // function expression, FE
	baz = "property of global object"
	复制代码

也就是说，对于`VO`，是有下面两种特殊情况的：

	函数表达式（与函数声明相对）不包含在VO之中
	没有使用var声明的变量（这种变量是，"全局"的声明方式，只是给Global添加了一个属性，并不在VO中）
	复制代码

**活动对象（Activation object)**

> 只有全局上下文的变量对象允许通过VO的属性名称间接访问；在函数执行上下文中，VO是不能直接访问的，此时由激活对象(Activation Object,缩写为AO)扮演VO的角色。激活对象 是在进入函数上下文时刻被创建的，它通过函数的arguments属性初始化。

**对于VO和AO的关系可以理解为，VO在不同的Execution Context中会有不同的表现：当在Global Execution Context中，可以直接使用VO；但是，在函数Execution Context中，AO就会被创建。**

[1](../_resources/23b699e91a9c15788e80180611f68e4e.webp)

当上面的例子开始执行outerFunc的时候，就会有一个outerFunc的AO被创建：

[1](../_resources/55a75d9663925dcd537d37c3054e20ce.webp)

	AO = {
	    arguments: {},
	    b : 'var in outerFunc',
	    innerFunc: <function>
	}
	复制代码

**(5) 细看Execution Context**
当一段JavaScript代码执行的时候，JavaScript解释器会创建Execution Context，其实这里会有两个阶段：

- 创建阶段（当函数被调用，但是开始执行函数内部代码之前）
    - 创建Scope chain
    - 创建VO/AO（variables, functions and arguments）
    - 设置this的值
- 激活/代码执行阶段
    - 设置变量的值、函数的引用，然后解释/执行代码

	function foo(i) {
	    var a = 'hello';
	    var b = function privateB() {

	    };
	    function c() {

	    }
	}

	foo(22);
	复制代码

对于上面的代码，在"创建阶段"，可以得到下面的Execution Context object：

	fooExecutionContext = {
	    scopeChain: { ... }, // 作用域链
	    variableObject: {
	        arguments: {
	            0: 22,
	            length: 1
	        },
	        i: 22,
	        c: pointer to function c()
	        a: undefined,
	        b: undefined
	    },
	    this: { ... } // this指向
	}
	复制代码

在"激活/代码执行阶段"，Execution Context object就被更新为：

	fooExecutionContext = {
	    scopeChain: { ... },
	    variableObject: {
	        arguments: {
	            0: 22,
	            length: 1
	        },
	        i: 22,
	        c: pointer to function c()
	        a: 'hello',
	        b: pointer to function privateB()
	    },
	    this: { ... }
	}
	复制代码

* * *

> 案例分析：
**案例一**

	(function(){
	    console.log(bar);
	    console.log(baz);

	    var bar = 20;

	    function baz(){
	        console.log("baz");
	    }

	})()
	复制代码

因为是匿名函数且处于全局，函数预处理阶段只是将函数的作用域提到了全局，在函数的执行阶段，首先进行变量、函数的提升，此时在执行上下文中的AO对象如下，然后再执行业务代码。

[1](../_resources/a026e38699039a50fd6d198595e68a6e.webp)

最后执行结果如下：

[1](../_resources/159b0169513b6370173503b0b49004ce.webp)

**案例2**

	(function(){
	    console.log(bar); // VM60:2 Uncaught ReferenceError: bar is not defined
	    console.log(baz); // function baz

	    bar = 20;
	    console.log(window.bar);  // 20
	    console.log(bar);   // 20

	    function baz(){
	        console.log("baz");
	    }

	})()
	复制代码

运行这段代码会得到`"bar is not defined(…)"`错误。当代码执行到`"console.log(bar);"`的时候，会去AO中查找`"bar"`。但是，根据前面的解释，函数中的`"bar"`并没有通过`var`关键字声明，所有`不会被存放在AO中`，也就有了这个错误。

[1](../_resources/2c52c055ae9ea4a3823cbced3cbad3d0.webp)

**案例3**

	(function(){
	    console.log(foo); // undefined
	    console.log(bar); // function
	    console.log(baz); // function

	    var foo = function(){};

	    function bar(){
	        console.log("bar");
	    }

	    var bar = 20;
	    console.log(bar);  // 20

	    function baz(){
	        console.log("baz");
	    }

	})()

	AO = {
	    arguments: {},
	    foo: undefined,
	    bar: <function>,
	    baz: <function>
	}
	复制代码

代码中，最"奇怪"的地方应该就是"bar"的输出了，第一次是一个函数，第二次是"20"。

其实也很好解释，回到前面对"创建VO/AO"的介绍，在创建VO/AO过程中，解释器会先扫描函数声明，然后"foo: "就被保存在了AO中；但解释器扫描变量声明的时候，虽然发现"var bar = 20;"，但是因为"foo"在AO中已经存在，所以就没有任何操作了。

但是，当代码执行到第二句"console.log(bar);"的时候，"激活/代码执行阶段"已经把AO中的"bar"重新设置了

[1](../_resources/da72d5d0b54b557ea1a18da614176a57.webp)

**(5) JavaScript作用域链**

当代码在一个环境中执行时，会创建变量对象的一个作用域链（scope chain）来保证对执行环境有权访问的变量和函数的有序访问。作用域第一个对象始终是当前执行代码所在环境的变量对象（VO）。

	function add(a,b){
		var sum = a + b;
		return sum;
	}
	复制代码

假设函数是在全局作用域中创建的，在函数a创建的时候，它的作用域链填入全局对象,全局对象中有所有全局变量，此时的全局变量就是VO。此时的作用域链就是：

		scope(add) -> Global Object(VO)

		VO = {
			this : window,
			add : <reference to function>
		}
	复制代码

如果是函数执行阶段，那么将其activation object（AO）作为作用域链第一个对象，第二个对象是上级函数的执行上下文AO，下一个对象依次类推。

	add(4,5);
	复制代码

例如，调用add后的作用域链是：

	此时作用域链（Scope Chain）有两级，第一级为AO，然后Global Object（VO）
		scope(add) -> AO -> VO
		AO = {
			this : window,
			arguments : [4,5],
			a : 4,
			b : 5,
			sum : undefined
		}

		VO = {
			this : window,
			add : <reference to function>
		}
	复制代码

在函数运行过程中标识符的解析是沿着作用域链一级一级搜索的过程，从第一个对象开始，逐级向后回溯，直到找到同名标识符为止，找到后不再继续遍历，找不到就报错。
看过上面的内容后，可能还有人不懂，我再通熟易懂的解释一遍，先举个例子：

	var x = 10;

	function foo() {
	    var y = 20;

	    function bar() {
	        var z = 30;

	        console.log(x + y + z);
	    };

	    bar()
	};

	foo();

	复制代码

上面代码的输出结果为”60″，函数bar可以直接访问”z”，然后通过作用域链访问上层的”x”和”y”。此时的作用域链为：

	js此时作用域链（Scope Chain）有三级，第一级为bar AO，第二级为foo AO,然后Global Object（VO）
		scope -> bar.AO -> foo.AO -> Global Object
		bar.AO = {
			z : 30,
			__parent__ : foo.AO
		}
		foo.AO = {
			y : 20,
			bar : <reference to function>,
			__parent__ : <Global Object>
		}

		Global Object = {
			x : 10,
			foo : <reference to function>,
			__parent__ : null
		}
	复制代码

### 三、刨析整个解析过程

[深入理解 Javascript 之 作用域](https://segmentfault.com/a/1190000015940175)

### 四、面试题

第一题：

	console.log(a());// 2
	var a = function b(){
	    console.log(1);
	}
	console.log(a());// 1
	function a(){
	    console.log(2);
	}
	console.log(a());// 1
	console.log(b());// reference error
	复制代码

复制代码代码编译后，变量提升，函数优先，赋值语句中b为右值，非变量声明，所以代码等价于
第三题：

	"use strict";
	function test() {
	    console.log(a);// undefined
	    console.log(b);// reference error
	    console.log(c);// reference error
	    var a = b =1;// 直接抛出语法错误
	    let c = 1;
	}
	test();
	console.log(b);// reference error
	console.log(a);// reference
	error

	复制代码

复制代码进入严格模式后，b=1这种语法会直接出错，不会变成全局变量
第四题：4.1题

	for(var i=0;i<5;i++){
	  setTimeout(function(){console.log(i)},0); // 5 5 5 5 5
	}

	复制代码

复制代码i 依附函数作用域，执行过程只有一个i，而setTimeout是异步函数，需要等栈中的代码执行完后再执行，此时i已经变为5
4.2题

	for(let i=0;i<5;i++){
	  setTimeout(function(){console.log(i)},0); // 1 2  3  4
	}

	复制代码

复制代码let 依附for的块级作用域，代码等价于

	for(let i=0;i<5;i++){
	  let j = i;
	  setTimeout(function(){console.log(j)},0); // 1 2  3  4
	}

	复制代码

复制代码可以看出每次循环都产生一个新的内存单元，异步函数执行时，取到的值为当时保持的快照值。
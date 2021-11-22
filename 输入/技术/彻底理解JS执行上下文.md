彻底理解JS执行上下文

[(L)](https://juejin.im/user/2805609402996862)


2020年04月27日   阅读 431

# 彻底理解JS执行上下文

# 概念

执行上下文：就是当前JS代码被解析和执行时所在的环境的抽象概念，JS中运行任何的代码都是在执行上下文中运行

# 执行上下文类型

1. 全局执行上下文：这是最默认的，最基础的执行上下文。不在任何函数中的代码都是位于全局执行上下文中，做了两件事，一个是创建全局对象（window），第二个就是将this指针指向这个全局对象，一个程序中只能存在一个全局执行上下文

2. 函数执行上下文：函数被调用的时候被创建，每次调用函数都会创建一个新的执行上下文
3. Eval函数执行上下文：指的是运行在 eval 函数中的代码，现在已经很少使用了，而且不推荐使用

# 执行栈

当JS引擎读取代码时，它会创建一个全局执行上下文并将其推入当前的执行栈，每当发生一个函数调用，引擎都会为该函数创建一个新的执行上下文，并将其推到当前执行的顶端，引擎会运行执行栈顶端的函数，当函数运行完成后，执行pop操作，运行下一个执行上下文

# 执行上下文是如何被创建的（ES6）

- 创建阶段
- 执行阶段

## 创建阶段

1. 确定this的值，绑定this，（ThisBinding）
2. 词法环境（LexicalEnvironment）被创建
3. 变量环境（VariableEnvironment）被创建
概念表示
```
	jsExecutionContext = {
	  ThisBinding = <this value>,
	  LexicalEnvironment = { ... },
	  VariableEnvironment = { ... },
	}

```
ThisBinding

- 全局执行上下文中，this指向全局对象，在浏览器中指向window对象
- 函数执行上下文中，this的指向取决于函数的调用方式

词法环境（LexicalEnvironment）

> 词法环境是一种规范类型，基于 ECMAScript 代码的词法嵌套结构来定义标识符与特定变量和函数的关联关系。词法环境由环境记录（environment record）和可能为空引用（null）的外部词法环境组成。

词法环境就是一个包含标识符变量映射的结构（这里的标识符表示变量/函数的名称，变量是对实际对象【包括函数类型对象】或原始值的引用）
在词法环境中，有两个组成部分：（1）环境记录（2）对外部环境的引用
1. 环境记录是存储变量和函数声明的实际位置
2. 对外部环境的引用意味着它可以访问外部词法环境
词法环境有两种类型：

- 全局环境，全局环境对外部的环境引用为null。拥有一个全局对象（window对象）及其关联的方法和属性，以及任何用户自定义的全局变量
- 函数环境，用户在函数中定义的变量被存储在环境记录中。对外部的环境引用可以是全局环境，也可以是包含内部函数的外部函数环境

对于函数环境来说，环境记录包含了一个`arguments`对象，该对象包含了索引和传递给函数的参数之间的映射，以及传递给函数的参数的长度
```
	jsfunction foo(a, b) {
	  var c = a + b;
	}
	foo(2, 3);

	// arguments 对象
	Arguments: {0: 2, 1: 3, length: 2},


```
对于环境记录，也有两种类型

- 声明性环境记录：存储变量、函数和参数（主要用于函数、catch词法环境）
- 对象环境记录：用于定义在全局执行上下文中出现的变量和函数的关联，全局环境包含对象环境记录（主要用于全局的词法环境）

伪代码
```
	jsGlobalExectionContext = {
	  LexicalEnvironment: {
	    EnvironmentRecord: {
	      // 对象环境记录
	      Type: "Object",
	      // 对外部环境的引用
	      outer: <null>
	  }
	}

	FunctionExectionContext = {
	  LexicalEnvironment: {
	    EnvironmentRecord: {
	      // 环境记录分类： 声明环境记录
	      Type: "Declarative",
	      // 对外部环境的引用
	      outer: <Global or outer function environment reference>
	  }
	}
```


变量环境（VariableEnvironment）

变量环境也是一个词法环境，因此它具有上面定义的词法环境的所有属性，在 ES6 中，LexicalEnvironment 组件和 VariableEnvironment 组件的区别在于前者用于存储函数声明和变量（ let 和 const ）绑定，而后者仅用于存储变量（ var ）绑定。
```
	jslet a = 20;
	const b = 30;
	var c;

	function multiply(e, f) {
	 var g = 20;
	 return e * f * g;
	}

	c = multiply(20, 30);

	// 执行上下文环境如下
	GlobalExectionContext = {

	  ThisBinding: <Global Object>,

	  LexicalEnvironment: {
	    EnvironmentRecord: {
	      // 对象环境记录
	      Type: "Object",
	      a: < uninitialized >,
	      b: < uninitialized >,
	      multiply: < func >
	    }
	    outer: <null>
	  },

	  VariableEnvironment: {
	    EnvironmentRecord: {
	      // 对象环境记录
	      Type: "Object",
	      c: undefined,
	    }
	    outer: <null>
	  }
	}

	FunctionExectionContext = {

	  ThisBinding: <Global Object>,

	  LexicalEnvironment: {
	    EnvironmentRecord: {
	      // 环境记录分类： 声明环境记录
	      Type: "Declarative",
	      Arguments: {0: 20, 1: 30, length: 2},
	    },
	    outer: <GlobalLexicalEnvironment GlobalVariableEnvironment>
	  },

	  VariableEnvironment: {
	    EnvironmentRecord: {
	      // 环境记录分类： 声明环境记录
	      Type: "Declarative",
	      g: undefined
	    },
	    outer: <GlobalLexicalEnvironment GlobalVariableEnvironment>
	  }
	}
```

可以看到，在创建阶段，let和const是处于一种`没有值`的状态，而var则已经被赋值`undefined`
这是因为在创建阶段，代码会被扫描并解析变量和函数声明，其中函数声明存储在环境中，而变量会被设置为`undefined`，或者未初始化
这就是变量提升的意义

## 执行阶段

在执行阶段完成对变量的分配，最后执行代码
在执行阶段，如果 Javascript 引擎在源代码中声明的实际位置找不到 let 变量的值，那么将为其分配 undefined 值。

# 换个角度看执行上下文（ES3）

词法环境和变量环境都是ES6的新规范，我们可以换个角度解释执行上下文，也就是从ES3的规范来理解执行上下文
每个执行上下文中，有三个重要的属性

- this
- 变量对象（VO），包含变量、函数声明、和函数的形参
- 作用域链

## VO和AO

VO 和 AO 是ES3规范中的概念，我们知道在创建过程的第二个阶段会创建变量对象，也就是VO，它是用来存放执行环境中可被访问但是不能被 delete 的函数标识符，形参，变量声明等，这个对象在js环境下是不可访问的。而AO 和VO之间区别就是AO 是一个激活的VO，仅此而已

- 变量对象（Variable object）JS的执行上下文中都有个对象用来存放执行上下文中可被访问但是不能被delete的函数标示符、形参、变量声明等。它们会被挂在这个对象上，这个对象是规范上或者说是引擎实现上的不可在JS环境中访问到活动对象
- 激活对象（Activation object）有了变量对象后，什么时候能被访问到呢？就是每进入一个执行上下文时，这个执行上下文中的变量对象就被激活，也就是该上下文中的函数标示符、形参、变量声明等就可以被访问到了

VO的创建步骤
1. 创建arguments对象
2. 扫描上下文的函数声明,为每一个扫描到的函数声明在VO上创建一个属性,指向函数的引用,如果函数已经存在,引用指针会被重写（函数提升）
3. 扫描上下文的变量声明,在VO上创建对应的属性，并将变量的值初始化为undefined，如果变量的名字在VO上已经存在，将不会进行任何操作并继续扫描
举例
```
	jsfunction foo(i) {
	    var a = 'hello';
	    var b = function privateB() {

	    };
	    function c() {

	    }
	}

	foo(22);
```

上面的内容的执行伪代码
```
	js// 创建阶段
	fooExecutionContext = {
	    scopeChain: { ... },
	    variableObject: {
	        arguments: {
	            0: 22,
	            length: 1
	        },
	        i: 22,
	        c: pointer to function c(),
	        a: undefined,
	        b: undefined
	    },
	    this: { ... }
	}
	// 激活阶段
	fooExecutionContext = {
	    scopeChain: { ... },
	    variableObject: {
	        arguments: {
	            0: 22,
	            length: 1
	        },
	        i: 22,
	        c: pointer to function c(),
	        a: 'hello',
	        b: pointer to function privateB()
	    },
	    this: { ... }
	}
```

ES3的VO，AO到ES6的词法环境,变量环境更换的意义

- 一是在创建过程中所执行的创建作用域链和创建变量对象(VO)都可以在创建词法环境的过程中完成。
- 二是针对es6中存储函数声明和变量(let 和 const)以及存储变量(var)的绑定，可以通过两个不同的过程(词法环境，变量环境)区分开来。

## 作用域链

这里的作用域链的概念，在词法环境中，就是`对外部环境的引用`这个属性的实现，js中正是因为有着作用域链，才实现了跨作用域的变量访问，也就是【闭包】的概念
```
	jsfunction one() {

	    var a = 1;
	    two();

	    function two() {

	        var b = 2;
	        three();

	        function three() {
	            var c = 3;
	            alert(a + b + c); // 6
	        }
	    }
	}

	one();
```

当执行到函数three的时候，变量a、b都不在当前函数的执行上下文中，这个时候就会顺着作用域链去寻找变量，直至在某个执行上下文中找到，最终的终点是全局执行上下文，可以把它理解成包含自身变量对象和上级变量对象的列表，通过 [[Scope]] 属性查找上级变量

上面的作用域链的伪代码
```
	js[[Scope Chain]] = [[three() VO] + [Two() VO] + [One() VO] + [Global VO]]
```

换一种表述
```
	jsvar a = 10
	function foo(i) {
	  var b = 20
	}
	foo()
```

作用域链伪代码
```
	jsfooContext.[[Scope]] = [
	    globalContext.VO
	]

	fooContext.Scope = fooContext.[[Scope]] + fooContext.VO

	fooContext.Scope = [
	    fooContext.VO,
	    globalContext.VO
	]
```

# 暂时性死区（TDZ）

在上面关于执行上下文的「词法环境」的举例中可以看到，let声明的变量，在执行上下文的「创建阶段」是一种「没有值」的状态，而var声明的变量，则已经是「undefined」了，如果在这个阶段访问var声明的变量，会正常得到undefined，但是访问let声明的变量，则会报错`ReferenceError: variable is not defined`，这个阶段就是`暂时性死区`

细化JS引擎解析变量的阶段

- 声明阶段（在作用域中注册变量名）
- 初始化阶段（分配内存，给作用域中的变量创建绑定，变量会被赋值undefined）
- 赋值阶段

var会直接完成「声明阶段」和「初始化阶段」 函数会直接完成全部阶段，所以这也是函数提升和变量提升的原因，同时函数的提升也是最高级的
let则不会一并完成几个阶段，所以如果通过了声明阶段，这个时候访问let声明的变量，就会报错，此时就是处于`暂时性死区`
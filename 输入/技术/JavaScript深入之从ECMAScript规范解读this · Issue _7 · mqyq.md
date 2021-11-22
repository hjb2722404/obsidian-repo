JavaScript深入之从ECMAScript规范解读this · Issue #7 · mqyqingfeng/Blog

New issue

#    JavaScript深入之从ECMAScript规范解读this   #7

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='16' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true' data-evernote-id='26'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='1397' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [mqyqingfeng](https://github.com/mqyqingfeng) opened this issueon 25 Apr 2017· 236 comments

## Comments

 [![11458263](../_resources/340ec8d3a19409bdd3755a108adba3f2.jpg)](https://github.com/mqyqingfeng)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='28'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='1434' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

  Owner This user is the owner of the Blog repository.

###   **  [mqyqingfeng](https://github.com/mqyqingfeng)  ** commented [on 25 Apr 2017](https://github.com/mqyqingfeng/Blog/issues/7#issue-223998815)    •

  edited   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-triangle-down v-align-middle js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='29'%3e%3cpath d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z' data-evernote-id='1445' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

## 前言

在《JavaScript深入之执行上下文栈》中讲到，当JavaScript代码执行一段可执行代码(executable code)时，会创建对应的执行上下文(execution context)。

对于每个执行上下文，都有三个重要属性

- 变量对象(Variable object，VO)
- 作用域链(Scope chain)
- this

今天重点讲讲 this，然而不好讲。
……
因为我们要从 ECMASciript5 规范开始讲起。
先奉上 ECMAScript 5.1 规范地址：
英文版：http://es5.github.io/#x15.1
中文版：http://yanhaijing.com/es5/#115
让我们开始了解规范吧！

## Types

首先是第 8 章 Types：

> Types are further subclassified into ECMAScript language types and specification types.

> An ECMAScript language type corresponds to values that are directly manipulated by an ECMAScript programmer using the ECMAScript language. The ECMAScript language types are Undefined, Null, Boolean, String, Number, and Object.

> A specification type corresponds to meta-values that are used within algorithms to describe the semantics of ECMAScript language constructs and ECMAScript language types. The specification types are Reference, List, Completion, Property Descriptor, Property Identifier, Lexical Environment, and Environment Record.

我们简单的翻译一下：
ECMAScript 的类型分为语言类型和规范类型。

ECMAScript 语言类型是开发者直接使用 ECMAScript 可以操作的。其实就是我们常说的Undefined, Null, Boolean, String, Number, 和 Object。

而规范类型相当于 meta-values，是用来用算法描述 ECMAScript 语言结构和 ECMAScript 语言类型的。规范类型包括：Reference, List, Completion, Property Descriptor, Property Identifier, Lexical Environment, 和 Environment Record。

没懂？没关系，我们只要知道在 ECMAScript 规范中还有一种只存在于规范中的类型，它们的作用是用来描述语言底层行为逻辑。
今天我们要讲的重点是便是其中的 Reference 类型。它与 this 的指向有着密切的关联。

## Reference

那什么又是 Reference ？
让我们看 8.7 章 The Reference Specification Type：

> The Reference type is used to explain the behaviour of such operators as delete, typeof, and the assignment operators.

所以 Reference 类型就是用来解释诸如 delete、typeof 以及赋值等操作行为的。
抄袭尤雨溪大大的话，就是：

> 这里的 Reference 是一个 Specification Type，也就是 “只存在于规范里的抽象类型”。它们是为了更好地描述语言的底层行为逻辑才存在的，但并不存在于实际的 js 代码中。

再看接下来的这段具体介绍 Reference 的内容：
> A Reference is a resolved name binding.

> A Reference consists of three components, the base value, the referenced name and the Boolean valued strict reference flag.

> The base value is either undefined, an Object, a Boolean, a String, a Number, or an environment record (10.2.1).

> A base value of undefined indicates that the reference could not be resolved to a binding. The referenced name is a String.

这段讲述了 Reference 的构成，由三个组成部分，分别是：

- base value
- referenced name
- strict reference

可是这些到底是什么呢？
我们简单的理解的话：

base value 就是属性所在的对象或者就是 EnvironmentRecord，它的值只可能是 undefined, an Object, a Boolean, a String, a Number, or an environment record 其中的一种。

referenced name 就是属性的名称。
举个例子：

var  foo  =  1;// 对应的Reference是：var  fooReference  =  {  base: EnvironmentRecord,  name: 'foo',  strict: false};

再举个例子：

var  foo  =  {  bar: function  ()  {  return  this;  }};  foo.bar();  // foo// bar对应的Reference是：var  BarReference  =  {  base: foo,  propertyName: 'bar',  strict: false};

而且规范中还提供了获取 Reference 组成部分的方法，比如 GetBase 和 IsPropertyReference。
这两个方法很简单，简单看一看：
1.GetBase
> GetBase(V). Returns the base value component of the reference V.
返回 reference 的 base value。
2.IsPropertyReference

> IsPropertyReference(V). Returns true if either the base value is an object or HasPrimitiveBase(V) is true; otherwise returns false.

简单的理解：如果 base value 是一个对象，就返回true。

## GetValue

除此之外，紧接着在 8.7.1 章规范中就讲了一个用于从 Reference 类型获取对应值的方法： GetValue。
简单模拟 GetValue 的使用：

var  foo  =  1;var  fooReference  =  {  base: EnvironmentRecord,  name: 'foo',  strict: false};GetValue(fooReference)  // 1;

GetValue 返回对象属性真正的值，但是要注意：
**调用 GetValue，返回的将是具体的值，而不再是一个 Reference**
这个很重要，这个很重要，这个很重要。

## 如何确定this的值

关于 Reference 讲了那么多，为什么要讲 Reference 呢？到底 Reference 跟本文的主题 this 有哪些关联呢？如果你能耐心看完之前的内容，以下开始进入高能阶段：

看规范 11.2.3 Function Calls：
这里讲了当函数调用的时候，如何确定 this 的取值。
只看第一步、第六步、第七步：
> 1.Let *> ref*>  be the result of evaluating MemberExpression.
> 6.If Type(*> ref*> ) is Reference, then
[object Object]
[object Object]
[object Object]
[object Object]
> 7.Else, Type(*> ref*> ) is not Reference.
[object Object]
让我们描述一下：
1.计算 MemberExpression 的结果赋值给 ref
2.判断 ref 是不是一个 Reference 类型
[object Object]

## 具体分析

让我们一步一步看：
1. 计算 MemberExpression 的结果赋值给 ref
什么是 MemberExpression？看规范 11.2 Left-Hand-Side Expressions：
MemberExpression :

- PrimaryExpression // 原始表达式 可以参见《JavaScript权威指南第四章》
- FunctionExpression // 函数定义表达式
- MemberExpression [ Expression ] // 属性访问表达式
- MemberExpression . IdentifierName // 属性访问表达式
- new MemberExpression Arguments // 对象创建表达式

举个例子：

function  foo()  {  console.log(this)}foo();  // MemberExpression 是 foofunction  foo()  {  return  function()  {  console.log(this)  }}foo()();  // MemberExpression 是 foo()var  foo  =  {  bar: function  ()  {  return  this;  }}foo.bar();  // MemberExpression 是 foo.bar

所以简单理解 MemberExpression 其实就是()左边的部分。
2.判断 ref 是不是一个 Reference 类型。
关键就在于看规范是如何处理各种 MemberExpression，返回的结果是不是一个Reference类型。
举最后一个例子：

var  value  =  1;var  foo  =  {  value: 2,  bar: function  ()  {  return  this.value;  }}//示例1console.log(foo.bar());//示例2console.log((foo.bar)());//示例3console.log((foo.bar  =  foo.bar)());//示例4console.log((false  ||  foo.bar)());//示例5console.log((foo.bar,  foo.bar)());

### foo.bar()

在示例 1 中，MemberExpression 计算的结果是 foo.bar，那么 foo.bar 是不是一个 Reference 呢？
查看规范 11.2.1 Property Accessors，这里展示了一个计算的过程，什么都不管了，就看最后一步：

> Return a value of type Reference whose base value is baseValue and whose referenced name is propertyNameString, and whose strict mode flag is strict.

我们得知该表达式返回了一个 Reference 类型！
根据之前的内容，我们知道该值为：
var  Reference  =  {  base: foo,  name: 'bar',  strict: false};
接下来按照 2.1 的判断流程走：

> 2.1 如果 ref 是 Reference，并且 IsPropertyReference(ref) 是 true, 那么 this 的值为 GetBase(ref)

该值是 Reference 类型，那么 IsPropertyReference(ref) 的结果是多少呢？
前面我们已经铺垫了 IsPropertyReference 方法，如果 base value 是一个对象，结果返回 true。
base value 为 foo，是一个对象，所以 IsPropertyReference(ref) 结果为 true。
这个时候我们就可以确定 this 的值了：
this  =  GetBase(ref)，
GetBase 也已经铺垫了，获得 base value 值，这个例子中就是foo，所以 this 的值就是 foo ，示例1的结果就是 2！
唉呀妈呀，为了证明 this 指向foo，真是累死我了！但是知道了原理，剩下的就更快了。

### (foo.bar)()

看示例2：
console.log((foo.bar)());
foo.bar 被 () 包住，查看规范 11.1.6 The Grouping Operator
直接看结果部分：
> Return the result of evaluating Expression. This may be of type Reference.

> NOTE This algorithm does not apply GetValue to the result of evaluating Expression.

实际上 () 并没有对 MemberExpression 进行计算，所以其实跟示例 1 的结果是一样的。

### (foo.bar = foo.bar)()

看示例3，有赋值操作符，查看规范 11.13.1 Simple Assignment ( = ):
计算的第三步：
> 3.Let rval be GetValue(rref).
因为使用了 GetValue，所以返回的值不是 Reference 类型，
按照之前讲的判断逻辑：
> 2.3 如果 ref 不是Reference，那么 this 的值为 undefined
this 为 undefined，非严格模式下，this 的值为 undefined 的时候，其值会被隐式转换为全局对象。

### (false || foo.bar)()

看示例4，逻辑与算法，查看规范 11.11 Binary Logical Operators：
计算第二步：
> 2.Let lval be GetValue(lref).
因为使用了 GetValue，所以返回的不是 Reference 类型，this 为 undefined

### (foo.bar, foo.bar)()

看示例5，逗号操作符，查看规范11.14 Comma Operator ( , )
计算第二步：
> 2.Call GetValue(lref).
因为使用了 GetValue，所以返回的不是 Reference 类型，this 为 undefined

### 揭晓结果

所以最后一个例子的结果是：

var  value  =  1;var  foo  =  {  value: 2,  bar: function  ()  {  return  this.value;  }}//示例1console.log(foo.bar());  // 2//示例2console.log((foo.bar)());  // 2//示例3console.log((foo.bar  =  foo.bar)());  // 1//示例4console.log((false  ||  foo.bar)());  // 1//示例5console.log((foo.bar,  foo.bar)());  // 1

注意：以上是在非严格模式下的结果，严格模式下因为 this 返回 undefined，所以示例 3 会报错。

### 补充

最最后，忘记了一个最最普通的情况：
function  foo()  {  console.log(this)}foo();

MemberExpression 是 foo，解析标识符，查看规范 10.3.1 Identifier Resolution，会返回一个 Reference 类型的值：

var  fooReference  =  {  base: EnvironmentRecord,  name: 'foo',  strict: false};

接下来进行判断：

> 2.1 如果 ref 是 Reference，并且 IsPropertyReference(ref) 是 true, 那么 this 的值为 GetBase(ref)

因为 base value 是 EnvironmentRecord，并不是一个 Object 类型，还记得前面讲过的 base value 的取值可能吗？ 只可能是 undefined, an Object, a Boolean, a String, a Number, 和 an environment record 中的一种。

IsPropertyReference(ref) 的结果为 false，进入下个判断：

> 2.2 如果 ref 是 Reference，并且 base value 值是 Environment Record, 那么this的值为 ImplicitThisValue(ref)

base value 正是 Environment Record，所以会调用 ImplicitThisValue(ref)
查看规范 10.2.1.1.6，ImplicitThisValue 方法的介绍：该函数始终返回 undefined。
所以最后 this 的值就是 undefined。

## 多说一句

尽管我们可以简单的理解 this 为调用函数的对象，如果是这样的话，如何解释下面这个例子呢？

var  value  =  1;var  foo  =  {  value: 2,  bar: function  ()  {  return  this.value;  }}console.log((false  ||  foo.bar)());  // 1

此外，又如何确定调用函数的对象是谁呢？在写文章之初，我就面临着这些问题，最后还是放弃从多个情形下给大家讲解 this 指向的思路，而是追根溯源的从 ECMASciript 规范讲解 this 的指向，尽管从这个角度写起来和读起来都比较吃力，但是一旦多读几遍，明白原理，绝对会给你一个全新的视角看待 this 。而你也就能明白，尽管 foo() 和 (foo.bar = foo.bar)() 最后结果都指向了 undefined，但是两者从规范的角度上却有着本质的区别。

此篇讲解执行上下文的 this，即便不是很理解此篇的内容，依然不影响大家了解执行上下文这个主题下其他的内容。所以，依然可以安心的看下一篇文章。

## 下一篇文章

[《JavaScript深入之执行上下文》](https://github.com/mqyqingfeng/Blog/issues/8)

## 深入系列

JavaScript深入系列目录地址：https://github.com/mqyqingfeng/Blog。

JavaScript深入系列预计写十五篇左右，旨在帮大家捋顺JavaScript底层知识，重点讲解如原型、作用域、执行上下文、变量对象、this、闭包、按值传递、call、apply、bind、new、继承等难点概念。

如果有错误或者不严谨的地方，请务必给予指正，十分感谢。如果喜欢或者有所启发，欢迎star，对作者也是一种鼓励。

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-tag js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='30'%3e%3cpath fill-rule='evenodd' d='M2.5 7.775V2.75a.25.25 0 01.25-.25h5.025a.25.25 0 01.177.073l6.25 6.25a.25.25 0 010 .354l-5.025 5.025a.25.25 0 01-.354 0l-6.25-6.25a.25.25 0 01-.073-.177zm-1.5 0V2.75C1 1.784 1.784 1 2.75 1h5.025c.464 0 .91.184 1.238.513l6.25 6.25a1.75 1.75 0 010 2.474l-5.026 5.026a1.75 1.75 0 01-2.474 0l-6.25-6.25A1.75 1.75 0 011 7.775zM6 5a1 1 0 100 2 1 1 0 000-2z' data-evernote-id='2121' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![11458263](../_resources/544b0e374410510d6c272b86a1ed6bcd.jpg)](https://github.com/mqyqingfeng)[mqyqingfeng](https://github.com/mqyqingfeng) added the   [深入系列](https://github.com/mqyqingfeng/Blog/labels/%E6%B7%B1%E5%85%A5%E7%B3%BB%E5%88%97) label [on 25 Apr 2017](https://github.com/mqyqingfeng/Blog/issues/7#event-1055840703)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='31'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='2127' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

This was referenced on 26 Apr 2017

 [JavaScript深入之执行上下文#8](https://github.com/mqyqingfeng/Blog/issues/8)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='32'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='2136' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [JavaScript深入之闭包#9](https://github.com/mqyqingfeng/Blog/issues/9)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='33'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='2143' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [![21247168](../_resources/a78ff3c2b982a250ea1c0d13e8fb015d.jpg)](https://github.com/littleluckly)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='34'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2151' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [littleluckly](https://github.com/littleluckly)  ** commented [on 18 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-302291207)    •

  edited by mqyqingfeng   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-triangle-down v-align-middle js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='35'%3e%3cpath d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z' data-evernote-id='2161' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

|     |
| --- |
| 下面一段代码的执行结果为1，why???，Foo()函数返回的this指window对吧，然后Foo().getName()，不就是指window.getName()吗，所以执行结果应该是5呀？求解答<br>function  Foo(){getName  =  function(){console.log(1); };return  this}function  getName(){console.log(5);}Foo().getName(); |

 [![11458263](../_resources/340ec8d3a19409bdd3755a108adba3f2.jpg)](https://github.com/mqyqingfeng)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='36'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2227' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

  Owner This user is the owner of the Blog repository.   AuthorThis user is the author of this issue.

###   **  [mqyqingfeng](https://github.com/mqyqingfeng)  ** commented [on 18 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-302293360)

|     |
| --- |
| [@littleluckly](https://github.com/littleluckly) this 确实是指向 window ，但是这道题的陷阱在于 Foo 函数执行的时候，里面的 getName 函数覆盖了外层的 getName 函数 |

 [![21247168](../_resources/a78ff3c2b982a250ea1c0d13e8fb015d.jpg)](https://github.com/littleluckly)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='37'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2259' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [littleluckly](https://github.com/littleluckly)  ** commented [on 18 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-302293717)

|     |
| --- |
| [@mqyqingfeng](https://github.com/mqyqingfeng) 对哦，Foo()函数里面也是个一个函数表达式，getName也是指向的全局。谢谢博主 |

 [![21247168](../_resources/a78ff3c2b982a250ea1c0d13e8fb015d.jpg)](https://github.com/littleluckly)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='38'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2281' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [littleluckly](https://github.com/littleluckly)  ** commented [on 18 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-302294650)    •

  edited   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-triangle-down v-align-middle js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='39'%3e%3cpath d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z' data-evernote-id='2291' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

|     |
| --- |
| [@mqyqingfeng](https://github.com/mqyqingfeng) 追问一下博主，如果代码改成如下这样，结果为3，请指教<br>function  Foo(){getName  =  function(){console.log(1);};return  this;}Foo.prototype.getName  =  function(){console.log(3);};function  getName(){console.log(5);};new  Foo().getName()//3 |

 [![11458263](../_resources/340ec8d3a19409bdd3755a108adba3f2.jpg)](https://github.com/mqyqingfeng)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='40'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2376' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

  Owner This user is the owner of the Blog repository.   AuthorThis user is the author of this issue.

###   **  [mqyqingfeng](https://github.com/mqyqingfeng)  ** commented [on 18 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-302299071)

|     |
| --- |
| [@littleluckly](https://github.com/littleluckly) 刚才去吃饭了，这道题考察的是运算符优先级问题，各运算符优先级可以查看[这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)。<br>你会发现 成员访问 和 new (带参数列表)的优先级都为 19，相同等级下，遇到谁先执行谁，所以 new Foo().getName()相当于 (new Foo()).getName()<br>接下来的就比较简单了, new 返回一个对象，这个对象的原型指向 Foo.prototype，然后访问这个对象上的getName方法，自然是调用写在原型上的这个方法啦，结果也就是 3。 |

 [![21247168](../_resources/a78ff3c2b982a250ea1c0d13e8fb015d.jpg)](https://github.com/littleluckly)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='41'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2408' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [littleluckly](https://github.com/littleluckly)  ** commented [on 18 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-302349595)

|     |
| --- |
| [@mqyqingfeng](https://github.com/mqyqingfeng) 博主请务必一定接受一个抠脚大汉对你表示的感谢~~~么么哒 |

 [![11458263](../_resources/340ec8d3a19409bdd3755a108adba3f2.jpg)](https://github.com/mqyqingfeng)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='42'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2430' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

  Owner This user is the owner of the Blog repository.   AuthorThis user is the author of this issue.

###   **  [mqyqingfeng](https://github.com/mqyqingfeng)  ** commented [on 18 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-302353372)

|     |
| --- |
| [@littleluckly](https://github.com/littleluckly) 哈哈，感觉这是一个有味道的感谢，(～￣▽￣)～ |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='43'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='2454' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![11458263](../_resources/544b0e374410510d6c272b86a1ed6bcd.jpg)](https://github.com/mqyqingfeng)[mqyqingfeng](https://github.com/mqyqingfeng) mentioned this issue [on 26 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#ref-issue-231506810)

 [JavaScript深入系列15篇正式完结！#17](https://github.com/mqyqingfeng/Blog/issues/17)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='44'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='2463' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='45'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='2466' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

This was referenced on 26 May 2017

 [JavaScript深入之闭包yy9306/yy9306.github.io#4](https://github.com/yy9306/yy9306.github.io/issues/4)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='46'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='2475' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [JavaScript深入之执行上下文yy9306/yy9306.github.io#13](https://github.com/yy9306/yy9306.github.io/issues/13)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='47'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='2482' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [JavaScript深入之作用域链yy9306/yy9306.github.io#15](https://github.com/yy9306/yy9306.github.io/issues/15)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='48'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='2489' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [![12730051](../_resources/bf7857102dbbb418391981b30afbf940.jpg)](https://github.com/MissCuriosity)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='49'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2497' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [MissCuriosity](https://github.com/MissCuriosity)  ** commented [on 27 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-304454879)

|     |
| --- |
| = =没看懂，谢特，我再来看一遍。 |

 [![12730051](../_resources/bf7857102dbbb418391981b30afbf940.jpg)](https://github.com/MissCuriosity)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='50'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2519' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [MissCuriosity](https://github.com/MissCuriosity)  ** commented [on 27 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-304456923)

|     |
| --- |
| 我自己打印了一下，在foo.**proto**,foo.bar.__proto__中都没有GetValue，在全局直接使用GetValue也是报错得啊（GetValue is not defined），这一章真的是看得万脸懵逼啊！！ |

 [![12730051](../_resources/bf7857102dbbb418391981b30afbf940.jpg)](https://github.com/MissCuriosity)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='51'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2541' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [MissCuriosity](https://github.com/MissCuriosity)  ** commented [on 27 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-304456946)

|     |
| --- |
| 感觉看了三遍也没懂！！！ |

 [![24775744](../_resources/02b78263710dfa2381a64259448400c9.png)](https://github.com/Nikaple)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='52'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2569' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [Nikaple](https://github.com/Nikaple)  ** commented [on 28 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-304479673)

|     |
| --- |
| [@MissCuriosity](https://github.com/MissCuriosity) GetValue, GetBase以及Reference类型等这篇文章提到的概念都属于浏览器底层的实现，只是为了从原理上来解读this指向问题的，自然在console里是无法使用的～ |

 [![11458263](../_resources/340ec8d3a19409bdd3755a108adba3f2.jpg)](https://github.com/mqyqingfeng)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='53'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2594' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

  Owner This user is the owner of the Blog repository.   AuthorThis user is the author of this issue.

###   **  [mqyqingfeng](https://github.com/mqyqingfeng)  ** commented [on 29 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-304608783)

|     |
| --- |
| [@Nikaple](https://github.com/Nikaple) 感谢回答，确实是这样的~<br>[@MissCuriosity](https://github.com/MissCuriosity) 回答的晚了，很抱歉，不知道你读规范受到了怎样的煎熬，实际上，我在学习 this 的时候，也深感艰难，要理解这篇文章的话，是要边跟着文章的思路边看规范的，而理解 this 的关键点在于通过查阅规范，判断表达式的结果是不是一个 Reference 类型。规范确实难懂，但若能克服对规范的恐惧，也是一个巨大的成长！与你相互勉励~ |

 [![23327067](../_resources/a938ba42cba920a5433b8dac24a6b558.jpg)](https://github.com/sunsl516)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='54'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2623' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [sunsl516](https://github.com/sunsl516)  ** commented [on 29 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-304608923)

|     |
| --- |
| 好了。博主。你成功把我讲懵逼了。 |

 [![11458263](../_resources/340ec8d3a19409bdd3755a108adba3f2.jpg)](https://github.com/mqyqingfeng)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='55'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2648' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

  Owner This user is the owner of the Blog repository.   AuthorThis user is the author of this issue.

###   **  [mqyqingfeng](https://github.com/mqyqingfeng)  ** commented [on 29 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-304614098)

|     |
| --- |
| [@sunsl516](https://github.com/sunsl516) 哈哈，这一篇不影响以后文章的阅读，你可以安心读接下来的文章，这篇文章是为了告诉大家还有一种讲解 this 的角度是从规范切入，如果有一天，你想知道从规范怎么解读 this，那再回来看这一篇文章哈~ |

 [![23327067](../_resources/a938ba42cba920a5433b8dac24a6b558.jpg)](https://github.com/sunsl516)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='56'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2675' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [sunsl516](https://github.com/sunsl516)  ** commented [on 30 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-304756389)

|     |
| --- |
| 嗯。 这个角度倒是很新颖。 这篇文章得反复琢磨才能搞懂。反正已经收藏了。后面再多看几遍。谢博主无私分享。[@mqyqingfeng](https://github.com/mqyqingfeng) |

 [![26685935](../_resources/00d240a7caddc6afca308b30985fa4d8.jpg)](https://github.com/lynn1824)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='57'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2697' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [lynn1824](https://github.com/lynn1824)  ** commented [on 31 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-305073671)

|     |
| --- |
| 太官方了，没看懂。<br>我知道的是：this一般有几种调用场景<br>var obj = {a: 1, b: function(){console.log(this);}}<br>1、作为对象调用时，指向该对象 obj.b(); // 指向obj<br>2、作为函数调用, var b = obj.b; b(); // 指向全局window<br>3、作为构造函数调用 var b = new Fun(); // this指向当前实例对象<br>4、作为call与apply调用 obj.b.apply(object, []); // this指向当前的object |

 [![11458263](../_resources/340ec8d3a19409bdd3755a108adba3f2.jpg)](https://github.com/mqyqingfeng)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='58'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2733' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

  Owner This user is the owner of the Blog repository.   AuthorThis user is the author of this issue.

###   **  [mqyqingfeng](https://github.com/mqyqingfeng)  ** commented [on 31 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-305092250)

[@lynn1824](https://github.com/lynn1824) 感谢补充，我觉得从调用场景去讲 this 的指向是一个非常重要的总结，这在我们日常的使用中非常重要。然而我该如何解释 [object Object]  [object Object]  [object Object]下 this 的指向呢？为什么 (obj.b)() 是作为对象调用， (false || obj.b)() 就是作为函数调用呢？不知道该如何很好的解释这些，才让我最终决定从规范的角度去讲一讲

 [![20948305](../_resources/5f325fe0ef304cff8126cd0187c71625.jpg)](https://github.com/MrGoodBye)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='59'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2761' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [MrGoodBye](https://github.com/MrGoodBye)  ** commented [on 31 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-305114154)

[@mqyqingfeng](https://github.com/mqyqingfeng) 感觉[object Object]像是一个[object Object],所以是[object Object].

 [![13806266](../_resources/9af97b81bcc14b1bde109c9f53792e93.jpg)](https://github.com/yangzhongxun)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='60'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2786' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [yangzhongxun](https://github.com/yangzhongxun)  ** commented [on 31 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-305126582)

|     |
| --- |
| 看了两遍，有一点不太明白，具体分析的例子里面的后三问的 this 为什么不是 window，而是 undefined，如果是 undefined，那么 undefined.value 的值为什么是 2 呢？博主有时间了还请帮忙解释下，多谢！ |

 [![11458263](../_resources/340ec8d3a19409bdd3755a108adba3f2.jpg)](https://github.com/mqyqingfeng)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='61'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2808' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

  Owner This user is the owner of the Blog repository.   AuthorThis user is the author of this issue.

###   **  [mqyqingfeng](https://github.com/mqyqingfeng)  ** commented [on 31 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-305126976)

[@MrGoodBye](https://github.com/MrGoodBye) 哈哈，[object Object]也有两个括号呐……看规范的意思，[object Object] 和 [object Object]的区别在于 [object Object]运算符对值进行了计算，可是为什么进行了计算，this 的指向就发生了变化呢？哎呀，我们还是来看规范吧……

 [![11458263](../_resources/340ec8d3a19409bdd3755a108adba3f2.jpg)](https://github.com/mqyqingfeng)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='62'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2837' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

  Owner This user is the owner of the Blog repository.   AuthorThis user is the author of this issue.

###   **  [mqyqingfeng](https://github.com/mqyqingfeng)  ** commented [on 31 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-305127225)

|     |
| --- |
| [@yangzhongxun](https://github.com/yangzhongxun) 非严格模式下， this 的值如果为 undefined，默认指向全局对象 |

 [![13806266](../_resources/9af97b81bcc14b1bde109c9f53792e93.jpg)](https://github.com/yangzhongxun)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='63'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2864' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [yangzhongxun](https://github.com/yangzhongxun)  ** commented [on 31 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-305140441)

|     |
| --- |
| [@mqyqingfeng](https://github.com/mqyqingfeng) 多谢博主！规范的确更加难懂，不过也是语言的根本，向博主学习！ |

 [![19797275](../_resources/5b17c053fc72237d3abd2ffb9e99341d.png)](https://github.com/webLion200)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='64'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2886' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [webLion200](https://github.com/webLion200)  ** commented [on 31 May 2017](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-305166706)

|     |
| --- |
| 看的我是万脸蒙逼啊 |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='65'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='2908' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![3871365](../_resources/ea4db8c328f3afce4330a28aa365394a.png)](https://github.com/linzhenjie)[linzhenjie](https://github.com/linzhenjie) mentioned this issue [on 11 Apr](https://github.com/mqyqingfeng/Blog/issues/7#ref-issue-597897776)

 [对Javascript的深入理解linzhenjie/blog#15](https://github.com/linzhenjie/blog/issues/15)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='66'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='2917' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [![19875237](../_resources/514ae6d7e58710ddee0d578e20d7ce5e.jpg)](https://github.com/iiicon)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='67'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2925' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [iiicon](https://github.com/iiicon)  ** commented [on 23 Apr](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-618206932)

> [> @lynn1824](https://github.com/lynn1824)>  感谢补充，我觉得从调用场景去讲 this 的指向是一个非常重要的总结，这在我们日常的使用中非常重要。然而我该如何解释 [object Object]>   [object Object]>   [object Object]> 下 this 的指向呢？为什么 (obj.b)() 是作为对象调用， (false || obj.b)() 就是作为函数调用呢？不知道该如何很好的解释这些，才让我最终决定从规范的角度去讲一讲

这两个[object Object] 差点把我绕进去，[object Object] 是运算过之后再 GetValue，
你这篇文章写的真是血强

 [![36765589](../_resources/d6c24ab3fdedf95346dcc87b807e25b5.png)](https://github.com/CosSalt)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='68'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2950' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [CosSalt](https://github.com/CosSalt)  ** commented [on 26 Apr](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-619490748)

|     |
| --- |
| 那些情况下 Reference 的 base 会是 boolean string 这些基本类型？ |

 [![22166503](../_resources/98d9aa284a8c8caa2700cc7bd9716653.png)](https://github.com/Jacksonluang)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='69'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2972' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [Jacksonluang](https://github.com/Jacksonluang)  ** commented [on 28 Apr](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-620405324)

|     |
| --- |
| 真的很懵逼，，，， |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='70'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='2990' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![12544073](../_resources/f31180899d597f4c04aba6a0b93f4a1c.jpg)](https://github.com/pzli)[pzli](https://github.com/pzli) mentioned this issue [on 6 May](https://github.com/mqyqingfeng/Blog/issues/7#ref-issue-613100046)

 [从ECMAScript规范解读thisChhXin/one-day-in-the-future#10](https://github.com/ChhXin/one-day-in-the-future/issues/10)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='71'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='2999' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [![48374304](../_resources/d6039c3ad5502f016286acb73e1b3a3d.jpg)](https://github.com/lifetimelovez)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='72'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3007' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [lifetimelovez](https://github.com/lifetimelovez)  ** commented [on 14 May](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-628517782)

|     |
| --- |
| 非常感谢 第一次读 花了一小时 理解了一半 确实是一个不一样的角度 |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='73'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='3025' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![16680895](../_resources/f5200bd7ceb6f294aa0beec2abd71a63.png)](https://github.com/yangdui)[yangdui](https://github.com/yangdui) mentioned this issue [on 16 May](https://github.com/mqyqingfeng/Blog/issues/7#ref-issue-619462785)

 [理解 thisyangdui/blog#4](https://github.com/yangdui/blog/issues/4)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='74'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='3034' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [![11676609](../_resources/9b04327e91b171529c7ab818a291f485.png)](https://github.com/lishihong)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='75'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3042' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [lishihong](https://github.com/lishihong)  ** commented [on 1 Jun](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-636577916)

|     |
| --- |
| function foo() {<br>console.log(this)<br>}<br>foo();<br>this 并不是undefined |

 [![33363204](../_resources/7ea55b699cbb435a6939a793e787e1ba.jpg)](https://github.com/XINXINP)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='76'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3068' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [XINXINP](https://github.com/XINXINP)  ** commented [on 2 Jun](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-637447992)

|     |
| --- |
| 以前学习this这块，尝试了很多方法，看网上的博文，看《你不知道的javaScript》，感觉都不透彻，今天看了这篇文章，才找到方向，直接规范，结合作者的总结，解开了一些疑惑。 |

 [![19543302](../_resources/99130b5e090146db99cfe8bc09172cbc.jpg)](https://github.com/Haven09)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='77'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3090' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [Haven09](https://github.com/Haven09)  ** commented [on 9 Jun](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-641390279)

|     |
| --- |
| > function foo() {<br>> console.log(this)<br>> }<br>> foo();<br>> this 并不是undefined<br>因为在非严格模式下，this的undefined会隐式转换为当前代码运行环境下的全局变量。浏览器环境下会指向window对象，node环境下会指向global对象。 |

 [![16821989](../_resources/a71bd212b07e22a7b277ae8e2780e7b9.jpg)](https://github.com/xieyezi)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='78'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3118' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [xieyezi](https://github.com/xieyezi)  ** commented [on 11 Jun](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-642499408)

|     |
| --- |
| > 我可能需要再看10遍才能懂了<br>那我可能需要看20遍了 |

 [![16821989](../_resources/a71bd212b07e22a7b277ae8e2780e7b9.jpg)](https://github.com/xieyezi)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='79'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3142' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [xieyezi](https://github.com/xieyezi)  ** commented [on 17 Jun](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-645190784)

|     |
| --- |
| function  Foo(){  getName  =  function(){  console.log(1); };  return  this;}function  getName(){  console.log(5);};new  Foo().getName()<br>如果是这样的话，它会提示type error |

 [![4509523](../_resources/3acc037e45732f895a38134fcce8532b.jpg)](https://github.com/wweggplant)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='80'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3211' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [wweggplant](https://github.com/wweggplant)  ** commented [on 18 Jun](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-645746652)

|     |
| --- |
| > function>   > Foo> (> )> {>   > getName>   > =>   > function> (> )> {>   > console> .> log> (> 1> )> ;>  > }> ;>   > return>   > this> ;> }> function>   > getName> (> )> {>   > console> .> log> (> 5> )> ;> }> ;> new>   > Foo> (> )> .> getName> (> )<br>> 如果是这样的话，它会提示type error<br>因为这个getName一直在全局对象上，Foo上当然找不到他了 |

 [![4509523](../_resources/3acc037e45732f895a38134fcce8532b.jpg)](https://github.com/wweggplant)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='81'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3282' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [wweggplant](https://github.com/wweggplant)  ** commented [on 18 Jun](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-645749437)

|     |
| --- |
| 看下来文章的重点是要确定()左边的是不是Reference |

 [![29219117](../_resources/bcf5389c41b0218eec2becdbde686155.png)](https://github.com/amandaQYQ)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='82'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3304' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [amandaQYQ](https://github.com/amandaQYQ)  ** commented [on 19 Jun](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-646550701)

|     |
| --- |
| 反复看了三四遍，又跟着查了下规范，下班前最后一秒，感觉有丢丢丢丢丢窥见皮毛了~ 大佬真厉害啊 |

 [![22569249](../_resources/a09debbe68cb60cb48f26905e2587db4.jpg)](https://github.com/coder30)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='83'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3326' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [coder30](https://github.com/coder30)  ** commented [on 23 Jun](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-648163167)

> [> @lynn1824](https://github.com/lynn1824)>  感谢补充，我觉得从调用场景去讲 this 的指向是一个非常重要的总结，这在我们日常的使用中非常重要。然而我该如何解释 [object Object]>   [object Object]>   [object Object]> 下 this 的指向呢？为什么 (obj.b)() 是作为对象调用， (false || obj.b)() 就是作为函数调用呢？不知道该如何很好的解释这些，才让我最终决定从规范的角度去讲一讲

[@mqyqingfeng](https://github.com/mqyqingfeng) 我觉得false || obj.b和foo.bar, foo.bar看起来类似进行了一次赋值操作，像 const a = false || obj.b， a(), 所以作为了一个函数调用，this 指向了全局

 [![4509523](../_resources/3acc037e45732f895a38134fcce8532b.jpg)](https://github.com/wweggplant)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='84'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3350' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [wweggplant](https://github.com/wweggplant)  ** commented [on 29 Jun](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-650924325)

> 刚才去吃饭了，这道题考察的是运算符优先级问题，各运算符优先级可以查看> [> 这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)> 。

> 你会发现 成员访问 和 new (带参数列表)的优先级都为 19，相同等级下，遇到谁先执行谁，所以 new Foo().getName()相当于 (new Foo()).getName()

> 接下来的就比较简单了, new 返回一个对象，这个对象的原型指向 Foo.prototype，然后访问这个对象上的getName方法，自然是调用写在原型上的这个方法啦，结果也就是 3。

[@jianghaoran116](https://github.com/jianghaoran116) 博主你好 "这个对象的原型指向 Foo.prototype"这里怎么理解，是规范里GetValue：调用 O 的 [[GetProperty]] 内部方法的返回值。 这么来的么，返回对象的原型。

“这个对象的原型指向 Foo.prototype”这个涉及到继承和原型链的问题。

由图可以看到，f1 = new Foo()，即new返回的对象是f1，f1的[[proto]]属性指向Foo.prototype。Foo()里有一个“输出1”的方法，但这个方法不会在f1中出现。f1会继承Foo.prototype里“输出3”的方法。

[![77389876-4c100e80-6dcf-11ea-8190-3baccaf12d16.png](../_resources/5e18c31b9be548511e2d87e13a16ae9f.png)](https://user-images.githubusercontent.com/49944109/77389876-4c100e80-6dcf-11ea-8190-3baccaf12d16.png)

如果还不懂的话，可以运行这段代码：
[object Object]
在此基础上添加下面的代码
[object Object]
这图牛逼了

 [![44806209](../_resources/4850be594309e2c0e543163908c6f799.jpg)](https://github.com/shy5)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='85'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3386' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [shy5](https://github.com/shy5)  ** commented [on 16 Jul](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-659307647)

|     |
| --- |
| getBase（）和getValue（）有啥区别啊 |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='86'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='3404' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![748306](../_resources/e2ccee81f8199c9841db8d363c7a7773.jpg)](https://github.com/aJean)[aJean](https://github.com/aJean) mentioned this issue [on 19 Jul](https://github.com/mqyqingfeng/Blog/issues/7#ref-issue-452436842)

 [javascript 运行时aJean/daily-activities#18](https://github.com/aJean/daily-activities/issues/18)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='87'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='3413' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [![30133933](../_resources/24143bfb27405f6e3efff451e39afb90.jpg)](https://github.com/LiZheng1501)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='88'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3421' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [LiZheng1501](https://github.com/LiZheng1501)  ** commented [on 28 Jul](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-664845339)

|     |
| --- |
| 您好大神，我想问个问题，我还是没看明白 ，是怎么确定foo,bar() , MemberExpress->foo.bar是一个reference的。。您是怎么判断的呢？ |

 [![26463204](../_resources/210f0b41c6f05da1699d99751279ab29.jpg)](https://github.com/chico-malo)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='89'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3443' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [chico-malo](https://github.com/chico-malo)  ** commented [on 19 Aug](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-676288172)

|     |
| --- |
| 我全神贯注花了一个小时才读懂在说啥… 不过，我想自己跑跑看这底层的过程，浏览器根本看不到，去搜索也没找到相关的东西… 哪位大大有相关的资料，别藏着掖着分享给我，非常感谢。 |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='90'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='3461' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![4001228](../_resources/9080fa17e1d243c6ae3161f2c60ba6af.png)](https://github.com/swiftwind0405)[swiftwind0405](https://github.com/swiftwind0405) mentioned this issue [on 25 Aug](https://github.com/mqyqingfeng/Blog/issues/7#ref-issue-612965470)

 [【JavaScript】用 ES 规范去解释 thisswiftwind0405/blog#54](https://github.com/swiftwind0405/blog/issues/54)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='91'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='3470' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [![30424461](../_resources/cd00de59da202885b64a81ec9cf0d06e.jpg)](https://github.com/growYdp)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='92'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3478' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [growYdp](https://github.com/growYdp)  ** commented [on 28 Aug](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-682396787)

|     |
| --- |
| 规范是不是都得读一遍.... |

 [![66249292](../_resources/087f3fe52283096f46da32f757dd1c62.png)](https://github.com/q774221810)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='93'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3500' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [q774221810](https://github.com/q774221810)  ** commented [on 11 Sep](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-690960038)

|     |
| --- |
| 发现新大陆，以前JS都不知道学了什么 |

 [![59857905](../_resources/468c88b301760288a6be293e67e254c3.png)](https://github.com/youjiaqi421)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='94'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3523' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [youjiaqi421](https://github.com/youjiaqi421)  ** commented [29 days ago](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-691760091)

|     |
| --- |
| > 下面一段代码的执行结果为1，为什么？，Foo（）函数返回的this指窗口对吧，然后Foo（）。getName（），不就是指window.getName（）吗，所以执行结果应该是5呀？求解答<br>> 函数>   > Foo>   > （）> {>  > getName>   > =>   > function>   > （）> {>  > 控制台。log>   > （1>   > ）> ;>   > }>   > ;>  > 返回>   > 此> }> 函数>   > getName>   > （）> {>  > 控制台。log>   > （5>   > ）> ;>   > }> 富（）。getName>   > （）> ;<br>第二个函数getName 才是一个全局函数 ,而第一个getName 函数表达式 不在全局注册 但是一个局部变量覆盖了全局所以是一 |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='95'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='3574' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![52566781](../_resources/8d0695445a2d77ecb6fd83534698a145.jpg)](https://github.com/A-cabbage)[A-cabbage](https://github.com/A-cabbage) mentioned this issue [19 days ago](https://github.com/mqyqingfeng/Blog/issues/7#ref-issue-707921391)

 [函数(上)A-cabbage/JavaScript#8](https://github.com/A-cabbage/JavaScript/issues/8)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='96'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='3583' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [![20720227](../_resources/db5be4392858814317247762e60aa36c.png)](https://github.com/alexzhao8326)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='97'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3591' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [alexzhao8326](https://github.com/alexzhao8326)  ** commented [18 days ago](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-698787579)    •

  edited   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-triangle-down v-align-middle js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='98'%3e%3cpath d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z' data-evernote-id='3601' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

|     |
| --- |
| 冴羽大大，我有点不能理解调用GetValue(V)就一定是返回具体值，而不是返回Reference,<br>规范的第一句是：If Type(V) is not Reference, return V.那是不是有Reference的情况？<br>还有这个Type(V)是怎么判断是不是Reference的？比如例子中var foo = 1; 那Type(foo)到底是不是Reference? |

 [![9879307](../_resources/5d958940f50879e1cdc7fdcc559ac2a3.png)](https://github.com/yusilong)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='99'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3621' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [yusilong](https://github.com/yusilong)  ** commented [14 days ago](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-700482270)

> [> @lynn1824](https://github.com/lynn1824)>  感谢补充，我觉得从调用场景去讲 this 的指向是一个非常重要的总结，这在我们日常的使用中非常重要。然而我该如何解释 [object Object]>   [object Object]>   [object Object]> 下 this 的指向呢？为什么 (obj.b)() 是作为对象调用， (false || obj.b)() 就是作为函数调用呢？不知道该如何很好的解释这些，才让我最终决定从规范的角度去讲一讲

> [> @mqyqingfeng](https://github.com/mqyqingfeng)>  感觉[object Object]> 像是一个[object Object]> ,所以是[object Object]> .

我同意你的说法：
(function(){...})()
(function(){...}())
这些实际上是自执行函数，所以实际上算是函数方法

 [![9879307](../_resources/5d958940f50879e1cdc7fdcc559ac2a3.png)](https://github.com/yusilong)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='100'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3650' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [yusilong](https://github.com/yusilong)  ** commented [14 days ago](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-700485963)

[object Object]
> 请问下楼主，里的结果分析应该用词法作用域还是用本章讲的this呢，有点混乱
我觉的你吧，原型链和作用域链搞混了，好像。
这一段代码这是函数调用，而没有实例化，所以this都是指向window对象。

 [![16821989](../_resources/a71bd212b07e22a7b277ae8e2780e7b9.jpg)](https://github.com/xieyezi)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='101'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3675' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [xieyezi](https://github.com/xieyezi)  ** commented [13 days ago](https://github.com/mqyqingfeng/Blog/issues/7#issuecomment-701159294)

> function>   > Foo> (> )> {>   > getName>   > =>   > function> (> )> {>   > console> .> log> (> 1> )> ;>  > }> ;>   > return>   > this> ;> }> function>   > getName> (> )> {>   > console> .> log> (> 5> )> ;> }> ;> new>   > Foo> (> )> .> getName> (> )

> 如果是这样的话，它会提示type error
因为这个getName一直在全局对象上，Foo上当然找不到他了

这里应该是用原型和原型链来解释：[object Object]应该看成是[object Object] 。new Foo() 先创建了一个 Foo的实例，然后再调用这个实例的[object Object]函数，然而这个实例并没有[object Object]函数，然后他就通过[object Object] ，也就是[object Object]上面去找，但是[object Object]还是找不到，所以就报错了。

 [Sign up for free](https://github.com/join?source=comment-repo)  **to join this conversation on GitHub**. Already have an account? [Sign in to comment](https://github.com/login?return_to=https%3A%2F%2Fgithub.com%2Fmqyqingfeng%2FBlog%2Fissues%2F7)

Assignees
  No one assigned

Labels

 [深入系列](https://github.com/mqyqingfeng/Blog/labels/%E6%B7%B1%E5%85%A5%E7%B3%BB%E5%88%97)

Projects
  None yet

Milestone
No milestone

Linked pull requests

Successfully merging a pull request may close this issue.
None yet

139 participants

 [![1744713](../_resources/2aeb6ab6ca2f38a8c74d8e34d08ee299.jpg)](https://github.com/chenxiaochun)  [![3871365](../_resources/ea4db8c328f3afce4330a28aa365394a.png)](https://github.com/linzhenjie)  [![4354095](../_resources/2cf6e4997e970f6b5daa7090e749db9b.jpg)](https://github.com/CaesarChan)  [![4509523](../_resources/2215904958080bd94cc508b47dcac15f.jpg)](https://github.com/wweggplant)  [![5285480](../_resources/ea640b18b18d29d60a11d163ed9eb9d9.jpg)](https://github.com/jianghaoran116)  [![5326755](../_resources/43511a7109faf8d9e5370ea51f76d2e0.png)](https://github.com/Zippowxk)  [![6256684](../_resources/248265fd71ec660dafdec216d672fc31.jpg)](https://github.com/Ghohankawk)  [![7463688](../_resources/dfae084ceecb64cd604151f207b0c6dd.jpg)](https://github.com/DarkYeahs)  [![8039013](../_resources/731e32e1b497d03aafc951f6a84d4d5d.jpg)](https://github.com/XuToTo)  [![8546063](../_resources/85efc14a5ae888a7cbef0eeb81193fd4.png)](https://github.com/lucky3mvp)  [![8995640](../_resources/af83d6c340804cc0db9c646b41852bf6.png)](https://github.com/webjscss)  [![9879307](../_resources/5d958940f50879e1cdc7fdcc559ac2a3.png)](https://github.com/yusilong)  [![9909704](../_resources/ae0f990ad406156b804e5301dfe39ef6.jpg)](https://github.com/xiaobinwu)  [![10160349](../_resources/97363fe69ca8c2c9f6a5245c7424eb62.jpg)](https://github.com/sclchic)  [![10348941](../_resources/54d2389a5b503aaeb7daa1c4eaf60be3.jpg)](https://github.com/5ibinbin)  [![11384498](../_resources/fd69d76a707ce3ee87999472fe2febaf.png)](https://github.com/fallenleaves409)  [![11458263](../_resources/abc742d3e1e78fa3aaacd0e19e39b249.jpg)](https://github.com/mqyqingfeng)  [![11554593](../_resources/fb7acb20cbef4e404b244f47b7ec67f3.png)](https://github.com/EvaSummers)  [![11676609](../_resources/9b04327e91b171529c7ab818a291f485.png)](https://github.com/lishihong)  [![11750032](../_resources/d957b466353f8352e16aab06a999c65f.png)](https://github.com/zanqianqvxifu)  and others
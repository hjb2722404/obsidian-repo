JavaScript 运算符规则与隐式类型转换详解 - 掘金

[(L)](https://juejin.im/user/57600ea72e958a0058f6ac24)
[王下邀月熊](https://juejin.im/user/57600ea72e958a0058f6ac24)
2017年09月04日阅读 1042

# JavaScript 运算符规则与隐式类型转换详解

> [> JavaScript 运算符规则与隐式类型转换详解](https://link.juejin.im/?target=https%3A%2F%2Fparg.co%2Fb74)>  从属于笔者的> [> 现代 JavaScript 开发：语法基础与工程实践](https://link.juejin.im/?target=https%3A%2F%2Fparg.co%2FbxN)> 系列文章，主要探讨 JavaScript 中令人迷惑的加减乘除与比较等常见运算中的规则与隐式类型转换；本文中涉及的参考资料全部声明在了> [> JavaScript 数据结构学习与实践资料索引](https://link.juejin.im/?target=https%3A%2F%2Fparg.co%2Fbxn)> 。

在 JavaScript 中，当我们进行比较操作或者加减乘除四则运算操作时，常常会触发 JavaScript 的隐式类型转换机制；而这部分也往往是令人迷惑的地方。譬如浏览器中的 `console.log` 操作常常会将任何值都转化为字符串然后展示，而数学运算则会首先将值转化为数值类型（除了 Date 类型对象）然后进行操作。

我们首先来看几组典型的 JavaScript 中运算符操作结果，希望阅读完本部分之后能够对每一个条目都能进行合理解释：

	// 比较
	[] == ![] // true
	NaN !== NaN // true

	1 == true // true
	2 == true // false
	"2" == true // flase

	null > 0 // false
	null < 0 // false
	null == 0 // false
	null >= 0 // true

	// 加法
	true + 1 // 1
	undefined + 1 // NaN

	let obj = {};

	{} + 1 // 1，这里的 {} 被当成了代码块
	{ 1 + 1 } + 1 // 1

	obj + 1 // [object Object]1
	{} + {} // Chrome 上显示 "[object Object][object Object]"，Firefox 显示 NaN

	[] + {} // [object Object]
	[] + a // [object Object]
	+ [] // 等价于 + "" => 0
	{} + [] // 0
	a + [] // [object Object]

	[2,3] + [1,2] // '2,31,2'
	[2] + 1 // '21'
	[2] + (-1) // "2-1"

	// 减法或其他操作，无法进行字符串连接，因此在错误的字符串格式下返回 NaN
	[2] - 1 // 1
	[2,3] - 1 // NaN
	{} - 1 // -1复制代码

## 原始类型间转换

JavaScript 中我们常说的原始类型包括了数值类型、字符串类型、布尔类型与空类型这几种；而我们常用的原始类型之间的转换函数就是 String、Number 与 Boolean:

	// String
	let value = true;
	console.log(typeof value); // boolean

	value = String(value); // now value is a string "true"
	console.log(typeof value); // string

	// Number
	let str = "123";
	console.log(typeof str); // string

	let num = Number(str); // becomes a number 123

	console.log(typeof num); // number

	let age = Number("an arbitrary string instead of a number");

	console.log(age); // NaN, conversion failed

	// Boolean
	console.log( Boolean(1) ); // true
	console.log( Boolean(0) ); // false

	console.log( Boolean("hello") ); // true
	console.log( Boolean("") ); // false复制代码

最终，我们可以得到如下的 JavaScript 原始类型转换表（包括复合类型向原始类型转换的范例）：

| 原始值 | 转化为数值类型 | 转化为字符串类型 | 转化为 Boolean 类型 |
| --- | --- | --- | --- |
| false | 0   | "false" | false |
| true | 1   | "true" | true |
| 0   | 0   | "0" | false |
| 1   | 1   | "1" | true |
| "0" | 0   | "0" | true |
| "1" | 1   | "1" | true |
| NaN | NaN | "NaN" | false |
| Infinity | Infinity | "Infinity" | true |
| -Infinity | -Infinity | "-Infinity" | true |
| ""  | 0   | ""  | false |
| "20" | 20  | "20" | true |
| "twenty" | NaN | "twenty" | true |
| [ ] | 0   | ""  | true |
| [20] | 20  | "20" | true |
| [10,20] | NaN | "10,20" | true |
| ["twenty"] | NaN | "twenty" | true |
| ["ten","twenty"] | NaN | "ten,twenty" | true |
| function(){} | NaN | "function(){}" | true |
| { } | NaN | "[object Object]" | true |
| null | 0   | "null" | false |
| undefined | NaN | "undefined" | false |

## ToPrimitive

在比较运算与加法运算中，都会涉及到将运算符两侧的操作对象转化为原始对象的步骤；而 JavaScript 中这种转化实际上都是由 ToPrimitive 函数执行的。实际上，当某个对象出现在了需要原始类型才能进行操作的上下文时，JavaScript 会自动调用 ToPrimitive 函数将对象转化为原始类型；譬如上文介绍的 `alert` 函数、数学运算符、作为对象的键都是典型场景，该函数的签名如下：

`ToPrimitive(input, PreferredType?)复制代码`
为了更好地理解其工作原理，我们可以用 JavaScript 进行简单地实现：

	var ToPrimitive = function(obj,preferredType){
	  var APIs = {
	    typeOf: function(obj){
	      return Object.prototype.toString.call(obj).slice(8,-1);
	    },
	    isPrimitive: function(obj){
	      var _this = this,
	          types = ['Null','Undefined','String','Boolean','Number'];
	      return types.indexOf(_this.typeOf(obj)) !== -1;
	    }
	  };
	  // 如果 obj 本身已经是原始对象，则直接返回
	  if(APIs.isPrimitive(obj)) {return obj;}

	  // 对于 Date 类型，会优先使用其 toString 方法；否则优先使用 valueOf 方法
	  preferredType = (preferredType === 'String' || APIs.typeOf(obj) === 'Date' ) ? 'String' : 'Number';
	  if(preferredType==='Number'){
	    if(APIs.isPrimitive(obj.valueOf())) { return obj.valueOf()};
	    if(APIs.isPrimitive(obj.toString())) { return obj.toString()};
	  }else{
	    if(APIs.isPrimitive(obj.toString())) { return obj.toString()};
	    if(APIs.isPrimitive(obj.valueOf())) { return obj.valueOf()};
	  }
	  throw new TypeError('TypeError');
	}复制代码

我们可以简单覆写某个对象的 valueOf 方法，即可以发现其运算结果发生了变化：

	let obj = {
	    valueOf:() => {
	        return 0;
	    }
	}

	obj + 1 // 1复制代码

如果我们强制将某个对象的 `valueOf` 与 `toString` 方法都覆写为返回值为对象的方法，则会直接抛出异常。

	obj = {
	        valueOf: function () {
	            console.log("valueOf");
	            return {}; // not a primitive
	        },
	        toString: function () {
	            console.log("toString");
	            return {}; // not a primitive
	        }
	    }

	obj + 1
	// error
	Uncaught TypeError: Cannot convert object to primitive value
	    at <anonymous>:1:5复制代码

值得一提的是对于数值类型的 `valueOf()` 函数的调用结果仍为数组，因此数组类型的隐式类型转换结果是字符串。而在 ES6 中引入 Symbol 类型之后，JavaScript 会优先调用对象的 [Symbol.toPrimitive] 方法来将该对象转化为原始类型，那么方法的调用顺序就变为了：

- 当 `obj[Symbol.toPrimitive](preferredType)` 方法存在时，优先调用该方法；
- 如果 preferredType 参数为 String，则依次尝试 `obj.toString()` 与 `obj.valueOf()`；
- 如果 preferredType 参数为 Number 或者默认值，则依次尝试 `obj.valueOf()` 与 `obj.toString()`。

而 [Symbol.toPrimitive] 方法的签名为：

	obj[Symbol.toPrimitive] = function(hint) {
	  // return a primitive value
	  // hint = one of "string", "number", "default"
	}复制代码

我们同样可以通过覆写该方法来修改对象的运算表现：

	user = {
	  name: "John",
	  money: 1000,

	  [Symbol.toPrimitive](hint) {
	    console.log(`hint: ${hint}`);
	    return hint == "string" ? `{name: "${this.name}"}` : this.money;
	  }
	};

	// conversions demo:
	console.log(user); // hint: string -> {name: "John"}
	console.log(+user); // hint: number -> 1000
	console.log(user + 500); // hint: default -> 1500复制代码

## 比较运算

JavaScript 为我们提供了严格比较与类型转换比较两种模式，严格比较（===）只会在操作符两侧的操作对象类型一致，并且内容一致时才会返回为 true，否则返回 false。而更为广泛使用的 == 操作符则会首先将操作对象转化为相同类型，再进行比较。对于 <= 等运算，则会首先转化为原始对象（Primitives），然后再进行对比。

标准的相等性操作符（== 与 !=）使用了[Abstract Equality Comparison Algorithm](https://link.juejin.im/?target=http%3A%2F%2Fwww.ecma-international.org%2Fecma-262%2F5.1%2F%23sec-11.9.3)来比较操作符两侧的操作对象（x == y），该算法流程要点提取如下：

- 如果 x 或 y 中有一个为 NaN，则返回 false；
- 如果 x 与 y 皆为 null 或 undefined 中的一种类型，则返回 true（null == undefined // true）；否则返回 false（null == 0 // false）；
- 如果 x,y 类型不一致，且 x,y 为 String、Number、Boolean 中的某一类型，则将 x,y 使用 toNumber 函数转化为 Number 类型再进行比较；
- 如果 x，y 中有一个为 Object，则首先使用 ToPrimitive 函数将其转化为原始类型，再进行比较。

我们再来回顾下文首提出的 `[] == ![]` 这个比较运算，首先 `[]` 为对象，则调用 ToPrimitive 函数将其转化为字符串 `""`；对于右侧的 `![]`，首先会进行显式类型转换，将其转化为 false。然后在比较运算中，会将运算符两侧的运算对象都转化为数值类型，即都转化为了 0，因此最终的比较结果为 true。在上文中还介绍了 `null >= 0` 为 true 的这种比较结果，在 ECMAScript 中还规定，如果 `<` 为 false，则 `>=` 为 true。

## 加法运算

对于加法运算而言，JavaScript 首先会将操作符两侧的对象转换为 Primitive 类型；然后当适当的隐式类型转换能得出有意义的值的前提下，JavaScript 会先进行隐式类型转换，再进行运算。譬如 value1 + value2 这个表达式，首先会调用 ToPrimitive 函数将两个操作数转化为原始类型：

	prim1 := ToPrimitive(value1)
	prim2 := ToPrimitive(value2)复制代码

这里将会优先调用除了 Date 类型之外对象的 `valueOf` 方法，而因为数组的 `valueOf` 方法的返回值仍为数组类型，则会返回其字符串表示。而经过转换之后的 prim1 与 prim2 中的任一个为字符串，则会优先进行字符串连接；否则进行加法计算。
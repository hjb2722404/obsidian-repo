处理 JS 中 undefined 的 7 个技巧

>

> 原文：> [> dmitripavlutin.com/7-tips-to-h…](https://dmitripavlutin.com/7-tips-to-handle-undefined-in-javascript/)

>
> 译者：前端小智
>
> 你知道的越多，你不知道的越多
>
> 点赞再看，养成习惯
>

> 本文 **> GitHub：**> [> github.com/qq449245884…](https://github.com/qq449245884/xiaozhi)>  上已经收录，更多往期高赞文章的分类，也整理了很多我的文档，和教程资料。欢迎 Star 和完善，大家面试可以参照考点复习，希望我们一起有点东西。

**为了保证的可读性，本文采用意译而非直译。**

大约 8 年前，当原作者开始学习 JS 时，遇到了一个奇怪的情况，既存在`undefined` 的值，也存在表示空值的`null`。它们之间的明显区别是什么? 它们似乎都定义了空值，而且，比较`null == undefined`的计算结果为`true`。

大多数现代语言，如 Ruby、Python 或 Java 都有一个空值 (`nil`或`null`)，这似乎是一种合理的方式。
对于 JavaScript，解释器在访问尚未初始化的变量或对象属性时返回`undefined`。例如：

	let company;
	company;    // =&gt; undefined
	let person = { name: 'John Smith' };
	person.age; // =&gt; undefined
	复制代码

另一方面，`null`表示缺少的对象引用，JS 本身不会将变量或对象属性设置为`null`。
一些原生方法，比如`String.prototype.match()`，可以返回`null`来表示丢失的对象。看看下面的示例：

	let array = null;
	array;                // =&gt; null
	let movie = { name: 'Starship Troopers',  musicBy: null };
	movie.musicBy;        // =&gt; null
	'abc'.match(/\[0-9\]/); // =&gt; null
	复制代码

由于 JS 的宽容特性，开发人员很容易访问未初始化的值，我也犯了这样的错误。
通常，这种危险的操作会生成`undefined` 的相关错误，从而快速地结束脚本。相关的常见错误消息有:

- `TypeError: 'undefined' is not a function`
- `TypeError: Cannot read property '&lt;prop-name&gt;' of undefined`
- `type errors`

JS 开发人员可以理解这个笑话的讽刺：

	function undefined() {
	  // problem solved
	}
	复制代码

为了降低此类错误的风险，必须理解生成`undefined`的情况。更重要的是抑制它的出现并阻止在应用程序中传播，从而提高代码的持久性。
让咱们详细讨论`undefined` 及其对代码安全性的影响。

## undefined 是什么鬼

JS 有 6 种基本类型

- Boolean: `true` 或 `false`
- Number: `1, 6.7, 0xFF`
- String: `"Gorilla and banana"`
- Symbol: `Symbol("name")` (starting ES2015)
- Null: `null`
- Undefined: `undefined`.

和一个单独的`Object` 类型:`{name: "Dmitri"}， ["apple"， "orange"]`。

根据 [ECMAScript 规范](https://www.ecma-international.org/ecma-262/7.0/#sec-undefined-value)，从 6 种原始类型中，`undefined`是一个特殊的值，它有自己的`Undefined`类型。

>
> 未为变量赋值时默认值为`undefined`> 。
该标准明确定义，当访问未初始化的变量、不存在的对象属性、不存在的数组元素等时，将接收到一个`undefined` 的值。例如

	let number;
	number;     // =&gt; undefined
	
	let movie = { name: 'Interstellar' };
	movie.year; // =&gt; undefined
	
	let movies = \['Interstellar', 'Alexander'\];
	movies\[3\];  // =&gt; undefined
	复制代码

上述代码大致流程：

- 未初始化的变量`number`
- 一个不存在的对象属性`movie.year`
- 或者不存在数组元素 movies[3](https://mathiasbynens.be/notes/es6-const)

都会被定义为`undefined`。
ECMAScript 规范定义了`undefined` 值的类型
>
**> Undefined type**>  是其唯一值为`undefined`>  值的类型。
在这个意义上，`typeof undefined`返回 “undefined” 字符串

	typeof undefined === 'undefined'; // =&gt; true
	复制代码

当然`typeof`可以很好地验证变量是否包含`undefined`的值

	let nothing;
	typeof nothing === 'undefined';   // =&gt; true
	复制代码

## 2. 创建未定义的常见场景

#### 2.1 未初始化变量

尚未赋值（未初始化）的声明变量默认为`undefined`。

	let myVariable;
	myVariable; // =&gt; undefined
	复制代码

`myVariable`已声明，但尚未赋值, 默认值为`undefined`。

解决未初始化变量问题的有效方法是尽可能分配初始值。 变量在未初始化状态中越少越好。 理想情况下，你可以在声明`const myVariable ='Initial value'`之后立即指定一个值，但这并不总是可行的。

**技巧 1：使用 let 和 const 来代替 var**

在我看来，ES6 最好的特性之一是使用`const`和`let`声明变量的新方法。`const`和`let`具有块作用域 (与旧的函数作用域`var`相反)，在声明行之前都存在于[暂时性死区](https://mathiasbynens.be/notes/es6-const)。

当变量一次性且永久地接收到一个值时，建议使用`const`声明，它创建一个不可变的绑定。

`const`的一个很好的特性是必须为变量`const myVariable ='initial'`分配一个初始值。 变量未暴露给未初始化状态，并且访问`undefined`是不可能的。

以下示例检查验证一个单词是否是回文的函数：

	function isPalindrome(word) {
	  const length = word.length;
	  const half = Math.floor(length / 2);
	  for (let index = 0; index &lt; half; index++) {
	    if (word\[index\] !== word\[length - index - 1\]) {
	      return false;
	    }
	  }
	  return true;
	}
	isPalindrome('madam'); // =&gt; true
	isPalindrome('hello'); // =&gt; false
	复制代码

`length` 和 `half` 变量被赋值一次。将它们声明为`const`似乎是合理的，因为这些变量不会改变。
如果需要重新绑定变量 (即多次赋值)，请应用`let`声明。只要可能，立即为它赋一个初值，例如，`let index = 0`。
那么使用 `var` 声明呢，相对于 ES6，建议是完全停止使用它。

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231094501.webp)

`var` 声明的变量提会被提升到整个函数作用域顶部。可以在函数作用域末尾的某个地方声明`var`变量，但是仍然可以在声明之前访问它: 对应变量的值是 `undefined`。

相反，用`let` 或者 `const` 声明的变量之前不能访问该变量。之所以会发生这种情况，是因为变量在声明之前处于[暂时死区](https://dmitripavlutin.com/variables-lifecycle-and-why-let-is-not-hoisted/#5-let-variables-lifecycle)。这很好，因为这样就很少有机会访问到 `undefined` 值。

使用`let`（而不是 var）更新的上述示例会引发`ReferenceError` 错误，因为无法访问暂时死区中的变量。

	function bigFunction() {
	  // code...
	  myVariable; // =&gt; Throws 'ReferenceError: myVariable is not defined'
	  // code...
	  let myVariable = 'Initial value';
	  // code...
	  myVariable; // =&gt; 'Initial value'
	}
	bigFunction();
	复制代码

**技巧 2: 增加内聚性**
内聚描述模块的元素 (命名空间、类、方法、代码块) 内聚在一起的程度。凝聚力的测量通常被称为高凝聚力或低内聚。
高内聚是优选的​​，因为它建议设计模块的元素以仅关注单个任务，它构成了一个模块。

- 专注且易懂：更容易理解模块的功能
- 可维护且更容易重构：模块中的更改会影响更少的模块
- 可重用：专注于单个任务，使模块更易于重用
- 可测试：可以更轻松地测试专注于单个任务的模块

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231094536.webp)

高内聚和低耦合是一个设计良好的系统的特征。
代码块本身可能被视为一个小模块，为了尽可能实现高内聚，需要使变量尽可能接近使用它们代码块位置。
例如，如果一个变量仅存在以形成块作用域内，不要将此变量公开给外部块作用域，因为外部块不应该关心此变量。
不必要地延长变量生命周期的一个典型例子是函数中`for`循环的使用：

	function someFunc(array) {
	  var index, item, length = array.length;
	  // some code...
	  // some code...
	  for (index = 0; index &lt; length; index++) {
	    item = array\[index\];
	    // some code...
	  }
	  return 'some result';
	}
	复制代码

`index`，`item`和`length`变量在函数体的开头声明，但是，它们仅在最后使用，那么这种方式有什么问题呢？
从顶部的声明到`for`语句中变量 index 和 item 都是未初始化的，值为 `undefined`。它们在整个函数作用域内具有不合理较长的生命周期。
一种更好的方法是将这些变量尽可能地移动到使用它们的位置：

	function someFunc(array) {
	  // some code...
	  // some code...
	  const length = array.length;
	  for (let index = 0; index &lt; length; index++) {
	    const item = array\[index\];
	    // some
	  }
	  return 'some result';
	}
	复制代码

`index`和`item`变量仅存在于`for`语句的作用域内，`for` 之外没有任何意义。`length`变量也被声明为接近其使用它的位置。
为什么修改后的版本优于初始版本？ 主要有几点：

- 变量未暴露`undefined`状态，因此没有访问`undefined`的风险
- 将变量尽可能地移动到它们的使用位置会增加代码的可读性
- 高内聚的代码块在必要时更容易重构并提取到单独的函数中

#### 2.2 访问不存在的属性

>
> 访问不存在的对象属性时，JS 返回`undefined`> 。
咱们用一个例子来说明这一点：

	let favoriteMovie = {
	  title: 'Blade Runner'
	};
	favoriteMovie.actors; // =&gt; undefined
	复制代码

`favoriteMovie`是一个具有单个属性 `title` 的对象。 使用属性访问器`favoriteMovie.actors`访问不存在的属性`actors`将被计算为`undefined`。

本身访问不存在的属性不会引发错误， 但尝试从不存在的属性值中获取数据时就会出现问题。 常见的的错误是 `TypeError: Cannot read property &lt;prop&gt; of undefined`。

稍微修改前面的代码片段来说明`TypeError throw`：

	let favoriteMovie = {
	  title: 'Blade Runner'
	};
	favoriteMovie.actors\[0\];
	// TypeError: Cannot read property '0' of undefined
	复制代码

`favoriteMovie`没有属性`actors`，所以`favoriteMovie.actors`的值 `undefined`。因此，使用表达式`favoriteMovie.actors[0]`访问`undefined`值的第一项会引发`TypeError`。

JS 允许访问不存在的属性，这种允许访问的特性容易引起混淆: 可能设置了属性，也可能没有设置属性, 绕过这个问题的理想方法是限制对象始终定义它所持有的属性。
不幸的是，咱们常常无法控制对象。在不同的场景中，这些对象可能具有不同的属性集，因此，必须手动处理所有这些场景：

接着我们实现一个函数`append(array, toAppend)`，它的主要功能在数组的开头和 / 或末尾添加新的元素。 `toAppend`参数接受具有属性的对象：

- first：元素插入数组的开头
- last：元素在数组末尾插入。

函数返回一个新的数组实例，而不改变原始数组 (即它是一个纯函数)。
`append()`的第一个版本看起来比较简单，如下所示：

	function append(array, toAppend) {
	  const arrayCopy = array.slice();
	  if (toAppend.first) {
	    arrayCopy.unshift(toAppend.first);
	  }
	  if (toAppend.last) {
	    arrayCopy.push(toAppend.last);
	  }
	  return arrayCopy;
	}
	append(\[2, 3, 4\], { first: 1, last: 5 }); // =&gt; \[1, 2, 3, 4, 5\]
	append(\['Hello'\], { last: 'World' });     // =&gt; \['Hello', 'World'\]
	append(\[8, 16\], { first: 4 });            // =&gt; \[4, 8, 16\]
	复制代码

由于`toAppend`对象可以省略`first`或`last`属性，因此必须验证`toAppend`中是否存在这些属性。如果属性不存在，则属性访问器值为`undefined`。

检查`first`或`last`属性是否是`undefined`, 在条件为 `if(toappendix .first){}`和 i`f(toappendix .last){}`中进行验证：

这种方法有一个缺点， `undefined`，`false`，`null`，`0`，`NaN`和`''`是虚值。
在`append()` 的当前实现中，该函数不允许插入虚值元素：

	append(\[10\], { first: 0, last: false }); // =&gt; \[10\]
	复制代码

`0`和`false`是虚值的。 因为 `if(toAppend.first){}`和`if(toAppend.last){}`实际上与`falsy`进行比较，所以这些元素不会插入到数组中，该函数返回初始数组`[10]`而不会进行任何修改。

以下技巧解释了如何正确检查属性的存在。
**技巧 3: 检查属性是否存在**
JS 提供了许多方法来确定对象是否具有特定属性：

- `obj.prop！== undefined`：直接与`undefined`进行比较
- `typeof obj.prop！=='undefined'`：验证属性值类型
- `obj.hasOwnProperty（'prop'）`：验证对象是否具有自己的属性
- `'prop' in obj`：验证对象是否具有自己的属性或继承属性

我的建议是使用 `in` 操作符，它的语法短小精悍。`in`操作符的存在表明一个明确的意图，即检查对象是否具有特定的属性，而不访问实际的属性值。

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231094544.webp)

`obj.hasOwnProperty('prop')`也是一个很好的解决方案，它比 `in` 操作符稍长，仅在对象自己的属性中进行验证。

涉及与`undefined`进行比较剩下的两种方式可能有效，但在我看来，`obj.prop！== undefined`和`typeof obj.prop！=='undefined'`看起来冗长而怪异，并暴露出直接处理`undefined`的可疑路径。。

让咱们使用`in`操作符改进`append(array, toAppend)` 函数：

	function append(array, toAppend) {
	  const arrayCopy = array.slice();
	  if ('first' in toAppend) {
	    arrayCopy.unshift(toAppend.first);
	  }
	  if ('last' in toAppend) {
	    arrayCopy.push(toAppend.last);
	  }
	  return arrayCopy;
	}
	append(\[2, 3, 4\], { first: 1, last: 5 }); // =&gt; \[1, 2, 3, 4, 5\]
	append(\[10\], { first: 0, last: false });  // =&gt; \[0, 10, false\]
	复制代码

`'first' in toAppend` (和`'last' in toAppend`) 在对应属性存在时为`true`，否则为`false`。`in`操作符的使用解决了插入虚值元素`0`和`false`的问题。现在，在`[10]`的开头和结尾添加这些元素将产生预期的结果`[0,10,false]`。

**技巧 4：解构访问对象属性**
在访问对象属性时，如果属性不存在，有时需要指示默认值。可以使用`in`和三元运算符来实现这一点。

	const object = { };
	const prop = 'prop' in object ? object.prop : 'default';
	prop; // =&gt; 'default'
	复制代码

当要检查的属性数量增加时，三元运算符语法的使用变得令人生畏。对于每个属性，都必须创建新的代码行来处理默认值，这就增加了一堵难看的墙，里面都是外观相似的三元运算符。

为了使用更优雅的方法，可以使用 ES6 对象的解构。
对象解构允许将对象属性值直接提取到变量中，并在属性不存在时设置默认值，避免直接处理`undefined`的方便语法。
实际上，属性提取现在看起来简短而有意义：

	const object = {  };
	const { prop = 'default' } = object;
	prop; // =&gt; 'default'
	复制代码

要查看实际操作中的内容，让我们定义一个将字符串包装在引号中的有用函数。`quote(subject, config)`接受第一个参数作为要包装的字符串。 第二个参数`config`是一个具有以下属性的对象：

- char：包装的字符，例如 `'`（单引号）或`“`（双引号），默认为`”`。
- `skipIfQuoted`：如果字符串已被引用则跳过引用的布尔值，默认为`true`。

使用对象析构的优点，让咱们实现`quote()`

	function quote(str, config) {
	  const { char = '"', skipIfQuoted = true } = config;
	  const length = str.length;
	  if (skipIfQuoted
	      &amp;&amp; str\[0\] === char
	      &amp;&amp; str\[length - 1\] === char) {
	    return str;
	  }
	  return char + str + char;
	}
	quote('Hello World', { char: '\*' });        // =&gt; '\*Hello World\*'
	quote('"Welcome"', { skipIfQuoted: true }); // =&gt; '"Welcome"'
	复制代码

`const {char = '"， skipifquote = true} = config`解构赋值在一行中从`config`对象中提取`char`和`skipifquote`属性。如果`config`对象中有一些属性不可用，那么解构赋值将设置默认值:`char`为`'"'`，`skipifquote`为`false`。

该功能仍有改进的空间。让我们将解构赋值直接移动到参数部分。并为`config`参数设置一个默认值 (空对象`{}`)，以便在默认设置足够时跳过第二个参数。

	function quote(str, { char = '"', skipIfQuoted = true } = {}) {
	  const length = str.length;
	  if (skipIfQuoted
	      &amp;&amp; str\[0\] === char
	      &amp;&amp; str\[length - 1\] === char) {
	    return str;
	  }
	  return char + str + char;
	}
	quote('Hello World', { char: '\*' }); // =&gt; '\*Hello World\*'
	quote('Sunny day');                  // =&gt; '"Sunny day"'
	复制代码

注意，解构赋值替换了函数 `config` 参数。我喜欢这样:`quote()`缩短了一行。 `={}`在解构赋值的右侧，确保在完全没有指定第二个参数的情况下使用空对象。

对象解构是一个强大的功能，可以有效地处理从对象中提取属性。 我喜欢在被访问属性不存在时指定要返回的默认值的可能性。因为这样可以避免`undefined`以及与处理它相关的问题。

**技巧 5: 用默认属性填充对象**
如果不需要像解构赋值那样为每个属性创建变量，那么丢失某些属性的对象可以用默认值填充。

ES6 `Object.assign（target，source1，source2，...）`将所有可枚举的自有属性的值从一个或多个源对象复制到目标对象中, 该函数返回目标对象。

例如，需要访问`unsafeOptions`对象的属性，该对象并不总是包含其完整的属性集。
为了避免从`unsafeOptions`访问不存在的属性，让我们做一些调整:

- 定义包含默认属性值的`defaults`对象
- 调用`Object.assign（{}，defaults，unsafeOptions）`来构建新的对象`options`。 新对象从`unsafeOptions`接收所有属性，但缺少的属性从`defaults`对象获取。

	    const unsafeOptions = {
	      fontSize: 18
	    };
	    const defaults = {
	      fontSize: 16,
	      color: 'black'
	    };
	    const options = Object.assign({}, defaults, unsafeOptions);
	    options.fontSize; // =&gt; 18
	    options.color;    // =&gt; 'black'
	复制代码

`unsafeOptions`仅包含`fontSize`属性。 `defaults`对象定义属性`fontSize`和`color`的默认值。

`Object.assign()` 将第一个参数作为目标对象`{}`。 目标对象从`unsafeOptions`源对象接收`fontSize`属性的值。 并且人`defaults`对象的获取`color`属性值，因为`unsafeOptions`不包含`color`属性。

枚举源对象的顺序很重要：后面的源对象属性会覆盖前面的源对象属性。
现在可以安全地访问`options`对象的任何属性，包括`options.color`在最初的`unsafeOptions`中是不可用的。
还有一种简单的方法就是使用 ES6 中展开运算符：

	const unsafeOptions = {
	  fontSize: 18
	};
	const defaults = {
	  fontSize: 16,
	  color: 'black'
	};
	const options = {
	  ...defaults,
	  ...unsafeOptions
	};
	options.fontSize; // =&gt; 18
	options.color;    // =&gt; 'black'
	复制代码

对象初始值设定项从`defaults`和`unsafeOptions`源对象扩展属性。 指定源对象的顺序很重要，后面的源对象属性会覆盖前面的源对象。
使用默认属性值填充不完整的对象是使代码安全且持久的有效策略。无论哪种情况，对象总是包含完整的属性集: 并且无法生成`undefined`的属性。

#### 2.3 函数参数

>
> 函数参数隐式默认为`undefined`> 。
通常，用特定数量的参数定义的函数应该用相同数量的参数调用。在这种情况下，参数得到期望的值

	function multiply(a, b) {
	  a; // =&gt; 5
	  b; // =&gt; 3
	  return a \* b;
	}
	multiply(5, 3); // =&gt; 15
	复制代码

调用`multiply(5,3)`使参数`a`和`b`接收相应的`5`和`3`值，返回结果:`5 * 3 = 15`。
在调用时省略参数会发生什么?

	function multiply(a, b) {
	  a; // =&gt; 5
	  b; // =&gt; undefined
	  return a \* b;
	}
	multiply(5); // =&gt; NaN
	复制代码

函数`multiply(a, b){}`由两个参数`a`和`b`定义。调用`multiply(5)`用一个参数执行: 结果一个参数是`5`，但是`b`参数是`undefined`。

**技巧 6: 使用默认参数值**
有时函数不需要调用的完整参数集，可以简单地为没有值的参数设置默认值。
回顾前面的例子，让我们做一个改进，如果`b`参数未定义，则为其分配默认值`2`：

	function multiply(a, b) {
	  if (b === undefined) {
	    b = 2;
	  }
	  a; // =&gt; 5
	  b; // =&gt; 2
	  return a \* b;
	}
	multiply(5); // =&gt; 10
	复制代码

虽然所提供的分配默认值的方法有效，但不建议直接与`undefined`值进行比较。它很冗长，看起来像一个 hack .
这里可以使用 ES6 的默认值：

	function multiply(a, b = 2) {
	  a; // =&gt; 5
	  b; // =&gt; 2
	  return a \* b;
	}
	multiply(5);            // =&gt; 10
	multiply(5, undefined); // =&gt; 10
	复制代码

#### 2.4 函数返回值

>
> 隐式地，没有`return`> 语句，JS 函数返回`undefined`> 。
在 JS 中，没有任何`return`语句的函数隐式返回`undefined`：

	function square(x) {
	  const res = x \* x;
	}
	square(2); // =&gt; undefined
	复制代码

`square()` 函数没有返回计算结果，函数调用时的结果`undefined`。
当`return`语句后面没有表达式时，默认返回 `undefined`。

	function square(x) {
	  const res = x \* x;
	  return;
	}
	square(2); // =&gt; undefined
	复制代码

`return;` 语句被执行，但它不返回任何表达式，调用结果也是`undefined`。

	function square(x) {
	  const res = x \* x;
	  return res;
	}
	square(2); // =&gt; 4
	复制代码

**技巧 7: 不要相信自动插入分号**
JS 中的以下语句列表必须以分号`(;)`结尾：

- 空语句
- `let,const,var,import,export`声明
- 表达语句
- `debugger` 语句
- `continue` 语句，`break` 语句
- `throw` 语句
- `return` 语句

如果使用上述声明之一，请尽量务必在结尾处指明**分号**：

	function getNum() {
	  let num = 1;
	  return num;
	}
	getNum(); // =&gt; 1
	复制代码

`let` 声明和`return` 语句结束时，强制性写**分号**。
当你不想写这些分号时会发生什么？ 例如，咱们想要减小源文件的大小。

在这种情况下，ECMAScript 提供[自动分号插入（ASI）机制](http://www.ecma-international.org/ecma-262/6.0/index.html#sec-automatic-semicolon-insertion)，为你插入**缺少的分号**。

ASI 的帮助下，可以从上一个示例中**删除分号**：

function getNum() { // Notice that semicolons are missing let num = 1 return num } getNum() // =&gt; 1

上面的代码是有效的 JS 代码, 缺少的**分号** ASI 会自动为我们插入。
乍一看，它看起来很 nice。 ASI 机制允许你少写不必要的分号，可以使 JS 代码更小，更易于阅读。

ASI 创建了一个小而烦人的陷阱。 当换行符位于`return`和`return \n expression`之间时，ASI 会在换行符之前自动插入分号 (`return; \n expression`)。

函数内部`return;` ？ 即该函数返回`undefined`。 如果你不详细了解 ASI 的机制，则意外返回的`undefined`会产生意想不到的问题。

来 `getPrimeNumbers()`调用返回的值：

	function getPrimeNumbers() {
	  return
	    \[ 2, 3, 5, 7, 11, 13, 17 \]
	}
	getPrimeNumbers() // =&gt; undefined
	复制代码

在`return`语句和数组之间存在一个换行, JS 在`return`后自动插入分号，解释代码如下：

	function getPrimeNumbers() {
	  return;
	  \[ 2, 3, 5, 7, 11, 13, 17 \];
	}
	getPrimeNumbers(); // =&gt; undefined
	复制代码

`return;` 使函数`getPrimeNumbers()` 返回`undefined`而不是期望的数组。
这个问题通过删除`return`和数组文字之间的换行来解决:

	function getPrimeNumbers() {
	  return \[
	    2, 3, 5, 7, 11, 13, 17
	  \];
	}
	getPrimeNumbers(); // =&gt; \[2, 3, 5, 7, 11, 13, 17\]
	复制代码

我的建议是研究[自动分号插入的确切方式](http://www.bradoncode.com/blog/2015/08/26/javascript-semi-colon-insertion/)，以避免这种情况。

当然，永远不要在`return`和返回的表达式之间放置换行符。

#### 2.5 void 操作符

`void &lt;expression&gt;`计算表达式无论计算结果如何都返回`undefined` 。

	void 1;                    // =&gt; undefined
	void (false);              // =&gt; undefined
	void {name: 'John Smith'}; // =&gt; undefined
	void Math.min(1, 3);       // =&gt; undefined
	复制代码

`void`操作符的一个用例是将表达式求值限制为`undefined`，这依赖于求值的一些副作用。

## 3. 未定义的数组

访问越界索引的数组元素时，会得到`undefined` 。

	const colors = \['blue', 'white', 'red'\];
	colors\[5\];  // =&gt; undefined
	colors\[-1\]; // =&gt; undefined
	复制代码

`colors`数组有 3 个元素，因此有效索引为`0,1`和`2`。
因为索引`5`和`-1`没有数组元素，所以访问`colors[5]`和`colors[-1]`值为`undefined`。
JS 中，可能会遇到所谓的稀疏数组。这些数组是有间隙的数组，也就是说，在某些索引中，没有定义元素。
当在稀疏数组中访问间隙（也称为空槽）时，也会得到一个`undefined`。
下面的示例生成稀疏数组并尝试访问它们的空槽

	const sparse1 = new Array(3);
	sparse1;       // =&gt; \[&lt;empty slot&gt;, &lt;empty slot&gt;, &lt;empty slot&gt;\]
	sparse1\[0\];    // =&gt; undefined
	sparse1\[1\];    // =&gt; undefined
	const sparse2 = \['white',  ,'blue'\]
	sparse2;       // =&gt; \['white', &lt;empty slot&gt;, 'blue'\]
	sparse2\[1\];    // =&gt; undefined
	复制代码

使用数组时，为了避免获取`undefined`，请确保使用有效的数组索引并避免创建稀疏数组。

## 4. undefined 和 null 之间的区别

一个合理的问题出现了:`undefined`和`null`之间的主要区别是什么? 这两个特殊值都表示为空状态。
主要区别在于`undefined`表示尚未初始化的变量的值，`null`表示故意不存在对象。
让咱们通过一些例子来探讨它们之间的区别。
number 定义了但没有赋值。

	let number;
	number; // =&gt; undefined
	复制代码

`number` 变量未定义，这清楚地表明未初始化的变量。
当访问不存在的对象属性时，也会发生相同的未初始化概念

	const obj = { firstName: 'Dmitri' };
	obj.lastName; // =&gt; undefined
	复制代码

因为`obj`中不存在`lastName`属性，所以 JS 正确地将`obj.lastName`计算为`undefined`。
在其他情况下，你知道变量期望保存一个对象或一个函数来返回一个对象。但是由于某些原因，你不能实例化该对象。在这种情况下，`null`是丢失对象的有意义的指示器。
例如，`clone()`是一个克隆普通 JS 对象的函数，函数将返回一个对象

	function clone(obj) {
	  if (typeof obj === 'object' &amp;&amp; obj !== null) {
	    return Object.assign({}, obj);
	  }
	  return null;
	}
	clone({name: 'John'}); // =&gt; {name: 'John'}
	clone(15);             // =&gt; null
	clone(null);           // =&gt; null
	复制代码

但是，可以使用非对象参数调用`clone()`: `15`或`null`(或者通常是一个原始值，`null`或`undefined`)。在这种情况下，函数不能创建克隆，因此返回`null`—— 一个缺失对象的指示符。

`typeof`操作符区分了这两个值

	typeof undefined; // =&gt; 'undefined'
	typeof null;      // =&gt; 'object'
	复制代码

严格相等运算符`===`可以正确区分`undefined`和`null`：

	let nothing = undefined;
	let missingObject = null;
	nothing === missingObject; // =&gt; false
	复制代码

## 总结

`undefined`的存在是 JS 的允许性质的结果，它允许使用：

- 未初始化的变量
- 不存在的对象属性或方法
- 访问越界索引的数组元素
- 不返回任何结果的函数的调用结果

大多数情况下直接与`undefined`进行比较是一种不好的做法。一个有效的策略是减少代码中`undefined`关键字的出现：

- 减少未初始化变量的使用
- 使变量生命周期变短并接近其使用的位置
- 尽可能为变量分配初始值
- 多敷衍 const 和 let
- 使用默认值来表示无关紧要的函数参数
- 验证属性是否存在或使用默认属性填充不安全对象
- 避免使用稀疏数组

代码部署后可能存在的 BUG 没法实时知道，事后为了解决这些 BUG，花了大量的时间进行 log 调试，这边顺便给大家推荐一个好用的 BUG 监控工具 [Fundebug](https://www.fundebug.com/?utm_source=xiaozhi)。

## 交流（欢迎加入群，群工作日都会发红包，互动讨论技术）

干货系列文章汇总如下，觉得不错点个 Star，欢迎 加群 互相学习。
>
> [> github.com/qq449245884…](https://github.com/qq449245884/xiaozhi)
我是小智，公众号「大迁世界」作者，**对前端技术保持学习爱好者。我会经常分享自己所学所看的干货**，在进阶的路上，共勉！
关注公众号，后台回复**福利**，即可看到福利，你懂的。

![](https://user-gold-cdn.xitu.io/2019/8/1/16c4a80bb29120db?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

**每次整理文章，一般都到 2 点才睡觉，一周 4 次左右，挺苦的，还望支持，给点鼓励**

![](https://user-gold-cdn.xitu.io/2019/9/29/16d7c9e2a5bfb741?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)
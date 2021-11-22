更简单的使用indexOf实现contains功能

# 更简单的使用indexOf实现contains功能

 By [@jhogoforbroke](https://twitter.com/jhogoforbroke)  on Jan 15, 2016

JavaScript并未提供contains方法。检测子字符串是否存在于字符串或者变量是否存在于数组你可能会这样做：

	var someText = 'javascript rules';
	if (someText.indexOf('javascript') !== -1) {
	}

	// or
	if (someText.indexOf('javascript') >= 0) {
	}

但是让我们看一下这些 [Expressjs](https://github.com/strongloop/express)代码段。

[examples/mvc/lib/boot.js](https://github.com/strongloop/express/blob/2f8ac6726fa20ab5b4a05c112c886752868ac8ce/examples/mvc/lib/boot.js#L26)

	for (var key in obj) {
	  // "reserved" exports
	  if (~['name', 'prefix', 'engine', 'before'].indexOf(key)) continue;

[lib/utils.js](https://github.com/strongloop/express/blob/2f8ac6726fa20ab5b4a05c112c886752868ac8ce/lib/utils.js#L93)

	exports.normalizeType = function(type){
	  return ~type.indexOf('/')
	    ? acceptParams(type)
	    : { value: mime.lookup(type), params: {} };
	};

[examples/web-service/index.js](https://github.com/strongloop/express/blob/2f8ac6726fa20ab5b4a05c112c886752868ac8ce/examples/web-service/index.js#L35)

	// key is invalid
	if (!~apiKeys.indexOf(key)) return next(error(401, 'invalid api key'));

难点是 [位操作符](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Bitwise_Operators)  **~**, “按位操作符操作数字的二进制形式，但是返回值依然是标准的JavaScript数值。”

它将`-1`转换为`0`,而`0`在javascript为`false`,所以:

	var someText = 'text';
	!!~someText.indexOf('tex'); // someText contains "tex" - true
	!~someText.indexOf('tex'); // someText NOT contains "tex" - false
	~someText.indexOf('asd'); // someText doesn't contain "asd" - false
	~someText.indexOf('ext'); // someText contains "ext" - true

### String.prototype.includes()

在ES6中提供了[includes() 方法](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/includes)供我们判断一个字符串是否包含了另一个字符串:

	'something'.includes('thing'); // true

在ECMAScript 2016 (ES7)甚至可能将其应用于数组，像indexOf一样:

	!!~[1, 2, 3].indexOf(1); // true
	[1, 2, 3].includes(1); // true

**不幸的是, 只有Chrome、Firefox、Safari 9及其更高版本和Edge支持了这功能。IE11及其更低版本并不支持****最好在受控的环境中使用此功能**

 [(L)](https://www.jstips.co/book/?utm_source=jstips&utm_medium=banner&utm_campaign=book&utm_content=interview)
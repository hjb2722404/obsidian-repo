1000+ 个项目的10大JavaScript错误

# 1000+ 个项目的10大JavaScript错误

[![v2-7b8847a2790af4b5b5b2e3c75dd41aec_l.jpg](../_resources/7b8847a2790af4b5b5b2e3c75dd41aec.png)](https://www.zhihu.com/people/kai-ke-ba-xiao-yi)

[开课吧小易](https://www.zhihu.com/people/kai-ke-ba-xiao-yi)
开课吧，数字化人才在线教育平台。

![v2-cf9913e6d3a40720bd8fcf4e59d57bfb_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/cf9913e6d3a40720bd8fcf4e59d57bfb.jpg)

为了便于阅读，每个错误都被缩短了，让我们更深入地研究每一个问题，以确定是什么导致了这些问题，以及如何避免产生这些问题。

## **1. Uncaught TypeError: Cannot read property**

如果你是一个JavaScript开发人员，你可能已经看到过这个错误。当你读取属性或在未定义对象上调用方法时，Chrome中就会发生这种情况。你可以在Chrome开发者控制台中轻松进行测试。

![v2-bb61860feecff010bfe6f2791d3be446_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/8f3fb380d3d644d4cd703c1e207acad8.jpg)

发生这种情况的原因有很多，但常见的原因是渲染UI组件时状态初始化不当。让我们来看一个在现实应用中如何发生这种情况的示例。我们将选择React，但是不正确初始化的相同原理也适用于Angular，Vue或任何其他框架。

	class Quiz extends Component {
	  componentWillMount() {
	    axios.get('/thedata').then(res => {
	      this.setState({items: res.data});
	    });
	  }
	  render() {
	    return (
	      <ul>
	        {this.state.items.map(item =>
	          <li key={item.id}>{item.name}</li>
	        )}
	      </ul>
	    );
	  }
	}

这里有两件重要的事情要意识到：

- • 组件的状态（例如 `this.state`）以 `undefined` 状态开始使用。
- • 当你异步获取数据时，无论数据是在构造函数 `componentWillMount` 还是 `componentDidMount` 中获取，组件都将在数据加载之前至少渲染一次。当Quiz第一次渲染时，`this.state.items` 是 `undefined`。这反过来又意味着ItemList会得到未定义的items，你会在控制台中得到一个错误——"UncaughtTypeError: Cannot read property 'map' of undefined "的错误。

这很容易解决，最简单的方法：在构造函数中使用合理的默认值初始化状态。

	class Quiz extends Component {
	  // 添加了这个:
	  constructor(props) {
	    super(props);
	    this.state = {
	      items: [] // 默认值
	    };
	  }
	  componentWillMount() {
	    axios.get('/thedata').then(res => {
	      this.setState({items: res.data});
	    });
	  }
	  render() {
	    return (
	      <ul>
	        {this.state.items.map(item =>
	          <li key={item.id}>{item.name}</li>
	        )}
	      </ul>
	    );
	  }
	}

你的应用程序中的实际代码可能会有不同，但我希望已经给了你足够的线索，让你在你的应用程序中修复或避免这个问题。如果没有，请继续阅读，因为我将在下面介绍有关相关错误的更多示例。

## **2. TypeError: ‘undefined’ is not an object (evaluating**

这是在Safari中读取属性或调用`undefined`对象上的方法时发生的错误，你可以在Safari开发者控制台中非常轻松地进行测试。这基本上与上述针对Chrome的错误相同，但Safari使用了不同的错误消息。

## **3. TypeError: null is not an object (evaluating**

这是在Safari中读取属性或调用`null`对象上的方法时发生的错误，你可以在Safari开发者控制台中非常轻松地进行测试。

有趣的是，在JavaScript中，null和undefined不相同，这就是为什么我们看到两个不同的错误消息的原因。**undefined通常是尚未分配的变量，而null表示该值为空白。** 要验证它们是否相等，请尝试使用严格相等运算符。

在实际示例中可能发生这种错误的一种方式是，在加载元素之前尝试在JavaScript中使用DOM元素，这是因为DOM API对于空白的对象引用返回null。

任何执行和处理DOM元素的JS代码都应在创建DOM元素后执行。JS代码按照HTML格式从上到下进行解释，所以，如果在DOM元素之前有一个标签，那么在浏览器解析HTML页面的时候，脚本标签内的JS代码就会被执行。如果在加载脚本之前尚未创建DOM元素，则会出现此错误。

在此示例中，我们可以通过添加事件侦听器来解决该问题，该事件侦听器将在页面准备就绪时通知我们。一旦触发了 `addEventListener`，`init()` 方法就可以使用DOM元素。

	<script>
	  function init() {
	    var myButton = document.getElementById("myButton");
	    var myTextfield = document.getElementById("myTextfield");
	    myButton.onclick = function() {
	      var userName = myTextfield.value;
	    }
	  }
	  document.addEventListener('readystatechange', function() {
	    if (document.readyState === "complete") {
	      init();
	    }
	  });
	</script>
	<form>
	  <input type="text" id="myTextfield" placeholder="Type your name" />
	  <input type="button" id="myButton" value="Go" />
	</form>

## **4. (unknown): Script error**

当未捕获的JavaScript错误违反跨源策略跨越域边界时，将发生脚本错误。例如，如果你将你的JavaScript代码托管在CDN上，任何未被捕获的错误(冒泡到window.onerror处理程序中的错误，而不是在try-catch中被捕获的错误)都会被报告为 "Script error"，而不是包含有用的信息。这是一种浏览器安全措施，旨在防止跨域传递数据，否则该域将无法通信。

要获取真实的错误消息，请执行以下操作。

### **发送Access-Control-Allow-Origin标头**

将 `Access-Control-Allow-Origin` 标头设置为 `*` 表示可以从任何域正确访问资源。你可以根据需要将 `*` 替换为您的域：例如，`Access-Control-Allow-Origin：www.example.com`。但是，处理多个域比较复杂，如果使用CDN可能会出现缓存问题，那么可能不值得花费精力。

以下是一些有关如何在各种环境中设置此标头的示例：
**Apache**
在将提供JavaScript文件的文件夹中，创建一个具有以下内容的 `.htaccess` 文件：
`Header add Access-Control-Allow-Origin "*"`
**Nginx**
将add_header指令添加到提供JavaScript文件的location块中：

	location ~ ^/assets/ {
	    add_header Access-Control-Allow-Origin *;
	}

**HAProxy**
将以下内容添加到提供JavaScript文件的asset后端：
`rspadd Access-Control-Allow-Origin:\ *`

### **在脚本标签上设置crossorigin =“ anonymous”**

在你的HTML源代码中，对于您设置了 `Access-Control-Allow-Origin` 标头的每个脚本，在script标记上设置`crossorigin="anonymous"`。在script标记上添加 `crossorigin` 属性之前，请确保已验证是否已为脚本文件发送了标头。在Firefox中，如果存在 `crossorigin` 属性，但没有 `Access-Control-Allow-Origin` 标头，则不会执行脚本。

## **5. TypeError: Object doesn’t support property**

这是在IE中发生的错误，当您调用undefined的方法时，你可以在IE开发人员控制台中对此进行测试。

![v2-faae60f18ad29192c25c9665d0b0355f_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/faae60f18ad29192c25c9665d0b0355f.jpg)

这等效于Chrome中的错误“ TypeError：‘undefined’ is not a function”。是的，对于相同的逻辑错误，不同的浏览器可能具有不同的错误消息。

这是IE在采用JavaScript命名空间的Web应用程序中常见的问题，在这种情况下，99.9％的问题是IE无法将当前名称空间中的方法绑定到 `this` 关键字。

例如，如果你的JS命名空间 `Rollbar` 使用 `isAwesome` 方法。通常，如果你在 `Rollbar` 名称空间中，则可以使用以下语法调用 `isAwesome` 方法：

`this.isAwesome();`
Chrome，Firefox和Opera将很乐意接受此语法。另一方面，IE则不会。因此，在使用JS命名空间时，最安全的方法是用实际的命名空间作为前缀。
`Rollbar.isAwesome();`

## **6. TypeError: ‘undefined’ is not a function**

这是在Chrome中发生的错误，当你调用undefined的函数时。你可以在Chrome开发者控制台和Mozilla Firefox开发者控制台中对此进行测试。

![v2-ac2ee2201fb1d7f5776c0699646dbc8f_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/ac2ee2201fb1d7f5776c0699646dbc8f.jpg)

随着这些年来JavaScript的编码技术和设计模式越来越复杂，在回调和闭包中的自引用作用域也相应地增多，这也是相当常见的这种或那种混乱的根源。
考虑以下示例代码片段：

	function clearBoard(){
	  alert("Cleared");
	}
	document.addEventListener("click", function(){
	  this.clearBoard(); // 这个 "this" 是什么？
	});

如果执行上述代码，然后单击该页面，则会导致以下错误“ Uncaught TypeError：this.clearBoard not a function”。原因是正在执行的匿名函数是在文档的上下文中，而 `clearBoard` 是在 `window` 中定义的。

传统的、与旧浏览器兼容的解决方案是简单地将对它的引用保存在一个变量中，然后闭包可以继承这个变量。例如：

	var self = this;
	document.addEventListener("click", function(){
	  self.clearBoard();
	});

另外，在较新的浏览器中，可以使用 `bind()` 方法传递正确的引用：
`document.addEventListener("click",this.clearBoard.bind(this));`

## **7. Uncaught RangeError: Maximum call stack**

这是Chrome浏览器在几种情况下出现的错误，一种是调用不终止的递归函数。你可以在Chrome开发者控制台中对此进行测试。

![v2-236b73fc6e91b2475fe876b8fa4afdb9_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/236b73fc6e91b2475fe876b8fa4afdb9.jpg)

如果将值传递给超出范围的函数，也可能会发生这种情况。许多函数的输入值仅接受特定范围的数字，例如，`Number.toExponential(digits)` 和 `Number.toFixed(digits)` 接受0到20之间的数字，而`Number.toFixed(digits)` 接受1到21之间的数字。

	var a = newArray(4294967295);  //OK
	var b = newArray(-1); //range error
	
	var num = 2.555555;
	document.writeln(num.toExponential(4));  //OK
	document.writeln(num.toExponential(-2)); //range error!
	
	num = 2.9999;
	document.writeln(num.toFixed(2));   //OK
	document.writeln(num.toFixed(25));  //range error!
	
	num = 2.3456;
	document.writeln(num.toPrecision(1));   //OK
	document.writeln(num.toPrecision(22));  //range error!

## **8. TypeError: Cannot read property ‘length’**

这是Chrome浏览器中发生的错误，因为读取undefined的变量的length属性，你可以在Chrome开发者控制台中进行测试。

![v2-ee9b47a057753f7c5508c9a1b084985f_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/ee9b47a057753f7c5508c9a1b084985f.jpg)

通常情况下，你可以在数组上找到定义的长度，但如果数组没有初始化或者变量名被隐藏在其他上下文中，你可能会遇到这个错误。通过以下示例让我们了解此错误。

	var testArray= ["Test"];
	function testFunction(testArray) {
	    for (var i = 0; i < testArray.length; i++) {
	      console.log(testArray[i]);
	    }
	}
	testFunction();

当你声明一个带参数的函数时，这些参数就变成了局部参数。这意味着即使你具有名称为 `testArray` 的变量，函数内具有相同名称的参数仍将被视为局部参数。
你可以通过两种方式解决问题：
删除函数声明语句中的参数（事实证明，你想访问那些在函数外部声明的变量，因此你不需要为函数使用参数）

	var testArray = ["Test"];
	
	/* 前置条件:在函数外部定义testArray */
	function testFunction(/* No params */) {
	   for (var i = 0; i < testArray.length; i++) {
	     console.log(testArray[i]);
	   }
	}
	
	testFunction()

调用函数，将我们声明的数组传递给它。

	var testArray = ["Test"];
	
	function testFunction(testArray) {
	  for (var i = 0; i < testArray.length; i++) {
	     console.log(testArray[i]);
	   }
	}
	
	testFunction(testArray);

## **9. Uncaught TypeError: Cannot set property**

当我们尝试访问未定义的变量时，它总是返回 `undefined`，我们无法获取或设置任何 `undefined` 属性。在这种情况下，应用程序将引发“ Uncaught TypeError：Cannot set property”。

例如，在Chrome浏览器中：

![v2-b6692080a30b79ffb29b360fd56c8de3_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/b6692080a30b79ffb29b360fd56c8de3.jpg)

如果 `test` 对象不存在，则错误将引发“ Uncaught TypeError：Cannot set property”。

## **10. ReferenceError: event is not defined**

当您尝试访问`undefined` 或超出当前范围的变量时，将引发此错误。你可以在Chrome浏览器中非常轻松地对其进行测试。

![v2-6de0d968874375495e30c374a2096b9c_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/6de0d968874375495e30c374a2096b9c.jpg)

如果你在使用事件处理系统时收到这个错误，请确保你使用传入的事件对象作为参数。IE等较旧的浏览器会提供全局变量事件，而Chrome会自动将事件变量附加到处理程序。Firefox不会自动添加它。jQuery之类的库试图规范这种行为，尽管如此，最好还是使用传递给事件处理程序函数的方法。

	document.addEventListener("mousemove", function (event) {
	  console.log(event);
	})

## **总结**

事实证明，其中许多都是null或undefined的错误。如果使用严格的编译器选项，像Typescript这样的静态类型检查系统可以帮助你避免使用它们。它可以警告你，如果一个类型是预期的，但还没有被定义。

发布于 08-25
[ Web 开发](https://www.zhihu.com/topic/19550516)
[ 前端开发](https://www.zhihu.com/topic/19550901)
[ JavaScript](https://www.zhihu.com/topic/19552521)
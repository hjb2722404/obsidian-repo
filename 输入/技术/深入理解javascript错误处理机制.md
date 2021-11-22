深入理解javascript错误处理机制

# 深入理解javascript错误处理机制

[![v2-8c640c1643aaa53774bbb4a3b45b05ac_l.jpg](../_resources/8c640c1643aaa53774bbb4a3b45b05ac.jpg)](https://www.zhihu.com/people/zheng-jiu-di-qiu-hao-lei-71)

[小母鸡-KFE](https://www.zhihu.com/people/zheng-jiu-di-qiu-hao-lei-71)

1. 错误分类
javascript错误, 可分为编译时错误, 运行时错误, 资源加载错误。本文着重讨论一下 **运行时错误** 和 **资源加载错误**。

### 1.1 js运行时错误

javascript提供了一种捕获运行时错误的捕获机制。如果代码能够捕获潜在的错误，并能适当处理, 就能确保代码不会在运行时产生意想不到的错误，给用户造成困扰, 这也意味着代码的质量是非常高的。

### 1.1.1 Error实例对象

javaScript 解析或运行时，一旦发生错误，引擎就会抛出一个错误对象。JavaScript 原生提供Error构造函数，所有抛出的错误都是这个构造函数的实例。

Error实例对象的三个属性 * message 错误提示信息 * name 错误名称 * stack 错误的堆栈
例如下面的代码, 打印错误实例对象, 可以得到`message name stack`信息

	var err = new Error('出错了');
	console.dir(err)

![v2-af4d09d8c108a096b7faebd5177a607a_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/af4d09d8c108a096b7faebd5177a607a.jpg)

上面的例子中，`err` 是一个对象(`object`)类型， 拥有`message、stack`两个属性，还有一个原型链上的属性`name`,来自于构造函数`Error`的原型

### 1.1.2 6种错误类型

以下6种错误类型都是Error对象的派生对象。在javascript中, 数组array、函数function都是特殊的对象

- • SyntaxError 语法错误

SyntaxError是代码解析时发生的语法错误。例如, 写了一个错误的语法`var a =`

	function fn() {
	    var a =
	}
	// Uncaught SyntaxError: Unexpected token }
	fn()

- • TypeError 类型错误

TypeError是变量或者参数不是预期类型时发生的错误。例如在number类型上调用array的方法。

	var n = 1234
	// Uncaught TypeError: a.concat is not a function
	a.concat(9)

- • RangeError 范围错误

RangeError是一个值超过有效范围发生的错误。例如设置数组的长度为一个负值。

	// 数组长度不得为负数
	new Array(-1)
	// Uncaught RangeError: Invalid array length

- • ReferenceError 引用错误

ReferenceError是引用一个不存在的变量时发生的错误。

	// Uncaught ReferenceError: mmm is not defined
	console.log(mmm)

- • EvalError eval错误 eval函数没有被正确执行时，会抛出EvalError错误。该错误类型已经不再使用了，只是为了保证与以前代码兼容，才继续保留。

	// Uncaught TypeError: eval is not a constructor
	new eval()
	// 不会报错
	eval = () => {}

- • URIError URL错误

URIError指调用`decodeURI encodeURI decodeURIComponent encodeURIComponent escape unescape`时发生的错误。

	// URIError: URI malformed
	    at decodeURIComponent
	decode
	decodeURIComponent('%')

### 1.2 资源加载错误

当以下标签(不包括`<link>`), 加载资源出错时, 会发生资源加载错误。
`<img>, <input type="image">, <object>, <script>, <style> , <audio>, <video>`

- • 资源加载错误可以用onerror事件监听

`<img onerror="handleError">`

- • 资源加载错误不会冒泡, 只能在事件流捕获阶段获取错误

	# 第三个参数默认为false, 设为true, 表示在事件流捕获阶段捕获
	window.addEventListener('error', handleError, true)

- • 当加载跨域资源时, 不会报错, 需要在元素上添加 crossorigin, 同时服务器需要在response header中, 设置Access-Control-Allow-Origin 为*或者允许的域名

`<script src="xxx" crossorigin></script>`

## 2. 错误捕获

>  参考阿里开源框架> [> jstracker](https://link.zhihu.com/?target=https%3A//github.com/CurtisCBS/monitor/blob/master/src/monitor.js)> 源码

>

	// 阿里 jstracker 核心源码
	// 捕获资源加载错误
	window.addEventListener('error', handleError, true)
	
	/**
	* 捕获js运行时错误
	* 函数参数：
	* message： 错误信息（字符串）
	* source: 发生错误当脚本URL
	* lineno: 发生错误当行号
	* colno: 发生错误当列号
	* error: Error对象
	**/
	window.onerror = function(message, source, lineno, colno, error) { ... }
	
	// 捕获vue中的错误, 重写console.error
	console.error = () => {}

上面的代码, 不是很严谨, 如果用户在代码中也写了`window.onerror`, 会被覆盖, 导致错误没有正常上报。

## 3. throw

> [> MDN关于throw的定义](https://link.zhihu.com/?target=https%3A//developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/throw)

>   **> throw**>  语句用来抛出一个用户自定义的异常。当前函数的执行将被停止（throw之后的语句将不会执行），并且控制将被传递到调用堆栈中的第一个catch块。如果调用者函数中没有catch块，程序将会终止。

>
MDN上关于throw的定义, 翻译得不够准确，对于“程序将会终止”，我有不同的看法,下面请听我的分析。
"throw 之后的语句将不会执行。", 这句话比较容易理解, 例如

	console.log(1)
	throw 1234
	// 下面这行代码不会执行
	console.log(2)

"如果调用者函数中没有catch块，程序将会终止", 这句话是有问题的。下面用代码来推翻这个结论

	<button id="btn-1">打印1</button>
	<button id="btn-2">打印2</button>
	<script>
	  function log(n) {
	    console.log(n)
	  }
	
	  document.getElementById('btn-1').onclick = function() {
	    log(1)
	  }
	
	  // 每1s打印一次
	  setInterval(() => {
	    log('setInterval依然在执行')
	  }, 1000)
	
	  throw new Error('手动抛出异常')
	
	  // 这段代码不会执行
	  document.getElementById('btn-2').onclick = function() {
	    log(2)
	  }
	</script>

运行上面的代码, 控制台首先会抛出错误, 然后每秒打印"setInterval依然在执行"

![](data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='236' height='65'></svg>)

点击btn-1, 打印1; 点击but-2, 无反应.
这就说明: **throw 之后, 程序没有停止运行**

![](data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='270' height='270'></svg>)

结论: **throw之后的语句不会执行, 并且控制将被传递到调用堆栈中的第一个catch块。如果调用者函数中没有catch块,程序也不会停止, throw 之前的语句依旧在执行。**

## 4. try...catch...finally

try/catch的作用是将可能引发错误的代码放在try块中，在catch中捕获错误，对错误进行处理，选择是否往下执行。

### 4.1 try 代码块中的错误, 会被catch捕获, 如果没有手动抛出错误, 不会被window捕获

	try {
	  throw new Error('出错了!');
	} catch (e) {
	  console.dir(e);
	  throw e
	}

![v2-6ea3cc8a1ea25f88cc4c1c8bc8d3e189_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/6ea3cc8a1ea25f88cc4c1c8bc8d3e189.jpg)

在catch中抛出异常, 用 `throw e`, 不要用`throw new Error(e)`, 因为`e`本身就是一个`Error`对象了, 具有错误的完整堆栈信息stack, `new Error` 会改变堆栈信息, 将堆栈定位到当前这一行.

### 4.2 try...finally... 不能捕获错误

下面的代码, 由于没有catch, 错误会直接被window捕获

	try {
	    throw new Error('出错啦啦啦')
	} finally {
	    console.log('啦啦啦')
	}

### 4.3 try...catch...只能捕获同步代码的错误, 不能捕获异步代码错误

下面的代码, 错误将不能被catch捕获

	try {
	    setTimeout(() => {
	        throw new Error('出错啦！')
	    })
	} catch(e){
	    // 不会执行
	    console.dir(e)
	}

因为setTimeout是异步任务, 里面回调函数会被放入到宏任务队列中, catch中代码块属于同步任务, 处于当前的事件队列中, 会立即执行。（参考[js事件循环机制](https://link.zhihu.com/?target=https%3A//yangbo5207.github.io/wutongluo/ji-chu-jin-jie-xi-lie/shi-er-3001-shi-jian-xun-huan-ji-zhi.html)） 当setTimeout中回调执行时, try/catch中代码块已不在堆栈中。所以错误不能被捕获。

## 5. promise

Promise 对象是 JavaScript 的一种异步操作解决方案。Promise是构造函数, 也是对象。

### Promise的三种状态:

- • pending 异步操作未完成
- • fulfilled 异步操作成功
- • rejected 异步操作失败

如果一个promise没有resolve或reject, 将一直处于pending状态。

### 5.1 Promise的两个方法

- • Promise.prototype.then 通常用来添加异步操作成功的回调
- • Promise.prototype.catch 用来添加异步操作失败的回调

### 5.2 Promise内部的错误捕获

用Promise可以解决“回调地狱”的问题,但如果不能好处理Promise错误，将会陷入另一个地狱:错误将被“吞掉”, 可能不会在控制台打印,也不能被window捕获。给调试、线上故障排查带来很大困难。

promise内部抛出的错误, 都不会被window捕获, 除非用了setTimeout/setInterval。
为了证明我的结论，我举了一些栗子 * 栗子1, 错误会抛出到控制台, promise.catch回调能够执行, 但错误不会被window捕获

	p = new Promise(()=>{
	    throw new Error('栗子1')
	})
	
	p.catch((e) => {
	    console.dir(e)
	})

- • 栗子2, p.then中但回调函数出错, 错误会抛出到控制台, promise.catch回调能够执行, 但错误不会被window捕获

	p = new Promise((resolve, reject) => {
	    resolve()
	})

	p.then(() => {
	    throw new Error('栗子2')
	}).catch((e) => {
	    console.dir(e)
	})

- • 栗子3, p.catch回调出错, 错误会抛出到控制台, 后续的promise.catch回调能够执行, 但错误不会被window捕获

	p = new Promise((resolve, reject) => {
	    reject()
	})

	p.catch(() => {
	    throw new Error('栗子2')
	}).catch((e) => {
	    console.dir(e)
	})

- • 栗子4, 错误会抛出到控制台, 后续的promise.catch回调不会执行,错误会被window捕获

	p = new Promise((resolve, reject) => {
	    reject()
	})

	p.catch(() => {
	    setTimeout((e) => {
	        throw new Error('栗子2')
	    })
	}).catch((e) => {
	    console.dir(e)
	})

例3和例4完全不一样的结果, 为什么会这样呢？因为promise内部也实现了类似于try/catch的错误捕获机制, 能够捕获错误。 参考[promise](https://link.zhihu.com/?target=https%3A//github.com/then/promise/blob/master/src/core.js) 实现

	// es6实现的promise部分源码
	function Promise(fn) {
	  ...
	  doResolve(fn, this);
	}
	
	function doResolve(fn, promise) {
	  var done = false;
	  var res = tryCallTwo(fn, function (value) {
	   ...
	  }, function (reason) {
	   ...
	  });
	}
	
	function tryCallTwo(fn, a, b) {
	  try {
	    fn(a, b);
	  } catch (ex) {
	    LAST_ERROR = ex;
	    return IS_ERROR;
	  }
	}

从es6实现的promise可以发现, `Promise() promise.then() promise.catch()` 回调函数执行时,都会被放到try...catch...中执行, 所以错误不能被`window.onerror`捕获。而try...catch...包括setTimeout/setInterval 等异步代码时, 是不能捕获到错误的。

### 5.3 在全局捕获promise错误

### 5.3.1 unhandledrejection 捕获未处理Promise错误

- • 用法

	window.addEventListener('error', (e) => {
	    console.log('window error', e)
	}, true)

	window.addEventListener('unhandledrejection', (e) => {
	    console.log('unhandledrejection', e)
	});

	let p = function() {
	    return new Promise((resolve, reject) => {
	        reject('出错啦')
	    })
	}

	p()

![v2-bfeb0768210d9324da77f577012f4299_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/bfeb0768210d9324da77f577012f4299.jpg)

- • 兼容性

![v2-c2c8681821a8d7600e9ffcfc9093992a_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c2c8681821a8d7600e9ffcfc9093992a.jpg)

unhandledrejection事件在浏览器中兼容性不好，通常不这么做。

## 6. async/await

当调用一个 async 函数时，会返回一个 Promise 对象。当这个 async 函数返回一个值时，Promise 的 resolve 方法会负责传递这个值；当 async 函数抛出异常时，Promise 的 reject 方法也会传递这个异常值。

async/await的用途是简化使用 promises 异步调用的操作，并对一组 Promises执行某些操作。正如Promises类似于结构化回调，async/await类似于组合生成器和 promises。

async 函数的返回值会被隐式的传递给`Promise.resolve`.
async函数内部的错误处理 * async的推荐用法

	async function getInfo1() {
	  try {
	    await ajax();
	  } catch (e) {
	    // 错误处理
	    throw e
	  }
	}

await后面函数返回的promise的状态有三种: * pending 异步操作未完成 * fulfilled 异步操作成功 * rejected 异步操作失败

async函数主体处理结果如下:

- • fulfilled 异步操作成功

如果await 后面函数返回的promise的状态是fulfilled(成功), 那程序将会 继续执行await后面到代码。下面的例子都是fulfilled状态的

	# demo 1: ajax success, no ajax().catch
	async function getInfo1() {
	  try {
	    await ajax();
	    console.log('123')
	  } catch (e) {
	    // 错误处理
	    throw e
	  }
	}
	
	# demo 2:  ajax failed, ajax().catch do nothing
	async function getInfo1() {
	  try {
	    await ajax().catch(e => do nothing)
	    console.log('123')
	  } catch (e) {
	    // 错误处理
	    throw e
	  }
	}

- • rejected 异步操作失败

如果await 后面函数返回的promise的状态是rejected(失败), 那程序将不会 执行await后面的代码，而是转到`catch`中到代码块。下面的例子都是fulfilled状态的。

	# demo 1: ajax failed
	async function getInfo1() {
	  try {
	    // ajax failed
	    await ajax();
	    console.log('123')
	  } catch (e) {
	    // 错误处理
	    throw e
	  }
	}
	
	# demo 2:  ajax failed, ajax().catch throw error
	async function getInfo1() {
	  try {
	     // ajax failed
	    await ajax().catch(error => throw error)
	    console.log('123')
	  } catch (e) {
	    // 错误处理
	    throw e
	  }
	}

- • pending 异步操作未完成

如果await 后面函数`ajax`没有被`resolve`或`reject`, 那么将 `ajax`一直处于pending状态, 程序将不会往后执行await 后面代码, 也不能被catch捕获, async函数也将一直处于pending状态.

这样的代码在我们身边很常见，举一个我遇到过的例子。

	function initBridge() {
	    return new Promise((resolve, reject) => {
	        window.$ljBridge.ready((bridge, webStatus) => {
	            ...
	            resolve()
	        })
	    })
	}
	
	function async init(){
	    try{
	        await initBradge()
	        // do something
	    } catch(e) {
	        throw e
	    }
	}
	
	init()

上面的代码, initBradge由于没有被正确当reject, 当出错时，将一直处于pending状态。init内部即不能捕获错误，也不能继续往后执行, 将一直处于pending状态。

## 总结

- • 错误分类
- • js运行时错误
    - • Error实例对象
    - • 6种错误类型

- • 错误捕获
- • throw

纠正MDN的翻译错误: **throw之后的语句不会执行, 程序不会停止, throw 之前的语句依旧在执行。**

- • try...catch...finally
- • promise
- • async/await

### 参考链接

- • [错误处理机制](https://link.zhihu.com/?target=https%3A//wangdoc.com/javascript/features/error.html)
- • [js事件循环机制](https://link.zhihu.com/?target=https%3A//yangbo5207.github.io/wutongluo/ji-chu-jin-jie-xi-lie/shi-er-3001-shi-jian-xun-huan-ji-zhi.html)

发布于 2019-04-23
[ JavaScript](https://www.zhihu.com/topic/19552521)
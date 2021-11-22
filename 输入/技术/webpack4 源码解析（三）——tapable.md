# webpack4 源码解析（三）——tapable

在解析webpack4 的 Compiler 模块前，我们先要解析以下它赖以实现的也是webpack的核心依赖模块tapable。



tapable 简而言之，就是一个注册钩子函数的模块。 



我们知道，webpack之所以强大，靠的就是丰富的插件系统，不管你有什么需求，总有插件能满足你。而这些插件能够按照你配置的方式工作，全部依赖于tapable模块，它将这些插件注册为一个个钩子函数，然后按照插件注册时告知的方式，在合适的时机安排它们运行，最终完成整个打包任务。

## 工作流程

tapable 的基本工作流程如下：

1. 引入钩子类型
2. 创建该钩子类型的实例
3. 注册事件
4. 触发事件，让监听函数执行

下面我们分别来说。

### 引入钩子类型

在webpack的Compiler.js中，我们可以看到如下的引入代码：

```javascript
……
const {
	Tapable,
	SyncHook,
	SyncBailHook,
	AsyncParallelHook,
	AsyncSeriesHook
} = require("tapable");
……
```



我们看到，除了引入Tapable本身，它引入了四种钩子，其中以Sync开头的为同步类型的钩子，而以Async开头的则为异步类型的钩子。

这意味着，以同步类型的钩子注册的事件，将以同步的方式执行，而以异步类型的钩子注册的事件则以异步的方式执行。

其实在tapable中，不止上面四种类型的钩子，打开tapable源码，我们可以看到：



![](https://i.loli.net/2019/06/12/5d010849359d817484.png)



其中，以蓝色线条框住的就是异步类型钩子，以橘红色线条框住的为同步类型的钩子，下面分别说明下它们的执行机制。

#### 同步钩子

* SyncHook: 串行同步执行，不关心事件处理函数的返回值，在触发事件之后，会按照事件注册的先后顺序执行所有的事件处理函数。
* SyncBailHook: 串行同步执行，如果事件处理函数执行时有一个返回值不为空（即有返回值），则跳过剩下未执行的事件处理函数。这里bail可以理解为熔断的意思，是一种保险机制。
* SyncWaterfallHook: 为串行同步执行，上一个事件处理函数的返回值作为参数传递给下一个事件处理函数，依次类推，而这里的waterfall则顾名思义是流水的意思，类似于流水线，下一个事件拿上一个事件的输出作为输入。
* SyncLoopHook:串行同步执行，事件处理函数返回 `true` 表示继续循环，即循环执行当前事件处理函数，返回 `undefined` 表示结束循环

#### 异步钩子

* AsycnParallelHook:异步并行执行，通过 `tapAsync` 注册的事件，通过 `callAsync` 触发，通过 `tapPromise` 注册的事件，通过 `promise` 触发（返回值可以调用 `then` 方法）
* AsyncSeriesHook:异步串行执行，与 `AsyncParallelHook` 相同，通过 `tapAsync` 注册的事件，通过 `callAsync` 触发，通过 `tapPromise` 注册的事件，通过 `promise` 触发，可以调用 `then` 方法。
* AsncParallelBailHook: 异步并行执行，与 `AsyncParallelHook` 相同但是如果其中一个事件有返回值，则立即停止执行。
* AsyncSeriesBailHook:异步串行执行，与 `AsyncSeriesHook` 相同，但是如果其中一个事件有返回值，则立即停止执行。
* AsyncSeriesLoopHook:异步串行执行，循环执行所有注册事件直到某个事件返回`undefined` 而停止。
* AsyncSeriesWaterfallHook:异步串行执行，上一个事件处理函数的返回值作为参数传递给下一个事件处理函数，一次类推。



### 创建实例

在Complier.js中，我们可以看到一开始在Complier类中就实例化了很多钩子实例：

```javascript
this.hooks = {
			/** @type {SyncBailHook<Compilation>} */
			shouldEmit: new SyncBailHook(["compilation"]),
			/** @type {AsyncSeriesHook<Stats>} */
			done: new AsyncSeriesHook(["stats"]),
			/** @type {AsyncSeriesHook<>} */
			additionalPass: new AsyncSeriesHook([]),
			/** @type {AsyncSeriesHook<Compiler>} */
			beforeRun: new AsyncSeriesHook(["compiler"]),
			/** @type {AsyncSeriesHook<Compiler>} */
			run: new AsyncSeriesHook(["compiler"]),
			/** @type {AsyncSeriesHook<Compilation>} */
			emit: new AsyncSeriesHook(["compilation"]),
			/** @type {AsyncSeriesHook<Compilation>} */
			afterEmit: new AsyncSeriesHook(["compilation"]),

			/** @type {SyncHook<Compilation, CompilationParams>} */
			thisCompilation: new SyncHook(["compilation", "params"]),
			/** @type {SyncHook<Compilation, CompilationParams>} */
			compilation: new SyncHook(["compilation", "params"]),
			/** @type {SyncHook<NormalModuleFactory>} */
			normalModuleFactory: new SyncHook(["normalModuleFactory"]),
			/** @type {SyncHook<ContextModuleFactory>}  */
			contextModuleFactory: new SyncHook(["contextModulefactory"]),

			/** @type {AsyncSeriesHook<CompilationParams>} */
			beforeCompile: new AsyncSeriesHook(["params"]),
			/** @type {SyncHook<CompilationParams>} */
			compile: new SyncHook(["params"]),
			/** @type {AsyncParallelHook<Compilation>} */
			make: new AsyncParallelHook(["compilation"]),
			/** @type {AsyncSeriesHook<Compilation>} */
			afterCompile: new AsyncSeriesHook(["compilation"]),

			/** @type {AsyncSeriesHook<Compiler>} */
			watchRun: new AsyncSeriesHook(["compiler"]),
			/** @type {SyncHook<Error>} */
			failed: new SyncHook(["error"]),
			/** @type {SyncHook<string, string>} */
			invalid: new SyncHook(["filename", "changeTime"]),
			/** @type {SyncHook} */
			watchClose: new SyncHook([]),

			// TODO the following hooks are weirdly located here
			// TODO move them for webpack 5
			/** @type {SyncHook} */
			environment: new SyncHook([]),
			/** @type {SyncHook} */
			afterEnvironment: new SyncHook([]),
			/** @type {SyncHook<Compiler>} */
			afterPlugins: new SyncHook(["compiler"]),
			/** @type {SyncHook<Compiler>} */
			afterResolvers: new SyncHook(["compiler"]),
			/** @type {SyncBailHook<string, Entry>} */
			entryOption: new SyncBailHook(["context", "entry"])
		};
```



### 注册事件

注册事件一般同步类型的钩子使用tap方法注册，而异步类型的钩子一般使用tapAsync方法类注册。

比如，在webpack包内的 APIPlugin.js中，就是这样注册的：

![](https://i.loli.net/2019/06/12/5d0114c6bc75344521.png)



而在CachePlugin.js中，则是这样注册的：

![](https://i.loli.net/2019/06/12/5d01152f11d3d25450.png)



在上面的钩子实例化时，我们可以看到 compilation 钩子是一个同步类型的钩子，而run 则是一个异步类型的钩子。



### 触发事件

我们以上面 `shouldEmit` 为例来看，它是在Complier.js的第230触发了事件的：

```javascript
if (this.hooks.shouldEmit.call(compilation) === false) {
				const stats = new Stats(compilation);
				stats.startTime = startTime;
				stats.endTime = Date.now();
				this.hooks.done.callAsync(stats, err => {
					if (err) return finalCallback(err);
					return finalCallback(null, stats);
				});
				return;
			}
```

我们可以从上面实例化的代码中看到，`shouldEmit`  是一个同步类型的钩子，在这里触发事件时，它使用`call` 方法来传递参数，我们看到这里的返回值是一个布尔值。而上面代码的第5行，`done`是一个异步类型的钩子，它则使用`callAsycn` 方法来注册事件，它则传入了一个`stats`对象和一个错误处理函数。

其实，触发事件一共有下面几种方式：

* call: 钩子触发时调用
* loop:触发循环类钩子的每个循环事件
* register:触发每一个添加的Tab对象，并且允许修改Tab对象

而根据钩子类型的不同，异步类型的钩子还可以在后面加上Asycn



## 工作原理

### nodejs 的 events模块

实际上，tapable 本质上是一个类似于nodejs 的 events 模块的事件发布器。我们看一下以下代码：

```javascript
const EventEmitter = require('events');
const myEmitter = new EventEmitter();

/**
 * param1 事件名
 * param2 回调函数
 */
myEmitter.on('run',(arg1,arg2)=>{
    console.log("run",arg1,arg2);
});
// 在这里发布事件
myEmitter.emit('run',111,222); // run 111 222
```

可以看到，事件发布器是使用on来注册一个事件的监听，而使用emit来发布（触发）这个事件。tapable本质上做的工作和它是一样的，不过是使用tap等方法来注册事件，用call等方法来发布事件而已。



### 构造函数

通过阅读tapable 我们可以发现，所有的钩子都继承自 Hook 类，那我们先看下Hook类的构造函数：

```javascript
constructor(args) {
		if (!Array.isArray(args)) args = [];
		this._args = args;
		this.taps = [];
		this.interceptors = [];
		this.call = this._call;
		this.promise = this._promise;
		this.callAsync = this._callAsync;
		this._x = undefined;
	}
```



我们可以看到，每一个钩子都拥有一个taps数组，一个拦截器数组(interceptors)，还有三个调用方法，分别对应普通同步调用(call)，异步调用(callAsync)和承诺调用（promise）。

而三个事件注册方法也在类的定义中初现：

```javascript
tap(options, fn) {
		if (typeof options === "string") options = { name: options };
		if (typeof options !== "object" || options === null)
			throw new Error(
				"Invalid arguments to tap(options: Object, fn: function)"
			);
		options = Object.assign({ type: "sync", fn: fn }, options);
		if (typeof options.name !== "string" || options.name === "")
			throw new Error("Missing name for tap");
		options = this._runRegisterInterceptors(options);
		this._insert(options);
	}

	tapAsync(options, fn) {
		……
	}

	tapPromise(options, fn) {
		……
	}
```

这三个方法，除了在合并对象时传入的 type 值不同，其它都相同。注册的实质就是将传入的选项和方法都合并到一个总的options对象里，然后使用_insert内部方法将这个对象扔进了 taps 数组中。中间还检查了是否定义了拦截器，如果有拦截器注册方法，则将当前事件注册到拦截器数组中。



在Hook类中，我们还应该注意，三个事件调用方法是通过 createCompileDelegate 方法调用_createCall 方法来生成，并且通过defineProperties方法定义到了Hook类的原型上面。

```javascript
//这个方法返回了一个编译后的钩子实例
_createCall(type) {
		return this.compile({
			taps: this.taps,
			interceptors: this.interceptors,
			args: this._args,
			type: type
		});
	}
	……
	// 创建编译的代理方法，返回了一个调用时才执行的钩子生成方法
	function createCompileDelegate(name, type) {
		return function lazyCompileHook(...args) {
		this[name] = this._createCall(type);
		return this[name](...args);
	};
}

//将调用方法定义到了原型上
Object.defineProperties(Hook.prototype, {
	_call: {
		value: createCompileDelegate("call", "sync"),
		configurable: true,
		writable: true
	},
	_promise: {
		value: createCompileDelegate("promise", "promise"),
		configurable: true,
		writable: true
	},
	_callAsync: {
		value: createCompileDelegate("callAsync", "async"),
		configurable: true,
		writable: true
	}
});

```



### 工厂类

在上层，所有的钩子都是由钩子工厂生成，而所有类型的钩子工厂都继承自钩子工厂类：

```javascript
class HookCodeFactory {
	constructor(config) {
		this.config = config;
		this.options = undefined;
		this._args = undefined;
	}

	create(options) {
		……
	}

	setup(instance, options) {
		instance._x = options.taps.map(t => t.fn);
	}

	/**
	 * @param {{ type: "sync" | "promise" | "async", taps: Array<Tap>, interceptors: Array<Interceptor> }} options
	 */
	init(options) {
		this.options = options;
		this._args = options.args.slice();
	}

	deinit() {
		this.options = undefined;
		this._args = undefined;
	}

	header() {
		……
	}

	needContext() {
		for (const tap of this.options.taps) if (tap.context) return true;
		return false;
	}

	callTap(tapIndex, { onError, onResult, onDone, rethrowIfPossible }) {
		……
	}

	callTapsSeries({}) {
	……
	}

	callTapsLooping({ onError, onDone, rethrowIfPossible }) {
		……
	}

	callTapsParallel({
		onError,
		onResult,
		onDone,
		rethrowIfPossible,
		onTap = (i, run) => run()
	}) {
		……
	}

	args({ before, after } = {}) {
		……
	}

	getTapFn(idx) {
		return `_x[${idx}]`;
	}

	getTap(idx) {
		return `_taps[${idx}]`;
	}

	getInterceptor(idx) {
		return `_interceptors[${idx}]`;
	}
}
```



我们发现，在钩子工厂中，完成了对钩子的创建、初始化和配置等工作，并且实现了各种类型的基本调用方法的代码生成方法。



### 钩子类实现

有了基本的钩子类和钩子工厂类，就可以用它们来生成各种同步/异步、串行/并行、熔断/流水类型的钩子了，我们以SyncBailHook为例来看：

```javascript
/*
	MIT License http://www.opensource.org/licenses/mit-license.php
	Author Tobias Koppers @sokra
*/
"use strict";

const Hook = require("./Hook");
const HookCodeFactory = require("./HookCodeFactory");

class SyncBailHookCodeFactory extends HookCodeFactory {
	content({ onError, onResult, resultReturns, onDone, rethrowIfPossible }) {
		return this.callTapsSeries({
			onError: (i, err) => onError(err),
			onResult: (i, result, next) =>
				`if(${result} !== undefined) {\n${onResult(
					result
				)};\n} else {\n${next()}}\n`,
			resultReturns,
			onDone,
			rethrowIfPossible
		});
	}
}

const factory = new SyncBailHookCodeFactory();

class SyncBailHook extends Hook {
	tapAsync() {
		throw new Error("tapAsync is not supported on a SyncBailHook");
	}

	tapPromise() {
		throw new Error("tapPromise is not supported on a SyncBailHook");
	}

	compile(options) {
		factory.setup(this, options);
		return factory.create(options);
	}
}

module.exports = SyncBailHook;

```

 可以看到，它先是继承了基础的钩子工厂，并通过调用 callTapsSeries 方法返回了一个串行的钩子实例，并且在onResult方法里，加了一个if判断，如果结果不为空，就停止，否则执行下一个事件，这就是熔断机制。



然后下面实例化了一个该类型的工厂，利用这个工厂配置了对钩子实例进行了配置(setup)和生成(create)。



其它类型的钩子类的实现也大同小异。只不过并行类的钩子不再调用callTapsSeries 方法，而是调用callTapsParallel 方法，而像 Waterfall 型的钩子则在onResult方法里的处理逻辑是将上一个事件执行返回的结果作为下一个事件的第一个参数传了进去而已。有兴趣的朋友可以按照本文所述的顺序去阅读下源码。


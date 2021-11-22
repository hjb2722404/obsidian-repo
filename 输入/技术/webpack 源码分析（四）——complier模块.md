# webpack 源码分析（四）——complier模块

上一篇我们看到，`webpack-cli` 通过 ``yargs` 对命令行传入的参数和配置文件里的配置项做了转换包装，然后传递给 `webpack` 的 `compiler` 模块去编译。

这一篇我们来看看 `compiler` 做了些什么事。

## 入口

首先，我们来看看 `webpack` 是在什么地方引入 `Compiler` 这个模块的，在 `webpack/lib/webpack.js` 中我们发现，这个文件第一行就引入了它，并在下面的主要逻辑中使用了它：

```javascript
const Compiler = require("./Compiler");

……

/*
* options：这就是由 webpack-cli 转换包装后的配置项
* callback：第二篇分析时，发现 `webpack-cli` 只是传入了 options对象来获取 `compiler` 对象，并没有传入回调 
*/

const webpack = (options, callback) => {

	// 验证配置项的格式
    // webpackOptionsSchema 是一个json格式的描述文件，它描述了webpack可接受的所有配置项及其格式
    // options 是用户定义的webpack.config.*.js中导出的所有配置项
    // validateSchema 使用 ajv 包，根据 webpackOptionsSchema 中定义的数据类型和描述来校验 options 中的各项配置项，最后返回一个错误对象，其中包含所有错误的配置项及说明
	const webpackOptionsValidationErrors = validateSchema(
		webpackOptionsSchema,
		options
	);
    // 如果存在配置项错误，则抛出所有错误
	if (webpackOptionsValidationErrors.length) {
		throw new WebpackOptionsValidationError(webpackOptionsValidationErrors);
	}
	//判断配置项是否数组，如果是数组则使用MultiCompiler进行编译，否则使用Compiler模块进行编译，一般情况下，我们的 options 都是对象不是数组
	let compiler;
	if (Array.isArray(options)) {
		compiler = new MultiCompiler(options.map(options => webpack(options)));
	} else if (typeof options === "object") {
        //使用默认配置项处理输入配置项
        // WebpackOptionsDefaulter 继承自 OptionsDefaulter 类
        // 在这个类里有两个对象：
        //	* this.defaults : 用来存放配置项的值
        //  * this.config : 用来存放配置项的值的类型
        // process 方法的处理逻辑：
        // 	* 如果defaults对象中存在，但在config对象中不存在，并且在options中也不存在，就从 defaults对象中复制一份到options中
        //  * 如果在config对象中存在并且值为 “call”，则说明它的值是一个方法调用，就直接调用，并将options作为参数传入
        //  * 如果在config对象中存在且值为 “make”,并且在 options中没有，则说明它是一个方法，就直接调用它，并将options作为参数传入，拿到返回值，赋值给options中对应的项
        //  * 如果在config对象中存在切值为 “append”,则取出options中对应的值，如果它不是数组，就把它重置为数组，并且把defaults对象中的值复制到数组中，最后将这个数组作为值赋值给options相应的项
		options = new WebpackOptionsDefaulter().process(options);
		// new 一个compiler实例，参数为当前执行node命令的目录路径
    // Compiler类继承自我们上一篇讲过的Tapable类，在构造函数中，初始化了各种类型的钩子实例
    // compiler 类的内部逻辑，后面详解++++++++++++++++++++++
		compiler = new Compiler(options.context);
    // WebpackOptionsDefaulter类处理后返回的options 复制给 compiler
		compiler.options = options;
    // 使用NodeEnviromentPlugin 类给compiler添加文件输入输出的能力
    // NodeEnviromentPlugin的内部逻辑，后面详解++++++++++++++++++++++++++
		new NodeEnvironmentPlugin().apply(compiler);
    // 如果配置项中有插件配置并且插件配置为数组
    // 遍历插件数组，如果插件是一个函数，则使用complier来调用它，，并且将compier作为参数出入
    // 否则，使用 WebpackPluginInstance 的 apply 方法来返回一个 void 值（相当于undefined）
		if (options.plugins && Array.isArray(options.plugins)) {
			for (const plugin of options.plugins) {
				if (typeof plugin === "function") {
					plugin.call(compiler, compiler);
				} else {
					plugin.apply(compiler);
				}
			}
		}
    // 触发 environment 同步钩子，这里的 call() 是我们讲过的Tapable钩子事件的触发方法
    // environment 准备好之后，执行插件
		compiler.hooks.environment.call();
    // 触发 afterEnvironment 同步钩子
    // environment 安装完成之后，执行插件
		compiler.hooks.afterEnvironment.call();
    // 使用 WebpackOptionsApply 类处理选项，返回处理过的选项对象
    // WebpackOptionsApply 的处理逻辑，后面详解++++++++++++++
		compiler.options = new WebpackOptionsApply().process(options, compiler);
	} else {
    //如果配置既不是数组类型也不是对象类型，抛出错误
		throw new Error("Invalid argument: options");
	}
  // 如果传入了回到函数
	if (callback) {
    // 如果回调不是函数，抛出参数类型错误
		if (typeof callback !== "function") {
			throw new Error("Invalid argument: callback");
		}
    // 如果是监听模式，或者（配置是数组且数组中的项中有监听选项为true）,则初始化监听配置，最后返回compiler实例的监听方法
    // 实例的监听方法会返回一个 Watching类的实例，它本质上是一个观察者
		if (
			options.watch === true ||
			(Array.isArray(options) && options.some(o => o.watch))
		) {
			const watchOptions = Array.isArray(options)
				? options.map(o => o.watchOptions || {})
				: options.watchOptions || {};
			return compiler.watch(watchOptions, callback);
		}
    // 使用compiler的run方法运行回调
		compiler.run(callback);
	}
  //返回compiler实例
	return compiler;
};

```

通过以上源码分析，我们得知，在` webpack()` 中，实际上总共做了三件事：

1. 对参数进行校验和规范化处理；
2. new 一个编译器实例并且初始化各种`tapable`钩子，并且在环境准备好和安装完成后执行响应的钩子
3. 初始化监听。

在上面的分析中，我们看到最核心的其实就是`compiler`实例，接下来我们就看下它的类的内部逻辑。

## compiler 分析

### 主体结构

首先，我们来看主要结构：

```javascript
/*…… *// 各种引入

// Compiler 类继承自Tapable
class Compiler extends Tapable {
	constructor(context) {……}//构造函数执行各种初始化操作
	watch(watchOptions, handler) {……}//监听初始化
	run(callback) {……}// 运行编译
	runAsChild(callback) {...} // 作为子编译进程运行
	purgeInputFileSystem() {...} // 净化输入
	emitAssets(compilation, callback) {...} // 发布资源
	emitRecords(callback) {...} // 发布记录
	readRecords(callback) {...} // 读取记录
	createChildCompiler(
		compilation,
		compilerName,
		compilerIndex,
		outputOptions,
		plugins
	) {...} // 创建子编译器
	isChild() {return !!this.parentCompilation;} // 是否子汇编
	createCompilation() {return new Compilation(this);} // 创建汇编实例
	newCompilation(params) {return compilation;} // 根据参数创建新的汇编实例
	createNormalModuleFactory() {return normalModuleFactory;} // 创建普通模块的工厂
	createContextModuleFactory() {return contextModuleFactory;} // 创建上下文模块的工厂
	newCompilationParams() {return params;} // 获取一个新的汇编参数对象
	compile(callback) {} // 编译
}

module.exports = Compiler;

class SizeOnlySource extends Source {} // 定义了一个类，作用是+++++++++++

```



接下来，我们一个一个来攻破。


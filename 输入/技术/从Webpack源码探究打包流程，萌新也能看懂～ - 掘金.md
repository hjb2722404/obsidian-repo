从Webpack源码探究打包流程，萌新也能看懂～ - 掘金

[(L)](https://juejin.im/user/5aa23691518825556d0db27e)

[cherryvenus](https://juejin.im/user/5aa23691518825556d0db27e)
2018年12月01日阅读 152

# 从Webpack源码探究打包流程，萌新也能看懂～

## 简介

上一篇讲述了如何理解[tapable这个钩子机制](https://link.juejin.im/?target=https%3A%2F%2Fjuejin.im%2Fpost%2F5be90b84e51d457c1c4df852)，因为这个是webpack程序的灵魂。虽然钩子机制很灵活，而然却变成了我们读懂webpack道路上的阻碍。每当webpack运行起来的时候，我的心态都是佛系心态，祈祷中间不要出问题，不然找问题都要找半天，还不如不打包。尤其是loader和plugin的运行机制，这两个是在什么时候触发的，作用于webpack哪一个环节？这些都是需要熟悉webpack源码才能有答案的问题。

大家就跟着我一步步揭开webpack的神秘面纱吧。

## 如何调试webpack

本小节主要描述了，如何调试webpack，如果你有自成一派的调试方法，或者更加主流的方法，可以留言讨论讨论。

### 简易版webpack启动

工欲善其事，必先利其器。我相信大家刚学习webpack的时候一定是跟着官方文档运行webpack打包网站。

> webpack上手文档，->> [> 萌新指路](https://link.juejin.im/?target=https%3A%2F%2Fwebpack.js.org%2Fguides%2Fgetting-started%2F)

初级操作应该依赖webpack-cli，通过在小黑框中输入`npx webpack --config webpack.config.js`，然后enter执行打包。虽然webpack-cli会帮助我们把大多数打包过程中会出现的问考虑进去，但是这样会使我们对webpack的源码更加陌生，似乎配置就是一切。

这种尴尬的时候，我们就要另辟蹊径来开发，并不用官方的入门方法。
我写的一个简易启动webpack的调试代码，如下方所示：

`debugger.js/论如何优雅地抛弃cli而运行webpack的方法//载入webpack主体let webpack=require('webpack');//指定webpack配置文件let config=require("./webpack.config.js");//执行webpack，返回一个compile的对象，这个时候编译并未执行let compile=webpack(config);//运行compile，执行编译compile.run();`

如果大家想知道我这段代码的灵感来源于哪里？我会告诉大家是来自webpack-cli。
挑出关键运行的部分，然后重组就可以做一个简易的webpack启动了。

> 话唠笔者：我为什么要这么做？代码越少分析起来越简单，“无关”代码越多，我们的视线就会被这些代码所困住而寸步难行。当然等到这部分掌握了，再去看cli的代码，也许收获会更大一些。

### 配置的温馨提醒

虽然我们都会配置Entry，但是我们可能会忽略Context的配置，如果我们的cmd在当下的目录，那么执行是OK的，但是如果我们不在当前目录下，然后执行，那么很有可能路径会出现问题，为了防止遮掩的悲剧产生，我推荐机上context配置也就是`context:你当前项目的绝对路径`。

`module.exports = {  //...  context: path.resolve(__dirname, 'app')};`

### 打断点！debugger

关键部分来了，写一个简易个webpack主要就是为了方便打断点！增加程序的可读性。

#### 非vscode玩家入口

如果你是小黑框（termial）和chrome的爱好者，以下方法请收下！[点击获取参考文档，这里有详细的操作过程。](https://link.juejin.im/?target=https%3A%2F%2Fnodejs.org%2Fen%2Fdocs%2Fguides%2Fdebugging-getting-started%2F%23inspector-clients)

`node --inspect-brk debugger1.js`

然后我们就可以愉快地像调试网页一样在亲切的chrome上玩耍了。但是问题来了，没有断点的调试，太可怕了，虽然每一步都显示非常地好，不过我并不想知道fs的读取，timer的运行和模块的加载等node原生方法，next的点击了几百下，webpack主流程并没有走几步，这极大的挑战了我的耐心，如果有小伙伴一步步next到了最后一步，希望你能来和我们分享一下。为了防止过于细节，这个时候我们可以在适当的地方打断点：

`options = new WebpackOptionsDefaulter().process(options);debugger//是他是他就是他，我们的救星compiler = new Compiler(options.context);`

WebpackOptionsDefaulter运行之后，程序便会自动停下任君调试。

#### vscode的玩家

如果是vscode的玩家，除了上述的debugger方法，我们还可以直接打红点，作为断点，这样更加方便。最后还可以一键清除所有的断点。
同时也可以在当前断点的时候，在调试控制台，输入自己想要了解的参数。

![](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="600" height="428"></svg>)

## webpack主流程是什么

对于webpack的主流程的解释，我分为了以下三种：
**简介版本：webpack的过程就通过Compiler发号施令，Compilation专心解析，最后返回Compiler输出文件。**

![](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="458" height="614"></svg>)

**专业版本：webpack的过程是通过Compiler控制流程，Compilation专业解析，ModuleFactory生成模块，Parser解析源码，最后通过Template组合模块，输出打包文件的过程。**

**粗暴版本：webpack就是打散源码再重组的过程。**

![](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1280" height="890"></svg>)

## 源码解读

我们直接开始从专业版本来理解webpack吧。从上方的启动代码我们可以看到`webpack(config)`是启动webpack打包的关键代码，也就是webpack.js是我们第一个研究对象。

> 因为笔者各种调试webpack，各种断点，导致源码的行数和线上的行数不一致，所以这里我会直接抛出代码而不是行数，大家自行对着webpack的源码对照。

### 一切的源头webpack.js

大家以为我会从第一步引入开始解析吗？不存在的，我们直接从关键逻辑开始吧。

`webpack.js中关键逻辑options = new WebpackOptionsDefaulter().process(options);compiler = new Compiler(options.context);compiler.options = options;new NodeEnvironmentPlugin().apply(compiler);···省略自定义插件的绑定compiler.hooks.environment.call();compiler.hooks.afterEnvironment.call();compiler.options = new WebpackOptionsApply().process(options, compiler);`

是不是觉得不知所云，不要慌，我们一行行看下来，这里的每一行都很重要。

`options = new WebpackOptionsDefaulter().process(options);`这一行的关键字Default，通过关键字我们可以猜测到这个类的作用就是将我们webpack.config.js中自定义的部分，覆盖webpack默认的配置。

挑一行这个类中的代码，便于大家理解。
`WebpackOptionsDefaulter.js默认配置的代码片段this.set("entry", "./src");`
这个就是入口的默认配置，如果我们不配入口，程序就会自动找src下方的文件打包。

> 话痨的笔者：webpack4.0有一个很大的特色就是零配置，无需webpack.config.js我们都可以打包。为什么呢？难道是webpack真的不需要配置了吗？做到人工智能了？不！因为有默认配置，就像所有的程序都有初始化的默认配置。

`new Compiler(options.context)`，非常重要的编译器，基本上编译的流程就是出自这个类。 `options.context`这个值是当前文件夹的绝对路径，通过WebpackOptionsDefaulter.js默认配置的代码片段的代码片段既可以理解。这个类稍后分析。

`WebpackOptionsDefaulter.js默认配置的代码片段this.set("context", process.cwd());`

然后就是一系列，对于compiler的配置以及将`NodeEnvironmentPlugin`的hooks以及自定义的插件plugins也是钩子分别挂入compiler之中，挂入之后触发environment的一些钩子。相当于开车前会启动车子一样。比如在解析文件（resolver）时一定会用到的文件系统，如何读取文件。这个就是将inputFileSystem输入文件系统挂载了compiler上，然后通过compiler来控制那些插件需要这个功能，就派发给他。

`/node/NodeEnvironmentPlugin.jsclass NodeEnvironmentPlugin {apply(compiler) {compiler.inputFileSystem = new CachedInputFileSystem(new NodeJsInputFileSystem(),60000);//....compiler.hooks.beforeRun.tap("NodeEnvironmentPlugin", compiler => {if (compiler.inputFileSystem === inputFileSystem) inputFileSystem.purge();});}}module.exports = NodeEnvironmentPlugin;`

`compiler.options = new WebpackOptionsApply().process(options, compiler);`，这里又对options做处理的，如果说第一步是格式化配置，那么这边就是将配置在compiler中激活。这个类很重要，因为compiler中的激活了许多钩子，同时在一些钩子上挂上（tap）了函数。

关键配置options激活解析：

- 这个是parse的一个解析器，如果文件是js，就会使用到这个parse，也就是说这个是在loader的时候进行的。

`WebpackOptionsApply.jsnew JavascriptModulesPlugin().apply(compiler);`

- 这一行是用于解析也就是入口的解析，是`SingleEntryPlugin`还是`MultiEntryPlugin`。这个方法相当于入口程序已经就绪，就等后续的一声令下就可以运行了。

`WebpackOptionsApply.jsnew EntryOptionPlugin().apply(compiler);compiler.hooks.entryOption.call(options.context, options.entry);`

- 当插件钩子都挂上后，执行的钩子。

`WebpackOptionsApply.jscompiler.hooks.afterPlugins.call(compiler);`

- 接着是各类路径解析的钩子，根据我们的自定义resolver来解析。

`WebpackOptionsApply.jscompiler.resolverFactory.hooks.resolveOptions`

### 关键点突破Compiler.js

![](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1280" height="886"></svg>)

可以说Compiler.js这个类才是真正得控制了webpack打包的流程，如果说webpack.js所做的事是准备，那么Compiler就是撸起袖子就是干。

#### constructor

我们从`constructor`开始解析`Compiler`。

Compiler首先是定义了一堆钩子，如果大家观察仔细会发现这就是流程的各个阶段（此处的代码可读性很友好），也就是各个阶段都有个钩子，这意味着什么？我们可以利用这些钩子挂上我们的插件，所以说Compiler很重要。

| 关键钩子 | 钩子类型 | 钩子参数 | 作用  |
| --- | --- | --- | --- |
| beforeRun | AsyncSeriesHook | Compiler | 运行前的准备活动，主要启用了文件读取的功能。 |
| run | AsyncSeriesHook | Compiler | “机器”已经跑起来了，在编译之前有缓存，则启用缓存，这样可以提高效率。 |
| beforeCompile | AsyncSeriesHook | params | 开始编译前的准备，创建的ModuleFactory，创建Compilation，并绑定ModuleFactory到Compilation上。同时处理一些不需要编译的模块，比如ExternalModule（远程模块）和DllModule（第三方模块）。 |
| compile | SyncHook | params | 编译了 |
| make | AsyncParallelHook | compilation | 从Compilation的addEntry函数，开始构建模块 |
| afterCompile | AsyncSeriesHook | compilation | 编译结束了 |
| shouldEmit | SyncBailHook | compilation | 获取compilation发来的电报，确定编译时候成功，是否可以开始输出了。 |
| emit | AsyncSeriesHook | compilation | 输出文件了 |
| afterEmit | AsyncSeriesHook | compilation | 输出完毕 |
| done | AsyncSeriesHook | Stats | 无论成功与否，一切已尘埃落定。 |

#### `Compiler.run()`

从函数的名称我们大致可以猜出他的作用，不过还是从Compiler的运行流程来加深对Compiler的理解。`Compiler.run()`开跑！

首先触发`beforeRun`这个async钩子，在这个钩子中绑定了读取文件的对象。接着是`run`这个async钩子，在这个钩子中主要是处理缓存的模块，减少编译的模块，加速编译速度。之后才会进去入`Compiler.compile()`的编译环节。

`Compiler.run的关键代码this.hooks.beforeRun.callAsync(this, err => {    ....this.hooks.run.callAsync(this, err => {    ....this.compile(onCompiled);....});....});`

等Compiler.compile运行结束之后会回调run中名为onCompiled的函数，这个函数的作用就是将编译后的内容生成文件。我们可以看到首先是`shouldEmit`判断是否编译成功，未成功则结束`done`，打印相应信息。成功则调用`Compiler.emitAssets`打包文件。

`Compiler.run中编译成功结束之后的回调函数关键代码if (this.hooks.shouldEmit.call(compilation) === false) {...this.hooks.done.callAsync(stats, err => {...    }    return}this.emitAssets(compilation, err => {    ...    if (compilation.hooks.needAdditionalPass.call()) {    ...    this.hooks.done.callAsync(stats, err => {});    };})`

#### `Compiler.compile()`

上一节只讨论了Compiler.run方法的整体流程，并未提及Compiler.compile，这个compiler顾名思义就是编译的意思。那么编译的过程中究竟发生了写什么呢？

`const params = this.newCompilationParams();this.hooks.beforeCompile.callAsync(params, err => {    ...this.hooks.compile.call(params);const compilation = this.newCompilation(params);    this.hooks.make.callAsync(compilation, err => {    ...        compilation.finish();        ompilation.seal(err => {...this.hooks.afterCompile.callAsync(compilation, err => {    ...    此处是回调函数，这个函数主要用于将编译成功的代码输出    ...});});});});`

首先是定义了`params`并传入了`hooks.compile`这个钩子中，`params`就是模块工厂，其中最常用的就是`normalModuleFactory`，将这个工厂传入钩子中，方便之后的插件或钩子操作模块。

> 钩子想要和程序产生联系，比如在compiler中加内容，就需要将Compiler传入钩子中，才可行，否则并无接口暴露给插件。
然后是beforeCompile预备一下，接着就是启动compile这个钩子。
这里新建了Compilation，一个很重要的专注于编译的类。

`hooks.make`这个钩子就是正式启动编译了，所以这个钩子执行完毕就意味这编译结束了，可以进行封装seal了。那么make这个钩子触发的时候，执行了那些步骤呢？

大家是否还记得在webpack.js中提到过的`EntryOptionPlugin`？

`WebpackOptionsApply.js    new EntryOptionPlugin().apply(compiler);    compiler.hooks.entryOption.call(options.context, options.entry);`

![](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1056" height="570"></svg>)

> 来自笔者的话痨：webpack的模块构建其实是通过entry，也就是入口文件开始分析，开始构建。也就是说一个入口文件会触发一次Compliation.addEntry，然后触发之后就是Compilation开始构建模块了。

`EntryOptionPlugin`是帮助我们处理入口类型的插件，他会webpack.config.js中entry的不同配置帮助我们搭配不同的EntryPlugin。通过entry配置进入的一共有3种类型，SingleEntryPlugin，MultiEntryPlugin和DynamicEntryPlugin，根据名字就能够轻易区分他们的类型。一般一个compiler只会触发一个EntryPlugin，然后在这个EntryPlugin中，会有我们构建模块的入口，也就是compilation的入口。

`???EntryPlugin.jscompiler.hooks.make.tapAsync("SingleEntryPlugin|MultiEntryPlugin|DynamicEntryPlugin",(compilation, callback) => {     ...compilation.addEntry(context, dep, name, callback);...});`

除了帮助我们打开compilation的大门之外，`???EntryPlugin`还绑定了一个事件就是，当前入口的模块工厂类型。

`SingleEntryPlugin.jscompiler.hooks.compilation.tap("SingleEntryPlugin",(compilation, { normalModuleFactory }) => {compilation.dependencyFactories.set(SingleEntryDependency,normalModuleFactory);});`

这个钩子函数帮我们定义了`SingleEntry`的模块类型，那么之后compliation编译的时候就会使用`normalModuleFactory`来创造模块。

`make`这个钩子相当于一个转折点，我们从主流程中跳转到正真编译的流程之中——compilation，一个专注于编译优化的类。
等compilation编译成功之后，再回到compiler主战场，我们将编译成功的内容`emitAssest`到硬盘上。

### 专业编译100年——Compilation.js

![](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1280" height="895"></svg>)

如果说Compiler是流程，那么Compilation就是编译主场了。也就是源代码经过他加工之后才得到了升华变成了规规矩矩的模样。

Compilation的工作总结起来就是，添加入口entry，通过entry分析模块，分析模块之间的依赖关系，就像图表一样。构建完成之后就开始seal，封装了这个阶段Compilation干了一系列的优化措施以及将解析后的模块转化为标准的webpack模块，输出备用，前提是你将优化plugin挂到了各个优化的hooks上面，触发了优化的钩子，但是钩子上也要注册了函数才能生效。

好了我们从Compile得到的信息来按照出场顺序分析Compilation.js

#### addEntry——一切开始的地方

上一节提到的`SingleEntryPlugin`（还有其他的EntryPlugin），就是一个启动口，等到触发`compile.hooks.make`的时候，就会启动`SingleEntryPlugin`中的`compilation.addEntry`这个方法，这个方法就是启动构建入口模块，成功后将入口模块添加到程序之中。

`//context,entry,name都是options中的值。addEntry(context, entry, name, callback) {this._addModuleChain(context,entry,module => {this.entries.push(module);},(err, module) => {...if (module) {slot.module = module;} else {const idx = this._preparedEntrypoints.indexOf(slot);if (idx >= 0) {this._preparedEntrypoints.splice(idx, 1);}}...return callback(null, module);});}`

#### 添加模块的依赖`_addModuleChain`

这个方法是模块构建的主要方法，由addEntry调用，等模块构建完成之后返回。

- `_addModuleChain`，构建模块，同时保存模块间之间的依赖。
    - `const moduleFactory = this.dependencyFactories.get(Dep);moduleFactory.create(...)`，这里的`moduleFactory`其实就是当前模块的类型的创造工厂，create就是从这个工厂中创造除了新产品（新模块）。
        - `this.addModule(module)->this.modules.push(module);`，将模块加入compilation.modules之中。
        - `onModule(module);`, 这个方法调用了addEntry中`this.entries.push(module)`，也就是将入口模块加入compilation.entries。
        - `this.buildModule->this.hooks.buildModule.call(module);module.build(...)`，这个方法就是给出了一个可以对module进行操作的hooks，大家可以自行定义plugin对此进行操作。之后便是模块自行的一个创建，这个创建的方法更具模块类型而定，比如normalModuleFactor创建的模块就来自NormalModule这个类。
            - _addModuleChain的内置方法`afterBuild()`，这个方法就是获取模块和模块依赖的创建所耗费的时间，然后如果有回调函数就执行回调函数。

#### 构建结束之后，回到Compiler，finish我们的构建

这里finish干了两件事，一件就是出发了结束构建的钩子，然后就是收集了每个模块构建是产生的问题。

#### 一切就绪，开始封装seal(callback)

产品已经准备好，准备打包出口。
开始逐个执行优化的钩子，如果大家有写优化的钩子的化。
开始优化：
此处是优化依赖的hook
此处是优化module的hook
此处是优化Chunk的hook
。。。。。
> 太多优化了，笔者已经开溜了。
优化结束之后开始执行来自Compiler的回调函数，也就是将生成文件。

除了各类钩子的call之外，seal还干了一件很重要时就是将格式化的js，通过Template模版，重新聚合在一起，然后回调Compiler生成文件。这一块会在之后Template的时候具体分析。

> 笔者有话说，其实主流程就是Compiler和Compliation，这两个类互相合作。接下来还有几个比较关键的类，不过从我的角度看来，不属于主要流程，但是很重要，因为是模块创建的类。就像是流水线上的产品一样，产品本身和流水线的流程无关。

### 模块的发源地—moduleFactory

![](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1280" height="889"></svg>)

moduleFactory是模块的实例，不过并不属于主流程，就像是乐高的零件一样，没有它，我们会拼又如何？巧妇难为无米之炊！需要编译的moduleFactory分为两类context和normal，我基本上遇到的都是normal类型的，所以这里以noraml类为主解释moduleFactory。

#### 他的使命

既然他是工厂，那么他的使命就是制作产品。这里模块就是产品，因此工厂只需要一个就够了。我们的工厂是在Compiler.compile中创建的，并将此作为参数传入了`compile.hooks.beforeCompile`和`compile.hooks.compile`这两个钩子之中，这意味着我们在写这两个钩子的挂载函数的时候，就可以调用这个工厂帮我们创建处理模块了。

`const NormalModule = require("./NormalModule");const RuleSet = require("./RuleSet");`

这两个参数很重要，一个是产品本身，也就是通过NormalModule创建的实例就是模块。`RuleSet`就是loaders，其中包括自带的loader和自定义的loader。也就是说Factory干了两件事，第一件是匹配了相对应的parser，将parser配置成了专门用于当前模块的解析器将源码解析成AST模式，第二件是创建generator用于生成代码也就是还原AST（这一块是模版生成的时候会用到），第三件是创建模块，构建模块的时候给他找到相映的loader，替换源码，添加相映的依赖模块，然后在模块解析的时候提供相应的parser解析器，在生成模版的时候提供相应的generator。

#### normalModule类

Fatory提供了原料（options）和工具（parser），就等于将参数输给了自动化的机器，这个normalModule就是创造的机器，由他来build模块，并将源码变为AST语法树。

`normalModule.js创建模块阶段build(options, compilation, resolver, fs, callback) {    //...return this.doBuild(options, compilation, resolver, fs, err => {    //...this._cachedSources.clear();//...try {const result = this.parser.parse(//重点在这里。//....);    //...});}`

在Compilation中模块创建好之后，开始触发module的build方法，开始生成模块，他的逻辑很简单，就是输入source源文件，然后通过reslover解析文件loader和依赖的文件，并返回结果。然后通过loader将此转化为标准的webpack模块，存储source，等待生成模版的时候备用。

等到需要打包的时候，就将编译过的源码在重组成JS代码，主要通过Facotry给模块配备的generator。

`normalModule.js生成代码阶段source(dependencyTemplates, runtimeTemplate, type = "javascript") {//...获取缓存const source = this.generator.generate(this,dependencyTemplates,runtimeTemplate,type);    //...存到缓存中return cachedSource;}`

### loader进行曲

#### loader究竟在哪里执行，如何执行

对于初学者来说，loader和plugin可能会傻傻地分不清（没错，我就是那个傻子）。深入了解源码之后，我才明明白白了解两者的不同。

| 懵懂的我 | 了解套路的我 |
| --- | --- |
| 区别1: plugin范围广，嗯，含义真的很广 | 区别1: plugin可以在任何一个流程节点出现，loader有特定的活动范围 |
| 区别2: 配置地方不一致，loader的配置很奇怪，居然不是module.loaders，而是module.ruleset | 区别2: plugin可以做和源码无关的事，比如监控，loader只能解析源码变成标准模块。 |

那么loader究竟在哪里执行的呢？了解了`Compilation`、`NormalModuleFactory`、`NormalModule`的功能之后，听我娓娓道来loader是如何进入module的！

首先是`Compilation._addModuleChain`开始添加模块时，触发了`Compilation.buildModule`这个方法，然后调用了`NormalModule.build`，开始创建模块了。创建模块之时，会调用`runLoaders`去执行loaders，但是对于loader所在的位置，程序还是迷茫的，所以这个时候需要请求`NormalModuleFactory.resolveRequestArray`，帮我们读取loader所在的地址，执行并返回。就这样一个个模块生成，一个个loader生成，直到最后一个模块创建完毕，然后就到了`Compilation.seal`的流程了。

#### 灵魂Parser

等到当前模块处理完loaders之后，将导入模块变成标准的JS模块之后，就要开始分解源码了，让它变成标准的AST语法树，这个时候就要依靠Parser。Parser很强大，他帮助我们将不规范的内容转化为标准的模块，方便打包活着其他操作。Parser相当于一个机器，源文件进入，然后处理，然后输出，源文件并未于Parser产生化学作用。Parser不是按照normalModule创建的个数存在的，而是按照模块的类型给匹配的。想想如果工厂中给每一个产品都配一个解析器，那么效率成功地biubiubiu下降了了。

javascript类型的Parser一共有3个类型，"auto"、"script"和"module"，根据模块的需求，Factoy帮我们匹配不同类型的Parser。

`JavascriptModulesPlugin.jsnormalModuleFactory.hooks.createParser.for("javascript/auto").tap("JavascriptModulesPlugin", options => {return new Parser(options, "auto");});normalModuleFactory.hooks.createParser.for("javascript/dynamic").tap("JavascriptModulesPlugin", options => {return new Parser(options, "script");});normalModuleFactory.hooks.createParser.for("javascript/esm").tap("JavascriptModulesPlugin", options => {return new Parser(options, "module");});`

Parser实则呢么解析我们的源码的呢？
首先先变成一个AST——标准的语法树，结构化的代码，方便后期解析，如果传入的source不是ast，也会被强制ast再进行处理。
这个解析库，webpack用的是acorn。

`Parser.jsstatic parse(code, options) {.....ast = acorn.parse(code, parserOptions);.....return ast;}parse(source, initialState) {    //...ast = Parser.parse(source, {sourceType: this.sourceType,onComment: comments});//...}`

### 叮咚——你的打包模版Template

![](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="891" height="1280"></svg>)

终于到了收尾的时候了，不过这个部分也不及简单呢。

Template是在compilation.seal的时候触发的们也就是模块构建完成之后。我们要将好不容易构建完成的模块再次重组成js代码，也就是我们在bundle中见到的代码。

我们打包出来的js，总是用着相同的套路？这是为什么？很明显有个标准的模版。等到我们的源文件变成ast之后，准备输出的处理需要依靠Template操作如何输出，以及webpack-source帮助我们合并替换还是ast格式的模块。最后按照chunk合并一起输出。

Template的类一共有5个：

- Template.js
- MainTemplate.js
- ModuleTemplate.js
- RuntimeTemplate
- ChunkTemplate.js

当然！模版替换是在Compilation中执行的，毕竟Compilation就像一个指挥者，指挥者大家如何按顺序一个个编译。

Compilation.seal触发了MainTemplate.getRenderManifest，获取需要渲染的信息，接着通过中的钩子触发了`mainTemplate.hooks.renderManifest`这个钩子，调用了JavascriptModulePlugin中相应的函数，创建了一个含有打包信息的fileManifest返回备用。

`JavascriptModulePlugin.jsresult.push({render: () =>compilation.mainTemplate.render(hash,chunk,moduleTemplates.javascript,dependencyTemplates),filenameTemplate,pathOptions: {noChunkHash: !useChunkHash,contentHashType: "javascript",chunk},identifier: `chunk${chunk.id}`,hash: useChunkHash ? chunk.hash : fullHash});`

![](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1202" height="256"></svg>)

`Compilation.jscreateChunkAssets(){    //...    const manifest = template.getRenderManifest(...)//获取渲染列表    //...    for (const fileManifest of manifest) {        //...        source = fileManifest.render();        //...    }    //...}`

准备工作做完之后就要开始渲染了，调用了fileManifest的render函数，其实就是`mainTemplate.render`。`mainTemplate.render`触发了`hooks.render`这个钩子，返回了一个`ConcatSource`的资源。其中有固定的模板，也有调用的模块。

`MainTemplate.js//...this.hooks.render.tap("MainTemplate",(bootstrapSource, chunk, hash, moduleTemplate, dependencyTemplates) => {const source = new ConcatSource();source.add("/******/ (function(modules) { // webpackBootstrap\n");    //...source.add(this.hooks.modules.call(//获取模块的资源new RawSource(""),chunk,hash,moduleTemplate,dependencyTemplates));source.add(")");return source;});//..render(hash, chunk, moduleTemplate, dependencyTemplates) {//...let source = this.hooks.render.call(new OriginalSource(Template.prefix(buf, " \t") + "\n","webpack/bootstrap"),chunk,hash,moduleTemplate,dependencyTemplates);//...return new ConcatSource(source, ";");}`

各个模块的模板替换MainTemplate将任务分配给了Template，让他去处理模块们的问题，于是调用了`Template.renderChunkModules`这个方法。这个方法首先是获取所有模块的替换资源。

`Template.jsstatic renderChunkModules(chunk,filterFn,moduleTemplate,dependencyTemplates,prefix = ""){const source = new ConcatSource();const modules = chunk.getModules().filter(filterFn);//...const allModules = modules.map(module => {return {id: module.id,source: moduleTemplate.render(module, dependencyTemplates, {chunk})};});//...//...}`

然后`ModuleTemplate`再去请求`NormalModule.source`这个方法。这里的module便使用了Factory给他配备的generator，生成了替换代码，generate阶段的时候会请求`RuntimeTemplate`，根据名字可以得知，是用于替换成运行时的代码。

`NormalModule.jssource(dependencyTemplates, runtimeTemplate, type = "javascript") {//...const source = this.generator.generate(this,dependencyTemplates,runtimeTemplate,type);const cachedSource = new CachedSource(source);//..return cachedSource;}`

![NormalModule.generator.generate产生的资源](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1280" height="973"></svg>)

然后丢入NormalModule将此变为cachedSource，返回给`ModuleTemplate`进一步处理。`ModuleTemplate`在对这个模块进行打包，最后出来的效果是这样的：

![ModuleTemplate最终处理结果](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1280" height="258"></svg>)

我们再回到`Template`，继续处理，经过`ModuleTemplate`的处理之后，我们返回的数据长这样。

![ModuleTemplate返回给Template的效果](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="762" height="476"></svg>)

革命尚未结束！替换仍在进行！我们回到`Template.renderChunkModules`，继续替换。

`static renderChunkModules(chunk,filterFn,moduleTemplate,dependencyTemplates,prefix = ""){const source = new ConcatSource();const modules = chunk.getModules().filter(filterFn);//...如果没有模块，则返回"[]"source.add("[]");return source;//...如果有模块则获取所有模块const allModules = modules.map(//...);//...开始添加模块source.add("[\n");//...    source.add(`/* ${idx} */`);source.add("\n");source.add(module.source);source.add("\n" + prefix + "]");//...return source;}`

![Template的最终返回](data:image/svg+xml;utf8,<?xml version="1.0"?><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1280" height="1120"></svg>)

我们将ConcatSource返回至`MainTemplate.render()`，再加个`;`，然后组合返回至`Compliation.createChunkAssets`。

到此seal中template就告一段落啦。至于生成文件，那就是通过webpack-source这个包，将我们的饿数组变成字符串然后拼接，最后输出。
> 所有图片素材均出自笔者之手，欢迎大家转载，请标明出处。毕竟捣鼓了一个多月，感觉自己都要秃了。
> 在酝酿下一篇研究什么了。感觉loader还需要多扒扒。（笑～）
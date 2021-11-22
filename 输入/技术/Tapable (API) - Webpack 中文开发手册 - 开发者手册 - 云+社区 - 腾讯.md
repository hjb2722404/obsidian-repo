Tapable (API) - Webpack 中文开发手册 - 开发者手册 - 云+社区 - 腾讯云

# Tapable

[Tapable](https://github.com/webpack/tapable)是一个小型库，允许你添加和应用插件到一个javascript模块。它可以被继承或混入其他模块。它类似于NodeJS的` EventEmitter `课程，专注于定制事件发射和操作。但是，除此之外，还` Tapable `允许您通过回调参数访问事件的“排放者”或“生产者”。

` Tapable ` 有四组成员函数：

- ` plugin(name:string, handler:function) `：这允许自定义插件注册到**Tapable实例**的事件中。这起到类似` on() `的方法` EventEmitter `，这是用于注册一个处理程序/侦听器当信号/事件发生做一些事情。
- ` apply(…pluginInstances: (AnyPlugin|function)[]) `：` AnyPlugin `应该是一个具有方法的类（或者很少，是一个对象）` apply `，或者只是一个带有一些注册码的函数。此方法仅**适用于**插件的定义，以便真正的事件侦听器可以注册到*Tapable*实例的注册表中。
- ` applyPlugins*(name:string, …) `：*Tapable*实例可以使用这些函数将特定哈希下的所有插件应用。这组方法就像使用各种策略精心控制事件发射的` emit() `方法` EventEmitter `。
- ` mixin(pt: Object) `：一种简单的方法来将` Tapable `原型扩展为mixin而不是继承。

不同的` applyPlugins* `方法涵盖以下用例：

- 插件可以串行运行。
- 插件可以并行运行。
- 插件可以一个接一个地运行，但从前一个插件（瀑布）获取输入。
- 插件可以异步运行。
- 放弃保释运行插件：也就是说，一旦一个插件返回非插件` undefined `，跳出运行流程并返回*该插件的返回*。这听起来像` once() `的` EventEmitter `，但是是完全不同的。

## 例

webpack的*Tapable*实例之一编译器负责编译webpack配置对象并返回一个编译实例。编译实例运行时，将创建所需的捆绑包。
请参阅下面的简化版本，了解它如何使用` Tapable `：
**node_modules/webpack/lib/Compiler.js**

var Tapable =  require("tapable");function  Compiler()  { Tapable.call(this);}Compiler.prototype = Object.create(Tapable.prototype);

现在在编译器上编写一个插件，
**my-custom-plugin.js**

function  CustomPlugin()  {}CustomPlugin.prototype.apply  =  function(compiler)  { compiler.plugin('emit', pluginFunction);}

编译器在其生命周期的适当位置通过执行插件
[**纠错](Tapable%20(API)%20-%20Webpack%20中文开发手册%20-%20开发者手册%20-%20云+社区%20-%20腾讯.md#)
**node_modules/webpack/lib/Compiler.js**

this.apply*("emit",options)  // will fetch all plugins under 'emit' name and run them.

本文档系腾讯云云+社区成员共同维护，如有问题请联系 yunjia_community@tencent.com
最后更新于：2017-12-18
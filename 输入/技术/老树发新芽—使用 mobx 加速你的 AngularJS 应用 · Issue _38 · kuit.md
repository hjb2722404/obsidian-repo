老树发新芽—使用 mobx 加速你的 AngularJS 应用 · Issue #38 · kuitos/kuitos.github.io

# 老树发新芽—使用 mobx 加速你的 AngularJS 应用

1月底的时候，Angular 官方博客发布了一则消息：

**> AngularJS**>  is planning one more significant release, version 1.7, and on July 1, 2018 it will enter a 3 year Long Term Support period.

即在 7月1日 AngularJS 发布 1.7.0 版本之后，AngularJS 将进入一个为期 3 年的 LTS 时期。也就是说 2018年7月1日 起至 2021年6月30日，AngularJS 不再合并任何会导致 breaking changes 的 features 或 bugfix，只做必要的问题修复。详细信息见这里：[Stable AngularJS and Long Term Support](https://blog.angular.io/stable-angularjs-and-long-term-support-7e077635ee9c)

看到这则消息时我还是感触颇多的，作为我的前端启蒙框架，我从 AngularJS 上汲取到了非常多的养分。虽然 AngularJS 作为一款优秀的前端 MVW 框架已经出色的完成了自己的历史使命，但考虑到即便到了 2018 年，许多公司基于 AngularJS 的项目依然处于服役阶段，结合我过去一年多在 mobx 上的探索和实践，我决定给 AngularJS 强行再续一波命。(搭车求治拖延症良方，二月初起草的文章五月份才写完，新闻都要过期了)

## 准备工作

在开始之前，我们需要给 AngularJS 搭配上一些现代化 webapp 开发套件，以便后面能更方便地装载上 mobx 引擎。

### AngularJS 配合 ES6/next

现在是2018年，使用 ES6 开发应用已经成为事实标准(有可能的推荐直接上 TS )。如何将 AngularJS 搭载上 ES6 这里不再赘述，可以看我之前的这篇文章：[Angular1.x + ES6 开发风格指南](https://github.com/kuitos/kuitos.github.io/issues/34)

### 基于组件的应用架构

AngularJS 在 1.5.0 版本后新增了一系列激动人心的特性，如 onw-way bindings、component lifecycle hooks、component definition 等，基于这些特性，我们可以方便的将 AngularJS 系统打造成一个纯组件化的应用(如果你对这些特性很熟悉可直接跳过至 [AngularJS 搭配 mobx](https://github.com/kuitos/kuitos.github.io/issues/38#AngularJS%20%E6%90%AD%E9%85%8D%20mobx))。我们一个个来看：

- onw-way bindings 单向绑定

AngularJS 中使用 [object Object]来定义组件的单向数据绑定，例如我们这样定义一个组件：

angular  .module('app.components',  [])  .directive('component',  ()  =>  ({  restrict: 'E',  template: '<p>count: {{$ctrl.count}}</p><button ng-click="$ctrl.count = $ctrl.count + 1">increase</button>'  scope: {  count: '<'  },  bindToController: true,  controllerAs: '$ctrl',  })

使用时：
{{app.count}}<component  count="app.count"></component>
当我们点击组件的 increase 按钮时，可以看到组件内的 count 加 1 了，但是 [object Object]并不受影响。

区别于 AngularJS 赖以成名的双向绑定特性 [object Object]，单向数据绑定能更有效的隔离操作影响域，从而更方便的对数据变化溯源，降低 debug 难度。

双向绑定与单向绑定有各自的优势与劣势，这里不再讨论，有兴趣的可以看我这篇回答：[单向数据绑定和双向数据绑定的优缺点，适合什么场景？](https://www.zhihu.com/question/49964363/answer/136022879)

- component lifecycle hooks 组件生命周期钩子

1.5.3 开始新增了几个组件的生命周期钩子（目的是为更方便的向 Angular2+ 迁移），分别是 [object Object]  [object Object]  [object Object]  [object Object]  [object Object](1.5.8增加)，写起来大概长这样：

class  Controller  {  $onInit()  {  // initialization  }  $onChanges(changesObj)  {  const  { user }  =  changesObj;  if(user  && !user.isFirstChange())  {  // changing  }  }  $onDestroy()  {}  $postLink()  {}  $doCheck()  {}  }angular  .module('app.components',  [])  .directive('component',  ()  =>  ({ controller: Controller, ...}))

事实上在 1.5.3 之前，我们也能借助一些机制来模拟组件的生命周期(如 [object Object]、[object Object]等)，但基本上都需要借助[object Object]这座‘‘桥梁’’。但现在我们有了框架原生 lifecycle 的加持，这对于我们构建更纯粹的、框架无关的 ViewModel 来讲有很大帮助。更多关于 lifecycle 的信息可以看官方文档：[AngularJS lifecycle hooks](https://code.angularjs.org/1.6.7/docs/api/ng/service/$compile#life-cycle-hooks)

- component definition

AngularJS 1.5.0 后增加了 [object Object] 语法用于更方便清晰的定义一个组件，如上述例子中的组件我们可以用[object Object]语法改写成：

angular  .module('app.components',  [])  .component('component',  {  template: '<p>count: {{$ctrl.count}}</p><button ng-click="$ctrl.onUpdate({count: $ctrl.count + 1})">increase</button>'  bindings: {  count: '<', onUpdate: '&'  },  })

本质上[object Object]就是[object Object]的语法糖，bindings 是 [object Object] 的语法糖，只不过[object Object]语法更简单语义更明了，定义组件变得更方便，与社区流行的风格也更一致(熟悉 vue 的同学应该已经发现了)。更多关于 AngularJS 组件化开发的 best practice，可以看官方的开发者文档：[Understanding Components](https://code.angularjs.org/1.6.7/docs/guide/component)

## AngularJS 搭配 mobx

准备工作做了一堆，我们也该开始进入本文的正题，即如何给 AngularJS 搭载上 mobx 引擎（本文假设你对 mobx 中的基础概念已经有一定程度的了解，如果不了解可以先移步 [mobx repo](https://github.com/mobxjs/mobx)  [mobx official doc](https://mobx.js.org/)）：

### 1. mobx-angularjs

引入 [mobx-angularjs](https://github.com/mobxjs/mobx-angularjs) 库连接 mobx 和 angularjs 。

npm i mobx-angularjs -S

### 2. 定义 ViewModel

在标准的 MVVM 架构里，ViewModel/Controller 除了构建视图本身的状态数据(即局部状态)外，作为视图跟业务模型之间沟通的桥梁，其主要职责是将业务模型适配(转换/组装)成对视图更友好的数据模型。因此，在 mobx 视角下，ViewModel 主要由以下几部分组成：

- 视图(局部)状态对应的 observable data

class  ViewModel  { @observable  isLoading  =  true;@observableisModelOpened  =  false;}

可观察数据(对应的 observer 为 view)，即视图需要对其变化自动做出响应的数据。在 mobx-angularjs 库的协助下，通常 observable data 的变化会使关联的视图自动触发 rerender(或触发网络请求之类的副作用)。ViewModel 中的 observable data 通常是视图状态(UI-State)，如 isLoading、isOpened 等。

- 由 应用/视图 状态衍生的 computed data

> Computed values are values that can be derived from the existing state or other computed values.

class  ViewModel  { @computed  get  userName()  {  return  `${this.user.firstName}  ${this.user.lastName}`;  }}

计算数据指的是由其他 observable/computed data 转换而来，更方便视图直接使用的衍生数据(derived data)。 **在重业务轻交互的 web 类应用中(通常是各种企业服务软件)， computed data 在 ViewModel 中应该占主要部分，且基本是由业务 store 中的数据(即应用状态)转换而来。** computed 这种数据推导关系描述能确保我们的应用遵循 single source of truth 原则，不会出现数据不一致的情况，这也是 RP 编程中的基本原则之一。

- action

ViewModel 中的 action 除了一小部分改变视图状态的行为外，大部分应该是直接调用 Model/Store 中的 action 来完成业务状态的流转。建议把所有对 observable data 的操作都放到被 aciton 装饰的方法下进行。

mobx 配合下，一个相对完整的 ViewModel 大概长这样：

import  UserStore  from  './UserStore';  class  ViewModel  { @inject(UserStore)  store;@observable  isDropdownOpened  =  false;@computedget  userName()  { return  `${this.store.firstName}  ${this.store.lastName}`;} @actiontoggel()  { this.isDropdownOpened  = !isDropdownOpened;}  updateFirstName(firstName)  {  this.store.updateFirstName(firstName);  }}

### 3. 连接 AngularJS 和 mobx

<section  mobx-autorun><counter  value="$ctrl.count"></counter>  <button  type="button" ng-click="$ctrl.increse()">increse</button></section>

import  template  from  './index.tpl.html';class  ViewModel  { @observable  count  =  0;@action  increse()  { this.count++;}}export  default  angular  .module('app',  [])  .component('container',  { template, controller: Controller,})  .component('counter',  { template: '<section><header>{{$ctrl.count}}</header></section>' bindings: {  value: '<'  }}).name;

可以看到，除了常规的基于 mobx 的 ViewModel 定义外，我们只需要在模板的根节点加上 [object Object] 指令，我们的 angularjs 组件就能很好的运作的 mobx 的响应式引擎下，从而自动的对 observable state 的变化执行 rerender。

## mobx-angularjs 加速应用的魔法

从上文的示例代码中我们可以看到，将 mobx 跟 angularjs 衔接运转起来的是 [object Object]指令，我们翻下 [mobx-angularjs](https://github.com/mobxjs/mobx-angularjs) 代码：

const  link: angular.IDirectiveLinkFn  =  ($scope)  =>  {  const  { $$watchers =  []  }  =  $scope  as  any  const  debouncedDigest  =  debounce($scope.$digest.bind($scope),  0);  const  dispose  =  reaction(  ()  =>  [...$$watchers].map(watcher  =>  watcher.get($scope)),  ()  => !$scope.$root.$$phase  &&  debouncedDigest()  )  $scope.$on('$destroy',  dispose)}

可以看到 [核心代码](https://github.com/mobxjs/mobx-angularjs/blob/master/src/index.ts#L19) 其实就三行：

reaction(  ()  =>  [...$$watchers].map(watcher  =>  watcher.get($scope)),  ()  => !$scope.$root.$$phase  &&  debouncedDigest()

思路非常简单，即在指令 link 之后，遍历一遍当前 scope 上挂载的 watchers 并取值，由于这个动作是在 mobx reaction 执行上下文中进行的，因此 watcher 里依赖的所有 observable 都会被收集起来，这样当下次其中任何一个 observable 发生变更时，都会触发 reaction 的副作用对 scope 进行 digest，从而达到自动更新视图的目的。

我们知道，angularjs 的性能被广为诟病并不是因为 ‘脏检查’ 本身慢，而是因为 angularjs 在每次异步事件发生时都是无脑的从根节点开始向下 digest，从而会导致一些不必要的 loop 造成的。而当我们在搭载上 mobx 的 push-based 的 change propagation 机制时，**只有当被视图真正使用的数据发生变化时，相关联的视图才会触发局部 digest (可以理解为只有 observable data 存在 subscriber/observer 时，状态变化才会触发关联依赖的重算，从而避免不必要资源消耗，即所谓的 lazy)**，区别于异步事件触发即无脑地 [object Object], 这种方式显然更高效。

## 进一步压榨性能

我们知道 angularjs 是通过劫持各种异步事件然后从根节点做 apply 的，这就导致只要我们用到了会被 angularjs 劫持的特性就会触发 apply，其他的诸如 [object Object]  [object Object] 都好说，我们有很多替代方案，但是 [object Object] 这类事件监听指令我们无法避免，就像上文例子中一样，假如我们能杜绝潜藏的根节点 apply，想必应用的性能提升能更进一步。

思路很简单，我们只要把 [object Object] 之流替换成不触发 apply 的版本即可。比如把[原来的 ng event 实现](https://github.com/angular/angular.js/blob/master/src/ng/directive/ngEventDirs.js#L49)这样改一下：

forEach(  'click dblclick mousedown mouseup mouseover mouseout mousemove mouseenter mouseleave keydown keyup keypress submit focus blur copy cut paste'.split(' '),  function(eventName)  {  var  directiveName  =  directiveNormalize('native-'  +  eventName);  ngEventDirectives[directiveName]  =  ['$parse',  '$rootScope',  function($parse,  $rootScope)  {  return  {  restrict: 'A',  compile: function($element,  attr)  {  var  fn  =  $parse(attr[directiveName],  /* interceptorFn */  null,  /* expensiveChecks */  true);  return  function  ngEventHandler(scope,  element)  {  element.on(eventName,  function(event)  {  fn(scope,  {$event:event})  });  };  }  };  }];  });

时间监听的回调中只是简单触发一下绑定的函数即可，不再 apply，bingo！

## 注意事项/ best practise

在 mobx 配合 angularjs 开发过程中，有一些点我们可能会 碰到/需要考虑：

- 避免 TTL

单向数据流优点很多，大部分场景下我们会优先使用 one-way binding 方式定义组件。通常你会写出这样的代码：

class  ViewModel  { @computed  get  unCompeletedTodos()  {  return  this.store.todos.filter(todo  => !todo.compeleted)  }}

<section  mobx-autorun>  <todo-panel  todos="$ctrl.unCompeletedTodos"></todo-panel></section>

[object Object] 组件使用单向数据绑定定义：

angular  .module('xxx',  [])  .component('todoPanel',  { template: '<ul><li ng-repeat="todo in $ctrl.todos track by todo.id">{{todo.content}}</li></ul>' bindings: {  todos: '<'  }})

看上去没有任何问题，但是当你把代码扔到浏览器里时就会收获一段 angularjs 馈赠的 TTL 错误：[object Object]。实际上这并不是 mobx-angularjs 惹的祸，而是 angularjs 目前未实现 one-way binding 的 deep comparison 导致的，由于每次 [object Object] 都会返回一个新的数组引用，而[object Object]又是基于引用作对比，从而每次 [object Object] 都是 false，最后自然报 TTL 错误了（具体可以看这里 [One-way bindings + shallow watching](https://github.com/angular/angular.js/issues/14039) ）。

不过好在 mobx 优化手段中恰好有一个方法能间接的解决这个问题。我们只需要给 computed 加一个表示要做深度值对比的 modifier 即可：

@computed.structget  unCompeletedTodos()  {  return  this.store.todos.filter(todo  => !todo.compeleted)}

本质上还是对 unCompeletedTodos 的 memorization，只不过对比基准从默认的值对比(===)变成了结构/深度 对比，因而在第一次 get unCompeletedTodos 之后，只要计算出来的结果跟前次的结构一致(只有当 computed data 依赖的 observable 发生变化的时候才会触发重算)，后续的 getter 都会直接返回前面缓存的结果，从而不会触发额外的 diff，进而避免了 TTL 错误的出现。

- [object Object] 和 [object Object] 触发顺序的问题

通常情况下我们希望在 ViewModel 中借助组件的 lifecycle 钩子做一些事情，比如在 [object Object] 中触发副作用(网络请求，事件绑定等)，在 [object Object] 里监听传入数据变化做视图更新。

class  ViewModel  {  $onInit()  { this.store.fetchUsers(this.id);  }  $onChanges(changesObj)  {  const  { id }  =  changesObj;  if(id  && !id.isFirstChange())  {  this.store.fetchUsers(id.currentValue)  }  }}

可以发现其实我们在 [object Object] 和 [object Object] 中做了重复的事情，而且这种写法也与我们要做视图框架无关的数据层的初衷不符，借助 mobx 的 observe 方法，我们可以将上面的代码改造成这种：

import  {  ViewModel,  postConstruct  }  from  'mmlpx';@ViewModelclass  ViewModel  { @observable  id  =  null; @postConstruct  onInit()  {  observe(this,  'id',  changedValue  =>  this.store.fetchUsers(changedValue))  }}

熟悉 angularjs 的同学应该能发现，事实上 observe 做的事情跟 [object Object] 是一样的，但是为了保证数据层的 UI 框架无关性，我们这里用 mobx 自己的观察机制来替代了 angularjs 的 watch。

- **忘记你是在写 AngularJS，把它当成一个简单的动态模板引擎**

不论是我们尝试将 AngularJS 应用 ES6/TS 化还是引入 mobx 状态管理库，实际上我们的初衷都是将我们的 Model 甚至 ViewModel 层做成视图框架无关，在借助 mobx 管理数据的之间的依赖关系的同时，通过 connector 将 mobx observable data 与视图连接起来，从而实现视图依赖的状态发生变化自动触发视图的更新。在这个过程中，angularjs 不再扮演一个框架的角色影响整个系统的架构，而仅仅是作为一个动态模板引擎提供 render 能力而已，后续我们完全可以通过配套的 connector，将 mobx 管理的数据层连接到不同的 view library 上。目前 mobx 官方针对 React/Angular/AngularJS 均有相应的 connector，社区也有针对 vue 的解决方案，并不需要我们从零开始。

在借助 mobx 构建数据层之后，我们就能真正做到标准 MVVM 中描述的那样，在 Model 甚至 VIewModel 不改一行代码的前提下轻松适配其他视图。view library 的语法、机制差异不再成为视图层 升级/替换 的鸿沟，我们能通过改很少量的代码来填平它，毕竟只是替换一个动态模板引擎而已。

## Why MobX

> React and MobX together are a powerful combination. React renders the application state by providing mechanisms to translate it into a tree of renderable components. MobX provides the mechanism to store and update the application state that React then uses.

> Both React and MobX provide optimal and unique solutions to common problems in application development. React provides mechanisms to optimally render UI by using a virtual DOM that reduces the number of costly DOM mutations. MobX provides mechanisms to optimally synchronize application state with your React components by using a reactive virtual dependency state graph that is only updated when strictly needed and is never stale.

MobX 官方的介绍，把上面一段介绍中的 React 换成任意其他( Vue/Angular/AngularJS ) 视图框架/库(VDOM 部分适当调整一下) 也都适用。得益于 MobX 的概念简单及独立性，它非常适合作为视图中立的状态管理方案。简言之是视图层只做拿数据渲染的工作，状态流转由 MobX 帮你管理。

## Why Not Redux

Redux 很好，而且社区也有很多跟除 React 之外的视图层集成的实践。单纯的比较 Redux 跟 MobX 大概需要再写一篇文章来阐述，这里只简单说几点与视图层集成时的差异：

1. 虽然 Redux 本质也是一个观察者模型，但是在 Redux 的实现下，状态的变化并不是通过数据 diff 得出而是 [object Object] 来手动通知的，而真正的 diff 则交给了视图层，这不仅导致可能的渲染浪费(并不是所有 library 都有 vdom)，在处理各种需要在变化时触发副作用的场景也会显得过于繁琐。

2. 由于第一条 Redux 不做数据 diff，因此我们无法在视图层接手数据前得知哪个局部被更新，进而无法更高效的选择性更新视图。

3. Redux 在 store 的设计上是 opinionated 的，它奉行 [object Object] 原则。应用可以完全由状态数据来描述、且状态可管理可回溯 这一点上我没有意见，但并不是只有[object Object]这一条出路，多 store 依然能达成这一目标。显然 mobx 在这一点上是 unopinionated 且灵活性更强。

4. Redux 概念太多而自身做的又太少。可以对比一下 [ngRedux](https://github.com/angular-redux/ng-redux) 跟 [mobx-angularjs](https://github.com/mobxjs/mobx-angularjs) 看看实现复杂度上的差异。

## 最后

除了给 AngularJS 搭载上更高效、精确的高速引擎之外，我们最主要的目的还是为了将 业务模型层甚至 视图模型层(统称为应用数据层) 做成 UI 框架无关，这样在面对不同的视图层框架的迁移时，才可能做到游刃有余。而 mobx 在这个事情上是一个很好的选择。

最后想说的是，如果条件允许的话，还是建议将 angularjs 系统升级成 React/Vue/Angular 之一，毕竟大部分时候基于新的视图技术开发应用是能带来确实的收益的，如 性能提升、开发效率提升 等。即便你短期内无法替换掉 angularjs(多种因素，比如已经基于 angularjs 开发/使用 了一套完整的组件库，代码体量太大改造成本过高)，你依然可以在局部使用 mobx/mobx-angularjs 改造应用或开发新功能，在 mobx-angularjs 帮助你提升应用性能的同时，也给你后续的升级计划创造了可能性。

PS： [mobx-angularjs](https://github.com/mobxjs/mobx-angularjs) 目前由我和另一个 US 小哥全力维护，如果有任何使用上的问题，欢迎随时联系。
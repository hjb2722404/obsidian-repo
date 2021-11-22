基于 MobX 构建视图框架无关的数据层-与 Vue 的结合(1) · Issue #39 · kuitos/kuitos.github.io

# 基于 MobX 构建视图框架无关的数据层-与 Vue 的结合(1)

*[mobx-vue](https://github.com/mobxjs/mobx-vue) 目前已进入 mobxjs 官方组织，欢迎试用求 star！*

几周前我写了一篇文章描述了 mobx 与 angularjs 结合使用的方式及目的 ([老树发新芽—使用 mobx 加速你的 AngularJS 应用](https://github.com/kuitos/kuitos.github.io/issues/38))，这次介绍一下如何将 MobX 跟 Vue 结合起来。

## 安装

npm i mobx-vue -S

## 使用

mobx-vue 的使用非常简单，只需要使用 connect 将你用 mobx 定义的 store 跟 vue component 连接起来即可：
<template>
<section>
<p  v-text="amount"></p>
<p  v-for="user in users" :key="user.name">{{user.name}}</p>
</section>

</template><script  lang="ts">  import { Connect } from  "mobx-vue";  import  Vue  from  "vue";  import  Component  from  "vue-class-component";  class  ViewModel { @observable users = []; @computed  get amount() { return  this.users.length } @action fetchUsers() {} } @Connect(new  ViewModel()) @Component()  export  default  class  App  extends  Vue { mounted() {   this.fetchUsers(); } }</script>

## Why MobX/mobx-vue

我们知道，mobx 跟 vue 都是基于 数据劫持&依赖收集 的方式来实现响应式机制的。mobx 官方也多次提到 [object Object]，那么我们为什么还要将两个几乎一样的东西结合起来呢？

> Yes, it's weird.

2016年我在构建公司级组件库的时候开始思考一个问题，我们如何在代码库基于某一框架的情况下，能以尽可能小的代价在未来将组件库迁移到其他 框架/库 下？总不能基于新的技术全部重写一遍吧，这也太浪费生命了。且不说对于基础控件而言，交互/行为 逻辑基本上是可确定的，最多也就是 UI 上的一些调整，而且单纯为了尝试新技术耗费公司人力物力将基础库推导重写也是非常不职业的做法。那么我们只能接受被框架绑架而只能深陷某一技术栈从此泥潭深陷吗？对于前端这种框架半衰期尤其短的领域而言显然是不可接受的，结果无非就是要么自己跑路坑后来人，要么招不到人来一起填坑... 简单来说我们无法享受新技术带来的种种红利。

在 MVVM 架构视角下，越是重型的应用其复杂度越是集中在 M(Model) 跟 VM(ViewModel) 这两层，尤其是 Model 层，理论上应该是能脱离上层视图独立运行独立发布独立测试的存在。而相应的不同视图框架只是使用了不同绑定语法的动态模板引擎而已，这个观点我在前面的几篇文章里都讲述过。所以只要我们将视图层做的很薄，我们迁移的成本自然会降到一个可接受的范畴，甚至有可能通过工具在编译期自动生成不同框架的视图层代码。

要做到 Model 甚至 ViewModel 独立可复用，我们需要的是一种可以帮助我们描述各数据模型间依赖关系图且框架中立的通用状态管理方案。这期间我尝试过 ES6 accessor、redux、rxjs 等方案，但都不尽如人意。accessor 过于底层且异步不友好、redux 开发体验太差(参考[Redux数据流管理架构有什么致命缺陷,未来会如何改进?](https://www.zhihu.com/question/277623017/answer/409520763))、rxjs 过重等等。直到后来看到 MobX：MobX 语法足够简单、弱主张(unopinioned)、oop 向、框架中立等特性正好符合我的需求。

在过去的一年多里，我分别在 react、angularjs、angular 上尝试过基于 MobX 构建 VM/M 层，其中有两个上线项目，一个个人项目，实践效果基本上也达到了我的预期。在架构上，我们只需要使用对应的 connector，就能基于同一数据层，在不同框架下自如的切换。这样看来，这套思路现在就剩 Vue 没有被验证了。

在 mobx-vue 之前，社区已经有一些优秀的 connector 实现，如 [movue](https://github.com/nighca/movue)  [vue-modex](https://github.com/dwqs/vue-mobx) 等，但基本都是基于 vue 的插件机制且 inspired by [vue-rx](https://github.com/vuejs/vue-rx)，除了使用起来相对繁琐的问题外，最大的问题是其实现基本都是借助 Vue.util.defineReactive 来做的，也就是说还是基于 Vue 自有的响应式机制，这在一定程度不仅浪费了 MobX 的reactive 能力，而且会为迁移到其他视图框架下埋下了不确定的种子(毕竟你无法确保是 Vue 还是 MobX 在响应状态变化)。

参考：[why mobx-vue](https://github.com/mobxjs/mobx-vue#why-mobx-vue)

**理想状态下应该是由 mobx 管理数据的依赖关系，vue 针对 mobx 的响应做出 re render 动作即可，vue 只是一个单纯的动态模板渲染引擎，就像 react 一样。**

在这样的一个背景下，[mobx-vue](https://github.com/mobxjs/mobx-vue) 诞生了。

## mobx-vue 是如何运作的

既然我们的目的是将 vue 变成一个单纯的模板渲染引擎(vdom)，并且使用 mobx 响应式机制取代 vue 的响应式，那么只要我们劫持到 Vue 的组件装载及更新方法，然后在组件装载的时候收集依赖，在依赖发生变更时更新组件即可。

以下内容与其叫做 mobx-vue 是如何运作的，不如叫 Vue 源码解析：
我们知道 Vue 通常是这样初始化的：
new  Vue({  el: '#app',  render: h  =>  h(App)});
那么找到 Vue 的构造函数，
function  Vue  (options)  { ...... this._init(options)}
跟进到[object Object]方法，除了一系列组件初始化行为外，最关键是最后一部分的 [object Object] 逻辑：
if  (vm.$options.el)  {  vm.$mount(vm.$options.el)}
跟进 [object Object] 方法，以 web runtime 为例：

if  (process.env.NODE_ENV !== 'production'  &&  config.performance  &&  mark)  {  updateComponent  =  ()  =>  { ... }}  else  {  updateComponent  =  ()  =>  {  vm._update(vm._render(),  hydrating)  }}vm._watcher  =  new  Watcher(vm,  updateComponent,  noop)

从这里可以看到，**[object Object] 方法将是组件更新的关键入口**，跟进 [object Object] 构造函数，看 Vue 怎么调用到这个方法的:

constructor  (  vm: Component,  expOrFn: string | Function,  cb: Function,  options?: Object  )  { ... this.expression  =  process.env.NODE_ENV !== 'production' ? expOrFn.toString() : ''  // parse expression for getter  if  (typeof  expOrFn  ===  'function')  {  this.getter  =  expOrFn  }  else  {  this.getter  =  parsePath(expOrFn)  ...  }  this.value  =  this.lazy ? undefined : this.get()

get  ()  { ... try  { value =  this.getter.call(vm,  vm)  }  catch  (e)  { ... }

看到这里，我们能发现，组件 装载/更新 的发起者是： [object Object] ，而我们只要通过 [object Object] 的方式就能获取相应的方法引用， 即 [object Object]。所以我们只要在 [object Object] 前将 MobX 管理下的数据植入组件上下文供组件直接使用，在[object Object] 时让 MobX 收集相应的依赖，在 MobX 检测到依赖更新时调用 [object Object] 即可。这样的话既能让 MobX 的响应式机制通过一种简单的方式 hack 进 Vue 体系，同时也能保证组件的原生行为不受到影响(生命周期钩子等)。

**中心思想就是用 MobX 的响应式机制接管 Vue 的 Watcher，将 Vue 降级成一个纯粹的装载 vdom 的组件渲染引擎。**
核心实现很简单：

const  { $mount }  =  Component.prototype;Component.prototype.$mount  =  function  (this: any, ...args: any[])  {  let  mounted  =  false;  const  reactiveRender  =  ()  =>  {  reaction.track(()  =>  {  if  (!mounted)  {  $mount.apply(this,  args);  mounted  =  true;  }  else  {  this._watcher.getter.call(this,  this);  }  });  return  this;  };  const  reaction  =  new  Reaction(`${name}.render()`,  reactiveRender);  dispose  =  reaction.getDisposer();  return  reactiveRender();};

完整代码在这里：https://github.com/mobxjs/mobx-vue/blob/master/src/connect.ts

## 最后

尤大大之前说过：[object Object]，本质上来看确实是这样的，mobx + react 组合提供的能力恰好是 Vue 与生俱来的。而 mobx-vue 做的事情则刚好相反：将 Vue 降级成 react 然后再配合 MobX 升级成 Vue 。这确实很怪异。但我想说的是，我们的初衷并不是说 Vue 的响应式机制实现的不好从而要用 MobX 替换掉，而是希望借助 MobX 这个相对中立的状态管理平台，面向不同视图层技术提供一种相对通用的数据层编程范式，从而尽量抹平不同框架间的语法及技术栈差异，以便为开发者提供更多的视图技术的决策权及可能性，而不至于被某一框架绑架裹挟。

PS: 这篇是系列文章的第一篇，后面将有更多关于 [object Object] 的架构范式及实践的内容，敬请期待！

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='42'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='1598' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)
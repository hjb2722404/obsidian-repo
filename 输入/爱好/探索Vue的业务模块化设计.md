探索Vue的业务模块化设计

# 探索Vue的业务模块化设计

[![v2-1246f6287b134276c3ddb3b82e0e207f_l.jpg](../_resources/b2d8e2061c2c84ef3729fe45b4fe2d74.jpg)](https://www.zhihu.com/people/unadlib)

[unadlib](https://www.zhihu.com/people/unadlib)
养鱼的

>  本文旨在探索基于Vuex封装模型的Vue业务模块化设计，并试图提出渐进增强架构设想。

基于Observable模型下的Vue有着简单直观的API，借助MVVM架构模式，在中小Web应用中使用Vue有天然优势。随着Vue的流行度日益增长，Vue在大型项目中的运用略显捉襟见肘；尤其在一些高度复杂的前端应用中，Vue2在TypeScript的支持情况不甚乐观，更重要的是Vuex状态逻辑在模块化设计上也有相当的优化空间。

那么，到底怎样的编程模式才更适合Vue中大型业务的开发需求？而基于Vuex的状态管理又有什么更好的模型化设计？

## 动机

在数年前，前端常谈论前后端分离并逐渐将其解决。但前端开发演进到当前，前端领域更进一步需要解决核心业务逻辑与UI的分离，它让逻辑与UI解耦，它带来的通用性上的代码或服务复用。而模块化便是一个解决UI与业务逻辑分离的巨大契机，它同时为了更全面的自动化测试策略来更好地保证产品质量，另外Team成员协作效率与产品迭代速度也将因此明显提升，最后它也将明显加强工程项目的自治与分治。

时下最流行的MVVM框架之一：Vue，便是我们今天想要探索模块化设计的目标。

## 状态模型

在探索模块化之前不得不先从前端的状态模型分类上进行分析，我把它归纳成如下图所示的五层模型：

![v2-e38c78a902dfb417aff08e552b2d13a3_r.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102123935.jpg)

对于大多数前端应用而言，都需要处理这五层状态模型其中的至少一种，但并不意味着这五层模型在中大型应用都会被设计实现。
下面就从Vue应用角度来谈谈这五层状态。

- • UI state

Vue官方提供很多UI逻辑复用的API：Mixins / Custom Directives / Plugins / Filters。尤其是Mixins在组件内的状态逻辑复用起到重要作用。但组件的逻辑复用至少还包括：Renderless Components / HOC。虽然HOC并不像React的HOC直观便利，虽然Vue的HOC使用并不如Mixins频繁，但在一些类似通用container组件的props注入，它却是不可取代。

在倡导组合大于继承的今天，对于最近受到广泛讨论的Vue3.0 Function-based Component RFC也算是迎合这样的趋势，相信它在未来Vue3.0 组件逻辑复用性将带来巨大便利。值得注意在React hooks刚出来的时，Vue团队便借助mixin来mock一个vue-hooks的PoC。如果是有致于Vue2在组件内类似hooks概念上封装以便对未来Vue3有更平滑的迁移过程，或许也是一个不错的探索小方向。

- • Sharing State

在共享状态逻辑复用上，Vuex的模块化设计对于大中型Vue项目中应该是至关重要的。对于Vuex更接近Object-based或者叫JSON-based设计定义，它与通常OOP模型契合程度并不算很好。那么，在我所理解的Vuex模块化定义中至少有以下几个方面：

1. 1. Modular State

首先，OO完全迎合模块颗粒的设计，尤其是通过DDD方式得到多个领域下的modules实现。模块间相互注入，并定义彼此间的上下文，甚至是定义各自的贫血/富血模型等等。

1. 1. Optional Life Cycle

常常模块间的初始化等动作存在相互依赖的关系，因此有可选且恰当的模块生命周期的APIs将提供相互依赖的模块间在初始化或者重置等依赖逻辑注入，当然这部分也可以完全由某个统一的事件系统来代替，这取决于是否希望模块生命周期标准化。

1. 1. Optional Event System
有可选或是可自定义的事件系统，以便模块间在复杂系统中有更便利地交互和消息传递。

* * *

**根据以上这些定义，那么这里我试图推出一个全新的解决方案 -——— [usm-vuex](https://link.zhihu.com/?target=https%3A//github.com/unadlib/usm)**

* * *

**Class-based Module**

![v2-ce81e7eb6b9737defbddc060440c3cc4_r.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102123956.jpg)

在上图左侧的code是Vuex的官方Todo例子，同样的逻辑基于`usm-vuex`的实现在右侧。左侧的Object-based的形式包括getters等computed API并不符合OO直觉；而基于`usm-vuex`的实操代码更接近OO直觉，同时又利用`usm-vuex`装饰器`@state`和`@action`进行定义并保持state和action的直接关联。

**Dependency injection & Object-oriented**

![v2-34853e42c4f56d5ff62bb2c56d05036d_r.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124005.jpg)

基于`usm-vuex`的module有直接注入的机制，无论是手动注入还是利用IoC注入，它能以诸如`this._modules.foobar`这样的方式直接调用依赖的模块。而基于class的module形式，又非常适合实践上下文/富血模型等OO概念。

**Optional Life Cycle/Event System**

![v2-6d6a08daeb1ddc29ae3bb66e37de3a57_r.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124014.jpg)

`usm-vuex`提供了以下5个模块生命周期APIs，并且支持异步:

- • moduleWillInitialize
- • moduleWillInitializeSuccess
- • moduleDidInitialize
- • moduleWillReset
- • moduleDidReset

当然，它是可选的，只有在必要情况下，你才需要使用它。
至于事件系统，可以根据自己的实际需要选择`events`和`rxjs`，或者自定义实现自己需要的事件系统模型，这完全取决于模块信息交互的复杂度和事件形式。

### Mutable

由于Vue和Vuex都是基于Observable模型，那么在中大型Vue应用中把全部的数据和状态都进行Observable实例化显然并不现实，毕竟如此巨大的数据量进行Observable实例化所消耗的性能将造成程序初始化缓慢，因此分离出以Mutable为主的services等状态层也算是一种可选择的手段之一。

这里主要可以分成三种类型以上：

- • Services Layer
- • Universal Layer
- • High-performance Layer

在必要情况下，Services可以借助Service Worker以及Web Worker等隔离运行环境，优化应用的运行效能；一些通用化JavaScript的类库也可以运行于此，进行各种通用逻辑的代码复用；而对于高性能模块，在现代浏览器的新特性支持越来越良好的情况下，完全可以利用WebAssembly进行显著的性能提升。

### Persistence

- • Storage Wrapper

通常在非必要情况下，一般不会单独抽离出持久层，而更多的情况是是直接在Vuex状态管理中使用相关持久化插件，例如`vuex-persist`等。但当中大型应用的持久化需要更多的缓存自定义逻辑时，引入存储包装库诸如`localforage`或`dexie`等进行一定程度的持久层设计也是必要考虑。

- • ORM

对于大多数Vue这样SPA而言，基于http等网络请求进行前后端交互，通常都会形成后端数据与前端状态的映射 关系，当后端的接口定义相对标准化，为了更高效的进行请求封装与接口管理，引入诸如`vuex-orm`/`type-orm`等库将显著提升开发效率和维护成本。

### Remote Data

- • Request Module / SDK

请求模块或应用可能涉及到的SDK，都可能需要一层完整的远程交互模块的封装，例如ajax/websocket/fetch等Web API的独立封装与整合，以提供按需配套的外部远程交互参数化配置与调度控制。

- • RESTful / GraphQL

从API数据查询类型分类，无论是RESTful还是GraphQL，在API与对应的响应数据结构都可以形成一整套的数据解析与再分发的管理，利用后端提供的schema并借助`normalizr`等类似数据解析库进行解析。它形成与后端完全一致的领域划分与映射关系，且解析后的数据集合几乎应该是后端的数据库的子集。这样做还能带来前端状态一致性的巨大便利。

## 模块分类

**按类型划分：**

- • Router Module
- • High Performance Module
- • Business Logic Module
- • UI Logic Module
- • External Module
- • Other Basic Module

在大部分情况，类型模块间的划分将决定模块处于状态分层位置是否是同层状态，是否需要主线程隔离运行等问题，甚至是代码库模块的分离与分类管理。当然，它也完全取决于对模块的颗粒度的控制。

**按用途划分：**

- • View Module
- • Service Module

View Module负责UI的大部分渲染逻辑与少量UI共享状态管理，而Service Module更多是负责核心的业务逻辑模块以及其他基础服务模块。它们的分类有助于将UI与业务完全隔离开，它同时也更有助于后续的自动化测试实践更完整的测试策略。

## 模块化要素

- • Dependency Management

在中大型Vue应用开发的最初阶段，在少数几个或十几个以内的模块间，手动模块初始化依赖注入或许更简便。但随着业务需求膨胀，模块逐渐变多，且它们之间的依赖关系越发复杂的时候，无论自己设计Dependency Injection(以下简称DI)/Service Locator或是采纳社区成熟方案，适时引入IoC相关的依赖管理库变得非常有必要。目前前端社区中的IoC库，以`inversify`最为知名成熟，当然也有一些类Angular DI库也是一个不错选择。

- • Event System

对于大部分的项目起步，模块间事件关系并不复杂时，确实无需引入一个复杂的事件系统，简单的封装即可；但当应用的模块间的事件关系升级到相当复杂度，甚至是需要事件流的方式处理彼此之间的复杂事件时，根据项目实际情况引入`RxJS`也算是当然不错的选择。部分其他观点上文已经提及，这里不再敷述。

- • General Logic

从软件开发方法而言，Domain-Driven Design是我们在分析和设计业务模型时非常重要的有效工具。合理的领域模型设计，对于越大型的应用变得越是至关重要。

从程序编程原则而言，诸如SOLID这样经典的OOP原则，以及像KISS或者DRY等原则，我们都应当进行充分地理解和运用这些原则，以尽可能减少一些反模式的情况出现在通用业务逻辑设计与实现中，避免后续因业务模型设计不合理导致的低效重构的可能。

- • Package Management

项目工程是否选择Multi-repo或是Monorepo，这完全取决于一开始分包后子包之间的依赖关系以及开发团队组织管理和协作模式，同时也包括一整套CI/CD/AT/UserStory/AC等开发流程相关部分的版本控制管理的完整定义。

若采用Monorepo，那么如何使用lerna时恰当地处理子包共享配置以及配置差异化则变得尤其重要。

- • Lazy Loading

懒加载在大中型应用中是常见的一种必要手段。那么在Vue应用中，至少可以有以下几方面可以进行相关处置：
1. 1. Modules and UIs of the subpackage - Factory Module或者UI container进行分包懒加载
2. 2. DI Asynchronous Factory - 诸如inversify这样的IoC所支持Asynchronous Factory
3. 3. Vuex register Module - 利用Vuex的API`registerModule`
4. 4. Dynamic Import - 利用webpack与ES提案中的`import()`
5. 5.  Module Loader - 诸如RequireJS这样浏览器级别的模块加载器

6. 6.  Component-based Design

无论是Mixins-based或者是未来Vue3.0的Function-based Component，Vue的UI组件应该尽可能的分离UI与业务逻辑，将UI组件变得更加纯粹化，仅保留必要的UI组件内的状态与逻辑。这样的组件颗粒将变得更为轻便、通用与高可复用，并在一些细节上注意隔离，例如能在利用`usm-vuex`进行computed的就尽量别在组件内进行。如此UI组件，目的就是变得更加简洁的“模版化”。

## 模块化工程

模块化工程需要注意细节点至少有以下几方面：

- • 工程化

对于是否采用Monorepo/Multi-repo，选择哪些工程构建工具Webpack/Glup， 业务逻辑如何分包，等问题，它们取决于Team的技术栈熟悉度与工程属性与相关社区基础设施建设成熟度，同时也取决于业务领域的拆分。

- • 自动化

这里应该思考和注意到涉及的CI/CD的脚本管理是否进行通用化配置封装，以及根据项目的业务特点设计更符合工程项目本身的全面自动化策略（MT/E2E/IT/UT,等）。

- • 开发模式

从开发模式角度更多应该考虑到开发的Workflow定义、业务拆分和开发人员划分，它们对于整体开发周期以及业务领域划分后对最后落地的模块实现模块颗粒进行并行开发/测试等的影响。当然，从软件项目的版本控制角度，也应一并考虑Team使用何种恰当的Branch Model，例如Branch by Abstraction等模型。

- • 编程模式

就算是整体项目OOP为主，但并不意味这OOP就应该项目的全部的编程模式，适当的FP/FRP都是应当和合理的。尤其是OOP下的module完全可以配合少量的核心可测的业务型helper function，以及一些完全不含业务的抽象工具型的util function。

- • 模型可视化

对复杂的中大型应用而言，小到module间依赖的function，大到项目的领域模型、module间的依赖关系与工程技术栈，甚至是完整的项目构架，如果这些信息能够不同以层次的模型可视化，那么这将对设计、管理和维护项目的方方面面都有极大的帮助。

## Demo

本文的架构完整Demo: [https://github.com/unadlib/usm-vuex-demo...](https://link.zhihu.com/?target=https%3A//github.com/unadlib/usm-vuex-demo)

以下是Demo项目中几个说明要点：

- • Vuex模块化 - 这里采用[usm-vuex](https://link.zhihu.com/?target=https%3A//github.com/unadlib/usm)，它将解决业务模块化这个重要问题
- • TypeScript - vue-cli3内建支持
- • TSX - 为更好的UI组件类型推导
- • 依赖注入 - 目前最好的DI库inversify
- • 分包 - 使用lerna构建Monorepo

lerna初始化后，进行领域驱动设计，得到大的领域模块。在必要情况下，将可以进行分包，同时启用动态import懒加载，以提高构建时性能和运行性能。
在核心应用子项目的初始化使用vue-cli3建构，选择TypeScript作为主要语言，它将自动引入Webpack的ts-loder。
这是核心目录结构：

	|-- App.vue
	|-- main.ts
	+-- modules/
	  |-- Todos/
	  |-- Navigation/
	  |-- Portal/
	  |-- Counter/
	  ...
	+-- lib/
	  |-- loader.ts
	  |-- moduleConnect.ts
	  ...
	+-- components/
	...

`main.ts`是默认的entry。

	*// ...
	**// omit some modules
	***import { load } from './lib/loader';
	
	const { portal, app } = load({
	  bootstrap: "Portal",
	  modules: {
	    Counter,
	    Todos,
	    Portal,
	    Navigation
	  },
	  main: App,
	  components: {
	    home: {
	      screen: TodosView,
	      path: "/",
	      module: "todos"
	    },
	    counter: {
	      screen: () => import("./components/Counter"),
	      path: "/counter",
	      module: "counter"
	    }
	  }
	});
	
	Vue.prototype.portal = portal;
	
	new Vue(app).$mount("#app");

`App.vue`是主视图文件。

	<template>
	  <div id="app">
	    <div id="nav">
	      <router-link to="/">Home</router-link> |
	      <router-link to="/counter">Counter</router-link>
	    </div>
	    <router-view />
	  </div>
	</template>

`modules`包含全部的业务逻辑，也包括视图层状态和导航模块等，它将由Vuex来启动，例如以下是Counter模块：

	import { injectable } from "inversify";
	import Module, { state, action, computed } from "../../lib/baseModule";
	
	@injectable()
	export default class Counter extends Module {
	  @state count: number = 0;
	
	  @action
	  calculate(num: number, state?: any) {
	    state.count += num;
	  }
	
	  getViewProps() {
	    return {
	      count: this.count,
	      calculate: (num: number) => this.calculate(num)
	    }
	  }
	}

`lib/loader.ts`是应用配置加载器，它根据中心化配置来启动整个项目。

	import { Container } from 'inversify';
	
	export function load(parmas: any = {}) {
	  const { bootstrap, modules, ...option } =  parmas;
	  const container = new Container({ skipBaseClassChecks: true });
	  Object.keys(modules).forEach(key => {
	    container.bind(key).to(modules[key]);
	  });
	  container.bind("AppOptions").toConstantValue(option);
	  const portal: any = container.get(bootstrap);
	  portal.bootstrap();
	  const app = portal.createApp();
	  return {
	    portal,
	    app,
	  };
	}

`lib/moduleConnect.ts`是ViewModule的View连接器，这是一个高阶组件形式的连接器。

	import { Component, Vue } from "vue-property-decorator";
	
	export default (ViewContainer: any, module: string) => {
	  @Component({
	    components: {
	      ViewContainer
	    }
	  })
	  class Container extends Vue {
	    props = ViewContainer.props;
	
	    get module() {
	      const portal = this.portal as any;
	      return portal[module];
	    }
	
	    render(createElement: any) {
	      const slots = Object.entries(this.$slots)
	        .map(([_, node]: [string, any]) => {
	          node.context = (this as any)._self
	          return node
	        });
	      const props = this.module.getViewProps(this.$props, this.$attrs);
	      return createElement(ViewContainer, {
	        props,
	        scopedSlots: this.$scopedSlots,
	        on: this.$listeners,
	        attrs: this.$attrs,
	      }, slots);
	    }
	  }
	  return Container;
	};

`components/Counter/index.tsx`是Counter的组件。

	import { Component, Vue, Prop } from "vue-property-decorator";
	import './style.scss';
	
	type Calculate = (sum: number) => void;
	
	@Component
	export default class CounterView extends Vue {
	  @Prop(Number) count!: number;
	  @Prop(Function) calculate!: Calculate;
	
	  render(){
	    return (
	      <div class="body">
	        <button onClick={()=> this.calculate(1)}>+</button>
	        <span>{this.count}</span>
	        <button onClick={()=> this.calculate(-1)}>-</button>
	      </div>
	    )
	  }
	}

配合TSX的View组件模块，同时基于此架构等整体设计将很大程度上契合TypeScript的类型检查和推导。

在该Demo架构中最核心的设计部分应该是`usm-vuex`，它让Vuex进行业务模块化变得简单明了，配合View层的ViewModule，它能够让当前的架构设计变得高内聚低耦合，在复用性与维护性上大大提高，同时配合DI，让模块间的依赖变得清晰易懂。

### 补充说明

看完该Demo架构设计或许会有这样的疑问：
>  既然如此类似Angular，那么为什么不直接使用Angualr而是Vue呢?
>

首先，从GUI State Model角度而言，我认同这样的说法：Mutable < Immutable < Observable，基于Mutable的脏检查机制的Angular，虽然从Anuglar已经极大优化了性能，但是事实上在某些关键的state逻辑处置上，有时候Angular还是不得不借助RxJS进行Observable才能进行更好的处理。而Vue天然的基于Observable，这在State模型上便占据上风。当然，这只是单纯的从GUI State Model上比较，这并不意味着Vue就因此是比Angular更优秀的框架。

而基于类似Demo架构的Vue应用，带来的便是更灵活和可自定义，几乎很多部件都是可选的。例如，IoC不满意，那么它是可以适时调整。但是如果是Angular，事实上可调整的空间并不大。很多时候，它已经提供完整的一整套解决方案。

最后从架构的演进来说，它的架构完全可以根据业务项目的成长和进行循序渐进地调整和优化，最终得到一个更契合项目业务自身的架构。这样的渐进增强架构方案和Vue所提出的渐进式框架是完全契合的，它符合一个业务的不断成长和变化的客观。当然，如果一个业务项目已经非常成熟和定义清晰且需求稳定，那么从一开始便选择使用Angular2+也无可厚非，甚至应该要完全支持这样节省资源的高效选择。

## 小结

在探索Vue的业务模块化设计过程中，Vuex的模块化方案是至关重要的一个环节，它将尽可能解决业务逻辑实现层面的高内聚和低耦合，而且在并行开发和自治分治上又有明显改善；同时基于此方案下的渐进增强架构理念，又能迎合不断快速变化的业务需求，使其不断的演进和优化工程，对于整体项目与业务模型间的契合起到显著地捏合作用。

`usm-vuex` Repo: [https://github.com/unadlib/usm](https://link.zhihu.com/?target=https%3A//github.com/unadlib/usm)

编辑于 2019-06-29
[ Vue.js](https://www.zhihu.com/topic/20022242)
[ Vue.js 3](https://www.zhihu.com/topic/20673092)
[ Vuex](https://www.zhihu.com/topic/20044614)
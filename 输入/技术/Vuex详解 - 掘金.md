# Vuex详解

#### 一、 什么是Vuex

	Vux 是一个专门为vue.js 应用程序开发的状态管理模式。它采用集中式存储管理应用的所有组件状态，并以相应的规则保证状态以一种可预测的方式发生变化
	复制代码

##### 1.1 使用场景

- **多个视图使用于同一状态**

	传参的方法对于多层嵌套的组件将会非常繁琐，并且对于兄弟组件间的状态传递无能为力
	复制代码

- **不同视图需要变更同一状态**：

	采用父子组件直接引用或者通过事件来变更和同步状态的多份拷贝，通常会导致无法维护的代码
	复制代码

##### 1.2 数据流层

[1](../_resources/8373267b8cd5241a5fa26add65f9bcca.webp)

**Vuex简化流程可以理解为：**

	View components -> actions(dispatch方式) -> mutations(commit方式) -> state -> View components
	而 getters则可以理解为computed，作为state的计算属性
	复制代码

**注意事项:**

	1. 数据流都是单向的
	
	2. 组件能够调用action
	
	3. action用来派发mutation
	
	4. 只有mutation可以改变状态
	
	5. store是响应式的，无论state什么时候更新，组件都将同步更新
	复制代码

#### 二、 核心概念

##### 2.1 State

	Vuex 使用单一状态树，用一个对象就包含了全部的应用层次状态。至此它便作为一个唯一的数据源而存在。
	这也意味着，每个应用将仅仅包含一个store实例。
	单状态树让我们能够直接地定位任一特定的状态片段，在调试的过程中也能轻易地取得整个当前应用状态的快照。
	复制代码

**2.1.1 在 Vue 组件中获得 Vuex 状态**
由于 Vuex 的状态存储是响应式的，从 store 实例中读取状态最简单的方法就是在计算属性中返回某个状态：

	// 创建一个 Counter 组件
	const Counter = {
	  template: `<div>{{ count }}</div>`,
	  computed: {
	    count () {
	      return store.state.count
	    }
	  }
	}
	
	//每当 store.state.count 变化的时候, 都会重新求取计算属性，并且触发更新相关联的 DOM。
	复制代码

Vuex 通过 `store` 选项，提供了一种机制将状态从根组件“注入”到每一个子组件中（需调用 Vue.use(Vuex)）：

	const app = new Vue({
	  el: '#app',
	  // 把 store 对象提供给 “store” 选项，这可以把 store 的实例注入所有的子组件
	  store,
	  components: { Counter },
	  template: `
	    <div class="app">
	      <counter></counter>
	    </div>
	  `
	})
	
	复制代码

通过在根实例中注册 store 选项，该 store 实例会注入到根组件下的所有子组件中，且子组件能通过 this.$store 访问到。让我们更新下 Counter 组件 的实现：

	const Counter = {
	  template: `<div>{{ count }}</div>`,
	  computed: {
	    count () {
	      return this.$store.state.count
	    }
	  }
	}
	复制代码

**2.1.2 mapState 辅助函数**

当一个组件需要获取多个状态时候，将这些状态都声明为计算属性会有些重复和冗余。为了解决这个问题，我们可以使用 mapState 辅助函数帮助我们生成计算属性，让你少按几次键：

	// 在单独构建的版本中辅助函数为 Vuex.mapState
	import { mapState } from 'vuex'
	
	export default {
	  // ...
	  computed: mapState({
	    // 箭头函数可使代码更简练
	    count: state => state.count,
	
	    // 传字符串参数 'count' 等同于 `state => state.count`
	    countAlias: 'count',
	
	    // 为了能够使用 `this` 获取局部状态，必须使用常规函数
	    countPlusLocalState (state) {
	      return state.count + this.localCount
	    }
	  })
	}
	复制代码

当映射的计算属性的名称与 state 的子节点名称相同时，我们也可以给 mapState 传一个字符串数组。

	computed: mapState([
	  // 映射 this.count 为 store.state.count
	  'count'
	])
	复制代码

由于 `mapState` 函数返回的是一个对象，在ES6的写法中，我们可以通过对象展开运算符，可以极大的简化写法:

	computed: {
	  localComputed () { /* ... */ },
	  // 使用对象展开运算符将此对象混入到外部对象中
	  ...mapState({
	    // ...
	  })
	}
	
	//相当于将 state的属性，都添加到computed，而且指向state中的数据
	复制代码

##### 2.2 Getter

	用来从store获取Vue组件数据，类似于computed
	复制代码

**Getter 接受 state 作为其第一个参数：**

	const store = new Vuex.Store({
	  state: {
	    todos: [
	      { id: 1, text: '...', done: true },
	      { id: 2, text: '...', done: false }
	    ]
	  },
	  getters: {
	    doneTodos: state => {
	      return state.todos.filter(todo => todo.done)
	    }
	  }
	})
	复制代码

**2.2.1 通过属性访问**
Getter 会暴露为 store.getters 对象，你可以以属性的形式访问这些值：

	store.getters.doneTodos // -> [{ id: 1, text: '...', done: true }]
	复制代码

Getter 也可以接受其他 getter 作为第二个参数：

	getters: {
	  // ...
	  doneTodosCount: (state, getters) => {
	    return getters.doneTodos.length
	  }
	}
	复制代码

在其他组件中使用getter:

	computed: {
	  doneTodosCount () {
	    return this.$store.getters.doneTodosCount
	  }
	}
	复制代码
	注意: getter 在通过属性访问时是作为 Vue 的响应式系统的一部分缓存其中的。
	复制代码

**2.2.2 通过方法访问**
你也可以通过让 getter 返回一个函数，来实现给 getter 传参。在你对 store 里的数组进行查询时非常有用。

	getters: {
	  // ...
	  getTodoById: (state) => (id) => {
	    return state.todos.find(todo => todo.id === id)
	  }
	}
	
	store.getters.getTodoById(2) // -> { id: 2, text: '...', done: false }
	复制代码
	注意: getter 在通过方法访问时，每次都会去进行调用，而不会缓存结果。
	复制代码

**2.2.3 mapGetters 辅助函数**
`mapGetters` 辅助函数仅仅是将 store 中的 getter 映射到局部计算属性：

	import { mapGetters } from 'vuex'
	
	export default {
	  // ...
	  computed: {
	  // 使用对象展开运算符将 getter 混入 computed 对象中
	    ...mapGetters([
	      'doneTodosCount',
	      'anotherGetter',
	      // ...
	    ])
	  }
	}
	复制代码

如果你想将一个 getter 属性另取一个名字，使用对象形式：

	mapGetters({
	  // 把 `this.doneCount` 映射为 `this.$store.getters.doneTodosCount`
	  doneCount: 'doneTodosCount'
	})
	复制代码

##### 2.3 Mutation

	事件处理器用来驱动状态的变化，类似于methods，同步操作
	复制代码

**更改 Vuex 的 store 中的状态的唯一方法是提交 mutation。**

	每个 mutation 都有一个字符串的 事件类型 (type) 和 一个 回调函数 (handler)。
	这个回调函数就是我们实际进行状态更改的地方，并且它会接受 state 作为第一个参数：
	复制代码
	const store = new Vuex.Store({
	  state: {
	    count: 1
	  },
	  mutations: {
	    increment (state,value) {
	      // 变更状态
	      state.count++
	    }
	  }
	})
	复制代码

当外界需要通过mutation handler 来修改state的数据时，不能直接调用 mutation handler，而是要通过 `commit` 方法 传入类型

	store.mutations.increment,这种方式是错误的
	
	必须使用 store.commit('increment',value) ,value可作为要传递进入store的数据
	复制代码

**2.3.1 提交载荷（Payload）**
你可以向 store.commit 传入额外的参数，即 mutation 的 载荷（payload）：

	// ...
	mutations: {
	  increment (state, value) {
	  //第一个参数是state,value可以作为传递进来数据的参数
	    state.count += value
	  }
	}
	复制代码

使用方式：

	store.commit('increment', 10)
	复制代码

在大多数情况下，载荷应该是一个对象，这样可以包含多个字段并且记录的 mutation 会更易读：

	...
	mutations: {
	  increment (state, payload) {
	    state.count += payload.amount
	  }
	}
	复制代码
	// 以载荷形式分发
	store.commit('increment', {
	  amount: 10
	})
	复制代码

**2.3.2 对象风格的提交方式**
提交 mutation 的另一种方式是直接使用包含 type 属性的对象：

	// 以对象形式分发
	store.commit({
	  type: 'increment',
	  amount: 10
	})
	复制代码

当使用对象风格的提交方式，整个对象都作为载荷传给 mutation 函数，因此 handler 保持不变：

	mutations: {
	  increment (state, payload) {
	    state.count += payload.amount
	  }
	}
	复制代码

**2.3.3 Mutation 需遵守 Vue 的响应规则**
既然 Vuex 的 `store` 中的状态是响应式的，那么当我们变更状态时，监视状态的 Vue 组件也会自动更新。

	1. 最好提前在你的 store 中初始化好所有所需属性
	
	2. 使用 Vue.set(obj, 'newProp', 123)
	
	3. 以新对象替换老对象。例如，利用对象展开运算符我们可以这样写：
	
	   state.obj = { ...state.obj, newProp: 123 }
	复制代码

**2.3.4 使用常量替代 Mutation 事件类型**
1. 新建 `mutation-types.js` 文件，定义常量来管理 `mutation` 中的类型:

	// mutation-types.js
	export const SOME_MUTATION = 'SOME_MUTATION'
	复制代码

或者直接导出对象

	export default  {
	  SOME_MUTATION:'SOME_MUTATION'
	
	}
	复制代码

1. 在 `store.js` 中引入 `mutation-types.js`，引入类型常量使用

	// store.js
	import Vuex from 'vuex'
	import { SOME_MUTATION } from './mutation-types'

	const store = new Vuex.Store({
	  state: { ... },
	  mutations: {
	    // 我们可以使用 ES2015 风格的计算属性命名功能来使用一个常量作为函数名
	    [SOME_MUTATION] (state) {
	      // mutate state
	    }
	  }
	})
	复制代码

**引入类型对象使用:**

	...
	import  MutationType from './mutation-type'
	 mutations: {
	    // 我们可以使用 ES2015 风格的计算属性命名功能来使用一个常量作为函数名
	    [MutationType.SOME_MUTATION] (state) {
	      // mutate state
	    }
	  }
	
	复制代码

3.在外部使用时，需要局部先引入或者在`main.js`全局引入`mutation-types.js`:

	import  MutationType from './mutation-type'
	
	this.$store.commit(MutationType.SOME_MUTATION,'传入内容')
	复制代码

**2.3.5 Mutation 必须是同步函数**

	mutations: {
	  someMutation (state) {
	    api.callAsyncMethod(() => {
	      state.count++
	    })
	  }
	}
	复制代码

假设现在正在debug 一个 app 并且观察 devtool中的mutation日志。 每一条 mutation 被记录，devtools 都需要捕捉到前一状态和后一状态的快照。 然而，在上面的例子中 mutation 中的异步函数中的回调让这不可能完成：

	因为当 mutation 触发的时候，回调函数还没有被调用，devtools 不知道什么时候回调函数实际上被调用——实质上任何在回调函数中进行的状态的改变都是不可追踪的。
	复制代码

**2.3.6 在组件中提交 Mutation**

你可以在组件中使用 `this.$store.commit('xxx')` 提交 mutation，或者使用 `mapMutations` 辅助函数将组件中的 methods 映射为 `store.commit` 调用（需要在根节点注入 `store`）。

方式一:

	  this.$store.commit('increment','参数')
	复制代码

方式二：

	import { mapMutations } from 'vuex'
	
	export default {
	  // ...
	  methods: {
	    ...mapMutations([
	      'increment', // 将 `this.increment()` 映射为 `this.$store.commit('increment')`
	
	      // `mapMutations` 也支持载荷：
	      'incrementBy' // 将 `this.incrementBy(amount)` 映射为 `this.$store.commit('incrementBy', amount)`
	    ]),
	    ...mapMutations({
	      add: 'increment' // 将 `this.add()` 映射为 `this.$store.commit('increment')`
	    })
	  }
	}
	复制代码

##### 2.4 Action

	可以给组件使用的函数，以此用来驱动事件处理器 mutations，异步操作
	复制代码

**Action 类似于 mutation，不同在于：**

	1. Action 提交的是 mutation，而不是直接变更状态。
	2. Action 可以包含任意异步操作。
	复制代码

例子:

	const store = new Vuex.Store({
	  state: {
	    count: 0
	  },
	  mutations: {
	    increment (state) {
	      state.count++
	    }
	  },
	  actions: {
	    increment (context) {  //context 执行的上下文，作为第一个参数
	      context.commit('increment')
	    }
	  }
	})
	复制代码

**Action 函数接受一个与 store 实例具有相同方法和属性的 context 对象，因此你可以调用 `context.commit` 提交一个 mutation，或者通过 `context.state` 和 `context.getters` 来获取 state 和 getters。**

需要调用 commit 很多次的时候,可以简写成:

	actions: {
	  increment ({ commit }) {
	    commit('increment')
	  }
	}
	复制代码

**2.4.1 分发 Action**
Action 通过 store.dispatch 方法触发：

	store.dispatch('increment')
	复制代码

Action 就不受约束！在Mutation无法执行的异步操作，可以在action内部进行使用:

	actions: {
	  incrementAsync ({ commit }) {
	    setTimeout(() => {
	      commit('increment')
	    }, 1000)
	  }
	}
	复制代码

**Actions 支持同样的载荷方式和对象方式进行分发：**

	// 以载荷形式分发
	store.dispatch('incrementAsync', {
	  amount: 10
	})
	
	// 以对象形式分发
	store.dispatch({
	  type: 'incrementAsync',
	  amount: 10
	})
	复制代码

来看一个更加实际的购物车示例，涉及到**调用异步 API 和分发多重 mutation：**

	actions: {
	  checkout ({ commit, state }, products) {
	    // 把当前购物车的物品备份起来
	    const savedCartItems = [...state.cart.added]
	    // 发出结账请求，然后乐观地清空购物车
	    commit(types.CHECKOUT_REQUEST)
	    // 购物 API 接受一个成功回调和一个失败回调
	    shop.buyProducts(
	      products,
	      // 成功操作
	      () => commit(types.CHECKOUT_SUCCESS),
	      // 失败操作
	      () => commit(types.CHECKOUT_FAILURE, savedCartItems)
	    )
	  }
	}
	复制代码

**2.4.2 在组件中分发 Action**

你在组件中使用 `this.$store.dispatch('xxx')` 分发 action，或者使用 `mapActions` 辅助函数将组件的 methods 映射为 `store.dispatch` 调用（需要先在根节点注入 `store`）：

	import { mapActions } from 'vuex'
	
	export default {
	  // ...
	  methods: {
	    ...mapActions([
	      'increment', // 将 `this.increment()` 映射为 `this.$store.dispatch('increment')`
	
	      // `mapActions` 也支持载荷：
	      'incrementBy' // 将 `this.incrementBy(amount)` 映射为 `this.$store.dispatch('incrementBy', amount)`
	    ]),
	    ...mapActions({
	      add: 'increment' // 将 `this.add()` 映射为 `this.$store.dispatch('increment')`
	    })
	  }
	}
	复制代码

**2.4.3 组合 Action**

	Action 通常是异步的，那么如何知道 action 什么时候结束呢？更重要的是，我们如何才能组合多个 action，以处理更加复杂的异步流程？
	复制代码

首先，你需要明白 `store.dispatch` 可以处理被触发的 `action` 的处理函数返回的 `Promise`，并且 `store.dispatch` 仍旧返回 `Promise`：

	actions: {
	  actionA ({ commit }) {
	    return new Promise((resolve, reject) => {
	      setTimeout(() => {
	        commit('someMutation')
	        resolve()
	      }, 1000)
	    })
	  }
	}
	复制代码

现在可以直接使用:

	store.dispatch('actionA').then(() => {
	  // ...
	})
	复制代码

在另外一个 action 中也可以：

	actions: {
	  // ...
	  actionB ({ dispatch, commit }) {
	    return dispatch('actionA').then(() => {
	      commit('someOtherMutation')
	    })
	  }
	}
	复制代码

最后，如果我们利用 `async / await`，我们可以如下组合 action：

	// 假设 getData() 和 getOtherData() 返回的是 Promise
	
	actions: {
	  async actionA ({ commit }) {
	    commit('gotData', await getData())
	  },
	  async actionB ({ dispatch, commit }) {
	    await dispatch('actionA') // 等待 actionA 完成
	    commit('gotOtherData', await getOtherData())
	  }
	}
	复制代码
	一个 store.dispatch 在不同模块中可以触发多个 action 函数。在这种情况下，只有当所有触发函数完成后，返回的 Promise 才会执行。
	复制代码

##### 2.5 Module

	由于使用单一状态树，应用的所有状态会集中到一个比较大的对象。当应用变得非常复杂时，store 对象就有可能变得相当臃肿。
	复制代码

为了解决以上问题，Vuex 允许我们将 store 分割成模块（module)。每个模块拥有自己的 state、mutation、action、getter、甚至是嵌套子模块——从上至下进行同样方式的分割：

	const moduleA = {
	  state: { ... },
	  mutations: { ... },
	  actions: { ... },
	  getters: { ... }
	}
	
	const moduleB = {
	  state: { ... },
	  mutations: { ... },
	  actions: { ... }
	}
	
	const store = new Vuex.Store({
	  modules: {
	    a: moduleA,
	    b: moduleB
	  }
	})
	
	store.state.a // -> moduleA 的状态
	store.state.b // -> moduleB 的状态
	
	假设模块A state 中 有 ‘city’，在外界访问时，则用 store.state.a.city
	#
	复制代码

**2.5.1 模块的局部状态**
对于模块内部的 mutation 和 getter，接收的第一个参数是**模块的局部状态对象。**

	const moduleA = {
	  state: { count: 0 },
	  mutations: {
	    increment (state) {
	      // 这里的 `state` 对象是模块的局部状态
	      state.count++
	    }
	  },
	
	  getters: {
	    doubleCount (state) {
	      return state.count * 2
	    }
	  }
	}
	复制代码

同样，对于模块内部的 `action`，局部状态通过 `context.state` 暴露出来，根节点状态则为 `context.rootState`：

	const moduleA = {
	  // ...
	  actions: {
	    incrementIfOddOnRootSum ({ state, commit, rootState }) {
	      if ((state.count + rootState.count) % 2 === 1) {
	        commit('increment')
	      }
	    }
	  }
	}
	复制代码

对于模块内部的 getter，根节点状态会作为第三个参数暴露出来：

	const moduleA = {
	  // ...
	  getters: {
	    sumWithRootCount (state, getters, rootState) {
	      return state.count + rootState.count
	    }
	  }
	}
	复制代码

**2.5.2 命名空间**

默认情况下，模块内部的 action、mutation 和 getter 是注册在**全局命名空间**的——这样使得多个模块能够对同一 mutation 或 action 作出响应。

	1. 如果希望你的模块具有更高的封装度和复用性，你可以通过添加 namespaced: true 的方式使其成为带命名空间的模块。
	2. 当模块被注册后，它的所有 getter、action 及 mutation 都会自动根据模块注册的路径调整命名。
	复制代码

例如:

	const store = new Vuex.Store({
	  modules: {
	    account: {
	      namespaced: true,
	
	      // 模块内容（module assets）
	      state: { ... }, // 模块内的状态已经是嵌套的了，使用 `namespaced` 属性不会对其产生影响
	      getters: {
	        isAdmin () { ... } // -> getters['account/isAdmin']
	      },
	      actions: {
	        login () { ... } // -> dispatch('account/login')
	      },
	      mutations: {
	        login () { ... } // -> commit('account/login')
	      },
	
	      // 嵌套模块
	      modules: {
	        // 继承父模块的命名空间
	        myPage: {
	          state: { ... },
	          getters: {
	            profile () { ... } // -> getters['account/profile']
	          }
	        },
	
	        // 进一步嵌套命名空间
	        posts: {
	          namespaced: true,
	
	          state: { ... },
	          getters: {
	            popular () { ... } // -> getters['account/posts/popular']
	          }
	        }
	      }
	    }
	  }
	})
	复制代码

启用了命名空间的 getter 和 action 会收到局部化的 `getter`，`dispatch` 和 `commit`。换言之，你在使用模块内容（module assets）时不需要在同一模块内额外添加空间名前缀。更改 `namespaced`属性后不需要修改模块内的代码。

#### 三、 拓展

##### 3.1 项目结构

Vue 并不限制代码的结构，但是，它规定了一些需要遵守的规则:

	1. 应用层级的状态应该集中到单个 store 对象中。
	
	2. 提交 mutation 是更改状态 state的唯一方法，并且这个过程是同步的。
	
	3. 异步逻辑都应该封装到 action 里面。
	复制代码

只要遵循以上规则，对于如何组织代码封装，是项目自身的规划。如果你的 store 文件太大，只需将 action、mutation 和 getter 分割到单独的文件。

在大型的项目应用开发中，会对Vuex的相关代码做一层封装分割到模块中，结构如下:

[1](../_resources/217b3abac2a40907081b4055bac19ad6.webp)

##### 3.2 插件

##### 3.3 严格模式

开启严格模式，仅需在创建 store 的时候传入 `strict`: `true`

	const store = new Vuex.Store({
	  // ...
	  strict: true
	})
	复制代码

**3.3.1 开发和发布环境**
**不要在发布环境下启用严格模式！**

	严格模式会深度监测状态树来检测不合规的状态变更——请确保在发布环境下关闭严格模式，以避免性能损失。
	复制代码

类似于插件，我们可以让构建工具来处理这种情况：

	const store = new Vuex.Store({
	  // ...
	  strict: process.env.NODE_ENV !== 'production'
	})
	复制代码

##### 3.4 表单处理

当在严格模式中使用 Vuex 时，在属于 Vuex 的 state 上使用 `v-model` 会比较棘手：

	<input v-model="obj.message">
	
	注：假设这里的 obj 是在计算属性中返回的一个属于 Vuex store 的对象，在用户输入时，v-model 会试图直接修改 obj.message。
	    在严格模式中，由于这个修改不是在 mutation 函数中执行的, 这里会抛出一个错误。
	复制代码

用“ Vuex 的思维 ”去解决这个问题的方法是：

	给 <input> 中绑定 value，然后侦听 input 或者 change 事件，在事件回调中调用 action:
	复制代码
	<input :value="message" @input="updateMessage">
	
	// ...
	computed: {
	  ...mapState({
	    message: state => state.obj.message
	  })
	},
	methods: {
	  updateMessage (e) {
	    this.$store.commit('updateMessage', e.target.value)
	  }
	}
	复制代码

在mutations函数中：

	// ...
	mutations: {
	  updateMessage (state, message) {
	    state.obj.message = message
	  }
	}
	复制代码

**3.4.1 双向绑定的计算属性**
使用带有 setter 的双向绑定计算属性：

	<input v-model="message">
	复制代码
	// ...
	computed: {
	  message: {
	    get () {
	      return this.$store.state.obj.message
	    },
	    set (value) {
	      this.$store.commit('updateMessage', value)
	    }
	  }
	}
	复制代码

#### 四、 项目使用

##### 安装

	  npm install vuex --save
	复制代码

在 `src` 目录下新建 store文件夹 ,其结构如下:

	├── index.html
	├── main.js
	├── api
	│   └── ... # 抽取出API请求
	├── pages
	│   ├── Goods.vue   //购物车
	│   └── ...
	└── store
	    ├── index.js          # 我们组装模块并导出 store 的地方
	    ├── actions.js        # 根级别的 action
	    ├── mutations.js      # 根级别的 mutation
	    └── {
	         state,
	         getters
	    }
	复制代码

`store/index.js`中代码:

	import Vue from 'vue'
	import Vuex from 'vuex'
	import mutations from './mutations'
	import actions from './actions'
	
	Vue.use(Vuex);
	
	//高级使用，定义常量，作为mutation的方法名
	//模块区分处理
	
	//仓库管理状态
	export default new Vuex.Store({
	  strict: process.env.NODE_ENV !== 'production', //采用严格模式，会抛出项目中不是通过mutation的方式修改而导致的异常。但是要注意：不要在发布环境下启用严格模式！
	  state: {
	    goods: {
	      totalPrice: 0,
	      totalNum: 0,
	      goodsData: []
	    }
	  },
	  // Getter 接受 state 作为其第一个参数， 也可以接受getter作为第二个参数
	  getters: {
	    totalNum(state) {
	      let aTotalNum = 0;
	      if(state.goods.goodsData.length){
	        state.goods.goodsData.forEach((item, index) => {
	          aTotalNum += item.num;
	        })
	      }
	      return aTotalNum;
	    },
	
	    totalPrice(state) {
	      let aTotalPrice = 0;
	      if(state.goods.goodsData.length){
	        state.goods.goodsData.forEach((item, index) => {
	          aTotalPrice += item.num * item.price;
	        })
	      }
	      return aTotalPrice.toFixed(2);
	    }
	  },
	  mutations,
	  actions
	})
	复制代码

在`store/mutations-type.js`中代码:

	import MutationsType from './mutations-type'
	
	//mutations 同步操作通过commit方式修改state的数据,接受state作为第一个参数，第二个参数是载荷
	export default {
	
	  //更新购物车，正常情况是添加/删除操作
	  [MutationsType.GOODS_UPDATE](state, list) {
	    state.goods.goodsData = list;
	  },
	
	  //减少商品
	  [MutationsType.GOODS_REDUCE](state, index) {
	    if (state.goods.goodsData[index].num > 0) {
	      state.goods.goodsData[index].num -= 1;
	    }
	  },
	
	  //增加商品
	  [MutationsType.GOODS_ADD](state, index) {
	    state.goods.goodsData[index].num += 1;
	  },
	}
	
	//使用对象定义常量，管理全局的mutaions
	复制代码

效果如下:

![16cd2ded38b49c9a](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105133206.gif)

**项目地址:**  [Github-购物车项目](https://github.com/ryanmans/Vue/tree/master/Vue%E5%9F%BA%E7%A1%80%E8%AF%AD%E6%B3%95%E5%AD%A6%E4%B9%A0/Vue-vuex)
Redux设计思想与使用场景 - 前端大宝剑 - SegmentFault 思否

1. [专栏](https://segmentfault.com/blogs)

2. / [前端大宝剑](https://segmentfault.com/blog/fedbj)

3. / 文章详情

 [![713215977-59b0a0f798a5b_big64](../_resources/1dc27cfc40f930f588977719be8c39fe.png)](https://segmentfault.com/u/dabai_5955b2921e87d)

 [**dabai**](https://segmentfault.com/u/dabai_5955b2921e87d)  ![rp.png](../_resources/8d87727f62d12ce605abb0e812df02c5.png)3.5k 发布于 [前端大宝剑](https://segmentfault.com/blog/fedbj)

  2018-06-23 发布

#   [Redux设计思想与使用场景](https://segmentfault.com/a/1190000015367584)

 [原创](https://segmentfault.com/a/1190000015367584)

- [redux](https://segmentfault.com/t/redux/blogs)

  2.9k 次阅读  ·  读完需要 10 分钟

欢迎关注我的公众号`睿Talk`，获取我最新的文章：
![bVbmYjo](../_resources/9d212e5a938423a059efd22d3f3306b6.png)

### 一、前言

Redux 作为 React 全家桶的一名重要成员，在众多大牛的力荐之下得到了广泛的应用，Github 上的 Star 也达到 42k 之多！然而，当触及最根本的问题，为什么要使用 Redux 的时候，很多人是说不清楚的。本文尝试解读 Redux 的设计初衷，并结合 React 谈谈实际的使用场景。本文只谈理论，不会对 Redux 的使用作过多的介绍。

### 二、Redux 设计思想

如何用一句话来描述 Redux ？官网是这么写的：
> Redux is a predictable state container for JavaScript apps.
> Redux是一个为JavaScript应用设计的，可预测的状态容器。

由此可见，Redux的主要作用是管理程序状态的。这里所说的状态指的是数据状态，也就model的状态( state )。当今流行的前端框架，都是使用 MVVM 的设计模式，也就 Model，View，View-Model。框架承担了大部分 View-Model 的工作，我们只需要把 Model 和 View 的映射关系定义清楚就行。用公式描述就是`View = Render(Model)`。所以本质来说，用户看到的页面，是Model 在某个状态下的视觉呈现。

![bVbnAa3](../_resources/3d7b5f7d7242ef965eb467c9aa1c5221.png)
页面的切换，可以简单理解为 Model 的状态变迁（同时也会涉及到 UI 的状态变迁）。数据的状态和 UI 的状态，下文统一称为 state。
那么，为什么需要专门有一个工具来管理 state 呢？先来看看下面这张图：
![bVbnAbO](../_resources/7fbf30f8e2ef42f05b5b3a209ae51b22.jpg)

这是一张backbone的数据流图，一个 View 可能涉及到多个 Model，当用户操作 View 的时候，可能引发多个 Model 的更新，而 Model 的更新又会引发另一个 View 的改变。View 与 Model 之间的关系错综复杂，如果想要添加一个功能或者修改 bug，都要花大量的时间进行调试，还容易出问题。

你也许会说，使用 React 就不会遇到这种问题，因为 React 天然就是使用 state 来管理界面的展示，state 与 View 一一对应，这与 Redux 的思想是契合的。然而，随着应用复杂度的增加，你会经历以下心路历程：

- 刚开始的时候，只需要做一些简单的展示，只要在顶层的组件获取数据后再以 props 的形式传给子组件就好了：

![bVbnAbW](../_resources/ed405e9a73d1d95196668d52024a201c.gif)

- 当加入交互功能后，兄弟组件之间需要共享 state 了，当组件一修改后组件二也要同步更新。React 的解决方案是状态提升（Lifting State Up），通过父组件来统一更新 state，再将新的state 通过 props 传递下去：

![bVbnAcd](../_resources/7adb4aa588ca14985673b3bace108e05.gif)

- 随着功能的不断丰富，组件越来越多，state也越来越复杂，直到有一天你发现，修改和共享某个state变得极其艰难：

![bVbnAcu](../_resources/68d9f5328d8a4c30c1feb0494fdba7c1.gif)

共享的state需要放在最顶层维护，然后一层一层地往下传递修改state的方法和展现的数据。这时你会发现，很多数据中间层的组件根本不需要用到，但由于子组件需要用，不得不经过这些中间层组件的传递。更令人头疼的事，当state变化的时候，你根本分不清楚是由哪个组件触发的。

- 这时候如果使用Redux对应用进行重构，状态的变化就会变得非常清晰：

![bVbmUqQ](../_resources/a5c3b436a4f28db524201e13c483ce60.gif)

应用的state统一放在store里面维护，当需要修改state的时候，dispatch一个action给reducer，reducer算出新的state后，再将state发布给事先订阅的组件。

所有对状态的改变都需要dispatch一个action，通过追踪action，就能得出state的变化过程。整个数据流都是单向的，可检测的，可预测的。当然，另一个额外的好处是不再需要一层一层的传递props了，因为Redux内置了一个发布订阅模块。

![bVbnAc6](../_resources/59ff3bcabd135623c63476b198ed042a.jpg)

### 三、使用场景

Redux虽好，但并不适用于所有项目。使用Redux需要创建很多模版代码，会让 state 的更新变得非常繁琐，谁用谁知道![joy.png](../_resources/636a452085e2c332a4c71911e6a85c8f.png)

正如 Redux 的作者 Dan Abramov 所言，Redux 提供了一个交换方案，它要求应用牺牲一定的灵活性以达到以下三个要求：

- > 通过简单对象和数组描述应用状态
- > 通过简单对象描述应用状态的改变
- > 使用纯函数来描述状态改变的逻辑

相应的，你会得到以下好处：

- > 可以很方便的将 state 存储到 Local Storage 中并在需要的时候取出并启动应用
- > 可以在服务器端直接计算出 state 再存到 HTML 中，然后在客户端秒开页面
- > 方便的序列化用户操作和对应的 state 快照，在出现 bug 的时候可以利用这些信息快速复现问题
- > 通过在网络中传递 action 对象，可以在对代码进行很小改动的情况下实现分布式应用
- > 可以在对代码进行很小改动的情况下实现撤销和恢复功能
- > 在开发过程中可以任意跳转到应用的某个历史状态并进行操作
- > 提供全面的审查和控制功能，让开发者可以定制自己的开发工具
- > 将 UI 和业务逻辑分离，使业务逻辑可以在多个地方重用

另外，对于 React 来说，当遇到以下情况你或许需要 Redux 的帮助：

- 同一个 state 需要在多个 Component 中共享
- 需要操作一些全局性的常驻 Component，比如 Notifications，Tooltips 等
- 太多 props 需要在组件树中传递，其中大部分只是为了透传给子组件
- 业务太复杂导致 Component 文件太大，可以考虑将业务逻辑拆出来放到 Reducer 中

### 四、结语

Redux 是一个为 JavaScript 应用设计的，可预测的状态容器。在使用之前，最好先弄清楚他能为你的程序带来什么，需要你做出怎样的妥协，也就是上文提到的交换方案。希望读完本文后，你对Redux 的设计思想与使用场景有一个更全面的了解。

- [![creativecommons-cc.png](../_resources/ddf121fdd94ed641d19e847c28c9e24e.png)](https://creativecommons.org/licenses/by-nc-nd/4.0/)
- [**](Redux设计思想与使用场景%20-%20前端大宝剑%20-%20SegmentFault%20思否.md#)

- [新浪微博](Redux设计思想与使用场景%20-%20前端大宝剑%20-%20SegmentFault%20思否.md#)
- [微信](Redux设计思想与使用场景%20-%20前端大宝剑%20-%20SegmentFault%20思否.md#)
- [Twitter](Redux设计思想与使用场景%20-%20前端大宝剑%20-%20SegmentFault%20思否.md#)
- [Facebook](Redux设计思想与使用场景%20-%20前端大宝剑%20-%20SegmentFault%20思否.md#)

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

#### 你可能感兴趣的

- [理解redux](http://segmentfault.com/a/1190000008317515)zp1996[源码分析](https://segmentfault.com/t/%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90)[javascript](https://segmentfault.com/t/javascript)[redux](https://segmentfault.com/t/redux)
- [flutter中使用redux之基础](http://segmentfault.com/a/1190000015579633)jzoom[前端](https://segmentfault.com/t/%E5%89%8D%E7%AB%AF)[redux](https://segmentfault.com/t/redux)[flutter](https://segmentfault.com/t/flutter)
- [Retalk，Redux 从未如此简单](http://segmentfault.com/a/1190000015456111)南小北[redux](https://segmentfault.com/t/redux)[flux](https://segmentfault.com/t/flux)[react.js](https://segmentfault.com/t/react.js)[前端](https://segmentfault.com/t/%E5%89%8D%E7%AB%AF)
- [redux以及react-redux简单实现](http://segmentfault.com/a/1190000016161913)emsoft[react.js](https://segmentfault.com/t/react.js)[javascript](https://segmentfault.com/t/javascript)[redux](https://segmentfault.com/t/redux)
- [Redux中间件的实践](http://segmentfault.com/a/1190000015773713)田臭脸[react.js](https://segmentfault.com/t/react.js)[redux](https://segmentfault.com/t/redux)
- [在使用Redux前你需要知道关于React的8件事](http://segmentfault.com/a/1190000013725571)funkyLover[react.js](https://segmentfault.com/t/react.js)[redux](https://segmentfault.com/t/redux)
- [对使用Redux和Redux-saga管理状态的思考](http://segmentfault.com/a/1190000011523186)莫凡[前端框架](https://segmentfault.com/t/%E5%89%8D%E7%AB%AF%E6%A1%86%E6%9E%B6)[前端工程化](https://segmentfault.com/t/%E5%89%8D%E7%AB%AF%E5%B7%A5%E7%A8%8B%E5%8C%96)[redux](https://segmentfault.com/t/redux)[react.js](https://segmentfault.com/t/react.js)
- [redux原来如此简单](http://segmentfault.com/a/1190000016311891)frontoldman[redux](https://segmentfault.com/t/redux)[javascript](https://segmentfault.com/t/javascript)

   **2 条评论**
 [默认排序](Redux设计思想与使用场景%20-%20前端大宝剑%20-%20SegmentFault%20思否.md#)  [时间排序](Redux设计思想与使用场景%20-%20前端大宝剑%20-%20SegmentFault%20思否.md#)

 [![2553393559-58db0cbc02df0_big64](../_resources/fdd49cafbc9e4d9d8c265f4272557e11.jpg)](https://segmentfault.com/u/aaawhz)

 [](https://segmentfault.com/a/1190000015367584#911)
 **[aaawhz](https://segmentfault.com/u/aaawhz)**   · 2018年11月12日

不错 对backbone缺点认识很深刻

   **  赞      回复

 [![2553393559-58db0cbc02df0_big64](../_resources/fdd49cafbc9e4d9d8c265f4272557e11.jpg)](https://segmentfault.com/u/aaawhz)

 [](https://segmentfault.com/a/1190000015367584#911)
 **[aaawhz](https://segmentfault.com/u/aaawhz)**   · 2018年11月12日

这个动图厉害了, 用什么工具做的?

   **  赞      回复

 ![user-128.png](../_resources/11debaada78cc2a630b8afb78eec12d1.png)
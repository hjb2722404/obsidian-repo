基于 qiankun 的微前端最佳实践（万字长文） - 从 0 到 1 篇

[(L)](https://juejin.im/user/2999123450531000)

[ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2999123450531000)

2020年05月13日   阅读 26385

#  基于 qiankun 的微前端最佳实践（万字长文） - 从 0 到 1 篇

[1](../_resources/4d1ae5af404bf3d233de03f771306dc9.webp)

## 写在开头

微前端系列文章：

- [基于 qiankun 的微前端最佳实践（万字长文） - 从 0 到 1 篇](https://juejin.im/post/6844904158085021704)
- [基于 qiankun 的微前端最佳实践（图文并茂） - 应用间通信篇](https://juejin.im/post/6844904151231496200)
- [万字长文+图文并茂+全面解析微前端框架 qiankun 源码 - qiankun 篇](https://juejin.im/post/6844904115999342600)

本系列其他文章计划一到两个月内完成，点个 `关注` 不迷路。
计划如下：

- 生命周期篇；
- IE 兼容篇；
- 生产环境部署篇；
- 性能优化、缓存方案篇；

## 引言

大家好~

本文是基于 `qiankun` 的微前端最佳实践系列文章之 `从 0 到 1 篇`，本文将分享如何使用 `qiankun` 如何搭建主应用基座，然后接入不同技术栈的微应用，完成微前端架构的从 0 到 1。

本教程采用 `Vue` 作为主应用基座，接入不同技术栈的微应用。如果你不懂 `Vue` 也没关系，我们在搭建主应用基座的教程尽量不涉及 `Vue` 的 `API`，涉及到 `API` 的地方都会给出解释。

> 注意：`qiankun`>  属于无侵入性的微前端框架，对主应用基座和微应用的技术栈都没有要求。
我们在本教程中，接入了多技术栈 `微应用` 的 `主应用` 最终效果图如下：

[1](../_resources/701f67229e37ff966fc53acc632dd88c.webp)

## 构建主应用基座

我们以 [实战案例 - feature-inject-sub-apps 分支](https://github.com/a1029563229/micro-front-template/tree/feature-inject-sub-apps) （案例是以 `Vue` 为基座的主应用，接入多个微应用） 为例，来介绍一下如何在 `qiankun` 中如何接入不同技术栈的微应用。

我们先使用 `vue-cli` 生成一个 `Vue` 的项目，初始化主应用。

> [> vue-cli](https://cli.vuejs.org/zh/guide/)>  是 `Vue`>  官方提供的脚手架工具，用于快速搭建一个 `Vue`>  项目。如果你想跳过这一步，可以直接 `clone`>   > [> 实战案例 - feature-inject-sub-apps 分支](https://github.com/a1029563229/micro-front-template/tree/feature-inject-sub-apps)>  的代码。

将普通的项目改造成 `qiankun` 主应用基座，需要进行三步操作：
1. 创建微应用容器 - 用于承载微应用，渲染显示微应用；
2. 注册微应用 - 设置微应用激活条件，微应用地址等等；
3. 启动 `qiankun`；

### 创建微应用容器

我们先在主应用中创建微应用的承载容器，这个容器规定了微应用的显示区域，微应用将在该容器内渲染并显示。
我们先设置路由，路由文件规定了主应用自身的路由匹配规则，代码实现如下：

	ts*// micro-app-main/src/routes/index.ts*
	import Home from "@/pages/home/index.vue";

	const routes = [
	  {
	    */**
	     * path: 路径为 / 时触发该路由规则
	     * name: 路由的 name 为 Home
	     * component: 触发路由时加载 `Home` 组件
	     */*
	    path: "/",
	    name: "Home",
	    component: Home,
	  },
	];

	export default routes;

	*// micro-app-main/src/main.ts*
	*//...*
	import Vue from "vue";
	import VueRouter from "vue-router";

	import routes from "./routes";

	*/**
	 * 注册路由实例
	 * 即将开始监听 location 变化，触发路由规则
	 */*
	const router = new VueRouter({
	  mode: "history",
	  routes,
	});

	*// 创建 Vue 实例*
	*// 该实例将挂载/渲染在 id 为 main-app 的节点上*
	new Vue({
	  router,
	  render: (h) => h(App),
	}).$mount("#main-app");
	复制代码

从上面代码可以看出，我们设置了主应用的路由规则，设置了 `Home` 主页的路由匹配规则。
我们现在来设置主应用的布局，我们会有一个菜单和显示区域，代码实现如下：

	ts*// micro-app-main/src/App.vue*
	*//...*
	export default class App extends Vue {
	  */**
	   * 菜单列表
	   * key: 唯一 Key 值
	   * title: 菜单标题
	   * path: 菜单对应的路径
	   */*
	  menus = [
	    {
	      key: "Home",
	      title: "主页",
	      path: "/",
	    },
	  ];
	}
	复制代码

上面的代码是我们对菜单配置的实现，我们还需要实现基座和微应用的显示区域（如下图）

[1](../_resources/5793476197473bdb105fff62006d1bee.webp)

我们来分析一下上面的代码：

- `第 5 行`：主应用菜单，用于渲染菜单；
- `第 9 行`：主应用渲染区。在触发主应用路由规则时（由路由配置表的 `$route.name` 判断），将渲染主应用的组件；
- `第 10 行`：微应用渲染区。在未触发主应用路由规则时（由路由配置表的 `$route.name` 判断），将渲染微应用节点；

从上面的分析可以看出，我们使用了在路由表配置的 `name` 字段进行判断，判断当前路由是否为主应用路由，最后决定渲染主应用组件或是微应用节点。
由于篇幅原因，样式实现代码就不贴出来了，最后主应用的实现效果如下图所示：

[1](../_resources/63b9014ac502468d141f7252b600590e.webp)

从上图可以看出，我们主应用的组件和微应用是显示在同一片内容区域，根据路由规则决定渲染规则。

### 注册微应用

在构建好了主框架后，我们需要使用 `qiankun` 的 `registerMicroApps` 方法注册微应用，代码实现如下：

	ts*// micro-app-main/src/micro/apps.ts*
	*// 此时我们还没有微应用，所以 apps 为空*
	const apps = [];

	export default apps;

	*// micro-app-main/src/micro/index.ts*
	*// 一个进度条插件*
	import NProgress from "nprogress";
	import "nprogress/nprogress.css";
	import { message } from "ant-design-vue";
	import {
	  registerMicroApps,
	  addGlobalUncaughtErrorHandler,
	  start,
	} from "qiankun";

	*// 微应用注册信息*
	import apps from "./apps";

	*/**
	 * 注册微应用
	 * 第一个参数 - 微应用的注册信息
	 * 第二个参数 - 全局生命周期钩子
	 */*
	registerMicroApps(apps, {
	  *// qiankun 生命周期钩子 - 微应用加载前*
	  beforeLoad: (app: any) => {
	    *// 加载微应用前，加载进度条*
	    NProgress.start();
	    console.log("before load", app.name);
	    return Promise.resolve();
	  },
	  *// qiankun 生命周期钩子 - 微应用挂载后*
	  afterMount: (app: any) => {
	    *// 加载微应用前，进度条加载完成*
	    NProgress.done();
	    console.log("after mount", app.name);
	    return Promise.resolve();
	  },
	});

	*/**
	 * 添加全局的未捕获异常处理器
	 */*
	addGlobalUncaughtErrorHandler((event: Event | string) => {
	  console.error(event);
	  const { message: msg } = event as any;
	  *// 加载失败时提示*
	  if (msg && msg.includes("died in status LOADING_SOURCE_CODE")) {
	    message.error("微应用加载失败，请检查应用是否可运行");
	  }
	});

	*// 导出 qiankun 的启动函数*
	export default start;
	复制代码

从上面可以看出，我们的微应用注册信息在 `apps` 数组中（此时为空，我们在后面接入微应用时会添加微应用注册信息），然后使用 `qiankun` 的 `registerMicroApps` 方法注册微应用，最后导出了 `start` 函数，注册微应用的工作就完成啦！

### 启动主应用

我们在注册好了微应用，导出 `start` 函数后，我们需要在合适的地方调用 `start` 启动主应用。
我们一般是在入口文件启动 `qiankun` 主应用，代码实现如下：

	ts*// micro-app-main/src/main.ts*
	*//...*
	import startQiankun from "./micro";

	startQiankun();
	复制代码

最后，启动我们的主应用，效果图如下：

[1](../_resources/63b9014ac502468d141f7252b600590e.webp)

因为我们还没有注册任何微应用，所以这里的效果图和上面的效果图是一样的。
到这一步，我们的主应用基座就创建好啦！

## 接入微应用

我们现在的主应用基座只有一个主页，现在我们需要接入微应用。
`qiankun` 内部通过 `import-entry-html` 加载微应用，要求微应用需要导出生命周期钩子函数（见下图）。

[1](../_resources/2be4bcf1fd0a0f0e5e26e3a2c76a1c85.webp)

从上图可以看出，`qiankun` 内部会校验微应用的生命周期钩子函数，如果微应用没有导出这三个生命周期钩子函数，则微应用会加载失败。

如果我们使用了脚手架搭建微应用的话，我们可以通过 `webpack` 配置在入口文件处导出这三个生命周期钩子函数。如果没有使用脚手架的话，也可以直接在微应用的 `window` 上挂载这三个生命周期钩子函数。

现在我们来接入我们的各个技术栈微应用吧！
> 注意，下面的内容对相关技术栈 `API`>  不会再有过多介绍啦，如果你要接入不同技术栈的微应用，最好要对该技术栈有一些基础了解。

## 接入 `Vue` 微应用

我们以 [实战案例 - feature-inject-sub-apps 分支](https://github.com/a1029563229/micro-front-template/tree/feature-inject-sub-apps) 为例，我们在主应用的同级目录（`micro-app-main` 同级目录），使用 `vue-cli` 先创建一个 `Vue` 的项目，在命令行运行如下命令：

	vue create micro-app-vue
	复制代码

本文的 `vue-cli` 选项如下图所示，你也可以根据自己的喜好选择配置。

[1](../_resources/3c34de63cb92376237ecfad2d3e609bd.webp)

在新建项目完成后，我们创建几个路由页面再加上一些样式，最后效果如下：

[1](../_resources/b6eb952bc8e8269004abcee1cae76c43.webp)

[1](../_resources/8d3234af9b2a654b427a141e7912d06b.webp)

### 注册微应用

在创建好了 `Vue` 微应用后，我们可以开始我们的接入工作了。首先我们需要在主应用中注册该微应用的信息，代码实现如下：

	ts*// micro-app-main/src/micro/apps.ts*
	const apps = [
	  */**
	   * name: 微应用名称 - 具有唯一性
	   * entry: 微应用入口 - 通过该地址加载微应用
	   * container: 微应用挂载节点 - 微应用加载完成后将挂载在该节点上
	   * activeRule: 微应用触发的路由规则 - 触发路由规则后将加载该微应用
	   */*
	  {
	    name: "VueMicroApp",
	    entry: "//localhost:10200",
	    container: "#frame",
	    activeRule: "/vue",
	  },
	];

	export default apps;
	复制代码

通过上面的代码，我们就在主应用中注册了我们的 `Vue` 微应用，进入 `/vue` 路由时将加载我们的 `Vue` 微应用。
我们在菜单配置处也加入 `Vue` 微应用的快捷入口，代码实现如下：

	ts*// micro-app-main/src/App.vue*
	*//...*
	export default class App extends Vue {
	  */**
	   * 菜单列表
	   * key: 唯一 Key 值
	   * title: 菜单标题
	   * path: 菜单对应的路径
	   */*
	  menus = [
	    {
	      key: "Home",
	      title: "主页",
	      path: "/",
	    },
	    {
	      key: "VueMicroApp",
	      title: "Vue 主页",
	      path: "/vue",
	    },
	    {
	      key: "VueMicroAppList",
	      title: "Vue 列表页",
	      path: "/vue/list",
	    },
	  ];
	}
	复制代码

菜单配置完成后，我们的主应用基座效果图如下

[1](../_resources/a976476a75d9f2a39b6b5a782f4424cc.webp)

### 配置微应用

在主应用注册好了微应用后，我们还需要对微应用进行一系列的配置。首先，我们在 `Vue` 的入口文件 `main.js` 中，导出 `qiankun` 主应用所需要的三个生命周期钩子函数，代码实现如下：

[1](../_resources/1294a1a2cdb3bf4d066c48f357515c75.webp)

从上图来分析：

- `第 6 行`：`webpack` 默认的 `publicPath` 为 `""` 空字符串，会基于当前路径来加载资源。我们在主应用中加载微应用时需要重新设置 `publicPath`，这样才能正确加载微应用的相关资源。（`public-path.js` 具体实现在后面）
- `第 21 行`：微应用的挂载函数，在主应用中运行时将在 `mount` 生命周期钩子函数中调用，可以保证在沙箱内运行。
- `第 38 行`：微应用独立运行时，直接执行 `render` 函数挂载微应用。
- `第 46 行`：微应用导出的生命周期钩子函数 - `bootstrap`。
- `第 53 行`：微应用导出的生命周期钩子函数 - `mount`。
- `第 61 行`：微应用导出的生命周期钩子函数 - `unmount`。

完整代码实现如下：

	js*// micro-app-vue/src/public-path.js*
	if (window.__POWERED_BY_QIANKUN__) {
	  *// 动态设置 webpack publicPath，防止资源加载出错*
	  *// eslint-disable-next-line no-undef*
	  __webpack_public_path__ = window.__INJECTED_PUBLIC_PATH_BY_QIANKUN__;
	}

	*// micro-app-vue/src/main.js*
	import Vue from "vue";
	import VueRouter from "vue-router";
	import Antd from "ant-design-vue";
	import "ant-design-vue/dist/antd.css";

	import "./public-path";
	import App from "./App.vue";
	import routes from "./routes";

	Vue.use(VueRouter);
	Vue.use(Antd);
	Vue.config.productionTip = false;

	let instance = null;
	let router = null;

	*/**
	 * 渲染函数
	 * 两种情况：主应用生命周期钩子中运行 / 微应用单独启动时运行
	 */*
	function render() {
	  *// 在 render 中创建 VueRouter，可以保证在卸载微应用时，移除 location 事件监听，防止事件污染*
	  router = new VueRouter({
	    *// 运行在主应用中时，添加路由命名空间 /vue*
	    base: window.__POWERED_BY_QIANKUN__ ? "/vue" : "/",
	    mode: "history",
	    routes,
	  });

	  *// 挂载应用*
	  instance = new Vue({
	    router,
	    render: (h) => h(App),
	  }).$mount("#app");
	}

	*// 独立运行时，直接挂载应用*
	if (!window.__POWERED_BY_QIANKUN__) {
	  render();
	}

	*/**
	 * bootstrap 只会在微应用初始化的时候调用一次，下次微应用重新进入时会直接调用 mount 钩子，不会再重复触发 bootstrap。
	 * 通常我们可以在这里做一些全局变量的初始化，比如不会在 unmount 阶段被销毁的应用级别的缓存等。
	 */*
	export async function bootstrap() {
	  console.log("VueMicroApp bootstraped");
	}

	*/**
	 * 应用每次进入都会调用 mount 方法，通常我们在这里触发应用的渲染方法
	 */*
	export async function mount(props) {
	  console.log("VueMicroApp mount", props);
	  render(props);
	}

	*/**
	 * 应用每次 切出/卸载 会调用的方法，通常在这里我们会卸载微应用的应用实例
	 */*
	export async function unmount() {
	  console.log("VueMicroApp unmount");
	  instance.$destroy();
	  instance = null;
	  router = null;
	}
	复制代码

在配置好了入口文件 `main.js` 后，我们还需要配置 `webpack`，使 `main.js` 导出的生命周期钩子函数可以被 `qiankun` 识别获取。

我们直接配置 `vue.config.js` 即可，代码实现如下：

	js*// micro-app-vue/vue.config.js*
	const path = require("path");

	module.exports = {
	  devServer: {
	    *// 监听端口*
	    port: 10200,
	    *// 关闭主机检查，使微应用可以被 fetch*
	    disableHostCheck: true,
	    *// 配置跨域请求头，解决开发环境的跨域问题*
	    headers: {
	      "Access-Control-Allow-Origin": "*",
	    },
	  },
	  configureWebpack: {
	    resolve: {
	      alias: {
	        "@": path.resolve(__dirname, "src"),
	      },
	    },
	    output: {
	      *// 微应用的包名，这里与主应用中注册的微应用名称一致*
	      library: "VueMicroApp",
	      *// 将你的 library 暴露为所有的模块定义下都可运行的方式*
	      libraryTarget: "umd",
	      *// 按需加载相关，设置为 webpackJsonp_VueMicroApp 即可*
	      jsonpFunction: `webpackJsonp_VueMicroApp`,
	    },
	  },
	};
	复制代码

我们需要重点关注一下 `output` 选项，当我们把 `libraryTarget` 设置为 `umd` 后，我们的 `library` 就暴露为所有的模块定义下都可运行的方式了，主应用就可以获取到微应用的生命周期钩子函数了。

在 `vue.config.js` 修改完成后，我们重新启动 `Vue` 微应用，然后打开主应用基座 `http://localhost:9999`。我们点击左侧菜单切换到微应用，此时我们的 `Vue` 微应用被正确加载啦！（见下图）

[1](../_resources/61d163a834278ff40ad7085f063bda64.webp)

此时我们打开控制台，可以看到我们所执行的生命周期钩子函数（见下图）

[1](../_resources/072a50edda7586f23540da5678270e6d.webp)

到这里，`Vue` 微应用就接入成功了！

## 接入 `React` 微应用

我们以 [实战案例 - feature-inject-sub-apps 分支](https://github.com/a1029563229/micro-front-template/tree/feature-inject-sub-apps) 为例，我们在主应用的同级目录（`micro-app-main` 同级目录），使用 `create-react-app` 先创建一个 `React` 的项目，在命令行运行如下命令：

	npx create-react-app micro-app-react
	复制代码

在项目创建完成后，我们在根目录下添加 `.env` 文件，设置项目监听的端口，代码实现如下：

	*# micro-app-react/.env*
	PORT=10100
	BROWSER=none
	复制代码

然后，我们创建几个路由页面再加上一些样式，最后效果如下：

[1](../_resources/e6fac6cfd40243a3e9edd301131cd01d.webp)

[1](../_resources/c1da4c16f0efc53aeca999a2d179393e.webp)

### 注册微应用

在创建好了 `React` 微应用后，我们可以开始我们的接入工作了。首先我们需要在主应用中注册该微应用的信息，代码实现如下：

	ts*// micro-app-main/src/micro/apps.ts*
	const apps = [
	  */**
	   * name: 微应用名称 - 具有唯一性
	   * entry: 微应用入口 - 通过该地址加载微应用
	   * container: 微应用挂载节点 - 微应用加载完成后将挂载在该节点上
	   * activeRule: 微应用触发的路由规则 - 触发路由规则后将加载该微应用
	   */*
	  {
	    name: "ReactMicroApp",
	    entry: "//localhost:10100",
	    container: "#frame",
	    activeRule: "/react",
	  },
	];

	export default apps;
	复制代码

通过上面的代码，我们就在主应用中注册了我们的 `React` 微应用，进入 `/react` 路由时将加载我们的 `React` 微应用。
我们在菜单配置处也加入 `React` 微应用的快捷入口，代码实现如下：

	ts*// micro-app-main/src/App.vue*
	*//...*
	export default class App extends Vue {
	  */**
	   * 菜单列表
	   * key: 唯一 Key 值
	   * title: 菜单标题
	   * path: 菜单对应的路径
	   */*
	  menus = [
	    {
	      key: "Home",
	      title: "主页",
	      path: "/",
	    },
	    {
	      key: "ReactMicroApp",
	      title: "React 主页",
	      path: "/react",
	    },
	    {
	      key: "ReactMicroAppList",
	      title: "React 列表页",
	      path: "/react/list",
	    },
	  ];
	}
	复制代码

菜单配置完成后，我们的主应用基座效果图如下

[1](../_resources/f98f706e963c03bd8bac856eed66e83d.webp)

### 配置微应用

在主应用注册好了微应用后，我们还需要对微应用进行一系列的配置。首先，我们在 `React` 的入口文件 `index.js` 中，导出 `qiankun` 主应用所需要的三个生命周期钩子函数，代码实现如下：

[1](../_resources/8d5aa09e972b1fb837ae62ee94a57f52.webp)

从上图来分析：

- `第 5 行`：`webpack` 默认的 `publicPath` 为 `""` 空字符串，会基于当前路径来加载资源。我们在主应用中加载微应用时需要重新设置 `publicPath`，这样才能正确加载微应用的相关资源。（`public-path.js` 具体实现在后面）
- `第 12 行`：微应用的挂载函数，在主应用中运行时将在 `mount` 生命周期钩子函数中调用，可以保证在沙箱内运行。
- `第 17 行`：微应用独立运行时，直接执行 `render` 函数挂载微应用。
- `第 25 行`：微应用导出的生命周期钩子函数 - `bootstrap`。
- `第 32 行`：微应用导出的生命周期钩子函数 - `mount`。
- `第 40 行`：微应用导出的生命周期钩子函数 - `unmount`。

完整代码实现如下：

	js*// micro-app-react/src/public-path.js*
	if (window.__POWERED_BY_QIANKUN__) {
	  *// 动态设置 webpack publicPath，防止资源加载出错*
	  *// eslint-disable-next-line no-undef*
	  __webpack_public_path__ = window.__INJECTED_PUBLIC_PATH_BY_QIANKUN__;
	}

	*// micro-app-react/src/index.js*
	import React from "react";
	import ReactDOM from "react-dom";
	import "antd/dist/antd.css";

	import "./public-path";
	import App from "./App.jsx";

	*/**
	 * 渲染函数
	 * 两种情况：主应用生命周期钩子中运行 / 微应用单独启动时运行
	 */*
	function render() {
	  ReactDOM.render(<App />, document.getElementById("root"));
	}

	// 独立运行时，直接挂载应用
	if (!window.__POWERED_BY_QIANKUN__) {
	  render();
	}

	/**
	 * bootstrap 只会在微应用初始化的时候调用一次，下次微应用重新进入时会直接调用 mount 钩子，不会再重复触发 bootstrap。
	 * 通常我们可以在这里做一些全局变量的初始化，比如不会在 unmount 阶段被销毁的应用级别的缓存等。
	 */
	export async function bootstrap() {
	  console.log("ReactMicroApp bootstraped");
	}

	/**
	 * 应用每次进入都会调用 mount 方法，通常我们在这里触发应用的渲染方法
	 */
	export async function mount(props) {
	  console.log("ReactMicroApp mount", props);
	  render(props);
	}

	/**
	 * 应用每次 切出/卸载 会调用的方法，通常在这里我们会卸载微应用的应用实例
	 */
	export async function unmount() {
	  console.log("ReactMicroApp unmount");
	  ReactDOM.unmountComponentAtNode(document.getElementById("root"));
	}
	复制代码

在配置好了入口文件 `index.js` 后，我们还需要配置路由命名空间，以确保主应用可以正确加载微应用，代码实现如下：

	js// micro-app-react/src/App.jsx
	const BASE_NAME = window.__POWERED_BY_QIANKUN__ ? "/react" : "";
	const App = () => {
	  //...

	  return (
	    // 设置路由命名空间
	    <Router basename={BASE_NAME}>{/* ... */}</Router>
	  );
	};
	复制代码

接下来，我们还需要配置 `webpack`，使 `index.js` 导出的生命周期钩子函数可以被 `qiankun` 识别获取。
我们需要借助 `react-app-rewired` 来帮助我们修改 `webpack` 的配置，我们直接安装该插件：

	npm install react-app-rewired -D
	复制代码

在 `react-app-rewired` 安装完成后，我们还需要修改 `package.json` 的 `scripts` 选项，修改为由 `react-app-rewired` 启动应用，就像下面这样

	json// micro-app-react/package.json

	//...
	"scripts": {
	  "start": "react-app-rewired start",
	  "build": "react-app-rewired build",
	  "test": "react-app-rewired test",
	  "eject": "react-app-rewired eject"
	}
	复制代码

在 `react-app-rewired` 配置完成后，我们新建 `config-overrides.js` 文件来配置 `webpack`，代码实现如下：

	jsconst path = require("path");

	module.exports = {
	  webpack: (config) => {
	    *// 微应用的包名，这里与主应用中注册的微应用名称一致*
	    config.output.library = `ReactMicroApp`;
	    *// 将你的 library 暴露为所有的模块定义下都可运行的方式*
	    config.output.libraryTarget = "umd";
	    *// 按需加载相关，设置为 webpackJsonp_VueMicroApp 即可*
	    config.output.jsonpFunction = `webpackJsonp_ReactMicroApp`;

	    config.resolve.alias = {
	      ...config.resolve.alias,
	      "@": path.resolve(__dirname, "src"),
	    };
	    return config;
	  },

	  devServer: function (configFunction) {
	    return function (proxy, allowedHost) {
	      const config = configFunction(proxy, allowedHost);
	      *// 关闭主机检查，使微应用可以被 fetch*
	      config.disableHostCheck = true;
	      *// 配置跨域请求头，解决开发环境的跨域问题*
	      config.headers = {
	        "Access-Control-Allow-Origin": "*",
	      };
	      *// 配置 history 模式*
	      config.historyApiFallback = true;

	      return config;
	    };
	  },
	};
	复制代码

我们需要重点关注一下 `output` 选项，当我们把 `libraryTarget` 设置为 `umd` 后，我们的 `library` 就暴露为所有的模块定义下都可运行的方式了，主应用就可以获取到微应用的生命周期钩子函数了。

在 `config-overrides.js` 修改完成后，我们重新启动 `React` 微应用，然后打开主应用基座 `http://localhost:9999`。我们点击左侧菜单切换到微应用，此时我们的 `React` 微应用被正确加载啦！（见下图）

[1](../_resources/41d81b206e8c102d22294ae6bcabfbe7.webp)

此时我们打开控制台，可以看到我们所执行的生命周期钩子函数（见下图）

[1](../_resources/262b7afd7448596b7bdd094cf47d2b8b.webp)

到这里，`React` 微应用就接入成功了！

## 接入 `Angular` 微应用

`Angular` 与 `qiankun` 目前的兼容性并不太好，接入 `Angular` 微应用需要一定的耐心与技巧。
> 对于选择 `Angular`>  技术栈的前端开发来说，对这类情况应该驾轻就熟（没有办法）。

我们以 [实战案例 - feature-inject-sub-apps 分支](https://github.com/a1029563229/micro-front-template/tree/feature-inject-sub-apps) 为例，我们在主应用的同级目录（`micro-app-main` 同级目录），使用 `@angular/cli` 先创建一个 `Angular` 的项目，在命令行运行如下命令：

	ng new micro-app-angular
	复制代码

本文的 `@angular/cli` 选项如下图所示，你也可以根据自己的喜好选择配置。

[1](../_resources/629cfc1a42573b5204be53c5edd62325.webp)

然后，我们创建几个路由页面再加上一些样式，最后效果如下：

[1](../_resources/8a8210382b912fa38830d511de1f6357.webp)

[1](../_resources/5bd38e33bee5a70d5cb91b1c394b18b9.webp)

### 注册微应用

在创建好了 `Angular` 微应用后，我们可以开始我们的接入工作了。首先我们需要在主应用中注册该微应用的信息，代码实现如下：

	ts*// micro-app-main/src/micro/apps.ts*
	const apps = [
	  */**
	   * name: 微应用名称 - 具有唯一性
	   * entry: 微应用入口 - 通过该地址加载微应用
	   * container: 微应用挂载节点 - 微应用加载完成后将挂载在该节点上
	   * activeRule: 微应用触发的路由规则 - 触发路由规则后将加载该微应用
	   */*
	  {
	    name: "AngularMicroApp",
	    entry: "//localhost:10300",
	    container: "#frame",
	    activeRule: "/angular",
	  },
	];

	export default apps;
	复制代码

通过上面的代码，我们就在主应用中注册了我们的 `Angular` 微应用，进入 `/angular` 路由时将加载我们的 `Angular` 微应用。
我们在菜单配置处也加入 `Angular` 微应用的快捷入口，代码实现如下：

	ts*// micro-app-main/src/App.vue*
	*//...*
	export default class App extends Vue {
	  */**
	   * 菜单列表
	   * key: 唯一 Key 值
	   * title: 菜单标题
	   * path: 菜单对应的路径
	   */*
	  menus = [
	    {
	      key: "Home",
	      title: "主页",
	      path: "/",
	    },
	    {
	      key: "AngularMicroApp",
	      title: "Angular 主页",
	      path: "/angular",
	    },
	    {
	      key: "AngularMicroAppList",
	      title: "Angular 列表页",
	      path: "/angular/list",
	    },
	  ];
	}
	复制代码

菜单配置完成后，我们的主应用基座效果图如下

[1](../_resources/5458a491156a197970ccd70f8e2535be.webp)

最后我们在主应用的入口文件，引入 `zone.js`，代码实现如下：
`Angular`>  运行依赖于 `zone.js`> 。

`qiankun`>  基于 `single-spa`>  实现，`single-spa`>  明确指出一个项目的 `zone.js`>  只能存在一份实例，所以我们在主应用注入 `zone.js`> 。

	js*// micro-app-main/src/main.js*

	*// 为 Angular 微应用所做的 zone 包注入*
	import "zone.js/dist/zone";
	复制代码

### 配置微应用

在主应用的工作完成后，我们还需要对微应用进行一系列的配置。首先，我们使用 `single-spa-angular` 生成一套配置，在命令行运行以下命令：

	*# 安装 single-spa*
	yarn add single-spa -S

	*# 添加 single-spa-angular*
	ng add single-spa-angular
	复制代码

运行命令时，根据自己的需求选择配置即可，本文配置如下：

[1](../_resources/3eb58c2ca809c8f2a6653e1e44f66039.webp)

在生成 `single-spa` 配置后，我们需要进行一些 `qiankun` 的接入配置。我们在 `Angular` 微应用的入口文件 `main.single-spa.ts` 中，导出 `qiankun` 主应用所需要的三个生命周期钩子函数，代码实现如下：

[1](../_resources/041f14ab36e7e5b7cd37a790e3ca71b3.webp)

从上图来分析：

- `第 21 行`：微应用独立运行时，直接执行挂载函数挂载微应用。
- `第 46 行`：微应用导出的生命周期钩子函数 - `bootstrap`。
- `第 50 行`：微应用导出的生命周期钩子函数 - `mount`。
- `第 54 行`：微应用导出的生命周期钩子函数 - `unmount`。

完整代码实现如下：

	ts*// micro-app-angular/src/main.single-spa.ts*
	import { enableProdMode, NgZone } from "@angular/core";

	import { platformBrowserDynamic } from "@angular/platform-browser-dynamic";
	import { Router } from "@angular/router";
	import { ɵAnimationEngine as AnimationEngine } from "@angular/animations/browser";

	import {
	  singleSpaAngular,
	  getSingleSpaExtraProviders,
	} from "single-spa-angular";

	import { AppModule } from "./app/app.module";
	import { environment } from "./environments/environment";
	import { singleSpaPropsSubject } from "./single-spa/single-spa-props";

	if (environment.production) {
	  enableProdMode();
	}

	*// 微应用单独启动时运行*
	if (!(window as any).__POWERED_BY_QIANKUN__) {
	  platformBrowserDynamic()
	    .bootstrapModule(AppModule)
	    .catch((err) => console.error(err));
	}

	const { bootstrap, mount, unmount } = singleSpaAngular({
	  bootstrapFunction: (singleSpaProps) => {
	    singleSpaPropsSubject.next(singleSpaProps);
	    return platformBrowserDynamic(getSingleSpaExtraProviders()).bootstrapModule(
	      AppModule
	    );
	  },
	  template: "<app-root />",
	  Router,
	  NgZone,
	  AnimationEngine,
	});

	*/** 主应用生命周期钩子中运行 */*
	export {
	  */**
	   * bootstrap 只会在微应用初始化的时候调用一次，下次微应用重新进入时会直接调用 mount 钩子，不会再重复触发 bootstrap。
	   * 通常我们可以在这里做一些全局变量的初始化，比如不会在 unmount 阶段被销毁的应用级别的缓存等。
	   */*
	  bootstrap,
	  */**
	   * 应用每次进入都会调用 mount 方法，通常我们在这里触发应用的渲染方法
	   */*
	  mount,
	  */**
	   * 应用每次 切出/卸载 会调用的方法，通常在这里我们会卸载微应用的应用实例
	   */*
	  unmount,
	};
	复制代码

在配置好了入口文件 `main.single-spa.ts` 后，我们还需要配置 `webpack`，使 `main.single-spa.ts` 导出的生命周期钩子函数可以被 `qiankun` 识别获取。

我们直接配置 `extra-webpack.config.js` 即可，代码实现如下：

	js*// micro-app-angular/extra-webpack.config.js*
	const singleSpaAngularWebpack = require("single-spa-angular/lib/webpack")
	  .default;
	const webpackMerge = require("webpack-merge");

	module.exports = (angularWebpackConfig, options) => {
	  const singleSpaWebpackConfig = singleSpaAngularWebpack(
	    angularWebpackConfig,
	    options
	  );

	  const singleSpaConfig = {
	    output: {
	      *// 微应用的包名，这里与主应用中注册的微应用名称一致*
	      library: "AngularMicroApp",
	      *// 将你的 library 暴露为所有的模块定义下都可运行的方式*
	      libraryTarget: "umd",
	    },
	  };
	  const mergedConfig = webpackMerge.smart(
	    singleSpaWebpackConfig,
	    singleSpaConfig
	  );
	  return mergedConfig;
	};
	复制代码

我们需要重点关注一下 `output` 选项，当我们把 `libraryTarget` 设置为 `umd` 后，我们的 `library` 就暴露为所有的模块定义下都可运行的方式了，主应用就可以获取到微应用的生命周期钩子函数了。

在 `extra-webpack.config.js` 修改完成后，我们还需要修改一下 `package.json` 中的启动命令，修改如下：

	json// micro-app-angular/package.json
	{
	  //...
	  "script": {
	    //...
	    // --disable-host-check: 关闭主机检查，使微应用可以被 fetch
	    // --port: 监听端口
	    // --base-href: 站点的起始路径，与主应用中配置的一致
	    "start": "ng serve --disable-host-check --port 10300 --base-href /angular"
	  }
	}
	复制代码

修改完成后，我们重新启动 `Angular` 微应用，然后打开主应用基座 `http://localhost:9999`。我们点击左侧菜单切换到微应用，此时我们的 `Angular` 微应用被正确加载啦！（见下图）

[1](../_resources/ad08656425d56e0f095be7e2482b9c57.webp)

到这里，`Angular` 微应用就接入成功了！

## 接入 `Jquery、xxx...` 微应用

> 这里的 `Jquery、xxx...`>  微应用指的是没有使用脚手架，直接采用 `html + css + js`>  三剑客开发的应用。
> 本案例使用了一些高级 `ES`>  语法，请使用谷歌浏览器运行查看效果。

我们以 [实战案例 - feature-inject-sub-apps 分支](https://github.com/a1029563229/micro-front-template/tree/feature-inject-sub-apps) 为例，我们在主应用的同级目录（`micro-app-main` 同级目录），手动创建目录 `micro-app-static`。

我们使用 `express` 作为服务器加载静态 `html`，我们先编辑 `package.json`，设置启动命令和相关依赖。

	json// micro-app-static/package.json
	{
	  "name": "micro-app-jquery",
	  "version": "1.0.0",
	  "description": "",
	  "main": "index.js",
	  "scripts": {
	    "start": "nodemon index.js"
	  },
	  "author": "",
	  "license": "ISC",
	  "dependencies": {
	    "express": "^4.17.1",
	    "cors": "^2.8.5"
	  },
	  "devDependencies": {
	    "nodemon": "^2.0.2"
	  }
	}
	复制代码

然后添加入口文件 `index.js`，代码实现如下：

	js*// micro-app-static/index.js*
	const express = require("express");
	const cors = require("cors");

	const app = express();
	*// 解决跨域问题*
	app.use(cors());
	app.use('/', express.static('static'));

	*// 监听端口*
	app.listen(10400, () => {
	  console.log("server is listening in http://localhost:10400")
	});
	复制代码

使用 `npm install` 安装相关依赖后，我们使用 `npm start` 启动应用。
我们新建 `static` 文件夹，在文件夹内新增一个静态页面 `index.html`（代码在后面会贴出），加上一些样式后，打开浏览器，最后效果如下：

[1](../_resources/78ef0483308d1a488115a282ab206293.webp)

### 注册微应用

在创建好了 `Static` 微应用后，我们可以开始我们的接入工作了。首先我们需要在主应用中注册该微应用的信息，代码实现如下：

	ts*// micro-app-main/src/micro/apps.ts*
	const apps = [
	  */**
	   * name: 微应用名称 - 具有唯一性
	   * entry: 微应用入口 - 通过该地址加载微应用
	   * container: 微应用挂载节点 - 微应用加载完成后将挂载在该节点上
	   * activeRule: 微应用触发的路由规则 - 触发路由规则后将加载该微应用
	   */*
	  {
	    name: "StaticMicroApp",
	    entry: "//localhost:10400",
	    container: "#frame",
	    activeRule: "/static"
	  },
	];

	export default apps;
	复制代码

通过上面的代码，我们就在主应用中注册了我们的 `Static` 微应用，进入 `/static` 路由时将加载我们的 `Static` 微应用。
我们在菜单配置处也加入 `Static` 微应用的快捷入口，代码实现如下：

	ts*// micro-app-main/src/App.vue*
	*//...*
	export default class App extends Vue {
	  */**
	   * 菜单列表
	   * key: 唯一 Key 值
	   * title: 菜单标题
	   * path: 菜单对应的路径
	   */*
	  menus = [
	    {
	      key: "Home",
	      title: "主页",
	      path: "/"
	    },
	    {
	      key: "StaticMicroApp",
	      title: "Static 微应用",
	      path: "/static"
	    }
	  ];
	}
	复制代码

菜单配置完成后，我们的主应用基座效果图如下

[1](../_resources/a8061281a40a4a90d674c558f99d05e5.webp)

### 配置微应用

在主应用注册好了微应用后，我们还需要直接写微应用 `index.html` 的代码即可，代码实现如下：

[1](../_resources/af99d4d601be21add3afe500a7410432.webp)

从上图来分析：

- `第 70 行`：微应用的挂载函数，在主应用中运行时将在 `mount` 生命周期钩子函数中调用，可以保证在沙箱内运行。
- `第 77 行`：微应用独立运行时，直接执行 `render` 函数挂载微应用。
- `第 88 行`：微应用注册的生命周期钩子函数 - `bootstrap`。
- `第 95 行`：微应用注册的生命周期钩子函数 - `mount`。
- `第 102 行`：微应用注册的生命周期钩子函数 - `unmount`。

完整代码实现如下：

	html*<!-- micro-app-static/static/index.html -->*
	<!DOCTYPE html>
	<html lang="en">
	  <head>
	    <meta charset="UTF-8" />
	    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
	    *<!-- 引入 bootstrap -->*
	    <link
	      href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css"
	      rel="stylesheet"
	    />
	    <title>Jquery App</title>
	  </head>

	  <body>
	    <section
	      id="jquery-app-container"
	      style="padding: 20px; color: blue;"
	    ></section>
	  </body>
	  *<!-- 引入 jquery -->*
	  <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	  <script>
	    */**
	     * 请求接口数据，构建 HTML
	     */*
	    async function buildHTML() {
	      const result = await fetch("http://dev-api.jt-gmall.com/mall", {
	        method: "POST",
	        headers: {
	          "Content-Type": "application/json",
	        },
	        *// graphql 的查询风格*
	        body: JSON.stringify({
	          query: `{ vegetableList (page: 1, pageSize: 20) { page, pageSize, total, items { _id, name, poster, price } } }`,
	        }),
	      }).then((res) => res.json());
	      const list = result.data.vegetableList.items;
	      const html = `<table class="table">
	  <thead>
	    <tr>
	      <th scope="col">菜名</th>
	      <th scope="col">图片</th>
	      <th scope="col">报价</th>
	    </tr>
	  </thead>
	  <tbody>
	    ${list
	      .map(
	        (item) => `
	    <tr>
	      <td>
	        <img style="width: 40px; height: 40px; border-radius: 100%;" src="${item.poster}"></img>
	      </td>
	      <td>${item.name}</td>
	      <td>￥ ${item.price}</td>
	    </tr>
	      `
	      )
	      .join("")}
	  </tbody>
	</table>`;
	      return html;
	    }

	    */**
	     * 渲染函数
	     * 两种情况：主应用生命周期钩子中运行 / 微应用单独启动时运行
	     */*
	    const render = async ($) => {
	      const html = await buildHTML();
	      $("#jquery-app-container").html(html);
	      return Promise.resolve();
	    };

	    *// 独立运行时，直接挂载应用*
	    if (!window.__POWERED_BY_QIANKUN__) {
	      render($);
	    }

	    ((global) => {
	      */**
	       * 注册微应用生命周期钩子函数
	       * global[appName] 中的 appName 与主应用中注册的微应用名称一致
	       */*
	      global["StaticMicroApp"] = {
	        */**
	         * bootstrap 只会在微应用初始化的时候调用一次，下次微应用重新进入时会直接调用 mount 钩子，不会再重复触发 bootstrap。
	         * 通常我们可以在这里做一些全局变量的初始化，比如不会在 unmount 阶段被销毁的应用级别的缓存等。
	         */*
	        bootstrap: () => {
	          console.log("MicroJqueryApp bootstraped");
	          return Promise.resolve();
	        },
	        */**
	         * 应用每次进入都会调用 mount 方法，通常我们在这里触发应用的渲染方法
	         */*
	        mount: () => {
	          console.log("MicroJqueryApp mount");
	          return render($);
	        },
	        */**
	         * 应用每次 切出/卸载 会调用的方法，通常在这里我们会卸载微应用的应用实例
	         */*
	        unmount: () => {
	          console.log("MicroJqueryApp unmount");
	          return Promise.resolve();
	        },
	      };
	    })(window);
	  </script>
	</html>
	复制代码

在构建好了 `Static` 微应用后，我们打开主应用基座 `http://localhost:9999`。我们点击左侧菜单切换到微应用，此时可以看到，我们的 `Static` 微应用被正确加载啦！（见下图）

[1](../_resources/ae961c58d72d8e2db1379fbe7a7bc53f.webp)

此时我们打开控制台，可以看到我们所执行的生命周期钩子函数（见下图）

[1](../_resources/db1c2a2e9a29bafd71352a8ec19ebc06.webp)

到这里，`Static` 微应用就接入成功了！

### 扩展阅读

如果在 `Static` 微应用的 `html` 中注入 `SPA` 路由功能的话，将演变成单页应用，只需要在主应用中注册一次。

如果是多个 `html` 的多页应用 - `MPA`，则需要在服务器（或反向代理服务器）中通过 `referer` 头返回对应的 `html` 文件，或者在主应用中注册多个微应用（不推荐）。

## 小结

最后，我们所有微应用都注册在主应用和主应用的菜单中，效果图如下：

[1](../_resources/701f67229e37ff966fc53acc632dd88c.webp)

从上图可以看出，我们把不同技术栈 `Vue、React、Angular、Jquery...` 的微应用都已经接入到主应用基座中啦！

## 最后一件事

如果您已经看到这里了，希望您还是点个赞再走吧~
您的点赞是对作者的最大鼓励，也可以让更多人看到本篇文章！

如果觉得本文对您有帮助，请帮忙在 [github](https://github.com/a1029563229/Blogs) 上点亮 `star` 鼓励一下吧！

[1](../_resources/d10ebb28aaf0e37699755a04b58f2abe.webp)

关注下面的标签，发现更多相似文章

[  前端](https://juejin.im/tag/%E5%89%8D%E7%AB%AF)
 [

[(L)](https://juejin.im/user/2999123450531000)

[ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2999123450531000)  前端工程师 @ 明源云

[发布了 23 篇专栏 ·](https://juejin.im/user/2999123450531000/posts)   获得点赞 1,356 ·    获得阅读 62,633](https://juejin.im/user/2999123450531000)

[安装掘金浏览器插件](https://juejin.im/extension/?utm_source=juejin.im&utm_medium=post&utm_campaign=extension_promotion)

打开新标签页发现好内容，掘金、GitHub、Dribbble、ProductHunt 等站点内容轻松获取。快来安装掘金浏览器插件获取高质量内容吧！

输入评论...

 [(L)](https://juejin.im/user/114004940030478)

 [ Iam_bling   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/114004940030478)

请教，前后端没有分离的jsp项目可以用qiankun嘛![1f62d.png](../_resources/e0119e99f4d36cfe56eea73cff8314fc.png)

1月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='661'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='662'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1028798616962366)
 [Yoocoo](https://juejin.im/user/1028798616962366)

最基本的子应用的端口号都跟主应用重复了，这文章是拿来看根本用不了吧，看评论全是盲目膜拜的我佛了

2月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='663'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='664'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
请在 Demo 的 Github Issue 提供无法运行的应用案例

2月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='665'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='666'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3227821867810664)
 [humor](https://juejin.im/user/3227821867810664)
前端开发工程师 @ MT
感觉qiankun最大的优势就是html-entry 巧妙的避开了js-entry加载子应用js的hash问题

3月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='667'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='668'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/465848660408238)
 [GeKi9256](https://juejin.im/user/465848660408238)
前端
请问楼主、有遇到【主应用】使用vue-admin-template及【子应用】也使用vue-admin-template时 vue-router

3月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='669'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='670'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/465848660408238)
 [GeKi9256](https://juejin.im/user/465848660408238)
前端
1、切换无效的情况嘛

3月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='671'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='672'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/465848660408238)
 [GeKi9256](https://juejin.im/user/465848660408238)
前端
回复
 [GeKi9256](https://juejin.im/user/465848660408238)
: 2、项目中404被拦截重载的情况嘛

3月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='673'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='674'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3931509311682894)
 [403 Forbidden](https://juejin.im/user/3931509311682894)

你好，我觉得微前端这种好像并不能解决我们的场景，因为我理解的是在你的描述下，比如说代码管理用的git，主应用和子应用是完全两个不同的repo，由于业务原因，他们不可能在一个项目的repo 里面，但是对于微前端这种场景，貌似所有的应用至少都是在一个repo 里面的，是吗？那像我说的这种场景，应该怎么样运用微前端呢

4月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='675'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='676'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1310273589485352)

 [ 眠云   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/1310273589485352)

前端开发 @ 阿里云
你好，我是公众号 进击的前端101 小编，请问我们可以转载你的文章吗 可以加我的微信 front_end_101 沟通

4月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='677'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='678'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1081575170116574)

 [ kkmo   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/1081575170116574)

依然在前行
不用lerna管理？

4月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='679'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='680'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3632442148130056)
 [胆](https://juejin.im/user/3632442148130056)

很棒![1f44d-1f3fb.png](../_resources/5e74a9f4fd619053371ece93d4fb6fae.png)的文章！请问直接输入基座路由加上微应用路由无法访问页面，是什么原因啊？比如/vue/hello

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='681'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='682'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3104676567324648)
 [芒果小跟班](https://juejin.im/user/3104676567324648)
前端
问个问题，刷新页面怎么办嘛？我把主应用history和主应用加过404页面都不太好使，你是怎么决解的嘛

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='683'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='684'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
你好，history 支持可能有问题

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='685'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='686'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/114004939777543)

 [ yingzz   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/114004939777543)

前端
催更催更 部署那块问题

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='687'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='688'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
哈哈 最近迭代任务太紧张 预计下个月才能产出

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='689'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='690'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2612095359911582)

 [ 禾口和先森   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2612095359911582)

前端 @ @搬砖工
部署使用nginx就好了

2月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='691'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='692'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/993614240687016)

 [ 赤虹   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/993614240687016)

前端超级工程师 @ 阿里巴巴-高德
如果不能解决子应用间独立开发，独立部署，沙箱容错，如果不能保证应用的性能。即使接100，也始终是个玩具。类似的我不用乾坤也能做。

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='693'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='694'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/712139265292045)
 [Sapphire](https://juejin.im/user/712139265292045)

大佬，我在部署之后 ，加载速度超级慢，有什么优化方案吗

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='695'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='696'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/993614240687016)

 [ 赤虹   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/993614240687016)

前端超级工程师 @ 阿里巴巴-高德
这么多运行时，不慢才怪。

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='697'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='698'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
考虑一下服务器带宽问题

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='699'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='700'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1204720474796110)
 [本尊50834](https://juejin.im/user/1204720474796110)
前端工程师
这样在本地启动没有问题，但是生产环境打包的话，楼主有什么好的方案吗？

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='701'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='702'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
最近在努力产出这块的文档哈

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='703'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='704'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3966693685860504)
 [快乐的小马甲](https://juejin.im/user/3966693685860504)

跟single-spa一模一样呀

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='705'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='706'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1451011081247560)

 [ 丶远方   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/1451011081247560)

前端开发工程师 @ 十八般武艺科技有限公司
请问大侠，我在主应用配置了路由匹配不到就跳转到404页面，这样的话子应用也会404，有没有什么方法解决我这个问题

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='707'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='708'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
你好，注册一下子应用的路由就好了

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='709'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='710'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1908407917358510)

 [ qwer   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/1908407917358510)

前端开发
看了文章，写的很认真，一看就会，不知道一写会不会就废，需要自己去实践一下。公司项目目前可能用不到微前端。

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='711'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='712'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
哈哈，可以的 捧场小王 ![1f44f.png](../_resources/39c38ca266ef7c0bbfd763ea2703e61f.png)

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='713'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='714'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/4248168660754935)

 [ 天生不是宠儿   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/4248168660754935)

如果是多个子应用那么模块打包是整体打包还是分开打包 不影响主进程应用

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='715'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='716'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
你好，最好是各个微应用独立打包，独立运行哈

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='717'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='718'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/993614241738974)
 [無名路人](https://juejin.im/user/993614241738974)
前端代码搬运工

比如有老应用react，和重构一部分了的vue，是直接用这个vue作为主应用基座还是新建一个?目前这两个项目也都有顶部菜单和侧边栏菜单，如果以微应用形式接入进来的话是要把老应用菜单全屏蔽吧？

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='719'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)1

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='720'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
你好，你这种情况可以直接使用重构的 Vue 应用作为基座。其他的你说的都对，微应用接入需要屏蔽菜单哈。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='721'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='722'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/782508011823006)
 [loky555](https://juejin.im/user/782508011823006)

qiankun 2.0的vue接入楼主研究分享下。我这边遇到qiankun2.0 子应用组件两次加载执行问题，没有解决方案。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='723'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='724'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
有可能有重复的节点，运行一下 Demo，应该不存在这种问题哈。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='725'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='726'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2295436011377559)
 [长沙林更林](https://juejin.im/user/2295436011377559)
前端工程师
关注一波~

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='727'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='728'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
哈哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='729'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='730'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2559318798372221)

 [ 吴阿铸   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2559318798372221)

前端开发 @ asiainfo

有几个点提问下哈，我按步骤走其中有一点有疑问，就是主应用的App.vue文件，一般情况下我们做项目的时候App.vue里只放一个 这样方便登录页面跟其他带sidebar跟header footer的页面走不同的layout，但是现在这里面就直接带了sidebar跟header，那这样登录页面就继承这个app.vue里的这些东西了。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='731'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='732'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2559318798372221)

 [ 吴阿铸   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2559318798372221)

前端开发 @ asiainfo
然后我如果把写在app.vue里的sidebar跟header写进home.vue的话，mircoVue就无法启动报错啦~

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='733'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='734'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云

你好，你的需求有两个方案可以解决 1. 系列文章 - 应用间通信篇有登录界面，你可以看看。 2. 按你现有的方案也可以实现，这个需要你自己研究一下哈，我们没有使用这种方案。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='735'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='736'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2559318798372221)

 [ 吴阿铸   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2559318798372221)

前端开发 @ asiainfo
回复
 [晒兜斯](https://juejin.im/user/2999123450531000)
: 谢谢哈~

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='737'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='738'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
回复
 [吴阿铸](https://juejin.im/user/2559318798372221)
: 不客气 哈哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='739'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='740'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3456520287701742)

 [ 改天换日喵   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/3456520287701742)

搬砖工人 @ 初九背单词
你可以监听路由控制是否显示其他区域的内容，我就是这么做的，可行哈。这样可以配置哪些路由可以显示菜单。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='741'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='742'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2049145402829079)
 [Fiction8816](https://juejin.im/user/2049145402829079)
前端
多个子项目用nginx进行代理，是不是也算微前端呢，这样子子项目的技术栈也可以任意选择

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='743'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)1

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='744'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
微前端有多种实现方案，听你的说法不太清晰，像是 MPA 的方案。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='745'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='746'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1187128285357432)
 [小岗英伦风](https://juejin.im/user/1187128285357432)
高级前端 @ 云族佳
这种方式牵涉到刷新和公用header之类的问题。体验一般

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='747'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='748'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/817692379458573)
 [quickeryi](https://juejin.im/user/817692379458573)
前端工程师 @ 字节跳动
路由分发应用式，也算是一种实现吧

4月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='749'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='750'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1398234517885965)
 [乌托邦](https://juejin.im/user/1398234517885965)

希望再来篇文章写调试和部署的![1f4aa.png](../_resources/35073baf492bf5cb07628c757ef93559.png)

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='751'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='752'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
好的好的 这块方案比较多，需要详细写一下 哈哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='753'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='754'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2154698519087800)
 [安可biganke](https://juejin.im/user/2154698519087800)
打杂的前端
回复
 [晒兜斯](https://juejin.im/user/2999123450531000)
: 你好，近期也在尝试，想知道最后如何部署生产，以及会遇到的问题。非常感谢您

5月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='755'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='756'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1398234517885965)
 [乌托邦](https://juejin.im/user/1398234517885965)

vue 的话， 路由的 mode 必须是 history ，这个坑了我好久。我觉得要特意指明下，因为大多数人应该不会用 history 这个模式吧

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='757'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)1

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='758'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
这块并没有限制哈，父子应用同时为 `hash` 模式也是可以的。我在写部署篇的时候看看这块怎么补充一下好一点，确实可能需要补充一下，谢谢你的建议哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='759'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='760'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1398234517885965)
 [乌托邦](https://juejin.im/user/1398234517885965)

回复
 [晒兜斯](https://juejin.im/user/2999123450531000)
: 我一开始主应用是 history 模式，微应用是 hash 模式，进入微应用的路由，微应用无法显示，也没有报错。最后统一成 history 就可以了

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='761'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='762'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1873223545274557)
 [优点:脾气好](https://juejin.im/user/1873223545274557)
web前端
get技能，我之前还在用iframe，准备去改成这个试试。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='763'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='764'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
哈哈 加油

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='765'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='766'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2788017221411768)
 [YAO同志105418](https://juejin.im/user/2788017221411768)

我的应用基座刷新后回丢失接入的微应用，这个怎么解决勒

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='767'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='768'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
不太清楚你的具体问题哈，可以加群发个图我帮你看看

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='769'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='770'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2788017221411768)
 [YAO同志105418](https://juejin.im/user/2788017221411768)

回复
 [晒兜斯](https://juejin.im/user/2999123450531000)
: 找到了 应该是webpck配置的原因

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='771'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='772'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3790771823840318)
 [豪Sir](https://juejin.im/user/3790771823840318)

Vue微应用路由用了这种写法，在主应用里面就会报错： component: () => import('@/views/About.vue') 报错信息： Uncaught SyntaxError: Unexpected token '<'…

展开
6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='773'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='774'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3790771823840318)
 [豪Sir](https://juejin.im/user/3790771823840318)

怪我看的不仔细， if (window.__POWERED_BY_QIANKUN__) { // 动态设置 webpack publicPath，防止资源加载出错 // eslint-disable-next-line no-undef __webpack_public_path__ = window.__INJECTED_PUBLIC_PATH_BY_QIANKUN__; }

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='775'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='776'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
哈哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='777'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='778'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3632442147089326)

 [ 醉卧沙场君莫笑   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/3632442147089326)

前端
主应用与微应用之间的通信、以及微应用之间有没有文章介绍，

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='779'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)1

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='780'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
在开头的系列文章中 - 应用间通信篇，有详细介绍哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='781'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)1

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='782'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1943592290765896)
 [D-ing104952](https://juejin.im/user/1943592290765896)

最近在各种尝试微前端的架子，刚试完umi+umi-plugin-qiankun的组合，一脸懵逼配置项。 大佬写的是我目前搜到的最详细的一篇文章了，赞![1f44d.png](../_resources/6eda7e79b2f79a13f1dd85187af0c1df.png)之前我demo遇到的问题更多是关于build后，各应用部署时关于publicPath的问题，非根部目下的配置等等这些，现在还是很晕。 大佬能分享下这方面的东西吗？

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='783'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)1

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='784'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
这块需要单独开个专栏，在生产部署篇来详细说。 这块涉及到一些 webpack 的知识哈，后面会详细说的哈 。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='785'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='786'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/4125023358948798)

 [ 方土   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/4125023358948798)

头发开发 @ M78星云

如果是一个很大的相互协同的系统，微化会更容易扩展，正好最近在研究这个，果断收藏了![1f604.png](../_resources/4645eddb296a7fcad78481155f31390e.png)

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='787'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='788'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
哈哈 可以的

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='789'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='790'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/96412753476279)

 [ zxh1307   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/96412753476279)

前端
我又来了![1f604.png](../_resources/4645eddb296a7fcad78481155f31390e.png)

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='791'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='792'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
哈哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='793'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='794'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3632442148141406)

 [ 撒点料儿   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/3632442148141406)

前端扫地僧
从过来人说，中台项目，真的很需要微前端

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='795'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='796'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
哈哈 是的

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='797'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='798'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2049145404929421)

 [ 千百度海   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2049145404929421)

FE
笔误：介入react app中，你写了通过react-create-app创建应用，应为create-react-app

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='799'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='800'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
谢谢提醒哈，已经修改啦

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='801'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='802'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2049145404929421)

 [ 千百度海   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2049145404929421)

FE
回复
 [晒兜斯](https://juejin.im/user/2999123450531000)

: 文字这么多，不小心就出错了，我上面的接入都打错了![1f602.png](../_resources/8723a7e9956be69c39a4901e62f93908.png)，这文章挺好的

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='803'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='804'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
回复
 [千百度海](https://juejin.im/user/2049145404929421)
: 哈哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='805'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='806'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1855631358952126)

 [ 无心同学   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/1855631358952126)

前端代码搬运工
点赞收藏一条龙，去我的收藏夹里吃灰把![1f602.png](../_resources/8723a7e9956be69c39a4901e62f93908.png)

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='807'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)4

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='808'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
哈哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='809'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='810'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1239904844782152)

 [ XGHeaven   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/1239904844782152)

屏幕像素叠加工程师 @ 字节跳动

反问系列: 为什么你们不喜欢用 iframe 呢？如果是 iframe 不满足要求为啥不做个提案呢？国内环境就是喜欢在外围打转，咋就不喜欢去推进标准呢，哎。哈哈哈，![1f436.png](../_resources/a72932aff1f4d3a9a2f38ec29e827821.png)护体

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='811'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)1

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='812'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云

标准也有一些提供，比如 shadow dom，但是 IE 兼容是绕不过去的坎呀，哈哈。 Why not iframe？请参考 [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxOCIgaGVpZ2h0PSIxOCIgdmlld0JveD0iMCAwIDE4IDE4Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgc3Ryb2tlPSIjMDI3RkZGIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS13aWR0aD0iLjgxOCI+CiAgICAgICAgPHBhdGggZD0iTTguMDMgNS4yNzZsMS41ODUtMS41ODRjMS4wOTMtMS4wOTMgMi45My0xLjAzIDQuMS4xNDEgMS4xNzIgMS4xNzIgMS4yMzYgMy4wMDguMTQyIDQuMTAyTDEyLjY3IDkuMTIzbC0uNzkyLjc5MmMtMS4wOTMgMS4wOTMtMi45MyAxLjAzLTQuMS0uMTQyIi8+CiAgICAgICAgPHBhdGggZD0iTTkuMjE5IDEyLjU3M2wtMS41ODQgMS41ODRjLTEuMDk0IDEuMDk0LTIuOTMgMS4wMy00LjEwMi0uMTQxLTEuMTcxLTEuMTcyLTEuMjM0LTMuMDA4LS4xNDEtNC4xMDFMNC41OCA4LjcyN2wuNzkyLS43OTJjMS4wOTMtMS4wOTQgMi45My0xLjAzIDQuMTAxLjE0MSIvPgogICAgPC9nPgo8L3N2Zz4K)yuque.com/kuitos/gky7yw/...](https://www.yuque.com/kuitos/gky7yw/gesexv) 有知大佬的理解 我们表示认同，使用 iframe 会让我们的产品实现不了一些我们想要的效果，导致卖不出高价，哈哈。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='813'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='814'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1239904844782152)

 [ XGHeaven   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/1239904844782152)

屏幕像素叠加工程师 @ 字节跳动
回复
 [晒兜斯](https://juejin.im/user/2999123450531000)
: 我看过这个，我就是看了之后才想起来，既然 iframe有问题，就给提案去解决呀，总不能因小失大呀。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='815'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='816'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
回复
 [XGHeaven](https://juejin.im/user/1239904844782152)
: 哈哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='817'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='818'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2612095359911582)

 [ 禾口和先森   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2612095359911582)

前端 @ @搬砖工
回复
 [XGHeaven](https://juejin.im/user/1239904844782152)
: 微前端的重心是解决了跨技术栈的问题，iframe有很多问题也是可以解决的

2月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='819'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='820'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/4107431171331742)

 [ 阿哲攻城狮   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/4107431171331742)

软件开发工程师 @ strong
什么场景下使用微应用架构合适？如果就是单一的技术栈，一套一系统，有必要使用微前端架构吗？

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='821'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='822'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云

微前端架构比较适合用于中台的前端架构；单一技术栈也可以使用微前端架构，微前端架构可以解决随着业务快速发展之后，单体应用进化成巨石应用，如何维护一个巨无霸中台应用的问题。

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='823'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='824'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/976022056222622)

 [ _小白_   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/976022056222622)

全栈工程师
后面按模块升级就会凸显微应用的好处了

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='825'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='826'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/4406498334867783)

 [ 前端菜13   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/4406498334867783)

web前端
想什么就来什么 开始跟着文章敲了![1f61c.png](../_resources/17588679cce9f1c5f0051561407c70af.png)

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='827'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)1

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='828'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
好的 哈哈 奥利给

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='829'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='830'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1855631358952126)

 [ 无心同学   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/1855631358952126)

前端代码搬运工
想吃奶，妈来了。想娘家人，孩他舅舅来了

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='831'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='832'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
回复
 [无心同学](https://juejin.im/user/1855631358952126)
: 哈哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='833'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='834'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2418581310280215)

 [ 方雨_Yu   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2418581310280215)

前端 @ null
如何实现每个子项目打包部署

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='835'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='836'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
这个在后面的部署系列文章会提到哈，可以使用脚手架来部署打包发布哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='837'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='838'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/166781495809917)

 [ 方雨   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/166781495809917)

前端 @ null
回复
 [晒兜斯](https://juejin.im/user/2999123450531000)
: 期待![1f60d.png](../_resources/545b42165e2ad77200949c34cae9acd0.png)

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='839'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='840'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/4265760848883255)
 [kd88](https://juejin.im/user/4265760848883255)
Web前端工程师
这个是我最感兴趣的点

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='841'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='842'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/1820446986609847)
 [Soneer](https://juejin.im/user/1820446986609847)
后端开发
回复
 [方雨](https://juejin.im/user/166781495809917)
: 这种留言最多是几级？看看呢？

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='843'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='844'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3491704661083134)

 [ 吴予安   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/3491704661083134)

前端 @ 面对老板开发
很棒，最近也在搞这个，明天去改(抄)代码![1f609.png](../_resources/20be5411dd986b08ccae57595e360ffc.png)

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='845'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='846'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云
好的呀，哈哈

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='847'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='848'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/3913917127986381)

 [ cfang   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/3913917127986381)

失业 @ 亘云科技

大佬: 这样的错误怎么解决 vue-router.esm.js:2117 Error: [qiankun]: moduleReport wrapper with id __qiankun_subapp_wrapper_for_module_report__ not ready! at Ae (dynamicHeadAppend.js:45)…

展开
6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='849'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-d03fcb84='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='850'%3e%3cg data-v-d03fcb84='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-d03fcb84='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-d03fcb84='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 [(L)](https://juejin.im/user/2999123450531000)

 [ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  (作者)](https://juejin.im/user/2999123450531000)

前端工程师 @ 明源云

加载动态样式时，微应用还没有准备就绪，微应用的加载有点问题哈，具体的需要看代码啦![1f602.png](../_resources/8723a7e9956be69c39a4901e62f93908.png)

6月前

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon like-icon js-evernote-checked' data-evernote-id='851'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M4.58 8.25V17h-1.4C2.53 17 2 16.382 2 15.624V9.735c0-.79.552-1.485 1.18-1.485h1.4zM11.322 2c1.011.019 1.614.833 1.823 1.235.382.735.392 1.946.13 2.724-.236.704-.785 1.629-.785 1.629h4.11c.434 0 .838.206 1.107.563.273.365.363.84.24 1.272l-1.86 6.513A1.425 1.425 0 0 1 14.724 17H6.645V7.898C8.502 7.51 9.643 4.59 9.852 3.249A1.47 1.47 0 0 1 11.322 2z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-35801ab3='' aria-hidden='true' width='16' height='16' viewBox='0 0 20 20' class='icon comment-icon js-evernote-checked' data-evernote-id='852'%3e%3cg data-v-35801ab3='' fill='none' fill-rule='evenodd'%3e%3cpath data-v-35801ab3='' d='M0 0h20v20H0z'%3e%3c/path%3e %3cpath data-v-35801ab3='' stroke='%238A93A0' stroke-linejoin='round' d='M10 17c-4.142 0-7.5-2.91-7.5-6.5S5.858 4 10 4c4.142 0 7.5 2.91 7.5 6.5 0 1.416-.522 2.726-1.41 3.794-.129.156.41 3.206.41 3.206l-3.265-1.134c-.998.369-2.077.634-3.235.634z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  回复

 **

相关推荐

-

    - [B_Cornelius](https://juejin.im/user/1521379822287294)

·

    - 2小时前·

    - [前端](https://juejin.im/tag/%E5%89%8D%E7%AB%AF)

 [基于useRef实现clickoutside](https://juejin.im/post/6895979849387606029)

    - [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)   5]()

    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6895979849387606029#comment)

    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-

    - [阿里巴巴淘系技术](https://juejin.im/user/395479919373991)

·

    - 7小时前·

    - [前端](https://juejin.im/tag/%E5%89%8D%E7%AB%AF)

 [4982亿背后的前端技术—2020天猫双11前端体系大揭秘](https://juejin.im/post/6895904259972448263)

    - [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)   35]()

    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)   24](https://juejin.im/post/6895904259972448263#comment)

    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-

    - [ThinkJS](https://juejin.im/user/2330620381634078)

·

    - 1天前·

    - [Serverless/](https://juejin.im/tag/Serverless)[前端](https://juejin.im/tag/%E5%89%8D%E7%AB%AF)

 [基于 Serverless 的 Valine 可能并没有那么香](https://juejin.im/post/6895513856228261896)

    - [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)   19]()

    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)   10](https://juejin.im/post/6895513856228261896#comment)

    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-

    - [xL丶](https://juejin.im/user/3113449536099437)

·

    - 1天前·

    - [前端](https://juejin.im/tag/%E5%89%8D%E7%AB%AF)

 [【从青铜到钻石】3 年创业公司成长经历 && 面试总结](https://juejin.im/post/6895347434029842440)

    - [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)   366]()

    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)   73](https://juejin.im/post/6895347434029842440#comment)

    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-

    - [小罗伯特](https://juejin.im/user/237150241292861)

·

    - 3小时前·

    - [前端](https://juejin.im/tag/%E5%89%8D%E7%AB%AF)

 [浅析前端性能优化总结](https://juejin.im/post/6895967227825094663)

    - [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)   4]()

    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6895967227825094663#comment)

    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-

    - [技术漫谈](https://juejin.im/user/1451011080718557)

·

    - 7小时前·

    - [前端/](https://juejin.im/tag/%E5%89%8D%E7%AB%AF)[JavaScript](https://juejin.im/tag/JavaScript)

 [在 JavaScript 中，我们能为原始类型添加一个属性或方法吗？](https://juejin.im/post/6895894647424417806)

    - [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)   7]()

    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)   6](https://juejin.im/post/6895894647424417806#comment)

    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-

    - [阿宝哥](https://juejin.im/user/764915822103079)

·

    - 1天前·

    - [前端](https://juejin.im/tag/%E5%89%8D%E7%AB%AF)

 [postMessage 还能这样玩](https://juejin.im/post/6895502625970585607)

    - [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)   202]()

    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)   30](https://juejin.im/post/6895502625970585607#comment)

    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-

    - [谭光志](https://juejin.im/user/1433418893103645)

·

    - 1天前·

    - [前端/](https://juejin.im/tag/%E5%89%8D%E7%AB%AF)[程序员](https://juejin.im/tag/%E7%A8%8B%E5%BA%8F%E5%91%98)

 [而立之年——回顾我的前端转行之路](https://juejin.im/post/6895502326195290119)

    - [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)   146]()

    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)   75](https://juejin.im/post/6895502326195290119#comment)

    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-

    - [京东设计中心JDC](https://juejin.im/user/3949101495616919)

·

    - 8小时前·

    - [React.js/](https://juejin.im/tag/React.js)[前端](https://juejin.im/tag/%E5%89%8D%E7%AB%AF)

 [SPA 路由三部曲之核心原理](https://juejin.im/post/6895882310458343431)

    - [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)   15]()

    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)   1](https://juejin.im/post/6895882310458343431#comment)

    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-

    - [技术漫谈](https://juejin.im/user/1451011080718557)

·

    - 1天前·

    - [JavaScript/](https://juejin.im/tag/JavaScript)[前端](https://juejin.im/tag/%E5%89%8D%E7%AB%AF)

 [ES2020 系列：可选链 "?." 为啥出现，我们能用它来干啥？](https://juejin.im/post/6895518401196720136)

    - [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)   87]()

    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)   48](https://juejin.im/post/6895518401196720136#comment)

    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

关于作者

[

[ 晒兜斯   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2999123450531000) 前端工程师 @ 明源云](https://juejin.im/user/2999123450531000)

![](data:image/svg+xml,%3csvg data-v-52d07ee0='' data-v-71f2d09e='' xmlns='http://www.w3.org/2000/svg' width='25' height='26' viewBox='0 0 25 26' class='zan js-evernote-checked' data-evernote-id='853'%3e%3cg data-v-52d07ee0='' data-v-71f2d09e='' fill='none' fill-rule='evenodd' transform='translate(0 .57)'%3e%3cellipse data-v-52d07ee0='' data-v-71f2d09e='' cx='12.5' cy='12.57' fill='%23E1EFFF' rx='12.5' ry='12.57'%3e%3c/ellipse%3e %3cpath data-v-52d07ee0='' data-v-71f2d09e='' fill='%237BB9FF' d='M8.596 11.238V19H7.033C6.463 19 6 18.465 6 17.807v-5.282c0-.685.483-1.287 1.033-1.287h1.563zm4.275-4.156A1.284 1.284 0 0 1 14.156 6c.885.016 1.412.722 1.595 1.07.334.638.343 1.687.114 2.361-.207.61-.687 1.412-.687 1.412h3.596c.38 0 .733.178.969.488.239.317.318.728.21 1.102l-1.628 5.645a1.245 1.245 0 0 1-1.192.922h-7.068v-7.889c1.624-.336 2.623-2.866 2.806-4.029z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  获得点赞1,356

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-52d07ee0='' data-v-71f2d09e='' width='25' height='25' viewBox='0 0 25 25' class='icon stat-view-icon js-evernote-checked' data-evernote-id='854'%3e%3cg data-v-52d07ee0='' data-v-71f2d09e='' fill='none' fill-rule='evenodd'%3e%3ccircle data-v-52d07ee0='' data-v-71f2d09e='' cx='12.5' cy='12.5' r='12.5' fill='%23E1EFFF'%3e%3c/circle%3e %3cpath data-v-52d07ee0='' data-v-71f2d09e='' fill='%237BB9FF' d='M4 12.5S6.917 7 12.75 7s8.75 5.5 8.75 5.5-2.917 5.5-8.75 5.5S4 12.5 4 12.5zm8.75 2.292c1.208 0 2.188-1.026 2.188-2.292 0-1.266-.98-2.292-2.188-2.292-1.208 0-2.188 1.026-2.188 2.292 0 1.266.98 2.292 2.188 2.292z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  文章被阅读62,633

- [(L)](https://juejin.im/post/6888942104484151304)
- [(L)](https://www.huodongxing.com/go/tl17)
- [(L)](https://juejin.im/pin/6893685972966309896)
- [(L)](https://developersummit.googlecnapps.cn/?utm_source=Juejin&utm_medium=banner&utm_campaign=gds2020)
- [(L)](https://qcon.infoq.cn/2020/shenzhen/schedule?utm_source=media&utm_medium=juejin&utm_campaign=9&utm_content=banner)

相关文章

[盘一盘那些提效/创意的 vscode 插件   ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  356    ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik0yIDR2OC4wMzhoNC40NDRMMTEuMTExIDE1di0yLjk2MkgxNFY0eiIvPgogICAgPC9nPgo8L3N2Zz4K)  45](https://juejin.im/post/6870428510041833480)[图解跨域请求、反向代理原理，对前端更友好的反向代理服务器 - Caddy   ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  186    ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik0yIDR2OC4wMzhoNC40NDRMMTEuMTExIDE1di0yLjk2MkgxNFY0eiIvPgogICAgPC9nPgo8L3N2Zz4K)  39](https://juejin.im/post/6844904167639629838)[万字长文+图文并茂+全面解析微前端框架 qiankun 源码 - qiankun 篇   ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  85    ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik0yIDR2OC4wMzhoNC40NDRMMTEuMTExIDE1di0yLjk2MkgxNFY0eiIvPgogICAgPC9nPgo8L3N2Zz4K)  18](https://juejin.im/post/6844904115999342600)[基于 qiankun 的微前端最佳实践（图文并茂） - 应用间通信篇   ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  69    ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik0yIDR2OC4wMzhoNC40NDRMMTEuMTExIDE1di0yLjk2MkgxNFY0eiIvPgogICAgPC9nPgo8L3N2Zz4K)  9](https://juejin.im/post/6844904151231496200)[万字长文+图文并茂+全面解析 React 源码 - render 篇   ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  17    ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik0yIDR2OC4wMzhoNC40NDRMMTEuMTExIDE1di0yLjk2MkgxNFY0eiIvPgogICAgPC9nPgo8L3N2Zz4K)  0](https://juejin.im/post/6844904099670917128)

目录

- [写在开头](https://juejin.im/post/6844904158085021704#heading-0)
- [引言](https://juejin.im/post/6844904158085021704#heading-1)
- [构建主应用基座](https://juejin.im/post/6844904158085021704#heading-2)
    - [创建微应用容器](https://juejin.im/post/6844904158085021704#heading-3)
    - [注册微应用](https://juejin.im/post/6844904158085021704#heading-4)
    - [启动主应用](https://juejin.im/post/6844904158085021704#heading-5)
- [接入微应用](https://juejin.im/post/6844904158085021704#heading-6)
- [接入 Vue 微应用](https://juejin.im/post/6844904158085021704#heading-7)
    - [注册微应用](https://juejin.im/post/6844904158085021704#heading-8)
    - [配置微应用](https://juejin.im/post/6844904158085021704#heading-9)
- [接入 React 微应用](https://juejin.im/post/6844904158085021704#heading-10)
    - [注册微应用](https://juejin.im/post/6844904158085021704#heading-11)
    - [配置微应用](https://juejin.im/post/6844904158085021704#heading-12)
- [接入 Angular 微应用](https://juejin.im/post/6844904158085021704#heading-13)
    - [注册微应用](https://juejin.im/post/6844904158085021704#heading-14)
    - [配置微应用](https://juejin.im/post/6844904158085021704#heading-15)
- [接入 Jquery、xxx... 微应用](https://juejin.im/post/6844904158085021704#heading-16)
    - [注册微应用](https://juejin.im/post/6844904158085021704#heading-17)
    - [配置微应用](https://juejin.im/post/6844904158085021704#heading-18)
    - [扩展阅读](https://juejin.im/post/6844904158085021704#heading-19)
- [小结](https://juejin.im/post/6844904158085021704#heading-20)
- [最后一件事](https://juejin.im/post/6844904158085021704#heading-21)
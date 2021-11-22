Vue3.x 从零开始（一）—— Vue-cli or Vite 构建 TypeScript 项目 - Wise.Wrong - 博客园

vue3.0从零开始
* * *

#   [Vue3.x 从零开始（一）—— Vue-cli or Vite 构建 TypeScript 项目](https://www.cnblogs.com/wisewrong/p/13717287.html)

千呼万唤始出来，2020 年 9 月 19 日凌晨，Vuejs 3.0 终于发布了，代号：[One Piece](https://github.com/vuejs/vue-next/releases/tag/v3.0.0)

作为一名从 Vue 1.x 就开始接触 Vue 的老玩家，心里只有一句话想说：学不动了...
但学不动也得学...

原本打算写一写 2.x 和 3.x 的差异，但仔细捋了一下发现内容还不少，干脆抛弃原本的思维，从零开始学 Vue

所以《Vue 3.x 从零开始》系列可能比较啰嗦。对于 Vue 2.x 的用户，直接阅读官方的[迁移指南](https://v3.vuejs.org/guide/migration/introduction.html#quickstart)是最好的选择

当然，如果有兴趣和我一起从零开始，也是一个不错的选择

在开始之前，请确保已经正确安装了 [node.js](http://nodejs.cn/)

**一、Vue CLI 构建项目**
为了快速构建 Vue 项目，Vue 团队开发了脚手架工具 [Vue CLI](https://cli.vuejs.org/)，这个脚手架需要全局安装
yarn global add @vue/cli# ORnpm install -g @vue/cli
**对于 Vue 3.x 的项目，需要使用 Vue CLI v4.5 以上的版本。**如果你的 Vue CLI 版本较低，也需要用上面的命令升级
安装完成后可以在命令行输入  vue -V  （注意第二个 V 大写），如果出现版本号则安装成功
![1059788-20200923145300179-699341871.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106124721.png)
然后在需要创建项目的文件夹下启动终端，在命令行输入下面的命令
vue ui
这个命令会在浏览器打开一个页面(http://localhost:8000/project/select)
这是 Vue CLI 提供的可视化工具，可以通过页面上的【创建】标签创建项目

除了这种可视化的方式之外，还可以完全通过命令行创建项目：
vue create my-vue3-demo

# my-vue3-demo 是项目目录的名称

运行命令之后，通过【↑】【↓】键选择条目
![1059788-20200923150223545-1879818749.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106124747.png)
这里可以直接选择 Vue 3 然后回车，Vue CLI 就会帮我们完成后续的创建工作
// 也可以选择第三项 “Manually select features”，会有更多的自定义配置，这里暂不介绍

**二、项目结构**
项目创建之后，会在当前目录下多出一个项目文件夹
通过命令行创建的默认 Vue 3 项目是一个比较纯粹的项目
![1059788-20200923152902236-231041888.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106124755.png)
从它的** package.json **中可以看到只有 vue.js 的核心依赖
然后启动项目试试，在项目根目录运行终端，在命令行输入
npm run serve
在浏览器中打开链接 **http://localhost:8080/**，就能看到项目的启动页
![1059788-20200923160233683-1921901133.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106124804.png)
项目默认使用的端口是 8080，如果想使用别的端口，可以在**项目的根目录**创建一个 **vue.config.js**
[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)
// vue.config.jsmodule.exports = {

outputDir: 'dist', // 打包的目录 lintOnSave: true, // 在保存时校验格式 productionSourceMap: false, // 生产环境是否生成 SourceMap devServer: {

open: true, // 启动服务后是否打开浏览器 overlay: { // 错误信息展示到页面 warnings: true,
errors: true },
host: '0.0.0.0',
port: 8066, // 服务端口 https: false,

hotOnly: false, // proxy: { // 设置代理 // '/api': { // target: host, // changeOrigin: true, // pathRewrite: { // '/api': '/', // } // }, // }, },

}
[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)

这个文件中的** devServer.port**  即启动本地服务的端口（更多配置可以参考[官方文档](https://cli.vuejs.org/zh/config/)）

* * *

项目中有一个 public 文件夹，可以存放一些不需要经过 webpack 打包的文件（[参考链接](https://cli.vuejs.org/zh/guide/html-and-static-assets.html#public-%E6%96%87%E4%BB%B6%E5%A4%B9)）

这个目录下有一个 index.html 文件，这是整个应用的 html 基础模板，也是打包编译后的项目入口
这个 index.html 文件中有一个** #app** 节点：
![1059788-20200923192649809-1159646399.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106124842.png)
Vue 的实例会挂载到这个节点

* * *

项目的代码在 src 目录下：
![1059788-20200923191847968-1868741333.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106124902.png)
现在的 src 目录非常简洁，其中 **main.js** 是 webpack 打包的入口文件
![1059788-20200923192027670-961205145.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106124926.png)
main.js 只是引入了 App.vue 组件，并挂载到上面提到的 #app 节点下
这里的 **createApp** 方法是 Vue 3 新增的全局 API，用来创建一个 Vue 应用，并挂载到某个 DOM 节点
在 2.x 的时代，上面的代码是这样写的：// 以下内容为 2.x 的对比，不感兴趣的话可以直接跳到下一节
![1059788-20200923195302784-1928595134.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106124952.png)
从表面上看，createApp 只是改良版的 render 函数，但其实他解决了 2.x 中的一些不太优雅用法
2.x 时代的 Vue 没有“应用”的概念，所谓的应用只是一个 Vue 的根实例  new Vue()
当我们需要修改一些全局属性的时候，只能通过 Vue 对象本身来修改，比如：
// 2.x 时代的全局属性Vue.prototype.$http = axios;
Vue.directive('focus', {
inserted: el => el.focus()
});
Vue.config.errorHandler = errorHandler;
这样的行为会污染 Vue 对象，导致从同一个 Vue 创建的实例会共享相同的全局配置
而通过 createApp 返回的是独立的实例，修改该实例的属性不会影响其他 createApp 创建的实例：
[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)
// 3.x createAppconst foo = createApp(Foo);
foo.directive('focus'  /* ... */);const bar = createApp(Bar);
bar.directive('focus'  /* ... */);// foo 和 bar 都具备了 focus 指令，但这两个指令的内容相互独立
[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)
如果确实需要两个应用共享配置，还可以通过 createApp 创建一个工厂函数：
[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)
const createMyApp = options => { const app = createApp(options)
app.directive('focus'  /* ... */) return app

}const foo = createMyApp(Foo).mount('#foo')const bar = createMyApp(Bar).mount('#bar')// foo 和 bar 会具备同一个 focus 指令

[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)

**三、使用 Vite 构建项目**

除了上面的 Vue CLI 创建项目之外，Vue 3.x 还可以通过新工具 [Vite](https://github.com/vitejs/vite) 创建项目

Vite 是一个由原生 ES 模块驱动的 Web 开发构建工具，支持模块热更新和按需加载
用尤大的话来讲，用了 Vite 之后就可以告别 webpack 了

![1059788-20200924101637887-2041166759.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125112.png)

先来用 Vite 创建一个项目吧：
npm init vite-app <project-name># 将 <project-name> 改为自己的项目名
![1059788-20200924104356055-194762414.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125121.png)
项目结构也非常简洁，在 package.json 中只引入了 vue.js
然后安装依赖，并启动项目：
npm install
npm run dev
项目地址为 **http://localhost:3000/**，如果页面没有自动打开，可以手动打开链接查看
如果需要对 Vite 进行配置，也需要在根目录创建一个 config 文件，命名为 **vite.config.js**（或者 vite.config.ts）
[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)
// vite.config.jsmodule.exports = {

port: 8077, // 服务端口 proxy: { // 代理 // string shorthand  "/foo": "http://localhost:4567/foo", // with options  "/api": {

target: "http://jsonplaceholder.typicode.com",
changeOrigin: true,
rewrite: (path) => path.replace(/^\/api/, ""),
},
},
};
[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)

更多配置可以参考源码中的**  [config.ts](https://github.com/vitejs/vite/blob/master/src/node/config.ts)**。不过大部分的配置项和上面提到的 vue.config.js 是一样的

目前（2020-09-24）Vite 还处于 beta 阶段，用 Vite 创建项目的方式可以了解，但不建议用到项目中

如果想学习更多关于 Vite 的知识，可以查看 [@yuuang](https://github.com/zhangyuang) 写的[《Vite 源码分析》](https://vite-design.surge.sh/guide/getting-start.html)

**四、TypeScript**
Vue 3 有一个重要的特性就是更好的支持 TypeScirpt

在使用 Vue CLI 创建项目的时候，可以选择** "Manually select features"**  选项，然后选择** "TypeScript"**，这样就能直接创建 ts 项目

如果一开始没有创建 ts 项目，但电脑上装有 Vue CLI，可以通过下面的命令将项目改造为 ts 项目：
vue add typescript
不过我们也可以自己动手，一步一步的引入 TypeScript，看看 **vue add typescript**  到底做了什么
首先安装 typescript 依赖：
npm install typescript -D
然后在项目根目录创建** tsconfig.json**  文件：
[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)
{ "include": [ "src/**/*.ts", "src/**/*.tsx", "src/**/*.vue",

], "exclude": [ "node_modules" ], "compilerOptions": { // 与 Vue 的浏览器支持保持一致  "target": "es5", // 如果使用 webpack 2+ 或 rollup，可以利用 tree-shake:  "module": "es2015", // 这可以对 `this` 上的数据 property 进行更严格的推断  "strict": true, "moduleResolution": "node" }

}
[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)

然后把 src 目录下的** main.js 文件名改为 main.ts**，以及其他 js 文件改为 ts 后缀（config.js => config.ts）

并编写 .d.ts 文件 **shims-vue.d.ts** 放到 src 目录下，和 main.ts 平级
[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)
/* shims-vue.d.ts */declare module '*.vue' {

import { defineComponent } from  'vue'; const component: ReturnType<typeof defineComponent>;

export default component;
}
[![copycode.gif](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)
![1059788-20200924151224901-1932402468.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125139.png)

由于 Vue 3 是使用 TypeScript 编写的，所以只要在 <script> 标签上声明 **lang="ts"**，就能直接在 .vue 文件中使用 ts 语法

为了让 TypeScript 能够正确推断 Vue 组件中的类型，还需要使用全局方法 **defineComponent** 来定义组件
![1059788-20200924150304940-1656143287.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125156.png)
Vue 有一些特性和 TypeScript 并不能完美契合 (如 computed 的返回类型)

为了更好的使用 ts，建议提前阅读[《TypeScript 支持》](https://v3.vuejs.org/guide/typescript-support.html#typescript-support)

到这里项目内部的改造基本完成，接下来**只要将入口文件从 main.js 改为 main.ts**  即可

**如果是 Vite 创建的项目**，直接修改根目录下的 index.html 文件，将 <script> 标签的 src 地址改为 "/src/main.ts"

**如果是 Vue CLI 创建的普通项目**，只需要安装 @vue/cli-plugin-typescrip
npm install @vue/cli-plugin-typescript -D
搞定~ 接下来就可以启动项目开始愉悦的编码了~

分类: [Vue](https://www.cnblogs.com/wisewrong/category/933810.html)

标签: [vue-cli](https://www.cnblogs.com/wisewrong/tag/vue-cli/), [vue](https://www.cnblogs.com/wisewrong/tag/vue/), [TypeScript](https://www.cnblogs.com/wisewrong/tag/TypeScript/), [vite](https://www.cnblogs.com/wisewrong/tag/vite/)

 [好文要顶](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)  [关注我](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)  [收藏该文](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)  [![icon_weibo_24.png](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)  [![wechat.png](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)

 [![20170925120030.png](../_resources/35ee2ef2ae71db106ffd2bda2c27768d.jpg)](https://home.cnblogs.com/u/wisewrong/)

 [Wise.Wrong](https://home.cnblogs.com/u/wisewrong/)
 [关注 - 8](https://home.cnblogs.com/u/wisewrong/followees/)
 [粉丝 - 1059](https://home.cnblogs.com/u/wisewrong/followers/)

 [+加关注](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)

 2

 0

 [«](https://www.cnblogs.com/wisewrong/p/13719007.html) 上一篇： [深度删除对象/数组中的空字段](https://www.cnblogs.com/wisewrong/p/13719007.html)

 [»](https://www.cnblogs.com/wisewrong/p/13744013.html) 下一篇： [Vue3.x 从零开始（二）—— 重新认识 Vue 组件](https://www.cnblogs.com/wisewrong/p/13744013.html)

posted @ 2020-09-24 15:35 [Wise.Wrong](https://www.cnblogs.com/wisewrong/)  阅读(1485)  评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=13717287) [收藏](Vue3.x%20从零开始（一）——%20Vue-cli%20or%20Vite%20构建%20TypeScript%20项目%20.md#)
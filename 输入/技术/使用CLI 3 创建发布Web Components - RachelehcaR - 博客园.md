使用CLI 3 创建发布Web Components - RachelehcaR - 博客园

#   [使用CLI 3 创建发布Web Components](https://www.cnblogs.com/Adiodanza/p/9641708.html)

本文翻译自：[codementor](https://www.codementor.io/vuejsdevelopers/create-publish-web-components-with-vue-cli-3-jqkyamofd)[(L)](https://www.codementor.io/vuejsdevelopers/create-publish-web-components-with-vue-cli-3-jqkyamofd)

翻译不当之处，欢迎指正交流
![1488787-20180913173020471-237599500.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102120126.png)

Web Components是web平台的未来吗？关于这一问题支持和反对的观点有很多。事实上浏览器对Web Components的支持正在逐渐形成，并有越来越多的工具、资源和IT从业人员正在致力于创建发布自己的Web Components。

*Vue.js是一个创建Web Components的很好的工具，在更新的Vue CLI 3和[@vue/web-component-wrapper](https://github.com/vuejs/vue-web-component-wrapper)中甚至更加简单。

这篇文章中，我们会讨论为什么你需要创建一个Web Components并向你展示如何在仅有Vue基础知识的情况下创建你的第一个Web Components。

Note: this article was originally posted *[here on the Vue.js Developers blog ](https://vuejsdevelopers.com/2018/05/21/vue-js-web-component/?jsdojo_id=cm_vwc)*on 2018/05/21 [本文章原创发布地址] *

- **什么是Web Components**

相信你已经对HTML元素（div，spans，tables等）很熟悉了，Web Components是一种定制的，可以在web app和web页面中使用并复用的HTML元素。

例如，你可以创建一个定制的element叫做 video-player ，并且

可以提供一个可重用的video接口, 它的 UI 功能超出了标准 HTML 5 视频元素的可用范围。这个元素能够为video文件和事件（如：播放play，暂停pause等）提供一个“src”属性，允许用户以编程方式来控制它。

<div><video-player src="..." onpause="..."></video-player></div>

这听起来或许很像常规的Vue components做的，不同之处就在于web components是浏览器原生的（或者说至少会随着规范来逐步实现）并能够像HTML元素一样来用。无论如何，不管你用什么工具去创建你的web components你都可以在react，angular等框架中（甚至不需要使用框架）来使用它。

[![copycode.gif](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)
function ReactComponent() {

return( <h1>A Vue.js web component used in React! </h1>  <video-player></video-player> );

}
[![copycode.gif](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)

- **如何创建一个web component?**

在内部，web components由浏览器早已熟悉的标准HTML元素构成，如divs，spans等。所以video-player在内部看起来更像这样:
[![copycode.gif](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)

<div>  <video src="..."></video>  <div class="buttons">  <button class="play-button"></button>  <button class="pause-button"></button> ... </div> ...</div>

[![copycode.gif](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)

Web components也可以包含CSS和Javascript。使用新的浏览器标准像Shadow DOM这种，通过你自己定制的组件完全封装，因此用户不需要担心CSS会覆盖web component中的规则。

当然，您将用API声明自带的web 组件。但我们目前不需要知道，因为我们将使用的的是一个抽象层

*更多深入介绍 [Web Components - Introduction](https://www.webcomponents.org/introduction)*

- **使用@vue/web-component-wrapper创建web components**

通过Vue CLI3和新的[@vue/web-component-wrapper](https://github.com/vuejs/vue-web-component-wrapper)库创建web components十分方便。

@vue/web-component-wrapper库提供了一个通过web componentAPI接入Vue组件的容器。这个容器能够自动代理properties，attributes，events和slot。这意味着你可以仅用你现有的Vue components知识写一个web components！

关于创建webcomponents另一个vue库[vue-custom-element](https://github.com/karol-f/vue-custom-element)

创建一个webcomponent，先确保已安装Vue CLI3并通过任何你熟悉的环境创建一个新的项目。
$ vue create vue-web-component-project

现在创建一个新的可以作为web component来使用的Vue component.这个组件在发布前可以通过webpack来编辑，所以你可以使用任何JavaScript的特性。但这里我们只是做一些简单的雏形来进行可行性的概念验证：

***src/components/VueWebComponent.vue***
[![copycode.gif](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)

<template>  <div>  <h1>My Vue Web Component</h1>  <div>{{ msg }}</div>  </div></template><script> export default {

props: ['msg'] }</script>
[![copycode.gif](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)
通过@vue/web-component-wrapper来准备一个包裹的组件以确保你的入口文件，正如： ***src/main.js***
[![copycode.gif](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)

**import** Vue **from**  'vue';**import** wrap **from**  '@vue/web-component-wrapper';**import** VueWebComponent **from** './components/VueWebComponent';**const** CustomElement = wrap(Vue, VueWebComponent);window.customElements.define('my-custom-element', CustomElement);

[![copycode.gif](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)
用来注册一个组建的APIcustomElements.define()注意custom element和web component在这方面是一样的

- **用Vue CLI3构建一个web component**

Vue CLI3包括了许多不错的新特性（查看[这篇文章](https://vuejsdevelopers.com/2018/03/26/vue-cli-3/)的摘要）。CLI Service使用的是Webpack来处理多项任务包括构建你自己的项目代码。这一点可以通过简单的vue-cli-service build指令来完成。通过添加

--target wc来转换，你可以创建一个依赖，完美地创建一个web component:
$ vue-cli-service build --target wc --name my-custom-element ./src/main.js

在幕后,使用webpack来处理单独的javascript文件和所有必须的内置web components。当被包含在一个页面内时，<my-custom-element> 这个脚本注册了一个用@vue/web-component-wrapper包裹着目标的Vue组件

- **在网页中使用你的Vue web component**

随着你的组建的构建, 任何人都可以在一个非Vue项目中使用它使用并不需要任何Vue.js的代码(即便你为了避免重复刻意不添加绑定而需要导入Vue库 作为在这种情况下，where你使用多个基于Vue的web components)一旦你加载定义在页面上的脚本时，定制的元素就起到了原生HTML元素的作用。

请注意, 包含polyfill（填充代码）是非常必要的, 因为大多数浏览器本身并不支持所有web component规范。在这里，我使用[webcomponents.js (v1 spec polyfills)](https://github.com/WebComponents/webcomponentsjs)

**index.html**
[![copycode.gif](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)

<!DOCTYPE html><html>  <head>  <meta charset="utf-8">  <meta http-equiv="X-UA-Compatible" content="IE=edge">  <meta name="viewport" content="width=device-width,initial-scale=1.0">  <title>My Non-Vue App</title>  </head>  <body>  <!--Load Vue-->  <script src="https://unpkg.com/vue"></script>  <!--Load the web component polyfill-->  <script src="https://cdnjs.cloudflare.com/ajax/libs/webcomponentsjs/1.2.0/webcomponents-loader.js"></script>  <!--Load your custom element-->  <script src="./my-custom-element.js"></script>  <!--Use your custom element-->  <my-custom-element msg="Hello..."></my-custom-element>  </body></html>

[![copycode.gif](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)

这段代码是有效的，如果你想把这段代码作为模板来引用的话，我把它们放到了[这里](https://github.com/anthonygore/vue-web-component)

- **发布**

最后，如果你想和所有人分享你的web component，没有比[webcomponents.org](https://www.webcomponents.org/)更好的地方了。这个网站有一个供免费下载web component的可浏览收藏夹，所展示的是由Vue,Polymer,Abgular等各种框架构建的组件。

扩展阅读

•	Docs for[ @vue/web-component-wrapper](https://github.com/vuejs/vue-web-component-wrapper)

•	Docs for [Vue CLI 3 Build Targets](https://github.com/vuejs/vue-cli/blob/dev/docs/build-targets.md#web-component)

• [Web Components - Introduction](https://www.webcomponents.org/introduction)

Get the latest Vue.js articles, tutorials and cool projects in your inbox with the *[Vue.js Developers Newsletter](https://vuejsdevelopers.com/newsletter/?jsdojo_id=cm_vwc)*

标签: [web](https://www.cnblogs.com/Adiodanza/tag/web/), [component](https://www.cnblogs.com/Adiodanza/tag/component/), [Vue](https://www.cnblogs.com/Adiodanza/tag/Vue/)

 [好文要顶](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)  [关注我](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)  [收藏该文](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)  [![icon_weibo_24.png](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)  [![wechat.png](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)

 [![20180914100036.png](../_resources/7eee82bbfd7cb7adf7fe4d452c08f9cc.jpg)](https://home.cnblogs.com/u/Adiodanza/)

 [RachelehcaR](https://home.cnblogs.com/u/Adiodanza/)
 [关注 - 0](https://home.cnblogs.com/u/Adiodanza/followees/)
 [粉丝 - 0](https://home.cnblogs.com/u/Adiodanza/followers/)

 [+加关注](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)

 0

 0

posted @ 2018-09-13 17:28 [RachelehcaR](https://www.cnblogs.com/Adiodanza/)  阅读(3450)  评论(2) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=9641708) [收藏](使用CLI%203%20创建发布Web%20Components%20-%20RachelehcaR%20-%20博客园.md#)
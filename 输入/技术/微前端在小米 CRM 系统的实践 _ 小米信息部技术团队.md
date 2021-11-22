微前端在小米 CRM 系统的实践 | 小米信息部技术团队

 ![](../_resources/d65539f31a51945b2bee4f650a1cbea7.png)

## 微前端在小米 CRM 系统的实践

2020-04-14

 [(L)](微前端在小米%20CRM%20系统的实践%20_%20小米信息部技术团队.md#)

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c0fa91bf1abf41b0c9f6432546a1599c.png)
**[作者简介]** 李帅帅，信息技术部平台部前端组，目前主要负责中台业务前端架构及小程序开发。
**[文章原地址]**  https://www.lishuaishuai.com/architecture/1344.html

## [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#%E4%B8%80%E3%80%81%E5%89%8D%E8%A8%80)一、前言

大型组织的组织结构、软件架构在不断地发生变化。移动优先（Mobile First）、App 中台（One App）、中台战略等，各种口号在不断的提出、修改和演进。同时，业务也在不断地发展，导致应用不断膨胀，进一步映射到软件架构上。

现有 Web 应用（SPA）不能很好的拓展和部署，随着时间的推移，各个项目变得越来越臃肿，web 应用变得越来越难以维护。

微前端是一种类似于微服务的架构，它将微服务的理念应用于浏览器端，即将 Web 应用由单一的单体应用转变为**多个小型前端应用聚合为一的应用**。各个前端应用还可以**独立运行、独立开发、独立部署**。

> Techniques, strategies and recipes for building a modern web app with multiple teams that can ship features independently. — Micro Frontends

关键词：解耦、聚合、技术栈无关、独立运行、独立开发、独立部署、易拓展

## [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#%E4%BA%8C%E3%80%81%E5%AE%9E%E6%96%BD%E5%BE%AE%E5%89%8D%E7%AB%AF%E7%9A%84%E5%85%AD%E7%A7%8D%E6%96%B9%E5%BC%8F)二、实施微前端的六种方式

《前端架构从入门到微前端》一书中，将微前端的实施分为六种：

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#2-1-%E8%B7%AF%E7%94%B1%E5%88%86%E5%8F%91)2.1 路由分发

路由分发式微前端，即通过路由将不同的业务分发到不同的、独立前端应用上。其通常可以通过 HTTP 服务器的反向代理来实现，又或者是应用框架自带的路由来解决。如图：

![2020-03-30_19-08-06.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/ce41c4b8d087447515718ebbb7d09e98.png)

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#2-2-%E5%89%8D%E7%AB%AF%E5%BE%AE%E6%9C%8D%E5%8A%A1%E5%8C%96)2.2 前端微服务化

前端微服务化，是微服务架构在前端的实施，每个前端应用都是完全独立（技术栈、开发、部署、构建独立）、自主运行的，最后通过模块化的方式组合出完成的应用。
采用这种方式意味着，一个页面上可以同时存在两个以上的前端应用在运行。如图：
![2020-03-30_19-31-27.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/6fd6b83aa663050e3af851a67c33e1d0.png)

目前主流的框架有 [Single-SPA](https://single-spa.js.org/)、[qiankun](https://qiankun.umijs.org/)、[Mooa](https://github.com/phodal/mooa)，后两者都是基于 `Single-SPA` 的封装。

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#2-3-%E5%BE%AE%E5%BA%94%E7%94%A8)2.3 微应用

微应用化是指在开发时应用都是以单一、微小应用的形式存在的，而在运行时，则是通过构建系统合并这些应用，并组合成一个新的应用。
微应用化大都是以软件工程的方式来完成前端应用的聚合，因此又可以称之为**组合式集成**。
微应用化只能使用唯一的一种前端框架。
如图：
![2020-03-30_21-01-15.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/feb592df9720592f052e2670941f41ef.png)

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#2-4-%E5%BE%AE%E4%BB%B6%E5%8C%96)2.4 微件化

微件化（Widget）是一段可以直接嵌入应用上运行的代码，它由开发人员预先编译好，在加载时不需要再做任何修改或编译。微前端下的微件化是指，每个业务团第编写自己的业务代码，并将编译好的代码部署到指定的服务器上，运行时只需要加载指定的代码即可。

如图：
![2020-03-30_21-56-36.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/eedb4341fee8625fa4684fea68093307.png)

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#2-5-iframe)2.5 iframe

iFrame 作为一个非常古老的，人人都觉得普通的技术，却一直很管用。
> HTML 内联框架元素 `<iframe>`>  表示嵌套的正在浏览的上下文，能有效地将另一个 HTML 页面嵌入到当前页面中。
iframe 可以创建一个全新的独立的宿主环境，这意味着我们的前端应用之间可以相互独立运行。采用 iframe 有几个重要的前提：

- 网站不需要 SEO 支持
- 拥有相应的应用管理机制。

在很多业务场景下，难免会遇到一些难以解决的问题，那么可以引入 iframe 来解决。

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#2-6-Web-Components)2.6 Web Components

Web Components 是一套不同的技术，允许开发者创建可重用的定制元素（它们的功能封装在代码之外）并且在您 Web 应用中使用它们。

在真正的项目上使用 Web Components 技术，离现在还有一些距离，结合 Web Components 来构建前端应用，是一种面向未来演进的架构。或者说在未来可以采用这种方式来构建应用。

如图：
![2020-03-30_22-36-43.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/b5cb4ba1c385297734770e156cca9f6f.png)
在真实的业务场景中，往往是上面提到六种方式中的几种的结合使用，或者是某种方式的变种。下面看我遇到的真实场景。

## [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#%E4%B8%89%E3%80%81%E7%9C%9F%E5%AE%9E%E7%9A%84%E4%B8%9A%E5%8A%A1%E5%9C%BA%E6%99%AF)三、真实的业务场景

现有三个内部系统，下面称之为 old-a、old-b 和 C，其中，old-a 和 old-b 是老旧的前后端未分离项目，C 为前后端分离的 SPA 应用（React + HIUI），三个系统的架构图大致如下：

![2020-03-31_09-24-28.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/f564c1cac1c69ddf84753b826ae617fc.png)
可以看到，old-a 运行在一台服务器 1 上，old-b 运行在服务器 2 上，C 系统的前端资源在服务器 2 上，并且 C 没有自己的域名。
三个系统均在后端同学维护和开发，他们的需求如下：

- 统一的域名
- 统一的界面和交互
- 系统需要方便拓展
- 不希望开发阶段每个系统有独立的代码仓库
- CI 构建

## [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#%E5%9B%9B%E3%80%81%E6%80%8E%E4%B9%88%E6%94%B9%E9%80%A0%EF%BC%9F)四、怎么改造？

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#4-1-%E5%85%B3%E9%94%AE%E7%82%B9)4.1 关键点

考虑开发同学的需求和开发成本、维护成本、未来的可拓展性，系统改造关键点如下：
1. 申请统一的域名（暂且称之为 crm.mi.com）
2. 将 old-a 和 old-b 两个老旧的系统样式调整，像系统 C 靠拢
3. 三个系统使用统一的菜单和权限
4. 三个系统使用统一的 SSO
5. C 系统和正在开发的 X 个系统使用 CI 解决打包和手动 copy 的问题

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#4-2-%E5%BE%AE%E5%89%8D%E7%AB%AF%E5%87%A0%E7%A7%8D%E6%96%B9%E5%BC%8F%E5%AF%B9%E6%AF%94)4.2 微前端几种方式对比

总体的改造方案使用微前端的思想进行。对上面提到的六种方式进行对比：
![2020-03-31_10-01-48.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/6f3ece93a034d92ea0c0fc4a7c63d5d9.png)

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#4-3-%E5%AE%9E%E6%96%BD)4.3 实施

对于上面几种方式，在具体的实施使用了路由分发、iFrame、应用微服务化、微应用化的融合方式。或者说是某种方案的变种，因为改造之后同时具备了这几种方案的特点。
对于 C 系统和正在开发的 x 个系统使用 single-spa 做改造，对于老旧的系统 old-a 和 old-b 使用 iframe 接入。
改造后如下图：
![2020-03-31_10-24-53.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/8cdc56064e9c16e90ac43dc66d642060.png)

此时，两个老系统分别部署在各自的服务器，C 和未来的多个应用部署在同一台服务器。然后，在 Nginx 层 为老系统分配了两个路由（暂且称之为 old-a 和 old-b），分别将请求打到各自的服务器，根路由打到 C 和 xx 应用的服务器。

使用 React 框架的 C 和 xx 应用基于 single-spa 改造后，那么老系统 iframe 如何接入？
在配置菜单时，老系统路由会被带上标识，统一交给其中一个应用以 iframe 的方式处理。
如图：
![2020-03-31_11-01-55.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c9215354327af84e581c1b7f26efe74d.png)
改造后微前端架构图：
![2020-03-31_14-51-36.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/4741f60cbe65b6d578d10abb5b0dc407.png)

## [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#%E4%BA%94%E3%80%81%E4%B8%80%E4%BA%9B%E9%97%AE%E9%A2%98)五、一些问题

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#5-1-%E5%AD%90%E5%BA%94%E7%94%A8%E6%B3%A8%E5%86%8C%E6%96%B9%E5%BC%8F)5.1 子应用注册方式

官方示例：
[object Object]
[object Object]
JAVASCRIPT
当增加一个应用的时候，就需要对 `single-spa-config.js` 文件进行修改。
通过可配置的方式实现子应用注册：
[object Object]
[object Object]
JAVASCRIPT
[object Object]
[object Object]
JSON

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#5-2-%E5%85%B1%E4%BA%AB-cookie)5.2 共享 cookie

将域名统一的一大好处是 iframe 域名和主应用域名同源。没有了跨域 可以在 `layout` 统一 SSO 登录，通过 cookie 共享让其他模块拿到登录信息。

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#5-3-%E5%BA%94%E7%94%A8%E4%B9%8B%E9%97%B4%E6%95%B0%E6%8D%AE%E5%85%B1%E4%BA%AB%E5%8F%8A%E9%80%9A%E4%BF%A1)5.3 应用之间数据共享及通信

由于此次改造，应用之间不涉及数据共享，所以没有顶级 store 的概念。模块之间的简单通信 可以通过 `postMessage` 或基于浏览器原生事件做通信。
[object Object]
[object Object]
JAVASCRIPT

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#5-4-css-%E9%9A%94%E7%A6%BB)5.4 css 隔离

样式的隔离有很多种处理方式，如：BEM、CSS Module、css 前缀、动态加载/卸载样式表、Web Components 自带隔离机制等。

此次采用添加 css 前缀来隔离样式，比如 postcss 插件：`postcss-plugin-namespace`。但是这个插件并不满足需求，我们的应用分布在 `src/`下，并以 `name.app` 的方式命名，需要给不同的应用添加不同的前缀。因此使用自己定制的插件：

[object Object]
[object Object]
JAVASCRIPT

### [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#5-5-js-%E6%B2%99%E7%AE%B1)5.5 js 沙箱

有一个可严重可不严重的问题，如何确保子应用之间的全局变量不会互相干扰，实现 js 的隔离。普遍的做法是给全局变量添加前缀，这种方式类似 css 的 BEM，通过约定的方式来避免冲突。这种方式简单，但不是很靠谱。

qiankun 内部的实现方式是通过 `Proxy` 来实现的沙箱模式，即在应用的 `bootstrap` 及 `mount` 两个生命周期开始之前分别给全局状态打下快照，然后当应用切出/卸载时，将状态回滚至 `bootstrap` 开始之前的阶段，确保应用对全局状态的污染全部清零。有兴趣的同学可以看源码。

## [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#%E5%85%AD%E3%80%81%E4%BC%98%E5%8C%96%E4%BD%93%E9%AA%8C-PWA)六、优化体验 PWA

1. 创建桌面图标，快速访问
2. Service Worker 缓存，对大文件和不经常更改的文件缓存，优化加载。

## [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#%E4%B8%83%E3%80%81-%E8%BF%98%E5%8F%AF%E4%BB%A5%E5%81%9A%E4%BB%80%E4%B9%88%EF%BC%9F)七、 还可以做什么？

上面的改造已经基本满足了业务需求，针对此业务还有更进一步的做法，达到更好的体验：

- 可以使用 [lerna](https://github.com/lerna/lerna) 统一管理所有项目，方便维护，或者让每个应用拥有独立的仓库，做到独立开发。
- 可以使用 [SystemJS](https://github.com/systemjs/systemjs) 实现应用的动态加载、独立部署。

## [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#%E5%85%AB%E3%80%81%E6%80%BB%E7%BB%93)八、总结

上面提到，此次的实践方式是微前端实现方式中几种的结合，或者是某种方式的变种。也许在理论上并不是最优的，但是在具体的问题中要是最优解。架构设计必须要与当前要解决的问题相匹配，**“没有最优的架构，只有最合适的架构”**。

微前端不是一个框架或者工具，而是一套架构体系。

这套体系除了**微前端的基础设施**外还需要具备**微前端配置中心**（版本管理、发布策略、动态构建、中心化管理）、**微前端观察工具**（应用状态可见、可控）等。

整个体系的搭建将是一个庞大的工程，目前大部分团队是在使用微前端的模式和思想来解决现有系统中的痛点。

## [(L)](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/#%E4%B9%9D%E3%80%81%E6%8E%A8%E8%8D%90%E9%98%85%E8%AF%BB)九、推荐阅读

[前端微服务化解决方案](https://alili.tech/archive/ea599f7c/)
[可能是你见过最完善的微前端解决方案](https://zhuanlan.zhihu.com/p/78362028)
[微前端的那些事儿](https://microfrontends.cn/)
[Micro Frontends](https://micro-frontends.org/)
https://single-spa.js.org/

* * *

**作者**
李帅帅，小米信息技术部平台部前端组
**招聘**

小米信息部武汉研发中心，信息部是小米公司整体系统规划建设的核心部门，支撑公司国内外的线上线下销售服务体系、供应链体系、ERP 体系、内网 OA 体系、数据决策体系等精细化管控的执行落地工作，服务小米内部所有的业务部门以及 40 家生态链公司。

同时部门承担大数据基础平台研发和微服务体系建设落，语言涉及 Java、Go，长年虚位以待对大数据处理、大型电商后端系统、微服务落地有深入理解和实践的各路英雄。
**欢迎投递简历：jin.zhang(a)xiaomi.com**
更多技术文章：[小米信息部技术团队](https://xiaomi-info.github.io/)

 Tags:  [架构设计](https://xiaomi-info.github.io/tags#%E6%9E%B6%E6%9E%84%E8%AE%BE%E8%AE%A1)  [微前端](https://xiaomi-info.github.io/tags#%E5%BE%AE%E5%89%8D%E7%AB%AF)

 [← 设计模式基础之——模板模式业务实战](https://xiaomi-info.github.io/2020/03/27/oo-use-template/)  [统计建模初探 —— Analysis of Correlation →](https://xiaomi-info.github.io/2020/05/24/analysis-of-correlation/)

 ![](../_resources/6f383071627d6c5a1e68e09644e371bd.png)
扫描二维码，分享此文章

 ![](data:image/svg+xml,%3csvg class='gitment-heart-icon js-evernote-checked' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 50 50' data-evernote-id='577'%3e%3cpath d='M25 39.7l-.6-.5C11.5 28.7 8 25 8 19c0-5 4-9 9-9 4.1 0 6.4 2.3 8 4.1 1.6-1.8 3.9-4.1 8-4.1 5 0 9 4 9 9 0 6-3.5 9.7-16.4 20.2l-.6.5zM17 12c-3.9 0-7 3.1-7 7 0 5.1 3.2 8.5 15 18.1 11.8-9.6 15-13 15-18.1 0-3.9-3.1-7-7-7-3.5 0-5.4 2.1-6.9 3.8L25 17.1l-1.1-1.3C22.4 14.1 20.5 12 17 12z' data-evernote-id='578' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Like   [Issue Page](https://xiaomi-info.github.io/2020/04/14/fe-microfrontends-practice/undefined)

 [![](data:image/svg+xml,%3csvg class='gitment-github-icon js-evernote-checked' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 50 50' data-evernote-id='581'%3e%3cpath d='M25 10c-8.3 0-15 6.7-15 15 0 6.6 4.3 12.2 10.3 14.2.8.1 1-.3 1-.7v-2.6c-4.2.9-5.1-2-5.1-2-.7-1.7-1.7-2.2-1.7-2.2-1.4-.9.1-.9.1-.9 1.5.1 2.3 1.5 2.3 1.5 1.3 2.3 3.5 1.6 4.4 1.2.1-1 .5-1.6 1-2-3.3-.4-6.8-1.7-6.8-7.4 0-1.6.6-3 1.5-4-.2-.4-.7-1.9.1-4 0 0 1.3-.4 4.1 1.5 1.2-.3 2.5-.5 3.8-.5 1.3 0 2.6.2 3.8.5 2.9-1.9 4.1-1.5 4.1-1.5.8 2.1.3 3.6.1 4 1 1 1.5 2.4 1.5 4 0 5.8-3.5 7-6.8 7.4.5.5 1 1.4 1 2.8v4.1c0 .4.3.9 1 .7 6-2 10.2-7.6 10.2-14.2C40 16.7 33.3 10 25 10z' data-evernote-id='582' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/login/oauth/authorize?scope=public_repo&redirect_uri=https%3A%2F%2Fxiaomi-info.github.io%2F2020%2F04%2F14%2Ffe-microfrontends-practice%2F&client_id=c93dd7ac9d2e687ef016&client_secret=c5822d75521e6843d4ec30db61bd2ee861cb7c3e)

 [Login](https://github.com/login/oauth/authorize?scope=public_repo&redirect_uri=https%3A%2F%2Fxiaomi-info.github.io%2F2020%2F04%2F14%2Ffe-microfrontends-practice%2F&client_id=c93dd7ac9d2e687ef016&client_secret=c5822d75521e6843d4ec30db61bd2ee861cb7c3e) with GitHub

[object ProgressEvent]
Powered by [Gitment](https://github.com/imsun/gitment)

© 2020 | Proudly powered by [Hexo](https://hexo.io/)
Theme by [yanm1ng](https://github.com/yanm1ng)

本站总访问量38039次

本文总阅读量6794次
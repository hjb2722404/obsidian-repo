基于qiankun落地部署微前端爬”坑“记

[(L)](https://juejin.im/user/712139267910237)

[ 树酱   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzM0RDE5QiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYuMzMzIDRMMTcgM3YzaC0yek0xNSA2aDJ2NGgtMnpNMTcgOGgxdjJoLTF6TTE3IDNoMXYyaC0xek0xOCAzaDJ2OGgtMnoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/712139267910237)

2020年07月22日   阅读 8099

#  基于qiankun落地部署微前端爬”坑“记

[1](../_resources/20cdf608299af2313d4059cb93cf5669.webp)
> ❝

> 前沿：前半年微前端火得一踏糊涂，刚好业务需求上有这样的应用场景，针对目前的微前端解决方案做了技术选型，qiankun作为蚂蚁金服内部孵化出来的微前端解决方案，经过线上应用充分检验及打磨最后开源，最终选择qiankun作为我们云产品架构入口。不过官方文档上关于上线部署文档较少，很多童鞋也可能只是在本地玩玩，没有到真正走通整个闭环，于是结合自身，在将qiankun落地过程中遇到的“那些坑”做个梳理。希望对你有所帮助

> ❞

### 1. 茶前点心

> ❝

> 本文不大篇幅介绍关于qiankun的“前世今生”，更多的设计理念介绍请看> [> 文档](https://qiankun.umijs.org/zh/guide/#%E4%BB%80%E4%B9%88%E6%98%AF%E5%BE%AE%E5%89%8D%E7%AB%AF)> 如果有想了解其他微前端解决方案的童鞋，也可以回顾下之前树酱分享的> [> 微前端那些事](https://juejin.im/post/6844904112258023437)

> ❞

举个例子：我们有个这样的场景，我有个门户Portal的登陆界面(主应用基座)，登陆成果后可以切换不同的子应用，如下有两个子应用A和B，且都在之前是独立部署的，单独可以访问，但是我们现在想借助qiankun把他们“嵌”到基座来加载，往下看实操

[1](../_resources/0fbe168b7b35f27c88defab0c779122a.webp)

上面是一个通过域名访问子应用的示意图，接下来我们看看一个view视图，header头部和sideMenu左侧菜单是属于portal门户的，而右侧区域则是显示切换子应用的视图，预期效果：当我们访问`dev.portal.com/a`该域名时（即切换到子应用A），左侧菜单也会根据不同应用切换不同数据

[1](../_resources/04b958d813cbabbecf746326b4a50d24.webp)
你可能会问直接用iframe不香吗？真不香，主要几个局限问题

- 父子应用之间通信问题
- cookie共享问题（可做单点登陆SSO）
- 交互视图效果不佳

#### 1.1 注册子应用时应该注意哪些问题？

> ❝
>  啊明同学：qiankun是如何注册子应用的呢？
> ❞

qiankun是通过`registerMicroApps(apps, lifeCycles)`API来注册子应用的，详细文档请看[点我](https://qiankun.umijs.org/zh/api/#%E5%9F%BA%E4%BA%8E%E8%B7%AF%E7%94%B1%E9%85%8D%E7%BD%AE) 用来实现当浏览器 url 发生变化时，自动加载相应的子应用的功能，结合上面的例子我们试着在基座main.js注册子应用

[1](../_resources/47ad6189b2e75e0dc4e04108418173bb.webp)主要包括：

- `entry`: 子应用的 entry 地址，比如我们现在有两个子应用A和B，那么这里配置的就是他们的资源访问域名或ip
- `render`：本质上是container的转换，container用来定义子应用的容器节点的选择器或者 Element 实例，这里使用的是实际例子
- `activeRule`：子应用的激活规则，即什么路由访问才会去fetch entry配置的域名或ip，我们用了`getActiveRule`来完成匹配，我们看看`getActiveRule`的实现,该函数通过传入当前 location 作为参数，然后根据函数返回数值来看，若返回值为 true 时则表明当前子应用会被激活，则去调用entry入口配置

[1](../_resources/0b60c17ee036c6c35412be449f69f121.webp)
匹配如下

	✅ https://dev.portal.com/a

	✅ https://dev.portal.com/a/anything/everything

	 https://dev.portal.com/c
	复制代码

匹配成功后，qiankun 通过 fetch 去获取所匹配子应用的静态资源

#### 1.2 资源访问跨域如何解决？

> ❝

>  啊呆同学：你这样不会跨域吗？基座 https://dev.portal.com/ 获子应用a的资源 https://dev.monitor.com/a的资源 ，根据浏览器同源策略(浏览器采用同源策略,禁止页面加载或执行与自身来源不同的域的任何脚本)应该获取不到吧，明显跨域

> ❞

答案：是，由于 qiankun 是通过 fetch 去获取子应用注册时配置的静态资源url，所有静态资源必须是支持跨域的，那就得设置允许源了，简单的设置可以看下面

[1](../_resources/44fd624fbaaf33c7e58a8e266fffe8c4.webp)

- `Access-Control-Allow-Origin`：跨域在服务端是不允许的。只能通过给Nginx配置`Access-Control-Allow-Origin *`后，才能使服务器能接受所有的请求源（Origin）
- `Access-Control-Allow-Headers`: 设置支持的Content-Type

#### 1.3 子应用加载失败是什么问题？

> ❝
>  啊明同学：跨域解决了，可还是fetch不到子应用a的静态资源？是什么问题咋搞？
> ❞

出现这个报错：`Application died in status LOADING_SOURCE_CODE: You need to export the functional lifecycles in xxx entry`

答案：你的打包姿势不对
> ❝
> vue-cli 3x项目中需要通过在vue.config.js配置output来配置输出的方式，如下所示
> ❞
[1](../_resources/c1f506a1ab74e6d8a97fd2e17e84b019.webp)

- `pubilcPath`: 主要解决的是子应用动态载入的 脚本、样式、图片 等地址不正确的问题
- `output.library`：需要与主应用注册子应用时的name一致且唯一
- `output.libraryTarget:umd` : 导出umd格式，可以支持inport、require和script引入

然后创建一个publichPath文件，并在main.js 引入
[1](../_resources/87ea6230d027add4ce635315207c94ec.webp)

#### 1.4 子应用的publichPath到底应该怎么配置？

> ❝
>  啊明同学：打包output配置改好了，但是为什么publichPath路径配置为/a?
> ❞
拓展: 沿用上文提到的a应用的访问域名 dev.monitor.com/a
现在浏览器要正确获取a应用的静态资源中的css文件,则会去访问 dev.monitor.com/a/css/common.css
主要分两种情况：

- publichPath如果默认配置或者配置为/，则生成的index.html 访问的资源是则不正确，因为将访问的是dev.monitor.com/css/common.css并不是a应用的资源
- 配置为/a，则生成的index.html 访问的资源是 就可以

[1](../_resources/869478a7df69198d883ea11b57c81d5f.webp)
> ❝
>  啊呆同学：那publichPath路径配置为`./`> 相对路径可以吗?
> ❞
答案：也是可以的，跟配置为`/a`访问一样

#### 1.5 如何保障原来的应用运行正常，但能集成到基座portal中

> ❝
>  啊明同学：我之前a应用是单独运行部署的，我通过qiankun集成到基座portal中会有影响吗？
> ❞
答案：使用这个全局变量来区分当前是否运行在 qiankun 的主应用中
那就是： `window.__POWERED_BY_QIANKUN_`那可以用来干嘛？请看下面
[1](../_resources/7ac5db54a1c374520a740b1f67705c2c.webp)

- 独立运行：`window.__POWERED_BY_QIANKUN__`为false，执行mount创建vue对象
- 运行在qiankun: `window.__POWERED_BY_QIANKUN__`为true，则不执行mount

#### 1.6 父应用如何共享util和data给子应用

> ❝
>  隔壁老王同学：如果我想把门户登陆应用登陆成功获取到的个人数据共享给子应用还有一些公用的方法，我该怎么做？
> ❞
答案：可以在注册子应用的时候，把定义好要共享的msg，通过props共享出去
[1](../_resources/e8cac4969ef947193f7ef08e1801eff3.webp)

- `msg.data`： 把store状态管理数据共享给子应用
- `msg.prototype`： 定义一些原型数据，比如是否为qiankun上下文中

父应用定义完，那子应用是如何获取呢？是通过在子应用挂载前，将props数据导到子应用通过遍历赋值给到子应用vue原型中[1](../_resources/f5c45e8b369e2c5990b8bb72ffbe2728.webp)

#### 1.7 history路由模式，需要如何配置ngnix，才能正常访问？

> ❝
>  啊宇同学：我看你访问的路由模式不是hash，而是history模式，那你是怎么解决当页面刷新404问题？
> ❞

答案：通过nginx配置加入try_files，history 模式同样会有一个问题，就是当页面刷新时，如果没有合适的配置，会出现404错误，针对这种请看，需要额外在nginx配置，对于找不到url的，将首页html返回

[1](../_resources/e0d252b65c4f23d966490fc534eb34c5.webp)

- `try_files`：用来解决nginx找不到client客户端所需要的资源时访问404的问题
- `proxy_pass`：主要是用来配置接口网关反向代理，可以使得父子应用下访问的api是一致的，防止接口跨域问题

了解更多ngnix配置学习，请看树酱之前写的[ngnix那些事](https://juejin.im/post/6844904102447546382)

#### 1.8 建议：针对刚学习微前端的童鞋

第一次学习微前端的童鞋可以学习Peter老师的`chunchao`微前端框架，会比较容易理解上手 [github链接](https://github.com/JinJieTan/chunchao/)

酱往期文章：

- [组件库源码中这些写法你掌握了吗？](https://juejin.im/post/6850037264471457805)
- [聊聊前端开发日常的协作工具](https://juejin.im/post/6844904176330375181)
- [前端表单数据那些事](https://juejin.im/post/6844903632073129997)
- [如何更好管理 Api 接口](https://juejin.im/post/6844904154574356493)
- [面试官问你关于node的那些事](https://juejin.im/post/6844904177466867726)
- [前端工程化那些事](https://juejin.im/post/6844904132512317453)
- [你学BFF和Serverless了吗](https://juejin.im/post/6844904185427673095)
- [前端运维部署那些事](https://juejin.im/post/6844904118020997128)

#### 请你喝杯 记得三连哦～

1.阅读完记得给 酱点个赞哦，有 有动力
2.关注公众号前端那些趣事，陪你聊聊前端的趣事

3.文章收录在Github [frontendThings](https://github.com/littleTreeme/frontendThings) 感谢Star✨

[1](../_resources/6f7d335fe230a885dafb858424175906.webp)
前端路由实现与 react-router 源码分析

##  前端路由实现与 react-router 源码分析

 *2016-06-18*  [前端大全](http://mp.weixin.qq.com/s?src=3&timestamp=1489413578&ver=1&signature=5Ejvg8tOKv*y-zarozxWOzXLxw*eVY8Ot7vIUv9BmqBJrFvCcH1t4GyQh5nNGPF7HqnrF6LB5gO8dWUoM0RWsYyzEfuceTjiNDP20NzEXoK*ZYFMfcHEx7AeCR5uKXCCAcm4p0FH6o7M52RFgm-qf66f1OMOG32MVWiWhh5n1gs=##)

（点击上方公众号，可快速关注）
****
> 作者：> 伯乐在线专栏作者 - joeyguo
> 链接：> http://web.jobbole.com/86407/

> [> 点击 → 了解如何加入专栏作者](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402764500&idx=1&sn=cfcc178c7718d548b7cdc04758502bd9&scene=21#wechat_redirect)

**
**

在单页应用上，前端路由并不陌生。很多前端框架也会有独立开发或推荐配套使用的路由系统。那么，当我们在谈前端路由的时候，还可以谈些什么？本文将简要分析并实现一个的前端路由，并对 react-router 进行分析。

**一个极简前端路由实现**

说一下前端路由实现的简要原理，以 hash 形式（也可以使用 History API 来处理）为例，当 url 的 hash 发生变化时，触发 hashchange 注册的回调，回调中去进行不同的操作，进行不同的内容的展示。直接看代码或许更直观。

> function>   > Router> ()>   > {
>     > this> .> routes>  = > {};
>     > this> .> currentUrl>  = > ''> ;
> }

> Router> .> prototype> .> route>  = > function> (> path> ,>   > callback> )>   > {

>     > this> .> routes> [> path> ]>  = > callback>  || > function> (){};
> };
> Router> .> prototype> .> refresh>  = > function> ()>   > {

>     > this> .> currentUrl>  = > location> .> hash> .> slice> (> 1> )>  || > '/'> ;

>     > this> .> routes> [> this> .> currentUrl> ]();
> };
> Router> .> prototype> .> init>  = > function> ()>   > {

>     > window> .> addEventListener> (> 'load'> ,>   > this> .> refresh> .> bind> (> this> ),>   > false> );

>     > window> .> addEventListener> (> 'hashchange'> ,>   > this> .> refresh> .> bind> (> this> ),>   > false> );

> }
> window> .> Router>  = > new>   > Router> ();
> window> .> Router> .> init> ();

上面路由系统 Router 对象实现，主要提供三个方法

- init 监听浏览器 url hash 更新事件
- route 存储路由更新时的回调到回调数组routes中，回调函数将负责对页面的更新
- refresh 执行当前url对应的回调函数，更新页面

Router 调用方式以及呈现效果如下：点击触发 url 的 hash 改变，并对应地更新内容（这里为 body 背景色）

> <ul>>
>     > <li><a > href> => "#/"> >> turn white> </a></li>>
>     > <li><a > href> => "#/blue"> >> turn blue> </a></li>>
>     > <li><a > href> => "#/green"> >> turn green> </a></li>>
> </ul>

> var>   > content>  = > document> .> querySelector> (> 'body'> );
> // change Page anything
> function>   > changeBgColor> (> color> )>   > {
>     > content> .> style> .> backgroundColor>  = > color> ;
> }
> Router> .> route> (> '/'> ,>   > function> ()>   > {
>     > changeBgColor> (> 'white'> );
> });
> Router> .> route> (> '/blue'> ,>   > function> ()>   > {
>     > changeBgColor> (> 'blue'> );
> });
> Router> .> route> (> '/green'> ,>   > function> ()>   > {
>     > changeBgColor> (> 'green'> );
> });

![0.gif](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231175127.gif)

以上为一个前端路由的简单实现，完整代码（https://github.com/joeyguo/blog/blob/master/lab/2016/router/simple-router.html），虽然简单，但实际上很多路由系统的根基都立于此，其他路由系统主要是对自身使用的框架机制的进行配套及优化，如与 react 配套的 react-router。

**react-router 分析**

**react-router 与 history 结合形式**

react-router 是基于 history 模块提供的 api 进行开发的，结合的形式本文记为 包装方式。所以在开始对其分析之前，先举一个简单的例子来说明如何进行对象的包装。

[640.webp](../_resources/915f0946b40eb39bd70466aba2814cba.webp)

可看到 historyModule 中含有机制：historyModule.updateLocation() -> listener( )，Router 通过对其进行包装开发，针对 historyModule 的机制对 Router 也起到了作用，即historyModule.updateLocation() 将触发 Router.listen 中的回调函数 。完整代码（https://github.com/joeyguo/blog/blob/master/lab/2016/router/package-style.html）

这种包装形式能够充分利用原对象（historyModule ）的内部机制，减少开发成本，也更好的分离包装函数（Router）的逻辑，减少对原对象的影响。

**react-router 使用方式**

react-router 以 react component 的组件方式提供 API， 包含 Router，Route，Redirect，Link 等等，这样能够充分利用 react component 提供的生命周期特性，同时也让定义路由跟写 react component 达到统一，如下

> render> ((
>   <> Router > history> => {> browserHistory> }> >
>     <> Route path> => "/">   > component> => {> App> }> >
>       <> Route path> => "about">   > component> => {> About> }> />
>       <> Route path> => "users">   > component> => {> Users> }> >
>         <> Route path> => "/user/:userId">   > component> => {> User> }> />
>       </> Route> >
>       <> Route path> => "*">   > component> => {> NoMatch> }> />
>     </> Route> >
>   </> Router> >
> ),>   > document> .> body> )

就这样，声明了一份含有 path to component 的各个映射的路由表。

react-router 还提供的 Link 组件（如下），作为提供更新 url 的途径，触发 Link 后最终将通过如上面定义的路由表进行匹配，并拿到对应的 component 及 state 进行 render 渲染页面。

> <Link to={`/user/89757`}>'joey'</Link>

这里不细讲 react-router 的使用，详情可见：https://github.com/reactjs/react-router

**从点击 Link 到 render 对应 component ，路由中发生了什么**

**为何能够触发 render component ？**

主要是因为触发了 react setState 的方法从而能够触发 render component。

从顶层组件 Router 出发（下面代码从 react-router/Router 中摘取），可看到 Router 在 react component 生命周期之组件被挂载前 componentWillMount 中使用 this.history.listen 去注册了 url 更新的回调函数。回调函数将在 url 更新时触发，回调中的 setState 起到 render 了新的 component 的作用。

> Router> .> prototype> .> componentWillMount>  = > function>   > componentWillMount> ()>   > {

>     > // .. 省略其他
>     > var>   > createHistory>  = > this> .> props> .> history> ;
>

>     > this> .> history>  = > _useRoutes2> [> 'default'> ](> createHistory> )({

>       > routes> : > _RouteUtils> .> createRoutes> (> routes>  || > children> ),

>       > parseQueryString> : > parseQueryString> ,
>       > stringifyQuery> : > stringifyQuery
>     > });
>

>     > this> .> _unlisten>  = > this> .> history> .> listen> (> function>   > (> error> ,>   > state> )>   > {

>         > _this> .> setState> (> state> ,>   > _this> .> props> .> onUpdate> );

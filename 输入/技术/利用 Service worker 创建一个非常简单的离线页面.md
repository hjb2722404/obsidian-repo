利用 Service worker 创建一个非常简单的离线页面

##  利用 Service worker 创建一个非常简单的离线页面

 *2016-06-15*  [前端大全]()

（点击上方公众号，可快速关注）
****
> 原文：Dean Hume
> 译文：> 伯乐在线 - 刘健超-J.c
> 链接：> http://web.jobbole.com/86346/
**
**

让我们想像以下情景：我们此时在一辆通往农村的火车上，用移动设备看着一篇很棒的文章。与此同时，当你点击“查看更多”的链接时，火车忽然进入了隧道，导致移动设备失去了网络，而 web 页面会呈现出类似以下的内容：

![0.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120808.jpg)

这是相当令人沮丧的体验！幸运的是，web 开发者们能通过一些新特性来改善这类的用户体验。我最近一直在折腾 Service Workers，它给 web 带来的无尽可能性总能给我惊喜。Service Workers 的美妙特质之一是允许你检测网络请求的状况，并让你作出相应的响应。

在这篇文章里，我打算用此特性检查用户的当前网络连接状况，如果没连接则返回一个超级简单的离线页面。尽管这是一个非常基础的案例，但它能给你带来启发，让你知道启动并运行该特性是多么的简单！如果你没了解过 Service Worker，我建议你看看此 Github repo，了解更多相关的信息。

在该案例开始前，让我们先简单地看看它的工作流程：

1. 在用户首次访问我们的页面时，我们会安装 Service Worker，并向浏览器的缓存添加我们的离线 HTML 页面
2. 然后，如果用户打算导航到另一个 web 页面（同一个网站下），但此时已断网，那么我们将返回已被缓存的离线 HTML 页面
3. 但是，如果用户打算导航到另外一个 web 页面，而此时网络已连接，则能照常浏览页面

**让我们开始吧**

假如你有以下 HTML 页面。这虽然非常基础，但能给你总体思路。

> <!DOCTYPE html>

接着，让我们在页面里注册 Service Worker，这里仅创建了该对象。向刚刚的 HTML 里添加以下代码。

> <script>
> // Register the service worker
> // 注册 service worker
> if>   > (> 'serviceWorker'>   > in>   > navigator> )>   > {

>     > navigator> .> serviceWorker> .> register> (> '/service-worker.js'> ).> then> (> function> (> registration> )>   > {

>     > // Registration was successful
>     > // 注册成功

>     > console> .> log> (> 'ServiceWorker registration successful with scope: '> ,>   > registration> .> scope> );

> }).> catch> (> function> (> err> )>   > {
>     > // registration failed :(
>     > // 注册失败 :(

>     > console> .> log> (> 'ServiceWorker registration failed: '> ,>   > err> );

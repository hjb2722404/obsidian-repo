* * *

title: 浏览器页面资源加载过程与优化  
date: 2017-12-22
----------------------------------------

> 评价页面性能好坏的核心之一就是**页面的加载速度**，而**页面加载速度**的关键就是**页面资源的加载**。本文将从浏览器浏览器页面资源加载过程展开分析，来引出页面**关键请求路径**的概念，并给出如何优化该**关键请求路径**的一些方法。  
> 下面相关内容，都是以chrome浏览器为例来进行介绍的。不同浏览器之间，可以会略有差异，但基本过程是一致的。

### 浏览器加载资源过程

首先抛出两个问题：

*   浏览器如何知道应该加载哪些资源？
*   浏览器是什么顺序来加载这些资源？  
    当浏览器截获到一个页面请求后，将会按照顺序做如下图所示的4件事。  
    [![](https://camo.githubusercontent.com/1a1bfdc2c5c67843454d41ab9ddb72cf8aac31923df2e428fda5efbe01069e11/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f32336134386561352d356561372d343961322d393639322d6632376337343839323931322e6a7067)
    ](https://camo.githubusercontent.com/1a1bfdc2c5c67843454d41ab9ddb72cf8aac31923df2e428fda5efbe01069e11/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f32336134386561352d356561372d343961322d393639322d6632376337343839323931322e6a7067)

1.  首先会将所有需要加载的资源进行分类。
2.  然后根据浏览器相关的安全策略，来决定资源的加载权限。
3.  接着对各个资源的加载优先级进行计算和排序。
4.  最后一步，根据加载优先级顺序来加载资源。

##### 第一步：资源分类

chrome浏览器会将资源分为14类，如下表所示。

| 类型 | 介绍 |
| --- | --- |
| kMainResource | 即主资源，html页面文件资源就属于该类型 |
| kImage | 各种图片资源 |
| kCSSStyleSheet | 顾名思义，就是层叠样式表css资源 |
| kScript | 脚本资源，例如js资源 |
| kFont | 字体资源，例如网页中常用的字体集.woff资源 |
| kRaw | 混合类型资源，最常见的ajax请求就属于这类资源 |
| kSVGDocument | SVG可缩放矢量图形文件资源 |
| kXSLStyleSheet | 扩展样式表语言XSLT，是一种转换语言，关于该类型可以查阅w3c XSL来了解 |
| kLinkPrefetch | HTML5页面的预读取资源(Link prefetch)，例如dns-prefetch。下面会有详细介绍 |
| kTextTrack | video的字幕资源，- 即`<track>`标签 |
| kImportResource | HTML Imports，将一个HTML文件导入到其他HTML文档中，例如`<link href="import/post.html" rel="import" />`。详细了解请查阅相关文档。 |
| kMedia | 多媒体资源，video or audio都属于该类资源 |
| kManifest | HTML5 应用程序缓存资源 |
| kMock | 预留的测试类型 |

##### 第二步：安全策略检查

网页安全政策（Content Security Policy，缩写 CSP）是由浏览器提供的一种白名单制度。开发者通过配置，来告诉浏览器各类外部资源的加载和执行限制，来提高网页的安全性。一种最常用的应用就是通过限制非信任域名脚本的加载来预防XSS攻击。  
可以通过两种方式来配置CSP。  
第一种，就是通过页面HTTP请求头的Content-Security-Policy字段来限制。如下图所示，这是www.google.com页面的请求头：  
[![](https://camo.githubusercontent.com/a7a64c7d7fc2ef1a5d4ac5029d4bdb0bfbb79cdb64f7bce00589e9f438fc621d/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f35356363613564342d363032662d343561352d626462302d3433336232323663353764392e6a7067)
](https://camo.githubusercontent.com/a7a64c7d7fc2ef1a5d4ac5029d4bdb0bfbb79cdb64f7bce00589e9f438fc621d/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f35356363613564342d363032662d343561352d626462302d3433336232323663353764392e6a7067)  
第二种是，通过`<meta>`标签来设置。`<meta>`是以key-value的方式来进行配置的。下面以几个具体的应用例子来介绍。

1.  用于预防XSS:

```html
<meta http-equiv="Content-Security-Policy" content="script-src 'self'; style-src nos.netease.com kaola.com;">
```

上面的`script-src`代表脚本资源；`style-src`代表样式资源；`'self'`代表只信任当前域名下的外来资源，其他域下的资源全部会被拦截；`nos.netease.com kaola.com`代表信任nos.netease.com和kaola.com这两个域名下的资源。  
所以上面的标签的意义就是：对于脚本资源只信任本域下的，对于样式资源，除了本域还会加载nos.netease.com和kaola.com这两个域名下的。

2.  用于站点请求协议升级过渡（http转https）：

```html
<meta http-equiv="Content-Secur****ity-Policy" content="upgrade-insecure-requests">
```

上面的`upgrade-insecure-requests`的意义，就如同字面意思一样：升级所有非安全请求。当加了这个meta标签以后，浏览器会将https页面中的所有htttp请自动升级到https。例如，当我们需要进行全站http转https改造时，对于原有的大量http资源会直接强制以https或wss等SSL加密形式发送请求而不会报错。当然如果资源服务器不支持https等SSL加密，那么该资源还是不会载入。

3.  用于阻止Mixed Content：

```html
<meta http-equiv="Content-Security-Policy" content="block-all-mixed-content">
```

混合内容(Mixed Content)就是第2个例子所说的，在https站点中，进行的http请求。这类在安全链接中混合了非安全请求内容就叫混合内容。出现这类请求时，我们可以在浏览器控制台中找到对应的警告信息，如下图所示。  
[![](https://camo.githubusercontent.com/92c73d135673b5a63473ba99d74f09f12dd177efebeb905c819b1ee1791c9934/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f34333637663864382d646162322d346236342d393264372d3630396532303465393164322e6a7067)
](https://camo.githubusercontent.com/92c73d135673b5a63473ba99d74f09f12dd177efebeb905c819b1ee1791c9934/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f34333637663864382d646162322d346236342d393264372d3630396532303465393164322e6a7067)  
混合内容会降低HTTPS网站的安全性和用户体验。不过让人略感放心的是，浏览器对于可能对安全性造成较大威胁的资源类型的混合模式请求都会直接拦截报错，例如脚本资源，如下图所示。但对于图片、音频、视频等资源只会警告，但不会阻止其加载。  
[![](https://camo.githubusercontent.com/dd3437d9ad17ab1849c2278c8b7ddd89ce628c12694ec114a757f25132951310/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f63633030626532622d376330372d346236312d383136362d3162363334643662663734352e706e67)
](https://camo.githubusercontent.com/dd3437d9ad17ab1849c2278c8b7ddd89ce628c12694ec114a757f25132951310/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f63633030626532622d376330372d346236312d383136362d3162363334643662663734352e706e67)  
对于安全性要求极高的网站，可以通过上面的标签来阻止所以类型的非安全链接请求，这样包括图片、音频、视频等资源也将会被拦截报错。  
当然对于Content-Security-Policy的设置还有很多其他作用，大家可以通过[MDN](https://developer.mozilla.org/zh-CN/docs/Web/Security/CSP/Using_Content_Security_Policy "MDN")来做进一步了解。

##### 第三步：资源优先级计算

资源的优先级被分为**5级**。不同资料上，对这**5级**的命名描述上可能有所不同。主要是因为资料本身可能是从**网络层面**，**浏览器内核**或者**用户端控制台显示**这三个方向中的某一个来说的。这三个方向虽然对这**5级**的命名不同，但都是一一对应的。  
**网络层面**，5级分别为：Highest、Medium、Low、Lowest、Idle;  
**浏览器内核**，5级分别为：VeryHigh、High、Medium、Low、VeryLow;  
**用户端控制台显示**，5级分别为：Highest、High、Medium、Low、Lowest;

下面是以**浏览器内核**作为研究方向，来介绍浏览器的资源优先级计算过程：

*   第一步，根据资源的类型来设定默认优先级。  
    对于每一类资源浏览器都有一个默认的加载优先级规则：

1.  html、css、font这三种类型的资源优先级最高；
2.  然后是preload资源（通过[`<link rel=“preload">`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Preloading_content "preload")标签预加载）、script、xhr请求；
3.  接着是图片、语音、视频；
4.  最低的是[prefetch](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Link_prefetching_FAQ "prefetch")预读取的资源。

*   第二步，根据一定的实际规则，对优先级进行调整。  
    初始优先级设置好以后，浏览器会根据资源的实际属性和位于文档中的位置等方面，对优先级进行调整，来确定出最终的加载优先级顺序。对于几个常见资源类型的调整规则如下：

1.  对于**XHR请求**资源：将**同步XHR请求**的优先级调整为最高。  
    XHR请求可以分为同步请求和异步请求，浏览器会把同步请求的优先级提升到最高级，以便尽早获取数据、加快页面的显示。
2.  对于**图片**资源：会根据图片是否在可见视图之内来改变优先级。  
    图片资源的默认优先级为Low。现代浏览器为了提高用户首屏的体验，在渲染时会计算图片资源是否在首屏可见视图之内，在的话，会将这部分视口可见图片(Image in viewport)资源的优先级提升为High。
3.  对于**脚本**资源：浏览器会将根据脚本所处的位置和属性标签分为三类，分别设置优先级。  
    首先，对于添加了defer/async属性标签的脚本的优先级会全部降为Low。  
    然后，对于没有添加该属性的脚本，根据该脚本在文档中的位置是在浏览器展示的第一张图片之前还是之后，又可分为两类。在之前的`(标记early**)`它会被定为High优先级，在之后的`(标记late**)`会被设置为Medium优先级。  
    下图总结了资源优先级计算后各类资源的优先级情况，其中特别将上面讲的三种常见资源的情况框了出来。红框框中的为脚本类型、紫框的为图片类型、蓝框为XHR请求。图片来源[点此](https://docs.google.com/document/d/1bCDuq9H1ih9iNjgzyAL0gpwNFiEP4TZS-YLRp_RuMlc/edit# "点此")。  
    [![](https://camo.githubusercontent.com/4f5fa61e4fe348514f2db2782f41cd9c50d0b73c83c05c780897e7c3efed1231/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f35303964343938652d616266302d343631362d623030622d6239383733626138383239392e6a7067)
    ](https://camo.githubusercontent.com/4f5fa61e4fe348514f2db2782f41cd9c50d0b73c83c05c780897e7c3efed1231/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f35303964343938652d616266302d343631362d623030622d6239383733626138383239392e6a7067)

##### 第四步：按照上面计算的安全策略和优先级来加载或阻塞资源。

### **关键请求链和优化**

上面详细介绍了浏览器的资源加载过程，其中核心在于资源的加载优先顺序的计算。我们可以通过优化资源的加载优先级顺序，来有效提高页面的加载响应速度。

首先来介绍下**关键请求链（Critical-Request-Chains）**的概念。可视区域渲染完毕（首屏），并对于用户来说可用时，必须加载的资源请求队列，就叫做**关键请求链**。这样，我们可以通过**关键请求链**，来确定优先加载的资源以及加载顺序，以实现浏览器尽可能快地加载页面。

##### 如何查找页面的**关键请求链**

1.  通过首屏快照获取关键image资源。  
    如下图所示，我们通过首屏快照，来获取首屏所要加载的图片资源。(红框内)  
    [![](https://camo.githubusercontent.com/6188498e3dc49cfe6d5233fdf3d17970e260ce288abae2b12be102372ba16368/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f31376665333936662d343237342d346431352d383435372d6139306530306463323032662e6a7067)
    ](https://camo.githubusercontent.com/6188498e3dc49cfe6d5233fdf3d17970e260ce288abae2b12be102372ba16368/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f31376665333936662d343237342d346431352d383435372d6139306530306463323032662e6a7067)
2.  通过**LightHouse**插件获取关键请求链中的关键js和css资源。  
    **LightHouse**详细的使用方法可以通过点击[此处](https://developers.google.com/web/tools/lighthouse/ "此处")来了解。通过执行该插件最终可以生成一个报告，里面包含了有关该页面性能的全方面报告和建议。其中有关关键请求链的报告如下图所示：  
    [![](https://camo.githubusercontent.com/f61e76ed191e1d2a849a7f75b090434f724034c02aa6f68bf64fc6f474f0237b/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f62626534653238362d633131302d343636632d626338382d3536366162653330313538342e6a7067)
    ](https://camo.githubusercontent.com/f61e76ed191e1d2a849a7f75b090434f724034c02aa6f68bf64fc6f474f0237b/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f62626534653238362d633131302d343636632d626338382d3536366162653330313538342e6a7067)
3.  通过浏览器控制台查看各个请求的优先级  
    打开Chrome控制台，切换到Network tab下，就可以查看资源的优先级（Priority）。如果没有Priority一栏，可以右键在下拉菜单中勾选Priority即可。如下图所示：  
    [![](https://camo.githubusercontent.com/f09b0e22986a592fc833624689494e8a5c40f0f476fa4a6f2d092f73cce567b8/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f64613564633033382d386137312d346630622d393063662d3434313438326139333935622e6a7067)
    ](https://camo.githubusercontent.com/f09b0e22986a592fc833624689494e8a5c40f0f476fa4a6f2d092f73cce567b8/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f64613564633033382d386137312d346630622d393063662d3434313438326139333935622e6a7067)

##### 优化**关键请求链**

优化**关键请求链**有很多方法，这里主要介绍两种。

*   第一种：利用**Preload**和**Prefetch**。
    
    这两个标签在文章前面的介绍中就已经有所介绍，它们都属于预加载性能优化技术。对于开发人员，我们可能比浏览器更加了解我们的应用。从而可以使用该技术来预先告知浏览器某些资源可能在将来会被使用到，让浏览器对这部分资源进行提前加载。  
    **Preload**:
    
    ```html
     <link rel="preload" href="test.jpg">
    ```
    
    **Prefetch**:  
    Prefetch包括资源预加载、DNS预解析、http预连接和页面预渲染。
    
    ```html
     资源预加载：<link rel="prefetch" href="test.css">
     DNS预解析：<link rel="dns-prefetch" href="//haitao.nos.netease.com">
     http预连接：<link rel="prefetch" href="//www.kaola.com"> 将建立对该域名的TCP链接
     页面预渲染：<link rel="prerender" href="//m.kaola.com"> 将会预先加载链接文档的所有资源
    ```
    
    那么**Prefetch**和**Preload**有什么区别呢？  
    具体来讲，**Preload**来告诉浏览器预先请求当前页需要的资源，从而提高这些资源的请求优先级。比如，对于那些本来请求优先级较低的关键请求，我们可以通过设置**Preload**来提升这些请求的优先级。  
    **Prefetch**来告诉浏览器用户将来可能在其他页面（非本页面）可能使用到的资源，那么浏览器会在空闲时，就去预先加载这些资源放在http缓存内，最常见的dns-prefetch。比如，当我们在浏览A页面，如果会通过A页面中的链接跳转到B页面，而B页面中我们有些资源希望尽早提前加载，那么我们就可以在A页面里添加这些资源**Prefetch**，那么当浏览器空闲时，就会去加载这些资源。  
    所以，对于那些可能在当前页面使用到的资源可以利用**Preload**，而对一些可能在将来的某些页面中被使用的资源可以利用**Prefetch**。如果从加载优先级上看，**Preload**会提升请求优先级；而**Prefetch**会把资源的优先级放在最低，当浏览器空闲时才去预加载。
    
    *   泼盆冷水：  
        既然**Prefetch**和**Preload**作用如此强大，我们是否可以放心使用呢？但实际上，除了dns-prefetch，其他的兼容性都十分堪忧。特别是在Safari上，由于苹果公司对安全性的苛刻要求，基本上对这些预加载技术都未实现支持。  
        **Preload**的支持性如下图所示，发现新版chrome支持较好，但Safari全军覆没。  
        [![](https://camo.githubusercontent.com/42f815a6ec650c8fc35775bf6f160e0f9e4ac813f1f52cf2552947a6333f8307/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f32356137393638322d666339652d343064632d393038342d6134333033386537363631382e6a7067)
        ](https://camo.githubusercontent.com/42f815a6ec650c8fc35775bf6f160e0f9e4ac813f1f52cf2552947a6333f8307/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f32356137393638322d666339652d343064632d393038342d6134333033386537363631382e6a7067)  
        **dns-prefetch**支持性还不错。  
        [![](https://camo.githubusercontent.com/76af59995001206e65569460bd9bf5fda0d966710c29ab4dce74d75cd01ec1a6/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f31666330636434622d333834372d346366332d396333612d6166383565663864623435312e6a7067)
        ](https://camo.githubusercontent.com/76af59995001206e65569460bd9bf5fda0d966710c29ab4dce74d75cd01ec1a6/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f31666330636434622d333834372d346366332d396333612d6166383565663864623435312e6a7067)  
        **Prefetch**同样的Safari全军覆没。  
        [![](https://camo.githubusercontent.com/f0e23e02733df7a0383b79f1e12737e72c9d44a69be3e718614132aca676389b/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f30613030653665612d366238372d346133662d626564372d3463353762336562363535362e6a7067)
        ](https://camo.githubusercontent.com/f0e23e02733df7a0383b79f1e12737e72c9d44a69be3e718614132aca676389b/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f30613030653665612d366238372d346133662d626564372d3463353762336562363535362e6a7067)
*   第二种：利用**LocalStorage**。  
    既然第一种的预加载技术来进行资源缓存的支持性较差，那么通常可以利用**LocalStorage**来对部分请求的数据和结果进行缓存，省去发送http请求所消耗的时间，从而提高网页的响应速度。  
    这类做法在移动端应用已经十分广泛。下面分别介绍鹅、猫、狗三家页面是如何利用LS来进行请求缓存的。
    
*   **微信**：利用LS来对js文件进行缓存。  
    如下图所示，用浏览器打开一篇微信公众账号文章，打开控制台，发现Network里竟然一个js文件都不需要加载？一脸懵逼！  
    [![](https://camo.githubusercontent.com/5e04e1678848e109bb28e92818c5cd8345ecaf5e9a0279501fccf017fa36c297/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f30396331303736362d346537312d343464342d386130362d3262376631383061353436342e6a7067)
    ](https://camo.githubusercontent.com/5e04e1678848e109bb28e92818c5cd8345ecaf5e9a0279501fccf017fa36c297/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f30396331303736362d346537312d343464342d386130362d3262376631383061353436342e6a7067)  
    切到LS才哗然大悟，原来所有的JS都藏在这里了！  
    [![](https://camo.githubusercontent.com/054da5befbac0f84c916e43d5d6518740de4f2eb2f33f075c505a657ec9d41cc/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f37643162313261662d336662352d343933622d623838372d3266646366613462396435352e6a7067)
    ](https://camo.githubusercontent.com/054da5befbac0f84c916e43d5d6518740de4f2eb2f33f075c505a657ec9d41cc/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f37643162313261662d336662352d343933622d623838372d3266646366613462396435352e6a7067)  
    微信就是利用了这种技巧来缓存关键路径里的js资源，从而大大加快了页面访问速度。  
    当然，实际实现起来，并不像表面看得那样，第一次访问时将js放到LS里，每次进来取出来执行这么简单，最核心的其实是需要设计一套缓存更新机制。首先我们对于缓存的js文件要通过后缀来设置独一无二的版本标识；其次，每次后端需要传一份资源配置文件，前端会根据这个配置文件来和LS中缓存的文件进行版本标识匹配，从而决定是利用LS缓存，还是重新发请求更新资源。例如，微信中的这个配置文件就是通过moon\_map来同步输出给前端的，如下图所示（饿了么有一个类似的[开源库](https://elemefe.github.io/bowl/#/)）：  
    [![](https://camo.githubusercontent.com/e543d176fbd66b86a1975614cbb37724621630ab7ef049f37a0d5ef6077e52d7/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f64326139313934312d346363342d343264372d613031652d6661363037373532653432362e6a7067)
    ](https://camo.githubusercontent.com/e543d176fbd66b86a1975614cbb37724621630ab7ef049f37a0d5ef6077e52d7/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f64326139313934312d346363342d343264372d613031652d6661363037373532653432362e6a7067)
    
*   **天猫**：利用LS来对关键的XHR异步请求进行缓存。  
    以[天猫超市首页](https://chaoshi.m.tmall.com/ "天猫超市首页")为例：  
    如下图，查看LS，发现其对首屏中的轮播和10个分类入口的数据进行了缓存。  
    [![](https://camo.githubusercontent.com/24f16f6472ea52fcb11735940c7bcbcab4f145c7fd2a7e526b364a46a09fbbef/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f37316639643365372d396463342d343430642d616230382d3739623661643633653861372e6a7067)
    ](https://camo.githubusercontent.com/24f16f6472ea52fcb11735940c7bcbcab4f145c7fd2a7e526b364a46a09fbbef/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f37316639643365372d396463342d343430642d616230382d3739623661643633653861372e6a7067)  
    上面的json内容，格式化后，发现其中包含banner和flowIcons这两个属性，里面的数据分别对应的就是轮播和分类入口的数据。这样就可以大大提升首屏的渲染展示时间。
    
*   **京东**：利用LS来对非关键请求进行缓存。  
    以PC版的[京东首页](https://www.jd.com/ "京东首页")为例。京东反向思维，另辟奇径地采用了另一种方式来利用LS。那就是把非关键请求剥离出来存放在LS内。  
    具体来说，对于首屏数据，还是正常加载和展示。但为了非首屏数据的加载和渲染会阻塞和抢占资源，从而影响首屏页面渲染。所以将非首屏资源的HTML/CSS等资源抽出来放在LS内，当页面滚动到可视区域时再去LS中获取数据，插入到dom中。这点很类似于现在的模块懒加载。如下图所示，每个LS里都包含了一个模块所需要的HTML/CSS的资源。  
    [![](https://camo.githubusercontent.com/9930a07d6285e04ce0f402631df636aa5dc8861787cabe9c9a83fe2420909eb7/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f34313932643339372d616132352d343030642d383566632d3266393663353061313663322e6a7067)
    ](https://camo.githubusercontent.com/9930a07d6285e04ce0f402631df636aa5dc8861787cabe9c9a83fe2420909eb7/68747470733a2f2f68616974616f2e6e6f732e6e6574656173652e636f6d2f34313932643339372d616132352d343030642d383566632d3266393663353061313663322e6a7067)
    

#### END

### 参考资料：

1.  从Chrome源码看浏览器如何加载资源：[https://zhuanlan.zhihu.com/p/30558018。](https://zhuanlan.zhihu.com/p/30558018%E3%80%82)
2.  Preload，Prefetch 和它们在 Chrome 之中的优先级：[https://yq.aliyun.com/articles/226240](https://yq.aliyun.com/articles/226240)
3.  聊聊浏览器资源加载优化：[http://qingbob.com/let-us-talk-about-resource-load/](http://qingbob.com/let-us-talk-about-resource-load/)
4.  关键请求：[http://www.zcfy.cc/article/the-critical-request-css-tricks-3843.html](http://www.zcfy.cc/article/the-critical-request-css-tricks-3843.html)
5.  其他：相关内容的MDN文档及Google Web Develop文档。
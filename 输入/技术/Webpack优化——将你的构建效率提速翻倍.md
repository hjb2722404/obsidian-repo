0\. 背景
------

随着构建体系不断完善、构建体验不断优化，webpack 已经逐渐成为了前端构建体系的一大霸主，对于工作中的真正意义上的前端工程项目，webpack 已经成为了我们前端构建技术选型的不二选择，包括 `create-react-app` 以及 `vue-cli` 等等业内常见的脚手架工具的构建体系，也都是基于 webpack 进行了上层封装。但随着业务代码不断增加，项目深度不断延伸，我们的构建时长也会因此不断增加。渐渐的，总会有人抛出这样的结论：webpack 构建太慢了、太“重”了。就以笔者本次近期为团队优化的项目为例，如下图所示，我们可以看到，随着项目的不断堆砌以及一些不正确的引用，团队内的项目单次构建时长已经达到了40s，这就造成了工程师如果需要重启 devServer 或者执行 build，都会造成很不好的体验。

![](https://user-gold-cdn.xitu.io/2019/8/24/16cc41c00a8266a4?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

而经过优化后，二次启动的时长能接近8s。那是什么样的神仙操作能有如此效果呢？不着急，我们一步步往下看，只要你跟着我的步骤，或许只需要一个晚上，你也能将你们的团队项目的构建体系做出进一步优化。

![](https://user-gold-cdn.xitu.io/2019/8/24/16cc41c546d67124?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

不过在正文开始之前，首先需要提前说明一点，本次文章介绍的构建效率提升手段是基于 webpack4 进行的，对于使用老版本的项目，如何从老版本升级到 webpack4 的流程我就不做过多介绍了，因为不论是掘金还是各种论坛上你都能搜到太多优质的文章了，所以对于大部分的基础知识，比如 `webpack-dev-server` 相关配置，还有一些常见的 plugin，在本文就不会较多提及。而对于那些持续跟进 webpack 版本的同学，我相信你们也知道现阶段 webpack5 也已经呼之欲出了，下图是官方给出的里程碑进度，趁着目前只更新到64%，笔者赶紧先发一波软文，或许到了5的时代，笔者今天所介绍的优化方式，或许都已经被集成到 webpack 自身的体系中了，谁让它一天天都在不断变好呢😊。

![](https://user-gold-cdn.xitu.io/2019/8/24/16cc41cde63ae559?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

这一年来，前前后后忙于毕业和工作，在掘金里的角色逐渐从一名作者转变为读者。如今工作和生活也基本趋于稳定，笔者也希望能像曾经那样，将自己的工作学习积淀，与大家悉数分享。作为笔者回归掘金的开篇之作，希望在看完这篇文章后，能够让大家在工作中，对于如今前端而言不可或缺的构建体系，有新的认知以及更为大胆的尝试。当然，如果在这过程中遇到了问题，我也特别欢迎能和大家一块交流、一块学习、一块进步。

闲话不多说，接下来就进入咱们本次的正题。

本文将以笔者在实践中解决问题的思路为索引，逐步带着大家以剖析问题 -> 发现问题 -> 解决问题的流程去了解对构建体系进行优化的整个过程。

1\. 构建打点
--------

要做优化，我们肯定得知道要从哪里做优化对吧。那在我们的一次构建流程中，是什么拉低了我们的构建效率呢？我们有什么方法可以将它们测量出来呢？

要解决这两个问题，我们需要用到一款工具：[speed-measure-webpack-plugin](https://www.npmjs.com/package/speed-measure-webpack-plugin)，它能够测量出在你的构建过程中，每一个 Loader 和 Plugin 的执行时长，官方给出的效果图是下面这样：

![](https://user-gold-cdn.xitu.io/2019/8/24/16cc41d62ee45a3a?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

而它的使用方法也同样简单，如下方示例代码所示，只需要在你导出 Webpack 配置时，为你的原始配置包一层 smp.wrap 就可以了，接下来执行构建，你就能在 console 面板看到如它 demo 所示的各类型的模块的执行时长。

```js
const SpeedMeasurePlugin = require("speed-measure-webpack-plugin");
 
const smp = new SpeedMeasurePlugin();
 
module.exports = smp.wrap(YourWebpackConfig);
```

> **小贴士**：由于 `speed-measure-webpack-plugin` 对于 webpack 的升级还不够完善，目前（就笔者书写本文的时候）还存在一个 BUG，就是无法与你自己编写的挂载在 `html-webpack-plugin` 提供的 hooks 上的自定义 Plugin （`add-asset-html-webpack-plugin` 就是此类）共存，因此，在你需要打点之前，如果存在这类 Plugin，请先移除，否则会产生如我这篇 [issue](https://github.com/stephencookdev/speed-measure-webpack-plugin/issues/63) 所提到的问题。

可以断言的是，大部分的执行时长应该都是消耗在编译 JS、CSS 的 Loader 以及对这两类代码执行压缩操作的 Plugin 上，如果你的执行结果和我所说的一样，请不要吝啬你的手指，为我的文章点个赞吧😁。

为什么会这样呢？因为在对我们的代码进行编译或者压缩的过程中，都需要执行这样的一个流程：编译器（这里可以指 webpack）需要将我们写下的字符串代码转化成 AST（语法分析树），就是如下图所示的一个树形对象：

![](https://user-gold-cdn.xitu.io/2019/8/24/16cc41dcf9921e41?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

显而易见，编译器肯定不能用正则去显式替换字符串来实现这样一个复杂的编译流程，而编译器需要做的就是遍历这棵树，找到正确的节点并替换成编译后的值，过程就像下图这样：

![](https://user-gold-cdn.xitu.io/2019/8/24/16cc41df63948532?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

这部分知识我在之前的一篇文章 [Webpack揭秘——走向高阶前端的必经之路](https://juejin.im/post/6844903685407916039) 中曾详细介绍过，如果你有兴趣了解，可以翻阅噢～

大家一定还记得曾经在学习《数据结构与算法》或者是面试时候，被树形结构的各种算法虐待千百遍的日子吧，你一定也还记得深度优先遍历和广度优先遍历的实现思路对吧。可想而知，之所以构建时长会集中消耗在代码的编译或压缩过程中，正是因为它们需要去遍历树以替换字符或者说转换语法，因此都需要经历"转化 AST -> 遍历树 -> 转化回代码"这样一个过程，你说，它的时长能不长嘛。

2\. 优化策略
--------

既然我们已经找到了拉低我们构建速率的“罪魁祸首”，接下来我们就点对点逐个击破了！这里，我就直接开门见山了，既然我们都知道构建耗时的原因，自然就能得出针对性的方略。所以我们会从四个大方向入手：缓存、多核、抽离以及拆分，你现在看到这四个词或许脑海里又能浮现出了一些熟悉的思路，这很棒，这样的话你对我接下来将介绍的手段一定就能更快理解。

### 2.1. 缓存

我们每次的项目变更，肯定不会把所有文件都重写一遍，但是每次执行构建却会把所有的文件都重复编译一遍，这样的重复工作是否可以被缓存下来呢，就像浏览器加载资源一样？答案肯定是可以的，其实大部分 Loader 都提供了 cache 配置项，比如在 `babel-loader` 中，可以通过设置 [cacheDirectory](https://webpack.docschina.org/loaders/babel-loader/#%E9%80%89%E9%A1%B9) 来开启缓存，这样，`babel-loader` 就会将每次的编译结果写进硬盘文件（默认是在项目根目录下的`node_modules/.cache/babel-loader`目录内，当然你也可以自定义）。

但如果 loader 不支持缓存呢？我们也有方法。接下来介绍一款神器：[cache-loader](https://www.npmjs.com/package/cache-loader) ，它所做的事情很简单，就是 `babel-loader` 开启 cache 后做的事情，将 loader 的编译结果写入硬盘缓存，再次构建如果文件没有发生变化则会直接拉取缓存。而使用它的方法很简单，正如官方 demo 所示，只需要把它卸载在代价高昂的 loader 的最前面即可：

```js
module.exports = {
  module: {
    rules: [
      {
        test: /\.ext$/,
        use: ['cache-loader', ...loaders],
        include: path.resolve('src'),
      },
    ],
  },
};
```

> **小贴士**：`cache-loader` 默认将缓存存放的路径是项目根目录下的 `.cache-loader` 目录内，我们习惯将它配置到项目根目录下的 `node_modules/.cache` 目录下，与 `babel-loader` 等其他 Plugin 或者 Loader 缓存存放在一块

同理，同样对于构建流程造成效率瓶颈的代码压缩阶段，也可以通过缓存解决大部分问题，以 `uglifyjs-webpack-plugin` 这款对于我们最常用的 Plugin 为例，它就提供了如下配置：

```js
module.exports = {
  optimization: {
    minimizer: [
      new UglifyJsPlugin({
        cache: true,
        parallel: true,
      }),
    ],
  },
};
```

我们可以通过开启 cache 配置开启我们的缓存功能，也可以通过开启 parallel 开启多核编译功能，这也是我们下一章节马上就会讲到的知识。而另一款我们比较常用于压缩 CSS 的插件—— `optimize-css-assets-webpack-plugin`，目前我还未找到有对缓存和多核编译的相关支持，如果读者在这块领域有自己的沉淀，欢迎在评论区提出批正。

> **小贴士**：目前而言笔者暂不建议将缓存逻辑集成到 CI 流程中，因为目前还仍会出现更新依赖后依旧命中缓存的情况，这显然是个 BUG，在开发机上我们可以手动删除缓存解决问题，但在编译机上过程就要麻烦的多。为了保证每次 CI 结果的纯净度，这里建议在 CI 过程中还是不要开启缓存功能。

### 2.2. 多核

这里的优化手段大家肯定已经想到了，自然是我们的 [`happypack`](https://github.com/amireh/happypack)。这似乎已经是一个老生常谈的话题了，从3时代开始，happypack 就已经成为了众多 webpack 工程项目接入多核编译的不二选择，几乎所有的人，在提到 webpack 效率优化时，怎么样也会说出 happypack 这个词语。所以，在前端社区繁荣的今天，从 happypack 出现的那时候起，就有许多优秀的质量文如雨后春笋般层出不穷。所以今天在这里，对于 happypack 我就不做过多细节上的介绍了，想必大家对它也再熟悉不过了，我就带着大家简单回顾一下它的使用方法吧。

```js
const HappyPack = require('happypack')
const os = require('os')


const happyThreadPool = HappyPack.ThreadPool({ size: os.cpus().length })

module.exports = {
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: 'happypack/loader?id=js',
      },
    ],
  },
  plugins: [
    new HappyPack({
      id: 'js',
      threadPool: happyThreadPool,
      loaders: [
        {
          loader: 'babel-loader',
        },
      ],
    }),
  ],
}
```

所以配置起来逻辑其实很简单，就是用 happypack 提供的 Plugin 为你的 Loaders 做一层包装就好了，向外暴露一个id ，而在你的 `module.rules` 里，就不需要写loader了，直接引用这个 id 即可，所以赶紧用 happypack 对那些你测出来的代价比较昂贵的 loaders 们做一层多核编译的包装吧。

而对于一些编译代价昂贵的 webpack 插件，一般都会提供 **parallel** 这样的配置项供你开启多核编译，因此，只要你善于去它的官网发现，一定会有意想不到的收获噢～

**PS**：这里需要特别提及一个在 `production` 模式下容易遇到的坑，因为有个特殊的角色出现了 —— `mini-css-extract-plugin`，坑在哪呢？有两点（这也是笔者在书写本文时还未解决的问题）：

1.  MiniCssExtractPlugin 无法与 happypack 共存，如果用 happypack 对 MiniCssExtractPlugin 进行包裹，就会触发这个问题：[github.com/amireh/happ…](https://github.com/amireh/happypack/issues/242) 。
2.  MiniCssExtractPlugin 必须置于 `cache-loader` 执行之后，否则无法生效，参考issue：[github.com/webpack-con…](https://github.com/webpack-contrib/cache-loader/issues/40) 。

所以最后，在 `production` 模式下的 CSS Rule 配置就变成了下面这样：

```js
module.exports = {
    ...,
    module: {
        rules: [
            ...,
            {
                test: /\.css$/
                exclude: /node_modules/,
                use: [
                    _mode === 'development' ? 'style-loader' : MiniCssExtractPlugin.loader,
                    'happypack/loader?id=css'
                ]
            }
        ]
    },
    plugins: [
        new HappyPack({
          id: 'css',
          threadPool: happyThreadPool,
          loaders: [
            'cache-loader',
            'css-loader',
            'postcss-loader',
          ],
        }),
    ],
}
```

### 2.3. 抽离

对于一些不常变更的静态依赖，比如我们项目中常见的 React 全家桶，亦或是用到的一些工具库，比如 lodash 等等，我们不希望这些依赖被集成进每一次构建逻辑中，因为它们真的太少时候会被变更了，所以每次的构建的输入输出都应该是相同的。因此，我们会设法将这些静态依赖从每一次的构建逻辑中抽离出去，以提升我们每次构建的构建效率。常见的方案有两种，一种是使用 [`webpack-dll-plugin`](https://webpack.docschina.org/plugins/dll-plugin/) 的方式，在首次构建时候就将这些静态依赖单独打包，后续只需要引用这个早就被打好的静态依赖包即可，有点类似“预编译”的概念；另一种，也是业内常见的 [`Externals`](https://webpack.docschina.org/configuration/externals/)的方式，我们将这些不需要打包的静态资源从构建逻辑中剔除出去，而使用 CDN 的方式，去引用它们。

那对于这两种方式，我们又该如何选择呢？

#### 2.3.1.webpack-dll-plugin 与 Externals 的抉择

团队早期的项目脚手架使用的是 webpack-dll-plugin 进行静态资源抽离，之所以这么做的原因是因为原先也是使用的 Externals，但是由于公司早期 CDN 服务并不成熟，项目使用了线上开源的 CDN 却因为服务不稳定导致了团队项目出现问题的情况，所以在一次迭代中统一替换成了 webpack-dll-plugin，但随着公司建立起了成熟的 CDN 服务后，团队的脚手架却因为各种原因迟迟没再更新。

而我，是坚定的 Externals 的支持着，这不是心之所向，先让我们来细数 webpack-dll-plugin 的三宗原罪：

1.  需要配置在每次构建时都不参与编译的静态依赖，并在首次构建时为它们预编译出一份 JS 文件（后文将称其为 lib 文件），每次更新依赖需要手动进行维护，一旦增删依赖或者变更资源版本忘记更新，就会出现 Error 或者版本错误。
    
2.  无法接入浏览器的新特性 script type="module"，对于某些依赖库提供的原生 ES Modules 的引入方式（比如 vue 的[新版引入方式](https://cn.vuejs.org/v2/guide/installation.html#CDN)）无法得到支持，没法更好地适配高版本浏览器提供的优良特性以实现更好地性能优化。
    
3.  将所有资源预编译成一份文件，并将这份文件显式注入项目构建的 HTML 模板中，这样的做法，在 HTTP1 时代是被推崇的，因为那样能减少资源的请求数量，但在 HTTP2 时代如果拆成多个 CDN Link，就能够更充分地利用 HTTP2 的多路复用特性。口说无凭，直接上图验证结论：
    

这，就是我选择 Externals 的原因。

但是，如果你的公司没有成熟的 CDN 服务，但又想对项目中的静态依赖进行抽离该怎么办呢？那笔者的建议还是选择 `webpack-dll-plugin` 来优化你的构建效率。如果你还是觉得每次更新依赖都需要去维护一个 lib 文件特别麻烦，那我还是特别提醒你，在使用 Externals 时选择一个靠谱的 CDN 是一件特别重要的事，毕竟这些依赖比如 React 都是你网站的骨架，少了他们可是连站点都运行不起来了噢。

#### 2.3.2.如何更为优雅地编写 Externals

我们都知道，在使用 Externals 的时候，还需要同时去更新 HTML 里面的 CDN，有时候时常会忘记这一过程而导致一些错误发生。那作为一名追求极致的前端，我们是否可以尝试利用现有资源将这一过程自动化呢？

这里我就给大家提供一个思路，我们先来回顾及分析一下，在我们配置 Externals 时，需要配置那些部分。

首先，在 `webpack.config.js` 配置文件内，我们需要添加 webpack 配置项：

```js
module.exports = {
  ...,
  externals: {
    
    
    "react": "React",
    "react-dom": "ReactDOM",
    "redux": "Redux",
    "react-router-dom": "ReactRouterDOM"
  }
}
```

与此同时，我们需要在模板 HTML 文件中同步更新我们的 CDN script 标签，一般一个常见的 CDN Link 就像这样：

`https://cdn.bootcss.com/react/16.9.0/umd/react.production.min.js`

这里以 BootCDN 提供的静态资源 CDN 为例（但不代表笔者推荐使用 BootCDN 提供的 CDN 服务，它上次更换域名的事件可真是让我踩了不少坑），我们可以发现，一份 CDN Link 其实主要也只是由四部分组成，它们分别是：CDN 服务 host、包名、版本号以及包路径，其他 CDN 服务也是同理。以上面的 Link 为例，这四部分对应的内容就是：

*   CDN 服务 host：[cdn.bootcss.com/](https://cdn.bootcss.com/)
*   包名：react
*   版本号：16.9.0
*   包路径：umd/react.production.min.js

到了这一步，大家应该想到了吧。我们完全可以自己编写一个 webpack 插件去自动生成 CDN Link script 标签并挂载在 html-webpack-plugin 提供的事件钩子上以实现自动注入 HTML，而我们所需要的一个 CDN Link 的四部分内容，CDN 服务 host 我们只需要与公司提供的服务统一即可，包名我们可以通过 `compiler.options.externals` 拿到，而版本号我们只需要读取项目的 `package.json` 文件即可，最后的包路径，一般都是一个固定的值。

具体代码实现我就不作详细介绍了，团队在项目脚手架更新迭代期间，笔者已经根据公司提供的 CDN 服务定制了一款 Webpack 插件，实现逻辑就如上述所示，所以后续工程师们就不再需要去关注同步 script 标签了，一切都被集成进 Plugin 逻辑自动化处理了，当然，大家如果对插件的源码有兴趣，可以在评论区提出噢～笔者会考虑作为团队的开源项目贡献给社区。

### 2.4. 拆分

虽然说在大前端时代下，SPA 已经成为主流，但我们不免还是会有一些项目需要做成 MPA（多页应用），得益于 webpack 的多 entry 支持，因此我们可以把多页都放在一个 repo 下进行管理和维护。但随着项目的逐步深入和不断迭代，代码量必然会不断增大，有时候我们只是更改了一个 entry 下的文件，但是却要对所有 entry 执行一遍构建，因此，这里为大家介绍一个**集群编译**的概念：

![](https://user-gold-cdn.xitu.io/2019/8/24/16cc41f028df03e3?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

什么是集群编译呢？这里的集群当然不是指我们的真实物理机，而是我们的 docker。其原理就是将单个 entry 剥离出来维护一个独立的构建流程，并在一个容器内执行，待构建完成后，将生成文件打进指定目录。为什么能这么做呢？因为我们知道，webpack 会将一个 entry 视为一个 chunk，并在最后生成文件时，将 chunk 单独生成一个文件，

因为如今团队在实践前端微服务，因此每一个子模块都被拆分成了一个单独的repo，因此我们的项目与生俱来就继承了集群编译的基因，但是如果把这些子项目以 entry 的形式打在一个 repo 中，也是一个很常见的情况，这时候，就需要进行拆分，集群编译便能发挥它的优势。因为团队里面不需要进行相关实践，因此这里笔者就不提供细节介绍了，只是为大家提供一个方向，如果大家有疑问也欢迎在评论区与我讨论。

3\. 提升体验
--------

这里主要是介绍几款 webpack 插件来帮助大家提升构建体验，虽然说它们在提升构建效率上对你没有什么太大的帮助，但能让你在等待构建完成的过程中更加舒服。

### 3.1. [progress-bar-webpack-plugin](https://www.npmjs.com/package/progress-bar-webpack-plugin)

这是一款能为你展示构建进度的 Plugin，它的使用方法和普通 Plugin 一样，也不需要传入什么配置。下图就是你加上它之后，在你的终端面板上的效果，在你的终端底部，将会有一个构建的进度条，可以让你清晰的看见构建的执行进度：

![](https://user-gold-cdn.xitu.io/2019/8/24/16cc41f3e68265ee?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

### 3.2. [webpack-build-notifier](https://www.npmjs.com/package/webpack-build-notifier)

这是一款在你构建完成时，能够像微信、Lark这样的APP弹出消息的方式，提示你构建已经完成了。也就是说，当你启动构建时，就可以隐藏控制台面板，专心去做其他事情啦，到“点”了自然会来叫你，它的效果就是下面这样，同时还有提示音噢～

![](https://user-gold-cdn.xitu.io/2019/8/24/16cc41f7afb6ad5a?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

### 3.3. webpack-dashboard

当然，如果你对 webpack 原始的构建输出不满意的话，也可以使用这样一款 Plugin 来优化你的输出界面，它的效果就是下面这样，这里我就直接上官图啦：

![](https://user-gold-cdn.xitu.io/2019/8/24/16cc41fd02456c61?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

4\. 总结
------

综上所述，其实本质上，我们对与webpack构建效率的优化措施也就两个大方向：缓存和多核。缓存是为了让二次构建时，不需要再去做重复的工作；而多核，更是充分利用了硬件本身的优势（我相信现如今大家的电脑肯定都是双核以上了吧，我自己这台公司发的低配 MAC 都有双核），让我们的复杂工作都能充分利用我们的 CPU。而将这两个方向化为实践的主角，也是我们前面介绍过的两大王牌，就是：`cache-loader` 和 `happypack`，所以你只要知道它并用好它，那你就能做到更好的构建优化实践。所以，别光看看，快拿着你的项目动手实践下，让你优化后的团队项目在你的 leader 面前眼前一亮吧！

**但是，大家一定要记着，这些东西并不是说用了效果就一定会是最好的，我们一定要切记把它们用在刀刃上，就是那些在第一阶段我们通过打点得出的构建代价高昂的 Loader 或者 Plugin，因为我们知道，像本地缓存就需要读写硬盘文件，系统IO需要时间，像启动多核也需要 IPC 通信时间，也就是说，如果本来构建时长就不长的模块，有可能因为添加了缓存或者多核会有得不偿失的结果，因此这些优化手段也需要合理的分配和使用。** 

如今，webpack 自身也在不断的迭代与优化，它早就已经不是两三年前那个一直让我们吐槽构建慢、包袱重的构建新星了，之所以会成为主流，也正是因为 webpack 团队已经在效率及体验上为我们做出很多了，而我们需要做的，已经很少了，而且我坚信，将来还会更少。

![](https://user-gold-cdn.xitu.io/2019/8/24/16cc4238a8c7d350?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)



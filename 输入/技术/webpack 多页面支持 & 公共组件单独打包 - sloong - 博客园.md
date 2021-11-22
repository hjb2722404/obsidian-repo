webpack 多页面支持 & 公共组件单独打包 - sloong - 博客园

# webpack - 多页面/入口支持 & 公共组件单独打包

**webpack系列目录**

- [webpack 系列 一：模块系统的演进](http://www.cnblogs.com/sloong/p/5570774.html)
- [webpack 系列 二：webpack 介绍&安装](http://www.cnblogs.com/sloong/p/5584684.html)
- [webpack 系列 三：webpack 如何集成第三方js库](http://www.cnblogs.com/sloong/p/5689135.html)
- [webpack 系列 四：webpack 多页面支持 & 公共组件单独打包](http://www.cnblogs.com/sloong/p/5689162.html)
- [webpack 系列 五：webpack Loaders 模块加载器](http://www.cnblogs.com/sloong/p/5826818.html)
- [webpack 系列 六：前端项目模板-webpack+gulp实现自动构建部署](http://www.cnblogs.com/sloong/p/5826859.html)

本系列并非全部原创，如非原创，正文篇首会注明转载地址

基于webpack搭建纯静态页面型前端工程解决方案模板， 最终形态源码见github: https://github.com/ifengkou/webpack-template

## 正文

本篇主要介绍：如何自动构建入口文件，并生成对应的output；公共js库如何单独打包。
多入口文件，自动扫描入口。同时支持SPA和多页面型的项目
公共js库如何单独打包。

上一篇示例，主要介绍如何集成第三方js库到项目中使用，如jquery。示例的入口只有一个index，而且是将公共js库连同page.js一起打包到output.js中。那么在开发中会出现，每新增一个页面模块，就需要修改webpack.config.js配置文件（增加一个入口），而且如果用到的第三方库比较多，这样也容易导致jquery,React等代码库重复被合并到打包后的js，导致js体积过大，页面加载时间过长

### 基础结构和准备工作

以下示例基于上一篇进行改进，上一篇项目源码
目录结构说明

	.
	├── package.json              # 项目配置
	├── src                       # 源码目录
	│   ├── pageA.html                # 入口文件a
	│   ├── pageB.html                # 入口文件b
	│   ├── css/                  # css资源
	│   ├── img/                  # 图片资源
	│   ├── js                    # js&jsx资源
	│   │   ├── pageA.js              # a页面入口
	│   │   ├── pageB.js              # b页面入口
	│   │   ├── lib/              # 没有存放在npm的第三方库或者下载存放到本地的基础库，如jQuery、Zepto、avalon
	│   ├── pathmap.json          # 手动配置某些模块的路径，可以加快webpack的编译速度
	├── webpack.config.js         # webpack配置入口

## 一：自动构建入口

### 官方多入口示例

webpack默认支持多入口，官方也有[多入口的示例](https://github.com/webpack/webpack/tree/master/examples/multiple-entry-points)。配件文件webpack.config.js如下

	//已简化
	var path = require("path");
	module.exports = {
	    entry: {
	        pageA: "./pageA",
	        pageB: "./pageB"
	    },
	    output: {
	        path: path.join(__dirname, "js"),
	        filename: "[name].bundle.js",
	        chunkFilename: "[id].chunk.js"
	    }
	}

每新增一个页面就需要在webpack.config.js的entry 中增加一个 pageC:"./pageC"，页面少还好，页面一多，就有点麻烦了，而且配置文件，尽可能不改动。那么如何支持不修改配置呢？

### 自动构建入口函数

entry实际上是一个map对象，结构如下{filename:filepath}，那么我们可以根据文件名匹配，很容易构造自动扫描器：
npm 中有一个用于文件名匹配的 glob模块，通过glob很容易遍历出src/js目录下的所有js文件：
安装glob模块
`$ npm install glob --save-dev`

修改webpack.config.js 配置，新增entries函数，修改entry:entries()，修改output的filename为"[name].js"

	//引入glob
	var glob = require('glob')
	//entries函数
	var entries= function () {
	    var jsDir = path.resolve(srcDir, 'js')
	    var entryFiles = glob.sync(jsDir + '/*.{js,jsx}')
	    var map = {};
	
	    for (var i = 0; i < entryFiles.length; i++) {
	        var filePath = entryFiles[i];
	        var filename = filePath.substring(filePath.lastIndexOf('\/') + 1, filePath.lastIndexOf('.'));
	        map[filename] = filePath;
	    }
	    return map;
	}
	//修改入口，已经修改outp的filename
	module.exports = {
	    //entry: "./src/js/index.js",
	    entry: entries(),
	    output: {
	        path: path.join(__dirname, "dist"),
	        filename: "[name].js"
	    },
	    ......
	    //以下省略，可以见下文详细配置

### 测试

1. 在src/js目录中新增pageA.js

	//js只有两行代码，在body中加一句话
	var $ = require("jquery")
	$("<div>这是jquery生成的多页面示例</div>").appendTo("body")

2. 新增pageA.html，也顺便修改原来的index.html 对于js文件名的更改

	<!DOCTYPE html>
	<html lang="en">
	<head>
	<meta charset="UTF-8">
	<title></title>
	</head>
	<body>
	<script src="../dist/index.js"></script>
	</body>
	</html>

3. 执行webpack，启动dev-server

	$ webpack
	$ webpack-dev-server

![718344-20160831173154246-767564206.png](../_resources/43e76e7807eb56cd4c022f6a502f7e0d.png)
OK，成功打包生成pageA.js,成功运行

## 二：公共库单独打包

先来分析下，上个步骤打包的日志：
![718344-20160831173205183-921864790.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132538.png)
index.js 依赖了avalon 和 jquery，然后打包后的index.js 有480kb
pageA.js 只用了jquery，然后打包后的js 有294kb
那么如果引用的lib库多一点，又被很多页面引用，那么lib库就会被重复打包到page.js中去，模块越多重复加载的情况越严重。

如果把**公共代码提取**出来作为单独的js，那么就到处可以**复用**，浏览器也就可以进行**缓存**，这时候就需要用到webpack内置插件WebPack.optimize.CommonsChunkPlugin

### CommonsChunkPlugin 介绍

**使用**
`new webpack.optimize.CommonsChunkPlugin(options)`
**Options**

翻译得比较简单，详见[官方说明](http://webpack.github.io/docs/list-of-plugins.html#commonschunkplugin):

- options.name or options.names(string|string[]): 公共模块的名称
- options.filename (string): 公开模块的文件名（生成的文件名）
- options.minChunks (number|Infinity|function(module,count) - boolean): 为number表示需要被多少个entries依赖才会被打包到公共代码库；为Infinity 仅仅创建公共组件块，不会把任何modules打包进去。并且提供function，以便于自定义逻辑。
- options.chunks(string[]):只对该chunks中的代码进行提取。
- options.children(boolean):如果为true,那么公共组件的所有子依赖都将被选择进来
- options.async(boolean|string):如果为true,将创建一个 option.name的子chunks（options.chunks的同级chunks） 异步common chunk
- options.minSize(number):所有公共module的size 要大于number，才会创建common chunk

2个常用的例子，更多例子见[官方说明](http://webpack.github.io/docs/list-of-plugins.html#commonschunkplugin):

1.Commons chunk for entries：针对入口文件提取公共代码

	new CommonsChunkPlugin({
	  name: "commons",
	  // (the commons chunk name)
	
	  filename: "commons.js",
	  // (the filename of the commons chunk)
	
	  // minChunks: 3,
	  // (Modules must be shared between 3 entries)
	
	  // chunks: ["pageA", "pageB"],
	  // (Only use these entries)
	})

2.Explicit vendor chunk：直接指定第三方依赖库，打包成公共组件

	entry: {
	  vendor: ["jquery", "other-lib"],
	  app: "./entry"
	}
	new CommonsChunkPlugin({
	  name: "vendor",
	
	  // filename: "vendor.js"
	  // (Give the chunk a different name)
	
	  minChunks: Infinity,
	  // (with more entries, this ensures that no other module
	  //  goes into the vendor chunk)
	})

### CommonsChunkPlugin使用

基于上篇的项目，参考上面的第二个例子，我们将jquery 和 avalon 提取出来打包成vendor.js
完整的webpack.config.js 如下：
```js
var webpack = require("webpack");
var path = require("path");
var srcDir = path.resolve(process.cwd(), 'src');
var nodeModPath = path.resolve(__dirname, './node_modules');
var pathMap = require('./src/pathmap.json');
var glob = require('glob')
var CommonsChunkPlugin = webpack.optimize.CommonsChunkPlugin;
var entries= function () {
var jsDir = path.resolve(srcDir, 'js')
var entryFiles = glob.sync(jsDir + '/*.{js,jsx}')
var map = {};

	    for (var i = 0; i < entryFiles.length; i++) {
	        var filePath = entryFiles[i];
	        var filename = filePath.substring(filePath.lastIndexOf('\/') + 1, filePath.lastIndexOf('.'));
	        map[filename] = filePath;
	    }
	    return map;
	}

	module.exports = {
	    //entry: "./src/js/index.js",
	    //entry: entries(),
	    entry: Object.assign(entries(), {
	        // 用到什么公共lib（例如jquery.js），就把它加进vendor去，目的是将公用库单独提取打包
	        'vendor': ['jquery', 'avalon']
	    }),
	    output: {
	        path: path.join(__dirname, "dist"),
	        filename: "[name].js"
	    },
	    module: {
	        loaders: [
	            {test: /\.css$/, loader: 'style-loader!css-loader'}
	        ]
	    },
	    resolve: {
	        extensions: ['.js', "", ".css"],
	        root: [srcDir,nodeModPath],
	        alias: pathMap,
	        publicPath: '/'
	    },
	    plugins: [
	        new CommonsChunkPlugin({
	            name: 'vendor',
	            minChunks: Infinity
	        })
	    ]
	}
```

### 测试、验证

1. 修改入口(Object.assign 是html5.js里面的....)

	//entry: entries(),
	entry: Object.assign(entries(), {
	    // 用到什么公共lib（例如jquery.js），就把它加进vendor去，目的是将公用库单独提取打包
	    'vendor': ['jquery', 'avalon']
	}),

2. 加入插件CommonsChunkPlugin

	var CommonsChunkPlugin = webpack.optimize.CommonsChunkPlugin;
	config 中增加 plugins
	    plugins: [
	        new CommonsChunkPlugin({
	            name: 'vendor',
	            minChunks: Infinity
	        })
	    ]

3. 修改index.html 和 pageA.html，增加对verdor.js的引用

	<script src="../dist/vendor.js"></script>
	<script src="../dist/index.js"></script>
	//<script src="../dist/pageA.js"></script>

4. 执行webpack
`$ webpack`
![718344-20160831173230371-524113608.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132548.png)
**结果分析**

可以看到index.js 就只有457 bytes了，pageA.js 227bytes。vendor.js 是集成了jquery+avalon，所以有488kb。

这样vendor.js 就可以重复利用了，也方便浏览器进行缓存。
调试过程中发现
`Uncaught ReferenceError: webpackJsonp is not defined`
这个是因为当时把vendor.js引入 放到了page.js 后面，导致page.js执行异常，所以，请一定把vendor.js 放在前面。
生成后的index.js就很轻便了，第三方库都被打包到vendor中了，代码如下:

	webpackJsonp([0],[
	/* 0 */
	/***/ function(module, exports, __webpack_require__) {
	
	    /**
	     * Created by sloong on 2016/6/1.
	     */
	    //avalon 测试
	    var avalon = __webpack_require__(1);
	    avalon.define({
	        $id: "avalonCtrl",
	        name: "Hello Avalon!"
	    });
	
	    /*
	    //zepto 测试
	    require("zepto")
	
	    $("<div>这是zepto生成的</div>").appendTo("body")*/
	
	    //jquery 测试
	    var $ = __webpack_require__(2)
	    $("<div>这是jquery生成的</div>").appendTo("body")
	
	/***/ }
	]);

页面测试均正常
![718344-20160831173238574-811870637.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132554.png)

OK，本篇结束了。如何让webpack 自动在html文件中引入所需js的`script`标签，如何给js和css文件加了hash值，这样浏览器每次都能检测到文件变更，而且也不需要手动修改引入的js文件链接，这些操作webpack都能轻松搞定
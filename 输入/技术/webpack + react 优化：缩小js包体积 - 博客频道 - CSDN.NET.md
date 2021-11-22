webpack + react 优化：缩小js包体积 - 博客频道 - CSDN.NET

[原](webpack%20+%20react%20优化：缩小js包体积%20-%20博客频道%20-%20CSDN.NET.md#)

### [webpack + react 优化：缩小js包体积](http://blog.csdn.net/code_for_free/article/details/51583737)

 分类：*前端**React*


### 一，前言

学校这边的项目刚组建好开发团队，前一段时间都在考虑如何前后端分离，如何多人协作开发的问题，恰好上一周陪女朋友去承德写生，能暂时放下工作和学校的事物，有了更多的思考时间。假期期间学习了webpack，并将前端代码进行了迁移，实现了前后端分离。

而**最近上线的时候发现打包压缩后的js包达到了477k,首屏渲染时间高达4s**，首屏渲染时间超过1.5s都是不能忍的，于是开始尝试研究一下webpack，毕竟只看了几个小时就拿来用了。

>
> 剧透，剧透，后面优化到284k，首屏渲染1.5s-2s。
>

> 这个时候想起以前boss和我聊职业规划的时候说过，**> “会用一项技术的人有很多，而出了问题懂得最大程度优化处理的人却没几个”**> ，虽然他举的例子是搜索引擎优化，要高大上得多，但深入学习，积极对待的心态是一样的。谢谢他的引导。

### 二，思路

前面啰嗦有点多，下面简单说说这次优化的思路。要想解决问题，必先了解问题，我去看了打包后的js，发现了一些问题及优化点。
1. js确实混淆压缩了，可是里面含有大量的开源库的copyright信息，可以去掉。
>

> （开源大牛们要相信我是尊重以及无敌崇拜你们的，为了性能暂时去掉这些信息，后期会在产品上单开一个页面说明自己用了哪些库以及给出链接*> （Facebook和Instagram都这样）*> ）

2. 引入的React没有切换到产品版本，React给出了下面的提示，良心！

> Warning: It looks like you’re using a minified copy of the development build of React. When deploying React apps to production, make sure to use the production build which skips development warnings and is faster. See > [http://facebook.github.io/react/downloads.html>  for more details.

3. 之前将css也打包进js里面了，因为css和js并行加载，所以可以将css分离出来，因为js远大于css，所以首屏渲染时间绝大部分只受js下载时间影响，看图：

![css,js下载时间](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132443.png)

### 三，动手

①压缩时去掉js所有注释，包括copyright信息。
在webpack.config.js文件的plugins数组里面添加及配置插件即可。
关于uglify的更多配置，请[点击这里](https://github.com/mishoo/UglifyJS2#usage).

	    new webpack.optimize.UglifyJsPlugin({
	      output: {
	        comments: false,  // remove all comments
	      },
	      compress: {
	        warnings: false
	      }
	    })



从477k 缩小到了408k，go ahead.
②将React切换到产品环境，参考如下：
>

> [> React doesn’t switch to production mode](http://stackoverflow.com/questions/37311972/react-doesnt-switch-to-production-mode)

同样在plugins里面添加：

	    new webpack.DefinePlugin({
	      'process.env': {
	          NODE_ENV: JSON.stringify(process.env.NODE_ENV),
	      },
	    }),


这时候注意打包的时候要带上node的环境设置，例如：
`NODE_ENV=production webpack --config webpack.production.config.js --progress`


从408k缩小到326k，还可以更进一步。
③分离css
先安装webpack插件：
`npm install extract-text-webpack-plugin --save`


在webpack配置文件中使用插件：

	var ExtractTextPlugin = require("extract-text-webpack-plugin");
	
	...
	
	    loaders:[
	      {
	          test: /\.css$/,
	          loader: ExtractTextPlugin.extract("style-loader", "css-loader")
	      },
	      {
	          test: /\.less$/,
	          loader: ExtractTextPlugin.extract("style-loader", "css-loader!less-loader")
	      },
	
	      ...
	
	...
	
	plugins: [
	    ...
	
	    new ExtractTextPlugin("bundle.css")
	]


最后326k = 284k（js） + 37.6k（css）.

#### **附上完整的webpage配置文件：**

	var webpack = require('webpack');
	var path = require('path');
	var ExtractTextPlugin = require("extract-text-webpack-plugin");
	
	module.exports = {
	  entry: [
	    path.resolve(__dirname, 'app/main.jsx')
	  ],
	  output: {
	    path: __dirname + '/server/public',
	    publicPath: '/',
	    filename: './bundle.js'
	  },
	  module: {
	    loaders:[
	      {
	          test: /\.css$/,
	          loader: ExtractTextPlugin.extract("style-loader", "css-loader")
	      },
	      {
	          test: /\.less$/,
	          loader: ExtractTextPlugin.extract("style-loader", "css-loader!less-loader")
	      },
	      { test: /\.(jpg|png)$/, loader: "url" },
	      { test: /\.js[x]?$/, include: path.resolve(__dirname, 'app'), exclude:/node_modules/,loader: 'babel-loader' },
	    ]
	  },
	  resolve: {
	    extensions: ['', '.js', '.jsx'],
	  },
	  plugins: [
	    new webpack.optimize.UglifyJsPlugin({
	      output: {
	        comments: false,
	      },
	      compress: {
	        warnings: false
	      }
	    }),
	    new webpack.DefinePlugin({
	      'process.env': {
	          NODE_ENV: JSON.stringify(process.env.NODE_ENV),
	      },
	    }),
	    new ExtractTextPlugin("bundle.css")
	  ]
	};


### 四，更进一步

1.5s-2s的首屏渲染时间还不理想，但学校的项目要求也不高，不过对自己的要求应该一如既往，后期会尝试从下面几个方向去优化，希望能有更多的实践经验和大家分享。
1. 将js分离，不同页面加载不同的js；
2. 将React剥离出去，使用cdn;
3. 既然用了React，可以尝试后端渲染；
虽然还不完美，但是进步总是值得肯定的，一步步来吧。

* * *

### 2016-09-16更新

进一步优化：

[前端性能优化：webpack分离 + LocalStorage缓存](http://blog.csdn.net/code_for_free/article/details/52556896)
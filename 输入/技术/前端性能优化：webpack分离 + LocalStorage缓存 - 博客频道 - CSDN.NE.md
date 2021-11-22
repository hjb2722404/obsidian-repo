前端性能优化：webpack分离 + LocalStorage缓存 - 博客频道 - CSDN.NET

[原](前端性能优化：webpack分离%20+%20LocalStorage缓存%20-%20博客频道%20-%20CSDN.NE.md#)

### [前端性能优化：webpack分离 + LocalStorage缓存](http://blog.csdn.net/code_for_free/article/details/52556896)

 分类：*前端*

 ** （1271）  ** （1）

### 一，优化背景

上一篇关于webpack优化的文章[webpack + react 优化：缩小js包体积](http://blog.csdn.net/code_for_free/article/details/51583737)谈到如何缩小webpack打包后的js代码体积，来减少网络请求数据量，这次尝试将第三方库（React，ajax等）从业务代码中分离出来，并且将分离出来的第三方库缓存在LocalStorage中。

#### **该次优化的出发点有下面两点：**

>

> ①每次更改业务代码都会打包成新的`bundle.js`> ,前端需要抛弃以前的HTTP缓存重新下载249K左右的`bundle.js`> ,即使改变的业务代码很少。

>  ②尝试使用LocalStorage（移动端上兼容很好）
第一点是痛点，第二点是作为前端工程师学习研究用的，希望足够严谨不会给用户带来副作用。

#### **优化结果**

①webpack分离出业务代码和第三方库
分离前：
![webpack代码切分](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231175934.png)
分离后：`bundle.js` 为业务代码，`vendor.js`为第三方库代码（几乎不更新）
![webpack代码切分](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231175940.png)
②使用LocalStorage缓存第三方库到本地
缓存前：
![localstorage缓存前](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231175945.png)
缓存后：（少下了198KB的libs.js，注：这里的app对应上面的bundle.js，libs对应vendor.js）
![localstorage缓存前](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231175950.png)
下面上相关代码。

### 二，优化思路

#### ①将公用库分出来

这一部给出webpack配置文件即可，注意看注释部分：

	var webpack = require('webpack');
	var path = require('path');
	var ExtractTextPlugin = require("extract-text-webpack-plugin");
	
	module.exports = {
	  entry: {
	    //业务代码
	    bundle: path.resolve(__dirname, 'src/main.jsx'),
	    //第三方库
	    vendor: ["react","react-dom","react-router","@fdaciuk/ajax"]
	  },
	  //输出路径
	  output: {
	    path: __dirname + '/server/public',
	    publicPath: '/',
	    filename: './[name].js'
	  },
	  module: {
	    loaders:[
	      { test: /\.css$/, loader: ExtractTextPlugin.extract("style-loader", "css-loader") },
	      { test: /\.scss$/, loader: ExtractTextPlugin.extract("style-loader", "css-loader!sass-loader") },
	      { test: /\.(jpg|png)$/, loader: "url" },
	      { test: /\.js[x]?$/, include: path.resolve(__dirname, 'src'), exclude:/node_modules/, loader: 'babel-loader' },
	      { test: /\.woff$/, loader: "url-loader?prefix=font/&limit=5000&mimetype=application/font-woff" },
	      { test: /\.ttf$/, loader: "file-loader?prefix=font/" },
	      { test: /\.svg$/, loader: "file-loader?prefix=font/" }
	    ]
	  },
	  resolve: {
	    extensions: ['', '.web.js', '.js', '.json', '.jsx'],
	    modulesDirectories: ['node_modules', path.join(__dirname, '../node_modules')],
	  },
	  plugins: [
	    new webpack.optimize.DedupePlugin(),
	    new ExtractTextPlugin("bundle.css"),
	    //将第三方库打包到vendor.js
	    new webpack.optimize.CommonsChunkPlugin({ name: 'vendor' }),
	    new webpack.DefinePlugin({ 'process.env': { NODE_ENV: JSON.stringify(process.env.NODE_ENV), }, }),
	    new webpack.optimize.UglifyJsPlugin({ output: { comments: false, }, compress: { warnings: false } }),
	  ]
	};

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15
- 16
- 17
- 18
- 19
- 20
- 21
- 22
- 23
- 24
- 25
- 26
- 27
- 28
- 29
- 30
- 31
- 32
- 33
- 34
- 35
- 36
- 37
- 38
- 39
- 40
- 41
- 42

关于这部分深入的理解和学习可以看[webpack的示例](https://github.com/webpack/webpack/tree/master/examples/common-chunk-and-vendor-chunk).

#### ②将公用库缓存在LoaclStorage中

这一步比较好玩，涉及到的东西也比较多，先上学习参考资料：

1. [MDN：LocalStorage](https://developer.mozilla.org/en-US/docs/Web/API/Storage/LocalStorage)

2. [知乎：静态资源（JS/CSS）存储在localStorage有什么缺点？为什么没有被广泛应用？](https://www.zhihu.com/question/28467444)

3. [Dynamic script addition should be ordered?（动态添加的script标签会按顺序执行吗？）](http://stackoverflow.com/questions/2804212/dynamic-script-addition-should-be-ordered)

关于这一部分，有两个要点：

- LocalStorage缓存
- LocalStorage缓存版本控制

按照惯例：上源码

	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
	<title>Examples</title>
	<meta name="description" content="">
	<meta name="keywords" content="">
	<!-- 利用noscript, 使script标签不加载，不执行 -->
	<noscript>
	  <script src="vendor.js"></script>
	  <script src="bundle.js"></script>
	</noscript>
	<script>
	  //这则匹配获取两个script的src
	  var script_info = document.head.querySelector('noscript').innerText.split(/\s/).join('').match(/src="(.+)".*src="(.+)"/);
	  var vendor_src = script_info[1], bundle_src = script_info[2];
	  var vendor_script = document.createElement('script'),
	      bundle_script = document.createElement('script'); vendor_script.defer = true;
	  bundle_script.defer = true, bundle_script.src = bundle_src;
	  if (window.localStorage) {
	    var cur_version = vendor_src, vendor = null;
	    if (window.localStorage.getItem("vendor_version") == cur_version && window.localStorage.getItem("vendor")) {
	      //命中缓存
	      vendor = window.localStorage.getItem("vendor");
	      vendor_script.innerText = vendor;
	      document.head.appendChild(vendor_script);
	      document.head.appendChild(bundle_script);
	    } else {
	      //获取js代码
	      var httpRequest = new XMLHttpRequest();
	      httpRequest.onreadystatechange = function(){
	        if (httpRequest.readyState === XMLHttpRequest.DONE && httpRequest.status === 200 || httpRequest.status === 304) {
	          vendor = httpRequest.responseText;
	          vendor_script.innerText = vendor;
	          document.head.appendChild(vendor_script);
	          document.head.appendChild(bundle_script);
	          //以当前vendor的src链接作为key用于版本控制
	          window.localStorage.setItem("vendor_version", cur_version);
	          //存储实际代码
	          window.localStorage.setItem("vendor", vendor);
	        }
	        //should handle 500
	      }
	      httpRequest.open('GET', vendor_src, true);
	      httpRequest.send(null);
	    }
	  } else {
	    //不支持localstorage时的回退方案，直接将script标签添加到head
	    vendor_script.src = vendor_script;
	    document.head.appendChild(vendor_script);
	    document.head.appendChild(bundle_script);
	  }
	</script>
	<link href="bundle.css" rel="stylesheet">
	</head>
	<body>
	  DEMO
	</body>
	</html>

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15
- 16
- 17
- 18
- 19
- 20
- 21
- 22
- 23
- 24
- 25
- 26
- 27
- 28
- 29
- 30
- 31
- 32
- 33
- 34
- 35
- 36
- 37
- 38
- 39
- 40
- 41
- 42
- 43
- 44
- 45
- 46
- 47
- 48
- 49
- 50
- 51
- 52
- 53
- 54
- 55
- 56
- 57
- 58
- 59
- 60
- 61
- 62

代码没有什么高深的地方（毕竟水平有限，但是简单易懂有用的代码也挺好的），应该看完就知道大概了，可能你会疑惑：
>
**> 为什么用了`<noscript>`> 标签？**
这里回答一下，也是今早折腾了一小下的小亮点。
我的web后台使用了rails，我在后台给静态资源文件名加上了指纹作为缓存的依据，实际如下：
rails 后台模板：会自动找到加上自问的静态资源。
![rails 后台模板](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231180002.png)
生成的HTML：
![noscript](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231180020.png)

可见一旦文件内容发生变化，对应的文件名也发生了改变（HTTP缓存失效），因此可以用文件名来做LocalStorage缓存的版本。也正是因为文件名不确定，因此只能通过去找到相应的script标签的src才能获取资源。

那么问题就来，一开始我把vendor和bundle的script标签放在控制缓存的脚本后面，但是执行到缓存脚本时，页面还没解析到后面两个script标签，因此无法获取script的src。而把vendor和bundle的script标签放在控制缓存的脚本前面时，在执行缓存脚本前vendor和bundle脚本就已经开始下载了**（通过设置type=”text”或其他可以使script不执行）**，不够优雅。

解决思路如下：
1. <s>页面还没解析到后面两个script标签时能获取后面的信息吗？</s>（个人觉得不合常理，如果有方法，请分享，万分感谢）
2. **有什么办法能让前面的script不下载？** => `<noscript>`包裹即可，well done.

### 三，优化结果 && more

优化结果其实前面已经提及了，无非是首次加载web应用后就不需要再加载不常改变的`libs.js`（200k左右），值得注意的是，前面缓存前后的比较其实不严谨，因为都把HTTP cache关了，实际场景中设置了HTTP cache，所以其实LocalStorage优化不大，但是节省了用户流量是实实在在的。

优化完之后还有些疑惑：

1. 为什么vendor.js体积比所有库（`["react","react-dom","react-router","@fdaciuk/ajax"]`）加起来大？`vendor.js`里面肯定包含了webpack实现模块化的一些代码，但占这么大应该不科学，抽空应该好好看看webpack的实现原理。

2. LocalStorage是否比HTTP cache更加可靠？

### 四，一些想法

除了将第三方库缓存下来之外，是不是也可以将一些万年不变的图片缓存下来？例如各个分类都有个大图，很耗流量，现在的做法是减少尺寸，在清晰度上牺牲了一些。
最近也在看事件循环，zepto.js的event.js和touch.js，好多可以学习深入的地方，兴奋之余也在提醒自己，要踏踏实实攻城拔寨。
>
> 人生是一场马拉松，今日的领先和落后都不值一提，唯一值得关注的是你自身的不断成长。
自勉。
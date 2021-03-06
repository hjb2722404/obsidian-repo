彻底解决 webpack 打包文件体积过大

# 彻底解决 webpack 打包文件体积过大

 作者  [clinyong](http://www.jianshu.com/u/a9df4616a946)  [**关注]()
 2016.03.12 09:05*  字数 1098  阅读 30162评论 11喜欢 43

webpack 把我们所有的文件都打包成一个 JS 文件，这样即使你是小项目，打包后的文件也会非常大。下面就来讲下如何从多个方面进行优化。

## 去除不必要的插件

刚开始用 webpack 的时候，开发环境和生产环境用的是同一个 webpack 配置文件，导致生产环境打包的 JS 文件包含了一大堆没必要的插件，比如 `HotModuleReplacementPlugin`, `NoErrorsPlugin`... 这时候不管用什么优化方式，都没多大效果。所以，如果你打包后的文件非常大的话，先检查下是不是包含了这些插件。

## 提取第三方库

像 react 这个库的核心代码就有 627 KB，这样和我们的源代码放在一起打包，体积肯定会很大。所以可以在 webpack 中设置
```
	{
	  entry: {
	   bundle: 'app'
	    vendor: ['react']
	  }

	  plugins: {
	    new webpack.optimize.CommonsChunkPlugin('vendor',  'vendor.js')
	  }
	}
```
这样打包之后就会多出一个 `vendor.js` 文件，之后在引入我们自己的代码之前，都要先引入这个文件。比如在 `index.html` 中
```
	 <script src="/build/vendor.js"></script>
	 <script src="/build/bundle.js"></script>
```
除了这种方式之外，还可以通过引用外部文件的方式引入第三方库，比如像下面的配置
```
	{
	  externals: {
	     'react': 'React'
	  }
	}
```
`externals` 对象的 key 是给 `require` 时用的，比如 `require('react')`，对象的 value 表示的是如何在 global 中访问到该对象，这里是 `window.React`。这时候 `index.html` 就变成下面这样
```
	<script src="//cdn.bootcss.com/react/0.14.7/react.min.js"></script>
	<script src="/build/bundle.js"></script>
```
当然，个人更推荐第一种方式。

## 代码压缩

webpack 自带了一个压缩插件 [UglifyJsPlugin](https://webpack.github.io/docs/list-of-plugins.html#uglifyjsplugin)，只需要在配置文件中引入即可。
```
	{
	  plugins: [
	    new webpack.optimize.UglifyJsPlugin({
	      compress: {
	        warnings: false
	      }
	    })
	  ]
	}
```
加入了这个插件之后，编译的速度会明显变慢，所以一般只在生产环境启用。
另外，服务器端还可以开启 gzip 压缩，优化的效果更明显。

## 代码分割

什么是代码分割呢？我们知道，一般加载一个网页都会把全部的 js 代码都加载下来。但是对于 web app 来说，我们更想要的是只加载当前 UI 的代码，没有点击的部分不加载。

看起来好像挺麻烦，但是通过 webpack 的 [code split](https://webpack.github.io/docs/code-splitting.html) 以及配合 [react router](https://github.com/reactjs/react-router) 就可以方便实现。具体的例子可以看下 react router 的官方示例 [huge apps](https://github.com/reactjs/react-router/tree/master/examples/huge-apps)。不过这里还是讲下之前配置踩过的坑。

`code split` 是[不支持](https://webpack.github.io/docs/code-splitting.html#es6-modules) ES6 的模块系统的，所以在导入和导出的时候千万要注意，特别是导出。如果你导出组件的时候用 ES6 的方式，这时候不管导入是用 CommomJs 还是 AMD，都会失败，而且还不会报错！

当然会踩到这个坑也是因为我刚刚才用 NodeJS，而且一入门就是用 ES6 的风格。除了这个之外，还有一点也要注意，在生产环境的 webpack 配置文件中，要加上 `publicPath`
```
	output: {
	    path: xxx,
	    publicPath: yyy,
	    filename: 'bundle.js'
	}
```
不然的话，webpack 在加载 chunk 的时候，路径会出错。

## 设置缓存

开始这个小节之前，可以先看下大神的一篇文章：[大公司里怎样开发和部署前端代码](https://github.com/fouber/blog/issues/6)。

对于静态文件，第一次获取之后，文件内容没改变的话，浏览器直接读取缓存文件即可。那如果缓存设置过长，文件要更新怎么办呢？嗯，以文件内容的 MD5 作为文件名就是一个不错的解决方案。来看下用 webpack 应该怎样实现
```
	output: {
	    path: xxx,
	    publicPath: yyy,
	    filename: '[name]-[chunkhash:6].js'
	}
```
打包后的文件名加入了 hash 值
```
	const bundler = webpack(config)

	bundler.run((err, stats) => {
	  let assets = stats.toJson().assets
	  let name

	  for (let i = 0; i < assets.length; i++) {
	    if (assets[i].name.startsWith('main')) {
	      name = assets[i].name
	      break
	    }
	  }

	  fs.stat(config.buildTemplatePath, (err, stats) => {
	    if (err) {
	      fs.mkdirSync(config.buildTemplatePath)
	    }

	    writeTemplate(name)
	  })
	})
```
手动调用 webpack 的 API，获取打包后的文件名，通过 `writeTemplate` 更新 html 代码。完整代码猛戳 [gitst](https://gist.github.com/clinyong/b28ff4a8fa7906d01723)。

这样子，我们就可以把文件的缓存设置得很长，而不用担心更新问题。

 [**  前端](http://www.jianshu.com/nb/3504297)
© 著作权归作者所有

 [举报文章]()
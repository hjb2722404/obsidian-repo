webpack进阶构建项目(一) - 空智 - 博客园

## [webpack进阶构建项目(一)](http://www.cnblogs.com/tugenhua0707/p/5576262.html)

 2016-06-11 23:43 by 空智, 8234 阅读, 4 评论, [收藏](http://www.cnblogs.com/tugenhua0707/p/5576262.html#), [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=5576262)


1.理解webpack加载器

webpack的设计理念，所有资源都是“模块”，webpack内部实现了一套资源加载机制，这与Requirejs、Sea.js、Browserify等实现有所不同.

Webpack提供了一套加载器，比如css-loader,less-loader,style-loader，url-loader等，用于将不同的文件加载到js文件中，比如url-loader用于在js中加载png/jpg格式的图片文件，css/style loader用于加载css文件，less-loader加载器是将less编译成css文件；比如代码配置如下：

```
module.exports = {
entry: "./src/main.js",
output: {
filename: "build.js",
path: __dirname + '/assets/',
publicPath: "/assets/" },
module: {
loaders: [
{test: /.css$/, loader: 'style!css'},
{test: /.(png|jpg)$/, loader: 'url-loader?limit=8192'}
]
}
resolve: {
extensions: ['', '.js', '.jsx'], //模块别名定义，方便后续直接引用别名，无须多写长长的地址 alias: {
a : 'js/assets/a.js', // 后面直接引用 require(“a”)即可引用到模块 b : 'js/assets/b.js',
c : 'js/assets/c.js' }
},
plugins: [commonsPlugin, new ExtractTextPlugin("[name].css")]
}
```

**module.loader:** 其中test是正则表达式，对符合的文件名使用相应的加载器./.css$/会匹配 xx.css文件，但是并不适用于xx.sass或者xx.css.zip文件.

**url-loader:** 它会将样式中引用到的图片转为模块来处理; 配置信息的参数“?limit=8192”表示将所有小于8kb的图片都转为base64形式。

**entry:** 模块的入口文件。依赖项数组中所有的文件会按顺序打包，每个文件进行依赖的递归查找，直到所有模块都被打成包；
**output：**模块的输出文件，其中有如下参数：
 **filename:** 打包后的文件名
 **path:** 打包文件存放的绝对路径。
 **publicPath:** 网站运行时的访问路径。
**relolve.extensions:** 自动扩展文件的后缀名，比如我们在require模块的时候，可以不用写后缀名的。
**relolve.alias:** 模块别名定义，方便后续直接引用别名，无须多写长长的地址
**plugins** 是插件项;

2.html-webpack-plugin学习
首先来看看项目的目录结构如下：

![561794-20160611231428527-428194220.png.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132321.jpg)

package.json 如下：
```

{ "name": "html-webpack-plugin", "version": "1.0.0", "description": "", "main": "index.js", "scripts": { "test": "echo \"Error: no test specified\" && exit 1" }, "author": "", "license": "ISC", "devDependencies": { "html-webpack-plugin": "^2.19.0", "webpack": "^1.13.1" }

}
```
运行命令 npm install 把依赖包加载出来；
接着在 webpack.config.js配置如下：

```var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');

console.log(SRC_PATH)
module.exports = {
entry: SRC_PATH + "/js/index.js", //输出的文件名 合并以后的js会命名为index.js output: {
path: BUILD_PATH,

filename: 'index.js' }, //添加我们的插件 会自动生成一个html文件 plugins: [ new HtmlwebpackPlugin({

title: 'Hello World app' })
]
};
```
在项目中的根目录下 运行 webpack 就能生成buid文件夹了，里面会自动生成 两个文件 index.html和index.js文件；
index.html代码如下：


```
<!DOCTYPE html><html>  <head>  <meta charset="UTF-8">  <title>Hello World app</title>  </head>  <body>  <script type="text/javascript" src="index.js"></script></body></html>
```

标题title就是我们配置上的；
且合并了依赖的js文件；我们可以直接在本地访问index.html 可以看到能打印出依赖的文件js代码了；可以看到可以解决依赖的问题；
**html-webpack-plugin** 还支持如下配置：
**title:** 用于生成的HTML文件的标题。
**filename:** 用于生成的HTML文件的名称，默认是index.html。你可以在这里指定子目录。
**template:** 模板文件路径，支持加载器，比如 html!./index.html

**inject:** true | 'head' | 'body' | false ,注入所有的资源到特定的 template 或者 templateContent 中，如果设置为 true

或者 body，所有的 javascript 资源将被放置到 body 元素的底部，'head' 将放置到 head 元素中。
**favicon:** 添加特定的 favicon 路径到输出的 HTML 文件中。
**minify:**{ //压缩HTML文件
removeComments:true, //移除HTML中的注释
collapseWhitespace:true //删除空白符与换行符
}

**hash:** true | false, 如果为 true, 将添加一个唯一的 webpack 编译 hash 到所有包含的脚本和 CSS 文件，对于解除 cache 很有用。

**cache:** true | false，如果为 true, 这是默认值，仅仅在文件修改之后才会发布文件。
**showErrors:** true | false, 如果为 true, 这是默认值，错误信息会写入到 HTML 页面中
**chunks:** 允许只添加某些块 (比如，仅仅 unit test 块)

**chunksSortMode:** 允许控制块在添加到页面之前的排序方式，支持的值：'none' | 'default' | {function}-default:'auto'

**excludeChunks:** 允许跳过某些块，(比如，跳过单元测试的块)
比如我现在webpack.config.js配置改为如下：


```var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');

console.log(SRC_PATH)
module.exports = {
entry: SRC_PATH + "/js/index.js", //输出的文件名 合并以后的js会命名为index.js output: {
path: BUILD_PATH,

filename: 'index.js' }, //添加我们的插件 会自动生成一个html文件 plugins: [ new HtmlwebpackPlugin({

title: 'Hello World app',
filename: '1.0.0/home.html',
inject: true,
hash: true })
]
};
```


然后再在命令行中继续运行webpack命令，可以看到在build下会生成2个目录 第一个是build/1.0.1/home.html; 第二个是 build/index.js

再来看下home.html代码如下：


```
<!DOCTYPE html><html>  <head>  <meta charset="UTF-8">  <title>Hello World app</title>  </head>  <body>  <script type="text/javascript" src="../index.js?d03211ff5e0251af224d"></script></body></html>
```


可以看到设置 hash为true js的后缀会自动加一个hash编码，对于页面解决缓存很有用；
生成多个 HTML 文件
通过在配置文件中添加多次这个插件，来生成多个 HTML 文件。
webpack.config.js代码如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');

console.log(SRC_PATH)
module.exports = {
entry: SRC_PATH + "/js/index.js", //输出的文件名 合并以后的js会命名为index.js output: {
path: BUILD_PATH,

filename: 'index.js' }, //添加我们的插件 会自动生成一个html文件 plugins: [ new HtmlwebpackPlugin(), new HtmlwebpackPlugin({

title: 'Hello World app',
filename: 'app1/home.html',
template: 'src/html/index.html',
inject: true,
hash: true })
]
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
官网可以看这里 https://www.npmjs.com/package/html-webpack-plugin
也可以在配置项 加上minify选项 压缩HTML文件；代码如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');

console.log(SRC_PATH)
module.exports = {
entry: SRC_PATH + "/js/index.js", //输出的文件名 合并以后的js会命名为index.js output: {
path: BUILD_PATH,

filename: 'index.js' }, //添加我们的插件 会自动生成一个html文件 plugins: [ new HtmlwebpackPlugin({

title: 'Hello World app',

minify:{ //压缩HTML文件 removeComments:true, //移除HTML中的注释 collapseWhitespace:true  //删除空白符与换行符 }

})
]
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
查看html生成后的文件可以看到已经被压缩了；
[回到顶部](http://www.cnblogs.com/tugenhua0707/p/5576262.html#_labelTop)
3.压缩js与css
webpack已经内嵌了uglifyJS来完成对JS与CSS的压缩混淆，无需引用额外的插件。
压缩代码如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
new webpack.optimize.UglifyJsPlugin({ //压缩代码 compress: {
warnings: false },
except: ['$super', '$', 'exports', 'require'] //排除关键字})
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
这里需要注意的是压缩的时候需要排除一些关键字，不能混淆，比如$或者require，如果混淆的话就会影响到代码的正常运行。
webpack.config.js代码改为如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');var webpack = require("webpack");//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');

console.log(SRC_PATH)
module.exports = {

entry: { 'index' : SRC_PATH + "/js/index.js" }, //输出的文件名 合并以后的js会命名为index.js output: {

path: BUILD_PATH + '/js/',

filename: '[name].js' }, //添加我们的插件 会自动生成一个html文件 plugins: [ new HtmlwebpackPlugin({

title: 'Hello World app',

minify:{ //压缩HTML文件 removeComments:true, //移除HTML中的注释 collapseWhitespace:true  //删除空白符与换行符 }

}), new webpack.optimize.UglifyJsPlugin({ //压缩代码 compress: {
warnings: false },
except: ['$super', '$', 'exports', 'require'] //排除关键字 })
]
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
继续运行下webpack可以看到js已经被压缩了；**注意：但是貌似对es6的语法不能压缩~**
[回到顶部](http://www.cnblogs.com/tugenhua0707/p/5576262.html#_labelTop)
4.理解less-loader加载器的使用
 我们先来理解下less-loader加载器，其他的sass-loader也是一个意思，less-loader加载器是把css代码转化到style标签内，
动态插入到head标签内；我们先来看看我项目的结构如下：

*![561794-20160611232141511-1570327227.png.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132329.jpg)*

src/html/index.html代码如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

<!DOCTYPE html>  <html>  <head>  <meta http-equiv="content-type" content="text/html;charset=utf-8"  />  <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport"/>  <meta content="yes" name="apple-mobile-web-app-capable"  />  <meta content="black" name="apple-mobile-web-app-status-bar-style"  />  <meta content="telephone=no" name="format-detection"  />  <meta content="email=no" name="format-detection"  />  <meta name="description" content="基于webpack的前端工程化开发解决方案探索"/>  <title>动态生成html的实践</title>  </head>  <body>  <div>hello webpack</div>  </body></html>

[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
现在我想通过html-webpack-plugin插件动态生成 html页面及引入index.js 和 生成 index.js文件；
webpack.config.js代码配置如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');

module.exports = {
entry: SRC_PATH + "/js/index.js",
output: {
filename: "build.js",
path: BUILD_PATH
},
module: {
loaders: [ //.css 文件使用 style-loader 和 css-loader 来处理 {
test: /\.less$/,
loader: "style!css!less" }
]
},
resolve: {
extensions: ['', '.js', '.jsx']
},
plugins: [ new HtmlwebpackPlugin({
title: 'Hello World app',
filename: 'index.html',
template: 'src/html/index.html',
inject: true,
hash: true })
]
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

在项目的根目录运行webpack,即可动态生成html文件和js文件，打开生成后的index.html即可看到css生效了，且css被动态内链到head标签内了；

![561794-20160611232322527-1176141872.png.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132336.jpg)

其中less/main.less 文件如下代码：
@color: red;
body {
    background:@color;
}
如上可以看到less文件得到编译，且动态插入到head标签内；
[回到顶部](http://www.cnblogs.com/tugenhua0707/p/5576262.html#_labelTop)
5.理解babel-loader加载器
babel-loader加载器能将ES6的代码转换成ES5代码，我们需要安装babel-loader
**执行命令：**npm install babel-loader --save-dev
因此现在需要在webpack.config.js 加入babel-loader的加载器即可；如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');

module.exports = {
entry: SRC_PATH + "/js/index.js",
output: {
filename: "build.js",
path: BUILD_PATH
},
module: {
loaders: [ //.css 文件使用 style-loader 和 css-loader 来处理 {
test: /\.less$/,
loader: "style!css!less" },
{
test: /\.js$/, loader: 'babel' }
]
},
resolve: {
extensions: ['', '.js', '.jsx']
},
plugins: [ new HtmlwebpackPlugin({
title: 'Hello World app',
filename: 'index.html',
template: 'src/html/index.html',
inject: true,
hash: true })
]
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
a.js 假如是ES6的语法；比如如下一句代码：
// es6的语法
let LOADER = true;
module.exports = LOADER;
现在在index.js代码如下：
var aModule = require('../less/main.less');
console.log(aModule);
// es6的语法
var aMoudle = require('./a');
console.log(aMoudle);
可以看到打印 aMoudle的值为true；说明可以正确的解析了；
[回到顶部](http://www.cnblogs.com/tugenhua0707/p/5576262.html#_labelTop)
6.理解 extract-text-webpack-plugin(独立打包样式文件)
执行安装命令：
sudo npm install extract-text-webpack-plugin
然后再webpack.config.js 加入加载器配置项如下代码：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');var ExtractTextPlugin = require('extract-text-webpack-plugin');//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');

module.exports = {
entry: SRC_PATH + "/js/index.js",
output: {
filename: "build.js",
path: BUILD_PATH
},
module: {
loaders: [ //.css 文件使用 style-loader 和 css-loader 来处理 {
test: /\.less$/,
loader: ExtractTextPlugin.extract( 'css?sourceMap!' +
'less?sourceMap' )
},
{
test: /\.js$/, loader: 'babel' }
]
},
resolve: {
extensions: ['', '.js', '.jsx']
},

plugins: [ // 内联css提取到单独的styles的css  new ExtractTextPlugin("index.css"), new HtmlwebpackPlugin({

title: 'Hello World app',
filename: 'index.html',
template: 'src/html/index.html',
inject: true,
hash: true })
]
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

在项目的根目录运行 webpack 即可生效；会在build目录下 生成 index.css文件，且在打包后的index.html会自动引入link标签的css；

如下所示：

![561794-20160611232553746-1257781010.png.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132344.jpg)

如果页面上有多个less文件或者css文件的话，也可以通过 @import 动态导入；如下在main.less 引入 a.less代码如下：
@import './a.less';
a.less 是和main.less 同级目录下的；
[回到顶部](http://www.cnblogs.com/tugenhua0707/p/5576262.html#_labelTop)
7.webpack打包多个资源文件
 我们在开发页面的时候，有时候需要有多个入口文件，做到文件是按需加载，这样就可以使用缓存提升性能；
只需要像如下编码即可：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
module.exports = {
entry: { "main": "./src/a.js", "index": "./src/index.js" },
output: {
filename: "[name].js" }
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
webpack.config.js代码如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');var ExtractTextPlugin = require('extract-text-webpack-plugin');var webpack = require("webpack");//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');

module.exports = {
entry: { "a": SRC_PATH + "/js/a.js", "index": SRC_PATH + "/js/index.js",
},
output: {
filename: "[name].js",
path: BUILD_PATH
},
module: {
loaders: [ //.css 文件使用 style-loader 和 css-loader 来处理 {
test: /\.less$/,
loader: ExtractTextPlugin.extract( 'css?sourceMap!' +
'less?sourceMap' )
},
{
test: /\.js$/, loader: 'babel' }
]
},
resolve: {
extensions: ['', '.js', '.jsx']
},

plugins: [ // 内联css提取到单独的styles的css  new ExtractTextPlugin("index.css"), new HtmlwebpackPlugin({

title: 'Hello World app',
filename: 'index.html',
template: 'src/html/index.html',
inject: true,
hash: true }), new webpack.optimize.UglifyJsPlugin({ //压缩代码 compress: {
warnings: false },
except: ['$super', '$', 'exports', 'require'] //排除关键字 })
]
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
[回到顶部](http://www.cnblogs.com/tugenhua0707/p/5576262.html#_labelTop)
8.webpack对图片的打包
 图片是 url-loader来加载的，我们既可以在css文件里url的属性；
首先先安装 url-loader插件；
**sudo npm install --save-dev url-loader**
首先在less文件里面加入如下代码：
@color: red;
body {
background:@color;
background:url('../images/1.png') no-repeat;
}
在index.js里面加入如下代码：
var aModule = require('../less/main.less');
console.log(aModule);
在webpack.config.js代码配置加入如下：
{
test: /.(png|jpg)$/,
loader: 'url?limit=8192'
}
webpack.config.js所有代码如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');var ExtractTextPlugin = require('extract-text-webpack-plugin');var webpack = require("webpack");//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');

module.exports = {
entry: { "a": SRC_PATH + "/js/a.js", "index": SRC_PATH + "/js/index.js",
},
output: {
filename: "[name].js",
path: BUILD_PATH
},
module: {
loaders: [ //.css 文件使用 style-loader 和 css-loader 来处理 {
test: /\.less$/,
loader: ExtractTextPlugin.extract( 'css?sourceMap!' +
'less?sourceMap' )
},
{
test: /\.js$/, loader: 'babel' },
{
test: /.(png|jpg)$/, loader: 'url?limit=8192&name=img/[hash:8].[name].[ext]' }
]
},
resolve: {
extensions: ['', '.js', '.jsx']
},

plugins: [ // 内联css提取到单独的styles的css  new ExtractTextPlugin("index.css"), new HtmlwebpackPlugin({

title: 'Hello World app',
filename: 'index.html',
template: 'src/html/index.html',
inject: true,
hash: true }), new webpack.optimize.UglifyJsPlugin({ //压缩代码 compress: {
warnings: false },
except: ['$super', '$', 'exports', 'require'] //排除关键字 })
]
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
因此在项目的根目录运行webpack后，即可，然后会生成index.css文件代码如下：

body{background:red;background:url(8eaebaa98ed1fe64bbf9f0f954b2b230.png) no-repeat}

因此可以看到会动态转换成base64编码；
[回到顶部](http://www.cnblogs.com/tugenhua0707/p/5576262.html#_labelTop)
9.学习web-dev-server 创建服务器及动态监听css及js文件的改变；

 在webpack中，我们经常使用webpack-dev-server作为开发服务器，用于实时监听和打包编译静态资源，这样每当我们修改js、css等等文件时，客户端（如浏览器等）能够自动刷新页面，展示实时的页面效果。

webpack-dev-server只监听webpack.config.js中entry入口下文件（如js、css等等）的变动，
只有这些文件的变动才会触发实时编译打包与页面刷新，但是html文件更改后保存不能监听新内容到，但是对于开发影响不大，我们在编写css文件
或者js文件的时候保存后，会自动刷新页面，所以html页面也会自动更新到；
首先需要进入我们的项目的根目录下需要安装webpack-dev-server 安装命令如下：
sudo npm install --save-dev webpack-dev-server
首先我项目的目录如下：

![561794-20160611232935918-1971341416.png.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132353.jpg)

安装完成后，需要在webpack.config.js文件配置下；如下代码：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');var ExtractTextPlugin = require('extract-text-webpack-plugin');var webpack = require("webpack");//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');

module.exports = {
entry: { "a": SRC_PATH + "/js/a.js", "index": SRC_PATH + "/js/index.js" },
output: {
filename: "/js/[name].js",
path: BUILD_PATH
},
module: {
loaders: [ //.css 文件使用 style-loader 和 css-loader 来处理 {
test: /\.less$/,
loader: ExtractTextPlugin.extract( 'css?sourceMap!' +
'less?sourceMap' )
},
{
test: /\.js$/, loader: 'babel' },
{

test: /.(png|jpg)$/, loader: 'url?limit=8192&name=images/[hash:8].[name].[ext]' }

]
},
resolve: {
extensions: ['', '.js', '.jsx']
},

plugins: [ // 内联css提取到单独的styles的css  new ExtractTextPlugin("/css/index.css"), new HtmlwebpackPlugin({

title: 'Hello World app',
filename: 'html/index.html',
template: 'src/html/index.html',
inject: true,
hash: true }), new webpack.optimize.UglifyJsPlugin({ //压缩代码 compress: {
warnings: false },
except: ['$super', '$', 'exports', 'require'] //排除关键字 })
]
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
接着需要创建一个webpack-config-dev.js文件，该文件的作用是创建本地服务器，及实时监听css及js文件的改变；代码如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path')var webpack = require('webpack');var HtmlwebpackPlugin = require('html-webpack-plugin');var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
devtool: 'cheap-eval-source-map',

entry: [ 'webpack-dev-server/client?http://127.0.0.1:8080', 'webpack/hot/dev-server', './src/js/index', './src/js/a', './src/less/main.less' ],

output: {
path: path.join(__dirname, 'build'),
filename: '/js/[name].js' },
plugins: [ new webpack.HotModuleReplacementPlugin(), new HtmlwebpackPlugin({
title: 'Hello World app',
filename: 'html/index.html',
template: 'src/html/index.html',
inject: true,
hash: true }), new ExtractTextPlugin("index.css")
],
module: {
loaders: [ //.css 文件使用 style-loader 和 css-loader 来处理 {
test: /\.less$/,
loader: ExtractTextPlugin.extract( 'css?sourceMap!' +
'less?sourceMap' )
},
{
test: /\.js$/, loader: 'babel' },
{

test: /.(png|jpg)$/, loader: 'url?limit=8192&name=images/[hash:8].[name].[ext]' }

]
},
devServer: {
contentBase: './dist',
hot: true }
}
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

上面只是在开发环境配置的；我们还需要一个线上环境，进行打包，我们还需要使用一个线上环境打包的配置；我们可以新建一个叫webpack.config.prod.js文件； 该文件的配置用于在生产环境的打包；配置代码如下：

[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path')var webpack = require('webpack');var HtmlwebpackPlugin = require('html-webpack-plugin');var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
devtool: 'source-map',
entry: ['./src/js/index','./src/js/a'],
output: {
path: path.join(__dirname, 'build'),
filename: '/js/[name].js' },
plugins: [ new webpack.HotModuleReplacementPlugin(), new HtmlwebpackPlugin({
title: 'Hello World app',
filename: 'html/index.html',
template: 'src/html/index.html',
inject: true,
hash: true }), new ExtractTextPlugin("index.css")
],
module: {
loaders: [ //.css 文件使用 style-loader 和 css-loader 来处理 {
test: /\.less$/,
loader: ExtractTextPlugin.extract( 'css?sourceMap!' +
'less?sourceMap' )
},
{
test: /\.js$/, loader: 'babel' },
{

test: /.(png|jpg)$/, loader: 'url?limit=8192&name=images/[hash:8].[name].[ext]' }

]
}
}
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
package.json文件代码如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

{ "name": "html-webpack-plugin", "version": "1.0.0", "description": "", "main": "index.js", "scripts": { "build": "webpack --config webpack.config.prod.js", "dev": "webpack-dev-server --config webpack.config.dev.js" }, "author": "", "license": "ISC", "devDependencies": { "babel-core": "^6.9.1", "babel-loader": "^6.2.4", "css-loader": "^0.23.1", "file-loader": "^0.8.5", "html-webpack-plugin": "^2.19.0", "http-server": "^0.9.0", "less": "^2.7.1", "less-loader": "^2.2.3", "react-hot-loader": "^1.3.0", "style-loader": "^0.13.1", "url-loader": "^0.5.7", "webpack": "^1.13.1", "webpack-dev-server": "^1.14.1" }

}
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
接着我们先运行webpack，就可以在项目的根目录下生成build文件夹了；
如下图所示：

![561794-20160611233145449-1053608616.png.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132401.jpg)

为了更方便运行我们在package.json添加如下代码：
"scripts": {
     "build": "webpack --config webpack.config.prod.js",
     "dev": "webpack-dev-server --config webpack.config.dev.js"
}
因此如果在开发环境的话，可以运行 npm run dec; 如果是线上的环境，可以运行 npm run build 即可;
但是当我们运行 npm run dev的时候 会出现如下错误：

![561794-20160611233211293-2084698151.png.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132408.jpg)

这是因为 默认centos的 hosts 会把本地 127.0.0.1 localhost 注释掉； 我们可以在我们hosts文件夹下 多加一句
127.0.0.1 localhost
即可；
我们可以参考 https://github.com/Unitech/pm2/issues/324

webpack-dev-server git上的地址：[https://github.com/tugenhua0707/webpack-dev-server ](https://github.com/tugenhua0707/webpack-dev-server)

[回到顶部](http://www.cnblogs.com/tugenhua0707/p/5576262.html#_labelTop)
10.assets-webpack-plugin插件解决html文件的版本号的问题；

 我们上面学习过 html-webpack-plugin 这个插件，它可以自动添加版本号，但是对于很多前端开发的时候，我们的html页面是放在服务器端那边的部署，架构是前后端分离，因为html是在后台的，所以根本操作不了html，也不应该耦合。

我们可以通过webpack的 assets-webpack-plugin 插件生成一个记录了版本号的文件；详细的可以看官网地址是： https://www.npmjs.com/package/assets-webpack-plugin;

首先我们需要在我们的项目下安装该插件：安装命令如下：
npm install assets-webpack-plugin --save-dev
只需要在webpack.config.json添加如下代码：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
// 部分代码var AssetsPlugin = require('assets-webpack-plugin');new AssetsPlugin({
filename: 'build/webpack.assets.js',

processOutput: function (assets) { return 'window.WEBPACK_ASSETS = ' + JSON.stringify(assets);

}
})
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
我们现在来在webpack.config.js配置项如下
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');var ExtractTextPlugin = require('extract-text-webpack-plugin');//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');var AssetsPlugin = require('assets-webpack-plugin');

module.exports = {
entry: { "a": SRC_PATH + "/js/a.js", "index": SRC_PATH + "/js/index.js" },
output: {
path: path.join(__dirname, "build"),
filename: "js/[name]-[chunkhash:8].js",
},
module: {
loaders: [ //.css 文件使用 style-loader 和 css-loader 来处理 {
test: /\.less$/,
loader: ExtractTextPlugin.extract( 'css?sourceMap!' +
'less?sourceMap' )
},
{
test: /\.js$/, loader: 'babel' }
]
},
resolve: {
extensions: ['', '.js', '.jsx']
},

plugins: [ // 内联css提取到单独的styles的css  new ExtractTextPlugin("css/index.css"), new HtmlwebpackPlugin({

title: 'Hello World app',
filename: 'html/index.html',
template: 'src/html/index.html',
inject: true }), new AssetsPlugin({
filename: 'build/webpack.assets.js',

processOutput: function (assets) { return 'window.WEBPACK_ASSETS = ' + JSON.stringify(assets);

}
})
]
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
然后运行webpack命令进行打包后 如下图所示：

![561794-20160611233618605-1334216716.png.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132416.jpg)

可以看到在我们的build目录下的js文件生成a和index带有版本号的js文件，在build目录下还生成了一个 webpack.assets.js文件；该文件

代码如下：
window.WEBPACK_ASSETS = {"a":{"js":"js/a-a7cbb4daad866656445a.js"},
"index":{"js":"js/index-a7cbb4daad866656445a.js"}}
因此我们可以把该webpack.assets.js文件让开发在页面上引入即可；
<script src="build/webpack.assets.js?v=' + Math.random() + '"></script>
<script src="' + window.WEBPACK_ASSETS['a'].js + '"></script>
<script src="' + window.WEBPACK_ASSETS['index'].js + '"></script>
我们继续看 chunkhash:8 的含义：其中8是指hash长度为8，默认是16。加上chunkhash就可以缓存文件；因为每次打包的时候都会自动生成
版本号，但是有些文件并没有修改的话，我们不需要更改版本号，我们想直接从缓存里面读取，对于更改的文件我们需要从服务器下载，对于
这样的 chunkhash 可以解决；比如如下两次的版本号：

window.WEBPACK_ASSETS = {"a":{"js":"js/a-ac4c0d24.js"},"index":{"js":"js/index-7c5ec642.js"}}

当我更改index.js代码的时候 a.js代码没有更改的话；变成如下：

window.WEBPACK_ASSETS = {"a":{"js":"js/a-ac4c0d24.js"},"index":{"js":"js/index-9a2fec25.js"}}

[回到顶部](http://www.cnblogs.com/tugenhua0707/p/5576262.html#_labelTop)
11.webpack关于同步加载和异步加载的问题
 使用webpack打包，直接使用require模块可以解决模块的依赖的问题，
  对于直接require模块，WebPack的做法是把依赖的文件都打包在一起，造成文件很臃肿。即是同步加载，同步的代码会被合成并且打包在一起；
而 异步加载的代码会被分片成一个个chunk，在需要该模块时再加载，即按需加载，同步加载过多代码会造成文件过大影响加载速度；
异步过多则文件太碎，造成过多的Http请求，同样影响加载速度。这要看开发者自己权衡下；
**同步加载**的写法如下：*
**var aModule =***** require('./a');**
而**异步加载**的写法如下：
**require.ensure(['./a'],function(require){**
***     var aModule = require('./a');**
**},'tips');**

*使用 **require.ensure** 可以解决异步加载模块的文件；如上代码，如果ensure不指定第三个参数的话(tips),那么webpack会随机生成一个数字

作为模块名，我们指定第三个参数为tips；那说明生成后的模块名叫tips.js；

这时候我们需要使用到webpack.config.js中的output选项需要加一个配置项：**chunkFilename: "[name].min.js"**

下面可以先来理解下 webpack中的output.filename 和output.chunkFilename
比如如下配置代码：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
{
entry: { "index": "pages/index.jsx" },
output: {
filename: "[name].min.js",
chunkFilename: "[name].min.js" }
}
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
**filename**应该比较好理解，就是对应于entry里面生成出来的文件名；即会生成 index.min.js文件名；
**chunkname**的理解是在按需加载（异步）模块的时候，这样的文件是没有被列在entry中的，如使用CommonJS的方式异步加载模块时候会使用到；
比如如上这要异步加载一个a.js模块，代码如下：
**require.ensure(['./a'],function(require){**
**    var aModule = require('./a');**
**},'tips');**
指定第三个参数为tips，因此配合output中的 chunkFilename， 即会生成 tips.min.js了；
比如如下所示：

![561794-20160611233930746-1490904613.png.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132423.jpg)

tips.js代码如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

webpackJsonp([1],[/* 0 */,/* 1 *//***/  function(module, exports) { /* // es6的语法 let LOADER = true; module.exports = LOADER; */  function a() {

console.log("a");
console.log(11);
console.log(222444);
}
a();/***/ }
]);
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
会通过 webpackJsonp 模块包装一下；接着我们在index.js代码看下，它使如何被调用的；如下片段代码：
**__webpack_require__.e/* nsure */(1, function (require) {**
**     var aModule = __webpack_require__(1);**
**});**
即可引用的到；也就是说如果a.js模块有1000+行代码，不会被包含到index.js代码内，但是index.js代码有a.js代码模块的引用；
可以加载到a.js代码的内容；
下面是我的webpack.config.js代码配置如下：
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

var path = require('path');var HtmlwebpackPlugin = require('html-webpack-plugin');var ExtractTextPlugin = require('extract-text-webpack-plugin');//定义了一些文件夹的路径var ROOT_PATH = path.resolve(__dirname);var SRC_PATH = path.resolve(ROOT_PATH, 'src');var BUILD_PATH = path.resolve(ROOT_PATH, 'build');var AssetsPlugin = require('assets-webpack-plugin');

module.exports = {
entry: { "index": SRC_PATH + "/js/index.js" },
output: {
path: path.join(__dirname, "build"),
filename: "js/[name]-[chunkhash:8].js",
chunkFilename: "js/[name]-[chunkhash:8].js" },
module: {
loaders: [ //.css 文件使用 style-loader 和 css-loader 来处理 {
test: /\.less$/,
loader: ExtractTextPlugin.extract( 'css?sourceMap!' +
'less?sourceMap' )
},
{
test: /\.js$/, loader: 'babel' }
]
},
resolve: {
extensions: ['', '.js', '.jsx']
},

plugins: [ // 内联css提取到单独的styles的css  new ExtractTextPlugin("css/index.css"), new HtmlwebpackPlugin({

title: 'Hello World app',
filename: 'html/index.html',
template: 'src/html/index.html',
inject: true }), new AssetsPlugin({
filename: 'build/webpack.assets.js',

processOutput: function (assets) { return 'window.WEBPACK_ASSETS = ' + JSON.stringify(assets);

}
})
]
};
[![复制代码](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)
index.js代码异步调用a.js模块的代码如下：
**require.ensure(['./a'],function(require){**
**    var aModule = require('./a');**
**},'tips');**
更多的配置项 看官网 http://webpack.github.io/docs/code-splitting.html

 [好文要顶](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)  [关注我](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)  [收藏该文](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)  [![icon_weibo_24.png](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)  [![wechat.png](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

 [![20160306101106.png.jpg](../_resources/7d59711e9cb9acc13a6c42a770d4861d.jpg)](http://home.cnblogs.com/u/tugenhua0707/)

 [空智](http://home.cnblogs.com/u/tugenhua0707/)
 [关注 - 20](http://home.cnblogs.com/u/tugenhua0707/followees)
 [粉丝 - 783](http://home.cnblogs.com/u/tugenhua0707/followers)

 [+加关注](webpack进阶构建项目(一)%20-%20空智%20-%20博客园.md#)

 7

 0

[«](http://www.cnblogs.com/tugenhua0707/p/5568734.html) 上一篇：[移动端开发适配总结](http://www.cnblogs.com/tugenhua0707/p/5568734.html)

- 分类: [前端项目工具](http://www.cnblogs.com/tugenhua0707/category/544573.html)

- 标签: [webpack进阶构建项目(一)](http://www.cnblogs.com/tugenhua0707/tag/webpack%E8%BF%9B%E9%98%B6%E6%9E%84%E5%BB%BA%E9%A1%B9%E7%9B%AE%28%E4%B8%80%29/)
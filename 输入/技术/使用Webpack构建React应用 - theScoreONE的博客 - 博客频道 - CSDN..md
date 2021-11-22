使用Webpack构建React应用 - theScoreONE的博客 - 博客频道 - CSDN.NET

#   [使用Webpack构建React应用](http://blog.csdn.net/mqy1023/article/details/51611626)

  标签： [webpack](http://www.csdn.net/tag/webpack)[react](http://www.csdn.net/tag/react)

 2016-06-11 17:33  2408人阅读    [评论](http://blog.csdn.net/mqy1023/article/details/51611626#comments)(0)    [收藏](使用Webpack构建React应用%20-%20theScoreONE的博客%20-%20博客频道%20-%20CSDN..md#)    [举报](http://blog.csdn.net/mqy1023/article/details/51611626#report)

 .

 ![category_icon.jpg](../_resources/760c5ec8c68b26ded5d32a15a75b0d4b.jpg)  分类：

   webpack*（3）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)      react*（13）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

 .

版权声明：本文出自mqy1023的博客，转载必须注明出处。

目录[(?)](http://blog.csdn.net/mqy1023/article/details/51611626#)[[+]](http://blog.csdn.net/mqy1023/article/details/51611626#)

前面写过一遍《[使用gulp+Browserify构建React应用](http://blog.csdn.net/mqy1023/article/details/51607820)》，本文来看看更强大的构建工具— —Webpack。先来看看webpack强大之处介绍

1、将css、图片以及其他资源打包到同一个包中
2、在打包之前对文件进行预处理(less、coffee、jsx等)
3、 根据入口文件的不同把你的包拆分成多个包
4、支持开发环境的特殊标志位
5、支持模块代码“热”替换
6、支持异步加载

  Webpack不仅帮助你打包所有的[JavaScript](http://lib.csdn.net/base/javascript)文件，还拥有其他应用需要的资源。这样设计可以让你能创建一个自动包含所有类型依赖的组件。由于可以自动包含所有的依赖，组件也变得更加方便移植。更妙的是，随着应用不断地开发并修改，当你移除某个组件的时候，它的*所有依赖也会自动被移除*。这意味这不会再有未被使用的css或图片遗留在代码目录中。

  本文主要是**编写一个[React](http://lib.csdn.net/base/react)开发的webpack构建包基础框架**，后续编写React简单小例子，构建吧命令、index.html均无需改变，只需要关注./app/jsx目录中编写组件的jsx代码即可。

[**源码地址**：]()https://github.com/mqy1023/react-basejs/tree/master/src/dev-base/webpack

### **一、React项目结构**

	/app
	   /jsx
	   index.html
	package.json
	webpack.config.js
	.babelrc

- 1
- 2
- 3
- 4
- 5
- 6
- 1
- 2
- 3
- 4
- 5
- 6

### **二、webpack脚本**

- 1、创建package.json管理node包信息文件：`npm init;`
- 2、package.json中scripts脚本

	"scripts": {
	    "start": "webpack-dev-server",//执行`npm start` 相当于执行`webpack-dev-server`命令启动服务器
	    "prod": "webpack -p"//执行`npm run prod` 相当于执行`webpack -p`打包命令
	}

    - 1
    - 2
    - 3
    - 4
    - 1
    - 2
    - 3
    - 4
- 3、`react`相关库

	npm install react --save;//react核心库
	npm install react-dom --save;//react操作dom库

    - 1
    - 2
    - 1
    - 2
- 4、`Babel`- -编译JSX

	npm install --save-dev babel-core;//babel核心
	npm install --save-dev babel-loader;    //webpack中babel编译器
	npm install --save-dev babel-preset-react;  //react的JSX编译成js

    - 1
    - 2
    - 3
    - 1
    - 2
    - 3
- 5、`html-webpack-plugin` - - 修改html文件插件

`npm install --save-dev html-webpack-plugin`;

- 6、`webpack`相关库

 **全局安装webpack：`npm install webpack -g`**

	npm install --save-dev webpack; //webpack核心
	npm install --save-dev webpack-dev-server;  //webpack服务器

    - 1
    - 2
    - 1
    - 2

* * *

- 7、`.babelrc` - - 设置webpack的loader加载器(babel编译器)规则

	{
	  "presets": [
	    "react"
	  ]
	}

    - 1
    - 2
    - 3
    - 4
    - 5
    - 1
    - 2
    - 3
    - 4
    - 5
- 8、`webpack.config.js` - - webpack配置

	var HtmlWebpackPlugin = require('html-webpack-plugin');
	var HTMLWebpackPluginConfig = new HtmlWebpackPlugin({
	  template: __dirname + '/app/index.html', //指定html模板目录路径
	  filename: 'index.html',    //新建文件名
	  inject: 'body' //<script>[output的filename(index_bundle.js)]</script>查到body中,另可插head
	});

	module.exports = {
	  entry: [
	    './app/js/App.jsx'    //App.js是主入口jsx
	  ],
	  output: {  //指定输出目录和输出文件名index_bundle.js
	    path: __dirname + '/dist',
	    filename: "index_bundle.js"
	  },
	  module: {
	    loaders: [ //正则：以jsx结尾；排除node_modules目录；babel加载器
	      {test: /\.jsx$/, exclude: /node_modules/, loader: "babel-loader"}
	    ]
	  },
	  plugins: [HTMLWebpackPluginConfig]
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

### **三、网页index.html**

	./app/index.html
	//html最轻量化，<script>都没有。
	//webpack配置中html-webpack-plugin插件自动插入转换并拼接后的js到<script>中

- 1
- 2
- 3
- 1
- 2
- 3

### **四、在./app/jsx目录下编写React的jsx**

其中模块化管理jsx，只需要在webpack.config.js的entry配置指定入口的App.jsx

### **五、使用**

1、npm install
2、构建命令

	webpack     //执行一次开发时的编译
	webpack -p      //执行一次生成环境的编译（压缩）
	webpack -w  //在开发时持续监控增量编译（很快）

	//因为在package.json配置了script
	npm start //相当于执行`webpack-dev-server`命令启动服务器
	npm run prod //相当于执行`webpack -p`打包命令

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 1
- 2
- 3
- 4
- 5
- 6
- 7

* * *

## **总结**

index.html文件和webpack构建包命令不变，每次开发React时，
只需要在./app/jsx目录下编写React组件的jsx代码，主入口jsx为**`App.jsx`**即可

[(L)](http://blog.csdn.net/mqy1023/article/details/51611626#)[(L)](http://blog.csdn.net/mqy1023/article/details/51611626#)[(L)](http://blog.csdn.net/mqy1023/article/details/51611626#)[(L)](http://blog.csdn.net/mqy1023/article/details/51611626#)[(L)](http://blog.csdn.net/mqy1023/article/details/51611626#)[(L)](http://blog.csdn.net/mqy1023/article/details/51611626#).

顶

1

踩

0

[使用Webpack构建React应用 - theScoreONE的博客 - 博客频道 - CSDN.](使用Webpack构建React应用%20-%20theScoreONE的博客%20-%20博客频道%20-%20CSDN..md#)

 [使用Webpack构建React应用 - theScoreONE的博客 - 博客频道 - CSDN.](使用Webpack构建React应用%20-%20theScoreONE的博客%20-%20博客频道%20-%20CSDN..md#)

- 上一篇[使用gulp+Browserify构建React应用](http://blog.csdn.net/mqy1023/article/details/51607820)

- 下一篇[《React:引领未来的用户界面开发框架》— —自编教程源码](http://blog.csdn.net/mqy1023/article/details/51755426)

#### 我的同类文章

   webpack*（3）*      react*（13）*

- *•*[webpack实践指南](http://blog.csdn.net/mqy1023/article/details/52193918)2016-08-12*阅读***242**

- *•*[《React:引领未来的用户界面开发框架》— —自编教程源码](http://blog.csdn.net/mqy1023/article/details/51755426)2016-06-24*阅读***5126**

- *•*[《webpack系列文章收藏》](http://blog.csdn.net/mqy1023/article/details/52083320)2016-08-01*阅读***113**
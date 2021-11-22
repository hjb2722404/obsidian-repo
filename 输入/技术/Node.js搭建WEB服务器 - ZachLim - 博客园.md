Node.js搭建WEB服务器 - ZachLim - 博客园

#   [Node.js搭建WEB服务器](https://www.cnblogs.com/linzhehuang/p/9476771.html)

## 前言

这几天为了熟悉vue.js框架，还有webpack的使用，就准备搭建一个发布和浏览markdwon的简单WEB应用。原本是想着用bash脚本和busybox的httpd来作为后台服务，但是bash脚本解析和生成JSON非常不方便，而用Java语言写又觉得部署不方便，所以就想到了正在用到的Node.js，于是就有了这篇博文。（文末有本文代码的github地址）

## 简单例子

首先，从搭建最简单的`Hello world`开始，建立以下目录、文件和内容。

### 建立项目及运行

**project**

	  web-server
	+ | - server.js

**server.js**

	const http = require('http');

	http.createServer(function(request, response) {
	  // 设置响应头
	  response.writeHeader(200, {
	    "Content-Type" : "text/plain"
	  });
	  // 响应主体为 "Hello world!"
	  response.write("Hello world!");
	  response.end();
	})
	// 设置监听端口为9000
	.listen(9000);

现在，在项目目录运行下面命令来执行`server.js`，浏览器地址栏中输入`localhost:9000`，如果一切访问都正常，浏览器就会显示`Hello world!`。

	node server.js

***提示：使用`ctrl+c`停止脚本运行。***
至此一个简单例子就运行成功了，下面来分析一下代码。

### 代码分析

首先，`server.js`中引入了Node.js的[`http模块`](http://nodejs.cn/api/http.html)，它提供了非常底层HTTP API支持。这里使用[`createServer()`](http://nodejs.cn/api/http.html#http_http_createserver_options_requestlistener)方法，它返回一个[`http.server`](http://nodejs.cn/s/jLiRTh)实例，使用该实例的`listen()`方法来设置监听端口。

方法[`createSever()`](http://nodejs.cn/api/http.html#http_http_createserver_options_requestlistener)中填写的参数是一个函数，该函数会作为回调函数自动添加到[`request事件`](http://nodejs.cn/s/2qCn57)去，其参数类型分别为[`http.IncomingMessage`](http://nodejs.cn/api/http.html#http_class_http_incomingmessage)和[`http.ServerResponse`](http://nodejs.cn/api/http.html#http_class_http_serverresponse)。在回调函数体里，利用`http.ServerResponse`的方法设置了响应头和响应主体，最后以`end()`方法结束本次请求。

## 路由功能

上述的例子仅仅实现了简单请求响应功能，现在增加路由的功能来健壮我们的WEB服务器。现在，修改为以下的目录、文件和内容。

## 实现简单路由

**project**

	  web-server
	  | - server.js
	+ | - router.js

**server.js**

	const http = require('http');
	const router = require('./router.js');

	function handleHello(request, response) {
	  // 设置响应头
	  response.writeHeader(200, {
	    "Content-Type" : "text/plain"
	  });
	  // 响应主体为 "Hello world!"
	  response.write("Hello world!");
	  response.end();
	}

	http.createServer(function(request, response) {
	  // 注册路径和其对应回调函数
	  router.register(request, response, [
	    {
	      'url': '/hello',
	      'handler': handleHello
	    }
	  ]);
	})
	// 设置监听端口为9000
	.listen(9000);

**router.js**

	const url = require('url');

	exports.register = function(request, response, mapping) {
	  // 解析请求路径
	  var pathName = url.parse(request.url).pathname;
	  // 执行相应请求路径的回调函数
	  for(let i = 0, len = mapping.length;i < len;i++) {
	    if(mapping[i].url === pathName) {
	      mapping[i].handler(request, response);
	      return;
	    }
	  }
	  // 请求路径不存在返回404页面
	  response.writeHeader(404, {
	    "Content-Type" : "text/html"
	  });
	  response.end(`
	    <html>
	      <head>
	        <title>NOT FOUND</title>
	      </head>
	      <body>
	        <h1>404 NOT FOUND</h1>
	      </body>
	    </html>
	  `);
	}

现在，再次执行`server.js`脚本，接着浏览器访问`localhost:9000\hello`会得到`Hello world!`的结果，而访问其他路径则会得到404页面。

这个功能的核心实现是在`router.js`中，通过请求路径的解析，然后根据预先注册好的`mapping`数组，找到与之对应的路径并执行相应的回调函数。

### 静态资源请求

当前的路由功能只能实现回调函数的执行，而一个WEB服务器应具有响应静态资源请求的能力，接下我们继续来改造它。现在，保持`server.js`内容不变，只改变`router.js`中的内容（部分代码内容省略）。

**route.js**

	const url = require('url');
	const path = require('path');
	const fs = require('fs');

	function getErrorInfo(errorType) {
	  // 省略代码
	}

	function writeErrorPage(response, errorType) {
	  // 省略代码
	}

	exports.register = function(request, response, mapping) {
	  // 解析请求路径
	  var pathName = url.parse(request.url).pathname;
	  // 执行相应请求路径的回调函数
	  for(let i = 0, len = mapping.length;i < len;i++) {
	    if(mapping[i].url === pathName) {
	      mapping[i].handler(request, response);
	      return;
	    }
	  }
	  // 请求路径为文件返回文件内容
	  var file = path.resolve(__dirname, '.' + pathName);
	  fs.exists(file, function(exists) {
	    // 请求路径不存在返回404页面
	    if(!exists) {
	      writeErrorPage(response, 'NOT_FOUND');
	    }
	    else {
	      var stat = fs.statSync(file);
	      // 请求路径为目录返回403页面
	      if(stat.isDirectory()) {
	        writeErrorPage(response, 'FORBIDDEN');
	      }
	      else {
	        response.writeHeader(200, {
	          "Content-Type" : "text/html"
	        });
	        response.end(
	          fs.readFileSync(file, 'utf-8')
	        );
	      }
	    }
	  });
	}

将静态资源请求的行为置后的设计，是为了保证回调函数一定能执行。当静态资源不存在时，应当返回不存在的错误，同时也设置了禁止目录的访问的规则。

## 后话

现在，只是实现了WEB服务器基本的功能，它还有很大的改进空间。我将项目开源到[github](https://github.com/linzhehuang/web-server)上，有兴趣的可以克隆下来。

分类: [经验和见解](https://www.cnblogs.com/linzhehuang/category/980794.html)

 [好文要顶](Node.js搭建WEB服务器%20-%20ZachLim%20-%20博客园.md#)  [关注我](Node.js搭建WEB服务器%20-%20ZachLim%20-%20博客园.md#)  [收藏该文](Node.js搭建WEB服务器%20-%20ZachLim%20-%20博客园.md#)  [![icon_weibo_24.png](Node.js搭建WEB服务器%20-%20ZachLim%20-%20博客园.md#)  [![wechat.png](Node.js搭建WEB服务器%20-%20ZachLim%20-%20博客园.md#)

 [![20200724224038.png](../_resources/8ece44aec541e67feb46ac23c615e134.png)](https://home.cnblogs.com/u/linzhehuang/)

 [ZachLim](https://home.cnblogs.com/u/linzhehuang/)
 [关注 - 1](https://home.cnblogs.com/u/linzhehuang/followees/)
 [粉丝 - 4](https://home.cnblogs.com/u/linzhehuang/followers/)

 [+加关注](Node.js搭建WEB服务器%20-%20ZachLim%20-%20博客园.md#)

 1

 0

 [«](https://www.cnblogs.com/linzhehuang/p/8503485.html) 上一篇： [编写dimgr脚本学到的知识及技巧](https://www.cnblogs.com/linzhehuang/p/8503485.html)

 [»](https://www.cnblogs.com/linzhehuang/p/9596299.html) 下一篇： [GCC 编译 Windows API 程序](https://www.cnblogs.com/linzhehuang/p/9596299.html)

posted @ 2018-08-14 19:02 [ZachLim](https://www.cnblogs.com/linzhehuang/)  阅读(7306)  评论(4) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=9476771) [收藏](Node.js搭建WEB服务器%20-%20ZachLim%20-%20博客园.md#)
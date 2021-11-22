Node.js 系列 - 搭建静态资源服务器 - 掘金

[(L)](https://juejin.im/user/4265760844680647)

[ 罐装汽水_Garrik   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/4265760844680647)

2018年10月30日   阅读 3288

# Node.js 系列 - 搭建静态资源服务器

作为还在漫漫前端学习路上的一位自学者。我以学习分享的方式来整理自己对于知识的理解，同时也希望能够给大家作为一份参考。希望能够和大家共同进步，如有任何纰漏的话，希望大家多多指正。感谢万分！

* * *

在上一章, 我们搭建了一个非常简单的 "Hello World" 服务器. 在这一章里, 我们要继续上一章所学的知识, 进一步尝试搭建, 提供静态资源的服务器.

## 什么是静态资源服务器?

那先说什么是 **静态资源**, 它指的是**不会被服务器的动态运行所改变或者生成的文件**. 它最初在服务器运行之前是什么样子, 到服务器结束运行时, 它还是那个样子. 比如平时写的 `js`, `css`, `html` 文件, 都可以算是静态资源. 那么很容易理解, 静态资源服务器的功能就是向客户端提供静态资源.

话不多说, 开始写代码:
首先我们知道, 它先是一个 "服务器". 那根据上一章的所学, 我们要先用 `http` 模块创建一个 HTTP 服务器.

	jsvar http = require('http');

	var server = http.createServer(function(req, res) {
	    // 业务逻辑, 等会儿再写.
	});

	server.listen(3000, function() {
	    console.log("静态资源服务器运行中.");
	    console.log("正在监听 3000 端口:")
	})
	复制代码

## url 模块

[url 模块 - 文档](http://nodejs.cn/api/url.html)
有了 HTTP 服务器之后, 我们就可以获取从客户端发过来的 HTTP 请求了.

请求报文中包含着请求 URL. 前文说过, URL 用于定位网络上的资源. 客户端通过 URL 来指明想要的服务器上资源. 那么服务器为了搞清楚客户端到底想要什么, 我们需要处理和解析 URL. 在 Node.js 中, 我们使用 `url` 模块来完成这类操作.

我们知道 URL 字符串是具有结构的字符串，包含多个意义不同的组成部分。 通过 `url.parse()` 函数, URL 字符串可以被解析为一个 URL 对象，其属性对应于字符串的各组成部分。如下图所示.

[1](../_resources/5e2ea46fedf5db270cefacf68bbb2663.webp)

* * *

那么回到我们的静态文件服务器代码.:
先在 `http.createServer` 函数被调用之前, 引入 `url` 模块:

	jsvar url = require('url');
	复制代码

然后在 HTTP 服务器里解析请求 URL. 客户端发来的请求 URL 作为属性存放在 `http.createServer` 的回调函数参数所接收的请求对象里, 属性名为 `url`.

	jsvar server = http.createServer(function(req, res) {
	    var urlObj = url.parse(req.url);
	});
	复制代码

## path 模块

[path 模块 - 文档](https://nodejs.org/api/path.html)
接下来从解析后的 URL 对象 `urlObj` 里取得请求 URL 中的路径名(pathname). 路径名保存在 `pathname` 属性里.

	jsvar server = http.createServer(function(req, res) {
	    var urlObj = url.parse(req.url);
	    var urlPathname = urlObj.pathname;
	});
	复制代码

但是光有 URL 对象里面的路径名是不够的. 我们还需要获得目标文件在服务器中所在目录的目录名(dirname).
假如说我们的项目结构是下面这样的:

	.
	├── public
	│   ├── index.css
	│   └── index.html
	└── server.js
	复制代码

我们的服务器代码写在 `server.js` 文件里. 客户端想要请求保存在 `public` 目录里的 `index.html` 文件. 用户在浏览器中输入 URL 的时候, 他只知道他想要的文件叫 `index.html`, 但这个文件在 HTTP 服务器所在的设备中的 『 绝对位置 』是不被知道的. 所以我们需要让 HTTP 服务器自己去处理这部分操作.

在这里就需要使用 Node.js 自带的 `path` 模块. 其提供了一些工具函数，用于处理文件与目录的路径.
使用起来很简单, 首先还是在 `http.createServer` 函数被调用之前, 引入 `path` 模块:

	jsvar path = require('path');
	复制代码

之后我们用 `path.join` 这个方法来把 目标文件所在目录的目录名和请求 URL 中的路径名合并起来. 在这个例子中, 客户端可以访问的静态文件全部在 `public` 这个目录中, 而 `public` 目录又在 `server.js` 文件所在的目录中. `server.js` 中保存的是我们的服务器代码.

想要获得 `server.js` 所在目录的在整个设备中的绝对路径, 我们可以在服务器代码中调用变量 `__dirname`, 它是当前文件在被模块包装器包装时传入的变量, 保存了当前模块的目录名。

	jsvar server = http.createServer(function(req, res) {
	    var urlObj = url.parse(req.url);
	    var urlPathname = urlObj.pathname;
	    var filePathname = path.join(__dirname, "/public", urlPathname);
	});
	复制代码

如果你想的话, 你可以用 `console.log(filePathname)` 来看看服务器运行后, 从客户端收到的请求 URL 会被转换成什么样.

## fs 模块

[fs 模块 - 文档](http://nodejs.cn/api/fs.html#fs_file_system)
现在来到了最重要的一步, 读取目标文件, 并且返回文件给客户端.

我们需要用 Node.js 自带的 `fs` 模块中的 `fs.write` 方法来实现这一步. 该方法第一个参数为目标文件的路径, 最后一个参数为一个回调函数, 回调有两个参数 (err, data)，其中 `data` 是文件的内容, 如果发生错误的话 `err` 保存错误信息. `fs.write` 方法可以在第二个参数中指定字符编码, 如果未指定则返回原始的 buffer. 在这个例子中, 我们不考虑这一项.

那么具体代码如下:
首先引入 `fs` 模块, 我就不赘述了, 参照前面就可以了. 下面是读取文件的代码.

	jsvar server = http.createServer(function(req, res) {
	    var urlObj = url.parse(req.url);
	    var urlPathname = urlObj.pathname;
	    var filePathname = path.join(__dirname, "/public", urlPathname);

	    fs.readFile(filePathname, (err, data) => {
	        // 如果有问题返回 404
	        if (err) {
	            res.writeHead(404);
	            res.write("404 - File is not found!");
	            res.end();
	        // 没问题返回文件内容
	        } else {
	            res.writeHead(200);
	            res.write(data);
	            res.end();
	        }
	    })
	});
	复制代码

现在我们就实现了一个基本的『 静态文件服务器 』可以在允许客户端请求保存在服务器中公开的静态文件了. 你可以尝试启动服务器, 然后让浏览器中访问 `http://localhost:3000/index.html`. 我的效果如下:

[1](../_resources/ad22085470f3c362b2abd69928223b01.webp)

## 设置 MIME 类型

[MIME 文档 - MDN](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Basics_of_HTTP/MIME_types#%E8%AE%BE%E7%BD%AE%E6%AD%A3%E7%A1%AE%E7%9A%84MIME%E7%B1%BB%E5%9E%8B%E7%9A%84%E9%87%8D%E8%A6%81%E6%80%A7)[Content-Type 文档 - MDN](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Content-Type)

多用途 Internet 邮件扩展（MIME）类型是用一种标准化的方式来表示文档的 "性质" 和 "格式"。 简单说, 浏览器通过 MIME 类型来确定如何处理文档. 因此在响应对象的头部设置正确 MIME 类型是非常重要的.

MIME 的组成结构非常简单: 由类型与子类型两个字符串中间用 `'/'` 分隔而组成, 其中没有空格. MIME 类型对大小写不敏感，但是传统写法都是小写.
例如:

- `text/plain` : 是文本文件默认值。意思是 未知的文本文件 ，浏览器认为是可以直接展示的.
- `text/html` : 是所有的HTML内容都应该使用这种类型.
- `image/png` : 是 PNG 格式图片的 MIME 类型.

在服务器中, 我们通过设置 `Content-Type` 这个响应头部的值, 来指示响应回去的资源的 MIME 类型. 在 Node.js 中, 可以很方便的用响应对象的 `writeHead` 方法来设置响应状态码和响应头部.

假如我们要响应给客户端一个 HTML 文件, 那么我们应该使用下面这条代码:

	jsres.writeHead(200, {"Content-Type":"text/html"});
	复制代码

你会发现我在上面的静态资源服务器的代码中, 没有设置响应资源的 MIME 类型. 但如果你试着运行服务器的话, 你会发现静态资源也以正确方式被展示到了浏览器.

之所以会这样的原因是在缺失 MIME 类型或客户端认为文件设置了错误的 MIME 类型时，浏览器可能会通过查看资源来进行猜测 MIME 类型, 叫做 『 MIME 嗅探 』. 不同的浏览器在不同的情况下可能会执行不同的操作。所以为了保证资源在每一个浏览器下的行为一致性, 我们需要手动设置 MIME 类型.

那么首先我们需要获取到准备响应给客户端的文件的 **后缀名**.
要做到这一步我们需要使用 `path` 模块的 `parse` 方法. 这个方法可以将一段路径解析成一个对象, 其中的属性对应路径的各个部位.
继续再刚才静态文件服务器案例的代码上添加:

	jsvar server = http.createServer(function(req, res) {
	    var urlObj = url.parse(req.url);
	    var urlPathname = urlObj.pathname;
	    var filePathname = path.join(__dirname, "/public", urlPathname);

	    // 解析后对象的 ext 属性中保存着目标文件的后缀名
	    var ext = path.parse(urlPathname).ext;

	    // 读取文件的代码...
	});
	复制代码

获取了文件后缀之后, 我们需要查找其对应的 **MIME 类型**了. 这一步可以很轻松的使用第三方模块 [MIME](https://www.npmjs.com/package/mime) 来实现. 你可以自行去 NPM 上去查阅它的使用文档.

对于我们目前的需求来说, 只需要用到 MIME 模块的 `getType()` 方法. 这个方法接收一个字符串参数 (后缀名), 返回其对应的 MIME 类型, 如果没有就返回 `null`.

使用的话, 首先要用 npm 安装 MIME 模块 ( 如果你还没创建 package.json 文件的话, 别忘了先执行 `npm init` )

	npm install mime --save
	复制代码

安装完毕. 引入模块到服务器代码中, 然后我们就直接用刚刚获得的后缀去找到其对应的 MIME 类型

	jsvar mime = require('mime');

	var server = http.createServer(function(req, res) {
	    var urlObj = url.parse(req.url);
	    var urlPathname = urlObj.pathname;
	    var filePathname = path.join(__dirname, "/public", urlPathname);

	    // 解析后对象的 ext 属性中保存着目标文件的后缀名
	    var ext = path.parse(urlPathname).ext;
	    // 获取后缀对应的 MIME 类型
	    var mimeType = mime.getType(ext);

	    // 读取文件的代码...
	});
	复制代码

好了, 现在最重要的东西 MIME 类型我们已经得到了. 接下来只要在响应对象的 `writeHead` 方法里设置好 `Content-Type` 就行了.

	jsvar server = http.createServer(function(req, res) {
	    // 代码省略...
	    var mimeType = mime.getType(ext);

	    fs.readFile(filePathname, (err, data) => {
	        // 如果有问题返回 404
	        if (err) {
	            res.writeHead(404, { "Content-Type": "text/plain" });
	            res.write("404 - File is not found!");
	            res.end();
	            // 没问题返回文件内容
	        } else {
	            // 设置好响应头
	            res.writeHead(200, { "Content-Type": mimeType });
	            res.write(data);
	            res.end();
	        }
	    })

	});
	复制代码

阶段性胜利 ✌️ 现在运行服务器, 在浏览器里访问一下 `localhost:3000/index.html` 试试吧!

[1](../_resources/e7c93d39ac0fb44f81d79b6d9891658f.webp)

可以看到现在 `Content-Type` 已经被正确设置了!

## 重构代码

现在来看看你的代码, 是不是开始感觉有点乱糟糟的. 我想聪明的你已经发现, 整个静态文件服务器的代码就是在做一件事: 响应回客户端想要的静态文件. 这段代码职责单一, 且复用频率很高. 那么我们有理由将其封装成一个模块.

具体的过程我就不赘述了. 以下是我的模块代码:

	js// readStaticFile.js

	// 引入依赖的模块
	var path = require('path');
	var fs = require('fs');
	var mime = require('mime');

	function readStaticFile(res, filePathname) {

	    var ext = path.parse(filePathname).ext;
	    var mimeType = mime.getType(ext);

	    // 判断路径是否有后缀, 有的话则说明客户端要请求的是一个文件
	    if (ext) {
	        // 根据传入的目标文件路径来读取对应文件
	        fs.readFile(filePathname, (err, data) => {
	            // 错误处理
	            if (err) {
	                res.writeHead(404, { "Content-Type": "text/plain" });
	                res.write("404 - NOT FOUND");
	                res.end();
	            } else {
	                res.writeHead(200, { "Content-Type": mimeType });
	                res.write(data);
	                res.end();
	            }
	        });
	        // 返回 false 表示, 客户端想要的 是 静态文件
	        return true;
	    } else {
	        // 返回 false 表示, 客户端想要的 不是 静态文件
	        return false;
	    }
	}

	// 导出函数
	module.exports = readStaticFile;
	复制代码

用于读取静态文件的模块 `readStaticFile` 封装好了之后. 我们可以在项目目录里新建一个 modules 目录, 用于存放模块. 以下是我目前的项目结构.

[1](../_resources/421be409e54171e4085790844ab62c9f.webp)

封装好了模块之后, 我们就可以删去服务器代码里那段读取文件的代码了, 直接引用模块就行了. 以下是我修改后的 server.js 代码:

	js// server.js

	// 引入相关模块
	var http = require('http');
	var url = require('url');
	var path = require('path');
	var readStaticFile = require('./modules/readStaticFile');

	// 搭建 HTTP 服务器
	var server = http.createServer(function(req, res) {
	    var urlObj = url.parse(req.url);
	    var urlPathname = urlObj.pathname;
	    var filePathname = path.join(__dirname, "/public", urlPathname);

	    // 读取静态文件
	    readStaticFile(res, filePathname);
	});

	// 在 3000 端口监听请求
	server.listen(3000, function() {
	    console.log("服务器运行中.");
	    console.log("正在监听 3000 端口:")
	})
	复制代码

* * *

好啦，今天的分享就告一段落啦。下一篇中，我会介绍 "如何搭建服务器路由" 和 "处理浏览器表单提交"
传送门 - [Node.js 系列 - 搭建路由 & 处理表单提交](https://juejin.im/post/6844903701446934535)
如果喜欢的话就点个关注吧！O(∩_∩)O 谢谢各位的支持❗️
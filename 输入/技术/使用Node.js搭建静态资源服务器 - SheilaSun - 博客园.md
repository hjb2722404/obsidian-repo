使用Node.js搭建静态资源服务器 - SheilaSun - 博客园

#   [使用Node.js搭建静态资源服务器](https://www.cnblogs.com/SheilaSun/p/7271883.html)

对于Node.js新手，搭建一个静态资源服务器是个不错的锻炼，从最简单的返回文件或错误开始，渐进增强，还可以逐步加深对http的理解。那就开始吧，让我们的双手沾满网络请求！

> Note:

> 当然在项目中如果有使用express框架，用> [> express.static](https://expressjs.com/en/starter/static-files.html)> 一行代码就可以达到目的了：

	app.use(express.static('public'))

> 这里我们要实现的正是`express.static`> 背后所做工作的一部分，建议同步阅读该模块源码。

## 基本功能

不急着写下第一行代码，而是先梳理一下就基本功能而言有哪些步骤。
1. 在本地根据指定端口启动一个http server，等待着来自客户端的请求
2. 当请求抵达时，根据请求的url，以设置的静态文件目录为base，映射得到文件位置
3. 检查文件是否存在
4. 如果文件不存在，返回404状态码，发送not found页面到客户端
5. 如果文件存在：

    - 打开文件待读取
    - 设置response header
    - 发送文件到客户端

6. 等待来自客户端的下一个请求

## 实现基本功能

### 代码结构

创建一个`nodejs-static-webserver`目录，在目录内运行`npm init`初始化一个package.json文件。

	mkdir nodejs-static-webserver && cd "$_"
	// initialize package.json
	npm init

接着创建如下文件目录：

	-- config
	---- default.json
	-- static-server.js
	-- app.js

**default.json**

	{
	    "port": 9527,
	    "root": "/Users/sheila1227/Public",
	    "indexPage": "index.html"
	}

`default.js`存放一些默认配置，比如端口号、静态文件目录（root)、默认页（indexPage）等。当这样的一个请求`http://localhost:9527/myfiles/`抵达时. 如果根据`root`映射后得到的目录内有index.html，根据我们的默认配置，就会给客户端发回index.html的内容。

**static-server.js**

	const http = require('http');
	const path = require('path');
	const config = require('./config/default');

	class StaticServer {
	    constructor() {
	        this.port = config.port;
	        this.root = config.root;
	        this.indexPage = config.indexPage;
	    }

	    start() {
	        http.createServer((req, res) => {
	            const pathName = path.join(this.root, path.normalize(req.url));
	            res.writeHead(200);
	            res.end(`Requeste path: ${pathName}`);
	        }).listen(this.port, err => {
	            if (err) {
	                console.error(err);
	                console.info('Failed to start server');
	            } else {
	                console.info(`Server started on port ${this.port}`);
	            }
	        });
	    }
	}

	module.exports = StaticServer;

在这个模块文件内，我们声明了一个`StaticServer `类，并给其定义了`start`方法，在该方法体内，创建了一个`server`对象，监听`rquest`事件，并将服务器绑定到配置文件指定的端口。在这个阶段，我们对于任何请求都暂时不作区分地简单地返回请求的文件路径。`path`模块用来规范化连接和解析路径，这样我们就不用特意来处理操作系统间的差异。

**app.js**

	const StaticServer = require('./static-server');

	(new StaticServer()).start();

在这个文件内，调用上面的`static-server`模块，并创建一个StaticServer实例，调用其`start`方法，启动了一个静态资源服务器。这个文件后面将不需要做其他修改，所有对静态资源服务器的完善都发生在`static-server.js`内。

在目录下启动程序会看到成功启动的log：

	> node app.js

	Server started on port 9527

在浏览器中访问，可以看到服务器将请求路径直接返回了。

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/Screen%20Shot%202017-07-29%20at%206.34.26%20PM.png)

### 路由处理

之前我们对任何请求都只是向客户端返回文件位置而已，现在我们将其替换成返回真正的文件：

	    routeHandler(pathName, req, res) {

	    }

	    start() {
	        http.createServer((req, res) => {
	            const pathName = path.join(this.root, path.normalize(req.url));
	            this.routeHandler(pathName, req, res);
	        }).listen(this.port, err => {
				...
	        });
	    }

将由`routeHandler`来处理文件发送。

### 读取静态文件

读取文件之前，用`fs.stat`检测文件是否存在，如果文件不存在，回调函数会接收到错误，发送404响应。

	    respondNotFound(req, res) {
	        res.writeHead(404, {
	            'Content-Type': 'text/html'
	        });
	        res.end(`<h1>Not Found</h1><p>The requested URL ${req.url} was not found on this server.</p>`);
	    }

	    respondFile(pathName, req, res) {
	        const readStream = fs.createReadStream(pathName);
	        readStream.pipe(res);
	    }

	    routeHandler(pathName, req, res) {
	        fs.stat(pathName, (err, stat) => {
	            if (!err) {
	                this.respondFile(pathName, req, res);
	            } else {
	                this.respondNotFound(req, res);
	            }
	        });
	    }

> Note:

> 读取文件，这里用的是流的形式`createReadStream`> 而不是`readFile`> ，是因为后者会在得到完整文件内容之前将其先读到内存里。这样万一文件很大，再遇上多个请求同时访问，`readFile`> 就承受不来了。使用文件可读流，服务端不用等到数据完全加载到内存再发回给客户端，而是一边读一边发送分块响应。这时响应里会包含如下响应头：

	Transfer-Encoding:chunked

> 默认情况下，可读流结束时，可写流的`end()`> 方法会被调用。

### MIME支持

现在给客户端返回文件时，我们并没有指定`Content-Type`头，虽然你可能发现访问文本或图片浏览器都可以正确显示出文字或图片，但这并不符合[规范](https://www.w3.org/Protocols/rfc2616/rfc2616-sec7.html#sec7.2.1)。任何包含实体主体（entity body）的响应都应在头部指明文件类型，否则浏览器无从得知类型时，就会自行猜测（从文件内容以及url中寻找可能的扩展名）。响应如指定了错误的类型也会导致内容的错乱显示，如明明返回的是一张`jpeg`图片，却错误指定了header：`'Content-Type': 'text/html'`，会收到一堆乱码。

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/Screen%20Shot%202017-07-30%20at%202.29.59%20PM.png)

虽然有现成的[mime](https://www.npmjs.com/package/mime)模块可用，这里还是自己来实现吧，试图对这个过程有更清晰的理解。
在根目录下创建`mime.js`文件：

	const path = require('path');

	const mimeTypes = {
	    "css": "text/css",
	    "gif": "image/gif",
	    "html": "text/html",
	    "ico": "image/x-icon",
	    "jpeg": "image/jpeg",
		 ...
	};

	const lookup = (pathName) => {
	    let ext = path.extname(pathName);
	    ext = ext.split('.').pop();
	    return mimeTypes[ext] || mimeTypes['txt'];
	}

	module.exports = {
	    lookup
	};

该模块暴露出一个`lookup`方法，可以根据路径名返回正确的类型，类型以`‘type/subtype’`表示。对于未知的类型，按普通文本处理。
接着在`static-server.js`中引入上面的`mime`模块，给返回文件的响应都加上正确的头部字段：

	    respondFile(pathName, req, res) {
	        const readStream = fs.createReadStream(pathName);
	        res.setHeader('Content-Type', mime.lookup(pathName));
	        readStream.pipe(res);
	    }

重新运行程序，会看到图片可以在浏览器中正常显示了。

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/Screen%20Shot%202017-07-30%20at%203.09.19%20PM.png)

> Note:

> 需要注意的是，`Content-Type`> 说明的应是原始实体主体的文件类型。即使实体经过内容编码（如`gzip`> ，后面会提到)，该字段说明的仍应是编码前的实体主体的类型。

## 添加其他功能

至此，已经完成了基本功能中列出的几个步骤，但依然有很多需要改进的地方，比如如果用户输入的url对应的是磁盘上的一个目录怎么办？还有，现在对于同一个文件（从未更改过）的多次请求，服务端都是勤勤恳恳地一遍遍地发送回同样的文件，这些冗余的数据传输，既消耗了带宽，也给服务器添加了负担。另外，服务器如果在发送内容之前能对其进行压缩，也有助于减少传输时间。

### 读取文件目录

现阶段，用url: `localhost:9527/testfolder`去访问一个指定root文件夹下真实存在的`testfolder`的文件夹，服务端会报错：

	Error: EISDIR: illegal operation on a directory, read

要增添对目录访问的支持，我们重新整理下响应的步骤：
1. 请求抵达时，首先判断url是否有尾部斜杠
2. 如果有尾部斜杠，认为用户请求的是目录

    - 如果目录存在
        - 如果目录下存在默认页（如index.html),发送默认页
        - 如果不存在默认页，发送目录下内容列表
    - 如果目录不存在，返回404

3. 如果没有尾部斜杠，认为用户请求的是文件

    - 如果文件存在，发送文件
    - 如果文件不存在，判断同名的目录是否存在
        - 如果存在该目录，返回301，并在原url上添加上`/`作为要转到的location
        - 如果不存在该目录，返回404

我们需要重写一下routeHandler内的逻辑：

	    routeHandler(pathName, req, res) {
	        fs.stat(pathName, (err, stat) => {
	            if (!err) {
	                const requestedPath = url.parse(req.url).pathname;
	                if (hasTrailingSlash(requestedPath) && stat.isDirectory()) {
	                    this.respondDirectory(pathName, req, res);
	                } else if (stat.isDirectory()) {
	                    this.respondRedirect(req, res);
	                } else {
	                    this.respondFile(pathName, req, res);
	                }
	            } else {
	                this.respondNotFound(req, res);
	            }
	        });
	    }

继续补充`respondRedirect`方法：

	    respondRedirect(req, res) {
	        const location = req.url + '/';
	        res.writeHead(301, {
	            'Location': location,
	            'Content-Type': 'text/html'
	        });
	        res.end(`Redirecting to <a href='${location}'>${location}</a>`);
	    }

浏览器收到301响应时，会根据头部指定的`location`字段值，向服务器发出一个新的请求。
继续补充`respondDirectory`方法：

	    respondDirectory(pathName, req, res) {
	        const indexPagePath = path.join(pathName, this.indexPage);
	        if (fs.existsSync(indexPagePath)) {
	            this.respondFile(indexPagePath, req, res);
	        } else {
	            fs.readdir(pathName, (err, files) => {
	                if (err) {
	                    res.writeHead(500);
	                    return res.end(err);
	                }
	                const requestPath = url.parse(req.url).pathname;
	                let content = `<h1>Index of ${requestPath}</h1>`;
	                files.forEach(file => {
	                    let itemLink = path.join(requestPath,file);
	                    const stat = fs.statSync(path.join(pathName, file));
	                    if (stat && stat.isDirectory()) {
	                        itemLink = path.join(itemLink, '/');
	                    }
	                    content += `<p><a href='${itemLink}'>${file}</a></p>`;
	                });
	                res.writeHead(200, {
	                    'Content-Type': 'text/html'
	                });
	                res.end(content);
	            });
	        }
	    }

当需要返回目录列表时，遍历所有内容，并为每项创建一个link，作为返回文档的一部分。需要注意的是，对于子目录的`href`，额外添加一个尾部斜杠，这样可以避免访问子目录时的又一次重定向。

在浏览器中测试一下，输入`localhost:9527/testfolder`，指定的`root`目录下并没有名为`testfolder`的文件，却存在同名目录，因此第一次会收到重定向响应，并发起一个对目录的新请求。

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/Screen%20Shot%202017-07-30%20at%207.57.25%20PM.png)

### 缓存支持

为了减少数据传输，减少请求数，继续添加缓存支持。首先梳理一下缓存的处理流程：
1. 如果是第一次访问，请求报文首部不会包含相关字段，服务端在发送文件前做如下处理：

    - 如服务器支持`ETag`，设置`ETag`头
    - 如服务器支持`Last-Modified`，设置`Last-Modified`头
    - 设置`Expires`头
    - 设置`Cache-Control`头（设置其`max-age`值）

浏览器收到响应后会存下这些标记，并在下次请求时带上与`ETag`对应的请求首部`If-None-Match`或与`Last-Modified`对应的请求首部`If-Modified-Since`。

2. 如果是重复的请求：

    - 浏览器判断缓存是否过期（通过`Cache-Control`和`Expires`确定）
        - 如果未过期，直接使用缓存内容，也就是强缓存命中，并不会产生新的请求
        - 如果已过期，会发起新的请求，并且请求会带上`If-None-Match`或`If-Modified-Since`，或者兼具两者
        - 服务器收到请求，进行缓存的新鲜度再验证：
            - 首先检查请求是否有`If-None-Match`首部，没有则继续下一步，有则将其值与文档的最新ETag匹配，失败则认为缓存不新鲜，成功则继续下一步
            - 接着检查请求是否有`If-Modified-Since`首部，没有则保留上一步验证结果，有则将其值与文档最新修改时间比较验证，失败则认为缓存不新鲜，成功则认为缓存新鲜

当两个首部皆不存在或者验证结果是不新鲜时，发送200及最新文件，并在首部更新新鲜度。
当验证结果是缓存仍然新鲜时（也就是弱缓存命中），不需发送文件，仅发送304，并在首部更新新鲜度
为了能启用或关闭某种验证机制，我们在配置文件里增添如下配置项：
**default.json**：

	{
		...
	    "cacheControl": true,
	    "expires": true,
	    "etag": true,
	    "lastModified": true,
	    "maxAge": 5
	}

这里为了能测试到缓存过期，将过期时间设成了非常小的5秒。
在`StaticServer`类中接收这些配置：

	class StaticServer {
	    constructor() {
			 ...
	        this.enableCacheControl = config.cacheControl;
	        this.enableExpires = config.expires;
	        this.enableETag = config.etag;
	        this.enableLastModified = config.lastModified;
	        this.maxAge = config.maxAge;
	    }

现在，我们要在原来的`respondFile`前横加一杠，增加是要返回304还是200的逻辑。

	    respond(pathName, req, res) {
	        fs.stat(pathName, (err, stat) => {
	            if (err) return respondError(err, res);
	            this.setFreshHeaders(stat, res);
	            if (this.isFresh(req.headers, res._headers)) {
	                this.responseNotModified(res);
	            } else {
	                this.responseFile(pathName, res);
	            }
	        });

	    }

准备返回文件前，根据配置，添加缓存相关的响应首部。

	    generateETag(stat) {
	        const mtime = stat.mtime.getTime().toString(16);
	        const size = stat.size.toString(16);
	        return `W/"${size}-${mtime}"`;
	    }

	    setFreshHeaders(stat, res) {
	        const lastModified = stat.mtime.toUTCString();
	        if (this.enableExpires) {
	            const expireTime = (new Date(Date.now() + this.maxAge * 1000)).toUTCString();
	            res.setHeader('Expires', expireTime);
	        }
	        if (this.enableCacheControl) {
	            res.setHeader('Cache-Control', `public, max-age=${this.maxAge}`);
	        }
	        if (this.enableLastModified) {
	            res.setHeader('Last-Modified', lastModified);
	        }
	        if (this.enableETag) {
	            res.setHeader('ETag', this.generateETag(stat));
	        }
	    }

需要注意的是，上面使用了`ETag`弱验证器，并不能保证缓存文件与服务器上的文件是完全一样的。关于强验证器如何实现，可以参考[etag](https://github.com/jshttp/etag/blob/master/index.js)包的源码。

下面是如何判断缓存是否仍然新鲜：

	    isFresh(reqHeaders, resHeaders) {
	        const  noneMatch = reqHeaders['if-none-match'];
	        const  lastModified = reqHeaders['if-modified-since'];
	        if (!(noneMatch || lastModified)) return false;
	        if(noneMatch && (noneMatch !== resHeaders['etag'])) return false;
	        if(lastModified && lastModified !== resHeaders['last-modified']) return false;
	        return true;
	    }

需要注意的是，http首部字段名是不区分大小写的（但http method应该大写），所以平常在浏览器中会看到大写或小写的首部字段。

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/Screen%20Shot%202017-07-31%20at%203.17.00%20PM.png)

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/Screen%20Shot%202017-07-31%20at%203.17.18%20PM.png)

但是`node`的`http`模块将首部字段都转成了小写，这样在代码中使用起来更方便些。所以访问header要用小写，如`reqHeaders['if-none-match']`。不过，仍然可以用`req.rawreq.rawHeaders`来访问原headers，它是一个`[name1, value1, name2, value2, ...]`形式的数组。

现在来测试一下，因为设置的缓存有效时间是极小的5s，所以强缓存几乎不会命中，所以第二次访问文件会发出新的请求，因为服务端文件并没做什么改变，所以会返回304。

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/1Screen%20Shot%202017-07-31%20at%207.35.42%20PM.png)

现在来修改一下请求的这张图片，比如修改一下size，目的是让服务端的再验证失败，因而必须给客户端发送200和最新的文件。

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/1Screen%20Shot%202017-07-31%20at%207.39.46%20PM.png)

接下来把缓存有效时间改大一些，比如10分钟，那么在10分钟之内的重复请求，都会命中强缓存，浏览器不会向服务端发起新的请求（但network依然能观察到这条请求）。

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/1Screen%20Shot%202017-07-31%20at%207.48.53%20PM.png)

### 内容编码

服务器在发送很大的文档之前，对其进行压缩，可以节省传输用时。其过程是：
1. 浏览器在访问网站时，默认会携带`Accept-Encoding`头

2. 服务器在收到请求后，如果发现存在`Accept-Encoding`请求头，并且支持该文件类型的压缩，压缩响应的实体主体（并不压缩头部），并附上`Content-Encoding`首部

3. 浏览器收到响应，如果发现有`Content-Encoding`首部，按其值指定的格式解压报文
对于图片这类已经经过高度压缩的文件，无需再额外压缩。因此，我们需要配置一个字段，指明需要针对哪些类型的文件进行压缩。
**default.json**

	{
		...
	    "zipMatch": "^\\.(css|js|html)$"
	}

**static-server.js**

		constructor() {
			...
	        this.zipMatch = new RegExp(config.zipMatch);
	    }

用`zlib`模块来实现流压缩：

	    compressHandler(readStream, req, res) {
	       const acceptEncoding = req.headers['accept-encoding'];
	       if (!acceptEncoding || !acceptEncoding.match(/\b(gzip|deflate)\b/)) {
	           return readStream;
	       } else if (acceptEncoding.match(/\bgzip\b/)) {
	           res.setHeader('Content-Encoding', 'gzip');
	           return readStream.pipe(zlib.createGzip());
	       } else if (acceptEncoding.match(/\bdeflate\b/)) {
	           res.setHeader('Content-Encoding', 'deflate');
	           return readStream.pipe(zlib.createDeflate());
	       }
	   }

因为配置了图片不需压缩，在浏览器中测试会发现图片请求的响应中没有`Content-Encoding`头。

### 范围请求

最后一步，使服务器支持范围请求，允许客户端只请求文档的一部分。其流程是：
1. 客户端向服务端发起请求
2. 服务端响应，附上`Accept-Ranges`头（值表示表示范围的单位，通常是“bytes”），告诉客户端其接受范围请求
3. 客户端发送新的请求，附上`Ranges`头，告诉服务端请求的是一个范围
4. 服务端收到范围请求，分情况响应：

    - 范围有效，服务端返回`206 Partial Content`，发送指定范围内内容，并在`Content-Range`头中指定该范围
    - 范围无效，服务端返回`416 Requested Range Not Satisfiable`，并在`Content-Range`中指明可接受范围

请求中的`Ranges`头格式为（这里不考虑多范围请求了）：

	Ranges: bytes=[start]-[end]

其中 start 和 end 并不是必须同时具有：
1. 如果 end 省略，服务器应返回从 start 位置开始之后的所有字节
2. 如果 start 省略，end 值指的就是服务器该返回最后多少个字节
3. 如果均未省略，则服务器返回 start 和 end 之间的字节
响应中的`Content-Range`头有两种格式：
1. 当范围有效返回 206 时：

	Content-Range: bytes (start)-(end)/(total)

2. 当范围无效返回 416 时：

	Content-Range: bytes */(total)

添加函数处理范围请求：

	    rangeHandler(pathName, rangeText, totalSize, res) {
	        const range = this.getRange(rangeText, totalSize);
	        if (range.start > totalSize || range.end > totalSize || range.start > range.end) {
	            res.statusCode = 416;
	            res.setHeader('Content-Range', `bytes */${totalSize}`);
	            res.end();
	            return null;
	        } else {
	            res.statusCode = 206;
	            res.setHeader('Content-Range', `bytes ${range.start}-${range.end}/${totalSize}`);
	            return fs.createReadStream(pathName, { start: range.start, end: range.end });
	        }
	    }

用 [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en)来测试一下。在指定的`root`文件夹下创建一个测试文件：

**testfile.js**

	This is a test sentence.

请求返回前六个字节 ”This “ 返回 206：

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/Screen%20Shot%202017-08-01%20at%202.41.42%20PM.png)

请求一个无效范围返回416：

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/Screen%20Shot%202017-08-01%20at%202.42.56%20PM.png)

### 读取命令行参数

至此，已经完成了静态服务器的基本功能。但是每一次需要修改配置，都必须修改`default.json`文件，非常不方便，如果能接受命令行参数就好了,可以借助 [yargs](https://github.com/yargs/yargs) 模块来完成。

	var options = require( "yargs" )
	    .option( "p", { alias: "port",  describe: "Port number", type: "number" } )
	    .option( "r", { alias: "root", describe: "Static resource directory", type: "string" } )
	    .option( "i", { alias: "index", describe: "Default page", type: "string" } )
	    .option( "c", { alias: "cachecontrol", default: true, describe: "Use Cache-Control", type: "boolean" } )
	    .option( "e", { alias: "expires", default: true, describe: "Use Expires", type: "boolean" } )
	    .option( "t", { alias: "etag", default: true, describe: "Use ETag", type: "boolean" } )
	    .option( "l", { alias: "lastmodified", default: true, describe: "Use Last-Modified", type: "boolean" } )
	    .option( "m", { alias: "maxage", describe: "Time a file should be cached for", type: "number" } )
	    .help()
	    .alias( "?", "help" )
	    .argv;

瞅瞅 help 命令会输出啥：

![](http://ot9sgcky1.bkt.clouddn.com/image/nodejs-static-webserver/Screen%20Shot%202017-08-01%20at%208.29.47%20PM.png)

这样就可以在命令行传递端口、默认页等：

	node app.js -p 8888 -i main.html

## 参考

1. [使用Node.js搭建简易Http服务器](http://coderlt.coding.me/2016/03/16/http-server-nodejs/)

2. [博文共赏：Node.js静态文件服务器实战](http://www.infoq.com/cn/news/2011/11/tyq-nodejs-static-file-server)

3. [HTTP 206 Partial Content In Node.js](https://www.codeproject.com/Articles/813480/HTTP-Partial-Content-In-Node-js)

## 源码

戳我的 GitHub repo: [nodejs-static-webserver](https://github.com/sheila1227/nodejs-static-webserver)

博文也同步在 GitHub，欢迎讨论和指正：[使用Node.js搭建静态资源服务器](https://github.com/sheila1227/FE-blog/issues/1)

标签: [Node](https://www.cnblogs.com/SheilaSun/tag/Node/), [http](https://www.cnblogs.com/SheilaSun/tag/http/)

 [好文要顶](使用Node.js搭建静态资源服务器%20-%20SheilaSun%20-%20博客园.md#)  [关注我](使用Node.js搭建静态资源服务器%20-%20SheilaSun%20-%20博客园.md#)  [收藏该文](使用Node.js搭建静态资源服务器%20-%20SheilaSun%20-%20博客园.md#)  [![icon_weibo_24.png](使用Node.js搭建静态资源服务器%20-%20SheilaSun%20-%20博客园.md#)  [![wechat.png](使用Node.js搭建静态资源服务器%20-%20SheilaSun%20-%20博客园.md#)

 [![20150331145757.png](../_resources/499ba7306d93f4aeb93b3822111583d2.jpg)](https://home.cnblogs.com/u/SheilaSun/)

 [SheilaSun](https://home.cnblogs.com/u/SheilaSun/)
 [关注 - 9](https://home.cnblogs.com/u/SheilaSun/followees/)
 [粉丝 - 141](https://home.cnblogs.com/u/SheilaSun/followers/)

 [+加关注](使用Node.js搭建静态资源服务器%20-%20SheilaSun%20-%20博客园.md#)

 9

 0

 [«](https://www.cnblogs.com/SheilaSun/p/4779895.html) 上一篇： [jQuery源码中的“new jQuery.fn.init()”什么意思？](https://www.cnblogs.com/SheilaSun/p/4779895.html)

 [»](https://www.cnblogs.com/SheilaSun/p/7294706.html) 下一篇： [使用Node.js实现简易MVC框架](https://www.cnblogs.com/SheilaSun/p/7294706.html)

posted @ 2017-08-02 08:27 [SheilaSun](https://www.cnblogs.com/SheilaSun/)  阅读(15527)  评论(10) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=7271883) [收藏](使用Node.js搭建静态资源服务器%20-%20SheilaSun%20-%20博客园.md#)
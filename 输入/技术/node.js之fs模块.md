node.js之fs模块

# node.js之fs模块

[[webp](../_resources/c60199425d12d5a42fd5e000f2b2b9a1.webp)](https://www.jianshu.com/u/a7bbc65dd117)

[明明三省](https://www.jianshu.com/u/a7bbc65dd117)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='274'%3e%3cpath d='M751.144277 307.2l-123.016533-238.933333h159.778133a81.92 81.92 0 0 1 59.1872 25.258666l160.256 167.492267A27.306667 27.306667 0 0 1 987.620011 307.2h-236.475734z m270.506667 111.547733L640.927744 946.039467a27.306667 27.306667 0 0 1-48.128-24.234667L766.504277 375.466667h-56.388266l-170.5984 590.165333a27.306667 27.306667 0 0 1-52.462934 0.034133L315.500544 375.466667H259.112277l174.523734 545.5872a27.306667 27.306667 0 0 1-48.128 24.302933L5.160277 418.747733A27.306667 27.306667 0 0 1 27.346944 375.466667H999.464277a27.306667 27.306667 0 0 1 22.152534 43.281066zM18.301611 261.0176L178.557611 93.525333A81.92 81.92 0 0 1 237.744811 68.266667h159.744L274.506411 307.2H38.030677a27.306667 27.306667 0 0 1-19.729066-46.1824zM453.877077 68.266667h117.896534l122.9824 238.933333H330.894677l122.9824-238.933333z' data-evernote-id='157' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*0.4422015.07.24 17:54:50字数 229阅读 59,803

## Node.js的文件系统的Api

	//公共引用
	var fs = require('fs'),
	path = require('path');
	123

### 1、读取文件readFile函数

	//readFile(filename,[options],callback);

	/**
	 * filename, 必选参数，文件名
	 * [options],可选参数，可指定flag（文件操作选项，如r+ 读写；w+ 读写，文件不存在则创建）及encoding属性
	 * callback 读取文件后的回调函数，参数默认第一个err,第二个data 数据
	 */

	fs.readFile(__dirname + '/test.txt', {flag: 'r+', encoding: 'utf8'}, function (err, data) {
	    if(err) {
	     console.error(err);
	     return;
	    }
	    console.log(data);
	});
	123456789101112131415

### 2、写文件

	// fs.writeFile(filename,data,[options],callback);
	var w_data = '这是一段通过fs.writeFile函数写入的内容；\n';
	var w_data = new Buffer(w_data);

	/**
	 * filename, 必选参数，文件名
	 * data, 写入的数据，可以字符或一个Buffer对象
	 * [options],flag,mode(权限),encoding
	 * callback 读取文件后的回调函数，参数默认第一个err,第二个data 数据
	 */

	fs.writeFile(__dirname + '/test.txt', w_data, {flag: 'a'}, function (err) {
	   if(err) {
	    console.error(err);
	    } else {
	       console.log('写入成功');
	    }
	});
	123456789101112131415161718

### 3、以追加方式写文件

	// fs.appendFile(filename,data,[options],callback);

	fs.appendFile(__dirname + '/test.txt', '使用fs.appendFile追加文件内容', function () {
	  console.log('追加内容完成');
	});
	12345

### 4、打开文件

	// fs.open(filename, flags, [mode], callback);

	/**
	 * filename, 必选参数，文件名
	 * flags, 操作标识，如"r",读方式打开
	 * [mode],权限，如777，表示任何用户读写可执行
	 * callback 打开文件后回调函数，参数默认第一个err,第二个fd为一个整数，表示打开文件返回的文件描述符，window中又称文件句柄
	 */

	fs.open(__dirname + '/test.txt', 'r', '0666', function (err, fd) {
	  console.log(fd);
	});
	123456789101112

### 5、读文件，读取打开的文件内容到缓冲区中；

	//fs.read(fd, buffer, offset, length, position, callback);
	/**
	 * fd, 使用fs.open打开成功后返回的文件描述符
	 * buffer, 一个Buffer对象，v8引擎分配的一段内存
	 * offset, 整数，向缓存区中写入时的初始位置，以字节为单位
	 * length, 整数，读取文件的长度
	 * position, 整数，读取文件初始位置；文件大小以字节为单位
	 * callback(err, bytesRead, buffer), 读取执行完成后回调函数，bytesRead实际读取字节数，被读取的缓存区对象
	 */

	fs.open(__dirname + '/test.txt', 'r', function (err, fd) {
	  if(err) {
	    console.error(err);
	    return;
	  } else {
	    var buffer = new Buffer(255);
	    console.log(buffer.length);
	    //每一个汉字utf8编码是3个字节，英文是1个字节
	    fs.read(fd, buffer, 0, 9, 3, function (err, bytesRead, buffer) {
	      if(err) {
	        throw err;
	      } else {
	        console.log(bytesRead);
	        console.log(buffer.slice(0, bytesRead).toString());
	        //读取完后，再使用fd读取时，基点是基于上次读取位置计算；
	        fs.read(fd, buffer, 0, 9, null, function (err, bytesRead, buffer) {
	          console.log(bytesRead);
	          console.log(buffer.slice(0, bytesRead).toString());
	        });
	      }
	    });
	  }
	});
	123456789101112131415161718192021222324252627282930313233

### 6、写文件，将缓冲区内数据写入使用fs.open打开的文件

	//fs.write(fd, buffer, offset, length, position, callback);

	/**
	 * fd, 使用fs.open打开成功后返回的文件描述符
	 * buffer, 一个Buffer对象，v8引擎分配的一段内存
	 * offset, 整数，从缓存区中读取时的初始位置，以字节为单位
	 * length, 整数，从缓存区中读取数据的字节数
	 * position, 整数，写入文件初始位置；
	 * callback(err, written, buffer), 写入操作执行完成后回调函数，written实际写入字节数，buffer被读取的缓存区对象
	 */

	fs.open(__dirname + '/test.txt', 'a', function (err, fd) {
	  if(err) {
	    console.error(err);
	    return;
	  } else {
	    var buffer = new Buffer('写入文件数据内容');
	    //写入'入文件'三个字
	    fs.write(fd, buffer, 3, 9, 12, function (err, written, buffer) {
	      if(err) {
	        console.log('写入文件失败');
	        console.error(err);
	        return;
	      } else {
	        console.log(buffer.toString());
	        //写入'数据内'三个字
	        fs.write(fd, buffer, 12, 9, null, function (err, written, buffer) {
	          console.log(buffer.toString());
	        })
	      }
	    });
	  }
	});
	123456789101112131415161718192021222324252627282930313233

### 7、刷新缓存区;

	// 使用fs.write写入文件时，操作系统是将数据读到内存，再把数据写入到文件中，当数据读完时并不代表数据已经写完，因为有一部分还可能在内在缓冲区内。
	// 因此可以使用fs.fsync方法将内存中数据写入文件；--刷新内存缓冲区；

	//fs.fsync(fd, [callback])
	/**
	 * fd, 使用fs.open打开成功后返回的文件描述符
	 * [callback(err, written, buffer)], 写入操作执行完成后回调函数，written实际写入字节数，buffer被读取的缓存区对象
	 */

	fs.open(__dirname + '/test.txt', 'a', function (err, fd) {
	  if(err)
	    throw err;
	  var buffer = new Buffer('我爱nodejs编程');
	  fs.write(fd, buffer, 0, 9, 0, function (err, written, buffer) {
	    console.log(written.toString());
	    fs.write(fd, buffer, 9, buffer.length - 9, null, function (err, written) {
	      console.log(written.toString());
	      fs.fsync(fd);
	      fs.close(fd);
	    })
	  });
	});
	12345678910111213141516171819202122

### 8、创建目录;

	//使用fs.mkdir创建目录
	//fs.mkdir(path, [mode], callback);

	/**
	 * path, 被创建目录的完整路径及目录名；
	 * [mode], 目录权限，默认0777
	 * [callback(err)], 创建完目录回调函数,err错误对象
	 */

	fs.mkdir(__dirname + '/fsDir', function (err) {
	  if(err)
	    throw err;
	  console.log('创建目录成功')
	});
	1234567891011121314

### 9、读取目录;

	//使用fs.readdir读取目录，重点其回调函数中files对象
	//fs.readdir(path, callback);

	/**
	 * path, 要读取目录的完整路径及目录名；
	 * [callback(err, files)], 读完目录回调函数；err错误对象，files数组，存放读取到的目录中的所有文件名
	 */

	fs.readdir(__dirname + '/fsDir/', function (err, files) {
	  if(err) {
	    console.error(err);
	    return;
	  } else {
	    files.forEach(function (file) {
	      var filePath = path.normalize(__dirname + '/fsDir/' + file);
	      fs.stat(filePath, function (err, stat) {
	        if(stat.isFile()) {
	          console.log(filePath + ' is: ' + 'file');
	        }
	        if(stat.isDirectory()) {
	          console.log(filePath + ' is: ' + 'dir');
	        }
	      });
	    });
	    for (var i = 0; i < files.length; i++) {
	      //使用闭包无法保证读取文件的顺序与数组中保存的致
	      (function () {
	        var filePath = path.normalize(__dirname + '/fsDir/' + files[i]);
	        fs.stat(filePath, function (err, stat) {
	          if(stat.isFile()) {
	            console.log(filePath + ' is: ' + 'file');
	          }
	          if(stat.isDirectory()) {
	            console.log(filePath + ' is: ' + 'dir');
	          }
	        });
	      })();
	    }
	  }
	});
	12345678910111213141516171819202122232425262728293031323334353637383940

### 10、查看文件与目录的信息;

	//fs.stat(path, callback);
	//fs.lstat(path, callback); //查看符号链接文件
	/**
	 * path, 要查看目录/文件的完整路径及名；
	 * [callback(err, stats)], 操作完成回调函数；err错误对象，stat fs.Stat一个对象实例，提供如:isFile, isDirectory,isBlockDevice等方法及size,ctime,mtime等属性
	 */

	//实例，查看fs.readdir
	12345678

### 11、查看文件与目录的是否存在

	//fs.exists(path, callback);

	/**
	 * path, 要查看目录/文件的完整路径及名；
	 * [callback(exists)], 操作完成回调函数；exists true存在，false表示不存在
	 */

	fs.exists(__dirname + '/te', function (exists) {
	  var retTxt = exists ? retTxt = '文件存在' : '文件不存在';
	  console.log(retTxt);
	});
	1234567891011

### 12、修改文件访问时间与修改时间

	//fs.utimes(path, atime, mtime, callback);

	/**
	 * path, 要查看目录/文件的完整路径及名；
	 * atime, 新的访问时间
	 * ctime, 新的修改时间
	 * [callback(err)], 操作完成回调函数；err操作失败对象
	 */

	fs.utimes(__dirname + '/test.txt', new Date(), new Date(), function (err) {
	  if(err) {
	    console.error(err);
	    return;
	  }
	  fs.stat(__dirname + '/test.txt', function (err, stat) {
	    console.log('访问时间: ' + stat.atime.toString() + '; \n修改时间：' + stat.mtime);
	    console.log(stat.mode);
	  })
	});
	12345678910111213141516171819

### 13、修改文件或目录的操作权限

	//fs.utimes(path, mode, callback);

	/**
	 * path, 要查看目录/文件的完整路径及名；
	 * mode, 指定权限，如：0666 8进制，权限：所有用户可读、写，
	 * [callback(err)], 操作完成回调函数；err操作失败对象
	 */

	fs.chmod(__dirname + '/fsDir', 0666, function (err) {
	  if(err) {
	    console.error(err);
	    return;
	  }
	  console.log('修改权限成功')
	});
	123456789101112131415

### 14、移动/重命名文件或目录

	//fs.rename(oldPath, newPath, callback);

	/**
	 * oldPath, 原目录/文件的完整路径及名；
	 * newPath, 新目录/文件的完整路径及名；如果新路径与原路径相同，而只文件名不同，则是重命名
	 * [callback(err)], 操作完成回调函数；err操作失败对象
	 */
	fs.rename(__dirname + '/test', __dirname + '/fsDir', function (err) {
	  if(err) {
	    console.error(err);
	    return;
	  }
	  console.log('重命名成功')
	});
	1234567891011121314

### 15、删除空目录

	//fs.rmdir(path, callback);

	/**
	 * path, 目录的完整路径及目录名；
	 * [callback(err)], 操作完成回调函数；err操作失败对象
	 */

	fs.rmdir(__dirname + '/test', function (err) {
	  fs.mkdir(__dirname + '/test', 0666, function (err) {
	    console.log('创建test目录');
	  });
	  if(err) {
	    console.log('删除空目录失败，可能原因：1、目录不存在，2、目录不为空')
	    console.error(err);
	    return;
	  }
	  console.log('删除空目录成功!');
	});
	123456789101112131415161718

### 16、监视文件

	//对文件进行监视，并且在监视到文件被修改时执行处理
	//fs.watchFile(filename, [options], listener);

	/**
	 * filename, 完整路径及文件名；
	 * [options], persistent true表示持续监视，不退出程序；interval 单位毫秒，表示每隔多少毫秒监视一次文件
	 * listener, 文件发生变化时回调，有两个参数：curr为一个fs.Stat对象，被修改后文件，prev,一个fs.Stat对象，表示修改前对象
	 */

	fs.watchFile(__dirname + '/test.txt', {interval: 20}, function (curr, prev) {
	  if(Date.parse(prev.ctime) == 0) {
	    console.log('文件被创建!');
	  } else if(Date.parse(curr.ctime) == 0) {
	    console.log('文件被删除!')
	  } else if(Date.parse(curr.mtime) != Date.parse(prev.mtime)) {
	    console.log('文件有修改');
	  }
	});
	fs.watchFile(__dirname + '/test.txt', function (curr, prev) {
	  console.log('这是第二个watch,监视到文件有修改');
	});
	123456789101112131415161718192021

### 17、取消监视文件

	//取消对文件进行监视
	//fs.unwatchFile(filename, [listener]);

	/**
	 * filename, 完整路径及文件名；
	 * [listener], 要取消的监听器事件，如果不指定，则取消所有监听处理事件
	 */

	var listener = function (curr, prev) {
	  console.log('我是监视函数')
	}
	fs.unwatchFile(__dirname + '/test.txt', listener);
	123456789101112

### 18、监视文件或目录

	// 对文件或目录进行监视，并且在监视到修改时执行处理；
	// fs.watch返回一个fs.FSWatcher对象，拥有一个close方法，用于停止watch操作；
	// 当fs.watch有文件变化时，会触发fs.FSWatcher对象的change(err, filename)事件，err错误对象，filename发生变化的文件名
	// fs.watch(filename, [options], [listener]);

	/**
	 * filename, 完整路径及文件名或目录名；
	 * [listener(event, filename], 监听器事件，有两个参数：event 为rename表示指定的文件或目录中有重命名、删除或移动操作或change表示有修改，filename表示发生变化的文件路径
	 */

	var fsWatcher = fs.watch(__dirname + '/test', function (event, filename) {
	  //console.log(event)
	});

	//console.log(fsWatcher instanceof FSWatcher);

	fsWatcher.on('change', function (event, filename) {
	  console.log(filename + ' 发生变化')
	});

	//30秒后关闭监视
	setTimeout(function () {
	  console.log('关闭')
	  fsWatcher.close(function (err) {
	    if(err) {
	      console.error(err)
	    }
	    console.log('关闭watch')
	  });
	}, 30000);
	123456789101112131415161718192021222324252627282930

### 19、文件流

	/*
	 * 流，在应用程序中表示一组有序的、有起点有终点的字节数据的传输手段；
	 * Node.js中实现了stream.Readable/stream.Writeable接口的对象进行流数据读写；以上接口都继承自EventEmitter类，因此在读/写流不同状态时，触发不同事件；
	 * 关于流读取：Node.js不断将文件一小块内容读入缓冲区，再从缓冲区中读取内容；
	 * 关于流写入：Node.js不断将流数据写入内在缓冲区，待缓冲区满后再将缓冲区写入到文件中；重复上面操作直到要写入内容写写完；
	 * readFile、read、writeFile、write都是将整个文件放入内存而再操作，而则是文件一部分数据一部分数据操作；
	 *
	 * -----------------------流读取-------------------------------------
	 * 读取数据对象：
	 * fs.ReadStream 读取文件
	 * http.IncomingMessage 客户端请求或服务器端响应
	 * net.Socket    Socket端口对象
	 * child.stdout  子进程标准输出
	 * child.stdin   子进程标准入
	 * process.stdin 用于创建进程标准输入流
	 * Gzip、Deflate、DeflateRaw   数据压缩
	 *
	 * 触发事件：
	 * readable  数据可读时
	 * data      数据读取后
	 * end       数据读取完成时
	 * error     数据读取错误时
	 * close     关闭流对象时
	 *
	 * 读取数据的对象操作方法：
	 * read      读取数据方法
	 * setEncoding   设置读取数据的编
	 * pause     通知对象众目停止触发data事件
	 * resume    通知对象恢复触发data事件
	 * pipe      设置数据通道，将读入流数据接入写入流；
	 * unpipe    取消通道
	 * unshift   当流数据绑定一个解析器时，此方法取消解析器
	 *
	 * ------------------------流写入-------------------------------------
	 * 写数据对象：
	 * fs.WriteStream           写入文件对象
	 * http.clientRequest       写入HTTP客户端请求数据
	 * http.ServerResponse      写入HTTP服务器端响应数据
	 * net.Socket               读写TCP流或UNIX流，需要connection事件传递给用户
	 * child.stdout             子进程标准输出
	 * child.stdin              子进程标准入
	 * Gzip、Deflate、DeflateRaw  数据压缩
	 *
	 * 写入数据触发事件：
	 * drain            当write方法返回false时，表示缓存区中已经输出到目标对象中，可以继续写入数据到缓存区
	 * finish           当end方法调用，全部数据写入完成
	 * pipe             当用于读取数据的对象的pipe方法被调用时
	 * unpipe           当unpipe方法被调用
	 * error            当发生错误
	 *
	 * 写入数据方法：
	 * write            用于写入数据
	 * end              结束写入，之后再写入会报错；
	 */
	123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354

### 20、创建读取流

	//fs.createReadStream(path, [options])
	/**
	 * path 文件路径
	 * [options] flags:指定文件操作，默认'r',读操作；encoding,指定读取流编码；autoClose, 是否读取完成后自动关闭，默认true；start指定文件开始读取位置；end指定文件开始读结束位置
	 */

	var rs = fs.createReadStream(__dirname + '/test.txt', {start: 0, end: 2});
	  //open是ReadStream对象中表示文件打开时事件，
	rs.on('open', function (fd) {
	  console.log('开始读取文件');
	});

	rs.on('data', function (data) {
	  console.log(data.toString());
	});

	rs.on('end', function () {
	  console.log('读取文件结束')
	});
	rs.on('close', function () {
	  console.log('文件关闭');
	});

	rs.on('error', function (err) {
	  console.error(err);
	});

	//暂停和回复文件读取；
	rs.on('open', function () {
	  console.log('开始读取文件');
	});

	rs.pause();

	rs.on('data', function (data) {
	  console.log(data.toString());
	});

	setTimeout(function () {
	  rs.resume();
	}, 2000);
	1234567891011121314151617181920212223242526272829303132333435363738394041

### 21、创建写入流

	//fs.createWriteStream(path, [options])
	/**
	 * path 文件路径
	 * [options] flags:指定文件操作，默认'w',；encoding,指定读取流编码；start指定写入文件的位置
	 */

	/* ws.write(chunk, [encoding], [callback]);
	 * chunk,  可以为Buffer对象或一个字符串，要写入的数据
	 * [encoding],  编码
	 * [callback],  写入后回调
	 */

	/* ws.end([chunk], [encoding], [callback]);
	 * [chunk],  要写入的数据
	 * [encoding],  编码
	 * [callback],  写入后回调
	 */

	var ws = fs.createWriteStream(__dirname + '/test.txt', {start: 0});
	var buffer = new Buffer('我也喜欢你');
	ws.write(buffer, 'utf8', function (err, buffer) {
	  console.log(arguments);
	  console.log('写入完成，回调函数没有参数')
	});
	//最后再写入的内容
	ws.end('再见');
	//使用流完成复制文件操作
	var rs = fs.createReadStream(__dirname + '/test.txt')
	var ws = fs.createWriteStream(__dirname + '/test/test.txt');

	rs.on('data', function (data) {
	  ws.write(data)
	});

	ws.on('open', function (fd) {
	  console.log('要写入的数据文件已经打开，文件描述符是： ' + fd);
	});

	rs.on('end', function () {
	  console.log('文件读取完成');
	  ws.end('完成', function () {
	    console.log('文件全部写入完成')
	  });
	});

	//关于WriteStream对象的write方法返回一个布尔类型，当缓存区中数据全部写满时，返回false;
	//表示缓存区写满，并将立即输出到目标对象中

	//第一个例子
	var ws = fs.createWriteStream(__dirname + '/test/test.txt');
	for (var i = 0; i < 10000; i++) {
	  var w_flag = ws.write(i.toString());
	  //当缓存区写满时，输出false
	  console.log(w_flag);
	}

	//第二个例子
	var ws = fs.createWriteStream(__dirname + '/test/untiyou.mp3');
	var rs = fs.createReadStream(__dirname + '/test/Until You.mp3');
	rs.on('data', function (data) {
	  var flag = ws.write(data);
	  console.log(flag);
	});

	//系统缓存区数据已经全部输出触发drain事件
	ws.on('drain', function () {
	  console.log('系统缓存区数据已经全部输出。')
	});
	12345678910111213141516171819202122232425262728293031323334353637383940414243444546474849505152535455565758596061626364656667686970

### 22、管道pipe实现流读写

	//rs.pipe(destination, [options]);
	/**
	 * destination 必须一个可写入流数据对象
	 * [opations] end 默认为true，表示读取完成立即关闭文件；
	 */

	var rs = fs.createReadStream(__dirname + '/test/Until You.mp3');
	var ws = fs.createWriteStream(__dirname + '/test/untiyou.mp3');
	rs.pipe(ws);
	rs.on('data', function (data) {
	  console.log('数据可读')
	});
	rs.on('end', function () {
	  console.log('文件读取完成');
	  //ws.end('再见')
	});
	12345678910111213141516

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='2704'%3e%3cpath d='M728.064 343.943529c-17.648941-2.891294-23.552-20.239059-26.503529-28.912941V104.026353C701.560471 46.200471 654.396235 0 595.425882 0c-53.007059 0-97.28 40.478118-106.134588 89.569882-29.997176 184.862118-138.541176 255.457882-217.630118 280.937412a26.142118 26.142118 0 0 0-18.130823 24.877177v560.067764c0 19.817412 16.022588 35.84 35.84 35.84h535.973647c56.018824-11.565176 94.328471-31.804235 120.892235-86.738823l120.832-416.105412c23.552-75.173647-14.757647-147.395765-100.231529-144.564706h-238.772706z m-571.813647 31.744H76.619294C35.358118 375.687529 0 410.383059 0 450.861176v462.426353c0 43.369412 32.406588 78.004706 76.619294 78.004706h79.631059c27.708235 0 50.115765-22.407529 50.115765-50.115764V425.863529a50.115765 50.115765 0 0 0-50.115765-50.115764z' data-evernote-id='151' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

95人点赞*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='64 64 896 896' focusable='false' class='js-evernote-checked' data-icon='right' width='1em' height='1em' fill='currentColor' aria-hidden='true' data-evernote-id='2708'%3e%3cpath d='M765.7 486.8L314.9 134.7A7.97 7.97 0 0 0 302 141v77.3c0 4.9 2.3 9.6 6.1 12.6l360 281.1-360 281.1c-3.9 3-6.1 7.7-6.1 12.6V883c0 6.7 7.7 10.4 12.9 6.3l450.8-352.1a31.96 31.96 0 0 0 0-50.4z' data-evernote-id='2709' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='2713'%3e%3cpath d='M771.413333 668.728889c-18.773333 3.015111-25.031111 20.878222-28.16 29.866667v217.884444c0 59.733333-49.948444 107.52-112.412444 107.52a115.427556 115.427556 0 0 1-112.412445-92.558222c-31.857778-190.919111-146.830222-263.850667-230.627555-290.133334a27.420444 27.420444 0 0 1-19.228445-26.168888V37.944889C268.572444 17.066667 285.582222 0 306.631111 0h567.864889c59.335111 11.946667 99.953778 32.824889 128 89.543111l128.113778 429.909333c24.974222 77.653333-15.644444 152.291556-106.211556 149.276445H771.413333z m-605.866666-32.824889H81.180444C37.546667 635.904 0 600.064 0 558.250667V80.611556C0 35.84 34.360889 0 81.180444 0H165.546667c29.297778 0 53.077333 23.779556 53.077333 53.077333v529.749334a53.077333 53.077333 0 0 1-53.077333 53.077333z' data-evernote-id='130' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

[*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='2718'%3e%3cpath d='M178.390055 120.591045C111.268624 120.591045 56.888889 174.401955 56.888889 240.556383V903.97778C56.888889 970.302855 111.097977 1024 178.390055 1024h545.731364c67.121431 0 121.558049-53.81091 121.558049-120.02222V240.613265c0-66.268192-54.209088-120.02222-121.558049-120.02222H178.390055z m455.117432 301.136319H269.06087a30.147761 30.147761 0 0 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z m303.18409 301.136318a30.318409 30.318409 0 0 1-30.375291-30.318409V180.317742c0-66.268192-53.81091-120.02222-121.330519-120.022219H329.697688a30.147761 30.147761 0 0 1 0-60.23864l454.946784 0.056882C885.326618 0.113765 967.009987 80.887013 967.009987 180.602155v511.943118a30.318409 30.318409 0 0 1-30.31841 30.318409z m-303.18409-120.47728H269.06087a30.147761 30.147761 0 1 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z' data-evernote-id='141' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*nodejs-issues](https://www.jianshu.com/nb/1389329)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='2724'%3e%3cpath d='M232.727273 579.87878833C271.28679 579.87878833 302.545455 548.62012233 302.545455 510.06060633 302.545455 471.50108933 271.28679 440.24242433 232.727273 440.24242433 194.167756 440.24242433 162.909091 471.50108933 162.909091 510.06060633 162.909091 548.62012233 194.167756 579.87878833 232.727273 579.87878833ZM512 579.87878833C550.559516 579.87878833 581.818182 548.62012233 581.818182 510.06060633 581.818182 471.50108933 550.559516 440.24242433 512 440.24242433 473.440484 440.24242433 442.181818 471.50108933 442.181818 510.06060633 442.181818 548.62012233 473.440484 579.87878833 512 579.87878833ZM791.272727 579.87878833C829.832243 579.87878833 861.090909 548.62012233 861.090909 510.06060633 861.090909 471.50108933 829.832243 440.24242433 791.272727 440.24242433 752.713211 440.24242433 721.454545 471.50108933 721.454545 510.06060633 721.454545 548.62012233 752.713211 579.87878833 791.272727 579.87878833Z' data-evernote-id='161' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

"为知识付费"
还没有人赞赏，支持一下

[[webp](../_resources/8af6ebdee768a6b95ecd9a21b21231b6.webp)](https://www.jianshu.com/u/a7bbc65dd117)

[明明三省](https://www.jianshu.com/u/a7bbc65dd117)青山在，绿水流，只记缘，不记仇。
总资产44 (约4.23元)共写了5.2W字获得342个赞共260个粉丝
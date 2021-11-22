node.js 标准/错误输出 和 process.exit - 拂晓风起-Kenko - 博客园

# [node.js 标准/错误输出 和 process.exit](https://www.cnblogs.com/kenkofox/p/4568805.html)

node.js中，各种模块有一种标准的写法：
this._process.exec(command, options, function (err, stdout, stderr) {
callback(err, stdout, stderr);
})
这里说的标准，是指回调函数，一般有err作为第一个参数，然后是具体的数据。

写服务器程序的时候，或多或少会用到**child_process**这个模块，而这个模块的用法正如上边代码所示。
例如调用一个shell命令删除文件，可以这样：
　　　　child_process.exec('rm -rf xxxx', function (err, stdout, stderr) {
callback(err, stdout, stderr);
})

返回的参数，其实err是一个对象，而stdout和stderr是字符串，stdout就是执行的子进程中使用**标准输出**的信息，而stderr就是子进程中**错误输出流**的内容。

那么问题来了，如果我们自己用node.js写一个简单脚本，让其他node程序去调用，怎么模仿实现一样的返回情况呢？
其他程序调用的时候，可能是这样：
child_process.exec('node doSomething.js', function (err, stdout, stderr) {
callback(err, stdout, stderr);
})
如果我们在子进程中，使用console.log/error打印信息，结果，会发现，在父进程的回调函数中将什么都得不到。
奇了怪了，console.error不就是错误输出吗？好吧，这只能怪自己写web写多了，然后node.js并不是这样的。

**接下来就要介绍三个玩意，分别对应stdout、stderr和err。**
process.stdout.write
process.stderr.write
process.exit(非0)

write函数接受的是一个字符串，那么为了方便使用，我们可以封装一下：

console.error = function () { var msg = Array.prototype.join.call(arguments, ', ');

process.stderr.write(msg);
};

最后，如果程序跑出错，除了在stderr中输出信息外，我们还可能需要立刻终止程序。
按照linux的规范，一般成功用0表示，而非0则表示失败。那么process.exit也遵循这个规范。

- **process.exit(0)表示成功完成，回调函数中，err将为null；**
- **process.exit(非0)表示执行失败，回调函数中，err不为null，err.code就是我们传给exit的数字。**

kenkofox@qq.com https://github.com/kenkozheng 欢迎投简历给我，力推腾讯工作机会

分类: [node.js](https://www.cnblogs.com/kenkofox/category/700125.html)

 [好文要顶](node.js%20标准_错误输出%20和%20process.exit%20-%20拂晓风起-Kenko%20-%20博客园.md#)  [关注我](node.js%20标准_错误输出%20和%20process.exit%20-%20拂晓风起-Kenko%20-%20博客园.md#)  [收藏该文](node.js%20标准_错误输出%20和%20process.exit%20-%20拂晓风起-Kenko%20-%20博客园.md#)  [![icon_weibo_24.png](node.js%20标准_错误输出%20和%20process.exit%20-%20拂晓风起-Kenko%20-%20博客园.md#)  [![wechat.png](node.js%20标准_错误输出%20和%20process.exit%20-%20拂晓风起-Kenko%20-%20博客园.md#)

 [![20160127172319.png](../_resources/877dee62b5b3f19ecdabe6df24564384.jpg)](http://home.cnblogs.com/u/kenkofox/)

 [拂晓风起-Kenko](http://home.cnblogs.com/u/kenkofox/)
 [关注 - 1](http://home.cnblogs.com/u/kenkofox/followees)
 [粉丝 - 287](http://home.cnblogs.com/u/kenkofox/followers)

 [+加关注](node.js%20标准_错误输出%20和%20process.exit%20-%20拂晓风起-Kenko%20-%20博客园.md#)

 2

 0

[«](https://www.cnblogs.com/kenkofox/p/4545789.html) 上一篇：[nodejs直接调用grunt（非调用批处理）](https://www.cnblogs.com/kenkofox/p/4545789.html)

[»](https://www.cnblogs.com/kenkofox/p/4572479.html) 下一篇：[JS 拦截/捕捉 全局错误 全局Error onerror](https://www.cnblogs.com/kenkofox/p/4572479.html)

posted @ 2015-06-11 12:53  [拂晓风起-Kenko](https://www.cnblogs.com/kenkofox/) 阅读(8690) 评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=4568805)  [收藏](https://www.cnblogs.com/kenkofox/p/4568805.html?utm_source=tuicool#)
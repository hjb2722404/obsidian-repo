Node.js 的 process.nextTick(callback) 理解

   Node.js 的 process.nextTick(callback) 理解

Node.js 是单线程的，基于事件循环，非阻塞 IO 的。事件循环中使用一个事件队列，在每个**时间点**上，系统只会处理一个事件，即使电脑有多个 CPU 核心，也无法同时并行的处理多个事件。因此，node.js 适合处理 I／O 型的应用，不适合那种 CPU 运算密集型的应用。在 I／O 型的应用中，给每一个输入输出定义一个回调函数，node.js 会自动将其加入到事件轮询的处理队列里，当 I／O 操作完成后，这个回调函数会被触发，系统会继续处理其他的请求。

在这里用 debuggable.com 上的那个文章中的一段比喻来讲，非常容易理解。如下：

我们写的 js 代码就像是一个国王，而 nodejs 给国王提供了很多仆人。早上，一个仆人叫醒了国王，问他有什么需要。国王给他一份清单，上面列举了所有需要完成的任务，然后睡回笼觉去了。当国王回去睡觉之后，仆人才离开国王，拿着清单，给其它的仆人一个个布置任务。仆人们各自忙各自的去了，直到完成了自己的任务后，才回来把结果禀告给国王。国王一次只召见一个人，其它的人就在外面排着队等着。国王处理完这个结果后，可能给他布置一个新的任务，或者就直接让他走了，然后再召见下一个人。等所有的结果都处理完了，国王就继续睡觉去了。直接有新的仆人完成任务后过来找他。这就是国王的幸福生活。

**process.nextTick(callback) **

功能：在事件循环的下一次循环中调用 callback 回调函数。效果是将一个函数推迟到代码书写的下一个**同步方法执行完毕时**或**异步方法的事件回调函数开始执行时**；与 setTimeout(fn, 0) 函数的功能类似，但它的效率高多了。

基于 node.js 的事件循环分析，每一次循环就是一次 tick，每一次 tick 时，v8 引擎从事件队列中取出所有事件依次进行处理，如果遇到 nextTick 事件，则将其加入到事件队尾，等待下一次 tick 到来时执行；造成的结果是，nextTick 事件被延迟执行；以下是 nextTick 源码

![151448124376230.png](../_resources/0ff60768176afc2439a45f7641fc3385.png)

从这几行代码中，我们可以看出很多信息：
1. nextTick 的确是把某任务放在队列的最后（array.push)
2. nodejs 在执行任务时，会一次性把队列中所有任务都拿出来，依次执行
3. 如果全部顺利完成，则删除刚才取出的所有任务，等待下一次执行
4. 如果中途出错，则删除已经完成的任务和出错的任务，等待下次执行
5. 如果第一个就出错，则 throw error
下面看一下应用场景（包含计算密集型操作，将其进行递归处理，而不阻塞进程）：
1. var http = require('http');
2. var wait = function (mils) {
3.     var now = new  Date;
4.     while (new  Date - now <= mils);
5. };
6. function compute() {
7.     // performs complicated calculations continuously
8.     console.log('start computing');
9.     wait(1000);
10.     console.log('working for 1s, nexttick');
11.     process.nextTick(compute);
12. }
13. http.createServer(function (req, res) {
14.     console.log('new request');
15.     res.writeHead(200, {'Content-Type': 'text/plain'});
16.     res.end('Hello World');
17. }).listen(5000, '127.0.0.1');
18. compute();

1、其中 compute 是一个密集计算的函数，我们把它变为可递归的，每一步需要 1 秒（使用 wait 来代替密集运行）。执行完一次后，通过 process.nextTick 把下一次的执行放在队列的尾部，转而去处理已经处于等待中的客户端请求。这样就可以同时兼顾两种任务，让它们都有机会执行。

关于 node.js 中处理计算密集型，可以参考以下几种方法：

- c/c++ 的 addon 来实现，在需要进行 cpu 密集型计算的地方，把 js 代码改写成 c/c++ 代码；对于不熟悉 C++ 代码，成本较高
- 使用 cluster 创建多进程处理，但编码复杂度比较高；
- 让 node 支持多线程模型的模块：threads_a_gogogithub 地址：https://github.com/xk/node-threads-a-gogo（比较好用一些，[参考介绍](http://snoopyxdy.blog.163.com/blog/static/60117440201349352443/)）

2、另外：异步模型的关系，导致某些代码的执行可能先于它们所需要的条件完成之前，所以将这些需要先置条件的代码放入到一个回调函数中，然后放入到下一个事件循环的顶层。那么这些代码就不会被立刻执行了，而是在下一轮事件启动之前等待，启动后在进行执行。

范例：

var MyConstructor = function() {
... process.nextTick(function() {
self._continue(); });};

MyConstructor.prototype.__proto__ = EventEmitter.prototype;

MyConstructor.prototype._continue = function() { // without the process.nextTick // these events would be emitted immediately // with no listeners. they would be lost. this.emit('data', 'hello'); this.emit('data', 'world'); this.emit('end');};

 function(req, res, next) { var c = new MyConstructor(...);
c.on('data', function(data) {
console.log(data); });
c.on('end', next);}

共计：2779 个字   全文完本文由 简悦 [SimpRead](http://ksria.com/simpread) 转码，原文地址 https://www.cnblogs.com/gaojun/p/4164864.html
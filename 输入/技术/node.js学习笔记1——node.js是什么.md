node.js学习笔记1——node.js是什么

# node.js学习笔记1——node.js是什么

理论知识
node.js已经出现并流行了好长一段时间了，但直到最近因为公司项目的需要，才开始学习，现在把学习的一些心得记录下来，以供自己和其他类似 入门者参考。
**node.js是什么？**
官方给出的解释如下：
> Node.js® is a platform built on Chrome's JavaScript runtime for easily
> building fast, scalable network applications. Node.js uses an
> event-driven, non-blocking I/O model that makes it lightweight and
> efficient, perfect for data-intensive real-time applications that run
> across distributed devices
大概意思是说：

> node.js是一个基于chrome的javascript引擎，为了构建更快速，容易，可扩展的网络应用程序而建立的平台。它使用事件驱动机制，非阻塞的I/O模式，这使得它对于那些运行在分布式设备上的数据密集型的实时性应用程序是非常轻量级，高效率和完美的。

从官方的解释，我们可以知道，node.js是一个基于chrome的js引擎（应该是V8）的平台，这就决定了它是一个javascript的运行时环境。所以基于它的应用程序应该都是使用javascript去实现的。

我们再来看看官方解释中的几个基本概念。
**事件驱动机制**
百度百科上对事件驱动的解释如下：
> 所谓事件驱动，简单地说就是你点什么按钮（即产生什么事件），电脑执行什么操作（即调用什么函数）.当然事件不仅限于用户的操作.
> 事件驱动的核心自然是事件。从事件角度说，事件驱动程序的基本结构是由一个事件收集器、一个事件发送器和一个事件处理器组成。
按照事件驱动的概念，那么node.js应该也是使用事件监听的机制，这和javascript本身并没有多大差别。
**非阻塞的I/O模式**
关于I/O模式，可以参考下面这篇文章：
[I/O模式详细探究](http://www.cnblogs.com/renxs/p/3683189.html)
通过这篇文章的解释我们至少可以知道，
阻塞的I/O模式，会导致应用中如果有一个请求要执行很久才能返回结果，那这期间客户端（服务端）会一直等待该请求处理结束，无法做其他任何事情；
非阻塞的I/O模式，即使应用程序中有一个请求要执行很久才能返回结果，客户端（服务端）依然可以在等待该请求处理的结果的同时，先处理其他的业务。
Guillermo Rauch 在《了不起的Node.js》一书中举了两个小例子来解释阻塞与非阻塞的区别：
运行下面的PHP代码：

	//php
	    print('Hello');

	    sleep(5);

	    print('world');

当运行这段代码时，程序会先打印出“Hello”，然后过5秒后再打印出“world”，这5秒期间不会做任何事，因为sleep（）函数让线程挂起了，阻塞了。
再看下面的Node.js小片段：

	console.log('Hello');

	    setTimeout(function(){
	        console.log('world');
	    },5000);

	    console.log('Bye');

	    //这段脚步会输出：

	    //Hello
	    //Bye
	    //world

可以看出，setTimeout()是非阻塞的，因为程序在等待程序执行“console.log('world')”语句的5秒内还继续执行了后面的代码，所以导致最后是先输出了“Bye”,5秒后才又输出了“world”,而如果setTimeout是阻塞的话，就会在打印出“Hello”后等待5秒钟再打印出“world”，然后再打印出“Bye”。

说了这么多，非阻塞的好处已经显而易见，就是node.js官方定义中所说的：**更高效，在处理密集型（比如高并发）实时性应用程序的时候更快速**。
形象点说，如果采用阻塞的服务端架构，使用你自己的个人笔记本电脑是无法处理每秒上千个请求的，但是，如果使用node.js，就可以。
另外，通过其他一些资料，我们知道，node.js是单线程的，那么它是如何进行并行操作的呢？
Guillermo Rauch 再次给了我们答案：

> 关键在于，在调用堆栈执行非常快的情况下，同一时刻你无须处理多个请求。因为非阻塞I/O确保了单线程执行时，不会因为有数据库访问或者硬盘访问等操作而导致被挂起。

况且，我们还可以创建子进程。这个以后再详细研究。
[markdownFile.md](../_resources/2e81414209fb782af2e56b88f0d5fa3c.bin)
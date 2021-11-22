CPU、GPU、内存以及多进程架构

 [翻译](https://blog.acohome.cn/tag/translate/)

# CPU、GPU、内存以及多进程架构

硬件是组成电脑的关键，在深入理解浏览器架构前，我们需要了解一些硬件基础，CPU GPU 以及内存在计算机中扮演着什么角色，都有什么功能

- ![](../_resources/66a81b15a37294047137ba8dcdb1e3f4.png)

## 阿飞

芝兰生于幽谷，不以无人而不芳。

阿飞的[更多文章](https://blog.acohome.cn/author/aco/)

 [![](../_resources/66a81b15a37294047137ba8dcdb1e3f4.png)](https://blog.acohome.cn/author/aco/)

#### [阿飞](https://blog.acohome.cn/author/aco/)

 16日 4月 2019  • 11 分钟

#### ##console.info

本文翻译自 `Google` 的官方文档，该系列共 `4` 篇文章，**从内部观察现代浏览器 `(Chrome)`**，同时解答了浏览器的内部架构，讲述了浏览器从输入 `url` 到页面呈现的全过程。

[原文链接: inside-browser-part1](https://developers.google.com/web/updates/2018/09/inside-browser-part1)

* * *

## [前言](https://blog.acohome.cn/inside-browser-part1/#-)

该篇文章作为本系列的第一篇，我们先来了解下关于计算机的核心术语和 `Chrome` 的多进程架构模型。

## [计算机的核心 - CPU & GPU](https://blog.acohome.cn/inside-browser-part1/#-cpu-gpu)

在了解浏览器是如何运行之前，我们必须对它所处的运行环境有所了解，毕竟浏览器是基于这些硬件的。

### #[CPU 中央处理器](https://blog.acohome.cn/inside-browser-part1/#cpu-)

![t-chrome-blog-cpu.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/9407812940681a84a4b4661b551da819.png)
4核 CPU 处理任务流程

`CPU (Central Processing Unit)` 是计算机的大脑，一个 `CPU` 核心就像是一个员工，能逐个处理分配的任务。它可以接收数学、艺术在内的所有任务，并将任务的处理结果返回给任务的发布者。

曾经大多数的 `CPU` 是单核的，而目前，我们经常使用多核的 `CPU` ，多核 `CPU` 为计算机提供了更为强大的计算能力。

### #[GPU 图像处理单元](https://blog.acohome.cn/inside-browser-part1/#gpu-)

![t-chrome-blog-gpu.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/8fc555c4a70f7f844dbb34edec74cf1f.png)
大量的 GPU 单元处理处理任务

`GPU (Graphics Processing Unit)` 是计算机另一个重要组成部分。不同于 `CPU` ，`GPU` 更擅长处理简单任务，同时一个任务可以由多个 `GPU` 核心共同处理。

`GPU` 顾名思义，它的出现就是为了处理图像任务。我们常常说的 “使用 `GPU`”、“`GPU` 支持”，就是使用 `GPU` 来进行快速渲染、平滑交互。近些年，随着 `GPU` 的迅速发展，越来越多的计算任务可以单独的运行在 `GPU` 上。

### #[计算机的三层架构](https://blog.acohome.cn/inside-browser-part1/#--1)

当你在你的计算机或手机上打开一个应用时，`CPU` 和 `GPU` 为应用提供了计算能力，但是应用是不能直接调用 `CPU` 或 `GPU` 的，必须通过调用操作系统提供的相关 `API` 来处理相关任务。

![t-chrome-blog-hw-os-app.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/2af38ddf296b92cd6bbbf97322774c33.png)
计算机的三层架构，硬件在底部，应用在顶部，操作系统负责协调硬件和应用

## [进程 (Process) & 线程 (Thread)](https://blog.acohome.cn/inside-browser-part1/#-process-thread-)

在深入了解浏览器 `(Chrome)` 前，我们还需了解操作系统提供两个概念：进程 `(Process)` & 线程 `(Thread)` 。
进程可以被认为是应用的执行程序，而线程则由进程产生，执行进程所分配的部分程序。
![t-chrome-blog-process-thread.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/97afac83d32e43397ea484653bb6b1ec.png)
进程是线程的容器
当你打开一个应用程序，一个进程就会被创建，该进程可能会创建多个线程来帮助其执行程序。
当一个进程被操作系统创建时，操作系统同时会为该线程分配一定大小的内存空间，该内存空间可以存储进程在执行过程中产生的一些数据。
不同的进程享有不同区域的内存空间，当进程退出时，进程所占用的内存空间也会得到释放。
![t-chrome-blog-memory.png](../_resources/31afd4b293665221b5a29f93e94ddfcc.png)
应用打开/关闭时，操作系统的行为

一个进程能够向操作系统请求启动另一个进程来帮助其执行任务，由于不同进程占用了不同的内存空间，所以不同进程所存储的数据是不共享的，如果进程间需要数据交互就只能通过 `IPC (Inter Process Communication)` 的方式。

许多应用程序被设计成多进程，一个重要的原因就是当某个进程无响应时，只要重新启动该进程即可，而其他的进程不会受到该进程的影响。
![t-chrome-blog-workerprocess.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/f931c78a0c7cd60257cfe5d79a4da27b.png)
多进程应用，通过 IPC 通信

## [浏览器架构](https://blog.acohome.cn/inside-browser-part1/#--2)

在了解进程以及线程后，浏览器是如果使用进程 `&` 线程来架构的呢？总的来说有两种：
1. 一个进程以及进程创建的多个线程来处理包括网络请求，渲染页面等多个任务
2. 创建很多个进程来处理多个任务，并且通过 `IPC` 的方式进行进程间通信
![t-chrome-blog-browser-arch.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/23162955642bb163b16a5d08bdbb3288.png)
不同的浏览器架构图
不同的浏览器架构有着不同的实现细节，如何实现一个浏览器也没有固定的标准。因此在这个系列中，我们所描述的浏览器架构是针对 `Chrome` 浏览器的。

`Chrome` 是以多进程进行架构的，处在顶端的是浏览器进程(主进程)，负责渲染基础部分的 `UI` 以及协调其他不同进程处理浏览器中不同的应用。对于渲染进程来说，主进程会根据选项卡的情况，创建多个渲染进程。`Chrome` 会为每个选项卡创建一个渲染进程，处理渲染任务。 `Chrome` 也会尝试为每个站点创建一个单独的进程包括 `iframe` 。

![t-chrome-blog-browser-arch2.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/898bb4e5c529e5d3280b6787a7d261a3.png)
Chrome 的多进程架构模型

## [不同进程处理的任务](https://blog.acohome.cn/inside-browser-part1/#--3)

下表展示了进程名以及进程任务
进程名
任务
[object Object] (主进程)
[object Object] 最基础的进程，控制标签栏、地址栏书签、前进后退按钮，以及一些基础功能，如：网络请求和文件访问
[object Object] (渲染进程)
控制每一个选项卡的窗口部分
[object Object](插件进程)
控制网站所有使用到的插件，比如：[object Object]
[object Object]( [object Object] 进程)
处理由其他进程发出的 [object Object] 任务，它被分成不同的进程，渲染浏览器窗口中的不同部分。
![t-chrome-blog-browserui.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/7f4058ac29b1f70d9e05a7045baccd2c.png)
浏览器窗口不同部分被不同的进程处理

上面是浏览器中主要的进程，浏览器还会创建其他的进程，比如 `Extension` (扩展进程) 和 `utility` (公共进程) 等。如果你想看到底有多少进程在运行，可以点击浏览器右上角 `-->`  `More Tools` (更多工具) `-->`  `Task Manager` (任务管理器)，弹出的窗口会详细的列出每个进程的 `ID` 、名称以及所占用的内存和 `CPU` 资源。

## [多进程架构的优点](https://blog.acohome.cn/inside-browser-part1/#--4)

之前，我们提到过 `Chrome` 为每个选项卡都开启了一个进程，那么优点在哪呢？
试想一个简单的场景，你在 `Chrome` 上打开了 `3` 个页面，当一个页面崩溃了会发生什么？

假设浏览器的 `3` 个页面共用一个渲染进程，那么当那个页面崩溃就会导致这个渲染进程的崩溃，那么其他两个页面理所当然的挂掉；那如果这 `3` 个页面由 `3` 个渲染进程单独渲染，那么单独一个页面的崩溃并不会影响到另外的两个页面。

![t-chrome-blog-tabs.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/2838102aa5ce695eb9e65c38b77ad6bb.png)
不同选项卡分配不同的渲染进程

浏览器多进程架构的另一个好处在于安全和私有。由于操作系统可以限制进程的权限，那么浏览器主进程就能创建拥有特定权限的进程，使得进程在一个沙箱中运行。比如浏览器创建的渲染进程的文件访问权限就会有一定的限制。

由于每个进程的内存空间都是私有的，而每个进程都会包含一些公共的基础功能(比如 `V8` 浏览器 `javascript` 解释器)，所以越多的进程意味着越大的内存消耗，当然如果不是多进程架构，而是以 `进程-线程` 的方式，就会减轻内存的消耗量（线程共享进程占用的内存空间）。因此 `Chrome` 会根据内存和 `CPU` 的情况预先确定出进程的限制，一旦进程达到限制，`Chrome` 就会使用 `进程-线程` 的模式来处理新的窗口创建。

## [节约内存 - Chrome 服务化](https://blog.acohome.cn/inside-browser-part1/#-chrome-)

相同的节约内存的策略同样适用于整个浏览器的进程架构，`Chrome` 在后台运行时，会将不同的任务分配不同的进程或整合进同一个进程。
主要的分配任务的策略如下：
1. 当硬件资源充分时，`Chrome` 将不同的任务分配到不同的进程，以提高运行的稳定和高效；
2. 当硬件资源有限时，`Chrome` 会将一些进程的功能汇集成一个进程，从而节约内存的使用；
![t-chrome-blog-servicfication.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/3046fc69e2f500f41c62a2f8c6d16a81.png)
Chrome 针对硬件资源分配任务

## [单独的渲染进程 - 站点隔离](https://blog.acohome.cn/inside-browser-part1/#--5)

[站点隔离](https://developers.google.com/web/updates/2018/07/site-isolation)是 `Chrome` 最近推出的一个功能，它确保了每个跨站点的 `iframe` 都渲染在单独的进程中。我们之前讨论过浏览器给每个选项卡分配了一个进程，那么跨站点的 `iframe` 也会被同一个进程渲染，那么这个跨站点的 `iframe` 就和主站点的在同一个进程下，共用了同一片内存区域。

在同一个进程中同时渲染 `a.com` 和 `b.com` 的内容似乎没多大问题，因为[同源策略](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)是 `web` 的核心安全模型，它确保了一个站点不能在未经允许的情况下获取另一个站点的数据。但是 [Meltdown 和 Spectre](https://developers.google.com/web/updates/2018/02/meltdown-spectre)漏洞的出现，我们必须要使用进程隔离来确保站点的隔离。在 `Chrome 67` 版本之后，站点隔离将自动应用在跨站点的 `iframe` 上。

![t-chrome-blog-isolation.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/fa70a857e645bec8876257580a935282.png)
站点隔离示意图

实现站点隔离是多年工程的累积，站点隔离远远不是开启一个渲染进程那么简单。这从根本上改变了该 `iframe` 与其他页面之间的交互方式。比如，当打开 `devtools` 时，由于 `iframe` 在另外一个进程上，但进程间是相互独立的，那么 `devtools` 的进程就必须流畅的实现页面获取合并等相关内容；即使简单的查找功能( `CTRL + F` )，都要通过搜索几个不同的进程来实现。因此浏览器工程师将该功能的发布视为一个重要的里程碑。

## [小结](https://blog.acohome.cn/inside-browser-part1/#--6)

这篇博文，大致介绍了如下内容

- 浏览器的架构模型
- 多进程模型的优点
- `Chrome` 的服务化，目的在于节约内存
- 站点隔离的实现方式

下一篇文章，我们将开始深入研究浏览器为了页面的显示，是如何搭配使用这些进程和线程。

## [相关文章](https://blog.acohome.cn/inside-browser-part1/#--7)

- [CPU、GPU、内存以及多进程架构](https://blog.acohome.cn/inside-browser-part1/)
- [一次导航到底发生了什么？](https://blog.acohome.cn/inside-browser-part2/)
- [详解渲染进程](https://blog.acohome.cn/inside-browser-part3/)
- [事件合成器](https://blog.acohome.cn/inside-browser-part4/)
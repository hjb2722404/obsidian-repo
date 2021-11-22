Docker容器应用日志查看 - benben的博客 - CSDN博客

原

# Docker容器应用日志查看

2018年06月15日 18:13:47[benben_2015](https://me.csdn.net/benben_2015)阅读数：8666

版权声明：本文为博主原创文章，未经博主允许不得转载。	https://blog.csdn.net/benben_2015/article/details/80708723

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' style='display: none%3b' data-evernote-id='527' class='js-evernote-checked'%3e%3cpath stroke-linecap='round' d='M5%2c0 0%2c2.5 5%2c5z' id='raphael-marker-block' style='-webkit-tap-highlight-color: rgba(0%2c 0%2c 0%2c 0)%3b' data-evernote-id='528' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

### docker attach命令

`docker attach [options] 容器`会连接到正在运行的容器，然后将容器的标准输入、输出和错误流信息附在本地打印出来。命令中`options`的取值有三种：`--detach-keys`,`--no-stdin`,`--sig-proxy`。

该命令只是进入容器终端，不会启动新的进程。所以当你同时使用多个窗口进入该容器，所有的窗口都会同步显示。如果一个窗口阻塞，那么其他窗口也就无法再进行操作。

使用`ctrl+c`可以直接断开连接，但是这样会导致容器退出，而且还`stop`了。如果想在脱离容器终端时，容器依然运行。就需要使用`--sig-proxy`这个参数。例如：

	$ docker attach --sig-proxy=false mytest

- 1

**注意：** 当使用`docker attach`连接到容器的标准输入输出时，`docker`使用大约`1MB`的内存缓冲区来最大化应用程序的吞吐量。如果此缓冲区填满，那么输出或写入的速度将会受到影响。因此查看应用日志，可以使用`docker logs`命令。

### docker logs命令

`docker logs [options] 容器`获取容器的日志。

| 名字  | 默认值 | 描述  |
| --- | --- | --- |
| –details |     | 显示提供给日志的额外细节 |
| –follow或-f |     | 按日志输出 |
| –since |     | 从某个时间开始显示 |
| –tail | all | 从日志末尾多少行开始显示 |
| –timestamps或-t |     | 显示时间戳 |
| –until |     | 打印某个时间以前的日志 |

例如打印容器`mytest`应用后10行的内容。

	$ docker logs --tail="10" mytest

- 1
mac os x 查看网络端口情况 - 永福的博客 - 开源中国社区

 原 mac os x 查看网络端口情况

 [**   收藏](mac%20os%20x%20查看网络端口情况%20-%20永福的博客%20-%20开源中国社区.md#)

 [永福](https://my.oschina.net/foreverich/home)

- 发表于 2年前

- 阅读 18646

- 收藏 12

- 点赞 4

- [评论0](https://my.oschina.net/foreverich/blog/402252#comment-list)

摘要: 查看mac os x 的网络端口使用情况， telnet， nc， netstat， lsof， 网络实用工具

## 查看端口是否打开

#### 使用 `netstat` 命令

	a. `netstat -nat | grep <端口号>`  , 如命令 `netstat -nat | grep 3306`
	b. `netstat -nat |grep LISTEN`

#### 使用 `lsof` 命令

	# yongfu-pro at yongfu-pro.local in ~ [22:39:32]
	$ lsof -n -P -i TCP -s TCP:LISTEN
	COMMAND PID       USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
	php-fpm 387 yongfu-pro    6u  IPv4 0x6d7f5d3c3a615679      0t0  TCP 127.0.0.1:9000 (LISTEN)
	Dropbox 413 yongfu-pro   26u  IPv4 0x6d7f5d3c445e2c09      0t0  TCP *:17500 (LISTEN)
	php-fpm 418 yongfu-pro    0u  IPv4 0x6d7f5d3c3a615679      0t0  TCP 127.0.0.1:9000 (LISTEN)
	php-fpm 419 yongfu-pro    0u  IPv4 0x6d7f5d3c3a615679      0t0  TCP 127.0.0.1:9000 (LISTEN)
	php-fpm 420 yongfu-pro    0u  IPv4 0x6d7f5d3c3a615679      0t0  TCP 127.0.0.1:9000 (LISTEN)
	stunnel 586 yongfu-pro    9u  IPv4 0x6d7f5d3c439ff679      0t0  TCP 127.0.0.1:1997 (LISTEN)

	lsof命令可以列出当前的所有网络情况， 此命令的解释如下：
	-n 表示主机以ip地址显示
	-P 表示端口以数字形式显示，默认为端口名称
	-i 意义较多，具体 man lsof, 主要是用来过滤lsof的输出结果
	-s 和 -i 配合使用，用于过滤输出

#### 使用`telnet` 命令

	检查本机的3306端口是否打开， 如下
	telnet 127.0.0.1 3306
	若该端口没有打开，则会自动退出，并显示如下内容：

	Trying 127.0.0.1...
	telnet: connect to address 127.0.0.1: Connection refused
	telnet: Unable to connect to remote host

若该端口为已打开的状态，则会一直保持连接。
如图
![telnet连接](../_resources/6d6d44115c8a5340e2e27372781c834a.png)
退出方法： ctrl + ] 再 ctrl + c
![tenet退出](../_resources/cb256efddaa05b3b4ca5b046b00a5b51.png)
或者： ctrl + d 再 enter键
![telnet-d](../_resources/7acbc4d9043299f7ed97ee6c8fb45484.png)

#### 使用 `nc` 命令

	# yongfu at yf-mac.local in ~ [9:33:14]
	$ nc  -w 10 -n -z 127.0.0.1 1990-1999
	Connection to 127.0.0.1 port 1997 [tcp/*] succeeded!
	Connection to 127.0.0.1 port 1998 [tcp/*] succeeded!

	-w 10  表示等待连接时间为10秒
	-n 尽量将端口号名称转换为端口号数字
	-z 对需要检查的端口没有输入输出，用于端口扫描模式
	127.0.0.1  需要检查的ip地址
	1990-1999  可以是一个端口，也可以是一段端口
	 返回结果为开放的端口， 如本例中的 1997 和 1998 端口

#### 使用`网络实用工具`

网络实用工具是苹果自带的网络分析工具
10.8之前的位于 `launchpad --> 其他--> 网络实用工具`

10.9之后隐藏了该应用，但可以通过 `spotlight` 搜索 `网络实用工具`或者 `最左上角的苹果标志 --> 关于本机 -->点按'系统报告' --> 标题栏的'窗口' --> 网络实用工具 --> 点按'端口扫描'`

spotlight 搜索
![spotlight](../_resources/2fd6ba1f116c87f4cca548934bf30c98.png)
或者
![窗口](../_resources/17d01d6915b5942a7b9b3e428fdc9c27.png)
在网络使用工具界面，选择'端口扫描'标签页，输入一个ip地址去扫描开放的接口。
如这里我们输入127.0.0.1查看本机的端口开放情况。
![扫描](../_resources/2e0b6cb9dea6120a4af606406c552fa2.png)
在会命令行的情况下，极度不推荐这种方法，因为这个图形化工具是按照端口的顺序从0到65535的方式去顺序扫描的，太慢了。推荐命令行方式。

 © 著作权归作者所有

- 分类：[小苹果day](https://my.oschina.net/foreverich/blog?catalog=3288910)

- 字数：697

- [**   打赏](mac%20os%20x%20查看网络端口情况%20-%20永福的博客%20-%20开源中国社区.md#)

- [**   点赞](mac%20os%20x%20查看网络端口情况%20-%20永福的博客%20-%20开源中国社区.md#)

- [**   收藏](mac%20os%20x%20查看网络端口情况%20-%20永福的博客%20-%20开源中国社区.md#)

- [** 分享](mac%20os%20x%20查看网络端口情况%20-%20永福的博客%20-%20开源中国社区.md#)
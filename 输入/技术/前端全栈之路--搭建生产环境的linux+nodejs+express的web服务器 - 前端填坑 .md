前端全栈之路--搭建生产环境的linux+nodejs+express的web服务器 - 前端填坑 - SegmentFault 思否

### 前言小序

以前我是个纯前端，就是很纯的那种。切切图，写写html、css布局；到后来写js，封装插件、组件；再后来公司没人力了，又要写后台，当时听说"PHP是世界上最好的语言...“，还学了php，会写一些php后台和myslq。后来还是因为公司没人了，又当起了运维，当时给某项目某司搭了个windows server+Apache+php+mysql的服务器。(因为当时他们要求在他们的windows server 2012内部服务器上搞项目)。

但作为一个前端，或者以前端自居的人来说内心还是觉得“javascript才是世界上最好的语言...^^”，于是后来转到javascript和nodejs的一条龙体系。之前自己的服务器有用过百度云的应用引擎bae，简单来说就是，百度搭建好的Linux和nodejs环境，直接git或者svn版本bae的仓库就可以进行项目开发，不需要理会服务器的搭建和管理。可以直接专注开始做业务层的开发，但是bae应用引擎的一些限制，比如临时生成的文件再新版本发布后会被清除等。不能满足需要了，后面开始自己从头搭建服务器。从写前端，写些后台，还搞起了服务器，当运维......虽然主要工作是前端开发，但勉强也算被逼成了个全栈的概念了吧，写这篇文章主要是对之前从事开发路上的总结和记录吧。并以一个实际线上生产的服务器例子为记录蓝本。本篇主要总结的是从什么都没有，到一个可进行基于nodejs环境进行业务层开发的过程，不涉及业务逻辑层如项目结构那些的东西。

好了，废话不多说了，进入正题。

### 系统架构层面的东西

从零开始，从无到有
1. 系统环境：阿里云 Linux centOS 6.8 64位
2. node环境：node 6.11.1
3. express：4.x
4. 版本控制：git 1.7.1

不同于开发环境node配置，生产环境还有许多不同于开发环境的nodejs环境的问题，不仅仅是安装node后，命令行执行`node app.js`就可以开启一个node的web服务器。下面将从最开始什么都没有说起，搭一个node生产服务器，可能会遇到的问题。

以下若有涉及本地开发环境的描述，环境为：mac os 10.12.3

### 1. Linux服务器

一般用于生产环境的现在大部分都使用Linux作为服务器的系统环境，虽然window server也可以，但处理node环境，优选linux系统。

Linux有很多版本，CentOS、Ubuntu、Debian等，具体选什么版本，自行百度啦，不多说了。百度云，阿里云，腾讯云这些云服务商也不多说了，具体用哪家的产品，自行看着选吧（土豪或者土豪公司自己买服务器机房的请忽略这句话）。

这里给个参考文章，[CentOS、Ubuntu、Debian三个linux比较异同](http://blog.csdn.net/educast/article/details/38315433/)

本篇实例使用：`阿里云ECS Linux centOS 6.8 64位`

### 2. Linux用户创建

服务器有了后，就要开始进行什么装软件，调配置的环境搭建了。可以直接在控制台服务器实例，点远程连接，打开一个web版的linux shell的窗口，与linux服务器进行交互。如果需要登录linux管理的人少或者就一个，可以直接用root用户进行操作。但出于规范和安全的考虑，这里我们创建一个用户，用于linux管理。并赋予可执行sudo的管理员权限。

创建eric用户(这里自行使用名称，eric是事例名称)，默认使用系统根目录/home下，生成eric目录，/home/eric即为eric的用户根目录
`# useradd eric`
然后赋予用户sudo权限，打开/etc/sudoers文件，找到
`root    ALL=(ALL)     ALL`
可以添加一行
`eric    ALL=(ALL)     ALL`或者不需要密码执行 `eric  ALL=(ALL)   NOPASSWD: ALL`
这样用户即可拥有sudo权限。
但是建议将创建的用户，添加到wheel用户组，而不是直接添加用户权限（wheel用户组是linux默认的具有超级管理员权限的分组）
并将`# %wheel    ALL=(ALL)    NOPASSWD: ALL`前面#号去掉，同样使用户拥有sudo权限，这样会更好一些。

### 3. ssh远程登录的设置

虽然可以通过web版的linux shell的窗口，也可以通过本地命令行终端通过ssh密码登录，但为了规范与安全和方便管理，我们使用本地命令行终端，通过ssh密钥对进行远程与linux交互。一般云服务器默认安装好了ssh，就不需要另行安装了，直接用就行了。

先在web版的linux shell登录linux服务器，切换到eric用户，执行
创建.ssh目录
`mkdir .ssh`
在`/home/eric/.ssh`目录下生成密钥对文件，默认文件名为私钥:`id_rsa`，公钥：`id_rsa.pub`。
`ssh-keygen -t rsa`
创建authorized_keys文件，存储用户公钥
`touch authorized_keys`
将用户公钥拷贝到authorized_keys文件，若有多个，每一个另起一行。
`cp id_rsa.pub >> authorized_keys`
注：关于密钥对当然也可以直接在云服务控制台UI界面根据云服务指引生成。
然后私钥下发给用户，id_rsa放在用户本机的用户目录的`~/.ssh/id_rsa`

这里有一个问题，就是如果本机要用ssh登录多个ssh连接，比如既要登github，又要登linux服务器，一个`id_rsa`文件会出问题，因为都默认使用这个名称的文件为私钥文件名。这样的话需要在.ssh目录下，创建名称为`config`的文件,重命名私钥文件为：比如阿里linux eric用户的`id_rsa`重命名为`id_rsa_aliyun_eric`，github下的bbb用户的私钥`id_rsa`

重命名为：`id_rsa_github_bbb`。
config文件可以配置如下

	*# 阿里云eric用户ssh配置*
	Host 119.23.xx.xxx
	HostName 119.23.xx.xxx
	User eric
	IdentityFile ~/.ssh/id_rsa_aliyun_eric

	*# github的ssh配置*
	Host github
	HostName github.com
	User bbb
	IdentityFile ~/.ssh/id_rsa_github_bbb

这样一台机可以实现多处ssh登录了。

### 4. nodejs的安装

安装nodejs有几种方案，
1. 通过 yum install nodejs
2. 通过linux进行Source code编译安装
3. 通过下载编译好的nodejs源码压缩包免编译安装
通过yum install安装主要就是nodejs版本的问题，不能指定版本安装。
source code编译安装比较麻烦，这里直接下载编译好的源码包，解压安装特定版本的nodejs

`wget --no-ckeck-certificate https://nodejs.org/dist/v6.11.1/node-v6.11.1-linux-x64.tar.xz`

并解压安装到/opt目录下
`tar -zxvf /home/eric/node-v6.11.1-linux-x64.tar.xz -C /opt/`
然后通过软链接node和npm到/usr/local/bin，使node可以在任何环境目录下执行

	ln -s /opt/node-v6.11.1-linux-x64/bin/node /usr/local/bin/node
	ln -s /opt/node-v6.11.1-linux-x64/bin/npm /usr/local/bin/npm

最后执行`node -v`,`npm -v`有版本显示说明安装成功。

### 5. nodejs创建http服务器

nodejs环境安装好后，进行以下http服务的测试

	 #进入用户目录
	 cd ~
	 #创建www目录作为web服务根目录
	 mkdir www
	 #进入www目录创建server.js作为nodejs的http服务器文件
	 touch server.js

作为测试用nodejs官网的事例代码测试下先

	const http = require('http');

	const hostname = '127.0.0.1';
	const port = 3000;

	const server = http.createServer((req, res) => {
	  res.statusCode = 200;
	  res.setHeader('Content-Type', 'text/plain');
	  res.end('Hello World\n');
	});

	server.listen(port, hostname, () => {
	  console.log(`Server running at http://${hostname}:${port}/`);
	});

执行node server.js后http服务运行成功，说明nodejs环境已可以顺利搭建nodejs的http服务器

### 6. 使用git作为版本控制系统

一般linux云服务器都默认装有git，没有的自行安装。
如果你想使用github做为git仓库，大可以使用github，通过github设置将提交的代码发布到linux服务器的www目录。（当然私有仓库要收费）
我们这里以自建git仓库为例，说下git仓库的创建和版本发布的问题

	 #进入用户根目录
	 cd ~
	 mkdir gitrepo
	 #创建git仓库
	 cd gitrepo
	 mkdir test.git
	 cd test.git
	 #执行git初始化指令建立空仓库
	 git init --bare

此时在test.git下会有一个.git的文件夹，说明名为test的git仓库建立完成。（当然还可以创建一个linux用户git来专门处理git相关的管理，再此我仅以一个eric单一linux用户来管理，这也是考虑到以后没有那么多管理员实际管理的情况，避免linux用户切换的繁琐）

最后进入www目录进行仓库克隆

	cd /home/eric/www
	git clone /home/eric/gitrepo/test.git

这样作为发布目录的www目录正式有了版本控制

### 7. git本地提交push远程后，通过hooks钩子的post-receive自动部署到www

当我们本地代码上传提交后，不能每次都进入www目录进行人工pull操作，这样实在不是一个好方式。用什么方式，当我们本地提交后，git会自动帮我们部署到www目标目录。就是hooks，也叫钩子。即git远程仓库接受到提交的指令后自动执行的脚本文件。

hooks目录下创建名称为post-receive的文件（这个文件可以理解为git仓库在收到本地push到本远程仓库之后要执行的脚本）
脚本事例如下

	#!/bin/sh

	unset GIT_DIR
	DeployPath=/home/eric/www

	echo "==============================================="
	cd $DeployPath
	echo "Starting publish"

	git pull origin master

	time=`date`
	echo "Publish success at time: $time."
	echo "================================================"

其实脚本就是进入到www目录，然后执行pull操作，只不过是脚本执行，而不是人工。当然这个是最简易的版本，随后我们要讨论下，一些根nodejs特殊性的提交细节。

### 8. 使用yarn替代npm作为nodejs，express的包管理工具

在搭建express架构的nodejs服务器时，通常我们使用npm管理package.json的install安装和管理。
但经过实践考虑，后来经过自我研究决定使用yarn代替npm。主要考虑一下两方面原因。
1. npm的速度比较慢
2. npm的版本依赖不好控制

[Yarn](https://yarnpkg.com/en/) 是 Facebook, Google, Exponent 和 Tilde 开发的一款新的 JavaScript 包管理工具。

具体yarn和npm的异同和优劣请自行百度，这里就不再赘述了，直接说说使用问题。
yarn的安装：
参照nodejs的源码安装过程，参照官网事例通过软链yarn到/usr/local/bin

不通过yum install的原因是，yum源的版本比较旧，直接yum安装的都是比较旧的版本，想安装最新的版本或特定版本，可以参照官网进行源码安装或者编译安装。

执行`yarn --version`显示版本号，说明yarn安装成功。
基本的express目录结构如下

	--bin
	    www
	--public
	--routes
	--views
	  app.js
	  package.json

在根据package.json执行yarn install后目录结构根目录多了一个`yarn.lock`的包依赖的锁定文件（这个是yarn特有的包管理的依赖管理文件）

install后，目录结构类似如下

	--bin
	    www
	--public
	--node_modules
	--routes
	--views
	  app.js
	  package.json
	  yarn.lock

至此应该说，express框架下的node服务算是比较像样子了，基本可以使用了。

### 9. 使用pm2作为node http服务的进程管理器

我们都知道使用node server.js会在命令行直接开启nodejs的web服务，但这样命令行当前窗口会被阻塞。想输入其他指令还得退出或者另起窗口。而且如果文件修改，需要停止后重新载入执行一次才回生效。开发环境还好，但这显然不是一个正式生产环境所能容忍的。所以我选择了[pm2](http://pm2.keymetrics.io/)作为node进程管理的工具（类似的还有forever，不过对比后没有pm2出色）。

首先安装pm2(一个小问题：由于我是源码安装npm install -g后模块全局的会安装在/opt/nodejs/bin下，同样要软链到/usr/local/bin，或者添加环境变量，才能全局使用)

	npm install -g pm2
	#使用pm2开启node进程
	pm2 start server.js

使用也是很简单直接pm2 start文件即可。更多指令详情可以看看官方文档，写的非常清楚了。
pm2同样可以以配置文件启动，这里为了以后便于管理，我们使用启动配置文件的形式启动。pm2默认的配置文件启动的文件名为ecosystem.config.js
我简单配置的启动脚本如下，仅供参考：

	module.exports = {
	  apps : [
	    {
	      *//general*
	      name      : 'node-web',
	      script    : 'bin/www', *//启动执行的初始脚本*

	      *//advanced*
	      watch     : ['appsback','routes','ecosystem.config.js','server.js'],*//监听文件变化*
	      ignore_watch: ['node_modules','apps','static'],*//忽略监听的文件夹*
	      max_memory_restart: '800M',*//内存达到多少会自动restart*
	      env: {
	        COMMON_VARIABLE: 'true'
	      },
	      env_production : {
	        NODE_ENV: 'production'
	      },

	      *//log file*
	      log_date_format: 'YYYY-MM-DD HH:mm:ss Z',*//日志格式*

	      *//control*
	      min_uptime: 3000,
	      listen_timeout: 3000,
	      kill_timeout: 5000,
	      max_restarts: 5,
	    }
	  ]
	};

pm2一个比较好的地方是，可以监听文件变化，即文件发生变化后node的http服务会重载而且是0秒重载。这才是一个生产环境应该有的操作...而不是停止后重新载入，对于线上环境基本是不允许的。

这样只要执行`pm2 start ecosystem.config.js`就可以开启一个node的http服务进程啦。
至此我们的express项目的目录结构大致变化成这样：

	--bin
	    www
	--public
	--node_modules
	--routes
	--views
	  ecosystem.config.js
	  server.js
	  package.json
	  yarn.lock

### 10. package.json变化导致的自动化部署的问题

我们知道如果本地package.json变化，需要执行npm install或者yarn install安装模块，但提交后服务器端怎么办呢？一个比较笨的方法就是，每次提交后若package.json变化就进入node的web根目录即www目录手动执行npm install或者yarn install。但这种方式显然不够智能，怎么办呢....

既然package.json变化必须npm install才能使node http重启后找到相应模块。于是我有以下两种形式的思考

1. 不监听package.json文件变化。即每次提交不管package.json有没有变化，都删除node_modules文件夹，执行yarn install对package.json依赖重新安装

2. 监听package.json变化，即只有package.json变化才去执行yarn install安装。

显然第一种更方便简单一些，不需要多余的监听，减少了服务器的一些配置。（现在想想这其实就是百度云bae的策略，他的官方文档介绍就是每次提交不管package.json有没有变化，都删除node_modules再装一遍）

但我想的是第二种显然更好更合理的，因为如果package.json没有变化那删除node_modules再装一遍显然是一步浪费资源的操作。剩下的问题就成了
1. 如何监听package.json变化
2. 变化后何时以及怎样去执行npm install或者update模块。

一开始想到已经在用的工具pm2有监听功能，但pm2监听只会产生restart的重启执行，不具有执行某一特定回调函数或脚本的功能（官方文档也说到了这一点）。所以只能想别的解决方案。

后来有想用使用linux系统自带的inotify监听文件变化，另外开启一个监听脚本时刻监听www目录下package.json的变化。但最后经过思考决定在git的hooks钩子post-receive脚本处理这个事情，这样可以省掉一个系统监听的脚本文件。

最后的解决方案就变成了：在post-receive脚本判断package.json文件有么有变化，并在git pull后执行install，然后重载pm2的node http服务进程，一气呵成。

最后post-receive脚本修改为以下形式供参考：

	#!/bin/sh

	unset GIT_DIR
	DeployPath=/home/eric/www

	echo "==============================================="
	cd $DeployPath
	echo "Starting publish"

	last_modify_time=`stat package.json | grep "Modify"`
	echo "t1:$last_modify_time"
	git pull origin master

	cur_modify_time=`stat package.json | grep "Modify"`
	echo "t2:$cur_modify_time"

	if [ "$last_modify_time" != "$cur_modify_time" ]; then
	  echo "package.json changed"
	  rm -rf node_modules
	  yarn install
	  pm2 restart ecosystem.config.js
	else
	  echo "package.json not changed"
	fi

	time=`date`
	echo "Publish success at time: $time."
	echo "================================================"

我这里是通过判断pull前后的package.json文件的最后修改时间是否有产生变化，来确定package.json本次push过来的是否有修改。

若变化了则执行删除node_modules再yarn install安装，最后pm2重启。若没有变化，则可以根本不执行以上的操作，省去了执行以上步骤带来的资源消耗。

当然如果再精细一点可以通过解析package.json里的依赖dependence的具体变化，是增加了模块还是删除了模块，还是修改了某一项依赖的版本作出install还是update还是delete的具体操作，而不用所用都重新删除再安装。不过这样对于json解析和npm或者yarn的增删改查操作过于繁琐，这个方式被我pass掉了，直接删了重装。由于yarn具有安装过的模块缓存，所以yarn isntall带来的时间上的问题基本可以忽略，速度非常快。这也是为什么我提倡用yarn替代npm的原因之一。

### 11. linux重启后的node web服务自启动

我们可以重启linux后，进入linux，进到/home/eric/www目录下，再次手动pm2 start ecosystem.config.js启动node的http服务。

虽然linux重启并不是一件很经常发生的事情，但这种手动需要做的事，当然可以交给linux的开机自启动脚本完成。
我们可以自己在，/etc/rc.d/rc.local目录下自建shell脚本。这里我们使用pm2给我们提供的功能，直接创建自启动脚本。
根据官网：
`pm2 startup`
直接根据提示信息，创建开机自启的`startup script`开机自启动脚本，非常方便。

### 12. 非root用户使用非80端口映射80端口的问题

默认情况下Linux的1024以下端口是只有root用户才有权限占用，我们的apache，nginx，nodejs等等程序如果想要用普通用户如eric来占用80端口的话就会抛出Permission denied:80的权限异常。

那我们只能使用8080这样的较大的端口号，但在url上要带着端口号这样可不好。这里我使用的是iptables进行的端口转发，即将8080这样的nodejs的http服务所用端口，转到80端口上，node服务虽然是8080端口，但用户url上不用带端口，直接用默认的80端口，也可以直接转发到8080的node服务器处理了。

使用root用户执行

`*iptables* -*t* *nat* -*A* *PREROUTING* -*p* *tcp* --*dport* *80* -*j* *REDIRECT* --*to*-*port* *8080*`

完了不要忘了保存和重启服务`service iptables save`，`service iptables restart`
另外还可以使用nginx作为反向代理，作端口转发。

================================================================================

至此，一个nodejs环境的http服务器，从无到有就建立了起来，有`http服务`、`git版本控制`、`自动化部署`、`pm2进程管理`，并且可以在生产环境使用的nodejs express的web服务器。房子盖好了，至于具体的业务逻辑，就在目录下尽情的搞装修吧。
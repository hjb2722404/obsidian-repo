## Why——为什么整这种活

在实际开发中，我们遇到了以下类型的问题：

### 1. 不同工程对nodejs版本要求不一样

比如我们的工程A是基于`angularjs1.5`的，它要求`nodejs`版本为`11.0.0`， 而工程B是基于`vue+vite`的，`vite`要求`nodejs`版本需要大于`12.0.0`。

尽管有`nvm`来管理`nodejs`版本，但它仍旧存在以下问题：

1. 全局环境污染
	
	比如`angularjs`工程是基于`gulp`的，所以需要全局安装`gulp`包，但是其他工程用不到，而`vue`工程则需要全局安装`vue-cli`，这样同一个`windows`环境下，安装了太多全局包，如果以后又有别的项目工程需要其他的全局包，那我们都得安装在同一个环境下，万一有两个工程所依赖的全局包相同但版本不同，就会造成全局环境的污染
	
2. 切换`node`版本后全局包需要重新安装

	切换本地`node`版本后，在之前`node`版本下安装的全局包都无法使用，需要重新安装，比如我们常用的`cnpm`、`nrm`等等。
	
3. `nvm`本身的安装也存在一些坑。

	之前好几位同事安装`nvm`都因为环境和版本的问题多多少少踩了一些坑，费时费力，不太安逸。
	
	
### 2. 某些npm包需要linux编译环境

典型地，如`node-sass`这个包，比如当我们想将它从`4.4.1`版本升级到`6.0.1`版本时，我们会敲下以下命令:
```shell

$ npm install node-sass@6.0.1
```

然后，噩梦就来临了，由于`node-sass`采用的是二进制文件分发，所以需要本地具有可以编译它的环境，比如`python`，`gyp`等等，但是一般来说，我们的`Windows`上并没有这些环境，所以就会报一堆错，而`Windows`如果想要安装这种环境，又需要安装一些很冷门还很难装的软件与库，搞得及其烦人。

### 3. 需要适应未来DevOps转型

现在很多大厂已经转型`DevOps`了，云计算和容器化是一种大趋势，随着业务量与项目数量的增长，开发和运维都面临着向DevOps的转型，所以提前进行容器化开发，可以为未来`容器化开发——容器化部署`模式铺平道路。

## What——方案简述

我们采用`Vscode + Docker + WSL`来解决上述问题。

### VsCode
不必多介绍，一款流行的编辑器，在本方案中，它只需要安装两个插件即可：
* `Remote-Containers`：用于连接远程容器
* `Remote-WSL`： 用于连接本地的WSL

### WSL（windows subsystem linux）

Windows系统下的Linux子系统，它在这里主要起的作用是用来提供一个linux环境，一是提供给docker作为运行环境，二是用来解决上述某些npm包需要linux编译环境的问题。

想更深入地了解WSL？ [点击这里](https://docs.microsoft.com/zh-cn/windows/wsl/about)

### Docker

一款容器应用，它可以提供比虚拟机更加快捷和对硬件资源消耗更少的虚拟化方案，为我们的提供一个虚拟的服务器和开发环境。

[WSL上的Docker远程容器入门](https://docs.microsoft.com/zh-cn/windows/wsl/tutorials/wsl-containers)

## How——如何搭建

### 1. 安装配置WSL 2.0版本

最新的Windws10默认都是直接支持WSL2的，我们只需要在windows应用商店搜索`linux`，就能看到支持的`Linux`子系统列表，选择其中一个安装就可以了。

![image-20211009092023034](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110090920251.png)

当然，推荐的话，还是`ubuntu`比较流行，遇到问题也比较容易搜索到相关解决方案。

为了更好地操作，推荐在应用商店中搜索`windows terminal`安装。

![image-20211009092216803](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110090922910.png)

另外，由于WSL是基于Hype-V技术的，需要Windows开启相关功能，并且保证BIOS中的虚拟化选项开启，由于不同电脑BIOS的设置方式不同，请自行在网络上搜索相关设置方法。

如何判断电脑是否开启了虚拟化呢？ 打开任务管理器，切换到【性能】一栏，可以看到【CPU】下面的信息中标识了是否开启了虚拟化：

![image-20211009092430535](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110090924656.png)

[官方WSL安装教程](https://docs.microsoft.com/zh-cn/windows/wsl/install)

[WSL开发环境设置](https://docs.microsoft.com/zh-cn/windows/wsl/setup/environment)



安装后，我们需要对默认WSL发新版和发行版的版本进行配置

在windows搜索框里输入 windows terminal，打开它

![image-20211012184537098](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110121845212.png)

输入以下命令：

```bash
> wsl -l --verbose
```

会列出本机现在安装的所有WSL发行版以及它的版本

```bash
  NAME                   STATE           VERSION
* Ubuntu                 Running         2
  docker-desktop-data    Running         2
  docker-desktop         Running         2
```

系统默认的那个发行版前会有一个`*`号，也就是，当你在`windows Terminal`中直接输入`wsl`时，打开的那个发行版：

```bash
PS C:\Users\trs> wsl
root@DESKTOP-RG3539D:/mnt/c/Users/trs#
```

如果你发现你刚刚安装的`Ubuntu`不是默认的发行版，使用以下命令将它设置为默认发行版：

```bash
> wsl --set-default ubuntu
```

如果你发现你的`Ubuntu`的版本不是`2`,使用以下命令转换其版本：

```bash
> wsl --set-version ubuntu 2
```



### 2. 安装配置Docker

Windows需要去官网下载Docker desktop最新版本，下载安装文件后直接安装即可。

[点击这里下载](https://docs.docker.com/desktop/windows/wsl/)

![image-20211009092713131](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110090927230.png)



安装好之后，我们要进行以下配置，运行`docker-desktop`程序

保证以下选项为勾选状态：

![image-20211012185324443](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110121853544.png)



![image-20211012185406762](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110121854848.png)

修改一下`docker`镜像源和配置：

![image-20211012185645645](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110121856738.png)

```json
{
  "registry-mirrors": [
    "http://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn"
  ],
  "insecure-registries": [],
  "debug": false,
  "experimental": false,
  "features": {
    "buildkit": true
  },
  "builder": {
    "gc": {
      "enabled": true,
      "defaultKeepStorage": "20GB"
    }
  }
}
```



### 3. 安装配置VsCode相关插件

![image-20211009092815254](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110090928351.png)

### 4. 在WSL容器中开发调试应用

##### 自动创建容器

插件安装成功后，在`VsCode`中打开工程目录，会看到左下角有两个相对的箭头的标识，点击它，就会弹出命令选项，让我们选择在哪里打开：

![image-20211009093045937](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110090930143.png)



在确保`docker desktop` 正常运行的前提下，我们可以选择在`WSL`中开发目录，也可以选择在容器内打开当前工程目录，这里我们选择在容器内打开。它会让我们选择要打开的目录，默认为当前目录：

![image-20211009093849854](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110090938031.png)



我们直接点击【Open】，它会让我们选择当前工程的环境类型：

![image-20211009094008663](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110090940780.png)



这里是前端项目，我们直接选择【Nodejs】，然后它会让我们选择当前工程所使用的`nodejs`版本，选择相应的版本，就可以了，容器会自动下载相关的`nodejs`环境。

![image-20211009100141449](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110091001533.png)



`VsCode`在配置好相关环境后，会在当前目录下生成一个一个名为`.devcontainer`的文件夹，里面存放着容器的环境配置，有了这个配置，下次再在容器中打开工程目录时，就不会再让我们选择工程环境类型了。



当然，为了不污染项目文件，可以把这个目录加入到`.gitignore`文件中。

之后，我们就可以像在本地开发一样，在容器内进行开发了。

##### 手动创建容器

我们发现，在选择`NodeJS`版本那一步，只有少数几个版本，比如我们需要`10.17.0`的话，这里就没有，怎么办呢，我们有另一种方式。

在工程根目录下新建`Dockerfile`文件，

```dockerfile
FROM node:10.17.0 # 这里写上需要的nodejs版本

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 8090 # 这里是应用在开发时默认运行的端口

CMD [ "npm", "run", "serve"]  # 拆解的开发命令 npm run serve
```

然后新建docker忽略文件`.dockerignore` :

```dockerfile
node_modules
npm-debug.log
```

新建后，点击左下角远程容器按钮，选择【在WSL中打开】：

![image-20211012190451098](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110121904365.png)

选择当前目录打开：

![image-20211012190546522](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110121905722.png)



在VS code 终端中，可以看到现在终端是在WSL中，运行以下命令:,(可以把` hjb/netresource`替换成你自己想要的任何可以描述该容器的名字)

```bash
root@DESKTOP-RG3539D:/mnt/d/project/tianmuyun/netresource# docker build . -t hjb/netresource
```

上面的命令会构建一个新的镜像，镜像中包含所需要的node版本环境和你的工程代码。

接下来运行：

```bash
root@DESKTOP-RG3539D:/mnt/d/project/tianmuyun/netresource# docker run -p 8090:8090 -d hjb/netresource
```

上面的命令会使用你刚刚构建的镜像实例化一个容器，并且会自动运行你在`Dockerfile`最后所设置的命令（这里是`npm run serve`），并且将容器内应用的运行端口`8090`映射到了本机的`8090`端口

然后可以通过下面命令看看运行的容器：

```bash
# docker ps
CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS         PORTS                                       NAMES
2e569ac583be   hjb/netresource   "docker-entrypoint.s…"   6 seconds ago   Up 3 seconds   0.0.0.0:8090->8090/tcp, :::8090->8090/tcp   inspiring_khorana
```

这里我们可以拿到输出的容器ID，用这个ID来查看docker内的运行日志：

```bash
# docker logs 2e569ac583be

 net-resource@0.1.0 build /usr/src/app
> vue-cli-service build


-  Building for production...
Browserslist: caniuse-lite is outdated. Please run:
npx browserslist@latest --update-db
Browserslist: caniuse-lite is outdated. Please run:
npx browserslist@latest --update-db
Browserslist: caniuse-lite is outdated. Please run:
```

当然，我们也可以在windows的docker-desktop里看到刚刚实例化运行起来的容器运行日志：

![image-20211012191534715](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110121915835.png)



从日志看到应用成功运行起来后，就可以在本地访问`8090`端口来浏览应用了。

当然，此时，我们修改工作区的内容，容器内的应用并不会刷新，因为现在容器内打开的是我们复制到容器中`usr/src/app`里的代码，而不是我们工作区的代码。要想像在windows下一样调试，可以进行以下操作：

点击远程容器图标：

![image-20211013094238016](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110130942111.png)

选择关闭远程连接

![image-20211013094318379](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110130943461.png)



然后重新点击本地的远程容器图标：

![image-20211013094356859](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110130943915.png)



![image-20211013094421304](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110130944393.png)



选择进入一个运行中的容器，

![image-20211013094503611](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110130945673.png)



选择我们之前运行起来的容器，此时VSCODE会打开一个新的远程窗口

![image-20211013094905936](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110130949042.png)



我们在新窗口的工作区目录区域右键，选择添加文件夹到工作区，然后在弹出的框里输入我们在`DockerFile`里设置的`WORKDIR`路径，选择并确定

![image-20211013095007073](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110130950150.png)

然后工作区目录中就有我们在容器内运行的工程文件了。

接下来就可以像在平时`windows`下一样修改和调试代码了，如果想进行git操作，在VSCODE中打开终端像平时操作一样就可以了。

![image-20211013095314887](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202110130953170.png)

### 5. 其它注意事项

* 由于该容器与本机的`Git`共享凭证信息，所以即使在容器内，也可以进行与远程`Git`仓库的交互操作。
* 尽管我们是在容器内打开的目录，但只是把本地目录挂载到了容器内，所以容器内对工程文件所做的修改，就是对本地目录内工程文件的修改。
* 有一个例外，就是我们在容器内运行`npm install`安装的包，再切换回本地工程，是无法使用的，需要重新在本地跑`npm install`才行。






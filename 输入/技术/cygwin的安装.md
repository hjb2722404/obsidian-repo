cygwin的安装

# cygwin的安装

环境搭建
**1、cygwin是什么？**

	Cygwin是一个在windows平台上运行的类UNIX模拟环境

**2、如何获得？**

	进入cygwin官网下载页面下载:

[cygwin下载页面](http://cygwin.com/install.html)

	可以根据自己的需要下载32位版或64位版的setup-xx.exe文件

**3、如何安装**
3.1、双击下载好的setup-xx.exe文件;
3.2、看到欢迎画面，直接点击下一步：
![0c4265765666374b696c7430ccff7c2e.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135458.png)
3.3、出现安装模式的对话框，如下图所示：
![4a5e1e3aa3bfa9c9a0fb407e958e17cd.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135503.png)
我们看到有三种安装模式：
　　Install from Internet，这种模式直接从Internet安装，适合网速较快的情况;
　　Download Without Installing，这种模式只从网上下载Cygwin的组件包，但不安装;

　　Install from Local Directory，这种模式与上面第二种模式对应，当你的Cygwin组件包已经下载到本地，则可以使用此模式从本地安装Cygwin。

　　从上述三种模式中选择适合你的安装模式，这里我们选择第一种安装模式，直接从网上安装，当然在下载的同时，Cygwin组件也保存到了本地，以便以后能够再次安装。选中后，点击“下一步”

3.4、设置cygwin安装目录和使用权限
![c0657af7e4df506992dd96ea529bce48.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135507.png)
　　这一步选择Cygwin的安装目录，以及一些参数的设置。默认的安装位置是C:/cygwin/，你也可以选择自己的安装目录，然后选择“下一步”
3.5、设置组件的本地存放目录
![1bd4e8f11ad5bf993b00db1550f907fd.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135516.png)
这一步我们可以选择安装过程中从网上下载的Cygwin组件包的保存位置，选择完以后，点击“下一步”
3.6、设置组建安装方式
![e6a41ddac0d6e6bb44e60fadec57ba39.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135519.png)
这一步选择连接的方式，选择你的连接方式，然后点击下一步
3.7、选择组件源
![b395b9acae3dd5b97c85373cc04cb4e7.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135522.png)
这里选择组件的镜像源，我们选择网易的163镜像服务器，下一步
软件自动加载镜像服务器上的组件包资源列表
3.8、选择需要的组件包
![079d8919c52bc177cf565d0598722406.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135526.png)

这一步，我们选择需要下载安装的组件包，为了使我们安装的Cygwin能够编译程序，我们需要安装gcc编译 器，默认情况下，gcc并不会被安装，我们需要选中它来安装。为了安装gcc，我们用鼠标点开组件列表中的“Devel”分支，在该分支下，有很多组件， 我们必须的是：

　　binutils
　　gcc
　　gcc-mingw
　　gdb
鼠标点击组件前面的循环按钮，会出现组建的版本日期，我们选择最新的版本安装，下图是选中后的组件的截图，选好后，下一步
![6348644516eb98089310bd72fb25b98c.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135530.png)
3.9、下载组件包资源
3.10、完成安装。
**4、运行**

	安装完成后桌面会出现cygwin的快捷方式，直接双击，即可运行

**5、安装中的问题**

	在组件包下载的过程中，可能会出现中断或者安装失败，多半是由于网络或镜像的原因，重新安装并尝试更改镜像源。

[markdownFile.md](../_resources/7529161dd29ee4490dea1fb8ebd51037.bin)
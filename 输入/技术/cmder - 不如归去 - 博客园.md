cmder - 不如归去 - 博客园

**转自：https://www.cnblogs.com/zqzjs/p/6188605.html**
**目录**

- [cmder](https://www.cnblogs.com/zqzjs/p/6188605.html#cmder)
- [安装包](https://www.cnblogs.com/zqzjs/p/6188605.html#%E5%AE%89%E8%A3%85%E5%8C%85)
- [修改命令提示符λ为$](https://www.cnblogs.com/zqzjs/p/6188605.html#%E4%BF%AE%E6%94%B9%E5%91%BD%E4%BB%A4%E6%8F%90%E7%A4%BA%E7%AC%A6%CE%BB%E4%B8%BA)
- [添加至环境变量](https://www.cnblogs.com/zqzjs/p/6188605.html#%E6%B7%BB%E5%8A%A0%E8%87%B3%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F)
- [添加至右键菜单](https://www.cnblogs.com/zqzjs/p/6188605.html#%E6%B7%BB%E5%8A%A0%E8%87%B3%E5%8F%B3%E9%94%AE%E8%8F%9C%E5%8D%95)
- [多窗口](https://www.cnblogs.com/zqzjs/p/6188605.html#%E5%A4%9A%E7%AA%97%E5%8F%A3)
- [新开shell窗口](https://www.cnblogs.com/zqzjs/p/6188605.html#%E6%96%B0%E5%BC%80shell%E7%AA%97%E5%8F%A3)
- [添加ll等命令](https://www.cnblogs.com/zqzjs/p/6188605.html#%E6%B7%BB%E5%8A%A0ll%E7%AD%89%E5%91%BD%E4%BB%A4)
- [常用快捷键](https://www.cnblogs.com/zqzjs/p/6188605.html#%E5%B8%B8%E7%94%A8%E5%BF%AB%E6%8D%B7%E9%94%AE)

## cmder

* * *

[cmder](https://github.com/cmderdev/cmder)是一个增强型命令行工具，不仅可以使用windows下的所有命令，更爽的是可以使用linux的命令,shell命令。

## 安装包

* * *

[安装包链接](http://pan.baidu.com/s/1eSmOkoi)
下载后，直接解压即用。
![743207-20161217182531011-1993640769.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107181014.png)

## 修改命令提示符λ为$

* * *

进入解压后的cmder的目录，进入vendor,打开init.bat文件。
修改第15行的代码
`@prompt $E[1;32;40m$P$S{git}{hg}$S$_$E[1;30;40m{lamb}$S$E[0m`
改为:
`@prompt $E[1;32;40m$P$S{git}{hg}$S$_$E[1;30;40m $$ $S$E[0m`
修改前后:
![743207-20161217183242448-1393899446.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107181018.png)
![743207-20161217183252839-2126921017.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107181020.png)

## 添加至环境变量

* * *

cmder.exe存放的目录添加到系统环境变量Path。添加成功够，就可以使用Win+R下输入cmder,就可以找到cmder.
![743207-20161217185057792-1283388088.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107181023.png)

## 添加至右键菜单

* * *

进入cmder的根目录执行注册要右键菜单即可。

	C:\Windows\system32>d:
	
	D:\>cd cmder
	
	D:\cmder>Cmder.exe /REGISTER ALL

效果:
![743207-20161217185529151-2114661695.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107181028.png)

## 多窗口

* * *

右键cmder底部边框栏,选择**new console**
![743207-20161217183734651-1493802276.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107181031.png)
可以设置新开的命令行在cmder中的位置，我这里选择的是居右，百分比可以设置新窗口的宽度。
效果:
![743207-20161217183802323-1999830688.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107181034.png)

## 新开shell窗口

* * *

步骤与上面一样，只是在选择的时候，选择shell。
![743207-20161217183943933-612315788.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107181037.png)

## 添加ll等命令

* * *

在cmder->config->aliases，打开aliases。
并将:

	l=ls --show-control-chars
	la=ls -aF --show-control-chars
	ll=ls -alF --show-control-chars
	ls=ls --show-control-chars -F

添加至文件末尾，用于增强命令并添加颜色区分。

## 常用快捷键

* * *

双Tab，用于补全
Ctrl+T，建立新页
Ctrl+W，关闭标签页
Ctrl+Tab，切换标签页
Alt+F4，关闭所有标签页
Ctrl+1，切换到第一个页签，Ctrl+2同理
Alt + enter，切换到全屏状态
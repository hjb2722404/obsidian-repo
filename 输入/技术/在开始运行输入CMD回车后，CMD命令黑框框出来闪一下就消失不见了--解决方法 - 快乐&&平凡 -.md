在开始运行输入CMD回车后，CMD命令黑框框出来闪一下就消失不见了--解决方法 - 快乐&&平凡 - 博客频道 - CSDN.NET

#   [在开始运行输入CMD回车后，CMD命令黑框框出来闪一下就消失不见了--解决方法](http://blog.csdn.net/wh_19910525/article/details/7847862)

.

  标签： [cmd](http://www.csdn.net/tag/cmd)[microsoft](http://www.csdn.net/tag/microsoft)[system](http://www.csdn.net/tag/system)[command](http://www.csdn.net/tag/command)[windows](http://www.csdn.net/tag/windows)[path](http://www.csdn.net/tag/path)

 2012-08-09 15:54  4263人阅读    [评论](http://blog.csdn.net/wh_19910525/article/details/7847862#comments)(0)    [收藏](在开始运行输入CMD回车后，CMD命令黑框框出来闪一下就消失不见了--解决方法%20-%20快乐&&平凡%20-.md#)    [举报](http://blog.csdn.net/wh_19910525/article/details/7847862#report)

 .

 ![category_icon.jpg](../_resources/760c5ec8c68b26ded5d32a15a75b0d4b.jpg)  分类：

   windows相关*（22）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

 .

版权声明：本文为博主原创文章，未经博主允许不得转载。

      如何 让 批处理文件 打开后 就进入 当前目录？
          在 当前 目录 下 创建 一个 xxx.bat 文件，内容为 cmd，就ok了。

        一、首先查看C:\WINDOWS\SYSTEM32下的CMD.EXE是否存在，文件日期是否正常；
　　检测结果为正常，与其他系统文件日期相同，应该不是这个问题。
　　二、再查看系统的**环境变量，path是否包含如下路径：%SystemRoot%\system32;%SystemRoot%;**
　　查看后发现存在（如果不存在就需加上）
　　三、看来还不是在上面的两个常见问题，应该是注册表被修改过。最后终于找到了解决办法：
　　注册表：

　　HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\AutoRun里的值清空，不能是空格哦!（就是没有数值，而一闪而过可能是EXIST，把他清除即可。）

**[点击 这里](http://baike.baidu.com/view/295769.htm)**，介绍 批处理。

[(L)](http://blog.csdn.net/wh_19910525/article/details/7847862#)[(L)](http://blog.csdn.net/wh_19910525/article/details/7847862#)[(L)](http://blog.csdn.net/wh_19910525/article/details/7847862#)[(L)](http://blog.csdn.net/wh_19910525/article/details/7847862#)[(L)](http://blog.csdn.net/wh_19910525/article/details/7847862#)[(L)](http://blog.csdn.net/wh_19910525/article/details/7847862#).

顶

0

踩

0

 .

[在开始运行输入CMD回车后，CMD命令黑框框出来闪一下就消失不见了--解决方法 - 快乐&&平凡 -](在开始运行输入CMD回车后，CMD命令黑框框出来闪一下就消失不见了--解决方法%20-%20快乐&&平凡%20-.md#)

 [在开始运行输入CMD回车后，CMD命令黑框框出来闪一下就消失不见了--解决方法 - 快乐&&平凡 -](在开始运行输入CMD回车后，CMD命令黑框框出来闪一下就消失不见了--解决方法%20-%20快乐&&平凡%20-.md#)

- 上一篇[git blame && git fsck –lost-found](http://blog.csdn.net/wh_19910525/article/details/7842503)

- 下一篇[eclipse 小结](http://blog.csdn.net/wh_19910525/article/details/7849686)

 .

#### 我的同类文章

   windows相关*（22）*

- *•*[在Windows 7 上大家Android studio环境](http://blog.csdn.net/wh_19910525/article/details/55509490)2017-02-17*阅读***34**

- *•*[Eclipse导入Android项目的正确方法](http://blog.csdn.net/wh_19910525/article/details/17501887)2013-12-23*阅读***944**

- *•*[windows下 git 的 颜色 和 命令别名 的配置](http://blog.csdn.net/wh_19910525/article/details/8317096)2012-12-19*阅读***1528**

- *•*[Imagemagick 对图片 大小 和 格式的 调整](http://blog.csdn.net/wh_19910525/article/details/8182938)2012-11-14*阅读***5034**

- *•*[从零 使用vc](http://blog.csdn.net/wh_19910525/article/details/8180931)2012-11-13*阅读***542**

- *•*[Git的Windows版本Msysgit的中文乱码解决](http://blog.csdn.net/wh_19910525/article/details/8155621)2012-11-06*阅读***2960**

- *•*[新建 一个android工程，res/layout 下的xml布局文件无法预览](http://blog.csdn.net/wh_19910525/article/details/17502749)2013-12-23*阅读***5441**

- *•*[在source insight中 添加新的文件类型](http://blog.csdn.net/wh_19910525/article/details/9626531)2013-07-30*阅读***1466**

- *•*[安装cygwin](http://blog.csdn.net/wh_19910525/article/details/8256159)2012-12-04*阅读***2393**

- *•*[C++之文件IO操作流](http://blog.csdn.net/wh_19910525/article/details/8181033)2012-11-14*阅读***2850**

- *•*[VC6.0的 错误解决办法 -- 小结](http://blog.csdn.net/wh_19910525/article/details/8176448)2012-11-12*阅读***561**

 [更多文章](http://blog.csdn.net/wh_19910525/article/category/1205665)
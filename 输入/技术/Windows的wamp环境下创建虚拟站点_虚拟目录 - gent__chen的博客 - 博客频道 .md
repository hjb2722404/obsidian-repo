Windows的wamp环境下创建虚拟站点/虚拟目录 - gent__chen的博客 - 博客频道 - CSDN.NET

#   [Windows的wamp环境下创建虚拟站点/虚拟目录](http://blog.csdn.net/gent__chen/article/details/48680137)

.

  标签： [windows](http://www.csdn.net/tag/windows)[wamp](http://www.csdn.net/tag/wamp)[虚拟站点](http://www.csdn.net/tag/%e8%99%9a%e6%8b%9f%e7%ab%99%e7%82%b9)[虚拟目录](http://www.csdn.net/tag/%e8%99%9a%e6%8b%9f%e7%9b%ae%e5%bd%95)

 2015-09-23 14:47  4031人阅读    [评论](http://blog.csdn.net/gent__chen/article/details/48680137#comments)(0)    [收藏](Windows的wamp环境下创建虚拟站点_虚拟目录%20-%20gent__chen的博客%20-%20博客频道%20.md#)    [举报](http://blog.csdn.net/gent__chen/article/details/48680137#report)

 .

 ![category_icon.jpg](../_resources/760c5ec8c68b26ded5d32a15a75b0d4b.jpg)  分类：

   lnmp/wamp*（1）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

 .

版权声明：本文为博主原创文章，未经博主允许不得转载。

准备工作：
（1）如果浏览器设置了代理，请关闭代理，否则将实现不了功能。（切记，本人在这翻了个跟头）
（2）如果不知道自己对本地的wamp环境操作了什么，建议重新安装wamp，以免出现了未知的结果。
开始步骤：
（1）首先，打开wamp，在浏览框中输出localhost，确认wamp环境运行无误，
                  ![Center.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132025.jpg)
（2）修改wamp安装目录下的wamp/bin/apache/apache2.4.9/conf/httpd.conf文件，将Virtual host功能打开
                 ![Center.jpg](../_resources/7e0f39c19576849c743ce76abcb67b8d.jpg)
这是还需要打开rewrite模块，找到LoadModule rewrite_module modules/mod_rewrite.so  去掉前面的注释。

（3）有编程经验的同志们应该知道，上一步就是调用一个文件，所以我们的虚拟站点的设置就是在该文件中修改，打开wamp/bin/apache/apache2.4.9/conf/extra/httpd-  vhosts.conf文件，做如下修改：

                  ![Center.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132030.jpg)
该文件中已经给了参考的设置模板，我们可以在此基础上做修改，
80端口是默认的端口，即改域名应为d.com。
DocumentRoot为虚拟站点对应的目录
ServerName为虚拟站点对应的域名
（3）本地hosts文件修改，打开C:Windows/System32/drivers/etc/hosts文件：
 添加一行    127.0.0.1       d.com   然后保存。
 （4）此时，你的d.com域名已经可以使用了，访问http://d.com/test.[PHP](http://lib.csdn.net/base/php)
              ![Center.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132038.jpg)
                test.php是我在DocumentRoot文件下创建的php文件，内容就是输出一行字符串。
（5）如果你认为你的虚拟站点已经配置完成了，那你大错特错了，让我们在来看看localhost
                  ![Center.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132044.jpg)

                 是不是打不开了，原因是我们使用了httpd- vhosts.conf文件来创建虚拟站点，但是该文件中并没有localhost的配置，配置如下：

                ![Center.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132051.jpg)
这样，我们的localhost又可以访问了。
![Center.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132056.jpg)
（6）至此，Windows的wamp环境下创建虚拟站点/虚拟目录的任务就完成了

[(L)](http://blog.csdn.net/gent__chen/article/details/48680137#)[(L)](http://blog.csdn.net/gent__chen/article/details/48680137#)[(L)](http://blog.csdn.net/gent__chen/article/details/48680137#)[(L)](http://blog.csdn.net/gent__chen/article/details/48680137#)[(L)](http://blog.csdn.net/gent__chen/article/details/48680137#)[(L)](http://blog.csdn.net/gent__chen/article/details/48680137#).


- 下一篇[自定义安装linux/Ubuntu版本操作系统/自定义磁盘分区](http://blog.csdn.net/gent__chen/article/details/48713991)

 .

#### 我的同类文章

   lnmp/wamp*（1）*

- *•*[在linux/ubuntu系统下安装LNMP环境](http://blog.csdn.net/gent__chen/article/details/48809989)2015-09-29*阅读***475**
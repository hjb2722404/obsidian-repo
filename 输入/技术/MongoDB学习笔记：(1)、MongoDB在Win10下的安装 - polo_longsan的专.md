MongoDB学习笔记：(1)、MongoDB在Win10下的安装 - polo_longsan的专栏 - 博客频道 - CSDN.NET

#   [MongoDB学习笔记：(1)、MongoDB在Win10下的安装](http://blog.csdn.net/polo_longsan/article/details/52430539)

.

  标签： [mongodb](http://www.csdn.net/tag/mongodb)

 2016-09-04 10:16  1587人阅读    [评论](http://blog.csdn.net/polo_longsan/article/details/52430539#comments)(3)    [收藏](MongoDB学习笔记：(1)、MongoDB在Win10下的安装%20-%20polo_longsan的专.md#)    [举报](http://blog.csdn.net/polo_longsan/article/details/52430539#report)

 .

 ![category_icon.jpg](../_resources/760c5ec8c68b26ded5d32a15a75b0d4b.jpg)  分类：

   mongodb*（2）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

 .

版权声明：本文为博主原创文章，未经博主允许不得转载。

1、下载[MongoDB](http://lib.csdn.net/base/mongodb)在windows下的安装文件

        首先去官网https://www.mongodb.com/download-center?jmp=nav#community下载安装文件。mongodb-win32-x86_64-2008plus-ssl-3.2.9-signed.msi。双及安装，选择安装路径。

![Center.jpg](../_resources/f47a881ccdbca8dd05814153338b76e6.jpg)
![Center.jpg](../_resources/bdc7795f35097bd3ea3ea1bf48c0b30a.jpg)
![Center.jpg](../_resources/bada326a67318fc81455e9de7356efd5.jpg)

2、接着在目录下新建data文件夹，F:\mongodb\data；logs文件夹，F:\mongodb\logs；conf文件夹，F:\mongodb\conf。分别用来存放数据，日志和配置文件。

![Center.jpg](../_resources/364572079ca9443c9a89894d4a03cce8.jpg)
在conf文件夹下新建mongodb.config文件，内容如下：
dbpath=F:\mongodb\data #[数据库](http://lib.csdn.net/base/mysql)路径
logpath=F:\mongodb\logs\mongodb.log #日志输出文件路径
logappend=true #错误日志采用追加模式，配置这个选项后mongodb的日志会追加到现有的日志文件，而不是从新创建一个新文件
journal=true #启用日志文件，默认启用
quiet=true #这个选项可以过滤掉一些无用的日志信息，若需要调试使用请设置为false
port=27017 #端口号 默认为27017
在logs文件夹下，新建mongodb.log文件。

3、开启mongodb服务，以管理员身份启动dos命令窗口，启动mongodb服务之后，可在服务中看到mongodb服务，下次直接执行bin目录下的mongo.exe客户端就可以进行操作了。

**[html]**  [view plain](http://blog.csdn.net/polo_longsan/article/details/52430539#)  [copy](http://blog.csdn.net/polo_longsan/article/details/52430539#)

 [![在CODE上查看代码片](../_resources/ba3acbf6d7a3420d26db10207385a617.png)](https://code.csdn.net/snippets/1865153)[[派生到我的代码片](../_resources/02725c4f62b67dc23f2b87e776850078.bin)](https://code.csdn.net/snippets/1865153/fork)

1. F:\mongodb\bin>mongod.exe --config F:\mongodb\conf\mongodb.config --install --serviceName "mongodb"

2.
3. F:\mongodb\bin>net start mongodb
4. mongodb 服务正在启动 .
5. mongodb 服务已经启动成功。
6.
7.
8. F:\mongodb\bin>

![Center.jpg](../_resources/0c9bf7c958635fbb5e0673926dae5176.jpg)

4、启动mongodb客户端mongo.exe，插入一条数据并查询出来。
![Center.jpg](../_resources/15d2e0beb4ef4ddaa46bce8060a27813.jpg)

[(L)](http://blog.csdn.net/polo_longsan/article/details/52430539#)[(L)](http://blog.csdn.net/polo_longsan/article/details/52430539#)[(L)](http://blog.csdn.net/polo_longsan/article/details/52430539#)[(L)](http://blog.csdn.net/polo_longsan/article/details/52430539#)[(L)](http://blog.csdn.net/polo_longsan/article/details/52430539#)[(L)](http://blog.csdn.net/polo_longsan/article/details/52430539#).

顶

0

踩

0

 .

[MongoDB学习笔记：(1)、MongoDB在Win10下的安装 - polo_longsan的专](MongoDB学习笔记：(1)、MongoDB在Win10下的安装%20-%20polo_longsan的专.md#)

 [MongoDB学习笔记：(1)、MongoDB在Win10下的安装 - polo_longsan的专](MongoDB学习笔记：(1)、MongoDB在Win10下的安装%20-%20polo_longsan的专.md#)

- 上一篇[ActiveMQ与Spring整合:(3)消息监听器](http://blog.csdn.net/polo_longsan/article/details/52356255)

- 下一篇[MongoDB学习笔记：(2)、MongoDB主从复制](http://blog.csdn.net/polo_longsan/article/details/52577561)

 .

#### 我的同类文章

   mongodb*（2）*

- *•*[MongoDB学习笔记：(3)、mongodb 3.2在java环境中的简单CRUD](http://blog.csdn.net/polo_longsan/article/details/52613861)2016-09-21*阅读***191**

- *•*[MongoDB学习笔记：(2)、MongoDB主从复制](http://blog.csdn.net/polo_longsan/article/details/52577561)2016-09-19*阅读***98**
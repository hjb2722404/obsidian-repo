dos的 if语句 - 快乐&&平凡 - 博客频道 - CSDN.NET

#   [dos的 if语句](http://blog.csdn.net/wh_19910525/article/details/7912123)

.

  标签： [dos](http://www.csdn.net/tag/dos)[less](http://www.csdn.net/tag/less)

 2012-08-27 14:53  2527人阅读    [评论](http://blog.csdn.net/wh_19910525/article/details/7912123#comments)(0)    [收藏](dos的%20if语句%20-%20快乐&&平凡%20-%20博客频道%20-%20CSDN.NET.md#)    [举报](http://blog.csdn.net/wh_19910525/article/details/7912123#report)

 .

 ![category_icon.jpg](../_resources/760c5ec8c68b26ded5d32a15a75b0d4b.jpg)  分类：

   windows相关*（22）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

 .

版权声明：本文为博主原创文章，未经博主允许不得转载。

## dos的 if语句 使用

**　　if用于条件判断，适用于以下情形：**
**　　1、判断驱动器、文件或文件夹是否存在，用 if exist 语句；
　　2、判断某两个字符串是否相等，用 if "字符串1"=="字符串2" 语句；
　　3、判断某两个数值是否相等，用 if 数值1 equ 数值2 语句；
　　4、判断某个变量是否已经被赋值，用 if defined str 语句；**

**　　if语句的完整格式是这样的：if 条件表达式 (语句1) else (语句2)，它的含义是：如果条件表达式成立，那么，就执行语句1，否则，将执行语句2。**

**　　对于以上四种情形，可以分别使用如下代码：**
**　　1、if exist d:\test.txt (echo D盘下有test.txt存在) else (echo D盘下不存在test.txt)
　　2、if "abc"=="xyz" (echo 字符串abc等于字符串xyz) else (echo 字符串abc不等于字符串xyz)
　　3、if 1 equ 2 (echo 1等于2) else (echo 1不等于2)
　　4、if defined str (echo 变量str已经被赋值，其值为%str%) else (echo 变量str的值为空)**

**　　判断字符串是否相等的时候，if会区分大小写，比如，单纯的if语句会认为字符串abc和字符串Abc不相同，若不想区分大小写，则需要添加 /i 开关，使用 if /i "字符串1"=="字符串2" 的格式；另外，等于符号是连续的"=="而非单独的"="。**

**　　判断两个数值之间的大小关系，除了等于用equ之外，还有其他的关系符号，所有适用于if语句的关系符号见下表：**
**中文含义 关系符 英文解释**
**等于   equ equal
大于   gtr greater than
大于或等于 geq greater than or equal
小于   lss less than
小于或等于 leq less than or equal
不等于   neq no equal**
**　　if语句还有一个精简格式：if 条件表达式 语句，它的含义是：如果条件表达式成立，将执行语句，否则，什么也不做。**
.

[(L)](http://blog.csdn.net/wh_19910525/article/details/7912123#)[(L)](http://blog.csdn.net/wh_19910525/article/details/7912123#)[(L)](http://blog.csdn.net/wh_19910525/article/details/7912123#)[(L)](http://blog.csdn.net/wh_19910525/article/details/7912123#)[(L)](http://blog.csdn.net/wh_19910525/article/details/7912123#)[(L)](http://blog.csdn.net/wh_19910525/article/details/7912123#).

顶

0

踩

0

 .

[dos的 if语句 - 快乐&&平凡 - 博客频道 - CSDN.NET](dos的%20if语句%20-%20快乐&&平凡%20-%20博客频道%20-%20CSDN.NET.md#)

 [dos的 if语句 - 快乐&&平凡 - 博客频道 - CSDN.NET](dos的%20if语句%20-%20快乐&&平凡%20-%20博客频道%20-%20CSDN.NET.md#)

- 上一篇[PackageManagerService.java 构造函数的 分析](http://blog.csdn.net/wh_19910525/article/details/7909877)

- 下一篇[dos下 和 批处理中的 for 语句的基本用法](http://blog.csdn.net/wh_19910525/article/details/7912440)

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
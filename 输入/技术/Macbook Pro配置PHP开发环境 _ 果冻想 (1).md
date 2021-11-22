Macbook Pro配置PHP开发环境 | 果冻想

# [Macbook Pro配置PHP开发环境](http://www.jellythink.com/archives/783)

2014-12-20分类：[环境搭建](http://www.jellythink.com/archives/category/developmentenv)阅读(5654)评论(24)

#### 前言

最近购置了一台Macbook Pro，所以准备将所有的工作环境都慢慢的迁移到Mac上来，简单的使用了一下，确实不错，用户体验真的是非常好。目前在学习PHP相关的开发，就需要配置PHP的开发环境，网上对Macbook上配置PHP开发环境的文件比较少，我上网查了一些资料，自己通过这篇文章做一个总结，希望对后来的同学们有点用。

安装环境如下：

- Mac OS 10.10.1
- Apache 2.4.9
- PHP 5.5.14
- MySQL 5.6.22

#### Apache配置

在Mac OS 10.10.1中是自带Apache软件的，我们只需要启动对应的服务就好了，以下命令是操作Apache时常用的几个命令：

	// 启动Apache服务
	sudo apachectl start

	// 重新启动Apache服务
	sudo apachectl restart

	// 关闭Apache服务
	sudo apachectl stop

	// 查看Apache的版本
	httpd -v

关于`sudo`命令，不用我多说了吧。先启动Apache服务吧，然后在浏览器中输入localhost。出现`It works`字样，说明Apache就搞定了。
在Macbook pro下，Apache的网站服务器根目录在`/Library/WebServer/Documents`路径下。

#### PHP配置

在Mac OS中已经自带了PHP了，我们只需要在Apache的配置文件中添加Apache对PHP的支持就好了，步骤如下：
1. 编辑http.conf配置文件，命令如下：
`sudo vim /etc/apache2/httpd.conf`
2. 去掉以下部分的注释：
`LoadModule php5_module libexec/apache2/libphp5.so`
3. 重启Apache服务吧；
4. 写一个简单的测试文件测试一下。
`<?php phpinfo(); ?>`

#### MySQL配置

安装MySQL是比较麻烦的，由于在Mac OS中是直接带有Apache和PHP的，所以安装它们，比较简单，而MySQL是不带的，需要我们去官网下载。
下载完成以后，直接安装吧。安装完成以后，从`System Preferences`中启动MySQL服务，如下图所示：
![alt](../_resources/505cfc50071967bc272d55cc5671dc98.png)

好了，现在从命令行登陆mysql，然后设置密码，如果对这里不熟悉的话，请参考这篇文章：《[MySQL扫盲篇](http://www.jellythink.com/archives/636)》。

在使用命令行登陆MySQL的时候，会出现2002，找不到mysql.sock文件的错误。

> 由于MySQL是把mysql.sock文件放在/tmp目录下，而Mac OS却去了/var/mysql目录下寻找对应的mysql.sock文件，所以，由于找不到对应的mysql.sock文件，就出现了这里对应的2002错误了。

所以为了解决这个问题，我们需要在/var/mysql目录下，存放一个指向/tmp/mysql.sock文件的软链接，命令如下：
`sudo ln -s /tmp/mysql.sock /var/mysql/mysql.sock`
然后重新启动MySQL服务就OK了。

#### 总结

好了，Apache、PHP和MySQL的配置都总结了，基本就是这点东西，接下来，让我们就愉快的开始PHP的学习之旅吧。对于这篇文章，就是一个简单的总结。希望对大家学习有帮助了。

2014年12月19日 于深圳。

未经允许不得转载：[果冻想](http://www.jellythink.com/) » [Macbook Pro配置PHP开发环境](http://www.jellythink.com/archives/783)

分享到：[更多]()  ([7]())

标签：[Apache](http://www.jellythink.com/archives/tag/apache)[Macbook Pro](http://www.jellythink.com/archives/tag/macbook-pro)[MySQL](http://www.jellythink.com/archives/tag/mysql)[PHP](http://www.jellythink.com/archives/tag/php)

### 相关推荐

- [PHP延迟静态绑定](http://www.jellythink.com/archives/956)
- [说说MySQL中的事务](http://www.jellythink.com/archives/952)
- [MySQL集合操作](http://www.jellythink.com/archives/940)
- [MySQL联接查询操作](http://www.jellythink.com/archives/937)
- [MySQL子查询](http://www.jellythink.com/archives/932)
- [SQL逻辑查询语句执行顺序](http://www.jellythink.com/archives/924)

### 评论 **24**

![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

- 昵称 (必填)
- 邮箱 (必填)
- 网址

1. #12
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)
站长你好，恒创科技买主机送平板，礼品有限，学生购买—9折加20%返现！！
[香港独立IP主机](http://www.henghost.com/deli-shareshoting.php)1年前 (2014-12-21)
2. #11
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)
我是用的XAMPP搭建的环境，很方便
cloudxiao1年前 (2014-12-22)

    - ![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

这个集成环境确实很方便，之前在windows上一直都是用它。
[果冻想](http://www.jellythink.com/)1年前 (2014-12-22)
3. #10
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)
我用的PHPnow，也挺好用的，不过貌似很久没更新了
ddcatzlx1年前 (2015-03-19)

    - ![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

恩。我直接在Mac自带的这些软件，进行配置的。都差不多。以后多交流使用心得。
[果冻想](http://www.jellythink.com/)1年前 (2015-03-28)
4. #9
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)
江南路过留个言
[三亚婚纱摄影](http://www.timi520.com/)1年前 (2015-05-17)
5. #8
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)
Macbook
[广告联盟官网](http://www.caolianmeng.com/)1年前 (2015-05-21)
6. #7
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)
非常好！今天刚下macbook pro的订单，后天到，跟站长一样用来工作[哈哈]
ECE211个月前 (07-17)

    - ![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

恭喜你，你会感觉到这个伙计非常的棒。
[果冻想](http://www.jellythink.com/)11个月前 (07-17)
7. #6
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)
刚买的Mac，想学习lamp开发，非常感谢站长的文章。我想学php，请问有什么书籍推荐
gaojingwei10个月前 (08-06)

    - ![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

就一个建议：打好基础。
在浮躁的工作环境中，真正能打好基础的人没几个，希望你能打好基础，至于推荐的书籍，直接上亚马逊搜一下销量最高的，基本就没差。
千万不要让自己的学习计划因为工作而改变。
[果冻想](http://www.jellythink.com/)10个月前 (08-06)

        - ![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

mac上开发php用哪个编辑器比较好？
gaojingwei10个月前 (08-06)

            - ![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

没有哪个最好，自己喜欢就好，用的惯，用的上手就好。
[果冻想](http://www.jellythink.com/)10个月前 (08-06)
8. #5
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)
有没有扩展memcache的教程，我怎么都安装不上
oioqian9个月前 (08-26)

    - ![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

我这篇文章没有总结。但是可以给你推荐一篇文章：http://segmentfault.com/a/1190000000606752
你可以参考一下这篇文章。
[果冻想](http://www.jellythink.com/)9个月前 (08-26)
9. #4
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

[…] ??本文链接：http://www.jellythink.com/archives/783 ??来源：果冻想???《Macbook Pro配置PHP开发环境》 […]

[Macbook Pro配置PHP开发环境 | Yuki博客](http://www.icorn.xyz/?p=29)9个月前 (08-30)
10. #3
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)
我也是用自带软件配置的，前期网络各种搜，但没有楼主有心，写下来。
[minuo](http://www.ibooks.org.cn/)8个月前 (09-18)

    - ![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

搜一次，然后就记下来变成自己的。还有，睡的好晚的，能早睡的机会一定要珍惜，以后有的你加班晚睡的。
[果冻想](http://www.jellythink.com/)8个月前 (09-18)
11. #2
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)
LoadModule php5_module libexec/apache2/libphp5.so
的＃在终端里怎么去除呢？谢谢你
[Gammalong](http://weibo.com/yeswecano)6个月前 (11-23)

    - ![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

???
[果冻想](http://www.jellythink.com/)6个月前 (11-23)

    - ![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

如果不会使用vi编辑器，可以用其他编辑器打开http.conf这个文件进行编辑。然后，去学习一下怎么使用vi编辑器更好，毕竟，vi的确好用。
ferry6个月前 (11-24)
12. #1
![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

apache配置文件是/etc/apache2/httpd.conf吧，因为在我的电脑上没有http.conf这个文件；不知是站长笔误还是确实有http.conf这个文件？新手，昨天才看了个2小时的PHP入门教程

Ayou5个月前 (01-10)

    - ![avatar-default.png](../_resources/9518e02fb460e1a7f542903a89a21442.png)

谢谢你的指正，确实写错了，对你造成的误导表示歉意，Sorry。
再次感谢你的指正。
[果冻想](http://www.jellythink.com/)5个月前 (01-10)
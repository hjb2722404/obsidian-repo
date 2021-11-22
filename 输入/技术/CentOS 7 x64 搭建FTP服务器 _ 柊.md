CentOS 7 x64 搭建FTP服务器 | 柊

[# CentOS 7 x64 搭建FTP服务器](https://www.yanning.wang/archives/184.html)
小柊 发表于 2015年10月22日 14时33分49秒

在上一次的博文《[CentOS 7 x64基本软件安装及配置](http://www.yanning.wang/archives/178.html)》中，我教大家搭建了一个简单的HTTP服务器，但是在上次的博文中，我并没有提及到如何搭建FTP服务器。

[![00.png](../_resources/cb680f272e8f2189ac19bdaf72c1592e.png)](https://sources.yanning.wang/images/Archives/184/00.png)

为什么还需要搭建FTP服务器呢？很简单，因为放在服务器中的网页文件需要不定期的更新，如果还是像之前博文中那样用touch创建、vim编辑内容，如果需要对网站进行一个大更新，那绝对是一个非常大的工程，如果有FTP服务的话，只需要用FTP工具连接到服务器，把需要更新的文件放到网站目录指定位置下覆盖更新就好了，非常简单。在CentOS下，搭建FTP服务器是使用vsftpd软件。

## 1.安装VSFTPD

老样子，先用XShell或者是别的SSH工具远程连接到服务器，用root用户登陆服务器。
然后键入以下命令以安装VSFTPD
***yum install vsftpd***
依旧会在检查依赖项目后要求用户确认，按y并回车即可。当提示“完成！”后即代表VSFTPD安装完毕。

[![01.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180425.png)](https://sources.yanning.wang/images/Archives/184/01.png)

然后我们需要将vsftpd启动并设置成开机自启动：

启动vsftpd：
***systemctl start vsftpd.service***
设置vsftpd开机自启动：
***systemctl enable vsftpd.service***

## 2.配置VSFTPD

完成第一步之后其实已经启动了ftp服务器，但我们并用不了，因为我们还没有对vsftpd进行一些必要的设置。
vsftpd的配置文件是/etc/vsftpd/vsftpd.conf，直接用vim打开编辑即可。
使用vim编辑器打开vsftpd配置文件：
***vim /etc/vsftpd/vsftpd.conf***

vsftpd的配置文件非常大，所以我就不截图展示和完整展示了，我们直接挑关键的地方进行一些简单的修改。
注：在vim中，非编辑状态下输入“/”+需要查找的内容 后按回车键可以快键查找指定字符串。

***anonymous_enable=YES***
是否允许匿名用户登陆FTP。
为了安全起见关闭这个功能（将等号后的YES改成NO即可）。

***dirmessage_enable=YES***
切换目录时，显示目录下.message文件中的内容
默认是开启的

***local_umask=022***
FTP上本地的文件权限，默认是077，不过vsftpd安装后的配置文件里默认是022.
没有什么特殊情况不用修改。

***xferlog_enable=YES***
启用上传和下载的日志功能，默认开启。
建议开启此功能，它可以对用户的操作进行日志记录，当出现问题的时候可以通过日志排查问题。

***ftpd_banner=XXXX***
FTP的欢迎信息。
在FTP登陆成功之后，服务器会往客户端发送一个欢迎消息以表示登陆成功。这是一个个性化的功能，您可以自由的设置其值，也可以在配置最前加上#注释本行。

***data_connection_timeout=120***
数据连接超时时间。
如果在使用vsftpd上传下载碎小文件的时候容易发生超时中断的问题，可以将本行前的#注释符去掉，然后将120改成5或者更小，然后重启vsftpd即可。

修改配置文件完成。保存后重启VSFTPD。
重启vsftpd服务：
***systemctl restart vsftpd.service***

[![02.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180430.png)](https://sources.yanning.wang/images/Archives/184/02.png)

## 3.创建FTP用户

修改完vsftpd的配置文件之后我们还是不能使用vsftpd，因为我们还没有设置ftp的用户。

添加一个名为ftpuser的用户，用户文件夹位置为：/var/www/html，且禁止此用户登陆服务器：
***useradd -d /var/www/html -s /sbin/nologin ftpuser***

然后设置一下密码，为ftpuser设置密码：
***passwd ftpuser***

这时候系统会要求您输入新的密码并且重复一遍。顺便一提在SSH中，密码一般不会回显，所以初学者可能会觉得输进去没反应，其实是已经输进去了。

[![03.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180438.png)](https://sources.yanning.wang/images/Archives/184/03.png)

## 4.调整防火墙

经过第三步创建用户之后，有小部分的同学可能已经可以登陆了。但是绝大部分的同学会连接ftp失败，提示连接失败 (连接已超时)

[![04.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180441.png)](https://sources.yanning.wang/images/Archives/184/04.png)

失败的原因很简单，不知大伙有没有想起来之前的博文中我教大家关闭了系统自带的firewall防火墙，换上了新的iptables防火墙？就是iptables防火墙将我们的连接请求阻断了。如果你个人怕麻烦，而且也觉得防火墙没什么用，那你可以将iptables防火墙关闭，关闭防火墙之后就可以正常使用了。

不过因为这么一点小事儿就关闭防火墙未免显得有点水，而且防火墙摆在那里总归是有用的。那么有什么办法既保留防火墙，又能让iptables不把我们的ftp连接请求阻断呢？

当然有，我们需要调整一下iptables的配置文件，使ftp协议的端口可以通过防火墙。

FTP有两种模式，主动模式和被动模式。由于两种模式使用的端口不一样，所以调整的内容也不一样。至于FTP的主动模式与被动模式有什么区别，待笔者日后慢慢交代。

### FTP主动模式

使用Vim编辑器打开iptables配置文件：
***vim /etc/sysconfig/iptables***
然后在配置文件中加入这么一句：
> -A INPUT -m state --state NEW -m tcp -p tcp --dport 21 -j ACCEPT
这句话告诉iptables开放21端口，允许接受从21端口传入的连接。
然后重启iptables服务：
***systemctl restart iptables.service***

现在就可以使用ftp工具登陆我们的ftp服务器了！

[![05.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180445.png)](https://sources.yanning.wang/images/Archives/184/05.png)

### FTP被动模式

如果ftp处于被动模式下，除了需要修改iptables的配置文件以外，还需要修改vsftpd的配置文件。
首先是修改vsftpd的配置文件：
使用Vim编辑器打开vsftpd配置文件：
***vim /etc/vsftpd/vsftpd.conf***

现在配置文件中找到“connect_from_port_20=YES”并将它修改为“connect_from_port_20=NO”，关闭掉vsftpd的主动模式。

然后在配置文件的末尾追加：
> #使vsftpd运行在被动模式
> pasv_enable=YES
> #被动模式最小端口号30000
> pasv_min_port=30000
> #被动模式最大端口号31000
> pasv_max_port=31000
保存配置文件并退出。
然后重启vsftpd服务：
***systemctl restart vsftpd.service***

然后再使用Vim编辑器打开iptables配置文件：
***vim /etc/sysconfig/iptables***

添加这两句话：（“#”开头的是注释，可以不添加）
> #开放ftp协议21端口，允许接受来自21端口的新建TCP连接
> -A INPUT -p tcp -m state --state NEW -m tcp --dport 21 -j ACCEPT
> #开放30000-31000号端口，允许接受来自此端口号段的新建TCP连接
> -A INPUT -p tcp --dport 30000:31000 -j ACCEPT
保存并退出，然后重启iptables服务：
***systemctl restart iptables.service***

现在就可以使用ftp工具登陆我们的ftp服务器了！

[![06.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180449.png)](https://sources.yanning.wang/images/Archives/184/06.png)

## 5.调整文件夹权限

可能现在又有个问题冒出来了，使用ftp工具登陆服务器之后，不管创建什么，都会失败。

[![07.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180453.png)](https://sources.yanning.wang/images/Archives/184/07.png)

这个问题主要是在服务器的文件夹权限设置上。以笔者为例，笔者将ftp服务器登陆后的默认文件夹设置为/var/www/html，登陆ftp之后上传什么文件都显示553 Could not create file.

进入/var/www文件夹
***cd /var/www***

[![08.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180457.png)](https://sources.yanning.wang/images/Archives/184/08.png)

查看一下目录权限
***ls –l***

[![09.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180502.png)](https://sources.yanning.wang/images/Archives/184/09.png)

我们可以看到html文件夹的权限是drwxr-xr-x。
我们将这个权限字符串分为四个部分，以顿号隔开：d、rwx、r-x、r-x。
这四部分分别说明了：
1.此文件其实是个文件夹；
2.此文件的文件主拥有读、写、执行权限；
3.此文件的组用户拥有读、执行权限；
4.此文件的其他用户拥有读、执行权限。

果然是权限不够！
调整一下权限，让所有人都拥有读、写、执行的权力
***chmod 777 html***
再看一下现在的文件夹权限
***ls –l***

[![loading.gif](../_resources/69a70c730ced60c33443c5a9bf292e35.gif)](https://sources.yanning.wang/images/Archives/184/10.png)

可以了，返回ftp工具，上传文件，一切正常！

[![loading.gif](../_resources/69a70c730ced60c33443c5a9bf292e35.gif)](https://sources.yanning.wang/images/Archives/184/11.png)

小柊
2015年10月22日 14:29:59

[(L)](http://www.jiathis.com/share/)

![loading.gif](../_resources/69a70c730ced60c33443c5a9bf292e35.gif)

# 关于 小柊

## 就是一个简单的孩子。

活在梦里的程序员。

本站所有文章转载时请注明原出处，谢谢合作。

「何も欲しいと言わなければ、永遠に傷つかずに済む。」
僕は何回かその瘡蓋を見て学んだ、望まない...
“只要不说出自己的想要的，就可以永远不会受到伤害。”
我几度经历伤痛才了解到这一点，所有我绝不会再抱有任何的期待…

###

[查看 小柊 发表的所有文章](https://www.yanning.wang/archives/author/hiiragi) | [电子邮箱](https://www.yanning.wang/archives/184.htmlmailto://zwhwyn.123@163.com) | [个人网站](https://www.yanning.wang/)
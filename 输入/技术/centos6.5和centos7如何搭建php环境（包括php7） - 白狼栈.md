centos6.5和centos7如何搭建php环境（包括php7） - 白狼栈

## [centos6.5和centos7如何搭建php环境（包括php7）](http://www.manks.top/linux_php.html)

更新于 2017年02月15日 by 白狼 被浏览了 1532 次
   **  1      **  0

 **博主推荐：**[yii2实战式教程](http://www.manks.top/document/yii2-blog-description.html)是一套幽默风趣的高质量教程，从 yii2基础入门 到 yii2高级进阶，正在火热持续更新中，让你不错过yii2的每一个技术干货。

总有人认为linux搭建php环境很复杂，然后尝试安装lnmp一键安装包。其实说白了就是安装一个web服务器，然后支持php即可，很简单的，比起你安装lnmp一键安装包还要简单。不说大话，看实际安装步骤。

首先我们先查看下centos的版本信息：
#适用于所有的linux lsb_release -a#或者cat /etc/redhat-release#又或者rpm -q centos-release
以上三种任意一种均可查看centos的版本信息。

这里我们分别在centos6.5和centos7上进行安装，安装过程中也仅仅是部分linux命令不同而已。为了方便起见，我们采用yum的方式进行安装，当然，如此一来安装的软件版本可能就会因为yum源的问题而不同，如果你想安装指定版本，我们后面也有说到。你也可以使用源码编译安装，因不属于本篇讨论范围，故略之。

**安装apache**
apache的安装很简单，我们利用yun install一键安装即可
yum install httpd
回车后即可安装，安装过程中会提示我们输入y确认即可，这里输入y确认之前，你可以看到你要安装的httpd的版本信息。
有些小伙伴安装过程中可能会出现失败的问题
You could try using --skip-broken to work around the problem

这个就是你yum源的问题，此刻最好更换你的yum源，不然你安装成功了，大部分也是无效的。既然报错了，我们最好找到解决问题的办法，而不是先算了！可以参考[阿里云服务器yum源更新问题](http://www.manks.top/linux_yum.html)[(L)](http://www.manks.top/linux_yum.html)

然后我们手动启动apache

#centos7 启动httpdapachectl start#centos6.5 启动httpd/etc/init.d/httpd start 或者 service httpd start

既然web服务器搭好了是不是就代表着可以通过web进行访问了呢？是的，浏览器直接访问你的服务器ip地址，就会打开apache的默认页面。
我们设置开机启动httpd服务

#centos7systemctl enable httpd.service#centos 6.*版本chkconfig --levels 235 httpd on

我们接着利用yun install命令安装php

yum install php #centos7 重启apacheapachectl restart#centos6 重启apache/etc/init.d/httpd restart 或者 service httpd restart

上面的步骤中，因yum源的不同，安装的php版本也不同，部分小伙伴要安装的php版本估计只有5.3 5.4（这个在安装php过程中，属于y确认之前可能看到），但是，这很明显不是大部分人想要的。

如果你已经点击了y确认安装，但是版本太低，你可以用下面的命令进行卸载
yum remove php
下面我们以安装php5.6为例说明一下，如果你的yum安装的php版本够高或者满足自己的意愿，此步骤可直接略过。

#CentOs 6.xrpm -Uvh  http://mirror.webtatic.com/yum/el6/latest.rpm #CentOs 7.Xrpm -Uvh  https://mirror.webtatic.com/yum/el7/epel-release.rpm

rpm -Uvh  https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
我们可以通过下面的命令安装php5.6版本

yum install php56w php56w-mysql php56w-mbstring php56w-mcrypt php56w-gd php56w-imap php56w-ldap php56w-odbc php56w-pear php56w-xml php56w-xmlrpc php56w-pdo

这样我们的php就安装好了
最近php7比较火，webstatic这个源也可以安装php7哦，你只需要把上面安装5.6版本的命令改为php70w即可，具体php的版本依个人所好

yum install php70w php70w-mysql php70w-mbstring php70w-mcrypt php70w-gd php70w-imap php70w-ldap php70w-odbc php70w-pear php70w-xml php70w-xmlrpc php70w-pdo

安装好php后记得重启apache哦
刚安装好的php环境，可以执行命令看看都安装了哪些模块
php -m
假如前面我们忘记安装mbstring扩展了，可能仍然需要手动安装mbstring扩展(实际上我们前面已经安装过了，此处仅仅举例说明)

#php5.6版本yum install php56w-mbstring#php7.0版本yum install php70w-mbstring#然后不要忘记重启apache

此外，我们可以通过下列命令查看php的配置文件所在目录，当然你也可以通过查看phpinfo获取相应信息
php -i | grep php.ini
最后我们介绍下相关文件的默认安装路径

#apache主配置文件/etc/httpd/conf/httpd.conf#相关配置 比如vhost文件就可以创建在该目录下/etc/httpd/conf.d/#模块配置文件 比如你要开启rewrite模块，可能你就需要到这个目录下面做一些配置了/etc/httpd/conf.modules.d/#web可访问目录 网站根目录/var/www/html#apache日志文件目录/var/log/httpd/

感觉本篇文章不错，对你有收获？
 [¥ 我要小额赞助，鼓励作者写出更好的教程]()

[(L)](http://www.manks.top/linux_php.html#)[(L)](http://www.manks.top/linux_php.html#)[(L)](http://www.manks.top/linux_php.html#)[(L)](http://www.manks.top/linux_php.html#)[(L)](http://www.manks.top/linux_php.html#)[(L)](http://www.manks.top/linux_php.html#).

   **  1      **  0
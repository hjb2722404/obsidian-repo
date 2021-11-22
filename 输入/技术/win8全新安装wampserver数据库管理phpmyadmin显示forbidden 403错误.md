win8全新安装wampserver数据库管理phpmyadmin显示forbidden 403错误 的解决方法

# win8全新安装wampserver数据库管理phpmyadmin显示forbidden 403错误 的解决方法

问题解决
wampserver

本来从学习PHP+MySQL以来，在win上本机测试如果懒得自己装服务器环境，就用的是张宴大哥编写的apmserv软件来搭建环境的，无奈现在很多组件都已经更新了好几个版本，而apmserv却一直停留在5.2.6版本，导致很多组件的新特性无法使用，所以不得已决定改用wampserver

不过有意思的是，这个wampserver的作者似乎是多虑了，默认安装在WIN8系统上时对权限的控制过于苛刻，导致全新安装的wampserver访问本地phpmyadmin时出现各种权限错误，其中就包括标题所示403禁止访问错误。

在网上找了很多文章，最后感谢 XDBruce 在自己博客的解决方案，让我彻底解决了问题，现将方案借花献佛：

1、找到系统任务栏右下角wampserver管理器小图标，左键单击，选择“Apache”目录，然后选择Alias directories 目录，选择“[http://localhost/phpmyadmin/”目录下的“edit](http://localhost/phpmyadmin/%E2%80%9D%E7%9B%AE%E5%BD%95%E4%B8%8B%E7%9A%84%E2%80%9Cedit) alias”选项，之后就会打开一个phpmyadmin.conf配置文件，将所有的

	Allow from 127.0.0.1

替换为

	Allow from all

保存退出。
2、还是刚刚那个“Apache”目录，选择httpd.conf选择，打开httpd.conf配置文件，也将所有的“Allow from”的值设置为 all。

3、这样设置后，就OK了，不过温馨提示：这样的设置只能用于本地测试，用于正式的服务器部署会有安全隐患，不过话说回来，有多少服务器正式部署会用wampserver呢？

感谢上面提到的博主，这里是原博文链接：

[win8下wamp无法进入phpMyAdmin或localhost的解决方法](http://blog.sina.com.cn/s/blog_6db312f1010194rt.html%20%E2%80%9Cwin8%E4%B8%8Bwamp%E6%97%A0%E6%B3%95%E8%BF%9B%E5%85%A5phpMyAdmin%E6%88%96localhost%E7%9A%84%E8%A7%A3%E5%86%B3%E6%96%B9%E6%B3%95%E2%80%9D)

[markdownFile.md](../_resources/d0f9917f49b3c681cd28e9b308a6eaad.bin)
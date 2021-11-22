Centos下修改启动项和网络配置 - Anker's Blog - 博客园

# [Centos下修改启动项和网络配置](http://www.cnblogs.com/Anker/p/3203931.html)

1、Centos默认是从图形界面启动，需要较多的资源，为了节省资源可以从命令行启动。修改方法如下：
/etc/inittab文件，把
代码:
id:5:initdefault:这一行，修改成
代码:
id:3:initdefault:保存后就reboot重新起动，
2、
**一、CentOS 修改IP地址**
修改对应网卡的IP地址的配置文件
**# vi /etc/sysconfig/network-scripts/ifcfg-eth0**
修改以下内容
DEVICE=eth0 #描述网卡对应的设备别名，例如ifcfg-eth0的文件中它为eth0

BOOTPROTO=static #设置网卡获得ip地址的方式，可能的选项为static，dhcp或bootp，分别对应静态指定的 ip地址，通过dhcp协议获得的ip地址，通过bootp协议获得的ip地址

BROADCAST=192.168.0.255 #对应的子网广播地址
HWADDR=00:07:E9:05:E8:B4 #对应的网卡物理地址
IPADDR=12.168.1.2 #如果设置网卡获得 ip地址的方式为静态指定，此字段就指定了网卡对应的ip地址
IPV6INIT=no
IPV6_AUTOCONF=no
NETMASK=255.255.255.0 #网卡对应的网络掩码
NETWORK=192.168.1.0 #网卡对应的网络地址
**ONBOOT=yes #系统启动时是否设置此网络接口，设置为yes时，系统启动时激活此设备**

**参考：**
**http://www.cnblogs.com/vicowong/archive/2011/04/23/2025545.html**
**http://hi.baidu.com/searchsprit/item/c2352c5da62a6613abf6d777**
冷静思考，勇敢面对，把握未来！

分类: [Linux驱动编程](http://www.cnblogs.com/Anker/category/436373.html)

[好文要顶](Centos下修改启动项和网络配置%20-%20Anker_s%20Blog%20-%20博客园.md#)[关注我](Centos下修改启动项和网络配置%20-%20Anker_s%20Blog%20-%20博客园.md#)[收藏该文](Centos下修改启动项和网络配置%20-%20Anker_s%20Blog%20-%20博客园.md#)[![icon_weibo_24.png](Centos下修改启动项和网络配置%20-%20Anker_s%20Blog%20-%20博客园.md#)[![wechat.png](Centos下修改启动项和网络配置%20-%20Anker_s%20Blog%20-%20博客园.md#)

[![u305504.png.jpg](../_resources/fda31ef1d46b78171f461ecaf3d04288.jpg)](http://home.cnblogs.com/u/Anker/)

[Anker's Blog](http://home.cnblogs.com/u/Anker/)
[关注 - 13](http://home.cnblogs.com/u/Anker/followees)
[粉丝 - 574](http://home.cnblogs.com/u/Anker/followers)

 [+加关注](Centos下修改启动项和网络配置%20-%20Anker_s%20Blog%20-%20博客园.md#)

 0
0

(请您对文章做出评价)

[«](http://www.cnblogs.com/Anker/p/3203477.html) 上一篇：[Centos下配置单元测试工具gtest](http://www.cnblogs.com/Anker/p/3203477.html)

[»](http://www.cnblogs.com/Anker/p/3209764.html) 下一篇：[Centos6.4下安装protobuf及简单使用](http://www.cnblogs.com/Anker/p/3209764.html)

posted @ 2013-07-21 16:21  [Anker's Blog](http://www.cnblogs.com/Anker/) 阅读(1083) 评论(0) [编辑](http://i.cnblogs.com/EditPosts.aspx?postid=3203931)  [收藏](http://www.cnblogs.com/Anker/archive/2013/07/21/3203931.html#)
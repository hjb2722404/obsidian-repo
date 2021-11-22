Centos7.3防火墙配置 - syoukaihou - 博客园

# [Centos7.3防火墙配置](https://www.cnblogs.com/xxoome/p/7115614.html)

**1、查看firewall服务状态**
systemctl status firewalld
![964175-20170704104259159-913218775.png](../_resources/0d56fe7391a159f716eb5f620fdec005.png)
**2、查看firewall的状态**
firewall-cmd --state
 ![964175-20170704104425769-698844041.png](../_resources/fd7940c2fee39c69a9987f795f6c0e5d.png)
**3、开启、****重启、关闭、****firewalld.service服务**

# 开启

service firewalld start

# 重启

service firewalld restart

# 关闭

service firewalld stop
**4、查看防火墙规则**
firewall-cmd --list-all

**![964175-20180711112139108-273720937.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180550.png)**

**5、查询、开放、关闭端口**
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](http://loadhtml/#)

# 查询端口是否开放

firewall-cmd --query-port=8080/tcp

# 开放80端口

firewall-cmd --permanent --add-port=
80
/
tcp

# 移除端口

firewall-cmd
--permanent
--remove-port=8080/tcp

*#重启防火墙(*
*修改配置后要重启防火墙*
*)*
*firewall-cmd --reload*

*# 参数解释*
*1*
*、firwall-*
*cmd：是Linux提供的操作firewall的一个工具；*
*2*
*、--*
*permanent：表示设置为持久；*
*3*
*、--add-port：标识添加的端口；*
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](http://loadhtml/#)

标签:  [linux](https://www.cnblogs.com/xxoome/tag/linux/)

[好文要顶](http://loadhtml/#)  [关注我](http://loadhtml/#)  [收藏该文](http://loadhtml/#)  [![icon_weibo_24.png](../_resources/c5fd93bfefed3def29aa5f58f5173174.png)](http://loadhtml/#)  [![wechat.png](../_resources/24de3321437f4bfd69e684e353f2b765.png)](http://loadhtml/#)

[![20170320211740.png](../_resources/211b480f55983eb3d49cf2a4b562841e.jpg)](http://home.cnblogs.com/u/xxoome/)

[syoukaihou](http://home.cnblogs.com/u/xxoome/)
[关注 - 1](http://home.cnblogs.com/u/xxoome/followees)
[粉丝 - 21](http://home.cnblogs.com/u/xxoome/followers)

[+加关注](http://loadhtml/#)
2
0

[«](https://www.cnblogs.com/xxoome/p/7113412.html)  上一篇：[office2016选择性安装](https://www.cnblogs.com/xxoome/p/7113412.html)

[»](https://www.cnblogs.com/xxoome/p/7121042.html)  下一篇：[linux下安装redis并配置](https://www.cnblogs.com/xxoome/p/7121042.html)

posted @
2017-07-04 11:04
[syoukaihou](https://www.cnblogs.com/xxoome/)  阅读(
17388
) 评论(
0

)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=7115614)  [收藏](https://www.cnblogs.com/xxoome/p/7115614.html#)
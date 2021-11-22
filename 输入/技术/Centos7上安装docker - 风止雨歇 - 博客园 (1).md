Centos7上安装docker - 风止雨歇 - 博客园

## [Centos7上安装docker](https://www.cnblogs.com/yufeng218/p/8370670.html)

Docker从1.13版本之后采用时间线的方式作为版本号，分为社区版CE和企业版EE。
社区版是免费提供给个人开发者和小型团体使用的，企业版会提供额外的收费服务，比如经过官方测试认证过的基础设施、容器、插件等。
社区版按照stable和edge两种方式发布，每个季度更新stable版本，如17.06，17.09；每个月份更新edge版本，如17.09，17.10。

##  一、安装docker

1、Docker 要求 CentOS 系统的内核版本高于 3.10 ，查看本页面的前提条件来验证你的CentOS 版本是否支持 Docker 。
通过 **uname -r **命令查看你当前的内核版本
$ uname -r
2、使用 `root` 权限登录 Centos。确保 yum 包更新到最新。
$ sudo  yum update
3、卸载旧版本(如果安装过旧版本的话)
$ sudo  yum remove docker docker-common docker-selinux docker-engine
4、安装需要的软件包， yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的
$ sudo  yum  install -y yum-utils device-mapper-persistent-data lvm2
5、设置yum源

$ sudo  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

 ![1107037-20180128094640209-1433322312.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180637.png)

6、可以查看所有仓库中所有docker版本，并选择特定版本安装
$ yum list docker-ce --showduplicates | sort -r
![1107037-20180128095038600-772177322.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180640.png)
7、安装docker

$ sudo  yum  install docker-ce #由于repo中默认只开启stable仓库，故这里安装的是最新稳定版17.12.0$ sudo  yum  install <FQPN> # 例如：sudo yum install docker-ce-17.12.0.ce

 ![1107037-20180128103448287-493824081.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180643.png)
8、启动并加入开机启动
$ sudo systemctl start docker
$ sudo systemctl enable docker
9、验证安装是否成功(有client和service两部分表示docker安装启动都成功了)
$ docker version
![1107037-20180128104046600-1053107877.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180647.png)

##  二、问题

1、因为之前已经安装过旧版本的docker，在安装的时候报错如下：
[![copycode.gif](Centos7上安装docker%20-%20风止雨歇%20-%20博客园%20(1).md#)

Transaction check error: file /usr/bin/docker from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package **docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64 **file /usr/bin/docker-containerd from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package **docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64 **file /usr/bin/docker-containerd-shim from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package **docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64 **file /usr/bin/dockerd from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package **docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64**

[![copycode.gif](Centos7上安装docker%20-%20风止雨歇%20-%20博客园%20(1).md#)
2、卸载旧版本的包
$ sudo  yum erase docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64
![1107037-20180128103145287-536100760.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180651.png)
3、再次安装docker
$ sudo  yum  install docker-ce

分类: [docker](https://www.cnblogs.com/yufeng218/category/1155301.html)

 [好文要顶](Centos7上安装docker%20-%20风止雨歇%20-%20博客园%20(1).md#)  [关注我](Centos7上安装docker%20-%20风止雨歇%20-%20博客园%20(1).md#)  [收藏该文](Centos7上安装docker%20-%20风止雨歇%20-%20博客园%20(1).md#)  [![icon_weibo_24.png](Centos7上安装docker%20-%20风止雨歇%20-%20博客园%20(1).md#)  [![wechat.png](Centos7上安装docker%20-%20风止雨歇%20-%20博客园%20(1).md#)

 [![20170215210050.png](../_resources/2e9d5429714ad0b3d79f6a8948abd81e.jpg)](http://home.cnblogs.com/u/yufeng218/)

 [风止雨歇](http://home.cnblogs.com/u/yufeng218/)
 [关注 - 1](http://home.cnblogs.com/u/yufeng218/followees)
 [粉丝 - 8](http://home.cnblogs.com/u/yufeng218/followers)

 [+加关注](Centos7上安装docker%20-%20风止雨歇%20-%20博客园%20(1).md#)

 7

 0

[«](https://www.cnblogs.com/yufeng218/p/8353794.html) 上一篇：[富文本编辑器--FCKEditor 上传图片](https://www.cnblogs.com/yufeng218/p/8353794.html)

[»](https://www.cnblogs.com/yufeng218/p/8370774.html) 下一篇：[Docker 国内镜像的配置及使用](https://www.cnblogs.com/yufeng218/p/8370774.html)

posted on 2018-01-28 10:44  [风止雨歇](https://www.cnblogs.com/yufeng218/) 阅读(62197) 评论(5) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=8370670)  [收藏](https://www.cnblogs.com/yufeng218/p/8370670.html#)
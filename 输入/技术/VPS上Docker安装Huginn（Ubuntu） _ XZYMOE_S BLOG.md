VPS上Docker安装Huginn（Ubuntu） | XZYMOE'S BLOG

# VPS上Docker安装Huginn（Ubuntu）

[2017年12月21日](https://www.xzymoe.com/docker-huginn-install/)[软件教程](https://www.xzymoe.com/category/how-to/)

我每天的资讯来源大多都来自与Feedly订阅的一些网站。但是不可否认是的RSS用户和网站越来越少，越来越多的网站甚至关闭了RSS订阅。作为一个重度RSS用户，直到在[挖站否](https://wzfou.com/)看见一款可以烧录RSS的程序Huginn，便对其产生了很大的兴趣。

![hugin-logo-300x130.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106130203.jpg)

### 1.关于Huginn的安装方式

在Huginn的官网给出了13种安装方式，但是全为英文的！！！网上主流的安装方法为部署在 Heroku上，部署过程也较为容易，但是Heroku也有他的缺陷比如需要用uptimerobot防止服务器休眠，当然也不排除Heroku某天停止服务了。随后考虑了了部署在VPS方案上，在Huginn官网推荐安装方式中，有一项为Automated deployment on DigitalOcean with Fodor.xyz，有DigitalOcean VPS的童鞋可以试一试，应该是自动安装的，总体应该比较简单。

除此之外，考虑用VPS安装Huginn，从硬件上需要0.5G内存的VPS，系统方面则是要求：

- Ubuntu (16.04, 14.04 and 12.04)
- Debian (Jessie and Wheezy)

VPS直接安装Huginn，首先需要编译Ruby、 Ruby gems的拓展，安装Ruby、MySQL数据库、Huginn和配置Nginx，总体过程较为复杂，我实验了多次一直卡在MySQL数据库上（最后换个VPS才成功了），总体过程较为复杂。因而我考虑使用Docker安装。

### 2.Docker安装Huginn

Docker安装Hugginn较为简单。
1.首先Putty链接VPS后，先更新系统（万年不变的老规矩）！
**
> apt-get update
> apt-get upgrade
**
2.安装Docker CE
**
> sudo apt-get -y install apt-transport-https ca-certificates curl
> curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –

> sudo add-apt-repository “deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable”

> sudo apt-get update
> sudo apt-get -y install docker-ce
**
3.安装Huginn镜像
**
> docker run -it -p 3000:3000 huginn/huginn
**
**特别注意**！！！不要安装成旧版的镜像<s>docker run -it -p 3000:3000 cantino/huginn</s>。
4.启动Huginn
打开你的浏览器，输入
**
> http://localhost:3000
**
localhost等于你的IP地址或者域名，( >﹏<。)～呜呜呜……
5.演示效果：
**
> http://huginn.xzymoe.com:3000/
**

### 3.重启VPS后，启动Huginn

由于VPS重启后，并没有自动加载镜像，因而重启VPS后，你的Huginn将无法启动，当然启动你的Huginn的方法也非常简单。
1.首先查出你的Huginn容器的id
**
> docker ps -a
**
2.启动容器
**
> docker start 容器_id/容器_name
**

3.不过VPS也是常年不关机的的，所以该项技能基本没有用武之地，当然万一遇到宕机，那么就只能自己再次启动了容器了，当然你也可以使用Linux的crontab计划任务来完成开机启动。这样配置一次即可达到一劳永逸的方法了。

Huginn的功能很强大，用起来配合Google的feedburner来对那些没有提供RSS的网站进行烧录RSS只是Huginn强大武器库中的一个小武器而已。

[RSS](https://www.xzymoe.com/tag/rss/)[Tutorial](https://www.xzymoe.com/tag/tutorial/)[软件](https://www.xzymoe.com/tag/software/)

## 文章导航

[** 启用FireFox Quantum自带翻译系统（Yandex）](https://www.xzymoe.com/active-firefox-quantum-tranlator/)

[Huginn烧录网站的RSS **](https://www.xzymoe.com/huginn-output-rss/)

## 7 thoughts on “VPS上Docker安装Huginn（Ubuntu）”

1.   ![02423cb2819c318ee8c1bd6633a489fc](../_resources/d5fe5cbcc31cff5f8ac010db72eb000c.jpg)

[Ann](http://huginn.timesharestravel.com:3000/)

 2018年3月10日 at 下午5:14

 ![](../_resources/6e83d85e071340a0b854e5f04152b869.png) Google Chrome 64.0.3282.186 ![](../_resources/4ff3381a1ac1a3527916b30f914d91b1.png) Windows 7 x64 Edition

您好。重启VPS后，启动Huginn容器的具体指令是啥？谢谢

[回复](https://www.xzymoe.com/docker-huginn-install/?replytocom=191#respond)

    - ![ce191eaf0803ed04dabedacd815d965c](../_resources/3821d842f26beb375462d8de97a8f39f.jpg)

xzymoe

 2018年3月10日 at 下午6:03

 ![](../_resources/d1aad333e9ea8b39d0715e594b707a77.png) Firefox 57.0 ![](../_resources/7f1b7f1f45c95fabdea37e82fd30db3f.png) Ubuntu x64

你可以试一试docker start suspicious_mestorf如果启动不了的话，你看下文章中那个先用docker ps -a查找出你huginn容器的id 再通过docker start id数值 来启动，每个人的id是不同的。

[回复](https://www.xzymoe.com/docker-huginn-install/?replytocom=192#respond)

2.   ![02423cb2819c318ee8c1bd6633a489fc](../_resources/d5fe5cbcc31cff5f8ac010db72eb000c.jpg)

[kevin](https://weibo.com/)

 2018年8月9日 at 下午11:32

 ![](../_resources/6e83d85e071340a0b854e5f04152b869.png) Google Chrome 67.0.3396.99 ![](../_resources/4ff3381a1ac1a3527916b30f914d91b1.png) Windows 7 x64 Edition

有没有google cloud 方案/?谢谢

[回复](https://www.xzymoe.com/docker-huginn-install/?replytocom=616#respond)

    - ![ce191eaf0803ed04dabedacd815d965c](../_resources/3821d842f26beb375462d8de97a8f39f.jpg)

xzymoe

 2018年8月10日 at 下午10:47

 ![](../_resources/d1aad333e9ea8b39d0715e594b707a77.png) Firefox 61.0 ![](../_resources/27fc7672974c2f58e8181ddcc9ff69aa.png) Windows 10 x64 Edition

在GCE上安装下Docker然后在用Docker安装Huginn就行了啊！

[回复](https://www.xzymoe.com/docker-huginn-install/?replytocom=618#respond)

3.   ![02423cb2819c318ee8c1bd6633a489fc](../_resources/d5fe5cbcc31cff5f8ac010db72eb000c.jpg)

乔丰

 2018年8月28日 at 上午8:37

 ![](../_resources/6e83d85e071340a0b854e5f04152b869.png) Google Chrome 63.0.3239.132 ![](../_resources/27fc7672974c2f58e8181ddcc9ff69aa.png) Windows 10 x64 Edition

[http://localhost:3000](http://localhost:3000/)
这个localhost在哪里看啊？
就像http://huginn.xzymoe.com:3000/里面的huginn.xzymoe.com这个是怎么来的？

[回复](https://www.xzymoe.com/docker-huginn-install/?replytocom=681#respond)

    - ![ce191eaf0803ed04dabedacd815d965c](../_resources/3821d842f26beb375462d8de97a8f39f.jpg)

xzymoe

 2018年8月28日 at 下午4:32

 ![](../_resources/d1aad333e9ea8b39d0715e594b707a77.png) Firefox 61.0 ![](../_resources/7f1b7f1f45c95fabdea37e82fd30db3f.png) Ubuntu x64

localhost是你server的IP地址啊！！替换下就可以了，如果要有huginn.xzymoe.com:3000的效果，那么就绑定一个域名到你的ip上就行了啊！

[回复](https://www.xzymoe.com/docker-huginn-install/?replytocom=686#respond)

4.   ![02423cb2819c318ee8c1bd6633a489fc](../_resources/d5fe5cbcc31cff5f8ac010db72eb000c.jpg)

钱越

 2018年10月3日 at 下午8:42

 ![](../_resources/6e83d85e071340a0b854e5f04152b869.png) Google Chrome 69.0.3497.100 ![](../_resources/5f16f3b2fe3c8b5075cf650e2fd6029e.png) GNU/Linux x64

在安装huginn镜像“docker run -it -p 3000:3000 huginn/huginn”时，似乎除了问题，无法打开http://localhost:3000（已经替换了相应的服务器的IP地址了），请问这样的话，问题出在哪里了？

[回复](https://www.xzymoe.com/docker-huginn-install/?replytocom=761#respond)

### 发表评论

Comment
Name
Email
Website
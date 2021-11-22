Huginn安装教程—建立只属于你自己的IFTTT - 简书

 [![Logo](../_resources/44fcd18b42ae40da8b1ffb6af9f94a2f.png)](http://www.jianshu.com/apps)  ![Goto app](../_resources/ab136bab903af127f35c5c974349c38f.png)

#  Huginn安装教程—建立只属于你自己的IFTTT

 [翔215](http://www.jianshu.com/users/512cd64277f8)  2016-07-14 11:45

### Huginn是什么

首先，Huginn是一款开源应用（开源赛高!!!），这是它的[Github地址](https://github.com/cantino/huginn)，有**上万的star**（经常混Github的人应该都知道，上万的star意味着这个开源应用是非常厉害、非常受欢迎的），那么Hugin到底是什么？官网上的解释是：**Huginn 是一个用于构建在线自动化任务的系统**，可以把它看成是一个可以部署在自己服务器上的**Yahoo! Pipes + IFTTT**。

Yahoo!Pipes的服务已经被关闭，大家可能不知道，IFTTT是这两年才流行起来的服务，它的功能是”如果一件事情被触发，则执行另一件设定好的事情“，比如，如果明天下雨，则自动给你的手机发送提醒，如果在微博上发布一条状态，则自动保存到印象笔记。。。等等，它的功能非常多。

Huginn是一个只属于自己的IFTTT，甚至**比IFTTT更加强大**，官网上介绍的功能就有很多，比如，**跟踪天气变化、跟踪当前热点、监控商品价格（网页变化）、自动发送邮件、连接各种常用服务**，等等。

作为一名RSS重度患者来说，Huginn最最让人心动的功能莫过于，**它可以将任意网站的内容变成RSS**。在这个RSS日益被忽略、被放弃的年代，很多网站都已经不再提供RSS服务，但是，我认为恰恰相反，**正因为是这个年代，这个信息大爆炸的年代，RSS才应该需要更加受到重视**，我在简书上的[这篇文章](http://www.jianshu.com/p/a304318d27dc)就有讲到RSS的方便和好处。可惜， 尽管**RSS能给用户带来最干净且完整的内容**，但是它不能够给网站运营商带来广告或流量，也缺少互动，所以正在被很多网站运营商所抛弃。

 ![54401-a18a7fc0cff1df8f.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141616.png)
Huginn官网图片

### 安装教程

Huginn需要自己部署到云端才能使用，官网上的部署教程非常详细，它可以部署在自己的VPS上(**强烈推荐**)，也可以部署在各大云平台的虚拟主机上，在这里主要介绍**部署在heroku**的方法。

>
> 简单地介绍一下heroku的免费账号：
>

`1. 免费帐号能创建无限个app（网站），所有app每个月的运行时长为550小时； 2. 支持python/ruby/php/nodejs等诸多语言，且非常友好； 3. 可使用Git、GitHub进行部署; 4. 每个网站在30分钟以内无人访问后便会自动关闭，在有人访问后会自动重新打开； 5. 添加信用卡的账户可以使用各种插件（大部分插件都有免费额度）`

>

其实，官网上的[部署教程](https://github.com/cantino/huginn/blob/master/doc/heroku/install.md)已经非常详细，但是它不支持通过Windows部署安装，在Windows上需要使用虚拟机才能部署到云端。那么，是不是Windows用户就不能将Huginn部署到云端呢？作为一名十足的工具控加Windows使用者，在各种Google之后，终于找到了解决办法，可以帮助**任意系统的用户在heroku上部署Huginn**，下面开始介绍具体的操作步骤：

1. 注册[heroku](https://dashboard.heroku.com/)账号；

2. 注册[Cloud9](https://c9.io/?redirect=0)账号（下面简称c9）；

3. 进入c9分配的workspaces，创建一个新的空间，空间属性选择private，template选择ruby，然后点击create workspace，见下图；

 ![54401-1450a674a60aa27f.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141622.jpg)
建立工作空间

4. 打开创建好的工作空间，接下来的操作跟官网上的教程基本上一样（c9空间内已经安装好了Heroku Toolbelt ）；

5. 在c9空间内的bash中输入`heroku login`，然后按照提示输入自己注册heroku时的邮箱地址和密码；

6. 创建名为huginn-myifttt的app：`heroku create huginn-myifttt`（**大家创建时需要换个名字**）

7. 将app应用clone到c9空间内：`heroku git:clone --app huginn-myifttt`

8. 将官网上的Huginn主程序也clone到c9空间内：`git clone https://github.com/cantino/huginn.git`

9. 将clone下来的Huginn主程序（除了.git文件夹以外的其他文件夹和文件）复制到huginn-myifttt文件夹内；

10. 进入到huginn-myifttt文件夹内：`cd huginn-myifttt`，随后输入`cp .env.example .env`，完成后再输入`bundle`，这一步会花费比较长的时间，请耐心等待；

11. 上面的命令完成后，再依次输入下面一组命令，将更改的应用上传到heroku的云端服务器上：`git add`，`git commit -am "install huginn"`，`git push heroku master`

12. 上面的命令完成后，在bash内输入：`bin/setup_heroku`，运行过程中会有几处提示，请按照提示输入，这一步运行时间也比较长，请耐心等待；

13. 待上面的命令完成之后，只属于你个人的Huginn网站正式部署完毕！！！当然，你也可以将邀请码分享给你的朋友，让他们能够注册你的huginn网站。

本教程建立好的网站地址是[huginn-myifttt.herokuapp.com]()，邀请码是`try-huginn`,欢迎大家注册使用。

### 补充说明

如果你使用的是heroku的免费账户，这里还有几点需要说明：

1. 免费账户的网站在30分钟内无人访问后会自动关闭（休眠），因此，如果要使网站能够不休眠的话，可以使用网站监控服务来防止其休眠，例如：[uptimerobot](https://uptimerobot.com)；

2. 尽管在heroku上可以创建无限个网站，但是，免费用户的所有app运行总时长为每个月550小时，添加信用卡之后，会再赠送450小时，从而能够保证一个网站能够运行30X24X7小时，因此，建议让网站每天只运行18小时，这可以通过上面的网站监控服务来进行简单的控制（在实际使用中，其实根本不需要Huginn每天都能运行24h，但是，如果无论如何都要的话，可以添加信用卡，或者注册两个账号，分别部署Huginn，然后让它们交替运行)；

3. 免费账户只要5M的 Postgres 数据库，只允许在数据库中记录10000行，因此，作者建议设置`heroku config:set AGENT_LOG_LENGTH=20`，如果添加信用卡的话，可以获得更大额度的免费数据库。

4. Huginn安装在heroku的过程中默认使用的是SendGrid的邮箱服务器，这还需要我们添加SendGrid插件才能正常使用，但是添加插件需要先添加信用卡，因此，非信用卡用户无法使用SendGrid的邮箱服务器，建议添加其它邮箱服务器，比如，gmail邮箱服务器，具体设置如下：

`heroku config:set SMTP_DOMAIN=google.com heroku config:set SMTP_USER_NAME=<你的gmail邮箱地址> heroku config:set SMTP_PASSWORD=<邮箱密码> heroku config:set SMTP_SERVER=smtp.gmail.com heroku config:set EMAIL_FROM_ADDRESS=<你的gmail邮箱地址>`

其中，**如果你的google开启了两步验证，请使用专用密码**。

### 总结

Huginn是一款异常强大的开源应用，可以帮助我们实现很多自动化的任务，从而打造一个只属于我们自己的IFTTT服务，非常实用。但是，在具体使用的过程中，你可能还需要具备一些网页前端的知识，包括HTML、CSS等；大家遇到不懂的知识，可以去[w3school](http://www.w3school.com.cn/)上学习，也要经常去google，其实，它还是非常容易上手的。同时，我还要再着重强调一点，**从某种程度上来说，Huginn比IFTTT要更加强大**。

关于Huginn的教程，**国内的中文教程少之又少**，所以本着让更多的人能够熟悉和使用这款开源应用，我写了这篇中文的安装教程，希望有更多的人能够使用它。最后，关于Huginn或RSS有什么需要交流的可以在微博或简书上私信给我。

© 著作权归作者所有

查看全部评论，参与文章讨论 [![Phone](../_resources/534f2814ba1e2c5cb71117e2b8f79f60.png)立刻下载 简书客户端](http://www.jianshu.com/apps/download)

作者信息

 [ ![100](../_resources/e5e8921870918501d930a1b74e2abe7a.jpg)      翔215](http://www.jianshu.com/users/512cd64277f8)

以梦为马，浪迹天涯
个人主页：http://xzonepiece.lofter.com

  — 热门文章 —  [《【干货】用了这些工具软件，百分之百能提高Windows使用效率（一）》](http://www.jianshu.com/p/c72017a0c7d4?utm_campaign=maleskine&utm_content=note&utm_medium=mobile_all_hots&utm_source=recommendation)  [《【干货】信息（时间）管理之最强工具包（解决方案）》](http://www.jianshu.com/p/9bc3fedb1ca3?utm_campaign=maleskine&utm_content=note&utm_medium=mobile_all_hots&utm_source=recommendation)  [《【干货】Markdown最强最快贴图方法》](http://www.jianshu.com/p/6fb3e2151f90?utm_campaign=maleskine&utm_content=note&utm_medium=mobile_all_hots&utm_source=recommendation)

热门推荐

 [《希望这五本书，能让你重新思考未来》](http://www.jianshu.com/p/96d78193e2b6?utm_campaign=maleskine&utm_content=note&utm_medium=mobile_all_hots&utm_source=recommendation)  [《即使她脱光了，也不应该成为被强奸的理由》](http://www.jianshu.com/p/c587c9baafb2?utm_campaign=maleskine&utm_content=note&utm_medium=mobile_all_hots&utm_source=recommendation)  [《推荐给年轻人的10个快时尚品牌》](http://www.jianshu.com/p/7933aece78cf?utm_campaign=maleskine&utm_content=note&utm_medium=mobile_all_hots&utm_source=recommendation)

 [打开应用]()  **|**  [完整网页](http://www.jianshu.com/p/2e6e3f845bc3?nomobile=yes)
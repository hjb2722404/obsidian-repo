Apache与Tomcat 区别联系 - WEB开发者

#  Apache与Tomcat 区别联系

 来源：[sunboy_2050](http://blog.csdn.net/sunboy_2050/article/details/7839906)  发布时间：2012-09-18  阅读次数：34780

[(L)](http://www.jiathis.com/share?uid=1541970)[98]()

 ![print.gif](../_resources/6676f586173a14287cc32a8380e36b84.gif)

　　[Apache](http://httpd.apache.org/ABOUT_APACHE.html) 和 [Tomcat](http://tomcat.apache.org/) 都是web网络服务器，两者既有联系又有区别，在进行HTML、PHP、JSP、Perl等开发过程中，需要准确掌握其各自特点，选择最佳的服务器配置。

　　Apache是web服务器（静态解析，如HTML），tomcat是java应用服务器（动态解析，如JSP、PHP）
　　Tomcat只是一个servlet(jsp也翻译成servlet)容器，可以认为是apache的扩展，但是可以独立于apache运行
![](../_resources/f2d3ded2d1665a557b6672e3a15f5028.png)
　　两者从以下几点可以比较的：
　　1、两者都是apache组织开发的
　　2、两者都有HTTP服务的功能
　　3、两者都是开源免费的

### 联系

　　1）Apache是普通服务器，本身只支持html即普通网页，可以通过插件支持php，还可以与Tomcat连通(Apache单向连接Tomcat，就是说通过Apache可以访问Tomcat资源，反之不然)。

　　2）Apache只支持静态网页，但像asp、jsp、php、cgi等动态网页就需要Tomcat来处理。
　　3）Apache和Tomcat整合使用：
　　　　如果客户端请求的是静态页面，则只需要Apache服务器响应请求；
　　　　如果客户端请求动态页面，则是Tomcat服务器响应请求，将解析的JSP等网页代码解析后回传给Apache服务器，再经Apache返回给浏览器端。

　　　　这是因为jsp是服务器端解释代码的，Tomcat只做动态代码解析，Apache回传解析好的静态代码，Apache+Tomcat这样整合就可以减少Tomcat的服务开销。

　　4）Apache和Tomcat是独立的，在同一台服务器上可以集成。

### 区别

　　Apache是有C语言实现的，支持各种特性和模块从而来扩展核心功能；Tomcat是Java编写的，更好的支持Servlet和JSP。

　　1、Apache是Web服务器，Web服务器传送(serves)页面使浏览器可以浏览，Web服务器专门处理HTTP请求(request)，但是应用程序服务器是通过很多协议来为应用程序提供 (serves)商业逻辑(business logic)。

　　Tomcat是运行在Apache上的应用服务器，应用程序服务器提供的是客户端应用程序可以调用(call)的方法 (methods)。它只是一个servlet(jsp也翻译成servlet)容器，可以认为是Apache的扩展，但是可以独立于apache运行。

　　2、Apache是普通服务器，本身只支持html静态普通网页。不过可以通过插件支持PHP，还可以与Tomcat连通(单向Apache连接Tomcat,就是说通过Apache可以访问Tomcat资源，反之不然)，Tomcat是jsp/servlet容器，同时也支持HTML、JSP、ASP、PHP、CGI等，其中CGI需要一些手动调试，不过很容易的。

　　3、Apache侧重于http server，Tomcat侧重于servlet引擎，如果以standalone方式运行，功能上Tomcat与apache等效支持JSP，但对静态网页不太理想。

　　4、Apache可以运行一年不重启，稳定性非常好，而Tomcat则不见得。
　　5、首选web服务器是Apache，但Apache解析不了的jsp、servlet才用tomcat。

　　6、Apache是很最开始的页面解析服务，tomcat是后研发出来的，从本质上来说tomcat的功能完全可以替代Apache，但Apache毕竟是tomcat的前辈级人物，并且市场上也有不少人还在用Apache，所以Apache还会继续存在，不会被取代，apache不能解析java的东西，但解析html速度快。

### 两者例子：

　　Apache是一辆车，上面可以装一些东西如html等，但是不能装水，要装水必须要有容器（桶），而这个桶也可以不放在卡车上，那这个桶就是TOMCAT。

### 两者整合：

　　Apache是一个web服务器环境程序，启用他可以作为web服务器使用不过只支持静态网页，不支持动态网页，如asp、jsp、php、cgi
　　如果要在Apache环境下运行jsp就需要一个解释器来执行jsp网页，而这个jsp解释器就是Tomcat

　　那为什么还要JDK呢？因为jsp需要连接数据库的话就要jdk来提供连接数据库的驱程，所以要运行jsp的web服务器平台就需要APACHE+TOMCAT+JDK

### 整合的好处：

　　如果客户端请求的是静态页面，则只需要Apache服务器响应请求
　　如果客户端请求动态页面，则是Tomcat服务器响应请求
　　因为jsp是服务器端解释代码的，这样整合就可以减少Tomcat的服务开销

QQ群： [WEB开发者官方总群(515171538)](http://shang.qq.com/wpa/qunwpa?idkey=dc0bdc28cab1a3a53fa2e3100718137cfa15d372d6143d02df2ab6b6ed898d3f) 验证消息：Admin10000

提示：常上QQ空间的朋友可关注[【WEB开发者】腾讯认证空间](http://user.qzone.qq.com/849023636)，精彩内容不错过。

 ![tag.gif](../_resources/1e83e3b0b677c92b3aa8a252268f7b86.gif)[apache](http://www.admin10000.com/tag/apache/) | [tomcat](http://www.admin10000.com/tag/tomcat/) | [web服务器](http://www.admin10000.com/tag/web%e6%9c%8d%e5%8a%a1%e5%99%a8/)

相关文档

- [高并发Web服务的演变——节约系统内存](http://www.admin10000.com/document/6190.html)

- [实用 .htaccess 用法大全](http://www.admin10000.com/document/6070.html)

- [“一片羽毛的故事”：Apache软件基金](http://www.admin10000.com/document/5536.html)

- [10个强大的Apache开源模块](http://www.admin10000.com/document/5056.html)

- [Nginx vs Apache](http://www.admin10000.com/document/4495.html)

- [Nginx取代Apache成为世界前1万家网站](http://www.admin10000.com/document/4494.html)

- [关于Apache的25个初中级面试题](http://www.admin10000.com/document/3923.html)

- [2月全球Web服务器：Microsoft增至32.](http://www.admin10000.com/document/3877.html)

- [Tomcat 生产服务器性能优化](http://www.admin10000.com/document/2483.html)

- [Nginx成为全球TOP1000网站最常用的We](http://www.admin10000.com/document/2317.html)

- [Web开发者必知的25个Apache性能优化技](http://www.admin10000.com/document/2061.html)

- [mod_pagespeed：让你的网站跑到更快](http://www.admin10000.com/document/1062.html)

- [PHP 5.4 内置web服务器](http://www.admin10000.com/document/959.html)

- [21个非常有用的.htaccess 提示和技巧](http://www.admin10000.com/document/941.html)

网友评论（共1条评论）

- ![](../_resources/d685c941f11a15c88f282d231b51aeaf.jpg)

uoou - 2014-12-10 16:07

图灵机器人基于DeepQA深度问答技术，是目前中文语境喜下智能度最高的机器人。图灵机器人提供免费API接口，接入简单、支持多平台及个性化设定。通过此平台，用户可以方便在微信、微博、QQ及客服等平台创建属于自己的个性化智能机器人。甚至还有人借助平台做一些为自己的赚钱的项目，图灵论坛上用户反应都很不错，不要叫我雷锋http://www.tuling123.com/openapi/cloud/proexp.jsp

«1»

 理智评论文明上网，拒绝恶意谩骂 发表评论 / 共1条评论

 [登录会员中心](http://www.admin10000.com/Member/Index.aspx)
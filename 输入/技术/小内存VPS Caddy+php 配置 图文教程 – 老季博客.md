小内存VPS Caddy+php 配置 图文教程 – 老季博客

# 小内存VPS Caddy+php 配置 图文教程

Posted on 2018-09-10 by [VPS推荐评测/搬瓦工优惠码](https://www.jiloc.com/author/_lei)
![caddy-white-character.png](../_resources/fddc84e1013fefc9a9df3de6ac574875.png)
![](../_resources/d5680dec2b02502fdeac85f6f2e33082.png)

[Caddy](https://www.jiloc.com/tag/caddy) 是一款由 Go 编写的 Web Server 工具，在折腾 Drone 的时候，我最终就是使用的它提供 Web 服务。回到标题，为什么要用Caddy 替换掉 [Nginx](https://www.jiloc.com/tag/nginx) 呢？最主要的原因是Caddy 能让网站自动支持 HTTPS。同样是使用 Let’s Encrypt，换成 [Nginx](https://www.jiloc.com/tag/nginx) 我们就必须手工操作，并且还需要设置三个月更新证书的计划任务。而且默认还支持 http/2，很多事情都不需要我们再配置了。另外它的配置文件也比 [Nginx](https://www.jiloc.com/tag/nginx) 的要简单很多，几十行的 [Nginx](https://www.jiloc.com/tag/nginx) 配置文件Caddy 仅需要几行就可以搞定了。

Table of Contents

- [1 安装Caddy](https://www.jiloc.com/43768.html#Caddy)
- [2 安装php](https://www.jiloc.com/43768.html#php)
- [3 修改php配置文件](https://www.jiloc.com/43768.html#php-2)
- [4 添加新用户](https://www.jiloc.com/43768.html#i)
- [5 切换用户caddy](https://www.jiloc.com/43768.html#caddy)
    - [5.1 总结](https://www.jiloc.com/43768.html#i-2)

# 安装Caddy

官网：https://caddyserver.com/download
选择平台、插件、执照即可下载。
官方提供两种下载方式
直接下载、一键安装脚本
推荐使用一键安装脚本：
`curl https://getcaddy.com | bash -s personal `

# 安装php

`yum install php php-fpm php-mysql php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc`

# 修改php配置文件

`vi /etc/php-fpm.d/www.conf`
原配置

	; Unix user/group of processes
	; Note: The user is mandatory. If the group is not set, the default user's group
	;       will be used.
	; RPM: apache Choosed to be able to access some dir as httpd
	user = apache
	; RPM: Keep a group allowed to write in log dir.
	group = apache

修改后

	; Unix user/group of processes
	; Note: The user is mandatory. If the group is not set, the default user's group
	;       will be used.
	; RPM: apache Choosed to be able to access some dir as httpd
	user = caddy
	; RPM: Keep a group allowed to write in log dir.
	group = caddy

修改后保存启动php-fom
`systemctl start php-fpm`

# 添加新用户

`useradd caddy`

# 切换用户caddy

`su caddy`
在web目录下创建配置文件Caddyfile

	www.example.com
	gzip
	tls admin@example.com
	fastcgi / 127.0.0.1:9000 php

保存后启动caddy

更多的配置指令可以上 https://caddyserver.com/docs 官方文档查看，也可以上 https://github.com/caddyserver/examples 仓库中查看各种程序对应的 Caddy 配置。

## 总结

最近使用下来之后觉得 Caddy 真是太方便了，不用操心 SSL 证书过期的事情，也不用愁看不懂配置文件了，简单几行就能搞定大部分的功能。对于没有什么特别功能的个人网站来说真是再适合不过了，希望大家也可以试试 Caddy 这款小清新 HTTP Server。

搬瓦工，年付`$49.99`的`CN2`高速线路，`1024MB`内存/`1000GB`流量/`1GB`带宽，电信联通优化`KVM`，延迟低，速度快，建站稳定，搬瓦工BandwagonHost VPS优惠码`BWH26FXH3HIQ`，支持<支付宝> 【[点击购买](https://www.jiloc.com/go/bwh-annually-49-99)】！

Vultr月付`$3.5`的`日本`节点，`512M`内存/`500G`流量/`1G`带宽，电信联通优化，延迟低，速度快【[点击购买](https://www.jiloc.com/go/vultr)】！

![](../_resources/fcb93cbfee34ebff31addf3d8293494b.png)

 **Categories[Linux图文教程](https://www.jiloc.com/category/lnmpa/linux), [LNMPA图文教程](https://www.jiloc.com/category/lnmpa), [PHP](https://www.jiloc.com/category/lnmpa/php)**Tags[Caddy](https://www.jiloc.com/tag/caddy), [cheap-vps](https://www.jiloc.com/tag/cheap-vps), [golang](https://www.jiloc.com/tag/golang), [Linux](https://www.jiloc.com/tag/linux), [Nginx](https://www.jiloc.com/tag/nginx)

[VPS推荐评测/搬瓦工优惠码](https://www.jiloc.com/author/_lei)
http://www.jiloc.com/
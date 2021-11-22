利用 Caddy 轻松实现反向代理/镜像（支持自签SSL证书） - 网络资源 - 如有乐享

# 利用 Caddy 轻松实现反向代理/镜像（支持自签SSL证书）

![699c2d0fgy1fdlcl8xcfuj20mj0cqti2](../_resources/24daf384f34df9ce0ecf62eab7faf92d.jpg)

Caddy是一个使用 Go语言写的 HTTP Server，开发时间并不长，在性能上或许比不上 Nginx，但是在 上手难度/配置难度 上面简单的不行不行的。

并且 Caddy支持 自动签订[Let’s Encrypt SSL](http://51.ruyo.net/p/3163.html)证书，什么都不需要你管，只需要提供一个邮箱，剩下的他会自己申请、配置和续约 SSL证书！

本文属于无脑转载自 [逗比哥的文章](https://doub.io/jzzy-2/) ~

## 官网地址

[https://caddyserver.com](http://51.ruyo.net/p/tag/caddyserver-com/)

## 部署 Caddy

Caddy 是 Go语言编译好的二进制程序，所以只有一个 Caddy 文件（还需要生成一个配置文件），但是为了管理方便，所以我做了个一键脚本。

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | wget-N--no-check-certificate https://softs.pw/Bash/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh<br># 如果上面这个脚本无法下载，尝试使用备用下载：<br>wget-N--no-check-certificate https://raw.githubusercontent.com/pipesocks/install/master/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh |

## 配置文件

Caddy的特点之一就是，配置文件非常的简单，继续下面看就知道了。

### 服务器IP 反向代理

下面是一个，用你服务器的IP 来反向代理一个 http协议的网站 http://www.baidu.com
一次性复制以下全部代码，并粘贴到SSH中执行：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | echo":80 {<br>gzip<br>proxy / http://www.baidu.com<br>}">/usr/local/caddy/Caddyfile |

### 域名 反向代理 HTTP

下面是一个，用你的域名 来反向代理一个 http协议的网站http://www.baidu.com
以下所有示例域名为 toyoo.ml，请注意替换为 自己的域名 ！
一次性复制以下全部代码，并粘贴到SSH中执行：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | echo"http://toyoo.ml {<br>gzip<br>proxy / http://www.baidu.com<br>}">/usr/local/caddy/Caddyfile |

如果你需要反向代理 HTTPS 协议的网站，比如  https://www.baidu.com ，那么继续看下面步骤。

### 域名 反向代理 HTTPS

如果你有 SSL证书和密匙的话，把 **SSL证书(xxx.crt)和密匙(xxx.key)文件**放到 /root文件夹下（也可以是其他文件夹，自己改下面代码），然后这样做：

一次性复制以下全部代码，并粘贴到SSH中执行：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | echo"https://toyoo.ml {<br>gzip<br>tls /root/xxx.crt /root/xxx.key<br>proxy / https://www.baidu.com<br>}">/usr/local/caddy/Caddyfile |

如果你没有 SSL证书和密匙，那么你可以这样做：

下面的 xxxx@xxx.xx改成你的邮箱，同时需要注意的是，**申请 SSL证书前，请务必提前解析好域名记录(解析后最好等一会，以全球生效)**，否则 Caddy会申请并配置失败！

一次性复制以下全部代码，并粘贴到SSH中执行：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | echo"https://toyoo.ml {<br>gzip<br>tls xxxx@xxx.xx<br>proxy / https://www.baidu.com<br>}">/usr/local/caddy/Caddyfile |

如果一切正常，那么Caddy会自动帮你申请 SSL证书并配置好，而且会定时续约SSL证书 和 强制 http重定向至https ！

上面这两段示例中，只要把 **https://www.baidu.com** 改成 **https://www.google.com** ，即可实现反向代理 Google了！

需要注意的是，因为墙会检测关键词，所以**请务必使用 HTTPS协议，不要使用 HTTP协议，否则很快就会被墙！**

### HTTP重定向为HTTPS

当你是手动指定 SSL证书和密匙 来配置的话，Caddy只会监听 443端口(https)，并不会自动设置 80端口(http)的重定向（如果是Caddy自动申请的SSL证书，那么就自动做好了），如果要做重定向的话，可以这样做：

下面的示例代码中，是把  http://toyoo.ml、http://233.toyoo.ml、https://666.toyoo.ml 三个域名都重定向到了  https://toyoo.ml 。

一次性复制以下全部代码，并粘贴到SSH中执行：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | echo"http://toyoo.ml ,http://233.toyoo.ml ,https://666.toyoo.ml {<br>redir https://toyoo.ml{url}<br>}<br>https://toyoo.ml {<br>gzip<br>tls /root/xxx.crt /root/xxx.key<br>proxy / https://www.baidu.com<br>}">/usr/local/caddy/Caddyfile |

修改完 Caddy的配置文件后，重启 Caddy即可。

|     |     |
| --- | --- |
| 1   | service caddy restart |

## 使用说明

**启动：**service caddy start
**停止：**service caddy stop
**重启：**service caddy restart
**查看状态：**service caddy status
**查看Caddy启动日志：** tail -f /tmp/caddy.log
**Caddy配置文件位置：**/usr/local/caddy/Caddyfile

## 卸载 Caddy

执行以下代码后，会问你是否确定要卸载 Caddy，输入 y即可。

|     |     |
| --- | --- |
| 1<br>2 | 注意：卸载Caddy会把Caddy的所有虚拟主机文件夹和配置文件删除，并且不可恢复！ |

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | wget-N--no-check-certificate https://softs.pw/Bash/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh uninstall<br># 如果上面这个脚本无法下载，尝试使用备用下载：<br>wget-N--no-check-certificate https://raw.githubusercontent.com/pipesocks/install/master/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh uninstall |

## 其他说明

### 单网站/多网站

当然，上面的几个示例，实际上都算是单网站。
最后一句代码都是  }">/usr/local/caddy/Caddyfile，也就是清空了 Caddy配置文件，然后再写入了配置信息。

如果你要设置多个网站，那么把最后一句代码改成 }">>/usr/local/caddy/Caddyfile即可，注意是把 >改成 >>，这样就不会清空原来的配置信息了，而是会把要添加的配置信息加到配置文件最后！

### 网页加密

什么？担心自己做的镜像不小心爆露被滥用？没事，设置一下用户名和密码即可，只需要在上面的示例中加入这行代码：

|     |     |
| --- | --- |
| 1   | basicauth/user passwd |

user指的是 用户名， passwd指的是 用户名密码，设置这个后，访问网页就需要输入用户名和密码来验证了！
修改配置文件后，记得重启 Caddy ！
**配置示例：**

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | echo"https://toyoo.ml {<br>gzip<br>basicauth / user passwd<br>tls /root/xxx.crt /root/xxx.key<br>proxy / https://www.baidu.com<br>}">/usr/local/caddy/Caddyfile |

### 记录日志

如果你想要记录网站访问日志，那么只需要在上面的示例中加入这行代码：

|     |     |
| --- | --- |
| 1   | log/tmp/caddy_1.log |

修改配置文件后，记得重启 Caddy ！
**配置示例：**

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | echo"https://toyoo.ml {<br>gzip<br>log /tmp/caddy_1.log<br>tls /root/xxx.crt /root/xxx.key<br>proxy / https://www.baidu.com<br>}">/usr/local/caddy/Caddyfile |

日志文件的位置和名字可以自己改，放到 /tmp文件夹的话，每次重启都会自动清空日志的。

### Caddy启动失败，打开 http://ip 显示的是 It works !

一些系统会自带 apache2 ，而 apache2 会占用80端口，导致Caddy无法绑定端口，所以只要关掉就好了。

|     |     |
| --- | --- |
| 1<br>2 | netstat-lntp<br># 我们可以通过这个命令查看是不是被其他软件占用了 80 端口。 |

不过 apache2 会默认开机自启动，如果不需要可以关闭自启动或者卸载 apache2 。
**停止 Apache2**

|     |     |
| --- | --- |
| 1<br>2<br>3 | service apache2 stop<br># 尝试使用上面这个关闭，如果没效果或者提示什么错误无法关闭，那就用下面这个强行关闭进程。<br>kill-9$(ps-ef\|grep"apache2"\|grep-v"grep"\|awk'{print $2}') |

**取消开机自启动**

|     |     |
| --- | --- |
| 1<br>2 | # 以下代码仅限 Debian/Ubuntu 系统 #<br>update-rc.d-fapache2 remove |

**卸载 Apache2**

|     |     |
| --- | --- |
| 1<br>2 | # 以下代码仅限 Debian/Ubuntu 系统 #<br>apt-get remove--purge apache2 |

关闭 Apache2后，就可以尝试启动 Caddy ，并试试能不能打开网页。

|     |     |
| --- | --- |
| 1   | service caddy start |

No related posts.
Measure
Measure
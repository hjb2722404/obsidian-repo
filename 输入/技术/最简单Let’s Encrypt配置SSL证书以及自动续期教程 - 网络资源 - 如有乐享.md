最简单Let’s Encrypt配置SSL证书以及自动续期教程 - 网络资源 - 如有乐享

# 最简单Let’s Encrypt配置SSL证书以及自动续期教程

![699c2d0fgy1fcq6dhh3woj20sp0can5n](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107133953.jpg)

本文推荐的方式，应该是目前最简单的方式了！
Let’s Encrypt应该一款免费开源的SSL生成程序。操作相对比较容易，使用门槛不高。
网上有很多Let’s Encrypt部署方法，有兴趣可以去Google一下。
本文介绍的 **Certbot **来生成HTTPS证书。
*以下推荐几款免费的SSL*
>>> [推荐几款非常不错的免费SSL](http://51.ruyo.net/p/2053.html)

## 官网

[https://certbot.eff.org/](http://51.ruyo.net/p/tag/certbot/)
[https://github.com/certbot/certbot](http://51.ruyo.net/p/tag/certbot/)

## 部署

本文演示以Centos为例！官方提供多种系统的配置说明，可以自行查阅。

![699c2d0fly1fcq6ojr088j20mr0fowfs](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107133957.jpg)

### **安装certbot**

|     |     |
| --- | --- |
| 1<br>2<br>3 | wget https://dl.eff.org/certbot-auto<br>chmoda+xcertbot-auto<br>./certbot-auto |

如果出现错误信息：

Failed to find apachectl in PATH: /usr/local/nginx/sbin:/usr/local/php/bin:/usr/local/mysql/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

请执行以下代码安装即可

|     |     |
| --- | --- |
| 1<br>2 | yum-yinstall httpd httpd-devel |

### **解析域名**

生成证书前，需要将域名全部解析到服务器上，否则生成失败。

### **生成域名证书**

下面的代码是生成 somecolor.cc / www.somecolor.cc / api.somecolor.cc
如果你要生成更多域名，直接后面再加 -d xxxxx.xx  即可啦。

|     |     |
| --- | --- |
| 1   | ./certbot-auto certonly--standalone-dsomecolor.cc-dwww.somecolor.cc-dapi.somecolor.cc |

命令执行过程中
需要填写你的邮箱 ，输入邮箱回车。
同意TOS条款 ，输入 Y 表示同意，回车。
还有一个同意分享邮箱，输入Y 回车。

![699c2d0fly1fcq7meqp8hj20mv0dc0tp](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107134002.jpg)

生成成功，可到目录 /etc/letsencrypt/live/  查看我们的证书了！

### **配置证书**

我们以Nginx为例！
可参考以下配置哦~~

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31<br>32<br>33<br>34<br>35 | server<br>{<br>listen443;<br>server_name api.somecolor.cc;<br>index index.html index.htm index.php;<br>root/home/wwwroot/api.cnsecer.com/;<br>ssl on;<br>ssl_certificate/etc/letsencrypt/live/somecolor.cc/fullchain.pem;<br>ssl_certificate_key/etc/letsencrypt/live/somecolor.cc/privkey.pem;<br>ssl_protocols  TLSv1 TLSv1.1TLSv1.2;#可不要<br>ssl_ciphers   ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:ECDHE-RSA-DES-CBC3-SHA:ECDHE-ECDSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA;#可不要<br>ssl_prefer_server_ciphers  on;#可不要<br>ssl_session_cache    shared:SSL:10m;#可不要<br>ssl_session_timeout24h;#可不要<br>keepalive_timeout300s;#可不要<br>location~.*\.(gif\|jpg\|jpeg\|png\|bmp\|swf)$<br>{<br>expires30d;<br>}<br>location~.*\.(js\|css)?$<br>{<br>expires12h;<br>}<br>location~/\.<br>{<br>deny all;<br>}<br>access_log/home/wwwlogs/somecolor.cc.log;<br>} |

### **自动续期**

首先我们需要将可执行文件 移动一个公共目录。
如果要放到root目录下，只要处理好权限问题也是可以的。
手动延期

|     |     |
| --- | --- |
| 1   | ./certbot-auto renew--dry-run |

利用Cron自动延期
注意路径问题。

|     |     |
| --- | --- |
| 1   | ./certbot-auto renew--quiet |

No related posts.
Measure
Measure
CentOS一键安装shadowsocks脚本 | 小z博客

# [CentOS一键安装shadowsocks脚本](https://www.xiaoz.me/archives/5643)

作者: 小z  分类: [Linux](https://www.xiaoz.me/archives/category/notes/linux)  发布时间: 2015-02-07 09:30  *ė*浏览 9,129 次  *6*[27条评论](https://www.xiaoz.me/archives/5643#comments)

本站为您推荐（香港平价主机）：[老薛主机](http://www.xiaoz.me/laoxue) | [恒创主机](http://www.xiaoz.me/url/?id=6)

Shadowsocks是一个基于python的轻量级socks代理软件,可以在任何系统简单的实现访问被屏蔽的网站。网友也常称为科学上网，简称ss,在此分享与记录CentOS一键安装shadowsocks脚本。

### 一、使用root用户登录，运行以下命令：

|     |     |
| --- | --- |
| 1<br>2<br>3 | wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh<br>chmod +x shadowsocks.sh<br>./shadowsocks.sh 2>&1 \| tee shadowsocks.log |

### 二、安装完成后，脚本提示如下：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10 | Congratulations, shadowsocks install completed!<br>Your Server IP:your_server_ip<br>Your Server Port:8989<br>Your Password:your_password<br>Your Local IP:127.0.0.1<br>Your Local Port:1080<br>Your Encryption Method:aes-256-cfb<br>Welcome to visit:http://teddysun.com/342.html<br>Enjoy it! |

### 三、卸载方法

|     |     |
| --- | --- |
| 1   | ./shadowsocks.sh uninstall |

### 四、配置文件

配置文件路径为：/etc/shadowsocks.json
单用户配置：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10 | {<br>"server":"your_server_ip",<br>"server_port":8989,<br>"local_address":"127.0.0.1",<br>"local_port":1080,<br>"password":"yourpassword",<br>"timeout":300,<br>"method":"aes-256-cfb",<br>"fast_open": false<br>} |

多用户配置：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15 | {<br>"server":"your_server_ip",<br>"local_address": "127.0.0.1",<br>"local_port":1080,<br>"port_password":{<br>"8989":"password0",<br>"9001":"password1",<br>"9002":"password2",<br>"9003":"password3",<br>"9004":"password4"<br>},<br>"timeout":300,<br>"method":"aes-256-cfb",<br>"fast_open": false<br>} |

### 五、相关使用命令

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | 启动：/etc/init.d/shadowsocks start<br>停止：/etc/init.d/shadowsocks stop<br>重启：/etc/init.d/shadowsocks restart<br>状态：/etc/init.d/shadowsocks status |

**其它说明：**默认配置服务器端口：8989客户端端口：1080，密码：自己设定（如不设定，默认为teddysun.com），多用户配置后需要重启shadowsocks服务。Windows客户端使用和下载请查看：[Windows使用Shadowsocks科学上网](http://www.xiaoz.me/archives/5616)，推荐使用[Vultr VPS](http://www.xiaoz.me/archives/6390)

**> 原文来自：**> [> CentOS下shadowsocks一键安装脚本](http://teddysun.com/342.html)
> 代为安装VPN服务，收费30元，有需要的请直接添加QQ：337003006

本文出自 小z博客，转载时请注明出处及相应链接。
本文永久链接: https://www.xiaoz.me/archives/5643

分享至：[![Weibo_Buttons.png](CentOS一键安装shadowsocks脚本%20_%20小z博客.md#)

博主QQ：337003006    站长交流群：147687134（期待您的加入）

*0*[shadowsocks](https://www.xiaoz.me/archives/tag/shadowsocks), [科学上网](https://www.xiaoz.me/archives/tag/%e7%a7%91%e5%ad%a6%e4%b8%8a%e7%bd%91)

[![老薛主机](../_resources/0f47d470f9114d0013791af6536fc100.jpg)](http://www.xiaoz.me/url/?id=5)
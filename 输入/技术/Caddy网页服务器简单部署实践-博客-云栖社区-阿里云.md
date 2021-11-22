Caddy网页服务器简单部署实践-博客-云栖社区-阿里云

Caddy Server是一个用golang写的优秀web server，国内用户相对偏少，但我非常喜欢这个东西，所以来做个简易的手册。
它有许多nginx和apache没有的功能，不仅具有特色而且非常实用，比如简洁的conf，http/2，markdown渲染等等
要说它的缺点，就是效率不如前两者。
本文会以下几块方面来介绍此服务器
caddy安装及配置文件基本写法
基本组成模块
传统php+mysql建站
caddy特色markdown建站
反向代理引入更多后端系统

# 1:Caddy的安装及配置文件基本写法

caddy的安装，就是从caddy的官网下载：https://caddyserver.com/download  想要什么模块就尽情点上吧2333

如果没有官网列表上设备或是有特殊需求的同学，可以参考无闻菊苣的文章自行构建可执行文件：https://wuwen.org/2015/11/13/caddy-in-action.html

PS:解压时请把压缩包放在一个新文件夹后再解压
然后执行   ./caddy   这时候访问 localhost:2015 就可以测试是否运行起来了，至于持久化运行，有多种方法实现，
candyserver下载下来的安装包里已经包含各系统启动文件
博主使用的是使用screen来守护，当然还有更专业的软件实现，比如supservisor

caddy的conf写法有好多种，首先你要在caddy的可执行文件的同目录创建一个名叫 Caddyfile 的文件，或者在启动时加入路径 ./caddy -conf="/path/to/Caddyfile"

接下来是几种caddy的conf的写法，简直辣眼睛
本地访问80：
`:80`
单网站：（它会帮您签好let's encrypt证书并且强制定向到https）
example.com
root /var/www/html
`//更多模块`
多网站：
example.com {
gzip
root /var/www/htm/
//更多模块
}

# 2:常用基本组成模块

均写入到conf站点配置中
1.log日志
log  /var/www/log/example.log
2.目录访问
browse
3.gzip压缩
gzip
4.自主ssl证书
tls  /path/ssl/example.com.crt /path/ssl/example.com.key
5.git拉取功能(3600秒为间隔时间)
git  https://github.com/user/project.git /var/www/html/git/  {
interval  3600
}
6.访问口令认证（用户emiria，密码abc123）
basicauth  / emiria abc123
7.cors跨域(下载时记得勾上)
cors  / {
origin  https://alleysakura.com
origin http://alleysakura.pw https://alleysakura.pw
methods POST,PUT
allow_credentials  false
max_age  3600
allowed_headers X-Custom-Header,X-Foobar
exposed_headers X-Something-Special,SomethingElse
}
8.IP屏蔽(下载时记得勾上)
ipfilter  / {
rule  block
ip  212.10.15.0-255  202.10.15.0-10  59.43.247.103
blockpage /var/www/html/403.html
}
9.跳转功能(目录重写功能也类似)
redir http://example.com{url}
而且不像nginx进行www重定向那么麻烦，把域名原域名（不限协议）写上，大括号里加上这个就可以，简直太赞了
10.自定义错误页面
errors {
404  404.html
500  /var/www/html/500.html
}

# 3:传统php+mysql建站

包管理器安装mysql+php，然后添加
fastcgi  /  127.0.0.1:9000  php

# 4:caddy特色markdown建站

具体官方wiki上有示例，功能非常强大，这是一个博主弄的示例站  [https://caddy.rd.md](https://caddy.rd.md/?spm=a2c4e.11153940.blogcont59006.8.5caf7d3blegCjv)

# 5:反向代理引入更多后端系统

引入反向代理，只需一行
proxy  / localhost:4000
负载均衡也是类似配置的23333
proxy  /  10.10.201.222:80  10.10.201.221:80  {
policy  round_robin
}
当然caddyserver还有许多不常用的，但是非常好玩的组件，大家可以去官网看看文档，博主也将继续探索~（> y <)
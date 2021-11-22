CentOS6.4 安装MongoDB - 缤纷世界 - 博客园

# [CentOS6.4 安装MongoDB](http://www.cnblogs.com/kgdxpr/p/3519352.html)

1、下载MongoDB（64位）
http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.4.9.tgz
或
http://pan.baidu.com/s/1mgyRB8c
2、安装MongoDB（安装到/usr/local）
[![复制代码](CentOS6.4%20安装MongoDB%20-%20缤纷世界%20-%20博客园.md#)
tar zxvf mongodb-linux-x86_64-2.4.9.tgz
mv mongodb-linux-x86_64-2.4.9 mongodb
cd mongodb
mkdir db
mkdir logs
cd bin
vi mongodb.conf
[![复制代码](CentOS6.4%20安装MongoDB%20-%20缤纷世界%20-%20博客园.md#)
dbpath=/usr/local/mongodb/db
logpath=/usr/local/mongodb/logs/mongodb.log
port=27017fork=truenohttpinterface=true
3、重新绑定mongodb的配置文件地址和访问IP

/usr/local/mongodb/bin/mongod --bind_ip localhost -f /usr/local/mongodb/bin/mongodb.conf

4、开机自动启动mongodb
vi /etc/rc.d/rc.local
/usr/local/mongodb/bin/mongod --config /usr/local/mongodb/bin/mongodb.conf
5、重启一下系统测试下能不能自启
#进入mongodb的shell模式 /usr/local/mongodb/bin/mongo
#查看数据库列表
show dbs
#当前db版本
db.version();

分类: [Linux](http://www.cnblogs.com/kgdxpr/category/376237.html)

[好文要顶](CentOS6.4%20安装MongoDB%20-%20缤纷世界%20-%20博客园.md#)[关注我](CentOS6.4%20安装MongoDB%20-%20缤纷世界%20-%20博客园.md#)[收藏该文](CentOS6.4%20安装MongoDB%20-%20缤纷世界%20-%20博客园.md#)[![icon_weibo_24.png](CentOS6.4%20安装MongoDB%20-%20缤纷世界%20-%20博客园.md#)[![wechat.png](CentOS6.4%20安装MongoDB%20-%20缤纷世界%20-%20博客园.md#)

[![sample_face.gif](../_resources/373280fde0d7ed152a0f7f06df3f3ad4.gif)](http://home.cnblogs.com/u/kgdxpr/)

[缤纷世界](http://home.cnblogs.com/u/kgdxpr/)
[关注 - 16](http://home.cnblogs.com/u/kgdxpr/followees)
[粉丝 - 18](http://home.cnblogs.com/u/kgdxpr/followers)

 [+加关注](CentOS6.4%20安装MongoDB%20-%20缤纷世界%20-%20博客园.md#)

 1
0

(请您对文章做出评价)

[«](http://www.cnblogs.com/kgdxpr/p/3514099.html) 上一篇：[yum安装高版本mysql(5.5)](http://www.cnblogs.com/kgdxpr/p/3514099.html)

[»](http://www.cnblogs.com/kgdxpr/p/3520136.html) 下一篇：[Java 日期格式化工具类](http://www.cnblogs.com/kgdxpr/p/3520136.html)

posted @ 2014-01-14 16:51  [缤纷世界](http://www.cnblogs.com/kgdxpr/) 阅读(11567) 评论(0) [编辑](http://i.cnblogs.com/EditPosts.aspx?postid=3519352)  [收藏](http://www.cnblogs.com/kgdxpr/p/3519352.html#)
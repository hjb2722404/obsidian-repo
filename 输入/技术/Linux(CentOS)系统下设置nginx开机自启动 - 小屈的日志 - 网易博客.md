Linux(CentOS)系统下设置nginx开机自启动 - 小屈的日志 - 网易博客

### Linux(CentOS)系统下设置nginx开机自启动

  2013-02-27 15:48:11|  分类： [默认分类](http://blog.163.com/qsc0624@126/blog/#m=0&t=1&c=fks_087068081080082067084081085095085082081064086082086068087) |  标签：[nginx](http://blog.163.com/qsc0624@126/blog/#m=0&t=3&c=nginx)  [自启动](http://blog.163.com/qsc0624@126/blog/#m=0&t=3&c=自启动)  [开机](http://blog.163.com/qsc0624@126/blog/#m=0&t=3&c=开机)  [linux服务器](http://blog.163.com/qsc0624@126/blog/#m=0&t=3&c=linux服务器)    |举报 |字号 [订阅]() .

 ![](../_resources/76aa36c26dc819ea34f91f742c558593.png)

用微信  “扫一扫”

将文章分享到朋友圈。

 [ ]()

 ![](../_resources/76aa36c26dc819ea34f91f742c558593.png)

用易信  “扫一扫”

将文章分享到朋友圈。

 [ ]()

 [  下载LOFTER](http://www.lofter.com/app?act=qbbkrzydb_20150408_01)  [我的照片书  |](http://yxp.163.com/)

Nginx 是一个很强大的高性能Web和[反向代理](http://baike.baidu.com/view/1165595.htm)服务器。下面介绍在linux下安装后，如何设置开机自启动。

首先，在linux系统的/etc/init.d/目录下创建nginx文件，使用如下命令：
vi /etc/init.d/nginx

在脚本中添加如下命令：

*********************************************************************************************************************************

#!/bin/bash

# nginx Startup script for the Nginx HTTP Server

# it is v.0.0.2 version.

# chkconfig: - 85 15

# description: Nginx is a high-performance web and proxy server.

#            It has a lot of features, but it's not for everyone.

# processname: nginx

**# pidfile: /var/run/nginx.pid**
****
**# config: /usr/local/nginx/conf/nginx.conf**
****
**nginxd=/usr/local/nginx/sbin/nginx**
****
**nginx_config=/usr/local/nginx/conf/nginx.conf**
****
**nginx_pid=/var/run/nginx.pid**
RETVAL=0
prog="nginx"

# Source function library.

. /etc/rc.d/init.d/functions

# Source networking configuration.

. /etc/sysconfig/network

# Check that networking is up.

[ ${NETWORKING} = "no" ] && exit 0
[ -x $nginxd ] || exit 0

# Start nginx daemons functions.

start() {
if [ -e $nginx_pid ];then
   echo "nginx already running...."
   exit 1
fi
   echo -n $"Starting $prog: "
   daemon $nginxd -c ${nginx_config}
  RETVAL=$?
  echo
   [ $RETVAL = 0 ] && touch /var/lock/subsys/nginx
   return $RETVAL
}

# Stop nginx daemons functions.

stop() {
       echo -n $"Stopping $prog: "
       killproc $nginxd
       RETVAL=$?
       echo
       [ $RETVAL = 0 ] && rm -f /var/lock/subsys/nginx /var/run/nginx.pid
}

# reload nginx service functions.

reload() {
    echo -n $"Reloading $prog: "
    #kill -HUP `cat ${nginx_pid}`
    killproc $nginxd -HUP
   RETVAL=$?
   echo
}

# See how we were called.

case "$1" in
start)
       start
       ;;
stop)
       stop
       ;;
reload)
       reload
       ;;
restart)
       stop
       start
       ;;
status)
       status $prog
       RETVAL=$?
       ;;
*)
       echo $"Usage: $prog {start|stop|restart|reload|status|help}"
       exit 1
esac
exit $RETVAL

*********************************************************************************************************************************

注意红色加粗部分，需要将路径改为自己机器的相应路径。
接着，设置文件的访问权限：

chmod a+x /etc/init.d/nginx                                                         (a+x参数表示 ==> all user can execute  所有用户可执行)

最后将ngix加入到rc.local文件中，这样开机的时候nginx就默认启动了
vi /etc/rc.local
添加
/etc/init.d/nginx start
保存并退出
下次重启就会生效，实现nginx的自启动。

 阅读(23875)|  评论(1)

 ![](../_resources/76aa36c26dc819ea34f91f742c558593.png)

用微信  “扫一扫”

将文章分享到朋友圈。

 [ ]()

 ![](../_resources/76aa36c26dc819ea34f91f742c558593.png)

用易信  “扫一扫”

将文章分享到朋友圈。

 [ ]()

 喜欢 推荐 转载

 .
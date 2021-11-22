CentOs Server环境搭建

# CentOs Server环境搭建

环境搭建
centOS

# CentOs Server环境搭建

标签（空格分隔）： 环境搭建 centos

* * *

	 引言：本文档是在全新的CentOs系统搭建JAVA工程相关的服务器环境的指导文档，阅读本文档请使用markdown阅读器，或者在IDE开发工具中安装markdown插件

* * *

##步骤索引：
1.安装JDK
2.安装Tomcat
3.安装Nginx
4.安装mysql
5.安装redis
#正文
##安装JDK
###检查CentOs是否默认安装了openjdk软件，可以使用以下命令中的任意命令，最好都试一下：

	#rpm -qa |grep java

	#rpm -qa |grep jdk

	#rpm -qa |grep gcj

执行命令后,如果没有任何输出，则说明该系统没有安装jdk，直接跳到第2步，相反，如果输出类似下面的结果：

	java-1.6.0-openjdk-1.6.0.35-1.13.7.1.el6_6.x86_64

	java-1.6.0-openjdk-1.7.0.35-2.3.7.1.el6_6.x86_64

则说明该系统已经安装了openjdk,我们需要卸载它，然后安装sun公司的jdk.卸载命令：

	#rpm –e  jdk相关文件名
	//(普通删除命令，删除特定的包，如果遇到依赖，则无法删除)

	#rpm -e –nodeps  jdk相关文件名

	//(强制删除命令，忽略依赖，删除特定的包。如果使用上面命令删除时，提示有依赖的其它文件，则用该命令可以对其进行强力删除)

> 注意：这里的jdk相关文件名指的是上个步骤中用查询命令 查出来的jdk的相关文件的文件名。
例如：

	 #rpm -e java-1.6.0-openjdk-1.6.0.35-1.13.7.1.el6_6.x86_64

如果无法删除，可以尝试以下命令：

	    #yum -y remove java jdk相关文件名

执行以上命令后，用find命令查看是否还有文件残留：

	#find / -name jdk
	#find / -name java
	#find / -name jre
	#find / -name gcj

查询无果，说明jdk已经删除干净。
若查询出来还有参与目录，可以用# rm -rf 目录，将残余目录一个一个删除掉。
至此jdk的删除工作已完成。
###下载sun公司的jdk包并安装
首先查询当前系统的位数，以确定要下载什么位数的jdk：

	# uname -r

会看到类似以下输出：

	2.6.32-358.el6.x86_64

我们可以看到该系统是64位，那我们就去搜索下载64位的jdk，这里我们选择下载1.6版本的。下载下来的文件名为：
> jdk-6u45-linux-x64.bin
我们把下载下来的文件利用ftp工具上传至服务器的usr/java目录中（java目录是新建的）。

[最新版jdk下载链接](http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase6-419409.html#jdk-6u45-oth-JPR)

然后在终端工具切换到java目录下，修改文件权限：

	#chmod u+x jdk-6u45-linux-x64.bin

执行安装：

	#./jdk-6u45-linux-x64.bin

如果可以查看到java版本号，说明安装成功：

	#java -version

3、配置环境变量

	#vi /etc/profile

在最后加上

	JAVA_HOME=/usr/java/jdk1.6.0_45 //注意版本号为你刚安装的

	PATH=$PATH:$JAVA_HOME/bin

	CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

	export JAVA_HOME

	export PATH

	export CLASSPATH

执行：wq保存退出，并更新配置文件：

	#source /etc/profile

至此，jdk安装成功。
##安装Tomcat
###下载tomcat
[最新版tomcat下载链接](http://tomcat.apache.org/download-70.cgi)
###将下载的文件（apache-tomcat-7.0.61.tar.gz）用ftp工具上传至服务器usr/local目录下
###终端切换到local目录下，解压缩tomcat：

	#tar -xzvf apache-tomcat-7.0.61.tar.gz

###将解压出的文件复制到usr/tomcat目录：

	#cp -R apache-tomcat-7.0.61 /usr/local/tomcat

###启动tomcat

	#/usr/local/tomcat/bin/startup.sh

###关闭防火墙

	#/etc/init.d/iptables stop

至此，tomcat安装配置成功，
###开启apachetomcat及把apache tomcat写入开机运行队列：
（1、apache tomcat 的启动命令：

	#/usr/local/tomcat/bin/startup.sh

（2apache tomcat的停止命令：

	#/usr/local/tomcat/bin/shutdown.sh

（3、apache tomcat开机启动设置：

	#echo "/usr/local/tomcat/bin/startup.sh" >> /etc/rc.local

3、配置TOMCAT的环境变量
编辑

	#vi ~/.bash_profile

加入 tomcat 环境参数

	TOMCAT_HOME=/usr/local/tomcat
	export PATH JAVA_HOME CLASSPATH TOMCAT_HOME

保存退出，然后执行

	#source ~/.bash_profile

让环境变量生效
现在开启TOMCAT服务：

	#/usr/local/tomcat/bin/startup.sh

然后打入

	#netstat –tnl

进行监听，如果能看到8080和8009两个，表示tomcat已经正常启动.
下面进行访问测试，看能否进入网页;打入：http://serverip:8080 ，可以看到网页的话说明tomcat已经安装成功。
##安装Nginx
###下载Nginx安装包
[最新版Nginx下载链接](http://nginx.org/en/download.html)
###在安装nginx前，需要确保系统安装了g++、gcc、openssl-devel、pcre-devel和zlib-devel软件。安装必须软件：

	#yum install gcc-c++
	#yum -y install zlib zlib-devel openssl openssl--devel pcre pcre-devel

###将安装包文件上传到/usr/local中执行以下操作：

	[root@admin local]# cd /usr/local
	[root@admin local]# tar -zxv -f nginx-1.2.6.tar.gz
	[root@admin local]# rm -rf nginx-1.2.6.tar.gz
	[root@admin local]# mv nginx-1.2.6 nginx
	[root@admin local]# cd /usr/local/nginx
	[root@admin nginx]# ./configure --prefix=/usr/local/nginx
	[root@admin nginx]# make
	[root@admin nginx]# make install

###启动

	#方法1
	[root@admin nginx-1.2.6]# /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
	#方法2
	[root@admin nginx-1.2.6]# cd /usr/local/nginx/sbin
	[root@admin sbin]# ./nginx

PS:启动时可能会报如下错误：

> nginx: [alert] could not open error log file: open() "/usr/local/nginx/logs/error.log" failed (2: No such file or directory)

> 2015/05/14 15:57:14 [emerg] 16430#0: open() "/usr/local/nginx/logs/access.log" failed (2: No such file or directory)

在nginx文件夹下新建logs文件夹，再次启动就可以了。
###测试

	#测试端口
	#netstat –na|grep 80
	#浏览器中测试
	http://ip:80

##安装Mysql
###卸载原有mysql

	# rpm -qa | grep mysql　　// 这个命令就会查看该操作系统上是否已经安装了mysql数据库

有的话，我们就通过 rpm -e 命令 或者 rpm -e --nodeps 命令来卸载掉

	# rpm -e mysql　　// 普通删除模式
	# rpm -e --nodeps mysql　　// 强力删除模式，如果使用上面命令删除时，提示有依赖的其它文件，则用该命令可以对其进行强力删除

在删除完以后我们可以通过 rpm -qa | grep mysql 命令来查看mysql是否已经卸载成功！！
###通过Yum安装mysql
首先我们可以输入 yum list | grep mysql 命令来查看yum上提供的mysql数据库可下载的版本：

	# yum list | grep mysql

然后我们可以通过输入 yum install -y mysql-server mysql mysql-devel 命令将mysql mysql-server mysql-devel都安装好(注意:安装mysql时我们并不是安装了mysql客户端就相当于安装好了mysql数据库了，我们还需要安装mysql-server服务端才行)

	# yum install -y mysql-server mysql mysql-devel

###mysql数据库的初始化及相关配置
我们通过输入 service mysqld start 命令就可以启动我们的mysql服务

	# service mysqld start

我们在使用mysql数据库时，都得首先启动mysqld服务，我们可以 通过 chkconfig --list | grep mysqld 命令来查看mysql服务是不是开机自动启动，如：

	#chkconfig --list | grep mysqld

我们发现mysqld服务并没有开机自动启动，我们当然可以通过 chkconfig mysqld on 命令来将其设置成开机启动，这样就不用每次都去手动启动了

	#chkconfig mysqld on

mysql数据库安装完以后只会有一个root管理员账号，但是此时的root账号还并没有为其设置密码,所以我们可以通过命令来给我们的root账号设置密码:

	# mysqladmin -u root password 'njxuqiangmysql'　　// 通过该命令给root账号设置密码为 njxuqiangmysql

此时我们就可以通过 mysql -u root -p 命令来登录我们的mysql数据库了

	#mysql -u root -p

> Enter password:
> Welcome to the MySQL monitor. Commands end with ; or \g.
> Your MySQL connection id is 5
> Server version: 5.1.73 Source distribution
> Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.
> Oracle is a registered trademark of Oracle Corporation and/or its
> affiliates. Other names may be trademarks of their respective
> owners.

> Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

> mysql>
##安装redis

	wget http://download.redis.io/redis-stable.tar.gz

	tar xvzf redis-stable.tar.gz

	cd redis-stable

	make

在make成功以后，需要make test。在make test出现异常。
异常一：

	couldn't execute "tclsh8.5": no such file or directory

异常原因：没有安装tcl
解决方案：

	#yum install -y tcl。

在make成功以后，会在src目录下多出一些可执行文件：redis-server，redis-cli等等。
方便期间用cp命令复制到usr目录下运行。

	#cp redis-server /usr/local/bin/

	cp redis-cli /usr/local/bin/

然后新建目录，存放配置文件

	#mkdir /etc/redis

	#mkdir /var/redis

	#mkdir /var/redis/log

	#mkdir /var/redis/run

	#mkdir /var/redis/6379

在redis解压根目录中找到配置文件模板，复制到如下位置。

	#cp redis.conf /etc/redis/6379.conf

通过vim命令修改

	daemonize yes

	pidfile /var/redis/run/redis_6379.pid

	logfile /var/redis/log/redis_6379.log

	dir /var/redis/6379

最后运行redis：

	 #redis-server /etc/redis/6379.conf

[markdownFile.md](../_resources/6a852044a90ba4eb4809e78a9c617bd6.bin)
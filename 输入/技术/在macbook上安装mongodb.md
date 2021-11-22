在macbook上安装mongodb

## 在Macbook上安装mongodb

1. 在当前用户根目录下创建mongo目录：

	$ cd /Users/username
	$ mkdir mongo

​

2. 登录[mongodb官网](https://www.mongodb.org/)，下载[mongoldb for mac](https://www.mongodb.org/dr/fastdl.mongodb.org/osx/mongodb-osx-x86_64-3.2.4.tgz/download)到mongo目录

3. 终端切换到mongo目录下，解压下载的tgz文件

	$ tar -zxvf mongodb-osx-x86_64-3.2.4.tgz

4. 创建mongodb目录：

	$ mkdir mongodb

5. 移动解压后的mongodb文件到mongodb目录：

	$ cp mongodb-osx-x86_64-3.2.4/ mongodb

6. 在mongo目录下创建数据存放目录：

	$ mkdir data && mkdir data/db

7. 切换到mongoldb的bin目录，启动mongod服务，并设置数据存放路径：

	$ cd mongodb/bin
	$ ./mongod --dbpath=/Users/username/mongo/data/db/

8. 完成！
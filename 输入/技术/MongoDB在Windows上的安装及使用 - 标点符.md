MongoDB在Windows上的安装及使用 - 标点符

# [MongoDB在Windows上的安装及使用](https://www.biaodianfu.com/mongodb-windows.html)

MongoDB作为非关系型数据库的代表，非常适合存储一些非结构化数据，本着以了解及研究为目的，在Windows机器上尝试了安装，发现中间还是有许多可以分享的点。

## MongoDB的安装

本以为安装是一件非常简单的事，但执行过程中却卡在了下载安装包。在官方的下载中心：https://www.mongodb.com/download-center 选择对应版本下载时，下载页面一直返回404。没有办法找了另外一个下载地址：https://www.mongodb.org/dl/win32/x86_64-2008plus-ssl

下载完成后按照提示进行安装，但是安装完毕后什么事情都没有发生，MongoDB没有默认启动、没有桌面快捷方式、Window菜单中也没有新增任何内容，一度让你以为没有安装成功。

## MongoDB的启动配置

安装完成MongoDB以后，如需使用，需要自己进行启动，常见的方式是注册为Windows服务。主要流程如下：
**1、添加环境变量**（主要方面执行mongodb命令，不用每次都切换到文件夹下执行，此步骤可省略）
变量名：MONGODB_HOME，值：C:\Program Files\MongoDB\Server\3.2（具体路径根据你的安装路径确定）
变量名：PATH，追加内容：%MONGODB_HOME%\bin;
完成后就可以在命令行直接执行MongoDB相关程序了。
**2、安装Windows服务**
为了方便的开启关闭MongoDB，需要注册Windows服务，方法比较简单，如下：

|     |     |
| --- | --- |
| 1   | mongod  --dbpath  "C:\MongoDB\data"  --logpath  "C:\MongoDB\log\mongodb.log"  --install |

上述指令调用了C:\Program Files\MongoDB\Server\3.2\bin目录下的mongod.exe文件，并指定了数据库文件存放地址和日志文件存放地址，mongod的主要参数有：（可以根据自己的情况进行设置）

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31<br>32<br>33<br>34<br>35<br>36<br>37<br>38<br>39<br>40<br>41<br>42<br>43<br>44<br>45<br>46<br>47<br>48<br>49<br>50<br>51<br>52<br>53<br>54<br>55<br>56<br>57<br>58<br>59 | ##基本配置<br>--quiet# 安静输出<br>--port arg# 指定服务端口号，默认端口27017<br>--bind_ip arg# 绑定服务IP，若绑定127.0.0.1，则只能本机访问，不指定默认本地所有IP<br>--logpath arg# 指定MongoDB日志文件，注意是指定文件不是目录<br>--logappend# 使用追加的方式写日志<br>--pidfilepath arg# PID File 的完整路径，如果没有设置，则没有PID文件<br>--keyFile arg# 集群的私钥的完整路径，只对于Replica Set 架构有效<br>--unixSocketPrefix arg# UNIX域套接字替代目录,(默认为 /tmp)<br>--fork# 以守护进程的方式运行MongoDB，创建服务器进程<br>--auth# 启用验证<br>--cpu# 定期显示CPU的CPU利用率和iowait<br>--dbpath arg# 指定数据库路径<br>--diaglog arg# diaglog选项 0=off 1=W 2=R 3=both 7=W+some reads<br>--directoryperdb# 设置每个数据库将被保存在一个单独的目录<br>--journal# 启用日志选项，MongoDB的数据操作将会写入到journal文件夹的文件里<br>--journalOptions arg# 启用日志诊断选项<br>--ipv6# 启用IPv6选项<br>--jsonp# 允许JSONP形式通过HTTP访问（有安全影响）<br>--maxConns arg# 最大同时连接数 默认2000<br>--noauth# 不启用验证<br>--nohttpinterface# 关闭http接口，默认关闭27018端口访问<br>--noprealloc# 禁用数据文件预分配(往往影响性能)<br>--noscripting# 禁用脚本引擎<br>--notablescan# 不允许表扫描<br>--nounixsocket# 禁用Unix套接字监听<br>--nssize arg  (=16)# 设置信数据库.ns文件大小(MB)<br>--objcheck# 在收到客户数据,检查的有效性，<br>--profile arg# 档案参数 0=off 1=slow, 2=all<br>--quota# 限制每个数据库的文件数，设置默认为8<br>--quotaFiles arg# number of files allower per db, requires --quota<br>--rest# 开启简单的rest API<br>--repair# 修复所有数据库run repair on all dbs<br>--repairpath arg# 修复库生成的文件的目录,默认为目录名称dbpath<br>--slowms arg  (=100)# value of slow for profile and console log<br>--smallfiles# 使用较小的默认文件<br>--syncdelay arg  (=60)# 数据写入磁盘的时间秒数(0=never,不推荐)<br>--sysinfo# 打印一些诊断系统信息<br>--upgrade# 如果需要升级数据库<br>##Replicaton 参数<br>--fastsync# 从一个dbpath里启用从库复制服务，该dbpath的数据库是主库的快照，可用于快速启用同步<br>--autoresync# 如果从库与主库同步数据差得多，自动重新同步，<br>--oplogSize arg# 设置oplog的大小(MB)<br>##主/从参数<br>--master# 主库模式<br>--slave# 从库模式<br>--source arg# 从库 端口号<br>--only arg# 指定单一的数据库复制<br>--slavedelay arg# 设置从库同步主库的延迟时间<br>## Replica set(副本集)选项：<br>--replSet arg# 设置副本集名称<br>##Sharding(分片)选项<br>--configsvr# 声明这是一个集群的config服务,默认端口27019，默认目录/data/configdb<br>--shardsvr# 声明这是一个集群的分片,默认端口27018<br>--noMoveParanoia# 关闭偏执为moveChunk数据保存 |

所有参数都可以写入 mongod.conf 配置文档里。启动时只需要添加：mongod  --config  /path/to/mongod.conf
其他相关指令：

|     |     |
| --- | --- |
| 1<br>2<br>3 | net start MongoDB  #启动 MongoDB 服务<br>net stop MongoDB  #停止 MongoDB 服务<br>mongod  --remove  #删除 MongoDB 服务 |

另外你也可以在Windows服务管理页面进行启动或停止操作。

## MongoDB的使用

- Robomongo：https://robomongo.org/
- Mongochef：[http://3t.io/mongochef/](http://3t.io/mongochef/#mongochef-download-compare)
- MongoHub：https://github.com/bububa/MongoHub
- RockMongo：http://rockmongo.com/
- mongoVUE：[http://www.mongovue.com/](http://www.mongovue.com/downloads/)
- MongoBooster：https://mongobooster.com/

更多参考资料：https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/

** 码字很辛苦，转载请注明来自**[标点符](https://www.biaodianfu.com/)**的[《MongoDB在Windows上的安装及使用》](https://www.biaodianfu.com/mongodb-windows.html)

 ** 2016-11-24   ** [程序开发](https://www.biaodianfu.com/category/programming)  **[NoSQL](https://www.biaodianfu.com/tag/nosql)
linux svn迁移备份的三种方法 | 爱积累爱分享

201306月26

## [linux svn迁移备份的三种方法](http://www.iitshare.com/linux-svn-migration.html)

[iitshare](http://www.iitshare.com/author/iitshare)  分类：[Linux](http://www.iitshare.com/category/linux),[项目实施](http://www.iitshare.com/category/project-implementation) |   标签：[svn](http://www.iitshare.com/tag/svn), [svn版本库迁移](http://www.iitshare.com/tag/svn%e7%89%88%e6%9c%ac%e5%ba%93%e8%bf%81%e7%a7%bb), [网站运营](http://www.iitshare.com/tag/%e7%bd%91%e7%ab%99%e8%bf%90%e8%90%a5), [项目实施](http://www.iitshare.com/tag/%e9%a1%b9%e7%9b%ae%e5%ae%9e%e6%96%bd) |  *[*0* Comments](http://www.iitshare.com/linux-svn-migration.html#respond)* [发表评论](http://www.iitshare.com/linux-svn-migration.html#respond)

#### svn备份方式对比分析

一般采用三种方式：
1、svnadmin dump
2、svnadmin hotcopy
3)svnsync
注意，svn备份不宜采用普通的文件拷贝方式（除非你备份的时候将库暂停），如copy、rsync命令。
曾经用rsync命令来做增量和全量备份，在季度备份检查审计中，发现备份出来的库大部分都不可用，因此最好是用svn本身提供的功能来进行备份。
优缺点分析：
**第一种** svnadmin dump是官方推荐的备份方式，优点是比较灵活，可以全量备份也可以增量备份，并提供了版本恢复机制。
缺点是：如果版本比较大，如版本数增长到数万、数十万，那么dump的过程将非常慢；备份耗时，恢复更耗时；不利于快速进行灾难恢复。
个人建议在版本数比较小的情况下使用这种备份方式。
**第二种** svnadmin hotcopy原设计目的估计不是用来备份的，只能进行全量拷贝，不能进行增量备份；
优点是：备份过程较快，灾难恢复也很快；如果备份机上已经搭建了svn服务，甚至不需要恢复，只需要进行简单配置即可切换到备份库上工作。
缺点是：比较耗费硬盘，需要有较大的硬盘支持（俺的备份机有1TB空间，呵呵）。
**第三种** svnsync实际上是制作2个镜像库，当一个坏了的时候，可以迅速切换到另一个。不过，必须svn1.4版本以上才支持这个功能。
优点是：当制作成2个镜像库的时候起到双机实时备份的作用；
缺点是：当作为2个镜像库使用时，没办法做到“想完全抛弃今天的修改恢复到昨晚的样子”；而当作为普通备份机制每日备份时，操作又较前2种方法麻烦。

#### svnadmin dump方式

SVN迁移需要做如下操作：
1. 将原来的Repository导出为一个文件dumpfile 。
#svnadmin dump 原先的repos的目录路径（/repository/directory） > dumpfile
#svnadmin dump /opt/svn/iitshare/ > /var/tmp/iitshare_20130626
2. 在另外一台机器上配置同样的SVN服务器。

参考：[linux SVN安装及配置图解教程](http://www.iitshare.com/linux-svn-installation-and-configuration.html)

3. 将dumpfile导入到新的repository 目录中。
#svnadmin load 新建的repos的目录路径（/repository/directory） < dumpfile
#svnadmin load /opt/svn/iitshare/ < /var/tmp/iitshare_20130626
4. 将原先服务器的配置文件备份后复制到新服务器中
#/opt/svn/iitshare/conf目录下
authz、passwd、svnserve.conf文件

#### svnadmin hotcopy方法

1. 备份
#svnadmin hotcopy /opt/svn/iitshare/ /var/tmp/iitshare_20130626 –clean-logs
如果你传递–clean-logs选项，svnadmin会执行热拷贝操作，然后删除不用的Berkeley DB日志文件。
你可以在任何时候运行这个命令得到一个版本库的安全拷贝，不管其它进程是否使用这个版本库。
2. 还原
#svnadmin hotcopy /var/tmp/iitshare_20130626 /opt/svn/iitshare/

1

[世纪花园二手房](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=19&ch=0&di=8&fv=0&is_app=0&jk=b3e6dd6716768480&k=%CA%C0%BC%CD%BB%A8%D4%B0%B6%FE%CA%D6%B7%BF&k0=%CA%C0%BC%CD%BB%A8%D4%B0%B6%FE%CA%D6%B7%BF&k1=%B1%B1%BE%A9%D1%F8%C9%FA%B9%DD%D7%AA%C8%C3&k2=%CD%F8%D2%B3%D6%C6%D7%F7&k3=%BB%C6%BD%F0%BD%BB%D2%D7%C6%BD%CC%A8&k4=%C4%CF%BE%A9%BA%CF%D7%E2%B0%C9&k5=%BA%A3%C4%CF%C8%FD%D1%C7&kdi0=8&kdi1=8&kdi2=8&kdi3=8&kdi4=8&kdi5=8&luki=1&mcpm=122507&n=10&p=baidu&q=01098069_cpr&rb=0&rs=1&seller_id=1&sid=8084761667dde6b3&ssp2=1&stid=8&t=tpclicked3_hc&td=1274649&tu=u1274649&u=http%3A%2F%2Fwww%2Eiitshare%2Ecom%2Flinux%2Dsvn%2Dmigration%2Ehtml&urlid=0)

3

[网页制作](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=19&ch=0&di=8&fv=0&is_app=0&jk=b3e6dd6716768480&k=%CD%F8%D2%B3%D6%C6%D7%F7&k0=%CD%F8%D2%B3%D6%C6%D7%F7&k1=%BB%C6%BD%F0%BD%BB%D2%D7%C6%BD%CC%A8&k2=%C4%CF%BE%A9%BA%CF%D7%E2%B0%C9&k3=%BA%A3%C4%CF%C8%FD%D1%C7&k4=mt4%BD%BB%D2%D7%C8%ED%BC%FE&k5=%D6%D0%B9%FA%C2%A5%CA%D0%B4%F3%C7%F7%CA%C6&kdi0=8&kdi1=8&kdi2=8&kdi3=8&kdi4=8&kdi5=8&luki=3&mcpm=228374&n=10&p=baidu&q=01098069_cpr&rb=0&rs=1&seller_id=1&sid=8084761667dde6b3&ssp2=1&stid=8&t=tpclicked3_hc&td=1274649&tu=u1274649&u=http%3A%2F%2Fwww%2Eiitshare%2Ecom%2Flinux%2Dsvn%2Dmigration%2Ehtml&urlid=0)

5

[南京合租吧](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=19&ch=0&di=8&fv=0&is_app=0&jk=b3e6dd6716768480&k=%C4%CF%BE%A9%BA%CF%D7%E2%B0%C9&k0=%C4%CF%BE%A9%BA%CF%D7%E2%B0%C9&k1=%BA%A3%C4%CF%C8%FD%D1%C7&k2=mt4%BD%BB%D2%D7%C8%ED%BC%FE&k3=%D6%D0%B9%FA%C2%A5%CA%D0%B4%F3%C7%F7%CA%C6&k4=%B7%BF%B5%D8%B2%FA%B1%C0%C5%CC&k5=%CA%C0%BC%CD%BB%A8%D4%B0%B6%FE%CA%D6%B7%BF&kdi0=8&kdi1=8&kdi2=8&kdi3=8&kdi4=8&kdi5=8&luki=5&mcpm=128669&n=10&p=baidu&q=01098069_cpr&rb=0&rs=1&seller_id=1&sid=8084761667dde6b3&ssp2=1&stid=8&t=tpclicked3_hc&td=1274649&tu=u1274649&u=http%3A%2F%2Fwww%2Eiitshare%2Ecom%2Flinux%2Dsvn%2Dmigration%2Ehtml&urlid=0)

7

[mt4交易软件](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=19&ch=0&di=8&fv=0&is_app=0&jk=b3e6dd6716768480&k=mt4%BD%BB%D2%D7%C8%ED%BC%FE&k0=mt4%BD%BB%D2%D7%C8%ED%BC%FE&k1=%D6%D0%B9%FA%C2%A5%CA%D0%B4%F3%C7%F7%CA%C6&k2=%B7%BF%B5%D8%B2%FA%B1%C0%C5%CC&k3=%CA%C0%BC%CD%BB%A8%D4%B0%B6%FE%CA%D6%B7%BF&k4=%B1%B1%BE%A9%D1%F8%C9%FA%B9%DD%D7%AA%C8%C3&k5=%CD%F8%D2%B3%D6%C6%D7%F7&kdi0=8&kdi1=8&kdi2=8&kdi3=8&kdi4=8&kdi5=8&luki=7&mcpm=497847&n=10&p=baidu&q=01098069_cpr&rb=0&rs=1&seller_id=1&sid=8084761667dde6b3&ssp2=1&stid=8&t=tpclicked3_hc&td=1274649&tu=u1274649&u=http%3A%2F%2Fwww%2Eiitshare%2Ecom%2Flinux%2Dsvn%2Dmigration%2Ehtml&urlid=0)

9

[中国楼市大趋势](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=19&ch=0&di=8&fv=0&is_app=0&jk=b3e6dd6716768480&k=%D6%D0%B9%FA%C2%A5%CA%D0%B4%F3%C7%F7%CA%C6&k0=%D6%D0%B9%FA%C2%A5%CA%D0%B4%F3%C7%F7%CA%C6&k1=%B7%BF%B5%D8%B2%FA%B1%C0%C5%CC&k2=%CA%C0%BC%CD%BB%A8%D4%B0%B6%FE%CA%D6%B7%BF&k3=%B1%B1%BE%A9%D1%F8%C9%FA%B9%DD%D7%AA%C8%C3&k4=%CD%F8%D2%B3%D6%C6%D7%F7&k5=%BB%C6%BD%F0%BD%BB%D2%D7%C6%BD%CC%A8&kdi0=8&kdi1=8&kdi2=8&kdi3=8&kdi4=8&kdi5=8&luki=9&mcpm=41125&n=10&p=baidu&q=01098069_cpr&rb=0&rs=1&seller_id=1&sid=8084761667dde6b3&ssp2=1&stid=8&t=tpclicked3_hc&td=1274649&tu=u1274649&u=http%3A%2F%2Fwww%2Eiitshare%2Ecom%2Flinux%2Dsvn%2Dmigration%2Ehtml&urlid=0)

2

[北京养生馆转让](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=19&ch=0&di=8&fv=0&is_app=0&jk=b3e6dd6716768480&k=%B1%B1%BE%A9%D1%F8%C9%FA%B9%DD%D7%AA%C8%C3&k0=%B1%B1%BE%A9%D1%F8%C9%FA%B9%DD%D7%AA%C8%C3&k1=%CD%F8%D2%B3%D6%C6%D7%F7&k2=%BB%C6%BD%F0%BD%BB%D2%D7%C6%BD%CC%A8&k3=%C4%CF%BE%A9%BA%CF%D7%E2%B0%C9&k4=%BA%A3%C4%CF%C8%FD%D1%C7&k5=mt4%BD%BB%D2%D7%C8%ED%BC%FE&kdi0=8&kdi1=8&kdi2=8&kdi3=8&kdi4=8&kdi5=8&luki=2&mcpm=107933&n=10&p=baidu&q=01098069_cpr&rb=0&rs=1&seller_id=1&sid=8084761667dde6b3&ssp2=1&stid=8&t=tpclicked3_hc&td=1274649&tu=u1274649&u=http%3A%2F%2Fwww%2Eiitshare%2Ecom%2Flinux%2Dsvn%2Dmigration%2Ehtml&urlid=0)

4

[黄金交易平台](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=19&ch=0&di=8&fv=0&is_app=0&jk=b3e6dd6716768480&k=%BB%C6%BD%F0%BD%BB%D2%D7%C6%BD%CC%A8&k0=%BB%C6%BD%F0%BD%BB%D2%D7%C6%BD%CC%A8&k1=%C4%CF%BE%A9%BA%CF%D7%E2%B0%C9&k2=%BA%A3%C4%CF%C8%FD%D1%C7&k3=mt4%BD%BB%D2%D7%C8%ED%BC%FE&k4=%D6%D0%B9%FA%C2%A5%CA%D0%B4%F3%C7%F7%CA%C6&k5=%B7%BF%B5%D8%B2%FA%B1%C0%C5%CC&kdi0=8&kdi1=8&kdi2=8&kdi3=8&kdi4=8&kdi5=8&luki=4&mcpm=350772&n=10&p=baidu&q=01098069_cpr&rb=0&rs=1&seller_id=1&sid=8084761667dde6b3&ssp2=1&stid=8&t=tpclicked3_hc&td=1274649&tu=u1274649&u=http%3A%2F%2Fwww%2Eiitshare%2Ecom%2Flinux%2Dsvn%2Dmigration%2Ehtml&urlid=0)

6

[海南三亚](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=19&ch=0&di=8&fv=0&is_app=0&jk=b3e6dd6716768480&k=%BA%A3%C4%CF%C8%FD%D1%C7&k0=%BA%A3%C4%CF%C8%FD%D1%C7&k1=mt4%BD%BB%D2%D7%C8%ED%BC%FE&k2=%D6%D0%B9%FA%C2%A5%CA%D0%B4%F3%C7%F7%CA%C6&k3=%B7%BF%B5%D8%B2%FA%B1%C0%C5%CC&k4=%CA%C0%BC%CD%BB%A8%D4%B0%B6%FE%CA%D6%B7%BF&k5=%B1%B1%BE%A9%D1%F8%C9%FA%B9%DD%D7%AA%C8%C3&kdi0=8&kdi1=8&kdi2=8&kdi3=8&kdi4=8&kdi5=8&luki=6&mcpm=94857&n=10&p=baidu&q=01098069_cpr&rb=0&rs=1&seller_id=1&sid=8084761667dde6b3&ssp2=1&stid=8&t=tpclicked3_hc&td=1274649&tu=u1274649&u=http%3A%2F%2Fwww%2Eiitshare%2Ecom%2Flinux%2Dsvn%2Dmigration%2Ehtml&urlid=0)

8

[网页游戏](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=19&ch=0&di=1&fv=0&is_app=0&jk=b3e6dd6716768480&k=%CD%F8%D2%B3%D3%CE%CF%B7&k0=%CD%F8%D2%B3%D3%CE%CF%B7&k1=%D6%D0%B9%FA%C2%A5%CA%D0%B4%F3%C7%F7%CA%C6&k2=%B7%BF%B5%D8%B2%FA%B1%C0%C5%CC&k3=%CA%C0%BC%CD%BB%A8%D4%B0%B6%FE%CA%D6%B7%BF&k4=%B1%B1%BE%A9%D1%F8%C9%FA%B9%DD%D7%AA%C8%C3&k5=%CD%F8%D2%B3%D6%C6%D7%F7&kdi0=1&kdi1=8&kdi2=8&kdi3=8&kdi4=8&kdi5=8&luki=8&mcpm=1239672&n=10&p=baidu&q=01098069_cpr&rb=0&rs=1&seller_id=1&sid=8084761667dde6b3&ssp2=1&stid=8&t=tpclicked3_hc&td=1274649&tu=u1274649&u=http%3A%2F%2Fwww%2Eiitshare%2Ecom%2Flinux%2Dsvn%2Dmigration%2Ehtml&urlid=0)

10

[房地产崩盘](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=19&ch=0&di=8&fv=0&is_app=0&jk=b3e6dd6716768480&k=%B7%BF%B5%D8%B2%FA%B1%C0%C5%CC&k0=%B7%BF%B5%D8%B2%FA%B1%C0%C5%CC&k1=%CA%C0%BC%CD%BB%A8%D4%B0%B6%FE%CA%D6%B7%BF&k2=%B1%B1%BE%A9%D1%F8%C9%FA%B9%DD%D7%AA%C8%C3&k3=%CD%F8%D2%B3%D6%C6%D7%F7&k4=%BB%C6%BD%F0%BD%BB%D2%D7%C6%BD%CC%A8&k5=%C4%CF%BE%A9%BA%CF%D7%E2%B0%C9&kdi0=8&kdi1=8&kdi2=8&kdi3=8&kdi4=8&kdi5=8&luki=10&mcpm=24476&n=10&p=baidu&q=01098069_cpr&rb=0&rs=1&seller_id=1&sid=8084761667dde6b3&ssp2=1&stid=8&t=tpclicked3_hc&td=1274649&tu=u1274649&u=http%3A%2F%2Fwww%2Eiitshare%2Ecom%2Flinux%2Dsvn%2Dmigration%2Ehtml&urlid=0)

[ ](http://wangmeng.baidu.com/)

文章作者：[iitshare](http://www.iitshare.com/)
本文地址：http://www.iitshare.com/linux-svn-migration.html
版权所有 © 转载时必须以链接形式注明作者和原始出处！

[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)[(L)](http://www.iitshare.com/linux-svn-migration.html#)更多[2](http://www.iitshare.com/linux-svn-migration.html#)
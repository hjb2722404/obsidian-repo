CentOS查看用户登录记录centos

## CentOS查看用户登录记录

时间:2015-05-17 01:08来源:cnblogs.com 作者:huey [举报](http://www.centoscn.com/plus/erraddsave.php?aid=5467&title=CentOS%B2%E9%BF%B4%D3%C3%BB%A7%B5%C7%C2%BC%BC%C7%C2%BC)  点击:1959次

 [![u=1754840656,2741043490&fm=76.jpg](../_resources/ca444a0bf42be41f5a9a65b7183ce20b.jpg)](https://www.baidu.com/s?tn=93125157_hao_pg&word=linux%C8%EB%C3%C5)

 [ linux入门](https://www.baidu.com/s?tn=93125157_hao_pg&word=linux%C8%EB%C3%C5)

 [![u=3249290878,1403091144&fm=76.jpg](../_resources/699c2373f2632fe2264f62368f56ceec.jpg)](https://www.baidu.com/s?tn=93125157_hao_pg&word=%B7%AD%D4%BDvpn%B5%E7%C4%D4%B0%E6)

 [ 翻越vpn电脑版](https://www.baidu.com/s?tn=93125157_hao_pg&word=%B7%AD%D4%BDvpn%B5%E7%C4%D4%B0%E6)

 [![u=1246260994,1367018692&fm=76.jpg](../_resources/0c64d7c31fb6a41bda0e5b15ec81dc77.jpg)     ![u=1246260994,1367018692&fm=76.jpg](../_resources/0c64d7c31fb6a41bda0e5b15ec81dc77.jpg)     linux内核学习    百度一下](https://www.baidu.com/s?tn=93125157_hao_pg&word=linux%C4%DA%BA%CB%D1%A7%CF%B0)

 [ linux内核学习](https://www.baidu.com/s?tn=93125157_hao_pg&word=linux%C4%DA%BA%CB%D1%A7%CF%B0)

 [![u=1639318162,2067026837&fm=76.jpg](../_resources/54c6e45b2595ed0aea4f2b314be60c49.jpg)](https://www.baidu.com/s?tn=93125157_hao_pg&word=%B4%F3%B0%D7%F6%E8%D3%CE%CF%B7)

 [ 大白鲨游戏](https://www.baidu.com/s?tn=93125157_hao_pg&word=%B4%F3%B0%D7%F6%E8%D3%CE%CF%B7)

 [![u=1060931767,4215576904&fm=76.jpg](../_resources/7b80adbadeddf17fb3f88c136cd1f97a.jpg)     ![u=1060931767,4215576904&fm=76.jpg](../_resources/7b80adbadeddf17fb3f88c136cd1f97a.jpg)     python编程入门    百度一下](https://www.baidu.com/s?tn=93125157_hao_pg&word=python%B1%E0%B3%CC%C8%EB%C3%C5)

 [ python编程入门](https://www.baidu.com/s?tn=93125157_hao_pg&word=python%B1%E0%B3%CC%C8%EB%C3%C5)

 [![u=2823688367,4002716258&fm=76.jpg](../_resources/58284b783e0acbd6d53740ddde4c06cf.jpg)](https://www.baidu.com/s?tn=93125157_hao_pg&word=vpn%B4%FA%C0%ED%C8%ED%BC%FE%C3%E2%B7%D1%B0%E6)

 [ vpn代理软件免费版](https://www.baidu.com/s?tn=93125157_hao_pg&word=vpn%B4%FA%C0%ED%C8%ED%BC%FE%C3%E2%B7%D1%B0%E6)

 [![u=1431404869,365833815&fm=76.jpg](../_resources/4fabe23334dbe511b434226b5f4020ae.jpg)](https://www.baidu.com/s?tn=93125157_hao_pg&word=%C3%E2%B7%D1vpn%B7%FE%CE%F1%C6%F7)

 [ 免费vpn服务器](https://www.baidu.com/s?tn=93125157_hao_pg&word=%C3%E2%B7%D1vpn%B7%FE%CE%F1%C6%F7)

 [![u=323335259,353434143&fm=76.jpg](../_resources/101ec3892dcd9d5070d4c55b7e0ecbe2.jpg)](https://www.baidu.com/s?tn=93125157_hao_pg&word=%BF%D8%D6%C6%CC%A8)

 [ 控制台](https://www.baidu.com/s?tn=93125157_hao_pg&word=%BF%D8%D6%C6%CC%A8)

 [![u=4102273231,4140368128&fm=76.jpg](../_resources/f1675c5103e2e4d58f879916ad4297a5.jpg)](https://www.baidu.com/s?tn=93125157_hao_pg&word=apache%B7%FE%CE%F1%C6%F7)

 [ apache服务器](https://www.baidu.com/s?tn=93125157_hao_pg&word=apache%B7%FE%CE%F1%C6%F7)

 [![u=3661159564,485530056&fm=76.jpg](../_resources/45f754e9611e8db5c58933b28c707c44.jpg)     ![u=3661159564,485530056&fm=76.jpg](../_resources/45f754e9611e8db5c58933b28c707c44.jpg)     vpn上facebook    百度一下](https://www.baidu.com/s?tn=93125157_hao_pg&word=vpn%C9%CFfacebook)

 [ vpn上facebook](https://www.baidu.com/s?tn=93125157_hao_pg&word=vpn%C9%CFfacebook)

 [ ](http://wangmeng.baidu.com/)

有关用户登录的信息记录在 utmp(/var/run/utmp)、wtmp(/var/log/wtmp)、btmp(/var/log/btmp) 和 lastlog(/var/log/lastlog) 等文件中。

who、w 和 users 等命令通过 utmp(/var/run/utmp) 文件查询当前登录用户的信息。
last 和 ac 命令通过 wtmp(/var/log/wtmp) 文件查询当前与过去登录系统的用户的信息。
lastb 命令通过 btmp(/var/log/btmp) 文件查询所有登录系统失败的用户的信息。
lastlog 命令通过 lastlog(/var/log/lastlog) 文件查询用户最后一次登录的信息。

who 命令：显示当前当登录的用户的信息
huey@huey-K42JE:~$ **who**huey pts/1 2015-05-11 18:29 (192.168.1.105)
sugar pts/2 2015-05-11 18:29 (192.168.1.105)
w 命令：显示登录的用户及其当前执行的任务

huey@huey-K42JE:~$ **w** 18:30:51 up 3 min, 2 users, load average: 0.10, 0.14, 0.06

USER TTY FROM LOGIN@ IDLE JCPU PCPU WHAT
huey pts/1 192.168.1.105 18:29 3.00s 0.52s 0.00s w
sugar pts/2 192.168.1.105 18:29 1:07 0.47s 0.47s -bash
users 命令：显示当前当登录的用户的用户名
huey@huey-K42JE:~$ **users**huey sugar
last 命令：显示当前与过去登录系统的用户的信息
![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)

huey@huey-K42JE:~$ **last**root pts/3 192.168.1.105 Mon May 11 18:33 - 18:33 (00:00) sugar pts/2 192.168.1.105 Mon May 11 18:32 still logged in sugar pts/2 192.168.1.105 Mon May 11 18:29 - 18:32 (00:02) huey pts/1 192.168.1.105 Mon May 11 18:29 still logged in reboot system boot 3.5.0-43-generic Mon May 11 18:27 - 18:33 (00:05) huey pts/1 192.168.1.105 Sat May 9 10:57 - 17:31 (06:33)

![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)
lastb 命令：显示所有登录系统失败的用户的信息
huey@huey-K42JE:~$ **sudo lastb**btmp begins Sat May 9 09:48:59 2015
lastlog 命令：显示用户最后一次登录的信息
![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)
huey@huey-K42JE:~$ **lastlog** 用户名 端口 来自 最后登陆时间
root pts/3 192.168.1.105 一 5月 11 18:36:43 +0800 2015
daemon **从未登录过**
bin **从未登录过**
sys **从未登录过**
......
hplip **从未登录过**
saned **从未登录过**
huey pts/1 192.168.1.105 一 5月 11 18:29:40 +0800 2015
guest-mIZNkv **从未登录过**
guest-bCf1SI **从未登录过**
sugar pts/2 192.168.1.105 一 5月 11 18:32:28 +0800 2015
mysql **从未登录过**
sshd **从未登录过**
![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)
ac 命令：显示用户连接时间的统计数据
a) 显示每天的总的连接时间
huey@huey-K42JE:~$ **ac -d**May 9	total 6.55
Today	total 0.54
b) 显示每个用户的总的连接时间
huey@huey-K42JE:~$ **ac -p**huey 6.78
sugar 0.23
root 0.12
total 7.13

1
[centos](https://www.baidu.com/s?tn=93614542_hao_pg&word=centos)

4

[杭州二手车交易](https://www.baidu.com/s?tn=93614542_hao_pg&word=%BA%BC%D6%DD%B6%FE%CA%D6%B3%B5%BD%BB%D2%D7%CA%D0%B3%A1)

7

[冷门创业好项目](https://www.baidu.com/s?tn=93614542_hao_pg&word=%C0%E4%C3%C5%B4%B4%D2%B5%BA%C3%CF%EE%C4%BF)

10

[家用小型发电机](https://www.baidu.com/s?tn=93614542_hao_pg&word=%BC%D2%D3%C3%D0%A1%D0%CD%B7%A2%B5%E7%BB%FA)

13

[网上选号](https://www.baidu.com/s?tn=93614542_hao_pg&word=%CD%F8%C9%CF%D1%A1%BA%C5)

2
[linux入门](https://www.baidu.com/s?tn=93614542_hao_pg&word=linux%C8%EB%C3%C5)

5

[荨麻疹好了](https://www.baidu.com/s?tn=93614542_hao_pg&word=%DD%A1%C2%E9%D5%EE%BA%C3%C1%CB)

8

[超小型电动车](https://www.baidu.com/s?tn=93614542_hao_pg&word=%B3%AC%D0%A1%D0%CD%B5%E7%B6%AF%B3%B5)

11

[新型阳台护栏](https://www.baidu.com/s?tn=93614542_hao_pg&word=%D0%C2%D0%CD%D1%F4%CC%A8%BB%A4%C0%B8)

14

[装载机秤](https://www.baidu.com/s?tn=93614542_hao_pg&word=%D7%B0%D4%D8%BB%FA%B3%D3)

3
[mysql](https://www.baidu.com/s?tn=93614542_hao_pg&word=mysql)

6

[加盟小型加工厂](https://www.baidu.com/s?tn=93614542_hao_pg&word=%BC%D3%C3%CB%D0%A1%D0%CD%BC%D3%B9%A4%B3%A7)

9
[开沟机](https://www.baidu.com/s?tn=93614542_hao_pg&word=%BF%AA%B9%B5%BB%FA)

12

[小型打桩机](https://www.baidu.com/s?tn=93614542_hao_pg&word=%D0%A1%D0%CD%B4%F2%D7%AE%BB%FA)

15

[7座suv汽车大全](https://www.baidu.com/s?tn=93614542_hao_pg&word=7%D7%F9suv%C6%FB%B3%B5%B4%F3%C8%AB)

[ ](http://wangmeng.baidu.com/)

**------分隔线----------------------------**

- 上一篇：[CentOS定位、查找文件的命令](http://www.centoscn.com/CentOS/help/2015/0517/5466.html)
- 下一篇：[CentOS 反复执行命令watch全屏显示输出](http://www.centoscn.com/CentOS/help/2015/0517/5468.html)
- [收藏](http://www.centoscn.com/plus/stow.php?aid=5467)
- [举报](http://www.centoscn.com/plus/erraddsave.php?aid=5467&title=CentOS%B2%E9%BF%B4%D3%C3%BB%A7%B5%C7%C2%BC%BC%C7%C2%BC)
- [推荐](http://www.centoscn.com/plus/recommend.php?aid=5467)
- [打印](http://www.centoscn.com/CentOS/help/2015/0517/5467.html#)
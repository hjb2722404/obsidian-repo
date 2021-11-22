linux crontab & 每隔10秒执行一次 - juandx - 博客园

# [linux crontab & 每隔10秒执行一次](http://www.cnblogs.com/juandx/p/4992465.html)

**linux下定时执行任务的方法 **
在LINUX中你应该先输入crontab -e，然后就会有个vi编辑界面，再输入0 3 * * 1 /clearigame2内容到里面 :wq 保存退出。

在LINUX中，周期执行的任务一般由cron这个守护进程来处理[ps -ef|grep cron]。cron读取一个或多个配置文件，这些配置文件中包含了命令行及其调用时间。

cron的配置文件称为“crontab”，是“cron table”的简写。
**一、cron在3个地方查找配置文件：**

1、/var/spool/cron/ 这个目录下存放的是每个用户包括root的crontab任务，每个任务以创建者的名字命名，比如tom建的crontab任务对应的文件就是/var/spool/cron/tom。

一般一个用户最多只有一个crontab文件。

**二、/etc/crontab 这个文件负责安排由系统管理员制定的维护系统以及其他任务的crontab。**

**三、/etc/cron.d/ 这个目录用来存放任何要执行的crontab文件或脚本。**
**四、权限**
crontab权限问题到/var/adm/cron/下一看，文件cron.allow和cron.deny是否存在
用法如下：
1、如果两个文件都不存在，则只有root用户才能使用crontab命令。

2、如果cron.allow存在但cron.deny不存在，则只有列在cron.allow文件里的用户才能使用crontab命令，如果root用户也不在里面，则root用户也不能使用crontab。

3、如果cron.allow不存在, cron.deny存在，则只有列在cron.deny文件里面的用户不能使用crontab命令，其它用户都能使用。
4、如果两个文件都存在，则列在cron.allow文件中而且没有列在cron.deny中的用户可以使用crontab，如果两个文件中都有同一个用户，
以cron.allow文件里面是否有该用户为准，如果cron.allow中有该用户，则可以使用crontab命令。

在crontab文件中如何输入需要执行的命令和时间。该文件中每行都包括六个域，其中前五个域是指定命令被执行的时间，最后一个域是要被执行的命令。
    每个域之间使用空格或者制表符分隔。格式如下：
　 minute hour day-of-month month-of-year day-of-week commands
    合法值 00-59 00-23 01-31 01-12 0-6 (0 is sunday) commands（代表要执行的脚本）

    除了数字还有几个个特殊的符号就是"*"、"/"和"-"、","，*代表所有的取值范围内的数字，"/"代表每的意思,"/5"表示每5个单位，"-"代表从某个数字到某个数字,","分开几个离散的数字。

**基本格式 :**
*****command
分　 时　 日　 月　 周　 命令
第1列表示分钟1～59 每分钟用*或者 */1表示
第2列表示小时1～23（0表示0点）
第3列表示日期1～31
第4列表示月份1～12
第5列标识号星期0～6（0表示星期天）
第6列要运行的命令

**crontab文件的一些例子：**
#每晚的21:30重启apache。
30 21 * * * /usr/local/etc/rc.d/lighttpd restart
#每月1、10、22日
45 4 1,10,22 * * /usr/local/etc/rc.d/lighttpd restart
#每天早上6点10分
10 6 * * * date
#每两个小时
0 */2 * * * date
#晚上11点到早上8点之间每两个小时，早上8点
0 23-7/2，8 * * * date
#每个月的4号和每个礼拜的礼拜一到礼拜三的早上11点
0 11 4 * mon-wed date
#1月份日早上4点
0 4 1 jan * date

很多时候，我们计划任务需要精确到秒来执行，根据以下方法，可以很容易地以秒执行任务。
以下方法将**每10秒执行一次**

1
2
3
4
5
6
7
[object Object]

[object Object]  [object Object]  [object Object]  [object Object]  [object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object]  [object Object]  [object Object]  [object Object]  [object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object]  [object Object]  [object Object]  [object Object]  [object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object]  [object Object]  [object Object]  [object Object]  [object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object]  [object Object]  [object Object]  [object Object]  [object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object]  [object Object]  [object Object]  [object Object]  [object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

注意如果用如果命令用到%的话需要用\转义
1
2
3
[object Object]

[object Object]  [object Object]  [object Object]  [object Object]  [object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object]  [object Object]  [object Object]  [object Object]  [object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

收获不会与付出成反比 by juandx

分类: [linux](http://www.cnblogs.com/juandx/category/600099.html)

标签: [linux](http://www.cnblogs.com/juandx/tag/linux/), [crontab](http://www.cnblogs.com/juandx/tag/crontab/)

 [好文要顶](linux%20crontab%20&%20每隔10秒执行一次%20-%20juandx%20-%20博客园.md#)  [关注我](linux%20crontab%20&%20每隔10秒执行一次%20-%20juandx%20-%20博客园.md#)  [收藏该文](linux%20crontab%20&%20每隔10秒执行一次%20-%20juandx%20-%20博客园.md#)  [![icon_weibo_24.png](linux%20crontab%20&%20每隔10秒执行一次%20-%20juandx%20-%20博客园.md#)  [![wechat.png](linux%20crontab%20&%20每隔10秒执行一次%20-%20juandx%20-%20博客园.md#)

 [![20140915225503.png](../_resources/55144e312063bc9174d6fb2c89f7bd54.png)](http://home.cnblogs.com/u/juandx/)

 [juandx](http://home.cnblogs.com/u/juandx/)
 [关注 - 3](http://home.cnblogs.com/u/juandx/followees)
 [粉丝 - 12](http://home.cnblogs.com/u/juandx/followers)

 [+加关注](linux%20crontab%20&%20每隔10秒执行一次%20-%20juandx%20-%20博客园.md#)

 3

 1

[«](http://www.cnblogs.com/juandx/p/4974633.html) 上一篇：[Head First HTML CSS XHTML笔记](http://www.cnblogs.com/juandx/p/4974633.html)

[»](http://www.cnblogs.com/juandx/p/5020230.html) 下一篇：[自动化部署教程(一) redhat安装jenkins](http://www.cnblogs.com/juandx/p/5020230.html)

posted @ 2015-11-24 18:20  [juandx](http://www.cnblogs.com/juandx/) 阅读(35217) 评论(5) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=4992465)  [收藏](http://www.cnblogs.com/juandx/archive/2015/11/24/4992465.html#)
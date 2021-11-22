##  [科普]Windows命令行kill进程小技巧

 [IceArmour](http://www.freebuf.com/author/icearmour)  2013-09-27  共**183411**人围观 ，发现 **25** 个不明物体    [WEB安全](http://www.freebuf.com/articles/web)

**在进行渗透测试的时候，难免会碰到某些软件影响渗透测试的进一步进行，所以在这种时候需要一些手段或工具结束一些阻碍渗透的进程，本文分享了三个结束进程的小tips，纯科普文，只为抛砖引玉，各位牛轻喷，如下：**

**1、PsKill.exe**

[PsKill](http://technet.microsoft.com/en-us/sysinternals/bb896683.aspx)可能是Microsoft Windows命令行里面最古老和最常用的结束进程的方法，很早以前是国外安全研究院Mark Russinovich开发的Sysinternals工具包里面的一个工具，现在被微软收购。

可以传输一个进程的PID号，然后通过pskill结束该进程。
```
C：\> pskill $PID
```
**2、TASKKILL.exe**
TASKKILL命令是Microsoft Windows内置的一款命令，可以用来终止进程，具体的命令规则如下：
```
TASKKILL [/S system [/U username [/P [password]]]] { [/FI filter] [/PID processid | /IM imagename] } [/F] [/T]

**参数列表:**

/S system 指定要连接到的远程系统。
/U [domain\]user 指定应该在哪个用户上下文
执行这个命令。
/P [password] 为提供的用户上下文指定密码。如果忽略，提示输入。
/F 指定要强行终止的进程。
/FI filter 指定筛选进或筛选出查询的的任务。
/PID process id 指定要终止的进程的PID。
/IM image name 指定要终止的进程的图像名。通配符 '*'可用来指定所有图像名。
/T Tree kill: 终止指定的进程和任何由此启动的子进程。
/? 显示帮助/用法。
**示例**
TASKKILL /S system /F /IM notepad.exe /T
TASKKILL /PID 1230 /PID 1241 /PID 1253 /T
TASKKILL /F /IM QQ.exe
```
**3、ProcessHacker工具**

ProcessHacker是国外安全研究者开发的一款专门用于结束进程的工具，详见[这里](http://processhacker.sourceforge.net/)，可以用它结束一些常见的杀毒软件进程，使用方法如下：
```
c:\> ProcessHacker.exe -c -ctype process -cobject $PID-Number -caction terminate
```
也是暂停进程的运行，如下：
```
c:\> ProcessHacker.exe -c -ctype process -cobject $PID-Number –caction suspend
```
你还有什么技巧吗？欢迎与我一起分享给大家。

http://www.freebuf.com/articles/web/13283.html#)

- 上一篇：[Web应用安全十大主动安全措施](http://www.freebuf.com/articles/web/13197.html)

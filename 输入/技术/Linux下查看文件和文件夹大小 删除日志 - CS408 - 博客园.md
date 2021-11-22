（转）Linux下查看文件和文件夹大小 删除日志 - CS408 - 博客园

场景：在sts中执行自动部署时候maven提示No space left on device错误，后来经检查发现是磁盘空间满了，用下面的方法分析发现tomcat下面的logs目录占用了很大的空间，删除多余的日志问题解决！

[回到顶部](https://www.cnblogs.com/lixuwu/p/5944062.html#_labelTop)

# 1 Linux下查看文件和文件夹大小

当磁盘大小超过标准时会有报警提示，这时如果掌握df和du命令是非常明智的选择。
 **df可以查看一级文件夹大小、使用比例、档案系统及其挂入点，但对文件却无能为力。**
** du可以查看文件及文件夹的大小。**
  两者配合使用，非常有效。比如用df查看哪个一级目录过大，然后用df查看文件夹或文件的大小，如此便可迅速确定症结。
  下面分别简要介绍

## 1.1 df命令

//可以用来查看分区的文件系统df -T
![755171-20161125101029409-925339042.png](../_resources/d1be2f9adc7fda6dcf1ec722db9cb27e.png)

 **df命令可以显示目前所有文件系统的可用空间及使用情形**，请看下列这个例子：
df -h
 ![755171-20161009214606825-692760341.png](../_resources/9aac71c4a87d416cbddd9bc29db38b88.png)
    参数 -h 表示使用「Human-readable」的输出，也就是在档案系统大小使用 GB、MB 等易读的格式。

    上面的命令输出的第一个字段（Filesystem）及最后一个字段（Mounted on）分别是档案系统及其挂入点。我们可以看到 /dev/sda1 这个分割区被挂在根目录下。

    接下来的四个字段 Size、Used、Avail、及 Use% 分别是该分割区的容量、已使用的大小、剩下的大小、及使用的百分比。 FreeBSD下，当硬盘容量已满时，您可能会看到已使用的百分比超过 100%，因为 FreeBSD 会留一些空间给 root，让 root 在档案系统满时，还是可以写东西到该档案系统中，以进行管理。

## 1.2 du命令

**ps:实战经验，两者配合使用**
[![copycode.gif](Linux下查看文件和文件夹大小%20删除日志%20-%20CS408%20-%20博客园.md#)

//查看系统中文件的使用情况df -h//查看当前目录下各个文件及目录占用空间大小du -sh *//方法一：切换到要删除的目录，删除目录下的所有文件rm -f *//方法二：删除logs文件夹下的所有文件，而不删除文件夹本身rm -rf log/*

[![copycode.gif](Linux下查看文件和文件夹大小%20删除日志%20-%20CS408%20-%20博客园.md#)

下面的删除方式暂未尝试。
ls *.log | xargs rm -f

![755171-20161115153016513-1594923932.png](../_resources/cf115184c7dc8b41e92eac7f791e1260.png)

** du：查询文件或文件夹的磁盘使用空间**

    如果当前目录下文件和文件夹很多，使用不带参数du的命令，可以循环列出所有文件和文件夹所使用的空间。这对查看究竟是那个地方过大是不利的，所以得指定深入目录的层数，参数：--max-depth=，这是个极为有用的参数！

如下，注意使用“*”，可以得到文件的使用空间大小.
    **提醒**：一向命令比linux复杂的FreeBSD，它的du命令指定深入目录的层数却是比linux简化，为 -d。

du -h --max-depth=1 /home
 ![755171-20161009214957466-575489713.png](../_resources/08fb7cec020106ffb73a1d83be375dc8.png)
下面的命令与上面的命令有什么异同？？
答：du -h --max-depth=1 /home仅列出home目录下面所有的一级目录文件大小；
du -h --max-depth=1 /home/* 列出home下面所有一级目录的一级目录文件大小。
du -h --max-depth=1 /home/*
![755171-20161009215601273-1952414310.png](../_resources/35d27dd91fe7e161d56acf94d4a7214e.png)
**1.3 查看linux文件目录的大小和文件夹包含的文件数**
    统计总数大小
    du -sh xmldb/
    du -sm * | sort -n //统计当前目录大小 并安大小 排序
    du -sk * | sort -n
    du -sk * | grep guojf //看一个人的大小
    du -m | cut -d "/" -f 2 //看第二个/ 字符前的文字
    查看此文件夹有多少文件 /*/*/* 有多少文件
    du xmldb/
    du xmldb/*/*/* |wc -l
    40752
    解释：
    wc [-lmw]
    参数说明：
    -l :多少行
    -m:多少字符
    -w:多少字

## **1.4 Linux:ls以K、M、G为单位查看文件大小**

**ps：注意man命令的使用，按“q”键可以退出man查询。**
[![copycode.gif](Linux下查看文件和文件夹大小%20删除日志%20-%20CS408%20-%20博客园.md#)
#man  ls……-h, --human-readable
print sizes in human readable format (e.g., 1K 234M 2G)
……

# lscuss.war nohup.out

# ls -l

total 30372-rw-r--r-- 1 root root 31051909 May 24  10:07 cuss.war-rw------- 1 root root 0 Mar 20  13:52 nohup.out

# ls -lh

total 30M-rw-r--r-- 1 root root 30M May 24  10:07 cuss.war-rw------- 1 root root 0 Mar 20  13:52 nohup.out

# ll -h

total 30M-rw-r--r-- 1 root root 30M May 24  10:07 cuss.war-rw------- 1 root root 0 Mar 20  13:52 nohup.out

[![copycode.gif](Linux下查看文件和文件夹大小%20删除日志%20-%20CS408%20-%20博客园.md#)

 ![755171-20161009221852401-1124125582.png](../_resources/31eef1da8876454a45550ac3c0f86f1e.png)

[回到顶部](https://www.cnblogs.com/lixuwu/p/5944062.html#_labelTop)

# 2 删除系统日志等

## 2.1 规范

linux下删除指定文件之外的其他文件

一、[Linux](http://www.2cto.com/os/linux/)下删除文件和文件夹常用命令如下：
删除文件： rm file  www.2cto.com
删除文件夹： rm -rf dir
需要注意的是， rmdir 只能够删除 空文件夹。

二、删除指定文件（夹）之外的所有文件呢？

- 需要在当前文件夹中进行:

#删除keep文件之外的所有文件
rm -rf !(folder) #删除folder1和folder2文件之外的所有文件
rm -rf !(folder1 | folder2)

- ****当前文件夹中结合使用grep和xargs来处理文件名：****

#删除keep文件之外的所有文件
ls | grep -v keep | xargs rm

说明： ls先得到当前的所有文件和文件夹的名字， grep -v keep，进行grep正则匹配查找keep，-v参数决定了结果为匹配之外的结果，也就是的到了keep之外的所有文件名，然后 xargs用于从 标准输入获得参数 并且传递给后面的命令，这里使用的命令是 rm，然后由rm删除前面选择的文件。

好处：使用了grep来正则表达式来匹配文件名字，可以一次保留多个文件，从而进行更加准确的处理。

- 使用find命令代替ls，改进方法3从而能够处理制定文件夹的文件：

#删除当前test文件夹中keep文件之外的所有文件
find ./test/ | grep -v keep | xargs rm
说明，用grep而不用find -name选取名字，因为find选取名字时比较麻烦，对正则表达式支持不够，无法排除指定文件名。

- 直接使用find命令删除其他文件：

#删除keep以外的其他文件。
find ./ -name '[^k][^e][^e][^p]*' -exec rm -rf {} \; #删除keep以外的其他文件。推荐！
find ./ -name '[^k][^e][^e][^p]*' | xargs rm -rf
说明：上面第二行的代码效率高些，原因在于删除多个文件时 -exec会启动多个进程来处理，而xargs会启动一个rm进程来处理。
[回到顶部](https://www.cnblogs.com/lixuwu/p/5944062.html#_labelTop)

# 3 实践

删除要慎重

## 3.1 保留删除

![755171-20170628150241039-913260357.png](../_resources/9781c40f6f9a2ac79e90032a66f8d436.png)

#删除生成 core,mbox等文件
find / -name core|xargs rm –rf
#删除日志
rm -rf /var/log/*

问题：日志文件中有很多文件，我想删除除debug.log 和sys.out 文件外的所有文件。
![755171-20170628153440914-1932017001.png](../_resources/6a8df98331fc60b14ba49d644dbf5928.png)
首先我要能够找到debug.log和sys.out这两个文件——
#建立查找规则 vi test.txt ^debug.log$^sys.out$
 尝试查找：

linux-hipe:/home/tws/server/basedata-server/logs # ls | grep -f test.txt debug.log

sys.out
 删除要保留文件外的其它文件：
ls | grep -vf test.txt |xargs  rm#记得加v，保留要保留的文件，不要删错了

#删除，文件名中带有数字，超过30天的日志：
find -mtime +30 -name "*[0-9]*" -exec rm {} \;

 关于find命令，请参考博文：
[linux下find命令的使用和总结](http://www.cnblogs.com/lixuwu/p/7816390.html)
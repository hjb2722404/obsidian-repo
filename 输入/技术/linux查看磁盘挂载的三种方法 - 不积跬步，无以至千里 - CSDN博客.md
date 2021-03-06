linux查看磁盘挂载的三种方法 - 不积跬步，无以至千里 - CSDN博客

转

# linux查看磁盘挂载的三种方法

2016年08月02日 14:12:27[聚优致成](https://me.csdn.net/qq_29350001)阅读数：30078更多
个人分类：[DM8168](https://blog.csdn.net/qq_29350001/article/category/6306382)

# 今天要讲的是linux下怎么查看磁盘的挂载，包括挂载点和挂载的硬盘或逻辑卷。

第一种方法：使用df命令，这个命令比较常用，大家都很熟悉。问题是这种方法，有时候挂载点和挂载的卷不在同一行，使用脚本分析需要一点技巧的。例如：
orientalson:/home # df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda2             15213032   8043668   7169364 53% /
udev                    514496       104    514392   1% /dev
/dev/mapper/vg_test-lv_test
                        511980     32840    479140   7% /home/mt
orientalson:/home #
上面显示的挂载点/home/mt和她挂载的卷不在同一行，使用shell脚本分析非常麻烦。不过也不是没办法，具体分析可以以后再讲。
第二种方法：使用mount命令，mount -l，这种方法的缺陷在于没有卷的大小，但是挂载点和挂载的卷在同一行。例如：
orientalson:/home # mount -l
/dev/sda2 on / type reiserfs (rw,acl,user_xattr) []
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
debugfs on /sys/kernel/debug type debugfs (rw)
udev on /dev type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
securityfs on /sys/kernel/security type securityfs (rw)
/dev/mapper/vg_test-lv_test on /home/mt type reiserfs (rw) []
orientalson:/home #
尽管使用肉眼不是太好看，但是使用shell脚本还是比较容易分析的。

第三种方法：查看文件/etc/mtab。原理是，每新挂载一个卷基本上都会更新这个文件的，那么自然可以通过这个文件来查看挂载点和挂职的卷。这种方法比mount -l稍微清晰了一点，但是，有时候是不可靠的。

orientalson:/home # cat /etc/mtab
/dev/sda2 / reiserfs rw,acl,user_xattr 0 0
proc /proc proc rw 0 0
sysfs /sys sysfs rw 0 0
debugfs /sys/kernel/debug debugfs rw 0 0
udev /dev tmpfs rw 0 0
devpts /dev/pts devpts rw,mode=0620,gid=5 0 0
securityfs /sys/kernel/security securityfs rw 0 0
/dev/mapper/vg_test-lv_test /home/mt reiserfs rw 0 0
orientalson:/home #
上面已经说了基本上会更新这个文件，但是并不总是更新这个问题。如果挂载时使用了-n选项，那么/etc/mtab文件里面就不会新挂载卷的信息。
orientalson:/home # umount /home/mt
orientalson:/home # mount -n /dev/vg_test/lv_test /home/mt
orientalson:/home # cat /etc/mtab
/dev/sda2 / reiserfs rw,acl,user_xattr 0 0
proc /proc proc rw 0 0
sysfs /sys sysfs rw 0 0
debugfs /sys/kernel/debug debugfs rw 0 0
udev /dev tmpfs rw 0 0
devpts /dev/pts devpts rw,mode=0620,gid=5 0 0
securityfs /sys/kernel/security securityfs rw 0 0
orientalson:/home #

转自： http://blog.chinaunix.net/uid-26748613-id-3525954.html
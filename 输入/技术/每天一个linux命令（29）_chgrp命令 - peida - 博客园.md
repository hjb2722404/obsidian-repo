每天一个linux命令（29）:chgrp命令 - peida - 博客园

#  每天一个linux命令（29）:chgrp命令

在lunix系统里，文件或目录的权限的掌控以拥有者及所诉群组来管理。可以使用chgrp指令取变更文件与目录所属群组，这种方式采用群组名称或群组识别码都可以。Chgrp命令就是change group的缩写！要被改变的组名必须要在/etc/group文件内存在才行。

1．命令格式：
chgrp [选项] [组] [文件]
2．命令功能：
chgrp命令可采用群组名称或群组识别码的方式改变文件或目录的所属群组。使用权限是超级用户。
3．命令参数：
必要参数:
-c 当发生改变时输出调试信息
-f 不显示错误信息
-R 处理指定目录以及其子目录下的所有文件
-v 运行时显示详细的处理信息
--dereference 作用于符号链接的指向，而不是符号链接本身
--no-dereference 作用于符号链接本身
选择参数:
--reference=<文件或者目录>
--help 显示帮助信息
--version 显示版本信息
4．使用实例：
实例1：改变文件的群组属性
命令：
chgrp -v bin log2012.log
输出：
[root@localhost test]# ll
---xrw-r-- 1 root root 302108 11-13 06:03 log2012.log
[root@localhost test]# chgrp -v bin log2012.log
“log2012.log” 的所属组已更改为 bin
[root@localhost test]# ll
---xrw-r-- 1 root bin  302108 11-13 06:03 log2012.log
说明：
将log2012.log文件由root群组改为bin群组
实例2：根据指定文件改变文件的群组属性
命令：
chgrp --reference=log2012.log log2013.log
输出：
[root@localhost test]# ll
---xrw-r-- 1 root bin  302108 11-13 06:03 log2012.log
-rw-r--r-- 1 root root     61 11-13 06:03 log2013.log
[root@localhost test]#  chgrp --reference=log2012.log log2013.log
[root@localhost test]# ll
---xrw-r-- 1 root bin  302108 11-13 06:03 log2012.log
-rw-r--r-- 1 root bin      61 11-13 06:03 log2013.log
说明：
改变文件log2013.log 的群组属性，使得文件log2013.log的群组属性和参考文件log2012.log的群组属性相同
实例3：改变指定目录以及其子目录下的所有文件的群组属性
命令：
输出：
[root@localhost test]# ll
drwxr-xr-x 2 root root   4096 11-30 08:39 test6
[root@localhost test]# cd test6
[root@localhost test6]# ll
---xr--r-- 1 root root 302108 11-30 08:39 linklog.log
---xr--r-- 1 root root 302108 11-30 08:39 log2012.log
-rw-r--r-- 1 root root     61 11-30 08:39 log2013.log
-rw-r--r-- 1 root root      0 11-30 08:39 log2014.log
-rw-r--r-- 1 root root      0 11-30 08:39 log2015.log
-rw-r--r-- 1 root root      0 11-30 08:39 log2016.log
-rw-r--r-- 1 root root      0 11-30 08:39 log2017.log
[root@localhost test6]# cd ..
[root@localhost test]# chgrp -R bin test6
[root@localhost test]# cd test6
[root@localhost test6]# ll
---xr--r-- 1 root bin 302108 11-30 08:39 linklog.log
---xr--r-- 1 root bin 302108 11-30 08:39 log2012.log
-rw-r--r-- 1 root bin     61 11-30 08:39 log2013.log
-rw-r--r-- 1 root bin      0 11-30 08:39 log2014.log
-rw-r--r-- 1 root bin      0 11-30 08:39 log2015.log
-rw-r--r-- 1 root bin      0 11-30 08:39 log2016.log
-rw-r--r-- 1 root bin      0 11-30 08:39 log2017.log
[root@localhost test6]# cd ..
[root@localhost test]# ll
drwxr-xr-x 2 root bin    4096 11-30 08:39 test6
[root@localhost test]#
说明：
改变指定目录以及其子目录下的所有文件的群组属性
实例4：通过群组识别码改变文件群组属性
命令：
chgrp -R 100 test6
输出：
[root@localhost test]# chgrp -R 100 test6
[root@localhost test]# ll
drwxr-xr-x 2 root users   4096 11-30 08:39 test6
[root@localhost test]# cd test6
[root@localhost test6]# ll
---xr--r-- 1 root users 302108 11-30 08:39 linklog.log
---xr--r-- 1 root users 302108 11-30 08:39 log2012.log
-rw-r--r-- 1 root users     61 11-30 08:39 log2013.log
-rw-r--r-- 1 root users      0 11-30 08:39 log2014.log
-rw-r--r-- 1 root users      0 11-30 08:39 log2015.log
-rw-r--r-- 1 root users      0 11-30 08:39 log2016.log
-rw-r--r-- 1 root users      0 11-30 08:39 log2017.log
[root@localhost test6]#
说明：
通过群组识别码改变文件群组属性，100为users群组的识别码，具体群组和群组识别码可以去/etc/group文件中查看
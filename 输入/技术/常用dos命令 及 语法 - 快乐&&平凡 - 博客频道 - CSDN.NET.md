常用dos命令 及 语法 - 快乐&&平凡 - 博客频道 - CSDN.NET

#   [常用dos命令 及 语法](http://blog.csdn.net/wh_19910525/article/details/7837331)

.

  标签： [dos](http://www.csdn.net/tag/dos)

 2012-08-07 00:08  2804人阅读    [评论](http://blog.csdn.net/wh_19910525/article/details/7837331#comments)(0)    [收藏](常用dos命令%20及%20语法%20-%20快乐&&平凡%20-%20博客频道%20-%20CSDN.NET.md#)    [举报](http://blog.csdn.net/wh_19910525/article/details/7837331#report)

 .

 ![category_icon.jpg](../_resources/760c5ec8c68b26ded5d32a15a75b0d4b.jpg)  分类：

   windows相关*（22）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)      其他杂类*（21）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

 .

版权声明：本文为博主原创文章，未经博主允许不得转载。

**cd **改变当前目录，
**dir**  列出 文件 和 文件夹名，
** dir /ad /b  **指列出来 当前 目录下的**文件夹**

**echo **
      **ECHO 提示信息内容**  #解释：输出提示信息
      如果想** 关闭“ECHO ”命令行 自身的显示**，则需要在该命令行前加上“@”  ，如：**@echo** 不显示本行的echo

      关闭DOS命令提示符，在DOS提示符状态下键入**ECHO OFF**，能够关闭DOS提示符的显示使屏幕只留下光标，直至键入ECHO ON，提示符才会重新出现。

      **输出空行，即相当于输入一个回车**，**ECHO．**

               值得注意的是命令行中的“．”要紧跟在ECHO后面中间不能有空格，否则“．”将被当作提示信息输出到屏幕。另外“．”可以用，：；”／[\]＋等任一符号替代。

           在下面的例子中ECHO．输出的回车，经DOS管道转向作为TIME命令的输入，即相当于在TIME命令执行后给出一个回车。所以执行时系统会在显示当前时间后，自动返回到DOS提示符状态：

C:〉ECHO.|TIME

**pause**  它会提示“请按任意键继续...” ，pause命令没有任何的参数，它的命令就是它的本身，当pause命令运行后，会中断执行的语句。这个中断不是立即停止，只是暂停，按下任意键之后就会继续执行下面的语句。而且应该不止可以用一次，在一个批处理命令中，可以尝试使用多个pause命令。

            我想把这个 提示文字 自定义，改成其他的。像“请按任意键开始或结束”或者直接将提示删除了，保留停顿功能，用以下  方式 可以实现：
          ** echo 请按任意键开始或结束
**
**           pause>nul
**
**           解释：第二句功能是去掉提示“请按任意键继续...”，第一句就是你想输出的提示内容**

**copy** / **xcopy** 拷贝 文件，

        /Y **不使用确认**是否要覆盖现有目标文件的提示。
　　/-Y **使用确认**是否要覆盖现有目标文件的提示。

**del **  删除**文件**，
**rd**  删除**目录**，
       /s 除目录本身外，还将删除指定目录下的所有子目录和文件。用于删除目录树。
       /q 安静模式，带 /s  删除目录树时不要求确认。
**mkdir** 和**md** 都是 创建 目录，
      在 windows下，创建 目录和 目录树，** 创建 目录树时， 不需要 加参数 就可以 创建**；
**move** srcfile targetfile
     移动 或者 重命名 文件和目录
ren srcfile targetfile 改变文件名，

-------------------------------------------------------------
语法部分：
** . **和 [Linux](http://lib.csdn.net/base/linux) 下 一样 代表 当前 目录；
**.. **也和 linux下一样 代表 上一级 目录；

在dos下 **命令和参数 不区分 大小写**，所以 命令 可以是 大写，也可以是小写，也可以是 大小写 混合；

在 批处理中** %号 代表 第几个参数**，比如 运行 a.bat a b ，a.bat** 本身 是 %0, 第一个参数a 是 %1,第二个是 %2 以此类推**。

dos中“|”“||”“&”“&&”分别代表

| 前面命令输出结果作为后面命令的输入内容

|| 前面命令执行失败的时候才执行后面的命令
& 前面命令执行后接着执行后面的命令
&& 前面命令执行成功了才执行后面的命令

两个% 是用来 去变量的值

[dos下的注释](http://blog.csdn.net/wh_19910525/article/details/8125762)

-------------------[if 语句的使用](http://blog.csdn.net/wh_19910525/article/details/7912123) -------------------

if not exist folder1 md folder2
           解释：如果 folder1文件夹 不存在，就 建立 dolder2 文件夹；
if not exist *.apk goto s2
if exist *.apk goto s1
:s1
 @echo off
 @echo   正在解包，请稍等...

 for %%i in (*.apk) do [Java](http://lib.csdn.net/base/javase) -jar apktool.jar d -f %%i _%%i && move _%%i 解包完的apk && move %%i 原始软件备份 && @echo %%i 解包完成!

 Pause
 exit
:s2
 echo 目录中没有发现apk文件！
 Pause

----------------------------[for 语句 的使用](http://blog.csdn.net/wh_19910525/article/details/7912440) ------------------------------

在cmd 窗口中：for %I in (command1) do command2
在批处理文件中：for %%I in (command1) do command2

for %%i in (*.apk) do 语句一 && 语句二 && 语句三
     解释：如果 for 里面 要 执行 多条 语句 用 &&  并列；

 .

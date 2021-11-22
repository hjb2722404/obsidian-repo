批处理命令学习笔记——Setlocal与Endlocal命令 - 工作日志 - CSDN博客

原

# 批处理命令学习笔记——Setlocal与Endlocal命令

2016年12月08日 13:29:32[在南京看海](https://me.csdn.net/qq_33336155)阅读数：8094标签：[dos](https://so.csdn.net/so/search/s.do?q=dos&t=blog)[windows](https://so.csdn.net/so/search/s.do?q=windows&t=blog)[批处理](https://so.csdn.net/so/search/s.do?q=%E6%89%B9%E5%A4%84%E7%90%86&t=blog)[详解](https://so.csdn.net/so/search/s.do?q=%E8%AF%A6%E8%A7%A3&t=blog)更多

个人分类：[tools](https://blog.csdn.net/qq_33336155/article/category/6565556)

版权声明：本文为博主原创文章，未经博主允许不得转载。	https://blog.csdn.net/qq_33336155/article/details/53516976

Setlocal 与 Endlocal 命令

开始与终止批处理文件中环境改动的本地化操作。在执行 Setlocal 之后所做的环境改动只限于批处理文件。要还原原先的设置，必须执行 Endlocal。达到批处理文件结尾时，对于该批处理文件的每个尚未执行的 Setlocal 命令，都会有一个隐含的 Endlocal 被执行。Endlocal结束批处理文件中环境改动的本地化操作。在执行Endlocal 之后所做的环境改动不再仅限于批处理文件。批处理文件结束后，原先的设置无法还原。

**语法：**

Setlocal {enableextension | disableextensions} {enabledelayedexpansion | disabledelayedexpansion}

...
Endlocal
...

如果命令扩展名被启用，SETLOCAL 可以接受{}中的可选参数，启动或停用命令处理器扩展名及延缓环境变量扩展名。详细信息，请参阅 CMD /? 和 SET /? 。

无论在 Setlocal 命令之前它们的设置是什么，这些修改会一直保留到匹配的 Endlocal 命令。

**示例：**
@ECHO OFF
Echo Before Setlocal:
Set PATH
Pause
Setlocal
Rem reset environment var PATH
Set PATH=E:\TOOLS
Echo after Setlocal and reset PATH
Set PATH
Pause
Endlocal
Echo Recovery PATH by Endlocal
Set PATH

从上例我们可以看到环境变量PATH第1次被显示得时候是系统默认路径。被设置成了“E:\TOOLS”后显示为“E:\TOOLS”。但当 Endlocal 后我们可以看到他又被还原成了系统的默认路径。但这个设置只在该批处理运行的时候有作用。当批处理运行完成后环境变量PATH将会还原。

**技巧：**

如果有一个参数，SETLOCAL 命令将设置 ERRORLEVEL 的值。如果有两个有效参数中的一个，该值则为零。用下列技巧，您可以在批脚本中使用这个来决定扩展名是否可用：

VERIFY OTHER 2>nul
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 echo Unable to enable extensions

这个方法之所以有效，是因为在 CMD.EXE 的旧版本上，SETLOCAL不设置 ERRORLEVEL 值。具有不正确参数的 VERIFY 命令将ERRORLEVEL 值初始化成非零值。
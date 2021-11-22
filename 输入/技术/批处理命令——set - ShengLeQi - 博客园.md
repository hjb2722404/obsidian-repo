批处理命令——set - ShengLeQi - 博客园

# [批处理命令——set](https://www.cnblogs.com/sheng-247/p/10481857.html)

from:https://www.cnblogs.com/Braveliu/p/5081084.html
【1】set命令简介
　　set，设置。
【2】set命令使用
　　1. 打印系统环境变量。set命令可以打印系统所有的环境变量信息。
　　应用示例：新建文本文件，命名为set_sys，修改文件类型为bat，用Notepad++打开编辑内容如下：
[![copycode.gif](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)

@echo  off::set 显示所有系统环境变量::set (暂时屏蔽掉，需要执行请去掉::)pause>nul::set c 显示所有以C开头的环境变量(不区分大小写)set cpause>nul::set q 显示所有以Q开头的环境变量(不区分大小写)set qpause>nul

[![copycode.gif](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)
执行结果：
![389111-20151229151816776-1792545452.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231174829.png)
　　命令解析：
　　第 3 行：由于打印系统环境变量信息太多，暂时屏蔽掉，若有兴趣在本机测试时候可以去掉屏蔽命令（::）
　　第 6 行：打印所有以C开头的环境变量信息（不区分大小写）
　　第 9 行：打印所有以Q开头的环境变量信息（不区分大小写）

　　2. 变量设置值。
　　应用示例：新建文本文件，命名为set_value，修改文件类型为bat，用Notepad++打开编辑内容如下：
[![copycode.gif](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)

@echo  offset var=呵呵~我是变量var的值echo %var%set var=abcdefgecho %var%set var="abcdefg"echo %var%set "var=abcdefg"echo %var%pause>nul

[![copycode.gif](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)
　　执行结果：
![389111-20151229153439823-694550358.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231174835.png)
　　命令解析：
　　注意：各种为变量赋值的写法，以及存在的差异性。
　　3. set /p命令。
　　应用示例：新建文本文件，命名为set_p，修改文件类型为bat，用Notepad++打开编辑内容如下：
@echo  offset /p var=请输入变量的值：echo 你输入的值是：%var%pause>nul
　　执行结果：
![389111-20151229153635151-1903191270.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231174840.png)
　　命令解析：
　　/p命令语法，作用可以在用户输入前加一段说明性的描述，即想让用户输入什么内容之类的说明。
　　4. set /a命令。
　　应用示例：新建文本文件，命名为set_a，修改文件类型为bat，用Notepad++打开编辑内容如下：
[![copycode.gif](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)

@echo  offrem +运算符set /a var=1+1echo %var%rem ()运算符set /a var=(1+1) + (1+1)echo %var%rem *运算符set /a var*=2echo %var%rem ,运算符 注意：求varB和varC时，两种写法的区别set /a varA=var, varB=%var%*2, varC=var*3echo %varA% %varB% %varC%rem 与运算符，必须双引号括起来set /a varD=1"&"0echo %varD%rem 或运算符，必须双引号括起来set /a varE=1"|"0echo %varE%rem 异运算符，必须双引号括起来set /a varF=0"^"0echo %varF%pause>nul

[![copycode.gif](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)
　　执行结果：
![389111-20151229153845167-1149911278.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231174847.png)
　　命令解析：
　　详情见脚本注释。/a expression 即可以用各种表达式为变量赋值。
　　5. set替换作用
　　应用示例：新建文本文件，命名为set_swap，修改文件类型为bat，用Notepad++打开编辑内容如下：
[![copycode.gif](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)

@echo  offset src= China I love youecho 替换前的值: "%src%"set des=%src:love=hate%echo 替换后的值: "%des%"set des=%src: =123%echo 替换后的值: "%des%"set des=%src:I=me%echo 替换后的值: "%des%"set des=%src:you=she%echo 替换后的值: "%des%"pause>nul

[![copycode.gif](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)
　　执行结果：
![389111-20151229154835089-497422655.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231174851.png)
　　命令解析：
　　同样的语句，写了那么多，如果你有点归纳总结的能力，估计应该可以看出来了。
　　总结个模板，即如此：set des=%src:str1=str2%
　　作用简述：把源变量src的值中所有的str1字符串替换成str2字符串，从而组合形成目标变量des的值。
　　6. set取舍作用
　　应用示例：新建文本文件，命名为set_at，修改文件类型为bat，用Notepad++打开编辑内容如下：
[![copycode.gif](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)

@echo  offset src=www.baidu.com.cnecho %src%set des=%src:~1,2%echo %des%set des=%src:~4,5%echo %des%set des=%src:~1,7%echo %des%set des=%src:~5%echo %des%set des=%src:~-5%echo %des%set des=%src:~0,-5%echo %des%set des=%src:~2,-3%echo %des%pause>nul

[![copycode.gif](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)
　　执行结果：
![389111-20151229155431307-917486462.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231174857.png)
　　命令解析：
　　第 4 行：~1,2 表示：把源变量src的值字符串从第1个索引位开始，取2位组成目标变量des的值（即：ww）。
　　第 6 行：~4,5 表示：把源变量src的值字符串从第4个索引位开始，取5位组成目标变量des的值（即：baidu）。
　　第 8 行：同理第4、6行（结果即：ww.baid）。
　　第 10 行：~5 表示：把源变量src的值字符串从第5个索引位开始，取后面所有组成目标变量des的值（即：aidu.com.cn）。
　　第 12 行：~-5 表示：把源变量src的值字符串从尾部开始取5个字符组成目标变量des的值（即：om.cn）。
　　第 14 行：~0,-5 表示：把源变量src的值字符串从0索引位开始，至尾部数第五个索引位为止取出组成目标变量des的值（即：www.baidu.c）
　　第 16 行：与第14行同理（结果即：w.baidu.com）。

Good Good Study, Day Day Up.

标签: [bat批处理](https://www.cnblogs.com/sheng-247/tag/bat%E6%89%B9%E5%A4%84%E7%90%86/)

 [好文要顶](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)  [关注我](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)  [收藏该文](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)  [![icon_weibo_24.png](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)  [![wechat.png](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)

 [![20170705172233.png](../_resources/6f4bdd57a3f890416460c8cbb2f45bf4.jpg)](http://home.cnblogs.com/u/sheng-247/)

 [ShengLeQi](http://home.cnblogs.com/u/sheng-247/)
 [关注 - 6](http://home.cnblogs.com/u/sheng-247/followees)
 [粉丝 - 4](http://home.cnblogs.com/u/sheng-247/followers)

 [+加关注](批处理命令——set%20-%20ShengLeQi%20-%20博客园.md#)

 0

 0

[«](https://www.cnblogs.com/sheng-247/p/10481624.html) 上一篇：[bat批处理教程之for的/f参数](https://www.cnblogs.com/sheng-247/p/10481624.html)

[»](https://www.cnblogs.com/sheng-247/p/10528160.html) 下一篇：[批处理文件 bat 后台运行](https://www.cnblogs.com/sheng-247/p/10528160.html)

posted @ 2019-03-06 10:45  [ShengLeQi](https://www.cnblogs.com/sheng-247/) 阅读(10) 评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=10481857)  [收藏](https://www.cnblogs.com/sheng-247/p/10481857.html#)
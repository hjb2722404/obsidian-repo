PHPStorm 常用 设置配置 和快捷键大全 Win/Mac - 风.foxwho(神秘狐) - CSDN博客

# PHPStorm 下载及主题样式下载

http://www.lanmps.com/lanmps-tools.html
风.fox

# 主题

Preferences->Appearance & Behavior ->Appearance
Theme 选择 Darcual

# 界面字体及大小

Preferences->Appearance & Behavior ->Appearance
Override default fonts by(not recommended) 勾选
以下可以根据你自己的喜欢更改
>
> 字体大小：14
>  name字体选择：
>   `MAC系统`> Lucida Grand
>   `Windows系统`>  Mircrosoft YaHei 或 微软雅黑

# 自动保存-每15秒自动保存

Preferences->Appearance & Behavior ->System Settings
Save files automatically if application is idle for 15 sec 勾选
你也可以修改你想要多少秒自动保存

# 关闭自动检测更新

Preferences->Appearance & Behavior ->System Settings->Updates
Automatically check update for …. 取消勾选
如果你链接PHPSTORM官网的网速很快可以PASS

# 文件编码

Preferences->Editor->File Encondings
IDE Encondings：IDE编码
Project Encoding：项目编码
Default encoding for properties files：默认文件编码
>
`UTF-8`>  本人的项目都是UTF-8编码，所以这里的是UTF-8
>  你要根据你自己的编码设置

# 显示行号

Preferences -> Editor->General->Appearance
Show line numbers 勾选
有的版本没有默认已勾选

# 正在编辑的文件加星号标识:

Preferences -> editor -> General->Editor Tabs
Mark modifed tabs with asterisk 勾选

# 编辑器内字体大小

Preferences -> editor ->Colors & Fonts->Font
先要把Scheme另存为一个才可以修改
Show Only monospaced fonts 取消勾选
修改字体,字体大小及行间距:
字体大小：15
行间距：1.1
字体：(可以根据喜好自行设置)
>
`MAC系统`> Monaco
>   `Windows系统`>  FiraCode、 Mircrosoft YaHei 或 微软雅黑

# 换行符修改

Preferences -> editor -> Code Style
line separator(for new files):选择`Unix and OSX(\n)`

# 当前编辑文件定位和自动定位

## 自动定位

Project面板，工具图标按钮（齿轮形状），弹出的菜单中选择
Autoscroll from Source
编辑文件时，左侧文件夹聚焦到该文件

## 手动定位-快捷键

在编辑的所选文件按ALT+F1, 然后选择PROJECT VIEW(新版下一级 Project)
![这里写图片描述](../_resources/fc2d28bb01bed7661f03fba5bcf5ae23.jpg)

## 手动定位-工具按钮定位

左侧 项目列表框 顶部的 定位图标
![这里写图片描述](../_resources/9fac53f3e2baae0b84d016fa9609ea2e.png)

# PHP手册

Preferences -> Tools->External Tools

Parameters参数
`-a  http://php.net/manual/zh/function.$SelectedText$.php   `

- 1
- 1

>
> 注意： > S> e> l> e> c> t> e> d> T> e> x> t> 表示选中的文本

## 如何使用

更多（CHM版）请看
http://www.cnblogs.com/keygle/p/3281395.html

# 对文件夹或文件设置显示过滤

Preferences -> editor->File Types
Ignore file and folders
里面填写你要的过滤不显示的
注意大小写哦

# 启动的时候不打开工程文件

Preferences->Appearance & Behavior ->System Settings
去掉 Reopen last project on startup.

# 插件

Preferences->plugins
browse repositories 按钮 ，在出现的窗口中，搜索并选择你要的插件。
点击 右侧的 Install 按钮进行插件安装，安装完成后 提示你要重启PHPstorm，重启之后可以使用插件

## 代码地图插件CodeGlance

## IdeaVim

vim 插件

## Markdown

Markdown是一种可以使用普通文本编辑器编写的标记语言，通过简单的标记语法，它可以使普通文本内容具有一定的格式。

## 其他插件

liveEdit（这是一款让你写html和css可以即写即浏览的插件，它需要配合谷歌浏览器Chrome使用） http://www.wwwquan.com/show-66-123-1.html

特效插件
https://segmentfault.com/q/1010000005920474

# TODO(表示待办事件)注释

`快捷键` Alt+6
`Alt+6` 可以查看添加了//TODO注释的代码片段
一般我们在开发过程中由于时间或者各方面的时间来不及完成的代码,往往会先将逻辑写出来,实现留待以后添加的内容都会加上//TODO注释
这样就可以根据快捷键快速的找到

# PHPstrom语法检查(默认启用)

如有强迫症的人可以关闭。
>
> 非常不建议关闭，因为可以快速的显示表示出，当前变量 命名是否规范，变量是否使用，或者变量是否拼写错误等等，总之优点很多
>  函数中未使用的变量是灰色的。使用未定义的变量会有红色下划线提示(主题不一样颜色会设置不一样)。提示变量很好的减少了手误

# 最近编辑修改过的文件

`Ctrl+E`可以快速打开你最近编辑的文件。

# 本地修改记录

项目名称上右键，点击Local History | Show History
可以看到每次修改项目，都修改了那些文件，可以看到项目或者文件的各个历史版本
Alt+Shift+C，可以看到项目最近的修改记录。

# 常用代码片段

`CTRL + j`能够快捷的输入常用的代码片段，类似vim的 snipMate，可以自定义代码片段

# 类名查找

`CTRL + N` 类名查找

# 文件名查找

`CTRL + SHIFT + N` 文件名查找

# 函数名查找

`CTRL + SHIFT + ALT + N` 函数名查找

# 方法变量快速查找

快速寻找方法，变量定义处：`ctrl + b`或者`ctrl+单击`

# 函数或类调用查找

`alt + F7`找到该函数或类在哪里调用

# 搜索所有

`Search every where` 支持类名、文件名，方法名等的单独搜索，常用的是全部搜索
`Search every where` 按两次shift 即可出现

# 代码格式化

`ctrl+alt+l`代码格式化

# 重命名

`shift + F6` 重命名
可以重命名函数方法名、变量名，文件名，函数名可以搜索引用的文件。还可以重命名标签名

# 注释

`Ctrl + /`，单行注释
`Ctrl + Shift + /`，多行注释,块注释
`/** + Enter`，自动生成注释

# 单词大小写

`ctrl + shift + u` 大小写
代码方法间快速跳转：alt + up, down

# 查找PHPStorm IDE内所有的动作

快捷键 Ctrl + Shift + A
Ctrl + Shift + A 是一个比较重要的快捷键，主要用于寻找PHPStorm IDE内所有的动作。

# 同一个项目内打开多个项目

File -> Open或者File->Open Directory选中项目文件夹后，
选中 Open in current window 及 Add to currently opended projects，
最后点击OK，这样同一个项目内可以打开多个项目。
如果你的IDE不能打开，请升级最新版phpstorm

# z-coding功能

z-coding是一个让你写html可以事半功倍的东西，比如你在html文件里输入ul.nav>li*5>a然后按Tab键，马上
>
> 能出来一大段代码，如下所示：

# Live Templates代码片断

https://laracasts.com/series/how-to-be-awesome-in-phpstorm

# 快捷键

快捷键镜像/映射：Default(Win和Mac中都使用默认快捷键)
>
> MAC中如果没有特殊说明，那么久使用Command替换Ctrl
风.fox

| 介绍  | 使用度 | win | Mac |
| --- | --- | --- | --- |
| Ctrl |     |     | Command+?<br>Command替换Ctrl |
| 在当前文件进行文本查找 （必备） |     | Ctrl + F |     |
| 在当前文件进行文本替换 （必备） |     | Ctrl + R |     |
| 撤销 （必备） |     | Ctrl + Z |     |
| 删除光标所在行 或 删除选中的行 （必备） |     | Ctrl + Y | Command+delete<br>⌘+delete |
| 剪切光标所在行 或 剪切选择内容 |     | Ctrl + X |     |
| 复制光标所在行 或 复制选择内容 |     | Ctrl + C |     |
| 复制光标所在行 或 复制选择内容，<br>并把复制内容插入光标位置下面 （必备） |     | Ctrl + D |     |
| 递进式选择代码块<br>可选中光标所在的单词或段落，<br>连续按会在原有选中的基础上再扩展选中范围 （必备） |     | Ctrl + W | Option+↑ |
| 显示最近打开的文件记录列表 |     | Ctrl + E |     |
| 根据输入的 类名 查找类文件 |     | Ctrl + N | Command+O<br>⌘+O |
| 在当前文件跳转到指定行处 |     | Ctrl + G | Command+L<br>⌘+L |
| 插入自定义动态代码模板 |     | Ctrl + J |     |
| 方法参数提示显示 |     | Ctrl + P |     |
| 光标所在的变量<br>/ 类名 / 方法名等上面（也可以在提示补充的时候按），<br>显示文档内容 |     | Ctrl + Q | F1或<br>Control+J |
| 前往当前光标所在的方法的父类的方法 / 接口定义 |     | Ctrl + U |     |
| 进入光标所在的方法/变量的接口或是定义出 |     | Ctrl + B或<br>Ctrl + 左键单击 | Command + B 或<br>Command + 左键单击 |
| 版本控制提交项目，<br>需要此项目有加入到版本控制才可用 |     | Ctrl + K |     |
| 版本控制更新项目，<br>需要此项目有加入到版本控制才可用 |     | Ctrl + T |     |
| 显示当前类的层次结构 |     | Ctrl + H | Control + H |
| 选择可重写的方法 |     | Ctrl + O | Control + O |
| 选择可继承的方法 |     | Ctrl + I | Control + I |
| 展开代码 |     | Ctrl + + |     |
| 折叠代码 |     | Ctrl + - |     |
| 注释光标所在行代码，<br>会根据当前不同文件类型使用不同的注释符号 （必备） |     | Ctrl + / |     |
| 移动光标到当前所在代码的花括号开始位置 |     | Ctrl + [ | Option+Command+[ |
| 移动光标到当前所在代码的花括号结束位置 |     | Ctrl + ] | Option+Command+] |
| 在光标所在的错误代码出显示错误信息 |     | Ctrl + F1 | Command+F1 |
| 调转到所选中的词的下一个引用位置 |     | Ctrl + F3 | 无   |
| 关闭当前编辑文件 |     | Ctrl + F4 | Command+W |
| 在 Debug 模式下，<br>设置光标当前行为断点，如果当前已经是断点则去掉断点 |     | Ctrl + F8 | Command+F8 |
| 执行 Make Project 操作 |     | 无   | 无   |
| 选中文件 / 文件夹，<br>使用助记符设定 / 取消书签 |     | Ctrl + F11 | Option+F3 |
| 弹出当前文件结构层，<br>可以在弹出的层上直接输入，进行筛选 |     | Ctrl + F12 | Command+F12 |
| 编辑窗口切换，<br>如果在切换的过程又加按上delete，则是关闭对应选中的窗口 |     | Ctrl + Tab | Control + → |
| 智能分隔行 |     | Ctrl + Enter | Option+Enter |
| 跳到文件尾 |     | Ctrl + End | Command+↘ |
| 跳到文件头 |     | Ctrl + Home | Command+↖ |
| 基础代码补全<br>默认在 Windows 系统上被输入法占用，<br>需要进行修改，<br>建议修改为 Ctrl + 逗号 （必备） |     | Ctrl + Space | Option + Space |
| 删除光标后面的单词或是中文句 |     | Ctrl + Delete | Option+Fn+delete |
| 删除光标前面的单词或是中文句 |     | Ctrl + BackSpace | Option+delete |
| 打开项目文件 |     | Alt+1 | Command+1 |
| 显示书签 |     | Alt + 2 | Command+2 |
| 查找//@todo标签 |     | Alt + 6 | Command+6 |
| 显示类中的方法 |     | Alt + 7 | Command+7 |
| 显示类中的方法 |     | Alt + 8 | Command+8 |
| 在打开的文件标题上，弹出该文件路径 |     | Ctrl + 左键单击 | Command+左键单击 |
| 按 Ctrl 不要松开，<br>会显示光标所在的类信息摘要 |     | Ctrl + 光标定位 | Command + 光标定位 |
| 光标跳转到当前单词 / 中文句的左侧开头位置 |     | Ctrl + 左方向键 | Option+← |
| 光标跳转到当前单词 / 中文句的右侧开头位置 |     | Ctrl + 右方向键 | Option+→ |
| 等效于鼠标滚轮向前效果 |     | Ctrl + 前方向键 | 无   |
| 等效于鼠标滚轮向后效果 |     | Ctrl + 后方向键 | 无   |
|     |     |     |     |
| Alt |     |     |     |
| 显示版本控制常用操作菜单弹出层 |     | Alt + ` | Option+V |
| 弹出一个提示，<br>显示当前类的声明 / 上下文信息 |     | Alt + Q | Control+Shift+Q |
| 显示当前文件选择目标弹出层，<br>弹出层中有很多目标可以进行选择 |     | Alt + F1 | Option+F1 |
| 对于前面页面，<br>显示各类浏览器打开目标选择弹出层 |     | Alt + F2 | Option+F2 |
| 选中文本，<br>逐个往下查找相同文本，并高亮显示 |     | Alt + F3 | Command+F |
| 查找光标所在的方法 / 变量 / 类被调用的地方 |     | Alt + F7 | Option+F7 |
| 在 Debug 的状态下，<br>选中对象，弹出可输入计算表达式调试框，<br>查看该输入内容的调试结果 |     | Alt + F8 | Option+F8 |
| 定位 / 显示到当前文件的 Navigation Bar |     | Alt + Home | Command+↑ |
| 根据光标所在问题，<br>提供快速修复选择，<br>光标放在的位置不同提示的结果也不同 （必备） |     | Alt + Enter | Option+Enter |
| 代码自动生成，<br>如生成对象的 set / get 方法，<br>构造函数，toString() 等 |     | Alt + Insert | Control+Enter 或<br>Command+N |
| 按左方向切换当前已打开的文件视图 |     | Alt + 左方向键 | Control+← 或<br>Shift+Command+[ |
| 按右方向切换当前已打开的文件视图 |     | Alt + 右方向键 | Control+→ 或<br>Shift+Command+] |
| 当前光标跳转到当前文件的前一个方法名位置 |     | Alt + 前方向键 | Option+↑ |
| 当前光标跳转到当前文件的后一个方法名位置 |     | Alt + 后方向键 | Option+↓ |
| 打开项目文件 |     | Alt+1 | Command+1 |
| 显示书签 |     | Alt + 2 | Command+2 |
| 查找//@todo标签 |     | Alt + 6 | Command+6 |
| 显示类中的方法 |     | Alt + 7 | Command+7 |
| 显示类中的方法 |     | Alt + 8 | Command+8 |
| 打开版本控制器 |     | Alt + 9 | Command+9 |
| 单词自变换之代码补全 |     | Alt + / | Option+/ |
| Shift |     |     |     |
| 如果有外部文档可以连接外部文档 |     | Shift + F1 |     |
| 跳转到上一个高亮错误 或 警告位置 |     | Shift + F2 |     |
| 在查找模式下，查找匹配上一个 |     | Shift + F3 | Shift+Command+G |
| 对当前打开的文件，<br>使用新Windows窗口打开，旧窗口保留 |     | Shift + F4 |     |
| 高级修改<br>可以重命名函数方法名、变量名，文件名，函数名可以搜索引用的文件。还可以重命名标签名 |     | Shift + F6 | Shift+F6 |
| 在 Debug 模式下，<br>智能步入。<br>断点所在行上有多个方法调用，<br>会弹出进入哪个方法 |     | Shift + F7 |     |
| 在 Debug 模式下，跳出，表现出来的效果跟 F9 一样 |     | Shift + F8 |     |
| 等效于点击工具栏的 Debug 按钮 |     | Shift + F9 | Control+D |
| 等效于点击工具栏的 Run 按钮 |     | Shift + F10 | Control+R |
| 弹出书签显示层 |     | Shift + F11 | Command+F3 |
| 取消缩进 |     | Shift + Tab |     |
| 隐藏当前 或 最后一个激活的工具窗口 |     | Shift + ESC |     |
| 选中光标到当前行尾位置 |     | Shift + End | Shift+Command+→ |
| 选中光标到当前行头位置 |     | Shift + Home | Shift+Command+← |
| 开始新一行。<br>光标所在行下空出一行，光标定位到新行位置 |     | Shift + Enter |     |
| 在打开的文件名上按此快捷键，<br>可以关闭当前打开文件 |     | Shift + 左键单击 |     |
| 当前文件的横向滚动轴滚动 |     | Shift + 滚轮前后滚动 |     |
| Ctrl + Alt |     |     |     |
| 格式化代码，<br>可以对当前文件和整个包目录使用 （必备） |     | Ctrl + Alt + L | Option+Command+L |
| 优化导入的类，<br>可以对当前文件和整个包目录使用 （必备） |     | Ctrl + Alt + O |     |
| 光标所在行 或 选中部分进行自动代码缩进，<br>有点类似格式化 |     | Ctrl + Alt + I | Control+Option+I |
| 对选中的代码弹出环绕选项弹出层 |     | Ctrl + Alt + T | Option+Command+T |
| 弹出模板选择窗口，<br>讲选定的代码加入动态模板中 |     | Ctrl + Alt + J | Option+Command+J |
| 调用层次 |     | Ctrl + Alt + H | Control+Command+H |
| 在某个调用的方法名上使用会跳到具体的实现处，<br>可以跳过接口 |     | Ctrl + Alt + B | Option+Command+B |
| 快速引进变量 |     | Ctrl + Alt + V | Option+Command+V |
| 同步、刷新 |     | Ctrl + Alt + Y | Option+Command+Y |
| 打开 系统设置 |     | Ctrl + Alt + S | Command+, |
| 显示使用的地方。<br>寻找被该类或是变量被调用的地方，<br>用弹出框的方式找出来 |     | Ctrl + Alt + F7 | Option+Command+F7 |
| 切换全屏模式 |     | 无   | Control+Command+F |
| 光标所在行上空出一行，光标定位到新行 |     | Ctrl + Alt + Enter | Option+Command+Enter |
| 弹出跟当前文件有关联的文件弹出层 |     | Ctrl + Alt + Home | Control+Command+↑ |
| 类名自动完成 |     | Ctrl + Alt + Space | Control+Option+Space |
| 退回到上一个操作的地方 （必备） |     | Ctrl + Alt + 左方向键 | Option+Command+← |
| 前进到上一个操作的地方 （必备） |     | Ctrl + Alt + 右方向键 | Option+Command+→ |
| 在查找模式下，跳到上个查找的文件 |     | Ctrl + Alt + 前方向键 | Option+Command+↑ |
| 在查找模式下，跳到下个查找的文件 |     | Ctrl + Alt + 后方向键 | Option+Command+↑ |
| Ctrl + Shift |     |     | fox.风 |
| 根据输入内容查找整个项目 或 指定目录内文件 （必备） |     | Ctrl + Shift + F | Option+Command+F |
| 根据输入内容替换对应内容，<br>范围为整个项目 或 指定目录内文件 （必备） |     | Ctrl + Shift + R | Command+Shift+R |
| 自动将下一行合并到当前行末尾 （必备） |     | Ctrl + Shift + J | Control+Shift+J |
| 取消撤销 （必备） |     | Ctrl + Shift + Z | Option+Command+Z |
| 递进式取消选择代码块。<br>可选中光标所在的单词或段落，<br>连续按会在原有选中的基础上再扩展取消选中范围 （必备） |     | Ctrl + Shift + W | Option+↓ |
| 通过文件名定位<br>/ 打开文件 / 目录，<br>打开目录需要在输入的内容后面多加一个正斜杠 （必备） |     | Ctrl + Shift + N | Command+Shift+O |
| 对选中的代码进行大小写轮流转换 （必备） |     | Ctrl + Shift + U | Command+Shift+U |
| 对当前类生成单元测试类，<br>如果已经存在的单元测试类则可以进行选择 |     | Ctrl + Shift + T | Command+Shift+T |
| 复制当前文件磁盘路径到剪贴板 |     | Ctrl + Shift + C | Command+Shift+C |
| 弹出缓存的最近拷贝的内容管理器弹出层 |     | Ctrl + Shift + V | Command+Shift+V |
| 显示最近修改的文件列表的弹出层 |     | Ctrl + Shift + E | Command+Shift+E |
| 显示方法层次结构 |     | Ctrl + Shift + H | Command+Shift+H |
| 跳转到类型声明处 |     | Ctrl + Shift + B | Command+Shift+B |
| 快速查看光标所在的方法 或 类的定义 |     | Ctrl + Shift + I | Command+Y 或<br>Option+Space |
| 查找动作 / 设置 |     | Ctrl + Shift + A | Command+Shift+A |
| 代码块注释 （必备） |     | Ctrl + Shift + / | Command+Shift+/ |
| 选中从光标所在位置到它的顶部中括号位置 |     | Ctrl + Shift + [ | Option+Command+Shift+[ |
| 选中从光标所在位置到它的底部中括号位置 |     | Ctrl + Shift + ] | Option+Command+Shift+] |
| 展开所有代码 |     | Ctrl + Shift + + | Command+Shift++ |
| 折叠所有代码 |     | Ctrl + Shift + - | Command+Shift+- |
| 高亮显示所有该选中文本，按Esc高亮消失 |     | Ctrl + Shift + F7 | Command+Shift+F7 |
| 在 Debug 模式下，指定断点进入条件 |     | Ctrl + Shift + F8 | Command+Shift+F8 |
| 编译选中的文件 /包/Module |     | 无   |     |
| 编辑器最大化 |     | Ctrl + Shift + F12 | Command+Shift+F12 |
| 智能代码提示 |     | Ctrl + Shift + Space | Control+Shift+Space |
| 自动结束代码，行末自动添加分号 （必备） |     | Ctrl + Shift + Enter | Command+Shift+Enter |
| 退回到上次修改的地方 |     | Ctrl + Shift + Backspace | Command+Shift+Backspace |
| 快速添加指定数值的书签 |     | Ctrl + Shift + 1,2,3…9 |     |
| 在代码文件上，<br>光标跳转到当前单词 / 中文句的左侧开头位置，<br>同时选中该单词 / 中文句 |     | Ctrl + Shift + 左方向键 |     |
| 在代码文件上，<br>光标跳转到当前单词 / 中文句的右侧开头位置，<br>同时选中该单词 / 中文句 |     | Ctrl + Shift + 右方向键 |     |
| 在光标焦点是在工具选项卡上，<br>缩小选项卡区域 |     | Ctrl + Shift + 左方向键 |     |
| 在光标焦点是在工具选项卡上，<br>扩大选项卡区域 |     | Ctrl + Shift + 右方向键 |     |
| 光标放在方法名上，<br>将方法移动到上一个方法前面，<br>调整方法排序 |     | Ctrl + Shift + 前方向键 |     |
| 光标放在方法名上，<br>将方法移动到下一个方法前面，<br>调整方法排序 |     | Ctrl + Shift + 后方向键 |     |
| Alt + Shift |     |     |     |
| 选择 / 添加 task |     | Alt + Shift + N |     |
| 显示添加到收藏夹弹出层 |     | Alt + Shift + F |     |
| 查看最近操作项目的变化情况列表 |     | Alt + Shift + C | Option+Shift+C |
| 添加到收藏夹 |     | Alt + Shift + F | 无   |
| 查看项目当前文件 |     | Alt + Shift + I | Option+Shift+I |
| 在 Debug 模式下，<br>下一步，进入当前方法体内，<br>如果方法体还有方法，<br>则会进入该内嵌的方法中，依此循环进入 |     | Alt + Shift + F7 |     |
| 弹出 Debug 的可选择菜单 |     | Alt + Shift + F9 | Control+D |
| 弹出 Run 的可选择菜单 |     | Alt + Shift + F10 | Control+Option+R |
| 选择被双击的单词 / 中文句，<br>按住不放，<br>可以同时选择其他单词 / 中文句 |     | Alt + Shift + 左键双击 | Option+Shift+左键双击 |
| 移动光标所在行向上移动 |     | Alt + Shift + 前方向键 | Option+Shift+↑ |
| 移动光标所在行向下移动 |     | Alt + Shift + 后方向键 | Option+Shift+↓ |
| Ctrl + Shift + Alt |     |     |     |
| 介绍  |     | 快捷键 |     |
|     |     |     |     |
| 无格式黏贴 |     | Ctrl + Shift + Alt + V |     |
| 前往指定的变量 / 方法 |     | Ctrl + Shift + Alt + N | Option+Command+O |
| 打开当前项目设置 |     | Ctrl + Alt + S | Command+, |
| 复制参考信息 |     | Ctrl + Shift + Alt + C |     |
| 其他  |     |     |     |
| 跳转到下一个高亮错误 或 警告位置 （必备） |     | F2  |     |
| 在查找模式下，定位到下一个匹配处 |     | F3  | Command+G |
| 编辑源 |     | F4  |     |
| 在 Debug 模式下，<br>进入下一步，如果当前行断点是一个方法，<br>则进入当前方法体内，如果该方法体还有方法，<br>则不会进入该内嵌的方法中 |     | F7  |     |
| 在 Debug 模式下，<br>进入下一步，<br>如果当前行断点是一个方法，<br>则不进入当前方法体内 |     | F8  |     |
| 在 Debug 模式下，<br>恢复程序运行，<br>但是如果该断点下面代码还有断点则停在下一个断点上 |     | F9  | Option+Command+R |
| 添加书签 |     | F11 |     |
| 回到前一个工具窗口 |     | F12 | F3  |
| 缩进  |     | Tab |     |
| 从工具窗口进入代码文件窗口 |     | ESC |     |
| 弹出 Search Everywhere 弹出层 | 必备  | 连按两次Shift | 连按两次Shift |

参考
http://blog.csdn.net/fenglailea/article/details/12166617
http://blog.csdn.net/fenglailea/article/details/38311673
DOS批处理中%~dp0表示什么意思 - 秋水的专栏 - CSDN博客

转

# DOS批处理中%~dp0表示什么意思

2017年03月01日 08:48:54[hncsl](https://me.csdn.net/hncsl)阅读数：3529标签：[批处理](https://so.csdn.net/so/search/s.do?q=%E6%89%B9%E5%A4%84%E7%90%86&t=blog)更多

个人分类：[其它 CMD](https://blog.csdn.net/hncsl/article/category/6754639)

如果一个install.bat文件位于D:\jeesite\bin
文件内容如下：

`[[BLOCK_OPEN]][[BLOCK_OPEN]]1. 1[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]@echo off[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]2. 2[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]echo [INFO] This is a demo.[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]3. 3[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]echo [INFO] %~dp0[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]4. 4[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]pause[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]]`

运行install.bat，命令行输出如下
> [INFO] This is a demo.
> [INFO] D:\jeesite\bin\

### 即：

- %0代表文件本身
- d代表盘符
- p代表路径

扩展的选项还包括：

- %~f0 - 完整的路径+文件名

> [INFO] D:\jeesite\bin\install.bat

- %~n0 - 文件名(无扩展名)

> [INFO] install

- %~x0 - 文件扩展名

> [INFO] .bat
%~s0 - 扩充的路径只含有短名(“s”为Short，短的)
%~a0 - 将 %0 扩充到文件的文件属性(“a”为attribute，即属性)
%~t0 - 将 %0 扩充到文件的日期/时间(“t”time)
%~z0 - 将 %0 扩充到文件的大小(Size 大小)
等等

转载：http://www.jianshu.com/p/5a1a882ead95
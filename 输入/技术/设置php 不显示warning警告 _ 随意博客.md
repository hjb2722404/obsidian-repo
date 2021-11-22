设置php 不显示warning警告 | 随意博客

-  粉丝 2

- [关注]()

[![](../_resources/b9b8337aaa7f46a745fb86524ff63fbf.png)](http://www.cleey.com/User/home/id/1.html)

cleey
望着那一丝海线，若隐若现。落日下的海霞，数不尽的美，看不完的醉
设置php 不显示warning警告
1、每个文件头部加上error_reporting(0);
 2、修改php配置文件   php.ini ，找到下面这一行：
error_reporting = E_ALL | E_STRICT；
 修改参数如下：

 E_ALL - 所有的错误和警告(不包括 E_STRICT) E_ERROR - 致命性的运行时错误 E_WARNING - 运行时警告(非致命性错误) E_PARSE - 编译时解析错误 E_NOTICE - 运行时提醒(这些经常是你代码中的bug引起的，也可能是有意的行为造成的。) E_STRICT - 编码标准化警告，允许PHP建议如何修改代码以确保最佳的互操作性向前兼容性。 E_CORE_ERROR - PHP启动时初始化过程中的致命错误 E_CORE_WARNING - PHP启动时初始化过程中的警告(非致命性错) E_COMPILE_ERROR - 编译时致命性错 E_COMPILE_WARNING - 编译时警告(非致命性错) E_USER_ERROR - 用户自定义的错误消息 E_USER_WARNING - 用户自定义的警告消息 E_USER_NOTICE - 用户自定义的提醒消息 例子:error_reporting = E_ALL & ~E_NOTICE ; 显示所有的错误，除了提醒error_reporting = E_COMPILE_ERROR|E_ERROR|E_CORE_ERROR ; 仅显示错error_reporting=E_ERROR :只会报告致命性错误

[<< 上一篇 Nginx wordpress 上传图片错误](http://www.cleey.com/blog/single/id/635.html)[mysql 建表 下一篇 >>](http://www.cleey.com/blog/single/id/637.html)

[** 收藏0]()[** 赞10]()
文章标签

 [随意](http://www.cleey.com/) | Created At 2014 By William Clinton | Contact Me: 1619488373@qq.com | 蜀ICP备14002619号 | [![21.gif](../_resources/4846349eb75026468ab56a45bd302050.gif)](http://tongji.baidu.com/hm-web/welcome/ico?s=1b4a31ca21a3edb942489a8c3d360549)  [![pic.gif](../_resources/bcdd9aa92c5876f207f70567d101a896.gif)](http://www.cnzz.com/stat/website.php?web_id=1253161039)
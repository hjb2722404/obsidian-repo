Ajax上传文件/照片时报错TypeError ：Illegal invocation的解决方法-js教程-PHP中文网

[首页](https://www.php.cn/) >[web前端](https://www.php.cn/web-designer.html) >[js教程](https://www.php.cn/js-tutorial.html) > 正文

# Ajax上传文件/照片时报错TypeError ：Illegal invocation的解决方法

**转载**2019-01-10 10:14:43**0**3040

本篇文章给大家带来的内容是关于Ajax上传文件/照片时报错TypeError ：Illegal invocation的解决方法，有一定的参考价值，有需要的朋友可以参考一下，希望对你有所帮助。

问题
Ajax上传文件/照片时报错TypeError ：Illegal invocation
![1547086027219617.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107134043.png)
**解决**
网上搜索问题，错误原因可能有以下几个，依次检查：
1. 请求类型有误，如post请求，但在后台设置的是get请求
2. 参数有误。 如没有传参，或是参数对应不上去
3. File类型的参数被预先处理了
检查后发现应该时原因3，故修改代码，设置$.ajax的processData: false：
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
[object Object]
[object Object][object Object][object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]
以上就是Ajax上传文件/照片时报错TypeError ：Illegal invocation的解决方法的详细内容，更多请关注php中文网其它相关文章！
[**微信](Ajax上传文件_照片时报错TypeError%20：Illegal%20invocation的解决方法-j.md#)
[**分享](Ajax上传文件_照片时报错TypeError%20：Illegal%20invocation的解决方法-j.md#)
.
![](../_resources/6096a4d5b74554d2e574a7520875cb34.png)

相关标签：[ajax](https://www.php.cn/search?word=ajax)  [jquery](https://www.php.cn/search?word=jquery)  [javascript](https://www.php.cn/search?word=javascript)

本文转载于：segmentfault，如有侵犯，请联系a@php.cn删除

- 上一篇：[有命名空间的事件监听器nsevent的详细介绍（代码示例）](https://www.php.cn/js-tutorial-414258.html)
- 下一篇：[JavaScript实现promise的方法（代码示例）](https://www.php.cn/js-tutorial-414260.html)

相关文章
相关视频

* * *

- [使用ajaxfileupload.js实现ajax...](https://www.php.cn/js-tutorial-12219.html)
- [ajax上传时参数提交不更新等相关问题_基础知识](https://www.php.cn/js-tutorial-18349.html)
- [Yii2实现ajax上传图片插件用法_PHP](https://www.php.cn/php-weizijiaocheng-49292.html)
- [PHP和AJAX上传文件](https://www.php.cn/php-notebook-94924.html)
- [Yii2实现ajax上传图片插件用法，](https://www.php.cn/php-notebook-161993.html)
- [node.js 通过ajax上传图片](https://www.php.cn/php-notebook-162377.html)
- [PHP Ajax上传文件实例[ajaxfileup...](https://www.php.cn/php-notebook-172659.html)
- [Ajax上传文件/照片时报错TypeError ：...](https://www.php.cn/js-tutorial-414259.html)
- [PHP 新手入门之AJAX 简介](https://www.php.cn/code/292.html)
- [PHP 新手入门之AJAX与PHP](https://www.php.cn/code/296.html)
- [AJAX与XML](https://www.php.cn/code/298.html)
- [AJAX实时搜索](https://www.php.cn/code/300.html)
- [AJAXRSS](https://www.php.cn/code/303.html)

网友评论
文明上网理性发言，请遵守 [新闻评论服务协议](Ajax上传文件_照片时报错TypeError%20：Illegal%20invocation的解决方法-j.md#)
[我要评论](Ajax上传文件_照片时报错TypeError%20：Illegal%20invocation的解决方法-j.md#)

## 专题推荐

- [![5d1ef1e9e866e635.jpg](../_resources/cb2dfe7fac00836fd2117e5ebed73e34.jpg)](https://www.php.cn/map/dugu.html)[独孤九贱-php全栈开发教程](https://www.php.cn/map/dugu.html)

全栈 ** 100W+
主讲：Peter-Zhu 轻松幽默、简短易学，非常适合PHP学习入门

- [![5d1ef236ca878949.jpg](../_resources/ebbdbb345fd86317a160dc874640da41.jpg)](https://www.php.cn/map/yunv.html)[玉女心经-web前端开发教程](https://www.php.cn/map/yunv.html)

入门 ** 50W+
主讲：灭绝师太 由浅入深、明快简洁，非常适合前端学习入门

- [![5d1ef2477c7d7587.jpg](../_resources/b731add08f26eddfa5985d0e039d25c4.jpg)](https://www.php.cn/toutiao-409221.html)[天龙八部-实战开发教程](https://www.php.cn/toutiao-409221.html)

实战 ** 80W+
主讲：西门大官人 思路清晰、严谨规范，适合有一定web编程基础学习
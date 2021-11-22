jquery cookie插件用法

# jquery cookie插件用法

jquery插件

* * *

插件的下载地址及英文说明：[jquery cookie on git hub](https://github.com/carhartl/jquery-cookie)

1、引入插件：

	<script src="js/jquery.cookie.js"></script>

2、设置cookie

	$.cookie('name', 'value');

3、设置有存储时间限制的cookie，例如保持7天：

	$.cookie('name', 'value', { expires: 7 });

4、设置cookie在整个站点根目录下有效：

	$.cookie('name', 'value', { expires: 7, path: '/' });

5、给定cookie名称读取对应cookie：

	$.cookie('name');

6、读取所有的cookie记录：

	$.cookie();

	注：这里返回的是一个对象，可使用console.log($.cookie());输出到浏览器控制台

7、删除cookie：

	$.removeCookie('name');

需要注意的是，如果你的cookie设置了有效路径，则使用相同设置才能删除：

	$.removeCookie('name', { path: '/' });

8、一些配置：
自动编码转换：

	$.cookie.raw = true;

自动实现json与string之间的转换：

	$.cookie.json = true;

[markdownFile.md](../_resources/c286b868abed2a80ff2359e7f333e9e1.bin)
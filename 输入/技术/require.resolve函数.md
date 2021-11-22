require.resolve函数

# require.resolve函数

nodejs函数
在Node.js中，可以使用require.resolve函数来查询某个模块文件的带有完整绝对路径的文件名，代码如下所示。

	require.resolve('./testModule.js');

在这行代码中，我们使用require.resolve函数来查询当前目录下testModule.js模块文件的带有完整绝对路径的模块文件名。
**注意**：使用require.resolve函数查询模块文件名时并不会加载该模块。
[markdownFile.md](../_resources/974cf5834939ff6c768c2ac35c002028.bin)
js中的Error对象

# js中的Error对象

javascript内置对象

* * *

在js中，有一个Error对象，我们通常可以用它来设置错误信息，或者设置异常捕捉。
Error对象的使用方法：

	var newErrorObj = new Error();
	var newErrorObj = new Error(number);
	var newErrorObj = new Error(
	  number,
	  description
	);

	//参数说明：
	//number:与错误相联的数字值。如果省略则为零。
	//description是描述错误的简短字符串。如果省略则为空字符串。

每当产生运行时错误，就产生 Error 对象的一个实例以描述错误。该实例有两个固有属性保存错误的描述（description 属性）和错误号（number 属性）。

错误号是 32 位的值。高 16 位字是设备代码，而低16位字是实际的错误代码。
Error 对象也可以用如上所示的语法显式创建，或用 throw 语句抛掉。在两种情况下，都可以添加选择的任何属性，以拓展 Error 对象的能力。
典型地，在 try...catch 语句中创建的局部变量引用隐式创建的 Error 对象。因此，可以按选择的任何方法使用错误号和描述。
下面的例子演示了隐式创建 Error 对象的使用：

	try
	{
	x = y                           // 产生错误。
	}catch(e){                         // 创建局部变量 e。
	  response.write(e)                  // 打印 "[objecError]".
	  response.write(e.number & 0xFFFF)  // 打印 5009。
	  response.write(e.description)      // 打印 "'y' isundefined".
	}

[markdownFile.md](../_resources/313c4f6838bd2ed75e3c943f04cb60e5.bin)
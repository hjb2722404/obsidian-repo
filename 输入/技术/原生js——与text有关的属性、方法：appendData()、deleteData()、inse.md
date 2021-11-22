原生js——与text有关的属性、方法：appendData()、deleteData()、insertData()、createTextNode()、splitText()……_代码小宝宝的博客-CSDN博客

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' style='display: none%3b' data-evernote-id='1364' class='js-evernote-checked'%3e %3cpath stroke-linecap='round' d='M5%2c0 0%2c2.5 5%2c5z' id='raphael-marker-block' style='-webkit-tap-highlight-color: rgba(0%2c 0%2c 0%2c 0)%3b' data-evernote-id='1365' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)

-

## 原生js——与text有关的属性、方法

-

##### 1.属性、属性值：

- **.nodeType**：；
- **.nodeName**：#text；
- **.nodeValue (也可以通过data属性来访问 )**：标签里面的文本内容；
- **.parentNode**：Element；
- **无子节点**；

 若要查看其他属性值，直接在控制台输出即可；

##### 2.方法：

- **appendData( textContent )**：在节点末尾插入指定的文本内容；
- **deleteData( index，count )**：从索引为index的位置开始删除count个字符；
- **insertData( index，textContent )**：在索引为index的位置上插入文本内容；
- **replaceData( index，count，textContent )**：用 textContent 替换从index指定的位置开始到 (offset + count) 止的文本；
- **splitText( index )**：从索引为index的位置将该文本节点分割成两个文本节点；
- **normalize**：规范化文本节点（将相邻的文本节点合并成一个文本节点），这个方法不是文本节点自身的，而是文本节点的父级元素的。
- **substringDate( index, count )**：提取从index指定的位置开始到(index + count)为止的字符串；

注:一个标签只有一个文本节点（ 但动态添加文本节点则不同 ）

	*<!--有一个空格，有一个文本节点-->*
		<p> </p>

- 1
- 2

	*<!--包含空格，包含文本，有一个文本节点-->*
		<p>有一个  文本节点；</p>

- 1
- 2

	*<!--空标签，无文本节点-->*
		<p></p>

- 1
- 2

举例：

		<div>哈哈哈哈</div>

- 1

		var div = document.querySelector("div");
		 *//这里缺少一行代码，控制台会报一个错误；*
		console.log(div.nodeValue);
		div.appendData("原来是这样");
		console.log(div.nodeValue);

- 1
- 2
- 3
- 4
- 5

输出的结果:( 因为我们获取到的是元素节点div，而非文本节点，望牢记：获取元素节点的文本节点一般情况就是.firstChild； )
 ![20190226133045374.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131923.jpg)所以，完整的代码如下：

		var div = document.querySelector("div");
		var divText = div.firstChild; *//这一步至关重要,要留心,不然就会发生以上的错误;*
		console.log(divText.nodeValue);
		divText.appendData("原来是这样");
		console.log(divText.nodeValue);

- 1
- 2
- 3
- 4
- 5

结果如下：
 ![20190226133531419.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131929.jpg)

###### 扩展：

注意文本中的转义字符( 跟文档类型的编码有关 )：

		divText.data = "<p>有 空格</p>";
		console.log( divText.data);

- 1
- 2

可能看到以下两种结果：

- 第一种：原样输出![20190226135044270.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131933.jpg)

- 第二种：转义后输出

 ![20190226135506361.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131939.jpg)
查看更多的转义字符，可参考该链接：

 [link（http://tool.oschina.net/commons?type=2）](http://tool.oschina.net/commons?type=2)

- **结束语…………………………福利时间到………………………………**

大家同为程序员，在这里给大家真诚的送上福利。

[福利链接点击这里！](https://m.tb.cn/h.V3sunkz?sm=6568e1)
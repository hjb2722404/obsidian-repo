将HTML字符转换为DOM节点并动态添加到文档中 - 掘金

# 将HTML字符转换为DOM节点并动态添加到文档中

将字符串动态转换为DOM节点，在开发中经常遇到，尤其在模板引擎中更是不可或缺的技术。 字符串转换为DOM节点本身并不难，本篇文章主要涉及两个主题：
> 1 字符串转换为HTML DOM节点的基本方法及性能测试
> 2 动态生成的DOM节点添加到文档中的方法及性能测试
本文的示例： 有如下代码段

	Html<!DOCTYPE html>
	<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	    <title>Document</title>
	</head>
	<body>
	    <div id='container'>
	<!-- 动态添加div
	    <div class='child'> XXX</div>
	 -->
	    </div>
	</body>
	</html>
	复制代码

任务是编写一个JavaScript函数，接收一个文本内容，动态生成一个包含该文本的div，返回该Node。

# 1.1 动态创建Node

## 1.1.1 innerHTML

第一种方法，我们使用document.createElement方法创建新的元素，然后利用innerHTML将字符串注入进去，最后返回firstChild，得到动态创建的Node。

	Html  <script>
	        function createNode(txt) {
	            const template = `<div class='child'>${txt}</div>`;
	            let tempNode = document.createElement('div');
	            tempNode.innerHTML = template;
	            return tempNode.firstChild;
	        }
	        const container = document.getElementById('container');
	        container.appendChild(createNode('hello'));

	    </script>
	复制代码

下面我们看第二种方法

## 1.1.2 DOMParser

DOMParser 实例的parseFromString方法可以用来直接将字符串转换为document 文档对象。有了document之后，我们就可以利用各种DOM Api来进行操作了。

	Javascript  function createDocument(txt) {
	            const template = `<div class='child'>${txt}</div>`;
	            let doc = new DOMParser().parseFromString(template, 'text/html');
	            let div = doc.querySelector('.child');
	            return div;
	        }

	        const container = document.getElementById('container');
	        container.appendChild(createDocument('hello'));
	复制代码

## 1.1.2 DocumentFragment

DocumentFragment 对象表示一个没有父级文件的最小文档对象。它被当做一个轻量版的 Document 使用，用于存储已排好版的或尚未打理好格式的XML片段。最大的区别是因为DocumentFragment不是真实DOM树的一部分，它的变化不会引起DOM树的重新渲染的操作(reflow) ，且不会导致性能等问题。

利用document.createRange().createContextualFragment方法，我们可以直接将字符串转化为DocumentFragment对象。

	Javascript function createDocumentFragment(txt) {
	            const template = `<div class='child'>${txt}</div>`;
	            let frag = document.createRange().createContextualFragment(template);
	            return frag;
	        }

	        const container = document.getElementById('container');
	        container.appendChild(createDocumentFragment('hello'));
	复制代码

这里要注意的是我们直接将生成的DocumentFragment对象插入到目标节点中，这会将其所有自己点插入到目标节点中，不包含自身。我们也可以使用

	Javascriptfrag.firstChild
	复制代码

来获取生成的div。

## 1.1.3 性能测试

下面我们来简单比对下上面三种方法的性能,只是测试生成单个节点，在实际使用中并不一定有实际意义。
先测试createNode。

	Javascript  function createNode(txt) {
	            const template = `<div class='child'>${txt}</div>`;

	            let start = Date.now();
	            for (let i = 0; i < 1000000; i++) {
	                let tempNode = document.createElement('div');
	                tempNode.innerHTML = template;
	                let node = tempNode.firstChild;
	            }
	            console.log(Date.now() - start);

	        }
	        createNode('hello');
	复制代码

测试100万个Node生成，用时 **6322**。
再来测试createDocument。

	Javascript    function createDocument(txt) {
	            const template = `<div class='child'>${txt}</div>`;
	            let start = Date.now();
	            for (let i = 0; i < 1000000; i++) {
	                let doc = new DOMParser().parseFromString(template, 'text/html');
	                let div = doc.firstChild;
	            }
	            console.log(Date.now() - start);
	        }
	    createDocument('hello');
	复制代码

测试100万个Node生成，用时 **55188**。
最后来测试createDocumentFragment.

	Javascript function createDocumentFragment(txt) {
	            const template = `<div class='child'>${txt}</div>`;
	            let start = Date.now();
	            for (let i = 0; i < 1000000; i++) {
	            let frag = document.createRange().createContextualFragment(template);
	            }
	            console.log(Date.now() - start);
	        }
	        createDocumentFragment();
	复制代码

测试100万个Node生成，用时 **6210**。
createDocumentFragment方法和createNode方法，在这轮测试中不相上下。下面我们看看将生成的DOM元素动态添加到文档中的方法。

## 1.2.0 批量添加节点

被动态创建出来的节点大多数情况都是要添加到文档中，显示出来的。下面我们来介绍并对比几种常用的方案。 下面我们批量添加的方法都采用createDocumentFragment方法。

## 1.2.1 直接append

直接append方法，就是生成一个节点就添加到文档中，当然这会引起布局变化，被普遍认为是性能最差的方法。

	Javascript const template = "<div class='child'>hello</div>";

	        function createDocumentFragment() {

	            let frag = document.createRange().createContextualFragment(template);
	            return frag;
	        }
	        // createDocumentFragment();
	        const container = document.getElementById('container');
	        let start = Date.now();
	        for (let i = 0; i < 100000; i++) {
	            container.appendChild(createDocumentFragment());
	        }
	        console.log(Date.now() - start);
	复制代码

上面的代码我们测算动态添加10万个节点。结果如下：

[1](../_resources/cd3e747b686d80f4fc15bd1297140f29.webp)

测试1000个节点耗时20毫秒，测试10000个节点耗时10001毫秒，测试100000个节点耗时46549毫秒。

## 1.2.2 DocumentFragment

上面我们已经介绍过DocumentFragment了，利用它转换字符串。下面我们利用该对象来作为临时容器，一次性添加多个节点。
利用document.createDocumentFragment()方法可以创建一个空的DocumentFragment对象。

	Javascript
	        const template = "<div class='child'>hello</div>";

	        function createDocumentFragment() {

	            let frag = document.createRange().createContextualFragment(template);
	            return frag;
	        }
	        // createDocumentFragment();
	        const container = document.getElementById('container');
	        let fragContainer = document.createDocumentFragment();
	        let start = Date.now();
	        for (let i = 0; i < 1000; i++) {
	            fragContainer.appendChild(createDocumentFragment());
	        }
	        container.appendChild(fragContainer);
	        console.log(Date.now() - start);
	复制代码

测试1000个节点耗时25毫秒，10000个节点耗时2877毫秒，100000个节点浏览器卡死。

## 1.3 小结

简单了介绍了几种方法，并没有什么技术含量。但是从动态添加节点来看，网上说的DocumentFragment方法性能远远好于直接append的说法在我的测试场景中并不成立。

DocumentFragment正确的应用场景应该是作为虚拟DOM容器，在频繁修改查询但是并不需要直接渲染的场景中。
更多精彩内容，请关注 微信订阅号“玄说前端”
[1](../_resources/f65e0c26d6efa7b7f554f82aeab7fd23.webp)
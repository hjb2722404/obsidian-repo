Element和Node的区别你造吗？

# Element和Node的区别你造吗？

[[webp](../_resources/f53071d3dcbfda3e923468a8067447d8.webp)](https://www.jianshu.com/u/991161da1503)

[Pursue](https://www.jianshu.com/u/991161da1503)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='275'%3e%3cpath d='M751.144277 307.2l-123.016533-238.933333h159.778133a81.92 81.92 0 0 1 59.1872 25.258666l160.256 167.492267A27.306667 27.306667 0 0 1 987.620011 307.2h-236.475734z m270.506667 111.547733L640.927744 946.039467a27.306667 27.306667 0 0 1-48.128-24.234667L766.504277 375.466667h-56.388266l-170.5984 590.165333a27.306667 27.306667 0 0 1-52.462934 0.034133L315.500544 375.466667H259.112277l174.523734 545.5872a27.306667 27.306667 0 0 1-48.128 24.302933L5.160277 418.747733A27.306667 27.306667 0 0 1 27.346944 375.466667H999.464277a27.306667 27.306667 0 0 1 22.152534 43.281066zM18.301611 261.0176L178.557611 93.525333A81.92 81.92 0 0 1 237.744811 68.266667h159.744L274.506411 307.2H38.030677a27.306667 27.306667 0 0 1-19.729066-46.1824zM453.877077 68.266667h117.896534l122.9824 238.933333H330.894677l122.9824-238.933333z' data-evernote-id='158' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*0.7992016.09.21 14:26:38字数 648阅读 6,585

### 1.写在前面

> 我们经常使用document.getElementById去获取DOM中的元素，也会使用childNodes来获取子节点。那么Element和Node的区别是什么？而什么又是HTMLCollection,HTMLElement,和NodeList呢？

#### 一个简单的页面：

	<html>
	  <body>
	    <h1>China</h1>
	    <!-- My comment ...  -->
	    <p>China is a popular country with...</p>
	    <div>
	      <button>See details</button>
	    </div>
	  </body>
	</html>
	
	1234567891011

`body`里的直系子元素一共有三个：`h`,`p`,`div`。我们可以用`document.body.childNodes`查看, 结果如下:
![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/nodelist.png)
问题来了：

- 1.这么会有这么多的#text？
- 2.注释算节点？

在回答上面两个问题之前，就有必要理解下什么是`Node`了。

### 2.Node vs Elemet

以下摘自MDN:

> A Node is an interface from which a number of DOM types inherit, and allows these various types to be treated (or tested) similarly.

> The following interfaces all inherit from Node its methods and properties: Document, Element, CharacterData (which Text, Comment, and CDATASection inherit), ProcessingInstruction, DocumentFragment, DocumentType, Notation, Entity, EntityReference.

简单的说就是`Node`是一个基类，DOM中的`Element`，`Text`和`Comment`都继承于它。
换句话说，`Element`，`Text`和`Comment`是三种特殊的`Node`，它们分别叫做`ELEMENT_NODE`,
`TEXT_NODE`和`COMMENT_NODE`。
***所以我们平时使用的html上的元素，即Element是类型为`ELEMENT_NODE`的`Node`。***
利用`nodeType`可以查看所有类型，如下图：
![](https://i.loli.net/2021/01/09/mxFYPeBVJow42jU.png)
到这里，我想我们就可以解释上面两个问题了。
实际上`Node`表示的是DOM树的结构，在html中，节点与节点之间是可以插入文本的，这个插入的空隙就是`TEXT_NODE`，即：

	<body>
	    we can put text here 1...
	    <h1>China</h1>
	    we can put text here 2...
	    <!-- My comment ...  -->
	    we can put text here 3...
	    <p>China is a popular country with...</p>
	    we can put text here 4...
	    <div>
	      <button>See details</button>
	    </div>
	    we can put text here 5 ...
	</body>
	12345678910111213

这下就顺理成章了，body的直系元素（3）＋ COMMENT_NODE(1) + TEXT_NODE(5) = 9

### 3.NodeList vs HTMLCollection

我们用`childNodes`找到了`NodeList`，但我们操作DOM时往往不想操作`Node`(我只想操作元素Element)，那么如何获取ElementList呢？

其实我们经常使用的`getElementsByXXX`返回的就是一个ElementList，只不过它的真实名字是`ElementCollection`。
就像`NodeList`是`Node`的集合一样，`ElementCollection`也是`Element`的集合。但需要特别注意的是：
***NodeList和ElementCollcetion都不是真正的数组***
如果`document.getElementsByTagName('a') instanceof Array`，那么必然是`false`。

### 4.写在最后

DOM(Document Object Model)简称文档对象模型，它是html和xml是文档编程的接口，它将文档解析为树结构，这个树的根部就是`document`,而`document`的第一个子节点(childeNodes[0])就是html，这才有了后面的一系列html元素。

最后附一张DOM图，此刻再看这张图是不是觉得回味无穷咧。
![](https://i.loli.net/2021/01/09/32xnwY5WpjDrGv1.png)
参考资料：

1.[Node vs Element](https://link.jianshu.com/?t=.http://stackoverflow.com/questions/9979172/difference-between-node-object-and-element-object)

2.[DOM](https://link.jianshu.com/?t=https://developer.mozilla.org/zh-CN/docs/Web/API/Document_Object_Model/Introduction)

3.[Node](https://link.jianshu.com/?t=https://developer.mozilla.org/zh-CN/docs/Web/API/Node)

4.[NodeList](https://link.jianshu.com/?t=https://developer.mozilla.org/zh-CN/docs/Web/API/NodeList)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='511'%3e%3cpath d='M728.064 343.943529c-17.648941-2.891294-23.552-20.239059-26.503529-28.912941V104.026353C701.560471 46.200471 654.396235 0 595.425882 0c-53.007059 0-97.28 40.478118-106.134588 89.569882-29.997176 184.862118-138.541176 255.457882-217.630118 280.937412a26.142118 26.142118 0 0 0-18.130823 24.877177v560.067764c0 19.817412 16.022588 35.84 35.84 35.84h535.973647c56.018824-11.565176 94.328471-31.804235 120.892235-86.738823l120.832-416.105412c23.552-75.173647-14.757647-147.395765-100.231529-144.564706h-238.772706z m-571.813647 31.744H76.619294C35.358118 375.687529 0 410.383059 0 450.861176v462.426353c0 43.369412 32.406588 78.004706 76.619294 78.004706h79.631059c27.708235 0 50.115765-22.407529 50.115765-50.115764V425.863529a50.115765 50.115765 0 0 0-50.115765-50.115764z' data-evernote-id='152' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

17人点赞*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='64 64 896 896' focusable='false' class='js-evernote-checked' data-icon='right' width='1em' height='1em' fill='currentColor' aria-hidden='true' data-evernote-id='515'%3e%3cpath d='M765.7 486.8L314.9 134.7A7.97 7.97 0 0 0 302 141v77.3c0 4.9 2.3 9.6 6.1 12.6l360 281.1-360 281.1c-3.9 3-6.1 7.7-6.1 12.6V883c0 6.7 7.7 10.4 12.9 6.3l450.8-352.1a31.96 31.96 0 0 0 0-50.4z' data-evernote-id='516' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='520'%3e%3cpath d='M771.413333 668.728889c-18.773333 3.015111-25.031111 20.878222-28.16 29.866667v217.884444c0 59.733333-49.948444 107.52-112.412444 107.52a115.427556 115.427556 0 0 1-112.412445-92.558222c-31.857778-190.919111-146.830222-263.850667-230.627555-290.133334a27.420444 27.420444 0 0 1-19.228445-26.168888V37.944889C268.572444 17.066667 285.582222 0 306.631111 0h567.864889c59.335111 11.946667 99.953778 32.824889 128 89.543111l128.113778 429.909333c24.974222 77.653333-15.644444 152.291556-106.211556 149.276445H771.413333z m-605.866666-32.824889H81.180444C37.546667 635.904 0 600.064 0 558.250667V80.611556C0 35.84 34.360889 0 81.180444 0H165.546667c29.297778 0 53.077333 23.779556 53.077333 53.077333v529.749334a53.077333 53.077333 0 0 1-53.077333 53.077333z' data-evernote-id='131' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

[*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='525'%3e%3cpath d='M178.390055 120.591045C111.268624 120.591045 56.888889 174.401955 56.888889 240.556383V903.97778C56.888889 970.302855 111.097977 1024 178.390055 1024h545.731364c67.121431 0 121.558049-53.81091 121.558049-120.02222V240.613265c0-66.268192-54.209088-120.02222-121.558049-120.02222H178.390055z m455.117432 301.136319H269.06087a30.147761 30.147761 0 0 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z m303.18409 301.136318a30.318409 30.318409 0 0 1-30.375291-30.318409V180.317742c0-66.268192-53.81091-120.02222-121.330519-120.022219H329.697688a30.147761 30.147761 0 0 1 0-60.23864l454.946784 0.056882C885.326618 0.113765 967.009987 80.887013 967.009987 180.602155v511.943118a30.318409 30.318409 0 0 1-30.31841 30.318409z m-303.18409-120.47728H269.06087a30.147761 30.147761 0 1 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z' data-evernote-id='142' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*Coding](https://www.jianshu.com/nb/1164921)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='531'%3e%3cpath d='M232.727273 579.87878833C271.28679 579.87878833 302.545455 548.62012233 302.545455 510.06060633 302.545455 471.50108933 271.28679 440.24242433 232.727273 440.24242433 194.167756 440.24242433 162.909091 471.50108933 162.909091 510.06060633 162.909091 548.62012233 194.167756 579.87878833 232.727273 579.87878833ZM512 579.87878833C550.559516 579.87878833 581.818182 548.62012233 581.818182 510.06060633 581.818182 471.50108933 550.559516 440.24242433 512 440.24242433 473.440484 440.24242433 442.181818 471.50108933 442.181818 510.06060633 442.181818 548.62012233 473.440484 579.87878833 512 579.87878833ZM791.272727 579.87878833C829.832243 579.87878833 861.090909 548.62012233 861.090909 510.06060633 861.090909 471.50108933 829.832243 440.24242433 791.272727 440.24242433 752.713211 440.24242433 721.454545 471.50108933 721.454545 510.06060633 721.454545 548.62012233 752.713211 579.87878833 791.272727 579.87878833Z' data-evernote-id='162' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

"打赏10毛？"
还没有人赞赏，支持一下

[[webp](../_resources/e523d82dfe8242f4c8708f55e5e9001b.webp)](https://www.jianshu.com/u/991161da1503)

[Pursue](https://www.jianshu.com/u/991161da1503)－ 就职于ThoughtWorks，一直在全栈开发的道路上，摸爬滚打，痛，并快乐着。

－...
总资产9 (约0.93元)共写了3.6W字获得416个赞共297个粉丝
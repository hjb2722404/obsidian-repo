关于VirtualDom的知识点 - 掘金

[(L)](https://juejin.im/user/1626932938545502)

[ 李赫feixuan   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/1626932938545502)

2019年02月12日   阅读 122

# 关于VirtualDom的知识点

### 记录一个前端大神的笔记，逐步学习

### 原文 [github.com/livoras/blo…](https://github.com/livoras/blog/issues/13)

### 故事

作为React的核心概念之一，virtual dom从某种意义上改变了前端的现有体系。大部分人把virtual dom当做一种性能提升策略，因为它可以有效的减少直接操作DOM带来的消耗，从而提升脚本的执行效率。但是实际上，virtual dom并不完全是避免DOM操作的消耗，有的情况下，直接操作DOM可能来的更快，而virtual dom的真正意义，在于把直接的DOM操作和js编程，提炼成一个抽象层，virtual dom是对js操作DOM的抽象，对于今后的前端编程而言，developer无需再直接操作DOM，而是通过virtual dom去操作，这是它真正的意义。

### VirtualDom真的快吗

VirtualDom最常被提及的优势就是它的效率高，原因是对js对象的操作要比对原生dom的操作要快很多，有了虚拟dom，我们更新视图前可以比较两颗虚拟dom树的差异，只更新差异部分，减少了对真正dom节点的操作，所以提高了效率。 然而事实上是不一定的，我们必须知道建立虚拟dom树本身和比较差异都是需要消耗时间的，如果不采用virtualdom，我们更新视图一般用innerHtml方法。这两种方法的更新时间可以粗略表示如下：

innerHtml:渲染成htmlstring + 重新创建所有dom
VirtualDom:渲染成VirtualDom + 比较新旧Dom树差异 + 必要dom更新

所以两者的快慢实际取决于需要渲染的界面大小和更新部分的多少，可以看出innerHtml这种重新创建所有的dom的方式在只有几行数据改变时可能会造成大量浪费，所以从整体来看VirtualDom更优，但如果只是渲染静态界面，则innerHtml反而更快。

### VirtualDom实现

一个简单VirtualDom机制，只需分为3个部分，第一步是建立VirtualDom树，第二步是设计比较新旧两个树之间差异的算法，最后一步是将差异更新到真正的视图部分。

### 创建VirtualDom树

一般情况下我们可以将DOM树表示为一个JavaScript的Object对象，如下有一颗DOM树

	<ul id='list'>
	    <li class='item'>Item 1</li>
	    <li class='item'>Item 2</li>
	    <li class='item'>Item 3</li>
	</ul>复制代码

该DOM树对应的JS对象如下：

	var element = {
	    tagName: 'ul', // 节点标签名
	    props: { // DOM的属性，用一个对象存储键值对
	        id: 'list'
	    },
	    children: [ // 该节点的子节点
	        {tagName: 'li', props: {class: 'item'}, children: ["Item 1"]},
	        {tagName: 'li', props: {class: 'item'}, children: ["Item 2"]},
	        {tagName: 'li', props: {class: 'item'}, children: ["Item 3"]},
	    ]
	}复制代码

两相比较，我们可以发现，我们将DOM中的任一元素表示为：
`{ type: ‘…’, props: { … }, children: [ … ] }复制代码`
而DOM中的纯文本节点会被表示为普通的JavaScript中的字符串。不过这还是一个简单的DOM树，如果是一个较大型的树，我们就需要一个辅助函数来构造结构

	function Element(tagName,props,children){
	    this.tagName=tagName
	    this.props=props
	    this.children=children
	}复制代码

我们用上面的构造函数来完成DOM数

	const ul = new Element('ul',{id:'list'},[
	    new Element('li',{class:'item'},['item 1']),
	    new Element('li',{class:'item'},['item 1']),
	    new Element('li',{class:'item'},['item 1'])
	])复制代码

我们再来编写一个方法，来真正的渲染DOM

	Element.prototype.render=function(){
	    // 根据tagName构建
	    var el = document.createElement(this.tagName)
	    var props = this.props
	    // 设置节点的DOM属性
	    for (var propName in props) {
	        var propValue = props[propName]
	        el.setAttribute(propName, propValue)
	    }

	    var children = this.children || []

	    children.forEach(function (child) {
	        var childEl = (child instanceof Element)
	            ? child.render() // 如果子节点也是虚拟DOM，递归构建DOM节点
	            : document.createTextNode(child) // 如果字符串，只构建文本节点
	        el.appendChild(childEl)
	    })

	    return el
	}复制代码

这时，我们再把ul插入到真正的节点中：

	const rootEl = ul.render()
	document.body.appendChild(rootEl)复制代码

### 比较两棵虚拟DOM树的差异

比较两棵DOM树的差异是 Virtual DOM 算法最核心的部分，这也是所谓的 Virtual DOM 的 diff 算法。两个树的完全的 diff 算法是一个时间复杂度为 O(n^3) 的问题。但是在前端当中，你很少会跨越层级地移动DOM元素。所以 Virtual DOM 只会对同一个层级的元素进行对比
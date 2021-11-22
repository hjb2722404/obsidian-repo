前端应该知道的Web Components - 潇湘待雨 - 博客园

#   [前端应该知道的Web Components](https://www.cnblogs.com/pqjwyn/p/7401918.html)

## 前端组件化的痛点

在前端组件化横行的今天，确实极大的提升了开发效率。不过有一个问题不得不被重视，拟引入的这些html、css、js代码有可能对你的其他代码造成影响。
虽然我们可以通过命名空间、闭包等一系列措施来加以防备，不过还是存在这些隐患。为了解决这些问题，有一个基本大家遗忘的技术还是可以了解一下的，
那就是Web Components。

## Web Components 是什么

Web Components是一个浏览器的新功能，提供了一个面向web包括下面几个方面标准的组件模型。
你可以认为Web Components是一个可复用的用户接口部件，
属于浏览器的一部分，所以不需要一些额外的例如jQuery或者Dojo之类的工具库。
一个存在的Web Components的使用完全不需要写代码，
仅仅需要在HTML中加一个import 语句就可以了。
Web Components使用了一些新颖并且在开发中的浏览器功能。
上面提到的部分当前在浏览器中可以正常的运行，但是有好多Web Components可以用来创造的部分没有被提及。
使用Web Components 你几乎可以来做任何可以使用HTML,CSS,JS能做到的事情，并且可以更便捷的被复用。
有时候关于Web Components和谷歌的plymer之间可能会存在一些困惑
简介而论，Polymer是基于Web Components技术的一个框架，你当然可以在不适用其的情况下开发Web Components

#### Web Components浏览器支持性

Web Components并没有被所有浏览器来实现(截止2017年chrome已经完全支持，其他浏览器还在投票表决中),因此如果在不支持的浏览器上使用Web Components，

应该使用由google polymer开发的 polyfills来达到目的。使用之前最好通过[Are We Componentized Yet](http://jonrimmer.github.io/are-we-componentized-yet/)查看浏览器兼容性。

#### Web Components 包括以下四种技术(每种都可以被单独使用)

- Shadow DOM

明确的定义如下：
一种可以在document下组合多个同级别并且可以项目作用的DOM树的方法，因此可以更好完善DOM的构成

- Custom Elements

定义如下：
一种可以允许开发者在document中定义并使用的新的dom元素类型，即自定义元素

- HTML Templates

模板没什么可说了，在标准实现之前其实我们一直都在用js来实现该方式

- HTML Imports

一种允许一个html文档在别的htmldocuments中包含和复用的方法

## 明确的文档定义如下：

- 一种新的html元素: template
- 关于 template 的接口： HTMLTemplateElement, HTMLContentElement (removed from spec) and HTMLShadowElement
- HTMLLinkElement接口和 link 元素的扩展
- 注册custom elements的接口：Document.registerElement()和对Document.createElement() and Document.createElementNS()的更新
- 对html元素原型对象新增的生命周期回调
- 默认为元素对象增加的新的css的伪类：:unresolved
- The Shadow DOM：ShadowRoot and Element.createShadowRoot(), Element.getDestinationInsertionPoints(), Element.shadowRoot
- Event接口的扩展、Event.path
- Document 接口的一些扩展
- Web Components样式应用新的伪类：:host, :host(), :host-context()

## 如何使用

	接下看最直接的还是hello world 。直接上代码：

#### index.html

	   <!DOCTYPE>
	<html>
	    <head>
	        <title>webcomponent</title>
	        <link rel="import" href="./components/helloword.html" />
	    </head>
	    <body>
	        <hellow-world></hellow-world>
	    </body>
	</html>

#### helloworld.html

	    <template>
	    <style>
	        .coloured {
	            color: red;
	        }
	    </style>
	    <p>the first webcompnent is  <strong class="coloured">Hello World</strong></p>
	</template>
	<script>
	    (function() {
	        // Creates an object based in the HTML Element prototype
	        // 基于HTML Element prototype 创建obj
	        var element = Object.create(HTMLElement.prototype);
	        // 获取特mplate的内容
	        var template = document.currentScript.ownerDocument.querySelector('template').content;
	        // element创建完成之后的回调
	        element.createdCallback = function() {
	            // 创建 shadow root
	            var shadowRoot = this.createShadowRoot();
	            // 向root中加入模板
	            var clone = document.importNode(template, true);
	            shadowRoot.appendChild(clone);
	        };
	        document.registerElement('hellow-world', {
	            prototype: element
	        });
	    }());
	</script>

#### 运行结果

![790851-20170820225549115-2026210783.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231180032.jpg)

## 结束语

上面就是关于WebComponents的基本介绍了，更多请移步[webcomponent-demo](https://github.com/xiaoxiangdaiyu/webcomponent-demo)查看。

作为一个目前都没有被浏览器全部支持的技术，当然是不会被大面积推广开来的。不过它的出现还是对组件的问题带来了一定的积极影响，
假以时日，也许会被所有浏览器全面支持，成为我们常用的一种方法。
参考文章：https://github.com/w3c/webcomponents
如水穿石，厚积才可薄发

标签: [且听潇湘话前端](https://www.cnblogs.com/pqjwyn/tag/%E4%B8%94%E5%90%AC%E6%BD%87%E6%B9%98%E8%AF%9D%E5%89%8D%E7%AB%AF/)

 [好文要顶](前端应该知道的Web%20Components%20-%20潇湘待雨%20-%20博客园.md#)  [关注我](前端应该知道的Web%20Components%20-%20潇湘待雨%20-%20博客园.md#)  [收藏该文](前端应该知道的Web%20Components%20-%20潇湘待雨%20-%20博客园.md#)  [![icon_weibo_24.png](前端应该知道的Web%20Components%20-%20潇湘待雨%20-%20博客园.md#)  [![wechat.png](前端应该知道的Web%20Components%20-%20潇湘待雨%20-%20博客园.md#)

 [![20171111082827.png](../_resources/357039b9560ee31615ac58975f521030.jpg)](https://home.cnblogs.com/u/pqjwyn/)

 [潇湘待雨](https://home.cnblogs.com/u/pqjwyn/)
 [关注 - 3](https://home.cnblogs.com/u/pqjwyn/followees/)
 [粉丝 - 39](https://home.cnblogs.com/u/pqjwyn/followers/)

 [+加关注](前端应该知道的Web%20Components%20-%20潇湘待雨%20-%20博客园.md#)

 5

 0

 [«](https://www.cnblogs.com/pqjwyn/p/7350820.html) 上一篇： [Generator函数执行器-co函数库源码解析](https://www.cnblogs.com/pqjwyn/p/7350820.html)

 [»](https://www.cnblogs.com/pqjwyn/p/7507464.html) 下一篇： [移动端踩坑之旅-ios下fixed、软键盘相关问题总结](https://www.cnblogs.com/pqjwyn/p/7507464.html)

posted @ 2017-08-20 23:03 [潇湘待雨](https://www.cnblogs.com/pqjwyn/)  阅读(20555)  评论(4) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=7401918) [收藏](前端应该知道的Web%20Components%20-%20潇湘待雨%20-%20博客园.md#)
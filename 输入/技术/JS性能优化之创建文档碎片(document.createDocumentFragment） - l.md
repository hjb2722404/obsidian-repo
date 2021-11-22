JS性能优化之创建文档碎片(document.createDocumentFragment） - leejersey - 博客园

# [JS性能优化之创建文档碎片(document.createDocumentFragment）](http://www.cnblogs.com/leejersey/p/3516603.html)

讲这个方法之前，我们应该先了解下插入节点时浏览器会做什么。

         在浏览器中，我们一旦把节点添加到document.body（或者其他节点）中，页面就会更新并反映出这个变化，对于少量的更新，一条条循环插入也会运行很好，也是我们常用的方法。代码如下：

[![复制代码](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)
for(var i=0;i<5;i++)

{ var op = document.createElement("span"); var oText = document.createTextNode(i); op.appendChild(oText); document.body.appendChild(op); }

[![复制代码](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)
但是，如果当我们要向document中添加大量数据时(比如1w条)，如果像上面的代码一样，逐条添加节点，这个过程就可能会十分缓慢。

当然,你也可以建个新的节点,比如说div,先将oP添加到div上,然后再将div添加到body中.但这样要在body中多添加一个<div></div>.但文档碎片不会产生这种节点.

[![复制代码](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)
var oDiv = document.createElement("div"); for(var i=0;i<10000;i++)

{ var op = document.createElement("span"); var oText = document.createTextNode(i); op.appendChild(oText); oDiv.appendChild(op); } document.body.appendChild(oDiv);

[![复制代码](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)

为了解决这个问题，我们可以引入createDocumentFragment()方法，它的作用是创建一个文档碎片，把要插入的新节点先附加在它上面，然后再一次性添加到document中。代码如下：

代码如下:
[![复制代码](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)
//先创建文档碎片var oFragmeng = document.createDocumentFragment();
for(var i=0;i<10000;i++)

{ var op = document.createElement("span"); var oText = document.createTextNode(i); op.appendChild(oText); //先附加在文档碎片中 oFragmeng.appendChild(op); } //最后一次性添加到document中document.body.appendChild(oFragmeng);

[![复制代码](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)
经过测试，在ie，firefox下性能明显得以提高。大家可以自己测试下。
前端性能优化都是从一些细节地方做起的，如果不加以注意，后果很严重。
PS：这个优化跟循环添加html代码有点类似。

标签: [优化](http://www.cnblogs.com/leejersey/tag/%E4%BC%98%E5%8C%96/)

[好文要顶](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)[关注我](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)[收藏该文](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)[![icon_weibo_24.png](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)[![wechat.png](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)

[![20141211145528.png.jpg](../_resources/db07bcb3a8decd69dd4c9b7ae40dc21a.jpg)](http://home.cnblogs.com/u/leejersey/)

[leejersey](http://home.cnblogs.com/u/leejersey/)
[关注 - 61](http://home.cnblogs.com/u/leejersey/followees)
[粉丝 - 154](http://home.cnblogs.com/u/leejersey/followers)

 [+加关注](JS%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%88%9B%E5%BB%BA%E6%96%87%E6%A1%A3%E7%A2%8E%E7%89%87(document.createDocumentFragment%EF%BC%89%20-%20l.md#)

 2
0

(请您对文章做出评价)

[«](http://www.cnblogs.com/leejersey/p/3516480.html) 上一篇：[弹性方框模型 (Flexible Box Model) 快速入门](http://www.cnblogs.com/leejersey/p/3516480.html)

[»](http://www.cnblogs.com/leejersey/p/3517065.html) 下一篇：[可扩展的移动搜索表单](http://www.cnblogs.com/leejersey/p/3517065.html)

posted @ 2014-01-12 21:54  [leejersey](http://www.cnblogs.com/leejersey/) 阅读(1578) 评论(0) [编辑](http://i.cnblogs.com/EditPosts.aspx?postid=3516603)  [收藏](http://www.cnblogs.com/leejersey/p/3516603.html#)
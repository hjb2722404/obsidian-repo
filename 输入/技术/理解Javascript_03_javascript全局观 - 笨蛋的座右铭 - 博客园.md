理解Javascript_03_javascript全局观 - 笨蛋的座右铭 - 博客园

# [理解Javascript_03_javascript全局观](https://www.cnblogs.com/fool/archive/2010/10/08/1846078.html)

今天让我们站在语言的高度来看一下Javascript都有点什么。因为是全局性的俯瞰，所以不针对细节作详细的讲解。
先来看一张图吧：
 ![2010100817445730.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120439.png)
解释一下：
核心（ECMAScript)：定义了脚本语言的所有对象，属性和方法
文档对象模型（DOM)：HTML和XML应用程序接口
浏览器对象模型(BOM)：对浏览器窗口进行访问操作

现在来具体的讲一个各个成分：
**关于ECMAScript**
 ECMAScript的工作是定义语法和对象，从最基本的数据类型、条件语句、关键字、保留字到异常处理和对象定义都是它的范畴。
在ECMAScript范畴内定义的对象也叫做原生对象。
其实上它就是一套定义了语法规则的接口，然后由不同的浏览器对其进行实现,最后我们输写遵守语法规则的程序，完成应用开发需求。

**关于DOM**
根据DOM的定义(HTML和XML应用程序接口)可知DOM由两个部分组成，针对于XML的DOM即DOM Core和针对HTML的DOM HTML。
那DOM Core 和DOM HTML有什么区别与联系呢?

DOM Core的核心概念就是节点(Node)。DOM会将文档中不同类型的元素(这里不元素并不特指<div>这种tag,还包括属性，注释，文本之类）都看作为不同的节点。

![2010100818513177.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120442.png)
节点结构图

上图描述了DOM CORE的结构图，比较专业,来看一个简单的：
1
2
3
[object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
 来看一下这段代码在标准浏览器里的DOM表现:
![2010100819041364.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120447.png)
div和span元素被展现成了一个元素节点，对应到节点结构图中的Element元素
"hello world"和div与span之间的间隔，被展现成了文本节点，对应到节点结构图中的CharacterDate元素

DOM CORE在解析文档时，会将所有的元素、属性、文本、注释等等视为一个节点对象（或继承自节点对象的对象,多态、向上转型）,根据文本结构依次展现，最后行成了一棵"DOM树"

DOM HTML的核心概念是HTMLElement，DOM HTML会将文档中的元素（这里的元素特指<body>这种tag,不包括注释，属性，文本)都视为HTMLElement。而元素的属性，则为HTMLElement的属性。

再来看一个示例：
从Node接口提供的属性

myElement.attributes["id"].value;很明显myElement.attributes["id"]返回一个对象.value是得到对象的value属性

Element实现的方法返回
myElement.getAttributes("id");很明显此时id现在只是一个属性而已，这只是一个得到属性的操作。

其实上DOM Core和DOM html的外部调用接口相差并不是很大，对于html文档可以用DOM html进行操作，针对xhtml可以用DOM Core。

**关于BOM**
 老规则，先来一张图：
![2010100819375011.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120451.png)

 BOM与浏览器紧密结合,这些对象也被称为是宿主对象，即由环境提供的对象。

这里要强调一个奇怪的对象Global对象，它代表一个全局对象，Javascript是不允许存在独立的函数，变量和常量，如果没有额外的定义，他们都作为Global对象的属性或方法来看待.像parseInt(),isNaN(),isFinite()等等都作为Global对象的方法来看待，像Nan,Infinity等"常量"也是Global对象的属性。像Boolean,String,Number，RegExp等内置的全局对象的构造函数也是Global对象的属性.但是Global对象实际上并不存在，也就是说你用Global.NaN访问NaN将会报错。实际上它是由window来充当这个角色，并且这个过程是在javascript首次加载时进行的。

好了，好了，就到这吧，本来还有一部分，算了，以后另开一节再说吧。

分类: [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签: [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

 [好文要顶](理解Javascript_03_javascript全局观%20-%20笨蛋的座右铭%20-%20博客园.md#)  [关注我](理解Javascript_03_javascript全局观%20-%20笨蛋的座右铭%20-%20博客园.md#)  [收藏该文](理解Javascript_03_javascript全局观%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![icon_weibo_24.png](理解Javascript_03_javascript全局观%20-%20笨蛋的座右铭%20-%20博客园.md#)  [![wechat.png](理解Javascript_03_javascript全局观%20-%20笨蛋的座右铭%20-%20博客园.md#)

 [![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

 [笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
 [关注 - 3](https://home.cnblogs.com/u/fool/followees/)
 [粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

 [+加关注](理解Javascript_03_javascript全局观%20-%20笨蛋的座右铭%20-%20博客园.md#)

 11

 0

 [«](https://www.cnblogs.com/fool/archive/2010/10/07/1845253.html) 上一篇： [理解Javascript_02_理解undefined和null](https://www.cnblogs.com/fool/archive/2010/10/07/1845253.html)

 [»](https://www.cnblogs.com/fool/archive/2010/10/09/1846424.html) 下一篇： [我的getElementsByClassName实现](https://www.cnblogs.com/fool/archive/2010/10/09/1846424.html)

posted @ 2010-10-08 20:06 [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(4802)  评论(3) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1846078) [收藏](理解Javascript_03_javascript全局观%20-%20笨蛋的座右铭%20-%20博客园.md#)
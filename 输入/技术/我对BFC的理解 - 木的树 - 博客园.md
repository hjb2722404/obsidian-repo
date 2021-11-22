我对BFC的理解 - 木的树 - 博客园

#  我对BFC的理解

　　最初这篇文章打算回答寒冬大神的[第一问](http://www.weibo.com/1196343093/Bhj510t50#_loginLayer_1411048014706)，谈谈CSS布局。本来呢我以为布局主要涉及float跟display相关属性，以及他们的包含框、静态位置等等。后来看了大神的一片[面试文章](http://www.cnblogs.com/winter-cn/archive/2013/05/11/3072926.html)，嗯？这里怎么还有个BFC，这是神马东东。待我搜索一下，萨萨萨，不看不知道，越看越糊涂，这到底是个神马东东。。。经过一个周时间的查阅资料和自我思考，在此总结一下我对BFC的认识，愿与各位道友分享，欢迎拍砖！

　　对CSS有了解的道友们肯定都知道盒式模型这个概念，对一个元素设置CSS，首先需要知道这个元素是block还是inline类型。而BFC就是用来格式化块级盒子，同样管理inline类型的盒子还有IFC，以及[其他的FC](http://reference.sitepoint.com/css/blockformatting)。那首先我们就来看一下FC的概念。

　  Formatting Context：指页面中的一个渲染区域，并且拥有一套渲染规则，他决定了其子元素如何定位，以及与其他元素的相互关系和作用。

　 BFC：块级格式化上下文，它是指一个独立的块级渲染区域，只有Block-level BOX参与，该区域拥有一套渲染规则来约束块级盒子的布局，且与区域外部无关。

　　**BFC的生成**

　　既然上文提到BFC是一块渲染区域，那这块渲染区域到底在哪，它又是有多大，这些由生成BFC的元素决定，CSS2.1中规定满足下列CSS声明之一的元素便会生成BFC。

- 根元素
- float的值不为none
- overflow的值不为visible
- display的值为inline-block、table-cell、table-caption
- position的值为absolute或fixed

　　看到有道友文章中把display：table也认为可以生成BFC，其实这里的主要原因在于Table会默认生成一个匿名的table-cell，正是这个匿名的table-ccell生成了BFC

　　**BFC的约束规则**
浏览器对于BFC这块区域的约束规则如下：

- 生成BFC元素的子元素会一个接一个的放置。垂直方向上他们的起点是一个包含块的顶部，两个相邻子元素之间的垂直距离取决于元素的margin特性。在BFC中相邻的块级元素外边距会折叠。
- 生成BFC元素的子元素中，每一个子元素做外边距与包含块的左边界相接触，（对于从右到左的格式化，右外边距接触右边界），即使浮动元素也是如此（尽管子元素的内容区域会由于浮动而压缩），除非这个子元素也创建了一个新的BFC（如它自身也是一个浮动元素）。

　　有道友对它做了[分解](http://f2e-js.com/?p=2599)，我们直接拿来：
1. 内部的Box会在垂直方向上一个接一个的放置
2. 垂直方向上的距离由margin决定。（完整的说法是：属于同一个BFC的两个相邻Box的margin会发生重叠，与方向无关。）

3. 每个元素的左外边距与包含块的左边界相接触（从左向右），即使浮动元素也是如此。（这说明BFC中子元素不会超出他的包含块，而position为absolute的元素可以超出他的包含块边界）

4. BFC的区域不会与float的元素区域重叠
5. 计算BFC的高度时，浮动子元素也参与计算
6. BFC就是页面上的一个隔离的独立容器，容器里面的子元素不会影响到外面元素，反之亦然
　　看到以上的几条约束，让我想起学习css时的几条规则

- Block元素会扩展到与父元素同宽，所以block元素会垂直排列
- 垂直方向上的两个相邻DIV的margin会重叠，而水平方向不会(此规则并不完全正确)
- 浮动元素会尽量接近往左上方（或右上方）
- 为父元素设置overflow：hidden或浮动父元素，则会包含浮动元素
- ......

　　哈哈，一股恍然大悟的感觉有木有，原来这些规则的背后都有更深层的概念，冥冥之中自有定数。。。
　　**BFC在布局中的应用**
　　上面说了那么多，那BFC究竟有何用处，毕竟再好的东西也要为我所用才行。
　　防止margin重叠：

　　同一个BFC中的两个相邻Box才会发生重叠与方向无关，不过由于上文提到的第一条限制，我们甚少看到水平方向的margin重叠。这在IE中是个例外，IE可以设置write-mode。下面这个demo来自寒冬大神的[博客](http://www.cnblogs.com/winter-cn/archive/2012/11/16/2772562.html)。

![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)margin水平重叠
　　可以看到水平方向的margin发生了重叠。

![282102232799113.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/92041455979d1d952be5b5c111db25fb.jpg)

　　要阻止margin重叠，只要将两个元素别放在一个BFC中即可（可以用上文提到的方式让相邻元素其中一个生成BFC）。阻止两个相邻元素的margin重叠看起来没有什么意义，主要用于嵌套元素。

![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)margin嵌套重叠
　　此时div与ul之间的垂直距离，取div、ul、li三者之间的最大外边距。

![291925114725177.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/fd5fc57d06e04dcdd8da6ac49d3436bd.jpg)
![291926585665399.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/f4899f9dce3cc5f18859284e1a6095e4.jpg)
![291928166914329.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/d67a9425fbdc5885e41d9b5fbababaed.png)

　　要阻止嵌套元素的重叠，只需让ul生成BFC即可（将上例中的注释去掉），这样div、ul、li之间便不会发生重叠现象。而li位于同一BFC内所以仍然存在重叠现象。

![291934549415396.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/d1993dc3e825c9544db09ce3a56c390c.png)
![291935025039174.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/09d33cff7c4ad3e2702048d16873507c.png)
![291935135033069.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/65a90fc40d44670eec3e56ce787bb4ad.png)

　　需要注意的是：

- 如果将为ul使用overflow：hidden的方式，ul生成BFC不应该再发生重叠现象可是我在chrome、firefox、ie上的测试结果都有发生重叠现象。这个问题，我没找到答案，还请道友们给解答一下
- 如果为ul设置了border或padding，那元素的margin便会被包含在父元素的盒式模型内，不会与外部div重叠。《CSS权威指南》中提到块级正常流元素的高度设置为auto，而且只有块级子元素，其默认高度将是从最高块级子元素的外边框边界到最低块级子元素外边框边界之间的距离。如果块级元素右上内边距或下内边距，或者有上边框或下边框，其高度是从其最高子元素的上外边距边界到其最低子元素的下外边距边界之间的距离。

　　浮动相关问题：

　　使得父元素包含子元素，常见的方式是为父元素设置overflow:hidden或浮动父元素。根本原因在于创建BFC的元素，子浮动元素也会参与其高度计算，即不会产生高度塌陷问题。实际上只要让父元素生成BFC即可，并不只有这两种方式。

![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)包围浮动

![292000092536095.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/7fe8d6a03344f2216303ab3bb596839b.png)

　　将上例中first中任意一项注释去掉都可以得到包围浮动的效果，其中overflow：hidden方式，与正常流最接近。

![292002209878806.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/0cb8766b7d2983baafaf7d5e06ed14bb.png)

![292002557068045.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/0ef34a230ccb09683ff2f9a035b7c860.png)

　　关于清除浮动更详尽的方式，请大家参考这篇文章[此处](http://www.cnblogs.com/dolphinX/p/3508869.html)，dolphinX道友的博客简洁明了。

　　多栏布局的一种方式
　　上文提到的一条规则：与浮动元素相邻的已生成BFC的元素不能与浮动元素相互覆盖。利用该特性可以作为多栏布局的一种实现方式。
![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)多栏布局
　　这种布局的特点在于左右两栏宽度固定，中间栏可以根据浏览器宽度自适应。

![292050554726831.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/3ed88077d2ec4022266fb69d019c4206.png)

　　IE中也有与BFC类似的概念成为hasLayout,我平时工作最低也是使用IE8，并没有涉及到这部分所以还请道友们查询其他资料。
　　总结

　　在我第一次接触到BFC时经常有一个疑问，BFC的结构是什么样的，像DOM一样的树状结构，还是一个BFC集合。其实我们不需要关心BFC的具体结构，这要看浏览器的具体实现采用什么样的数据结构。对于BFC我们只需要知道使用一定的CSS声明可以生成BFC，浏览器对生成的BFC有一系列的渲染规则，利用这些渲染规则可以达到一定的布局效果，为了达到特定的布局效果我们让元素生成BFC。

　　对于CSS新手来说不建议涉猎BFC，还是应该去看看相应的CSS布局规则，像《CSS设计指南》、《CSS权威指南》这两本都很不错，达到一定积累再来看BFC，说不定会有一种豁然开朗的感觉。BFC中几乎涉及到CSS布局的所有重要属性，这也是BFC的难点和我们需要掌握BFC的意义所在。

　　文章中的部分内容可能与道友看到的其他博客有所出入，毕竟每个人的工作经验、所遇问题跟测试方法不一样，差异在所难免，探讨技术的乐趣在于不断的总结积累与自我推翻，只要大方向正确细节问题可以慢慢探索。

　  参考文章
　　http://www.cnblogs.com/winter-cn/archive/2012/11/16/2772562.html
　　http://f2e-js.com/?p=2599
　　http://www.cnblogs.com/dolphinX/p/3508869.html

　　http://wenku.baidu.com/link?url=yRqbHnEVEL58mfPg1KDneWqX5AjcL34U70ANznTaWU6DUcTx6yaEcKBbDjPxyP3GVoNN7-GdTSPbEmty6RmCTJ3qY6FzPqSB7TvwbmFayYO

　　http://reference.sitepoint.com/css/blockformatting
　　http://www.yuiblog.com/blog/2010/05/19/css-101-block-formatting-contexts/
　　http://www.cnblogs.com/winter-cn/archive/2013/05/11/3072929.html
　　到了各位道友点评时间，如有错误，还请不吝指正。。。
Measure
Measure
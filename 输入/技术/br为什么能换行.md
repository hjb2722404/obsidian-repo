br为什么能换行

# br为什么能换行

## 背景

在做富文本编辑器基础研究时，研究到DOM节点的`offsetLeft`属性，发现当我们不对浏览器默认样式进行如下`reset`时，该属性的值会比期望的多出`8px`的宽度（`chrome浏览器`）:

	* {
		margin: 0;
	}

同时，我们也知道，这肯定是浏览器默认样式（`user agent stylesheet`）在作祟，可以从控制台看到浏览器默认样式如下：

	// user agent stylesheet
	body {
		display:block;
		margin: 8px;
	}

于是，就想着看看其它HTML标签的默认样式是什么，搜索到了`chrome内核源码`的[默认CSS样式表](http://trac.webkit.org/browser/webkit/trunk/Source/WebCore/css/html.css)

通过查阅该文档，理解了很多之前无法理解的内容，比如，为什么`div`是块级元素而`span`就是内联元素，而为什么我们又可以通过`css`规则将`div`改变为内联元素或者把`span`元素转变为块级元素。

但是在这份文档里，我却没有看到`br`标签的默认样式，于是就产生了好奇，是什么样式设置让`br`可以实现换行的呢？
经过一番搜索，终于有了答案。
这个故事，得从头讲起。

## 浏览器的组成

我们常说的浏览器，实际上由以下几部分组成，先看图：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821093807.png)

> 上图箭头表示各个组成部分之间的通讯

- 用户界面：包括地址输入框、前进返回按钮、书签、历史记录等用户可见和可操作性的区域；
- 浏览器引擎：负责在用户界面和渲染引擎之间传送指令，或者在本地缓存中读写数据，相当于在各个模块之间跑腿送货的。
- 渲染引擎：即我们说的浏览器内核。负责解析`DOM`文档(`HTML`等)和`CSS`规则并将内容排版到浏览器中显示有样式的界面，这个是我们下面要讲的。
- 网络模块： 负责开启网络县城发送请求和下载资源
- `JS`引擎： 负责解释和执行`JS`脚本，典型的如：`V8`引擎
- `UI`后端： 负责绘制基本的浏览器窗口内控件，如按钮、输入框等
- 数据持久化：负责`cookie/localStorage`等本地缓存的存储

## 渲染引擎

我们的网页之所以能够有各种各样的布局与样式，全依赖于渲染引擎对我们所写`HTML`与`CSS`的解析渲染。
**网页呈现流程**：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821102244.png)

**webkit渲染流程**：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821102406.png)

**gecko渲染流程**：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821102422.jpg)

从这3张图我们得到以下信息点：

- 网络模块负责从网络获取得到`HTML`、`JS`、`CSS`等资源
- 渲染引擎中的`HTML`解析器与`JS`引擎分别解释执行`HTML`内容与`JS`脚本，生成`DOM`树。
- `CSS`解析器解析`CSS规则`生成了样式规则集（即 `CSSOM`树）
- 渲染引擎根据`DOM`树与`CSSOM`树生成样式树
- 再根据样式树与布局（gecko成为重排，主要是计算后的元素位置）生成渲染树
- 最后渲染引擎将渲染树绘制到显示设备上。

既然`HTML`的作用只是用来构建`DOM`树，体现结构与语义，那么同理`<br>` 标签也就只是表示文档某处有一个换行，但是却无法真正实现换行的效果。
那么这个真正的换行效果是谁实现的呢？答案是——`CSS`.

## CSS的五种来源

有这样一段代码：

	<html>
		<body>
			<h1>静夜思</h1>
			<p>
				<span>窗前明月光</span><br>			<span>疑是地上霜</span><br data-tomark-pass>			<span>举头望明月</span><br data-tomark-pass>			<span>低头思故乡</span><br data-tomark-pass>		</p>
		</body>
	</html>

我们不给它设置任何`CSS`样式，看看效果：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821102433.png)

在没有设置任何样式的情况下，标题依旧加粗加大，内容依旧有换行。
而这些效果，全部来自于浏览器的默认样式： `user agent stylesheet`
说到这里，我们就要说一下网页中`CSS`的五种来源了:

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821102443.png)

上面三种样式来源，就是我们在前端开发时经常要编写的部分，而下面两种，则是浏览器内置的，而由下到上，上面一级的样式可以覆盖下面一级的，其中：

- 浏览器用户自定义样式，是指用户可以通过浏览器选项中提供的功能来设置浏览器默认的一些样式，比如字体，字号等；

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821102458.png)

- 浏览器默认样式，就是我们上面说的`user agent stylesheet`，是在我们没有在程序中编写样式，也没有设置浏览器用户自定义样式时，浏览器会去读取一份内置的样式表，利用这份样式表里的样式来渲染页面。

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821102511.png)

可是在检查元素这里却看不到`<br>`标签对应的浏览器默认样式，我们查阅浏览器源码中的 [默认CSS样式表](http://trac.webkit.org/browser/webkit/trunk/Source/WebCore/css/html.css)，也没有发现有 `<br>` 标签的样式，那它的换行是如何实现的呢？

## br的CSS实现

几经周折，我们在[HTML规范的HTML标签示例](https://www.w3.org/TR/CSS21/sample.html)中找到了它：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821102524.png)

原来 `<br>`标签的换行是这几条`css`规则

	br:before       {
	    content: "\A";
	    white-space: pre-line
	}

为什么这几条就能实现换行呢？

我们知道`white-space:pre-line`的作用是去除空格，保留换行，但它本身并不会添加换行效果，那剩下的就是要弄清楚`content： '\A'` 是什么意思就知道换行是如何实现的了。

通过查看规范，`CSS`的`content`属性只能用于`:after`和`:before`伪元素，它接受以下类型的值：

- 普通字符串，如`content: '你好'`
- 元素属性，如 `content: attr(alt)`
- 外部资源：如 `content:url(http://www.baidu.com/picture/a.jpg)`
- 调用计数器： 如 `content: counter(dd) ' '`
- `unicode`字符： 如 `content:'\21e0'`
- 引号标志：如 `content: open-quote | close-quote | no-open-quote | no-close-quote`

！！！恍然大悟，原来`\A` 是 `unicode` 字符，那么`\A` 在`unicode`字符中表示什么呢？

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821102531.jpg)

众所周知，`unicode` 是 `ascii`的超级，并且`unicode`码是16进制的，那16进制的`A`正好是十进制的`010`，我们终于在这张表里找到了十进制`010`的`ascii`码对应的字符：`\n`—— 换行符！！！

现在我们知道`br`为什么可以换行了：

- 利用伪元素创建了一个内容为换行符的元素
- 利用`white-space`属性保留了这个换行符

## 扩展1： 自己实现换行

我们完全可以不用`br`标签，自己实现换行：

	<style>
	span:before {
	            content:'\A';
	            white-space: pre-line;
	        }
	        span:after {
	            content: '\A';
	            white-space: pre-line;
	        }
	</style>

	<body>
		A<span>测试下换行</span>B
	</body>

我们看看效果：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821102539.png)

## 扩展2： 小写的a行不行

由于`unicode`码是不区分大小写的，所以把 `\A` 替换成`\a`也是完全没有问题的，读者可自行测试。

## 扩展3：只能使用 pre-line吗

使用`white-space`的目的就是保留我们利用`content`创建的换行符，所以所有可以保留换行的值都是可以的：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200821102549.png)

由上表知，可以保留换行符的`pre,pre-wrap,pre-line,break-spaces`都是可以的，读者可自行测试

## 扩展4：换行换成回车可以吗？

我们知道，要生成换行的效果，除了换行符，回车也可以达到相同效果，那把这里的换行符换成回车符（`\d`）可以吗?
不可以。
这涉及到回车和换行的区别，简而言之，这两个词是借鉴于老式打字机：
*"回车"，告诉打字机把打印头定位在左边界
"换行"， 告诉打字机把纸向下移一行。
对应到计算机输入中，回车只是代表把光标定位到行首，并不能实现换行，真正要移动到下一行，要使用换行符

## 扩展5：能不能覆盖br标签的样式让她不换行

既然我们前面讲`CSS`五个来源时，说上一级的会覆盖下一级，我们可以利用这个特性，将`span`变成块级元素，将`p`变成内联元素，那我们在自己的`CSS`中重写`br`的伪元素样式，可以改变它的行为吗？

	br::before {
	            content: '\d';
	            white-space: nowrap;
	        }
	        br::after {
	            content: '\d';
	            white-space: nowrap;
	        }

经过测试，不可以。
原因暂时未知，如果读者中有研究出结果的，欢迎分享出来。
经过对规范文档一番搜索，发现一些蛛丝马迹：

首先，在`HTML`规范中[关于`br`标签的说明部分](https://www.w3.org/TR/html52/textlevel-semantics.html#the-br-element)， 我们可以找到以下说明：

> This element > [> has rendering requirements involving the bidirectional algorithm](https://www.w3.org/TR/html52/dom.html#bidireq)> .

> 该元素渲染时需要符合双向演化算法的要求
好，先暂停一下，啥是个双向演化算法？

我们都知道，一般来说，我们接触的书写语言，无论是汉语还是英语还是德语法语，它的书写顺序都是从左至右的，可是世界是多样的，就有那么一些语言，它的书写方向偏偏就是从右至左的，比如阿拉伯语等，这还不是问题，关键是，这些语言中的数字却又是从左至右书写的，这样就导致这种语言实质上同时包含了两种书写方向，而在计算机中，这些语言的文字都是使用`unicode`编码来实现的，所以，聪明的大神们设计了针对`unicode`字符集的`双向演化算法`来解决这类问题。

好巧不巧，任何语言的书写都需要换行（这不废话吗），所以`br` 的渲染也要符合双向演化算法的要求。
知道了这个，我们再来看[双向演化算法的要求](https://www.w3.org/TR/html52/dom.html#bidireq)：

> The mapping of HTML to the Unicode bidirectional algorithm must be done in one of three ways. Either the user agent must implement CSS, including in particular the CSS > [> unicode-bidi](https://www.w3.org/TR/css-writing-modes-3/#propdef-unicode-bidi)> , > [> direction](https://www.w3.org/TR/css-writing-modes-3/#propdef-direction)> , and > [> content](https://www.w3.org/TR/css-content-3/#propdef-content)>  properties, and must have, in its user agent style sheet, the rules using those properties given in this specification’s > [> rendering](https://www.w3.org/TR/html52/rendering.html#rendering)>  section, or, alternatively, the user agent must act as if it implemented just the aforementioned properties and had a user agent style sheet that included all the aforementioned rules, but without letting style sheets specified in documents override them, or, alternatively, the user agent must implement another styling language with equivalent semantics. [> [> CSS-WRITING-MODES-3]](https://www.w3.org/TR/html52/references.html#biblio-css-writing-modes-3)>  [> [> CSS3-CONTENT]](https://www.w3.org/TR/html52/references.html#biblio-css3-content)

> HTML到Unicode双向算法的映射必须通过以下三种方式之一完成。 用户代理必须实现CSS，特别是CSS unicode-bidi，direction和content属性，并且必须在其用户代理样式表中具有使用本规范呈现部分中给出的那些属性的规则，或者，** 用户代理必须充当仅实现上述属性的行为，并且具有包括所有上述规则的用户代理样式表，但又不能让文档中指定的样式表覆盖它们，或者，用户代理必须实施另一种样式语言 具有相同的语义 **

看到上面我用一对星号括起来的内容没，就是说作为用户代理，浏览器有两种选择：

- 实现规范给出的规则，并且不允许文档中的样式表覆盖他们。【吼吼，被我抓到了】
- 试试另一种样式语言，具有相同的语义【也可能是这种】

那我们看看[规范给出的规则](https://www.w3.org/TR/html52/rendering.html#bidirectional-text)：

	@namespace url(http://www.w3.org/1999/xhtml);

	[dir]:dir(ltr), bdi:dir(ltr), input[type=tel i]:dir(ltr) { direction: ltr; }
	[dir]:dir(rtl), bdi:dir(rtl) { direction: rtl; }

	address, blockquote, center, div, figure, figcaption, footer, form, header, hr,
	legend, listing, main, p, plaintext, pre, summary, xmp, article, aside, h1, h2,
	h3, h4, h5, h6, hgroup, nav, section, table, caption, colgroup, col, thead,
	tbody, tfoot, tr, td, th, dir, dd, dl, dt, ol, ul, li, bdi, output,
	[dir=ltr i], [dir=rtl i], [dir=auto i] {
	  unicode-bidi: isolate;
	}

	bdo, bdo[dir] { unicode-bidi: isolate-override; }

	input[dir=auto i]:matches([type=search i], [type=tel i], [type=url i],
	[type=email i]), textarea[dir=auto i], pre[dir=auto i] {
	  unicode-bidi: plaintext;
	}
	*/* see prose for input elements whose type attribute is in the Text state */*

	*/* the rules setting the 'content' property on <br> and <wbr> elements also has bidi implications */*

看到第22行的注释了吗？
它的意思是`br`标签的`content`属性可以设置类似以上的规则。

但同时，`br`标签又属于段落文本类型，它同样可以实现[段落文本的规则](https://www.w3.org/TR/html52/rendering.html#non-replaced-elements-phrasing-content)：

	//……
	br { display-outside: newline; } /* this also has bidi implications */
	//……

遗憾的是，这些都只是规范推荐的规则，浏览器可以不按这些规则实现，只要实现相同的语义就可以。
那浏览器还有什么选择呢？
这又引出了另一对概念：替换元素与非替换元素
说到`CSS`的模型，我们都知道块级元素和内联元素的区分，但却很少了解，其实还有一种维度的区分方式，就是替换元素和非替换元素。

所谓替换元素，就是在渲染时，直接用其它内容将它替换掉，所以它并不属于`CSS`格式化模型，而是独立计算渲染的，但是我们可以通过`CSS`样式设置它的大小和位置。（这个具体比较复杂，有兴趣可以自行研究下）

比如，`img`标签就是典型的替换元素，浏览器在渲染它的时候，实际上是直接拿它的`src`属性所指向的图片对象将它替换了。 尽管我们查看源码可以看到它的位置仍旧是一个`img`标签，但是实际上在渲染层面，它已经被替换，

在[`MDN`文档](https://developer.mozilla.org/zh-CN/docs/Web/CSS/::before)中，我们也可以找到这样的话：

> 由`::before`>  和`::after`>  生成的伪元素 > [> 包含在元素格式框内](https://www.w3.org/TR/CSS2/generate.html#before-after-content)> ， 因此不能应用在*> [> 替换元素上](https://developer.mozilla.org/en-US/docs/Web/CSS/Replaced_element)> ，* 比如`<img>`> 或`<br>`> 元素。

就是这么奇怪，在`HTML`规范中，替换元素并不包含`<br>`，但在这里，又说`<br>`是替换元素，我们只能暂时认为，在浏览器内核实现时，开发人员可能会选择使用这种方式来实现换行：

——直接将`br`标签替换为一个换行符。
根据可以查阅到的资料，目前就只有这两种猜测：

- 浏览器实现了规范推荐的规则，这些规则被隐藏起来了，所以查看元素时看不到它的默认规则，同时根据双向演化算法要求禁止我们去覆盖它的规则
- 浏览器选择了将它实现为替换元素，因为替换元素不属于`CSS`格式化模型，所以我们无法通过自己编写的CSS规则改变它的行为

%23%20br%E4%B8%BA%E4%BB%80%E4%B9%88%E8%83%BD%E6%8D%A2%E8%A1%8C%0A%0A%23%23%20%E8%83%8C%E6%99%AF%0A%0A%E5%9C%A8%E5%81%9A%E5%AF%8C%E6%96%87%E6%9C%AC%E7%BC%96%E8%BE%91%E5%99%A8%E5%9F%BA%E7%A1%80%E7%A0%94%E7%A9%B6%E6%97%B6%EF%BC%8C%E7%A0%94%E7%A9%B6%E5%88%B0DOM%E8%8A%82%E7%82%B9%E7%9A%84%60offsetLeft%60%E5%B1%9E%E6%80%A7%EF%BC%8C%E5%8F%91%E7%8E%B0%E5%BD%93%E6%88%91%E4%BB%AC%E4%B8%8D%E5%AF%B9%E6%B5%8F%E8%A7%88%E5%99%A8%E9%BB%98%E8%AE%A4%E6%A0%B7%E5%BC%8F%E8%BF%9B%E8%A1%8C%E5%A6%82%E4%B8%8B%60reset%60%E6%97%B6%EF%BC%8C%E8%AF%A5%E5%B1%9E%E6%80%A7%E7%9A%84%E5%80%BC%E4%BC%9A%E6%AF%94%E6%9C%9F%E6%9C%9B%E7%9A%84%E5%A4%9A%E5%87%BA%608px%60%E7%9A%84%E5%AE%BD%E5%BA%A6%EF%BC%88%60chrome%E6%B5%8F%E8%A7%88%E5%99%A8%60%EF%BC%89%3A%0A%0A%60%60%60css%0A*%20%7B%0A%09margin%3A%200%3B%0A%7D%0A%60%60%60%0A%0A%E5%90%8C%E6%97%B6%EF%BC%8C%E6%88%91%E4%BB%AC%E4%B9%9F%E7%9F%A5%E9%81%93%EF%BC%8C%E8%BF%99%E8%82%AF%E5%AE%9A%E6%98%AF%E6%B5%8F%E8%A7%88%E5%99%A8%E9%BB%98%E8%AE%A4%E6%A0%B7%E5%BC%8F%EF%BC%88%60user%20agent%20stylesheet%60%EF%BC%89%E5%9C%A8%E4%BD%9C%E7%A5%9F%EF%BC%8C%E5%8F%AF%E4%BB%A5%E4%BB%8E%E6%8E%A7%E5%88%B6%E5%8F%B0%E7%9C%8B%E5%88%B0%E6%B5%8F%E8%A7%88%E5%99%A8%E9%BB%98%E8%AE%A4%E6%A0%B7%E5%BC%8F%E5%A6%82%E4%B8%8B%EF%BC%9A%0A%0A%60%60%60css%0A%2F%2F%20user%20agent%20stylesheet%0Abody%20%7B%0A%09display%3Ablock%3B%0A%09margin%3A%208px%3B%0A%7D%0A%60%60%60%0A%0A%E4%BA%8E%E6%98%AF%EF%BC%8C%E5%B0%B1%E6%83%B3%E7%9D%80%E7%9C%8B%E7%9C%8B%E5%85%B6%E5%AE%83HTML%E6%A0%87%E7%AD%BE%E7%9A%84%E9%BB%98%E8%AE%A4%E6%A0%B7%E5%BC%8F%E6%98%AF%E4%BB%80%E4%B9%88%EF%BC%8C%E6%90%9C%E7%B4%A2%E5%88%B0%E4%BA%86%60chrome%E5%86%85%E6%A0%B8%E6%BA%90%E7%A0%81%60%E7%9A%84%5B%E9%BB%98%E8%AE%A4CSS%E6%A0%B7%E5%BC%8F%E8%A1%A8%5D(http%3A%2F%2Ftrac.webkit.org%2Fbrowser%2Fwebkit%2Ftrunk%2FSource%2FWebCore%2Fcss%2Fhtml.css)%0A%0A%E9%80%9A%E8%BF%87%E6%9F%A5%E9%98%85%E8%AF%A5%E6%96%87%E6%A1%A3%EF%BC%8C%E7%90%86%E8%A7%A3%E4%BA%86%E5%BE%88%E5%A4%9A%E4%B9%8B%E5%89%8D%E6%97%A0%E6%B3%95%E7%90%86%E8%A7%A3%E7%9A%84%E5%86%85%E5%AE%B9%EF%BC%8C%E6%AF%94%E5%A6%82%EF%BC%8C%E4%B8%BA%E4%BB%80%E4%B9%88%60div%60%E6%98%AF%E5%9D%97%E7%BA%A7%E5%85%83%E7%B4%A0%E8%80%8C%60span%60%E5%B0%B1%E6%98%AF%E5%86%85%E8%81%94%E5%85%83%E7%B4%A0%EF%BC%8C%E8%80%8C%E4%B8%BA%E4%BB%80%E4%B9%88%E6%88%91%E4%BB%AC%E5%8F%88%E5%8F%AF%E4%BB%A5%E9%80%9A%E8%BF%87%60css%60%E8%A7%84%E5%88%99%E5%B0%86%60div%60%E6%94%B9%E5%8F%98%E4%B8%BA%E5%86%85%E8%81%94%E5%85%83%E7%B4%A0%E6%88%96%E8%80%85%E6%8A%8A%60span%60%E5%85%83%E7%B4%A0%E8%BD%AC%E5%8F%98%E4%B8%BA%E5%9D%97%E7%BA%A7%E5%85%83%E7%B4%A0%E3%80%82%0A%0A%E4%BD%86%E6%98%AF%E5%9C%A8%E8%BF%99%E4%BB%BD%E6%96%87%E6%A1%A3%E9%87%8C%EF%BC%8C%E6%88%91%E5%8D%B4%E6%B2%A1%E6%9C%89%E7%9C%8B%E5%88%B0%60br%60%E6%A0%87%E7%AD%BE%E7%9A%84%E9%BB%98%E8%AE%A4%E6%A0%B7%E5%BC%8F%EF%BC%8C%E4%BA%8E%E6%98%AF%E5%B0%B1%E4%BA%A7%E7%94%9F%E4%BA%86%E5%A5%BD%E5%A5%87%EF%BC%8C%E6%98%AF%E4%BB%80%E4%B9%88%E6%A0%B7%E5%BC%8F%E8%AE%BE%E7%BD%AE%E8%AE%A9%60br%60%E5%8F%AF%E4%BB%A5%E5%AE%9E%E7%8E%B0%E6%8D%A2%E8%A1%8C%E7%9A%84%E5%91%A2%EF%BC%9F%0A%0A%E7%BB%8F%E8%BF%87%E4%B8%80%E7%95%AA%E6%90%9C%E7%B4%A2%EF%BC%8C%E7%BB%88%E4%BA%8E%E6%9C%89%E4%BA%86%E7%AD%94%E6%A1%88%E3%80%82%0A%0A%E8%BF%99%E4%B8%AA%E6%95%85%E4%BA%8B%EF%BC%8C%E5%BE%97%E4%BB%8E%E5%A4%B4%E8%AE%B2%E8%B5%B7%E3%80%82%0A%0A%23%23%20%E6%B5%8F%E8%A7%88%E5%99%A8%E7%9A%84%E7%BB%84%E6%88%90%0A%0A%E6%88%91%E4%BB%AC%E5%B8%B8%E8%AF%B4%E7%9A%84%E6%B5%8F%E8%A7%88%E5%99%A8%EF%BC%8C%E5%AE%9E%E9%99%85%E4%B8%8A%E7%94%B1%E4%BB%A5%E4%B8%8B%E5%87%A0%E9%83%A8%E5%88%86%E7%BB%84%E6%88%90%EF%BC%8C%E5%85%88%E7%9C%8B%E5%9B%BE%EF%BC%9A%0A%0A!%5B%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821093807.png)%0A%0A%3E%20%E4%B8%8A%E5%9B%BE%E7%AE%AD%E5%A4%B4%E8%A1%A8%E7%A4%BA%E5%90%84%E4%B8%AA%E7%BB%84%E6%88%90%E9%83%A8%E5%88%86%E4%B9%8B%E9%97%B4%E7%9A%84%E9%80%9A%E8%AE%AF%0A%0A*%20%E7%94%A8%E6%88%B7%E7%95%8C%E9%9D%A2%EF%BC%9A%E5%8C%85%E6%8B%AC%E5%9C%B0%E5%9D%80%E8%BE%93%E5%85%A5%E6%A1%86%E3%80%81%E5%89%8D%E8%BF%9B%E8%BF%94%E5%9B%9E%E6%8C%89%E9%92%AE%E3%80%81%E4%B9%A6%E7%AD%BE%E3%80%81%E5%8E%86%E5%8F%B2%E8%AE%B0%E5%BD%95%E7%AD%89%E7%94%A8%E6%88%B7%E5%8F%AF%E8%A7%81%E5%92%8C%E5%8F%AF%E6%93%8D%E4%BD%9C%E6%80%A7%E7%9A%84%E5%8C%BA%E5%9F%9F%EF%BC%9B%0A*%20%E6%B5%8F%E8%A7%88%E5%99%A8%E5%BC%95%E6%93%8E%EF%BC%9A%E8%B4%9F%E8%B4%A3%E5%9C%A8%E7%94%A8%E6%88%B7%E7%95%8C%E9%9D%A2%E5%92%8C%E6%B8%B2%E6%9F%93%E5%BC%95%E6%93%8E%E4%B9%8B%E9%97%B4%E4%BC%A0%E9%80%81%E6%8C%87%E4%BB%A4%EF%BC%8C%E6%88%96%E8%80%85%E5%9C%A8%E6%9C%AC%E5%9C%B0%E7%BC%93%E5%AD%98%E4%B8%AD%E8%AF%BB%E5%86%99%E6%95%B0%E6%8D%AE%EF%BC%8C%E7%9B%B8%E5%BD%93%E4%BA%8E%E5%9C%A8%E5%90%84%E4%B8%AA%E6%A8%A1%E5%9D%97%E4%B9%8B%E9%97%B4%E8%B7%91%E8%85%BF%E9%80%81%E8%B4%A7%E7%9A%84%E3%80%82%0A*%20%E6%B8%B2%E6%9F%93%E5%BC%95%E6%93%8E%EF%BC%9A%E5%8D%B3%E6%88%91%E4%BB%AC%E8%AF%B4%E7%9A%84%E6%B5%8F%E8%A7%88%E5%99%A8%E5%86%85%E6%A0%B8%E3%80%82%E8%B4%9F%E8%B4%A3%E8%A7%A3%E6%9E%90%60DOM%60%E6%96%87%E6%A1%A3(%60HTML%60%E7%AD%89)%E5%92%8C%60CSS%60%E8%A7%84%E5%88%99%E5%B9%B6%E5%B0%86%E5%86%85%E5%AE%B9%E6%8E%92%E7%89%88%E5%88%B0%E6%B5%8F%E8%A7%88%E5%99%A8%E4%B8%AD%E6%98%BE%E7%A4%BA%E6%9C%89%E6%A0%B7%E5%BC%8F%E7%9A%84%E7%95%8C%E9%9D%A2%EF%BC%8C%E8%BF%99%E4%B8%AA%E6%98%AF%E6%88%91%E4%BB%AC%E4%B8%8B%E9%9D%A2%E8%A6%81%E8%AE%B2%E7%9A%84%E3%80%82%0A*%20%E7%BD%91%E7%BB%9C%E6%A8%A1%E5%9D%97%EF%BC%9A%20%E8%B4%9F%E8%B4%A3%E5%BC%80%E5%90%AF%E7%BD%91%E7%BB%9C%E5%8E%BF%E5%9F%8E%E5%8F%91%E9%80%81%E8%AF%B7%E6%B1%82%E5%92%8C%E4%B8%8B%E8%BD%BD%E8%B5%84%E6%BA%90%0A*%20%60JS%60%E5%BC%95%E6%93%8E%EF%BC%9A%20%E8%B4%9F%E8%B4%A3%E8%A7%A3%E9%87%8A%E5%92%8C%E6%89%A7%E8%A1%8C%60JS%60%E8%84%9A%E6%9C%AC%EF%BC%8C%E5%85%B8%E5%9E%8B%E7%9A%84%E5%A6%82%EF%BC%9A%60V8%60%E5%BC%95%E6%93%8E%0A*%20%60UI%60%E5%90%8E%E7%AB%AF%EF%BC%9A%20%E8%B4%9F%E8%B4%A3%E7%BB%98%E5%88%B6%E5%9F%BA%E6%9C%AC%E7%9A%84%E6%B5%8F%E8%A7%88%E5%99%A8%E7%AA%97%E5%8F%A3%E5%86%85%E6%8E%A7%E4%BB%B6%EF%BC%8C%E5%A6%82%E6%8C%89%E9%92%AE%E3%80%81%E8%BE%93%E5%85%A5%E6%A1%86%E7%AD%89%0A*%20%E6%95%B0%E6%8D%AE%E6%8C%81%E4%B9%85%E5%8C%96%EF%BC%9A%E8%B4%9F%E8%B4%A3%60cookie%2FlocalStorage%60%E7%AD%89%E6%9C%AC%E5%9C%B0%E7%BC%93%E5%AD%98%E7%9A%84%E5%AD%98%E5%82%A8%0A%0A%23%23%20%E6%B8%B2%E6%9F%93%E5%BC%95%E6%93%8E%0A%0A%E6%88%91%E4%BB%AC%E7%9A%84%E7%BD%91%E9%A1%B5%E4%B9%8B%E6%89%80%E4%BB%A5%E8%83%BD%E5%A4%9F%E6%9C%89%E5%90%84%E7%A7%8D%E5%90%84%E6%A0%B7%E7%9A%84%E5%B8%83%E5%B1%80%E4%B8%8E%E6%A0%B7%E5%BC%8F%EF%BC%8C%E5%85%A8%E4%BE%9D%E8%B5%96%E4%BA%8E%E6%B8%B2%E6%9F%93%E5%BC%95%E6%93%8E%E5%AF%B9%E6%88%91%E4%BB%AC%E6%89%80%E5%86%99%60HTML%60%E4%B8%8E%60CSS%60%E7%9A%84%E8%A7%A3%E6%9E%90%E6%B8%B2%E6%9F%93%E3%80%82%0A%0A**%E7%BD%91%E9%A1%B5%E5%91%88%E7%8E%B0%E6%B5%81%E7%A8%8B**%EF%BC%9A%0A%0A!%5B%E7%BD%91%E9%A1%B5%E6%B8%B2%E6%9F%93%E6%B5%81%E7%A8%8B%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821102244.png)%0A%0A**webkit%E6%B8%B2%E6%9F%93%E6%B5%81%E7%A8%8B**%EF%BC%9A%0A%0A!%5B%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821102406.png)%0A%0A**gecko%E6%B8%B2%E6%9F%93%E6%B5%81%E7%A8%8B**%EF%BC%9A%0A%0A!%5B%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821102422.jpg)%0A%0A%E4%BB%8E%E8%BF%993%E5%BC%A0%E5%9B%BE%E6%88%91%E4%BB%AC%E5%BE%97%E5%88%B0%E4%BB%A5%E4%B8%8B%E4%BF%A1%E6%81%AF%E7%82%B9%EF%BC%9A%0A%0A*%20%E7%BD%91%E7%BB%9C%E6%A8%A1%E5%9D%97%E8%B4%9F%E8%B4%A3%E4%BB%8E%E7%BD%91%E7%BB%9C%E8%8E%B7%E5%8F%96%E5%BE%97%E5%88%B0%60HTML%60%E3%80%81%60JS%60%E3%80%81%60CSS%60%E7%AD%89%E8%B5%84%E6%BA%90%0A*%20%E6%B8%B2%E6%9F%93%E5%BC%95%E6%93%8E%E4%B8%AD%E7%9A%84%60HTML%60%E8%A7%A3%E6%9E%90%E5%99%A8%E4%B8%8E%60JS%60%E5%BC%95%E6%93%8E%E5%88%86%E5%88%AB%E8%A7%A3%E9%87%8A%E6%89%A7%E8%A1%8C%60HTML%60%E5%86%85%E5%AE%B9%E4%B8%8E%60JS%60%E8%84%9A%E6%9C%AC%EF%BC%8C%E7%94%9F%E6%88%90%60DOM%60%E6%A0%91%E3%80%82%0A*%20%60CSS%60%E8%A7%A3%E6%9E%90%E5%99%A8%E8%A7%A3%E6%9E%90%60CSS%E8%A7%84%E5%88%99%60%E7%94%9F%E6%88%90%E4%BA%86%E6%A0%B7%E5%BC%8F%E8%A7%84%E5%88%99%E9%9B%86%EF%BC%88%E5%8D%B3%20%60CSSOM%60%E6%A0%91%EF%BC%89%0A*%20%E6%B8%B2%E6%9F%93%E5%BC%95%E6%93%8E%E6%A0%B9%E6%8D%AE%60DOM%60%E6%A0%91%E4%B8%8E%60CSSOM%60%E6%A0%91%E7%94%9F%E6%88%90%E6%A0%B7%E5%BC%8F%E6%A0%91%0A*%20%E5%86%8D%E6%A0%B9%E6%8D%AE%E6%A0%B7%E5%BC%8F%E6%A0%91%E4%B8%8E%E5%B8%83%E5%B1%80%EF%BC%88gecko%E6%88%90%E4%B8%BA%E9%87%8D%E6%8E%92%EF%BC%8C%E4%B8%BB%E8%A6%81%E6%98%AF%E8%AE%A1%E7%AE%97%E5%90%8E%E7%9A%84%E5%85%83%E7%B4%A0%E4%BD%8D%E7%BD%AE%EF%BC%89%E7%94%9F%E6%88%90%E6%B8%B2%E6%9F%93%E6%A0%91%0A*%20%E6%9C%80%E5%90%8E%E6%B8%B2%E6%9F%93%E5%BC%95%E6%93%8E%E5%B0%86%E6%B8%B2%E6%9F%93%E6%A0%91%E7%BB%98%E5%88%B6%E5%88%B0%E6%98%BE%E7%A4%BA%E8%AE%BE%E5%A4%87%E4%B8%8A%E3%80%82%20%0A%0A%E6%97%A2%E7%84%B6%60HTML%60%E7%9A%84%E4%BD%9C%E7%94%A8%E5%8F%AA%E6%98%AF%E7%94%A8%E6%9D%A5%E6%9E%84%E5%BB%BA%60DOM%60%E6%A0%91%EF%BC%8C%E4%BD%93%E7%8E%B0%E7%BB%93%E6%9E%84%E4%B8%8E%E8%AF%AD%E4%B9%89%EF%BC%8C%E9%82%A3%E4%B9%88%E5%90%8C%E7%90%86%60%3Cbr%3E%60%20%E6%A0%87%E7%AD%BE%E4%B9%9F%E5%B0%B1%E5%8F%AA%E6%98%AF%E8%A1%A8%E7%A4%BA%E6%96%87%E6%A1%A3%E6%9F%90%E5%A4%84%E6%9C%89%E4%B8%80%E4%B8%AA%E6%8D%A2%E8%A1%8C%EF%BC%8C%E4%BD%86%E6%98%AF%E5%8D%B4%E6%97%A0%E6%B3%95%E7%9C%9F%E6%AD%A3%E5%AE%9E%E7%8E%B0%E6%8D%A2%E8%A1%8C%E7%9A%84%E6%95%88%E6%9E%9C%E3%80%82%0A%0A%E9%82%A3%E4%B9%88%E8%BF%99%E4%B8%AA%E7%9C%9F%E6%AD%A3%E7%9A%84%E6%8D%A2%E8%A1%8C%E6%95%88%E6%9E%9C%E6%98%AF%E8%B0%81%E5%AE%9E%E7%8E%B0%E7%9A%84%E5%91%A2%EF%BC%9F%E7%AD%94%E6%A1%88%E6%98%AF%E2%80%94%E2%80%94%60CSS%60.%0A%0A%23%23%20CSS%E7%9A%84%E4%BA%94%E7%A7%8D%E6%9D%A5%E6%BA%90%0A%0A%E6%9C%89%E8%BF%99%E6%A0%B7%E4%B8%80%E6%AE%B5%E4%BB%A3%E7%A0%81%EF%BC%9A%0A%0A%60%60%60%0A%3Chtml%3E%0A%09%3Cbody%3E%0A%09%09%3Ch1%3E%E9%9D%99%E5%A4%9C%E6%80%9D%3C%2Fh1%3E%0A%09%09%3Cp%3E%0A%09%09%09%3Cspan%3E%E7%AA%97%E5%89%8D%E6%98%8E%E6%9C%88%E5%85%89%3C%2Fspan%3E%3Cbr%3E%0A%09%09%09%3Cspan%3E%E7%96%91%E6%98%AF%E5%9C%B0%E4%B8%8A%E9%9C%9C%3C%2Fspan%3E%3Cbr%3E%0A%09%09%09%3Cspan%3E%E4%B8%BE%E5%A4%B4%E6%9C%9B%E6%98%8E%E6%9C%88%3C%2Fspan%3E%3Cbr%3E%0A%09%09%09%3Cspan%3E%E4%BD%8E%E5%A4%B4%E6%80%9D%E6%95%85%E4%B9%A1%3C%2Fspan%3E%3Cbr%3E%0A%09%09%3C%2Fp%3E%0A%09%3C%2Fbody%3E%0A%3C%2Fhtml%3E%0A%60%60%60%0A%0A%E6%88%91%E4%BB%AC%E4%B8%8D%E7%BB%99%E5%AE%83%E8%AE%BE%E7%BD%AE%E4%BB%BB%E4%BD%95%60CSS%60%E6%A0%B7%E5%BC%8F%EF%BC%8C%E7%9C%8B%E7%9C%8B%E6%95%88%E6%9E%9C%EF%BC%9A%0A%0A!%5Bimage-20200820164730890%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821102433.png)%0A%0A%0A%0A%E5%9C%A8%E6%B2%A1%E6%9C%89%E8%AE%BE%E7%BD%AE%E4%BB%BB%E4%BD%95%E6%A0%B7%E5%BC%8F%E7%9A%84%E6%83%85%E5%86%B5%E4%B8%8B%EF%BC%8C%E6%A0%87%E9%A2%98%E4%BE%9D%E6%97%A7%E5%8A%A0%E7%B2%97%E5%8A%A0%E5%A4%A7%EF%BC%8C%E5%86%85%E5%AE%B9%E4%BE%9D%E6%97%A7%E6%9C%89%E6%8D%A2%E8%A1%8C%E3%80%82%0A%0A%E8%80%8C%E8%BF%99%E4%BA%9B%E6%95%88%E6%9E%9C%EF%BC%8C%E5%85%A8%E9%83%A8%E6%9D%A5%E8%87%AA%E4%BA%8E%E6%B5%8F%E8%A7%88%E5%99%A8%E7%9A%84%E9%BB%98%E8%AE%A4%E6%A0%B7%E5%BC%8F%EF%BC%9A%20%60user%20agent%20stylesheet%60%0A%0A%E8%AF%B4%E5%88%B0%E8%BF%99%E9%87%8C%EF%BC%8C%E6%88%91%E4%BB%AC%E5%B0%B1%E8%A6%81%E8%AF%B4%E4%B8%80%E4%B8%8B%E7%BD%91%E9%A1%B5%E4%B8%AD%60CSS%60%E7%9A%84%E4%BA%94%E7%A7%8D%E6%9D%A5%E6%BA%90%E4%BA%86%3A%0A%0A!%5B%E6%B5%8F%E8%A7%88%E5%99%A8%E6%A0%B7%E5%BC%8F%E7%9A%84%E7%89%A9%E7%A7%8D%E6%9D%A5%E6%BA%90%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821102443.png)%0A%0A%0A%0A%E4%B8%8A%E9%9D%A2%E4%B8%89%E7%A7%8D%E6%A0%B7%E5%BC%8F%E6%9D%A5%E6%BA%90%EF%BC%8C%E5%B0%B1%E6%98%AF%E6%88%91%E4%BB%AC%E5%9C%A8%E5%89%8D%E7%AB%AF%E5%BC%80%E5%8F%91%E6%97%B6%E7%BB%8F%E5%B8%B8%E8%A6%81%E7%BC%96%E5%86%99%E7%9A%84%E9%83%A8%E5%88%86%EF%BC%8C%E8%80%8C%E4%B8%8B%E9%9D%A2%E4%B8%A4%E7%A7%8D%EF%BC%8C%E5%88%99%E6%98%AF%E6%B5%8F%E8%A7%88%E5%99%A8%E5%86%85%E7%BD%AE%E7%9A%84%EF%BC%8C%E8%80%8C%E7%94%B1%E4%B8%8B%E5%88%B0%E4%B8%8A%EF%BC%8C%E4%B8%8A%E9%9D%A2%E4%B8%80%E7%BA%A7%E7%9A%84%E6%A0%B7%E5%BC%8F%E5%8F%AF%E4%BB%A5%E8%A6%86%E7%9B%96%E4%B8%8B%E9%9D%A2%E4%B8%80%E7%BA%A7%E7%9A%84%EF%BC%8C%E5%85%B6%E4%B8%AD%EF%BC%9A%0A%0A*%20%E6%B5%8F%E8%A7%88%E5%99%A8%E7%94%A8%E6%88%B7%E8%87%AA%E5%AE%9A%E4%B9%89%E6%A0%B7%E5%BC%8F%EF%BC%8C%E6%98%AF%E6%8C%87%E7%94%A8%E6%88%B7%E5%8F%AF%E4%BB%A5%E9%80%9A%E8%BF%87%E6%B5%8F%E8%A7%88%E5%99%A8%E9%80%89%E9%A1%B9%E4%B8%AD%E6%8F%90%E4%BE%9B%E7%9A%84%E5%8A%9F%E8%83%BD%E6%9D%A5%E8%AE%BE%E7%BD%AE%E6%B5%8F%E8%A7%88%E5%99%A8%E9%BB%98%E8%AE%A4%E7%9A%84%E4%B8%80%E4%BA%9B%E6%A0%B7%E5%BC%8F%EF%BC%8C%E6%AF%94%E5%A6%82%E5%AD%97%E4%BD%93%EF%BC%8C%E5%AD%97%E5%8F%B7%E7%AD%89%EF%BC%9B%0A%0A%20%20!%5Bimage-20200820165341836%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821102458.png)%0A%0A*%20%E6%B5%8F%E8%A7%88%E5%99%A8%E9%BB%98%E8%AE%A4%E6%A0%B7%E5%BC%8F%EF%BC%8C%E5%B0%B1%E6%98%AF%E6%88%91%E4%BB%AC%E4%B8%8A%E9%9D%A2%E8%AF%B4%E7%9A%84%60user%20agent%20stylesheet%60%EF%BC%8C%E6%98%AF%E5%9C%A8%E6%88%91%E4%BB%AC%E6%B2%A1%E6%9C%89%E5%9C%A8%E7%A8%8B%E5%BA%8F%E4%B8%AD%E7%BC%96%E5%86%99%E6%A0%B7%E5%BC%8F%EF%BC%8C%E4%B9%9F%E6%B2%A1%E6%9C%89%E8%AE%BE%E7%BD%AE%E6%B5%8F%E8%A7%88%E5%99%A8%E7%94%A8%E6%88%B7%E8%87%AA%E5%AE%9A%E4%B9%89%E6%A0%B7%E5%BC%8F%E6%97%B6%EF%BC%8C%E6%B5%8F%E8%A7%88%E5%99%A8%E4%BC%9A%E5%8E%BB%E8%AF%BB%E5%8F%96%E4%B8%80%E4%BB%BD%E5%86%85%E7%BD%AE%E7%9A%84%E6%A0%B7%E5%BC%8F%E8%A1%A8%EF%BC%8C%E5%88%A9%E7%94%A8%E8%BF%99%E4%BB%BD%E6%A0%B7%E5%BC%8F%E8%A1%A8%E9%87%8C%E7%9A%84%E6%A0%B7%E5%BC%8F%E6%9D%A5%E6%B8%B2%E6%9F%93%E9%A1%B5%E9%9D%A2%E3%80%82%0A%0A%20%20!%5Bimage-20200820165713997%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821102511.png)%0A%0A%E5%8F%AF%E6%98%AF%E5%9C%A8%E6%A3%80%E6%9F%A5%E5%85%83%E7%B4%A0%E8%BF%99%E9%87%8C%E5%8D%B4%E7%9C%8B%E4%B8%8D%E5%88%B0%60%3Cbr%3E%60%E6%A0%87%E7%AD%BE%E5%AF%B9%E5%BA%94%E7%9A%84%E6%B5%8F%E8%A7%88%E5%99%A8%E9%BB%98%E8%AE%A4%E6%A0%B7%E5%BC%8F%EF%BC%8C%E6%88%91%E4%BB%AC%E6%9F%A5%E9%98%85%E6%B5%8F%E8%A7%88%E5%99%A8%E6%BA%90%E7%A0%81%E4%B8%AD%E7%9A%84%20%5B%E9%BB%98%E8%AE%A4CSS%E6%A0%B7%E5%BC%8F%E8%A1%A8%5D(http%3A%2F%2Ftrac.webkit.org%2Fbrowser%2Fwebkit%2Ftrunk%2FSource%2FWebCore%2Fcss%2Fhtml.css)%EF%BC%8C%E4%B9%9F%E6%B2%A1%E6%9C%89%E5%8F%91%E7%8E%B0%E6%9C%89%20%60%3Cbr%3E%60%20%E6%A0%87%E7%AD%BE%E7%9A%84%E6%A0%B7%E5%BC%8F%EF%BC%8C%E9%82%A3%E5%AE%83%E7%9A%84%E6%8D%A2%E8%A1%8C%E6%98%AF%E5%A6%82%E4%BD%95%E5%AE%9E%E7%8E%B0%E7%9A%84%E5%91%A2%EF%BC%9F%0A%0A%23%23%20br%E7%9A%84CSS%E5%AE%9E%E7%8E%B0%0A%0A%E5%87%A0%E7%BB%8F%E5%91%A8%E6%8A%98%EF%BC%8C%E6%88%91%E4%BB%AC%E5%9C%A8%5BHTML%E8%A7%84%E8%8C%83%E7%9A%84HTML%E6%A0%87%E7%AD%BE%E7%A4%BA%E4%BE%8B%5D(https%3A%2F%2Fwww.w3.org%2FTR%2FCSS21%2Fsample.html)%E4%B8%AD%E6%89%BE%E5%88%B0%E4%BA%86%E5%AE%83%EF%BC%9A%0A%0A!%5Bimage-20200820170511486%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821102524.png)%0A%0A%0A%0A%E5%8E%9F%E6%9D%A5%20%60%3Cbr%3E%60%E6%A0%87%E7%AD%BE%E7%9A%84%E6%8D%A2%E8%A1%8C%E6%98%AF%E8%BF%99%E5%87%A0%E6%9D%A1%60css%60%E8%A7%84%E5%88%99%0A%0A%60%60%60css%0Abr%3Abefore%20%20%20%20%20%20%20%7B%20%0A%20%20%20%20content%3A%20%22%5CA%22%3B%20%0A%20%20%20%20white-space%3A%20pre-line%20%0A%7D%0A%60%60%60%0A%0A%E4%B8%BA%E4%BB%80%E4%B9%88%E8%BF%99%E5%87%A0%E6%9D%A1%E5%B0%B1%E8%83%BD%E5%AE%9E%E7%8E%B0%E6%8D%A2%E8%A1%8C%E5%91%A2%EF%BC%9F%0A%0A%E6%88%91%E4%BB%AC%E7%9F%A5%E9%81%93%60white-space%3Apre-line%60%E7%9A%84%E4%BD%9C%E7%94%A8%E6%98%AF%E5%8E%BB%E9%99%A4%E7%A9%BA%E6%A0%BC%EF%BC%8C%E4%BF%9D%E7%95%99%E6%8D%A2%E8%A1%8C%EF%BC%8C%E4%BD%86%E5%AE%83%E6%9C%AC%E8%BA%AB%E5%B9%B6%E4%B8%8D%E4%BC%9A%E6%B7%BB%E5%8A%A0%E6%8D%A2%E8%A1%8C%E6%95%88%E6%9E%9C%EF%BC%8C%E9%82%A3%E5%89%A9%E4%B8%8B%E7%9A%84%E5%B0%B1%E6%98%AF%E8%A6%81%E5%BC%84%E6%B8%85%E6%A5%9A%60content%EF%BC%9A%20'%5CA'%60%20%E6%98%AF%E4%BB%80%E4%B9%88%E6%84%8F%E6%80%9D%E5%B0%B1%E7%9F%A5%E9%81%93%E6%8D%A2%E8%A1%8C%E6%98%AF%E5%A6%82%E4%BD%95%E5%AE%9E%E7%8E%B0%E7%9A%84%E4%BA%86%E3%80%82%0A%0A%E9%80%9A%E8%BF%87%E6%9F%A5%E7%9C%8B%E8%A7%84%E8%8C%83%EF%BC%8C%60CSS%60%E7%9A%84%60content%60%E5%B1%9E%E6%80%A7%E5%8F%AA%E8%83%BD%E7%94%A8%E4%BA%8E%60%3Aafter%60%E5%92%8C%60%3Abefore%60%E4%BC%AA%E5%85%83%E7%B4%A0%EF%BC%8C%E5%AE%83%E6%8E%A5%E5%8F%97%E4%BB%A5%E4%B8%8B%E7%B1%BB%E5%9E%8B%E7%9A%84%E5%80%BC%EF%BC%9A%0A%0A*%20%E6%99%AE%E9%80%9A%E5%AD%97%E7%AC%A6%E4%B8%B2%EF%BC%8C%E5%A6%82%60content%3A%20'%E4%BD%A0%E5%A5%BD'%60%0A*%20%E5%85%83%E7%B4%A0%E5%B1%9E%E6%80%A7%EF%BC%8C%E5%A6%82%20%60content%3A%20attr(alt)%60%0A*%20%E5%A4%96%E9%83%A8%E8%B5%84%E6%BA%90%EF%BC%9A%E5%A6%82%20%60content%3Aurl(http%3A%2F%2Fwww.baidu.com%2Fpicture%2Fa.jpg)%60%0A*%20%E8%B0%83%E7%94%A8%E8%AE%A1%E6%95%B0%E5%99%A8%EF%BC%9A%20%E5%A6%82%20%60content%3A%20counter(dd)%20'%20'%60%0A*%20%60unicode%60%E5%AD%97%E7%AC%A6%EF%BC%9A%20%E5%A6%82%20%60content%3A'%5C21e0'%60%0A*%20%E5%BC%95%E5%8F%B7%E6%A0%87%E5%BF%97%EF%BC%9A%E5%A6%82%20%60content%3A%20open-quote%20%7C%20close-quote%20%7C%20no-open-quote%20%7C%20no-close-quote%60%0A%0A%EF%BC%81%EF%BC%81%EF%BC%81%E6%81%8D%E7%84%B6%E5%A4%A7%E6%82%9F%EF%BC%8C%E5%8E%9F%E6%9D%A5%60%5CA%60%20%E6%98%AF%20%60unicode%60%20%E5%AD%97%E7%AC%A6%EF%BC%8C%E9%82%A3%E4%B9%88%60%5CA%60%20%E5%9C%A8%60unicode%60%E5%AD%97%E7%AC%A6%E4%B8%AD%E8%A1%A8%E7%A4%BA%E4%BB%80%E4%B9%88%E5%91%A2%EF%BC%9F%0A%0A!%5B%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821102531.jpg)%0A%0A%E4%BC%97%E6%89%80%E5%91%A8%E7%9F%A5%EF%BC%8C%60unicode%60%20%E6%98%AF%20%60ascii%60%E7%9A%84%E8%B6%85%E7%BA%A7%EF%BC%8C%E5%B9%B6%E4%B8%94%60unicode%60%E7%A0%81%E6%98%AF16%E8%BF%9B%E5%88%B6%E7%9A%84%EF%BC%8C%E9%82%A316%E8%BF%9B%E5%88%B6%E7%9A%84%60A%60%E6%AD%A3%E5%A5%BD%E6%98%AF%E5%8D%81%E8%BF%9B%E5%88%B6%E7%9A%84%60010%60%EF%BC%8C%E6%88%91%E4%BB%AC%E7%BB%88%E4%BA%8E%E5%9C%A8%E8%BF%99%E5%BC%A0%E8%A1%A8%E9%87%8C%E6%89%BE%E5%88%B0%E4%BA%86%E5%8D%81%E8%BF%9B%E5%88%B6%60010%60%E7%9A%84%60ascii%60%E7%A0%81%E5%AF%B9%E5%BA%94%E7%9A%84%E5%AD%97%E7%AC%A6%EF%BC%9A%60%5Cn%60%E2%80%94%E2%80%94%20%E6%8D%A2%E8%A1%8C%E7%AC%A6%EF%BC%81%EF%BC%81%EF%BC%81%0A%0A%E7%8E%B0%E5%9C%A8%E6%88%91%E4%BB%AC%E7%9F%A5%E9%81%93%60br%60%E4%B8%BA%E4%BB%80%E4%B9%88%E5%8F%AF%E4%BB%A5%E6%8D%A2%E8%A1%8C%E4%BA%86%EF%BC%9A%0A%0A*%20%E5%88%A9%E7%94%A8%E4%BC%AA%E5%85%83%E7%B4%A0%E5%88%9B%E5%BB%BA%E4%BA%86%E4%B8%80%E4%B8%AA%E5%86%85%E5%AE%B9%E4%B8%BA%E6%8D%A2%E8%A1%8C%E7%AC%A6%E7%9A%84%E5%85%83%E7%B4%A0%0A*%20%E5%88%A9%E7%94%A8%60white-space%60%E5%B1%9E%E6%80%A7%E4%BF%9D%E7%95%99%E4%BA%86%E8%BF%99%E4%B8%AA%E6%8D%A2%E8%A1%8C%E7%AC%A6%0A%0A%23%23%20%E6%89%A9%E5%B1%951%EF%BC%9A%20%E8%87%AA%E5%B7%B1%E5%AE%9E%E7%8E%B0%E6%8D%A2%E8%A1%8C%0A%0A%E6%88%91%E4%BB%AC%E5%AE%8C%E5%85%A8%E5%8F%AF%E4%BB%A5%E4%B8%8D%E7%94%A8%60br%60%E6%A0%87%E7%AD%BE%EF%BC%8C%E8%87%AA%E5%B7%B1%E5%AE%9E%E7%8E%B0%E6%8D%A2%E8%A1%8C%EF%BC%9A%0A%0A%60%60%60html%0A%3Cstyle%3E%0Aspan%3Abefore%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20content%3A'%5CA'%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20white-space%3A%20pre-line%3B%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20span%3Aafter%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20content%3A%20'%5CA'%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20white-space%3A%20pre-line%3B%0A%20%20%20%20%20%20%20%20%7D%0A%3C%2Fstyle%3E%0A%0A%3Cbody%3E%0A%09A%3Cspan%3E%E6%B5%8B%E8%AF%95%E4%B8%8B%E6%8D%A2%E8%A1%8C%3C%2Fspan%3EB%0A%3C%2Fbody%3E%0A%60%60%60%0A%0A%E6%88%91%E4%BB%AC%E7%9C%8B%E7%9C%8B%E6%95%88%E6%9E%9C%EF%BC%9A%0A%0A!%5Bimage-20200820175414520%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821102539.png)%0A%0A%23%23%20%E6%89%A9%E5%B1%952%EF%BC%9A%20%E5%B0%8F%E5%86%99%E7%9A%84a%E8%A1%8C%E4%B8%8D%E8%A1%8C%0A%0A%E7%94%B1%E4%BA%8E%60unicode%60%E7%A0%81%E6%98%AF%E4%B8%8D%E5%8C%BA%E5%88%86%E5%A4%A7%E5%B0%8F%E5%86%99%E7%9A%84%EF%BC%8C%E6%89%80%E4%BB%A5%E6%8A%8A%20%60%5CA%60%20%E6%9B%BF%E6%8D%A2%E6%88%90%60%5Ca%60%E4%B9%9F%E6%98%AF%E5%AE%8C%E5%85%A8%E6%B2%A1%E6%9C%89%E9%97%AE%E9%A2%98%E7%9A%84%EF%BC%8C%E8%AF%BB%E8%80%85%E5%8F%AF%E8%87%AA%E8%A1%8C%E6%B5%8B%E8%AF%95%E3%80%82%0A%0A%23%23%20%E6%89%A9%E5%B1%953%EF%BC%9A%E5%8F%AA%E8%83%BD%E4%BD%BF%E7%94%A8%20pre-line%E5%90%97%0A%0A%E4%BD%BF%E7%94%A8%60white-space%60%E7%9A%84%E7%9B%AE%E7%9A%84%E5%B0%B1%E6%98%AF%E4%BF%9D%E7%95%99%E6%88%91%E4%BB%AC%E5%88%A9%E7%94%A8%60content%60%E5%88%9B%E5%BB%BA%E7%9A%84%E6%8D%A2%E8%A1%8C%E7%AC%A6%EF%BC%8C%E6%89%80%E4%BB%A5%E6%89%80%E6%9C%89%E5%8F%AF%E4%BB%A5%E4%BF%9D%E7%95%99%E6%8D%A2%E8%A1%8C%E7%9A%84%E5%80%BC%E9%83%BD%E6%98%AF%E5%8F%AF%E4%BB%A5%E7%9A%84%EF%BC%9A%0A%0A!%5Bimage-20200820175841022%5D(https%3A%2F%2Fraw.githubusercontent.com%2Fhjb2722404%2Fmyimg%2Fmaster%2F20200821102549.png)%0A%0A%E7%94%B1%E4%B8%8A%E8%A1%A8%E7%9F%A5%EF%BC%8C%E5%8F%AF%E4%BB%A5%E4%BF%9D%E7%95%99%E6%8D%A2%E8%A1%8C%E7%AC%A6%E7%9A%84%60pre%2Cpre-wrap%2Cpre-line%2Cbreak-spaces%60%E9%83%BD%E6%98%AF%E5%8F%AF%E4%BB%A5%E7%9A%84%EF%BC%8C%E8%AF%BB%E8%80%85%E5%8F%AF%E8%87%AA%E8%A1%8C%E6%B5%8B%E8%AF%95%0A%0A%23%23%20%E6%89%A9%E5%B1%954%EF%BC%9A%E6%8D%A2%E8%A1%8C%E6%8D%A2%E6%88%90%E5%9B%9E%E8%BD%A6%E5%8F%AF%E4%BB%A5%E5%90%97%EF%BC%9F%0A%0A%E6%88%91%E4%BB%AC%E7%9F%A5%E9%81%93%EF%BC%8C%E8%A6%81%E7%94%9F%E6%88%90%E6%8D%A2%E8%A1%8C%E7%9A%84%E6%95%88%E6%9E%9C%EF%BC%8C%E9%99%A4%E4%BA%86%E6%8D%A2%E8%A1%8C%E7%AC%A6%EF%BC%8C%E5%9B%9E%E8%BD%A6%E4%B9%9F%E5%8F%AF%E4%BB%A5%E8%BE%BE%E5%88%B0%E7%9B%B8%E5%90%8C%E6%95%88%E6%9E%9C%EF%BC%8C%E9%82%A3%E6%8A%8A%E8%BF%99%E9%87%8C%E7%9A%84%E6%8D%A2%E8%A1%8C%E7%AC%A6%E6%8D%A2%E6%88%90%E5%9B%9E%E8%BD%A6%E7%AC%A6%EF%BC%88%60%5Cd%60%EF%BC%89%E5%8F%AF%E4%BB%A5%E5%90%97%3F%0A%0A%E4%B8%8D%E5%8F%AF%E4%BB%A5%E3%80%82%0A%0A%E8%BF%99%E6%B6%89%E5%8F%8A%E5%88%B0%E5%9B%9E%E8%BD%A6%E5%92%8C%E6%8D%A2%E8%A1%8C%E7%9A%84%E5%8C%BA%E5%88%AB%EF%BC%8C%E7%AE%80%E8%80%8C%E8%A8%80%E4%B9%8B%EF%BC%8C%E8%BF%99%E4%B8%A4%E4%B8%AA%E8%AF%8D%E6%98%AF%E5%80%9F%E9%89%B4%E4%BA%8E%E8%80%81%E5%BC%8F%E6%89%93%E5%AD%97%E6%9C%BA%EF%BC%9A%0A%0A*%22%E5%9B%9E%E8%BD%A6%22%EF%BC%8C%E5%91%8A%E8%AF%89%E6%89%93%E5%AD%97%E6%9C%BA%E6%8A%8A%E6%89%93%E5%8D%B0%E5%A4%B4%E5%AE%9A%E4%BD%8D%E5%9C%A8%E5%B7%A6%E8%BE%B9%E7%95%8C%0A%0A%22%E6%8D%A2%E8%A1%8C%22%EF%BC%8C%20%20%20%E5%91%8A%E8%AF%89%E6%89%93%E5%AD%97%E6%9C%BA%E6%8A%8A%E7%BA%B8%E5%90%91%E4%B8%8B%E7%A7%BB%E4%B8%80%E8%A1%8C%E3%80%82%0A%0A%E5%AF%B9%E5%BA%94%E5%88%B0%E8%AE%A1%E7%AE%97%E6%9C%BA%E8%BE%93%E5%85%A5%E4%B8%AD%EF%BC%8C%E5%9B%9E%E8%BD%A6%E5%8F%AA%E6%98%AF%E4%BB%A3%E8%A1%A8%E6%8A%8A%E5%85%89%E6%A0%87%E5%AE%9A%E4%BD%8D%E5%88%B0%E8%A1%8C%E9%A6%96%EF%BC%8C%E5%B9%B6%E4%B8%8D%E8%83%BD%E5%AE%9E%E7%8E%B0%E6%8D%A2%E8%A1%8C%EF%BC%8C%E7%9C%9F%E6%AD%A3%E8%A6%81%E7%A7%BB%E5%8A%A8%E5%88%B0%E4%B8%8B%E4%B8%80%E8%A1%8C%EF%BC%8C%E8%A6%81%E4%BD%BF%E7%94%A8%E6%8D%A2%E8%A1%8C%E7%AC%A6%0A%0A%23%23%20%E6%89%A9%E5%B1%955%EF%BC%9A%E8%83%BD%E4%B8%8D%E8%83%BD%E8%A6%86%E7%9B%96br%E6%A0%87%E7%AD%BE%E7%9A%84%E6%A0%B7%E5%BC%8F%E8%AE%A9%E5%A5%B9%E4%B8%8D%E6%8D%A2%E8%A1%8C%0A%0A%E6%97%A2%E7%84%B6%E6%88%91%E4%BB%AC%E5%89%8D%E9%9D%A2%E8%AE%B2%60CSS%60%E4%BA%94%E4%B8%AA%E6%9D%A5%E6%BA%90%E6%97%B6%EF%BC%8C%E8%AF%B4%E4%B8%8A%E4%B8%80%E7%BA%A7%E7%9A%84%E4%BC%9A%E8%A6%86%E7%9B%96%E4%B8%8B%E4%B8%80%E7%BA%A7%EF%BC%8C%E6%88%91%E4%BB%AC%E5%8F%AF%E4%BB%A5%E5%88%A9%E7%94%A8%E8%BF%99%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%8C%E5%B0%86%60span%60%E5%8F%98%E6%88%90%E5%9D%97%E7%BA%A7%E5%85%83%E7%B4%A0%EF%BC%8C%E5%B0%86%60p%60%E5%8F%98%E6%88%90%E5%86%85%E8%81%94%E5%85%83%E7%B4%A0%EF%BC%8C%E9%82%A3%E6%88%91%E4%BB%AC%E5%9C%A8%E8%87%AA%E5%B7%B1%E7%9A%84%60CSS%60%E4%B8%AD%E9%87%8D%E5%86%99%60br%60%E7%9A%84%E4%BC%AA%E5%85%83%E7%B4%A0%E6%A0%B7%E5%BC%8F%EF%BC%8C%E5%8F%AF%E4%BB%A5%E6%94%B9%E5%8F%98%E5%AE%83%E7%9A%84%E8%A1%8C%E4%B8%BA%E5%90%97%EF%BC%9F%0A%0A%60%60%60css%0Abr%3A%3Abefore%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20content%3A%20'%5Cd'%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20white-space%3A%20nowrap%3B%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20br%3A%3Aafter%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20content%3A%20'%5Cd'%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20white-space%3A%20nowrap%3B%0A%20%20%20%20%20%20%20%20%7D%0A%60%60%60%0A%0A%0A%0A%E7%BB%8F%E8%BF%87%E6%B5%8B%E8%AF%95%EF%BC%8C%E4%B8%8D%E5%8F%AF%E4%BB%A5%E3%80%82%0A%0A%E5%8E%9F%E5%9B%A0%E6%9A%82%E6%97%B6%E6%9C%AA%E7%9F%A5%EF%BC%8C%E5%A6%82%E6%9E%9C%E8%AF%BB%E8%80%85%E4%B8%AD%E6%9C%89%E7%A0%94%E7%A9%B6%E5%87%BA%E7%BB%93%E6%9E%9C%E7%9A%84%EF%BC%8C%E6%AC%A2%E8%BF%8E%E5%88%86%E4%BA%AB%E5%87%BA%E6%9D%A5%E3%80%82%0A%0A%E7%BB%8F%E8%BF%87%E5%AF%B9%E8%A7%84%E8%8C%83%E6%96%87%E6%A1%A3%E4%B8%80%E7%95%AA%E6%90%9C%E7%B4%A2%EF%BC%8C%E5%8F%91%E7%8E%B0%E4%B8%80%E4%BA%9B%E8%9B%9B%E4%B8%9D%E9%A9%AC%E8%BF%B9%EF%BC%9A%0A%0A%E9%A6%96%E5%85%88%EF%BC%8C%E5%9C%A8%60HTML%60%E8%A7%84%E8%8C%83%E4%B8%AD%5B%E5%85%B3%E4%BA%8E%60br%60%E6%A0%87%E7%AD%BE%E7%9A%84%E8%AF%B4%E6%98%8E%E9%83%A8%E5%88%86%5D(https%3A%2F%2Fwww.w3.org%2FTR%2Fhtml52%2Ftextlevel-semantics.html%23the-br-element)%EF%BC%8C%20%E6%88%91%E4%BB%AC%E5%8F%AF%E4%BB%A5%E6%89%BE%E5%88%B0%E4%BB%A5%E4%B8%8B%E8%AF%B4%E6%98%8E%EF%BC%9A%0A%0A%3E%20This%20element%20%5Bhas%20rendering%20requirements%20involving%20the%20bidirectional%20algorithm%5D(https%3A%2F%2Fwww.w3.org%2FTR%2Fhtml52%2Fdom.html%23bidireq).%0A%3E%0A%3E%20%E8%AF%A5%E5%85%83%E7%B4%A0%E6%B8%B2%E6%9F%93%E6%97%B6%E9%9C%80%E8%A6%81%E7%AC%A6%E5%90%88%E5%8F%8C%E5%90%91%E6%BC%94%E5%8C%96%E7%AE%97%E6%B3%95%E7%9A%84%E8%A6%81%E6%B1%82%0A%0A%E5%A5%BD%EF%BC%8C%E5%85%88%E6%9A%82%E5%81%9C%E4%B8%80%E4%B8%8B%EF%BC%8C%E5%95%A5%E6%98%AF%E4%B8%AA%E5%8F%8C%E5%90%91%E6%BC%94%E5%8C%96%E7%AE%97%E6%B3%95%EF%BC%9F%0A%0A%E6%88%91%E4%BB%AC%E9%83%BD%E7%9F%A5%E9%81%93%EF%BC%8C%E4%B8%80%E8%88%AC%E6%9D%A5%E8%AF%B4%EF%BC%8C%E6%88%91%E4%BB%AC%E6%8E%A5%E8%A7%A6%E7%9A%84%E4%B9%A6%E5%86%99%E8%AF%AD%E8%A8%80%EF%BC%8C%E6%97%A0%E8%AE%BA%E6%98%AF%E6%B1%89%E8%AF%AD%E8%BF%98%E6%98%AF%E8%8B%B1%E8%AF%AD%E8%BF%98%E6%98%AF%E5%BE%B7%E8%AF%AD%E6%B3%95%E8%AF%AD%EF%BC%8C%E5%AE%83%E7%9A%84%E4%B9%A6%E5%86%99%E9%A1%BA%E5%BA%8F%E9%83%BD%E6%98%AF%E4%BB%8E%E5%B7%A6%E8%87%B3%E5%8F%B3%E7%9A%84%EF%BC%8C%E5%8F%AF%E6%98%AF%E4%B8%96%E7%95%8C%E6%98%AF%E5%A4%9A%E6%A0%B7%E7%9A%84%EF%BC%8C%E5%B0%B1%E6%9C%89%E9%82%A3%E4%B9%88%E4%B8%80%E4%BA%9B%E8%AF%AD%E8%A8%80%EF%BC%8C%E5%AE%83%E7%9A%84%E4%B9%A6%E5%86%99%E6%96%B9%E5%90%91%E5%81%8F%E5%81%8F%E5%B0%B1%E6%98%AF%E4%BB%8E%E5%8F%B3%E8%87%B3%E5%B7%A6%E7%9A%84%EF%BC%8C%E6%AF%94%E5%A6%82%E9%98%BF%E6%8B%89%E4%BC%AF%E8%AF%AD%E7%AD%89%EF%BC%8C%E8%BF%99%E8%BF%98%E4%B8%8D%E6%98%AF%E9%97%AE%E9%A2%98%EF%BC%8C%E5%85%B3%E9%94%AE%E6%98%AF%EF%BC%8C%E8%BF%99%E4%BA%9B%E8%AF%AD%E8%A8%80%E4%B8%AD%E7%9A%84%E6%95%B0%E5%AD%97%E5%8D%B4%E5%8F%88%E6%98%AF%E4%BB%8E%E5%B7%A6%E8%87%B3%E5%8F%B3%E4%B9%A6%E5%86%99%E7%9A%84%EF%BC%8C%E8%BF%99%E6%A0%B7%E5%B0%B1%E5%AF%BC%E8%87%B4%E8%BF%99%E7%A7%8D%E8%AF%AD%E8%A8%80%E5%AE%9E%E8%B4%A8%E4%B8%8A%E5%90%8C%E6%97%B6%E5%8C%85%E5%90%AB%E4%BA%86%E4%B8%A4%E7%A7%8D%E4%B9%A6%E5%86%99%E6%96%B9%E5%90%91%EF%BC%8C%E8%80%8C%E5%9C%A8%E8%AE%A1%E7%AE%97%E6%9C%BA%E4%B8%AD%EF%BC%8C%E8%BF%99%E4%BA%9B%E8%AF%AD%E8%A8%80%E7%9A%84%E6%96%87%E5%AD%97%E9%83%BD%E6%98%AF%E4%BD%BF%E7%94%A8%60unicode%60%E7%BC%96%E7%A0%81%E6%9D%A5%E5%AE%9E%E7%8E%B0%E7%9A%84%EF%BC%8C%E6%89%80%E4%BB%A5%EF%BC%8C%E8%81%AA%E6%98%8E%E7%9A%84%E5%A4%A7%E7%A5%9E%E4%BB%AC%E8%AE%BE%E8%AE%A1%E4%BA%86%E9%92%88%E5%AF%B9%60unicode%60%E5%AD%97%E7%AC%A6%E9%9B%86%E7%9A%84%60%E5%8F%8C%E5%90%91%E6%BC%94%E5%8C%96%E7%AE%97%E6%B3%95%60%E6%9D%A5%E8%A7%A3%E5%86%B3%E8%BF%99%E7%B1%BB%E9%97%AE%E9%A2%98%E3%80%82%0A%0A%E5%A5%BD%E5%B7%A7%E4%B8%8D%E5%B7%A7%EF%BC%8C%E4%BB%BB%E4%BD%95%E8%AF%AD%E8%A8%80%E7%9A%84%E4%B9%A6%E5%86%99%E9%83%BD%E9%9C%80%E8%A6%81%E6%8D%A2%E8%A1%8C%EF%BC%88%E8%BF%99%E4%B8%8D%E5%BA%9F%E8%AF%9D%E5%90%97%EF%BC%89%EF%BC%8C%E6%89%80%E4%BB%A5%60br%60%20%E7%9A%84%E6%B8%B2%E6%9F%93%E4%B9%9F%E8%A6%81%E7%AC%A6%E5%90%88%E5%8F%8C%E5%90%91%E6%BC%94%E5%8C%96%E7%AE%97%E6%B3%95%E7%9A%84%E8%A6%81%E6%B1%82%E3%80%82%0A%0A%E7%9F%A5%E9%81%93%E4%BA%86%E8%BF%99%E4%B8%AA%EF%BC%8C%E6%88%91%E4%BB%AC%E5%86%8D%E6%9D%A5%E7%9C%8B%5B%E5%8F%8C%E5%90%91%E6%BC%94%E5%8C%96%E7%AE%97%E6%B3%95%E7%9A%84%E8%A6%81%E6%B1%82%5D(https%3A%2F%2Fwww.w3.org%2FTR%2Fhtml52%2Fdom.html%23bidireq)%EF%BC%9A%0A%0A%3EThe%20mapping%20of%20HTML%20to%20the%20Unicode%20bidirectional%20algorithm%20must%20be%20done%20in%20one%20of%20three%20ways.%20Either%20the%20user%20agent%20must%20implement%20CSS%2C%20including%20in%20particular%20the%20CSS%20%5Bunicode-bidi%5D(https%3A%2F%2Fwww.w3.org%2FTR%2Fcss-writing-modes-3%2F%23propdef-unicode-bidi)%2C%20%5Bdirection%5D(https%3A%2F%2Fwww.w3.org%2FTR%2Fcss-writing-modes-3%2F%23propdef-direction)%2C%20and%20%5Bcontent%5D(https%3A%2F%2Fwww.w3.org%2FTR%2Fcss-content-3%2F%23propdef-content)%20properties%2C%20and%20must%20have%2C%20in%20its%20user%20agent%20style%20sheet%2C%20the%20rules%20using%20those%20properties%20given%20in%20this%20specification%E2%80%99s%20%5Brendering%5D(https%3A%2F%2Fwww.w3.org%2FTR%2Fhtml52%2Frendering.html%23rendering)%20section%2C%20or%2C%20alternatively%2C%20the%20user%20agent%20must%20act%20as%20if%20it%20implemented%20just%20the%20aforementioned%20properties%20and%20had%20a%20user%20agent%20style%20sheet%20that%20included%20all%20the%20aforementioned%20rules%2C%20but%20without%20letting%20style%20sheets%20specified%20in%20documents%20override%20them%2C%20or%2C%20alternatively%2C%20the%20user%20agent%20must%20implement%20another%20styling%20language%20with%20equivalent%20semantics.%20%5B%5BCSS-WRITING-MODES-3%5C%5D%5D(https%3A%2F%2Fwww.w3.org%2FTR%2Fhtml52%2Freferences.html%23biblio-css-writing-modes-3)%20%5B%5BCSS3-CONTENT%5C%5D%5D(https%3A%2F%2Fwww.w3.org%2FTR%2Fhtml52%2Freferences.html%23biblio-css3-content)%0A%3E%0A%3EHTML%E5%88%B0Unicode%E5%8F%8C%E5%90%91%E7%AE%97%E6%B3%95%E7%9A%84%E6%98%A0%E5%B0%84%E5%BF%85%E9%A1%BB%E9%80%9A%E8%BF%87%E4%BB%A5%E4%B8%8B%E4%B8%89%E7%A7%8D%E6%96%B9%E5%BC%8F%E4%B9%8B%E4%B8%80%E5%AE%8C%E6%88%90%E3%80%82%20%E7%94%A8%E6%88%B7%E4%BB%A3%E7%90%86%E5%BF%85%E9%A1%BB%E5%AE%9E%E7%8E%B0CSS%EF%BC%8C%E7%89%B9%E5%88%AB%E6%98%AFCSS%20unicode-bidi%EF%BC%8Cdirection%E5%92%8Ccontent%E5%B1%9E%E6%80%A7%EF%BC%8C%E5%B9%B6%E4%B8%94%E5%BF%85%E9%A1%BB%E5%9C%A8%E5%85%B6%E7%94%A8%E6%88%B7%E4%BB%A3%E7%90%86%E6%A0%B7%E5%BC%8F%E8%A1%A8%E4%B8%AD%E5%85%B7%E6%9C%89%E4%BD%BF%E7%94%A8%E6%9C%AC%E8%A7%84%E8%8C%83%E5%91%88%E7%8E%B0%E9%83%A8%E5%88%86%E4%B8%AD%E7%BB%99%E5%87%BA%E7%9A%84%E9%82%A3%E4%BA%9B%E5%B1%9E%E6%80%A7%E7%9A%84%E8%A7%84%E5%88%99%EF%BC%8C%E6%88%96%E8%80%85%EF%BC%8C**%20%E7%94%A8%E6%88%B7%E4%BB%A3%E7%90%86%E5%BF%85%E9%A1%BB%E5%85%85%E5%BD%93%E4%BB%85%E5%AE%9E%E7%8E%B0%E4%B8%8A%E8%BF%B0%E5%B1%9E%E6%80%A7%E7%9A%84%E8%A1%8C%E4%B8%BA%EF%BC%8C%E5%B9%B6%E4%B8%94%E5%85%B7%E6%9C%89%E5%8C%85%E6%8B%AC%E6%89%80%E6%9C%89%E4%B8%8A%E8%BF%B0%E8%A7%84%E5%88%99%E7%9A%84%E7%94%A8%E6%88%B7%E4%BB%A3%E7%90%86%E6%A0%B7%E5%BC%8F%E8%A1%A8%EF%BC%8C%E4%BD%86%E5%8F%88%E4%B8%8D%E8%83%BD%E8%AE%A9%E6%96%87%E6%A1%A3%E4%B8%AD%E6%8C%87%E5%AE%9A%E7%9A%84%E6%A0%B7%E5%BC%8F%E8%A1%A8%E8%A6%86%E7%9B%96%E5%AE%83%E4%BB%AC%EF%BC%8C%E6%88%96%E8%80%85%EF%BC%8C%E7%94%A8%E6%88%B7%E4%BB%A3%E7%90%86%E5%BF%85%E9%A1%BB%E5%AE%9E%E6%96%BD%E5%8F%A6%E4%B8%80%E7%A7%8D%E6%A0%B7%E5%BC%8F%E8%AF%AD%E8%A8%80%20%E5%85%B7%E6%9C%89%E7%9B%B8%E5%90%8C%E7%9A%84%E8%AF%AD%E4%B9%89%20**%0A%0A%E7%9C%8B%E5%88%B0%E4%B8%8A%E9%9D%A2%E6%88%91%E7%94%A8%E4%B8%80%E5%AF%B9%E6%98%9F%E5%8F%B7%E6%8B%AC%E8%B5%B7%E6%9D%A5%E7%9A%84%E5%86%85%E5%AE%B9%E6%B2%A1%EF%BC%8C%E5%B0%B1%E6%98%AF%E8%AF%B4%E4%BD%9C%E4%B8%BA%E7%94%A8%E6%88%B7%E4%BB%A3%E7%90%86%EF%BC%8C%E6%B5%8F%E8%A7%88%E5%99%A8%E6%9C%89%E4%B8%A4%E7%A7%8D%E9%80%89%E6%8B%A9%EF%BC%9A%0A%0A*%20%E5%AE%9E%E7%8E%B0%E8%A7%84%E8%8C%83%E7%BB%99%E5%87%BA%E7%9A%84%E8%A7%84%E5%88%99%EF%BC%8C%E5%B9%B6%E4%B8%94%E4%B8%8D%E5%85%81%E8%AE%B8%E6%96%87%E6%A1%A3%E4%B8%AD%E7%9A%84%E6%A0%B7%E5%BC%8F%E8%A1%A8%E8%A6%86%E7%9B%96%E4%BB%96%E4%BB%AC%E3%80%82%E3%80%90%E5%90%BC%E5%90%BC%EF%BC%8C%E8%A2%AB%E6%88%91%E6%8A%93%E5%88%B0%E4%BA%86%E3%80%91%0A*%20%E8%AF%95%E8%AF%95%E5%8F%A6%E4%B8%80%E7%A7%8D%E6%A0%B7%E5%BC%8F%E8%AF%AD%E8%A8%80%EF%BC%8C%E5%85%B7%E6%9C%89%E7%9B%B8%E5%90%8C%E7%9A%84%E8%AF%AD%E4%B9%89%E3%80%90%E4%B9%9F%E5%8F%AF%E8%83%BD%E6%98%AF%E8%BF%99%E7%A7%8D%E3%80%91%0A%0A%E9%82%A3%E6%88%91%E4%BB%AC%E7%9C%8B%E7%9C%8B%5B%E8%A7%84%E8%8C%83%E7%BB%99%E5%87%BA%E7%9A%84%E8%A7%84%E5%88%99%5D(https%3A%2F%2Fwww.w3.org%2FTR%2Fhtml52%2Frendering.html%23bidirectional-text)%EF%BC%9A%0A%0A%60%60%60css%0A%40namespace%20url(http%3A%2F%2Fwww.w3.org%2F1999%2Fxhtml)%3B%0A%0A%5Bdir%5D%3Adir(ltr)%2C%20bdi%3Adir(ltr)%2C%20input%5Btype%3Dtel%20i%5D%3Adir(ltr)%20%7B%20direction%3A%20ltr%3B%20%7D%0A%5Bdir%5D%3Adir(rtl)%2C%20bdi%3Adir(rtl)%20%7B%20direction%3A%20rtl%3B%20%7D%0A%0Aaddress%2C%20blockquote%2C%20center%2C%20div%2C%20figure%2C%20figcaption%2C%20footer%2C%20form%2C%20header%2C%20hr%2C%0Alegend%2C%20listing%2C%20main%2C%20p%2C%20plaintext%2C%20pre%2C%20summary%2C%20xmp%2C%20article%2C%20aside%2C%20h1%2C%20h2%2C%0Ah3%2C%20h4%2C%20h5%2C%20h6%2C%20hgroup%2C%20nav%2C%20section%2C%20table%2C%20caption%2C%20colgroup%2C%20col%2C%20thead%2C%0Atbody%2C%20tfoot%2C%20tr%2C%20td%2C%20th%2C%20dir%2C%20dd%2C%20dl%2C%20dt%2C%20ol%2C%20ul%2C%20li%2C%20bdi%2C%20output%2C%0A%5Bdir%3Dltr%20i%5D%2C%20%5Bdir%3Drtl%20i%5D%2C%20%5Bdir%3Dauto%20i%5D%20%7B%0A%20%20unicode-bidi%3A%20isolate%3B%0A%7D%0A%0Abdo%2C%20bdo%5Bdir%5D%20%7B%20unicode-bidi%3A%20isolate-override%3B%20%7D%0A%0Ainput%5Bdir%3Dauto%20i%5D%3Amatches(%5Btype%3Dsearch%20i%5D%2C%20%5Btype%3Dtel%20i%5D%2C%20%5Btype%3Durl%20i%5D%2C%0A%5Btype%3Demail%20i%5D)%2C%20textarea%5Bdir%3Dauto%20i%5D%2C%20pre%5Bdir%3Dauto%20i%5D%20%7B%0A%20%20unicode-bidi%3A%20plaintext%3B%0A%7D%0A%2F*%20see%20prose%20for%20input%20elements%20whose%20type%20attribute%20is%20in%20the%20Text%20state%20*%2F%0A%0A%2F*%20the%20rules%20setting%20the%20'content'%20property%20on%20%3Cbr%3E%20and%20%3Cwbr%3E%20elements%20also%20has%20bidi%20implications%20*%2F%0A%60%60%60%0A%0A%E7%9C%8B%E5%88%B0%E7%AC%AC22%E8%A1%8C%E7%9A%84%E6%B3%A8%E9%87%8A%E4%BA%86%E5%90%97%EF%BC%9F%0A%0A%E5%AE%83%E7%9A%84%E6%84%8F%E6%80%9D%E6%98%AF%60br%60%E6%A0%87%E7%AD%BE%E7%9A%84%60content%60%E5%B1%9E%E6%80%A7%E5%8F%AF%E4%BB%A5%E8%AE%BE%E7%BD%AE%E7%B1%BB%E4%BC%BC%E4%BB%A5%E4%B8%8A%E7%9A%84%E8%A7%84%E5%88%99%E3%80%82%0A%0A%E4%BD%86%E5%90%8C%E6%97%B6%EF%BC%8C%60br%60%E6%A0%87%E7%AD%BE%E5%8F%88%E5%B1%9E%E4%BA%8E%E6%AE%B5%E8%90%BD%E6%96%87%E6%9C%AC%E7%B1%BB%E5%9E%8B%EF%BC%8C%E5%AE%83%E5%90%8C%E6%A0%B7%E5%8F%AF%E4%BB%A5%E5%AE%9E%E7%8E%B0%5B%E6%AE%B5%E8%90%BD%E6%96%87%E6%9C%AC%E7%9A%84%E8%A7%84%E5%88%99%5D(https%3A%2F%2Fwww.w3.org%2FTR%2Fhtml52%2Frendering.html%23non-replaced-elements-phrasing-content)%EF%BC%9A%0A%0A%60%60%60css%0A%2F%2F%E2%80%A6%E2%80%A6%0Abr%20%7B%20display-outside%3A%20newline%3B%20%7D%20%2F*%20this%20also%20has%20bidi%20implications%20*%2F%0A%2F%2F%E2%80%A6%E2%80%A6%0A%60%60%60%0A%0A%E9%81%97%E6%86%BE%E7%9A%84%E6%98%AF%EF%BC%8C%E8%BF%99%E4%BA%9B%E9%83%BD%E5%8F%AA%E6%98%AF%E8%A7%84%E8%8C%83%E6%8E%A8%E8%8D%90%E7%9A%84%E8%A7%84%E5%88%99%EF%BC%8C%E6%B5%8F%E8%A7%88%E5%99%A8%E5%8F%AF%E4%BB%A5%E4%B8%8D%E6%8C%89%E8%BF%99%E4%BA%9B%E8%A7%84%E5%88%99%E5%AE%9E%E7%8E%B0%EF%BC%8C%E5%8F%AA%E8%A6%81%E5%AE%9E%E7%8E%B0%E7%9B%B8%E5%90%8C%E7%9A%84%E8%AF%AD%E4%B9%89%E5%B0%B1%E5%8F%AF%E4%BB%A5%E3%80%82%0A%0A%E9%82%A3%E6%B5%8F%E8%A7%88%E5%99%A8%E8%BF%98%E6%9C%89%E4%BB%80%E4%B9%88%E9%80%89%E6%8B%A9%E5%91%A2%EF%BC%9F%0A%0A%E8%BF%99%E5%8F%88%E5%BC%95%E5%87%BA%E4%BA%86%E5%8F%A6%E4%B8%80%E5%AF%B9%E6%A6%82%E5%BF%B5%EF%BC%9A%E6%9B%BF%E6%8D%A2%E5%85%83%E7%B4%A0%E4%B8%8E%E9%9D%9E%E6%9B%BF%E6%8D%A2%E5%85%83%E7%B4%A0%0A%0A%E8%AF%B4%E5%88%B0%60CSS%60%E7%9A%84%E6%A8%A1%E5%9E%8B%EF%BC%8C%E6%88%91%E4%BB%AC%E9%83%BD%E7%9F%A5%E9%81%93%E5%9D%97%E7%BA%A7%E5%85%83%E7%B4%A0%E5%92%8C%E5%86%85%E8%81%94%E5%85%83%E7%B4%A0%E7%9A%84%E5%8C%BA%E5%88%86%EF%BC%8C%E4%BD%86%E5%8D%B4%E5%BE%88%E5%B0%91%E4%BA%86%E8%A7%A3%EF%BC%8C%E5%85%B6%E5%AE%9E%E8%BF%98%E6%9C%89%E4%B8%80%E7%A7%8D%E7%BB%B4%E5%BA%A6%E7%9A%84%E5%8C%BA%E5%88%86%E6%96%B9%E5%BC%8F%EF%BC%8C%E5%B0%B1%E6%98%AF%E6%9B%BF%E6%8D%A2%E5%85%83%E7%B4%A0%E5%92%8C%E9%9D%9E%E6%9B%BF%E6%8D%A2%E5%85%83%E7%B4%A0%E3%80%82%0A%0A%E6%89%80%E8%B0%93%E6%9B%BF%E6%8D%A2%E5%85%83%E7%B4%A0%EF%BC%8C%E5%B0%B1%E6%98%AF%E5%9C%A8%E6%B8%B2%E6%9F%93%E6%97%B6%EF%BC%8C%E7%9B%B4%E6%8E%A5%E7%94%A8%E5%85%B6%E5%AE%83%E5%86%85%E5%AE%B9%E5%B0%86%E5%AE%83%E6%9B%BF%E6%8D%A2%E6%8E%89%EF%BC%8C%E6%89%80%E4%BB%A5%E5%AE%83%E5%B9%B6%E4%B8%8D%E5%B1%9E%E4%BA%8E%60CSS%60%E6%A0%BC%E5%BC%8F%E5%8C%96%E6%A8%A1%E5%9E%8B%EF%BC%8C%E8%80%8C%E6%98%AF%E7%8B%AC%E7%AB%8B%E8%AE%A1%E7%AE%97%E6%B8%B2%E6%9F%93%E7%9A%84%EF%BC%8C%E4%BD%86%E6%98%AF%E6%88%91%E4%BB%AC%E5%8F%AF%E4%BB%A5%E9%80%9A%E8%BF%87%60CSS%60%E6%A0%B7%E5%BC%8F%E8%AE%BE%E7%BD%AE%E5%AE%83%E7%9A%84%E5%A4%A7%E5%B0%8F%E5%92%8C%E4%BD%8D%E7%BD%AE%E3%80%82%EF%BC%88%E8%BF%99%E4%B8%AA%E5%85%B7%E4%BD%93%E6%AF%94%E8%BE%83%E5%A4%8D%E6%9D%82%EF%BC%8C%E6%9C%89%E5%85%B4%E8%B6%A3%E5%8F%AF%E4%BB%A5%E8%87%AA%E8%A1%8C%E7%A0%94%E7%A9%B6%E4%B8%8B%EF%BC%89%0A%0A%E6%AF%94%E5%A6%82%EF%BC%8C%60img%60%E6%A0%87%E7%AD%BE%E5%B0%B1%E6%98%AF%E5%85%B8%E5%9E%8B%E7%9A%84%E6%9B%BF%E6%8D%A2%E5%85%83%E7%B4%A0%EF%BC%8C%E6%B5%8F%E8%A7%88%E5%99%A8%E5%9C%A8%E6%B8%B2%E6%9F%93%E5%AE%83%E7%9A%84%E6%97%B6%E5%80%99%EF%BC%8C%E5%AE%9E%E9%99%85%E4%B8%8A%E6%98%AF%E7%9B%B4%E6%8E%A5%E6%8B%BF%E5%AE%83%E7%9A%84%60src%60%E5%B1%9E%E6%80%A7%E6%89%80%E6%8C%87%E5%90%91%E7%9A%84%E5%9B%BE%E7%89%87%E5%AF%B9%E8%B1%A1%E5%B0%86%E5%AE%83%E6%9B%BF%E6%8D%A2%E4%BA%86%E3%80%82%20%E5%B0%BD%E7%AE%A1%E6%88%91%E4%BB%AC%E6%9F%A5%E7%9C%8B%E6%BA%90%E7%A0%81%E5%8F%AF%E4%BB%A5%E7%9C%8B%E5%88%B0%E5%AE%83%E7%9A%84%E4%BD%8D%E7%BD%AE%E4%BB%8D%E6%97%A7%E6%98%AF%E4%B8%80%E4%B8%AA%60img%60%E6%A0%87%E7%AD%BE%EF%BC%8C%E4%BD%86%E6%98%AF%E5%AE%9E%E9%99%85%E4%B8%8A%E5%9C%A8%E6%B8%B2%E6%9F%93%E5%B1%82%E9%9D%A2%EF%BC%8C%E5%AE%83%E5%B7%B2%E7%BB%8F%E8%A2%AB%E6%9B%BF%E6%8D%A2%EF%BC%8C%0A%0A%E5%9C%A8%5B%60MDN%60%E6%96%87%E6%A1%A3%5D(https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FCSS%2F%3A%3Abefore)%E4%B8%AD%EF%BC%8C%E6%88%91%E4%BB%AC%E4%B9%9F%E5%8F%AF%E4%BB%A5%E6%89%BE%E5%88%B0%E8%BF%99%E6%A0%B7%E7%9A%84%E8%AF%9D%EF%BC%9A%0A%0A%3E%E7%94%B1%60%3A%3Abefore%60%20%E5%92%8C%60%3A%3Aafter%60%20%E7%94%9F%E6%88%90%E7%9A%84%E4%BC%AA%E5%85%83%E7%B4%A0%20%5B%E5%8C%85%E5%90%AB%E5%9C%A8%E5%85%83%E7%B4%A0%E6%A0%BC%E5%BC%8F%E6%A1%86%E5%86%85%5D(https%3A%2F%2Fwww.w3.org%2FTR%2FCSS2%2Fgenerate.html%23before-after-content)%EF%BC%8C%20%E5%9B%A0%E6%AD%A4%E4%B8%8D%E8%83%BD%E5%BA%94%E7%94%A8%E5%9C%A8*%5B%E6%9B%BF%E6%8D%A2%E5%85%83%E7%B4%A0%E4%B8%8A%5D(https%3A%2F%2Fdeveloper.mozilla.org%2Fen-US%2Fdocs%2FWeb%2FCSS%2FReplaced_element)%EF%BC%8C*%20%E6%AF%94%E5%A6%82%60%3Cimg%3E%60%E6%88%96%60%3Cbr%3E%60%E5%85%83%E7%B4%A0%E3%80%82%0A%0A%E5%B0%B1%E6%98%AF%E8%BF%99%E4%B9%88%E5%A5%87%E6%80%AA%EF%BC%8C%E5%9C%A8%60HTML%60%E8%A7%84%E8%8C%83%E4%B8%AD%EF%BC%8C%E6%9B%BF%E6%8D%A2%E5%85%83%E7%B4%A0%E5%B9%B6%E4%B8%8D%E5%8C%85%E5%90%AB%60%3Cbr%3E%60%EF%BC%8C%E4%BD%86%E5%9C%A8%E8%BF%99%E9%87%8C%EF%BC%8C%E5%8F%88%E8%AF%B4%60%3Cbr%3E%60%E6%98%AF%E6%9B%BF%E6%8D%A2%E5%85%83%E7%B4%A0%EF%BC%8C%E6%88%91%E4%BB%AC%E5%8F%AA%E8%83%BD%E6%9A%82%E6%97%B6%E8%AE%A4%E4%B8%BA%EF%BC%8C%E5%9C%A8%E6%B5%8F%E8%A7%88%E5%99%A8%E5%86%85%E6%A0%B8%E5%AE%9E%E7%8E%B0%E6%97%B6%EF%BC%8C%E5%BC%80%E5%8F%91%E4%BA%BA%E5%91%98%E5%8F%AF%E8%83%BD%E4%BC%9A%E9%80%89%E6%8B%A9%E4%BD%BF%E7%94%A8%E8%BF%99%E7%A7%8D%E6%96%B9%E5%BC%8F%E6%9D%A5%E5%AE%9E%E7%8E%B0%E6%8D%A2%E8%A1%8C%EF%BC%9A%0A%0A%E2%80%94%E2%80%94%E7%9B%B4%E6%8E%A5%E5%B0%86%60br%60%E6%A0%87%E7%AD%BE%E6%9B%BF%E6%8D%A2%E4%B8%BA%E4%B8%80%E4%B8%AA%E6%8D%A2%E8%A1%8C%E7%AC%A6%E3%80%82%0A%0A%E6%A0%B9%E6%8D%AE%E5%8F%AF%E4%BB%A5%E6%9F%A5%E9%98%85%E5%88%B0%E7%9A%84%E8%B5%84%E6%96%99%EF%BC%8C%E7%9B%AE%E5%89%8D%E5%B0%B1%E5%8F%AA%E6%9C%89%E8%BF%99%E4%B8%A4%E7%A7%8D%E7%8C%9C%E6%B5%8B%EF%BC%9A%0A%0A*%20%E6%B5%8F%E8%A7%88%E5%99%A8%E5%AE%9E%E7%8E%B0%E4%BA%86%E8%A7%84%E8%8C%83%E6%8E%A8%E8%8D%90%E7%9A%84%E8%A7%84%E5%88%99%EF%BC%8C%E8%BF%99%E4%BA%9B%E8%A7%84%E5%88%99%E8%A2%AB%E9%9A%90%E8%97%8F%E8%B5%B7%E6%9D%A5%E4%BA%86%EF%BC%8C%E6%89%80%E4%BB%A5%E6%9F%A5%E7%9C%8B%E5%85%83%E7%B4%A0%E6%97%B6%E7%9C%8B%E4%B8%8D%E5%88%B0%E5%AE%83%E7%9A%84%E9%BB%98%E8%AE%A4%E8%A7%84%E5%88%99%EF%BC%8C%E5%90%8C%E6%97%B6%E6%A0%B9%E6%8D%AE%E5%8F%8C%E5%90%91%E6%BC%94%E5%8C%96%E7%AE%97%E6%B3%95%E8%A6%81%E6%B1%82%E7%A6%81%E6%AD%A2%E6%88%91%E4%BB%AC%E5%8E%BB%E8%A6%86%E7%9B%96%E5%AE%83%E7%9A%84%E8%A7%84%E5%88%99%0A*%20%E6%B5%8F%E8%A7%88%E5%99%A8%E9%80%89%E6%8B%A9%E4%BA%86%E5%B0%86%E5%AE%83%E5%AE%9E%E7%8E%B0%E4%B8%BA%E6%9B%BF%E6%8D%A2%E5%85%83%E7%B4%A0%EF%BC%8C%E5%9B%A0%E4%B8%BA%E6%9B%BF%E6%8D%A2%E5%85%83%E7%B4%A0%E4%B8%8D%E5%B1%9E%E4%BA%8E%60CSS%60%E6%A0%BC%E5%BC%8F%E5%8C%96%E6%A8%A1%E5%9E%8B%EF%BC%8C%E6%89%80%E4%BB%A5%E6%88%91%E4%BB%AC%E6%97%A0%E6%B3%95%E9%80%9A%E8%BF%87%E8%87%AA%E5%B7%B1%E7%BC%96%E5%86%99%E7%9A%84CSS%E8%A7%84%E5%88%99%E6%94%B9%E5%8F%98%E5%AE%83%E7%9A%84%E8%A1%8C%E4%B8%BA%0A%0A%0A%0A%0A
CSS简史（译） - 前端学习笔记 - SegmentFault 思否

 [ ![2787724954-5695bc46c1306_big64](../_resources/e97e7c8033ee0f287da9d1ffee142d42.jpg)     **zhangwang**](https://segmentfault.com/u/zhangwang)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='1'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='169' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  7.5k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='2'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='173' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/zhangwang1990)

[![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-comment-alt-lines fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='comment-alt-lines' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='5'%3e%3cpath fill='currentColor' d='M448 0H64C28.7 0 0 28.7 0 64v288c0 35.3 28.7 64 64 64h96v84c0 7.1 5.8 12 12 12 2.4 0 4.9-.7 7.1-2.4L304 416h144c35.3 0 64-28.7 64-64V64c0-35.3-28.7-64-64-64zm16 352c0 8.8-7.2 16-16 16H288l-12.8 9.6L208 428v-60H64c-8.8 0-16-7.2-16-16V64c0-8.8 7.2-16 16-16h384c8.8 0 16 7.2 16 16v288zm-96-216H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h224c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16zm-96 96H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h128c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16z' data-evernote-id='184' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://segmentfault.com/a/1190000011872815#comment-area)

#   [CSS简史（译）](https://segmentfault.com/a/1190000011872815)

[css](https://segmentfault.com/t/css)

 发布于 2017-11-06

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

> 一直觉得自己没学好`css`> (事实上也许也是如此),经常听说`js`> 的历史，但是好像对`css`> 的历史却一无所知。虽然历史这类内容对实际的开发也许没有实际的帮助（不像学习了`Flexbox`> ,`Grids`> 就能马上用到布局中），但是总觉得这也是一个前端工程师应有的软知识。所以看到本文的英文原文的时候就有了翻译的冲动，希望你读完也能有收获。

> 翻译正文如下：

`html`和`css`是那么密不可分，以至于你可能会觉得它们是一起出现的。实际上，自1989年Tim Berners Lie发明互联网后的多年中，这个世界上都不存在一个名为`css`的事物，`web`的原始版本根本就没有提供一种装饰网页的方法。

在www的邮件列表中深埋着一封由Marc Andreessen写于1994年的不出名的邮件（Marc Andreessen也是后来知名的Mosaic浏览器和网景浏览器的合作开发者）。在那封邮件中，Andreessen指出由于没有办法通过`html`装饰一个网站，当他被问到视觉设计时，他唯一能告诉web开发者的一句话是"sorry you're screwed(对不起，你搞砸了)"。

不过，在随后仅短短10年后，`CSS`就被一个现代的web社区全面采用，我们一起来看看，这一路发生了什么？

## web在寻找一种标记语言

关于`web`如何布局存在很多种理论上的观点。然而，这并不是Berners Lie 的优先考虑事项，他在欧洲核子研究中心的雇主大多只对网络感兴趣，因此他们的主要精力也是集中在网络上。不过，社区中的开发者则提出了一些竞争性的网页布局理论，最显着的理论分别来自**Pei Yaun Wei**，**Andreesen**和**HakonWium Lie**。

Pei-Yuan Wei在1991年创建图形浏览器 ViolaWWW ，他整合了他自己提出的样式语言到自己开发的浏览器中，还期望自己的样式语法最终能成为`web`关于样式的官方标准。虽然这个目标并未达到，但是他提出的样式语法确实为其它的一些样式语法提供了一些灵感。

![  ](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108133509.png)

与此同时，Andreessen 在他开发的网景浏览器中进行了不同的尝试。他并没有创建一种分离式的标记语言，而是采取拓展HTML标签的方法来包含非标准化的HTML标签已达到装饰网页的目的。不幸的是，没过多久，网页就失去了所有的语义化并看起来像下面这样混乱：

	<MULTICOL COLS="3" GUTTER="25">
	  <P><FONT SIZE="4" COLOR="RED">This would be some font broken up into columns</FONT></P>
	</MULTICOL>

开发者很快就意识到，这种尝试是没有前景的。随机web社区产出了很多其它的替换方案，比如`RRP`--一种运用缩写非常简洁的样式表语言；`PSL96`--一种支持函数和状态语句的语言。如果你对这些语言具体是什么样子的感兴趣，可以参考Zach Bloom 写的一篇非常优秀的[比较文章](https://eager.io/blog/the-languages-which-almost-were-css/)。

最终被大家采纳的语言是由Hakon Wium 在 1994年 10月提出的样式语法。它被称为样式层叠表，简称CSS。

## 我们为什么要使用CSS

CSS最终胜出的主要原因是因为它非常简单，这一点在和它同时代的竞争者比起来则更加明显。早期的CSS语法如下：

	window.margin.left = 2cm
	font.family = times
	h1.font.size = 24pt 30%

css是一种描述性的编程语言。当我们写CSS时，我们并不会告诉浏览器具体该如何渲染网页。相反，我们逐个写好描述HTML文档的规则，让浏览器来处理渲染。考虑到网络主要是由业余程序员和雄心勃勃的爱好者构建，CSS遵循了一种可预测的，包容性的格式，这样任何人都可以轻易的使用它，这意味着就算部分语法有误，CSS还是可以正常运行，这是一种特性而非一个bug。

CSS从某种程度上看又是独一无二的，就像它的全名样式层叠表中描述的那样，CSS支持样式级联。级联意味着样式可以遵循一个特殊的规则继承和覆盖之前定义过的其它样式，而且CSS还支持在同一个页面上使用多个样式表。

注意到上面最初CSS语法中的百分比没？这其实是非常重要的一点，Lie相信，用户和开发者可能会采用不同的方法来定义样式，浏览器则是两者之间的中介，通过协商差异来呈现页面。上面的百分比代表了样式的权重，权重越低越容易被覆盖。当年Lie在初次展示CSS时，他甚至添加了一个滑块，用以在浏览器中切换的用户定义样式和开发者定义样式。

在CSS提出的早期，这一点引起了大辩论，一些人认为开发者应该具备对样式完全的控制权限，其他人则认为用户应该具备一定的控制权限。最终，为了提供更清晰的覆盖规则这个百分比被移除了，不过这也是现代CSS中支持[权重Specificity](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Specificity)这一概念的原因。

不久后,**Lie**就发布了他的原始提案，他还在Bert Bos团队找到了一个合作者Bos，**Bos**是Argo浏览器的开发者，他也指定了兼容自己浏览器的样式语言，这种样式语言之后部分也被融入到CSS中。随后他们两人制定了一个更为详细的标准并向新创建HTML的工作组W3C求助推广。

经过多年的努力，到1996年底，CSS语法变成了下面这样：

	html {
	  margin-left: 2cm;
	  font-family: "Times", serif;
	}
	
	h1 {
	  font-size: 24px;
	}

CSS自此诞生了。

## 浏览器的麻烦

当时由于CSS还只是是一个草案了，网景浏览器还是压宝在拓展HTML标签上，他们使用了大量诸如`multicol`,`layer`,`blink`这类的标签。IE则零碎的采用了部分CSS标准，不过他们的采用非常片面而且有时和标准比起来还是错误的。这意味着，早期的CSS标准在经过五年的官方推荐之后，市面上还是没有完全支持它的浏览器。

第一次完整的兼容来自于一个非主流的地方。

当**Tantek Celik**在1997年参加开发Mac版本的IE浏览器时，他的团队还非常的小。一年后，他的团队人员被减半，他成为了他们团队渲染引擎方面的领导，当时微软的浏览器团队的大部分的精力集中在windows版的IE上，不过还好Mac版团队则只需要关注他们自己的设备。从2000年的IE5开始，Celik和他的团队决定把焦点放在其他人还不关注的对CSS的兼容上。

![1460000011872821](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108133526.png)

Mac版的IE5花费了该团队两年的开发时间，在此期间，Celik和使用相同设备的W3C成员及web开发者交流频繁，IE-for-Mac团队逐步验证了CSS的各方面。终于，在2002年3月，他们发布了Mac版的IE5，这是第一个支持完整CSS级别1的浏览器。

## 文档类型切换

还记得吗，前面我们提到，windows版的IE也添加了对CSS的支持，但是他们的实现有一些bug和他们使用的盒子模型也和标准不一样。windows的合资模型把`border`和`pading`等属性在包含在元素的总宽高内，而标准都要求通过设置`box-sizing`的值来确定其是否被添加到宽高中。

Celik知道，想让CSS正常发挥作用，这些差距必须被调和。他在和CSS标准的倡导者 Todd Fahrner 交谈后提出了文档类型切换，其使用方法你一定见过，如下：

`<!DOCTYPE html>`
上面是现代HTML5的写法，不过在以前，写文档类型还是有些繁琐的，如下所示：

`<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">`

上面是一个符合标准的例子，其中的`-//W3C//DTD HTML 4.0//EN`是关键点，当web开发者添加这些到他自己的网页时，浏览器就知道将使用"标准模式"`standards mode`来渲染页面，CSS也的解析也将与规范一致。如果文档类型丢失或过期，浏览器将切换到“怪异模式”（`quirks mode`），根据旧盒子模型渲染内容，采用老浏览器的非标准解析方式。在最初，一些开发者甚至倾向于有意设置为怪异模式以获得对老盒子模型的支持。

![1460000011872822](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108133531.jpg)

Eric Meyer(有时候被称为CSS之父)曾经说过:`文档类型切换拯救了CSS`。也许他是对的，如果没有文档类型切换，今天可能还需要用各种技巧来写CSS以实现兼容性。

## 盒子模型的Hack

还有一点需要单独说明，使用文档类型切换后，现代浏览器对老站点兼容完好，但是旧浏览器新站点的兼容性却并不好（造成这种现象的主要原因是IE）。查看[Box Model Hack](http://tantek.com/CSS/Examples/boxmodelhack.html)你会发现Celik采用一个非常高明的技巧，它利用了一个非常少见的被称作`voice-family`的CSS属性来欺骗浏览器用以实现在一个类中添加多个宽高。Celik建议开发者把旧盒子模型相关语法放在前面，然后在`voice-family`属性中添加一个`}`来实现对标签的关闭，之后再写符合新盒子模型的宽度，如下所示：

	div.content {
	  width: 400px;
	  voice-family: ""}"";
	  voice-family: inherit;
	  width: 300px;
	}

`voice-family`在旧浏览器中无法识别，但是却能解析定义的字符串，所以当添加额外的`}`时，浏览器会在读取第二个宽度之前停止解析。这种方式简单有效并使得大量的web开发者开始采用标准模式。

## 标准设计的先驱

2001年微软发布了IE6，虽然它最终还是成为了web开发者的一大绊脚石，但它实际上带来了一些非常令人印象深刻的对CSS标准的支持，考虑到它最终占据了高达80%的市场，它对CSS的推广还是有一定的作用的。

标准有了，浏览器也有了，CSS进入了生产模式。现在最需要的是人们开始使用它。

过去十年里，web一直缺少一个标准的样式语言，这并非意味着开发者停止了开发，实际上他们开发出了一系列的浏览器hacks，比如基于表格进行布局，引入`flash`并实现一些`HTML`不能做到的功能。兼容标准的CSS设计是一种新的趋势，`web` 需要一些先驱者来运用它们。

有两个网站运用了CSS进行了重设计，它们只相隔几个月出现，**Wired（连线杂志）**首先发布了自己的基于CSS标准的网站，之后不久**ESPN**也发布了基于CSS标准的网站。

Douglas Bowman 是Wired(连线杂志)的web设计团队负责人。在2002年时，Bowman和他的团队发现还没有大型的网站在他们的开发中使用CSS，Bowman觉得重新使用最新的兼容性的HTML和CSS来开发Wired（连线杂志）是他对web社区的一种义务。他推动着他的团队从头开始设计，在2002年9月，他们上线了重新开发的站点。

![1460000011872823](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108133537.gif)

ESPN在仅仅几个月后也上线了他们重写设计后的站点，他们更大规模的运用了CSS标准。这些网站压赌在`CSS`上，甚至采用了一些当时不被看好的`CSS`技术。但是所有的付出都赢得了回报，如果你去问参与了重构的开发者，他们也许会滔滔不绝告诉你新标准带来的各种好处。更高的性能，更方便更改，更容易分享，最重要的是，`css`还是web友善的。Wired最初甚至每日更换颜色主题。

![1460000011872824](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108133541.jpg)

虽然如果你现在去细看这些重构后的代码，还是会发现一些hacks。比如web还是只支持几个不同尺寸的显示器，你也许还会发现这两个网站都使用固定宽度的列结合相对和绝对定位来进行布局，使用图片被用来替换文字。虽然存在这些缺陷，这些站点还是为接下来的开发打下了基础。他们是值得尊敬的先驱！

## CSS禅意花园和语义化的web

2003年，Jeffrey Zeldman 出版了他的书 《Designing with Web Standards》，这本书随后成为了web开发者学习CSS标准的手册。书中去除了CSS的一些遗留技术和小技巧，最重要的是帮助web开发者看到了使用CSS进行样式开发所拥有的广阔空间。一年后，Dave Shea发布了《CSS Zen Garden》，它鼓励开发者分离html和css。还该网站展示了最新的技巧和建议，并通过长期的说明来让人们确信现在是采用标准的时代了。

现在，伴随着缓慢而坚定的势头，CSS越来越高级，并逐步加入了一些新属性，浏览器也开始竞相实现新标准，开发人员不断在自己的项目中运用新特性，CSS真的成为了事实上的标准。就像很久之前它声称的那样。

## 有用的链接

- [A Look Back at the History of CSS(原文链接)](https://css-tricks.com/look-back-history-css/?imm_mid=0f79f3&cmp=em-web-na-na-newsltr_20171101)
- [我的博客中本文的链接](https://github.com/zhangwang1990/blogs/blob/master/articles/CSS%E7%AE%80%E5%8F%B2%E5%9B%9E%E9%A1%BE.md)

[www.miniui.com](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CjnCaxeg9X7iCNdOQigbiuaSYB7exhrFcl96OgJYK6ayu2twIEAEgkdfZR2CdAcgBAakCUZAIJMdkgz6oAwHIA8sEqgTcAU_Q3Ps0fEloNnpTDazE6rr0_CA0iL0M24rOdWk6_wr5VlViEibcl-K7xecc5BOpuzoZhq3rgu7-U5ETNcdkyWdc_HIpsXhB8VVUs1NN2iOaCYMKAQ5pgG2ZaTCcENN3PjSbF9-_AC7K8x6RYntF0XgfMYp5K7krLVmfZfWLZbuq7EouCR9eBfufuG0eWys_8vWA8XHsP9iw5eovRra961gY4eax_SWSidr0BJZkTR4W3trusD2gr9t4HKLicIJ7ZzIvlL5bWa1HkVaGcD8DIg3L1DkZl0awu_fZVoHABKmyupcegAfRiK4eqAeOzhuoB9XJG6gHk9gbqAe6BqgH8NkbqAfy2RuoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgbqAfC2hvYBwHSCAcIgGEQARgfmgkyaHR0cDovL21pbml1aS5jb20vZGVtby8jc3JjPWRhdGFncmlkL2NlbGxlZGl0Lmh0bWyxCXl_GJsFNyWngAoByAsB2BMCiBQB&ae=1&num=1&sig=AOD64_3oUuZ8p1Mrjl8j1yoibvlhuOUUmw&client=ca-pub-6330872677300335&nb=1&adurl=http://miniui.com/demo/%3Fgclid%3DEAIaIQobChMI-PjUyOao6wIVU4jCCh3iHAlzEAEYASAAEgIZPvD_BwE%23src%3Ddatagrid/celledit.html)

[jQuery MiniUI](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CjnCaxeg9X7iCNdOQigbiuaSYB7exhrFcl96OgJYK6ayu2twIEAEgkdfZR2CdAcgBAakCUZAIJMdkgz6oAwHIA8sEqgTcAU_Q3Ps0fEloNnpTDazE6rr0_CA0iL0M24rOdWk6_wr5VlViEibcl-K7xecc5BOpuzoZhq3rgu7-U5ETNcdkyWdc_HIpsXhB8VVUs1NN2iOaCYMKAQ5pgG2ZaTCcENN3PjSbF9-_AC7K8x6RYntF0XgfMYp5K7krLVmfZfWLZbuq7EouCR9eBfufuG0eWys_8vWA8XHsP9iw5eovRra961gY4eax_SWSidr0BJZkTR4W3trusD2gr9t4HKLicIJ7ZzIvlL5bWa1HkVaGcD8DIg3L1DkZl0awu_fZVoHABKmyupcegAfRiK4eqAeOzhuoB9XJG6gHk9gbqAe6BqgH8NkbqAfy2RuoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgbqAfC2hvYBwHSCAcIgGEQARgfmgkyaHR0cDovL21pbml1aS5jb20vZGVtby8jc3JjPWRhdGFncmlkL2NlbGxlZGl0Lmh0bWyxCXl_GJsFNyWngAoByAsB2BMCiBQB&ae=1&num=1&sig=AOD64_3oUuZ8p1Mrjl8j1yoibvlhuOUUmw&client=ca-pub-6330872677300335&nb=0&adurl=http://miniui.com/demo/%3Fgclid%3DEAIaIQobChMI-PjUyOao6wIVU4jCCh3iHAlzEAEYASAAEgIZPvD_BwE%23src%3Ddatagrid/celledit.html)

[快速开发WebUI界面，支持Java、.Net、PHP](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CjnCaxeg9X7iCNdOQigbiuaSYB7exhrFcl96OgJYK6ayu2twIEAEgkdfZR2CdAcgBAakCUZAIJMdkgz6oAwHIA8sEqgTcAU_Q3Ps0fEloNnpTDazE6rr0_CA0iL0M24rOdWk6_wr5VlViEibcl-K7xecc5BOpuzoZhq3rgu7-U5ETNcdkyWdc_HIpsXhB8VVUs1NN2iOaCYMKAQ5pgG2ZaTCcENN3PjSbF9-_AC7K8x6RYntF0XgfMYp5K7krLVmfZfWLZbuq7EouCR9eBfufuG0eWys_8vWA8XHsP9iw5eovRra961gY4eax_SWSidr0BJZkTR4W3trusD2gr9t4HKLicIJ7ZzIvlL5bWa1HkVaGcD8DIg3L1DkZl0awu_fZVoHABKmyupcegAfRiK4eqAeOzhuoB9XJG6gHk9gbqAe6BqgH8NkbqAfy2RuoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgbqAfC2hvYBwHSCAcIgGEQARgfmgkyaHR0cDovL21pbml1aS5jb20vZGVtby8jc3JjPWRhdGFncmlkL2NlbGxlZGl0Lmh0bWyxCXl_GJsFNyWngAoByAsB2BMCiBQB&ae=1&num=1&sig=AOD64_3oUuZ8p1Mrjl8j1yoibvlhuOUUmw&client=ca-pub-6330872677300335&nb=7&adurl=http://miniui.com/demo/%3Fgclid%3DEAIaIQobChMI-PjUyOao6wIVU4jCCh3iHAlzEAEYASAAEgIZPvD_BwE%23src%3Ddatagrid/celledit.html)

[ 打开](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CjnCaxeg9X7iCNdOQigbiuaSYB7exhrFcl96OgJYK6ayu2twIEAEgkdfZR2CdAcgBAakCUZAIJMdkgz6oAwHIA8sEqgTcAU_Q3Ps0fEloNnpTDazE6rr0_CA0iL0M24rOdWk6_wr5VlViEibcl-K7xecc5BOpuzoZhq3rgu7-U5ETNcdkyWdc_HIpsXhB8VVUs1NN2iOaCYMKAQ5pgG2ZaTCcENN3PjSbF9-_AC7K8x6RYntF0XgfMYp5K7krLVmfZfWLZbuq7EouCR9eBfufuG0eWys_8vWA8XHsP9iw5eovRra961gY4eax_SWSidr0BJZkTR4W3trusD2gr9t4HKLicIJ7ZzIvlL5bWa1HkVaGcD8DIg3L1DkZl0awu_fZVoHABKmyupcegAfRiK4eqAeOzhuoB9XJG6gHk9gbqAe6BqgH8NkbqAfy2RuoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgbqAfC2hvYBwHSCAcIgGEQARgfmgkyaHR0cDovL21pbml1aS5jb20vZGVtby8jc3JjPWRhdGFncmlkL2NlbGxlZGl0Lmh0bWyxCXl_GJsFNyWngAoByAsB2BMCiBQB&ae=1&num=1&sig=AOD64_3oUuZ8p1Mrjl8j1yoibvlhuOUUmw&client=ca-pub-6330872677300335&nb=8&adurl=http://miniui.com/demo/%3Fgclid%3DEAIaIQobChMI-PjUyOao6wIVU4jCCh3iHAlzEAEYASAAEgIZPvD_BwE%23src%3Ddatagrid/celledit.html)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='43' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='41' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

阅读 2.8k  发布于 2017-11-06

本作品系 翻译 ([阅读原文](https://css-tricks.com/look-back-history-css/?imm_mid=0f79f3&cmp=em-web-na-na-newsltr_20171101)) ， [采用《署名-非商业性使用-禁止演绎 4.0 国际》许可协议](https://creativecommons.org/licenses/by-nc-nd/4.0/)

* * *

 [![2787724954-5695bc46c1306_big64](../_resources/e97e7c8033ee0f287da9d1ffee142d42.jpg)](https://segmentfault.com/u/zhangwang)

#####   [zhangwang](https://segmentfault.com/u/zhangwang)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='17'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='451' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  7.5k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='18'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='455' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/zhangwang1990)
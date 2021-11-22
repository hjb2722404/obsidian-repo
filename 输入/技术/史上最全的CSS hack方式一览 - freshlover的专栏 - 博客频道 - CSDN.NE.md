史上最全的CSS hack方式一览 - freshlover的专栏 - 博客频道 - CSDN.NET

#   [史上最全的CSS hack方式一览](http://blog.csdn.net/freshlover/article/details/12132801)

.

  标签： [CSS hack](http://www.csdn.net/tag/CSS%20hack)[IE条件注释](http://www.csdn.net/tag/IE%e6%9d%a1%e4%bb%b6%e6%b3%a8%e9%87%8a)

 2013-09-28 15:57  75732人阅读    [评论](http://blog.csdn.net/freshlover/article/details/12132801#comments)(4)    [收藏](史上最全的CSS%20hack方式一览%20-%20freshlover的专栏%20-%20博客频道%20-%20CSDN.NE.md#)    [举报](http://blog.csdn.net/freshlover/article/details/12132801#report)

 .

 ![category_icon.jpg](../_resources/760c5ec8c68b26ded5d32a15a75b0d4b.jpg)  分类：

   前端开发*（43）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

 .

版权声明：本文为博主原创文章，未经博主允许不得转载。

目录[(?)](http://blog.csdn.net/freshlover/article/details/12132801#)[[+]](http://blog.csdn.net/freshlover/article/details/12132801#)

做前端多年，虽然不是经常需要hack，但是我们经常会遇到各浏览器表现不一致的情况。基于此，某些情况我们会极不情愿的使用这个不太友好的方式来达到大家要求的页面表现。我个人是不太推荐使用hack的，要知道一名好的前端，要尽可能不使用hack的情况下实现需求，做到较好的用户体验。可是啊，现实太残酷，浏览器厂商之间历史遗留的问题让我们在目标需求下不得不向hack妥协，虽然这只是个别情况。今天，结合自己的经验和理解，做了几个demo把IE6~IE10和其他标准浏览器的CSS hack做一个总结，也许本文应该是目前最全面的hack总结了吧。

### 什么是CSS hack

由于不同厂商的流览器或某浏览器的不同版本（如IE6-IE11,Firefox/Safari/Opera/Chrome等），对CSS的支持、解析不一样，导致在不同浏览器的环境中呈现出不一致的页面展现效果。这时，我们为了获得统一的页面效果，就需要针对不同的浏览器或不同版本写特定的CSS样式，我们把这个针对不同的浏览器/不同版本写相应的CSS code的过程，叫做CSS hack!

### CSS hack的原理

由于不同的浏览器和浏览器各版本对CSS的支持及解析结果不一样，以及CSS优先级对浏览器展现效果的影响，我们可以据此针对不同的浏览器情景来应用不同的CSS。

### CSS hack分类

CSS Hack大致有3种表现形式，CSS属性前缀法、选择器前缀法以及IE条件注释法（即HTML头部引用if IE）Hack，实际项目中CSS Hack大部分是针对IE浏览器不同版本之间的表现差异而引入的。

- 属性前缀法(即类内部Hack)：例如 IE6能识别下划线"_"和星号" * "，IE7能识别星号" * "，但不能识别下划线"_"，IE6~IE10都认识"\9"，但firefox前述三个都不能认识。
- 选择器前缀法(即选择器Hack)：例如 IE6能识别*html .class{}，IE7能识别*+html .class{}或者*:first-child+html .class{}。
- IE条件注释法(即HTML条件注释Hack)：针对所有IE(注：IE10+已经不再支持条件注释)： <!--[if IE]>IE浏览器显示的内容 <![endif]-->，针对IE6及以下版本： <!--[if lt IE 6]>只在IE6-显示的内容 <![endif]-->。这类Hack不仅对CSS生效，对写在判断语句里面的所有代码都会生效。

CSS hack书写顺序，一般是将适用范围广、被识别能力强的CSS定义在前面。

### CSS hack方式一：条件注释法

这种方式是IE浏览器专有的Hack方式，微软官方推荐使用的hack方式。举例如下
只在IE下生效
<!--[if IE]>
这段文字只在IE浏览器显示
<![endif]-->
只在IE6下生效
<!--[if IE 6]>
这段文字只在IE6浏览器显示
<![endif]-->
只在IE6以上版本生效
<!--[if gte IE 6]>
这段文字只在IE6以上(包括)版本IE浏览器显示
<![endif]-->
只在IE8上不生效
<!--[if ! IE 8]>
这段文字在非IE8浏览器显示
<![endif]-->
非IE浏览器生效
<!--[if !IE]>
这段文字只在非IE浏览器显示
<![endif]-->

### CSS hack方式二：类内属性前缀法

属性前缀法是在CSS样式属性名前加上一些只有特定浏览器才能识别的hack前缀，以达到预期的页面展现效果。
IE浏览器各版本 CSS hack 对照表

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| hack | 写法  | 实例  | IE6(S) | IE6(Q) | IE7(S) | IE7(Q) | IE8(S) | IE8(Q) | IE9(S) | IE9(Q) | IE10(S) | IE10(Q) |
| *   | *color | 青色  | Y   | Y   | Y   | Y   | N   | Y   | N   | Y   | N   | Y   |
| +   | +color | 绿色  | Y   | Y   | Y   | Y   | N   | Y   | N   | Y   | N   | Y   |
| -   | -color | 黄色  | Y   | Y   | N   | N   | N   | N   | N   | N   | N   | N   |
| _   | _color | 蓝色  | Y   | Y   | N   | Y   | N   | Y   | N   | Y   | N   | N   |
| #   | #color | 紫色  | Y   | Y   | Y   | Y   | N   | Y   | N   | Y   | N   | Y   |
| \0  | color:red\0 | 红色  | N   | N   | N   | N   | Y   | N   | Y   | N   | Y   | N   |
| \9\0 | color:red\9\0 | 粉色  | N   | N   | N   | N   | N   | N   | Y   | N   | Y   | N   |
| !important | color:blue !important;color:green; | 棕色  | N   | N   | Y   | N   | Y   | N   | Y   | N   | Y   | Y   |

说明：在标准模式中

- “-″减号是IE6专有的hack
- “\9″ IE6/IE7/IE8/IE9/IE10都生效
- “\0″ IE8/IE9/IE10都生效，是IE8/9/10的hack
- “\9\0″ 只对IE9/IE10生效，是IE9/10的hack

demo如下

**[css]**  [view plain](http://blog.csdn.net/freshlover/article/details/12132801#)  [copy](http://blog.csdn.net/freshlover/article/details/12132801#)

1. <script type="text/javascript">
2.     //alert(document.compatMode);
3. </script>
4. <style type="text/css">
5. body:nth-of-type(1) .iehack{

6.     color: #F00;/* 对Windows IE9/Firefox 7+/Opera 10+/所有Chrome/Safari的CSS hack ，选择器也适用几乎全部Mobile/Linux/Mac browser*/

7. }
8. .demo1,.demo2,.demo3,.demo4{
9.     width:100px;
10.     height:100px;
11. }
12. .hack{
13. /*demo1 */
14. /*demo1 注意顺序，否则IE6/7下可能无法正确显示，导致结果显示为白色背景*/
15.     background-color:red; /* All browsers */
16.     background-color:blue !important;/* All browsers but IE6 */
17.     *background-color:black; /* IE6, IE7 */
18.     +background-color:yellow;/* IE6, IE7*/
19.     background-color:gray\9; /* IE6, IE7, IE8, IE9, IE10 */
20.     background-color:purple\0; /* IE8, IE9, IE10 */
21.     background-color:orange\9\0;/*IE9, IE10*/
22.     _background-color:green; /* Only works in IE6 */

23.     *+background-color:pink; /*  WARNING: Only works in IE7 ? Is it right? */

24. }
25.
26. /*可以通过javascript检测IE10，然后给IE10的<html>标签加上class=”ie10″ 这个类 */
27. .ie10 #hack{
28.     color:red; /* Only works in IE10 */
29. }
30.
31. /*demo2*/
32. .iehack{
33. /*该demo实例是用于区分标准模式下ie6~ie9和Firefox/Chrome的hack，注意顺序
34. IE6显示为：绿色，
35. IE7显示为：黑色，
36. IE8显示为：红色，
37. IE9显示为：蓝色，
38. Firefox/Chrome显示为：橘色，
39. （本例IE10效果同IE9,Opera最新版效果同IE8）
40. */
41.     background-color:orange;  /* all - for Firefox/Chrome */
42.     background-color:red\0;  /* ie 8/9/10/Opera - for ie8/ie10/Opera */
43.     background-color:blue\9\0;  /* ie 9/10 - for ie9/10 */
44.     *background-color:black;  /* ie 6/7 - for ie7 */
45.     _background-color:green;  /* ie 6 - for ie6 */
46. }
47.
48. /*demo3
49. 实例是用于区分标准模式下ie6~ie9和Firefox/Chrome的hack，注意顺序
50. IE6显示为：红色，
51. IE7显示为：蓝色，
52. IE8显示为：绿色，
53. IE9显示为：粉色，
54. Firefox/Chrome显示为：橘色，
55. （本例IE10效果同IE9，Opera最新版效果也同IE9为粉色）
56.
57. */
58. .element {
59.     background-color:orange;    /* all IE/FF/CH/OP*/
60. }
61. .element {
62.     *background-color: blue;    /* IE6+7, doesn't work in IE8/9 as IE7 */
63. }
64. .element {
65.     _background-color: red;     /* IE6 */
66. }
67. .element {
68.     background-color: green\0; /* IE8+9+10  */
69. }
70. :root .element { background-color:pink\0; }  /* IE9+10 */
71.
72. /*demo4*/
73. /*
74.
75. 该实例是用于区分标准模式下ie6~ie10和Opera/Firefox/Chrome的hack，本例特别要注意顺序
76. IE6显示为：橘色，
77. IE7显示为：粉色，
78. IE8显示为：黄色，
79. IE9显示为：紫色，
80. IE10显示为：绿色，
81. Firefox显示为：蓝色，
82. Opera显示为：黑色，
83. Safari/Chrome显示为：灰色，
84.
85. */
86. .hacktest{
87.     background-color:blue;      /* 都识别，此处针对firefox */
88.     background-color:red\9;      /*all ie*/
89.     background-color:yellow\0;    /*for IE8/IE9/10 最新版opera也认识*/
90.     +background-color:pink;        /*for ie6/7*/
91.     _background-color:orange;       /*for ie6*/
92. }
93.
94. @media screen and (min-width:0){
95.     .hacktest {background-color:black\0;}  /*opera*/
96. }
97. @media screen and (min-width:0) {

98.     .hacktest { background-color:purple\9; }/*  for IE9/IE10  PS:国外有些习惯常写作\0，根本没考虑Opera也认识\0的实际 */

99. }

100. @media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {

101.    .hacktest { background-color:green; } /* for IE10+ 此写法可以适配到高对比度和默认模式，故可覆盖所有ie10的模式 */

102. }

103. @media screen and (-webkit-min-device-pixel-ratio:0){ .hacktest {background-color:gray;} }  /*for Chrome/Safari*/

104.

105. /* #963棕色 :root is for IE9/IE10, 优先级高于@media, 慎用！如果二者合用，必要时在@media样式加入 !important 才能区分IE9和IE10 */

106. /*
107. :root .hacktest { background-color:#963\9; }
108. */
109. </style>

demo1是测试不同IE浏览器下hack 的显示效果
IE6显示为：粉色，
IE7显示为：粉色，
IE8显示为：蓝色，
IE9显示为：蓝色，
Firefox/Chrome/Opera显示为：蓝色，

若去掉其中的!important属性定义，则IE6/7仍然是粉色，IE8是紫色，IE9/10为橙色，Firefox/Chrome变为红色，Opera是紫色。是不是有些奇怪：除了IE6以外，其他所有的表现都符合我们的期待。那为何IE6表现的颜色不是_background-color:green;的绿色而是*+background-color:pink的粉色呢？其实是最后一句所谓的IE7私有hack惹的祸？不是说*+是IE7的专有hack吗？？？错，你可能太粗心了！我们常说的IE7专有*+hack的格式是*+html selector，而不是上面的直接在属性上加*+前缀。如果是为IE7定制特殊样式，应该这样使用：

*+html #ie7test { /* IE7 only*/
color:green;
}

经过测试，我发现属性前缀*+background-color:pink;只有IE6和IE7认识。而*+html selector只有IE7认识。所以我们在使用时候一定要特别注意。

demo2实例是用于区分标准模式下ie6~ie9和Firefox/Chrome的hack，注意顺序
IE6显示为：绿色，
IE7显示为：黑色，
IE8显示为：红色，
IE9显示为：蓝色，
Firefox/Chrome显示为：橘色，
（本例IE10效果同IE9,Opera最新版效果同IE8）
demo3实例也是用于区分标准模式下ie6~ie9和Firefox/Chrome的hack，注意顺序
IE6显示为：红色，
IE7显示为：蓝色，
IE8显示为：绿色，
IE9显示为：粉色，
Firefox/Chrome显示为：橘色，
（本例IE10效果同IE9，Opera最新版效果也同IE9为粉色）
demo4实例是用于区分标准模式下ie6~ie10和Opera/Firefox/Chrome的hack，本例特别要注意顺序
IE6显示为：橘色，
IE7显示为：粉色，
IE8显示为：黄色，
IE9显示为：紫色，
IE10显示为：绿色，
Firefox显示为：蓝色，
Opera显示为：黑色，
Safari/Chrome显示为：灰色，
![SouthEast.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102114815.jpg)

### CSS hack方式三：选择器前缀法

选择器前缀法是针对一些页面表现不一致或者需要特殊对待的浏览器，在CSS选择器前加上一些只有某些特定浏览器才能识别的前缀进行hack。
目前最常见的是
*html *前缀只对IE6生效
*+html *+前缀只对IE7生效
@media screen\9{...}只对IE6/7生效
@media \0screen {body { background: red; }}只对IE8有效
@media \0screen\,screen\9{body { background: blue; }}只对IE6/7/8有效
@media screen\0 {body { background: green; }} 只对IE8/9/10有效
@media screen and (min-width:0\0) {body { background: gray; }} 只对IE9/10有效

@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {body { background: orange; }} 只对IE10有效

等等
结合CSS3的一些选择器，如html:first-child，body:nth-of-type(1)，衍生出更多的hack方式，具体的可以参考下表：
![SouthEast.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102114834.jpg)

### CSS3选择器结合JavaScript的Hack

我们用IE10进行举例：

由于IE10用户代理字符串（UserAgent）为：Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)，所以我们可以使用[JavaScript](http://lib.csdn.net/base/18)将此属性添加到文档标签中，再运用CSS3基本选择器匹配。

JavaScript代码:
var htmlObj = document.documentElement;
htmlObj.setAttribute('data-useragent',navigator.userAgent);
htmlObj.setAttribute('data-platform', navigator.platform );
CSS3匹配代码：
html[data-useragent*='MSIE 10.0'] #id {
color: #F00;
}

### CSS hack利弊

一般情况下，我们尽量避免使用CSS hack，但是有些情况为了顾及用户体验实现向下兼容，不得已才使用hack。比如由于IE8及以下版本不支持CSS3,而我们的项目页面使用了大量CSS3新属性在IE9/Firefox/Chrome下正常渲染，这种情况下如果不使用css3pie或htc或条件注释等方法时,可能就得让IE8-的专属hack出马了。使用hack虽然对页面表现的一致性有好处，但过多的滥用会造成html文档混乱不堪，增加管理和维护的负担。相信只要大家一起努力，少用、慎用hack，未来一定会促使浏览器厂商的标准越来越趋于统一，顺利过渡到标准浏览器的主流时代。抛弃那些陈旧的IE hack，必将减轻我们编码的复杂度，少做无用功。

最后补上一张引自国外某大牛总结的CSS hack表，这时一张6年前的旧知识汇总表了，放在这里仅供需要时候方便参考。
![SouthEast.gif](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102114852.gif)

说明：本文测试环境为IE6~IE10，Chrome 29.0.1547.66 m，Firefox 20.0.1 ，Opera 12.02等。一边工作，一边总结，总结了几天写下整理好，今天把它分享出来，文中难免有纰漏，如大侠发现请及时告知！

转载请注明来自CSDN freshlover的博客专栏《[史上最全CSS Hack方式一览](http://blog.csdn.net/freshlover/article/details/12132801)》

[(L)](http://blog.csdn.net/freshlover/article/details/12132801#)[(L)](http://blog.csdn.net/freshlover/article/details/12132801#)[(L)](http://blog.csdn.net/freshlover/article/details/12132801#)[(L)](http://blog.csdn.net/freshlover/article/details/12132801#)[(L)](http://blog.csdn.net/freshlover/article/details/12132801#)[(L)](http://blog.csdn.net/freshlover/article/details/12132801#).

顶

34

踩

2

 .

[史上最全的CSS hack方式一览 - freshlover的专栏 - 博客频道 - CSDN.NE](史上最全的CSS%20hack方式一览%20-%20freshlover的专栏%20-%20博客频道%20-%20CSDN.NE.md#)

 [史上最全的CSS hack方式一览 - freshlover的专栏 - 博客频道 - CSDN.NE](史上最全的CSS%20hack方式一览%20-%20freshlover的专栏%20-%20博客频道%20-%20CSDN.NE.md#)

- 上一篇[HTML文档类型DTD与浏览器怪异模式](http://blog.csdn.net/freshlover/article/details/11616563)

- 下一篇[你需要知道的三个 CSS 技巧](http://blog.csdn.net/freshlover/article/details/12446405)

 .

#### 我的同类文章

   前端开发*（43）*

- *•*[信不信由你！iPhone6屏幕宽度不一定是375px，iPhone6 Plus屏幕宽度不一定是414px](http://blog.csdn.net/freshlover/article/details/44454991)2015-03-19*阅读***13402**

- *•*[Ajax跨域、Json跨域、Socket跨域和Canvas跨域等同源策略限制的解决方法](http://blog.csdn.net/freshlover/article/details/44223467)2015-03-12*阅读***17660**

- *•*[移动端Web开发调试之Chrome远程调试(Remote Debugging)](http://blog.csdn.net/freshlover/article/details/42528643)2015-01-08*阅读***42785**

- *•*[百度分享新浪微博无法分享图片的解决方法](http://blog.csdn.net/freshlover/article/details/38301787)2014-07-30*阅读***4747**

- *•*[最齐全的网站元数据meta标签的含义和用法](http://blog.csdn.net/freshlover/article/details/25322839)2014-05-08*阅读***9926**

- *•*[【精心推荐】20款优秀 jQuery Accordion（手风琴）特效插件](http://blog.csdn.net/freshlover/article/details/17244031)2013-12-10*阅读***3891**

- *•*[Sublime Text 无法使用Package Control或插件安装失败的解决方法](http://blog.csdn.net/freshlover/article/details/44261229)2015-03-14*阅读***72461**

- *•*[移动端Web开发调试之Weinre调试教程](http://blog.csdn.net/freshlover/article/details/42640253)2015-01-12*阅读***16558**

- *•*[[整理]JavaScript跨域解决方法大全](http://blog.csdn.net/freshlover/article/details/40827207)2014-11-05*阅读***3704**

- *•*[Sublime Text2两款漂亮的主题皮肤安装与切换使用方法](http://blog.csdn.net/freshlover/article/details/29592407)2014-06-09*阅读***45929**

- *•*[Responsive Design响应式网站设计心得笔记](http://blog.csdn.net/freshlover/article/details/17426893)2013-12-19*阅读***4479**

 [更多文章](http://blog.csdn.net/freshlover/article/category/1370873)
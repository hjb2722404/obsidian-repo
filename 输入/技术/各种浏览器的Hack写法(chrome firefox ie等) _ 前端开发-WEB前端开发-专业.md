各种浏览器的Hack写法(chrome firefox ie等) | 前端开发-WEB前端开发-专业前端开发网站

# 各种浏览器的Hack写法(chrome firefox ie等)

作者： 发布： 分类：[前端开发](http://www.wufangbo.com/category/qdkf/) 阅读：32,076次

Hack是针对不同的浏览器去写不同的CSS样式，从而让各浏览器能达到一致的渲染效果，那么针对不同的浏览器写不同的CSS CODE的过程，就叫CSS HACK，同时也叫写CSS Hack。然后将Hack放在浏览器特定的CSS文件中，让其符合条件的浏览器解析这些代码，就如前面所说的条件样式，我们将CSS Hack代码放入条件样式文件中，符合条件的浏览器就解析，不符合的将不解析，从面达到您所需要的页面渲染效果。总的一句话来说使用CSS Hack将会使用你的CSS代码部分失去作用，然后借助条件样式，使用其原CSS代码在一些浏览器解析，而CSS Hack代码在符合条件要求的浏览器中替代原CSS那部分代码。常见的就是在IE6下使用，不具体说，我想大家都有碰到过了。下面我们就一起来看看所有浏览器都具有什么Hack，换句话说，各种浏览器都能识别哪些CSS的写法。

下面是我收集有关于各浏览器下Hack的写法
1、Firefox
@-moz-document url-prefix() { .selector { property: value; } }
上面是仅仅被Firefox浏览器识别的写法，具体如：
@-moz-document url-prefix() { .demo { color:lime; } }
支持Firefox的还有几种写法：

/* 支持所有firefox版本 */ #selector[id=selector] { property: value; } 或者： @-moz-document url-prefix() { .selector { property: value; } } /* 支持所有Gecko内核的浏览器 (包括Firefox) */ *>.selector { property: value; }

2、Webkit枘核浏览器(chrome and safari)

@media screen and (-webkit-min-device-pixel-ratio:0) { Selector { property: value; } }

上面写法主要是针对Webkit内核的浏览器，如Google Chrome 和 Safari浏览器：
@media screen and (-webkit-min-device-pixel-ratio:0) { .demo { color: #f36; } }
3、Opera浏览器

html:first-child>body Selector {property:value;} 或者： @media all and (min-width:0) { Selector {property: value;} } 或者： @media all and (-webkit-min-device-pixel-ratio:10000), not all and (-webkit-min-device-pixel-ratio:0) { head~body Selector { property: value; } }

上面则是Opera浏览器的Hack写法：

@media all and (-webkit-min-device-pixel-ratio:10000), not all and (-webkit-min-device-pixel-ratio:0) { head~body .demo { background: green; } }

4、IE9浏览器
:root Selector {property: value9;}
上面是IE9的写法，具体应用如下：
:root .demo {color: #ff09;}
5、IE9以及IE9以下版本
Selector {property:value9;}
这种写法只有IE9以及IE9以下版本能识别，这里需要注意此处“9”只能是“9”不能是别的，比如说“8”，不然会失去效果的，如：
.demo {background: lime9;}
6、IE8浏览器
Selector {property: value/;} 或者： @media screen{ Selector {property: value;} }
上面写法只有IE能识别，如：
.color {color: #fff/;} 或者： @media screen{ .color {color: #fff;} }
7、IE8以及IE8以上的版本
Selector {property: value;}
这种写法只有IE8以及IE8以上版本支持，如
.demo {color: #ff0;}
8、IE7浏览器

*+html Selector{property:value;} 或 *:first-child+html Selector {property:value;}

上面两种是IE7浏览器下才能识别，如：

*+html .demo {background: green;} 或者： *:first-child+html .demo {background: green;}

9、IE7及IE7以下版本浏览器
Selector {*property: value;}
上面的写法在IE7以及其以下版本都可以识别，如：
.demo {*background: red;}
10、IE6浏览器

Selector {_property/**/:/**/value;} 或者： Selector {_property: value;} 或者： *html Selector {property: value;}

具体应用如下：

.demo {_width/**/:/**/100px;} 或者： .demo {_width: 100px;} 或者： *html .demo {width: 100px;}

上面具体介绍了各种版本浏览器下如何识别各种的Hack写法，包括了IE6-9以及现代版本的浏览器写法。综合上面的所述，我们针对不同浏览器的Hack写法主要分为两种从CSS选择器和CSS属性上来区别不同的Hack写法。下面我们分别来看这两种的不同写法：

CSS选择器的Hack写法
下面我们主要来看CSS选择器和CSS属性选择器在不同浏览器的支持情况。下面先来看CSS选择器支持情况。
CSS选择器的Hack写法
1、IE6以及IE6以下版本浏览器
* html .demo {color: green;}
2、仅仅IE7浏览器
*:first-child+html .demo {color: green;}
3、除IE6之外的所有浏览器（IE7-9, Firefox,Safari,Opera）
html>body .demo {color: green;}
4、IE8-9,Firefox,Safari,Opear
html>/**/body .demo {color: green;}
5、IE9+
:root .demo {color: red;}
6、Firefox浏览器
@-moz-document url-prefix() { .demo { color: red; } }
6、Webkit内核浏览器（Safari和Google Chrome）
@media screen and (-webkit-min-device-pixel-ratio:0) { .demo { color: red; } }
7、Opera浏览器

@media all and (-webkit-min-device-pixel-ratio:10000), not all and (-webkit-min-device-pixel-ratio:0) { head~body .demo { color: red; } }

8、iPhone / mobile webkit
@media screen and (max-device-width: 480px) { .demo { color: red } }
CSS属性Hack写法
1、IE6浏览器
.demo {_color: red;}
2、IE6-7浏览器识别
.demo {*color: red;}
3、所有浏览器除IE6浏览外
.demo {color/**/:red;}
4、IE6-9浏览器
.demo {color: red9;}
5、IE7-8浏览器
.demo {color/***/:red9;}

上面罗列的都是各种浏览器下的有关于CSS的Hack的写法，基中有针对于现代浏览器Safari,Google Chrome和Firefox的写法，而且也有针对于我们前端人员最讨厌的IE6-9的各版本浏览器的Hack的写法，而且这些Hack我们又分为CSS选择器的Hack写法和CSS属性的Hack写法。然而具体何种适用，大家可以要据自己的需求来定，下面列出我个人的两种写法：

一、经济实惠型定法：

这种写法注重单独的CSS的Hack写法。不同的浏览器使用不同的Hack写法，其实也只是以IE的Hack写法比较多（因为我们写Hack也主要是针对IE的浏览器）特别是IE6下的浏览器。单独为各种浏览器写Hack的好处是：针对各种浏览顺的Hack写法省力易记。因为其他的浏览器主要是针对现代浏览器，相对来说是比较少的。针对于这种Hack的使用，我推荐使用下面的方法：

.demo { color: red;/*所有现代浏览器*/ color: green9;/*所有IE浏览器*/ color: lime;/*IE8-9浏览器*/ *color: red;/*IE6-7浏览器*/ +color: blue;/*IE7浏览器*/ _color: orange;/*IE6浏览器*/ } @media all and (min-width:0px){ color: #000;/*Webkit和Opera浏览器*/ } @media screen and (-webkit-min-device-pixel-ratio:0) { color: #f36;/*Webkit内核浏览器*/ } @media all and (-wekit-min-device-pixel-ratio:10000), not all and (-webkit-min-device-pixel-ratio:0) { head~body .demo {color: #369;} /*Opera*/ } @-moz-document url-prefix(){ .demo{color:#ccc;}/* all firefox */ }

二、完美主义写法
这种方法是追求完美主义的写法，主要是配合我们上一节所说的IE条件注释，全部采用选择器Hack的写法。这种写法分两步：
1、创建条件样式表，并在HTML中body里添加相应的class类名：
<!–[if IE6]–><<!–[if IE7]–><!–[if IE8]–><!–[if IE9]–><!–[if !IE]–>
2、接着创建对应的样式

.demo {color: blue;}/*现代浏览器*/ .non-ie .demo {color: red;}/*除IE外浏览器*/ .ie9 .demo {color: yellow;}/*IE9浏览器*/ .ie8 .demo{color: green;}/*IE8浏览器*/ .ie7 .demo {color: orange;}/*IE7浏览器*/ .ie6 .demo {color: lime;}/*IE6浏览器*/ @media all and (min-width: 0px){ .demo {color:black;} /* webkit and opera */ } @media screen and (-webkit-min-device-pixel-ratio:0){ .demo{color:#369;}/* webkit */ } @media all and (-webkit-min-device-pixel-ratio:10000), not all and (-webkit-min-device-pixel-ratio:0) { head~body .demo{color:#cf6;}/* opera */ } @-moz-document url-prefix(){ .demo{color:#963;}/* firefox * / }

上面就是目前各种浏览器下，相关CSS的Hack的写法，下面我们具体来看一个实例：
HTML Markup
test color
CSS Code

.demo { color: red;/*所有现代浏览器*/ color: green9;/*所有IE浏览器*/ color: lime;/*IE8-9浏览器*/ *color: red;/*IE6-7浏览器*/ +color: blue;/*IE7浏览器*/ _color: orange;/*IE6浏览器*/ } :root .demo {color: #9639;} @-moz-document url-prefix(){ .demo{color:#897;}/* all firefox */ } @media screen and (-webkit-min-device-pixel-ratio:0) { .demo { color: #000; }/*webkit*/ } @media all and (-webkit-min-device-pixel-ratio:10000), not all and (-webkit-min-device-pixel-ratio:0) { head~body .demo { color: red; }/*opera*/ }

请看最终效果图：
>
![各种浏览器的Hack写法(chrome firefox ie等)](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231113341.png)

请面罗列了各浏览器下的Hack的写法，大家写浏览的CSS Hack时也可以参考下面的图表

转载请注明：[各种浏览器的Hack写法(chrome firefox ie等)](http://www.wufangbo.com/css-hack/) - [前端开发](http://www.wufangbo.com/)
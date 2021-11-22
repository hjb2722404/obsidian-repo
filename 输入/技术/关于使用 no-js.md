关于使用 no-js

# 关于使用 no-js

理论知识
no-js 是配合 Modernizr 一起使用的类名（class）

	Modernizr is a JavaScript library that detects HTML5 and CSS3 features in the user’s browser

Modernizr 是一个 javascript 库，检查你的游览器是否支持 CSS3 或者 HTML5 的特性而自动添加一些类名（class）到 并 替换掉原来的 .no-js（简单来说，Modernizr 就是一个CSS3/HTML5 的测试器，你需要测试什么，这可以到它的官方网站配置，选择自己需要测试的元素）。

还有让你的游览器支持 HTML5 中的新的标签，例如 :`<nav>, <header>, <footer> 和 <figure>`
**IE8 例子**

	<html class=" js no-flexbox no-canvas no-canvastext no-webgl no-touch no-geolocation postmessage no-websqldatabase no-indexeddb hashchange no-history draganddrop no-websockets no-rgba no-hsla no-multiplebgs no-backgroundsize no-borderimage no-borderradius no-boxshadow no-textshadow no-opacity no-cssanimations no-csscolumns no-cssgradients no-cssreflections no-csstransforms no-csstransforms3d no-csstransitions fontface generatedcontent no-video no-audio localstorage sessionstorage no-webworkers no-applicationcache no-svg no-inlinesvg no-smil no-svgclippaths" lang="zh">

可以看到，IE8 不支持很多 CSS3。以no开头的，都是不支持
**如何使用：**
0、在 关闭前加载 Modernizr。（这是个独立的 js 库，跟 jQuery 没关系，没有 jQuery 也可以使用。）
`<script src="/js/modernizr-2.5.3.min.js"></script></head>`

1、如果你的游览器没启用 javascript，当然 html 中的 class=”no-js” 是没改变的，我们可以用这个 class 来提示用户启用 javascript。

`<!DOCTYPE html><html dir="ltr" lang="en-US" class="no-js"><!-- html 需要添加 no-js 这个class -->`

2、除了侦查游览器是否用了 javascript，还可以玩其他的东西，类似 IE hack。譬如 IE8 不支持 box-shadow，我们可以指定这个 div 使用背景图片让它看起来有暗影。

	/* 是否支持 JavaScript */

	/* 默认支持JS，所以就隐藏这个提示 */.please-enable-js {
	    display:none;
	}
	/* 不支持 JS 就显示用户需要启用JS */html.no-js .please-enable-js {
	    display:block;
	}

	/* 是否支持 css 渐变*/.glossy {
	    /* 默认设计使用css渐变 */
	    background-image: linear-gradient(top, #555, #333);
	}
	.no-cssgradients .glossy {
	    /* 不支持css渐变的就是用图片，这样不会损坏原本的设计 */
	    background-image: url("images/glossybutton.png");
	}

使用 Modernizr 中的 javascript 方式侦查一些 HTML5 元素

	if (Modernizr.canvas){
	   // 如果游览器支持 HTML canvas，就运行这些代码
	} else {
	   // 不支持就运行这写代码
	}

更多侦查在 Modernizr test： http://modernizr.github.com/Modernizr/test/index.html
Modernizr 是一款很好的工具，让设计者更好控制他的设计。如果你只用一点点或许没用完全用上它的功能，这样太浪费了，你还是使用 html5shiv 吧。
更新 #1

可以在游览器 console 里输入Modernizr，也可以看到测试的结果（结果是布尔值）。（当然你要加载这个 Modernizr 的 javascript 才能用）

更新 #2 – 关于 html5shiv 误解

1、html5shiv 只是个 javascript 库，只有一个功能，就是让 Internet Explorer 6-8 支持 HTML5 的标签，例如 article，section，aside，video 等等……

2、Modernizr 默认包含了这个库
3、使用 html5shiv，配合 conditional comment。你也不想支持的游览器加载多余的东西吧（IE9+ 是支持 HTML5的）：

	<!--[if lt IE 9]>
	    <script src="assets/js/html5shiv.js"></script>
	<![endif]-->

[markdownFile.md](../_resources/9d6b74251e0d7a3ab23516f643b17c47.bin)
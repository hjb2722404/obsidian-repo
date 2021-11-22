详解JavaScript模块化开发 _trigkit4 - SegmentFault 思否

 [ ![62070976-5ade9afb60f6c_big64](../_resources/d1c0675ba1fcd688300492add20cdb8c.jpg)     **trigkit4**](https://segmentfault.com/u/trigkit4)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='1'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='193' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  30k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='2'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='197' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/hawx1993)

[![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-comment-alt-lines fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='comment-alt-lines' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='5'%3e%3cpath fill='currentColor' d='M448 0H64C28.7 0 0 28.7 0 64v288c0 35.3 28.7 64 64 64h96v84c0 7.1 5.8 12 12 12 2.4 0 4.9-.7 7.1-2.4L304 416h144c35.3 0 64-28.7 64-64V64c0-35.3-28.7-64-64-64zm16 352c0 8.8-7.2 16-16 16H288l-12.8 9.6L208 428v-60H64c-8.8 0-16-7.2-16-16V64c0-8.8 7.2-16 16-16h384c8.8 0 16 7.2 16 16v288zm-96-216H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h224c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16zm-96 96H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h128c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16z' data-evernote-id='208' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://segmentfault.com/a/1190000000733959#comment-area)

#   [详解JavaScript模块化开发](https://segmentfault.com/a/1190000000733959)

[javascript](https://segmentfault.com/t/javascript)[前端](https://segmentfault.com/t/%E5%89%8D%E7%AB%AF)

 发布于 2014-10-21

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

## 什么是模块化开发？

前端开发中，起初只要在`script`标签中嵌入几十上百行代码就能实现一些基本的交互效果，后来js得到重视，应用也广泛起来了，`jQuery，Ajax，Node.Js，MVC，MVVM`等的助力也使得前端开发得到重视，也使得前端项目越来越复杂，然而，`JavaScript`却没有为组织代码提供任何明显帮助，甚至没有类的概念，更不用说模块（module）了，那么什么是模块呢？

一个模块就是实现特定功能的文件，有了模块，我们就可以更方便地使用别人的代码，想要什么功能，就加载什么模块。模块开发需要遵循一定的规范，否则就都乱套了。
根据AMD规范，我们可以使用`define`定义模块，使用`require`调用模块。
目前，通行的js模块规范主要有两种：`CommonJS`和`AMD`。

## AMD规范

AMD 即`Asynchronous Module Definition`，中文名是“异步模块定义”的意思。它是一个在浏览器端模块化开发的规范，服务器端的规范是`CommonJS`

模块将被异步加载，模块加载不影响后面语句的运行。所有依赖某些模块的语句均放置在回调函数中。
`AMD` 是 `RequireJS` 在推广过程中对模块定义的规范化的产出。

### define() 函数

AMD规范只定义了一个函数 `define`，它是全局变量。函数的描述为：

	define(id?, dependencies?, factory);

**参数说明：**

	id：指定义中模块的名字，可选；如果没有提供该参数，模块的名字应该默认为模块加载器请求的指定脚本的名字。如果提供了该参数，模块名必须是“顶级”的和绝对的（不允许相对名字）。
	
	依赖dependencies：是一个当前模块依赖的，已被模块定义的模块标识的数组字面量。
	依赖参数是可选的，如果忽略此参数，它应该默认为["require", "exports", "module"]。然而，如果工厂方法的长度属性小于3，加载器会选择以函数的长度属性指定的参数个数调用工厂方法。
	
	工厂方法factory，模块初始化要执行的函数或对象。如果为函数，它应该只被执行一次。如果是对象，此对象应该为模块的输出值。

### 模块名的格式

模块名用来唯一标识定义中模块，它们同样在依赖性数组中使用：

	模块名是用正斜杠分割的有意义单词的字符串
	单词须为驼峰形式，或者"."，".."
	模块名不允许文件扩展名的形式，如“.js”
	模块名可以为 "相对的" 或 "顶级的"。如果首字符为“.”或“..”则为相对的模块名
	顶级的模块名从根命名空间的概念模块解析
	相对的模块名从 "require" 书写和调用的模块解析

### 使用 require 和 exports

创建一个名为"`alpha`"的模块，使用了`require`，`exports`，和名为"`beta`"的模块:

	 define("alpha", ["require", "exports", "beta"], function (require, exports, beta) {
	       exports.verb = function() {
	           return beta.verb();
	           *//Or:*
	           return require("beta").verb();
	       }
	   });

`require API` 介绍： [https://github.com/amdjs/amdj...](https://github.com/amdjs/amdjs-api/wiki/require)

`AMD`规范中文版：[https://github.com/amdjs/amdj...](https://github.com/amdjs/amdjs-api/wiki/AMD-(%E4%B8%AD%E6%96%87%E7%89%88))

目前，实现AMD的库有`RequireJS 、curl 、Dojo  、Nodules` 等。

## CommonJS规范

`CommonJS`是服务器端模块的规范，`Node.js`采用了这个规范。Node.JS首先采用了js模块化的概念。

根据`CommonJS`规范，一个单独的文件就是一个模块。每一个模块都是一个单独的作用域，也就是说，在该模块内部定义的变量，无法被其他模块读取，除非定义为`global`对象的属性。

输出模块变量的最好方法是使用`module.exports`对象。

	var i = 1;
	var max = 30;
	
	module.exports = function () {
	  for (i -= 1; i++ < max; ) {
	    console.log(i);
	  }
	  max *= 1.1;
	};

上面代码通过`module.exports`对象，定义了一个函数，该函数就是模块外部与内部通信的桥梁。
加载模块使用`require`方法，该方法读取一个文件并执行，最后返回文件内部的`module.exports`对象。

`CommonJS` 规范：[http://javascript.ruanyifeng....](http://javascript.ruanyifeng.com/nodejs/commonjs.html)

## RequireJS和SeaJS

`RequireJS`由James Burke创建，他也是AMD规范的创始人。
`define`方法用于定义模块，`RequireJS`要求每个模块放在一个单独的文件里。
`RequireJS` 和 `Sea.js` 都是模块加载器，倡导模块化开发理念，核心价值是让 `JavaScript` 的模块化开发变得简单自然。
`SeaJS`与`RequireJS`最大的区别:
`SeaJS`对模块的态度是懒执行, 而`RequireJS`对模块的态度是预执行

不明白？看这篇图文并茂的文章吧：[http://www.douban.com/note/28...](http://www.douban.com/note/283566440/)

`RequireJS API`:[http://www.requirejs.cn/docs/...](http://www.requirejs.cn/docs/api.html)

`RequireJS`的用法：[http://www.ruanyifeng.com/blo...](http://www.ruanyifeng.com/blog/2012/11/require_js.html)

### 为什么要用requireJS

试想一下，如果一个网页有很多的js文件，那么浏览器在下载该页面的时候会先加载js文件，从而停止了网页的渲染，如果文件越多，浏览器可能失去响应。其次，要保证js文件的依赖性，依赖性最大的模块（文件）要放在最后加载，当依赖关系很复杂的时候，代码的编写和维护都会变得困难。

RequireJS就是为了解决这两个问题而诞生的：

	（1）实现js文件的异步加载，避免网页失去响应；
	（2）管理模块之间的依赖性，便于代码的编写和维护。

`RequireJS`文件下载：[http://www.requirejs.cn/docs/...](http://www.requirejs.cn/docs/download.html)

## AMD和CMD

`CMD`（Common Module Definition） 通用模块定义。该规范明确了模块的基本书写格式和基本交互规则。该规范是在国内发展出来的。AMD是依赖关系前置，CMD是按需加载。

在 CMD 规范中，一个模块就是一个文件。代码的书写格式如下：

	define(factory);

`factory` 为函数时，表示是模块的构造方法。执行该构造方法，可以得到模块向外提供的接口。factory 方法在执行时，默认会传入三个参数：`require、exports 和 module：`

	define(function(require, exports, module) {
	
	  *// 模块代码*
	
	});

require是可以把其他模块导入进来的一个参数，而export是可以把模块内的一些属性和方法导出的。

CMD规范地址：[https://github.com/seajs/seaj...](https://github.com/seajs/seajs/issues/242)

	AMD 是 RequireJS 在推广过程中对模块定义的规范化产出。
	CMD 是 SeaJS 在推广过程中对模块定义的规范化产出。

对于依赖的模块，`AMD` 是提前执行，`CMD` 是延迟执行。

	AMD:提前执行（异步加载：依赖先执行）+延迟执行
	CMD:延迟执行（运行到需加载，根据顺序执行）

CMD 推崇依赖就近，AMD 推崇依赖前置。看如下代码：

	*// CMD*
	define(function(require, exports, module) {
	var a = require('./a')
	a.doSomething()
	*// 此处略去 100 行*
	var b = require('./b') *// 依赖可以就近书写*
	b.doSomething()
	*// ... *
	})
	
	*// AMD 默认推荐的是*
	define(['./a', './b'], function(a, b) { *// 依赖必须一开始就写好*
	a.doSomething()
	*// 此处略去 100 行*
	b.doSomething()
	...
	})

另外一个区别是：

	AMD:API根据使用范围有区别，但使用同一个api接口
	CMD:每个API的职责单一

`AMD`的优点是：异步并行加载，在`AMD`的规范下，同时异步加载是不会产生错误的。
`CMD`的机制则不同，这种加载方式会产生错误，如果能规范化模块内容形式，也可以

`jquery1.7`以上版本会自动模块化，支持`AMD`模式：主要是使用`define`函数，`sea.js`虽然是`CommonJS`规范，但却使用了`define`来定义模块

所以jQuery已经自动模块化了

	seajs.config({
	
	'base':'/',
	
	'alias':{
	
	    'jquery':'jquery.js'//定义jQuery文件
	
	}
	});

`define`函数和`AMD`的`define`类似：

	define(function(require, exports, module{
	
	     *//先要载入jQuery的模块*
	
	     var $ = require('jquery');
	
	     *//然后将jQuery对象传给插件模块*
	
	     require('./cookie')($);
	
	     *//开始使用 $.cookie方法*
	
	});

## sea.js如何使用？

	 - 引入sea.js的库
	 - 如何变成模块？
	      - define
	 - 3.如何调用模块？
	
	      -exports
	      -sea.js.use
	
	 - 4.如何依赖模块？
	
	      -require
	
	 <script type="text/javascript">
	        define(function (require,exports,module) {
	            *//exports : 对外的接口*
	            *//requires : 依赖的接口*
	            require('./test.js');*//如果地址是一个模块的话，那么require的返回值就是模块中的exports*
	        })
	</script>

## sea.js 开发实例

	 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>鼠标拖拽的模块化开发实践</title>
	<style type="text/css">
	#div1{ width:200px; height:200px; background:black; position:absolute; display:none;}
	#div2{ width:30px; height:30px; background:yellow; position:absolute; bottom:0; right:0;}
	#div3{ width:100px; height:100px; background:blue; position:absolute; right:0; top:0;}
	</style>
	<script type="text/javascript" src="./sea.js"></script>
	<script type="text/javascript">
	
	*//A同事 ：*
	seajs.use('./main.js');
	
	</script>
	</head>
	
	<body>
	<input type="button" value="确定" id="input1" />
	<div id="div1">
	    <div id="div2"></div>
	</div>
	<div id="div3"></div>
	</body>
	</html>

### A同事

	*//A同事写的main.js:*
	
	define(function (require,exports,module) {
	    var oInput = document.getElementById('input1');
	    var oDiv1 = document.getElementById('div1');
	    var oDiv2 = document.getElementById('div2');
	    var oDiv3 = document.getElementById('div3');
	
	    require('./drag.js').drag(oDiv3);
	    oInput.onclick = function () {
	        oDiv1.style.display = 'block';
	        require('./scale.js').scale(oDiv1,oDiv2);
	
	        require.async('./scale.js', function (ex) {
	            ex.scale(oDiv1,oDiv2);
	        })
	    }
	});

### B同事

	*//B同事写的drag.js:*
	
	define(function(require,exports,module){
	
	    function drag(obj){
	        var disX = 0;
	        var disY = 0;
	        obj.onmousedown = function(ev){
	            var ev = ev || window.event;
	            disX = ev.clientX - obj.offsetLeft;
	            disY = ev.clientY - obj.offsetTop;
	
	            document.onmousemove = function(ev){
	                var ev = ev || window.event;
	
	                 var L = require('./range.js').range(ev.clientX - disX , document.documentElement.clientWidth - obj.offsetWidth , 0 );
	                 var T = require('./range.js').range(ev.clientY - disY , document.documentElement.clientHeight - obj.offsetHeight , 0 );
	
	                obj.style.left = L + 'px';
	                obj.style.top = T + 'px';
	            };
	            document.onmouseup = function(){
	                document.onmousemove = null;
	                document.onmouseup = null;
	            };
	            return false;
	        };
	    }
	
	    exports.drag = drag;*//对外提供接口*
	
	});

### C同事

	*//C同事写的scale.js:*
	
	define(function(require,exports,module){
	
	    function scale(obj1,obj2){
	        var disX = 0;
	        var disY = 0;
	        var disW = 0;
	        var disH = 0;
	
	        obj2.onmousedown = function(ev){
	            var ev = ev || window.event;
	            disX = ev.clientX;
	            disY = ev.clientY;
	            disW = obj1.offsetWidth;
	            disH = obj1.offsetHeight;
	
	            document.onmousemove = function(ev){
	                var ev = ev || window.event;
	
	                var W = require('./range.js').range(ev.clientX - disX + disW , 500 , 100);
	                var H = require('./range.js').range(ev.clientY - disY + disH , 500 , 100);
	
	                obj1.style.width = W + 'px';
	                obj1.style.height = H + 'px';
	            };
	            document.onmouseup = function(){
	                document.onmousemove = null;
	                document.onmouseup = null;
	            };
	            return false;
	        };
	
	    }
	
	    exports.scale = scale;
	
	});

### D同事

	// D同事的range.js*--限定拖拽范围*
	
	    define(function(require,exports,module){
	
	        function range(iNum,iMax,iMin){
	
	            if( iNum > iMax ){
	                return iMax;
	            }
	            else if( iNum < iMin ){
	                return iMin;
	            }
	            else{
	                return iNum;
	            }
	
	        }
	
	        exports.range = range;
	
	    });

![bVkONe](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107125158.png)

## requirejs开发实例

`require.config`是用来定义别名的，在`paths`属性下配置别名。然后通过`requirejs`(参数一，参数二)；参数一是数组，传入我们需要引用的模块名，第二个参数是个回调函数，回调函数传入一个变量，代替刚才所引入的模块。

### main.js文件

	*//别名配置*
	requirejs.config({
	    paths: {
	        jquery: 'jquery.min' *//可以省略.js*
	    }
	});
	*//引入模块，用变量$表示jquery模块*
	requirejs(['jquery'], function ($) {
	    $('body').css('background-color','red');
	});

引入模块也可以只写`require()`。`requirejs`通过`define()`定义模块，定义的参数上同。在此模块内的方法和变量外部是无法访问的，只有通过`return`返回才行.

### define 模块

	define(['jquery'], function ($) {*//引入jQuery模块*
	    return {
	        add: function(x,y){
	            return x + y;
	        }
	    };
	});

将该模块命名为`math.js`保存。

### main.js引入模块方法

	require(['jquery','math'], function ($,math) {
	    console.log(math.add(10,100));//110
	});

## 没有依赖

如果定义的模块不依赖其他模块，则可以：

	define(function () {
	
	    return {
	        name: "trigkit4",
	        age: "21"
	    }
	});

`AMD`推荐的风格通过返回一个对象做为模块对象，`CommonJS`的风格通过对`module.exports`或`exports`的属性赋值来达到暴露模块对象的目的。

[![9335933442977398037](../_resources/e6b783dfca3bb4b11de5526d1ff4bd7e.png)](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CvGePRKjFX47CPMai2gTTh5mgC5CO4rFg2ZTSqp4M6ayu2twIEAEgkdfZR2CdAaAB8ILE0wPIAQKpAh9hEcS3ZoQ-qAMByAPJBKoE3wFP0Doy1sBPzE6NO-XyGORhWWBzi_MjwYkuHkf2oKDKTDC9vGNveD5VkVDZc_M5x2cP6uw8qUELS2qXQf2nE6IjHbB6G1N65X28_-Cq-gamuI-uaP0GUJrpzt3lXx6z0FWRGqdqT0KghRygrPY2uMeVi7_3m7SdwJliIoF5ALfimdm2e07mH1leGV4_OJTFrucAmrnOuGEhA9VqozOwnPGk1LICwA1YDOlZPDfghWUz5w_9JLwY7RJF0HVCO4dHJg6p9Xg5bYRVoie2crp5f-YyiIfFwBR0XvFHJzd_nxcLwATe9qCp1gGgBgKAB_j8uyyoB9XJG6gH8NkbqAfy2RuoB47OG6gHk9gbqAe6BqgH7paxAqgHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BvYBwHSCAcIgGEQARgfsQmwT8n9mrSCyYAKAZgLAcgLAbgMAdgTAg&ae=1&num=1&cid=CAASEuRod3KewvABzYoaJCMcBb9CZQ&sig=AOD64_3HCsBn9fV4C4iEuh0-FPBbMM5EMw&client=ca-pub-6330872677300335&nb=17&adurl=https://www.ucloud.cn/site/global.html%3Futm_source%3Dgoogle%26utm_campaign%3D%25E7%25BD%2591%25E7%259B%259F%252D%25E5%2585%25B3%25E9%2594%25AE%25E8%25AF%258D%25E5%25AE%259A%25E5%2590%2591%252D10%252E09%26utm_adgroup%3D%25E5%2585%25B3%25E9%2594%25AE%25E8%25AF%258D%25E5%25AE%259A%25E5%2590%2591%26utm_term%3D%25E5%2585%25B3%25E9%2594%25AE%25E8%25AF%258D%25E5%25AE%259A%25E5%2590%2591%26utm_medium%3Dsearch%255Fcpc%26utm_channel%3Dpc%26utm_content%3Dwangmeng%26ytag%3D%25E5%2587%25BA%25E6%25B5%25B7_%25E5%2585%25B3%25E9%2594%25AE%25E8%25AF%258D%25E5%25AE%259A%25E5%2590%25912_%25E6%25B5%25B7%25E5%25A4%2596%25E6%259C%258D%25E5%258A%25A1%25E5%2599%25A8_segmentfault.com_google_search%26gclid%3DEAIaIQobChMIjvTaltyr7QIVRpGWCh3TQwa0EAEYASAAEgINOvD_BwE)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='22' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='21' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

阅读 57.5k   更新于 2018-01-03

本作品系原创， [采用《署名-非商业性使用-禁止演绎 4.0 国际》许可协议](https://creativecommons.org/licenses/by-nc-nd/4.0/)

* * *

 [![62070976-5ade9afb60f6c_big64](../_resources/d1c0675ba1fcd688300492add20cdb8c.jpg)](https://segmentfault.com/u/trigkit4)

#####   [trigkit4](https://segmentfault.com/u/trigkit4)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='17'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  30k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='18'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z'%3e%3c/path%3e%3c/svg%3e)](https://github.com/hawx1993)
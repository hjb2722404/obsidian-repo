CSS魔法堂：一起玩透伪元素和Content属性 - ^_^肥子John - SegmentFault 思否

 [ ![102673977-54e68d943c286_big64](../_resources/483351f3e15a43fc0f26bf2d229ca258.png)     **肥仔John**](https://segmentfault.com/u/fsjohnhuang)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='1'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='171' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  2.5k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='2'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='175' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/fsjohnhuang)

[![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-comment-alt-lines fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='comment-alt-lines' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='5'%3e%3cpath fill='currentColor' d='M448 0H64C28.7 0 0 28.7 0 64v288c0 35.3 28.7 64 64 64h96v84c0 7.1 5.8 12 12 12 2.4 0 4.9-.7 7.1-2.4L304 416h144c35.3 0 64-28.7 64-64V64c0-35.3-28.7-64-64-64zm16 352c0 8.8-7.2 16-16 16H288l-12.8 9.6L208 428v-60H64c-8.8 0-16-7.2-16-16V64c0-8.8 7.2-16 16-16h384c8.8 0 16 7.2 16 16v288zm-96-216H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h224c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16zm-96 96H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h128c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16z' data-evernote-id='186' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://segmentfault.com/a/1190000016441049#comment-area)

#   [CSS魔法堂：一起玩透伪元素和Content属性](https://segmentfault.com/a/1190000016441049)

[css3](https://segmentfault.com/t/css3)[css](https://segmentfault.com/t/css)

 发布于 2018-09-18

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

## 前言

 继上篇《[CSS魔法堂：稍稍深入伪类选择器](https://www.cnblogs.com/fsjohnhuang/p/9551799.html)》记录完伪类后，我自然而然要向伪元素伸出“魔掌”的啦^_^。本文讲讲述伪元素以及功能强大的Contet属性，让我们可以通过伪元素更好地实现更多的可能！

## 初识伪元素

 说起伪元素我第一想到的莫过于`::before`和`::after`这两个了，它俩其实就是在其附属的选择器命中的元素上插入第一个子节点和追加最后一个子节点。那这时我不禁地想问：“直接添加两个class为.before和.after不是一样的吗？”

 其实使用伪元素`::before`和`::after`以下两个好处：
1. HTML的代码量减少，对SEO有帮助；
2. 提高JavaScript查询元素的效率。

 那为什么会这两好处呢？原因就是伪元素并不存在于DOM中，而是位于CSSOM，HTML代码和DOM Tree中均没有它的身影，量少了自然效率有所提升。但这也引入一个问题——我们没办法通过JavaScript完全操控伪元素（我将在下面一节为大家讲述）

### 一大波伪元素来了

除了`::before`和`::after`外，别漏了以下的哦！

1. `:first-line`：只能用于块级元素。用于设置附属元素的第一个行内容的样式。可用的CSS属性为`font,color,background,word-spacing,letter-spacing,text-decoration,vertical-align,text-transform,line-height,clear`。

2. `:first-letter`：只能用于块级元素。用于设置附属元素的第一个字母的样式。可用的CSS属性为`font,color,background,marin,padding,border,text-decoration,vertical-align,text-transform,line-height,float,clear`。

3. `::selection`：匹配选中部分的内容。可用的CSS属性为`background,color`。

有没有发现有的伪元素前缀是`:`有的却是`::`呢？`::`是CSS3的写法，其实除了`::selection`外，其他伪元素既两种前缀都是可以的，为兼容性可选择使用`:`，为容易区分伪元素和伪类则使用`::`，但我还是建议使用`::`来提高可读性，兼容性就让postcss等工具帮我们处理就好了。

### `::before`和`::after`的注意事项

1. 默认`display: inline`；
2. 必须设置content属性，否则一切都是无用功；
3. 默认`user-select: none`，就是`::before`和`::after`的内容无法被用户选中的；
4. 伪元素和伪类结合使用形如：`.target:hover::after`。

## JavaScript操作伪元素

 上文提到由于伪元素仅位于CSSOM中，因此我们仅能通过操作CSSOM API——`window.getComputedStyle`来读取伪元素的样式信息，注意：我们能做的就是读取，无法设置的哦！

	{- window.getComputedStyle的类型 -}
	data PseudoElement = ":before" | "::before" | ":after" | "::after" | ":first-line" | "::first-line" | ":first-letter" | "::first-letter" | "::selection" | ":backdrop" | "::backdrop" | Null
	
	window.getComputedStyle :: HTMLElement -> PesudoElement -> CSSStyleDeclaration
	
	{- CSSStyleDeclaration实例的方法 -}
	data CSSPropertyName = "float" | "backround-color" | ......
	data DOMPropertyName = "cssFloat" | "styleFloat" | "backgroundColor" | ......
	
	-- IE9+的方法
	CSSStyleDeclaration#getPropertyValue :: CSSPropertyName -> *
	-- IE6~8的方法
	CSSStyleDeclaration#getAttribute :: CSSPropertyName -> *
	-- 键值对方式获取
	CSSStyleDeclaration#[DOMPropertyName] -> *

示例：

	.target[title="hello world"]::after{
	  display: inline-block;
	  content: attr(title);
	  background: red;
	  text-decoration: underline;
	}
	
	const elTarget = document.querySelector(".target")
	const computedStyle = window.getComputedStyle(elTarget, "::after")
	const content = computedStyle.getPropertyValue("content")
	const bg = computedStyle.getAttribute("backgroundColor")
	const txtDecoration = computedStyle["text-decoration"]
	
	console.log(content) *// "hello world"*
	console.log(bg)      *// red*
	console.log(txtDecoration) *// underline*

## 玩透Content属性

 到这里我们已经可以利用`::before`和`::after`实现tooltip等效果了，但其实更为强大的且更需花时间研究的才刚要开始呢！那就是Content属性，不仅仅可以简单直接地设置一个字符串作为伪元素的内容，它还具备一定限度的编程能力，就如上面`attr(title)`那样，以其附属元素的title特性作为content值。下面请允许我为大家介绍吧！

	div::after{
	    content: "普通字符串";
	    content: attr(父元素的html属性名称);
	    content: url(图片、音频、视频等资源的url);
	    */* 使用unicode字符集，采用4位16进制编码
	     * 但不同的浏览器显示存在差异，而且移动端识别度更差
	     */*
	    content: "\21e0";
	    */* content的多个值可以任意组合，各部分通过空格分隔 */*
	    content: "'" attr(title) "'";
	
	    */* 自增计数器，用于插入数字/字母/罗马数字编号
	     * counter-reset: [<identifier> <integer>?]+，必选，用于标识自增计数器的作用范围，<identifier>为自定义名称，<integer>为起始编号默认为0。
	     * counter-increment: [<identifier> <integer>?]+，用于标识计数器与实际关联的范围，<identifier>为counter-reset中的自定义名称，<integer>为步长默认为1。
	     * <list-style-type>: disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha
	     */*
	    content: counter(<identifier>, <list-style-type>);
	
	    */* 以父附属元素的qutoes值作为content的值
	     */*
	    content: open-quote | close-quote | no-open-quote | no-close-quote;
	}

换行符：HTML实体为`&#010`，CSS为`\A`，JS为`\uA`。
 可以看到Content接受6种类型，和一种组合方式。其中最后两种比较复杂，我们后面逐一说明。

### 自定义计数器

 HTML为我们提供`ul`或`ol`和`li`来实现列表，但如果我们希望实现更为可性化的列表，那么该如何处理呢？content属性的counter类型值就能帮到我们。

	<!-- HTML 部分-->
	.dl
	 .dt{chapter1}
	 .dd{text11}
	 .dd{text12}
	 .dt{chapter2}
	 .dd{text21}
	
	*/* CSS部分 */*
	.dl {
	  counter-reset: dt 0; */* 表示解析到.dl时，重置dt计数器为0 */*
	
	  & .dt {
	    counter-reset: dd 0; */* 表示解析到.dt时，重置dd计数器为0 */*
	
	    &::before{
	        counter-increment: dt 1; */* 表示解析到.dt时，dt计数器自增1 */*
	        content: counter(dt, lower-roman) " ";
	    }
	  }
	
	  & .dd::before {
	    counter-increment: dd 1; */* 表示解析到.dd时，dd计数器自增1 */*
	    content: counter(dd) " ";
	  }
	}

![1460000016441052](../_resources/282ad128def08571c300fada9c0e2acc.png)

通过`counter-reset`来定义和重置计数器，通过`counter-increment`来增加计数器的值，然后通过`counter`来决定使用哪个计数器，并指定使用哪种样式。

 如果用JavaScript来表示应该是这样的

	const globalCounters = {"__temp":{}}
	
	function resetCounter(name, value){
	  globalCounters[name] = value
	}
	function incrementCounter(name, step){
	  const oVal = globalCounters[name]
	  if (oVal){
	    globalCounters[name] = oVal + step
	  }
	  else{
	    globalCounters.__temp[name] = step
	  }
	}
	function counter(name, style){
	    return globalCounters[name] || globalCounters.__temp[name]
	}
	
	function applyCSS(mount){
	    const clz = mount.className
	    if (clz == "dl"){
	        resetCounter("dt", 0)
	        const children = mount.children
	        for (let i = 0; i < children.length; ++i){
	          applyCSS(children[i])
	        }
	    }
	    else if (clz == "dt"){
	        resetCounter("dd", 0)
	        incrementCounter("dt", 1)
	        const elAsBefore = document.createElement("span")
	        elAsBefore.textContent = counter("dt", "lower-roman") + " "
	        mount.insertBefore(mount.firstChild)
	    }
	    else if (clz == "dd"){
	        incrementCounter("dd", 1)
	        const elAsBefore = document.createElement("span")
	        elAsBefore.textContent = counter("dd", "lower-roman") + " "
	        mount.insertBefore(mount.firstChild)
	    }
	}

#### 嵌套计数器

 对于多层嵌套计数器我们可以使用`counters(<identifier>, <separator>, <list-style-type>?)`

	.ol
	  .li
	    .ol
	      .li{a}
	      .li{b}
	  .li
	    .ol
	      .li{c}
	.ol {
	    counter-reset: ol;
	    & .li::before {
	        counter-increment: ol;
	        content: counters(ol, ".");
	    }
	}

#### Content的限制

1. IE8+才支持Content属性；
2. 除了Opera9.5+中所有元素均支持外，其他浏览器仅能用于`:before,:after`内使用；
3. 无法通过JS获取Counter和Counters的运算结果。得到的就只能是`"counter(mycouonter) \" \""`。

### 自定义引号

 引号这个平时很少在意的符号，其实在不同的文化中使用的引号将不尽相同，如简体中文地区使用的`""`，而日本则使用`「」`。那我们根据需求自定义引号呢？答案是肯定的。

 通过`open-quote`,`close-quote`,`no-open-quote`和`no-close-quote`即可实现，下面我们通过例子来理解。
 `<q>`会根据父元素的`lang`属性自动创建`::before`和`::after`来实现插入quotation marks。

	p[lang=en]>q{英语}
	p[lang=no]>q{挪威语}
	p[lang=zh]>q{汉语}
	p[lang=en]>q.no-quote{英语2}
	div[lang=no]>.quote{挪威语2}

CSS片段：

	p[lang=en] > q{
	  quotes: "<!--" "-->"; */* 定义引号 */*
	}
	p[lang=en] > q.no-quote::before{
	  content: no-open-quote;
	  */*或者 content: none;*/*
	}
	div[lang=no] > .quote {
	  quotes: "<<-" "->>";
	}
	div[lang=no] > .quote::before {
	  content: open-quote;
	}
	div[lang=no] > .quote::after {
	  content: close-quote;
	}

![1460000016441053](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108133610.png)

## 示例

### 分割线

`p.sep{or}`

	.sep {
	  position: relative;
	  text-align: center;
	
	  &::before,
	  &::after {
	    content: "";
	    box-sizing: border-box;
	    height: 1px;
	    width: 50%;
	    border-left: 3em solid transparent;
	    border-right: 3em solid transparent;
	    position: absolute;
	    top: 50%;
	  }
	
	  &::before {
	    left: 0;
	  }
	
	  &::after {
	    right: 0;
	  }
	}

### 只读效果(通过遮罩原来的元素实现)

	.input-group {
	  position: relative;
	
	  &.readonly::before {
	    content: "";
	    position: absolute;
	    width: 100%;
	    height: 100%;
	    top: 0;
	    left: 0;
	  }
	}

### 计数器

	.selections>input[type=checkbox]{option1}+input[type=checkbox]{option2}
	.selection-count
	.selections{
	  counter-reset: selection-count;
	
	  & input:checked {
	    counter-increment: selection-count;
	  }
	}
	.selection-count::before {
	  content: counter(selection-count);
	}

## 最后

 尊重原创，转载请注明来自：[https://www.cnblogs.com/fsjoh...](https://www.cnblogs.com/fsjohnhuang/p/9665156.html) 肥仔John^_^

## 参考

[http://www.wozhuye.com/compat...](http://www.wozhuye.com/compatible/297.html)

[https://dev.opera.com/article...](https://dev.opera.com/articles/css-generated-content-techniques/)

[www.miniui.com](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CzQG4ZNk9X5fjLLGMs8IP-quYoA23sYaxXJfejoCWCumsrtrcCBABIJHX2UdgnQHIAQGpAlGQCCTHZIM-qAMByAPLBKoE1AFP0Hd2WTqj-ECCkv-RmNkNfboMlB23fy3bJFdBDjemxHmkdFpD-HtN2iM5AYPoPy9aFlRtpuPLjLVP54_147YCU1GzK5U6Dvt0B_fFeM-GcsMdnRwbN16_-sLJ45dK512Vmp-Buv3GSaVkFok9paK9Y9-CD2sujoVIbMfPxAEYyQaqrYAqydfk_tgTEpmSpgoJMWsCadPHIkVetZl_eNgu6i-ZdIx-Bre_hR-gTHRo8hHiAhaAwgmQQ_Hy60zDiHmeng58iU1XiAmg8tKWw_HyWe7HCsAEqbK6lx6AB9GIrh6oB47OG6gH1ckbqAeT2BuoB7oGqAfw2RuoB_LZG6gHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BuoB8LaG9gHAdIIBwiAYRABGB-aCTJodHRwOi8vbWluaXVpLmNvbS9kZW1vLyNzcmM9ZGF0YWdyaWQvY2VsbGVkaXQuaHRtbLEJeX8YmwU3JaeACgHICwHYEwKIFAE&ae=1&num=1&sig=AOD64_31vkjCnz7EawGXVZCeNRA0gXv0rw&client=ca-pub-6330872677300335&nb=1&adurl=http://miniui.com/demo/%3Fgclid%3DEAIaIQobChMIl6Wl89eo6wIVMcZMAh36FQbUEAEYASAAEgIRw_D_BwE%23src%3Ddatagrid/celledit.html)

[jQuery MiniUI](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CzQG4ZNk9X5fjLLGMs8IP-quYoA23sYaxXJfejoCWCumsrtrcCBABIJHX2UdgnQHIAQGpAlGQCCTHZIM-qAMByAPLBKoE1AFP0Hd2WTqj-ECCkv-RmNkNfboMlB23fy3bJFdBDjemxHmkdFpD-HtN2iM5AYPoPy9aFlRtpuPLjLVP54_147YCU1GzK5U6Dvt0B_fFeM-GcsMdnRwbN16_-sLJ45dK512Vmp-Buv3GSaVkFok9paK9Y9-CD2sujoVIbMfPxAEYyQaqrYAqydfk_tgTEpmSpgoJMWsCadPHIkVetZl_eNgu6i-ZdIx-Bre_hR-gTHRo8hHiAhaAwgmQQ_Hy60zDiHmeng58iU1XiAmg8tKWw_HyWe7HCsAEqbK6lx6AB9GIrh6oB47OG6gH1ckbqAeT2BuoB7oGqAfw2RuoB_LZG6gHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BuoB8LaG9gHAdIIBwiAYRABGB-aCTJodHRwOi8vbWluaXVpLmNvbS9kZW1vLyNzcmM9ZGF0YWdyaWQvY2VsbGVkaXQuaHRtbLEJeX8YmwU3JaeACgHICwHYEwKIFAE&ae=1&num=1&sig=AOD64_31vkjCnz7EawGXVZCeNRA0gXv0rw&client=ca-pub-6330872677300335&nb=0&adurl=http://miniui.com/demo/%3Fgclid%3DEAIaIQobChMIl6Wl89eo6wIVMcZMAh36FQbUEAEYASAAEgIRw_D_BwE%23src%3Ddatagrid/celledit.html)

[快速开发WebUI界面，支持Java、.Net、PHP](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CzQG4ZNk9X5fjLLGMs8IP-quYoA23sYaxXJfejoCWCumsrtrcCBABIJHX2UdgnQHIAQGpAlGQCCTHZIM-qAMByAPLBKoE1AFP0Hd2WTqj-ECCkv-RmNkNfboMlB23fy3bJFdBDjemxHmkdFpD-HtN2iM5AYPoPy9aFlRtpuPLjLVP54_147YCU1GzK5U6Dvt0B_fFeM-GcsMdnRwbN16_-sLJ45dK512Vmp-Buv3GSaVkFok9paK9Y9-CD2sujoVIbMfPxAEYyQaqrYAqydfk_tgTEpmSpgoJMWsCadPHIkVetZl_eNgu6i-ZdIx-Bre_hR-gTHRo8hHiAhaAwgmQQ_Hy60zDiHmeng58iU1XiAmg8tKWw_HyWe7HCsAEqbK6lx6AB9GIrh6oB47OG6gH1ckbqAeT2BuoB7oGqAfw2RuoB_LZG6gHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BuoB8LaG9gHAdIIBwiAYRABGB-aCTJodHRwOi8vbWluaXVpLmNvbS9kZW1vLyNzcmM9ZGF0YWdyaWQvY2VsbGVkaXQuaHRtbLEJeX8YmwU3JaeACgHICwHYEwKIFAE&ae=1&num=1&sig=AOD64_31vkjCnz7EawGXVZCeNRA0gXv0rw&client=ca-pub-6330872677300335&nb=7&adurl=http://miniui.com/demo/%3Fgclid%3DEAIaIQobChMIl6Wl89eo6wIVMcZMAh36FQbUEAEYASAAEgIRw_D_BwE%23src%3Ddatagrid/celledit.html)

[ 打开](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CzQG4ZNk9X5fjLLGMs8IP-quYoA23sYaxXJfejoCWCumsrtrcCBABIJHX2UdgnQHIAQGpAlGQCCTHZIM-qAMByAPLBKoE1AFP0Hd2WTqj-ECCkv-RmNkNfboMlB23fy3bJFdBDjemxHmkdFpD-HtN2iM5AYPoPy9aFlRtpuPLjLVP54_147YCU1GzK5U6Dvt0B_fFeM-GcsMdnRwbN16_-sLJ45dK512Vmp-Buv3GSaVkFok9paK9Y9-CD2sujoVIbMfPxAEYyQaqrYAqydfk_tgTEpmSpgoJMWsCadPHIkVetZl_eNgu6i-ZdIx-Bre_hR-gTHRo8hHiAhaAwgmQQ_Hy60zDiHmeng58iU1XiAmg8tKWw_HyWe7HCsAEqbK6lx6AB9GIrh6oB47OG6gH1ckbqAeT2BuoB7oGqAfw2RuoB_LZG6gHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BuoB8LaG9gHAdIIBwiAYRABGB-aCTJodHRwOi8vbWluaXVpLmNvbS9kZW1vLyNzcmM9ZGF0YWdyaWQvY2VsbGVkaXQuaHRtbLEJeX8YmwU3JaeACgHICwHYEwKIFAE&ae=1&num=1&sig=AOD64_31vkjCnz7EawGXVZCeNRA0gXv0rw&client=ca-pub-6330872677300335&nb=8&adurl=http://miniui.com/demo/%3Fgclid%3DEAIaIQobChMIl6Wl89eo6wIVMcZMAh36FQbUEAEYASAAEgIRw_D_BwE%23src%3Ddatagrid/celledit.html)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='43' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='41' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

阅读 4.2k  更新于 2018-09-18

本作品系 原创， [采用《署名-非商业性使用-禁止演绎 4.0 国际》许可协议](https://creativecommons.org/licenses/by-nc-nd/4.0/)

* * *

 [![102673977-54e68d943c286_big64](../_resources/483351f3e15a43fc0f26bf2d229ca258.png)](https://segmentfault.com/u/fsjohnhuang)

#####   [肥仔John](https://segmentfault.com/u/fsjohnhuang)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='16'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  2.5k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='17'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z'%3e%3c/path%3e%3c/svg%3e)](https://github.com/fsjohnhuang)
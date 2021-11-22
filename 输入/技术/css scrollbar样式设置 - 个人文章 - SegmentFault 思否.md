css scrollbar样式设置 - 个人文章 - SegmentFault 思否

 [ ![3099806835-57ad264730029_big64](../_resources/489ac23c244591144524605dbabfa1b2.jpg)     **specialCoder**](https://segmentfault.com/u/learnme)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='1'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='170' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  1.6k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='2'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='174' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/specialCoder)

[![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-comment-alt-lines fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='comment-alt-lines' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='5'%3e%3cpath fill='currentColor' d='M448 0H64C28.7 0 0 28.7 0 64v288c0 35.3 28.7 64 64 64h96v84c0 7.1 5.8 12 12 12 2.4 0 4.9-.7 7.1-2.4L304 416h144c35.3 0 64-28.7 64-64V64c0-35.3-28.7-64-64-64zm16 352c0 8.8-7.2 16-16 16H288l-12.8 9.6L208 428v-60H64c-8.8 0-16-7.2-16-16V64c0-8.8 7.2-16 16-16h384c8.8 0 16 7.2 16 16v288zm-96-216H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h224c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16zm-96 96H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h128c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16z' data-evernote-id='185' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://segmentfault.com/a/1190000012800450#comment-area)

#   [css scrollbar样式设置](https://segmentfault.com/a/1190000012800450)

[html](https://segmentfault.com/t/html)[css](https://segmentfault.com/t/css)

 发布于 2018-01-11

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

# 一 前言

在CSS 中，如果我们在块级容器上设置了属性:

	overflow:scroll */* x y 方向都会*/*
	或者
	overflow-x:scroll */*只是x方向*/*
	或者
	overflow-y:scroll  */*只是y方向*/*

当块级内容区域超出块级元素范围的时候，就会以滚动条的形式展示，你可以滚动里面的内容，里面的内容不会超出块级区域范围。
有时候我们需要自定义滚动条的样式，比如一开始就它显示，比如想改变滚动条的颜色，设置轨道的样式等，那么这篇文章就是为你准备的。

# 二 正文

1.认识滚动条
![bV1RSv](https://gitee.com/hjb2722404/tuchuang/raw/master/img/b42dff97122223bd679add5a71082bf4.png)
设置scrollbar的为CSS伪元素，对应上图的数字：

	::-webkit-scrollbar              { /* 1 */ }
	::-webkit-scrollbar-button       { /* 2 */ }
	::-webkit-scrollbar-track        { /* 3 */ }
	::-webkit-scrollbar-track-piece  { /* 4 */ }
	::-webkit-scrollbar-thumb        { /* 5 */ }
	::-webkit-scrollbar-corner       { /* 6 */ }
	::-webkit-resizer                { /* 7 */ }

属性介绍：

	::-webkit-scrollbar    *//滚动条整体部分*
	::-webkit-scrollbar-button   *//滚动条两端的按钮*
	::-webkit-scrollbar-track   *// 外层轨道*
	::-webkit-scrollbar-track-piece    *//内层轨道，滚动条中间部分（除去）*
	::-webkit-scrollbar-thumb *//滚动条里面可以拖动的那个*
	::-webkit-scrollbar-corner   *//边角*
	::-webkit-resizer   *///定义右下角拖动块的样式*

2.设置样式
[demo](http://www.xuanfengge.com/demo/201311/scroll/css3-scroll.html)
进入页面，打开控制台工具，选中其中一个样式，就能看到该样式的CSS源码。

	*/*定义滚动条高宽及背景
	 高宽分别对应横竖滚动条的尺寸*/*
	::-webkit-scrollbar
	{
	    width:16px;
	    height:16px;
	    background-color:#F5F5F5;
	}
	*/*定义滚动条轨道
	 内阴影+圆角*/*
	::-webkit-scrollbar-track
	{
	    -webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.3);
	    border-radius:10px;
	    background-color:#F5F5F5;
	}
	*/*定义滑块
	 内阴影+圆角*/*
	::-webkit-scrollbar-thumb
	{
	    border-radius:10px;
	    -webkit-box-shadow:inset 0 0 6px rgba(0,0,0,.3);
	    background-color:#555;
	}

![bV1R2y](https://gitee.com/hjb2722404/tuchuang/raw/master/img/5ebbb7e85a38a670da00b71466b5d4b3.png)
任何对象都可以设置：边框、阴影、背景图片等等，创建的滚动条任然会按照操作系统本身的设置来完成其交互的行为。下面的伪类可以应用到上面的伪元素中。

	:horizontal*//适用于任何水平方向上的滚动条*
	:vertical*//适用于任何垂直方向的滚动条*
	:decrement*//适用于按钮和轨道碎片。表示递减的按钮或轨道碎片，例如可以使区域向上或者向右移动的区域和按钮*
	:increment*//适用于按钮和轨道碎片。表示递增的按钮或轨道碎片，例如可以使区域向下或者向左移动的区域和按钮*
	:start*//适用于按钮和轨道碎片。表示对象（按钮轨道碎片）是否放在滑块的前面*
	:end *//适用于按钮和轨道碎片。表示对象（按钮轨道碎片）是否放在滑块的后面*
	:double-button*//适用于按钮和轨道碎片。判断轨道结束的位置是否是一对按钮。也就是轨道碎片紧挨着一对在一起的按钮。*
	:single-button*//适用于按钮和轨道碎片。判断轨道结束的位置是否是一个按钮。也就是轨道碎片紧挨着一个单独的按钮。*
	:no-button*//表示轨道结束的位置没有按钮。*
	:corner-present*//表示滚动条的角落是否存在。*
	:window-inactive*//适用于所有滚动条，表示包含滚动条的区域，焦点不在该窗口的时候。*

用法举例：

	::-webkit-scrollbar-track-piece:start {
	   /* Select the top half (or left half) or scrollbar track individually */
	}
	
	::-webkit-scrollbar-thumb:window-inactive {
	   /* Select the thumb when the browser window isn't in focus */
	}
	
	::-webkit-scrollbar-button:horizontal:decrement:hover {
	   /* Select the down or left scroll button when it's being hovered by the mouse */
	}

3.IE浏览器

兼容IE的参考链接：[https://www.cnblogs.com/koley...](https://www.cnblogs.com/koleyang/p/5484922.html)

![bV1R7R](https://gitee.com/hjb2722404/tuchuang/raw/master/img/e77c796b79b4968302f686f0d955426b.gif)
![bV1R8h](../_resources/402fa8af7113df41f6b85fd8dc225650.png)

# 三 后记

Chrome能很好的支持自定义滚动条，其它的浏览器在不同程度上支持自定义滚动条样式。

参考文章：[http://blog.csdn.net/cysear/a...](http://blog.csdn.net/cysear/article/details/70264148)

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

阅读 54.6k  更新于 2019-03-25

本作品系 原创， [采用《署名-非商业性使用-禁止演绎 4.0 国际》许可协议](https://creativecommons.org/licenses/by-nc-nd/4.0/)

* * *

 [![3099806835-57ad264730029_big64](../_resources/489ac23c244591144524605dbabfa1b2.jpg)](https://segmentfault.com/u/learnme)

#####   [specialCoder](https://segmentfault.com/u/learnme)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='16'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='427' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  1.6k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='17'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='431' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/specialCoder)
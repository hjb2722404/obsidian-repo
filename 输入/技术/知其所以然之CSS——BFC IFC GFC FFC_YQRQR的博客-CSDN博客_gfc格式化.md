知其所以然之CSS——BFC IFC GFC FFC_YQRQR的博客-CSDN博客_gfc格式化



[![3_yqrqr](../_resources/9b5303207914618c1a9d516c401de6b9.png)](https://blog.csdn.net/YQRQR)
[(L)](https://blog.csdn.net/YQRQR)  [Ms.Yang](https://blog.csdn.net/YQRQR)

码龄8年  [![nocErtification.png](../_resources/cc44893427cf71b0f457dc9be488e432.png)暂无认证](https://me.csdn.net/YQRQR?utm_source=14998968)

# 以然之CSS——BFC IFC GFC FFC

![original.png](../_resources/8f19bb4e9750fc1d08da69d6a9ac56cd.png)

[Ms.Yang](https://me.csdn.net/YQRQR)  2018-10-20 22:35:27  ![articleReadEyes.png](../_resources/c4360f77d43b7f3fdc7b1e070f32dfd4.png)  222  ![tobarCollect.png](../_resources/5dad7f82dd0d8ba01fecbf11a059a7cd.png)  收藏  1

分类专栏：  [css](https://blog.csdn.net/yqrqr/category_6283671.html)  文章标签：  [BFC](https://www.csdn.net/gather_2c/MtTaEg0sNDEwNjItYmxvZwO0O0OO0O0O.html)  [IFC](https://so.csdn.net/so/search/s.do?q=IFC&t=blog&o=vip&s=&l=&f=&viparticle=)  [GFC](https://so.csdn.net/so/search/s.do?q=GFC&t=blog&o=vip&s=&l=&f=&viparticle=)  [FFC](https://so.csdn.net/so/search/s.do?q=FFC&t=blog&o=vip&s=&l=&f=&viparticle=)

版权

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' style='display: none%3b' data-evernote-id='1785' class='js-evernote-checked'%3e %3cpath stroke-linecap='round' d='M5%2c0 0%2c2.5 5%2c5z' id='raphael-marker-block' style='-webkit-tap-highlight-color: rgba(0%2c 0%2c 0%2c 0)%3b' data-evernote-id='1786' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)

### 文章目录

[格式化上下文 (FC - Formatting Context )](https://blog.csdn.net/YQRQR/article/details/83217710#_FC__Formatting_Context__1)

[BFC (Block Formatting Context)](https://blog.csdn.net/YQRQR/article/details/83217710#BFC_Block_Formatting_Context_3)

[IFC(Inline Formatting Context)](https://blog.csdn.net/YQRQR/article/details/83217710#IFCInline_Formatting_Context_43)

[GFC(GridLayout Formatting Context)](https://blog.csdn.net/YQRQR/article/details/83217710#GFCGridLayout_Formatting_Context_100)

[FFC(Flex Formatting Context)](https://blog.csdn.net/YQRQR/article/details/83217710#FFCFlex_Formatting_Context_107)

[扩展](https://blog.csdn.net/YQRQR/article/details/83217710#_115)
[1. 盒模型](https://blog.csdn.net/YQRQR/article/details/83217710#1__116)

[2. Block-level Box](https://blog.csdn.net/YQRQR/article/details/83217710#2_Blocklevel_Box_119)

[3. Inline-level Box](https://blog.csdn.net/YQRQR/article/details/83217710#3_Inlinelevel_Box_121)

[4. 外边距重叠](https://blog.csdn.net/YQRQR/article/details/83217710#4__123)

[5. visible:hidden 与 display:hidden区别](https://blog.csdn.net/YQRQR/article/details/83217710#5_visiblehidden__displayhidden_155)

[6. CSS三种定位机制](https://blog.csdn.net/YQRQR/article/details/83217710#6_CSS_159)
[普通流](https://blog.csdn.net/YQRQR/article/details/83217710#_160)
[浮动](https://blog.csdn.net/YQRQR/article/details/83217710#_166)
[绝对定位](https://blog.csdn.net/YQRQR/article/details/83217710#_170)

[相对定位relative与绝对定位absolute、fixed](https://blog.csdn.net/YQRQR/article/details/83217710#relativeabsolutefixed_171)

[参考](https://blog.csdn.net/YQRQR/article/details/83217710#_182)

## 格式化上下文 (FC - Formatting Context )

格式化上下文是css视觉渲染过程中的一个重要概念，主要影响盒子布局；

## BFC (Block Formatting Context)

BFC是布局中的迷你布局；
块级格式化上下文，指一个独立的块级渲染区域，只有Block-level Box可以参与；该区域有一套渲染规则来约束盒子布局，且与区域外部无关；
BFC形成条件（满足一下任一条件即可）:
> 浮动元素，float除了none外的值
> 绝对定位元素，position:absolute/fixed
> overflow设置为hidden,auto,scroll
> display为inline-block或者table-cell或者table-caption的元素
BFC并不是元素，而是元素带有的一些属性，因此上面元素是产生了BFC，而他们本身并不是BFC。
BFC规则
> 内部的Box会在垂直方向一个接一个的放置
> Box垂直方向的距离由margin决定，属于同一个BFC的两个相邻Box的margin会发生重叠
> BFC的区域不会与float box重叠
> BFC就是页面上一个隔离的独立容器，容器里面的子元素不会影响到外面的的元素；反之亦然
> 计算BFC高度的时候，浮动元素也参与计算
> 每个元素margin box的左边与包含块border box的左边相接触，即使存在浮动也如此
BFC副作用
> 使用 overflow 创建 BFC 后在某些情况下你可能会看到出现一个滚动条或者元素内容被削减，也可能使另一个开发人员感到困惑，无法理解代码的用意。
> float: left 将把元素移至左侧，并被其他元素环绕
使用display:flow-root可以创建一个BFC并且没有副作用；但此属性浏览器兼容不好
无论什么时候创建BFC都要基于自身的需要来考虑
BFC作用
> 包裹浮动元素（依据规则4、5）
> 浮动元素是脱离文档流的，如果一个没有高度或者高度为auto的容器的子元素是浮动元素，则该容器的高度不会被撑开，通过BFC就能解决容器高度不会被撑开的问题。
> 阻止外边距叠加（依据规则4）
> 阻止环绕浮动元素，实现多列布局（依据规则3、4、6）
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107132415.png)

> 对于浮动元素，可能会造成文字环绕的情况(Figure1)，但这并不是我们想要的布局(Figure2才是想要的)。要解决这个问题，我们可以用外边距，也可以用BFC；

> Figure1现象产生原因是：在BFC上下文中，每个盒子的左外侧紧贴包含块的左侧（从右到左的格式里，则为盒子右外侧紧贴包含块右侧），甚至有浮动也是如此（尽管盒子里的行盒子 Line Box 可能由于浮动而变窄），除非盒子创建了一个新的BFC（在这种情况下盒子本身可能由于浮动而变窄）。

![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107132410.png)

## IFC(Inline Formatting Context)

内联格式化上下文，盒子依次水平排列，从它包含块的最顶端开始。
盒子在垂直方向上可以以不同的方式对齐，以他们的顶部、底部、中部、文字基线对齐。
> IFC作用
水平居中
当一个块要在环境中水平居中时，设置其为inline-block则会在外层产生IFC，通过text-align则可以使其水平居中。
<style>
.container{
width:300px;
height:300px;
background: greenyellow;
color:#fff;
text-align: center;
}
.container span{
width:200px;
height:50px;
background: lightcoral;
display: inline-block;
}
</style>

<div class="container">
<span>IFC布局 — 水平居中</span>
</div>
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107132404.png)
垂直居中
创建一个IFC，用其中一个元素撑开父元素的高度，然后设置其vertical-align:middle，其他行内元素设置此属性既可以在此父元素下垂直居中
<style>
.container{
background: greenyellow;
color:#fff;
display: inline-block;
}
.container div{
display: inline-block;
width:120px;
height:50px;
background: lightskyblue;
vertical-align:middle;
}
.container div:last-child{
height:180px;
background: lightblue;
vertical-align:middle;
}
</style>
<div class="container">
        <div>1垂直居中</div>
    <div>2垂直居中</div>
</div>
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107132358.png)

## GFC(GridLayout Formatting Context)

网格布局格式化上下文，display的值为grid时会生成网格容器。
可以在网格容器内定义行、列，为每个容器网格项目定义位置、空间
目前没有浏览器支持；

## FFC(Flex Formatting Context)

自适应格式化上下文，display值为flex/inline-flex的元素将会生成自适应容器；

Flex Box由伸缩容器和伸缩项目组成。元素的display属性设置为flex/inline-flex可以得到一个伸缩容器。设置为flex（inline-flex）的容器被渲染成块级元素（行内元素）；

伸缩容器中的每个子元素都是一个伸缩项目，伸缩项目可以是任意数量。
Flex Box定义了伸缩容器内伸缩项目该如何布局；

## 扩展

### 1. 盒模型

它指定元素如何显示以及（某种程度上）如何交互。页面上每个元素都被看做一个矩形框，这个框由元素的内容、内边距、边框、外边距组成；如图所示：
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107132354.jpg)

### 2. Block-level Box

display属性为block,list-item,table的元素， 会生成block-level box。并且参与block formatting context;

### 3. Inline-level Box

display属性为inline,inline-block,inline-table的元素，会生成inline-level box。并且参与inline formatting context

### 4. 外边距重叠

当两个或者多个垂直边距相遇时，他们将形成一个外边距，这种合并外边距的方式成为折叠（collapse）。
折叠的结果按照如下规则计算：
> 两个相邻的外边距都是正数时，折叠结果是它们两者中的较大值；
> 两个相邻的外边距都是负数时，折叠结果是两者绝对值的较大值；
> 两个外边距一正一负时，折叠结果是两者相加的和；
产生折叠的必要条件是两个margin必须是相邻的！！！

不产生折叠的情况参考此篇：[揭开外边距折叠(Collapsing margins)的面纱](https://bbs.csdn.net/topics/340188875)

<style>
.container p{
width:100px;
background-color: lightblue;
margin:100px;
height:80px;
}
.container p:last-child{
margin:50px 100px 100px;
}
</style>

<div class='container'>
<p>1</p>
<p>2</p>
</div>
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107132347.png)

### 5. visible:hidden 与 display:hidden区别

visible:hidden隐藏元素，所占用的文档空间未消失；
display:hidden隐藏元素，不占用文档空间

### 6. CSS三种定位机制

#### 普通流

在普通流中元素框的位置由元素在HTML中的位置决定。
块级框从上至下一个接一个地垂直排列， 框之间的垂直距离由框的垂直外边距计算出来。
行内框在一行中水平排列。

#### 浮动

浮动框可以向左向右移动，直到它的边缘碰到包含框或另一个浮动框的边框为止；
浮动框不在文档的普通流中，所有文档普通流中的块框表现的就像浮动框不存在一样；

#### 绝对定位

##### 相对定位relative与绝对定位absolute、fixed

元素相对定位是相对于它的起点（原位置）移动，元素仍占据原先的空间，相对定位属于普通流定位模型。
元素绝对定位是相对于距离它最近的那个已定位的祖先（相对/绝对）元素决定的。如果没有已定位的祖先元素，那么它的位置相对于初始包含块；
固定定位是绝对定位的一种，不过固定元素的包含块是视口（viewport），使得我们能够创建总是出现在窗口固定位置的元素；
z-index属性控制定位框（相对/绝对）的堆叠次序。 z-index的值越高， 框的位置就上面
除非专门制定，否则所有的框都在普通流中

## 参考

[CSS 浮动](http://www.w3school.com.cn/css/css_positioning_floating.asp)

[CSS概念 - 可视化格式模型（二） 定位概述（普通流、绝对定位）](https://www.cnblogs.com/blackwood/p/3174154.html)

[什么是BFC](https://www.cnblogs.com/libin-1/p/7098468.html)

[(L)](https://blog.csdn.net/sunny_night)  [sunny_night的博客](https://blog.csdn.net/sunny_night)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 282

[(L)](https://blog.csdn.net/sunny_night/article/details/81183638)[BFC](https://blog.csdn.net/sunny_night/article/details/81183638)、[IFC](https://blog.csdn.net/sunny_night/article/details/81183638)、[GFC](https://blog.csdn.net/sunny_night/article/details/81183638)、[FFC](https://blog.csdn.net/sunny_night/article/details/81183638)  [(L)](https://blog.csdn.net/sunny_night/article/details/81183638)[BFC](https://blog.csdn.net/sunny_night/article/details/81183638)[BFC](https://blog.csdn.net/sunny_night/article/details/81183638)是浏览器在践行渲染标准的时候的术语。为什么这么说呢？[BFC](https://blog.csdn.net/sunny_night/article/details/81183638)有几个参数组成： 1、Box：[css](https://blog.csdn.net/sunny_night/article/details/81183638)布局的基本单位。 Box是[css](https://blog.csdn.net/sunny_night/article/details/81183638)布局的对象和基本单位。直观来说，就是一个页面是由很多个Box组成的。元素的类型和display属性，决定了这个Box的类型。不同类型的Box，会参与不同的Formating Context（一个决定如何渲染文档的容器）,因此Box内的元素会以......

[(L)](https://blog.csdn.net/aprilia_RS660)  [aprilia_RS660的博客](https://blog.csdn.net/aprilia_RS660)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 38

[块级格式化上下文](https://blog.csdn.net/aprilia_RS660/article/details/106609110)[BFC](https://blog.csdn.net/aprilia_RS660/article/details/106609110)  [块级格式化上下文（Block Formatting Context）](https://blog.csdn.net/aprilia_RS660/article/details/106609110)  [BFC](https://blog.csdn.net/aprilia_RS660/article/details/106609110)：它是一块独立的渲染区域，它规定了在该区域中，常规流块盒的布局。不同的[BFC](https://blog.csdn.net/aprilia_RS660/article/details/106609110)区域，他们进行渲染时互不干扰。 具体规则:创建[BFC](https://blog.csdn.net/aprilia_RS660/article/details/106609110)的元素，隔绝了它内部与外部的联系，内部的渲染不会影响到外部 创建[BFC](https://blog.csdn.net/aprilia_RS660/article/details/106609110)的元素，它的自动高度需要计算浮动元素 创建[BFC](https://blog.csdn.net/aprilia_RS660/article/details/106609110)的元素，不会和他的子元素进行外边距合并[BFC](https://blog.csdn.net/aprilia_RS660/article/details/106609110)渲染区域：这个区域由某个HTML元素...

[![anonymous-User-img.png](../_resources/ebdf7b8d2d6a8248a39b7dcafdfcdc5f.png)](http://loadhtml/#)

![commentFlag@2x.png](../_resources/9691c48478c7ead86dba3f18e2b18539.png)

[(L)](https://blog.csdn.net/qq_38152997)  [qq_38152997的博客](https://blog.csdn.net/qq_38152997)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 61

[(L)](https://blog.csdn.net/qq_38152997/article/details/98306952)[bfc](https://blog.csdn.net/qq_38152997/article/details/98306952)块级格式化上下文的原理 [　　由于如浮动、margin值叠加等时候会用到](https://blog.csdn.net/qq_38152997/article/details/98306952)[BFC](https://blog.csdn.net/qq_38152997/article/details/98306952)，但让我详细说[BFC](https://blog.csdn.net/qq_38152997/article/details/98306952)到底是什么，有说不清楚，所以决定对[BFC](https://blog.csdn.net/qq_38152997/article/details/98306952)的知识进行一个整理。1.[BFC](https://blog.csdn.net/qq_38152997/article/details/98306952)是什么　　[BFC](https://blog.csdn.net/qq_38152997/article/details/98306952)中三个英文字母B、F、C分别是Block（块级盒子）、Formatting（格式化）、Context（上下文）。　　[BFC](https://blog.csdn.net/qq_38152997/article/details/98306952)的中文意思是块级格式化上下文。简单的理解[BFC](https://blog.csdn.net/qq_38152997/article/details/98306952)，其从样式上和普通盒子没有什么区别，其从功能上可以将其看作是隔离了的......

[(L)](https://blog.csdn.net/qq_32422537)  [白日梦先生的博客](https://blog.csdn.net/qq_32422537)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 1413

[深入理解块级格式化上下文(](https://blog.csdn.net/qq_32422537/article/details/79760786)[BFC](https://blog.csdn.net/qq_32422537/article/details/79760786)) [一、 什么是](https://blog.csdn.net/qq_32422537/article/details/79760786)[BFC](https://blog.csdn.net/qq_32422537/article/details/79760786)块级格式化上下文，Block Formatting Context，也就是常说的[BFC](https://blog.csdn.net/qq_32422537/article/details/79760786)，它是Web页面的可视化[CSS](https://blog.csdn.net/qq_32422537/article/details/79760786)渲染区域的一部分，是布局过程中生成块级盒子的区域，也是浮动元素与其他元素的交互限定区域。 [BFC](https://blog.csdn.net/qq_32422537/article/details/79760786)的布局规则如下：内部的盒子会在垂直方向，一个一个地放置[BFC](https://blog.csdn.net/qq_32422537/article/details/79760786)是页面上的一个隔离的独立容器属于同一个[BFC](https://blog.csdn.net/qq_32422537/article/details/79760786)的两个相邻Box的上下margin会发生重叠计算......

[(L)](https://blog.csdn.net/ll990207/article/details/107190585)[BFC](https://blog.csdn.net/ll990207/article/details/107190585)块级格式化上下文_ll990207的博客-CSDN博客

7-7

[(L)](https://blog.csdn.net/ll990207/article/details/107190585)[BFC](https://blog.csdn.net/ll990207/article/details/107190585)定义块格式化上下文(Block Formatting Context,[BFC](https://blog.csdn.net/ll990207/article/details/107190585)) 是Web页面的可视[CSS](https://blog.csdn.net/ll990207/article/details/107190585)渲染的一部分,是块盒子的布局过程发生的区域,也是浮动元素与其他元素交互的区域。[BFC](https://blog.csdn.net/ll990207/article/details/107190585)触发...

[(L)](https://blog.csdn.net/weixin_34378045/article/details/88487279)[CSS](https://blog.csdn.net/weixin_34378045/article/details/88487279)格式化上下文之[GFC](https://blog.csdn.net/weixin_34378045/article/details/88487279)、[FFC](https://blog.csdn.net/weixin_34378045/article/details/88487279) - weixin_34378045的博客 - CSDN博客

4-17

[(L)](https://blog.csdn.net/weixin_34378045/article/details/88487279)[GFC](https://blog.csdn.net/weixin_34378045/article/details/88487279)(GridLayout Formatting Contexts)直译为"网格布局格式化上下文",当为一个元素设置display值为grid的时候,此元素将会获得一个独立的渲染区域,我们可以通过在网格容器...

[(L)](https://blog.csdn.net/qq_22972501)  [Adir的博客](https://blog.csdn.net/qq_22972501)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 1921

[(L)](https://blog.csdn.net/qq_22972501/article/details/52830918)[BFC](https://blog.csdn.net/qq_22972501/article/details/52830918)、[IFC](https://blog.csdn.net/qq_22972501/article/details/52830918)、[GFC](https://blog.csdn.net/qq_22972501/article/details/52830918)和[FFC](https://blog.csdn.net/qq_22972501/article/details/52830918)  [(L)](https://blog.csdn.net/qq_22972501/article/details/52830918)[BFC](https://blog.csdn.net/qq_22972501/article/details/52830918)  [BFC](https://blog.csdn.net/qq_22972501/article/details/52830918)(Block Formatting Contexts)意为“块级格式化上下文”。就是页面上的一个渲染区域，容器内的子元素不会对外面的元素布局产生影响，反之亦然。如何生成[BFC](https://blog.csdn.net/qq_22972501/article/details/52830918)： float的值不为none; overflow的值不为visible; position的值不为relative和static; display的值为table-cell,table-caption何...

[(L)](https://blog.csdn.net/weixin_30627341)  [weixin_30627341的博客](https://blog.csdn.net/weixin_30627341)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 116

[(L)](https://blog.csdn.net/weixin_30627341/article/details/95184454)[BFC](https://blog.csdn.net/weixin_30627341/article/details/95184454)，[IFC](https://blog.csdn.net/weixin_30627341/article/details/95184454)，[GFC](https://blog.csdn.net/weixin_30627341/article/details/95184454)，[FFC](https://blog.csdn.net/weixin_30627341/article/details/95184454)的定义及功能 [What's FC？一定不是KFC，FC的全称是：Formatting Contexts，是W3C](https://blog.csdn.net/weixin_30627341/article/details/95184454)  [CSS](https://blog.csdn.net/weixin_30627341/article/details/95184454)2.1规范中的一个概念。它是页面中的一块渲染区域，并且有一套渲染规则，它决定了其子元素将如何定位，以及和其他元素的关系和相互作用。[BFC](https://blog.csdn.net/weixin_30627341/article/details/95184454)[BFC](https://blog.csdn.net/weixin_30627341/article/details/95184454)(Block Formatting Contexts)直译为"块级格式化上下文"。Block Formatting Contexts就是页面上......

[(L)](https://blog.csdn.net/qq_39454432/article/details/106969744)[BFC](https://blog.csdn.net/qq_39454432/article/details/106969744) (块级格式化上下文)_qq_39454432的博客-CSDN博客

6-26

[(L)](https://blog.csdn.net/qq_39454432/article/details/106969744)[BFC](https://blog.csdn.net/qq_39454432/article/details/106969744) (块级格式化上下文)[BFC](https://blog.csdn.net/qq_39454432/article/details/106969744)简述: [BFC](https://blog.csdn.net/qq_39454432/article/details/106969744)即 Block Formatting Contexts (块级格式化上下文),是 W3C [CSS](https://blog.csdn.net/qq_39454432/article/details/106969744)2.1 规范中的一个渲染规范,是页面中的一块渲染区域并且有...

[(L)](https://blog.csdn.net/qq_45803199/article/details/105998276)[BFC](https://blog.csdn.net/qq_45803199/article/details/105998276)(块级格式化上下文)_qq_45803199的博客-CSDN博客

7-2

[学习目标:理解](https://blog.csdn.net/qq_45803199/article/details/105998276)[BFC](https://blog.csdn.net/qq_45803199/article/details/105998276)了解渐进增强和优雅降级typora-copy-images-to: media[BFC](https://blog.csdn.net/qq_45803199/article/details/105998276)(块级格式化上下文)[BFC](https://blog.csdn.net/qq_45803199/article/details/105998276)(Block formatting context)直译为块级格式化上下文。元素的显示模式...

[(L)](https://blog.csdn.net/m0_37686205)  [阳光下的冷静的博客](https://blog.csdn.net/m0_37686205)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 73

[(L)](https://blog.csdn.net/m0_37686205/article/details/100053324)[BFC](https://blog.csdn.net/m0_37686205/article/details/100053324)、[IFC](https://blog.csdn.net/m0_37686205/article/details/100053324)、[GFC](https://blog.csdn.net/m0_37686205/article/details/100053324) 和 [FFC](https://blog.csdn.net/m0_37686205/article/details/100053324)  [(L)](https://blog.csdn.net/m0_37686205/article/details/100053324)[BFC](https://blog.csdn.net/m0_37686205/article/details/100053324)（Block formatting contexts）：块级格式上下文页面上的一个隔离的渲染区域，那么他是如何产生的呢？可以触发[BFC](https://blog.csdn.net/m0_37686205/article/details/100053324)的元素有float、position、overflow、display：table-cell/ inline-block/table-caption ；[BFC](https://blog.csdn.net/m0_37686205/article/details/100053324)有什么作用呢？比如说实现多栏布局’[IFC](https://blog.csdn.net/m0_37686205/article/details/100053324)（Inline formatting contexts）......

[(L)](https://blog.csdn.net/qq_35125764)  [qq_35125764的博客](https://blog.csdn.net/qq_35125764)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 57

[十分钟让你搞懂](https://blog.csdn.net/qq_35125764/article/details/103873149)[BFC](https://blog.csdn.net/qq_35125764/article/details/103873149)  [IFC](https://blog.csdn.net/qq_35125764/article/details/103873149)  [GFC](https://blog.csdn.net/qq_35125764/article/details/103873149)  [FFC](https://blog.csdn.net/qq_35125764/article/details/103873149)  [什么是Formatting context(格式上下文)?Formatting context 是 W3C](https://blog.csdn.net/qq_35125764/article/details/103873149)  [CSS](https://blog.csdn.net/qq_35125764/article/details/103873149)2.1 规范中的一个概念。它是页面中的一块渲染区域，并且有一套渲染规则，它决定了其子元素将如何定位，以及和其他元素的关系和相互作用.Box：[css](https://blog.csdn.net/qq_35125764/article/details/103873149)的基本单位Box 是[css](https://blog.csdn.net/qq_35125764/article/details/103873149)的布局的基本单位，一个页面可以看作是由很多个box组成的。不同类型的box,会参与不同的Formatti......

[(L)](https://blog.csdn.net/qq_22253617/article/details/79053766)[CSS](https://blog.csdn.net/qq_22253617/article/details/79053766)的两种格式化上下文:[BFC](https://blog.csdn.net/qq_22253617/article/details/79053766)和[IFC](https://blog.csdn.net/qq_22253617/article/details/79053766)_qq_22253617的博客-CSDN博客

5-20

[这篇文章具体介绍了](https://blog.csdn.net/qq_22253617/article/details/79053766)[CSS](https://blog.csdn.net/qq_22253617/article/details/79053766)针对block-level元素和inline-level元素设计的两种格式化上下文:[BFC](https://blog.csdn.net/qq_22253617/article/details/79053766)(Block Formatting Context)和[IFC](https://blog.csdn.net/qq_22253617/article/details/79053766)(Inline Formatting Context),它们规定了block-...

[块级格式化上下文](https://blog.csdn.net/aprilia_RS660/article/details/106609110)[BFC](https://blog.csdn.net/aprilia_RS660/article/details/106609110)_aprilia_RS660的博客-CSDN博客

6-8

[块级格式化上下文(BlockFormattingContext)](https://blog.csdn.net/aprilia_RS660/article/details/106609110)[BFC](https://blog.csdn.net/aprilia_RS660/article/details/106609110):它是一块独立的渲染区域,它规定了在该区域中,常规流块盒的布局。不同的[BFC](https://blog.csdn.net/aprilia_RS660/article/details/106609110)区域,他们进行渲染时互不干扰。具体...

[(L)](https://blog.csdn.net/WuLex)  [极客神殿](https://blog.csdn.net/WuLex)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 57

[(L)](https://blog.csdn.net/WuLex/article/details/99626766)[CSS](https://blog.csdn.net/WuLex/article/details/99626766)-格式化上下文（Formatting Context） [Formatting Context：指页面中的一个渲染区域，并且拥有一套渲染规则，他决定了其子元素如何定位，以及与其他元素的相互关系和作用。](https://blog.csdn.net/WuLex/article/details/99626766)[BFC](https://blog.csdn.net/WuLex/article/details/99626766)块级格式化上下文，它是指一个独立的块级渲染区域，只有 Block-level BOX 参与，该区域拥有一套渲染规则来约束块级盒子的布局，且与区域外部无关。生成浮动, 绝对定位元素, 和 display 属性为 inline-boxs、table......

[(L)](https://blog.csdn.net/u010552788)  [u010552788的专栏](https://blog.csdn.net/u010552788)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 320

[(L)](https://blog.csdn.net/u010552788/article/details/50988930)[BFC](https://blog.csdn.net/u010552788/article/details/50988930)(块级格式化上下文) [(L)](https://blog.csdn.net/u010552788/article/details/50988930)[BFC](https://blog.csdn.net/u010552788/article/details/50988930)(块级格式化上下文)字数1536 阅读990 评论1 喜欢8[BFC](https://blog.csdn.net/u010552788/article/details/50988930)(块级格式化上下文)@([CSS](https://blog.csdn.net/u010552788/article/details/50988930))[[CSS](https://blog.csdn.net/u010552788/article/details/50988930)|[BFC](https://blog.csdn.net/u010552788/article/details/50988930)][TOC]　　已经是一个耳听熟闻的词语了，网上有许多关于 [BFC](https://blog.csdn.net/u010552788/article/details/50988930) 的文章，介绍了如何触发 [BFC](https://blog.csdn.net/u010552788/article/details/50988930) 以及 [BFC](https://blog.csdn.net/u010552788/article/details/50988930) 的一些用处（如清浮动，防止 margin 重叠等）。虽然我知道如何利用 [BFC](https://blog.csdn.net/u010552788/article/details/50988930) 解决这些问题，但当别人问我 [BFC](https://blog.csdn.net/u010552788/article/details/50988930) 是什么，我...

[(L)](https://blog.csdn.net/e1172090224/article/details/88683548)[BFC](https://blog.csdn.net/e1172090224/article/details/88683548)、[IFC](https://blog.csdn.net/e1172090224/article/details/88683548)、[GFC](https://blog.csdn.net/e1172090224/article/details/88683548)、[FFC](https://blog.csdn.net/e1172090224/article/details/88683548)_e1172090224的博客-CSDN博客

5-30

[(L)](https://blog.csdn.net/e1172090224/article/details/88683548)[BFC](https://blog.csdn.net/e1172090224/article/details/88683548)Block Formatting Context)块级格式化上下文,指的是一个独立的块级渲染区域,拥有一套独立的渲染规则,该区域拥有一套渲染规则来约束块级盒子的布局,且与区域外部...

[前端的](https://blog.csdn.net/qq_22855325/article/details/76153101)[BFC](https://blog.csdn.net/qq_22855325/article/details/76153101)、[IFC](https://blog.csdn.net/qq_22855325/article/details/76153101)、[GFC](https://blog.csdn.net/qq_22855325/article/details/76153101)和[FFC](https://blog.csdn.net/qq_22855325/article/details/76153101)_[css](https://blog.csdn.net/qq_22855325/article/details/76153101),[css](https://blog.csdn.net/qq_22855325/article/details/76153101)3,前端_YinghaoGuo的..._CSDN博客

1-6

[什么是](https://blog.csdn.net/qq_22855325/article/details/76153101)[BFC](https://blog.csdn.net/qq_22855325/article/details/76153101)、[IFC](https://blog.csdn.net/qq_22855325/article/details/76153101)、[GFC](https://blog.csdn.net/qq_22855325/article/details/76153101)和[FFC](https://blog.csdn.net/qq_22855325/article/details/76153101)[CSS](https://blog.csdn.net/qq_22855325/article/details/76153101)2.1中只有[BFC](https://blog.csdn.net/qq_22855325/article/details/76153101)和[IFC](https://blog.csdn.net/qq_22855325/article/details/76153101), [CSS](https://blog.csdn.net/qq_22855325/article/details/76153101)3中才有[GFC](https://blog.csdn.net/qq_22855325/article/details/76153101)和[FFC](https://blog.csdn.net/qq_22855325/article/details/76153101)... 3、[GFC](https://blog.csdn.net/qq_22855325/article/details/76153101)([css](https://blog.csdn.net/qq_22855325/article/details/76153101)3) [GFC](https://blog.csdn.net/qq_22855325/article/details/76153101)(GridLayout Formatting Contexts)直译为"网格布局格式化上下文",当...

[静态补充](https://blog.csdn.net/weixin_45281192/article/details/103201561)[CSS](https://blog.csdn.net/weixin_45281192/article/details/103201561)-[BFC](https://blog.csdn.net/weixin_45281192/article/details/103201561)、[IFC](https://blog.csdn.net/weixin_45281192/article/details/103201561)、[FFC](https://blog.csdn.net/weixin_45281192/article/details/103201561)、[GFC](https://blog.csdn.net/weixin_45281192/article/details/103201561)_weixin_45281192的博客-CSDN博客

8-1

[(L)](https://blog.csdn.net/weixin_45281192/article/details/103201561)[GFC](https://blog.csdn.net/weixin_45281192/article/details/103201561)简介 [GFC](https://blog.csdn.net/weixin_45281192/article/details/103201561)全称:Grids Formatting Context网格格式化上下文 简介: [CSS](https://blog.csdn.net/weixin_45281192/article/details/103201561)3引入的一种新的布局模型——Grids网格布局,目前暂未推广使用,使用频率较低,简单了解即可。 Gri...

©️2020 CSDN  皮肤主题: 大白  设计师: CSDN官方博客  [返回首页](https://blog.csdn.net/)

[关于我们](https://www.csdn.net/company/index.html#about)  [招聘](https://www.csdn.net/company/index.html#recruit)  [广告服务](https://www.csdn.net/company/index.html#advertisement)  [网站地图](https://www.csdn.net/gather/A)  ![](data:image/svg+xml,%3csvg width='16' height='16' xmlns='http://www.w3.org/2000/svg' data-evernote-id='2739' class='js-evernote-checked'%3e%3cpath d='M2.167 2h11.666C14.478 2 15 2.576 15 3.286v9.428c0 .71-.522 1.286-1.167 1.286H2.167C1.522 14 1 13.424 1 12.714V3.286C1 2.576 1.522 2 2.167 2zm-.164 3v1L8 10l6-4V5L8 9 2.003 5z' fill='%23999AAA' fill-rule='evenodd' data-evernote-id='2740' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  [(L)](https://blog.csdn.net/YQRQR/article/details/83217710mailto:webmaster@csdn.net)[kefu@csdn.net](https://blog.csdn.net/YQRQR/article/details/83217710mailto:webmaster@csdn.net)![](data:image/svg+xml,%3csvg t='1538012951761' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23083' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2741' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2742' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2743' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M466.4934485 880.02006511C264.6019863 859.18313878 107.13744214 688.54706608 107.13744214 481.14947309 107.13744214 259.68965394 286.68049114 80.14660493 508.14031029 80.14660493s401.00286817 179.54304901 401.00286814 401.00286816v1.67343191C908.30646249 737.58941724 715.26799489 943.85339507 477.28978337 943.85339507c-31.71423369 0-62.61874229-3.67075386-92.38963569-10.60739903 30.09478346-11.01226158 56.84270313-29.63593923 81.5933008-53.22593095z m-205.13036267-398.87059202a246.77722444 246.77722444 0 0 0 493.5544489 0 30.85052691 30.85052691 0 0 0-61.70105383 0 185.07617062 185.07617062 0 0 1-370.15234125 0 30.85052691 30.85052691 0 0 0-61.70105382 0z' p-id='23084' fill='%23999AAA' data-evernote-id='2744' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  [(L)](http://bbs.csdn.net/forums/Service)[客服论坛](http://bbs.csdn.net/forums/Service)![](data:image/svg+xml,%3csvg t='1538013874294' width='17' height='17' style='' viewBox='0 0 1194 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23784' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2745' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2746' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2747' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M1031.29689505 943.85339507h-863.70679012A71.98456279 71.98456279 0 0 1 95.60554212 871.86883228v-150.85178906c0-28.58329658 16.92325492-54.46750945 43.13135785-65.93861527l227.99160176-99.75813425c10.55341735-4.61543317 18.24580594-14.0082445 20.72896295-25.23643277l23.21211998-105.53417343a71.95757195 71.95757195 0 0 1 70.28414006-56.51881307h236.95255971c33.79252817 0 63.02360485 23.5090192 70.28414004 56.51881307l23.21211997 105.53417343c2.48315701 11.25517912 10.17554562 20.62099961 20.72896296 25.23643277l227.99160177 99.75813425a71.98456279 71.98456279 0 0 1 43.13135783 65.93861527v150.85178906A71.98456279 71.98456279 0 0 1 1031.26990421 943.85339507z m-431.85339506-143.94213475c143.94213474 0 143.94213474-48.34058941 143.94213474-107.96334876s-64.45411922-107.96334877-143.94213474-107.96334877c-79.51500637 0-143.94213474 48.34058941-143.94213475 107.96334877s0 107.96334877 143.94213475 107.96334876zM1103.254467 296.07330247v148.9894213a35.97878598 35.97878598 0 0 1-44.15700966 35.03410667l-143.94213473-33.57660146a36.0057768 36.0057768 0 0 1-27.80056231-35.03410668V296.1002933c-35.97878598-47.98970852-131.95820302-71.98456279-287.91126031-71.98456279S347.53801649 248.11058478 311.53223967 296.1002933v115.385829c0 16.73431906-11.52508749 31.25538946-27.80056233 35.03410668l-143.94213473 33.57660146A35.97878598 35.97878598 0 0 1 95.63253297 445.06272377V296.07330247C162.81272673 152.13116772 330.77670658 80.14660493 599.47049084 80.14660493s436.63077325 71.98456279 503.81096699 215.92669754z' p-id='23785' fill='%23999AAA' data-evernote-id='2748' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  400-660-0108  ![](data:image/svg+xml,%3csvg t='1538013544186' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23556' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2749' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2750' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2751' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M902.60033922 650.96445566c-18.0718526-100.84369837-94.08399771-166.87723736-94.08399771-166.87723737 10.87530062-91.53186599-28.94715402-107.78733693-28.94715401-107.78733691C771.20003413 93.08221664 517.34798062 98.02553561 511.98620441 98.16348824 506.65661791 98.02553561 252.75857992 93.08221664 244.43541101 376.29988138c0 0-39.79946279 16.25547094-28.947154 107.78733691 0 0-75.98915247 66.03353901-94.0839977 166.87723737 0 0-9.63372291 170.35365477 86.84146124 20.85850523 0 0 21.70461757 56.79068296 61.50407954 107.78733692 0 0-71.1607951 23.19910867-65.11385185 83.46161052 0 0-2.43717093 67.16015592 151.93232126 62.56172014 0 0 108.5460788-8.0932473 141.10300432-52.14626271H526.33792324c32.57991817 44.05301539 141.10300431 52.1462627 141.10300431 52.14626271 154.3235077 4.59843579 151.95071457-62.56172013 151.95071457-62.56172014 6.00095876-60.26250183-65.11385185-83.46161053-65.11385185-83.46161052 39.77647014-50.99665395 61.4810877-107.78733693 61.4810877-107.78733692 96.45219231 149.49514952 86.84146124-20.85850523 86.84146125-20.85850523' p-id='23557' fill='%23999AAA' data-evernote-id='2752' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)[(L)](https://url.cn/5epoHIm?_type=wpa&qidian=true)[QQ客服（8:30-22:00）](https://url.cn/5epoHIm?_type=wpa&qidian=true)

[公安备案号 11010502030143](http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010502030143)  [京ICP备19004658号](http://beian.miit.gov.cn/publish/query/indexFirst.action)  [京网文〔2020〕1039-165号](https://csdnimg.cn/release/live_fe/culture_license.png)  [版权与免责声明](https://www.csdn.net/company/index.html#statement)  [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)  [网络110报警服务](http://www.cyberpolice.cn/)

[中国互联网举报中心](http://www.12377.cn/)  [家长监护](https://download.csdn.net/index.php/tutelage/)  [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)  [北京互联网违法和不良信息举报中心](http://www.bjjubao.org/)  ©1999-2020 北京创新乐知网络技术有限公司
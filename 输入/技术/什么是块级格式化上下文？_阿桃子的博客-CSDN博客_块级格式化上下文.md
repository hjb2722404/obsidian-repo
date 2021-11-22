什么是块级格式化上下文？_阿桃子的博客-CSDN博客_块级格式化上下文



[![csdn-logo.png](../_resources/f644837a2aad496e397a83031b0bdfd5.png)](https://www.csdn.net/)
[博客](https://blog.csdn.net/)
[学院](https://edu.csdn.net/)
[下载](https://download.csdn.net/)
[论坛](https://bbs.csdn.net/)
[问答](https://ask.csdn.net/)
[直播](https://live.csdn.net/)
[招聘](http://job.csdn.net/)
[VIP会员](https://mall.csdn.net/vip)
![csdn-sou.png](../_resources/07f4099b8587cb1747aa74f644f610db.png)
[(L)](https://mp.csdn.net/)[创作中心](https://mp.csdn.net/)

[登录/注册](https://passport.csdn.net/account/login)

# 什么是块级格式化上下文？

![reprint.png](../_resources/dbf543fd90d5a6de481a60cc5d1caad1.png)

[阿桃子](https://me.csdn.net/taotao6039)  2014-07-07 16:56:05  ![articleReadEyes.png](../_resources/c4360f77d43b7f3fdc7b1e070f32dfd4.png)  2809  ![tobarCollect.png](../_resources/5dad7f82dd0d8ba01fecbf11a059a7cd.png)  收藏  1

分类专栏：  [CSS3](https://blog.csdn.net/taotao6039/category_1833377.html)

转文请标明 --- 出处：穆乙 http://www.cnblogs.com/pigtail/

## 一、BFC是什么？

BFC（Block Formatting Context）直译为“块级格式化范围”。

是 W3C CSS 2.1 规范中的一个概念，它决定了元素如何对其内容进行定位，以及与其他元素的关系和相互作用。当涉及到可视化布局的时候，Block Formatting Context提供了一个环境，HTML元素在这个环境中按照一定规则进行布局。一个环境中的元素不会影响到其它环境中的布局。比如浮动元素会形成BFC，浮动元素内部子元素的主要受该浮动元素影响，两个浮动元素之间是互不影响的。这里有点类似一个BFC就是一个独立的行政单位的意思。也可以说BFC就是一个作用范围。可以把它理解成是一个独立的容器，并且这个容器的里box的布局，与这个容器外的毫不相干。

另一个通俗点的解释是：在普通流中的 Box(框) 属于一种 formatting context(格式化上下文) ，类型可以是 block ，或者是 inline ，但不能同时属于这两者。并且， Block boxes(块框) 在 block formatting context(块格式化上下文) 里格式化， Inline boxes(块内框) 则在 inline formatting context(行内格式化上下文) 里格式化。任何被渲染的元素都属于一个 box ，并且不是 block ，就是 inline 。即使是未被任何元素包裹的文本，根据不同的情况，也会属于匿名的 block boxes 或者 inline boxes。所以上面的描述，即是把所有的元素划分到对应的 formatting context 里。

其一般表现规则，我整理了以下这几个情况：

1、在创建了 Block Formatting Context 的元素中，其子元素按文档流一个接一个地放置。垂直方向上他们的起点是一个包含块的顶部，两个相邻的元素之间的垂直距离取决于 ‘margin’ 特性。

    根据 CSS 2.1 [8.3.1 Collapsing margins](http://www.w3.org/TR/CSS21/box.html#collapsing-margins) 第一条，两个相邻的普通流中的块框在垂直位置的空白边会发生折叠现象。也就是处于同一个BFC中的两个垂直窗口的margin会重叠。

    根据 CSS 2.1 [8.3.1 Collapsing margins](http://www.w3.org/TR/CSS21/box.html#collapsing-margins) 第三条，生成 block formatting context 的元素不会和在流中的子元素发生空白边折叠。所以解决这种问题的办法是要为两个容器添加具有BFC的包裹容器。

2、在 Block Formatting Context 中，每一个元素左外边与包含块的左边相接触（对于从右到左的格式化，右外边接触右边）， 即使存在浮动也是如此（尽管一个元素的内容区域会由于浮动而压缩），除非这个元素也创建了一个新的 Block Formatting Context 。

3、Block Formatting Context就是页面上的一个隔离的独立容器，容器里面的子元素不会在布局上影响到外面的元素，反之也是如此。
4、根据 CSS 2.1 9.5 Floats 中的描述，创建了 Block Formatting Context 的元素不能与浮动元素重叠。

    表格的 border-box、块级的替换元素、或是在普通流中创建了新的 block formatting context（如元素的 'overflow' 特性不为 'visible' 时）的元素不可以与位于相同的 block formatting context 中的浮动元素相重叠。

5 、当容器有足够的剩余空间容纳 BFC 的宽度时，所有浏览器都会将 BFC 放置在浮动元素所在行的剩余空间内。

6、 在 IE6 IE7 IE8 Chrome Opera 中，当 BFC 的宽度介于 "容器剩余宽度" 与 "容器宽度" 之间时，BFC 会显示在浮动元素的下一行；在 Safari 中，BFC 则仍然保持显示在浮动元素所在行，并且 BFC 溢出容器；在 Firefox 中，当容器本身也创建了 BFC 或者容器的 'padding-top'、'border-top-width' 这些特性不都为 0 时表现与 IE8(S)、Chrome 类似，否则表现与 Safari 类似。

经验证，最新版本的浏览中只有firefox会在同一行显示，其它浏览器均换行。

7、 在 IE6 IE7 IE8 Opera 中，当 BFC 的宽度大于 "容器宽度" 时，BFC 会显示在浮动元素的下一行；在 Chrome Safari 中，BFC 则仍然保持显示在浮动元素所在行，并且 BFC 溢出容器；在 Firefox 中，当容器本身也创建了 BFC 或者容器的 'padding- top'、'border-top-width' 这些特性不都为 0 时表现与 IE8(S) 类似，否则表现与 Chrome 类似。

经验证，最新版本的浏览中只有firefox会在同一行显示，其它浏览器均换行。

8、根据CSS2.1 规范第[10.6.7](http://www.w3.org/TR/CSS2/visudet.html#root-height)部分的高度计算规则，在计算生成了 block formatting context 的元素的高度时，其浮动子元素应该参与计算。

如果还有其它情况，请各位回得中补充，我会及时更新！
下面先看一个比较典型的例子：
![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)
<!DOCTYPE HTML>
<html>
<head>
<meta  http-equiv="Content-Type"  content="text/html; charset=gb2312">
<title>无标题文档</title>
<style>
*  {  padding:0;  margin:0;  }
#red, #yellow, #orange, #green  {  width:100px;  height:100px;  float:left;  }
#red  {  background-color:red;  }
#yellow  {  background-color:yellow;  }
#orange  {  background-color:orange;  }
#green  {  background-color:green;  }
</style>
</head>

<body>
<div  id="c1">
<div  id="red">
</div>
<div  id="yellow">
</div>
</div>
<div  id="c2">
<div  id="orange">
</div>
<div  id="green">
</div>
</div>
<p>Here is the text!</p>
</body>
</html>
![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)
效果如下：

![22163918-6ed19f54023e43ba93b1ae6a9cd7b9ce.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/7b2ce16cbfe23220d675700c56e9601e.jpg)

该段代码本意要形成两行两列的布局，但是由于#red，#yellow，#orange，#green四个div在同一个布局环境BFC中，因此虽然它们位于两个不同的div（#c1和#c2）中，但仍然不会换行，而是一行四列的排列。

若要使之形成两行两列的布局，就要创建两个不同的布局环境，也可以说要创建两个BFC。那到底怎么创建BFC呢？

## 二、如何产生BFC：当一个HTML元素满足下面条件的任何一点，都可以产生Block Formatting Context：

float的值不为none。
overflow的值不为visible。
display的值为table-cell, table-caption, inline-block中的任何一个。
position的值不为relative和static。
如果还其它方式，请在回复中给出，我会及时更新！！
上面的例子，我再加两行代码，创建两个BFC：
#c1{overflow:hidden;}
#c2{overflow:hidden;}
效果如下：

![22164507-899b0064301443608c2818dbed6625a5.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/277f5a6072a269cbe38f66ac46cfa81d.jpg)

上面创建了两个布局环境BFC。内部子元素的左浮动不会影响到外部元素。所以#c1和#c2没有受浮动的影响，仍然各自占据一行！

## 三、BFC能用来做什么？

 a、不和浮动元素重叠
如果一个浮动元素后面跟着一个非浮动的元素，那么就会产生一个覆盖的现象，很多自适应的两栏布局就是这么做的。
看下面一个例子
![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)
<!DOCTYPE HTML>
<html>
<head>
<meta  http-equiv="Content-Type"  content="text/html; charset=gb2312">
<title>无标题文档</title>
<style>
html,body  {height:100%;  }

*  {  padding:0;  margin:0;  color:#fff;  text-decoration:none;  list-style:none;  font-family:"微软雅黑"  }

.aside{background:#f00;width:170px;float:left;height:300px;}
.main{background:#090;height:100%;}
</style>
</head>

<body>
<div  class="aside">
</div>
<div  class="main">
</div>
</body>
</html>
![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)
效果图如下：

![22165058-38e78fce602b4ce9b860fe07e437e5a3.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/ed4181d60d7cd4181517c50989d017a0.jpg)

很明显，.aside和.mian重叠了。试分析一下，由于两个box都处在同一个BFC中，都是以BFC边界为起点，如果两个box本身都具备BFC的话，会按顺序一个一个排列布局，现在.main并不具备BFC，按照规则2，内部元素都会从左边界开始，除非它本身具备BFC，按上面规则4拥有BFC的元素是不可以跟浮动元素重叠的，所以只要为.mian再创建一个BFC,就可以解决这个重叠的问题。上面已经说过创建BFC的方法，可以根据具体情况选用不同的方法，这里我选用的是加overflow:hidden。

由于ie的原因需要再加一个解发haslayout的zoom:1，有关haslayout后面会讲到。
b、清除元素内部浮动

只要把父元素设为BFC就可以清理子元素的浮动了，最常见的用法就是在父元素上设置overflow: hidden样式，对于IE6加上zoom:1就可以了(IE Haslayout)。

 看下面例子：
![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)
<!DOCTYPE HTML>
<html>
<head>
<meta  http-equiv="Content-Type"  content="text/html; charset=gb2312">
<title>无标题文档</title>
<style>
html,body  {height:100%;  }

*  {  padding:10px;  margin:0;  color:#000;  text-decoration:none;  list-style:none;  font-family:"微软雅黑"  }

.outer{width:300px;border:1px solid #666;padding:10px;}
.innerLeft{height:100px;width:100px;float:left;background:#f00;}
.innerRight{height:100px;width:100px;float:right;background:#090;}
</style>
</head>

<body>
<div  class="outer">
<div  class="innerLeft"></div>
<div  class="innerRight"></div>
</div>
</div>
</body>
</html>
![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)
效果图如下：

![22221139-0d543d2929ae4931ae1cd2b842ef03ff.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/32dcdb9b7f4f1fc7259017489f16f0c7.jpg)

根据 CSS2.1 规范第 [10.6.3](http://www.w3.org/TR/CSS21/visudet.html#normal-block) 部分的高度计算规则，在进行普通流中的块级非替换元素的高度计算时，浮动子元素不参与计算。

同时 CSS2.1 规范第[10.6.7](http://www.w3.org/TR/CSS2/visudet.html#root-height)部分的高度计算规则，在计算生成了 block formatting context 的元素的高度时，其浮动子元素应该参与计算。

所以，触发外部容器BFC，高度将重新计算。比如给outer加上属性overflow:hidden触发其BFC。
c、解决上下相邻两个元素重叠
 看下面例子：
![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)
<!DOCTYPE HTML>
<html>
<head>
<meta  http-equiv="Content-Type"  content="text/html; charset=gb2312">
<title>无标题文档</title>
<style>
html,body  {height:100%;  }

*  {  padding:0;  margin:0;  color:#fff;  text-decoration:none;  list-style:none;  font-family:"微软雅黑"  }

.rowone{background:#f00;height:100px;margin-bottom:20px;overflow:hidden;}
.rowtow{background:#090;height:100px;margin-top:20px;position:relative}
</style>
</head>

<body>
<div  class="rowone">
</div>
<div  class="rowtow">
</div>
</body>
</html>
![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)
效果如下：

![22172143-85d79dc18a24465bacf0342974b51f8c.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/85e268be7d6bd5906da3fd939a16bd0c.jpg)

根据 CSS 2.1 [8.3.1 Collapsing margins](http://www.w3.org/TR/CSS21/box.html#collapsing-margins) 第一条，两个相邻的普通流中的块框在垂直位置的空白边会发生折叠现象。也就是处于同一个BFC中的两个垂直窗口的margin会重叠。

根据 CSS 2.1 [8.3.1 Collapsing margins](http://www.w3.org/TR/CSS21/box.html#collapsing-margins) 第三条，生成 block formatting context 的元素不会和在流中的子元素发生空白边折叠。所以解决这种问题的办法是要为两个容器添加具有BFC的包裹容器。

所以解这个问题的办法就是,把两个容器分别放在两个据有BFC的包裹容器中，IE里就是触发layout的两个包裹容器中！

![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)
<!DOCTYPE HTML>
<html>
<head>
<meta  http-equiv="Content-Type"  content="text/html; charset=gb2312">
<title>无标题文档</title>
<style>
html, body  {  height:100%;  }

*  {  padding:0;  margin:0;  color:#fff;  text-decoration:none;  list-style:none;  font-family:"微软雅黑"  }

.mg  {overflow:hidden;  }
.rowone  {  background:#f00;  height:100px;  margin-bottom:20px;  }
.rowtow  {  background:#090;  height:100px;  margin-top:20px;  }
</style>
</head>

<body>
<div  class="mg">
<div  class="rowone">
</div>
</div>
<div  class="mg">
<div  class="rowtow">
</div>
</div>
</body>
</html>
![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)
效果如下：

![22172555-b85dcd2a91744ea6aa8dc34fbd3befb6.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/b428f42db3416fea2f4393f160d05e47.jpg)

[(L)](https://blog.csdn.net/weixin_40013817)  [weixin_40013817的博客](https://blog.csdn.net/weixin_40013817)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 130

[css面试点-BFC（块级](https://blog.csdn.net/weixin_40013817/article/details/102148906)[格式化](https://blog.csdn.net/weixin_40013817/article/details/102148906)[上下文](https://blog.csdn.net/weixin_40013817/article/details/102148906)）与常见布局方案 [定位方案常见的定位方案，定位方案是控制元素的布局，有三种常见方案:普通流 (normal flow)在普通流中，元素按照其在 HTML 中的先后位置至上而下布局，在这个过程中，行内元素水平排列，直到当行被占满然后换行，块级元素则会被渲染为完整的一个新行，除非另外指定，否则所有元素默认都是普通流定位，也可以说，普通流中元素的位置由该元素在 HTML 文档中的位置决定。浮动 (float......](https://blog.csdn.net/weixin_40013817/article/details/102148906)

[(L)](https://blog.csdn.net/whsw423)  [你猜的博客](https://blog.csdn.net/whsw423)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 2854

[块级](https://blog.csdn.net/whsw423/article/details/50997587)[格式化](https://blog.csdn.net/whsw423/article/details/50997587)[上下文](https://blog.csdn.net/whsw423/article/details/50997587)  [初识块级](https://blog.csdn.net/whsw423/article/details/50997587)[格式化](https://blog.csdn.net/whsw423/article/details/50997587)[上下文](https://blog.csdn.net/whsw423/article/details/50997587)(Block Formatting Contexts)前言html文档中元素的定位有3种方式(普通流、绝对定位、浮动)，除普通流以外，浮动与绝对定位都会导致元素脱离普通流，按照各自的方式进行定位。 带有BFC属性的容器属于普通流的一种。块级[格式化](https://blog.csdn.net/whsw423/article/details/50997587)[上下文](https://blog.csdn.net/whsw423/article/details/50997587) (BFC)块[格式化](https://blog.csdn.net/whsw423/article/details/50997587)[上下文](https://blog.csdn.net/whsw423/article/details/50997587)是页面 CSS 视觉渲染的一部分。它是用于决定块盒子的布局及浮动相互影响范围的一个区域。BFC是元素在...

[![anonymous-User-img.png](../_resources/ebdf7b8d2d6a8248a39b7dcafdfcdc5f.png)](http://loadhtml/#)

![commentFlag@2x.png](../_resources/9691c48478c7ead86dba3f18e2b18539.png)

[(L)](https://blog.csdn.net/yuliying)  [yuliying的专栏](https://blog.csdn.net/yuliying)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 1294

[关于对CSS中BFC (块级](https://blog.csdn.net/yuliying/article/details/78989019)[格式化](https://blog.csdn.net/yuliying/article/details/78989019)[上下文](https://blog.csdn.net/yuliying/article/details/78989019)) 的理解 [转自: https://www.thinktxt.com/web-front/2017/02/18/css-bfc-layout-model.html也许你已经掌握了HTML、CSS的基本布局技能，但是有可能还有一些难以琢磨透的专业名词还不是很清楚，比如BFC。今天我们就来聊聊对BFC的理解，以便我们在布局的过程中能够更加得心应手。概念BFC(Block Formatt...](https://blog.csdn.net/yuliying/article/details/78989019)

[(L)](https://blog.csdn.net/zqixiao_09)  [知秋一叶](https://blog.csdn.net/zqixiao_09)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 4418

[进程](https://blog.csdn.net/zqixiao_09/article/details/50877756)[上下文](https://blog.csdn.net/zqixiao_09/article/details/50877756)、中断[上下文](https://blog.csdn.net/zqixiao_09/article/details/50877756)及原子[上下文](https://blog.csdn.net/zqixiao_09/article/details/50877756)  [谈论进程](https://blog.csdn.net/zqixiao_09/article/details/50877756)[上下文](https://blog.csdn.net/zqixiao_09/article/details/50877756) 、中断[上下文](https://blog.csdn.net/zqixiao_09/article/details/50877756) 、 原子[上下文](https://blog.csdn.net/zqixiao_09/article/details/50877756)之前，有必要讨论下两个概念：a -- [上下文](https://blog.csdn.net/zqixiao_09/article/details/50877756)       [上下文](https://blog.csdn.net/zqixiao_09/article/details/50877756)是从英文context翻译过来，指的是一种环境。相对于进程而言，就是进程执行时的环境；       具体来说就是各个变量和数据，包括所有的寄存器变量、进程打开的文件、内存信息等。b -- 原子       原子（atom）本意是“不能被进一步分割的最小粒子”，而原子操作（...

[块级](https://blog.csdn.net/whsw423/article/details/50997587)[格式化](https://blog.csdn.net/whsw423/article/details/50997587)[上下文](https://blog.csdn.net/whsw423/article/details/50997587)_你猜的博客-CSDN博客_块级[格式化](https://blog.csdn.net/whsw423/article/details/50997587)[上下文](https://blog.csdn.net/whsw423/article/details/50997587)

8-5

[初识块级](https://blog.csdn.net/whsw423/article/details/50997587)[格式化](https://blog.csdn.net/whsw423/article/details/50997587)[上下文](https://blog.csdn.net/whsw423/article/details/50997587)(Block Formatting Contexts)前言html文档中元素的定位有3种方式(普通流、绝对定位、浮动),除普通流以外,浮动与绝对定位都会导致元素脱离普通流...

[块级](https://blog.csdn.net/JEFF_luyiduan/article/details/107726378)[格式化](https://blog.csdn.net/JEFF_luyiduan/article/details/107726378)[上下文](https://blog.csdn.net/JEFF_luyiduan/article/details/107726378)_JEFF_xieyuzhi的博客-CSDN博客

8-1

[文章目录块级](https://blog.csdn.net/JEFF_luyiduan/article/details/107726378)[格式化](https://blog.csdn.net/JEFF_luyiduan/article/details/107726378)[上下文](https://blog.csdn.net/JEFF_luyiduan/article/details/107726378)块级[格式化](https://blog.csdn.net/JEFF_luyiduan/article/details/107726378)[上下文](https://blog.csdn.net/JEFF_luyiduan/article/details/107726378)全称Block Formatting Context, 简称BFC它是一块独立的渲染区域,它规定了在该区域中,常规流块盒的布局不同的BFC区域,它们...

[(L)](https://blog.csdn.net/zhiyu520)  [汁语在师大](https://blog.csdn.net/zhiyu520)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 1万+

[进程](https://blog.csdn.net/zhiyu520/article/details/2719827)[上下文](https://blog.csdn.net/zhiyu520/article/details/2719827)和中断[上下文](https://blog.csdn.net/zhiyu520/article/details/2719827)  [  进程](https://blog.csdn.net/zhiyu520/article/details/2719827)[上下文](https://blog.csdn.net/zhiyu520/article/details/2719827)和中断[上下文](https://blog.csdn.net/zhiyu520/article/details/2719827)是操作系统中很重要的两个概念，这两个概念在操作系统课程中不断被提及，是最经常接触、看上去很懂但又说不清楚到底怎么回事。造成这种局面的原因，可能是原来接触到的操作系统课程的教学总停留在一种浅层次的理论层面上，没有深入去研究。处理器总处于以下状态中的一种：１、内核态，运行于进程[上下文](https://blog.csdn.net/zhiyu520/article/details/2719827)，内核代表进程运行于内核空间；２、内核态，运行于中断[上下文](https://blog.csdn.net/zhiyu520/article/details/2719827)，内核代表硬件运行于内核空间；３...

[(L)](https://blog.csdn.net/cherry8179)  [cherry8179的博客](https://blog.csdn.net/cherry8179)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 106

[块级](https://blog.csdn.net/cherry8179/article/details/100633297)[格式化](https://blog.csdn.net/cherry8179/article/details/100633297)[上下文](https://blog.csdn.net/cherry8179/article/details/100633297)（BFC）和行内[格式化](https://blog.csdn.net/cherry8179/article/details/100633297)[上下文](https://blog.csdn.net/cherry8179/article/details/100633297)（IFC） [这两天一直在研究盒子模型，bfc，ifc等相关内容，其中错综复杂的关系在我脑袋里捋了很多遍，以下为总结（可能有误）： 备用图片： 一.普通流 1.Normal flow. In CSS 2.1, normal flow includes block formatting of b...](https://blog.csdn.net/cherry8179/article/details/100633297)

[块级](https://blog.csdn.net/weixin_46544600/article/details/105327182)[格式化](https://blog.csdn.net/weixin_46544600/article/details/105327182)[上下文](https://blog.csdn.net/weixin_46544600/article/details/105327182)_weixin_46544600的博客-CSDN博客

7-3

[常规流块盒 在水平方向上,必须撑满包含块 常规流块盒 在包含块的垂直方向上依次摆放 常规流块盒 若外边距无缝隙相邻,则进行外边距合并 常规流块盒 的自动高度...](https://blog.csdn.net/weixin_46544600/article/details/105327182)

[块级](https://blog.csdn.net/weixin_45670020/article/details/106837223)[格式化](https://blog.csdn.net/weixin_45670020/article/details/106837223)[上下文](https://blog.csdn.net/weixin_45670020/article/details/106837223)_WAWA战士的博客-CSDN博客

6-18

[一、 什么是BFC块级](https://blog.csdn.net/weixin_45670020/article/details/106837223)[格式化](https://blog.csdn.net/weixin_45670020/article/details/106837223)[上下文](https://blog.csdn.net/weixin_45670020/article/details/106837223),Block Formatting Context,也就是常说的BFC,它是Web页面的可视化CSS渲染区域的一部分,是布局过程中生成块级盒子的区域,也是浮动元素...

[(L)](https://blog.csdn.net/line233)  [line233的博客](https://blog.csdn.net/line233)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 98

[BFC（块级](https://blog.csdn.net/line233/article/details/89071537)[格式化](https://blog.csdn.net/line233/article/details/89071537)[上下文](https://blog.csdn.net/line233/article/details/89071537)） [block format context(块级](https://blog.csdn.net/line233/article/details/89071537)[格式化](https://blog.csdn.net/line233/article/details/89071537)[上下文](https://blog.csdn.net/line233/article/details/89071537))，它决定了元素如何对其内容进行定位，以及与其他元素的关系和相互作用，当涉及到可视化布局的时候，BFC提供了一个环境 html元素在这个环境中按照一定的规则进行布局。实际上，BFC提供了一个独立的空间，让空间里的子元素不会影响到外面的布局（如下图）具体实现是为元素设置一些CSS属性，来触发这一空间：触发规则： ......

[(L)](https://blog.csdn.net/qq_39083004)  [Maha](https://blog.csdn.net/qq_39083004)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 112

[BFC-块](https://blog.csdn.net/qq_39083004/article/details/79499216)[格式化](https://blog.csdn.net/qq_39083004/article/details/79499216)[上下文](https://blog.csdn.net/qq_39083004/article/details/79499216)  [最近见群里面试题，不停的会提到BFC，所以就查了一下。What块](https://blog.csdn.net/qq_39083004/article/details/79499216)[格式化](https://blog.csdn.net/qq_39083004/article/details/79499216)[上下文](https://blog.csdn.net/qq_39083004/article/details/79499216)（Block Formatting Context,BFC）是web页面的可视化CSS渲染的一部分，是布局过程中生成块级盒子的区域，也是浮动元素与其他元素的交互限定区域。 def:它是一个独立的渲染区域，只有Block-level box参与， 它规定了内部的Block-level Box如何布局，并且与这个区域......

[块级](https://blog.csdn.net/lettertiger/article/details/79258674)[格式化](https://blog.csdn.net/lettertiger/article/details/79258674)[上下文](https://blog.csdn.net/lettertiger/article/details/79258674)(Block Formatting Context) - letterTiger的博客

12-16

[CSS块级](https://blog.csdn.net/lettertiger/article/details/79258674)[格式化](https://blog.csdn.net/lettertiger/article/details/79258674)[上下文](https://blog.csdn.net/lettertiger/article/details/79258674)是块级盒子的一种能力,这种能力并不是直接通过css属性声明而获得的,而是添加css的一部分相关属性之后自动获得的能力,也就是说没有一个明确的...

[块级](https://blog.csdn.net/Z_E_U_S/article/details/105165805)[格式化](https://blog.csdn.net/Z_E_U_S/article/details/105165805)[上下文](https://blog.csdn.net/Z_E_U_S/article/details/105165805)_Z_E_U_S的博客-CSDN博客

3-28

[块级](https://blog.csdn.net/Z_E_U_S/article/details/105165805)[格式化](https://blog.csdn.net/Z_E_U_S/article/details/105165805)[上下文](https://blog.csdn.net/Z_E_U_S/article/details/105165805)全称Block Formatting Context,简称BFC它是一块独立的渲染区... 在一个Web页面的CSS渲染中,块级[格式化](https://blog.csdn.net/Z_E_U_S/article/details/105165805)[上下文](https://blog.csdn.net/Z_E_U_S/article/details/105165805) (Block Fromatting Context)是按照块级盒...

[(L)](https://blog.csdn.net/ixygj197875)  [歪脖先生的博客](https://blog.csdn.net/ixygj197875)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 140

[CSS 块](https://blog.csdn.net/ixygj197875/article/details/79344475)[格式化](https://blog.csdn.net/ixygj197875/article/details/79344475)[上下文](https://blog.csdn.net/ixygj197875/article/details/79344475) BFC [块](https://blog.csdn.net/ixygj197875/article/details/79344475)[格式化](https://blog.csdn.net/ixygj197875/article/details/79344475)[上下文](https://blog.csdn.net/ixygj197875/article/details/79344475)CSS 块级框参与的[格式化](https://blog.csdn.net/ixygj197875/article/details/79344475)[上下文](https://blog.csdn.net/ixygj197875/article/details/79344475)，称作块[格式化](https://blog.csdn.net/ixygj197875/article/details/79344475)[上下文](https://blog.csdn.net/ixygj197875/article/details/79344475)（Block Formatting Contexts，简称BFC），它规定了内部的块级框如何排列。块[格式化](https://blog.csdn.net/ixygj197875/article/details/79344475)[上下文](https://blog.csdn.net/ixygj197875/article/details/79344475)看似抽象，其实比较简单，它实际上就是页面上的一个块级元素，只是在布局上，该元素内部的元素和外部的元素相互独立，互不影响。通俗的讲，就是在创建了块[格式化](https://blog.csdn.net/ixygj197875/article/details/79344475)[上下文](https://blog.csdn.net/ixygj197875/article/details/79344475)的元素中，其子元素都会按照块[格式化](https://blog.csdn.net/ixygj197875/article/details/79344475)[上下文](https://blog.csdn.net/ixygj197875/article/details/79344475)的规则排列自己。以下元素都......

[BFC:块级](https://blog.csdn.net/bury_/article/details/79446842)[格式化](https://blog.csdn.net/bury_/article/details/79446842)[上下文](https://blog.csdn.net/bury_/article/details/79446842)_bury_的博客-CSDN博客

6-15

[一、 什么是BFC块级](https://blog.csdn.net/bury_/article/details/79446842)[格式化](https://blog.csdn.net/bury_/article/details/79446842)[上下文](https://blog.csdn.net/bury_/article/details/79446842),Block Formatting Context,也就是常说的BFC,它是Web页面的可视化CSS渲染区域的一部分,是布局过程中生成块级盒子的区域,也是浮动元素...

[...Block Formatting Contexts (块级](https://blog.csdn.net/wangjiaohome/article/details/80392626)[格式化](https://blog.csdn.net/wangjiaohome/article/details/80392626)[上下文](https://blog.csdn.net/wangjiaohome/article/details/80392626)..._CSDN博客

11-4

[在举例说明 BFC 如何阻止外边距折叠之前,首先说明一下外边距折叠的规则:仅当两个块级元素相邻并且在同一个块级](https://blog.csdn.net/wangjiaohome/article/details/80392626)[格式化](https://blog.csdn.net/wangjiaohome/article/details/80392626)[上下文](https://blog.csdn.net/wangjiaohome/article/details/80392626)时,它们垂直方向之间的外边距才会叠加。

©️2020 CSDN  皮肤主题: 大白  设计师: CSDN官方博客  [返回首页](https://blog.csdn.net/)

[关于我们](https://www.csdn.net/company/index.html#about)  [招聘](https://www.csdn.net/company/index.html#recruit)  [广告服务](https://www.csdn.net/company/index.html#advertisement)  [网站地图](https://www.csdn.net/gather/A)  ![](data:image/svg+xml,%3csvg width='16' height='16' xmlns='http://www.w3.org/2000/svg' data-evernote-id='3170' class='js-evernote-checked'%3e%3cpath d='M2.167 2h11.666C14.478 2 15 2.576 15 3.286v9.428c0 .71-.522 1.286-1.167 1.286H2.167C1.522 14 1 13.424 1 12.714V3.286C1 2.576 1.522 2 2.167 2zm-.164 3v1L8 10l6-4V5L8 9 2.003 5z' fill='%23999AAA' fill-rule='evenodd' data-evernote-id='3171' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  [(L)](https://blog.csdn.net/taotao6039/article/details/37520765mailto:webmaster@csdn.net)[kefu@csdn.net](https://blog.csdn.net/taotao6039/article/details/37520765mailto:webmaster@csdn.net)![](data:image/svg+xml,%3csvg t='1538012951761' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23083' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='3172' class='js-evernote-checked'%3e%3cdefs data-evernote-id='3173' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='3174' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M466.4934485 880.02006511C264.6019863 859.18313878 107.13744214 688.54706608 107.13744214 481.14947309 107.13744214 259.68965394 286.68049114 80.14660493 508.14031029 80.14660493s401.00286817 179.54304901 401.00286814 401.00286816v1.67343191C908.30646249 737.58941724 715.26799489 943.85339507 477.28978337 943.85339507c-31.71423369 0-62.61874229-3.67075386-92.38963569-10.60739903 30.09478346-11.01226158 56.84270313-29.63593923 81.5933008-53.22593095z m-205.13036267-398.87059202a246.77722444 246.77722444 0 0 0 493.5544489 0 30.85052691 30.85052691 0 0 0-61.70105383 0 185.07617062 185.07617062 0 0 1-370.15234125 0 30.85052691 30.85052691 0 0 0-61.70105382 0z' p-id='23084' fill='%23999AAA' data-evernote-id='3175' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  [(L)](http://bbs.csdn.net/forums/Service)[客服论坛](http://bbs.csdn.net/forums/Service)![](data:image/svg+xml,%3csvg t='1538013874294' width='17' height='17' style='' viewBox='0 0 1194 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23784' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='3176' class='js-evernote-checked'%3e%3cdefs data-evernote-id='3177' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='3178' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M1031.29689505 943.85339507h-863.70679012A71.98456279 71.98456279 0 0 1 95.60554212 871.86883228v-150.85178906c0-28.58329658 16.92325492-54.46750945 43.13135785-65.93861527l227.99160176-99.75813425c10.55341735-4.61543317 18.24580594-14.0082445 20.72896295-25.23643277l23.21211998-105.53417343a71.95757195 71.95757195 0 0 1 70.28414006-56.51881307h236.95255971c33.79252817 0 63.02360485 23.5090192 70.28414004 56.51881307l23.21211997 105.53417343c2.48315701 11.25517912 10.17554562 20.62099961 20.72896296 25.23643277l227.99160177 99.75813425a71.98456279 71.98456279 0 0 1 43.13135783 65.93861527v150.85178906A71.98456279 71.98456279 0 0 1 1031.26990421 943.85339507z m-431.85339506-143.94213475c143.94213474 0 143.94213474-48.34058941 143.94213474-107.96334876s-64.45411922-107.96334877-143.94213474-107.96334877c-79.51500637 0-143.94213474 48.34058941-143.94213475 107.96334877s0 107.96334877 143.94213475 107.96334876zM1103.254467 296.07330247v148.9894213a35.97878598 35.97878598 0 0 1-44.15700966 35.03410667l-143.94213473-33.57660146a36.0057768 36.0057768 0 0 1-27.80056231-35.03410668V296.1002933c-35.97878598-47.98970852-131.95820302-71.98456279-287.91126031-71.98456279S347.53801649 248.11058478 311.53223967 296.1002933v115.385829c0 16.73431906-11.52508749 31.25538946-27.80056233 35.03410668l-143.94213473 33.57660146A35.97878598 35.97878598 0 0 1 95.63253297 445.06272377V296.07330247C162.81272673 152.13116772 330.77670658 80.14660493 599.47049084 80.14660493s436.63077325 71.98456279 503.81096699 215.92669754z' p-id='23785' fill='%23999AAA' data-evernote-id='3179' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  400-660-0108  ![](data:image/svg+xml,%3csvg t='1538013544186' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23556' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='3180' class='js-evernote-checked'%3e%3cdefs data-evernote-id='3181' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='3182' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M902.60033922 650.96445566c-18.0718526-100.84369837-94.08399771-166.87723736-94.08399771-166.87723737 10.87530062-91.53186599-28.94715402-107.78733693-28.94715401-107.78733691C771.20003413 93.08221664 517.34798062 98.02553561 511.98620441 98.16348824 506.65661791 98.02553561 252.75857992 93.08221664 244.43541101 376.29988138c0 0-39.79946279 16.25547094-28.947154 107.78733691 0 0-75.98915247 66.03353901-94.0839977 166.87723737 0 0-9.63372291 170.35365477 86.84146124 20.85850523 0 0 21.70461757 56.79068296 61.50407954 107.78733692 0 0-71.1607951 23.19910867-65.11385185 83.46161052 0 0-2.43717093 67.16015592 151.93232126 62.56172014 0 0 108.5460788-8.0932473 141.10300432-52.14626271H526.33792324c32.57991817 44.05301539 141.10300431 52.1462627 141.10300431 52.14626271 154.3235077 4.59843579 151.95071457-62.56172013 151.95071457-62.56172014 6.00095876-60.26250183-65.11385185-83.46161053-65.11385185-83.46161052 39.77647014-50.99665395 61.4810877-107.78733693 61.4810877-107.78733692 96.45219231 149.49514952 86.84146124-20.85850523 86.84146125-20.85850523' p-id='23557' fill='%23999AAA' data-evernote-id='3183' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)[(L)](https://url.cn/5epoHIm?_type=wpa&qidian=true)[QQ客服（8:30-22:00）](https://url.cn/5epoHIm?_type=wpa&qidian=true)

[公安备案号 11010502030143](http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010502030143)  [京ICP备19004658号](http://beian.miit.gov.cn/publish/query/indexFirst.action)  [京网文〔2020〕1039-165号](https://csdnimg.cn/release/live_fe/culture_license.png)  [版权与免责声明](https://www.csdn.net/company/index.html#statement)  [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)  [网络110报警服务](http://www.cyberpolice.cn/)

[中国互联网举报中心](http://www.12377.cn/)  [家长监护](https://download.csdn.net/index.php/tutelage/)  [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)  [北京互联网违法和不良信息举报中心](http://www.bjjubao.org/)  ©1999-2020 北京创新乐知网络技术有限公司
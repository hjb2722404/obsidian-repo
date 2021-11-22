CSS进阶（2）—— width,height如此高深,难道你真懂得 - 掘金

[(L)](https://juejin.im/user/1521379824374167)

[ 闲人王昱珩   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/1521379824374167)

2019年06月13日   阅读 1964

# CSS进阶（2）—— width,height如此高深,难道你真懂得

> 本节内容主要针对《CSS world》第三章——流、元素与基本尺寸的内容进行了一些提取与概括。 不能否认的是《CSS world》是一本非常好的书，但就看完这一章的感受而言，ZXX还不足以被称之为一个非常好的作者（纯属个人观点）。作者想通过不断地抛出问题，以及给出相应解决方案的方式，引导式的带领读者进入CSS的世界。然而CSS世界每个“个体”之间的关联性过于强烈的特性导致很难单独的去讲某一个特性，因此第一遍看的时候会有很多不明白的地方，不过我也不担心，学1+1的时候也觉得难，后来学了1*1，1+1看起来就简单了。

## 1.元素的内外盒子

HTML中只有两种元素，块级元素和内联元素。块级元素拥有“换行”的特性，一般用于结构（骨架），内联元素能够同行显示，一般用于内容展示。需要注意的是，块级元素并不是指“display:block”的元素，同样的，内联元素也不单单是“display:inline"的元素。但是，这两句话反过来说是可以的。那么是不是指，块级元素包含了"display:block/table/list-item"之类的元素呢？也不是！

这里我们需要借助一个常用的设置——display:inline-block来引出一个概念，就是每个HTML标签或者说元素，都包含了内、外两层。inline-block的特性是，"外层盒子"用了内联元素的特性——可以和其他内联元素同行显示，而"内层盒子"则借助了块级元素的自适应宽度的特性，并且能够设置容器的高度。

借助inline-block元素的内外盒子的概念，就可以得出，display:block=> display:block-block，他是由外在的块级盒子和内在的块级盒子组成的。display:inline元素也是同理。

## 2.list-item中特殊的“附加盒子”

display:list-item是li标签的默认属性，通常显示为一个F12无法选中的小圆点，事实上查阅一下list-style的属性，你会发现有很多不仅仅是小圆点，还有诸如1234排序的这种标记，但由于其不服从管教的特性，通常我们会将list-style置为none。我们都知道，list-style元素隶属于“块级元素”，然而list-item由于其特殊性质，在块级元素之外还有一个"附加盒子"，学名"标记盒子"（marker box），专门用来放圆点、数字这种标记盒子，因此所有的块级元素在“主块级盒子”的基础上，list-item还有其特殊的一个附加盒子。关于这个特性，个人觉得有点印象就好，实际项目中list-item几乎是弃用的存在。

## 3.深藏不露的width：auto

如果没有手动设置width，也就是width设为默认值auto，根据不同的元素，会表现出不同的特性。

- 首先是最常见的块级元素，如div、p标签这些元素的默认宽度就是100%于父容器，这里我们先不讨论高度，我们可以称这种特性为充分利可用空间。
- 第二个特性是子元素的收缩与父元素的包裹（原文中这里用收缩与包裹，似乎有些不太恰当），典型代表是浮动、绝对定位、inline-block元素、table元素，这种特性在后面会一一展开，这里不多赘述。
- 收缩到最小，则会中最容易出现在table-layout为auto的表格中。有兴趣的可以去这个链接试一下（[地址](https://demo.cssworld.cn/3/2-1.php)）
- 超出容器限制。在父元素宽度固定的情况下，子元素的宽度一般是不会超过父元素的，除非有一些特殊情况，如连续的特别长的英文单词，或者是内联元素被设置了white-space:nowrap。有兴趣的可以去这个链接试一下（[地址](https://demo.cssworld.cn/3/2-2.php)）

## 4.浅析元素的包裹性

元素的包裹性在上一点的第二条中有提到，这里为什么要说浅析，因为在后续讲到浮动，定位的时候都会牵扯到元素的包裹特性，因此这里只作一些概念的了解和简单的应用。首先什么是元素的"包裹性"，顾名思义，就是包裹和自适应性，所谓自适应性，指的是在指定父容器宽度（注意这里的指定不一定是具体指明）的内部子元素的尺寸由他本身决定。换句话说，内部子元素似乎有个max-width：“父容器宽度”的感觉。当然，在子元素的min-width大于father.width的时候，这条准则不适用。当子元素的内容宽度即将超出父元素的宽度时，就会自动换行，听起来很正常，实际上则大有用途，而且在这条法则遇到float和绝对定位的时候会遇到很多看似不怎么正常的情况，在后面讲到这部分内容的时候还会具体描述。

## 5.利用元素包裹性，实现文字较少时居中对齐，文字较多时，内容左对齐

利用元素的包裹性，我们可以做一个简单的需求，如：我们希望在一个确定宽度的元素内文字内容少的时候文字居中对齐，而文字内容多的时候文字左对齐。在文字少的时候，inline-block元素的外层盒子是inline元素，而inline元素在block元素中可以用text-align：center居中对齐。当inline-block元素内部的宽度 ==> 父元素宽度的时候，会自动换行，这时候我们利用inline-block内部的块级元素特性，给内层盒子添加text-align:left，这样子元素相对于外部的整体表现总是整体居中，而其自身的表现则是文字居左，最终代码如下。

	html<!-- 文字少居中显示，文字多居左显示 -->
	<div class="box">
	    <div class="content">少量文字</div>
	</div>
	<div class="box">
	    <div class="content">许多文字许多文字许多文字许多文字</div>
	</div>
	<style>
	.box{
	    width: 200px;
	    text-align: center;
	    background: #1A95FF;
	}
	.box>.content{
	    margin:20px 0;
	    display: inline-block;
	    text-align: left;
	    background: #E6A23C;
	}
	</style>
	复制代码

由于markdown编辑器支持标签语言，因此我们可以直接预览最终效果如下（小提示：你可以通过浏览器直接检查下面的元素看到CSS样式）

少量文字

许多文字许多文字许多文字许多文字

## 6.width值的作用对象

关于盒模型的四层这里简单复述一下，从内到外分别是content-box,padding-box,border-box和透明的margin-box。一般情况下，width是直接作用给content-box的，这样往往会导致我们在布局的时候添加padding和border的时候，导致元素整体的宽高变大。如我们从设计稿上获取一个width:100px，padding:10px,border:1px的元素，最终我们需要通过width - paddingLeft - paddingRight - boderLelft - borderRight去计算content-width。这样未免太过麻烦。因此CSS提供了border-box模型方便我们进行开发。事实上box-sizing:border-box改变的就是width的作用对象。原来width只作用于content-box，用了boder-box后，width = padding + border + content 。

## 7.width:100%到底是多宽——百分比的动态计算是怎么回事

其实在原文中是没有这一章节的，只有类似的内容。首先这个问题是什么意思，来看一个例子，如果有个inline-block特性的父元素的宽度是auto，他包含两个用百分比计算宽度的子元素A和B，A的宽度是50%，B的宽度也是50%，但AB里面的内容不相等，那么实际会产生什么效果呢？眼见为实。

	html<!-- 百分比计算问题 -->
	<div class="f_box">
	    <span class="box_a">我是A元素</span>
	    <span class="box_b">我是B元素我是B元素</span>
	</div>
	<style>
	.f_box{
	    display: inline-block;
	    height: 100px;
	    background: #F56C6C;
	    white-space: nowrap;
	}
	.box_a{
	    width:50%;
	    background: #E6A23C;
	    display: inline-block;
	}
	.box_b{
	    width:50%;
	    background: #67c23a;
	    display: inline-block;
	}
	</style>
	复制代码

由于markdown编辑器支持标签语言，因此我们可以直接预览最终效果如下（小提示：你可以通过浏览器直接检查下面的元素看到CSS样式）
我是A元素我是B元素我是B元素

导致上面结果的原因是由于父元素包含的两个子元素宽度都是百分比宽度，因此他们的宽度都依赖于父元素的width乘百分比得到，而父元素的宽度是auto，auto乘百分比=NaN。当然在实际计算的时候，并非如此，而且父元素的宽度已经通过auto计算得到了。这事实上跟浏览器的渲染顺序有关系，关于渲染机制，我之前有写一篇文章大概理了一下浏览器的渲染过程，当然人没有今天这个这么细致，在本例中，你只需要知道dom内容是从上往下，从外往内渲染即可。你可以这么理解，当渲染到父元素的时候，子元素的宽度=auto（实际上是依赖父元素宽度的百分比），因此父元素遵循图文至高法则，得到A,B元素content区域的宽度加一加作为自己的最终的宽度，有了这个经过auto得到的宽度后，再和子元素的百分比进行计算，子元素相应的宽度就出来了，在本例中，A的内容比较少，因此宽度还有冗余，而B的内容多了一些，则超出width区域了。

## 8.height：100%有时候为什么不生效？

关于height：auto的问题这里不过多叙述，通常情况下，由于浏览器的宽度有限，因此在设计的时候width：auto比height复杂得多，有些人可能觉得换行属于高度分配的一部分，事实上换行是因为宽度不够才导致的，高度改变只是其表现形式而已。对于height：auto来说，只要记录每个元素高度，叠加即可，当然某些特殊的属性如float，margin导致的叠压问题等，会在后面单独说明。

下面来讲讲重点，也是height和width一个比较明显的区别，就是对百分比单位的支持。对于width属性，就算其父元素是width：auto（当然这个样式不需要显示声明），其百分比值也是可以支持的。但是对于height的百分比属性，如果其父元素是height为auto，那么只要子元素在文档流中（如float，绝对定位都可以使元素脱离文档流），其百分比值就完全没用了。

为什么会这样呢？因为在规范中给出了答案。原文这样描述：如果包含块的高度没有显示指定，并且该元素不是绝对定位，则计算值为auto。也就是子元素的100%*auto=NaN，所以计算结果无效。因此非绝对定位元素要使用height：100%，要不断的给父级，父级的父级添加height：具体值，才会生效，好在这种情况不会很多。

那么宽度为什么可以支持呢？因为包含块的宽度取决于该元素的宽度，其行为是“未定义”的，也就是不同的浏览器可以有不同的特性，好在大家都想到一块去了，最终的布局效果在各个浏览器下都是一致的。就是按照包含块真实的计算值作为百分比计算的基数。

## 9.height:100%在绝对定位元素和非绝对定位元素表现的不同点

刚才已经说明了如果让非绝对定位元素height百分比生效的方法，就是显示声明其父元素的高度。那么height：100%到底是多高呢？我们已经知道了宽度的作用对象在普通盒模型里是content，那么height：100%是不是也是指content-height*100%呢？答案是，在非绝对定位的子元素中是这样，但在绝对定位元素中，计算百分比的时候会以父级元素的content-height + padding-height作为基数。这只是个注意点，眼见为实就好。

	html<div class="box">
	    <div class="child">高度100px</div>
	</div>
	<div class="box rel">
	    <div class="child">高度160px</div>
	</div>
	<style>
	.box {
	    height: 160px;
	    padding: 30px;
	    box-sizing: border-box;
	    background-color: #F56C6C;
	}
	.child {
	    height: 100%;
	    background: #E6A23C;
	}
	.rel {
	    position: relative;
	}
	.rel > .child {
	    width: 100%;
	    position: absolute;
	}
	</style>
	复制代码

由于markdown编辑器支持标签语言，因此我们可以直接预览最终效果如下（小提示：你可以通过浏览器直接检查下面的元素看到CSS样式）

高度100px

高度160px

## 10.min/max-width/height的初始化探究

关于min/max-width/height是做什么，从字面上理解就可以，规定元素的最大最小基本尺寸。通常用于自适应布局方案。与基本尺寸（width，height）不同的是，min/max-width/height的初始值要相对复杂一些。根据作者的测试，min-width/height的初始值是auto，max-width/height的初始值是none。下面我们写两个例子，来证明一下为什么min-的初始值是auto而不是0，max-的初始时none而不是auto。

首先是min-，这个例子会非常好理解，只需要用下面的CSS证明即可

	html<style>
	.box{
	    transtion:min-height .3s;
	}
	.box:hover{
	    min-height:300px;
	}
	</style>
	复制代码

如果min-height默认为0的话，当我们鼠标移入box时，应该会有连续0-300px的动画出现，然而事实是，高度是突然增加的，没有过渡，因此min-height默认应该是auto，当然你也可以写一下证明一下。

	html<style>
	.box{
	    min-height:0px;
	    transtion:min-height .3s;
	}
	.box:hover{
	    min-height:300px;
	}
	</style>
	复制代码

当声明min-height为0的时候，过渡效果就出现了。那么max-默认为什么不是auto呢？借用作者的例子，已知父元素的width是400px，子元素的width是800px，如果你没有声明max-width，且他的默认值符合猜想auto的话，那么max-width的值应该是400px,那么这个max-width的默认值便会覆盖width的值，width：800px就不生效了，实际上并不会这样，因此我们可以得出max-width:none的结论。

## 11.min > max > !important

原文标题，超越！important，超越最大 —— 标题狗!

其实就是一个覆盖问题，CSS世界中权重"最大"的是!important,吗？其实还有特例，比如今天要说的min-,max-，如果你设置了width：100px，并给他买了个保险!important ===> width:100px!important; 然而遇到了max-width:50px，最后宽度的值依旧是50px，!important失效。当min-width>max-width的时候，这个时候听谁的呢？听min-width的，所以记住min>max>!important即可。

## 12.利用max-height的原理实现元素的展开效果

展开收起”是网页中比较常见的操作，之前我一直用改变height的方式去做，虽然需要动态计算height，但也勉强能用，现在有一种更好的方法，让height从一个比较小的值变成"auto"。我以前也这么做过，发现没有动画，因为auto - 0 =NaN,因此是不会有动画。如果能让auto变成一个具体的值就好了，就像我之前提到的动态计算height的值。现在我们可以用max-height的自适应性来解决这个问题。我们只需要设定为保证比展开内容高度大的值就可以，因为max-height值比height计算值大的时候，元素的高度就是height的计算高度。眼见为实

	html
	<!-- 展开效果 -->
	<div class="father">
		<div class="son">1</div>
		<div class="son">2</div>
		<div class="son">3</div>
		<div class="son">4</div>
		<div class="son">5</div>
	</div>
	<style>
	.father{
		max-height: 20px;
		overflow: hidden;
		transition: 0.5s linear;
		/*background: green;*/
	}
	.father:hover{
		max-height: 200px;
		/*background: red;*/
	}
	.son{
		height: 20px
	}
	</style>
	复制代码

[效果链接点这里](https://demo.cssworld.cn/3/3-2.php)

不忘初心，方得始终

本文的内容到此就结束了，喜欢博主的童鞋可以扫描二维码加博主好友~ 也可以扫中间二维码入驻博主的粉丝群（708637831）~当然你也可以扫描二维码打赏并直接包养帅气的博主一枚。

[1](../_resources/5217515d74fb5d39eecba606faf2d50a.webp)[1](../_resources/7438acae0ee89543fe2833ee96e74b85.webp)[1](../_resources/dc4b5e67db9a9ea202d3a14b85732559.webp)
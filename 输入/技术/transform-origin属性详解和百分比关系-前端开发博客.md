transform-origin属性详解和百分比关系-前端开发博客

# [transform-origin属性详解和百分比关系](http://caibaojian.com/transform-origin.html)

2017-11-02**

CSS3 transform里面有一个属性transform-origin，该属性可以改变元素的原点位置，之前的一篇文章：[CSS揭秘之沿着环形路径运动的动画](http://caibaojian.com/css3-animate-spin.html)，正是巧妙的运用了原点位置，从而实现了围绕圆心运动。transform-origin里面的百分比没有详细了解是以什么为标准的。今天看看这篇文章详细了介绍了这个值跟left、right、top、bottom之间的关系。

默认情况，变形的原点在元素的中心点，或者是元素X轴和Y轴的50%处，如下图所示：![transform-1.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131439.jpg)我们没有使用`transform-origin`改变元素原点位置的情况下，CSS变形进行的旋转、移位、缩放等操作都是以元素自己中心（变形原点）位置进行变形的。但很多时候需要在不同的位置对元素进行变形操作，我们就可以使用`transform-origin`来对元素进行原点位置改变，使元素原点不在元素的中心位置，以达到需要的原点位置。

如果我们把元素变换原点（`transform-origin`）设置0（x） 0（y），这个时候元素的变换原点转换到元素的左顶角处，如下图所示：![transform-2.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131513.jpg)正如上图所示，改变`transform-origin`属性的X轴和Ｙ轴的值就可以重置元素变形原点位置，其基本语法如下所示:

	transform-origin：[<percentage> | <length> | left | center | right | top | bottom] | [<percentage> | <length> | left | center | right] | [[<percentage> | <length> | left | center | right] && [<percentage> | <length> | top | center | bottom]] <length> ?

上面的语法让人看得发晕，其实可以将语法拆分成：

	/*只设置一个值的语法*/
	transform-origin: x-offset
	transform-origin:offset-keyword
	/*设置两个值的语法*/
	transform-origin：x-offset  y-offset
	transform-origin：y-offset  x-offset-keyword
	transform-origin：x-offset-keyword  y-offset
	transform-origin：x-offset-keyword  y-offset-keyword
	transform-origin：y-offset-keyword  x-offset-keyword
	/*设置三个值的语法*/
	transform-origin：x-offset  y-offset  z-offset
	transform-origin：y-offset  x-offset-keyword  z-offset
	transform-origin：x-offset-keyword  y-offset  z-offset
	transform-origin：x-offset-keyword  y-offset-keyword  z-offset
	transform-origin：y-offset-keyword  x-offset-keyword  z-offset

`transform-origin`属性值可以是百分比、em、px等具体的值，也可以是top、right、bottom、left和center这样的关键词。

2D的变形中的`transform-origin`属性可以是一个参数值，也可以是两个参数值。如果是两个参数值时，第一值设置水平方向X轴的位置，第二个值是用来设置垂直方向Ｙ轴的位置。

3D的变形中的`transform-origin`属性还包括了Ｚ轴的第三个值。其各个值的取值简单说明如下：

- x-offset：用来设置`transform-origin`水平方向Ｘ轴的偏移量，可以使用`<length>`和`<percentage>`值，同时也可以是正值（从中心点沿水平方向Ｘ轴向右偏移量），也可以是负值（从中心点沿水平方向Ｘ轴向左偏移量）。
- offset-keyword：是`top`、`right`、`bottom`、`left`或`center`中的一个关键词，可以用来设置`transform-origin`的偏移量。
- y-offset：用来设置`transform-origin`属性在垂直方向Ｙ轴的偏移量，可以使用`<length>`和`<percentage>`值，同时可以是正值（从中心点沿垂直方向Ｙ轴向下的偏移量），也可以是负值（从中心点沿垂直方向Ｙ轴向上的偏移量）。
- x-offset-keyword：是`left`、`right`或`center`中的一个关键词，可以用来设置`transform-origin`属性值在水平Ｘ轴的偏移量。
- y-offset-keyword：是`top`、`bottom`或`center`中的一个关键词，可以用来设置`transform-origin`属性值在垂直方向Ｙ轴的偏移量。
- z-offset：用来设置3D变形中`transform-origin`远离用户眼睛视点的距离，默认值`z=0`，其取值可以`<length>`，不过`<percentage>`在这里将无效。

看上去`transform-origin`取值与`background-position`取值类似。为了方便记忆，可以把关键词和百分比值对比起来记：

- top = top center = center top = 50% 0
- right = right center = center right = 100%或(100% 50%)
- bottom = bottom center = center bottom = 50% 100%
- left = left center = center left = 0或(0 50%)
- center = center center = 50%或（50% 50%）
- top left = left top = 0 0
- right top = top right = 100% 0
- bottom right = right bottom = 100% 100%
- bottom left = left bottom = 0 100%

为了让大家能一眼看明白，下面截图以transform中的旋转rotate()为例，并transform-origin取值不一样时的效果：**transform-origin取值为center（或center center或50% 或50% 50%）：**![transform-3.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131521.jpg)**transform-origin取值为top（或top center或center top或50％ 0）：**![transform-4.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131537.jpg)**transform-origin取值为right(或right center 或center right 或 100％ 或 100％ 50％)：**![transform-5.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131545.jpg)**transform-origin取值为bottom(或bottom center 或center bottom 或 50％ 100％)：**![transform-6.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131603.jpg)**transform-origin取值为left(或left center或center left或0或0 50％):**![transform-7.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131613.jpg)**transform-origin取值为top left(或left top或0 0)：**![transform-8.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131621.jpg)**transform-origin取值为right top（或top right或100％ 0）：**![transform-9.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131640.jpg)**transform-origin取值为bottom right（或right bottom或100％ 100％）:**![transform-10.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131649.jpg)**transform-origin取值为left bottom（或bottom left 或 0 100％）:**![transform-11.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131700.jpg)CSS3变形中旋转、缩放、倾斜都可以通过`transform-origin`属性重置元素的原点，但其中的位移`translate()`始终以元素中心点进行位移。例如下面的两段代码的演示过程：

	div {
	  -webkit-transform-origin: 50% 50%;
	  -moz-transform-origin: 50% 50%;
	  -o-transform-origin: 50% 50%;
	  -ms-transform-origin: 50% 50%;
	  transform-origin: 50% 50%;
	
	  -webkit-transform: translate(40px, 40px) translate(-50px, 35px) translateY(30px);
	  -moz-transform: translate(40px, 40px) translate(-50px, 35px) translateY(30px);
	  -o-transform: translate(40px, 40px) translate(-50px, 35px) translateY(30px);
	  -ms-transform: translate(40px, 40px) translate(-50px, 35px) translateY(30px);
	  transform: translate(40px, 40px) translate(-50px, 35px) translateY(30px);
	}

接下来通过`transform-origin`将变形原点设置为100% 100%:

	div {
	  -webkit-transform-origin: 100% 100%;
	  -moz-transform-origin: 100% 100%;
	  -o-transform-origin: 100% 100%;
	  -ms-transform-origin: 100% 100%;
	  transform-origin: 100% 100%;
	
	  -webkit-transform: translate(40px, 40px) translate(-50px, 35px) translateY(30px);
	  -moz-transform: translate(40px, 40px) translate(-50px, 35px) translateY(30px);
	  -o-transform: translate(40px, 40px) translate(-50px, 35px) translateY(30px);
	  -ms-transform: translate(40px, 40px) translate(-50px, 35px) translateY(30px);
	  transform: translate(40px, 40px) translate(-50px, 35px) translateY(30px);
	}

虽然元素的变形原点通过`transform-origin`从50% 50%变成100% 100%，但元素位移`translate()`始终是依元素中心点进行位移，如下图所示：![transform-12.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131709.jpg)到目前为止，`transform-origin`属性在现代主流浏览器得到很好的支持，但在一些浏览器之下依然需要添加各浏览器私有属性，详细情况如下所示:

- 2D变形中transform-origin需要添加浏览器私有属性版本：IE9+、Firefox3.5+、Chrome4+、Safari3.1+、Opera10.5+；iOS Safari3.2+、Android Browser2.1+、Blackberry Browser7.0+、Chrome for Android25.0+。
- 2D变形中transform-origin支持W3C标准规范的浏览器：IE10+、Firefox16+、Opera12.1+；Opera Mobile11.0+、Firefox for Android19.0。
- 3D变形中transform-origin需要添加浏览器私有属性版本：IE10+、Firefox10+、Chrome12+、Safari4+、Opera15+、iOS Safari3.2+、Android Browser3.0+、Blackberry Browser7.0+、Opera Mobile14.0+、Chrome for Android25.0+。
- 3D变形中transform-origin支持W3C标准规范的浏览器:Firefox16+、Firefox for Android19+

通过`transform-origin`属性改变元素的原点，可以实现不同的变形效果，下面的示例中我们分别演示了改变元素原点前后，CSS3变形各函数对图像变形操作。

为了能更具有对比性，下面的示例中有两个`div`，每个`div`各有5个`img`，而第一个`div`是指`transform-origin`为默认值时效果，第二个`div`是指`transform-origin`修改后在不同`transform`函数中效果。

	<div>
	    <img src="images/cardKingClub.png" alt="" width="142" height="200" />
	    <img src="images/cardKingClub.png" alt="" width="142" height="200" />
	    <img src="images/cardKingClub.png" alt="" width="142" height="200" />
	    <img src="images/cardKingClub.png" alt="" width="142" height="200" />
	    <img src="images/cardKingClub.png" alt="" width="142" height="200" />
	</div>
	<div>
	    <img src="images/cardKingClub.png" alt="" width="142" height="200" />
	    <img src="images/cardKingClub.png" alt="" width="142" height="200" />
	    <img src="images/cardKingClub.png" alt="" width="142" height="200" />
	    <img src="images/cardKingClub.png" alt="" width="142" height="200" />
	    <img src="images/cardKingClub.png" alt="" width="142" height="200" />
	</div>

默认样式：

	div {
	    width: 500px;
	    height: 300px;
	    margin: 30px auto;
	    position: relative;
	    background: url(images/bg-grid.jpg) no-repeat center center;
	    background-size: 100% 100%;
	}
	div img {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    margin-left: -71px;
	    margin-top: -100px;
	}

**注：**为了节省篇幅，代码中省去了各浏览器前缀。
首先来看transform-origin属性改变元素原点前后rotate()函数对图像的旋转效果：

	div img:nth-child(1){
	    opacity: .5;
	    z-index: 1;
	    transform: rotate(10deg);
	}
	div img:nth-child(2){
	    opacity: .6;
	    z-index: 2;
	    transform: rotate(25deg);
	}
	div img:nth-child(3){
	    opacity: .7;
	    z-index: 3;
	    transform: rotate(35deg);
	}
	div img:nth-child(4){
	    opacity: .8;
	    z-index: 4;
	    transform: rotate(45deg);
	}
	div img:nth-child(5){
	    z-index: 5;
	    transform: rotate(60deg);
	}
	div:nth-of-type(2) img {
	    transform-origin: bottom;
	}

上面实例演示了变形中旋转`rotate()`函数围绕不同原点旋转的效果，第一个容器`div`中的图片围绕图片默认原点（中心）旋转的过程；而第二个容器`div`中的图片经过`transform-origin`属性将图片原点从中心点（`center`）修改为底部中心点（`bottom`）旋转过程：![transform-13.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131723.jpg)接下来，我们在来看`transform-origin`修改原点前后，CSS3变形中倾斜`skew()`函数对图片变形的过程：

	div img:nth-child(1){
	    opacity: .5;
	    z-index: 1;
	    transform: skewX(10deg);
	}
	div img:nth-child(2){
	    opacity: .6;
	    z-index: 2;
	    transform: skewX(15deg);
	}
	div img:nth-child(3){
	    opacity: .7;
	    z-index: 3;
	    transform: skewX(20deg);
	}
	div img:nth-child(4){
	    opacity: .8;
	    z-index: 4;
	    transform: skewX(25deg);
	}
	div img:nth-child(5){
	    z-index: 5;
	    transform: skewX(30deg);
	}
	div:nth-of-type(2) img {
	    transform-origin: bottom;
	}

效果如下所示：![transform-14.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131730.jpg)上面两个例子简单的演示了变形中的`rotate()`和`skew()`函数都可以通过`transform-origin`属性改变对象原点，让对象根据不同的原点进行变形。接来我继续向大家演示变形中的缩放`scale()`函数在不同原点产生变形效果：

	div img:nth-child(1){
	    opacity: .5;
	    z-index: 1;
	    transform: scale(1.2);
	}
	div img:nth-child(2){
	    opacity: .6;
	    z-index: 2;
	    transform: scale(1.1);
	}
	div img:nth-child(3){
	    opacity: .7;
	    z-index: 3;
	    transform: scale(.9);
	}
	div img:nth-child(4){
	    opacity: .8;
	    z-index: 4;
	    transform: scale(.8);
	}
	div img:nth-child(5){
	    z-index: 5;
	    transform: scale(.6);
	}
	div:nth-of-type(2) img {
	    transform-origin: right;
	}

效果如下所示：![transform-15.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131738.jpg)上面三个简单实例再次验证了CSS3变形中的旋转`rotate()`、缩放`scale()`和倾斜`skew()`函数都可以通过`transform-origin`属性来改变元素对象的原点位置。但是`transform-origin`属性改变元素对像原点位置，位移`translate()`函数始终会根据元素对像中心点进行位移。

前面演示的只是2D变形中`transform-origin`用来修改元素对象原点，以及对各种变形函数产生的不同效果。接下来，在来看一个简单的实例，演示一下3D变形中`transform-origin`修改元素原点的3D旋转效果。

	div img {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    margin-left: -71px;
	    margin-top: -100px;
	    backface-visibility: visible;
	    transform: perspective(500px);
	}
	div img:nth-child(1){
	    opacity: .5;
	    z-index: 1;
	    transform: rotate3d(1, 1, 1,10deg);
	}
	div img:nth-child(2){
	    opacity: .6;
	    z-index: 2;
	    transform: rotate3d(1, 1, 1,25deg);
	}
	div img:nth-child(3){
	    opacity: .7;
	    z-index: 3;
	    transform: rotate3d(1, 1, 1,35deg);
	}
	div img:nth-child(4){
	    opacity: .8;
	    z-index: 4;
	    transform: rotate3d(1, 1, 1,45deg);
	}
	div img:nth-child(5){
	    z-index: 5;
	    transform: rotate3d(1, 1, 1,60deg);
	}
	div:nth-of-type(2) img {
	    transform-origin: left bottom -50px;
	}

其效果如下所示：![transform-16.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131746.jpg)参考文章: http://www.w3cplus.com/css3/transform-origin.html
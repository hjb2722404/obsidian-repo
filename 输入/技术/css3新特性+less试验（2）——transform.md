css3新特性+less试验（2）——transform

# css3新特性+less试验（2）——transform

CSS3
less
transform
本次试验将深入探索CSS3的新特性——transform(变形)。
###**实验对象：transform**

> transform：顾名思义，就是【变形】的意思，在CSS3中的变形有以下几种：旋转 （rotate） | 扭曲 （skew） | 缩放 （scale） | 移动 （translate） | 矩阵变形 （matrix），注意，不同于gradient是background属性的值，transform本身是一个属性。

###**语法**

	transform:transform: none | rotate | scale | skew | translate |matrix;

###**试验**
####1、rotate [旋转]
#####用法

	transform:rotate(<angle>)

#####html

	<div class="box1"></div>
	    <div class="box2"></div>
	    <div class="box3"></div>
	    <div class="box4"></div>
	    <div class="box5"></div>
	    <div class="box6"></div>

#####less

	.rotate(@angle) {
	  transform: rotate(@angle);
	}
	
	.box {
	  width: 100px;
	  height: 100px;
	  margin-left: 100px;
	  margin-top: 100px;
	  border-top: 4px solid red;
	  background: black;
	  float: left;;
	}
	
	.box1 {
	  .box;
	  .rotate(20deg);
	}
	
	.box2 {
	  .box;
	  .rotate(45deg);
	}
	
	.box3 {
	  .box;
	  .rotate(90deg);
	}
	
	.box4 {
	  .box;
	  .rotate(180deg);
	}
	
	.box5 {
	  .box;
	  .rotate(270deg);
	
	}
	.box6 {
	  .box;
	  .rotate(360deg);
	}

#####CSS

	.box {
	  width: 100px;
	  height: 100px;
	  margin-left: 100px;
	  margin-top: 100px;
	  border-top: 4px solid red;
	  background: black;
	  float: left;
	}
	.box1 {
	  width: 100px;
	  height: 100px;
	  margin-left: 100px;
	  margin-top: 100px;
	  border-top: 4px solid red;
	  background: black;
	  float: left;
	  transform: rotate(20deg);
	}
	.box2 {
	  width: 100px;
	  height: 100px;
	  margin-left: 100px;
	  margin-top: 100px;
	  border-top: 4px solid red;
	  background: black;
	  float: left;
	  transform: rotate(45deg);
	}
	.box3 {
	  width: 100px;
	  height: 100px;
	  margin-left: 100px;
	  margin-top: 100px;
	  border-top: 4px solid red;
	  background: black;
	  float: left;
	  transform: rotate(90deg);
	}
	.box4 {
	  width: 100px;
	  height: 100px;
	  margin-left: 100px;
	  margin-top: 100px;
	  border-top: 4px solid red;
	  background: black;
	  float: left;
	  transform: rotate(180deg);
	}
	.box5 {
	  width: 100px;
	  height: 100px;
	  margin-left: 100px;
	  margin-top: 100px;
	  border-top: 4px solid red;
	  background: black;
	  float: left;
	  transform: rotate(270deg);
	}
	.box6 {
	  width: 100px;
	  height: 100px;
	  margin-left: 100px;
	  margin-top: 100px;
	  border-top: 4px solid red;
	  background: black;
	  float: left;
	  transform: rotate(360deg);
	}

#####效果
![f26a4e8cca074d61ef98e375cdde9ffd.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/257ed184f0275ba7939a623128d6b2ed.jpg)

> 从左至右依次为box1~box6，我们可以看出，在CSS中，所有角度值的变化都如图片中下半部分所示，请注意体会，如果不清楚，请看下图，我加入了单位格子为100*100的网格线，还有边框为4PX的外层DIV，并取消各个box的margin值以后的效果：

![a60591dfb770118fd5326be02bb6acb3.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/44f9edea14e2a6a1173808de1a15491b.png)

> 可以看到，实际上，rotate的旋转是围绕着一个圆心的，而默认不设置圆心位置的话，圆心就是旋转元素自身的几何中心，即（50%，50%），上图是我将圆心设置为（0%，0%）后的效果。

看看我的代码（less中的代码）:

	.rotate(@angle) {
	  transform: rotate(@angle);
	  transform-origin:0% 0%; //这里就是设置圆心的代码
	}

> 你可以自己尝试一下设置不同的圆心效果有何不同哦！
####2 、skew 【扭曲】
#####用法

	transform:skew(<angle> [, <angle>]);
	
	第一个参数为x轴的斜切角度，第二个参数为Y轴斜切角度，也可以分别来写：
	
	transform:skewX(<angle>); |  transform:skewY(<angle>);

#####HTML

	<div class="content">
	
	    <div class="box1"></div>
	    <div class="box2"></div>
	    <div class="box3"></div>
	    <div class="box4"></div>
	    <div class="box5"></div>
	    <div class="box6"></div>
	
	</div>

#####less

	.skew(@x_angle:0;@y_angle:0){
	  transform: skew(@x_angle,@y_angle);
	}
	
	body{
	  background: url("bg.png") repeat;
	}
	
	.content {
	  position: relative;
	  margin-left: 100px;
	  margin-top: 100px;
	  width: 1400px;
	  height: 800px;
	  border: 4px solid #ffff00;
	}
	.box {
	  width: 100px;
	  height: 100px;
	  border-top: 4px solid red;
	  background: black;
	  margin-right: 100px;
	  float: left;
	  color:#ffffff;
	}
	
	.box1{
	  .box;
	  .skew(30deg);
	}
	
	.box2{
	  .box;
	  .skew(0deg,30deg);
	}
	
	.box3{
	  .box;
	  .skew(30deg,30deg);
	}
	
	.box4{
	   .box;
	   .skew(50deg);
	 }
	
	.box5{
	  .box;
	  .skew(130deg);
	}
	
	.box6{
	  .box;
	  .skew(170deg);
	}

##### css

	body {
	  background: url("bg.png") repeat;
	}
	.content {
	  position: relative;
	  margin-left: 100px;
	  margin-top: 100px;
	  width: 1400px;
	  height: 800px;
	  border: 4px solid #ffff00;
	}
	.box {
	  width: 100px;
	  height: 100px;
	  border-top: 4px solid red;
	  background: black;
	  margin-right: 100px;
	  float: left;
	  color: #ffffff;
	}
	.box1 {
	  width: 100px;
	  height: 100px;
	  border-top: 4px solid red;
	  background: black;
	  margin-right: 100px;
	  float: left;
	  color: #ffffff;
	  transform: skew(30deg, 0);
	}
	.box2 {
	  width: 100px;
	  height: 100px;
	  border-top: 4px solid red;
	  background: black;
	  margin-right: 100px;
	  float: left;
	  color: #ffffff;
	  transform: skew(0deg, 30deg);
	}
	.box3 {
	  width: 100px;
	  height: 100px;
	  border-top: 4px solid red;
	  background: black;
	  margin-right: 100px;
	  float: left;
	  color: #ffffff;
	  transform: skew(30deg, 30deg);
	}
	.box4 {
	  width: 100px;
	  height: 100px;
	  border-top: 4px solid red;
	  background: black;
	  margin-right: 100px;
	  float: left;
	  color: #ffffff;
	  transform: skew(50deg, 0);
	}
	.box5 {
	  width: 100px;
	  height: 100px;
	  border-top: 4px solid red;
	  background: black;
	  margin-right: 100px;
	  float: left;
	  color: #ffffff;
	  transform: skew(130deg, 0);
	}
	.box6 {
	  width: 100px;
	  height: 100px;
	  border-top: 4px solid red;
	  background: black;
	  margin-right: 100px;
	  float: left;
	  color: #ffffff;
	  transform: skew(170deg, 0);
	}

#####效果
![9eb912f1022f073637bc2bdf77bfcbfd.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/74c0af4a874d1a2cc3937dd1ddd24cf0.png)

> 从左至右分别是box1> box6，我们可以看出，box4与box5，分别在X轴斜切角度为50deg和130deg，而它们相对于Y轴对称，我们可以由此得出：skew的角度范围为0> 180deg，不能为90deg，为什么不能为90deg呢，你可以试试就知道了。

> 同样滴，斜切也是有参照圆心的，依旧是transform-origin。这个大家可以自己试验，之后的实验中再不说明。
####3、translate [平移]
#####用法

	transform:translate(<length> [, <length>]);
	
	第一个参数为x轴的平移距离，第二个参数为Y轴平移距离，也可以分别来写：
	
	transform:translateX(<length>); |  transform:translateY(<length>);

> 这个比较简单，没什么特别说明的，就不演示代码了
####4、scale[缩放]
#####用法

	transform:scale(<number> [, <number>]);
	
	第一个参数为x轴的缩放倍数，第二个参数为Y轴缩放倍数，均支持小数，也可以分别来写：
	
	transform:scaleX(<number>); |  transform:scaleY(<number>);

> 这个也比较简单，没什么特别说明的，就不演示代码了
####5、matrix[矩阵变形]
#####用法

	matrix(<number>,<number>,<number>,<number>,<number>,<number>)：
	
	以一个含六值的(a,b,c,d,e,f)变换矩阵的形式指定一个2D变换，相当于直接应用一个[a,b,c,d,e,f]变换矩阵

> 由于本人数学是渣渣，对于矩阵也是不甚了解，所以这里不知如何下手，如果有知道的大神能制作一个关于此的教程，请劳烦第一时间告知一下文章地址。

[markdownFile.md](../_resources/a6723a2192e0ecb44c7e9f50c4a30dad.bin)
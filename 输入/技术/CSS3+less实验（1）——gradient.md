CSS3+less实验（1）——gradient

# CSS3+less实验（1）——gradient

CSS3
less
gradient
从今天起，将陆续进行CSS3新特性的详细实验，由于要兼容各个浏览器（一想到这就觉得做前端真烦啊），所以配合LESS来处理css样式。
###本次实验对象——gradient

> gradient是CSS3新推出的可以实现渐变的 background的值，也就是说，它本身不是一个css属性，而是background属性的一个可能的值，所以这一点要搞清楚。

###**线性渐变**
####1、语法：

	background:-prefix-linear-gradient(angle,startcolor,stopcolor);

####2、说明：

	prefix:浏览器前缀，目前有 moz[火狐]，webkit[chrome，safari],o[opara]
	
	angle:起始角度。取值范围 0~360(deg),也可以直接使用left(90deg),top(180deg),bottom(0deg),right(270deg)来实现水平或垂直的渐变
	
	startcolor : 渐变起始颜色
	
	stopcolor : 渐变终止颜色

####3、html：

	//index.html
	
	<!DOCTYPE html>
	<html>
	<head lang="en">
	   <meta charset="UTF-8">
	   <meta http-equiv="X-UA-Compatible" content="IE=edge">
	   <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	   <meta name="renderer" content="webkit">
	   <title>css3动画试验之——gradient</title>
	   <link rel="stylesheet" href="style.css" type="text/css"/>
	</head>
	<body>
	
	   <div class="box1"></div>
	   <div class="box2"></div>
	   <div class="box3"></div>
	   <div class="box4"></div>
	   <div class="box5"></div>
	   <div class="box6"></div>
	   <div class="box7"></div>
	
	</body>
	</html>

####4、less
> 关于less，如果没有接触过的，请看这里：> [> LESS中文教程](http://www.bootcss.com/p/lesscss/)

	//style.less
	
	.gradient(@angle:top,@start:#000,@stop:#ff050e){
	
	  background: -webkit-linear-gradient(@angle,@start,@stop);
	  background: -moz-linear-gradient(@angle,@start,@stop);
	  background: -o-linear-gradient(@angle,@start,@stop);
	  background: linear-gradient(@angle,@start,@stop);
	
	}
	
	.box {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	}
	
	.box1 {
	  .box;
	  .gradient();
	}
	
	.box2 {
	  .box;
	  .gradient(left,#000,#fff);
	}
	
	.box3 {
	  .box;
	  .gradient(30deg,#000,#fff);
	}
	
	.box4 {
	  .box;
	  .gradient(180deg,#000,#fff);
	}
	
	.box5 {
	  .box;
	  .gradient(0deg,#000,#fff);
	}
	
	.box6 {
	  .box;
	  .gradient(90deg,#000,#fff);
	}
	
	.box7 {
	  .box;
	  .gradient(270deg,#000,#fff);
	}

####5、CSS

	//style.css
	.box {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	}
	.box1 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -webkit-linear-gradient(top, #000000, #ff050e);
	  background: -moz-linear-gradient(top, #000000, #ff050e);
	  background: -o-linear-gradient(top, #000000, #ff050e);
	  background: linear-gradient(top, #000000, #ff050e);
	}
	.box2 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -webkit-linear-gradient(left, #000000, #ffffff);
	  background: -moz-linear-gradient(left, #000000, #ffffff);
	  background: -o-linear-gradient(left, #000000, #ffffff);
	  background: linear-gradient(left, #000000, #ffffff);
	}
	.box3 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -webkit-linear-gradient(30deg, #000000, #ffffff);
	  background: -moz-linear-gradient(30deg, #000000, #ffffff);
	  background: -o-linear-gradient(30deg, #000000, #ffffff);
	  background: linear-gradient(30deg, #000000, #ffffff);
	}
	.box4 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -webkit-linear-gradient(180deg, #000000, #ffffff);
	  background: -moz-linear-gradient(180deg, #000000, #ffffff);
	  background: -o-linear-gradient(180deg, #000000, #ffffff);
	  background: linear-gradient(180deg, #000000, #ffffff);
	}
	.box5 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -webkit-linear-gradient(0deg, #000000, #ffffff);
	  background: -moz-linear-gradient(0deg, #000000, #ffffff);
	  background: -o-linear-gradient(0deg, #000000, #ffffff);
	  background: linear-gradient(0deg, #000000, #ffffff);
	}
	.box6 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -webkit-linear-gradient(90deg, #000000, #ffffff);
	  background: -moz-linear-gradient(90deg, #000000, #ffffff);
	  background: -o-linear-gradient(90deg, #000000, #ffffff);
	  background: linear-gradient(90deg, #000000, #ffffff);
	}
	.box7 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -webkit-linear-gradient(270deg, #000000, #ffffff);
	  background: -moz-linear-gradient(270deg, #000000, #ffffff);
	  background: -o-linear-gradient(270deg, #000000, #ffffff);
	  background: linear-gradient(270deg, #000000, #ffffff);
	}

####6、效果
![e2b4527e0ee3e5ce2edcd0119fa6c56c.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/3114743f91b2484152f9d28139f4b21a.png)
> 从做至右的样式分别是box1~box7
###**径向渐变**
####1、语法
-prefix-radial-gradient([ || ,]? [ || ,]? , [, ]*);
####2、说明

	prefix:浏览器前缀，目前有 moz[火狐]，webkit[chrome，safari],o[opara]
	
	bg-position || angle :背景位置或角度，只能出现其中一种，否则元素不显示
	
	bg-position: 可选值为百分比，或数值，或 left ,bottom,top,center,right等值
	angle: 可选值为角度值，单位 deg
	
	shape  ||  size  :形状或大小，只能出现其中一种，否则元素不显示
	
	shape : 形状，可选值为 circle(圆) 或 ellipse（椭圆），默认为ellipse
	
	size : 大小，可选值为像素数，如 48px;
	
	color-stop:终止颜色，可以有多个

####3、HTML

	  <div class="box8"></div>
	  <div class="box9"></div>
	  <div class="box10"></div>
	  <div class="box11"></div>
	  <div class="box12"></div>
	  <div class="box13"></div>

####4、Less

	.gradient-radial(@positionOrAngle:bottom left,@shapeOrSize:circle,@color_stop1:#000000,@color_stop2:#D2F726 ,@color_stop13:#DD2222 ){
	  background: -moz-radial-gradient(@positionOrAngle,@shapeOrSize, @color_stop1,@color_stop2,@color_stop13);
	  background: -webkit-radial-gradient(@positionOrAngle,@shapeOrSize, @color_stop1,@color_stop2,@color_stop13);
	}
	
	.box {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	}
	
	.box8 {
	  .box;
	  .gradient-radial(center,ellipse);
	}
	
	.box9 {
	  .box;
	  .gradient-radial(bottom left,#000000  50%,#D2F726  30%,#DD2222  80%);
	}
	
	.box10 {
	  .box;
	  .gradient-radial(ellipse,#000000  50%,#D2F726  30%,#DD2222  80%);
	}
	
	.box11 {
	  .box;
	  .gradient-radial(circle,#000000 ,#D2F726 ,#DD2222 );
	}
	
	.box12 {
	  .box;
	  .gradient-radial(closest-corner,#000000 ,#D2F726  ,#DD2222  );
	}
	
	.box13 {
	  .box;
	  .gradient-radial(16px,#000000,#D2F726 ,#DD2222 );

####5、CSS

	.box8 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -moz-radial-gradient(center, ellipse, #000000, #d2f726, #dd2222);
	  background: -webkit-radial-gradient(center, ellipse, #000000, #d2f726, #dd2222);
	}
	.box9 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -moz-radial-gradient(bottom left, #000000 50%, #d2f726 30%, #dd2222 80%, #dd2222);
	  background: -webkit-radial-gradient(bottom left, #000000 50%, #d2f726 30%, #dd2222 80%, #dd2222);
	}
	.box10 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -moz-radial-gradient(ellipse, #000000 50%, #d2f726 30%, #dd2222 80%, #dd2222);
	  background: -webkit-radial-gradient(ellipse, #000000 50%, #d2f726 30%, #dd2222 80%, #dd2222);
	}
	.box11 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -moz-radial-gradient(circle, #000000, #d2f726, #dd2222, #dd2222);
	  background: -webkit-radial-gradient(circle, #000000, #d2f726, #dd2222, #dd2222);
	}
	.box12 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -moz-radial-gradient(closest-corner, #000000, #d2f726, #dd2222, #dd2222);
	  background: -webkit-radial-gradient(closest-corner, #000000, #d2f726, #dd2222, #dd2222);
	}
	.box13 {
	  width: 120px;
	  height: 60px;
	  float: left;
	  margin-right: 10px;
	  background: -moz-radial-gradient(16px, #000000, #d2f726, #dd2222, #dd2222);
	  background: -webkit-radial-gradient(16px, #000000, #d2f726, #dd2222, #dd2222);

####6、效果
![043fc3c308eb2ad80c1f8e96f91a2392.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/e92d4cd2bbd95c471cd5f9d963d8d2cc.png)
> 从左至右分别为box8~box13，我只实验了几种参数组合，其他不同参数组合效果有兴趣可以自己做实验观察。

[markdownFile.md](../_resources/ce1fed6478e556c620304c799a922094.bin)
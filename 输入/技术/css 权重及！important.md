css 权重及！important

# css 权重及！important

css
权重
！important
在编写css样式的时候，我们会时常碰到自己写的样式没有生效，尤其是引用一些外部框架的时候，这种情况更容易发生。
##CSS样式的优先级
按照官方的表述，css优先级如下：
> 通用选择器（*） < 元素(类型)选择器 < 类选择器 < 属性选择器 < 伪类 < ID 选择器 <内联样式
举例：
例如以下代码：
index.html

	<!DOCTYPE html>
	<html>
	<head lang="en">
	    <meta charset="UTF-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	    <meta name="renderer" content="webkit">
	    <title>css权重计算测试</title>
	    <link rel="stylesheet" href="style.css"/>
	    <style>
	        img { width: 150px;}
	    </style>
	
	</head>
	<body>
	
	<img src="img.jpg"  width="1080" style="width: 100px"  class="img" id="img" alt="图片"/>
	
	</body>
	</html>

style.css

	@charset "utf-8";
	/*
	//author:hjb2722404
	//description:
	//date:2015/10/10
	*/
	
	* { width:1000px; }  // 通用选择器
	.img { width: 180px;} // 类选择器
	img[alt="img"] {
	    width: 400px;
	}                     //属性选择器
	img:hover { width: 500px;} // 伪类选择器
	#img { width: 300px;}   //ID 选择器

此时，我们查看效果，![684e2c951764562fe978d95b373fc244.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/2b819539a071d9d5c90d4aec97d7a77c.png)

发现最终起作用的是内联样式，并且鼠标悬浮到图片上时：hover的样式并未起作用。说明内联样式优先级最高。
我们去掉行内样式：

	<img src="img.jpg"  width="1080"  class="img" id="img" alt="图片"/>

再看效果：
![d8bbd2836225acdd6e939d9c07f96fec.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/3135ef950ae5f6ed869a7032404bd097.png)
发现最终应用了ID选择器的规则，并且：hover伪类未起作用，我们继续去掉ID选择器，看效果：

	* { width: 1000px;}
	.img { width: 180px;}
	img[alt="img"] {
	    width: 400px;
	}
	img:hover { width: 500px;}
	/*#img { width: 300px;}*/

![655de2825a5945a173df083571fb1313.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/b233d203fa63bd9d41b0880a7c5e16e3.png)
发现此时应用了”属性选择器“的规则，当鼠标悬停到图片上时：
![54aa0bf61f1cd574403a41a8b274ded4.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/4623a7b3bf08f5e7e532e05551b27680.png)
应用了”伪类“的规则，说明伪类的优先级高于”属性选择器“。
我们继续去掉属性选择器与伪类：

	* { width: 1000px;}
	.img { width: 180px;}
	/*img[alt="img"] {*/
	    /*width: 400px;*/
	/*}*/
	/*img:hover { width: 500px;}*/
	/*#img { width: 300px;}*/

效果如下：
![3d267c9bc9fec50b8fc386bcee7d5406.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/97d0cbb6548ffb83ce5b1ee8e0c0e497.png)
这里应用了”类选择器“的规则。
我们继续去掉类选择器：

	* { width: 1000px;}
	/*.img { width: 180px;}*/
	/*img[alt="img"] {*/
	    /*width: 400px;*/
	/*}*/
	/*img:hover { width: 500px;}*/
	/*#img { width: 300px;}*/

效果如下：
![a3684d1f46844fc4fc65221a33c410fd.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/ec8e771db1e0d829bbbfccbcf66c814c.png)
发现应用了”元素选择器“规则。
继续去掉元素选择器：

	 <link rel="stylesheet" href="style.css"/>
	    <!--<style>-->
	        <!--img { width: 150px;}-->
	    <!--</style>-->

效果如下：
![5608831d184bfa583bb6c59b38f30953.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/3532d641f926a58f6e16a089a8549188.png)
我们发现它应用了”通用选择器“的规则。继续去掉通用选择器：

	/** { width: 1000px;}*/

效果如下：
![6501526e8625a18ce29f7ea2ec4107e7.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/25eb847ecd91e4d58500531a5fb6d279.png)
发现应用了元素自身的属性值。
再去掉元素自身属性之后，不必说，显示的就是原图大小了
至此，我们一步步验证了CSS官方的优先级顺序规则，除了最后一点，提醒我们注意：
**元素自身属性的优先级反而是最低的**
这一实验驳斥了一些博客上所说的”离元素越近优先级越高“的说法
##css样式优先级计算规则：
实际上，优先级之所以表现为上面所示，是因为CSS内部是按每条样式的权重值来计算优先级的，各类型选择器所对应的权重值如下：
> 元素, 伪元素: 1 – (0,0,0,1)
> 类, 伪类, 属性: 1 – (0,0,1,0)
> ID: 1 – (0,1,0,0)
> 内联样式: 1 – (1,0,0,0)
我们可以这样理解：
假使元素在未应用任何样式前它的权重值为0，那么，每条样式的权重值就是该样式所包含的所有选择器相对应的权重值之和：
元素，伪元素：+1
类，伪类，属性：+10
ID：+100
内联样式：+1000
例如以下样式：

	p {}  //p为元素，总权重就是：1
	div p{} //p与div都是元素，总权重是：1=1=2
	.div p // .div是类，p是元素，总权重是：10+1=11

所以，如果这三条样式修饰同一p元素，最终应用的就是第三条权重值最大的样式。
##总有例外
那么，如果同时有几个选择器规则应用在同一个元素上，我想最终要的那条权重又比其他的比较低，怎么办呢？
还拿一开始那个例子来说，我现在就想让图片宽度为150px，即应用元素选择器中的样式，在不注释和删除其他样式的情况下，我该怎么做，答案就是：
###！important
!important允许开发人员强制应用某样式，他的用法是写在该样式的某属性值后，结束分号前，以便强制应用该样式，如：

	 <style>
	        img { width: 150px !important;}
	    </style>

我们看看效果：
![a25eff7503d0847632d6bc9a3e7751c6.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c80abe653e7fb07e2fa8645ce900c72b.png)
成功了！
> 注意：在开发中不到万不得已，尽量不要使用此方法，建议通过改变选择器类型来改变权重。至于为啥，自行问度娘吧> .

[markdownFile.md](../_resources/07d3712e7c21ae5a65b807ff4348d917.bin)
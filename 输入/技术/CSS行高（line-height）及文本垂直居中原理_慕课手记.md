CSS行高（line-height）及文本垂直居中原理_慕课手记

#  CSS行高（line-height）及文本垂直居中原理

 2016-05-16 23:37:18  1959浏览  [2评论](http://www.imooc.com/article/7767#comment)

在CSS中，line-height 属性设置两段段文本之间的距离，也就是行高，如果我们把一段文本的line-height设置为父容器的高度就可以实现文本垂直居中了，比如下面的例子：

	<!DOCTYPE html>
	    <html lang="en">
	    <head>
	       <meta charset="UTF-8">
	       <title>Document</title>
	       <style>
	       div {
	           width: 300px;
	           height: 200px;
	           border: 1px solid red;
	       }
	       span {
	           line-height: 200px;
	       }
	      </style>
	</head>
	<body>
	   <div>
	       <span>文本垂直居中原理</span>
	   </div>
	</body>
	</html>

这样，span标签中的文字就相对于div垂直方向居中了，想要文本水平居中设置text-align：center即可。
![图片描述](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134002.png)
那么，它怎么就垂直居中了？为了弄清楚它，下面我们先来看几个概念。

1. **行框**
在浏览器中，会将给每一段文本生成一个**行框**，行框的高度就是行高。行框由上间距、文本高度、下间距组成，上间距的距离与下间距的距离是相等的。
![图片描述](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134005.png)
默认情况下一行文本的行高分为：上间距，文本的高度，下间距，并且上间距是等于下间距的，所以文字默认在这一行中是垂直居中的。
2. **文本中的几条线**
![图片描述](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134010.png)
几条线与行高的关系图解：
![图片描述](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134016.png)
文本的行高也可以看成是基线到基线的距离。
![图片描述](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134020.png)

如果一段文本的高度为16px，如果给他设置line-height的高度为200，那么相当于，文本的上下间距的高度增加了，但是文本本身的高度依然是16是不变的，并且一直默认在行框中垂直居中，而上间距和下间距平分了200px的高度并且减去文本本身的高度。所以，容器被这一行文本占满，而本身文字在自己的一行中是垂直居中的，所以看起来就像是在容器中垂直居中。

3. **Chrome浏览器的默认值**

谷歌浏览器字体的默认大小是：16px，字体的最小值为：12px，默认行高为：18px；默认情况下如果没有给div设置高度，那么这个div的高度会比其中文本的大小大一点（这个大多少现在没有办法确定）

4. **行高的单位**
**px(像素)**
设置起来是最直接的，同时也最方便的。
**%(百分号)**
如果line-height单位设置为%，那么将来在计算的时候，基数是当前标签中的文本的字体的大小。
如果是%,%之前的数据一定是整数 ：150% ，200%
**em**
效果跟%是一样一样的。
注意：一行em的大小相当于是当前标签中的font-size的大小。
如果是em,em之前的数据一定是：1.2em ,1.5em ,2em
**不带单位**
如果不涉及到继承，那么带不带单位（em）都是一样的效果，但是如果涉及到继承的话，那么就有很大的区别了：

- 如果单位是em，那么将来在继承的时候，我们的浏览器会先将行高对应的具体的数值计算出来以后再继承。
- 如果没有单位，那么将来在继承的时候，我们的浏览器会先将line-height这个属性继承给子元素，再在子元素的font-size来计算。line-height: 1.5;

1. **行高可以被继承**
我们知道，CSS的三大特性是继承、层叠、优先级。line-height也是可以被继承的，如下面的示例：

	<!DOCTYPE html>
	<html lang="en">
	<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<style>
	span {
	    display: inline-block;
	}
	</style>
	</head>
	<body>
	<div>
	    <span>中国人</span>
	</div>
	</body>
	</html>

在不给div设置行高的情况下，span标签的文字行高默认为18
![图片描述](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134052.png)
接着我们给div设置一个行高等于20px

	div {
	line-height: 20px;
	}
	span {
	display: inline-block;
	}

我们再来看看span标签的的变化
![图片描述](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134101.png)
而且，不管我们给行高设置什么单位（px、%、em、不带单位）都可以被继承。
2. **行高计算的基数**

如果行高的单位不是px，那么将来行高要进行计算：这个计算需要一个基数，这个基数是当前标签的字体大小，而不是浏览器默认字体大小。以上面的例子为例，我们并没有设置任何字体大小，此时我们把line-height设置为150%，那么文字的行高将变为24px（16px*1.5=24）。

	div {
	   line-height: 150%;
	}

效果如下
![图片描述](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134105.png)
此时我们在给div设置一个font-size等于20px：

	div {
	line-height: 150%;
	font-size:20px;
	}

那么文字的行高将会变成30px，20px*1.5=30px;
![图片描述](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134110.png)

 相关标签：  [Html/CSS](http://www.imooc.com/article/tag/5)

- [![57be62af0001e22c02540242-100-100.jpg](../_resources/fc0ebc61215540ba947e0f883ec549d9.jpg)](http://www.imooc.com/u/112179/articles)
- [![57fa4d4b000114db04190419-100-100.jpg](../_resources/fd6eb251eb9ecfa08b19bcb34d054499.jpg)](http://www.imooc.com/u/173711/articles)
- [![54f87a040001b14b01000100-100-100.jpg](../_resources/b14bc156ee390161e57d8190c5e9b14d.jpg)](http://www.imooc.com/u/1293820/articles)
- [![5729c3fe0001a8ee03130220-100-100.jpg](../_resources/0597df3e9d873c927bdf7926c6ded18e.jpg)](http://www.imooc.com/u/2044875/articles)
- [![545868f30001886f02200220-100-100.jpg](../_resources/ee57b443459e961e382ab3279fea8ebd.jpg)](http://www.imooc.com/u/2903231/articles)
- [![56f3571d00013c8302660167-100-100.jpg](../_resources/e530b3f3bb2c2ef80372f0103041b3db.jpg)](http://www.imooc.com/u/3093224/articles)
- [![576763070001f39d05600560-100-100.jpg](../_resources/7cdfd19edfcdbb296465332808e78e7b.jpg)](http://www.imooc.com/u/3233775/articles)
- [![545869510001a20b02200220-100-100.jpg](../_resources/77e4c1baa7a37b40f100ad0b1753900b.jpg)](http://www.imooc.com/u/3340670/articles)
- [![5458639d0001bed702200220-100-100.jpg](../_resources/c54b2b79b94d8e9632d92d798a195569.jpg)](http://www.imooc.com/u/3374119/articles)

 12  人推荐

- [](http://www.imooc.com/article/7767#)  [](http://www.imooc.com/article/7767#)  [](http://www.imooc.com/article/7767#)  .

   收藏
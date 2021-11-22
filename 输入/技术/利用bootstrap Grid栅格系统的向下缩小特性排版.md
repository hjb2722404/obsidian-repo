利用bootstrap Grid栅格系统的向下缩小特性排版

# 利用bootstrap Grid栅格系统的向下缩小特性排版

bootstrap
技巧
栅格布局

我们都知道，bootstrap栅格系统为我们提供了.col-xs*,.col-sm-*,.col-md-*,.col-lg-* 四种布局类来方便我们快速构建响应式布局。

四种类对应的屏幕最小宽度如下：
![6c5a1c9f490b674293e535f8f1d651c1.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120820.png)
现在设想一下，我们有一块布局，需要在小屏幕上显示为两栏布局，而在超小屏幕上显示为单栏布局，我们自然会想到以下方案：

	<div class="row">
	    <div class="col-sm-6 col-xs-12"></div>
	    <div class="col-sm-6 col-xs-12"></div>
	</div>

这样写，对不对呢？严格来说，对！
但是，这样写会增加开发量增加代码冗余，因为我们本可以有更好的方案。
在bootstrap官方文档中，有这么一句不起眼的话：

> 栅格类适用于与屏幕宽度大于或等于分界点大小的设备 ， 并且针对小屏幕设备覆盖栅格类。 因此，在元素上应用任何 .col-md-* 栅格类适用于与屏幕宽度大于或等于分界点大小的设备 ， 并且针对小屏幕设备覆盖栅格类。 因此，在元素上应用任何 .col-lg-* 不存在， 也影响大屏幕设备。

什么意思呢，用人话说就是，如果你给一个块设置了适用于某一种屏幕的类，那么在屏幕宽度等于或大于它的最大分界点的设备上，同一行内布局不变，在屏幕宽度小于它的最小分界点的设备上，将自动变为单栏布局。

所以，上面的代码可以改为：

	<div class="row">
	    <div class="col-sm-6"></div>
	    <div class="col-sm-6"></div>
	</div>

**除非你有意在更小的屏幕上也要分栏，一般来说，你不需要单独为更小的屏幕设置栅格类。**
相反，在更大的屏幕上，你要是希望它仍旧保持为两栏，那你也不必这样写：

	<div class="row">
	    <div class="col-sm-6 col-md-6"></div>
	    <div class="col-sm-6 col-md-6"></div>
	</div>

因为你无论给不给它们加.col-md-6类，它们最终在大屏幕上的显示效果不会有任何不同。
所以，以下代码：

	<div class="row">
	    <div class="col-sm-6 col-xs-12 col-md-6"></div>
	    <div class="col-sm-6 col-xs-12 col-md-6"></div>
	</div>

等同于：

	<div class="row">
	    <div class="col-sm-6"></div>
	    <div class="col-sm-6"></div>
	</div>

以上所示例为两栏的情况，多栏的原理是一样的，有兴趣的同学可以自己做做试验。
[markdownFile.md](../_resources/5c5939d215b83ef8829650d3880543b0.bin)
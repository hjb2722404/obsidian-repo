利用Responsive Nav.js插件制作响应式导航

# 利用Responsive Nav.js插件制作响应式导航

响应式设计

在制作响应式Web站点的过程中，导航的响应式设计是很重要的一个环节，Responsive Nav是bootstrap官方推荐的一款响应式导航制作插件，官方站点：

[响应式导航（Responsive Nav）](http://www.bootcss.com/p/responsive-nav.js/)
但是，官方给出了使用示例是最简单的一个例子，里面的链接都还是带下划线的蓝色链接字体，小屏下的menu也只是一个链接，没有样式。
根据官方示例的原理，设计了一款带有简单样式的导航，这是宽屏下的显示效果：
![be85f231f2a6bfc41c1d7a05f3962d87.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231121105.png)
下面是PAD同等宽度屏幕上的显示效果：
![19d54b328784d5fa42c2a7d805bc7b02.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231121058.png)
下面是手机屏幕上显示效果：
![ef49388b79fbcae4ea01a5b73f9729ca.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231121110.png)
直接上代码：
**responsiveNav.html**

	<!DOCTYPE html>
	<html>
	<head lang="en">
	    <meta charset="UTF-8">
	    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
	    <title>响应式导航测试</title>
	<!--    <link rel="stylesheet" href="css/bootstrap.min.css"/> -->
	    <link rel="stylesheet" href="css/myNav.css"/>
	    <link rel="stylesheet" href="css/responsive-nav.css"/>
	    <!--调用responsive nav的css样式表文件-->
	    <!--    <script type="text/javascript" src="js/jquery.js"></script>
	      <script type="text/javascript" src="js/bootstrap.min.js"></script> -->
	    <script type="text/javascript" src="js/responsive-nav.min.js"></script>
	    <!--调用responsive nav的js插件-->
	</head>
	<body>
	    <div class="container">
	
	        <div class="row"> <!--两个外层DIV是为了整合bootstrap插件-->
	
	            <nav class="nav-collapse"> <!--这里的className就是下方插件要调用的参数-->
	
	                <ul>
	                    <li>
	                        <a href="#">首页</a>
	                    </li>
	                    <li>
	                        <a href="#">导航项目一</a>
	                    </li>
	                    <li>
	                        <a href="#">导航项目二</a>
	                    </li>
	                    <li>
	                       <a href="#">导航项目三</a>
	                    </li>
	                    <li>
	                        <a href="#">导航项目四</a>
	                    </li>
	                </ul>
	
	            </nav>
	        </div>
	
	    </div>
	    <script>
	        var navigation = responsiveNav(".nav-collapse");
	        <!--这里就是该插件最简单的调用方式，更多的设置请参考官网说明-->
	    </script>
	</body>
	</html>

**myNav.css：**

	ul ,li { margin: 0; padding: 0;} //reset浏览器默认样式
	.nav-collapse { min-height: 60px; }//设置导航的最小高度
	.nav-collapse ul { width:100%;list-style-type: none; background: #333333;}//为导航设置
	.nav-collapse ul li { max-height: 40px; line-height: 40px; display: inline-block; background-color: #333333;}
	//设置li样式，这里需要特别注意，这里一定要将li的display设置为inline-block，这样项目才能在行内显示，千万不要是用float:left这样的语句，否则Responsive Nav插件会失效
	.nav-collapse ul li a{ width: 100%; height: 100%; text-decoration: none; color: #cccccc; display: block; text-align: center; font-weight: bold;}
	.nav-collapse ul li a:hover { background: #cccccc; color: #333333;} //为链接设置样式
	
	//大屏显示时，li的宽度要指定，否则大屏下会显示为100%宽度；
	@media screen and (min-width: 40em) {
	
	    .nav-collapse ul li { width: 18%; } //这里的数字根据导航项目的数量自己计算得到；
	}
	
	/*为menu菜单设置简单样式，你也可以设置为图片*/
	.nav-toggle {
	    width: 40px;
	    height: 30px;
	    line-height: 30px;
	    text-decoration: none;
	    background: #333;
	    color: #fff;
	    display: block;
	    text-align: center;
	}

基本上就是以上代码，可以根据这样的基本原理，制作出更多可变的响应式导航
[markdownFile.md](../_resources/451672af95bce61540ae704381bf5dd4.bin)
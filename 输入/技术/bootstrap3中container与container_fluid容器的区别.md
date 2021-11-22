bootstrap3中container与container_fluid容器的区别

# bootstrap3中container与container_fluid容器的区别

理论知识
.container与.container_fluid是bootstrap中的两种不同类型的外层容器，按照官方的说法，这两者的区别是：
> .container 类用于固定宽度并支持响应式布局的容器。
> .container-fluid 类用于 100% 宽度，占据全部视口（viewport）的容器。
一开始，我以为所谓固定宽度是开发者可以设置该容器为固定宽度，所以我采用了如下布局样式：

	<body>

	    <div class="container" style="width: 800px" >

	        <div class="col-md-6">

	            <p>官方解释container容器用于固定宽度并且能够自适应布局，我现在给外层应用了container类的div设置一个固定宽度800px，用来测试是否能实现自适应</p>

	        </div>

	        <div class="col-md-6">
	            <img src="image/QQ截图20150423144403.png" alt="" style="width:100%;"/>
	        </div>

	    </div>

	</body>

当我这样做了以后，我发现，缩小浏览器宽度到小于800px的值时，内容不再自适应了，所以，我调出了调试台，看了bootstrap.css中对.container的定义：

	.container{
	    padding-right:15px;
	    padding-left:15px;
	    margin-right:auto;
	    margin-left:auto
	}

	@media (min-width:768px){
	    .container{
	        width:750px
	    }

	}

	@media (min-width:992px){
	    .container{
	        width:970px
	    }

	}

	@media (min-width:1200px){
	    .container{
	        width:1170px
	    }

	}

我忽然明白，所谓固定宽度并不是允许开发者自己设置容器的宽度，而是bootstrap内部根据屏幕宽度利用媒体查询，帮我们设置了固定宽度，并且是能够自适应的。
所以，无论何种情况下，请不要手动为响应式布局中的外层布局容器设置固定宽度值。
那么，.container-fluid，又是怎样的呢？
根据测试，.container-fluid自动设置为外层视窗的100%，如果外层视窗为body，那么它将全屏显示，无论屏幕大小，并且自动实现响应式布局。
[markdownFile.md](../_resources/41f705ea3a7a2774cd9c8bd035d1f2ca.bin)
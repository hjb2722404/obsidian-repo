如何把css'content的操作跟价值发挥到最大💢 - 掘金

[(L)](https://juejin.im/user/2911162518997064)

[ 聪明的汤姆   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzM0RDE5QiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYuMzMzIDRMMTcgM3YzaC0yek0xNSA2aDJ2NGgtMnpNMTcgOGgxdjJoLTF6TTE3IDNoMXYyaC0xek0xOCAzaDJ2OGgtMnoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/2911162518997064)

2019年08月16日   阅读 5199

# 如何把css'content的操作跟价值发挥到最大

`content`属性需要与`before`及`after`伪元素配合使用，作用是可以定义`伪元素`所显示的内容，本文主要列举`content`的可选值及实用的案例与技巧

## 基本用法

一个简单的例子：

	<p>「不会写前端」</p>
	复制代码
	p {
	  &::before {
	    content: "欢迎关注"
	  }
	
	  &::after {
	    content: "微信公众号"
	  }
	}
	复制代码

浏览器显示的是这个亚子：
[1](../_resources/4dad2b6ada377cf7edcdb2dea6c11fe4.webp)

我们看看实际上在浏览器渲染的结构：
[1](../_resources/704760bb3639a15beb101fa578abffa8.webp)

没错，就是这么粗暴，就跟他们的名字一样，一前一后
值得注意的是，在新的规范中，单冒号指`伪类`、双冒号指`伪元素`，就算你写成`:after`，标准的浏览器还是会渲染成`::after`，目的是兼容旧写法

## 可取的值

1. 普通字符
2. `unicode`
3. `attr`函数
4. `url`函数
5. `counter`函数
6. `css`变量

## 逐一使用

为了使文章简洁，下面有部分`content`属性在外层省略父元素：

	// 原始
	p {
	  &::after {
	    content: "";
	  }
	}
	
	// 省略后
	content: "";
	复制代码

#### 1. 普通字符

	content: "我是文字内容";
	复制代码

#### 2. unicode

浏览器自带的特殊字符：

	p {
	  &:after {
	    content: "\02691";
	    color: red;
	  }
	}
	复制代码

显示如下：
[1](../_resources/2be48dd6006af216a2a1007b536788f1.webp)

[html特殊字符对照表](https://www.22vd.com/33993.html)

* * *

`iconfont`自定义字体图标：

	<span class="icon icon-close"></span>
	复制代码
	@font-face {
	  font-family: "iconfont";
	  src: url('//at.alicdn.com/t/font_1209853_ok7e8ntkhr.ttf?t=1560857741304') format('truetype');
	}
	
	.icon {
	  font-family: "iconfont";
	}
	
	.icon-close::before {
	  content: "\e617";
	}
	复制代码

显示如下：

[1](../_resources/67f2b4d98387f98e5d0252a89e447e5b.webp)

[iconfont-阿里巴巴矢量图标库](https://www.iconfont.cn/)

#### 3. attr函数

顾名思义，这个函数可以获取`html`元素中某一属性的值，如`id`、`class`、`style`等

	<p data-content="我是文字内容"></p>
	复制代码
	content: attr(data-content);
	复制代码

#### 4. url函数

显示我的掘金头像：

	content: url("https://user-gold-cdn.xitu.io/2019/8/7/16c681a0fb3e84c4?imageView2/1/w/180/h/180/q/85/format/webp/interlace/1");
	复制代码

显示如下：

[1](../_resources/5b6ec93b8d2dc7a68dcfc710ad6d02e9.webp)

缺点就是无法控制图片的大小

#### 5. counter函数

`counter`函数的作用是插入计数器的值，配合`content`属性可以把计数器里的值显示出来，介绍用法之前，得先熟悉两个属性`counter-reset`跟`counter-increment`

* * *

`counter-reset`的作用是定义一个计数器：

	counter-reset: count1 0; // 声明一个计数器count1，并从0开始计算
	counter-reset: count2 1; // 声明一个计数器count2，并从1开始计算
	counter-reset: count3 0 count4 0 count5 0; // 声明多个计数器
	复制代码

* * *

`counter-increment`使计数器的值递增，可以理解成`javascript`中的`+=`：

	counter-reset: count 0;
	counter-increment: count 2; // 使count自增2，当前count的值为2
	counter-increment: count -2; // 使count自增-2，当前count的值为-2
	复制代码

注意，这里的计数器`count`的值为什么不是变回了`0`，可以理解成样式覆盖，就如以下代码：

	div {
	  width: 100px;
	  width: 200px; // 实际渲染的宽度
	}
	复制代码

#### 6. css变量

显示变量的时候，如果变量是`string`类型则可以直接显示，如果是`int`类型，则需要借用`counter`函数

	// string类型
	--name: "不会写前端";
	
	p {
	  &::after {
	    content: var(--name); // 显示为"不会写前端"
	  }
	}
	
	---------- 我是分割线 ----------
	
	// int类型
	--count: 60;
	
	p {
	  &::after {
	    counter-reset: color var(--count);
	    content: counter(count); // 显示为"60"
	  }
	}
	
	---------- 我是分割线 ----------
	
	// 不支持的类型及情况
	--count: 60.5; // 显示为"0"，不支持小数
	--count: 60px; // 显示为""，不支持css属性值
	复制代码

## 拼接

普通字符串拼接：

	content: "xxx" + "xxx";
	复制代码

字符串拼接函数：

	// 不能使用 + 连接符，也可以不需要空格，这里只是为了区分
	content: "我支持" attr(xx);
	count: "我的掘金头像：" url("xxxxx");
	content: "计数器的值为：" counter(xx);
	复制代码

隐性转换：

	content: 0; // 显示为""
	content: "" + 0; // 显示为"0"
	content: "" + attr(name); // 显示为"attr(name)"
	复制代码

## 实用案例

#### 1. 当a标签内容为空时，显示其`href`属性里面的值：

	<a href="https://juejin.im/user/2911162518997064"></a>
	复制代码
	a {
	  &:empty {
	    &::after {
	      content: "链接内容为：" attr(href);
	    }
	  }
	}
	复制代码

显示如下：
[1](../_resources/8112e498fe9537d66a2d5f61a5c257f9.webp)

#### 2. 面包屑跟分隔符

	<ul>
	  <li>首页</li>
	  <li>商品</li>
	  <li>详情</li>
	</ul>
	复制代码
	ul {
	  display: flex;
	  font-weight: bold;
	
	  li {
	    &:not(:last-child) {
	      margin-right: 5px;
	
	      &::after {
	        content: "\276D";
	        margin-left: 5px;
	      }
	    }
	  }
	}
	复制代码

显示如下：
[1](../_resources/ff0f38662ac8c09465236924dc19e953.webp)

[1](../_resources/735e67190b8db01642fd2531bf5bbcdb.webp)

之前还这样写来着

	<li v-for="(item, index) in list">
	  <span>{{item}}</span>
	  <span v-show="index < list.length - 1">、</span>
	</li>
	复制代码

#### 3. 进度条

	<div class="progress" style="--percent: 14;"></div>
	<div class="progress" style="--percent: 41;"></div>
	<div class="progress" style="--percent: 94;"></div>
	复制代码
	.progress {
	  width: 400px;
	  height: 17px;
	  margin: 5px;
	  color: #fff;
	  background-color: #f1f1f1;
	  font-size: 12px;
	
	  &::before {
	    counter-reset: percent var(--percent);
	    content: counter(percent) "%"; // 文字显示
	
	    display: inline-block;
	    width: calc(100% * var(--percent) / 100); // 宽度计算
	    max-width: 100%; // 以防溢出
	    height: inherit;
	    text-align: right;
	    background-color: #2486ff;
	  }
	}
	复制代码

显示如下：
[1](../_resources/34aa399eada19bb6adcacb376e80d065.webp)

加个过渡效果：

	transition: width 1s ease; // 页面首次进入没有过渡效果，因为width必须要发生变化才行
	复制代码

![16c9882fafa444f5](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231180547.gif)

鱼和熊掌不可兼得，如果只靠`css`，想在页面首次进入触发动画效果，那只有`animation`才能做到了

	.progress {
	  &::before {
	    // 移除width跟transition属性
	    animation: progress 1s ease forwards;
	  }
	
	  @keyframes progress {
	    from {
	      width: 0;
	    }
	
	    to {
	      width: calc(100% * var(--percent) / 100);
	    }
	  }
	}
	复制代码

页面刷新后效果如下：
![16c988685491bc7d](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231180623.gif)

参考文章：[小tips: 如何借助content属性显示CSSvar变量值](https://www.zhangxinxu.com/wordpress/2019/05/content-css-var/)

#### 4. tooltip提示

	<button data-tooltip="我是一段提示">按钮</button>
	复制代码
	[data-tooltip] {
	  position: relative;
	
	  &::after {
	    content: attr(data-tooltip); // 文字内容
	    display: none; // 默认隐藏
	    position: absolute;
	
	    // 漂浮在按钮上方并居中
	    bottom: calc(100% + 10px);
	    left: 50%;
	    transform: translate(-50%, 0);
	
	    padding: 5px;
	    border-radius: 4px;
	    color: #fff;
	    background-color: #313131;
	    white-space: nowrap;
	    z-index: 1;
	  }
	
	  // 鼠标移入button的时候显示tooltip
	  &:hover {
	    &::after {
	      display: block;
	    }
	  }
	}
	复制代码

效果如下：
![16c98467c903e1bb](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231180639.gif)

多方向、主题、动画实现可以移步我之前写过的一篇文章：[利用css‘content实现指令式tooltip文字提示](https://juejin.im/post/6844903891184648205)

#### 5. 计算checkbox选中的个数

	<form>
	  <input type="checkbox" id="one">
	  <label for="one">波霸奶茶</label>
	  <input type="checkbox" id="two">
	  <label for="two">烤奶</label>
	  <input type="checkbox" id="three">
	  <label for="three">咖啡</label>
	
	  <!-- 输入结果 -->
	  <div class="result">已选中：</div>
	</form>
	复制代码
	form {
	  counter-reset: count 0;
	
	  // 当checkbox选中的时候，计数器自增1
	  input[type="checkbox"] {
	    &:checked {
	      counter-increment: count 1;
	    }
	  }
	
	  // 输出结果
	  .result {
	    &::after {
	      content: counter(count);
	    }
	  }
	}
	复制代码

效果如下：
![16c98515482fbbed](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231180645.gif)

#### 6. 给目录加章节计数

	<!-- 章节 -->
	<ul class="section">
	  <li>
	    <h1>自我介绍</h1>
	
	    <!-- 子章节 -->
	    <ul class="subsection">
	      <li>
	        <h2></h2>
	      </li>
	      <li>
	        <h2></h2>
	      </li>
	    </ul>
	  </li>
	
	  <li>
	    <h1>写一段css代码</h1>
	  </li>
	</ul>
	复制代码
	// 章节
	.section {
	  counter-reset: section 0; // 外层计数器
	
	  h1 {
	    &::before {
	      counter-increment: section 1; // 自增1
	      content: "Section"counter(section) ". ";
	    }
	  }
	
	  // 子章节
	  .subsection {
	    counter-reset: subsection 0; // 内层计数器
	
	    h2 {
	      &::before {
	        counter-increment: subsection 1; // 自增1
	        content: counter(section) "."counter(subsection); // 计数器是有作用域的，这里可以访问外层计数器
	      }
	    }
	  }
	}
	复制代码

显示如下：
[1](../_resources/f3a28737cb33d648edccf04355def7c1.webp)

#### 7. 加载中...动画

	<p>加载中</p>
	复制代码
	p {
	  &::after {
	    content: ".";
	    animation: loading 2s ease infinite;
	
	    @keyframes loading {
	      33% {
	        content: "..";
	      }
	
	      66% {
	        content: "...";
	      }
	    }
	  }
	}
	复制代码

效果如下：
![16c992eb9037c7e0](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231180707.gif)

#### 8. 无更多数据

	<div class="no-more">无更多数据</div>
	复制代码
	.no-more {
	  &::before {
	    content: "——";
	    margin-right: 10px;
	  }
	
	  &::after {
	    content: "——";
	    margin-left: 10px;
	  }
	}
	复制代码

效果如下：
[1](../_resources/2adb6e2fb5f9a767602db3cdcfc8688a.webp)

## 总结

`content`始终都需要配合`before`跟`after`伪元素使用，主要是显示一些`额外`的信息，更多案例需要大家去挖掘，只要脑洞大，篇幅较长，如有内容或知识点出错，请大家纠正!

## 往期推荐

[讲道理，仅3行核心css代码的rate评分组件，我被自己秀到头皮发麻‍♂️](https://juejin.im/post/6844903919106129934)

[contenteditable跟user-modify还能这么玩️](https://juejin.im/post/6844903910809796621)
[css掩人耳目式海浪动效，这可能是最简单的实现方式了吧？️](https://juejin.im/post/6844903909169823757)

## 最后

如果你觉得这篇文章不错，请别忘记点个`赞`跟`关注`哦~
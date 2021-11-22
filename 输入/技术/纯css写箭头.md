# 纯css写箭头


	<!DOCTYPE html>
	<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">

	<head>
	  <title>CSS 箭头Demo</title>
	  <style type="text/css">
	    /* 向上的箭头,类似于A,只有三个边，不能指定上边框 */

	    div.arrow-up {
	      width: 0;
	      height: 0;
	      border-left: 5px solid transparent;
	      /* 左边框的宽 */
	      border-right: 5px solid transparent;
	      /* 右边框的宽 */
	      border-bottom: 5px solid #2f2f2f;
	      /* 下边框的长度|高,以及背景色 */
	      font-size: 0;
	      line-height: 0;
	    }
	    /* 向下的箭头 类似于 V */

	    div.arrow-down {
	      width: 0;
	      height: 0;
	      border-left: 20px solid transparent;
	      border-right: 20px solid transparent;
	      border-top: 20px solid #f00;
	      font-size: 0;
	      line-height: 0;
	    }
	    /* 向左的箭头: 只有三个边：上、下、右。而 <| 总体来看，向左三角形的高=上+下边框的长度。 宽=右边框的长度 */

	    div.arrow-left {
	      width: 0;
	      height: 0;
	      border-bottom: 15px solid transparent;
	      /* 下边框的高 */
	      border-top: 15px solid transparent;
	      /* 上方边框的高 */
	      border-right: 10px solid yellow;
	      /* 右边框的长度|宽度，以及背景色 */
	      font-size: 0;
	      line-height: 0;
	    }
	    /* 向右的箭头: 只有三个边：上、下、左。而 |> 总体来看，向右三角形的高=上+下边框的长度。 宽=左边框的长度 */

	    div.arrow-right {
	      width: 0;
	      height: 0;
	      border-bottom: 15px solid transparent;
	      /* 下边框的高 */
	      border-top: 15px solid transparent;
	      /* 上方边框的高 */
	      border-left: 60px solid green;
	      /* 左边框的长度|宽度，以及背景色 */
	      font-size: 0;
	      line-height: 0;
	    }
	    /* 基本样式 */

	    .tip {
	      background: #eee;
	      border: 1px solid #ccc;
	      padding: 10px;
	      border-radius: 8px;
	      box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
	      position: relative;
	      width: 200px;
	    }
	    /* 箭头 - :before and :after, 一起组成了好看的气泡小箭头 */

	    .tip:before {
	      position: absolute;
	      display: inline-block;
	      border-top: 7px solid transparent;
	      border-right: 7px solid #eee;
	      border-bottom: 7px solid transparent;
	      border-right-color: rgba(0, 0, 0, 0.2);
	      left: -8px;
	      top: 20px;
	      content: '';
	    }
	    /* 背景阴影*/

	    .tip:after {
	      position: absolute;
	      display: inline-block;
	      border-top: 6px solid transparent;
	      border-right: 6px solid #eee;
	      border-bottom: 6px solid transparent;
	      left: -6px;
	      top: 21px;
	      content: '';
	    }
	  </style>
	</head>

	<body>
	  <div id="contentHolder">
	    <h1>CSS 箭头Demo</h1>
	    <p>以下代码.是极好的纯 CSS 箭头样式，不使用背景图!</p>
	    <div id="position:relative;">
	      <div class="arrow-up">向上的箭头</div>

	      <div class="arrow-down">向下的箭头</div>

	      <div class="arrow-left">向左的箭头</div>

	      <div class="arrow-right">向右的箭头</div>
	    </div>
	    <h2>CSS 箭头气泡 ，使用 伪类(Pseudo-Element)</h2>
	    <div style="position:relative;">
	      <div class="tip">
	        企业级开发首选技术是什么？JavaEE和.Net哪个技术更好？在JavaEE开发中主要用哪些框架？另外在移动大热的趋势下如何开发出一个成功的Android产品？
	      </div>
	      <br/>
	      <div class="tip">
	        向左的箭头: 只有三个边：上、下、右。而
	        < | 总体来看，向左三角形的高=上+下边框的长度。 宽=右边框的长度 向右的箭头: 只有三个边：上、下、左。而 |> 总体来看，向右三角形的高=上+下边框的长度。 宽=左边框的长度 向上的箭头,类似于A,只有三个边，不能指定上边框
	      </div>
	    </div>
	  </div>
	</body>

	</html>
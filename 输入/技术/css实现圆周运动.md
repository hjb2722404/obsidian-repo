css实现圆周运动

# css实现圆周运动

[![2-9636b13945b9ccf345bc98d0d81074eb.jpg](../_resources/9636b13945b9ccf345bc98d0d81074eb.jpg)](https://www.jianshu.com/u/368d0bf007d7)

[laohan](https://www.jianshu.com/u/368d0bf007d7)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='286'%3e%3cpath d='M751.144277 307.2l-123.016533-238.933333h159.778133a81.92 81.92 0 0 1 59.1872 25.258666l160.256 167.492267A27.306667 27.306667 0 0 1 987.620011 307.2h-236.475734z m270.506667 111.547733L640.927744 946.039467a27.306667 27.306667 0 0 1-48.128-24.234667L766.504277 375.466667h-56.388266l-170.5984 590.165333a27.306667 27.306667 0 0 1-52.462934 0.034133L315.500544 375.466667H259.112277l174.523734 545.5872a27.306667 27.306667 0 0 1-48.128 24.302933L5.160277 418.747733A27.306667 27.306667 0 0 1 27.346944 375.466667H999.464277a27.306667 27.306667 0 0 1 22.152534 43.281066zM18.301611 261.0176L178.557611 93.525333A81.92 81.92 0 0 1 237.744811 68.266667h159.744L274.506411 307.2H38.030677a27.306667 27.306667 0 0 1-19.729066-46.1824zM453.877077 68.266667h117.896534l122.9824 238.933333H330.894677l122.9824-238.933333z' data-evernote-id='169' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*0.0962016.07.25 21:55:33字数 500阅读 4,714

## 自身旋转

旋转元素，首先想到的就是rotate这个属性。

	.circle {
	    width: 30px;
	    height: 30px;
	    background: #aaa;
	    animation: spin 3s linear;
	}
	@keyframes spin{
	    to {
	        transform: rotate(1turn);
	    }
	}
	1234567891011

详见[https://jsfiddle.net/8nt3k843/](https://link.jianshu.com/?t=https://jsfiddle.net/8nt3k843/)

## 绕圆旋转

rotate可以实现旋转，但只是绕自身旋转，是以其中心为圆心，进行旋转。如果想实现绕着一个圆进行旋转，则需要多用到一个属性了。

	.container {
	    width: 300px;
	    height: 300px;
	    border: 1px dotted red;
	    border-radius: 50%;
	    position: relative;
	    box-sizing: border-box;
	}
	.circle {
	    position: absolute;
	    left: 50%;
	    top: 0;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    background: #aaa;
	    transform-origin: 0 150px;
	    animation: spin 3s infinite linear
	}
	12345678910111213141516171819

如上代码，增加***transform-origin***这个属性，***使旋转的中心刚好位于圆的中心***，这样就可以实现绕圆旋转了。

详见[https://jsfiddle.net/ysm0Lurg/](https://link.jianshu.com/?t=https://jsfiddle.net/ysm0Lurg/)

## 绕圆旋转，内容不转

乍一看，实现了绕圆的效果，但注意到我们的旋转的元素是没有内容的，如果有内容的话，又会如何呢

效果见[https://jsfiddle.net/7fc06a9c/](https://link.jianshu.com/?t=https://jsfiddle.net/7fc06a9c/)

可以看到，旋转元素里面的内容也跟着元素一起旋转起来，但这并不是我们想要的效果。
有没有什么方法可以让内容不跟着一起旋转呢？其实很简单，再嵌套一层，然后让里面的内容进行反方向旋转就好了。

	.circle{
	    animation: spin 3s linear;
	}
	.content {
	    animation: inherit;
	    animation-direction: reverse;
	}
	1234567

代码详见[https://jsfiddle.net/t1cnn6fo/](https://link.jianshu.com/?t=https://jsfiddle.net/t1cnn6fo/)

## 绕圆旋转，不而外嵌套

通过嵌套多了一层，让内外层往不同的方向旋转，达到内容不旋转的效果。那么，有没有可能不而外嵌套呢，方法也是有的。
那就是利用***translate***来实现。

	@keyframes spin {
	from {
	    transform: translate(-50%, 135px) rotate(0turn) translate(50%, -135px) rotate(1turn)
	}
	to {
	    transform: translate(-50%, 135px) rotate(1turn) translate(50%, -135px) rotate(0turn)
	}
	}
	12345678

先利用translate，将旋转的中心与圆的中心重合，然后进行旋转，之后又利用translate，移动到原先的位置。最后再围绕自身中心，进行反方向旋转，以达到内容不旋转的效果

代码详见[https://jsfiddle.net/243wbskt/](https://link.jianshu.com/?t=https://jsfiddle.net/243wbskt/)

其实，最关键的一点还是在于坐标的转换，如下所示：

	// 核心要点

	// css
	transform-origin: x y;  // x, y为元素左上角相对圆心坐标的距离
	transform: rotate(30deg);

	// 等价于
	// transform-origin: 0 0;
	transform: translate(x, y); // x, y为元素左上角相对圆心坐标的距离
	transform: rotate(30deg);
	transform: translate(-x, -y); // x, y为元素左上角相对圆心坐标的距离
	1234567891011

参考链接：[http://www.w3cplus.com/css3/css-secrets/animation-along-a-circular-path.html](https://link.jianshu.com/?t=http://www.w3cplus.com/css3/css-secrets/animation-along-a-circular-path.html)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='598'%3e%3cpath d='M728.064 343.943529c-17.648941-2.891294-23.552-20.239059-26.503529-28.912941V104.026353C701.560471 46.200471 654.396235 0 595.425882 0c-53.007059 0-97.28 40.478118-106.134588 89.569882-29.997176 184.862118-138.541176 255.457882-217.630118 280.937412a26.142118 26.142118 0 0 0-18.130823 24.877177v560.067764c0 19.817412 16.022588 35.84 35.84 35.84h535.973647c56.018824-11.565176 94.328471-31.804235 120.892235-86.738823l120.832-416.105412c23.552-75.173647-14.757647-147.395765-100.231529-144.564706h-238.772706z m-571.813647 31.744H76.619294C35.358118 375.687529 0 410.383059 0 450.861176v462.426353c0 43.369412 32.406588 78.004706 76.619294 78.004706h79.631059c27.708235 0 50.115765-22.407529 50.115765-50.115764V425.863529a50.115765 50.115765 0 0 0-50.115765-50.115764z' data-evernote-id='163' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

11人点赞*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='64 64 896 896' focusable='false' class='js-evernote-checked' data-icon='right' width='1em' height='1em' fill='currentColor' aria-hidden='true' data-evernote-id='602'%3e%3cpath d='M765.7 486.8L314.9 134.7A7.97 7.97 0 0 0 302 141v77.3c0 4.9 2.3 9.6 6.1 12.6l360 281.1-360 281.1c-3.9 3-6.1 7.7-6.1 12.6V883c0 6.7 7.7 10.4 12.9 6.3l450.8-352.1a31.96 31.96 0 0 0 0-50.4z' data-evernote-id='603' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='607'%3e%3cpath d='M771.413333 668.728889c-18.773333 3.015111-25.031111 20.878222-28.16 29.866667v217.884444c0 59.733333-49.948444 107.52-112.412444 107.52a115.427556 115.427556 0 0 1-112.412445-92.558222c-31.857778-190.919111-146.830222-263.850667-230.627555-290.133334a27.420444 27.420444 0 0 1-19.228445-26.168888V37.944889C268.572444 17.066667 285.582222 0 306.631111 0h567.864889c59.335111 11.946667 99.953778 32.824889 128 89.543111l128.113778 429.909333c24.974222 77.653333-15.644444 152.291556-106.211556 149.276445H771.413333z m-605.866666-32.824889H81.180444C37.546667 635.904 0 600.064 0 558.250667V80.611556C0 35.84 34.360889 0 81.180444 0H165.546667c29.297778 0 53.077333 23.779556 53.077333 53.077333v529.749334a53.077333 53.077333 0 0 1-53.077333 53.077333z' data-evernote-id='142' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

[*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='612'%3e%3cpath d='M178.390055 120.591045C111.268624 120.591045 56.888889 174.401955 56.888889 240.556383V903.97778C56.888889 970.302855 111.097977 1024 178.390055 1024h545.731364c67.121431 0 121.558049-53.81091 121.558049-120.02222V240.613265c0-66.268192-54.209088-120.02222-121.558049-120.02222H178.390055z m455.117432 301.136319H269.06087a30.147761 30.147761 0 0 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z m303.18409 301.136318a30.318409 30.318409 0 0 1-30.375291-30.318409V180.317742c0-66.268192-53.81091-120.02222-121.330519-120.022219H329.697688a30.147761 30.147761 0 0 1 0-60.23864l454.946784 0.056882C885.326618 0.113765 967.009987 80.887013 967.009987 180.602155v511.943118a30.318409 30.318409 0 0 1-30.31841 30.318409z m-303.18409-120.47728H269.06087a30.147761 30.147761 0 1 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z' data-evernote-id='153' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*css](https://www.jianshu.com/nb/5321871)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='618'%3e%3cpath d='M232.727273 579.87878833C271.28679 579.87878833 302.545455 548.62012233 302.545455 510.06060633 302.545455 471.50108933 271.28679 440.24242433 232.727273 440.24242433 194.167756 440.24242433 162.909091 471.50108933 162.909091 510.06060633 162.909091 548.62012233 194.167756 579.87878833 232.727273 579.87878833ZM512 579.87878833C550.559516 579.87878833 581.818182 548.62012233 581.818182 510.06060633 581.818182 471.50108933 550.559516 440.24242433 512 440.24242433 473.440484 440.24242433 442.181818 471.50108933 442.181818 510.06060633 442.181818 548.62012233 473.440484 579.87878833 512 579.87878833ZM791.272727 579.87878833C829.832243 579.87878833 861.090909 548.62012233 861.090909 510.06060633 861.090909 471.50108933 829.832243 440.24242433 791.272727 440.24242433 752.713211 440.24242433 721.454545 471.50108933 721.454545 510.06060633 721.454545 548.62012233 752.713211 579.87878833 791.272727 579.87878833Z' data-evernote-id='173' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

"小礼物走一走，来简书关注我"
还没有人赞赏，支持一下

[![2-9636b13945b9ccf345bc98d0d81074eb.jpg](../_resources/9636b13945b9ccf345bc98d0d81074eb.jpg)](https://www.jianshu.com/u/368d0bf007d7)

[laohan](https://www.jianshu.com/u/368d0bf007d7)https://github.com/liuhanqu
总资产1 (约0.09元)共写了3039字获得71个赞共18个粉丝
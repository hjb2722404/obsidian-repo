js drag拖动排序

# js drag拖动排序

[[webp](../_resources/23893946a526c9c47f5909609741f433.webp)](https://www.jianshu.com/u/bbf9a7ff6028)

[虎虎虎呼呼](https://www.jianshu.com/u/bbf9a7ff6028)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='280'%3e%3cpath d='M751.144277 307.2l-123.016533-238.933333h159.778133a81.92 81.92 0 0 1 59.1872 25.258666l160.256 167.492267A27.306667 27.306667 0 0 1 987.620011 307.2h-236.475734z m270.506667 111.547733L640.927744 946.039467a27.306667 27.306667 0 0 1-48.128-24.234667L766.504277 375.466667h-56.388266l-170.5984 590.165333a27.306667 27.306667 0 0 1-52.462934 0.034133L315.500544 375.466667H259.112277l174.523734 545.5872a27.306667 27.306667 0 0 1-48.128 24.302933L5.160277 418.747733A27.306667 27.306667 0 0 1 27.346944 375.466667H999.464277a27.306667 27.306667 0 0 1 22.152534 43.281066zM18.301611 261.0176L178.557611 93.525333A81.92 81.92 0 0 1 237.744811 68.266667h159.744L274.506411 307.2H38.030677a27.306667 27.306667 0 0 1-19.729066-46.1824zM453.877077 68.266667h117.896534l122.9824 238.933333H330.894677l122.9824-238.933333z' data-evernote-id='163' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*12017.09.06 14:02:04字数 694阅读 12,638

这次来做一个拖动排序，带有动画效果，先上效果图，不熟悉拖动api的可以查看[链接](https://www.jianshu.com/p/2489e6a563df)

![5192857-9f25d42f928b9f56.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145605.gif)
效果图

在线演示：[http://jsrun.net/XpiKp/edit](https://link.jianshu.com/?t=http://jsrun.net/XpiKp/edit)

### 思路（先不考虑动画）

每个li既是可拖动，同时也是容器，拖动到li上面时移动拖动的li。
先把html写好

	<ul>
	        <li class="ele" draggable="true">1</li>
	        <li class="ele" draggable="true">2</li>
	        <li class="ele" draggable="true">3</li>
	        <li class="ele" draggable="true">4</li>
	        <li class="ele" draggable="true">5</li>
	        <li class="ele" draggable="true">6</li>
	        <li class="ele" draggable="true">7</li>
	        <li class="ele" draggable="true">8</li>
	    </ul>
	12345678910

css

	ul {
	        list-style: none;
	        margin: 200px;
	        font-size: 0;
	    }
	    .ele {
	        font-size: 16px;
	        width: 100px;
	        height: 40px;
	        border: 1px solid #999;
	        background: #EA6E59;
	        margin: 2px 0;
	        border-radius: 10px;
	        padding-left: 10px;
	        color: white;
	        cursor: move;
	    }
	1234567891011121314151617

下面添加事件，由于拖动是实时的，所以没有使用drop而是使用了dragover。并且用一个变量来保存当前拖动的元素。这里直接使用事件委托，直接使用ul来监听

	var node = document.querySelector("#container");
	var draging = null;
	//使用事件委托，将li的事件委托给ul
	node.ondragstart = function(event) {
	    /firefox设置了setData后元素才能拖动！！！！
	        event.dataTransfer.setData("te", event.target.innerText); //不能使用text，firefox会打开新tab
	        draging = event.target;
	    }
	node.ondragover = function(event) {
	        event.preventDefault();
	        var target = event.target;
	    //因为dragover会发生在ul上，所以要判断是不是li
	        if (target.nodeName === "LI"&&target !== draging) {
	                //_index是实现的获取index
	                if (_index(draging) < _index(target)) {
	                    target.parentNode.insertBefore(draging, target.nextSibling);
	                } else {
	                    target.parentNode.insertBefore(draging, target);
	                }
	        }
	    }
	
	12345678910111213141516171819202122

接下来就是移动正在拖动的li了，当前li的index大于容器li时就插入在容器的前面，反之插入在容器的后面，那么怎么获取当前li的index呢？Node有一个属性previousElementSibling，表示该元素前面的一个元素，那么我们可以这样

	function _index(el) {
	        var index = 0;
	        if (!el || !el.parentNode) {
	            return -1;
	        }
	        while (el && (el = el.previousElementSibling)) {
	            index++;
	        }
	        return index;
	    }
	12345678910

好的，基本的排序就做好了，在线演示地址[http://jsrun.net/GkiKp/edit](https://link.jianshu.com/?t=http://jsrun.net/GkiKp/edit)

### 动画

好了，先讲思路，动画其实不需要给所有元素都添加，只需要给移动的元素和目标元素添加动画就够了，例如我们交换了1和2的位置，那么就给1和2添加动画。这种添加动画的思路是通用的，比如可以做元素的页面进入动画。

![5192857-138c008c704da4e3.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145610.png)
1和2

我们可以记录1和2交换之前的位置，然后获取交换之后的位置，然后让元素从原位置慢慢移动到目标位置。
图片表示

![5192857-55c64cac9b8a31ac.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145614.png)
图片表示

那么我们先获取初始位置，肯定是在移动元素之前进行获取，那么我们在dragover移动元素之前加上

	var targetRect = target.getBoundingClientRect();
	var dragingRect = draging.getBoundingClientRect();
	12

然后在交换位置之后再次获取元素位置

	var targetAfter = target.getBoundingClientRect();
	var dragingAfter = draging.getBoundingClientRect();
	12

#### 位置还原

先获取两者的差，然后就可以为其添加transform，由于我们需要将元素瞬间移动到原来的位置，所以我们需要将其transition设为none

	target.style.transition='none';
	target.style.transform='translate3d(' +
	                (targetRect.left - targetAfter.left) + 'px,' +
	                (targetRect.top - targetAfter.top) + 'px,0)'
	
	//draging同理
	123456

然后就可以再设置transform进行移动，这里如果直接设置的话，当然动画是无法显示的，原因可以看[这里](https://www.jianshu.com/p/e2e271a0bb0e)

	target.offsetWidth; //触发重绘
	target.style.transition='all 300ms';
	target.style.transform='translate3d(0,0,0)';
	123

#### 还有一个问题

由于我们的动画是添加在dragover里面，然而dragover是会不停的触发，加过就是元素不停“抽搐”，所以我们需要判断元素是否已经添加了动画。这个的话方法就很多了，这里我是设置了一个定时器，事件到了之后将transition和transform清空，设置动画之前进行判断定时器是否已经存在

	clearTimeout(target.animated);
	target.animated = setTimeout(function() {
	target.style.transition='';
	target.style.transform='';
	target.animated = false;
	//draging同理
	}, ms);
	1234567

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='927'%3e%3cpath d='M728.064 343.943529c-17.648941-2.891294-23.552-20.239059-26.503529-28.912941V104.026353C701.560471 46.200471 654.396235 0 595.425882 0c-53.007059 0-97.28 40.478118-106.134588 89.569882-29.997176 184.862118-138.541176 255.457882-217.630118 280.937412a26.142118 26.142118 0 0 0-18.130823 24.877177v560.067764c0 19.817412 16.022588 35.84 35.84 35.84h535.973647c56.018824-11.565176 94.328471-31.804235 120.892235-86.738823l120.832-416.105412c23.552-75.173647-14.757647-147.395765-100.231529-144.564706h-238.772706z m-571.813647 31.744H76.619294C35.358118 375.687529 0 410.383059 0 450.861176v462.426353c0 43.369412 32.406588 78.004706 76.619294 78.004706h79.631059c27.708235 0 50.115765-22.407529 50.115765-50.115764V425.863529a50.115765 50.115765 0 0 0-50.115765-50.115764z' data-evernote-id='157' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

25人点赞*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='64 64 896 896' focusable='false' class='js-evernote-checked' data-icon='right' width='1em' height='1em' fill='currentColor' aria-hidden='true' data-evernote-id='931'%3e%3cpath d='M765.7 486.8L314.9 134.7A7.97 7.97 0 0 0 302 141v77.3c0 4.9 2.3 9.6 6.1 12.6l360 281.1-360 281.1c-3.9 3-6.1 7.7-6.1 12.6V883c0 6.7 7.7 10.4 12.9 6.3l450.8-352.1a31.96 31.96 0 0 0 0-50.4z' data-evernote-id='932' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='936'%3e%3cpath d='M771.413333 668.728889c-18.773333 3.015111-25.031111 20.878222-28.16 29.866667v217.884444c0 59.733333-49.948444 107.52-112.412444 107.52a115.427556 115.427556 0 0 1-112.412445-92.558222c-31.857778-190.919111-146.830222-263.850667-230.627555-290.133334a27.420444 27.420444 0 0 1-19.228445-26.168888V37.944889C268.572444 17.066667 285.582222 0 306.631111 0h567.864889c59.335111 11.946667 99.953778 32.824889 128 89.543111l128.113778 429.909333c24.974222 77.653333-15.644444 152.291556-106.211556 149.276445H771.413333z m-605.866666-32.824889H81.180444C37.546667 635.904 0 600.064 0 558.250667V80.611556C0 35.84 34.360889 0 81.180444 0H165.546667c29.297778 0 53.077333 23.779556 53.077333 53.077333v529.749334a53.077333 53.077333 0 0 1-53.077333 53.077333z' data-evernote-id='136' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

[*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='941'%3e%3cpath d='M178.390055 120.591045C111.268624 120.591045 56.888889 174.401955 56.888889 240.556383V903.97778C56.888889 970.302855 111.097977 1024 178.390055 1024h545.731364c67.121431 0 121.558049-53.81091 121.558049-120.02222V240.613265c0-66.268192-54.209088-120.02222-121.558049-120.02222H178.390055z m455.117432 301.136319H269.06087a30.147761 30.147761 0 0 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z m303.18409 301.136318a30.318409 30.318409 0 0 1-30.375291-30.318409V180.317742c0-66.268192-53.81091-120.02222-121.330519-120.022219H329.697688a30.147761 30.147761 0 0 1 0-60.23864l454.946784 0.056882C885.326618 0.113765 967.009987 80.887013 967.009987 180.602155v511.943118a30.318409 30.318409 0 0 1-30.31841 30.318409z m-303.18409-120.47728H269.06087a30.147761 30.147761 0 1 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z' data-evernote-id='147' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*JavaScript](https://www.jianshu.com/nb/15870651)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='947'%3e%3cpath d='M232.727273 579.87878833C271.28679 579.87878833 302.545455 548.62012233 302.545455 510.06060633 302.545455 471.50108933 271.28679 440.24242433 232.727273 440.24242433 194.167756 440.24242433 162.909091 471.50108933 162.909091 510.06060633 162.909091 548.62012233 194.167756 579.87878833 232.727273 579.87878833ZM512 579.87878833C550.559516 579.87878833 581.818182 548.62012233 581.818182 510.06060633 581.818182 471.50108933 550.559516 440.24242433 512 440.24242433 473.440484 440.24242433 442.181818 471.50108933 442.181818 510.06060633 442.181818 548.62012233 473.440484 579.87878833 512 579.87878833ZM791.272727 579.87878833C829.832243 579.87878833 861.090909 548.62012233 861.090909 510.06060633 861.090909 471.50108933 829.832243 440.24242433 791.272727 440.24242433 752.713211 440.24242433 721.454545 471.50108933 721.454545 510.06060633 721.454545 548.62012233 752.713211 579.87878833 791.272727 579.87878833Z' data-evernote-id='167' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

"小礼物走一走，来简书关注我"
还没有人赞赏，支持一下

[[webp](../_resources/6358a6ba90d6f5e56d72ff4ee6cfb0cd.webp)](https://www.jianshu.com/u/bbf9a7ff6028)

[虎虎虎呼呼](https://www.jianshu.com/u/bbf9a7ff6028)
总资产2 (约0.23元)共写了2728字获得29个赞共7个粉丝
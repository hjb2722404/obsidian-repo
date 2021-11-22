# 富文本编辑器开发系列——`textRange`对象`API`详解

## textRange对象简介

在`IE9`浏览器和更早版本的浏览器中，是没有提供用来表示选区的`Range`对象的`API`的，但是它们依旧有可编辑区域的相关能力，是因为它们提供了另一个对象接口：`textRange`对象

## textRange对象属性与API概览

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210162002.png)

## textRange 属性详解

我们先直观地看一下这些属性。

我们有下面一段代码：

```html
<body>
    <div onscroll="UpdateInfo();" style="padding: 20px; left: 50px; border:1px solid yellow; width:400px; overflow:scroll; position: relative;">
        <div>Select some content within this field.</div>
        <div id="cc">The coordinates of the selected content's boundary rectangle</div>
        <div>are visible in the field below</div>
    </div>
</body>
```

再来看页面中选中一个选区后各个属性所指向的

从上面的思维导图中，我们可以看到这些属性的简要介绍。但是还有一些要注意的点

### 祖先元素中离它最近的定位元素

这其实指的就是的元素的`offsetParent` 属性指向的元素，也就是说对于当前选中区域所在的`textRange`对象，会一层一层往上找它的祖先元素，遇到的第一个定位元素。

我们可以这样理解，获取到包含元素A的所有祖先元素，然后去除掉这些元素中的非定位元素，剩下的嵌套结构中元素A的父级元素就是它的 `offsetParent` 属性所指向的元素。

```html
<div class="1" style="position: fixed;">
  <div class="2">
  	<div class="3" style="position: relative;">
  		<div class="4" >
  			<div class="5" style="position: absolute;">
 					 <div class="6" >
  						<div class="A">
              		这个是元素A  
             	</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

// 去除非定位元素

<div class="1" style="position: fixed;">
  	<div class="3" style="position: relative;">
  			<div class="5" style="position: absolute;">
  						<div class="A">
              		这个是元素A  
             	</div>
				</div>
		</div>
</div>
// 元素A的 offsetParent 指向的元素就是 className为 “5”的元素


```



这个属性，有以下原则：

* 如果元素自身的定位方式为`fixed` 或者`display`为`node`，则它的`offsetParent`为 `null`；
* 如果元素的祖先元素里没有定位元素，并且元素本身没有定位，此时元素的`offsetParent` 为最近的`table/td/th或body`元素
* 如果元素的祖先元素里没有定位元素，而元素定位为`absolute`或`relative` ，分两种情况：
  * `IE7`以上和其它现代浏览器中，此时元素的`offsetParent` 为 最近的`table/td/th或body`元素；
  * `IE7` 以下版本浏览器中，此时元素的 `offsetParent` 为最近的`table/td/th或html`元素；
* 如果元素的祖先元素里有定位元素，而元素自身不是`fixed`定位，则元素的`offsetParent` 为离它最近的有定位的祖先元素。

知道了以上规则，我们就更好理解`textRange`对象的`offsetLeft`属性与`offsetTop`属性了。

下面来看下这些属性的表现。

**本文以下代码示例全部需要在IE9以下版本浏览器中才能正常运行**



<iframe src="https://codesandbox.io/embed/textrangeproperty-b52pk?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="textRange_property"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

运行效果：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210162024.gif)

我们拖动后选择的拖蓝区域形成了一个矩形区域，而`textRange` 对象的几个属性都和这个矩形区域有关： 

* `boundingLeft`： 矩形区域左端到父窗口左边框右侧的坐标距离
* `boundingTop`：矩形区域上端到父窗口上边框下侧的坐标距离
* `boundingWidth` ： 矩形区域的宽度
* `boundingHeight`： 矩形区域的高度
* `offsetLeft`： 矩形区域左端到它最近的定位父级元素的左边框的右侧的距离（这里也是body，所以与left值相等）
* `offsetTop`： 矩形区域上端到它最近的定位父级元素的上边框的下侧的距离（这里也是Body, 所以与 top值相等）

##  方法

### `collapse(start)`  闭合拖蓝

将拖蓝范围的起点移动到终点，反之亦然，同`range`

示例：




![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210162045.gif)

示例说明：

我们选中了一个选区‘button is released’，当我们释放鼠标时触发了事件，该事件调用了`collapse`方法将选区向终点闭合了，为了证明，我们在调用方法后，立即插入了一个按钮的内容，证明插入位置是选区终点处。



### `compareEndPoints`  比较拖蓝与指定对象

语法：`object.compareEndPoints(type, rangeToCompare);`

说明：比较另一个拖蓝对象与该拖蓝对象的两个端点的位置关系

参数：

 * type： 比较哪两个端点
   	* EndToEnd:  当前拖蓝的终点与目标对象的终点
      	* EndToStart: 当前拖蓝的终点与目标对象的起点
      	* StartToEnd：当前拖蓝的起点与目标对象的终点
      	* StartToStart：当前拖蓝的起点与目标对象的起点
* rangeToCompare：要比较的目标拖蓝对象

返回值：

* -1：第一个点在第二个点前面
* 0：两个点在同一个位置
* 1：第一个点在第二个点后面

示例

<iframe src="https://codesandbox.io/embed/floral-shape-dn89k?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="floral-shape-dn89k"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



示例说明： 我们的目标对象是文本中加粗的部分 ‘bold text’ ，而当前拖蓝对象就是我们鼠标拖动选区的范围，每一次选取，都会触发比较端点的方法，根据该方法返回的值，我们就可以判断出当前拖蓝与目标对象的位置关系。



### `duplicate()`  克隆拖蓝副本

语法： `object.duplicate(); `

说明：返回一个当前拖蓝对象的副本，同 `range`对象的 `cloneRange`方法

相关示例请移步[rangeAPI](./)

> 由于IE已经事实上出于死亡状态（截止写本文时，微软的Eage浏览器已经使用了谷歌的内核），以下IE下的API不再探讨。只供读者在阅读某些较旧的编辑器源码时当做参考用。



### `execCommand()` 在当前拖蓝上执行命令



### `expand`  扩展拖蓝范围





### `findText` 搜索原先拖蓝内的指定文本，并调整拖蓝使其包含第一次匹配的内容





### `getBookmark`  保存当前拖蓝的端点位置



### `getBoundingClientRect` 返回拖蓝矩形对象相对于浏览器的位置大小信息



### `getClientRects`  返回当前拖蓝矩形对象形状信息



### `inRange` 返回当前拖蓝是否包含指定拖蓝



### `isEqual` 返回当前拖蓝是否与指定拖蓝相等



### `move`  将拖蓝闭合，并将空白区域移动指定单位数



### `moveEnd`  将拖蓝结束位置移动指定单位数



### `moveStart` 将拖蓝的开始位置移动指定单位数



### `moveToBookMark`  获取保存的拖蓝位置信息



### `moveToElementText` 使拖蓝包含指定元素的文本



### `moveToPoint`  移动当前拖蓝的起点和终点到指定位置



### `parentElement`  返回拖蓝父元素



### `pasteHTML`  将HTML粘贴入给定的拖蓝，并替换拖蓝内原先的内容



### `queryCommandEnabled`  返回表明指定命令是否可用于给定文档当前状态下使用 `exexCommand` 命令成功事项的布尔值



### `queryCommandState`  返回表明指定命令当前状态的布尔值



### `queryCommandValue`  返回表明指定命令当前值的`DOMString`



### `scrollIntoView` 将拖蓝滚动到可视范围内



### `select`  将当前拖蓝选中



### `setEndPoint`  根据其它拖蓝的端点设置当前拖蓝的结束点
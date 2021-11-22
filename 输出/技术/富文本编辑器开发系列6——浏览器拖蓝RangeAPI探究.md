# 富文本编辑器开发系列——`Range API` 探究

[TOC]

## 基本属性

为了方便观察`range`的基本属性，我们写以下测试代码：

![image-20200831214251078](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210154455.png)

[在线测试](https://jshare.com.cn/selection/BtGfG1)

我们选中一段文本，然后看页面的输出和控制台的输出。

![image-20200831214635853](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210154526.png)



![image-20200831214813395](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210154538.png)



![image-20200831214844785](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200910092643.png)



我们观察到它的几个属性：

* `collapsed`: 是否闭合，即当前选区是否是一个光标，只有开始节点与结束节点相同，并且开始偏移量与结束偏移量相同时才是`true`，此处未闭合，所以是`false`。
* `commonAncestorContainer`：返回包含开始节点与结束节点的最深一级的节点（根节点），此处是设置了`onclick`属性的`div`节点，注意，这里最深一级是指可编辑区域所包含的节点中的最深一级（并且不包含设置了`contenteditable`属性为`true`的节点本身。）
* `endContainer`:  结束节点，拖蓝结束点所在的`DOM` 节点，此处是多行文本所在的文本节点，注意，是文本节点，而不是包含它的`p` 节点。
* `endOffset` : 结束偏移量，即从结束节点的开始位置数起，到拖蓝结束位置所经过的字数。如果结束节点是一个包含子元素的`DOM`元素，则代表从该节点的第一个节点到拖蓝结束位置所在的节点所经过的节点数。
* `startContainer`：开始节点，拖蓝的起点所在的`DOM`节点，此处是`id`为`first`的`p`节点所包裹的文本节点，但又不包含其中`id`为`third`的`span`节点。
* `startOffset`：开始偏移量，即从开始节点的开始位置数起，到拖蓝开始位置所经过的字数。如果开始节点是一个包含子元素的`DOM`元素，则代表从该节点第一个节点到拖蓝开始位置所在的节点所经过的节点数。

对于`startContainer` 中的情况，我们可以再做一个实验来验证：

![image-20200831220732554](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210154547.png)



可以看到，这里开始节点是`这里是另一段普通的` 文本节点，而结束节点是`文字内容啊` 文本节点，虽然它们都在同一`p`节点中，但因为有`span` 节点的分割，它俩分别是独立的文本节点了。

## 成员方法

###  `setStart(startNode, startOffset)`

设置拖蓝的起点,`startNode`：开始节点，`startOffset`: 起点相对于开始节点开始位置的偏移量

![rangeApi_setStart](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210154559.gif)

[![Edit rangeAPI_setStart](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapisetstart-h5ye5?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapisetstart-h5ye5?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_setStart"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



### `setEnd(endNode, endOffset)`

设置拖蓝的终点，`endNode`:结束节点， `endOffset`: 终点相对于结束节点开始位置的偏移量。

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210154656.gif)



[![Edit rangeAPI_setStartBefore](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapisetstartbefore-xye5b?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapisetstartbefore-xye5b?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_setStartBefore"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



### `setStartBefore(referenceNode)`

相对于另一个节点来设置拖蓝的开始位置，该拖蓝的开始节点与另一个节点的父节点是同一个，开始节点在另一个节点之前

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210154840.gif)

[![Edit rangeAPI_setStartBefore](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapisetstartbefore-ck81v?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapisetstartbefore-ck81v?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_setStartBefore"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



###  `setStartAfter(referenceNode)`

相对于另一个节点来设置拖蓝的开始位置，该拖蓝的开始节点与另一个节点的父节点是同一个，开始节点在另一个节点之后.

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210154901.gif)





[![Edit rangeAPI_setStartAfter](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapisetstartafter-jw701?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapisetstartafter-jw701?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_setStartAfter"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



###  `setEndBefore(referenceNode)`

相对于另一个节点来设置拖蓝的结束位置，该拖蓝的结束节点与另一个节点的父节点是同一个，结束节点在另一个节点之前.

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210154922.gif)

[![Edit rangeAPI_setEndBefore](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapisetendbefore-qtn4x?fontsize=14&hidenavigation=1&theme=dark)[在线测试](https://jshare.com.cn/selection/4PGffs)

<iframe src="https://codesandbox.io/embed/rangeapisetendbefore-qtn4x?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_setEndBefore"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



###  `setEndAfter(referenceNode)`

相对于另一个节点来设置拖蓝的结束位置，该拖蓝的结束节点与另一个节点的父节点是同一个，结束节点在另一个节点之后.

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210154942.gif)

[![Edit rangeAPI_setEndAfter](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapisetendafter-ngxx8?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapisetendafter-ngxx8?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_setEndAfter"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



###  `seelctNode(referenceNode)`

将拖蓝设置为包含整个节点及其内容， 拖蓝的起始和结束节点的父节点与传入节点（`referenceNode`）的父节点相同。

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210154959.gif)

[![Edit rangeAPI_selectNode](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapiselectnode-uiipq?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapiselectnode-uiipq?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_selectNode"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



###  `selectNodeContents(referenceNode)`

设置拖蓝，使其包含传入节点的内容，拖蓝的起始和结束节点的父节点即为传入的节点。

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210155013.gif)

[![Edit rangeAPI_selectNodeContents](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapiselectnodecontents-1rru5?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapiselectnodecontents-1rru5?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_selectNodeContents"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



###  `collapse(toStart)`

  闭合拖蓝。`toStart`: 闭合方向，`true`向起点闭合，`false`向终点闭合。

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210155024.gif)

[![Edit rangeAPI_collapse](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapicollapse-5qvgs?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapicollapse-5qvgs?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_collapse"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>





###  `cloneContents()`

返回包含拖蓝中所有节点的文档片段

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210155040.gif)

[![Edit rangeAPI_cloneContents](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapiclonecontents-7orr6?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapiclonecontents-7orr6?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_cloneContents"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



###  `deleteContents()`

从文档中移除拖蓝包含的内容

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210155057.gif)

[![Edit rangeAPI_deleteContents (forked)](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapideletecontents-forked-ccil7?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapideletecontents-forked-ccil7?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_deleteContents (forked)"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

###  `extractContents()`

把拖蓝的内容从文档树移动到一个文档片段中，返回该文档片段

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210155109.gif)



[![Edit rangeAPI_extractContents](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapiextractcontents-zk6q6?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapiextractcontents-zk6q6?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_extractContents"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

###  `insertNode(newNode)`

在拖蓝的起始位置插入一个新的节点，如果将新节点添加到一个文本节点，则该文本节点在插入点处被拆分，插入发生在两个文本节点之间；如果新节点是一个文档片段，则插入文档片段的子节点。

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210155128.gif)

[![Edit rangeAPI_insertNode](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapiinsertnode-8fps2?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapiinsertnode-8fps2?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_insertNode"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



###  `surroundContents(newParent)`

将拖蓝的内容移动到一个新的节点，并将新节点放到这个范围的起始处。它会从DOM中删除新节点内容。



![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210155200.gif)

[![Edit rangeAPI_surroundContents](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapisurroundcontents-6vo9d?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapisurroundcontents-6vo9d?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_surroundContents"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>



###  `compareBoundaryPoints(how, sourceRange)`



比较两个拖蓝的端点。 `how`：指定如何比较，参见本表下方`how`部分。`sourceRange` : 要与之比较的拖蓝，返回一个数字，`-1/0/1`中的一个，表示本拖蓝的指定端点在源拖蓝的指定端点前面，相同位置还是后面。

#### `how`

指定如何比较，有四个可选值：

* `Range.END_TO_END`:  比较源拖蓝的终点与本拖蓝的终点
* `Range.END_TO_START`: 比较源拖蓝的终点与本拖蓝的起点
* `Range.START_TO_END`: 比较源拖蓝的起点与本拖蓝的终点
* `Range.START_TO_START`: 比较源拖蓝的起点与本拖蓝的起点

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20200910092954.gif)



[![Edit rangeAPI_compareBoundaryPoints](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/rangeapicompareboundarypoints-71bx7?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/rangeapicompareboundarypoints-71bx7?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="rangeAPI_compareBoundaryPoints"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>






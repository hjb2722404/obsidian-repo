#  富文本编辑器开发系列——浏览器`Selection API`探究

[TOC]

## 1. Selection 基本属性

我们先上示例代码：

``` html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Selection API</title>
</head>
<body>
    <div id="box">
        <div onclick="showInfo()">
            <p>这里是一段普通的 <span>文字</span></p>
            <p>这里是另一段普通的 <span>文字</span></p>
        </div>
    </div>
</body>
<script>
    function showInfo() {
        var sel = window.getSelection();
        console.log(sel.toString());
    }
</script>
</html>
```

我们在本地运行起这个示例页面，并且在控制台中的`source`面板里，在`console`语句一行打上断点，从右向左选中第二行文字的一部分，然后看看当前的`selection`是什么样的：

<img src="https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210152935.png"  />

在这里，可以看到当前`Selection`的所有属性：

* `anchorNode`:  锚点，返回该选区起点所在的节点，这里的值是`文字`所在的文本节点，因为我们是从右向左拖动选择的，所以起点是该节点而不是`这里是另一段普通的` 所在的文本节点
* `anchorOffset`: 锚点偏移量，表示的是选区起点在其所在节点中的位置偏移量，如果起点节点是文本节点，name返回的就是从该文字节点的第一个字开始，到被选中的第一个字之间的字数；如果起点节点是一个元素，则返回的就是在选区第一个节点之前的同级节点总数（这些节点都是起点节点的子节点）。这里我们的节点是文字节点，所以返回的是开始的`文`字在`文字`这个文本节点中偏移量。
* `focusNode`: 该选区终点所在的节点， 这里就是`这是一段普通的`这部分文字所在的文字节点
* `focusOffset`: 与`anchorOffset`类型，这里是文本节点，并且选中内容在该节点开头，所以偏移量为0
* `isCollapsed`:  是否闭合，此处开始节点和结束节点，开始偏移量与结束偏移量皆不相同，所以为`false`.
* `rangeCount`:  包含的拖蓝区域数量，除了`firfox`外，其它浏览器默认都只有一个
* `type`: 类型，这里的值是 `Range` ，代表当前是一个拖蓝区域

<iframe src="https://codesandbox.io/embed/sleepy-austin-vntvg?expanddevtools=1&fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="sleepy-austin-vntvg"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

我们修改一下内容：

```html
<p>这里是另一段普通的 <span>文字内容啊</span></p>
```

然后还是从右向左拖动选择，但选择范围改变一下：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210152959.png)

然后再看当前的偏移量：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153004.png)

印证了我们上面的说明。还要注意一点，对于开始节点来说，这里的偏移量是3，意味着选区的开始位置前面有3个字符，即选区是从第4个字符开始的，而对于结束节点，偏移量是4，说明选区结束位置是在该文本节点的第4个字之后。

## 2. Selection 选区API

### `getRangeAt(index)` 获取拖蓝区域

我们在`js`部分增加两行代码：

```javascript
var range = sel.getRangeAt(0);
console.log(range);
```

还是和上面一样的操作，然后还是在`console`语句处断点：

![image-20200630164803780](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153022.png)

可以看到，成功获取到了当前的拖蓝对象，而我们在具体的网页编辑器功能开发中，通常用的最多的也是这个拖蓝对象，它的几个关键属性：

* `collapsed` ： 描述拖蓝是否闭合，如果我们只是在区域中某个文字后面点击鼠标，并不拖动选中文字，此时选区和拖蓝的开始节点与结束节点是同一个节点，偏移量也都相同，那么我们就说此时选区和拖蓝都是闭合的。
* `startContainer`: 拖蓝的开始节点。拖蓝与选区不同，拖蓝的开始节点与选中时拖动方向无关。所以此例中的开始节点就是`另一段普通的` 所在的文本节点。
* `startOffset`：开始节点偏移量，这里是3，同样意味着拖蓝的开始位置在开始节点（文本节点）第3个字符之后。
* `endContainer`：拖蓝的结束节点。
* `endOffest`：结束节点偏移量，这里是4，意味着拖蓝的结束位置在结束节点（文本节点）的第4个字符之后



### `collapse(parentNode, offset)`   将当前选区闭合到指定节点的指定位置

我们继续在`js`部分增加代码：

```javascript
sel.collapse(document.getElementById('box'), 0);
```

然后还是按照上面的方法操作，这次不再断点。

我们发现，选中内容后点击选区，拖蓝消失了，其实就是选区闭合了，因为现在的页面内容还不是可编辑区域，所以闭合后没有看到有任何光标标识拖蓝闭合的位置。

我们改造下代码：

```html
 <div id="box" contenteditable>
        <div onclick="showInfo()">
            <p id="first">这里是一段普通的 <span>文字</span>内容</p>
            <p id="second">这里是另一段普通的 <span>文字内容啊</span></p>
        </div>
    </div>
    //...
   <script>
    function showInfo() {
        var sel = window.getSelection();
        var range = sel.getRangeAt(0);
        sel.collapse(document.getElementById('first'), 2);
    }
</script>
```



此时，按照上文的操作完成后，如下：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153032.gif)

![image-20200630172713899](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153044.png)

根据光标位置可知，选区闭合到了`ID`为`first`的`p`元素的第二个节点（`<span>文字</span>`）之后

[![Edit selectionAPI_collapse](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/selectionapicollapse-2ul13?fontsize=14&hidenavigation=1&theme=dark)



<iframe src="https://codesandbox.io/embed/selectionapicollapse-2ul13?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="selectionAPI_collapse"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

### `extend(node, offset)` 将选区焦点移动到特定位置。

此时，从选区中原来拖蓝的结束节点(即使是闭合拖蓝也一样)到指定的位置之间将形成新的拖蓝，原拖蓝将消失。

我们改造下`js`代码：

```javascript
var sel = window.getSelection();
var range = sel.getRangeAt(0);
sel.extend(document.getElementById('first'), 1);
```

 仍旧按照上文中的操作，从右向左拖动选中`另一段普通的 文字内容`, 触发脚本后结果如下：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153057.gif)

![image-20200630175426041](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153130.png)

[![Edit quizzical-shape-7h05b](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/quizzical-shape-7h05b?fontsize=14&hidenavigation=1&theme=dark)

<iframe src="https://codesandbox.io/embed/quizzical-shape-7h05b?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="quizzical-shape-7h05b"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

### `modify(alter, direction, tranularity)`  修改选区

* `alter`：操作类型，有两个可取值：
  * `move`: 移动光标位置
  * `extend`： 扩展选区范围

* `direction`: 移动或扩展方向，有四个可取值

  * `forward`:  文本前进方向
  * `backward` : 文本后退方向
  * `left` : 向左
  * `right` : 向右

* `tranularity`： 颗粒度，按照什么为单位进行移动或扩展
* `character`: 每次移动或扩展一个字符的位置
  * `word`：每次移动或扩展一个单词的位置，英文状态下比较明显，中文状态下有时一个字就是一个单词（例如`是`），有时一个词语是一个单词（例如`普通`）,不确定。
  * `sentence`：每次移动或扩展一个句子的位置，以句号为分界（中英文句号皆可）。
  * `line`： 每次移动或扩展一行的位置，如果原开始位置在某行的第N个字符后，那移动或扩展后的位置就是上（下）一行的第N个字符后，如果上（下）一行字符总数小于N，则移动或扩展到行首（尾）。
  * `paragraph`:  每次移动或者扩展一个段落。偏移位置规则同上。
  * `lineboundary`: 移动或扩展到行首或行尾（根据方向）。
  * `sentenceboundary`: 移动或扩展到句首或句尾。
  * `paragraphboundary`： 移动或扩展到段首或段尾。
  * `documentboundary` : 移动或扩展到文档开头或结尾。


示例代码如下：

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Selection API</title>
</head>
<body>
    <div id="box" contenteditable>
        <div onclick="showInfo()">
            <p id="first">这里是一段普通的 <span>文字</span>内容</p>
            <p id="second">这里是另一段普通的 <span id="third">文字内容啊</span></p>
            <p>这是一段带有英文的句子： this is a line with english</p>
            <p>这是一段带有英文的多行句子： this is a line with english。这是一段带有英文的多行句子： this is a line with english.这是一段带有英文的多行句子： this is a line with english,这是一段带有英文的多行句子： this is a line with english。这是一段带有英文的多行句子： this is a line with english。这是一段带有英文的多行句子： this is a line with english。这是一段带有英文的多行句子： this is a line with english，这是一段带有英文的多行句子： this is a line with english。</p>
        </div>
    </div>
</body>
<script>
	function showInfo() {
        var sel = window.getSelection();
        var range = sel.getRangeAt(0);
        sel.modify('move','backward', 'character');
        // sel.modify('extend','backward', 'character');
        // sel.modify('extend','forward', 'character');
        // sel.modify('extend','backward', 'word');
        // sel.modify('extend','backward', 'sentence');
        // sel.modify('extend','backward', 'line');
        // sel.modify('extend','backward', 'paragraph');
        // sel.modify('extend','backward', 'lineboundary');
        // sel.modify('extend','backward', 'sentenceboundary');
        // sel.modify('extend','backward', 'paragraphboundary');
        // sel.modify('extend','backward', 'documentboundary');
}
</script>
</html>
```



可以直接将此代码复制到本地运行，并通过开放关闭`js`中不同的注释来查看不同参数下操作的差别。

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153143.gif)

[![Edit gifted-wood-vmw7z](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/gifted-wood-vmw7z?fontsize=14&hidenavigation=1&theme=dark)



<iframe src="https://codesandbox.io/embed/gifted-wood-vmw7z?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="gifted-wood-vmw7z"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

### `collapseToStart()` 取消当前选区，并把光标定位在原选区的最开始处

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153158.gif)

[![Edit gifted-sara-yjnot](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/gifted-sara-yjnot?fontsize=14&hidenavigation=1&theme=dark)



<iframe src="https://codesandbox.io/embed/gifted-sara-yjnot?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="gifted-sara-yjnot"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

### `collapseToEnd()` 取消当前选区，并把光标定位在原选区的结束位置

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153211.gif)

[![Edit sharp-bird-6jsbs](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/sharp-bird-6jsbs?fontsize=14&hidenavigation=1&theme=dark)



<iframe src="https://codesandbox.io/embed/sharp-bird-6jsbs?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="sharp-bird-6jsbs"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

### `selectAllChildren(parentNode)` 把指定元素所有子元素设为选中区域（不包含该元素本身），并取消之前选中区域

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153224.gif)

[![Edit selectionAPI_selectAllChildren](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/selectionapiselectallchildren-wpbyd?fontsize=14&hidenavigation=1&theme=dark)



<iframe src="https://codesandbox.io/embed/selectionapiselectallchildren-wpbyd?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="selectionAPI_selectAllChildren"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

### `addRange(range)` 将一个拖蓝区域加入选区当中

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153236.gif)

[![Edit selectionAPI_addRange](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/selectionapiaddrange-34otx?fontsize=14&hidenavigation=1&theme=dark)



<iframe src="https://codesandbox.io/embed/selectionapiaddrange-34otx?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="selectionAPI_addRange"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

### `removeRange(range)` 从选区中移除一个拖蓝区域

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153318.gif)

由于大多数浏览器一个选区都只能拖动出一个拖蓝区域，所以执行此操作后，用户选中的拖蓝区域将消失，且光标将消失。（注：并不会删除拖蓝区域中的内容）

[![Edit selectionAPI_removeRange](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/selectionapiremoverange-dhwus?fontsize=14&hidenavigation=1&theme=dark)



<iframe src="https://codesandbox.io/embed/selectionapiremoverange-dhwus?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="selectionAPI_removeRange"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

### `removeAllRanges()` 从当前选区中移除所有的拖蓝区区域

参看`addRange`在线代码示例中的用法



### `deleteFromDocument()` 从页面中删除选区中的内容

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153406.gif)

[![Edit selectionAPI_removeRange (forked)](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/selectionapiremoverange-forked-8rwmr?fontsize=14&hidenavigation=1&theme=dark)



<iframe src="https://codesandbox.io/embed/selectionapiremoverange-forked-8rwmr?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="selectionAPI_removeRange (forked)"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

### `toString()` 返回代表当前selection对象的字符串,例如当前选择的文本文字

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153512.gif)

[![Edit selectionAPI_deleteFromDocument (forked)](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/selectionapideletefromdocument-forked-q3k55?fontsize=14&hidenavigation=1&theme=dark)



<iframe src="https://codesandbox.io/embed/selectionapideletefromdocument-forked-q3k55?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="selectionAPI_deleteFromDocument (forked)"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>

### `containsNode(aNode,aPartlyContained)` 判断指定节点是否包含在当前选区内

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201210153601.gif)

* `aNode`： 用于判断是否包含在选区中的那个节点
* `aPartlyContained`： 当此参数为`true`时，即使选区只包含指定节点的一部分内容，该方法也将返回`true`，当此参数为`false`时，只有选区完全包含指定节点时，才返回`true`。

[![Edit selectionAPI_toString (forked)](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/selectionapitostring-forked-ldscf?fontsize=14&hidenavigation=1&theme=dark)



<iframe src="https://codesandbox.io/embed/selectionapitostring-forked-ldscf?fontsize=14&hidenavigation=1&theme=dark"
     style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;"
     title="selectionAPI_toString (forked)"
     allow="accelerometer; ambient-light-sensor; camera; encrypted-media; geolocation; gyroscope; hid; microphone; midi; payment; usb; vr; xr-spatial-tracking"
     sandbox="allow-forms allow-modals allow-popups allow-presentation allow-same-origin allow-scripts"
   ></iframe>
















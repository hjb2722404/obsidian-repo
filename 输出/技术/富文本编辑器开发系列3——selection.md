# 富文本编辑器开发系列——`selection`

[TOC]

## Selection简介

`Selection`俗称`选区`，它代表浏览器页面中的文本选区。文本选区是由用户拖拽鼠标经过文字而产生，当然，如果页面内某块区域时可编辑的（`contenteditable`）, 选区也可以获取光标所在位置，此时并没有文本被选中，所以此时的选区被标记为闭合选区，即选区闭合于光标所在位置，选区开始位置和结束位置为同一个位置。

## 原生的selection有以下属性：

|           属性 | 说明                                                         |
| -------------: | :----------------------------------------------------------- |
|   `anchorNode` | 只读，返回该选区起点所在的节点                               |
| `anchorOffset` | 只读，返回一个数字，其表示的是选区起点在其所在节点中的位置偏移量，如果起点节点是文本节点，name返回的就是从该文字节点的第一个字开始，到被选中的第一个字之间的字数；如果起点节点是一个元素，则返回的就是在选区第一个节点之前的同级节点总数（这些节点都是起点节点的子节点） |
|    `focusNode` | 只读， 返回该选区终点所在的节点                              |
|  `focusOffset` | 只读，返回一个数组，其表示选区终点在终点所在节点的位置偏移量，如果终点节点是文本节点，那选区末尾被选中的第一个字，在该文本节点中时第几个字，就返回几，如果终点节点是元素，则返回选区末尾之后第一个节点之前的同级节点数。 |
|  `isCollapsed` | 只读，布尔值，选区是否为闭合选区                             |
|   `rangeCount` | 只读，返回该选区所包含的拖蓝（`range`）数量，除了`firefox`，其它 浏览器通常一个选区都只有一个拖蓝 |

## 原生selection有以下成员方法：

| 方法名                          | 参数说明                                                     |
| ------------------------------- | ------------------------------------------------------------ |
| `getRangeAt(index)`             | 返回选区包含的拖蓝的`引用`.`index`, 拖蓝在选区所有拖蓝中的编号，必须小于`rangeCount`，否则会报错 |
| `collapse(parentNode,offset)`   | 闭合选区.`parentNode`:光标落在的目标节点，`offset` 落在节点的偏移量 |
| `extend(node,offset)`           | 将选区的焦点移动到一个特定位置.`node`:焦点会被移动至此节点，`offset`：焦点偏移量，默认为0. |
| `modify(alter,dir,gran)`        | 修改当前选区.`alter`:改变类型,传入`"move"`移动光标位置，传入`"extend"`扩展当前选区。`dir`：调整选区的方向，传入`"forward"`或`"backward"`来根据选区内容语言的书写方向来调整，或者使用`"left"`或`"right"`来指明调整方向。`gran`: 调整的颗粒度，可选值有`"character"、"word"、"sentence"、"line"、"paragraph"、"lineboundary"、"sentenceboundary"、"paragraphboundary"、"documentboundary"` |
| `collapseToStart()`             | 将当前的选区折叠到起始点                                     |
| `collapseToEnd()`               | 将当前的选区折叠到最末尾的一个节点                           |
| `addRnge(range)`                | 向选区中加入一个拖蓝.`range`要被加入的拖蓝                   |
| `removeRange(range)`            | 从选区中移除一个拖蓝.`range`要移除的拖蓝                     |
| `removeAllRanges()`             | 将所有的拖蓝都从选区中移除                                   |
| `deleteFromDocument()`          | 从页面中删除选区中的内容                                     |
| `selectionLanguageChange()`     | 当键盘的朝向发生改变后修改指针的`bidi优先级`(与`unicode`所涉及的语言方向有关) |
| `toString()`                    | 返回当前选区的纯文本内容                                     |
| `containsNode(node,bool)`       | 判断某一个节点是否为当前选区的一部分. `node`目标节点，`bool`是否完全包含 |
| `selectAllChildren(parentNode)` | 将某一指定节点的子节点框入选区.`parentNode`，要选中的所  有节点的父节点 |

## API详解

请参阅 [[富文本编辑器开发系列5——浏览器选区SelectionAPI探究|浏览器SelectionAPI探究]]






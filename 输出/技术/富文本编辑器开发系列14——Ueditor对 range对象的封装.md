# 富文本编辑器开发系列——`Ueditor`对 `range`对象的封装

## UEditor封装的Range的API

| 属性或方法                                      | 说明                                                         |
| ----------------------------------------------- | ------------------------------------------------------------ |
| `startContainer`                                | 只读，开始节点——当前拖蓝的起点所在的节点                     |
| `startOffset`                                   | 只读，当前拖蓝起点相对于开始节点的起始位置的偏移量           |
| `endContaier`                                   | 只读，结束节点——当前拖蓝的终点所在的节点                     |
| `endOffset`                                     | 只读，当前拖蓝结束点相对于结束节点起始位置的偏移量           |
| `collapsed`                                     | 只读，当前拖蓝是否闭合                                       |
| `document`                                      | 只读，当前拖蓝所属的`Document`                               |
| `new Range(doc)`                                | 创建一个跟`doc`绑定的空的拖蓝                                |
| `cloneContents()`                               | 克隆拖蓝的内容到一个文档片段中,如果拖蓝是闭合的将返回`null`  |
| `deleteContents()`                              | 删除当前拖蓝中的所有内容                                     |
| `extractContents()`                             | 将当前拖蓝的内容移动到一个文档片段里，原内容将从`DOM`树上移除，这将导致拖蓝闭合。 |
| `setStart(Node,offset)`                         | 设置拖蓝的开始节点和偏移量                                   |
| `setEnd(node,offset)`                           | 设置拖蓝的结束节点和偏移量                                   |
| `setStartAfter(node)`                           | 将拖蓝开始位置设置到给定节点之后                             |
| `setStartBefore(node)`                          | 将拖蓝的开始位置设置到给定节点之前                           |
| `setEndAfter(node)`                             | 将拖蓝结束位置设置到给定节点之后                             |
| `setEndBefore(node)`                            | 将拖蓝结束位置设置到给定节点之前                             |
| `setStartAtFirst(node)`                         | 设置拖蓝的开始位置到给定节点的第一个子节点之前               |
| `setStartAtLast(node)`                          | 设置拖蓝的开始位置到给定节点的最后一个节点之后               |
| `setEndAtFirst(node)`                           | 设置拖蓝的结束位置到给定节点的第一个子节点之前               |
| `setEndAtLast(node)`                            | 这是拖蓝的结束位置到给定节点的最后一个子节点最后             |
| `selectNode(node)`                              | 选中给定节点                                                 |
| `selectNodeContents(node)`                      | 选中给定节点的所有子孙节点（包含它自身）                     |
| `cloneRange()`                                  | 克隆当前拖蓝对象                                             |
| `collapse(toStart)`                             | 闭合当前拖蓝, `toStart` :闭合方向，`true`向起点闭合，`false`向终点闭合 |
| `shrinkBoundary(ignoreEnd)`                     | 调整拖蓝的开始位置和结束位置，使其收缩到最小的位置，跨节点的拖蓝将收缩到最内层元素中，`ignoreEnd`：是否忽略对结束位置的调整 |
| `getCommonAncestor(includeSelf,ignoreTextNode)` | 获取离当前选区内包含的所有节点最近的公共祖先节点。`includeSelf`：获取到的公共祖先节点是否可以是当前选区的开始（结束）节点。`ignoreTextNode`: 是否忽略类型为文本节点的祖先节点。 |
| `trimBoundary(ignoreEnd)`                       | 调整当前拖蓝的边界容器（开始节点和结束节点），如果容器是文本节点，则调整到包含该文本节点的父节点上.`ignoreEnd`,是否忽略对结束边界的调整 |
| `txtToElmBoundary(ignoreCollapsed)`             | 如果选区在文本边界上，就扩展拖蓝到文本的父节点上。`ignoreCollapsed`：当拖蓝闭合时是否执行此操作 |
| `insertNode(node)`                              | 在当前拖蓝的开始位置前插入节点，新插入的节点会被该拖蓝包含   |
| `setCursor(toEnd)`                              | 闭合拖蓝，并且定位光标到闭合后的位置。`toEnd`：闭合的方向    |
| `createBookmark(serialize)`                     | 创建当前拖蓝的的一个书签，记录下当前拖蓝的位置，方便当`DOM`树改变时，还能找回原来是选区位置。`serialize`: 控制返回的标记位置是对当前位置的引用还是ID。 |
| `moveToBookmark(bookmark)`                      | 调整当前拖蓝的边界到书签位置，并删除该书签对象所标记的位置内的节点。 |
| `enlarge(toBlock)`                              | 调整拖蓝的边界，使其“放大‘到最近的父节点，`toBlock`: 是否要求扩大后的父节点必须是`block`节点（块级节点） |
| `adjustmentBoundary()`                          | 调整拖蓝的边界，使其”缩小“到最合适的位置                     |
| `applyInlineStyle(tagName,attrs)`               | 给拖蓝中的内容添加给定的行内标签。`tagName`:标签名。`attrs`: 可选，为行内标签添加初始属性 |
| `removeInlineStyle(tagName)`                    | 移除当前拖蓝内指定的行内标签，但保留其中的内容               |
| `removeInlineStyle(tagNameArr)`                 | 移除当前拖蓝内指定的一组行内标签，但保留其中内容             |
| `getClosedNote()`                               | 获取当前选中的自闭合节点                                     |
| `select()`                                      | 在页面上高亮拖蓝所表示的区域                                 |
| `scrollToView(win, offset)`                     | 滚动页面到当前拖蓝开始的位置，`win`:当前拖蓝对象所属的`window`对象, `offset`: 距离拖蓝对象开始位置出的偏移量 |
| `equals()`                                      | 判断给定的拖蓝对象是否和当前的拖蓝对象表示的是同一个区域     |
| `traversal(doFn,filterFn)`                      | 遍历拖蓝内的节点，每当遍历到一个节点时，都会执行`doFn`函数，参数为当前节点。`filterFn`，可选，过滤器，符合该过滤器条件的节点才会执行`doFn`函数。 |
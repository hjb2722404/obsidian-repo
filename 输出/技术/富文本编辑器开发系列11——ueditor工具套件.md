#  为UEeditor 源码分析——DOM操作工具包分析

由于`UEeditor`的所有操作都是基于`DOM` 的，所以它开发了一套`DOM` 操作工具包用来在进行编辑器操作时更方便第进行`DOM` 操作。下面来逐一看一下它的实现。



## 概观

```javascript
function getDomNode(){...} 
var attrFix = {...},  
	styleBlock = utils.listToMap([...]); 
var domUtils = dom.domUtils = {...};
var fillCharReg = new RegExp(...);
```



我们看到，这个工具包显示定义了：

* `getDomNode` ： 一个公共方法
* `attrFix` ： 一个对象
* `styleBlock`： 一个`Map`
* `domUtils`: 工具包对外暴露的接口
* `fillCharReg` ：一个正则表达式



## getDomNode

```javascript
function getDomNode(node, start, ltr, startFromChild, fn, guard) {
    var tmpNode = startFromChild && node[start],
        parent;
    !tmpNode && (tmpNode = node[ltr]);
    while (!tmpNode && (parent = (parent || node).parentNode)) {
        if (parent.tagName == 'BODY' || guard && !guard(parent)) {
            return null;
        }
        tmpNode = parent[ltr];
    }
    if (tmpNode && fn && !fn(tmpNode)) {
        return  getDomNode(tmpNode, start, ltr, false, fn);
    }
    return tmpNode;
}
```



该方法接受6个参数，下面是对他们的说明：

* `node`: 源节点——需要获取其兄弟节点的节点对象
* `start`  开始查找的节点，有两个取值： `firstChild`-从第一个字节点开始查找，`lastChild` 从最后一个子节点开始查找
* `ltr`：查找方向，有两个取值： `nextSibling`-向后查找， `previousSibling`-向前查找
* `startFromChild`： 查找过程是否从其子节点开始，布尔值
* `fn`：对节点进行某些条件过滤的函数
* `guard`：守护函数

然后看执行过程：

1. 如果设置了从子节点开始查找，则将该节点的第一个或最后一个节点（根据`start`的值）缓存下来作为目标节点。
2. 如果源节点没有子节点，则设置目标节点为它的前一个或后一个节点（根据`ltr`的值）
3. 开始循环
4. 如果目标节点为`null`，则获取它的父节点
5. 如果父节点是`BODY`标签， 或者父节点没有被守护，则返回 `null`， 否则，设置父节点的上一个或下一个节点为目标节点。
6. 结束循环
7. 如果获取到了目标节点，并且传入了过滤函数，并且经过该函数过滤后的结果为`null`，则递归调用本方法，设置过滤前的目标节点为源节点，直至最后过滤的结果不为`null`
8. 返回最后的结果节点

总结：从过程看，这个方法就是根据传入的参数来查找某个节点的上一个节点或下一个节点（不限于同级）。



## domUtils

### 常量说明

```javascript
// 节点类型常量

    NODE_ELEMENT:1,  // 元素节点
    NODE_DOCUMENT:9, // 文档节点
    NODE_TEXT:3, // 文本节点
    NODE_COMMENT:8, // 注释节点
    NODE_DOCUMENT_FRAGMENT:11, // 文档片段节点

//A节点相对于B节点的位置关系
        
    POSITION_IDENTICAL:0,  // 元素相同
    POSITION_DISCONNECTED:1, // 两个节点在不同文档中
    POSITION_FOLLOWING:2, // 节点A在节点B之后
    POSITION_PRECEDING:4, // 节点A在节点B之前
    POSITION_IS_CONTAINED:8, // 节点A被节点B包含
    POSITION_CONTAINS:16, // 节点A包含节点B
        
// 兼容IE6的空白填充字符
    
    fillChar: ie && browser.version == '6'  ? '\ufeff' : '\u200B'  

// 按键控制
 keys = {
     8: 1, // backspace 退格键
     46: 1, // delete 删除键
     16: 1, // shift
     17: 1, // Ctrl
     18: 1, // Alt
     37: 1, // left 方向左键
     38: 1, //　up 方向上键
     39: 1, // right 方向右键
     40: 1, // down 方向下键
     13: 1, // enter 回车键
 }
```



节点类型，就是每个节点的 `nodeType` 的值，具体参考： [`nodeType`](https://developer.mozilla.org/zh-CN/docs/Web/API/Node/nodeType)

空白填充字符，两个`unicode`编码：

* `\ufeff` : 
  *  `Unicode3.2` 之前，`\uFEFF` 表示「零宽不换行空格（Zero Width No-Break Space）」；
  *  `Unicode3.2`新增了 `\u2060 `用来表示零宽不换行空格，`\uFEFF` 就只用来表示「字节次序标记（Byte Order Mark）」，即用来放在文件开头标记字节顺序。

* `\u200b`: 零宽度空白，通常用来占位，但却不会显示下设备上。（光标会将其当做一个字符，所以遇到零宽空白时会停下，不会跳到下一个字符处，再按一下才会跳到下一个字符），实际应用中常用来作为换行控制（英文输入时避免一个单词被断在两行）。



### API

| 方法                                          | 说明                                                         |
| --------------------------------------------- | ------------------------------------------------------------ |
| `getPosition(nodeA,nodeB)`                    | 获取节点A相对于节点B的位置关系                               |
| `getNodeIndex(node,bool)`                     | 检测节点在父节点中的索引位置，`bool`【可选】,是否合并多个连续的文本节点 |
| `inDoc(node,ducument)`                        | 检测节点`node`是否在给定的`document`对象上                   |
| `findParent(node,filterFn， bool)`            | 根据给定的过滤规则，查找符合该过滤规则的`node`节点的第一个祖先节点, `bool`【可选】，起点是否为其自身 |
| `findParentByTagName(node,tagNamesArr, bool)` | 查找`node`的节点名为`tagName`的第一个祖先节点。`bool`【可选】，查找的起点是否为给定的节点 |
| `findParents(node,bool)`                      | 查找节点的祖先节点集合，`bool`【可选】，给定节点是否出现在结果集中 |
| `insertAfter(node,newNode)`                   | 在节点`node`后面插入新节点`newNode`                          |
| ` remove(node, bool)`                         | 删除节点`node`及其下属所有节点，`bool`【可选】，是否保留子节点 |
| `getNextDomNode(node，bool)`                  | 取得`node`节点的下一个兄弟节点，如果该节点其后没有兄弟节点，则递归查找其父节点之后的第一个兄弟节点，直到找到满足条件的节点或者递归到BODY节点之后才会结束。`bool`【可选】，是否从给定节点的子节点开始查找。 |
| `getWindow(node)`                             | 获取`node`节点所属的`window`对象                             |
| `getCommonAncestor(nodeA,nodeB)`              | 获取离`nodeA`与 `nodeB` 最近的公共的祖先节点                 |
| `clearEmptySibling(node,boolleft,boolright)`  | 清除`node`节点左右连续为空的兄弟`inline`节点，`boolleft`【可选】，是否忽略右边的兄弟节点，`booright`【可选】，是否忽略左边的兄弟节点 |
| `split(node,offset)`                          | 将一个文本节点拆分成两个文本节点，`offset`指定拆分位置。     |
| `isWhitespace(node)`                          | 检测文本节点是否为空节点                                     |
| `getXY(element)`                              | 获取元素`element`相对于视窗的位置坐标                        |
| `on(element, type, fn)`                       | 为元素`element`绑定原生DOM事件，`type`为事件类型，`fn`为处理函数 |
| `un(element,type,fn)`                         | 解除DOM事件绑定                                              |
| `isSameElement(nodeA,nodeB)`                  | 比较`nodeA`与`nodeB`是否具有相同的标签名、属性名以及属性值   |
| `isSameStyle(nodeA,nodeB)`                    | 判断`nodeA`与`nodeB`的元素`style`属性是否一致                |
| `isBlockElm(node)`                            | 检查节点`node`是否为`block`元素                              |
| `isBody(node)`                                | 检测`node`节点是否为`body`节点                               |
| `breakParent(node,parentNode)`                | 以`node`节点为分界，将该节点的指定祖先节点`parentNode`拆分成两个独立节点。拆分形成的两个节点之间是`node`节点。 |
| `isEmptyInlineElement(node)`                  | 检查节点是否为空的`inline`节点                               |
| `trimWhiteTextNode(node)`                     | 删除节点`node`下首尾两端的空白文本节点                       |
| `getElementsByTagName(node,tagName)`          | 原生方法`getElementsByTagName`的封装                         |
| `mergeToParent(node)`                         | 将节点`node`提取到父节点上                                   |
| `mergeSibling(node,boolLeft,boolRight)`       | 合并节点`node`的左右兄弟节点,`bool`【可选】，可以根据给定的条件选择是否忽略合并左节点，`boolRight`【可选】 ，根据给定条件选择是否忽略合并右节点 |
| `unSelectable(node)`                          | 设置节点`node`及其子节点不会被选中                           |
| `removeAttributes(node, attrNames)`           | 删除`node`节点上指定属性名称的属性                           |
| `createElments(doc, tagName, attrs)`          | 在`doc`下创建一个标签名为`tag`，属性为`attrs` 的元素         |
| `setAttributes(node, attrs)`                  | 为节点`node` 添加属性                                        |
| `getComputedStyle(element,styleName)`         | 获取元素经过计算的样式值                                     |
| `removeClasses(ele, classNames)`              | 删除元素指定的类名                                           |
| `addClass(ele,classNames)`                    | 给元素添加类名                                               |
| `hasClass(ele, classNames)`                   | 判断元素是否包含指定类名                                     |
| `preventDefault(evt)`                         | 阻止事件默认行为                                             |
| `removeStyle(ele, styleName)`                 | 删除元素指定的样式                                           |
| `getStyle(ele, styleName)`                    | 获取元素指定的样式值                                         |
| `setStyle(ele, styleName, styleValue)`        | 为元素设置单个样式                                           |
| `setStyles(ele, objstyles)`                   | 为元素设置多个样式                                           |
| `getChildCount(node, fn)`                     | 获取子节点的数量, `fn`【可选】,过滤函数                      |
| `isEmptyNode(node)`                           | 判断给定节点是否为空节点                                     |
| `scrollToView(node,win,offsetTop)`            | 将显示区域滚动到指定节点的位置                               |
| `isBr(node)`                                  | 判断给定节点是否为`br`                                       |
| `isEmptyBlock(ele, reg)`                      | 判断给定的元素是否是一个空元素，`reg`【可选】，指定判断规则  |
| `setViewportOffset(ele, offset)`              | 移动元素使得该元素的位置移动指定的偏移量的距离               |
| `moveChild(src, tag, dir)`                    | 把节点`src`的所有子节点追加到另一个节点`tag`上去，`dir`【可选】，布尔值，控制附加的行为是'追加'还是‘插入顶部’ |
| `isTagNode(node, tagName)`                    | 检测节点的标签是否为给定的标签                               |
| `filterNodeList(nodeList, fn)`                | 给定一个节点数组，在通过制定的过滤函数过滤后，获取其中满足过滤条件的第一个节点 |
| `filterNodeList(nodeList, tagNames)`          | 给定一个节点数组和一个标签名，获取节点数组中能够匹配标签名的节点集合中的第一个节点。 |
| `filterNodeList(nodeList,fn, forAll)`         | 给定一个节点数组，在通过指定函数过滤后，如果参数`forAll`为`true`，则会返回所有满足过滤条件的节点集合，否则，返回满足条件的节点集合中的第一个节点 |
| `isInNodeEndBoundary(rng)`                    | 查询给定的`rng`选区是否在给定的`node`节点内，且在该节点的最末尾 |

## 每个方法的实现解析

### `getPosition(nodeA,nodeB)`

```javascript
getPosition:function (nodeA, nodeB) {
    //...
        // domUtils.POSITION_FOLLOWING
        return  2;
    },

```

从实现看，我们可以学习到以下几点：

* `dom`节点是可以进行全等判断的，如果全等为真，则说明是同一个节点。这里隐含了另外一层意思：即使两个节点标签名、内容、属性等全都一样，它们也不会全等，因为它们不是同一个节点

```javascript
 // 如果两个节点是同一个节点
        if (nodeA === nodeB) {
            // domUtils.POSITION_IDENTICAL
            return 0;
        }
```



* 判断`nodeA`包含`nodeB`或者`nodeB`包含`nodeA` 的算法都是通过遍历它们自身的祖先节点，看是否与对方相等

```javascript
 			var node,
            parentsA = [nodeA],
            parentsB = [nodeB];
        node = nodeA;
        while (node = node.parentNode) {
            // 如果nodeB是nodeA的祖先节点
            if (node === nodeB) {
                // domUtils.POSITION_IS_CONTAINED + domUtils.POSITION_FOLLOWING
                return 10;
            }
            parentsA.push(node);
        }
        node = nodeB;
        while (node = node.parentNode) {
            // 如果nodeA是nodeB的祖先节点
            if (node === nodeA) {
                // domUtils.POSITION_CONTAINS + domUtils.POSITION_PRECEDING
                return 20;
            }
            parentsB.push(node);
        }
```



* 如果两个节点互不包含，且两个节点的根节点不是同一个节点，则两个节点不在同一个文档中

```
		parentsA.reverse();
        parentsB.reverse();
        if (parentsA[0] !== parentsB[0]) {
            // domUtils.POSITION_DISCONNECTED
            return 1;
        }
```



* 通过循环祖先节点的索引找到两个节点的公共父节点，遍历`nodeA`之后的兄弟节点，如果其中一个节点是`nodeB`，则说明节点A在节点B之前

```javascript
		var i = -1;
        while (i++, parentsA[i] === parentsB[i]) {
        }
        nodeA = parentsA[i];
        nodeB = parentsB[i];
        while (nodeA = nodeA.nextSibling) {
            if (nodeA === nodeB) {
                // domUtils.POSITION_PRECEDING
                return 4
            }
        }
```



* 不符合以上情况，则节点A在节点B之后。
* 这个方法返回一个整型值，分别代表以下结果：
  * 0：元素相同
  * 1：两个节点在不同文档中
  * 2：节点A在节点B之后
  * 4： 节点A在节点B之前
  * 8：节点A被节点B包含
  * 10：节点A被节点B包含且节点A在节点B之后
  * 16：节点A包含节点B
  * 20：节点A包含节点B且节点A在节点B之前

### `getNodeIndex(node, ignoreTextNode)`

作用：获取节点`node`在父节点中的索引位置

其基本思想就是初始索引值为0，循环遍历节点之前的兄弟节点，每次迭代将前一个节点设为当前节点，判断如果参数`ignoreTextNdoe`为真，且当前节点类型为文本节点，则跳过当前迭代，每次迭代索引值加1，直到前面再无兄弟节点，此时获得的索引值就是节点在父节点中的位置索引。

```javascript
getNodeIndex:function (node, ignoreTextNode) {
        var preNode = node,
            i = 0;
        while (preNode = preNode.previousSibling) {
            if (ignoreTextNode && preNode.nodeType == 3) {
                if(preNode.nodeType != preNode.nextSibling.nodeType ){
                    i++;
                }
                continue;
            }
            i++;
        }
        return i;
    },
```

### `findParent(node, filterFn, includeSelf)`

作用：根据给定过滤条件，查找符合条件的第一个祖先节点，可设置是否包含自身。

* 传入的`node`不可以是`body`节点
* 根据`includeSelf`参数，如果不包含自身，则从父节点开始查找
* 循环，每次迭代使用过滤条件来判断当前节点是否符合条件，如果符合且不是`body`节点，返回当前节点，否则，将当前节点的父节点设置为当前节点，开始下一次迭代
* 如果没有符合条件的，返回`null`

```javascript
findParent:function (node, filterFn, includeSelf) {
        if (node && !domUtils.isBody(node)) {
            node = includeSelf ? node : node.parentNode;
            while (node) {
                if (!filterFn || filterFn(node) || domUtils.isBody(node)) {
                    return filterFn && !filterFn(node) && domUtils.isBody(node) ? null : node;
                }
                node = node.parentNode;
            }
        }
        return null;
    },
```



### `findParentByTagName(node, tagNames, includeSelf, excludeFn)`

作用：找到指定标签名的父节点

其实就是对`findParent()`方法的封装，只不过过滤条件是固定的一个标签名数组



### `findParents(node, includeSelf, filterFn, closerFirst)`

作用：查找祖先节点

也是对`findParent()`方法的封装，只不过找到符合条件的节点不直接返回，而是找到所有符合条件的，加入到一个数组再返回



### `insertAfter(node, newNode)`

作用：将`newNode` 插入到 `node` 之后

* 如果`node` 后面还有兄弟节点，就将`newNode`插入到该兄弟节点之前
* 否则，说明`node`已经是父节点的最后一个子节点，则将`nweNode`追加为父节点的子节点，并追加到最后位置

```javascript
insertAfter:function (node, newNode) {
        return node.nextSibling ? node.parentNode.insertBefore(newNode, node.nextSibling):
            node.parentNode.appendChild(newNode);
    },
```



### `remove(node, keepChildren)`

作用： 删除节点，可控制是否保留子节点（即只删除节点自身）

* 如果节点没有父节点（比如document），则什么也不做，直接返回节点
* 如果节点有父节点
  * 如果保留子节点，则遍历节点的子节点并全部插入为其父节点的子节点
  * 从父节点上删除该节点

```javascript
remove:function (node, keepChildren) {
        var parent = node.parentNode,
            child;
        if (parent) {
            if (keepChildren && node.hasChildNodes()) {
                while (child = node.firstChild) {
                    parent.insertBefore(child, node);
                }
            }
            parent.removeChild(node);
        }
        returnode;
    },
```

### `getNextDomNode(node, startFromChild, filterFn, guard)`

作用： 查找节点的下一个节点，如果存在兄弟节点，则返回下一个兄弟节点，如果不存在兄弟节点，则返回父节点的下一个兄弟节点，以此类推

其实就是对`getDomNode`的封装。

### `getPreDomNode(node, startFromChild, filterFn, guard)`

作用：查找节点的上一个节点，如果存在上一个兄弟节点，则返回，如果不存在，则返回父节点的前一个兄弟节点，以此类推；

也是对`getDomNode`的封装

### `isBookmarkNode(node)`

作用： 检测节点是否是编辑器定义的书签节点

满足条件：

	* 必须是元素节点（nodeType 为1）
	* 必须具有id属性
	* id属性的值包含`_baidu_bookmark_`标识

### `getWindow(node)`

作用： 获取节点所属的window对象

```javascript
getWindow:function (node) {
        var doc = node.ownerDocument || node;
        return doc.defaultView || doc.parentWindow;
    },
```

1. 通过node.ownerDocument获取到文档节点
2. 通过defaultView获取当前window

### `getCommonAncestor(nodeA, nodeB)`

作用： 获取离nodeA与nodeB最近的公共祖先节点

1. 如果两个节点是同一个节点，直接返回该节点
2. 分别定义A的祖先节点数组和B的祖先节点数组，并且让当前父节点是A，迭代索引 i 初始值为-1
3. 循环迭代：
   1. 令当前父节点为当前父节点的父节点
   2. 如果当前父节点与B相同，则返回当前父节点 (说明B节点是A节点的祖先节点)
   3. 否则，将当前父节点加入到A的祖先节点数组
4. 令当前父节点为B节点
5. 循环迭代
   1. 令当前父节点为当前父节点的父节点
   2. 如果当前父节点与A是同一个节点，则返回当前父节点（说明A节点是B节点的祖先节点）
   3. 否则，将当前父节点加入到B节点祖先节点数组
6. 反转A节点祖先节点数组和B节点祖先节点 （A和B没有包含关系）
7. 循环迭代
   1. 迭代索引 i 值+1
   2. 如果A节点的祖先节点数组的第i 个节点与 B 节点祖先节点数组的第 i 个节点为同一个节点，结束迭代
8. 如果此时迭代索引 i 为 0， 返回null， 否则， 返回A节点祖先节点数组的第 i-1 个节点。

```javascript
getCommonAncestor:function (nodeA, nodeB) {
        if (nodeA === nodeB)
            return nodeA;
        var parentsA = [nodeA] , parentsB = [nodeB], parent = nodeA, i = -1;
        while (parent = parent.parentNode) {
            if (parent === nodeB) {
                return parent;
            }
            parentsA.push(parent);
        }
        parent = nodeB;
        while (parent = parent.parentNode) {
            if (parent === nodeA)
                return parent;
            parentsB.push(parent);
        }
        parentsA.reverse();
        parentsB.reverse();
        while (i++, parentsA[i] === parentsB[i]) {
        }
        return i == 0 ? null : parentsA[i - 1];

    },
```



### `clearEmptySibling(node,ignoreNext,ignorePre)`

作用： 清除node节点左右连续为空的兄弟inline节点

```javascript
clearEmptySibling:function (node, ignoreNext, ignorePre) {
        function clear(next, dir) {
            var tmpNode;
            while (next && !domUtils.isBookmarkNode(next) && (domUtils.isEmptyInlineElement(next)
                //这里不能把空格算进来会吧空格干掉，出现文字间的空格丢掉了
                || !new RegExp('[^\t\n\r' + domUtils.fillChar + ']').test(next.nodeValue) )) {
                tmpNode = next[dir];
                domUtils.remove(next);
                next = tmpNode;
            }
        }
        !ignoreNext && clear(node.nextSibling, 'nextSibling');
        !ignorePre && clear(node.previousSibling, 'previousSibling');
    },
```

1. 这里的关键算法是传参技巧，clear函数的第一个参数，传入的是`node.nextSibling`(或`node.previousSibling)`，第二个参数传入的是查找方向，如果前（后）一个节点是空的行内节点，则在清除它之前缓存下一个节点：`next[dir] == node.nextSibling.nextSibling`，然后以此类推地遍历之后的节点。
2. 关于判断条件：
   * 下一个节点是存在的
   * 下一个节点不能是编辑器的书签节点（算法见前面）
   * 下一个节点是内联的空节点
   * 下一个节点如果是空格（回车/换行/制表符），不能清除，fillChar 为空白填充字符`\ufeff`(IE6以下)或`\200B`

接下来就看看 `isEmptyInlineElement`方法



### `isEmptyInlineElement(node)`

```javascript
isEmptyInlineElement:function (node) {
        if (node.nodeType != 1 || !dtd.$removeEmpty[ node.tagName ]) {
            return 0;
        }
        node = node.firstChild;
        while (node) {
            //如果是创建的bookmark就跳过
            if (domUtils.isBookmarkNode(node)) {
                return 0;
            }
            if (node.nodeType == 1 && !domUtils.isEmptyInlineElement(node) ||
                node.nodeType == 3 && !domUtils.isWhitespace(node)
                ) {
                return 0;
            }
            node = node.nextSibling;
        }
        return 1;

    },
```



该函数的返回值是0或1，0为false，1为true，算法：

1. 如果节点不是元素类型（`nodeType`不等于1），节点不是`dtd.$removeEmpty`对象内定义的标签，则返回0；

   看看`dtd.$removeEmpty`对象里都有哪些标签：

   ```javascript
   // dtd.js
   //如果没有子节点就可以删除的元素列表，像span,a
           $removeEmpty : _({a:1,abbr:1,acronym:1,address:1,b:1,bdo:1,big:1,cite:1,code:1,del:1,dfn:1,em:1,font:1,i:1,ins:1,label:1,kbd:1,q:1,s:1,samp:1,small:1,span:1,strike:1,strong:1,sub:1,sup:1,tt:1,u:1,'var':1}),
   ```

2. 从节点的第一个子节点开始遍历，

   * 如果子节点是书签节点，说明节点不是空节点，返回0
   * 如果子节点是元素节点并且不是空的内联节点（这里递归调用本函数判断），或者子结点是文本节点并且不是空白字符，说明节点不是空的內联节点，返回0；
   * 如果不是以上情形，则是空的內联节点，返回1；



### `split(node,offset)`

作用： 将一个文本节点拆分成两个文本节点，`offset`指定拆分位置。

```javascript
split:function (node, offset) {
        var doc = node.ownerDocument;
        if (browser.ie && offset == node.nodeValue.length) {
            var next = doc.createTextNode('');
            return domUtils.insertAfter(node, next);
        }
        var retval = node.splitText(offset);
        //ie8下splitText不会跟新childNodes,我们手动触发他的更新
        if (browser.ie8) {
            var tmpNode = doc.createTextNode('');
            domUtils.insertAfter(retval, tmpNode);
            domUtils.remove(tmpNode);
        }
        return retval;
    },
```

1. 如果是IE，并且拆分位置位于节点末尾，则创建一个新的文本节点，并将它插入到原来节点的后面。
2. 使用splicText方法拆分文本节点。
3. 如果是IE8，在拆分后获得的新节点后插入一个新的空文本节点
4. 返回拆分获得的新节点

### `isWhitespace(node)`



#### 作用

检测文本节点`textNode`是否为空节点

```javascript
isWhitespace:function (node) {
        return !new RegExp('[^ \t\n\r' + domUtils.fillChar + ']').test(node.nodeValue);
   }
```

#### 分析

核心为正则表达式： `[^ \t\n\r]` , 就是判断节点文本是空文本值（包括换行等）。

### `getXY(element)`

#### 作用

获取元素element相对于viewport的位置坐标

```javascript
getXY:function (element) {
        var x = 0, y = 0;
        while (element.offsetParent) {
            y += element.offsetTop;
            x += element.offsetLeft;
            element = element.offsetParent;
        }
        return { 'x':x, 'y':y};
    },
```

#### 分析

1. 默认横纵坐标都为0；
2. 递归检测元素的`offsetParent`，并将他们的坐标累加；

### `on(element, type, handler)`

#### 作用

为元素绑定原生DOM事件

#### 分析

```javascript
on:function (element, type, handler) {

        var types = utils.isArray(type) ? type : utils.trim(type).split(/\s+/),
            k = types.length;
        if (k) while (k--) {
            type = types[k];
            if (element.addEventListener) {
                element.addEventListener(type, handler, false);
            } else {
                if (!handler._d) {
                    handler._d = {
                        els : []
                    };
                }
                var key = type + handler.toString(),index = utils.indexOf(handler._d.els,element);
                if (!handler._d[key] || index == -1) {
                    if(index == -1){
                        handler._d.els.push(element);
                    }
                    if(!handler._d[key]){
                        handler._d[key] = function (evt) {
                            return handler.call(evt.srcElement, evt || window.event);
                        };
                    }
                    element.attachEvent('on' + type, handler._d[key]);
                }
            }
        }
        element = null;
    }
```

1. 判断是否为多事件绑定，无论是否为多个事件，都把事件名转为一个数组。
2. 如果存在 `addEventListener` 方法，则直接使用此方法添加事件监听
3. 如果不存在`addEventListener` 方法，先判断事件绑定的方法是否具有_d私有属性，如果没有，则为其设置该属性
4. 生成唯一key值，检查待绑定元素是否已经绑定过事件
5. 如果未绑定过相同事件，则将待绑定元素加入已绑定元素数组，并且添加事件绑定；

### `un(element, type, handler)`

#### 作用

解除元素的事件绑定

#### 分析

```javascript
un:function (element, type, handler) {
        var types = utils.isArray(type) ? type : utils.trim(type).split(/\s+/),
            k = types.length;
        if (k) while (k--) {
            type = types[k];
            if (element.removeEventListener) {
                element.removeEventListener(type, handler, false);
            } else {
                var key = type + handler.toString();
                try{
                    element.detachEvent('on' + type, handler._d ? handler._d[key] : handler);
                }catch(e){}
                if (handler._d && handler._d[key]) {
                    var index = utils.indexOf(handler._d.els,element);
                    if(index!=-1){
                        handler._d.els.splice(index,1);
                    }
                    handler._d.els.length == 0 && delete handler._d[key];
                }
            }
        }
    }
```

解绑过程与绑定过程类似，不再分析



### `isSameElement(nodeA, nodeB)`

#### 作用

比较节点`nodeA`与节点`nodeB`是否具有相同的标签名、属性名一级属性值

#### 分析

```javascript
isSameElement:function (nodeA, nodeB) {
        if (nodeA.tagName != nodeB.tagName) {
            return false;
        }
        var thisAttrs = nodeA.attributes,
            otherAttrs = nodeB.attributes;
        if (!ie && thisAttrs.length != otherAttrs.length) {
            return false;
        }
        var attrA, attrB, al = 0, bl = 0;
        for (var i = 0; attrA = thisAttrs[i++];) {
            if (attrA.nodeName == 'style') {
                if (attrA.specified) {
                    al++;
                }
                if (domUtils.isSameStyle(nodeA, nodeB)) {
                    continue;
                } else {
                    return false;
                }
            }
            if (ie) {
                if (attrA.specified) {
                    al++;
                    attrB = otherAttrs.getNamedItem(attrA.nodeName);
                } else {
                    continue;
                }
            } else {
                attrB = nodeB.attributes[attrA.nodeName];
            }
            if (!attrB.specified || attrA.nodeValue != attrB.nodeValue) {
                return false;
            }
        }
        // 有可能attrB的属性包含了attrA的属性之外还有自己的属性
        if (ie) {
            for (i = 0; attrB = otherAttrs[i++];) {
                if (attrB.specified) {
                    bl++;
                }
            }
            if (al != bl) {
                return false;
            }
        }
        return true;
    }
```

1. 如果两个节点的标签名不同，返回假；
2. 如果两个节点的属性数量不同，返回假；
3. 遍历第一个节点的属性，
	1. 如果是`style`属性，
		1. 如果当前属性的`specified`属性为真，则第一个节点的有效计数器加一
		2. 利用isSameStyle方法比较两个节点的style属性是否相同，如果相同，则继续循环下一个属性，如果不同，返回假；
	2. 如果不是`style`属性
		1. 如果是IE浏览器
			1. 如果当前属性的`specified`属性为真，则第一个节点的有效计数器加一，并且获取节点二的同名属性
		2. 如果非IE浏览器， 则获取第二个节点的同名属性
		3. 如果第二个节点的同名属性的`specified`属性不为真，或者属性值与第二个节点同名属性的值不相等，则返回假，否则，继续循环下一个属性
4. 循环结束后，
	1. 如果是IE浏览器
		1. 遍历第二个节点的属性
			1. 如果当前属性的`specified`属性为真，则第二个节点的有效节点计数器加一
		2. 如果两个节点的有效节点计数器的值不相等，返回假。
	2. 如果不是IE浏览器，此时还未返回假，则返回真

> HTML DOM **specified** 属性用于判断 HTML 标签是否设置了属性值
如果在标签中设置了属性值，则 specified 属性返回 true，如果是 DTD/Schema 中的默认值，则返回 false
在遍历元素的attributes属性时，IE7 - 浏览器会返回 HTML 元素中所有可能的特性，包括没有指定的特性，可以利用特性节点的 specified 属性来解决 IE7 - 浏览器的这个问题。如果 specified 属性的值为 true，则意味着该属性被设置过。在 IE 中，所有未设置过的特性的该属性值都是 false。而在其他浏览器中，任何特性节点的 specified 值始终为 true

### `isSameStyle(nodeA, nodeB)`
#### 作用
判断节点A与节点B的元素的`style`属性是否一致
#### 解析
```javascript
isSameStyle:function (nodeA, nodeB) {

 var styleA = nodeA.style.cssText.replace(/( ?; ?)/g, ';').replace(/( ?: ?)/g, ':'),

 styleB = nodeB.style.cssText.replace(/( ?; ?)/g, ';').replace(/( ?: ?)/g, ':');

 if (browser.opera) {

 styleA = nodeA.style;

 styleB = nodeB.style;

 if (styleA.length != styleB.length)

 return false;

 for (var p in styleA) {

 if (/^(\\d+|csstext)$/i.test(p)) {

 continue;

 }

 if (styleA\[p\] != styleB\[p\]) {

 return false;

 }

 }

 return true;

 }

 if (!styleA || !styleB) {

 return styleA == styleB;

 }

 styleA = styleA.split(';');

 styleB = styleB.split(';');

 if (styleA.length != styleB.length) {

 return false;

 }

 for (var i = 0, ci; ci = styleA\[i++\];) {

 if (utils.indexOf(styleB, ci) == -1) {

 return false;

 }

 }

 return true;

 },
```

1. 先拿到两个节点的`style`属性的`cssText`属性，并过滤掉其中`css`属性分号左右多余的空格
2. 如果是`opera`浏览器 ，做以下前置处理
	1. 获取到另个节点的`style`属性
	2. 如果两个`style`属性（数组）的长度不一样，返回假
	3. 遍历第一个节点的`style`属性数组
		1. 如果当前属性名是全数字或者`cssText`，则跳过继续循环下一个
		2. 如果第一个节点`style`属性数组中的当前属性与第二个节点`style`属性数组中同名的属性的值不同，则返回假
	4. 遍历结束，如果还未返回假，则返回真。 
3. 如果两个节点其中一个的`cssText`不存在，则看另一个节点的是否也不存在，如果存在，则返回假，如果也不存在，则说明两个节点都没有设置样式，返回真
4. 使用分号分割两个节点的`cssText`属性为`css`规则数组
5. 如果两个规则数组的长度不相等，返回假。
6. 遍历第一个属性数组中的`css`规则，如果第二个规则数组中没有相同的规则，则返回假。
7. 到这一步还没有返回假，则返回真。
### `isBlockElm(node)`
#### 作用
检查节点是否为`block`块元素
#### 解析
```javascript
isBlockElm:function (node) {

 return node.nodeType == 1 && (dtd.$block[node.tagName] || styleBlock[domUtils.getComputedStyle(node, 'display')]) && !dtd.$nonChild[node.tagName];

 },
```

该方法的判断规则如下： 
* 如果该元素原本是block元素， 则不论该元素当前的css样式是什么都会返回true； 
	* 原本就是block的元素：
```javascript
{
address:1,  // 联系信息标记
blockquote:1, // 长引用标记
center:1, // 居中标记，已弃用
dir:1, // 目录列表- 已弃用
div:1, // 分区标记
dl:1, // 定义列表标记
fieldset:1, // 表单元素分组标记
form:1, // 表单标记
h1:1, // 一级标题标记
h2:1, // 二级标题标记
h3:1, // 三级标题标记
h4:1, // 四级标题标记
h5:1, // 五级标题标记
h6:1, // 六级标题标记
hr:1, // 水平分割线标记
isindex:1, //不知道
menu:1, // 菜单标记- 暂不支持
noframes:1, // 为不支持框架的浏览器显示的文本标记
ol:1, // 有序列表标记
p:1, // 段落文本标记
pre:1, // 预格式化标记
table:1, // 表格标记
ul:1 // 无序列表标记
}
```
* 否则，检测该元素的css样式， 
	* 如果该元素当前是block元素， 则返回true。 
	* 其余情况下都返回false。
```javascript
标识元素为block元素的样式，display为以下值：

'-webkit-box', '-moz-box', 'block' ,

 'list-item' , 'table' , 'table-row-group' ,

 'table-header-group', 'table-footer-group' ,

 'table-row' , 'table-column-group' , 'table-column' ,

 'table-cell' , 'table-caption'

```

以上情况均要排除 `iframe` 和`textarea` 标签

### `isBody(node)`
#### 作用
检测节点是否为`body`节点
#### 分析
``` javascript
isBody:function (node) {

 return node && node.nodeType == 1 && node.tagName.toLowerCase() == 'body';

 },
```

同时满足以下三个条件：
* 节点存在
* 节点的`nodeType` 为 1（元素节点）
* 节点的标签名`tagName` 为`body`

### `breakParent(node,parent)`
#### 作用
以node节点为分界，将该节点的指定祖先节点parent拆分成两个独立的节点,拆分形成的两个节点之间是node节点
#### 分析
``` javascript
breakParent:function (node, parent) {

 var tmpNode,

 parentClone = node,

 clone = node,

 leftNodes,

 rightNodes;

 do {

 parentClone = parentClone.parentNode;

 if (leftNodes) {

 tmpNode = parentClone.cloneNode(false);

 tmpNode.appendChild(leftNodes);

 leftNodes = tmpNode;

 tmpNode = parentClone.cloneNode(false);

 tmpNode.appendChild(rightNodes);

 rightNodes = tmpNode;

 } else {

 leftNodes = parentClone.cloneNode(false);

 rightNodes = leftNodes.cloneNode(false);

 }

 while (tmpNode = clone.previousSibling) {

 leftNodes.insertBefore(tmpNode, leftNodes.firstChild);

 }

 while (tmpNode = clone.nextSibling) {

 rightNodes.appendChild(tmpNode);

 }

 clone = parentClone;

 } while (parent !== parentClone);

 tmpNode = parent.parentNode;

 tmpNode.insertBefore(leftNodes, parent);

 tmpNode.insertBefore(rightNodes, parent);

 tmpNode.insertBefore(node, rightNodes);

 domUtils.remove(parent);

 return node;

 },
   
   
  
```

1. 定义变量
* 临时节点 tmpNode,
* 祖先节点副本 parentClone, 初始化为分界节点
* 分界节点副本 clone, 初始化为分界节点
* 分界前的节点
* 分界后的节点

2. 循环
	1. 祖先节点副本被赋值为当前祖先节点的父节点
	2. 如果分界前的节点存在
		1. 临时节点为当前祖先节点副本本身的副本
		2. 将分界前节点添加为临时节点的最后一个子节点
		3. 将临时节点赋值给分界前节点
		4. 临时节点赋值为当前祖先节点副本本身的副本
		5. 将分界后节点添加为临时节点的最后一个子节点
		6. 将临时节点赋值给分界后节点
	3. 如果分界前节点不存在
		1. 分界前节点赋值为当前祖先节点本身的副本
		2. 分界后节点赋值为当前分界前节点本身的副本
	4. 循环遍历分界节点之前的兄弟节点，并将兄弟节点插入到分界前节点的第一个子节点前
	5. 循环遍历分界节点之后的兄弟节点，并将兄弟节点插入到分界后节点的最后一个子节点之后。
	6. 将分界节点副本赋值为祖先节点副本。
	7. 如果当前的祖先节点副本和指定祖先节点不是同一个节点，则继续循环，否则结束循环。

3. 将临时节点赋值为指定祖先节点的父节点
4. 将分界前节点插入到指定祖先节点之前
5. 将分界后节点插入到指定祖先节点之前
6. 将指定分界节点插入到分界后节点之前
7. 移除指定祖先节点
8. 返回指定分界节点
### `isEmptyInlineElement(node)`
#### 作用
检测节点是否是空的inline节点

如果给定的节点是空的inline节点，则返回1，否则返回0

#### 分析
``` javascript
isEmptyInlineElement:function (node) {

 if (node.nodeType != 1 || !dtd.$removeEmpty\[ node.tagName \]) {

 return 0;

 }

 node = node.firstChild;

 while (node) {

 //如果是创建的bookmark就跳过

 if (domUtils.isBookmarkNode(node)) {

 return 0;

 }

 if (node.nodeType == 1 && !domUtils.isEmptyInlineElement(node) ||

 node.nodeType == 3 && !domUtils.isWhitespace(node)

 ) {

 return 0;

 }

 node = node.nextSibling;

 }

 return 1;

  

 },
```

1. 如果节点的`nodeType`不等于1，或者是没有子节点就可以删除的元素，则返回0，

没有子节点就可以删除的元素：

```javascript
{
a:1,  // 超链接标记
abbr:1, // 缩写标记
acronym:1, // 首字母缩写标记
address:1, // 地址或联系信息标记
b:1, // 粗体标记
bdo:1, // 文本方向定义标记
big:1, // 大号字体标记
cite:1, // 文献引用标记
code:1, // 计算机代码标记
del:1, // 删除线标记
dfn:1, // 术语定义标记
em:1, // 内容强调标记
font:1, // 字体属性设置标记
i:1, // 斜体文本标记
ins:1, // 新增内容标记
label:1, // 输入框说明标记
kbd:1, // 键盘文本定义标记
q:1, // 短引用标记
s:1, // 删除线文本标记 - strike标签缩写，已弃用
samp:1, // 样本文本定义（系统终端或浏览器控制台输出样式）
small:1, // 小号字体标记
span:1, // 行内标记
strike:1,  // 删除线文本标记 - 已弃用
strong:1, // 内容强调标记，强调程度高于em
sub:1, // 下标文本定义标记
sup:1, // 上标文本定义标记
tt:1,  // 等宽字体文本标记
u:1, // 文本下划线标记
var:1 // 变量名称标记
}
```

2. 令 `node` 为 给定节点的第一个子节点
3. 循环
	1. 如果当前`node`指向的节点是书签节点，返回0
	2. 如果当前`node`指向节点的`nodeType`为1（元素节点） 并且它不是空的`inline`节点，或者，当前指向节点的`nodeType`为3（文本节点），并且它不是空白节点，返回0
	3. 令`node`为当前指向节点的下一个兄弟节点，继续循环，直到最后一个兄弟节点。
4. 如果循环结束，还没有返回0，则返回1

### `trimWhiteTextNode(node)`
#### 作用
删除node节点下首尾两端的空白文本子节点
#### 分析
```javascript
trimWhiteTextNode:function (node) {

 function remove(dir) {

 var child;

 while ((child = node[dir]) && child.nodeType == 3 && domUtils.isWhitespace(child)) {

 node.removeChild(child);

 }

 }

 remove('firstChild');

 remove('lastChild');

 },
```

1. 现在内部定义了一个工具方法 `remove`，指定子元素类型，如果这个子元素符合指定类型，并且是文本节点，并且是空白节点，就删除这个子元素
2. 调用`remove`删除第一个子节点（如果符合条件才删除）
3. 调用`remove` 删除最后一个子节点(如果符合条件才删除)
### `mergeChild(node, tagName, attrs)`
#### 作用
合并`node`节点下相同的子节点
#### 分析
```javascript
mergeChild:function (node, tagName, attrs) {

 var list = domUtils.getElementsByTagName(node, node.tagName.toLowerCase());

 for (var i = 0, ci; ci = list[i++];) {

 if (!ci.parentNode || domUtils.isBookmarkNode(ci)) {

 continue;

 }

 //span单独处理

 if (ci.tagName.toLowerCase() == 'span') {

 if (node === ci.parentNode) {

 domUtils.trimWhiteTextNode(node);

 if (node.childNodes.length == 1) {

 node.style.cssText = ci.style.cssText + ";" + node.style.cssText;

 domUtils.remove(ci, true);

 continue;

 }

 }

 ci.style.cssText = node.style.cssText + ';' + ci.style.cssText;

 if (attrs) {

 var style = attrs.style;

 if (style) {

 style = style.split(';');

 for (var j = 0, s; s = style[j++];) {

 ci.style[utils.cssStyleToDomStyle(s.split(':')[0])] = s.split(':')[1];

 }

 }

 }

 if (domUtils.isSameStyle(ci, node)) {

 domUtils.remove(ci, true);

 }

 continue;

 }

 if (domUtils.isSameElement(node, ci)) {

 domUtils.remove(ci, true);

 }

 }

 },
```

1. 获取节点下与节点标签名相同的所有元素
2. 遍历这些元素
	1. 如果元素没有父节点或者是书签元素，则跳过这个元素继续遍历
	2. 如果是`span`标签
		1. 如果该元素是节点的直接子元素
			1. 清除节点首尾两端的空白子节点
			2. 如果清除后节点只剩一个子元素
				1. 则将该元素的样式追加到节点样式后面
				2. 删除该元素
				3. 继续遍历
		2. 如果该元素不是节点的直接子元素
			1. 将节点的样式追加到该元素样式后面
			2. 如果指定了属性参数
				1. 如果指定了样式属性
					1. 则将指定的样式属性追加到元素样式后面
			3. 如果该元素的样式与节点样式一样，则删除该元素后继续遍历
	3. 如果该元素与节点是同一个元素，则删除该元素


					
					
		
### ` getElementsByTagName (node, name,filter)`
#### 作用
原生方法`getElementsByTagName`的封装
#### 分析
```javascript
getElementsByTagName:function (node, name,filter) {

 if(filter && utils.isString(filter)){

 var className = filter;

 filter = function(node){return domUtils.hasClass(node,className)}

 }

 name = utils.trim(name).replace(/[ ]{2,}/g,' ').split(' ');

 var arr = [];

 for(var n = 0,ni;ni=name[n++];){

 var list = node.getElementsByTagName(ni);

 for (var i = 0, ci; ci = list[i++];) {

 if(!filter || filter(ci))

 arr.push(ci);

 }

 }

  

 return arr;

 },
```
1. 如果传入了`filter`参数，并且`filter`参数是个字符串，则将该字符串作为类名，定义过滤方法（以保护该类名为过滤条件）
2. 清除传入的`name`参数两端的空白符号，将连续两个以上的空格替换为1个空格，然后用空格分割之。
3. 遍历分割后的`name`标签数组
	1. 获得所有符合当前标签名的子元素
	2. 遍历获得的子元素列表，筛选出符合`filter`函数条件的，放入一个新数组
4. 返回新数组
### `mergeToParent(node)`
#### 作用
将节点`node`提取到父元素上
#### 分析
```javascript
mergeToParent:function (node) {

 var parent = node.parentNode;

 while (parent && dtd.$removeEmpty[parent.tagName]) {

 if (parent.tagName == node.tagName || parent.tagName == 'A') {//针对a标签单独处理

 domUtils.trimWhiteTextNode(parent);

 //span需要特殊处理  不处理这样的情况 <span stlye="color:#fff">xxx<span style="color:#ccc">xxx</span>xxx</span>

 if (parent.tagName == 'SPAN' && !domUtils.isSameStyle(parent, node)

 || (parent.tagName == 'A' && node.tagName == 'SPAN')) {

 if (parent.childNodes.length > 1 || parent !== node.parentNode) {

 node.style.cssText = parent.style.cssText + ";" + node.style.cssText;

 parent = parent.parentNode;

 continue;

 } else {

 parent.style.cssText += ";" + node.style.cssText;

 //trace:952 a标签要保持下划线

 if (parent.tagName == 'A') {

 parent.style.textDecoration = 'underline';

 }

 }

 }

 if (parent.tagName != 'A') {

 parent === node.parentNode && domUtils.remove(node, true);

 break;

 }

 }

 parent = parent.parentNode;

 }

 },
```

1. 获取节点的父节点
2. 从父节点开始向上遍历所有祖先节点（直到父节点标签不再是没有子元素就可以删除的元素）
	1. 如果祖先节点与节点标签名相同，或者祖先节点是A标签
		1. 清除祖先节点首尾两端的空白文本节点
		2. 如果祖先节点是SPAN标签，并且祖先节点与节点样式属性不同，或者祖先节点是A标签并且节点是SPAN标签
			1. 如果祖先节点的子节点数大于1，或者祖先节点不是节点的父节点
				1. 将祖先节点的样式追加到节点的样式后面
				2. 继续向上遍历
			1. 否则
				1. 将节点的样式追加到祖先节点的样式后面
				2. 如果祖先节点是A标签
					1. 祖先节点的样式里加入下划线
		3. 如果祖先节点不是A标签
			1. 如果当前祖先节点是节点的父节点，则删除节点。


### `mergeSibling(node, ignorePre, ignoreNext)`
#### 作用
合并节点`node`的左右兄弟节点，可以根据给定的条件选择是否忽略合并左右节点

#### 分析
```javascript
mergeSibling:function (node, ignorePre, ignoreNext) {

 function merge(rtl, start, node) {

 var next;

 if ((next = node[rtl]) && !domUtils.isBookmarkNode(next) && next.nodeType == 1 && domUtils.isSameElement(node, next)) {

 while (next.firstChild) {

 if (start == 'firstChild') {

 node.insertBefore(next.lastChild, node.firstChild);

 } else {

 node.appendChild(next.firstChild);

 }

 }

 domUtils.remove(next);

 }

 }

 !ignorePre && merge('previousSibling', 'firstChild', node);

 !ignoreNext && merge('nextSibling', 'lastChild', node);

 },
```

如果节点的兄弟节点不是书签节点而且类型是元素并且兄弟节点与节点具有相同的属性和属性值，则遍历兄弟节点的子节点，根据合并方向将他们插入为节点的第一个子节点或最后一个子节点。


### `unSelectable(node)`

#### 作用

设置节点node及其子节点不会被选中(即不会被加入拖蓝)

#### 分析

```javascript
function (node) {

 node.style.MozUserSelect =

 node.style.webkitUserSelect =

 node.style.msUserSelect =

 node.style.KhtmlUserSelect = 'none';

 }
```


设置节点的CSS属性`-user-select` 属性为`none`;

### `removeAttributes(node, attrNames)`

#### 作用

删除节点node上的指定属性名称的属性

####  分析

```javascript
removeAttributes:function (node, attrNames) {

 attrNames = utils.isArray(attrNames) ? attrNames : utils.trim(attrNames).replace(/[ ]{2,}/g,' ').split(' ');

 for (var i = 0, ci; ci = attrNames[i++];) {

 ci = attrFix[ci] || ci;

 switch (ci) {

 case 'className':

 node[ci] = '';

 break;

 case 'style':

 node.style.cssText = '';

 var val = node.getAttributeNode('style');

 !browser.ie && val && node.removeAttributeNode(val);

 }

 node.removeAttribute(ci);

 }

 },
```

1. 确保传入的属性是一个数组，如果不是，就使用`split`方法将其转换为数组
2. 遍历这些属性
	1. 如果属性名是`className`,则将节点的该属性设置为空
	2. 如果属性名是`style`，则将节点的样式值设为空，并将属性删除
	3. 删除节点上的该属性
### `createElement(doc, tag, attrs)`

#### 作用

在doc下创建一个标签名为tag，属性为attrs的元素

#### 分析

```javascript
createElement:function (doc, tag, attrs) {

 return domUtils.setAttributes(doc.createElement(tag), attrs)

 },
```

1. 调用`doc`上的`createElement`方法创建标签
2. 利用`setAttributes`方法将属性添加到标签上


### `setAttributes(node, attrs)`

#### 作用

为节点node添加属性attrs，attrs为属性键值对

#### 分析

```javascript
setAttributes:function (node, attrs) {

 for (var attr in attrs) {

 if(attrs.hasOwnProperty(attr)){

 var value = attrs[attr];

 switch (attr) {

 case 'class':

 //ie下要这样赋值，setAttribute不起作用

 node.className = value;

 break;

 case 'style' :

 node.style.cssText = node.style.cssText + ";" + value;

 break;

 case 'innerHTML':

 node[attr] = value;

 break;

 case 'value':

 node.value = value;

 break;

 default:

 node.setAttribute(attrFix[attr] || attr, value);

 }

 }

 }

 return node;

 },
```

1. 遍历要设置的属性
2. 如果某个属性是传入的属性数组的自有属性
	1. 获取要设置的属性值
	2. 如果属性是`class`，则设置节点的`className` 为属性值
	3. 如果属性是`style`， 则设置节点`style.cssText` 的值为原有的值加上新设置的值
	4. 如果属性是`innerHTML`, 则使用中括号语法直接赋值
	5. 如果属性是`value`，则直接将节点的`value`设置为新值
	6. 默认地，使用`setAttribute`方法为节点设置属性。

### `getComputedStyle(element, styleName)`

#### 作用

获取元素`element`经过计算后的某个样式的值。

#### 分析

```javascript
getComputedStyle:function (element, styleName) {

 //一下的属性单独处理

 var pros = 'width height top left';

  

 if(pros.indexOf(styleName) > -1){

 return element['offset' + styleName.replace(/^\w/,function(s){return s.toUpperCase()})] + 'px';

 }

 //忽略文本节点

 if (element.nodeType == 3) {

 element = element.parentNode;

 }

 //ie下font-size若body下定义了font-size，则从currentStyle里会取到这个font-size. 取不到实际值，故此修改.

 if (browser.ie && browser.version < 9 && styleName == 'font-size' && !element.style.fontSize &&

 !dtd.$empty[element.tagName] && !dtd.$nonChild[element.tagName]) {

 var span = element.ownerDocument.createElement('span');

 span.style.cssText = 'padding:0;border:0;font-family:simsun;';

 span.innerHTML = '.';

 element.appendChild(span);

 var result = span.offsetHeight;

 element.removeChild(span);

 span = null;

 return result + 'px';

 }

 try {

 var value = domUtils.getStyle(element, styleName) ||

 (window.getComputedStyle ? domUtils.getWindow(element).getComputedStyle(element, '').getPropertyValue(styleName) :

 ( element.currentStyle || element.style )[utils.cssStyleToDomStyle(styleName)]);

  

 } catch (e) {

 return "";

 }

 return utils.transUnitToPx(utils.fixColor(styleName, value));

 },
```

1. 如果要获取的是需要单独处理的样式的值(`width, height, top, left`)，则返回元素的`offsetWidh/offsetHeight/offsetTop/offsetLeft`值（加单位）
2. 如果传入的是文本节点，则获取其父节点的对应属性值。
3. 处理IE9以下`font-size`属性的值(利用行框高度 = 字体大小的特性)
4. 使用`getStyle`方法获取元素的指定样式的值，如果返回为假值，则判断有无`window.getComputedStyle`方法，有的话就用该方法的`getPropertyValue`方法来获取指定样式的值，如果没有，则从元素的`currentStyle`或`style`对象上获取。
5. 将结果转换为像素单位返回。

### `removeClasses(elm, classNames)`

#### 作用

删除元素上指定的类（class）

#### 分析

```javascript
removeClasses:function (elm, classNames) {

 classNames = utils.isArray(classNames) ? classNames :

 utils.trim(classNames).replace(/[ ]{2,}/g,' ').split(' ');

 for(var i = 0,ci,cls = elm.className;ci=classNames[i++];){

 cls = cls.replace(new RegExp('\\b' + ci + '\\b'),'')

 }

 cls = utils.trim(cls).replace(/[ ]{2,}/g,' ');

 if(cls){

 elm.className = cls;

 }else{

 domUtils.removeAttributes(elm,['class']);

 }

 },

```

1. 将参数传入的类名处理为一个类名数组
2. 循环类名数组，将元素完整类名中的这些由参数指定要去除的类名都替换为空
3. 如果最后处理过的类名不为空，则将其作为元素的类名，否则，移除元素的类属性。

### `addClass(elm, classNames)`

#### 作用

为元素添加类

#### 分析

```javascript
addClass:function (elm, classNames) {

 if(!elm)return;

 classNames = utils.trim(classNames).replace(/[ ]{2,}/g,' ').split(' ');

 for(var i = 0,ci,cls = elm.className;ci=classNames[i++];){

 if(!new RegExp('\\b' + ci + '\\b').test(cls)){

 cls += ' ' + ci;

 }

 }

 elm.className = utils.trim(cls);

 },
```

1. 验证传入元素的存在性
2. 将传入的类名数组化
3. 循环类名数组，如果当前元素的不具有此类，则为之增加该类
4. 将处理后的类名字符串作为元素的类属性的值

### `hasClass(element, className)`

#### 作用 

判断指定元素是否具有指定的类名

#### 分析

```javascript
hasClass:function (element, className) {

 if(utils.isRegExp(className)){

 return className.test(element.className)

 }

 className = utils.trim(className).replace(/[ ]{2,}/g,' ').split(' ');

 for(var i = 0,ci,cls = element.className;ci=className[i++];){

 if(!new RegExp('\\b' + ci + '\\b','i').test(cls)){

 return false;

 }

 }

 return i - 1 == className.length;

 },
```

1. 如果传入的类名是一个正则表达式，则直接返回元素类属性值对这个正则的匹配性结果
2. 传入的 类名数组化
3. 循环类名数组，元素类属性值如果不包含其中任何一个，返回false
4. 看循环下标（减1）最后的值是否与类名数组长度一样，如果一样，说明包含传入的所有类，如果不一样，说明不完全包含。

### `preventDefault(evt)`

#### 作用

阻止事件默认行为

#### 分析

```javascript
preventDefault:function (evt) {

 evt.preventDefault ? evt.preventDefault() : (evt.returnValue = false);

 },

```

#### 分析

1. 针对新浏览器，直接执行`evt.preventDefault()`方法
2. 针对没有此方法的旧浏览器，通过设置`evt.returnValue`为`false`实现

### `removetyle(element, name)`

#### 作用

删除指定元素的指定样式

#### 分析
```javascript
removeStyle:function (element, name) {

 if(browser.ie ){

 //针对color先单独处理一下

 if(name == 'color'){

 name = '(^|;)' + name;

 }

 element.style.cssText = element.style.cssText.replace(new RegExp(name + '[^:]*:[^;]+;?','ig'),'')

 }else{

 if (element.style.removeProperty) {

 element.style.removeProperty (name);

 }else {

 element.style.removeAttribute (utils.cssStyleToDomStyle(name));

 }

 }

  
  

 if (!element.style.cssText) {

 domUtils.removeAttributes(element, ['style']);

 }

 },

```

1.  针对IE，通过将`style.cssText`中对应的样式属性和指替换为空来去除样式（针对color的处理经过IE仿真测试，这样处理会导致替换出错，没理解什么意思）
2.  针对其他浏览器，通过`style`对象上的`removeProperty()`或`removeAttribute()`方法来去除对应样式。
3.  如果去除该样式后，元素的style为空了，则直接移除元素的style属性。

### `getStyle(element, name)`

#### 作用

获取指定元素的指定样式属性的值

#### 分析

```javascript
getStyle:function (element, name) {

 var value = element.style[ utils.cssStyleToDomStyle(name) ];

 return utils.fixColor(name, value);

 },
```

1. 将CSS属性名转换为DOM属性名
2. 从元素`style`对象上获取对应DOM属性的值
3. 将值里面的rgb颜色转换为16进制的颜色值
4. 返回

### `setStyle(element, name, value)`

#### 作用

为元素设置样式属性值

#### 分析

```javascript

setStyle:function (element, name, value) {

 element.style[utils.cssStyleToDomStyle(name)] = value;

 if(!utils.trim(element.style.cssText)){

 this.removeAttributes(element,'style')

 }

 },
```

1. 将CSS属性名转换为DOM属性名
2. 为DOM样式属性设置值
3. 如果元素的内联样式文本为空，删除元素的 `style` 属性

### `setStyles(element, styles)`

#### 作用

为元素element设置多个样式属性值

#### 分析

```javascript
setStyles:function (element, styles) {

 for (var name in styles) {

 if (styles.hasOwnProperty(name)) {

 domUtils.setStyle(element, name, styles[name]);

 }

 }

 },
```

遍历`styles`对象中的样式属性和指，并使用上述`setStyle()`方法为元素设置样式

### `removeDirtyAttr(node)`

#### 作用

删除针对firefox的`_moz_dirty`属性(这是浏览器针对文本打印效果而自动为元素添加的属性)

#### 分析

```javascript
removeDirtyAttr:function (node) {

 for (var i = 0, ci, nodes = node.getElementsByTagName('*'); ci = nodes[i++];) {

 ci.removeAttribute('_moz_dirty');

 }

 node.removeAttribute('_moz_dirty');

 },
```

获取节点下所有标签，移除它们上面的`_moz_dirty`属性

### `getChildCount(node, fn)`

#### 作用

返回节点的子节点中符合条件的节点数量

#### 分析

```javascript
getChildCount:function (node, fn) {

 var count = 0, first = node.firstChild;

 fn = fn || function () {

 return 1;

 };

 while (first) {

 if (fn(first)) {

 count++;

 }

 first = first.nextSibling;

 }

 return count;

 },
```

1. 从第一个子节点开始遍历，如果节点符合过滤器条件，计数器加1
2. 返回计数器最后的值

### `isEmptyNode(node)`

#### 作用

判定给定节点是否为空节点

#### 分析

```javascript
isEmptyNode:function (node) {

 return !node.firstChild || domUtils.getChildCount(node, function (node) {

 return !domUtils.isBr(node) && !domUtils.isBookmarkNode(node) && !domUtils.isWhitespace(node)

 }) == 0

 },
```

如果节点的第一个子节点不存在，或者节点的非BR，非书签，非空白的子节点数为0，则判定为空节点。

### `scrollToView(node, win, offsetTop)`

#### 作用

将显示区域滚动到指定节点的位置

#### 分析

```javascript
scrollToView:function (node, win, offsetTop) {

 var getViewPaneSize = function () {

 var doc = win.document,

 mode = doc.compatMode == 'CSS1Compat';

 return {

 width:( mode ? doc.documentElement.clientWidth : doc.body.clientWidth ) || 0,

 height:( mode ? doc.documentElement.clientHeight : doc.body.clientHeight ) || 0

 };

 },

 getScrollPosition = function (win) {

 if ('pageXOffset' in win) {

 return {

 x:win.pageXOffset || 0,

 y:win.pageYOffset || 0

 };

 }

 else {

 var doc = win.document;

 return {

 x:doc.documentElement.scrollLeft || doc.body.scrollLeft || 0,

 y:doc.documentElement.scrollTop || doc.body.scrollTop || 0

 };

 }

 };

 var winHeight = getViewPaneSize().height, offset = winHeight * -1 + offsetTop;

 offset += (node.offsetHeight || 0);

 var elementPosition = domUtils.getXY(node);

 offset += elementPosition.y;

 var currentScroll = getScrollPosition(win).y;

 // offset += 50;

 if (offset > currentScroll || offset < currentScroll - winHeight) {

 win.scrollTo(0, offset + (offset < 0 ? -20 : 20));

 }

 },
```
 
 `getViewPaneSize`方法，获取文档宽高
 
 1. 获取当前文档的渲染模式，如果是`CSS1COMPAT`，为标准模式，否则为怪异模式
 2. 如果是标准模式，返回（`documentElement`）对象上的（`clientWidth`和`clientHeight`）作为文档的宽高
 3. 如果是怪异模式，返回`body` 对象的 （`clientWidth` 与 `clientHeight`)作为文档的宽高

`getScrollPosition(win)` 方法，获取滚动位置

1. 如果不是IE9以下的浏览器（IE9以下，window对象上没有`pageXoffset`属性），则返回当前窗口对象的`pageXoffset`和`pageYoffset`值作为位置坐标（其实就是`scrollX与scrollY`的别名）
2. 如果是IE9以下浏览器，返回`documentElement`对象的`scrollLeft`与`scrollTop`或者（前两个值不存在或为0)`body`对象的`scrollTop`和`scrollLeft`值。

滚动过程：
1. 拿到当前窗口的高度和，计算出要滚动的初始距离
2. 初始滚动距离加上指定的偏移量（即最终位置距离给定节点顶部的距离）
3. 获取节点的位置
4. 距离加上节点距离窗口顶部的距离
5. 获取到当前窗口的滚动位置和滚动距离
6. 如果计算的最终距离大于当前滚动距离，或者计算的最终距离小于当前滚动距离减去窗口高度的值，则将窗口滚动到最终距离处并加上一定距离（20px）;



### `isBr(node)`

#### 作用

判定给定节点是否为br

#### 分析

```js
isBr:function (node) {

 return node.nodeType == 1 && node.tagName == 'BR';

 },
```

如果节点是元素节点，并且它的标签名为`BR`，则为 `br`元素。

### `isEmptyBlock(node, reg)`

#### 作用

根据指定的判断规则判断给定的节点是否是一个空元素

#### 分析

```js
isEmptyBlock:function (node,reg) {

 if(node.nodeType != 1)

 return 0;

 reg = reg || new RegExp('[ \xa0\t\r\n' + domUtils.fillChar + ']', 'g');

  

 if (node[browser.ie ? 'innerText' : 'textContent'].replace(reg, '').length > 0) {

 return 0;

 }

 for (var n in dtd.$isNotEmpty) {

 if (node.getElementsByTagName(n).length) {

 return 0;

 }

 }

 return 1;

 },
```

1. 如果不是元素节点，返回假
2. 构建测试用的正则表达式，如果调用者传入了就用调用者传入的，没有传入则使用`[\xa0\t\r\n]` 空白符组作为正则表达式选项。
	1. `xa0`，其中`x`代表16进制，`a0`代表`0xa0`，是不间断空格的`unicode`码
	2. `\t`：`Tab` 制表符；
	3. `\r`: `return`；回车符(CR[carriage return])
	4. `\n`:  `new line` 换行符(LF(line feed))
3. 如果节点的文本内容中的空白符替换为空之后，文本内容的长度依旧大于零，则返回假
4.  遍历`dtd.$isNotEmpty`对象中的节点类型，如果节点的子节点里有其中任何一种类型，则返回假。
5.  经过以上步骤，还没返回假，就返回真。

```js
// dtd.$isNoEmpty
_({
table:1,
ul:1,
ol:1,
dl:1,
iframe:1,
area:1,
base:1,
col:1,
hr:1,
img:1,
embed:1,
input:1,
link:1,
meta:1,
param:1,
h1:1,
h2:1,
h3:1,
h4:1,
h5:1,
h6:1
}),

```

### `setViewportOffset(element, offset)`

#### 作用

移动元素使得该元素的位置移动指定的偏移量的距离

#### 分析

```js
setViewportOffset:function (element, offset) {

 var left = parseInt(element.style.left) | 0;

 var top = parseInt(element.style.top) | 0;

 var rect = element.getBoundingClientRect();

 var offsetLeft = offset.left - rect.left;

 var offsetTop = offset.top - rect.top;

 if (offsetLeft) {

 element.style.left = left + offsetLeft + 'px';

 }

 if (offsetTop) {

 element.style.top = top + offsetTop + 'px';

 }

 },
```

1. 获取元素当前样式设置的偏移量
2. 获取元素矩形实际坐标信息
3. 计算偏移后的坐标：用给定偏移量减去当前元素矩形实际的偏移坐标
4. 重置元素的样式，为原来样式的偏移量加上计算后的偏移量。

### `moveChild(src, tag, dir)`

#### 作用

把节点src的所有子节点移动到另一个节点tag上去, 可以通过dir参数控制附加的行为是“追加”还是“插入顶部”

#### 分析

```js
moveChild:function (src, tag, dir) {

 while (src.firstChild) {

 if (dir && tag.firstChild) {

 tag.insertBefore(src.lastChild, tag.firstChild);

 } else {

 tag.appendChild(src.firstChild);

 }

 }

 },
```

1. 遍历src节点的子元素，
2. 如果dir为true，则将src的最后一个子元素插入到tag节点的第一个子元素之前
3. 否则，将src节点的第一个子节点插入到tag节点的最后一个子元素之后。
4. 直到src的子节点全部被移动完为止。

### `isTagNode(node, tagNames)`

#### 作用

检测节点的标签是否为给定类型的标签

#### 分析

```js
 isTagNode:function (node, tagNames) {

 return node.nodeType == 1 && new RegExp('\\b' + node.tagName + '\\b','i').test(tagNames)

 },
```

如果：
* 节点是元素节点
* 节点的标签名称与给定的标签名匹配

则返回真，否则，返回假

### `filterNodeList(nodelist, filter,forAll)`

#### 作用

给定一个节点数组，在通过指定的过滤器过滤后， 如果参数forAll为true， 则会返回所有满足过滤条件的节点集合， 否则， 返回满足条件的节点集合中的第一个节点

#### 分析

```js
filterNodeList : function(nodelist,filter,forAll){

 var results = [];

 if(!utils .isFunction(filter)){

 var str = filter;

 filter = function(n){

 return utils.indexOf(utils.isArray(str) ? str:str.split(' '), n.tagName.toLowerCase()) != -1

 };

 }

 utils.each(nodelist,function(n){

 filter(n) && results.push(n)

 });

 return results.length == 0 ? null : results.length == 1 || !forAll ? results[0] : results

 },
```

1. 首先判断传入的过滤条件是否为函数
	1. 如果不是函数，则定义一个过滤函数：将过滤条件转换为字符串，然后判断这个字符串中是否有节点的标签名
2. 遍历节点数组，使用过滤函数来过滤节点，如果节点符合过滤函数的条件，将节点加入结果数组
3. 如果forAll为true，则返回结果数组，否则返回结果数组中的第一个节点。

### `isInNodeEndBoundary(rng, node)`

#### 作用
查询给定的range选区是否在给定的node节点内，且在该节点的最末尾

#### 分析

```js
isInNodeEndBoundary : function (rng,node){

 var start = rng.startContainer;

 if(start.nodeType == 3 && rng.startOffset != start.nodeValue.length){

 return 0;

 }

 if(start.nodeType == 1 && rng.startOffset != start.childNodes.length){

 return 0;

 }

 while(start !== node){

 if(start.nextSibling){

 return 0

 };

 start = start.parentNode;

 }

 return 1;

 },
```

1. 如果选区开始节点为文本节点并且开始偏移量不等于开始节点内容的长度，则返回假。
2. 如果选区开始节点为元素节点并且选区开始偏移量不等于开始节点子元素数量，返回假
3. 从开始节点不断向祖先节点遍历直到给定节点，如果遍历中的节点后面有兄弟节点， 则返回假
4. 完成以上步骤，还未返回假，则返回真。
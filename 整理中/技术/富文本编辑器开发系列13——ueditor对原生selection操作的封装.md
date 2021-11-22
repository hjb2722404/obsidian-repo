# `ueditor`对原生`selection`操作的封装

> 由于原生`selection`对象的方法在各个浏览器上实现存在差异，为了解决这些差异实现浏览器兼容性，`UEditor`对原生的`selection`对象进行了二次封装。

## 封装的API

| 方法                    | 说明                               |
| ----------------------- | ---------------------------------- |
| `getNative()`           | 获取原生`selection`对象            |
| `getIERange()`          | 在`IE9.0`及以下版本中获取拖蓝对象  |
| `cache()`               | 缓存当前选区的拖蓝和铨叙的开始节点 |
| `getStartElementPath()` | 获取选区开始位置的父节点到`body`   |
| `clear()`               | 清空缓存                           |
| `isFocus()`             | 编辑器是否得到了选区               |
| `getRange()`            | 获取选区对应的拖蓝                 |
| `getStart()`            | 获取开始元素，用于状态反射         |
| `getText()`             | 得到选区中的文本                   |
| `clearRange()`          | 清除选区                           |

## getNative——获取原生selection对象

在IE中，selection对象是直接挂载在文档对象上的，通过下面的方式获取：

```javascript
document.selection
```

而在非IE浏览器中，则是提供了一个getSelection()方法：

```javascript
window.getSelection();
// 或者
document.getSelection();
```

另外，要考虑到当前页面中没有选区的情况，需要返回null，因为返回值是一个object类型，null是一个对象类型，并且表示没有对象。

最终的兼容代码：

```javascript
getNative:function () {
            var doc = this.document;
            try {
                return !doc ? null : browser.ie9below ? doc.selection : domUtils.getWindow( doc ).getSelection();
            } catch ( e ) {
                return null;
            }
        },
```

## 私有方法 getBoundaryInformation

从名称我们可以看出，此方法是获取选区内某个拖蓝的边界信息的,

首先，使用`duplicate`方法将拖蓝复制一份，这样的话在复制出的拖蓝上的操作不会影响原拖蓝，可以避免对DOM结构的频繁修改，减少浏览器重绘。



> 从这里使用 `duplicate`方法和下面将使用的`moveToElementText`方法我们可知，本方法是用于IE浏览器和10.5版本以上的Opera浏览器的，因为只有这些浏览器才支持这两个方法。



然后将拖蓝闭合到选区的开始节点，并获取拖蓝的父元素（其实就是选区开始节点），如果该元素没有子节点，则退出，并返回一个对象，该对象有两个属性，`container`指明该拖蓝当前所在的容器（即选区开始节点），`offset`指明该拖蓝当前闭合点的偏移量为0。

```javascript
		var getIndex = domUtils.getNodeIndex;
        range = range.duplicate();
        range.collapse( start );
        var parent = range.parentElement();
        //如果节点里没有子节点，直接退出
        if ( !parent.hasChildNodes() ) {
            return  {container:parent, offset:0};
        }
```

如果该元素有子节点，则获取到它的所有子节点，然后再复制一份拖蓝，获取到子节点数组的开始索引和结束索引。开始以下循环，直到开始索引大于结束索引：

* 计算出子节点数组的中间项索引
* 获取到中间项
* 将当前拖蓝的开始点和结束点对齐到中间项元素的内容
* 比较当前拖蓝对象（上面复制的）的起点或终点的位置与原拖蓝对象对象的起点或终点的位置，将获得`-1/0/1`三个值中的一个
* 如果获得的结果大于0， 则说明第一个点在第二个点的后面，结束索引向前移动一格
* 如果获得的结果小于0，则说明第一个点在第二个点的前面，开始索引向后移动一格
* 如果获得的结果等于0，这说明两个点在同一个位置，直接返回结果，`container`仍旧是该元素，偏移量就是当前中间项在子节点中的索引值。



```javascript
			var siblings = parent.children,
            child,
            testRange = range.duplicate(),
            startIndex = 0, endIndex = siblings.length - 1, index = -1,
            distance;
        while ( startIndex <= endIndex ) {
            index = Math.floor( (startIndex + endIndex) / 2 );
            child = siblings[index];
            testRange.moveToElementText( child );
            var position = testRange.compareEndPoints( 'StartToStart', range );
            if ( position > 0 ) {
                endIndex = index - 1;
            } else if ( position < 0 ) {
                startIndex = index + 1;
            } else {
                //trace:1043
                return  {container:parent, offset:getIndex( child )};
            }
        }
```



如果经过上面的循环之后，当前索引仍旧是 `-1`， 则执行以下操作

* `moveToElementText()` 使拖蓝副本包含当前父元素的文本
* `setEndPoint()` 根据源拖蓝区域的端点设置当前拖蓝区域的结束点
* 计算出拖蓝副本内容的长度
* 获取当前元素的所有兄弟节点
* 如果内容长度为0， 则将当前节点的最后一个兄弟节点设置为子节点
* 返回结果，`container`是子元素，偏移量就是当前子节点的内容长度。
* 如果内容长度大于0， 则反向遍历兄弟节点，获取他们内容的长度，如果其中任何一个节点内容长度小于等于0，则停止，该节点的内容长度就是当前长度
* 返回结果，容器为停止遍历时满足条件的那个节点，偏移量为当前长度的负值



```
 if ( index == -1 ) {
     testRange.moveToElementText( parent );
     testRange.setEndPoint( 'StartToStart', range );
     distance = testRange.text.replace( /(\r\n|\r)/g, '\n' ).length;
     siblings = parent.childNodes;
     if ( !distance ) {
     child = siblings[siblings.length - 1];
     return  {container:child, offset:child.nodeValue.length};
     }

    var i = siblings.length;
    while ( distance > 0 ){
    distance -= siblings[ --i ].nodeValue.length;
    }
    return {container:siblings[i], offset:-distance};
    }
```

## getRange

在针对可编辑区域做任何操作前，我们都需要获得当前拖蓝区域（`range`）,而恰恰在`IE9`以下的`IE`浏览器版本跟其它浏览器获取区域的方法有差别，我们看看`UE`是如何做兼容的。

```javascript
getRange: function() {
                var me = this;

                function optimze(range) {
                    //...
                }

                if (me._cachedRange != null) {
                    return this._cachedRange;
                }
                var range = new baidu.editor.dom.Range(me.document);

                if (browser.ie9below) {
                    //...
                } else {
                   ///
                }
                return this._bakRange = range;
            },
```



主线逻辑：

1. 如果当前编辑器实例上有缓存的拖蓝区域，直接返回该区域
2. new一个封装好的Range对象
3. 如果浏览器为低于`IE9`的`IE`浏览器，进行处理
4. 其它浏览器，进行处理
5. 返回处理后的区域

### `Range`对象

```
var Range = dom.Range = function(document) {
            var me = this;
            me.startContainer =
                me.startOffset =
                    me.endContainer =
                        me.endOffset = null;
            me.document = document;
            me.collapsed = true;
        };
```

这里是传入了当前的文档对象（兼容`iframe`引入编辑器的情况）,然后初始化了区域对象的属性，这些属性的名称和原生`range`对象的属性名称是一样的。

```javascript
Range.prototype = {//...}
```

 然后在原型上定义了很多方法，这些方法可参考`API`手册。

### 对`IE9`以下浏览器的兼容

```javascript
if (browser.ie9below) {
var nativeRange = me.getIERange();
	if (nativeRange) {
//备份的_bakIERange可能已经失效了，dom树发生了变化比如从源码模式切回来，所以try一下，失效就放到body开始位置
        try {
            transformIERangeToRange(nativeRange, range);
        } catch (e) {
            optimze(range);
        }

	} else {
		optimze(range);
	}
}
```

1. 首先通过内部方法`getIERange`获取到区域对象
2. 如果区域对象不为null，则尝试将`IE`的区域对象转换为通用的区域对象格式，如果已经转换过了，则直接对上一步new出来的区域对象进行优化
3. 否则直接优化上一步new出的区域对象

#### `getIERange`

```javascript
getIERange: function() {
                var ieRange = _getIERange(this);
                if (!ieRange) {
                    if (this._bakIERange) {
                        return this._bakIERange;
                    }
                }
                return ieRange;
            },
            
  ......
  function _getIERange(sel) {
            var ieRange;
            //ie下有可能报错
            try {
                ieRange = sel.getNative().createRange();
            } catch (e) {
                return null;
            }
            var el = ieRange.item ? ieRange.item(0) : ieRange.parentElement();
            if ((el.ownerDocument || el) === sel.document) {
                return ieRange;
            }
            return null;
        }
  
```

`getIERange` 实则是调用了私有方法`_getIERange`，这个方法就是利用IE的`selection.createRange()`方法来获得一个拖蓝区域。这里获得的其实是一个元素，所以需要判断它是否有子元素，如果有，则返回其第一个子元素，如果没有，则返回它的父元素。并且需要判断拖蓝节点和选区是否出于同一个文档上下文中。


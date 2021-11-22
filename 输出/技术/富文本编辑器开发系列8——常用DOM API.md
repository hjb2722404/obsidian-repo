# 富文本编辑器开发系列——常用`DOM API`

## 获取window

通常，我们在浏览器中，都是直接通过 `window.xxx`来直接使用`window`对象的，但是由于浏览器中的页面可能包含框架集，此时每一个框架集都是有一个`window`对象，那么如何准确获取我们需要的`window`对象呢？

如果页面包含多个框架（一般来说，每一个），那么每个框架都加载的是不同的文档，它们都有自己的 `documet`文档对象，在每个`document`对象上都有一个名为 `defaultView`的属性指向它所在的`window`，所以我们可以这样或取某个文档关联的 `window`:

```javascript
var win = document.defaultView
```

如果该文档没有关联的对象，则会返回 `null`；

但是日常开发中，我们往往首先拿到的是某个DOM节点而非`document`对象，那我们又如何判断该节点是属于页面中哪个`document`呢？

每一个节点都有一个只读属性 `ownerDocument`，通过该属性，就可以获取到它所属的`document`：

```javascript
var doc = node.ownerDocument;
```

## 获取节点

### 通过元素ID获取节点

```javascript
document.getElementById()
```

### 通过元素的name属性获取节点

```javascript
document.getELementsByName()
```

### 通过元素标签获取节点

```javascript
document.getElementsByTagName()
```

## 节点指针

### 获取元素首个子节点

```javascript
node.firstChild
```

### 获取元素的最后一个子节点

```javascript
node.lastChild
```

### 获取元素的子节点列表

```javascript
node.childNodes
```

### 获取元素下一个兄弟节点

```javascript
node.nextSibling // 若不存在返回null
```

### 获取元素上一个兄弟节点

```javascript
node.previousSibling
```

### 获取元素的父节点

```javascript
node.parentNode
```

### 获取节点标签名

```javascript
node.tagName
```

## 元素操作

### 创建元素节点

```javascript
document.createElement(tagName)
```

### 创建属性节点

```javascript
document.createAttribute(attrName)
```

### 创建文本节点

```javascript
document.createTextNode(textContent)
```

### 在某个子节点前插入一个新的子节点

```javascript
node.insertBefore(newNode, node)
```

### 在最后一个位置追加一个子节点

```javascript
node.appendChild(newNode)
```

### 将某一个子节点替换为另一个

```javascript
node.replaceChild(newNode, oldNode)
```

### 创建指定节点的副本

```javascript
node.cloneNode(bool) // bool： ture-复制子节点  false-仅复制当前节点
```

### 删除子节点

```javascript
node.removeChild(childNode)
```

## 属性操作

### 获取元素的指定属性值

```javascript
node.getAttribute(attrName)
```

### 创建或改变元素节点的属性

```javascript
node.setAttribute(attrName, attrValue)
```

### 删除元素中的指定属性

```javascript
node.removeAttribute(attrName)
```

## 文本操作

### 从offset指定的位置插入string

```javascript
node.insertData(offset, String)
```

### 将string插入到文本节点的末尾处

```javascript
node.appendData(string)
```

### 从offset起删除count个字符

```javascript
node.deleteData(offset, count)
```

### 从offset将count个字符用string替代

```javascript
node.replaceData(offset, count, string)
```

### 从offset起将文本节点分成两个节点

```javascript
node.splitData(offset)
```

### 返回由offset起的count个节点

```javascript
node.substring(offset, count)
```


## HTMLElment元素的属性与方法总结




| 属性/方法名                | 描述                                                                                                                                                                                                                       |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| accessKey                  | 为元素指定获取焦点的快捷键                                                                                                                                                                                                 |
| align                      | ？                                                                                                                                                                                                                         |
| ariaAtomic                 | 指示辅助技术是否根据`aria-relevant`定义的通知显示全部或部分更改区域                                                                                                                                                        |
| ariaAutoComplete           | 反映了 `aria-autocomplete`属性的值，指示输入文本是否可触发自动完成功能                                                                                                                                                     |
| ariaBusy                   | 反映了 `aria-busy`属性的值，指示元素是否正在被修改，因为辅助技术可能希望等到修改完成后再将它们暴露给用户                                                                                                                   |
| ariaChecked                | 反映了 `aria-checked`属性的值，表示复选框、单选按钮或其它具有选中状态的控件的当前选中状态                                                                                                                                  |
| ariaColCount               | 反映了 aria-colcount 属性的值，该属性定义了表、网格或树形网格中的列数                                                                                                                                                      |
| ariaColIndex               | 反映了 aria-colindex 属性的值，该属性定义了元素的列索引或相对于表、网格或树形网格中总列数的位置                                                                                                                            |
| ariaColSpan                | 反映了 aria-colspan 属性的值，该属性定义了表格、网格或树形网格中的单元格或网格单元格所跨越的列数                                                                                                                           |
| ariaCurrent                | 反映了 aria-current属性的值，该属性指示表示容器或一组相关元素中的当前项的元素。                                                                                                                                            |
| ariaDescription            | 反映了 aria-description 属性的值，该属性定义了描述或注释当前元素的字符串值                                                                                                                                                 |
| ariaDisabled               | 反映了 aria-disabled 属性的值，表示该元素可感知但被禁用，因此不可编辑或以其他方式操作                                                                                                                                      |
| ariaExpanded               | 反映了 aria-expanded 属性的值，该属性表示该元素拥有或控制的分组元素是展开还是折叠                                                                                                                                          |
| ariaHasPopup               | 反映了 aria-haspopup 属性的值，该属性表示可以由元素触发的交互式弹出元素的可用性和类型，例如菜单或对话框                                                                                                                    |
| ariaHidden                 | 反映了 aria-hidden 属性的值，该属性指示元素是否暴露给可访问性 API。                                                                                                                                                        |
| ariaKeyShortcuts           | 反映了 aria-keyshortcuts 属性的值，该属性指示作者已实现的用于激活元素或将焦点置于元素上的键盘快捷键。                                                                                                                      |
| ariaLabel                  | 反映了 aria-label 属性的值，该属性定义了标记当前元素的字符串值。                                                                                                                                                           |
| ariaLevel                  | 反映了 aria-level 属性的值，该属性定义了结构中元素的层次级别。                                                                                                                                                             |
| ariaLive                   | 反映了 aria-live 属性的值，它表示一个元素将被更新，并描述了用户代理、辅助技术和用户可以从实时区域中期望的更新类型                                                                                                          |
| ariaModal                  | 反映了 aria-modal 属性的值，该属性表示元素在显示时是否为模态。                                                                                                                                                             |
| ariaMultiLine              | 反映了 aria-multiline 属性的值，该属性指示文本框是接受多行输入还是仅接受单行                                                                                                                                               |
| ariaMultiSelectable        | 反映了 aria-multiselectable 属性的值，表示用户可以从当前可选择的后代中选择多个项目                                                                                                                                         |
| ariaOrientation            | 反映了 aria-orientation 属性的值，表示元素的方向是水平、垂直还是未知/模糊                                                                                                                                                  |
| ariaPlaceholder            | 反映了 aria-placeholder 属性的值，该属性定义了一个简短的提示，旨在帮助用户在控件没有值时输入数据。                                                                                                                         |
| ariaPosInSet               | 反映了 aria-posinset 属性的值，该属性定义了元素在当前列表项或树项集中的编号或位置                                                                                                                                          |
| ariaPressed                | 反映了 aria-pressed 属性的值，表示当前切换按钮的“按下”状态                                                                                                                                                                 |
| ariaReadOnly               | 反映了 aria-readonly 属性的值，表示该元素不可编辑，但可操作                                                                                                                                                                |
| ariaRelevant               | 反映了 aria-relevant 属性的值，该属性指示当活动区域内的可访问性树被修改时用户代理将触发哪些通知。 这用于描述 aria-live 区域中的哪些变化是相关的并且应该公布                                                                |
| ariaRequired               | 反映了 aria-required 属性的值，它表示在提交表单之前需要用户在元素上输入。                                                                                                                                                  |
| ariaRoleDescription        | 反映了 aria-roledescription 属性的值，该属性为元素的角色定义了人类可读的、作者本地化的描述                                                                                                                                 |
| ariaRowCount               | 反映了 aria-rowcount 属性的值，该属性定义了表格、网格或树形网格中的总行数                                                                                                                                                  |
| ariaRowIndex               | 反映了aria rowindex属性的值，该属性定义了元素的行索引或相对于表、网格或treegrid中总行数的位置                                                                                                                              |
| ariaRowSpan                | 反映了 aria-rowspan 属性的值，该属性定义了表格、网格或树形网格中的单元格或网格单元格所跨越的行数。                                                                                                                         |
| ariaSelected               | 反映了 aria-selected 属性的值，它表示具有选中状态的元素的当前“选中”状态                                                                                                                                                    |
| ariaSetSize                | 反映了 aria-setsize 属性的值，该属性定义了当前列表项或树项集合中的项数                                                                                                                                                     |
| ariaSort                   | 反映了 aria-sort 属性的值，该属性指示表或网格中的项目是按升序还是降序排序。                                                                                                                                                |
| ariaValueMax               | 反映了 aria-valuemax 属性的值，该属性定义了范围小部件的最大允许值。                                                                                                                                                        |
| ariaValueMin               | 反映了 aria-valuemin 属性的值，该属性定义了范围小部件的最小允许值。                                                                                                                                                        |
| ariaValueNow               | 反映了 aria-valuenow 属性的值，该属性定义了范围小部件的当前值                                                                                                                                                              |
| ariaValueText              | 反映了 aria-valuetext 属性的值，该属性为范围小部件定义了 aria-valuenow 的人类可读文本替代方案                                                                                                                              |
| assignedSlot               | 只读属性返回一个HTMLSlotElement，表示节点插入的`<slot>` 元素                                                                                                                                                               |
| attributeStyleMap          | StylePropertyMap 接口提供了 CSS 声明块的表示，它是 CSSStyleDeclaration 的替代方案                                                                                                                                          |
| attributes                 | 返回注册到指定节点的所有属性节点的实时集合                                                                                                                                                                                 |
| autocapitalize             | 用于控制文本输入在用户输入/编辑时是否以及如何自动大写                                                                                                                                                                      |
| autofocus                  | 布尔属性，表示一个元素应该在页面加载后自动获得焦点，或者当它所属的 `<dialog>` 显示时                                                                                                                                       |
| baseURI                    | 返回节点的绝对基 URL                                                                                                                                                                                                       |
| childElementCount          | 只读属性返回此元素的子元素数。                                                                                                                                                                                             |
| childNodes                 | 只读属性返回给定元素的子节点的活动节点列表，其中为第一个子节点分配了索引0。子节点包括元素、文本和注释                                                                                                                      |
| children                   | 返回一个实时 HTMLCollection，其中包含调用它的元素的所有子元素。                                                                                                                                                            |
| classList                  | 只读属性，它返回元素的类属性的实时 DOMTokenList 集合。 然后可以使用它来操作类列表。                                                                                                                                        |
| className                  | 获取和设置指定元素的class属性的值                                                                                                                                                                                          |
| clientHeight               | 对于没有 CSS 或内联布局框的元素，Element.clientHeight 只读属性为零； 否则，它是以像素为单位的元素的内部高度。 它包括填充但不包括边框、边距和水平滚动条（如果存在）                                                         |
| clientLeft                 | 元素左边框的宽度（以像素为单位）。 如果元素的文本方向是从右到左，并且存在溢出导致呈现左垂直滚动条，则它包括垂直滚动条的宽度。 clientLeft 不包括左边距或左边距。 clientLeft 是只读的                                        |
| clientTop                  | 元素上边框的宽度（以像素为单位）。 它是元素的只读整数属性。                                                                                                                                                                |
| clientWidth                | 对于内联元素和没有CSS的元素，Element.clientWidth属性为零；否则，它是以像素为单位的元素的内部宽度。它包括填充，但不包括边框、边距和垂直滚动条（如果存在）                                                                   |
| contentEditable            | 指定元素是否可编辑                                                                                                                                                                                                         |
| dataset                    | 只读属性提供对元素的自定义数据属性（`data-*`）的读/写访问。它公开了一个字符串映射（DOMStringMap），每个`data-*`属性都有一个条目。                                                                                          |
| dir                        | 获取或设置当前元素内容的文本书写方向                                                                                                                                                                                       |
| draggable                  | 指示是否可以使用本机浏览器行为或HTML拖放API来拖动元素                                                                                                                                                                      |
| elementTiming              | ？                                                                                                                                                                                                                         |
| enterKeyHint               | 用于定义为虚拟键盘上的 Enter 键显示的操作标签（或图标）                                                                                                                                                                    |
| firstChild                 | 返回节点在树中的第一个子节点，如果节点没有子节点，则返回 null。 如果节点是 Document，则返回其直接子节点列表中的第一个节点                                                                                                  |
| firstElementChild          | 返回元素的第一个子元素，如果没有子元素，则返回 null                                                                                                                                                                        |
| hidden                     | 如果元素被隐藏则为真； 否则该值为假。 这与使用 CSS 属性 display 来控制元素的可见性有很大不同                                                                                                                               |
| id                         | 表示元素的标识符，反映 id 全局属性                                                                                                                                                                                         |
| innerHTML                  | 获取或设置元素中包含的HTML或XML标记                                                                                                                                                                                        |
| innerText                  | 表示节点及其子节点的“呈现”文本内容                                                                                                                                                                                         |
| inputMode                  | ？                                                                                                                                                                                                                         |
| isConnected                | 如果该节点与 DOM 树连接则返回 `true`, 否则返回 `false`                                                                                                                                                                     |
| isContentEditable          | 只读属性返回一个[`布尔值`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Boolean)：如果当前元素的内容为可编辑状态，则返回 `true`，否则返回 `false`。                                    |
| lang                       | 用来获取或设置元素属性值或文本内容的基语言                                                                                                                                                                                 |
| lastChild                  | 只读属性，返回当前节点的最后一个子节点                                                                                                                                                                                     |
| lastElementChild           | 只读属性返回元素的最后一个子元素，如果没有子元素，则返回 null。                                                                                                                                                            |
| localName                  | 只读属性返回元素限定名的本地部分                                                                                                                                                                                           |
| namespaceURI               | 只读属性返回元素的命名空间URI，如果元素不在命名空间中，则返回null。                                                                                                                                                        |
| nextElementSibling         | 只读属性返回紧跟在其父级子列表中指定元素之后的元素，如果指定元素是列表中的最后一个元素，则返回null。                                                                                                                       |
| nextSibling                | 只读属性返回紧跟在其父元素childNodes中指定节点之后的节点，或者如果指定节点是父元素中的最后一个子节点，则返回null。                                                                                                         |
| nodeName                   | 只读属性以字符串形式返回当前节点的名称                                                                                                                                                                                     |
| nodeType                   | 标识节点的整数。它区分不同类型的节点，如元素、文本和注释。                                                                                                                                                                 |
| nodeValue                  | 接口的 nodeValue 属性返回或设置当前节点的值                                                                                                                                                                                |
| nonce                      | 返回一次使用的加密编号，该编号由内容安全策略用于确定是否允许进行给定的获取                                                                                                                                                 |
| offsetHeight               | 只读属性以整数形式返回元素的高度，包括垂直填充和边框。                                                                                                                                                                     |
| offsetLeft                 | 只读属性返回当前元素的左上角在HTMLElement.offsetParent节点内向左偏移的像素数                                                                                                                                               |
| offsetParent               | 只读属性返回对元素的引用，该元素是最近（在包含层次结构中最近）定位的祖先元素。                                                                                                                                             |
| offsetTop                  | 只读属性返回当前元素的外边界相对于offsetParent节点顶部的内边界的距离                                                                                                                                                       |
| offsetWidth                | 只读属性以整数形式返回元素的布局宽度。                                                                                                                                                                                     |
| onabort                    | ？                                                                                                                                                                                                                         |
| onanimationend             | 处理animationend事件的事件处理程序。 当CSS动画完成时，将触发animationend事件。                                                                                                                                             |
| onanimationiteration       | 用于处理animationiteration事件的事件处理程序,当一个CSS动画的迭代结束，另一个开始时，就会触发animationiteration事件。                                                                                                       |
| onanimationstart           | 当CSS动画启动时，将触发animationstart事件                                                                                                                                                                                  |
| onauxclick                 | 当在同一个元素中按下并释放非主定点设备按钮（除了主按钮（通常是最左边的按钮）以外的任何鼠标按钮）时，auxclick事件将在元素上激发。                                                                                           |
| onbeforecopy               | ？                                                                                                                                                                                                                         |
| onbeforecut                | ？                                                                                                                                                                                                                         |
| onbeforepaste              | ？                                                                                                                                                                                                                         |
| onbeforexrselect           | ？                                                                                                                                                                                                                         |
| onblur                     | 属性是处理 blur 事件的事件处理程序。它可以在元素、文档和窗口中使用                                                                                                                                                         |
| oncancel                   | 属性是一个事件处理程序，用于处理发送到`<dialog>`元素的取消事件                                                                                                                                                             |
| oncanplay                  | 当用户代理可以播放媒体时，canplay 事件被触发，但是估计没有足够的数据被加载到播放媒体的末端，而不必停止进一步缓冲内容                                                                                                       |
| oncanplaythrough           | 当用户代理可以播放媒体时，将触发canplaythrough事件，并估计已经加载了足够的数据来播放媒体到最后，而不必停止进一步缓冲内容                                                                                                   |
| onchange                   | 用于处理更改事件的事件处理程序。                                                                                                                                                                                           |
| onclick                    | 处理给定元素上单击事件的事件处理程序。                                                                                                                                                                                     |
| onclose                    | 一个事件处理程序，用于处理发送到 `<dialog>` 元素的关闭事件。                                                                                                                                                               |
| oncontextmenu              | 当用户试图打开上下文菜单时，将触发contextmenu事件                                                                                                                                                                          |
| oncopy                     | 当用户试图复制文本时，copy事件激发。                                                                                                                                                                                       |
| oncuechange                | 当TextTrack更改了当前显示的提示时，将触发cuechange事件                                                                                                                                                                     |
| oncut                      | 当用户尝试剪切文本时，将触发cut事件                                                                                                                                                                                        |
| ondblclick                 | 处理给定元素上的 dblclick 事件的事件处理程序。当用户双击一个元素时会引发 dblclick 事件。 它在两次点击事件后触发                                                                                                            |
| ondrag                     | 拖动事件的全局事件处理程序                                                                                                                                                                                                 |
| ondragend                  | dragend事件的全局事件处理程序                                                                                                                                                                                              |
| ondragenter                | dragenter事件的全局事件处理程序                                                                                                                                                                                            |
| ondragleave                | dragleave 事件的全局事件处理程序                                                                                                                                                                                           |
| ondragover                 | dragover事件的全局事件处理程序                                                                                                                                                                                             |
| ondragstart                | dragstart事件的全局事件处理程序                                                                                                                                                                                            |
| ondrop                     | drop事件的全局事件处理程序                                                                                                                                                                                                 |
| ondurationchange           | `**durationchange**`事件会在`duration`发生变更时触发。                                                                                                                                                                     |
| onemptied                  | 当媒体变空时，会触发清空事件； 例如，如果媒体已加载（或部分加载），则发送此事件，并调用 load() 方法重新加载它。                                                                                                            |
| onended                    | 当由于到达媒体末尾而停止播放时会触发结束事件。                                                                                                                                                                             |
| onerror                    | 当尝试加载或执行媒体时发生某种形式的错误时会触发错误事件                                                                                                                                                                   |
| onfocus                    | 当用户将焦点设置在元素上时会引发 focus 事件                                                                                                                                                                                |
| onformdata                 | 用于处理 formdata 事件的事件处理程序，在表示表单数据的条目列表构建后触发。 这发生在提交表单时，但也可以通过调用 FormData() 构造函数来触发。 onformdata 在 HTMLFormElement 上可用                                           |
| onfullscreenchange         | 当元素进入或退出全屏模式时会触发该事件                                                                                                                                                                                     |
| onfullscreenerror          | 当尝试转换进入​​或退出全屏模式时发生错误时，该事件将发送到元素                                                                                                                                                             |
| ongotpointercapture        | 当元素使用 setPointerCapture() 捕获指针时会触发 gotpointercapture 事件                                                                                                                                                     |
| oninput                    | 它处理`<input>、<select>和<textarea>`元素上的输入事件。它还处理打开contenteditable或designMode的元素上的这些事件。                                                                                                         |
| oninvalid                  | 当可提交元素已被检查且不满足其约束时，将触发 invalid 事件                                                                                                                                                                  |
| onkeydown                  | 当用户按下键盘键时会触发 keydown 事件                                                                                                                                                                                      |
| onkeypress                 | keypress 事件应该在用户按下键盘上的一个键时触发。 但是，实际上浏览器不会为某些键触发按键事件【已弃用】                                                                                                                     |
| onkeyup                    | 当用户释放先前按下的键时，会触发keyup事件                                                                                                                                                                                  |
| onload                     | 当给定的资源已加载时，将触发 load 事件                                                                                                                                                                                     |
| onloadeddata               | 当媒体的第一帧完成加载时，会触发加载数据事件。                                                                                                                                                                             |
| onloadedmetadata           | 当元数据被加载时，loadedmetadata 事件被触发                                                                                                                                                                                |
| onloadstart                | 当请求开始加载数据时触发 loadstart 事件                                                                                                                                                                                    |
| onlostpointercapture       | 当一个捕获的指针被释放时，lostpointercapture 事件被触发                                                                                                                                                                    |
| onmousedown                | 当用户按下鼠标按钮时会触发 mousedown 事件                                                                                                                                                                                  |
| onmouseenter               | 当指针设备（通常是鼠标）移动到附加了侦听器的元素上时，会触发 mouseenter 事件                                                                                                                                               |
| onmouseleave               | 当指针设备（通常是鼠标）从附加了侦听器的元素上移开时，会触发 mouseleave 事件                                                                                                                                               |
| onmousemove                | 当用户移动鼠标时触发mousemove事件                                                                                                                                                                                          |
| onmouseout                 | 当鼠标离开元素时会触发 mouseout 事件。                                                                                                                                                                                     |
| onmouseover                | 当用户将鼠标移到特定元素上时会触发 mouseover 事件                                                                                                                                                                          |
| onmouseup                  | 当用户释放鼠标按钮时触发 mouseup 事件                                                                                                                                                                                      |
| onmousewheel               | 当操作鼠标滚轮或类似设备时，将异步触发鼠标滚轮事件【已弃用】                                                                                                                                                               |
| onpaste                    | 当用户尝试粘贴文本时，将触发粘贴事件                                                                                                                                                                                       |
| onpause                    | 当媒体播放暂停时会触发 pause 事件                                                                                                                                                                                          |
| onplay                     | 当由于 play 方法或 autoplay 属性将 paused 属性从 true 更改为 false 时，将触发 play 事件。                                                                                                                                  |
| onplaying                  | 当由于缺少媒体数据而暂停或延迟播放后准备开始播放时会触发playing事件                                                                                                                                                        |
| onpointercancel            | 当浏览器确定不可能再有任何指针事件时，将触发 pointercancel 事件，或者如果在触发 pointerdown 事件后，然后使用指针通过平移、缩放或滚动来操纵视口                                                                             |
| onpointerdown              | 当指针变为活动状态时，会触发 pointerdown 事件。                                                                                                                                                                            |
| onpointerenter             | 当指针设备移动到元素或其后代之一的命中测试边界时，pointerenter 事件会触发                                                                                                                                                  |
| onpointerleave             | 当指针设备移出元素的命中测试边界时，会触发 pointerleave 事件。                                                                                                                                                             |
| onpointermove              | 当指针改变坐标并且指针未被浏览器触摸操作取消时，会触发 pointermove 事件。                                                                                                                                                  |
| onpointerout               | 触发pointerout 事件有几个原因，包括：指针设备移出元素的命中测试边界； 为不支持悬停的设备触发 pointerup 事件（请参阅 pointerup）； 触发 pointercancel 事件后（参见 pointercancel）； 当触控笔离开数字化仪可检测的悬停范围时 |
| onpointerover              | 当指针设备移动到元素的命中测试边界时会触发 pointerover 事件                                                                                                                                                                |
| onpointerrawupdate         | ？                                                                                                                                                                                                                         |
| onpointerup                | 当指针不再活动时，会触发 pointerup 事件                                                                                                                                                                                    |
| onprogress                 | ？                                                                                                                                                                                                                         |
| onratechange               | ratechange 事件在播放速率改变时被触发                                                                                                                                                                                      |
| onreset                    | reset 事件在 `<form>` 被重置时触发                                                                                                                                                                                         |
| onresize                   | 在调整窗口大小后触发 resize 事件                                                                                                                                                                                           |
| onscroll                   | scroll 事件在文档视图或元素被用户、Web API 或用户代理滚动时触发                                                                                                                                                            |
| onsearch                   | 当使用 type="search" 的 `<input>` 元素启动搜索时，将触发搜索事件                                                                                                                                                           |
| onseeked                   | 当搜索操作完成、当前播放位置更改并且布尔搜索属性更改为false时，将触发seek事件                                                                                                                                              |
| onseeking                  | 当搜索操作开始时会触发搜索事件，这意味着布尔搜索属性已更改为 true 并且媒体正在寻找新位置                                                                                                                                   |
| onselect                   | select 事件仅在 `<input type="text">` 或 `<textarea>` 中的文本被选中后触发。                                                                                                                                               |
| onselectionchange          | selectionchange 事件在网页上选择的文本发生变化时触发                                                                                                                                                                       |
| onselectstart              | 当用户开始在网页上进行新的文本选择时触发 selectstart 事件                                                                                                                                                                  |
| onstalled                  | 当用户代理试图获取媒体数据时，但是数据出乎意料地不会出现,将触发停止的事件。                                                                                                                                                |
| onsubmit                   | 当用户提交表单时会触发 submit 事件                                                                                                                                                                                         |
| onsuspend                  | 当媒体数据加载已暂停时，会触发 suspend 事件。                                                                                                                                                                              |
| ontimeupdate               | 当 currentTime 属性指示的时间已更新时触发 timeupdate 事件                                                                                                                                                                  |
| ontoggle                   | ?                                                                                                                                                                                                                          |
| ontransitioncancel         | 当 CSS 过渡被取消时，将触发 transitioncancel 事件                                                                                                                                                                          |
| ontransitionend            | 当 CSS 过渡完成时会触发 transitionend 事件。 如果在完成之前移除了过渡，例如如果移除了过渡属性或显示设置为无，则不会生成该事件。                                                                                            |
| ontransitionrun            | 当 CSS 转换第一次创建时，即在任何转换延迟开始之前触发 transitionrun 事件                                                                                                                                                   |
| ontransitionstart          | 当 CSS 过渡实际开始时，即在任何过渡延迟结束后触发 transitionstart 事件                                                                                                                                                     |
| onvolumechange             | 当音量改变时会触发 volumechange 事件                                                                                                                                                                                       |
| onwaiting                  | 当由于暂时缺少数据而停止播放时会触发等待事件。                                                                                                                                                                             |
| onwebkitanimationend       | ?                                                                                                                                                                                                                          |
| onwebkitanimationiteration | ?                                                                                                                                                                                                                          |
| onwebkitanimationstart     | ?                                                                                                                                                                                                                          |
| onwebkitfullscreenchange   | ?                                                                                                                                                                                                                          |
| onwebkitfullscreenerror    | ?                                                                                                                                                                                                                          |
| onwebkittransitionend      | ?                                                                                                                                                                                                                          |
| onwheel                    | 当用户旋转鼠标（或其他指点设备）滚轮时，会触发滚轮事件。                                                                                                                                                                   |
| outerHTML                  | Element DOM 接口的 outerHTML 属性获取描述元素及其后代的序列化 HTML 片段。 它也可以设置为用从给定字符串解析的节点替换元素                                                                                                   |
| outerText                  | HTMLElement.outerText 是一个非标准属性。 作为一个 getter，它返回与 HTMLElement.innerText 相同的值。 作为 setter，它删除当前节点并用给定的文本替换它                                                                        |
| ownerDocument              | Node接口的ownerDocument只读属性返回节点的顶级文档对象                                                                                                                                                                      |
| parentElement              | Node.parentElement 只读属性返回 DOM 节点的父元素，如果节点没有父节点或其父节点不是 DOM 元素，则返回 null                                                                                                                   |
| parentNode                 | Node.parentNode 只读属性返回 DOM 树中指定节点的父节点                                                                                                                                                                      |
| part                       | Element 接口的 part 属性表示元素的部件标识符（即使用 part 属性设置），作为 DOMTokenList 返回。 这些可用于通过 ::part 伪元素设置 shadow DOM 的部分样式。                                                                    |
| prefix                     | Element.prefix 只读属性返回指定元素的命名空间前缀，如果没有指定前缀，则返回 null                                                                                                                                           |
| previousElementSibling     | Element.previousElementSibling 只读属性返回紧邻其父子项列表中指定元素之前的 Element，如果指定元素是列表中的第一个元素，则返回 null。                                                                                       |
| previousSibling            | Node.previousSibling 只读属性返回紧邻其父子节点列表中指定节点之前的节点，如果指定节点是该列表中的第一个节点，则返回 null。                                                                                                 |
| scrollHeight               | Element.scrollHeight 只读属性是对元素内容高度的度量，包括由于溢出而在屏幕上不可见的内容。                                                                                                                                  |
| scrollLeft                 | Element.scrollLeft 属性获取或设置元素内容从其左边缘滚动的像素数                                                                                                                                                            |
| scrollTop                  | Element.scrollTop 属性获取或设置元素内容垂直滚动的像素数                                                                                                                                                                   |
| scrollWidth                | Element.scrollWidth 只读属性是元素内容宽度的度量，包括由于溢出而在屏幕上不可见的内容。                                                                                                                                     |
| shadowRoot                 | Element.shadowRoot 只读属性表示元素托管的影子根。 使用 Element.attachShadow() 将阴影根添加到现有元素。                                                                                                                     |
| slot                       | Element 接口的 slot 属性返回元素插入的 shadow DOM slot 的名称                                                                                                                                                              |
| spellcheck                 | spellcheck 全局属性是一个枚举属性，定义是否可以检查元素是否存在拼写错误                                                                                                                                                    |
| style                      | style 全局属性包含要应用于元素的 CSS 样式声明。 请注意，建议在单独的一个或多个文件中定义样式。 此属性和 `<style>` 元素的主要目的是允许快速设置样式，例如用于测试目的                                                       |
| tabIndex                   | HTMLElement 接口的 tabIndex 属性表示当前元素的 Tab 键顺序                                                                                                                                                                  |
| tagName                    | Element 接口的 tagName 只读属性返回调用它的元素的标签名称。 例如，如果元素是 `<img>`，它的 tagName 属性是“IMG”（对于 HTML 文档；对于 XML/XHTML 文档，它的大小写可能不同）                                                  |
| textContent                | Node 接口的 textContent 属性表示节点及其后代的文本内容。                                                                                                                                                                   |
| title                      | title 全局属性包含表示与其所属元素相关的咨询信息的文本。                                                                                                                                                                   |
| translate                  | translate 全局属性是一个枚举属性，用于指定在页面本地化时是否应该翻译元素的可翻译属性值及其 Text 节点子项，或者是否保持它们不变                                                                                             |


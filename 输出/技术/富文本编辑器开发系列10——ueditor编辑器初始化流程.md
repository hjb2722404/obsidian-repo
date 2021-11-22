# ueditor源码分析——编辑器初始化流程

## 全局对象

`ueditor` 全局顶级的 `UE` 对象，并挂载在了`window` 对象上

```javascript
var baidu = window.baidu || {};

window.baidu = baidu;

window.UE = baidu.editor = window.UE || {};
```

在顶级 `UE` 对象上，又挂载了一些顶级模块，分别是：

* `UE.plugins` :  编辑器的插件对象，以键值对的形式存储所有插件
* `UE.commands`: 编辑器里的命令对象，以键值对形式存放编辑器命令
* `UE.instants` : 编辑器实例对象，存储所有编辑器实例，可以支持多实例同时运行
* `UE.I18N` : 编辑器的多语言支持对象
* `UE._customizeUI`: 自定义`UI`组件对象，存储用户自定义的编辑器`UI`组件（包括弹窗、按钮等）
* `UE.version` : 当前的`UE` 版本
* `UE.dom` :  `UE`的核心类——`dom`操作类，类似`microsoft office word`的操作主要就是借助这个类实现的
* `UE.browser` : 浏览器检测工具，可以检测浏览器内核和版本，在实现浏览器兼容的时候有用
* `UE.Editor`:  `UE`的核心类，为用户提供与编辑器交互的接口
* `UE.EventBase` ：`UE`的事件基类，主要用来注册监听事件，移除监听，触发事件等。
* `UE.uNode` :  编辑器模拟的节点类，在二次开发时非常有用，可以对编辑器中的内容进行节点级操作。
* `UE.ajax`: 请求工具类，用于异步场景，如文件上传等。
* `UE.utils`: 系统工具包，主要是一些常用工具方法是封装，为了减少依赖，没有使用`jquery`或`underscore`等库提供的工具，而是自己实现了一套。
* `UE.ui`: 私有工具方法，不对外暴露，主要提供界面创建功能。

## 流程概览

![编辑器初始化流程图](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210610152553.png)



## 全局入口

从官方文档可知，`UE`的入口其实就是构造了一个 `Editor`对象:

```javascript
<script type="text/javascript">
        var ue = UE.getEditor('container');
 </script>
```

我们看下`UE.getEditor` 的实现：

##### `ueditor.all.js`  在接近文件末尾的地方：

```javascript
//...
UE.getEditor = function(id, opt) {
            var editor = instances[id];
            if (!editor) {
                editor = instances[id] = new UE.ui.Editor(opt);
                editor.render(id);
            }
            return editor;
        };
//...
```

这是获取编辑器实例的方法，它接受两个参数:

* `id` : 编辑器的容器ID
* `opt`: 编辑器配置，具体配置说明可查看  [官方文档](http://fex.baidu.com/ueditor/[[start-config]])

这个方法会检查在编辑器实例存储对象（`instances`）中，是否已经有了同ID的编辑器实例，如果有，则返回，如果没有，则调用`UE.ui.Editor` 方法新建一个实例，并且将该实例渲染到ID所指定的容器中。

### 初始化编辑器界面

我们来看下 `UE.ui.Editor`方法是实现：

```javascript
var instances = {};


        UE.ui.Editor = function(options) {
            var editor = new UE.Editor(options);
            editor.options.editor = editor;
            utils.loadFile(document, {
                href: editor.options.themePath + editor.options.theme + '/css/ueditor.css?v=' + Math.random(),
                tag: 'link',
                type: 'text/css',
                rel: 'stylesheet',
            });

            var oldRender = editor.render;
            editor.render = function(holder) {
                if (holder.constructor === String) {
                    editor.key = holder;
                    instances[holder] = editor;
                }
                utils.domReady(function() {
                    editor.langIsReady ? renderUI() : editor.addListener('langReady', renderUI);

                    function renderUI() {
                        editor.setOpt({
                            labelMap: editor.options.labelMap || editor.getLang('labelMap'),
                        });
                        new EditorUI(editor.options);
                        if (holder) {
                            if (holder.constructor === String) {
                                holder = document.getElementById(holder);
                            }
                            holder && holder.getAttribute('name') && (editor.options.textarea = holder.getAttribute('name'));
                            if (holder && /script|textarea/ig.test(holder.tagName)) {
                                var newDiv = document.createElement('div');
                                holder.parentNode.insertBefore(newDiv, holder);
                                var cont = holder.value || holder.innerHTML;
                                editor.options.initialContent = /^[\t\r\n ]*$/.test(cont) ? editor.options.initialContent :
                                    cont.replace(/>[\n\r\t]+([ ]{4})+/g, '>')
                                        .replace(/[\n\r\t]+([ ]{4})+</g, '<')
                                        .replace(/>[\n\r\t]+</g, '><');
                                holder.className && (newDiv.className = holder.className);
                                holder.style.cssText && (newDiv.style.cssText = holder.style.cssText);
                                if (/textarea/i.test(holder.tagName)) {
                                    editor.textarea = holder;
                                    editor.textarea.style.display = 'none';


                                } else {
                                    holder.parentNode.removeChild(holder);


                                }
                                if (holder.id) {
                                    newDiv.id = holder.id;
                                    domUtils.removeAttributes(holder, 'id');
                                }
                                holder = newDiv;
                                holder.innerHTML = '';
                            }

                        }
                        domUtils.addClass(holder, 'edui-' + editor.options.theme);
                        editor.ui.render(holder);
                        var opt = editor.options;
                        //给实例添加一个编辑器的容器引用
                        editor.container = editor.ui.getDom();
                        var parents = domUtils.findParents(holder, true);
                        var displays = [];
                        for (var i = 0, ci; ci = parents[i]; i++) {
                            displays[i] = ci.style.display;
                            ci.style.display = 'block';
                        }
                        if (opt.initialFrameWidth) {
                            opt.minFrameWidth = opt.initialFrameWidth;
                        } else {
                            opt.minFrameWidth = opt.initialFrameWidth = holder.offsetWidth;
                            var styleWidth = holder.style.width;
                            if (/%$/.test(styleWidth)) {
                                opt.initialFrameWidth = styleWidth;
                            }
                        }
                        if (opt.initialFrameHeight) {
                            opt.minFrameHeight = opt.initialFrameHeight;
                        } else {
                            opt.initialFrameHeight = opt.minFrameHeight = holder.offsetHeight;
                        }
                        for (var i = 0, ci; ci = parents[i]; i++) {
                            ci.style.display = displays[i];
                        }
                        //编辑器最外容器设置了高度，会导致，编辑器不占位
                        //todo 先去掉，没有找到原因
                        if (holder.style.height) {
                            holder.style.height = '';
                        }
                        editor.container.style.width = opt.initialFrameWidth + (/%$/.test(opt.initialFrameWidth) ? '' : 'px');
                        editor.container.style.zIndex = opt.zIndex;
                        oldRender.call(editor, editor.ui.getDom('iframeholder'));
                        editor.fireEvent('afteruiready');
                    }
                });
            };
            return editor;
        };
```



差不多一百行代码，做了以下几件事：

1.  `new` 了一个 `UE.Editor`编辑器实例 ，传入了配置项
2. 加载主题样式文件
3. 缓存该实例默认的渲染方法
4. 重写该编辑器实例渲染方法
5. 返回编辑器实例

其它的没什么可说的，我们看下它为什么要重写渲染方法，以及渲染方法都做了什么

1. 渲染方法接收了一个`holder`参数，其实就是我们前面说的容器ID，所以编辑器先以将该ID设置成了编辑器的`key`，并且将编辑器存入了实例存储对象（`instances`）
2. 当浏览器DOM渲染加载完毕后，因为语言包配置可能是从后台异步加载，所以要先判断编辑器语言包是否就绪，如果就绪就执行编辑器渲染，如果没有就绪，则监听语言包就绪的事件，监听到就绪后执行渲染。
3.  新建了一个编辑器界面实例（`new EditorUI`），然后拿到了容器，检查了容器是否为`script`或`textarea`标签，如果是，在新建一个`div`容器，将`holder`容器的类名和`CSS`样式复制到新建的`div`容器上。如果`holder`容器是个`textarea`，就将它隐藏掉，如果不是，就直接移除。
4. 如果`holder`容器有`id`属性，将它的值赋给新的`div`容器，并且删除`holder`的`id`属性，以保证`id`的唯一性。
5. 将新的`div`容器作为新的`holder`容器使用。
6. 为容器增加主题类名
7. 将新容器渲染到页面中
8. 给实例添加一个编辑器的容器引用
9. 查找容器的所有祖先节点，缓存他们的`display`值，并将他们的`display`都设置为`block`， 避免初始化宽高时外层容器隐藏导致编辑器宽的`offsetWidth`和`offsetHeight`获取不准确
10. 为容器设置初始宽高
11. 恢复祖先元素的`display`值

12. 如果容器自身设置了高度，则去掉，否则编辑器不占位
13. 为容器设置宽高和显示层级
14. 使用缓存的渲染方法，渲染`iframeholder`容器。
15. 触发`afteruiready`事件。

那我们可能会好奇，这个`iframeholder`是怎么来的呢？

实际上是在新建编辑器界面实例时创建的，我们看下 `EditorUI`构造方法：

```javascript
function EditorUI(options) {
    this.initOptions(options);
    this.initEditorUI();
 }
```

这里也是调用了两个方法:

* 初始化`UI`配置
* 初始化`UI`界面

`initOptions`方法是`UIBase`类的原型方法，看一下实现：

```javascript
initOptions: function(options) {
    var me = this;
    for (var k in options) {
    me[k] = options[k];
    }
	this.id = this.id || 'edui' + uiUtils.uid();
},
```

实现很简单，实际上就是将`this`赋值给`me`，然后将传入的配置项全部赋值到`me`对象上，然后生成了当前`UI`的唯一ID

### 初始化编辑器UI

`initEditorUi`方法是`EditorUI`类的原型方法，看下实现

```javascript
initEditorUI: function() {
                this.editor.ui = this;
                this._dialogs = {};
                this.initUIBase();
                this._initToolbars();
                var editor = this.editor,
                    me = this;

                editor.addListener('ready', function() {
                  
                });

                editor.addListener('mousedown', function(t, evt) {
              
                });
                editor.addListener('delcells', function() {
                    
                });

                var pastePop, isPaste = false,
                    timer;
                editor.addListener('afterpaste', function() {
                   
                });

                editor.addListener('afterinserthtml', function() {
                   
                });
                editor.addListener('contextmenu', function(t, evt) {
                    baidu.editor.ui.Popup.postHide(evt);
                });
                editor.addListener('keydown', function(t, evt) {
                   
                });
                editor.addListener('wordcount', function(type) {
                    setCount(this, me);
                });

                function setCount(editor, ui) {
                   
                }

                editor.addListener('selectionchange', function() {
                   
                });
                var popup = new baidu.editor.ui.Popup({
                    
                });
                popup.render();
                if (editor.options.imagePopup) {
                    editor.addListener('mouseover', function(t, evt) {
                       
                    });
                    editor.addListener('selectionchange', function(t, causeByUi) {
                        
                    });
                }

            }
```

它做了这些事：

1. 将当前对象赋值给当前编辑器实例的`ui`对象
2. 定义对话框对象
3. 初始化基础`UI`
4. 初始化编辑器实例的工具条
5. 增加一系列事件监听：
   * `ready`： 编辑器加载完成
   * `mousedown`: 鼠标按下
   * `delcells`: 删除单元格
   * `afterpaste`: 粘贴后
   * `afterinserthtml`: 插入`html`后
   * `contextmenu`: 触发右键菜单后
   * `keydown` : 键盘按下
   * `wordcount`: 统计字体
   * `selectionchange` ： 选区改变
6. 定义弹出窗对象
7. 渲染弹窗
8. 如果配置了图片弹窗，则设置图片弹窗里的监听
   * `mouseover`: 鼠标划过
   * `selectionchange`: 选区内容改变

这其中比较重要的，是初始化基础`UI`和初始化工具条，我们分别看一下：

`initUIBase` 是`UIBase`类的原型方法，实现只有一句话：

```javascript
 this._globalKey = utils.unhtml(uiUtils.setGlobal(this.id, this));
```

这里，`setGlobal`会将第二个参数传入的对象设置到全局对象`root`上，键名是第一个参数，然后返回访问该对象的`key`。

```javascript
setGlobal: function(id, obj) {
    root[id] = obj;
    return magic + '["' + id + '"]';
},
```

为什么返回的`key`是一个`magic`对象成员访问的形式呢，看看`root`的定义就知道了：

```javascript
var magic = '$EDITORUI';
var root = window[magic] = {};
```

现在我们应该可以明白了，`root`就是挂载在window对象上的对象 `magic`, 我们实际上将当前实例（`this`）挂载到了`magic`上，所以访问时只需要使用`magic`的成员访问形式就可以访问到当前实例了。

最后，我们得到的当前实例的全局访问`key`（`this._globalKey`）是经过`unhtml`方法转义过后的形式为`magin[id]`的字符串，实际上就是`window[$EDITORUI]`[id]。

### 工具条初始化

回过头，我们再看初始化工具条的方法 `_initToolbars`， 它就是`EditorUI`类的原型方法

```
 _initToolbars: function() {
                var editor = this.editor;
                var toolbars = this.toolbars || [];
                var toolbarUis = [];
                for (var i = 0; i < toolbars.length; i++) {
                    // do Some thing 
                }

                //接受外部定制的UI

                utils.each(UE._customizeUI, function(obj, key) {
                    var itemUI, index;
                    if (obj.id && obj.id != editor.key) {
                        return false;
                    }
                    itemUI = obj.execFn.call(editor, editor, key);
                    if (itemUI) {
                        index = obj.index;
                        if (index === undefined) {
                            index = toolbarUi.items.length;
                        }
                        toolbarUi.add(itemUI, index);
                    }
                });

                this.toolbars = toolbarUis;
            },
```

我们看它做了哪些事：

1. 获得当前编辑器实例
2. 获取工具条（是个数组）
3. 定义工具的`UI` (也是个数组)
4. 遍历工具条数组，处理每一个工具
5. 接受外部定制的`UI`
6. 将工具`UI`数组作为工具条

这里面第4、5步比较重要。

先看第4步：

```javascript
var toolbar = toolbars[i];
var toolbarUi = new baidu.editor.ui.Toolbar({ theme: editor.options.theme });
for (var j = 0; j < toolbar.length; j++) {
    var toolbarItem = toolbar[j];
    var toolbarItemUi = null;
    if (typeof toolbarItem == 'string') {
        toolbarItem = toolbarItem.toLowerCase();
        if (toolbarItem == '|') {
            toolbarItem = 'Separator';
        }
        if (toolbarItem == '||') {
            toolbarItem = 'Breakline';
        }
        if (baidu.editor.ui[toolbarItem]) {
            toolbarItemUi = new baidu.editor.ui[toolbarItem](editor);
        }

        //fullscreen这里单独处理一下，放到首行去
        if (toolbarItem == 'fullscreen') {
            if (toolbarUis && toolbarUis[0]) {
                toolbarUis[0].items.splice(0, 0, toolbarItemUi);
            } else {
                toolbarItemUi && toolbarUi.items.splice(0, 0, toolbarItemUi);
            }
            continue;
        }
    } else {
    	toolbarItemUi = toolbarItem;
    }
    if (toolbarItemUi && toolbarItemUi.id) {

        toolbarUi.add(toolbarItemUi);
     }
    }
toolbarUis[i] = toolbarUi;
```

1. 取得当前工具条，这里一个工具条其实就是一行工具按钮，最终界面上有几行工具按钮，就有几个工具条。
2. 新建一个工具`UI`
3. 遍历当前这一行工具条中的所有工具名，进行如下处理
   1. 如果当前工具名是字符串类型，则将它转为全小写，做如下处理
      1. 如果是`|` ，则是分割符
      2. 如果是`||`， 则是换行符
      3. 如果当前编辑器实例的`ui`对象上有该工具同名的方法，则使用该方法实例化一个该类工具出来
      4. 如果当前工具名为`fullscrenn`（全屏）, 单独处理，放到首行去
   2. 如果不是字符串类型，说明是对象或数组，则当前工具的`UI`就被赋值为当前工具
   3. 如果此时当前工具`UI`存在并且具有`id` 属性，则将当前工具添加到当前这一行工具条`UI`中
4. 将当前行的工具条`UI`添加到整个工具条`UI`中

然后看第5步：

```javascript
utils.each(UE._customizeUI, function(obj, key) {
    var itemUI, index;
    if (obj.id && obj.id != editor.key) {
        return false;
    }
    itemUI = obj.execFn.call(editor, editor, key);
    if (itemUI) {
        index = obj.index;
        if (index === undefined) {
            index = toolbarUi.items.length;
        }
        toolbarUi.add(itemUI, index);
    }
});
```

这一步遍历了`UE._customizeUI`对象中的所有对象，将他们作为`UI`对象添加到了工具条中。

`UE`提供了 `UE.registerUI`方法，使得我们可以在二次开发时定制增加自己的工具到工具条中，实际上这个方法就是将我们提供的工具放在了`UE._custoomizeUI`对象中，然后在这里将它们添加到了工具条中。

这里首先判断了当前对象是否是注册在当前实例上的，如果不是，则中断执行。如果是，则让当前编辑器实例调用我们设定的执行方法生成它的`UI`， 然后将它插入到工具条中，这里的`index`参数是注册时传入的，可以定义插入的位置。

### render方法

现在我们再回过头来看`Editor`构造方法里的第14步： 使用缓存的渲染方法渲染`iframeholder`这一步，那我们就很好奇，这个缓存下的渲染方法是什么样的呢？

我们在`Editor.prototype`对象里找到了它：

```javascript
 /**
 * 渲染编辑器的DOM到指定容器
 * @method render
 * @param { Element } containerDom 直接指定容器对象
 * @remind 执行该方法,会触发ready事件
 * @warning 必须且只能调用一次
 */
render: function(container) {
   //... 
},
```



在这个方法中，先是获取了当前编辑器实例和配置，并且定义了一个获取dom样式的方法：

```javascript
 var me = this,
 options = me.options,
 getStyleValue = function(attr) {
 return parseInt(domUtils.getComputedStyle(container, attr));
 };
```

如果传入的容器参数是字符串，则以此为`id`获取容器真实元素：

```javascript
if (utils.isString(container)) {
	container = document.getElementById(container);
}
```

如果元素存在于页面，则根据元素的布局宽高（包含padding和border，不包含margin）设置元素的宽高，最终的宽高要减去元素当前的padding。

```javascript
if (container) {
	if (options.initialFrameWidth) {
        options.minFrameWidth = options.initialFrameWidth;
    } else {
        options.minFrameWidth = options.initialFrameWidth = container.offsetWidth;
    }
    if (options.initialFrameHeight) {
        options.minFrameHeight = options.initialFrameHeight;
    } else {
        options.initialFrameHeight = options.minFrameHeight = container.offsetHeight;
    }

    container.style.width = /%$/.test(options.initialFrameWidth) ? '100%' : options.initialFrameWidth -
        getStyleValue('padding-left') - getStyleValue('padding-right') + 'px';
    container.style.height = /%$/.test(options.initialFrameHeight) ? '100%' : options.initialFrameHeight -
        getStyleValue('padding-top') - getStyleValue('padding-bottom') + 'px';

    container.style.zIndex = options.zIndex;
```

创建编辑器的`html`代码：

```javascript
var html = (ie && browser.version < 9 ? '' : '<!DOCTYPE html>') +
            '<html xmlns=\'http://www.w3.org/1999/xhtml\' class=\'view\' ><head>' +
            '<style type=\'text/css\'>' +
            //设置四周的留边
            '.view{padding:0;word-wrap:break-word;cursor:text;height:90%;overflow:hidden}\n';
        //设置默认字体和字号
        //font-family不能呢随便改，在safari下fillchar会有解析问题
         html += 'body{margin:28px;font-family:宋体,SimSun;font-size:16px;}';
        //设置段落间距
        html += 'p{margin:5px 0;}</style>' +
            (options.iframeCssUrl ? '<link rel=\'stylesheet\' type=\'text/css\' href=\'' + utils.unhtml(options.iframeCssUrl) + '\'/>' : '') +
            (options.initialStyle ? '<style>' + options.initialStyle + '</style>' : '') +
            '</head><body class=\'view\' ></body>' +
            '<script type=\'text/javascript\' ' + (ie ? 'defer=\'defer\'' : '') + ' id=\'_initialScript\'>' +
            'setTimeout(function(){editor = window.parent.UE.instants[\'ueditorInstant' + me.uid + '\'];editor._setup(document);},0);' +
            'var _tmpScript = document.getElementById(\'_initialScript\');_tmpScript.parentNode.removeChild(_tmpScript);</script></html>';
```

这里面，要注意

* IE的9以下版本需要去掉`iframe`中页面的`DOCTYPE`头才能让`iframe`里的内容正常显示

然后就是将创建`iframe`并将`html`放入`iframe`中，并且设置超出隐藏：

```javascript
container.appendChild(domUtils.createElement(document, 'iframe', {
    id: 'ueditor_' + me.uid,
    width: '100%',
    height: '100%',
    frameborder: '0',
    //先注释掉了，加的原因忘记了，但开启会直接导致全屏模式下内容多时不会出现滚动条
    //scrolling :'no',
    src: 'javascript:void(function(){document.open();' + (options.customDomain && document.domain != location.hostname ? 'document.domain="' + document.domain + '";' : '') +
    'document.write("' + html + '");document.close();}())',
}));
container.style.overflow = 'hidden';
```

最后，设置了一个延时执行函数，来处理给定百分比时高度算不对的问题：

```javascript
//解决如果是给定的百分比，会导致高度算不对的问题
	setTimeout(function() {
        if (/%$/.test(options.initialFrameWidth)) {
        options.minFrameWidth = options.initialFrameWidth = container.offsetWidth;
        //如果这里给定宽度，会导致ie在拖动窗口大小时，编辑区域不随着变化
        //  container.style.width = options.initialFrameWidth + 'px';
        }
        if (/%$/.test(options.initialFrameHeight)) {
        options.minFrameHeight = options.initialFrameHeight = container.offsetHeight;
        container.style.height = options.initialFrameHeight + 'px';
        }
    });
}
```


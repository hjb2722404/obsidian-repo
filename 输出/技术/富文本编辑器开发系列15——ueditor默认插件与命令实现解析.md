# Ueditor源码分析——默认插件与命令实现解析

## 粘贴：paste

### 调用方式：

```javascript
ueditor.exceCommand('paste')
```



### 实现分析



```javascript
UE.plugins['paste'] = function () {
    function getClipboardData(callback){
        //...
    }
    var me = this;
    me.setOpt({//...});
    var tXtContent, htmlContent, address;
    function getPureHtml(){//...}
    function filter(div){//...}
    me.addListener('pasteTransfer', function(cmd, plainType){//..});
    me.addListener('ready', function(){//...});
    me.commands['paste'] = {//...}    
}
```



* 粘贴功能是以插件方式定义的。
* 在插件方法中定义了粘贴命令，作为执行粘贴操作的入口。
* 定义了三个私有方法，和三个局部变量，添加了两个事件监听器。

```javascript
	me.setOpt({
        retainOnlyLabelPasted : false
    });
```

 配置`retainOnlyLabelPasted` : 非纯文本粘贴模式下，是否净化HTML内容。

入口：

```javascript
me.commands['paste'] = {
        execCommand: function (cmd) {
            if (browser.ie) {
                getClipboardData.call(me, function (div) {
                    filter(div);
                });
                me.document.execCommand('paste');
            } else {
                alert(me.getLang('pastemsg'));
            }
        }
    }
```



这个入口易弃用，因为从它的逻辑看只支持IE下的粘贴操作，那真正的入口在哪呢？

```javascript
me.addListener('ready', function() {
            domUtils.on(me.body, 'cut', function() {
                var range = me.selection.getRange();
                if (!range.collapsed && me.undoManger) {
                    me.undoManger.save();
                }
            });

            //ie下beforepaste在点击右键时也会触发，所以用监控键盘才处理
            domUtils.on(me.body, browser.ie || browser.opera ? 'keydown' : 'paste', function(e) {
                if ((browser.ie || browser.opera) && ((!e.ctrlKey && !e.metaKey) || e.keyCode != '86')) {
                    return;
                }
                getClipboardData.call(me, function(div) {
                    filter(div);
                });
            });

        });
```

原来是在这个事件监听器中，当`UE`加载完成后，添加了两个监听，一个是在剪切时，如果当前光标所在拖蓝区域不是闭合的，就先保存好当前现场。另一个就是当监听到编辑器内容区域的粘贴事件时，就从系统剪贴板获取内容，并且对内容进行过滤后加入编辑器。

这里面有一个兼容操作，即在`IE`下或者`opera`下，`beforepaste`在点击右键时也会触发，所以对键盘做了一个监听判断，如果按下的不是`ctrl+v`，则说明不是粘贴，就中断执行。

```javascript
function getClipboardData(callback) {
        var doc = this.document;
        if (doc.getElementById('baidu_pastebin')) {
            return;
        }
        var range = this.selection.getRange(),
            bk = range.createBookmark(),
        //创建剪贴的容器div
            pastebin = doc.createElement('div');
        pastebin.id = 'baidu_pastebin';
        // Safari 要求div必须有内容，才能粘贴内容进来
        browser.webkit && pastebin.appendChild(doc.createTextNode(domUtils.fillChar + domUtils.fillChar));
        doc.body.appendChild(pastebin);
        //trace:717 隐藏的span不能得到top
        //bk.start.innerHTML = '&nbsp;';
        bk.start.style.display = '';
        pastebin.style.cssText = "position:absolute;width:1px;height:1px;overflow:hidden;left:-1000px;white-space:nowrap;top:" +
            //要在现在光标平行的位置加入，否则会出现跳动的问题
            domUtils.getXY(bk.start).y + 'px';

        range.selectNodeContents(pastebin).select(true);

        setTimeout(function () {
            if (browser.webkit) {
                for (var i = 0, pastebins = doc.querySelectorAll('[[baidu_pastebin]]'), pi; pi = pastebins[i++];) {
                    if (domUtils.isEmptyNode(pi)) {
                        domUtils.remove(pi);
                    } else {
                        pastebin = pi;
                        break;
                    }
                }
            }
            try {
                pastebin.parentNode.removeChild(pastebin);
            } catch (e) {
            }
            range.moveToBookmark(bk).select(true);
            callback(pastebin);
        }, 0);
    }
```

1. 先判断是否已经有了剪贴内容，避免没有执行完粘贴操作就再次粘贴
2. 获取当前拖蓝区域，并创建书签，以便于粘贴后的光标位置恢复
3. 创建粘贴容器
4. 设置该容器宽高都为1像素，超出内容隐藏，不断行，并且顶部位置与当前光标顶部位置平行（避免位置跳动）。
5. 选中粘贴容器中的内容
6. 移除空的粘贴容器，获取最终要粘贴的内容
7. 恢复光标位置，对粘贴内容进行过滤。



你可能会注意到，在上述第5步后，第6/7部实在一个延时函数里进行的：

```javascript

setTimeout(function(){
    if (browser.webkit) {
        // ...
    }
    //...
}, 0)

```



这个延迟函数起什么作用呢？

其实它是把这个操作放到异步操作中，之所以如此，是因为此时需要等待程序拿到剪贴板的内容（毕竟是粘贴操作嘛）后才能执行第6/7步。

那么，剪贴板的内容是从哪里获取的呢？搜寻源码，我们可以找到如下代码：

```javascript
bindEvents:{
            //插入粘贴板的图片，拖放插入图片
            'ready':function(e){
                var me = this;
                if(window.FormData && window.FileReader) {
                    domUtils.on(me.body, 'paste drop', function(e){
                        var hasImg = false,
                            items;
                        //获取粘贴板文件列表或者拖放文件列表
                        items = e.type == 'paste' ? getPasteImage(e):getDropImage(e);
                        if(items){
                            var len = items.length,
                                file;
                            while (len--){
                                file = items[len];
                                if(file.getAsFile) file = file.getAsFile();
                                if(file && file.size > 0) {
                                    sendAndInsertFile(file, me);
                                    hasImg = true;
                                }
                            }
                            hasImg && e.preventDefault();
                        }

                    });
                    //...
                }
            }
        }

```



可以看到，在编辑器的`ready`事件里，设置了一个监听器，监听编辑器可编辑区域的`paste`和`drop`事件，这里判断如果事件类型是`paste`， 就会去获取剪贴板文件列表，看下`getPasteImage`的实现：

```javascript
function getPasteImage(e){
        return e.clipboardData && e.clipboardData.items && e.clipboardData.items.length == 1 && /^image\//.test(e.clipboardData.items[0].type) ? e.clipboardData.items:null;
    }
```

这里是利用了浏览器提供的事件对象的`clipboardData`对象，这个数据对象就是粘贴板里的内容了。

当然，从这个方法是正则可以看出来，这个方法只是去获取剪贴板中的图片文件的。那么，如果是字符串呢？

我们可以在`paste`事件的`API`的说明里找到下面的一段话：

>如果光标位于可编辑的上下文中（例如，在 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/textarea) 或者 `contenteditable` 属性设置为 `true的元素`），则默认操作是将剪贴板的内容插入光标所在位置的文档中。

而我们看到在延迟函数前有这么一句：

```javascript
range.selectNodeContents(pastebin).select(true);
```

也就是所，这一句确保当前光标所在位置是位于剪贴容器中的，而在延迟函数执行前，浏览器会将剪贴板的内容拆入这个剪贴容器中。

所以在执行下面的过滤函数时，剪贴板的内容就已经被加入到了编辑器中。

```javascript
function filter(div) {
        var html;
        if (div.firstChild) {
            //去掉cut中添加的边界值
            var nodes = domUtils.getElementsByTagName(div, 'span');
            for (var i = 0, ni; ni = nodes[i++];) {
                if (ni.id == '_baidu_cut_start' || ni.id == '_baidu_cut_end') {
                    domUtils.remove(ni);
                }
            }

            if (browser.webkit) {

                var brs = div.querySelectorAll('div br');
                for (var i = 0, bi; bi = brs[i++];) {
                    var pN = bi.parentNode;
                    if (pN.tagName == 'DIV' && pN.childNodes.length == 1) {
                        pN.innerHTML = '<p><br/></p>';
                        domUtils.remove(pN);
                    }
                }
                var divs = div.querySelectorAll('[[baidu_pastebin]]');
                for (var i = 0, di; di = divs[i++];) {
                    var tmpP = me.document.createElement('p');
                    di.parentNode.insertBefore(tmpP, di);
                    while (di.firstChild) {
                        tmpP.appendChild(di.firstChild);
                    }
                    domUtils.remove(di);
                }

                var metas = div.querySelectorAll('meta');
                for (var i = 0, ci; ci = metas[i++];) {
                    domUtils.remove(ci);
                }

                var brs = div.querySelectorAll('br');
                for (i = 0; ci = brs[i++];) {
                    if (/^apple-/i.test(ci.className)) {
                        domUtils.remove(ci);
                    }
                }
            }
            if (browser.gecko) {
                var dirtyNodes = div.querySelectorAll('[_moz_dirty]');
                for (i = 0; ci = dirtyNodes[i++];) {
                    ci.removeAttribute('_moz_dirty');
                }
            }
            if (!browser.ie) {
                var spans = div.querySelectorAll('span.Apple-style-span');
                for (var i = 0, ci; ci = spans[i++];) {
                    domUtils.remove(ci, true);
                }
            }

            //ie下使用innerHTML会产生多余的\r\n字符，也会产生&nbsp;这里过滤掉
            html = div.innerHTML;//.replace(/>(?:(\s|&nbsp;)*?)</g,'><');

            //过滤word粘贴过来的冗余属性
            html = UE.filterWord(html);
            //取消了忽略空白的第二个参数，粘贴过来的有些是有空白的，会被套上相关的标签
            var root = UE.htmlparser(html);
            //如果给了过滤规则就先进行过滤
            if (me.options.filterRules) {
                UE.filterNode(root, me.options.filterRules);
            }
            //执行默认的处理
            me.filterInputRule(root);
            //针对chrome的处理
            if (browser.webkit) {
                var br = root.lastChild();
                if (br && br.type == 'element' && br.tagName == 'br') {
                    root.removeChild(br)
                }
                utils.each(me.body.querySelectorAll('div'), function (node) {
                    if (domUtils.isEmptyBlock(node)) {
                        domUtils.remove(node,true)
                    }
                })
            }
            html = {'html': root.toHtml()};
            me.fireEvent('beforepaste', html, root);
            //抢了默认的粘贴，那后边的内容就不执行了，比如表格粘贴
            if(!html.html){
                return;
            }
            root = UE.htmlparser(html.html,true);
            //如果开启了纯文本模式
            if (me.queryCommandState('pasteplain') === 1) {
                me.execCommand('insertHtml', UE.filterNode(root, me.options.filterTxtRules).toHtml(), true);
            } else {
                //文本模式
                UE.filterNode(root, me.options.filterTxtRules);
                txtContent = root.toHtml();
                //完全模式
                htmlContent = html.html;

                address = me.selection.getRange().createAddress(true);
                me.execCommand('insertHtml', me.getOpt('retainOnlyLabelPasted') === true ?  getPureHtml(htmlContent) : htmlContent, true);
            }
            me.fireEvent("afterpaste", html);
        }
    }
```



1. 去掉从编辑器内剪切时增加的边界值节点
2. 不同浏览器处理空白节点
   * 如果是`webkit`内核浏览器：
   * 如果是`gecko`内核浏览器
   * 其它非`ie`的浏览器
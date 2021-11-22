jquery源码学习

# jquery源码学习

源码

## 节点遍历

### 什么是遍历

遍历就是将数据的所有节点都查询一遍
jQuery遍历函数包括了用于筛选，查找，和串联元素的方法。jQuery的遍历查找方式为“移动”，包括向上移动（祖先），向下移动（子孙），水平移动（同胞）。

#### 遍历处理函数

- 文档筛选eq(index)
    - 将匹配元素集缩减值指定index上的一个
    - index为整数，指示元素的位置，最小为0
    - index如果为负数，则从集合中的最后一个元素往回计数
    - 如果给定表示DOM元素集合的jQuery对象，eq()方法会用集合中的一个元素构造一个新的jQuery对象。所使用的index参数标示集合中元素的位置。
- 文档筛选filter(selector)
    - 将匹配元素集合缩减为匹配指定选择器的元素
    - selector为选择器表达式
- 文档筛选not(selector)
    - 从匹配元素集合中删除元素
    - selector为选择器表达式
- 树遍历children(selector)
    - 此方法允许我们检索DOM树中的元素，并用匹配元素构造新的jQuery对象
    - find()和children()方法类似，不过后者只沿着DOM树向下遍历单一层级。
    - children()方法不返回文本节点，如需获得文本和注释节点，使用contents()
- 树遍历closest(selector)
    - 获得匹配选择器的第一个祖先元素，从当前元素开始沿DOM树向上
    - closest从当前元素开始，parents()从父元素开始。
- 树遍历find(selector)
    - find() 方法获得当前元素集合中每个元素的后代，通过选择器、jQuery 对象或元素来筛选

### jQuery的遍历结构设计

#### 遍历接口的分类

- 祖先
- 同胞兄弟
- 后代
- 过滤

#### jQuery内部的抽象处理

1.针对层级关系的处理，jQuery就抽出了一个dir的方法，用于根据传递的元素与词素的位置关系，查找指定的元素：

	    function dir(elem,dir,until){
	    //定义一个元素数组对象
	        var matched = [],
	        //如果until不为undefined，则将其值赋给truncate变量
	        truncate = until !== undefined;
	        //【将当前节点的父元素设为当前节点】如果当前节点的节点类型不为document，则执行循环【依靠这一点实现遍历】
	        while((elem = elem[dir]) && elem.nodeType !==9){
	        //如果元素节点类型为Element,则执行：
	            if(elem.nodeType === 1){
	            //如果truncate被定义
	                if (truncate){
	                // 如果节点名称等于until，或者节点类名等于until
	                    if(elem.nodeName.toLowerCase() == until || elem.className == until){
	                     //跳出循环
	                        break;
	                    }
	                }
	                //如果truncate未定义，则将元素添加到matched元素数组里
	                matched.push(elem);
	            }
	        }
	        //返回数组对象
	        return matched;
	    }

	    jQuery.each({
	    parent: function(elem) {
	    //定义父元素等于所选元素的父节点
	      var parent = elem.parentNode;
	      //返回父节点（如果父节点是轻量级文档对象，则返回NULL）
	      return parent && parent.nodeType !== 11 ? parent : null;
	    },
	    parents: function(elem) {
	    // 执行dir(elem，“parentNode”)函数，返回执行结果（数组对象）
	      return dir(elem, "parentNode");
	    },
	    parentsUntil: function(elem, until) {
	    //// 执行dir(elem，“parentNode”,until)函数，返回执行结果（数组对象）
	      return dir(elem, "parentNode", until);
	    }
	  }, function(name, fn) {
	    ajQuery[name] = function(until, selector) {
	      return  fn(until, selector);
	    };
	  });

> 我们发现，dir函数实现祖先元素的遍历，依赖与在循环条件中将当前元素设置为当前元素的父节点来实现，并由until参数来控制遍历到文档的哪一层级。

### 遍历祖先

- parent()
    - 允许我们能够在DOM树中搜索到这些元素的父级元素，从有序的向上匹配元素，并根据匹配的元素创建一个新的 jQuery 对象。
- parents()
    - .parents()和.parent()方法是相似的，但后者只是进行了一个单级的DOM树查找
- parentsUntil()
    - .parentsUntil()方法会找遍所有这些元素的前辈元素，直到遇到了跟参数匹配的元素才会停止。返回的jQuery对象中包含了所有找到的前辈元素，除了与 .parentsUntil() 选择器匹配的那个元素。

### 遍历同胞

- nextAll()
    - 获得匹配元素集合中每个元素之后的所有同辈元素，由选择器进行筛选（可选）
- nextUntil()
    - 获得每个元素之后所有的同辈元素，直到遇到匹配选择器的元素为止。
- prevAll()
    - 获得匹配元素集合中每个元素之前的所有同辈元素，由选择器进行筛选（可选）
- prevUntil()
    - 获得每个元素之前所有的同辈元素，直到遇到匹配选择器的元素为止。
- next()
    - 获得匹配元素集合中每个元素紧邻的同辈元素
- prev()
    - 获得匹配元素集合中每个元素紧邻的前一个同辈元素，由选择器筛选（可选）。
- siblings()
    - 获得匹配元素集合中所有元素的同辈元素，由选择器筛选（可选）。

### 遍历后代

- find()
    - find()方法返回被选元素的后代元素，一路向下直到最后一个后代。
    - find()和.children()方法是相似的，但后者只是再DOM树中向下遍历一个层级。
    - find()方法允许我们能够通过查找DOM树中的这些元素的后代元素，匹配的元素将构造一个新的jQuery对象。
    - find()方法还可以接受一个选择器表达式，该选择器表达式可以是任何可传给$()函数的选择器表达式。如果紧随兄弟匹配选择器，它将被保留在新构建的jQuery对象中；否则，它被排除在外。

## 文档处理

### 节点操作

jQuery对节点的操作封装出了一系列的接口，可以接受HTML字符串、DOM 元素、元素数组、或者jQuery对象，用来插在集合中每个匹配元素的不同位置

#### 回调函数

一个返回HTML字符串，DOM元素，或者jQuery对象的函数，插在每个元素的后面。

#### 源码实现：

	append: function() {
	    return this.domManip(arguments, function(elem) {
	        if (this.nodeType === 1
	            || this.nodeType === 11
	            || this.nodeType === 9) {
	            var target = manipulationTarget(this, elem);
	            target.appendChild(elem);
	        }
	    });
	},
	prepend: function() {
	    return this.domManip(arguments, function(elem) {
	        if (this.nodeType === 1
	            || this.nodeType === 11
	            || this.nodeType === 9) {
	            var target = manipulationTarget(this, elem);
	            target.insertBefore(elem, target.firstChild);
	        }
	    });
	},

domManip()是jQuery DOM操作的核心函数。对封装的节点操作做了参数上的校正支持，与对应处理的调用：append、prepend、before、after、replaceWith、appendTo、prependTo、insertBefore、insertAfter、replaceAll。

#### 浏览器提供的节点操作接口：

- appendChild()
    - 通过把一个节点增加到当前节点的childNodes[]组，给文档树增加节点；
- cloneNode()
    - 复制当前节点，或者复制当前节点以及它的子孙节点
- hasChildNodes()
    - 如果当前节点拥有子节点，则将返回true；
- insertBefore()
    - 给文档树插入一个节点，位置在当前节点的指定子节点前。如果该节点已经存在，则删除之后再插入到它的位置。
- removeChild()
    - 从文档树中删除并返回指定的子节点。
- replaceChild()
    - 从文档树中删除并返回指定的子节点，用另一个节点替换它。

> 以上接口都有一个特性，传入的是一个节点元素。如果我们传递不是一个dom节点元素，如果是一个字符串，一个函数或者其他呢？
> 所以针对所有接口的操作，jQuery会抽象出一种参数的处理方案，也就是domManip存在的意义了

### 深入domManip()

针对节点的操作有几个重点的细节：

- 保证最终操作的永远都是dom元素，浏览器最终API只认识那么几个接口，所以如果传递的是字符串或者其他的，当然需要转换。
- 针对节点的大量操作，我们肯定是需要引入文档碎片化做优化的，这个必不可少

domMainp在设计上需要做的处理：

- 解析参数，字符串，函数，对象
- 针对大数据引入文档碎片处理
- 如果参数中包含script的处理

其中还有很多细节的问题：

1：IE下面innerHTML会忽略没作用域元素,no-scope element(script,link,style,meta,noscript)等，所以这类通过innerHTML创建需要加前缀

2：innerHTML在IE下面会对字符串进行trimLeft操作，去掉空白
3: innerHTML不会执行脚本的代码，如果支持defer除外
4：很多标签不能作为div的子元素、td、tr, tbody等等
5：jQuery是合集对象，文档碎片的与事件的复制问题

#### 模拟append，简单流程

> 用于描述文档处理的设计结构与流畅

	<!doctype html>
	<html>
	<head>
	    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
	    <script src="http://code.jquery.com/jquery-latest.js"></script>
	    <title>domManip</title>
	</head>
	<body>

	<button>模拟append</button>
	<div id="test"></div>

	<script type="text/javascript">
	    /**
	     *  一个简单的流程。
	     *  用于描述文档处理的设计结构与流程
	     * *
	     */
	     //建立文档碎片
	    function buildFragment(elems, context) {
	        //创建一个新的文档碎片对象
	        var fragment = context.createDocumentFragment(),
	            nodes = [],
	            i = 0,
	            //当前需要操作节点:div字符串
	            elem,
	            //传入的节点总数
	            l = elems.length; //1

	        for (; i < l; i++) {
	            elem = elems[i];
	            //在传入的上下文环境$('#test')中创建一个元素div做为容器
	            tmp = fragment.appendChild(context.createElement("div"));
	            //放到文档碎片中
	            tmp.innerHTML = elem;   //将div字符串放入刚刚创建的div元素中
	        }
	        return fragment; //返回：<div><div>通过append加入慕课网</div></div>
	    }

	    function domManip(parentEles, target, callback) {
	        var l = parentEles.length; // 1
	        var iNoClone = l - 1; // 0

	        if (l) {
	        //buildFragment(div字符串，$('#test'));
	        //return:<div><div>通过append加入慕课网</div></div>
	            var fragment = buildFragment([target], parentEles[0].ownerDocument);
	            first = fragment.firstChild;
	            if (fragment.childNodes.length === 1) {
	                fragment = first;
	            }
	            if (first) {
	                callback.call(parentEles, first);
	            }
	        }

	    }

	    function append(parentEles, target) {
	    //return domManip($('#test'),div字符串);
	        return domManip([parentEles], target, function(elem) {
	            parentEles.appendChild(elem)
	        });
	    }

	    $("button").click(function(){
	    //此处调用append方法，传入两个参数：
	    //parentEles:ID为test的元素节点
	    //target：一个div字符串
	        append(document.getElementById('test'),'<div>通过append加入慕课网</div>' )
	    })

	</script>
	</body>
	</html>

1:函数调用了domManip函数，传进去的参数第一个是arguments，这个大家都知道arguments是函数参数对象，是一个类数组对象。这里arguments可能是包含dom元素的数组，或者html字符串

2:第二参数是一个回调函数，target.appendChild(elem);看到这个代码就很明了，在回调函数中分离各自的处理方法，通过domManip抽象出公共的处理，其余的prepend 、before 、after等接口也是类似的处理

#### append处理script

- .append()-> .domManip() -> buildFragment() ->clean() 这样的处理流程
- clean() 中会动态产生一个div， 将div 的innerHTML 设为传入的字符串，再用getElementsByTagName('script') 的方式把所有的script 抓出来另行储存
- clean() 执行完毕回到domManip() 中， domManip() 再将script 们一一拿出来执行
- 如果是外部js 就动态载入，如果是内联 js 就用eval()

> 总结下来，domManip主要就做了两件事：
> 1.根据用户传入的参数，创建了多个fragment，然后通过回调函数参数传入
> 2.控制script的执行过程，在创建fragment的时候不执行，最后dom操作结束后会统一执行

[markdownFile.md](../_resources/9ae0e56a307781ff6a66628b45b6d9cd.bin)
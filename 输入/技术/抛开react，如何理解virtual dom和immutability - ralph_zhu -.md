抛开react，如何理解virtual dom和immutability - ralph_zhu - 博客园

#   [抛开react，如何理解virtual dom和immutability](https://www.cnblogs.com/front-end-ralph/p/5283586.html)

去年以来，React的出现为前端框架设计和编程模式吹来了一阵春风。很多概念，无论是原本已有的、还是由React首先提出的，都因为React的流行而倍受关注，成为大家研究和学习的热点。本篇分享主要就聚焦于这些概念中出现频率较高的两个：virtual dom（虚拟DOM）和data immutability（数据不变性）。希望通过几段代码和同学们分享博主对于这两个概念的思考和理解。

文章分为四个部分，由大家最为熟悉的基于dom node的编程开始：
1. 基于模板和dom node的编程：回顾前端传统的编程模式，简单总结前端发展的趋势和潮流
2. 面向immutable data model的编程：浅析在virtual dom出现之前，为什么基于immutability的编程不具备大规模流行的条件
3. 引入virtual dom，优化渲染性能：介绍virtual dom以及一些常见的性能优化技巧，给出性能比较的测试方法和结论
4. virtual dom和redux的整合：示范如何与redux整合

1. 基于模板和dom node的编程

基于模板和dom node的编程是前端开发中最为传统和深入人心的开发方式。这种开发方式编码简单、模式灵活、学习曲线平滑，深受大家的喜爱。模版层渲染既可以在后端完成（如smarty、velocity、jade）也可以在前端完成（如mustache，handlebars），而dom操作一般则会借助于诸如jquery、yui之类封装良好的类库。本文为了方便同学们在纯前端环境中进行实验，将采用handlebars + jquery的技术选型。其中handlebars负责前端渲染，jquery负责事件监听和dom操作。从本节开始，将使用不同的方式实现一个支持添加、删除操作的列表，大致界面如下：

![786024-20160316144658756-2002430731.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231174205.png)
首先简要分析一下代码逻辑：

模板放在script标签中，type设置为text/template，用于稍后渲染；由于需要频繁添加、删除dom元素，因此选用事件代理（delegation），以避免频繁处理添加、删除监听器的逻辑。html代码：

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

1  <!doctype html> 2  <html> 3  <head> 4  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"  /> 5  <link href="https://cdn.bootcss.com/bootstrap/4.0.0-alpha.2/css/bootstrap.min.css" rel="stylesheet"  /> 6  <style> 7   .dbl-top-margin { 8   margin-top: 20px; 9  }10   .float-right {11   float: right;12  }13  </style>14  <script class="template" type="text/template">15  <ul class="list-group dbl-top-margin">16   {{#items}}17  <li class="list-group-item">18  <span>{{name}}</span>19  <button data-index="{{@index}}" class="item-remove btn btn-danger btn-sm float-right">删除</button>20  </li>21   {{/items}}22  </ul>23  <div class="dbl-top-margin">24  <input placeholder="添加新项目" type="text" class="form-control item-name"  />25  <button class="dbl-top-margin btn btn-primary col-xs-12 item-add">添加</button>26  </div>27  </script>28  </head>29  <body>30  <div class="container"></div>31  <script src="bundle.js"></script>32  </body>33  </html>

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)
javascript代码：
[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

1  var $ = require('jquery'); 2  var Handlebars = require('handlebars'); 3   4  var template = $('.template').text(); 5   6  // 用一组div标签将template包裹起来 7 template = ['<div>', template, '</div>'].join(''); 8   9  // 初次渲染模板时所用到的数据10  var model = {11   items: [{12 name: '项目1'13   }, {14 name: '项目2'15   }, {16 name: '项目3'17   }]18  };19  20  // Handlebars.compile方法返回编译后的模块方法，调用这个模板方法并传入数据，即可得到渲染后的模板21  var html = Handlebars.compile(template)(model);22  23  24  var $container = $('.container');25  $container.html(html);26  27  var $ul = $container.find('ul');28  var $itemName = $container.find('.item-name');29  30  var liTemplate = ''31 + '<li class="list-group-item">'32 + '<span>{{name}}</span>'33 + '<button class="item-remove btn btn-danger btn-sm float-right">删除</button>'34 + '</li>';35  36 $container.delegate('.item-remove', 'click', function (e) {37  var $li = $(e.target).parents('li');38   $li.remove();39  });40  41 $container.delegate('.item-add', 'click', function () {42  var name = $itemName.val();43  // 清空输入框44 $itemName.val('');45  // 渲染新项目并插入46   $ul.append(Handlebars.compile(liTemplate)({47   name: name48   }));49 });

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

虽然编码起来简单易行，但是这种传统的开发模式弊端也比较明显，尤其是在前端项目规模不断扩大，复杂度不断提升的今天。比如，由于dom操作和数据操作夹杂在一起，很难将view层从业务代码中剥离开来；由于没有集中维护内部状态，当事件监听器增多，尤其当监听器间有相互触发的关系时，程序调试变得困难；没有通行的模块化、组件化的解决方案；尽管可以在一定程度上进行优化，但相同内容的模板往往有冗余，甚至同时存在于前、后端，比如上面的liTemplate就是一个例子…… 虽然问题较多，但经常更新自己知识储备的同学一般都有一套结合自己工作经验的处理办法，能力和篇幅所限，本文也无法涉及方方面面的知识。后文提到的virtual dom和immutability主要涉及到这里的两个问题：view层分离和状态维护。

无论是mvc还是mvvm，将view层从业务代码中更好地分离出来一直是多年以来前端社区努力和前进的方向。将view层分离的具体手段很多，大都和model和view model的使用有关。react之前的先行者如backbone、angularjs注重于model的设计而并没有在状态维护上下太多的功夫，举个例子，对angularjs中的NgModelController有开发经验的同学可能就会抱怨这种用于同步view和model的机制过于复杂。react在面对这一问题时，也许是由于有了angularjs的前车之鉴，并没有尝试要做出一套更复杂的机制，而是将flux推荐给大家，鼓励使用immutable model。immutable model使得设计良好的系统中几乎可以不再考虑内部状态(state)的维护问题，也无需太多地担忧view和model的同步。一旦有操作（action）发生，一个新的model被创建，与之绑定的view层也随即被重新渲染，整个过程清晰明了，秩序井然。要么让代码简单到明显没有错误，要么让代码复杂到没有明显错误，react选择了前者。

2. 面向immutable data model的编程

然而在react出现之前，immutable data model的确没有流行起来，这是为什么呢？博主先和大家分享一种朴素的基于immutability的编程模式，再回过头来分析具体原因。接着使用上例中的handlebars + jquery的技术选型，但思路有一些略微的变化：实现一个接收model参数的render方法，render方法中调用handlebars编译后的方法来渲染html，并直接使用innerHTML写入容器；相应的事件监听器中不再直接对DOM进行操作，而是生成一个新的model对象，并调用render方法；由于innerHTML频繁更新，基于和上例中相似的原因，我们使用事件代理来完成事件监听；由于本例中的model结构简单，暂时不引入immutablejs之类的类库，而是使用jquery的extend方法来深度复制对象。

下面来看代码实现：
[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

1  var $ = require('jquery'); 2  var Handlebars = require('handlebars'); 3  var template = $('.template').text(); 4   5  // 用一组div标签将template包裹起来 6 template = ['<div>', template, '</div>'].join(''); 7 template = Handlebars.compile(template); 8   9  var model = {10   items: [{11 name: 'item-1'12   }, {13 name: 'item-2'14   }]15  };16  17  var $container = $('.container');18  19  20  function render(model) {21 $container[0].innerHTML = template(model);22  }23  24  25 $container.delegate('.item-remove', 'click', function (e) {26  var index = $(e.target).attr('data-index');27 index = parseInt(index, 10);28 model = $.extend(true, {}, model);29 model.items.splice(index, 1);30   render(model);31  });32  33 $container.delegate('.item-add', 'click', function () {34  var name = $('.item-name').val();35 model = $.extend(true, {}, model);36   model.items.push({37   name: name38   });39   render(model);40  });41  42 render(model);

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

上面的代码中有两个地方容易成为性能瓶颈，刚好这两处都在一个语句中：$container[0].innerHTML = template(model); 模板渲染是比较耗时的字符串操作，当然经过了handlebars的编译，性能上基本可以接受；但直接从容器根部写入innerHTML则是明显的性能杀手：明明只需要添加或删除一个li，浏览器却重新渲染了整个view层。说到这里，在react出现之前immutability没有流行起来的原因应该也就比较清晰了。下节会简单提到性能比较，这里先卖一个关子，这一步看似简单，但博主初次尝试却没有得到理想中的实验结果。言归正传，按照正常的思路，为了优化innerHTML带来的性能损耗，直接渲染看来是不可取了，下一步应该就是比较已经存在的dom结构和新传入的model所将要渲染出的dom结构，只对有修改的部分进行更新操作。思路虽然很自然，但是要和dom树进行比较，也很难避免繁重的dom操作。那可不可以对dom树进行缓存呢？比如，相较于getAttribute之类原生的dom方法，节点的属性值其实可以被以某种数据结构缓存下来，用于提高diff的速度。宏观上说，virtual dom出现的目的就是缓存dom树，并在他们之间进行同步。当然缓存的实现形式已经比较具体，不再是普通的map、list或者set，而是virtual dom tree。下一节中将介绍如何用hyperscript——一款简单的开源框架——来构建virtual dom tree。

3. 引入virtual dom，优化渲染性能

既然要构建virtual dom tree，那之前通过handlebars渲染的方式就不能再使用了，因为handlebars的渲染结果是字符串，而被缓存起来的dom节点并不是以字符串的形式存在的。这一节中，我们先对技术选型进行一些更新：jquery + hyperscript。jquery继续负责事件逻辑（其实hyperscript中也有事件监听的机制，但是既然我们的jquery事件监听逻辑已经写好了，这里就先沿用了。如果有需要，后面可以使用hyperscript再重构一遍）hyperscript负责view层逻辑，包括virtual dom tree的维护和实际dom tree的更新。当然，更新dom tree这一步对开发者是透明的，我们不需要自己去调用原生的dom方法。

hyperscript的使用非常简单，记住下面一个api就可以开始工作了：
h(tag, attrs?, [text?, Elements?,...])

第一个参数是节点类型，比如div、input、button等，第二个可选的参数是属性，比如value，type等，第三个可选的参数是子节点（或子节点数组）。使用这个api对view层进行重构：

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

1  function generateTree(model) { 2  return h('div', [ 3 h('ul.list-group.dbl-top-margin', model.items.map(function (item, index) { 4  return h('li.list-group-item', [ 5   item.name, 6 h('button.item-remove.btn.btn-danger.btn-sm.float-right', { 7   value: item.name 8 }, '删除') 9   ]);10   })),11 h('div.dbl-top-margin', [12 h('input.form-control.item-name', {13 placeholder: '添加新项目',14 type: 'text'15   }),16 h('button.dbl-top-margin.btn.btn-primary.col-xs-12.item-add', '添加')17   ])18   ])19 }

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

最外层是一个div节点，作为容器包裹内部元素。div的第一个子节点是ul，ul中通过遍历model.items生成li，每个li里有item.name和一个删除按钮。div的第二个子节点是用于输入新项目的文本框和一个“添加”按钮。当然，每次生成新的virtual tree的性能是比较低下的：虽然避免了大量dom操作，但是却将时间消耗在了virtual tree的构建上。一个典型的例子是，如果items中的项目没有改变，我们其实可以把它们缓存起来。博主暂时还没有机会深入研究react的实现，但有过react开发经验的同学应该对数组中不出现key时而报的warn并不陌生。这里应该就是react性能优化中比较重要的一个点。利用类似的思路，对generateTree函数进行适当的优化：

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

1  var hyperItems = {}; 2  var hyperFooter = h('div.dbl-top-margin', [ 3 h('input.form-control.item-name', { 4 placeholder: '添加新项目', 5 type: 'text' 6   }), 7 h('button.dbl-top-margin.btn.btn-primary.col-xs-12.item-add', '添加') 8   ]); 9  function generateTree(model) {10  return h('div', [11 h('ul.list-group.dbl-top-margin', model.items.map(function (item, index) {12 hyperItems[item.name] = hyperItems[item.name] || h('li.list-group-item', [13   item.name,14 h('button.item-remove.btn.btn-danger.btn-sm.float-right', {15   value: item.name16 }, '删除')17   ]);18  return hyperItems[item.name];19   })),20   hyperFooter21   ])22 }

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

除了一开始提到了数组项的缓存之外，由于添加新项目的部分是不会改变的，因此我们先创建好hyperFooter实例，每次需要生成virtual tree的时候直接调用就好了。hyperscript的部分介绍清楚了，接下来就来看代码实现：

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

1  var $ = require('jquery'); 2  var h = require('virtual-dom/h'); 3  var diff = require('virtual-dom/diff'); 4  var patch = require('virtual-dom/patch'); 5  var createElement = require('virtual-dom/create-element'); 6   7  var model = { 8   items: [] 9  };10  11  var $container = $('.container');12  13  var hyperItems = {};14  15  var hyperFooter = h('div.dbl-top-margin', [16 h('input.form-control.item-name', {17 placeholder: '添加新项目',18 type: 'text'19   }),20 h('button.dbl-top-margin.btn.btn-primary.col-xs-12.item-add', '添加')21   ]);22  23  function generateTree(model) {24  return h('div', [25 h('ul.list-group.dbl-top-margin', model.items.map(function (item, index) {26 hyperItems[item.name] = hyperItems[item.name] || h('li.list-group-item', [27   item.name,28 h('button.item-remove.btn.btn-danger.btn-sm.float-right', {29   value: item.name30 }, '删除')31   ]);32  return hyperItems[item.name];33   })),34   hyperFooter35   ])36  }37  38  var root;39  var tree;40  function render(model) {41  var newTree = generateTree(model);42  if (!root) {43 tree = newTree;44 root = createElement(tree);45   $container.append(root);46  return;47   }48  var patches = diff(tree, newTree);49 root = patch(root, patches)50 tree = newTree;51  }52  53 $container.delegate('.item-remove', 'click', function (e) {54  var value = $(e.target).val();55 model = $.extend(true, {}, model);56  for (var i = 0; i < model.items.length; i++) {57  if (model.items[i].name === value) {58 model.items.splice(i, 1);59  break;60   }61   }62   render(model);63  });64  65 $container.delegate('.item-add', 'click', function () {66  var name = $('.item-name').val();67   model.items.push({68   name: name69   });70   render(model);71  });72  73 render(model);

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

上面的代码中需要说明的是render函数的实现：每次调用render时，先使用传入的model对象生成一棵virtual dom tree，此时如果是第一次渲染（root为空），则利用这棵virtual dom tree构建真实的dom tree，并将其放入到容器中；如果不是第一次渲染，则比较已经存在的virtual dom tree和新构建的virtual dom tree，获取到不同的部分，保存到patches变量中，再调用patch方法实际更新dom tree。

这样的实现是不是就没有性能问题呢？还需要实验数据来证明。细心的同学可能会注意到，在上一节中提到了在性能比较的环节博主曾经踩了一个坑。虽然几天以前博主就开始准备这篇博文，但是由于观点无法得到实验数据的佐证，一度难以继续。接下来就来一起回顾这个坑。一开始的时候博主使用了类似下面的办法来考察直接使用innerHTML和利用virtual dom在连续反复渲染上的性能表现：

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

1  var time = Date.now();2  for (var i = 0; i < 100; i++) {3 model = $.extend(true, {}, model);4   model.items.push({5 name: 'item-' + n6   });7   render(model);8  }9 console.log(Date.now() - time);

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

期待的结果自然应该是virtual dom的耗时低于innerHTML，但实际情况却大相径庭——innerHTML的表现远胜virtual dom，这让博主一度开始怀疑起自己的人生观。为什么不能使用这样的方式来验证性能呢：写入innerHTML并不一定会引发一次渲染，如果写入的时间间隔短于浏览器ui线程的响应时间，之前写入的结果可能未来得及渲染就被忽略掉，也就是我们常说的掉帧。有两个常用的知识可以从侧面印证这一点：1是requestAnimationFrame的使用，2是为什么从reflow，repaint的角度来看，利用innerHTML可以优化程序性能。问题找到了，并且既然我们想实实在在的测试两种渲染方式带来的性能差异，这里就应该处理掉由游览器自身repaint机制而造成的干扰因素：

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

1  var start; 2  var timeConsumed = 0; 3  function renderTest(n) { 4  if (n === 0) { 5   console.log(timeConsumed); 6  return; 7   } 8 model = $.extend(true, {}, model); 9   model.items.push({10 name: 'item-' + n11   });12 start = Date.now();13   render(model);14 timeConsumed += Date.now() - start;15 requestAnimationFrame(renderTest.bind(undefined, n - 1));16  };17 renderTest(100);

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

通过调用requestAnimationFrame，保证每一次对innerHTML的写入都被浏览器真实渲染了出来；再对每次渲染的时间进行累加，这样的结果就比较准确了。不出乎意料，直接使用innerHTML的方式的耗时在300ms左右；而使用virtual dom的方式耗时大概只有1/3。即使优化的程度还比较低，但是virtual dom在性能上的确有明显的提升。

4. virtual dom和redux的整合

基于immutability的程序和redux的整合是非常自然的一件事：将产生新model的逻辑集中起来，便于代码维护、模块化、测试和业务逻辑解耦。本例中，需要两个action，分别对应添加和删除操作；reducer生成新的state，并根据action的类型对state进行操作；最后，将render方法绑定在store上即可。

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

1  var $ = require('jquery'); 2  var h = require('virtual-dom/h'); 3  var diff = require('virtual-dom/diff'); 4  var patch = require('virtual-dom/patch'); 5  var createElement = require('virtual-dom/create-element'); 6  var redux = require('redux'); 7   8  var $container = $('.container'); 9   10  var hyperItems = {}; 11   12  var hyperFooter = h('div.dbl-top-margin', [ 13 h('input.form-control.item-name', { 14 placeholder: '添加新项目', 15 type: 'text' 16   }), 17 h('button.dbl-top-margin.btn.btn-primary.col-xs-12.item-add', '添加') 18   ]); 19   20  function generateTree(model) { 21  return h('div', [ 22 h('ul.list-group.dbl-top-margin', model.items.map(function (item, index) { 23 hyperItems[item.name] = hyperItems[item.name] || h('li.list-group-item', [ 24   item.name, 25 h('button.item-remove.btn.btn-danger.btn-sm.float-right', { 26   value: item.name 27 }, '删除') 28   ]); 29  return hyperItems[item.name]; 30   })), 31   hyperFooter 32   ]) 33  } 34   35  var root; 36  var tree; 37  function render(model) { 38  var newTree = generateTree(model); 39  if (!root) { 40 tree = newTree; 41 root = createElement(tree); 42   $container.append(root); 43  return; 44   } 45  var patches = diff(tree, newTree); 46 root = patch(root, patches) 47 tree = newTree; 48  } 49   50 $container.delegate('.item-remove', 'click', function (e) { 51  var name = $(e.target).val(); 52   store.dispatch(removeItem(name)); 53  }); 54   55 $container.delegate('.item-add', 'click', function () { 56  var name = $('.item-name').val(); 57   store.dispatch(addItem(name)); 58  }); 59   60   61  // action types 62  var ADD_ITEM = 'ADD_ITEM'; 63  var REMOVE_ITEM = 'REMOVE_ITEM' 64   65  // action creators 66  function addItem(name) { 67  return { 68   type: ADD_ITEM, 69   name: name 70   }; 71  } 72   73  function removeItem(name) { 74  return { 75   type: REMOVE_ITEM, 76   name: name 77   }; 78  } 79   80  // reducers 81  var listApp = function (state, action) { 82  // deep copy当前state，类似于前面的model 83 state = $.extend(true, {}, state); 84   85  switch (action.type) { 86  case ADD_ITEM:  87 (function () { 88   state.items.push({ 89   name: action.name 90   }) 91   })(); 92  break; 93  case REMOVE_ITEM: 94 (function () { 95  var items = state.items; 96  for (var i = 0; i < items.length; i++) { 97  if (items[i].name === action.name) { 98 items.splice(i, 1); 99  break;100   }101   }102   })();103  break;104   }105  106  // 总是返回一个新的state107  return state;108  };109  110  111  var initState = {112   items: []113  };114  115  // store116  var store = redux.createStore(listApp, initState);117  118  render(initState);119  120  // 监听store变化121 store.subscribe(function () {122   render(store.getState());123 });

[![copycode.gif](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

可以说，由react构建的庞大生态有一半的功劳要归功于virtual dom。如果没有virtual dom，基于immutable data的编程模式由于性能原因就难以在前端进行推广，flux/redux这类依赖于immutability的框架也就无用武之地了。

博主在本文中的代码仅供研究学习，有相关需要的同学建议直接使用react，无论是兼容性、性能优化还是社区建设都已经比较到位了 :)

作者：ralph_zhu
时间：2016-03-16 15:00

原文：http://www.cnblogs.com/front-end-ralph/p/5283586.html[(L)](http://www.cnblogs.com/front-end-ralph/p/5190442.html)

 [好文要顶](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)  [关注我](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)  [收藏该文](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)  [![icon_weibo_24.png](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)  [![wechat.png](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

 [![20151012130305.png](../_resources/06711c03b231a3a63ead775ca4d819cf.jpg)](https://home.cnblogs.com/u/front-end-ralph/)

 [ralph_zhu](https://home.cnblogs.com/u/front-end-ralph/)
 [关注 - 6](https://home.cnblogs.com/u/front-end-ralph/followees/)
 [粉丝 - 68](https://home.cnblogs.com/u/front-end-ralph/followers/)

 [+加关注](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)

 4

 0

 [«](https://www.cnblogs.com/front-end-ralph/p/5208045.html) 上一篇： [细数Javascript技术栈中的四种依赖注入](https://www.cnblogs.com/front-end-ralph/p/5208045.html)

 [»](https://www.cnblogs.com/front-end-ralph/p/6500829.html) 下一篇： [Javascript中快速退出多重循环的技巧](https://www.cnblogs.com/front-end-ralph/p/6500829.html)

posted @ 2016-03-16 15:10 [ralph_zhu](https://www.cnblogs.com/front-end-ralph/)  阅读(1824)  评论(1) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=5283586) [收藏](抛开react，如何理解virtual%20dom和immutability%20-%20ralph_zhu%20-.md#)
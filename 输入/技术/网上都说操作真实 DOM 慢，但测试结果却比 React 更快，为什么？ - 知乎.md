网上都说操作真实 DOM 慢，但测试结果却比 React 更快，为什么？ - 知乎

[ 前端开发](https://www.zhihu.com/topic/19550901)
[ JavaScript](https://www.zhihu.com/topic/19552521)
[ React](https://www.zhihu.com/topic/20013159)

# 网上都说操作真实 DOM 慢，但测试结果却比 React 更快，为什么？

网上都说操作真实dom怎么怎么慢，但是下面这个链接案例中原生的方式却是最快的 [http://chrisharrington.github.io/demos/performance/...](https://link.zhihu.com/?target=http%3A//chrisharrington.github.io/demos/performance/) 我在本地也写了个例子循环…

关注者
**2,291**
被浏览
**181,244**

#### 38 个回答

[![7be980a0f_l.jpg](../_resources/b36f2585cb215e5edc9ebad7870fd826.jpg)](https://www.zhihu.com/people/evanyou)

[尤雨溪](https://www.zhihu.com/people/evanyou)

[​![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' class='css-1ifz0go js-evernote-checked' width='18' height='18' data-evernote-id='764'%3e%3csvg viewBox='0 0 24 24' x='-3' y='-3' fill='%23FFFFFF' width='30' height='30'%3e%3cpath d='M3.56231227%2c13.8535307 C2.40051305%2c12.768677 2.41398885%2c11.0669203 3.59484487%2c9.99979213 L3.59222085%2c9.99654885 C4.26730143%2c9.45036719 4.79446755%2c8.21005186 4.7184197%2c7.34453784 L4.72305873%2c7.34412719 C4.66942824%2c5.75539997 5.8824188%2c4.56066914 7.47188965%2c4.64242381 L7.47229112%2c4.6386236 C8.33515314%2c4.72977993 9.58467253%2c4.22534048 10.1426329%2c3.55925173 L10.1462611%2c3.56228565 C11.2316055%2c2.40008701 12.9353108%2c2.41394456 14.0015072%2c3.59634088 L14.0047263%2c3.59374004 C14.5498229%2c4.26841874 15.7896857%2c4.79521622 16.6545744%2c4.71844347 L16.6549836%2c4.72304294 C18.245027%2c4.66894057 19.4396947%2c5.88213996 19.3575031%2c7.47241135 L19.3623099%2c7.47292747 C19.2704388%2c8.3358681 19.7742711%2c9.58421483 20.4407199%2c10.1424506 L20.437686%2c10.1460789 C21.5997217%2c11.2312209 21.5860695%2c12.9345218 20.4042441%2c14.0007396 L20.4072865%2c14.0045125 C19.7325967%2c14.5495925 19.2055209%2c15.7896954 19.2815865%2c16.6561959 L19.2770449%2c16.6565978 C19.3315454%2c18.2453037 18.1173775%2c19.4393568 16.5274188%2c19.3571512 L16.5269029%2c19.3619539 C15.6647098%2c19.270083 14.415408%2c19.7741709 13.8573671%2c20.4403558 L13.8537409%2c20.4373235 C12.76842%2c21.5995708 11.0650432%2c21.5864553 9.99899434%2c20.4039226 L9.99527367%2c20.406923 C9.45025436%2c19.7323399 8.21017638%2c19.2051872 7.34461983%2c19.2812352 L7.344304%2c19.2776405 C5.75448683%2c19.3312904 4.55977145%2c18.1170085 4.64254978%2c16.527117 L4.63769921%2c16.5265942 C4.72957031%2c15.6644394 4.22547659%2c14.4151814 3.55928015%2c13.8571569 L3.56231227%2c13.8535307 Z'%3e%3c/path%3e%3c/svg%3e%3cpath d='M2.63951518%2c13.3895441 C3.70763333%2c14.2842292 4.44777637%2c16.1226061 4.30075305%2c17.5023312 L4.32211542%2c17.3063047 C4.17509209%2c18.6910561 5.17786655%2c19.7063729 6.5613937%2c19.5844846 L6.364106%2c19.6008202 C7.75140298%2c19.4789319 9.57474349%2c20.2554985 10.4468305%2c21.3349009 L10.3224262%2c21.1803415 C11.1982831%2c22.2647703 12.6257916%2c22.2723098 13.5167278%2c21.2079863 L13.3898102%2c21.3600325 C14.2845162%2c20.2919393 16.1229361%2c19.5518136 17.5026934%2c19.6988334 L17.3054057%2c19.6774716 C18.6914461%2c19.8244915 19.7067866%2c18.8217404 19.5836389%2c17.4395022 L19.6012314%2c17.6367853 C19.4793403%2c16.2482641 20.255925%2c14.4249662 21.3353526%2c13.5528995 L21.1807897%2c13.677301 C22.2639871%2c12.8014646 22.2727834%2c11.3739894 21.2084351%2c10.483074 L21.3604848%2c10.6099886 C20.2923667%2c9.71530351 19.5522236%2c7.87818322 19.6992469%2c6.49720154 L19.6778846%2c6.69448464 C19.8249079%2c5.30847665 18.8221335%2c4.2944164 17.4386063%2c4.41630468 L17.635894%2c4.39871256 C16.248597%2c4.52185742 14.4252565%2c3.74529084 13.5531695%2c2.66588842 L13.6775738%2c2.81919121 C12.8017169%2c1.73601905 11.3742084%2c1.72722299 10.4832722%2c2.79154644 L10.6101898%2c2.63950024 C9.71548377%2c3.70759343 7.87706394%2c4.44771919 6.49730661%2c4.30195588 L6.69459432%2c4.32206116 C5.30855394%2c4.17504128 4.29447%2c5.17904888 4.41636114%2c6.56128713 L4.3987686%2c6.36400404 C4.52065973%2c7.75126861 3.74407501%2c9.57456653 2.66464737%2c10.4478898 L2.81921035%2c10.3222318 C1.73601288%2c11.1993248 1.72721662%2c12.6255433 2.79156494%2c13.5164587 L2.63951518%2c13.3895441 Z' fill='%23FF9607'%3e%3c/path%3e%3csvg class='Zi Zi--Star' fill='%23fff' x='6' y='6' viewBox='0 0 24 24' width='12' height='12'%3e%3cpath d='M5.515 19.64l.918-5.355-3.89-3.792c-.926-.902-.639-1.784.64-1.97L8.56 7.74l2.404-4.871c.572-1.16 1.5-1.16 2.072 0L15.44 7.74l5.377.782c1.28.186 1.566 1.068.64 1.97l-3.89 3.793.918 5.354c.219 1.274-.532 1.82-1.676 1.218L12 18.33l-4.808 2.528c-1.145.602-1.896.056-1.677-1.218z' fill-rule='evenodd'%3e%3c/path%3e%3c/svg%3e%3c/svg%3e)](https://www.zhihu.com/topic/20054793)

前端开发等 3 个话题下的优秀回答者

这里面有好几个方面的问题。
**1. 原生 DOM 操作 vs. 通过框架封装操作。**

这是一个性能 vs. 可维护性的取舍。框架的意义在于为你掩盖底层的 DOM 操作，让你用更声明式的方式来描述你的目的，从而让你的代码更容易维护。没有任何框架可以比纯手动的优化 DOM 操作更快，因为框架的 DOM 操作层需要应对任何上层 API 可能产生的操作，它的实现必须是普适的。针对任何一个 benchmark，我都可以写出比任何框架更快的手动优化，但是那有什么意义呢？在构建一个实际应用的时候，你难道为每一个地方都去做手动优化吗？出于可维护性的考虑，这显然不可能。框架给你的保证是，你在不需要手动优化的情况下，我依然可以给你提供过得去的性能。

**2. 对 React 的 Virtual DOM 的误解。**

React 从来没有说过 “React 比原生操作 DOM 快”。React 的基本思维模式是每次有变动就整个重新渲染整个应用。如果没有 Virtual DOM，简单来想就是直接重置 innerHTML。很多人都没有意识到，在一个大型列表所有数据都变了的情况下，重置 innerHTML 其实是一个还算合理的操作... 真正的问题是在 “全部重新渲染” 的思维模式下，即使只有一行数据变了，它也需要重置整个 innerHTML，这时候显然就有大量的浪费。

我们可以比较一下 innerHTML vs. Virtual DOM 的重绘性能消耗：

- • innerHTML: render html string **O(template size)** + 重新创建所有 DOM 元素** O(DOM size)**
- • Virtual DOM: render Virtual DOM + diff **O(template size) **+ 必要的 DOM 更新 **O(DOM change)**

Virtual DOM render + diff 显然比渲染 html 字符串要慢，但是！它依然是纯 js 层面的计算，比起后面的 DOM 操作来说，依然便宜了太多。可以看到，innerHTML 的总计算量不管是 js 计算还是 DOM 操作都是和整个界面的大小相关，但 Virtual DOM 的计算量里面，只有 js 计算和界面大小相关，DOM 操作是和数据的变动量相关的。前面说了，和 DOM 操作比起来，js 计算是极其便宜的。这才是为什么要有 Virtual DOM：它保证了 1）不管你的数据变化多少，每次重绘的性能都可以接受；2) 你依然可以用类似 innerHTML 的思路去写你的应用。

**3. MVVM vs. Virtual DOM**

相比起 React，其他 MVVM 系框架比如 Angular, Knockout 以及 Vue、Avalon 采用的都是数据绑定：通过 Directive/Binding 对象，观察数据变化并保留对实际 DOM 元素的引用，当有数据变化时进行对应的操作。MVVM 的变化检查是数据层面的，而 React 的检查是 DOM 结构层面的。MVVM 的性能也根据变动检测的实现原理有所不同：Angular 的脏检查使得任何变动都有固定的 **O(watcher count) **的代价；Knockout/Vue/Avalon 都采用了依赖收集，在 js 和 DOM 层面都是** O(change)**：

- • 脏检查：scope digest **O(watcher count) **+ 必要 DOM 更新 **O(DOM change)**
- • 依赖收集：重新收集依赖 **O(data change)** + 必要 DOM 更新 **O(DOM change)**

可以看到，Angular 最不效率的地方在于任何小变动都有的和 watcher 数量相关的性能代价。但是！当所有数据都变了的时候，Angular 其实并不吃亏。依赖收集在初始化和数据变化的时候都需要重新收集依赖，这个代价在小量更新的时候几乎可以忽略，但在数据量庞大的时候也会产生一定的消耗。

MVVM 渲染列表的时候，由于每一行都有自己的数据作用域，所以通常都是每一行有一个对应的 ViewModel 实例，或者是一个稍微轻量一些的利用原型继承的 "scope" 对象，但也有一定的代价。所以，MVVM 列表渲染的初始化几乎一定比 React 慢，因为创建 ViewModel / scope 实例比起 Virtual DOM 来说要昂贵很多。这里所有 MVVM 实现的一个共同问题就是在列表渲染的数据源变动时，尤其是当数据是全新的对象时，如何有效地复用已经创建的 ViewModel 实例和 DOM 元素。假如没有任何复用方面的优化，由于数据是 “全新” 的，MVVM 实际上需要销毁之前的所有实例，重新创建所有实例，最后再进行一次渲染！这就是为什么题目里链接的 angular/knockout 实现都相对比较慢。相比之下，React 的变动检查由于是 DOM 结构层面的，即使是全新的数据，只要最后渲染结果没变，那么就不需要做无用功。

Angular 和 Vue 都提供了列表重绘的优化机制，也就是 “提示” 框架如何有效地复用实例和 DOM 元素。比如数据库里的同一个对象，在两次前端 API 调用里面会成为不同的对象，但是它们依然有一样的 uid。这时候你就可以提示 track by uid 来让 Angular 知道，这两个对象其实是同一份数据。那么原来这份数据对应的实例和 DOM 元素都可以复用，只需要更新变动了的部分。或者，你也可以直接 track by $index 来进行 “原地复用”：直接根据在数组里的位置进行复用。在题目给出的例子里，如果 angular 实现加上 track by $index 的话，后续重绘是不会比 React 慢多少的。甚至在 dbmonster 测试中，Angular 和 Vue 用了 track by $index 以后都比 React 快: [dbmon](https://link.zhihu.com/?target=http%3A//vuejs.github.io/js-repaint-perfs/) (注意 Angular 默认版本无优化，优化过的在下面）

顺道说一句，React 渲染列表的时候也需要提供 key 这个特殊 prop，本质上和 track-by 是一回事。
**4. 性能比较也要看场合**

在比较性能的时候，要分清楚初始渲染、小量数据更新、大量数据更新这些不同的场合。Virtual DOM、脏检查 MVVM、数据收集 MVVM 在不同场合各有不同的表现和不同的优化需求。Virtual DOM 为了提升小量数据更新时的性能，也需要针对性的优化，比如 shouldComponentUpdate 或是 immutable data。

- • 初始渲染：Virtual DOM > 脏检查 >= 依赖收集
- • 小量数据更新：依赖收集 >> Virtual DOM + 优化 > 脏检查（无法优化） > Virtual DOM 无优化
- • 大量数据更新：脏检查 + 优化 >= 依赖收集 + 优化 > Virtual DOM（无法/无需优化）>> MVVM 无优化

不要天真地以为 Virtual DOM 就是快，diff 不是免费的，batching 么 MVVM 也能做，而且最终 patch 的时候还不是要用原生 API。在我看来 Virtual DOM 真正的价值从来都不是性能，而是它 1) 为函数式的 UI 编程方式打开了大门；2) 可以渲染到 DOM 以外的 backend，比如 ReactNative。

**5. 总结**

以上这些比较，更多的是对于框架开发研究者提供一些参考。主流的框架 + 合理的优化，足以应对绝大部分应用的性能需求。如果是对性能有极致需求的特殊情况，其实应该牺牲一些可维护性采取手动优化：比如 Atom 编辑器在文件渲染的实现上放弃了 React 而采用了自己实现的 tile-based rendering；又比如在移动端需要 DOM-pooling 的虚拟滚动，不需要考虑顺序变化，可以绕过框架的内置实现自己搞一个。

[编辑于 2016-02-08](https://www.zhihu.com/question/31809713/answer/53544875)

[![539a2d33b_l.jpg](../_resources/f86d94aac674e6799c4e31bdaf47cd60.jpg)](https://www.zhihu.com/people/si-tu-zheng-mei)

[司徒正美](https://www.zhihu.com/people/si-tu-zheng-mei)

[​![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' class='css-1ifz0go js-evernote-checked' width='18' height='18' data-evernote-id='765'%3e%3csvg viewBox='0 0 24 24' x='-3' y='-3' fill='%23FFFFFF' width='30' height='30'%3e%3cpath d='M3.56231227%2c13.8535307 C2.40051305%2c12.768677 2.41398885%2c11.0669203 3.59484487%2c9.99979213 L3.59222085%2c9.99654885 C4.26730143%2c9.45036719 4.79446755%2c8.21005186 4.7184197%2c7.34453784 L4.72305873%2c7.34412719 C4.66942824%2c5.75539997 5.8824188%2c4.56066914 7.47188965%2c4.64242381 L7.47229112%2c4.6386236 C8.33515314%2c4.72977993 9.58467253%2c4.22534048 10.1426329%2c3.55925173 L10.1462611%2c3.56228565 C11.2316055%2c2.40008701 12.9353108%2c2.41394456 14.0015072%2c3.59634088 L14.0047263%2c3.59374004 C14.5498229%2c4.26841874 15.7896857%2c4.79521622 16.6545744%2c4.71844347 L16.6549836%2c4.72304294 C18.245027%2c4.66894057 19.4396947%2c5.88213996 19.3575031%2c7.47241135 L19.3623099%2c7.47292747 C19.2704388%2c8.3358681 19.7742711%2c9.58421483 20.4407199%2c10.1424506 L20.437686%2c10.1460789 C21.5997217%2c11.2312209 21.5860695%2c12.9345218 20.4042441%2c14.0007396 L20.4072865%2c14.0045125 C19.7325967%2c14.5495925 19.2055209%2c15.7896954 19.2815865%2c16.6561959 L19.2770449%2c16.6565978 C19.3315454%2c18.2453037 18.1173775%2c19.4393568 16.5274188%2c19.3571512 L16.5269029%2c19.3619539 C15.6647098%2c19.270083 14.415408%2c19.7741709 13.8573671%2c20.4403558 L13.8537409%2c20.4373235 C12.76842%2c21.5995708 11.0650432%2c21.5864553 9.99899434%2c20.4039226 L9.99527367%2c20.406923 C9.45025436%2c19.7323399 8.21017638%2c19.2051872 7.34461983%2c19.2812352 L7.344304%2c19.2776405 C5.75448683%2c19.3312904 4.55977145%2c18.1170085 4.64254978%2c16.527117 L4.63769921%2c16.5265942 C4.72957031%2c15.6644394 4.22547659%2c14.4151814 3.55928015%2c13.8571569 L3.56231227%2c13.8535307 Z'%3e%3c/path%3e%3c/svg%3e%3cpath d='M2.63951518%2c13.3895441 C3.70763333%2c14.2842292 4.44777637%2c16.1226061 4.30075305%2c17.5023312 L4.32211542%2c17.3063047 C4.17509209%2c18.6910561 5.17786655%2c19.7063729 6.5613937%2c19.5844846 L6.364106%2c19.6008202 C7.75140298%2c19.4789319 9.57474349%2c20.2554985 10.4468305%2c21.3349009 L10.3224262%2c21.1803415 C11.1982831%2c22.2647703 12.6257916%2c22.2723098 13.5167278%2c21.2079863 L13.3898102%2c21.3600325 C14.2845162%2c20.2919393 16.1229361%2c19.5518136 17.5026934%2c19.6988334 L17.3054057%2c19.6774716 C18.6914461%2c19.8244915 19.7067866%2c18.8217404 19.5836389%2c17.4395022 L19.6012314%2c17.6367853 C19.4793403%2c16.2482641 20.255925%2c14.4249662 21.3353526%2c13.5528995 L21.1807897%2c13.677301 C22.2639871%2c12.8014646 22.2727834%2c11.3739894 21.2084351%2c10.483074 L21.3604848%2c10.6099886 C20.2923667%2c9.71530351 19.5522236%2c7.87818322 19.6992469%2c6.49720154 L19.6778846%2c6.69448464 C19.8249079%2c5.30847665 18.8221335%2c4.2944164 17.4386063%2c4.41630468 L17.635894%2c4.39871256 C16.248597%2c4.52185742 14.4252565%2c3.74529084 13.5531695%2c2.66588842 L13.6775738%2c2.81919121 C12.8017169%2c1.73601905 11.3742084%2c1.72722299 10.4832722%2c2.79154644 L10.6101898%2c2.63950024 C9.71548377%2c3.70759343 7.87706394%2c4.44771919 6.49730661%2c4.30195588 L6.69459432%2c4.32206116 C5.30855394%2c4.17504128 4.29447%2c5.17904888 4.41636114%2c6.56128713 L4.3987686%2c6.36400404 C4.52065973%2c7.75126861 3.74407501%2c9.57456653 2.66464737%2c10.4478898 L2.81921035%2c10.3222318 C1.73601288%2c11.1993248 1.72721662%2c12.6255433 2.79156494%2c13.5164587 L2.63951518%2c13.3895441 Z' fill='%23FF9607'%3e%3c/path%3e%3csvg class='Zi Zi--Star' fill='%23fff' x='6' y='6' viewBox='0 0 24 24' width='12' height='12'%3e%3cpath d='M5.515 19.64l.918-5.355-3.89-3.792c-.926-.902-.639-1.784.64-1.97L8.56 7.74l2.404-4.871c.572-1.16 1.5-1.16 2.072 0L15.44 7.74l5.377.782c1.28.186 1.566 1.068.64 1.97l-3.89 3.793.918 5.354c.219 1.274-.532 1.82-1.676 1.218L12 18.33l-4.808 2.528c-1.145.602-1.896.056-1.677-1.218z' fill-rule='evenodd'%3e%3c/path%3e%3c/svg%3e%3c/svg%3e)](https://www.zhihu.com/topic/20054793)

JavaScript话题下的优秀回答者

> 我最近搞虚拟DOM，就说说> [> avalon](https://link.zhihu.com/?target=https%3A//github.com/RubyLouvre/avalon)> 是怎么更新数据的吧，react的实现方式也差不多

	<!DOCTYPE html>
	<html>
	    <head>
	        <meta charset="UTF-8">
	        <script src="avalon.js"></script>
	        <script>
	            var vm = avalon.define({
	                $id: 'test',
	                array: ["a", "b", "c", "d"],
	                change: function () {
	                    vm.array = ["x", "c", "a", "b", "f", "k"]
	                }
	            })
	
	        </script>
	    </head>
	    <body ms-controller="test">
	        <button type="button" ms-click="change">change</button>
	        <ul>
	            <li ms-repeat="array">{{el}}</li>
	        </ul>
	    </body>
	</html>

![4db96b3fae1dc26db2d7d4c2817b2226_r.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102131425.jpg)

注意到列表多了许多注释节点吧，这叫做**路标系统**，用于确定数组元素的作用域范围，方便移动它们。大家如果会angular，使用ng-repeat也会有这样的注释元素。但这些不是重点。

为了让大家明白虚拟DOM为什么这么高效的原因，我们直接在chrome控制台下对这些LI元素做一些修改，全部加上title属性。它们能方便告诉我们，一会儿点击了change按钮，重新渲染列表，这些LI元素是新建的，还是沿用的旧的。

![fe6e72b2bd6e640ec56ad75426d9ee74_r.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102131501.jpg)

当我们点击change按钮后
![dcb5240342485782c9b9ae0fd08c52df_r.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102131518.jpg)

我们可以发现，能重复利用的节点被重复利用，它是优先考虑移动节点，这时它不用一一改动LI元素里面的所有要改动的地方;对于新添加的元素，它会利用上次被删除的元素对应的节点，然后改变其属性值 ;当没有可利用的节点，框架才会将虚拟节点转换真实节点。在某些MVVM框架，需要用户显式写“track by $index”, react则要求用key，avalon是内部使用hash算法搞定。

这只是diff算法的冰山一角。
其实，**如果没有循环绑定（ms-repeat, ng-repeat, v-for），MVVM是不存在性能问题**。
循环绑定会破坏原来的页面结构，引起页面重新布局。
传统的字符串模板，对付它们只会innerHTML，这导致每次都会生成大量的节点，选区，光标位置，事件及挂在它上面的第三方组件都要重新处理。
而一些弱的MVVM框架，它们的算法就差一点，无法尽量利用已有节点。

avalon与react的做法是使用了虚拟DOM做缓冲层，每次数据变动，都生成对应区域的虚拟DOM树，然后两个虚拟DOM做合并操作（diff），得到更新的操作集(patch)。

avalon目前没有考虑支持多种渲染形态（只有DOM，不存在canvas, webgl, native等渲染介质），那么可以偷懒，对不存在绑定的元素及其孩子，不再转换为虚拟DOM，这样减少diff的节点。

创建一个DOM的消耗是非常惊人，目前，在浏览器中存在四种形态的对象
1. 1. 超轻量 Object.create(nulll)
2. 2. 轻量 一般的对象 {}
3. 3. 重量 带有访问器属性的对象, avalon或vue的VM对象
4. 4. 超重量 各种节点或window对象
然后频繁访问或创建 3，4种形态的对象是很不明智的。但VM对象能为编程带来极好的用户体验，因此这个代价是可以接受的。

在过去的MVVM框架中，绑定属性的操作主体是元素节点（它们一般放在观察者模式的订阅数组中），有了虚拟DOM，我们就直接操作虚拟DOM，这样它们移出或插入虚拟DOM树，是不耗费什么性能，更不会结合CSS样式表产生reflow,rerender 什么破事。 因此原真实DOM拥有了**绑定属性**(ms-*, ng-*)与**路标系统 **，以后我们将虚拟DOM树的变更同步到真实DOM树时是非常方便的。

而react是怎么追踪到其更变更的节点呢？它有**data-reactid**！只要确保对应关系，虚拟DOM怎么插入，移除，重排，react会在一个事务的尽头，才开始重新真实DOM，这样也能确保更新成功。

![ce7da9b36d8a9a6736c4ace0f995b783_r.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102131527.jpg)

总而言之，有了虚拟DOM，我们是使用够轻量的对象代替超重对象作为直接操作 主体，减少对超重对象的操作！虚拟DOM的结构是很轻量，最多不超过10个属性，并且其继承层级不超过2层。而DOM节点有70＋个属性，继承层级有6，7层（文本节点6层，元素节点7层）.访问一个属性，可能会追溯几重原型链

[通过JS修改属性时触发DOM回调 · Issue #272 · RubyLouvre/avalon · GitHub](https://link.zhihu.com/?target=https%3A//github.com/RubyLouvre/avalon/issues/272)

![514c13fea2383512b40fb400fcfb88c2_r.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102131540.jpg)

其二，能在虚拟DOM与真实DOM建立映射关系.avalon是使用绑定属性与路标系统 ，react使用data-reactid，但data-reactid是元素节点的自定义属性，对于文本节点，它没有办法，只好外包一个span，因此严重破坏旧有结构。即便插入了这么span，react性能还是很快。

第三，react与avalon的所有虚拟DOM对象是可回收循环利用。而节点循环利用是很危险，很易造成内存泄漏。

虚拟DOM不只是一个缓冲层，里面涉及大量算法，你可以使用hash或KMP，确保更新最少。或者在某级对象创建一个更新对象包，将重复变更的属性放在里面，这样aaa=bbb, aaa=ccc,aaa=ddd就自动合并成一个aaa=ddd。

为了追求性能，react强制单向流动，方便让状态叠加。但双向绑定也能叠加，只是会让VM内部数据多转几圈。

无论怎么样，虚拟DOM是一个伟大的发明，但react实现得比较笨拙而已。随着大家对其源码的研读，今年会冒出更多同类型产品。前端就是因为源码公开而繁荣昌盛！因此大家必须读源码，只会调API，永远是低级码农。

[编辑于 2016-01-05](https://www.zhihu.com/question/31809713/answer/80089685)

[![c63d0c24e732b2d2b24b577d8e445658_l.jpg](../_resources/f1a87be85b34cdbb03de0eb09f8a977c.jpg)](https://www.zhihu.com/people/fredriklo)

[罗志宇](https://www.zhihu.com/people/fredriklo)

鉴于有人表示没有看懂。 下面是结论:

- • 题主测试结果反常是因为测试用例构造有问题。
- • React.js 相对于直接操作原生DOM有很大的性能优势， 背后的技术支撑是基于virtual DOM的batching 和diff.
- • React.js 的使用的virtual DOM 在Javascript Engine中也有执行效率的优势。

如果想知道解释，请继续阅读。。
－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

看了好几个答案感觉都没有答到点子上面。如果一个框架发明出来就是为了提高性能，那就一定要在性能上面有所体现。编程模型类型框架实在是太多太多，React.js仅仅因为这个不可能会那么受好评。

React.js仅仅是做MVC中的View，也就是渲染层，任务其实非常单一的，也没有那么多哲学方面的东西需要承载。

**1.题主测试结果反常是因为测试用例构造有问题。**

我们来看看题主的测试用例(由于题主问的react.js 和原生，所以其他的我都去掉了).
*以下所有的代码都在:*
*

[http://fredrikluo.github.io/testcases/reactjstest.html...](https://link.zhihu.com/?target=http%3A//fredrikluo.github.io/testcases/reactjstest.html)*

原生 (只保留了关键代码，其他都去掉了，这样看得更清楚一点）
![b94c1db9c8dc910b47ef6f9fdbcb534d_r.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102131613.jpg)
这里看出问题没？

整个测试用例的模式是：
1. 1. 构造一个 String, 包含一个1000个 Tag。
2. 2. 把这1000个 Tag 一次性添加到 DOM 树中。
其实，**题主的测试用例只做了一次 DOM 操作**。。而且主要问题是，如果你真的做一个WebAPP, 然后直接操作DOM更新，更新的模式完全不是这样子的。

在现实中，更新模式更像这个样子滴：

同样是 1000 元素需要更新， 你的界面上面分成了20个逻辑区域（或者层，或者 view, 或者whatever 框架取的名字）, **每个区域 50 个元素。在界面需要更新的时候，每个逻辑区域分别操作 DOM Tree 更新**。

那么代码看起来更像是这样子的:
![54b8f7da17021f35800e48adeee7b119_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/54b8f7da17021f35800e48adeee7b119.png)

然后我们再来看看结果
![6ef03bab2d7e4612a2a8def8b0796918_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/5ae3981f3def2ba027119da743ea1644.jpg)

天了撸， 发生了什么， 原生的怎么慢这么多。（React.js 并不需要修改，无论如何每个区域都是把新的操作作用在Virtual DOM上面，然后每帧只会调用一次Render)。

**2. React.js 相对于直接操作原生DOM有很大的性能优势， 背后的技术支撑是基于virtual DOM的batching 和diff。**

原生DOM 操作慢吗？

做为一个浏览器内核开发人员， 我可以负责任的告诉你，慢。
你觉得只是改变一个字符串吗？

![96f472167b8944d42aabe61393c68241_r.jpg](../_resources/96f472167b8944d42aabe61393c68241.jpg)
我们来看看你在插入一个DOM元素的时候，发生了什么.
![fe8b480c0016fd023b25bd4c4e8f3914_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/fe8b480c0016fd023b25bd4c4e8f3914.png)

实际上，浏览器在收到更新的DOM Tree需要立即调用HTML Parser对传入的字符串进行解析，这个，呃，耗的时间可不是字符串替换可以比的哦 .

(*其实你们已经处于一个好时代了，换做几年前，浏览器还可能会花几秒到几分钟给你Reflow一下）*

这个例子还算简单的了，如果你插入的标签里面包括了脚本，浏览器可能还需要即时编译的你脚本(JIT).

*这些时间都算在你的DOM操作中的哦**。***

我们再来看看统计。
![93799d4434552f68d7c8fcf9a39bdf6b_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/93799d4434552f68d7c8fcf9a39bdf6b.png)

131 ms **都花在了Loading 里面(ParseHTML)**。

*另外注意一些细节，Profiler 报告整个函数使用了418ms, 因为有些时间在JS里面是统计不到的，比如Rendering的时间， 所以， 多用Profiler.*

我们再来看一个图， 这个原测试用例的Profiling， 1000 Tag 一次插入

![3ffd05a65cdafc445226abfb79a04be3_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/3ffd05a65cdafc445226abfb79a04be3.png)

呃，如果你还没有看出端倪的话，我提示一下: 这里的解析时间(Loading)降到了13 ms.

***同样的数据（1000 元素），分20次解析， 每次解析50个，耗时是 一次性解析的 10 倍左右。。也就是说，有9倍开销，都花在了DOM函数，以及背后的依赖的函数本身的开销上了。** DOM 操作本身可能不耗时，但是建立上下文，层层传递的检查的开销就不容小视了***。**

这个官方称为”API Overhead”. 改变DOM 结构的调用都有极其高的API Overhead.
而对于Overhead高的API，标准解决办法就是两个：

Batching 和 Diff.

Diff 大家都比较了解， Batching是个啥？

想象在一个小山村里面，只有一条泥泞的公路通向市区，公交车班次少，每次要开半个小时，如何保证所有乘客最快到达目的地？

*搜集尽量多的乘客，然后一次性的把它们运往市区， 这个就是Batching.*

如果你搜下React.js 的文档里面。这里有专门提到：

> “ You may be thinking that it's expensive to change data if there are a large number of nodes under an owner. The good news is that JavaScript is fast and `render()` methods tend to be quite simple, so in most applications this is extremely fast. Additionally, the bottleneck is almost always the DOM mutation and not JS execution. React will optimize this for you using batching and change detection.“

*这个才是React.js 引入Virtual DOM 的精髓之一， **把所有的DOM操作搜集起来，一次性提交给真实的DOM**. *

Batching 或者 Diff, 说到底，都是为了尽量减少对慢速DOM的调用。

*类似技术在游戏引擎里面（对 OPENGL 的Batch), 网络传输方面( 报文的Batch), 文件系统读写上都大量有使用。*

**3. React.js 的使用的virtual DOM在Javascript Engine中也有执行效率的优势**

Virtual DOM 和 DOM 在JS中的执行效率比较**。**

－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
前方高能预警， 一般前端开发不需要了解那么多，不过如果你如果都看懂了，来欧朋浏览器面试吧 :)

抛开浏览器内核开销不算， 从Javascript 执行效率来讲，Virtual DOM 和DOM之间到底有多大差别呢？

这个其实可以回答Virtual DOM 到底有多快这个问题上面。 了解这个问题，需要了解浏览器内核，DOM以及网页文档到底都是什么关系。
![40b07ca3f65089ee272d690dd3b10d2b_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/40b07ca3f65089ee272d690dd3b10d2b.png)

很吃惊吧。

其实DOM 完全不属于Javascript (也不在Javascript 引擎中存在). Javascript 其实是一个非常独立的引擎，DOM其实是浏览器引出的一组让Javascript操作HTML文档的API而已。

*如果你了解Java的话，这个相当于JNI.*

那么问题就来了, **DOM的操作对于Javascript实际上是外部函数调用**。 每次Javascript 调用DOM时候，都需要保存当前的上下文，然后调用DOM, 然后再恢复上下文。 这个在没有即时编译(JIT)的时代可能还好点。 自从加入即时编译(JIT), 这种上下文开销简直就是。。惨不忍睹。

我们来顺便写一段Javascript.

![](data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='408' height='228'></svg>)

然后在v8里面跑一跑(直接使用v8 sample中的shell ). 由于v8 单独的Shell中不存在DOM， 我们用print代替， print 是外部函数， 调用它和调用DOM是一回事。

调用的堆栈看起来是这样的。
![310b77624852fffe1e2160d7acfed8af_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/2518a81f68a43dc912a86d15827ca3ff.jpg)

这里可以看到V8是如何执行JIT代码，然后JIT代码调用到Print的过程 (JIT 代码就是没有符号的那一堆，Frame #1 - #5.）

我们来看看v8 JIT 生成的代码.
![87d461d6e5f85a11cb6a99d78a2c0a9b_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/87d461d6e5f85a11cb6a99d78a2c0a9b.png)

看到这里还算合理， 一个call调走，不过我们来看看 CallApiAccessorStub是个什么鬼：

![](data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='257' height='261'></svg>)

60+ 条额外指令用于保存上下文和堆栈检查。。
我靠，我就调个函数，你至于吗..

*当然，现代的JIT技术已经进步很多了，换到几年前，这个函数直接就不JIT了 (不编译了, 在V8中即不优化，你懂的，慢10到100倍）.*

而Virtual DOM的执行完全都在Javascript 引擎中，完全不会有这个开销。

什么，你说我第一个测试结果里面两边的速度就差一半嘛（117 ms vs 235 ms)，react.js还只是做了一次DOM操作，原生的可是做了50次哦， 你说的virtual DOM框架完全不会有开销是几个意思？

我们来稍微改改测试代码。
![50c0b736b5ae63b0c35c925670ec537e_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/50c0b736b5ae63b0c35c925670ec537e.png)
给你们每个条目加个标示符，这样每次更新的DOM都不一样，我看React.js你怎么做Diff, 哇哈哈哈哈哈.

然后你可以多点几次React的测试按钮，一般来说来，第二次以后, 你就可以看到性能稳定在这个数字。
![88388ee7e8345d256bed0ee90a942083_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/5ac01595b414a51604615c701cde068a.jpg)

这个是个什么情况？ 这个可不是React.js Diff的功劳哦？因为我们每次的更新都是完全不同的，它木有办法占便宜做Diff哦。。

这个其实是Javascript 引擎的工作特性引起。Javascript 引擎目前用的都是即时编译(JIT). 所以

- • ***第一次点击运行的时候所耗的时间 ＝ 框架被编译的时间(JIT) + 执行时间***
- • ***之后执行的时间 ＝ 执行时间。***

所以, **53 ms那个才是Virtual DOM 的真实执行性能哦, 是不是觉得好快呀**。

*当然, v8的JIT方法还要特殊一些, 他是两次编译的, 第一次粗编译，第二次会把执行很多的函数进行精细编译. 所以第三次以后才是最快的时间。*
*
两次编译虽然很有趣也很有用，鉴于这个帖子实在是太长了，这里就不讲了。 有兴趣看这个:*

[v8: a tale of two compilers -- wingolog](https://link.zhihu.com/?target=https%3A//wingolog.org/archives/2011/07/05/v8-a-tale-of-two-compilers)

*原测试用例在测react第二次运行的时候会很慢（大概4s左右), 原因是这个：*
onClick: this.select.bind(null, this.props.data[i])

bind 会每次创建一个新的函数对象，于是原测试里面每次点击会创建1000个新的函数对象。恭喜原作者，JS的内存真是不要钱。。
我的测试用例里面暂时去掉了，彻底修复可以不用bind, 指向一个函数即可，然后用其他方法为每个列表项保存状态。

-------------------------------------------------------------------------------------------------------------

回答 @[杨伟贤](http://www.zhihu.com/people/yang-wei-xian)

你用的技巧称为是 *DocumentFragment, *参见

[Document Object Model (Core) Level 1](https://link.zhihu.com/?target=http%3A//www.w3.org/TR/REC-DOM-Level-1/level-one-core.html%23ID-B63ED1A3)

这个改善性能技巧早期流行其实主要是防止浏览器在JS修改DOM的时候立即Reflow。(防止你在修改了DOM以后立即取元素大小一类的）。

这个技巧在现代浏览器里面基本没有作用，因为，基本上Reflow和Layout都是能延迟就延迟。
不相信的话你这样写

	var tplDom = document.createElement('div');
	container.appendChild(tplDom);
	tplDom.innerHTML = html;
	html = '';

tplDom先加入global DOM然后在修改，这个算是刷global DOM了吧？
在chromium里面没有任何区别的。
我更改以后的测试用例里面就是这样写的：）

所以，这个和刷不刷global DOM没有任何关系的。你看到的性能提升，其实是避免了
container.innerHTML += html;
中+=, 因为+= 是其实是一个替代操作，而不是增量操作。

另外, 你测出来的只是插入新元素时间而代码里面还需要删掉之前的节点的代码.
因为对于react.js
第一次运行时间 ＝ JIT时间+插入时间
多次以后 = 更新节点时间。 （v8优化器原因）

而更新节点 ＝ 删除节点＋插入新的节点 （你也可以用replaceChild, 性能没有能测出来差异）.

react.js由于第一次运行带着JIT,所以没有办法剥离出来纯插入时间。于是加入删除之前节点的代码，然后多次运行测试更新节点的时间才是有比较性的。

修改后的测试用例在

[http://fredrikluo.github.io/testcases/reactjstest-1.html...](https://link.zhihu.com/?target=http%3A//fredrikluo.github.io/testcases/reactjstest-1.html)

你可以试试，这个是我这里测出来的结果。
![8bb3f203a2c082ef6b1e821d7d7d9a9f_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/8bb3f203a2c082ef6b1e821d7d7d9a9f.png)

很接近了是不是？不可否认这是一个非常好的优化，
是不是觉得React已经没有什么优势？

少年，你太天真了，浏览器这个世界很险恶的，我刚才说Layout和Reflow被怎么了来着？
被延迟了。。

我们来看看profiler的输出。
React 的性能统计
![eae5800183ba03b92c54182f0e3cf666_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/eae5800183ba03b92c54182f0e3cf666.png)
Raw的性能统计
![372dd6baf138b3a93ee58a1ccaada0d5_r.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/372dd6baf138b3a93ee58a1ccaada0d5.png)

事实上React的耗用的时间的是80m, 而优化后的Raw也有144 ms, 接近一半的时间。

**为蜀莫呢？**

有个31ms 和95ms的rendering差别，而在这个例子里面， rendering = Recalculate Style 和Layout（参见上面的堆栈，或者你自己也可以试试）。而这个差异，在JS里面是测不到了，因为， 呃，他们被延迟了。。

原因也很简单，React 修改的粒度更小。

virtual DOM每次用Batch + diff来修改DOM的时候, 假如你有个<span class=''123"> abc</span>如果只是内容变了，那spanNode.textContent会被换掉, style啥的不会动。 而在原生例子里面，整个spanNode被换掉。

*浏览器： 你把整个节点都换了，我肯定只能重新计算style和layout了， 怪我咯。*

从本质上面讲， react.js 和自己写算法直接操作原生的DOM是这样一个关系：

**修改的内容 -> React.js -> DOM操作**
**修改的内容 -> 你的算法 -> DOM操作**

**React.js 和你的算法最后都是把特定的意图翻译成一组DOM操作，差别只是谁的翻译更加优化而已**

而原回答其实想说明的时候，react.js 在使用virtual DOM这套算法以后DOM操作在通常情况下比自己的写是优化非常多的。这个其实是对“使用react.js和（用自己算法）操作DOM哪个快”这个问题的直接回答。 而你当然可以进一步优化算法，在特定的环境下面接近或者超过React, 不过，这个在实际开发中并没有适普性。

这个其实和问编译器和手动汇编哪个快是一模一样

**算法 -> 原代码 ->编译器－>汇编**
**算法 ->手动翻译->汇编**

而在目前CPU的复杂程度下，手动翻译反而大部分时间比不上编译器， 复杂度越高，需要考虑的变量越多，越容易用算法来实现而人脑总是爱忘东西的。

不可否认是原测试用例里面的不管是测raw还是测react的的算法都写得很有问题。所以对原回答中只是尽量不做大的修改来说明问题而已。

最后还要感谢你的提问，否则没法讲得这个深度，其实在写virtual DOM JIT那一段的时候我就很犹豫是不是讲得有点过了。

-----------------------------------------------------------------------------------------------------------

回答
[@尤雨溪](https://www.zhihu.com/people/cfdec6226ece879d2571fbc274372e9f)

呃。。你说的这句话是吧 － “发明出来就是为了提高性能” 以及 “没有那么多哲学方面的东西需要承载”。
既然我们讨论的是“发明出来”， 我们就来看看原团队的意思咯， 戳这里， 这个原团队的blog post：

[Why did we build React?](https://link.zhihu.com/?target=https%3A//facebook.github.io/react/blog/2013/06/05/why-react.html)

－－ 摘要如下：
**Why did we build React?**

There are a lot of JavaScript MVC frameworks out there. Why did we build React and why would you want to use it?

**React isn't an MVC framework.**
....
**React doesn't use templates.**
...
**Reactive updates are dead simple**
React really shines when your data changes over time.
....

Because this re-render is so fast (around 1ms for TodoMVC), the developer doesn't need to explicitly specify data bindings. We've found this approach makes it easier to build apps

....
这个才是全文重点, 请再次默念下“**really shines**”

这篇Post翻译成大白话就是：
**哥做了一个框架， 有这个功能，还有这个功能，但是最牛逼的功能就是：你的数据变的时候渲染的特别快哦, 快得你们爱怎么搞怎么搞。**

真的不是性能嘛？...

PS: 虽然我觉得你说得很有道理，他们都是react.js的好处啦，不过就从"why"来说

- • 但是“通过引入函数式思维来加强对状态的管理”， 貌似木有在“why”里面提到？
- • 第三方那个我木有找到引用。
- • 而“Virtual DOM 可以渲染到非 DOM 的后端从而催生 ReactNative”, 是在：“Because React has its own lightweight representation of the document, we can do some pretty cool things with it:”

听起来貌似是：
“React really shines when your data changes over time.

In a traditional JavaScript application, you need to look at what data changed and imperatively make changes to the DOM to keep it up-to-date. Even AngularJS, which provides a declarative interface via directives and data binding [requires a linking function to manually update DOM nodes](https://link.zhihu.com/?target=https%3A//code.angularjs.org/1.0.8/docs/guide/directive%23reasonsbehindthecompilelinkseparation).

React takes a different approach.”
的副产品哦(by-product).
[编辑于 2015-07-22](https://www.zhihu.com/question/31809713/answer/54833728)

[ ![v2-bdca9d0c3096fdb2cc52adfbbf117f66_250x250.jpeg](../_resources/bdca9d0c3096fdb2cc52adfbbf117f66.jpg)基因宝](https://genebox.cn/web?channel=zhihu_pc&cb=https%3A%2F%2Fsugar.zhihu.com%2Fplutus_adreaper_callback%3Fsi%3D314b3f67-5718-401a-96d4-fd245fa4a36a%26os%3D3%26zid%3D236%26zaid%3D738835%26zcid%3D769495%26cid%3D769494%26event%3D__EVENTTYPE__%26value%3D__EVENTVALUE__%26ts%3D__TIMESTAMP__%26cts%3D__TS__)

广告​![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='Icon Icon--triangle Pc-word-card-sign-svg js-evernote-checked' viewBox='0 0 24 24' data-evernote-id='634'%3e%3cpath d='M9.218 16.78a.737.737 0 0 0 1.052 0l4.512-4.249a.758.758 0 0 0 0-1.063L10.27 7.22a.737.737 0 0 0-1.052 0 .759.759 0 0 0-.001 1.063L13 12l-3.782 3.716a.758.758 0 0 0 0 1.063z' fill-rule='evenodd'%3e%3c/path%3e%3c/svg%3e)

[## 为什么越来越多的人开始做基因检测，这是一次重新认识自己的机会！  2ml唾液，破解自己身上的秘密。测基因，只选基因宝。原价398，现在只要9块9起，快递上门，你不来测测吗？查看详情](https://genebox.cn/web?channel=zhihu_pc&cb=https%3A%2F%2Fsugar.zhihu.com%2Fplutus_adreaper_callback%3Fsi%3D314b3f67-5718-401a-96d4-fd245fa4a36a%26os%3D3%26zid%3D236%26zaid%3D738835%26zcid%3D769495%26cid%3D769494%26event%3D__EVENTTYPE__%26value%3D__EVENTVALUE__%26ts%3D__TIMESTAMP__%26cts%3D__TS__)

[![v2-aceb6d41e07a5a07035de76de3cdaadf_l.jpg](../_resources/aceb6d41e07a5a07035de76de3cdaadf.jpg)](https://www.zhihu.com/people/axurez)

[Colliot](https://www.zhihu.com/people/axurez)
You have loved enough.

你的问题就是错的，从多个层面上来说都是错的。

- • 首先，这个测试显示的数字上，是否 react 真的慢于原生？只有前两次是这样，后面你测一千次也是 react 更快。
- • 其次，这个显示的数字是否代表真实的速度？并不是这样。实际表现，原生更慢。
    - • [罗志宇：网上都说操作真实 DOM 慢，但测试结果却比 React 更快，为什么？](https://www.zhihu.com/question/31809713/answer/54833728) 这个回答讲的已经很清楚了，（就这个测试而言）原生花在 rendering 上的时间相当多，你可以自己用 Chrome 开发者工具的 performance 测测看。
    - • 我这里的数据是，react 的版本，rendering 小于 scripting，原生的 rendering 是 scripting 的 1.5 倍以上。本来 react 显示的数字就比原生小，我这里是 30ms 对 50ms（左右），这么一算总时间就是 60ms 对 125ms。
    - • 这个数字是真的假的，很容易就能感受到，你用鼠标去飞速点击，react 的毫无卡顿，但原生的就会卡卡的。
- • 最后，这个程序能否代表真实 DOM 操作？并不能。
    - • 原生肯定不会比 react 慢，比如这里你可以第一次渲染的时候把列表里的 DOM 都存起来，以后每次渲染遍历一遍 DOM，直接设置它们的 innertHTML。在我这里这么做只要 20ms。
    - • 测试里这段代码着实太恶劣了（见下），生成一段巨大的 HTML，让浏览器去解析，这是可能都算不上 DOM 操作了。这么做相当于写一段程序，展示一段数据，你不是留一个接口，直接让人去改内存，而是把数据硬编码在程序里，每次要刷新就重新编译一遍。
    - • 哪怕是生成一个 DOM，循环的时候 clone 它，然后让 container 去 appendChild，都要比这个来得好，基本可以做到 react 那样不卡（我这里显示是 35ms）。（有趣的是这种做法在 profile 的时候性能急剧下降，不知道为什么）

	for (var i = 0; i < data.length; i++) {
	 var render = template;
	 render = render.replace("{{className}}", "");
	 render = render.replace("{{label}}", data[i].label);
	 html += render;
	}

	container.innerHTML = html;

[发布于 2017-12-08](https://www.zhihu.com/question/31809713/answer/272717698)

[![da8e974dc_l.jpg](../_resources/4d975e132ebfbf1d8b4f22e50800ae92.jpg)](https://www.zhihu.com/people/sharpmaster)

[徐飞](https://www.zhihu.com/people/sharpmaster)

[​![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' class='css-1ifz0go js-evernote-checked' width='18' height='18' data-evernote-id='766'%3e%3csvg viewBox='0 0 24 24' x='-3' y='-3' fill='%23FFFFFF' width='30' height='30'%3e%3cpath d='M3.56231227%2c13.8535307 C2.40051305%2c12.768677 2.41398885%2c11.0669203 3.59484487%2c9.99979213 L3.59222085%2c9.99654885 C4.26730143%2c9.45036719 4.79446755%2c8.21005186 4.7184197%2c7.34453784 L4.72305873%2c7.34412719 C4.66942824%2c5.75539997 5.8824188%2c4.56066914 7.47188965%2c4.64242381 L7.47229112%2c4.6386236 C8.33515314%2c4.72977993 9.58467253%2c4.22534048 10.1426329%2c3.55925173 L10.1462611%2c3.56228565 C11.2316055%2c2.40008701 12.9353108%2c2.41394456 14.0015072%2c3.59634088 L14.0047263%2c3.59374004 C14.5498229%2c4.26841874 15.7896857%2c4.79521622 16.6545744%2c4.71844347 L16.6549836%2c4.72304294 C18.245027%2c4.66894057 19.4396947%2c5.88213996 19.3575031%2c7.47241135 L19.3623099%2c7.47292747 C19.2704388%2c8.3358681 19.7742711%2c9.58421483 20.4407199%2c10.1424506 L20.437686%2c10.1460789 C21.5997217%2c11.2312209 21.5860695%2c12.9345218 20.4042441%2c14.0007396 L20.4072865%2c14.0045125 C19.7325967%2c14.5495925 19.2055209%2c15.7896954 19.2815865%2c16.6561959 L19.2770449%2c16.6565978 C19.3315454%2c18.2453037 18.1173775%2c19.4393568 16.5274188%2c19.3571512 L16.5269029%2c19.3619539 C15.6647098%2c19.270083 14.415408%2c19.7741709 13.8573671%2c20.4403558 L13.8537409%2c20.4373235 C12.76842%2c21.5995708 11.0650432%2c21.5864553 9.99899434%2c20.4039226 L9.99527367%2c20.406923 C9.45025436%2c19.7323399 8.21017638%2c19.2051872 7.34461983%2c19.2812352 L7.344304%2c19.2776405 C5.75448683%2c19.3312904 4.55977145%2c18.1170085 4.64254978%2c16.527117 L4.63769921%2c16.5265942 C4.72957031%2c15.6644394 4.22547659%2c14.4151814 3.55928015%2c13.8571569 L3.56231227%2c13.8535307 Z'%3e%3c/path%3e%3c/svg%3e%3cpath d='M2.63951518%2c13.3895441 C3.70763333%2c14.2842292 4.44777637%2c16.1226061 4.30075305%2c17.5023312 L4.32211542%2c17.3063047 C4.17509209%2c18.6910561 5.17786655%2c19.7063729 6.5613937%2c19.5844846 L6.364106%2c19.6008202 C7.75140298%2c19.4789319 9.57474349%2c20.2554985 10.4468305%2c21.3349009 L10.3224262%2c21.1803415 C11.1982831%2c22.2647703 12.6257916%2c22.2723098 13.5167278%2c21.2079863 L13.3898102%2c21.3600325 C14.2845162%2c20.2919393 16.1229361%2c19.5518136 17.5026934%2c19.6988334 L17.3054057%2c19.6774716 C18.6914461%2c19.8244915 19.7067866%2c18.8217404 19.5836389%2c17.4395022 L19.6012314%2c17.6367853 C19.4793403%2c16.2482641 20.255925%2c14.4249662 21.3353526%2c13.5528995 L21.1807897%2c13.677301 C22.2639871%2c12.8014646 22.2727834%2c11.3739894 21.2084351%2c10.483074 L21.3604848%2c10.6099886 C20.2923667%2c9.71530351 19.5522236%2c7.87818322 19.6992469%2c6.49720154 L19.6778846%2c6.69448464 C19.8249079%2c5.30847665 18.8221335%2c4.2944164 17.4386063%2c4.41630468 L17.635894%2c4.39871256 C16.248597%2c4.52185742 14.4252565%2c3.74529084 13.5531695%2c2.66588842 L13.6775738%2c2.81919121 C12.8017169%2c1.73601905 11.3742084%2c1.72722299 10.4832722%2c2.79154644 L10.6101898%2c2.63950024 C9.71548377%2c3.70759343 7.87706394%2c4.44771919 6.49730661%2c4.30195588 L6.69459432%2c4.32206116 C5.30855394%2c4.17504128 4.29447%2c5.17904888 4.41636114%2c6.56128713 L4.3987686%2c6.36400404 C4.52065973%2c7.75126861 3.74407501%2c9.57456653 2.66464737%2c10.4478898 L2.81921035%2c10.3222318 C1.73601288%2c11.1993248 1.72721662%2c12.6255433 2.79156494%2c13.5164587 L2.63951518%2c13.3895441 Z' fill='%23FF9607'%3e%3c/path%3e%3csvg class='Zi Zi--Star' fill='%23fff' x='6' y='6' viewBox='0 0 24 24' width='12' height='12'%3e%3cpath d='M5.515 19.64l.918-5.355-3.89-3.792c-.926-.902-.639-1.784.64-1.97L8.56 7.74l2.404-4.871c.572-1.16 1.5-1.16 2.072 0L15.44 7.74l5.377.782c1.28.186 1.566 1.068.64 1.97l-3.89 3.793.918 5.354c.219 1.274-.532 1.82-1.676 1.218L12 18.33l-4.808 2.528c-1.145.602-1.896.056-1.677-1.218z' fill-rule='evenodd'%3e%3c/path%3e%3c/svg%3e%3c/svg%3e)](https://www.zhihu.com/topic/20054793)

前端开发等 3 个话题下的优秀回答者

对于使用原生DOM接口操作大片DOM而言：
1. 1. 如果对DOM创建过程稍作优化，首次创建必定比所有框架或者库都快。
2. 2. 如果对DOM变更过程做相对复杂的优化，它会比大多数框架或者库都快。
3. 3. 如果想要DOM的变更过程更快，需要作更加复杂的优化。

很多时候大家讨论某些东西的快慢，是基于完全不优化的方式的，这时候得出一个原生操作更慢的结论也不奇怪。实际上，对于每个框架或者库，对于其中的不同DOM操作类型，基本都存在针对性的优化方式，可以大幅提升性能。

[发布于 2015-07-02](https://www.zhihu.com/question/31809713/answer/53500968)

[![sidebar-download-qrcode.7caef4dd.png](../_resources/7caef4dd36377ef2fb2a1ea9bcb370f7.png)  下载知乎客户端  与世界分享知识、经验和见解](http://zhi.hu/BDXoI)

[广告![v2-d2aee61cf9963be67c4ea8274b2601db_540x450.jpeg](../_resources/0e614d3113dce8c50c028e90c853ff46.jpg)](https://www.zhihu.com/xen/market/ecom-page/1260905243170816000)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' class='Icon Icon--close Pc-card-button-close-svg js-evernote-checked' data-evernote-id='618'%3e%3cpath fill-rule='evenodd' d='M3 2L2 3l3 3-3 3 1 1 3-3 3 3 1-1-3-3 3-3-1-1-3 3'%3e%3c/path%3e%3c/svg%3e)

相关问题
[如何正确、客观地评价 React？](https://www.zhihu.com/question/31613336) 30 个回答
[问一个react更新State的问题？](https://www.zhihu.com/question/66749082) 15 个回答
[学习react 有哪些瓶颈需要克服？](https://www.zhihu.com/question/56689795) 14 个回答
[react-router页面滚动时，页面位置问题？](https://www.zhihu.com/question/41679526) 8 个回答
[react真的好用吗？](https://www.zhihu.com/question/47829384) 8 个回答
相关推荐

[![04d3c071d_250x0.jpg](../_resources/dcc652dc05772f4a3b8aa69326ea96de.jpg)  深入理解React v16新功能  程墨Morgan    ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)](https://www.zhihu.com/lives/896398188230103040)[![04d3c071d_250x0.jpg](../_resources/dcc652dc05772f4a3b8aa69326ea96de.jpg)  帮助你深入理解 React  程墨Morgan    ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)](https://www.zhihu.com/lives/883022235516960768)[![04d3c071d_250x0.jpg](../_resources/dcc652dc05772f4a3b8aa69326ea96de.jpg)  快速了解React的新功能Suspense和Hooks    ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 15 15' fill='currentColor' width='15' height='15'%3e%3cg fill='%23ffab2e' fill-rule='evenodd'%3e%3cpath d='M10.925 14.302c.173.13.408.13.58-.002a.514.514 0 0 0 .175-.572l-1.323-4.296 3.435-2.456c.175-.13.25-.36.185-.572a.5.5 0 0 0-.468-.36H9.275L7.96 1.754c-.064-.21-.21-.354-.46-.354-.14 0-1.027 3.53-.988 6.32.04 2.788.98 3.85.98 3.85l3.433 2.732z'%3e%3c/path%3e%3cpath d='M7.5 1.4a.47.47 0 0 0-.474.354l-1.318 4.29H1.49a.499.499 0 0 0-.467.36.523.523 0 0 0 .185.572l3.42 2.463-1.307 4.286c-.066.21.004.44.176.572.172.13.407.132.58.003l3.42-2.734L7.5 1.4z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)](https://www.zhihu.com/lives/1051824303045246976)

[广告![v2-d2aee61cf9963be67c4ea8274b2601db_540x450.jpeg](../_resources/0e614d3113dce8c50c028e90c853ff46.jpg)](https://www.zhihu.com/xen/market/ecom-page/1260905243170816000)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' class='Icon Icon--close Pc-card-button-close-svg js-evernote-checked' data-evernote-id='619'%3e%3cpath fill-rule='evenodd' d='M3 2L2 3l3 3-3 3 1 1 3-3 3 3 1-1-3-3 3-3-1-1-3 3'%3e%3c/path%3e%3c/svg%3e)

[刘看山](https://liukanshan.zhihu.com/)·[知乎指南](https://www.zhihu.com/question/19581624)·[知乎协议](https://www.zhihu.com/term/zhihu-terms)·[知乎隐私保护指引](https://www.zhihu.com/term/privacy)

[应用](https://www.zhihu.com/app)·[工作](https://app.mokahr.com/apply/zhihu)·

[侵权举报](https://zhuanlan.zhihu.com/p/51068775)·[网上有害信息举报专区](http://www.12377.cn/)

[京 ICP 证 110745 号](https://tsm.miit.gov.cn/dxxzsp/)
[京 ICP 备 13052560 号 - 1](http://www.beian.miit.gov.cn/)

[![v2-d0289dc0a46fc5b15b3363ffa78cf6c7.png](../_resources/a189ff184431df9dd82945e16df93153.png)京公网安备 11010802010035 号](http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010802020088)

互联网药品信息服务资格证书
（京）- 非经营性 - 2017 - 0067违法和不良信息举报：010-82716601
[儿童色情信息举报专区](https://www.zhihu.com/term/child-jubao)
[证照中心](https://www.zhihu.com/certificates)
[联系我们](https://www.zhihu.com/contact) © 2020 知乎
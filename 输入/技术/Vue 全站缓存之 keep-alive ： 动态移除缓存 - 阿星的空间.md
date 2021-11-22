Vue 全站缓存之 keep-alive ： 动态移除缓存 - 阿星的空间

# Vue 全站缓存之 keep-alive ： 动态移除缓存

> 阅读本文之前，默认大家对 vue 和 keep-alive 都很熟悉，所以不再啰嗦相关资料，直接进入正文。
> 有耐心的话，且听我细细道来，如果你遇到过类似问题，或正在寻找解决方案，那么你可以直接翻到文末看结论。

## 前言

以一个记账项目举例，常见的场景有`首页、记到账页面、选择合同、新建合同、选择客户、新建客户`这些页面。![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125427.png)

在这些页面中，很显然，用户的浏览行为应该是逐渐深入的，通俗得讲就是浏览页面在不断前进。
而且这些页面之间还是有互动性存在的，两种互动行为：

- 一. 用户前进时，总是进入新的页面。（比如在合同列表页反复加载多次列表之后，进入其中一个合同详情，再返回时，应该仍停留之前里列表页同一个位置，而不是重新刷新列表页。）
- 二. 用户后退时，需要能保留前一页数据并继续操作。（比如，记到账时需要选择合同，选择合同时可以新建合同，新建合同时填了一堆数据可以去选择客户，在选择客户时又去创建了客户，那么这一堆操作下来应该能够做到：`创建完客户后继续新建合同，建完合同后继续记该合同的到账`）

![jidaozhang.gif](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125436.gif)

上图是 demo 项目中的真实效果，目前常见的 vue 开发方案里，一般都会引入 vuex 或 localStorage ，在各个页面不断的存储和调用页面内的数据，我觉得，**这很不科学很不优雅**。

## keep-alive 什么问题

vue 支持 keep-alive 组件，如果启用，页面内的所有数据都会被保留，所以，上文的互动行为二`后退时保留前一页数据继续操作`没有问题。
问题出在互动行为一`用户前进时总是进入新页面`，然而一旦缓存，你就没法总是进新页面了，你总是进入缓存页，这就很让人头疼了。

官方提供了`include`和`exclude`特性，说你可以决定哪些页面使用缓存哪些页面不用缓存。[链接](https://cn.vuejs.org/v2/api/#keep-alive)

然而问题又回到了原点，并没有解决我们`酌情决定是否使用已缓存的缓存`这一需求。

所以很多人想到了一个方法`在离开页面时销毁这个页面`是不是就可以了，然而并不能，这里出现了 bug ，组件销毁了缓存还在:![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125447.png)

于是，就有人提出`希望keep-alive能增加可以动态删除已缓存组件的功能`，[issue](https://github.com/vuejs/vue/issues/6509)

这是个老话题，之前一直没有进展，核心原因就在于 keep-alive 不能正确处理已销毁的组件。

## 尝试解决这个问题

如果能实现`动态使用缓存`这一功能，那么所有问题也就迎刃而解。
最初，我研究 keep-alive 的代码，发现了这么一段代码：![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125511.png)

于是，我想，如果在此处判断`如果组件已被销毁则不使用缓存`，是不是就解决这个问题了，于是我提交了一个 [PR](https://github.com/vuejs/vue/pull/7151):![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125520.png)

不过这个 PR 迟迟没有通过，我就放弃了。

## 暴力解决这个问题

我继续研究有没有其他方案，然后我在打印组件变量的时候，发现了这么个眼熟的字段：![Snipaste_2018-07-23_15-20-37.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125532.png)

这不就是 keep-alive 的组件嘛，我赶忙点开再看，发现了更眼熟的东东：![Snipaste_2018-07-23_15-23-45.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125959.png)

于是，这事儿就变得简单了，直接按图索骥，咱在销毁组件之前，寻找路由组件所在父级的 keep-alive 组件，操控其中的 cache 列表，强行删除其中的缓存，问题也就迎刃而解，是不是很直接很暴力。

## 结论

keep-alive 默认不支持动态销毁已缓存的组件，所以此处给出的解决方案是通过直接操控 keep-alvie 组件里的 cahce 列表，暴力移除缓存：

	*//使用Vue.mixin的方法拦截了路由离开事件，并在该拦截方法中实现了销毁页面缓存的功能。*
	Vue.mixin({
	    beforeRouteLeave:function(to, from, next){
	        if (from && from.meta.rank && to.meta.rank && from.meta.rank>to.meta.rank)
	        {*//此处判断是如果返回上一层，你可以根据自己的业务更改此处的判断逻辑，酌情决定是否摧毁本层缓存。*
	            if (this.$vnode && this.$vnode.data.keepAlive)
	            {
	                if (this.$vnode.parent && this.$vnode.parent.componentInstance && this.$vnode.parent.componentInstance.cache)
	                {
	                    if (this.$vnode.componentOptions)
	                    {
	                        var key = this.$vnode.key == null
	                                    ? this.$vnode.componentOptions.Ctor.cid + (this.$vnode.componentOptions.tag ? `::${this.$vnode.componentOptions.tag}` : '')
	                                    : this.$vnode.key;
	                        var cache = this.$vnode.parent.componentInstance.cache;
	                        var keys  = this.$vnode.parent.componentInstance.keys;
	                        if (cache[key])
	                        {
	                            if (keys.length) {
	                                var index = keys.indexOf(key);
	                                if (index > -1) {
	                                    keys.splice(index, 1);
	                                }
	                            }
	                            delete cache[key];
	                        }
	                    }
	                }
	            }
	            this.$destroy();
	        }
	        next();
	    },
	});

## 后语

本文主要围绕如何动态删除 keep-alive 缓存这一问题进行探索，其他关于`如何设定页面层级、如何在前后页之间进行数据传递`等问题，敬请期待《Vue 全站缓存之 vue-router-then ：前后页数据传递》。

请继续阅读-系列篇2：[Vue 全站缓存二：如何设计全站缓存](https://wanyaxing.com/blog/20180724141008.html)
原文来自阿星的空间：https://wanyaxing.com/blog/20180723114341.html

 [Vue](https://wanyaxing.com/blog/?tag=Vue)  [Vuex](https://wanyaxing.com/blog/?tag=Vuex)  [VueRouter](https://wanyaxing.com/blog/?tag=VueRouter)

   阅读数：2076
 发表于：2018-07-23 11:43:41

总想写点啥，然而有点忙<s>懒</s>。

程序员之中有大神，更多的当然是普通人。是程序员，都可以有一颗敢想敢做的心，善于思考，勇于行动。希望自己能在这里分享下对项目、框架、脚本、插件、APP、任何事或物的研究或改进之想法，呃，或者也可以聊聊生活聊聊人生。

高楼大厦平地起，咱也想加上一块砖。

我是万亚星，码农一枚。

标签关键字： IT 互联网、架构、 Web 后端开发、 PHP 、 Python、 Nodejs、 Web 前端开发 、 Vue.js 、 Javascript 、 CSS 、 HTML5 、微信公众号、钉钉服务、 MySQL / 数据库、 iOS 和 Android 略懂……

Email : [wyx@wanyaxing.com](https://wanyaxing.com/blog/20180723114341.htmlmailto:wyx@wanyaxing.com)
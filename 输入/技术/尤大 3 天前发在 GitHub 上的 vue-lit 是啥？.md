尤大 3 天前发在 GitHub 上的 vue-lit 是啥？

[(L)](https://juejin.im/user/413072099914717)

[ axuebin   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzM0RDE5QiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYuMzMzIDRMMTcgM3YzaC0yek0xNSA2aDJ2NGgtMnpNMTcgOGgxdjJoLTF6TTE3IDNoMXYyaC0xek0xOCAzaDJ2OGgtMnoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/413072099914717)

2020年09月20日   阅读 12212

# 尤大 3 天前发在 GitHub 上的 vue-lit 是啥？

> 未经授权，不得转载，原文地址：> [> github.com/axuebin/art…](https://github.com/axuebin/articles/issues/41)

## 写在前面

![17d0c8d08b064e7baa535d16ca10a84c~tplv-k3u1fbpfcp-zoom-1.image](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131336.png)

尤大北京时间 9月18日 下午的时候发了一个微博，人狠话不多。看到这个表情，大家都知道有大事要发生。果然，在写这篇文章的时候，上 `GitHub` 上看了一眼，刚好碰上发布：

![a16d2749f1e34cd9bcbd32f9b7bca1c7~tplv-k3u1fbpfcp-zoom-1.image](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131329.png)

我们知道，一般开源软件的 `release` 就是一个 **最终版本**，看一下官方关于这个 `release` 版本的介绍：

> Today we are proud to announce the official release of Vue.js 3.0 "One Piece".

更多关于这个 `release` 版本的信息可以关注：[github.com/vuejs/vue-n…](https://github.com/vuejs/vue-next/releases/tag/v3.0.0)

除此之外，我在尤大的 `GitHub` 上发现了另一个东西 [vue-lit](https://github.com/yyx990803/vue-lit)，直觉告诉我这又是一个啥面向未来的下一代 xxx，所以我就点进去看了一眼是啥新玩具。

## Hello World

> Proof of concept mini custom elements framework powered by @vue/reactivity and lit-html.

看上去是尤大的一个验证性的尝试，看到 `custom element` 和 `lit-html`，盲猜一把，是一个可以直接在浏览器中渲染 `vue` 写法的 `Web Component` 的工具。

> 这里提到了 `lit-html`> ，后面会专门介绍一下。
按照尤大给的 `Demo`，我们来试一下 `Hello World`：

	html<!DOCTYPE html>
	<html lang="en">
	  <head>
	    <script type="module">
	      import {
	        defineComponent,
	        reactive,
	        html,
	        onMounted
	      } from 'https://unpkg.com/@vue/lit@0.0.2';
	
	      defineComponent('my-component', () => {
	        const state = reactive({
	          text: 'Hello World',
	        });
	
	        function onClick() {
	          alert('cliked!');
	        }
	
	        onMounted(() => {
	          console.log('mounted');
	        });
	
	        return () => html`
	          <p>
	            <button @click=${onClick}>Click me</button>
	            ${state.text}
	          </p>
	        `;
	      })
	    </script>
	  </head>
	  <body>
	    <my-component />
	  </body>
	</html>
	复制代码

不用任何编译打包工具，直接打开这个 `index.html`，看上去没毛病：

![f079cde5ec964631b43d417cb1b886af~tplv-k3u1fbpfcp-zoom-1.image](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131341.png)

!

可以看到，这里渲染出来的是一个 `Web Component`，并且 `mounted` 生命周期也触发了。

## 关于 lit-html 和 lit-element

看 `vue-lit` 之前，我们先了解一下 `lit-html` 和 `lit-ement`，这两个东西其实已经出来很久了，可能并不是所有人都了解。

### lit-html

[lit-html](https://lit-html.polymer-project.org/) 可能很多人并不熟悉，甚至没有见过。

![cb60e9f73f5c4cebbfc113caf4c471ae~tplv-k3u1fbpfcp-zoom-1.image](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131409.png)

所以是啥？答案是 **HTML 模板引擎**。

如果没有体感，我问一个问题，`React` 核心的东西有哪些？大家都会回答：`jsx`、`Virtual-DOM`、`diff`，没错，就是这些东西构成了 `UI = f(data)` 的 `React`。

来看看 `jsx` 的语法：

	jsxfunction App() {
	  const msg = 'Hello World';
	  return <div>{msg}</div>;
	}
	复制代码

再看看 `lit-html` 的语法：

	jsfunction App() {
	  const msg = 'Hello World';
	  return html`
	    <div>${msg}</div>
	  `;
	}
	复制代码

我们知道 `jsx` 是需要编译的它的底层最终还是 `createElement`....。而 `lit-html` 就不一样了，它是基于 `tagged template` 的，使得它不用编译就可以在浏览器上运行，并且和 `HTML Template` 结合想怎么玩怎么玩，扩展能力更强，不香吗？

当然，无论是 `jsx` 还是 `lint-html`，这个 `App` 都是需要 `render` 到真实 `DOM` 上。

#### lint-html 实现一个 Button 组件

直接上代码（省略样式代码）：

	html<!DOCTYPE html>
	<html lang="en">
	<head>
	  <script type="module">
	    import { html, render } from 'https://unpkg.com/lit-html?module';
	
	    const Button = (text, props = {
	      type: 'default',
	      borderRadius: '2px'
	    }, onClick) => {
	      // 点击事件
	      const clickHandler = {
	        handleEvent(e) {
	          alert('inner clicked!');
	          if (onClick) {
	            onClick();
	          }
	        },
	        capture: true,
	      };
	
	      return html`
	        <div class="btn btn-${props.type}" @click=${clickHandler}>
	          ${text}
	        </div>
	      `
	    };
	    render(Button('Defualt'), document.getElementById('button1'));
	    render(Button('Primary', { type: 'primary' }, () => alert('outer clicked!')), document.getElementById('button2'));
	    render(Button('Error', { type: 'error' }), document.getElementById('button3'));
	  </script>
	</head>
	<body>
	  <div id="button1"></div>
	  <div id="button2"></div>
	  <div id="button3"></div>
	</body>
	</html>
	复制代码

效果：

![611c541ee7664ede9d6a109db7024dee~tplv-k3u1fbpfcp-zoom-1.image](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131416.png)

#### 性能

`lit-html` 会比 `React` 性能更好吗？这里我没仔细看过源码，也没进行过相关实验，无法下定论。
但是可以大胆猜测一下，`lit-html` 没有使用类 `diff` 算法而是直接基于相同 `template` 的更新，看上去这种方式会更轻量一点。

但是，我们常问的一个问题 “在渲染列表的时候，key 有什么用？”，这个在 `lit-html` 是不是没法解决了。我如果删除了长列表中的其中一项，按照 `lit-html` 的基于相同 `template` 的更新，整个长列表都会更新一次，这个性能就差很多了啊。

> // TODO：埋个坑，以后看

### lit-element

[lit-element](https://lit-element.polymer-project.org/) 这又是啥呢？

![b1c24ef2c3834b849f06fd9e3457c555~tplv-k3u1fbpfcp-zoom-1.image](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131428.png)

关键词：**web components**。
**例子**：

	javascriptimport { LitElement, html } from 'lit-element';
	
	class MyElement extends LitElement {
	  static get properties() {
	    return {
	      msg: { type: String },
	    };
	  }
	  constructor() {
	    super();
	    this.msg = 'Hello World';
	  }
	  render() {
	    return html`
	      <p>${this.msg}</p>
	    `;
	  }
	}
	
	customElements.define('my-element', MyElement);
	复制代码

**效果**：

![c7ccd42c7314489e9a53b936ec198ef7~tplv-k3u1fbpfcp-zoom-1.image](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131434.png)

**结论**：可以用类 `React` 的语法写 `Web Component`。

so, `lit-element` 是一个可以创建 `Web Component` 的 `base class`。分析一下上面的 Demo，`lit-element` 做了什么事情：

1. **static get properties**: 可以 `setter` 的 `state`
2. **constructor**: 初始化 `state`
3. **render**: 通过 `lit-html` 渲染元素，并且会创建 `ShadowDOM`
总之，`lit-element` 遵守 `Web Components` 标准，它是一个 `class`，基于它可以快速创建 `Web Component`。
更多关于如何使用 `lit-element` 进行开发，在这里就不展开说了。

## Web Components

### 浏览器原生能力香吗？

说 `Web Components` 之前我想先问问大家，大家还记得 `jQuery` 吗，它方便的选择器让人难忘。但是后来 `document.querySelector` 这个 `API` 的出现并且广泛使用，大家似乎就慢慢地淡忘了 `jQuery`。

浏览器原生 `API` 已经足够好用，我们并不需要为了操作 `DOM` 而使用 `jQuery`。
[You Dont Need jQuery](https://github.com/nefe/You-Dont-Need-jQuery)
再后来，是不是很久没有直接操作过 `DOM` 了？
是的，由于 `React` / `Vue` 等框架（库）的出现，帮我们做了很多事情，我们可以不用再通过复杂的 `DOM API` 来操作 `DOM`。
我想表达的是，是不是有一天，如果浏览器原生能力足够好用的时候，`React` 等是不是也会像 `jQuery` 一样被浏览器原生能力替代？

### 组件化

像 `React` / `Vue` 等框架（库）都做了同样的事情，在之前浏览器的原生能力是实现不了的，比如创建一个可复用的组件，可以渲染在 `DOM` 中的任意位置。

现在呢？我们似乎可以不使用任意的框架和库，甚至不用打包编译，仅是通过 `Web Components` 这样的浏览器原生能力就可以创建可复用的组件，是不是未来的某一天我们就抛弃了现在所谓的框架和库，直接使用原生 `API` 或者是使用基于 `Web Components` 标准的框架和库来开发了？

> 当然，未来是不可知的
**我不是一个 Web Components 的无脑吹，只不过，我们需要面向未来编程。**
来看看 `Web Components` 的一些主要功能吧。

### Custom elements: 自定义元素

自定义元素顾名思义就是用户可以自定义 `HTML` 元素，通过 `CustomElementRegistry` 的 `define` 来定义，比如：

	javascriptwindow.customElements.define('my-element', MyElement);
	复制代码

然后就可以直接通过 `<my-element />` 使用了。
根据规范，有两种 `Custom elements`：

- **Autonomous custom elements**: 独立的元素，不继承任何 `HTML` 元素，使用时可以直接 `<my-element />`
- **Customized buld-in elements**: 继承自 `HTML` 元素，比如通过 `{ extends: 'p' }` 来标识继承自 `p` 元素，使用时需要 `<p is="my-element"></p>`

两种 `Custom elements` 在实现的时候也有所区别：

	javascript// Autonomous custom elements
	class MyElement extends HTMLElement {
	  constructor() {
	    super();
	  }
	}
	
	// Customized buld-in elements：继承自 p 元素
	class MyElement extends HTMLParagraphElement {
	  constructor() {
	    super();
	  }
	}
	复制代码

[更多关于 Custom elements](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_custom_elements)

### 生命周期函数

在 `Custom elements` 的构造函数中，可以指定多个回调函数，它们将会在元素的不同生命时期被调用。

- **connectedCallback**：元素首次被插入文档 `DOM` 时
- **disconnectedCallback**：元素从文档 `DOM` 中删除时
- **adoptedCallback**：元素被移动到新的文档时
- **attributeChangedCallback**: 元素增加、删除、修改自身属性时

我们这里留意一下 `attributeChangedCallback`，是每当元素的属性发生变化时，就会执行这个回调函数，并且获得元素的相关信息：

	javascriptattributeChangedCallback(name, oldValue, newValue) {
	  // TODO
	}
	复制代码

需要特别注意的是，如果需要在元素**某个属性**变化后，触发 `attributeChangedCallback()` 回调函数，你必须**监听这个属性**：

	javascriptclass MyElement extends HTMLElement {
	  static get observedAttributes() {
	    return ['my-name'];
	  }
	  constructor() {
	    super();
	  }
	}
	复制代码

元素的 `my-name` 属性发生变化时，就会触发回调方法。

### Shadow DOM

`Web Components` 一个非常重要的特性，可以将结构、样式封装在组件内部，与页面上其它代码隔离，这个特性就是通过 `Shadow DOM` 实现。

![974d936580b445d7a1adcc040dd50d44~tplv-k3u1fbpfcp-zoom-1.image](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131443.png)

关于 `Shadow DOM`，这里主要想说一下 `CSS` 样式隔离的特性。`Shadow DOM` 里外的 `selector` 是相互获取不到的，所以也没办法在内部使用外部定义的样式，当然外部也没法获取到内部定义的样式。

这样有什么好处呢？划重点，样式隔离，`Shadow DOM` 通过局部的 `HTML` 和 `CSS`，解决了样式上的一些问题，类似 `vue` 的 `scope` 的感觉，元素内部不用关心 `selector` 和 `CSS rule` 会不会被别人覆盖了，会不会不小心把别人的样式给覆盖了。所以，元素的 `selector` 非常简单：`title` / `item` 等，不需要任何的工具或者命名的约束。

[更多关于 Shadow DOM](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_shadow_DOM)

### Templates: 模板

可以通过 `<template>` 来添加一个 `Web Component` 的 `Shadow DOM` 里的 `HTML` 内容：

	html<body>
	  <template id="my-paragraph">
	    <style>
	      p {
	        color: white;
	        background-color: #666;
	        padding: 5px;
	      }
	    </style>
	    <p>My paragraph</p>
	  </template>
	  <script>
	    customElements.define('my-paragraph',
	      class extends HTMLElement {
	        constructor() {
	          super();
	          let template = document.getElementById('my-paragraph');
	          let templateContent = template.content;
	
	          const shadowRoot = this.attachShadow({mode: 'open'}).appendChild(templateContent.cloneNode(true));
	        }
	      }
	    )
	  </script>
	  <my-paragraph></my-paragraph>
	</body>
	复制代码

效果：

![6f5fd0b3a0fe4d92af074a101520c9bd~tplv-k3u1fbpfcp-zoom-1.image](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131451.png)

我们知道，`<template>` 是不会直接被渲染的，所以我们是不是可以定义多个 `<template>` 然后在自定义元素时根据不同的条件选择渲染不同的 `<template>`？答案当然是：可以。

[更多关于 Templates](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_templates_and_slots)

## vue-lit

介绍了 `lit-html/element` 和 `Web Components`，我们回到尤大这个 `vue-lit`。
首先我们看到在 `Vue 3.0` 的 `Release` 里有这么一段：

> The @vue/reactivity module exports functions that provide direct access to Vue's reactivity system, and can be used as a standalone package. It can be used to pair with other templating solutions (e.g. lit-html) or even in non-UI scenarios.

意思大概就是说 `@vue/reactivity` 模块和类似 `lit-html` 的方案配合，也能设计出一个直接访问 `Vue` 响应式系统的解决方案。
巧了不是，对上了，这不就是 `vue-lit` 吗？

### 源码解析

	javascriptimport { render } from 'https://unpkg.com/lit-html?module'
	import {
	  shallowReactive,
	  effect
	} from 'https://unpkg.com/@vue/reactivity/dist/reactivity.esm-browser.js'
	复制代码

- `lit-html` 提供核心 `render` 能力
- `@vue/reactiity` 提供 `Vue` 响应式系统的能力

这里稍带解释一下 `shallowReactive` 和 `effect`，不展开：
**shallowReactive**：简单理解就是“浅响应”，类似于“浅拷贝”，它仅仅是响应数据的第一层

	javascriptconst state = shallowReactive({
	  a: 1,
	  b: {
	    c: 2,
	  },
	})
	
	state.a++ // 响应式
	state.b.c++ // 非响应式
	复制代码

**effect**：简单理解就是 `watcher`

	javascriptconst state = reactive({
	  name: "前端试炼",
	});
	console.log(state); // 这里返回的是Proxy代理后的对象
	effect(() => {
	  console.log(state.name); // 每当name数据变化将会导致effect重新执行
	});
	复制代码

接着往下看：

	javascriptexport function defineComponent(name, propDefs, factory) {
	  // propDefs
	  // 如果是函数，则直接当作工厂函数
	  // 如果是数组，则监听他们，触发 attributeChangedCallback 回调函数
	  if (typeof propDefs === 'function') {
	    factory = propDefs
	    propDefs = []
	  }
	  // 调用 Web Components 创建 Custom Elements 的函数
	  customElements.define(
	    name,
	    class extends HTMLElement {
	      // 监听 propDefs
	      static get observedAttributes() {
	        return propDefs
	      }
	      constructor() {
	        super()
	        // 创建一个浅响应
	        const props = (this._props = shallowReactive({}))
	        currentInstance = this
	        const template = factory.call(this, props)
	        currentInstance = null
	        // beforeMount 生命周期
	        this._bm && this._bm.forEach((cb) => cb())
	        // 定义一个 Shadow root，并且内部实现无法被 JavaScript 访问及修改，类似 <video> 标签
	        const root = this.attachShadow({ mode: 'closed' })
	        let isMounted = false
	        // watcher
	        effect(() => {
	          if (!isMounted) {
	            // beforeUpdate 生命周期
	            this._bu && this._bu.forEach((cb) => cb())
	          }
	          // 调用 lit-html 的核心渲染能力，参考上文 lit-html 的 Demo
	          render(template(), root)
	          if (isMounted) {
	            // update 生命周期
	            this._u && this._u.forEach((cb) => cb())
	          } else {
	            // 渲染完成，将 isMounted 置为 true
	            isMounted = true
	          }
	        })
	      }
	      connectedCallback() {
	        // mounted 生命周期
	        this._m && this._m.forEach((cb) => cb())
	      }
	      disconnectedCallback() {
	        // unMounted 生命周期
	        this._um && this._um.forEach((cb) => cb())
	      }
	      attributeChangedCallback(name, oldValue, newValue) {
	        // 每次修改 propDefs 里的参数都会触发
	        this._props[name] = newValue
	      }
	    }
	  )
	}
	
	// 挂载生命周期
	function createLifecycleMethod(name) {
	  return (cb) => {
	    if (currentInstance) {
	      ;(currentInstance[name] || (currentInstance[name] = [])).push(cb)
	    }
	  }
	}
	
	// 导出生命周期
	export const onBeforeMount = createLifecycleMethod('_bm')
	export const onMounted = createLifecycleMethod('_m')
	export const onBeforeUpdate = createLifecycleMethod('_bu')
	export const onUpdated = createLifecycleMethod('_u')
	export const onUnmounted = createLifecycleMethod('_um')
	
	// 导出 lit-hteml 和 @vue/reactivity 的所有 API
	export * from 'https://unpkg.com/lit-html?module'
	export * from 'https://unpkg.com/@vue/reactivity/dist/reactivity.esm-browser.js'
	
	复制代码

**简化版有助于理解**
整体看下来，为了更好地理解，我们不考虑生命周期之后可以简化一下：

	javascriptimport { render } from 'https://unpkg.com/lit-html?module'
	import {
	  shallowReactive,
	  effect
	} from 'https://unpkg.com/@vue/reactivity/dist/reactivity.esm-browser.js'
	
	export function defineComponent(name, factory) {
	  customElements.define(
	    name,
	    class extends HTMLElement {
	      constructor() {
	        super()
	        const root = this.attachShadow({ mode: 'closed' })
	        effect(() => {
	          render(factory(), root)
	        })
	      }
	    }
	  )
	}
	复制代码

也就这几个流程：
1. 创建 `Web Components` 的 `Custom Elements`
2. 创建一个 `Shadow DOM` 的 `ShadowRoot` 节点
3. 将传入的 `factory` 和内部创建的 `ShadowRoot` 节点交给 `lit-html` 的 `render` 渲染出来
回过头来看尤大提供的 DEMO：

	javascriptimport {
	  defineComponent,
	  reactive,
	  html,
	} from 'https://unpkg.com/@vue/lit'

	defineComponent('my-component', () => {
	  const msg = 'Hello World'
	  const state = reactive({
	    show: true
	  })
	  const toggle = () => {
	    state.show = !state.show
	  }

	  return () => html`
	    <button @click=${toggle}>toggle child</button>
	    ${state.show ? html`<my-child msg=${msg}></my-child>` : ``}
	  `
	})
	复制代码

`my-component` 是传入的 `name`，第二个是一个函数，也就是传入的 `factory`，其实就是 `lit-html` 的第一个参数，只不过引入了 `@vue/reactivity` 的 `reactive` 能力，把 `state` 变成了响应式。

没毛病，和 `Vue 3.0 Release` 里说的一致，`@vue/reactivity` 可以和 `lit-html` 配合，使得 `Vue` 和 `Web Components` 结合到一块儿了，是不是还挺有意思。

## 写在最后

可能尤大只是一时兴起，写了这个小玩具，但是可以见得这可能真的是一种大趋势。

猜测不久将来这些关键词会突然就爆发：`Unbundled` / `ES Modules` / `Web components` / `Custom Element` / `Shadow DOM`...

是不是值得期待一下？
**思考可能还比较浅，文笔有限，不足之处欢迎大家指出。**

## 招聘

阿里国际化团队基础架构组招聘前端 P6/P7，base 杭州，基础设施建设，业务赋能... 很多事情可以做。
要求熟悉 工程化/ Node/ React... 可直接发送简历至 `yibin.xb@alibaba-inc.com`。
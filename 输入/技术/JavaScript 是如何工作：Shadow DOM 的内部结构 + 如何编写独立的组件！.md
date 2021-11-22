JavaScript 是如何工作：Shadow DOM 的内部结构 + 如何编写独立的组件！

# JavaScript 是如何工作：Shadow DOM 的内部结构 + 如何编写独立的组件！

[[webp](../_resources/a3461d93dd326bfee27233844289c77f.webp)](https://www.jianshu.com/u/349e46bfba30)

[Fundebug](https://www.jianshu.com/u/349e46bfba30)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='275'%3e%3cpath d='M751.144277 307.2l-123.016533-238.933333h159.778133a81.92 81.92 0 0 1 59.1872 25.258666l160.256 167.492267A27.306667 27.306667 0 0 1 987.620011 307.2h-236.475734z m270.506667 111.547733L640.927744 946.039467a27.306667 27.306667 0 0 1-48.128-24.234667L766.504277 375.466667h-56.388266l-170.5984 590.165333a27.306667 27.306667 0 0 1-52.462934 0.034133L315.500544 375.466667H259.112277l174.523734 545.5872a27.306667 27.306667 0 0 1-48.128 24.302933L5.160277 418.747733A27.306667 27.306667 0 0 1 27.346944 375.466667H999.464277a27.306667 27.306667 0 0 1 22.152534 43.281066zM18.301611 261.0176L178.557611 93.525333A81.92 81.92 0 0 1 237.744811 68.266667h159.744L274.506411 307.2H38.030677a27.306667 27.306667 0 0 1-19.729066-46.1824zM453.877077 68.266667h117.896534l122.9824 238.933333H330.894677l122.9824-238.933333z' data-evernote-id='158' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*0.7132019.01.29 09:38:18字数 4,385阅读 3,499

**摘要：** 深入JS系列17。

- 原文：[JavaScript 是如何工作: Shadow DOM 的内部结构+如何编写独立的组件！](https://segmentfault.com/a/1190000018033709)
- 作者：[前端小智](https://segmentfault.com/a/1190000017794020)

**[Fundebug](https://www.fundebug.com/)经授权转载，版权归原作者所有。**
这是专门探索 JavaScript 及其所构建的组件的系列文章的第 17 篇。
如果你错过了前面的章节，可以在这里找到它们：

- [JavaScript 是如何工作的：引擎，运行时和调用堆栈的概述！](https://segmentfault.com/a/1190000017352941)
- [JavaScript 是如何工作的：深入V8引擎&编写优化代码的5个技巧！](https://segmentfault.com/a/1190000017369465)
- [JavaScript 是如何工作的：内存管理+如何处理4个常见的内存泄漏！](https://segmentfault.com/a/1190000017392370)
- [JavaScript 是如何工作的：事件循环和异步编程的崛起+ 5种使用 async/await 更好地编码方式！](https://segmentfault.com/a/1190000017419328)
- [JavaScript 是如何工作的：深入探索 websocket 和HTTP/2与SSE +如何选择正确的路径！](https://segmentfault.com/a/1190000017448270)
- [JavaScript 是如何工作的：与 WebAssembly比较 及其使用场景！](https://segmentfault.com/a/1190000017485968)
- [JavaScript 是如何工作的：Web Workers的构建块+ 5个使用他们的场景!](https://segmentfault.com/a/1190000017578650)
- [JavaScript 是如何工作的：Service Worker 的生命周期及使用场景!](https://segmentfault.com/a/1190000017749922)
- [JavaScript 是如何工作的：Web 推送通知的机制!](https://segmentfault.com/a/1190000017794020?_ea=6014340#articleHeader0)
- [JavaScript是如何工作的：使用 MutationObserver 跟踪 DOM 的变化!](https://segmentfault.com/a/1190000017832686)
- [JavaScript是如何工作的：渲染引擎和优化其性能的技巧!](https://segmentfault.com/a/1190000017872125#articleHeader0)
- [JavaScript是如何工作的：深入网络层 + 如何优化性能和安全!](https://segmentfault.com/a/1190000017903157)
- [JavaScript是如何工作的：CSS 和 JS 动画底层原理及如何优化它们的性能！](https://segmentfault.com/a/1190000017927665)
- [JavaScript的如何工作的：解析、抽象语法树（AST）+ 提升编译速度5个技巧!](https://segmentfault.com/a/1190000017961297)
- [JavaScript是如何工作的：深入类和继承内部原理+Babel和 TypeScript 之间转换!](https://segmentfault.com/a/1190000017992671)
- [JavaScript是如何工作的：存储引擎+如何选择合适的存储API!](https://segmentfault.com/a/1190000018020391)

![3973862-3d638c4dcb4b0483.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108142250.png)
image

### 概述

Web Components 是一套不同的技术，允许你创建可重用的定制元素，它们的功能封装在你的代码之外，你可以在 Web 应用中使用它们。
Web组件由四部分组成:

- Shadow DOM（影子DOM）
- HTML templates（HTML模板）
- Custom elements（自定义元素）
- HTML Imports（HTML导入）

在本文中主要讲解 **Shadow DOM（影子DOM）**
Shadow DOM 这款工具旨在构建基于组件的应用。因此，可为网络开发中的常见问题提供解决方案：

- **隔离 DOM**：组件的 DOM 是独立的（例如，document.querySelector() 不会返回组件 shadow DOM 中的节点）。
- **作用域 CSS**：shadow DOM 内部定义的 CSS 在其作用域内。样式规则不会泄漏，页面样式也不会渗入。
- **组合**：为组件设计一个声明性、基于标记的 API。
- **简化 CSS** - 作用域 DOM 意味着您可以使用简单的 CSS 选择器，更通用的 id/类名称，而无需担心命名冲突。

### Shadow DOM

本文假设你已经熟悉 DOM 及其它的 Api 的概念。如果不熟悉，可以在这里阅读关于它的详细文章—— [https://developer.mozilla.org...](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction)。

阴影 DOM 只是一个普通的 DOM，除了两个区别:

- 创建/使用的方式
- 与页面其他部分有关的行为方式

通常，你创建 DOM 节点并将其附加至其他元素作为子项。 借助于 shadow DOM，您可以创建作用域 DOM 树，该 DOM 树附加至该元素上，但与其自身真正的子项分离开来。这一作用域子树称为影子树。被附着的元素称为影子宿主。 您在影子中添加的任何项均将成为宿主元素的本地项，包括 `<style>`。 这就是 shadow DOM 实现 CSS 样式作用域的方式

通常，创建 DOM 节点并将它们作为子元素追加到另一个元素中。借助于 shadow DOM，创建一个作用域 DOM 树，附该 DOM 树附加到元素上，但它与实际的子元素是分离的。这个作用域的子树称为 **影子树**，被附着的元素称为**影子宿主**。向影子树添加的任何内容都将成为宿主元素的本地元素，包括 `<style>`，这就是 影子DOM 实现 CSS 样式作用域的方式。

### 创建 shadow DOM

**影子根**是附加到“宿主”元素的文档片段，元素通过附加影子根来获取其 shadow DOM。要为元素创建阴影 DOM，调用 `element.attachShadow()` :

	var header = document.createElement('header');
	var shadowRoot = header.attachShadow({mode: 'open'});
	var paragraphElement = document.createElement('p');
	
	paragraphElement.innerText = 'Shadow DOM';
	shadowRoot.appendChild(paragraphElement);
	123456

[规范](http://w3c.github.io/webcomponents/spec/shadow/#h-methods)定义了元素列表，这些元素无法托管影子树，元素之所以在所选之列，其原因如下：

- 浏览器已为该元素托管其自身的内部 shadow DOM（`<textarea>`、`<input>`）。
- 让元素托管 shadow DOM 毫无意义 (`<img>`)。

例如，以下方法行不通：

	document.createElement('input').attachShadow({mode: 'open'});
	// Error. `<input>` cannot host shadow dom.
	12

### Light DOM

这是组件用户写入的标记。该 DOM 不在组件 shadow DOM 之内，它是元素的实际孩子。假设已经创建了一个名为`<extended-button>` 的定制组件，它扩展了原生 HTML 按钮组件，此时希望在其中添加图像和一些文本。代码如下:

	<extended-button>
	  <!-- the image and span are extended-button's light DOM -->
	  <img src="boot.png" slot="image">
	  <span>Launch</span>
	</extended-button>
	12345

**“extension -button”** 是定义的定制组件，其中的 HTML 称为 **Light DOM**，该组件由用户自己添加。

这里的 Shadow DOM 是你创建的组件 `extension-button`。Shadow DOM是 组件的本地组件，它定义了组件的内部结构、作用域 CSS 和 封装实现细节。

### 扁平 DOM 树

浏览器将用户创建的 Light DOM 分发到 Shadow DOM，并对最终产品进行渲染。扁平树是最终在 DevTools 中看到的以及页面上呈渲染的对象。

	<extended-button>
	  #shadow-root
	  <style>…</style>
	  <slot name="image">
	    <img src="boot.png" slot="image">
	  </slot>
	  <span id="container">
	    <slot>
	      <span>Launch</span>
	    </slot>
	  </span>
	</extended-button>
	123456789101112

### 模板 (Templates)

如果需要 Web 页面上重复使用相同的标签结构时，最好使用某种类型的模板，而不是一遍又一遍地重复相同的结构。这在以前也是可以实现，但是 HTML `<template>` 元素(在现代浏览器中得到了很好的支持)使它变得容易得多。此元素及其内容不在 DOM 中渲染，但可以使用 JavaScript 引用它。

一个简单的例子:

	<template id="my-paragraph">
	  <p> Paragraph content. </p>
	</template>
	123

这不会出现在页面中，直到使用 JavaScrip t引用它，然后使用如下方式将其追加到 DOM 中:

	var template = document.getElementById('my-paragraph');
	var templateContent = template.content;
	document.body.appendChild(templateContent);
	123

到目前为止，已经有其他技术可以实现类似的行为，但是，正如前面提到的，将其原生封装起来是非常好的，Templates 也有相当不错的浏览器支持:

![3973862-955d0996cc624b93.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108142325.png)
image

模板本身是有用的，但它们与自定义元素配合会更好。 可以 `customElement` Api 能定义一个自定义元素，并且告知 HTML 解析器如何正确地构造一个元素，以及在该元素的属性变化时执行相应的处理。

让我们定义一个 Web 组件名为 `<my-paragraph>`，该组件使用之前模板作为它的 Shadow DOM 的内容：

	customElements.define('my-paragraph',
	 class extends HTMLElement {
	   constructor() {
	     super();
	
	     let template = document.getElementById('my-paragraph');
	     let templateContent = template.content;
	     const shadowRoot = this.attachShadow({mode: 'open'}).appendChild(templateContent.cloneNode(true));
	  }
	});
	12345678910

这里需要注意的关键点是，我们向影子根添加了模板内容的克隆，影子根是使用 [Node.cloneNode()](https://developer.mozilla.org/en-US/docs/Web/API/Node/cloneNode) 方法创建的。

因为将其内容追加到一个 Shadow DOM 中，所以可以在模板中使用 [(L)](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/style) 元素的形式包含一些样式信息，然后将其封装在自定义元素中。如果只是将其追加到标准 DOM 中，它是无法工作。

例如，可以将模板更改为:

	<template id="my-paragraph">
	  <style>
	    p {
	      color: white;
	      background-color: #666;
	      padding: 5px;
	    }
	  </style>
	  <p>Paragraph content. </p>
	</template>
	12345678910

现在自定义组件可以这样使用:

	<my-paragraph></my-paragraph>
	1

### <slot> 元素

模板有一些缺点，主要是静态内容，它不允许我们渲染变量/数据，好可以让我们按照一般使用的标准 HTML 模板的习惯来编写代码。**Slot** 是组件内部的占位符，用户可以使用自己的标记来填充。让我们看看上面的模板怎么使用 `slot` ：

	<template id="my-paragraph">
	  <p>
	    <slot name="my-text">Default text</slot>
	  </p>
	</template>
	12345

如果在标记中包含元素时没有定义插槽的内容，或者浏览器不支持插槽，`<my-paragraph>` 就只展示文本 **“Default text”**。
为了定义插槽的内容，应该在 `<my-paragraph>` 元素中包含一个 HTML 结构，其中的 slot 属性的值为我们定义插槽的名称：

	<my-paragraph>
	 <span slot="my-text">Let's have some different text!</span>
	</my-paragraph>
	123

可以插入插槽的元素称为 [Slotable](https://developer.mozilla.org/en-US/docs/Web/API/Slotable); 当一个元素插入一个插槽时，它被称为开槽 (slotted)。

注意，在上面的例子中，插入了一个 `<span>` 元素，它是一个开槽元素，它有一个属性 `slot`，它等于 `my-text`，与模板中的 `slot` 定义中的 `name` 属性的值相同。

在浏览器中渲染后，上面的代码将构建以下扁平 DOM 树:

	<my-paragraph>
	  #shadow-root
	  <p>
	    <slot name="my-text">
	      <span slot="my-text">Let's have some different text!</span>
	    </slot>
	  </p>
	</my-paragraph>
	12345678

### 设定样式

使用 shadow DOM 的组件可通过主页来设定样式，定义其自己的样式或提供钩子（以 [CSS 自定义属性](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_variables)的形式）让用户替换默认值。

**代码部署后可能存在的BUG没法实时知道，事后为了解决这些BUG，花了大量的时间进行log 调试，这边顺便给大家推荐一个好用的BUG监控工具 [Fundebug](https://www.fundebug.com/?utm_source=xiaozhi)。**

### 组件定义的样式

作用域 CSS 是 Shadow DOM 最大的特性之一:

- 外部页面的 CSS 选择器不应用于组件内部
- 组件内定义的样式不会影响页面的其他元素，它们的作用域是宿主元素

shadow DOM 内部使用的 CSS 选择器在本地应用于组件实际上，这意味着我们可以再次使用公共vid/类名，而不用担心页面上其他地方的冲突,最佳做法是在 Shadow DOM 内使用更简单的 CSS 选择器,它们在性能上也不错。

看看在 #shadow-root 定义了一些样式的:

	#shadow-root
	<style>
	  #container {
	    background: white;
	  }
	  #container-items {
	    display: inline-flex;
	  }
	</style>
	
	<div id="container"></div>
	<div id="container-items"></div>
	123456789101112

上面例子中的所有样式都是#shadow-root的本地样式。使用<link>元素在#shadow-root中引入样式表，这些样式表也都属于本地的。

### :host 伪类选择器

使用 `:host` 伪类选择器，用来选择组件宿主元素中的元素 (相对于组件模板内部的元素)。

	<style>
	  :host {
	    display: block; /* by default, custom elements are display: inline */
	  }
	</style>
	12345

当涉及到 `:host` 选择器时，应该小心一件事:父页面中的规则具有比元素中定义的 `:host` 规则具有更高的优先级，这允许用户从外部覆盖顶级样式。而且 `:host` 只在影子根目录下工作，所以你不能在Shadow DOM 之外使用它。

如果 `:host(<selector>)` 的函数形式与 `<selector>` 匹配，你可以指定宿主，对于你的组件而言，这是一个很好的方法，它可让你基于宿主将对用户互动或状态的反应行为进行封装，或对内部节点进行样式设定：

	<style>
	  :host {
	    opacity: 0.4;
	  }
	
	  :host(:hover) {
	    opacity: 1;
	  }
	
	  :host([disabled]) { /* style when host has disabled attribute. */
	    background: grey;
	    pointer-events: none;
	    opacity: 0.4;
	  }
	
	  :host(.pink) > #tabs {
	    color: pink; /* color internal #tabs node when host has class="pink". */
	  }
	</style>
	12345678910111213141516171819

### :host-context(<selector>)

`:host-context(<selector>)` 或其任意父级与 <selector> 匹配，它将与组件匹配。 例如，在文档的元素上可能有一个用于表示样式主题 (theme) 的 CSS 类，而我们应当基于它来决定组件的样式。

比如，很多人都通过将类应用到 <html> 或 <body> 进行主题化：

	<body class="lightheme">
	  <custom-container>
	  …
	  </custom-container>
	</body>
	12345

在下面的例子中，只有当某个祖先元素有 CSS 类theme-light时，我们才会把background-color样式应用到组件内部的所有元素中：

	:host-context(.theme-light) h2 {
	  background-color: #eef;
	}
	123

#### **/deep/**

组件样式通常只会作用于组件自身的 HTML 上，我们可以使用 `/deep/` 选择器，来强制一个样式对各级子组件的视图也生效，它不但作用于组件的子视图，也会作用于组件的内容。

在下面例子中，我们以所有的元素为目标，从宿主元素到当前元素再到 DOM 中的所有子元素：

	:host /deep/ h3 {
	  font-style: italic;
	}
	123

`/deep/` 选择器还有一个别名 `>>>`，可以任意交替使用它们。
`/deep/`>  和 `>>>`>  选择器只能被用在**> 仿真 (emulated)**> 模式下。 这种方式是默认值，也是用得最多的方式。

### 从外部为组件设定样式

有几种方法可从外部为组件设定样式：最简单的方法是使用标记名称作为选择器，如下

	custom-container {
	  color: red;
	}
	123

**外部样式比在 Shadow DOM 中定义的样式具有更高的优先级。**
例如，如果用户编写选择器:

	custom-container {
	  width: 500px;
	}
	123

它将覆盖组件的样式:

	:host {
	  width: 300px;
	}
	123

对组件本身进行样式化只能到此为止。但是如果人想要对组件的内部进行样式化，会发生什么情况呢？为此，我们需要 CSS 自定义属性。

### 使用 CSS 自定义属性创建样式钩子

如果组件的开发者通过 [CSS 自定义属性](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_variables)提供样式钩子，则用户可调整内部样式。其思想类似于`<slot>`，但适用于样式。

看看下面的例子：

	<!-- main page -->
	<style>
	  custom-container {
	    margin-bottom: 60px;
	     - custom-container-bg: black;
	  }
	</style>
	
	<custom-container background>…</custom-container>
	123456789

在其 shadow DOM 内部：

	:host([background]) {
	  background: var( - custom-container-bg, #CECECE);
	  border-radius: 10px;
	  padding: 10px;
	}
	12345

在本例中，该组件将使用 black 作为背景值，因为用户指定了该值，否则，背景颜色将采用默认值 `#CECECE`。
> 作为组件的作者，是有责任让开发人员了解他们可以使用的 CSS 定制属性，将其视为组件的公共接口的一部分。

### 在 JS 中使用 slot

Shadow DOM API 提供了使用 slot 和分布式节点的实用程序，这些实用程序在编写自定义元素时迟早派得上用场。

### slotchange 事件

当 `slot` 的分布式节点发生变化时，`slotchange` 事件将触发。例如，如果用户从 light DOM 中添加/删除子元素。

	var slot = this.shadowRoot.querySelector('#some_slot');
	slot.addEventListener('slotchange', function(e) {
	  console.log('Light DOM change');
	});
	1234

要监视对 light DOM 的其他类型的更改，可以在元素的构造函数中使用 `MutationObserver`。以前讨论过 [MutationObserver 的内部结构以及如何使用它](https://segmentfault.com/a/1190000017832686)。

### assignedNodes() 方法

有时候，了解哪些元素与 slot 相关联非常有用。调用 `slot.assignedNodes()` 可查看 slot 正在渲染哪些元素。 `{flatten: true}` 选项将返回 slot 的备用内容（前提是没有分布任何节点）。

让我们看看下面的例子:

	<slot name=’slot1’><p>Default content</p></slot>
	1

假设这是在一个名为 `<my-container>` 的组件中。
看看这个组件的不同用法，以及调用 `assignedNodes()` 的结果是什么:
在第一种情况下，我们将向 `slot` 中添加我们自己的内容:

	<my-container>
	  <span slot="slot1"> container text </span>
	</my-container>
	123

调用 `assignedNodes()` 会得到 `[<span slot= " slot1 " > container text </span>]`，注意，结果是一个节点数组。

在第二种情况下，将内容置空:

	<my-container> </my-container>
	1

调用 `assignedNodes()` 的结果将返回一个空数组 `[]`。
在第三种情况下，调用 `slot.assignedNodes({flatten: true})`，得到结果是: `[<p>默认内容</p>]`。
此外，要访问 `slot` 中的元素，可以调用 `assignedNodes()` 来查看元素分配给哪个组件 `slot`。

### 事件模型

值得注意的是，当发生在 Shadow DOM 中的事件冒泡时，会发生什么。

当事件从 Shadow DOM 中触发时，其目标将会调整为维持 Shadow DOM 提供的封装。也就是说，事件的目标重新进行了设定，因此这些事件看起来像是来自组件，而不是来自 Shadow DOM 中的内部元素。

下面是从 Shadow DOM 传播出去的事件列表(有些没有):

- **聚焦事件：**blur、focus、focusin、focusout
- **鼠标事件：**click、dblclick、mousedown、mouseenter、mousemove，等等
- **滚轮事件：**wheel
- **输入事件：**beforeinput、input
- **键盘事件：**keydown、keyup
- **组合事件：**compositionstart、compositionupdate、compositionend
- **拖放事件：**dragstart、drag、dragend、drop，等等

### 自定义事件

默认情况下，自定义事件不会传播到 Shadow DOM 之外。如果希望分派自定义事件并使其传播，则需要添加 `bubbles: true` 和 `composed: true` 选项。

让我们看看派发这样的事件是什么样的:

	var container = this.shadowRoot.querySelector('#container');
	container.dispatchEvent(new Event('containerchanged', {bubbles: true, composed: true}));
	12

#### 浏览器支持

如希望获得 shadow DOM 检测功能，请查看是否存在 attachShadow：

	const supportsShadowDOMV1 = !!HTMLElement.prototype.attachShadow;
	1

![3973862-136997dd93bc7864.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108142335.png)
image

有史以来第一次，我们拥有了实施适当 CSS 作用域、DOM 作用域的 API 原语，并且有真正意义上的组合。 与自定义元素等其他网络组件 API 组合后，shadow DOM 提供了一种编写真正封装组件的方法，无需花多大的功夫或使用如 `<iframe>` 等陈旧的东西。

### 关于Fundebug

[Fundebug](https://www.fundebug.com/)专注于JavaScript、微信小程序、微信小游戏、支付宝小程序、React Native、Node.js和Java线上应用实时BUG监控。 自从2016年双十一正式上线，Fundebug累计处理了9亿+错误事件，付费客户有Google、360、金山软件、百姓网等众多品牌企业。欢迎大家[免费试用](https://www.fundebug.com/team/create)！

[图片上传失败...(image-a6bff-1548725834164)]

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='1663'%3e%3cpath d='M728.064 343.943529c-17.648941-2.891294-23.552-20.239059-26.503529-28.912941V104.026353C701.560471 46.200471 654.396235 0 595.425882 0c-53.007059 0-97.28 40.478118-106.134588 89.569882-29.997176 184.862118-138.541176 255.457882-217.630118 280.937412a26.142118 26.142118 0 0 0-18.130823 24.877177v560.067764c0 19.817412 16.022588 35.84 35.84 35.84h535.973647c56.018824-11.565176 94.328471-31.804235 120.892235-86.738823l120.832-416.105412c23.552-75.173647-14.757647-147.395765-100.231529-144.564706h-238.772706z m-571.813647 31.744H76.619294C35.358118 375.687529 0 410.383059 0 450.861176v462.426353c0 43.369412 32.406588 78.004706 76.619294 78.004706h79.631059c27.708235 0 50.115765-22.407529 50.115765-50.115764V425.863529a50.115765 50.115765 0 0 0-50.115765-50.115764z' data-evernote-id='152' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

5人点赞*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='64 64 896 896' focusable='false' class='js-evernote-checked' data-icon='right' width='1em' height='1em' fill='currentColor' aria-hidden='true' data-evernote-id='1667'%3e%3cpath d='M765.7 486.8L314.9 134.7A7.97 7.97 0 0 0 302 141v77.3c0 4.9 2.3 9.6 6.1 12.6l360 281.1-360 281.1c-3.9 3-6.1 7.7-6.1 12.6V883c0 6.7 7.7 10.4 12.9 6.3l450.8-352.1a31.96 31.96 0 0 0 0-50.4z' data-evernote-id='1668' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='1672'%3e%3cpath d='M771.413333 668.728889c-18.773333 3.015111-25.031111 20.878222-28.16 29.866667v217.884444c0 59.733333-49.948444 107.52-112.412444 107.52a115.427556 115.427556 0 0 1-112.412445-92.558222c-31.857778-190.919111-146.830222-263.850667-230.627555-290.133334a27.420444 27.420444 0 0 1-19.228445-26.168888V37.944889C268.572444 17.066667 285.582222 0 306.631111 0h567.864889c59.335111 11.946667 99.953778 32.824889 128 89.543111l128.113778 429.909333c24.974222 77.653333-15.644444 152.291556-106.211556 149.276445H771.413333z m-605.866666-32.824889H81.180444C37.546667 635.904 0 600.064 0 558.250667V80.611556C0 35.84 34.360889 0 81.180444 0H165.546667c29.297778 0 53.077333 23.779556 53.077333 53.077333v529.749334a53.077333 53.077333 0 0 1-53.077333 53.077333z' data-evernote-id='131' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

[*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='1677'%3e%3cpath d='M178.390055 120.591045C111.268624 120.591045 56.888889 174.401955 56.888889 240.556383V903.97778C56.888889 970.302855 111.097977 1024 178.390055 1024h545.731364c67.121431 0 121.558049-53.81091 121.558049-120.02222V240.613265c0-66.268192-54.209088-120.02222-121.558049-120.02222H178.390055z m455.117432 301.136319H269.06087a30.147761 30.147761 0 0 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z m303.18409 301.136318a30.318409 30.318409 0 0 1-30.375291-30.318409V180.317742c0-66.268192-53.81091-120.02222-121.330519-120.022219H329.697688a30.147761 30.147761 0 0 1 0-60.23864l454.946784 0.056882C885.326618 0.113765 967.009987 80.887013 967.009987 180.602155v511.943118a30.318409 30.318409 0 0 1-30.31841 30.318409z m-303.18409-120.47728H269.06087a30.147761 30.147761 0 1 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z' data-evernote-id='142' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*Fundebug 博客](https://www.jianshu.com/nb/8233963)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='1683'%3e%3cpath d='M232.727273 579.87878833C271.28679 579.87878833 302.545455 548.62012233 302.545455 510.06060633 302.545455 471.50108933 271.28679 440.24242433 232.727273 440.24242433 194.167756 440.24242433 162.909091 471.50108933 162.909091 510.06060633 162.909091 548.62012233 194.167756 579.87878833 232.727273 579.87878833ZM512 579.87878833C550.559516 579.87878833 581.818182 548.62012233 581.818182 510.06060633 581.818182 471.50108933 550.559516 440.24242433 512 440.24242433 473.440484 440.24242433 442.181818 471.50108933 442.181818 510.06060633 442.181818 548.62012233 473.440484 579.87878833 512 579.87878833ZM791.272727 579.87878833C829.832243 579.87878833 861.090909 548.62012233 861.090909 510.06060633 861.090909 471.50108933 829.832243 440.24242433 791.272727 440.24242433 752.713211 440.24242433 721.454545 471.50108933 721.454545 510.06060633 721.454545 548.62012233 752.713211 579.87878833 791.272727 579.87878833Z' data-evernote-id='162' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

"Debug就用Fundebug!"
还没有人赞赏，支持一下

[[webp](../_resources/96eb0990fbc22c0f30edee14809cd8a9.webp)](https://www.jianshu.com/u/349e46bfba30)

[Fundebug](https://www.jianshu.com/u/349e46bfba30)一行代码搞定BUG监控！https://www.fundebug.com/

总资产699 (约67.76元)共写了80.7W字获得7,724个赞共1,850个粉丝
微前端乾坤使用过程中的坑_puyahua的专栏-CSDN博客

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' style='display: none%3b' data-evernote-id='1346' class='js-evernote-checked'%3e %3cpath stroke-linecap='round' d='M5%2c0 0%2c2.5 5%2c5z' id='raphael-marker-block' style='-webkit-tap-highlight-color: rgba(0%2c 0%2c 0%2c 0)%3b' data-evernote-id='1347' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)

# 微前端乾坤使用过程中的坑

乾坤在启动子应用的时候默认开启沙箱模式`{sandbox: true}`，这样的情况下，乾坤节点下会生成一个 [shadow dom](https://developer.mozilla.org/zh-CN/docs/Web/Web_Components/Using_shadow_DOM)，shadow dom 内的样式与外部样式是没有关联的，这样就会给子应用内的样式带来一系列问题。这其中很多问题并不是乾坤造成的，而是 shadow dom 本身的特性导致的，乾坤还是不错的（不背锅）。随时补充

### 1.iconffont 字体在子应用无法加载

原因：shadow dom 是不支持@font-face 的，所以当引入 iconfont 的时候，尽管可以引入样式，但由于字体文件是不存在的，所以相对应的图标也无法展示。

相关链接：[@font-face doesn’t work with Shadow DOM?](https://github.com/mdn/interactive-examples/issues/887#issuecomment-432606925)，[Icon Fonts in Shadow DOM](https://stackoverflow.com/questions/28794189/icon-fonts-in-shadow-dom)

方案：

1. 把字体文件放在主应用加载
2. 使用通用的字体文件

### 2.dom的查询方法找不到指定的元素

原因：shadow dom 内的元素是被隔离的元素，故 document下查询的方法例如，querySelector、getElementsById 等是获取不到 shadow dom 内元素的。

方案：代理 document 下各个查询元素的方法，使用子应用传入的容器，即外面的 shadow dom一层查询。具体使用可以参考乾坤的这个方法 [initGlobalState](https://qiankun.umijs.org/zh/api#initglobalstatestate)。

### 3.组件库动态创建的元素无法使用自己的样式

原因：有些对话框或提示窗是通过`document.body.appendChild`添加的，所以 shadow dom 内引入的 CSS 是无法作用到外面元素的。

方案：代理`document.body.appendChild`方法，即把新加的元素添加到 shadow dom容器下，而不是最外面的 body节点下。

**补充：** 类似的问题都可以往这个方向靠，看是不是shadow dom节点或者dom方法的问题。

### 4.第三方引入的 JS 不生效

原因：有些 JS 文件本身是个立即执行函数，或者会动态的创建 scipt 标签，但是所有获取资源的请求是被乾坤劫持处理，所以都不会正常执行，也不会在 window 下面挂载相应的变量，自然在取值调用的时候也不存在这个变量。

方案：参考乾坤的 issue，[子应用向body添加script标签失败](https://github.com/umijs/qiankun/issues/812)

### 5.webpack-dev-server 代理访问的接口 cookie 丢失

原因：在主应用的端口下请求子应用的端口，存在跨域，axios 默认情况下跨域是不携带 cookie 的，假如把 axios 的 `withCredential`设置为 true（表示跨域携带 cookie），那么子应用需要设置跨域访问头`Access-Control-Allow-Origin`（在 devServer 下配置 header）为指定的域名，但不能设置为*，这时候同时存在主应用和子应用端口发出的请求，而跨域访问头只能设置一个地址，就导致无法代理指定服务器接口。

方案：子应用接口请求的端口使用主应用接口请求的端口，使用主应用的配置代理请求

	*// 主应用*

	devServer: {
	    ...
		port: 9600
	    proxy: {
			*// 代理配置*
	    }
	}

	*// 子应用*
	devServer: {
	    ...
		port: 9600, *// 使用主应用的页面访问端口*
	}

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15
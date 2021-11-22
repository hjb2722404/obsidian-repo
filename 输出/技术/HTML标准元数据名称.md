
## 是什么

标准元数据名称是在HTML的`<meta>` 标签中定义的`name` 属性的可选名称，`name`属性包含两种类型：
* 标准名称。这是规范中定义的，所有浏览器都能够明白其所指称的名称
* 自定义名称。由网页作者自己定义的名称。

这里所说的标准元数据名称就是上述第一种。

##  都有哪些

### 1. HTML规范中定义的标准名称

* `application-name`  网页中所运行的应用名称。（注意不同于`<title>标签`）
* `author`： 文档作者的名字
* `description`：对页面内容的描述，一些浏览器将其作为书签的默认描述。
* `generator`： 生成此页面的软件的标识符
* `keywords`： 与页面内容相关的关键词，使用逗号分割。
* `referrer`： 控制由当前文档发出的请求的HTTP Referer请求头

####  referrer的可选值

* `no-referrer`： 不发送HTTP Referer请求头
* `origin`： 只发送当前文档的`origin`
* `no-referrer-when-downgrade`: 
	* 如果请求目标比当前页面一样安全或更加安全，则发送完整URL
	* 如果目标页面比当前页面更加不安全，则不发送`referrer`【这是默认行为】
* `origin-when-cross-origin`：对同源请求发送完整URL（不含参数），其他情况只发送`origin`
* `same-origin`： 对同源请求发送完整URL（不含参数），其他情况，不发送`referrer`请求头
* `strict-origin`： 
	* 如果请求目标与当前页面一样或更加安全，发送 `origin`
	* 如果请求目标不如当前页面安全，不发送`referrer`
* `strict-origin-when-cross-origin`：
	* 对同源请求发送完整URL（不含参数）
	* 其他情况
		* 如果请求目标与当前页面一样或更加安全，发送`origin`
		* 如果请求目标不如当前页面安全，则不发送`referrer`
* `unsafe-URL`：对同源请求和跨源请求发送完整URL（不含参数）


### 2. CSS颜色调整规范中定义的标准名称

* `color-scheme` ： 指定与当前文档兼容的配色方案，它的可选值有：
	* `normal`：未指定配色方案，应当仅使用默认配色方案进行渲染
	* `[light | dark]+`：文档支持的一种或多种配色方案，优先第一种。
	* `only light`：仅支持浅色模式（浅色背景，深色前景）

### 3. CSS设备适配规范定义的标准名称
#### viewport
* `viewport`：为视口的初始大小提供指示，目前仅用于移动设备，其可选的值有：
	* `width`：定义视口的宽度，可能的值：
		* 一个正整数。（此时单位为像素）
		* 一个字符串。（带单位的CSS宽度值）
		* `device-width` 表示与设备宽度一致
	* `height`： 定义`viewport`的高度，未被任浏览器使用，不介绍值了
	* `initial-scale`：定义设备宽度（与横竖屏相关）与视口大小之间的比例
		* 是一个`0.0-10.0`之间的【正数】；
	* `maximum-scale`： 定义缩放的最大值，必须大于等于`minimum-scale`
		* 是一个`0.0-10.0`之间的【正数】；
	* `minimum-scale`：定义缩放的最小值，必须小于等于`maximum-scale`
		* 是一个`0.0-10.0`之间的【正数】；
	* `user-scalable`：用户是否可以缩放当前页面
		* `yes` 或 `no` ，默认为`yes`
	* `viewport-fit` ： 视口是否根据设备自适应，可能的值
		* `auto`：不会影响“初始布局”视口，整个网页都是可查看的
		* `caontain`：视口被缩放以适合显示中内接的最大矩形
		* `cover`： 缩放视口以填充设备显示。

> 将 `user-scalable` 设置为 `no` 会阻止一切意义上的缩放，视力不好的人可能会因此无法阅读和理解页面内容

### 4. 其它元数据名称

* `creator`：当前文档的创建者，例如某个组织或者机构。如果有不止一个创建者，则应当使用多个名称为 `creator` 的 `<meta>` 元素
* `googolbot`：`robots` 的替代名称，只被 Googlebot（Google 的网页爬虫/索引搜寻器）使用
* `publisher`：当前文档的发布者/出版者
* `robots`：爬虫应当遵守的规则。是一个使用逗号分隔的、由下列值构成的列表：
	* `index`：允许爬虫索引此页面（所有爬虫）
	* `noindex`：要求爬虫不索引此页面（所有爬虫）
	* `follow` ：允许爬虫跟踪页面上链接所指向的页面（所有爬虫）
	* `onfollow`：要求爬虫不跟踪页面上的链接（所有爬虫）
	* `all`：与`index,follow` 等价（只针对谷歌爬虫）
	* `none`：与`noindex, nofollow等价`（只针对谷歌爬虫）
	* `noarchive`：要求搜索引擎不缓存页面内容（针对谷歌、雅虎、必应搜索）
	* `nosnippet`：要求搜索引擎不要在搜索结果页显示本页面的描述。（针对谷歌、必应搜索）
	* `noimageindex`：要求本页面不会成为搜索结果页中索引图像的引用页。（只针对谷歌搜索）
	* `nocache`：`noarchive`的替代名称。（只针对必应）
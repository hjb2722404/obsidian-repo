## 是什么

HTTP 协议的 `Content-Security-Policy` 响应头允许网站管理员控制用户代理可以为给定页面加载的资源

## 有什么用 

可以防止[[Web安全详解#跨站点脚本攻击]]

## 语法

```
Content-Security-Policy: <policy-directive>; <policy-directive>
```


##  指令`<policy-directive>`说明

### 获取资源型指令

#### 可选来源
* `<host-source>` : 因特网主机的名称或IP地址，以及可选的URL方案和/或端口号
* `<scheme-source>` 某种协议方案，符合该协议的均被视为有效源，例如：`http:`,`https:`,`blob:`,`data:` 等，注意，必须有冒号
* `'self'`:  与当前文档同源（包括相同的URL协议地址和端口号），必须包括单引号
* `'unsafe-eval'` : 允许使用`eval（）`和类似方法从字符串创建代码。必须包括单引号
* `'unsafe-hashes'`:允许启用特定的内联事件处理程序。如果只需要允许内联事件处理程序，而不需要内联`<script>`元素或`javascript:url`，那么这种方法比使用不安全的内联表达式更安全
* `'unsafe-inline'`: 允许使用内联资源，例如内联`<script>`元素、`javascript:url`、内联事件处理程序和内联`<style>`元素。单引号是必需的
* `'none'` : 引用空集合，即不匹配 url。需要单引号
* `'nonce-<base64-value>'`:使用加密`nonce`（一次使用的数字）的特定内联脚本的允许列表。服务器必须在每次传输策略时生成唯一的`nonce`值。提供一个不可用的`nonce`是至关重要的，因为绕过资源的策略在其他方面是微不足道的。指定`nonce`会使现代浏览器忽略“不安全的内联”，这仍然可以为没有`nonce`支持的旧浏览器设置
* `'<hash-algorithm>-<base64-value>'`:脚本或样式的sha256、sha384或sha512散列。此源代码的使用由两部分组成，两部分用破折号分隔：用于创建哈希的加密算法和脚本或样式的base64编码哈希。生成散列时，不要包含`<script>`或`<style>`标记，并注意大小写和空格很重要，包括前导或尾随空格

#### `child-src`  

定义使用 `<frame>` 和 `<iframe>` 等元素加载的 Web Worker 和嵌套浏览上下文的有效来，不符合要求的请求将被用户代理视为致命的网络错误
> 如果要规范嵌套的浏览上下文和worker，应该分别使用`frame src`和`worker src`指令，而不是`child src`。

##### 示例
```
<head>
	<meta http-equiv="content-security-policy" content="child-src https://www.baidu.com/; child-src unsafe-inline">
</head>

<body>
 
<iframe src="https://a.com"></iframe> // 框架里的页面将无法加载

<script>
  var blockedWorker = new Worker("data:application/javascript,...");
  console.log(blockWorker); 控制台将报错
</script>
</body>
```


#### `connect-src`
限制可以通过脚本接口加载的url，受限制的API有
* `<a>`标签的`ping`属性
* `WindowOrWorkerGlobalScope.fetch`
* `XMLHttpRequest`
* `EventSource`
* `Navigator.sendBeacon()`

##### 示例
```
<head>
	<meta http-equiv="content-security-policy" content="connect-src https://www.baidu.com/; child-src unsafe-inline">
</head>

<body>
 
// 以下链接都将不被允许

<a ping="https://not-example.com">

<script>
  var xhr = new XMLHttpRequest();
  xhr.open('GET', 'https://not-example.com/');
  xhr.send();

  var ws = new WebSocket("https://not-example.com/");

  var es = new EventSource("https://not-example.com/");

  navigator.sendBeacon("https://not-example.com/", { ... });
</script>



</body>
```

#### `default-src`
该指令用作其他 CSP 获取指令的后备。 对于其它指令，用户代理查找 `default-src` 指令并为其使用此值


#### `font-src`

指令指定使用@font-face 加载的字体的有效来源。

##### 示例
```
<head>
	<meta http-equiv="content-security-policy" content="font-src https://www.baidu.com/; child-src unsafe-inline">
	
	// 以下字体将无法加载


<style>
  @font-face {
    font-family: "MyFont";
    src: url("https://not-example.com/font");
  }
  body {
    font-family: "MyFont";
  }
</style>
</head>

<body>


</body>
```


#### `frame-src`

指定使用`<frame>`和`<iframe>`等元素加载嵌套浏览上下文的有效源。

##### 示例

见 [[#child-src]]，将`<meta>`中`child-src`改为`frame-src`即可

#### `img-src`

指定图像和favicon的有效源

##### 特殊可选来源

* `'strict-dynamic'`：严格的动态源代码表达式指定，通过使用nonce或hash将显式给予标记中存在的脚本的信任传播到该根脚本加载的所有脚本。同时，任何允许列表或源表达式（如“self”或“unsafe inline”）都将被忽略
* `'report-sample'`:  要求在违规报告中包含违规代码的样本

##### 示例

```
<head>
	<meta http-equiv="content-security-policy" content="
img-src https://www.baidu.com/; ">
</head>

<body>
 
// 以下图片将无法加载

<img src="https://not-example.com/foo.jpg" alt="example picture">


</body>
```

#### `manifest-src`

指定哪些manifest可以应用到资源。

##### 示例

```
<head>
	<meta http-equiv="content-security-policy" content="
manifest-src https://www.baidu.com/; ">

// 以下清单文件将无法加载
<link rel="manifest" href="https://not-example.com/manifest">


</head>

<body>


</body>
```


#### `media-src`

指定使用`<audio>`和`<video>`元素加载媒体的有效源。
	
##### 示例	
```
<head>
	<meta http-equiv="content-security-policy" content=" 
	media-src https://www.baidu.com/; ">

</head>

<body>

// 以下音频与视频将不会被加载和播放

<audio src="https://not-example.com/audio"></audio>

<video src="https://not-example.com/video">
  <track kind="subtitles" src="https://not-example.com/subtitles">
</video>


</body>
```

#### `object-src`

指定`<object>`、`<embed>`和`<applet>`元素的有效源

##### 示例

```
<head>
	<meta http-equiv="content-security-policy" content=" 
	object-src https://www.baidu.com/; ">

</head>

<body>

// 以下控件将不会被加载


<embed src="https://not-example.com/flash"></embed>
<object data="https://not-example.com/plugin"></object>
<applet archive="https://not-example.com/java"></applet>



</body>
```


#### `prefetch-src`

指令指定可以预取或预呈现的有效源

##### 示例

```
<head>
	<meta http-equiv="content-security-policy" content=" 
	prefetch-src https://www.baidu.com/; ">
	
	// 以下资源将不会被预拉取或预渲染
	<link rel="prefetch" src="https://example.org/"></link>
	<link rel="prerender" src="https://example.org/"></link>

</head>

<body>

</body>
```

#### `script-src`

指令指定 JavaScript 的有效来源。 这不仅包括直接加载到 `<script>` 元素中的 URL，还包括可以触发脚本执行的内联脚本事件处理程序 (`onclick`) 和 XSLT 样式表

##### 特殊可选来源

* `'strict-dynamic'`：严格的动态源代码表达式指定，通过使用nonce或hash将显式给予标记中存在的脚本的信任传播到该根脚本加载的所有脚本。同时，任何允许列表或源表达式（如“self”或“unsafe inline”）都将被忽略
* `'report-sample'`:  要求在违规报告中包含违规代码的样本

##### 示例

```
<head>
	<meta http-equiv="content-security-policy" content=" 
	script-src https://www.baidu.com/; ">
	
	// 以下资源将不会被预拉取或预渲染
	<link rel="prefetch" src="https://example.org/"></link>
	<link rel="prerender" src="https://example.org/"></link>

</head>

<body>

// 以下脚本将不会被加载或执行


<script src="https://not-example.com/js/library.js"></script>


<button id="btn" onclick="doSomething()">

// 但是可以通过addEventListener方法来调用


document.getElementById("btn").addEventListener('click', doSomething);



</body>
```

#### `style-src`

指定样式表的有效源
```
<head>
	<meta http-equiv="content-security-policy" content=" 
	style-src https://www.baidu.com/; ">
	
	// 以下样式表将不会被加载或应用
	
	<link href="https://not-example.com/styles/main.css" rel="stylesheet" type="text/css" />

	<style>
	#inline-style { background: red; }
	</style>

	<style>
	  @import url("https://not-example.com/styles/print.css") print;
	</style>


</head>

<body>

</body>
```

### 文档型指令

#### `base-uri`

限制可在文档的`<base>`元素中使用的URL

##### 特殊可选来源

* `'strict-dynamic'`：严格的动态源代码表达式指定，通过使用nonce或hash将显式给予标记中存在的脚本的信任传播到该根脚本加载的所有脚本。同时，任何允许列表或源表达式（如“self”或“unsafe inline”）都将被忽略
* `'report-sample'`:  要求在违规报告中包含违规代码的样本

##### 示例

```
<meta http-equiv="Content-Security-Policy" content="base-uri 'self'">

// 控制台将会报错，改配置将不会被应用
<base href="https://example.com/">

```

#### `sendbox`

为请求的资源启用沙盒，类似于`<iframe>`沙盒属性。它对页面的操作应用限制，包括阻止弹出窗口、阻止插件和脚本的执行以及强制执行同一源策略。

##### 允许的配置值

**不允许应用上文的[[#可选来源]]**

* `allow-downloads`: 允许在用户单击按钮或链接后下载
* `allow-forms`: 允许页面提交表单。 如果不使用该关键字，则不允许进行此操作
* `allow-modals`: 允许页面打开模式窗口
* `allow-orientation-lock`: 允许页面禁用锁定屏幕方向的功能
* `allow-pointer-lock`: 允许页面使用指针锁 API
* `allow-popups`:  允许弹出窗口（例如来自 window.open、target="_blank"、showModalDialog）。 如果未使用此关键字，则该功能将默默地失败。
* `allow-popups-to-escape-sandbox` 允许沙盒文档打开新窗口，而无需对其强制使用沙盒标志。例如，这将允许安全地对第三方广告进行沙盒处理，而无需对登录页施加相同的限制。
* `allow-presentation`. 允许嵌入程序控制`iframe`是否可以启动表示会话
* `allow-same-origin` 允许将内容视为来自其正常来源。如果不使用此关键字，则嵌入的内容将被视为来自唯一的来源
* `allow-scripts`: 允许页面运行脚本（但不创建弹出窗口）。如果不使用此关键字，则不允许此操作
* `allow-top-navigation`: 允许页面将内容导航（加载）到顶级浏览上下文。如果不使用此关键字，则不允许此操作。
* `allow-top-navigation-by-user-activation` 允许资源浏览顶级浏览上下文，但只有在用户手势启动时才允许

###  导航型指令

#### `form-action`

限制表单提交目标的URL


##### 特殊可选来源

* `'strict-dynamic'`：严格的动态源代码表达式指定，通过使用nonce或hash将显式给予标记中存在的脚本的信任传播到该根脚本加载的所有脚本。同时，任何允许列表或源表达式（如“self”或“unsafe inline”）都将被忽略
* `'report-sample'`:  要求在违规报告中包含违规代码的样本

##### 示例

```
<meta http-equiv="Content-Security-Policy" content="form-action 'none'">

// 此表单将无法提交
<form action="javascript:alert('Foo')" id="form1" method="post">
  <input type="text" name="fieldName" value="fieldValue">
  <input type="submit" id="submit" value="submit">
</form>
```

#### `frame-ancestors`

指定可以使用`<frame>`、`<iframe>`、`<object>`、`<embed>`或`<applet>`嵌入页面的有效父级

##### 可选来源

* `<host-source>`
* `<scheme-source>`
* `'self'`
* `'none'`






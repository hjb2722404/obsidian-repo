## 是什么

简而言之，它是一个指定IE8以上版本浏览器采用何种文档兼容模式来渲染页面的指令。

## 在哪里用

有两个地方使用：

* 客户端——`HTML` 文档中 `<meta>`标签里，使用`http-equiv`属性指定
* 服务端—— HTTP响应头中设置

如果客户端与服务端都设置了，采用客户端的设置。

## 什么是文档兼容模式

文档兼容模式是IE8浏览器引入的，它允许开发人员告诉IE浏览器采用与旧版本IE相同的方式来渲染页面，从而允许由开发人员选择何时对页面进行更新。
通过实施适当的兼容模式，站点可以确保与 Internet Explorer 8 及更高版本的兼容性。

比如，如果设置兼容模式为`IE=5`，则即使使用IE8打开页面，其渲染效果也将和在IE7的怪异模式下的渲染效果一样，而如果设置兼容模式为`IE=7`，则在IE8中打开页面时渲染讲过将和IE7标准模式下渲染效果一样。

**根据概念，只能指定高版本IE浏览器使用低版本IE浏览器的渲染机制，而无法指定低版本浏览器采用高版本浏览器的渲染机制**


## 有哪些值

* `IE=5` : 将采用IE7的怪异模式渲染页面
* `IE=7`：将采用IE7标准模式渲染页面
* `IE=8`：将采用IE8标准模式渲染页面
* `IE=9`：将采用IE9标准模式渲染页面
* `IE=10`：将采用IE10标准模式渲染页面
* `IE=11`：将采用IE11标准模式渲染页面
* `IE=edge`：将采用浏览器支持的最高文档模式渲染页面
* `IE=EmulateIE7`
	* 采用IE7标准模式（如果有效<！DOCTYPE>声明存在）
	* 采用怪异模式（否则）
*  `IE=EmulateIE8`
	* 采用IE8标准模式（如果有效<！DOCTYPE>声明存在）
	* 采用怪异模式（否则）
*  `IE=EmulateIE9`
	* 采用IE9标准模式（如果有效<！DOCTYPE>声明存在）
	* 采用怪异模式（否则）
*  `IE=EmulateIE10`
	* 采用IE10标准模式（如果有效<！DOCTYPE>声明存在）
	* 采用怪异模式（否则）
*  `IE=EmulateIE11`
	* 采用IE11标准模式（如果有效<！DOCTYPE>声明存在）
	* 采用怪异模式（否则）

## 怎么用

### 客户端

```html

<meta http-equiv="X-UA-Compatible" content="IE=edge">

```

### 服务端

以`Apache`为例

```c

<IfModulemod_setenvif.c>
<IfModulemod_headers.c>
BrowserMatch MSIE ie
    Header set X-UA-Compatible "IE=Edge" env=ie
BrowserMatchchromeframegcf
    Header append X-UA-Compatible "chrome=1" env=gcf
</IfModule>
</IfModule>

```

以`nginx` 为例
```
add_header "X-UA-Compatible" "IE=Edge,chrome=1"; 
```

### 多个并列值

```
<meta http-equiv="X-UA-Compatible" content="IE=7; IE=9" />

```

以上就表明，将IE8和IE7按照IE7标准渲染，但是IE9还是按照IE9的标准渲染。它允许有不同的向后兼容水平。

### 兼容谷歌内嵌

```
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />

```

添加”chrome=1“将允许站点在使用了谷歌浏览器内嵌框架（Chrome Frame）的客户端渲染，对于没有使用的，则没有任何影响。【大多数国产浏览器都是有谷歌内嵌的，所以建议默认加上】
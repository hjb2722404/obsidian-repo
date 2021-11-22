# HTML的meta标签详解

## 是什么
`<meta>` 标签是用来描述文档[[元数据]]的元素标签。

## 在哪里

`<meta>` 标签一般放置在`HTML`文档的 `<head>` 标签中

## 什么时候用

需要向能够读取网页代码的程序或人提供额外信息和特殊行为指令时，比如：

* 为HTML解析器提供当前页面所使用的字符集
* 为HTML解析器提供当前页面内容所使用的编码格式
* 为搜索引擎提供关键词、作者等SEO内容
* 让HTML解析器执行页面重定向操作
* 让HTML解析器按照某种指定的模式渲染页面
* 为用户提供当前应用的作者和版本号等信息
* 等等

## 有什么属性

### `charset`

定义文档的字符编码

值： 必须是与ASCII大小写无关的编码名称，比如`utf-8`，`gbk`，`gb2312`

### `content` 

这个属性定义与 `http-equiv` 或 `name `属性相关的元信息，具体取决于所使用的值

### `http-equiv` 

`equiv`的意思是`等效，同等`，所以这个属性定义的是一个编译型的指令，它所有允许的值都是特定的`HTTP`  头部名称，它`等同于对应的HTTP头部设置`.

值：

* `content-security-policy`  它允许页面作者定义当前页的[[HTML的内容安全策略]]，控制用户代理（比如浏览器）在一个页面上可以加载使用的资源，有助于防止[[跨站点脚本攻击]]，它的值详见 [[HTML的内容安全策略 | HTML的内容安全策略]] 一文。
* `content-type`  该属性只能用于HTML文档，不能用于XML文档。它的值必须是`text/html; charset=utf-8` (即`content`属性的值)
* `defalt-style` 设置默认`CSS`样式表组的名称
* `x-ua-compatible` :  规定IE8以上浏览器使用何种模式渲染页面。
* `refresh`
	* 如果`content` 只包含一个正整数，则为重新载入页面的时间间隔
	* 如果 `content` 包含一个正整数，并且后面跟着字符串 `;url=`和一个合法的URL，则是重定向到该URL的时间间隔。

### `name`

和`content` 属性一起使用，以名-值对的方式给文档提供元数据，其中，`name`为元数据名称，`content`为元数据的值，参见[[HTML标准元数据名称]]

## 怎么用

### 示例1  指定页面字符集为`utf-8`

```
<meta charset="utf-8">
```

在 HTML 文档中，它与下面的代码是等效的：

```
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
```

这是因为，、第二种是HTML5出现之前（HTML4）用来定义字符集的，而HTML5新增了`charset` 属性，使得我们可以使用第一种方式更方便地指定页面字符集。

### 示例2 指定视口以何种方式缩放
```
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

它指定了视口（`viewport`）的宽度等于设备宽度，设备宽度与视口大小见的缩放比例是1.（即视口宽度与设备宽度一致），详见[[HTML标准元数据名称#viewport]]


### 示例3  定义网页描述

```
<meta name="description" content="{150 words}">
```

它用于定义对网页内容的描述。（不超过150个单词）

### 示例4 定义版权信息 

```
<meta name="copyright" content="company name">
```

它用来保护公司的所有版权

### 示例5  定义网页摘要
```
<meta name="abstract" content="some text">
```

它用于定义特定网页的摘要

### 示例6 定义作者信息

```
<meta name="author" content="name, email@hotmail.com">
```

用于定义HTML文档的作者

### 示例7  定义公司网站地址

```
<meta name="url" content="http://www.websiteaddrress.com">
```

用于定义标签属性中定义的特定公司的URL地址

### 示例8 指定文档评级
```
<meta name="rating" content="General">
```

它用于处理我们文档中的评级。

### 示例9  定义文档字幕

```
<meta name="subtitle" content=" subtitle using metatag">
```

如果我们想为HTML文档定义字幕，那么就可以使用这个标签

### 示例10  指定网页每隔一段时间刷新一次

```
<meta name="refresh" content="50″>
```

它是用来在其定义的时间间隔之后刷新我们的网页的（毫秒）

### 示例11  定义文档分类

```
<meta name="Classification" content="Business">
```

它用于按定义的实体值对文档进行分类

### 示例12  定义文档摘要

```
<meta name="summary" content="">
```

此标记用于定义文档摘要

### 示例13 定义允许哪些搜索引擎爬虫访问

```
<meta name="robots" content="Robotics"/>
```

### 示例14 定义网页关键词

```
<meta name = "keywords" content = "HTML, Meta Tags, Metadata" />
```

### 示例15 定义网页cookie失效时间
```
<meta http-equiv = "cookie" content = "userid = xyz;  
expires = Tuesday, 31-Dec-19 23:59:59 IST;" />
```

### 示例16 指定页面n毫秒后跳转到其它地址

```
<meta http-equiv = "refresh" content = "10; url = https://www.educba.com/" />
```

### 示例17  指定IE8以上浏览器始终使用最新模式渲染

```
<meta http-equiv="X-UA-Compatible" content="IE=edge">
```
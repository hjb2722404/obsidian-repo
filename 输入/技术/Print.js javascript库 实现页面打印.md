Print.js javascript库 实现页面打印

# [Print.js javascript库 实现页面打印](https://www.jianshu.com/p/bc079fbb20c7)

### [官网地址](https://links.jianshu.com/go?to=https%3A%2F%2Fprintjs.crabbly.com%2F)

### 您可以从GitHub版本下载最新版本的Print.js

### [下载v1.0.61](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fcrabbly%2FPrint.js%2Freleases%2Ftag%2Fv1.0.61)

### npm 安装

	  npm install print-js --save
	1

### npm安装时将库导入项目

	 import print from 'print-js'
	1

### 首先，我们需要在页面上包含Print.js库和样式

	 <script src="print.js"></script>
	  <link rel="stylesheet" type="text/css" href="print.css">
	12

### 下面主要介绍一下我们要用的打印方法printJS();

> printJS()将接受一个对象作为参数，下面表格的参数则为该对象的属性,通过控制属性值来控制打印;
参数
默认值
说明
printable:
null
文档来源：pdf或图像的url，html元素的id或json数据的对象
type:
PDF
可打印类型。可用的打印选项包括：pdf，html，image，json和raw-html。
header:
null
用于HTML，Image或JSON打印的可选标头。它将放在页面顶部。此属性将接受文本或原始HTML
headerStyle:
'font-weight：300;'
要应用于标题文本的可选标题样式
maxWidth:
800
最大文档宽度（像素）。根据需要更改此项。在打印HTML，图像或JSON时使用。
css:
null
这允许我们传递一个或多个应该应用于正在打印的html的css文件URL。值可以是包含单个URL的字符串，也可以是包含多个URL的数组。
style:
null
这允许我们传递一个字符串，该字符串应该应用于正在打印的html。
scanStyles:
true
设置为false时，库不会处理应用于正在打印的html的样式。使用css参数时很有用。
targetStyle:
null
默认情况下，在打印HTML元素时，库仅处理某些样式。此选项允许您传递要处理的样式数组。例如：['padding-top'，'border-bottom']
targetStyles:
null

与[object Object]相同，这将处理任何一系列样式。例如：['border'，'padding']，将包括'border-bottom'，'border-top'，'border-left'，'border-right'，'padding-top'等。你也可以传递['*']来处理所有样式

ignoreElements:
[]
接受打印父html元素时应忽略的html的id数组。
properties:
null
在打印JSON时使用。这些是对象属性名称。
gridHeaderStyle:
'font-weight：bold;'
打印JSON数据时网格标题的可选样式。
gridStyle:
'border: 1px solid lightgray; margin-bottom: -1px;'
打印JSON数据时网格行的可选样式
repeatTableHeader:
true
在打印JSON数据时使用。设置为时false，数据表标题仅显示在第一页中。
showModal:
null
启用此选项可在检索或处理大型PDF文件时显示用户反馈
modalMessage:
'Retrieving Document...'
当向用户显示的消息showModal被设定为true。
onLoadingStart:
null
加载PDF时要执行的功能
onLoadingEnd:
null
加载PDF后要执行的功能
documentTitle:
'Document'
打印html，image或json时，它将显示为文档标题。如果用户尝试将打印作业保存为pdf文件，它也将是文档的名称。
fallbackPrintable:
null

打印pdf时，如果浏览器不兼容（检查浏览器兼容性表），库将在新选项卡中打开pdf。这允许您传递要打开的不同pdf文档，而不是传递给[object Object]的原始文档。如果您在备用pdf文件中注入javascript，这可能很有用。

onPdfOpen :
null

打印pdf时，如果浏览器不兼容（检查浏览器兼容性表），库将在新选项卡中打开pdf。可以在此处传递回调函数，这将在发生这种情况时执行。在您想要处理打印流程，更新用户界面等的某些情况下，它可能很有用。

onPrintDialogClose:
null
关闭浏览器打印对话框后执行回调功能
onError:
error => throw error
发生错误时要执行的回调函数。
base64:
false
在打印作为base64数据传递的PDF文档时使用
honorMarginPadding(不建议使用):
true
这用于保留或删除正在打印的元素的填充和边距。有时这些样式设置在屏幕上很棒，但在打印时看起来很糟糕。您可以通过将其设置为false来删除它。
honorColor(不建议使用) :
false
要以彩色打印文本，请将此属性设置为true。默认情况下，所有文本都将以黑色打印。
font(不建议使用):
'TimesNewRoman'
打印HTML或JSON时使用的字体
font_size(不建议使用):
'12pt'
打印HTML或JSON时使用的字体大小
imageStyle (不建议使用):
'width:100%;'
打印图像时使用。接受包含要应用于每个图像的自定义样式的字符串。
frameId:
null
print.js会将要打印的内容复制到一个新的Frame中,此参数是frame的id值

## 示例

#### HTML打印

> 有时我们只想打印HTML页面的选定部分，这可能很棘手。使用Print.js，我们可以轻松传递我们要打印的元素的id。该元素可以是任何标记，只要它具有唯一ID即可。该库将尝试将其打印得非常接近它在屏幕上的外观，同时，它将为它创建一个打印机友好的格式。

	<form method="post" action="#" id="printJS-form">
	    ...
	 </form>

	 <button type="button" onclick="printJS('printJS-form', 'html')">
	    Print Form
	 </button>
	1234567

**向表单添加标题**

	 <button type="button" onclick="printJS({ printable: 'printJS-form', type: 'html', header: '这是标题内容' })">
	    打印
	 </button>
	123

html时候需要注意的事项:

> 直接采用默认的参数打印html的时候如果打印内容过多时候可能会非常慢，这时候需要设置scanStyles:false,然后把css抽取出来，这样速度就会非常的快！

	printJS({ printable: 'myHtmlElement', type: 'html', scanStyles: false, css: '/my_stylesheet.css' })
	1

#### 图片的打印

> 通过传递图像网址，Print.js可用于快速打印页面上的任何图像。当您使用低分辨率版本的图像在屏幕上显示多个图像时，此功能非常有用。当用户尝试打印所选图像时，您可以将高分辨率URL传递给Print.js。

	<img src="images/print-01.jpg" />
	 printJS('图片的url', 'image')
	12

**添加标题**

	printJS({printable: 'images/print-01-highres.jpg', type: 'image', header: '这是标题'})
	1

**打印多张图片**

	 printJS({
	  printable: ['images/print-01-highres.jpg', 'images/print-02-highres.jpg', 'images/print-03-highres.jpg'],
	  type: 'image',
	  header: '标题仅显示在第一张图片',
	  imageStyle: 'width:50%;margin-bottom:20px;'
	 })
	123456

#### JSON的打印

> 一种简单快捷的方法来打印动态数据或javascript对象数组。

	var  someJSONdata = [
	    {
	       name: 'John Doe',
	       email: 'john@doe.com',
	       phone: '111-111-1111'
	    },
	    {
	       name: 'Barry Allen',
	       email: 'barry@flash.com',
	       phone: '222-222-2222'
	    },
	    {
	       name: 'Cool Dude',
	       email: 'cool@dude.com',
	       phone: '333-333-3333'
	    }
	 ]

	<button type="button"
	onclick="printJS({printable: someJSONdata, properties: ['name', 'email', 'phone'], type: 'json'})">
	    打印
	 </button>
	12345678910111213141516171819202122

**自定义css来设置数据网格的样式：**

	 <button type="button" onclick="printJS({
	        printable: someJSONdata,
	        properties: ['name', 'email', 'phone'],
	        type: 'json',
	        gridHeaderStyle: 'color: red;  border: 2px solid #3971A5;',
	        gridStyle: 'border: 2px solid #3971A5;'
	    })">
	    打印
	 </button>
	123456789

**自定义发送对象数组的表头文本**

	 <button type="button" onclick="printJS({
	        printable: someJSONdata,
	        properties: [
	        { field: 'name', displayName: '自定义表头'},
	        { field: 'email', displayName: '自定义表头'},
	        { field: 'phone', displayName: '自定义表头'}
	        ],
	        type: 'json'
	        })">
	   打印
	 </button>
	1234567891011

## JSON，HTML和图像打印可以接收原始HTML标头

	<button type="button" onclick="printJS({
	        printable: someJSONdata,
	        type: 'json',
	        properties: ['name', 'email', 'phone'],
	        header: '<h3 class="custom-h3">My custom header</h3>',
	        style: '.custom-h3 { color: red; }'
	      })">
	    Print header raw html
	</button>
	123456789

#### [感谢WwJoyous的分享](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fwwjoyous%2Farticle%2Fdetails%2F80881881)

### [浪客行1213的简书](https://www.jianshu.com/p/8253ea5e83b9)

* * *

![15037106-e8686e2dc933396f.png](../_resources/d595e2c02c262d1b103f92f1fe2ccca0.png)
xhh
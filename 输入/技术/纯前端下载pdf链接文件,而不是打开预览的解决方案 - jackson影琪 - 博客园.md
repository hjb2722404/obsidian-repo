纯前端下载pdf链接文件,而不是打开预览的解决方案 - jackson影琪 - 博客园

# 纯前端下载pdf链接文件,而不是打开预览的解决方案

## 一,介绍与需求

###  1.1,介绍

      XMLHttpRequest 用于在后台与服务器交换数据。这意味着可以在不重新加载整个网页的情况下，对网页的某部分进行更新。
      问题:Chrome 会自动调用内置的 pdf 阅读器打开

###  1.2,需求

      在谷歌(Chrome)浏览器中,使用a标签属性download下载pdf链接文件，如果是相同域时,可以直接下载;但是如果域不同,则不是下载，而是直接打开页面预览文件。但是需求是直接点击下载文件,而不是打开预览；以及下载后台返回的文件流。

## 二,下载文件

###  **  已发布npm包：[web-downloadfile](https://www.npmjs.com/package/web-downloadfile)，运行如下命令即可安装使用**

** cnpm install web-downloadfile --save **
**目前只提供三个Api,分别如下:**

** import { base64ToFileOrBlob, saveFileToBlob, saveFileToLink } from 'web-downloadfile'; **

**详细的使用方式可查看[官网](https://www.npmjs.com/package/web-downloadfile)**[**web-downloadfile**](https://www.npmjs.com/package/web-downloadfile)

### 2.1,思路

    通过a标签的download属性,我们可以直接下载后台接口返回的数据流文件;故此,我们是否可以模拟发送http请求,将文件链接转换成文件流来使用a标签download下载。以下主要介绍链接文件转文件流下载的思路与方法

### 2.2,文件路径转文件流

1,先校验是否是路径链接
使用正则表达式校验url是否合法

1 let reg = /^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+).)+([A-Za-z0-9-~\/])+$/;2  if (!reg.test(url)) {3  throw  new Error("传入参数不合法,不是标准的链接");4 }

2,创建XMLHttpRequest对象
模拟发送http请求,获取文件流
[![copycode.gif](纯前端下载pdf链接文件,而不是打开预览的解决方案%20-%20jackson影琪%20-%20博客园.md#)

1 let xhr = new XMLHttpRequest();//创建 XMLHttpRequest 对象 2 xhr.open('get', 'http://url', true);//规定请求的类型、URL 以及是否异步处理请求。三个参数分别是 method：请求的类型；GET 或 POST url：文件在服务器上的位置 async：true（异步）或 false（同步） 3 xhr.setRequestHeader('Content-Type', `application/pdf`);//设置请求头 4 xhr.responseType = "blob";//返回的数据类型 这儿需要blob对象 5 xhr.onload = function () {//请求成功回调函数 6  if (this.status == 200) { 7  //接受二进制文件流 8  var blob = this.response; 9   }10   }11 xhr.send();//将请求发送到服务器

[![copycode.gif](纯前端下载pdf链接文件,而不是打开预览的解决方案%20-%20jackson影琪%20-%20博客园.md#)
3,完整方法
[![copycode.gif](纯前端下载pdf链接文件,而不是打开预览的解决方案%20-%20jackson影琪%20-%20博客园.md#)

1  /** 2   * 文件链接转文件流下载--主要针对pdf 解决谷歌浏览器a标签下载pdf直接打开的问题 3   * @param url ：文件链接 4   * @param fileName ：文件名; 5   * @param type ：文件类型; 6  */ 7  function fileLinkToStreamDownload(url, fileName, type) { 8  let reg = /^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+).)+([A-Za-z0-9-~\/])+$/; 9  if (!reg.test(url)) {10  throw  new Error("传入参数不合法,不是标准的文件链接");11 } else {12  let xhr = new XMLHttpRequest();13 xhr.open('get', url, true);14 xhr.setRequestHeader('Content-Type', `application/${type}`);15 xhr.responseType = "blob";16 xhr.onload = function () {17  if (this.status == 200) {18  //接受二进制文件流19  var blob = this.response;20   downloadExportFile(blob, fileName, type)21   }22   }23   xhr.send();24   }25 }

[![copycode.gif](纯前端下载pdf链接文件,而不是打开预览的解决方案%20-%20jackson影琪%20-%20博客园.md#)

###  2.3,下载文件

1,创建下载链接
[![copycode.gif](纯前端下载pdf链接文件,而不是打开预览的解决方案%20-%20jackson影琪%20-%20博客园.md#)

1 let downloadElement = document.createElement('a');2 let href = blob;3  if (typeof blob == 'string') {4 downloadElement.target = '_blank';//如果是链接,打开新标签页下载5 } else {6 href = window.URL.createObjectURL(blob); //创建下载的链接7   }8 downloadElement.href = href;//下载链接

[![copycode.gif](纯前端下载pdf链接文件,而不是打开预览的解决方案%20-%20jackson影琪%20-%20博客园.md#)
2,模拟点击下载链接

1 downloadElement.download = tagFileName + moment(new Date().getTime()).format('YYYYMMDDhhmmss') + '.' + fileType; //下载后文件名2  document.body.appendChild(downloadElement);3 downloadElement.click(); //点击下载

3,下载完成后释放资源

1 document.body.removeChild(downloadElement); //下载完成移除元素2  if (typeof blob != 'string') {3 window.URL.revokeObjectURL(href); //释放掉blob对象4 }

4,完成方法
[![copycode.gif](纯前端下载pdf链接文件,而不是打开预览的解决方案%20-%20jackson影琪%20-%20博客园.md#)

1  /** 2   *下载导出文件 3   * @param blob ：返回数据的blob对象或链接 4   * @param tagFileName ：下载后文件名标记 5   * @param fileType ：文件类 word(docx) excel(xlsx) ppt等 6  */ 7  function downloadExportFile(blob, tagFileName, fileType) { 8  let downloadElement = document.createElement('a'); 9 let href = blob;10  if (typeof blob == 'string') {11 downloadElement.target = '_blank';12 } else {13 href = window.URL.createObjectURL(blob); //创建下载的链接14   }15 downloadElement.href = href;16 downloadElement.download = tagFileName + moment(new Date().getTime()).format('YYYYMMDDhhmmss') + '.' + fileType; //下载后文件名17   document.body.appendChild(downloadElement);18 downloadElement.click(); //点击下载19 document.body.removeChild(downloadElement); //下载完成移除元素20  if (typeof blob != 'string') {21 window.URL.revokeObjectURL(href); //释放掉blob对象22   }23  24 }

[![copycode.gif](纯前端下载pdf链接文件,而不是打开预览的解决方案%20-%20jackson影琪%20-%20博客园.md#)

###  2.4,base64对象转文件对象

主要针对图片,不过其他文件也可
[![copycode.gif](纯前端下载pdf链接文件,而不是打开预览的解决方案%20-%20jackson影琪%20-%20博客园.md#)

1  /** 2   * base64对象转文件对象 3   * @param urlData ：数据的base64对象 4   * @param type ：类型 image/png; 5   * @returns {Blob}：Blob文件对象 6  */ 7  function base64ToBlob(urlData, type) { 8 let arr = urlData.split(','); 9 let array = arr[0].match(/:(.*?);/)10 let mime = (array && array.length > 1 ? array[1] : type) || type;11  // 去掉url的头，并转化为byte12 let bytes = window.atob(arr[1]);13  // 处理异常,将ascii码小于0的转换为大于014 let ab = new ArrayBuffer(bytes.length);15  // 生成视图（直接针对内存）：8位无符号整数，长度1个字节16 let ia = new Uint8Array(ab);17  for (let i = 0; i < bytes.length; i++) {18 ia[i] = bytes.charCodeAt(i);19   }20  return  new Blob([ab], {21   type: mime22   });23 }

[![copycode.gif](纯前端下载pdf链接文件,而不是打开预览的解决方案%20-%20jackson影琪%20-%20博客园.md#)

###  2.5,使用实例

1,文件链接转文件流下载
1 fileLinkToStreamDownload('http://127.0.0.1/download.pdf', '下载文件实例', 'pdf')
2,base64对象转文件对象下载

1 let blob = base64ToBlob('data:image/png;base64,iVBORw0KGgo=...','image/png')//获取图片的文件流2 downloadExportFile(blob, 'download', 'png')

**  问题记录:浏览器缓存问题**

  由于浏览器的缓存机制，当我们使用XMLHttpRequest发出请求的时候，浏览器会将请求的地址与缓存中的地址进行比较，如果存在相同记录则根据不向服务器发出请求而直接返回与上一次请求相同内容。

**  解决这类缓存问题的办法:**

**1,**时间戳方法 —即在每次请求的url后面加上当前时间的字符串或其他类似的不会重复的随机字符串，这样浏览器每次发出的是不同的url，即会当做不同的请求来处理，而不会从缓存中读取。

1 　if(url.indexOf("?")>=0){//判断url中是否已经带有参数2 url = url + "&t=" + (new Date()).valueOf();3 }else{4 url = url + "?t=" + (new Date()).valueOf();5 }

2,在XMLHttpRequest发送请求之前加上:
加If-Modified-Since头
1 xhr.setRequestHeader("If-Modified-Since","0"); 　2 xhr.send(null);
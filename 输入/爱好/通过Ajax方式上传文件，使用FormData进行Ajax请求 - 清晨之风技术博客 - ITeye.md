通过Ajax方式上传文件，使用FormData进行Ajax请求 - 清晨之风技术博客 - ITeye博客

 [首页](http://www.iteye.com/)  [资讯](http://www.iteye.com/news)  [精华](http://www.iteye.com/magazines)  [论坛](http://www.iteye.com/forums)  [问答](http://www.iteye.com/ask)  [博客](http://www.iteye.com/blogs)  [专栏](http://www.iteye.com/blogs/subjects)  [群组](http://www.iteye.com/groups)  [*更多*  ▼](http://yunzhu.iteye.com/blog/2177923#)

 因系统升级，暂停注册。稍后将全面支持使用CSDN帐号进行注册及登录  [您还未登录 !](http://yunzhu.iteye.com/login)  [登录](http://yunzhu.iteye.com/login)

# [清晨之风技术博客](http://yunzhu.iteye.com/)

- [**博客**](http://yunzhu.iteye.com/)

- [微博](http://yunzhu.iteye.com/weibo)

- [相册](http://yunzhu.iteye.com/album)

- [收藏](http://yunzhu.iteye.com/link)

- [留言](http://yunzhu.iteye.com/blog/guest_book)

- [关于我](http://yunzhu.iteye.com/blog/profile)

###   [通过Ajax方式上传文件，使用FormData进行Ajax请求](http://yunzhu.iteye.com/blog/2177923)  *  *

**博客分类：**

- [RESTful Web Services](http://yunzhu.iteye.com/category/332027)
- [Web前端开发](http://yunzhu.iteye.com/category/158909)

[通过Ajax方式上传文件](http://www.iteye.com/blogs/tag/%E9%80%9A%E8%BF%87Ajax%E6%96%B9%E5%BC%8F%E4%B8%8A%E4%BC%A0%E6%96%87%E4%BB%B6)[使用FormData进行Ajax请求](http://www.iteye.com/blogs/tag/%E4%BD%BF%E7%94%A8FormData%E8%BF%9B%E8%A1%8CAjax%E8%AF%B7%E6%B1%82)

通过传统的form表单提交的方式上传文件：
Html代码  [![收藏代码](../_resources/55eb9a99292517e853b6a4f5ef4c4e57.png)]()

1. **<****form** id= "uploadForm" action= "http://localhost:8080/cfJAX_RS/rest/file/upload" method= "post" enctype ="multipart/form-data"**>**

2.      **<****h1** **>**测试通过Rest接口上传文件 **</****h1****>**

3.      **<****p** **>**指定文件名： **<****input** type ="text" name="filename" **/>****</****p****>**

4.      **<****p** **>**上传文件： **<****input** type ="file" name="file" **/>****</****p****>**

5.      **<****p** **>**关键字1： **<****input** type ="text" name="keyword" **/>****</****p****>**

6.      **<****p** **>**关键字2： **<****input** type ="text" name="keyword" **/>****</****p****>**

7.      **<****p** **>**关键字3： **<****input** type ="text" name="keyword" **/>****</****p****>**

8.      **<****input** type ="submit" value="上传"**/>**
9. **</****form****>**

不过传统的form表单提交会导致页面刷新，但是在有些情况下，我们不希望页面被刷新，这种时候我们都是使用Ajax的方式进行请求的：
Js代码  [![收藏代码](../_resources/55eb9a99292517e853b6a4f5ef4c4e57.png)]()
1. $.ajax({
2.      url : "http://localhost:8080/STS/rest/user",
3.      type : "POST",
4.      data : $( '#postForm').serialize(),
5.      success : **function**(data) {
6.           $( '#serverResponse').html(data);
7.      },
8.      error : **function**(data) {

9.           $( '#serverResponse').html(data.status + " : " + data.statusText + " : " + data.responseText);

10.      }
11. });

如上，通过$('#postForm').serialize()可以对form表单进行序列化，从而将form表单中的所有参数传递到服务端。

但是上述方式，只能传递一般的参数，上传文件的文件流是无法被序列化并传递的。
不过如今主流浏览器都开始支持一个叫做FormData的对象，有了这个FormData，我们就可以轻松地使用Ajax方式进行文件上传了。

**关于FormData及其用法**

* * *

FormData是什么呢？我们来看看Mozilla上的介绍。

XMLHttpRequest Level 2添加了一个新的接口[object Object].利用[object Object],我们可以通过JavaScript用一些键值对来模拟一系列表单控件,我们还可以使用XMLHttpRequest的[[object Object]](https://developer.mozilla.org/zh-CN/docs/DOM/XMLHttpRequest#send())方法来异步的提交这个"表单".比起普通的ajax,使用[object Object]的最大优点就是我们可以异步上传一个二进制文件.

所有主流浏览器的较新版本都已经支持这个对象了，比如Chrome 7+、Firefox 4+、IE 10+、Opera 12+、Safari 5+。

参见：https://developer.mozilla.org/zh-CN/docs/Web/API/XMLHttpRequest/FormData

这里只展示一个通过from表单来初始化FormData的方式
<form enctype=*"multipart/form-data"* method=*"post"* name=*"fileinfo"*>
Js代码  [![收藏代码](../_resources/55eb9a99292517e853b6a4f5ef4c4e57.png)]()
1. **var** oData = **new** FormData(document.forms.namedItem("fileinfo" ));
2. oData.append( "CustomField", "This is some extra data" );
3. **var** oReq = **new** XMLHttpRequest();
4. oReq.open( "POST", "stash.php" , **true** );
5. oReq.onload = **function**(oEvent) {
6.       **if** (oReq.status == 200) {
7.           oOutput.innerHTML = "Uploaded!" ;
8.      } **else** {

9.           oOutput.innerHTML = "Error " + oReq.status + " occurred uploading your file.<br \/>";

10.      }
11. };
12. oReq.send(oData);

参见：https://developer.mozilla.org/zh-CN/docs/Web/Guide/Using_FormData_Objects

**使用FormData，进行Ajax请求并上传文件**

* * *

这里使用JQuery，但是老版本的JQuery比如1.2是不支持的，最好使用2.0或更新版本：
Html代码  [![收藏代码](../_resources/55eb9a99292517e853b6a4f5ef4c4e57.png)]()
1. **<****form** id= "uploadForm"**>**

2.       **<****p** **>**指定文件名： **<****input** type="text" name="filename" value= ""**/>****</****p** **>**

3.       **<****p** **>**上传文件： **<****input** type="file" name="file"**/>****</** **p****>**

4.       **<****input** type="button" value="上传" onclick="doUpload()" **/>**
5. **</****form****>**

Js代码  [![收藏代码](../_resources/55eb9a99292517e853b6a4f5ef4c4e57.png)]()
1. **function** doUpload() {
2.      **var** formData = **new** FormData($( "#uploadForm" )[0]);
3.      $.ajax({
4.           url: 'http://localhost:8080/cfJAX_RS/rest/file/upload' ,
5.           type: 'POST',
6.           data: formData,
7.           async: **false**,
8.           cache: **false**,
9.           contentType: **false**,
10.           processData: **false**,
11.           success: **function** (returndata) {
12.               alert(returndata);
13.           },
14.           error: **function** (returndata) {
15.               alert(returndata);
16.           }
17.      });
18. }

**17**
顶
**8**
踩

分享到： [![](../_resources/0013c38df93cdddf18e2247e957202ee.jpg)]()  [![](../_resources/01c0f24bf292056e30da0722f350667b.jpg)]()

 [VMware中的CentOS如何通过笔记本的无线网络 ...](http://yunzhu.iteye.com/blog/2211911) | [Jersey开发Restful的文件上传接口如何传递 ...](http://yunzhu.iteye.com/blog/2177914)

- 2015-01-21 10:39

- 浏览 243528

- [评论(18)](http://yunzhu.iteye.com/blog/2177923#comments)

- 分类:[企业架构](http://www.iteye.com/blogs/category/architecture)

- [相关推荐](http://www.iteye.com/wiki/blog/2177923)

##### 参考知识库

[![](../_resources/ad7bcbb917b1f4e2d2529c7d85812311.jpg)](http://lib.csdn.net/base/android)

 [Android知识库](http://lib.csdn.net/base/android)    *36150*  关注 *|*  *3137*  收录

[![](../_resources/fe26642b9caae68f01bcdf1e8d2d6670.jpg)](http://lib.csdn.net/base/react)

 [React知识库](http://lib.csdn.net/base/react)    *3091*  关注 *|*  *393*  收录

[![](../_resources/74102c21b1c5c6fb7a50419072b54b1f.jpg)](http://lib.csdn.net/base/ai)

 [人工智能基础知识库](http://lib.csdn.net/base/ai)    *15026*  关注 *|*  *208*  收录

[![](../_resources/118ffd8d3fd3214c1c1672c5478cfb5b.jpg)](http://lib.csdn.net/base/java)

 [Java 知识库](http://lib.csdn.net/base/java)    *31072*  关注 *|*  *3747*  收录

##### 评论

 [(L)](http://yunzhu.iteye.com/blog/2177923)

18 楼 [忆梦昔年](http://2870347567.iteye.com/) 2017-05-04

服务器端用java，框架是ssh怎么接收![](../_resources/cfef373baaca4fd38b1d75773b04b6d6.gif)

17 楼 [yyhuaisha](http://yyhuaisha.iteye.com/) 2017-03-22

panda0924 写道
lhist 写道
为什么我用这个在浏览器的控制台报错，错误信息如下：

XMLHttpRequest cannot load http://localhost:1337/. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'null' is therefore not allowed access.send

@ jquery-2.2.1.js:9175jQuery.extend.ajax
@ jquery-2.2.1.js:8656doUpload
@ t1.html:26onchange
@ t1.html:62

还有一条警告：

Synchronous XMLHttpRequest on the main thread is deprecated because of its detrimental effects to the end user's experience. For more help, check http://xhr.spec.whatwg.org/.

怎么办？？

jquery要加两个参数。 $.ajax({
                type: "post",
                url: "/Uploadhelp/Upimg",
                data: formdata,
                contentType: false,
                processData: false,
                success: function (data) {
                }
            });这两个false的参数一个不能少

@qq237738572  人家说了老版本的jq不支持

16 楼 [panda0924](http://panda0924.iteye.com/) 2017-01-10

善良一脉 写道
能用zepto.js中的ajax吗？？  我用的是zepto中的ajax来上传图片，报Illegal invocation（非法调用）

我用的jquery之前和你一样，加上这两个参数就好了
$.ajax({
                type: "post",
                url: "/Uploadhelp/Upimg",
                data: formdata,
                contentType: false,
                processData: false,
                success: function (data) {
                }
            });

15 楼 [panda0924](http://panda0924.iteye.com/) 2017-01-10

lhist 写道
为什么我用这个在浏览器的控制台报错，错误信息如下：

XMLHttpRequest cannot load http://localhost:1337/. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'null' is therefore not allowed access.send

@ jquery-2.2.1.js:9175jQuery.extend.ajax
@ jquery-2.2.1.js:8656doUpload
@ t1.html:26onchange
@ t1.html:62

还有一条警告：

Synchronous XMLHttpRequest on the main thread is deprecated because of its detrimental effects to the end user's experience. For more help, check http://xhr.spec.whatwg.org/.

怎么办？？

jquery要加两个参数。 $.ajax({
                type: "post",
                url: "/Uploadhelp/Upimg",
                data: formdata,
                contentType: false,
                processData: false,
                success: function (data) {
                }
            });这两个false的参数一个不能少

14 楼 [caption_1](http://caption-1.iteye.com/) 2016-12-14

dataType: "json",  这个设置好就没事了吧！！！

13 楼 [absunique](http://absunique.iteye.com/) 2016-11-25

LZ,请问这种情况下，表单其它字段怎么指定编码。

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
这个AJAX好像不读

12 楼 [一如小溪](http://910135296.iteye.com/) 2016-11-03

请问楼主，我也用了你这种方法上传文件，但是我通过URL去调用远程服务器上的接口的时候，需要传参数给它才能获得返回值，我是通过在header里面传参数的，但是一加上header，它就会报 跨域的 错误，什么同源策略...等等。如果我不通过header 传参（用户名，文件名）的话，是可以正常访问到对方的接口的，但是如果没有给它传参，他就报用户名无效，也就得不到所需要的返回值。 请问 在使用 AJAX formData 上传文件的时候，为什么不能通过设置header的方式传参呢，会报错！！！![](../_resources/352d067f058b7434e3c4818518686f43.gif)

11 楼 [qq237738572](http://qq237738572.iteye.com/) 2016-10-25

楼主不错，分享的很好。but:::

就没有人发现问题吗？我的jquery1.11版本，使用你的方法 为什么jquery报错呢？

错误信息 ：jquery.min.js?    Uncaught TypeError: Illegal invocation.

Javascript代码  [![收藏代码](../_resources/55eb9a99292517e853b6a4f5ef4c4e57.png)]()
1. **var** jsonData = **new** FormData($("#video-second-form")[0]);

2.                         jsonData.append('file', $("#subtitle-file")[0].files[0]);

3.                         jsonData.append('name', $("#subtitle-file").val());

4.                         $.ajax({
5.                             type: "post",

6.                             url: APPNAME + "/video/transcoderSecond?type=replace",

7.                             dataType: 'json',

8.                             data: jsonData,//$("#video-second-form").serializeArray(),

9.                             processData: **false**,
10.                             contentType: **false**,
11.                             success: **function** (result) {

12.                                 hideLoading();

13.                                 Info.showInfo(result.message);

14.                             }
15.                         });

10 楼 [追风的小志](http://1838428891.iteye.com/) 2016-09-08

d[color=red][/color]

9 楼 [善良一脉](http://zou1491575403.iteye.com/) 2016-08-18

能用zepto.js中的ajax吗？？  我用的是zepto中的ajax来上传图片，报Illegal invocation（非法调用）

8 楼 [zhao499356](http://zhao499356.iteye.com/) 2016-06-29

java怎么解析文件啊

7 楼 [jeffrey9061](http://jeffrey9061.iteye.com/) 2016-03-17

非常感谢你，给我指点了迷津，让我实现了无刷新文件上传，非常感谢！！！

我在博客园写了一篇博客，里面引用到了你这篇文章，特地做了链接，以表感谢。但是，我另外还有一些小问题，如果您知道的，麻烦指点一二，谢谢。![](../_resources/8ca2d5814f5e1e7ae3023eb5b4ff18c6.gif)

6 楼 [a8350020](http://a8350020.iteye.com/) 2016-03-17

很有用，在用百度的富文本的时候就是用的formData通过ajax提交的图片。但是用这种方式提交一直报400错误，后台接收不到请求，有点头疼···

5 楼 [lhist](http://lhist.iteye.com/) 2016-03-08

为什么我用这个在浏览器的控制台报错，错误信息如下：

XMLHttpRequest cannot load http://localhost:1337/. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'null' is therefore not allowed access.send

@ jquery-2.2.1.js:9175jQuery.extend.ajax
@ jquery-2.2.1.js:8656doUpload
@ t1.html:26onchange
@ t1.html:62

还有一条警告：

Synchronous XMLHttpRequest on the main thread is deprecated because of its detrimental effects to the end user's experience. For more help, check http://xhr.spec.whatwg.org/.

怎么办？？

4 楼 [zxcq06](http://zxcq06.iteye.com/) 2015-12-22

确实有用，解决了我纠结已久的问题，多谢楼主，特此注册顶贴。

3 楼 [ch-y](http://ch-y.iteye.com/) 2015-12-11

帮了我的大忙，谢谢博主，赞一个

2 楼 [yunzhu](http://yunzhu.iteye.com/) 2015-11-27

空云万里晴 写道
日哦，服务端怎么解析的又不说。踩

兄台，我这个讲的是怎么用Ajax方式上传文件。

服务端怎么解析，那个要看服务端用的什么语言，还有用的什么框架，这之类的教程太多太多了。
你是想让我讲哪种呢？如果我讲的是服务端用Spring怎么解析，而你用的是PHP，你会不会说“日哦，PHP服务端怎么解析的又不说。踩”

1 楼 [空云万里晴](http://hoeping.iteye.com/) 2015-11-26

日哦，服务端怎么解析的又不说。踩

##### 发表评论

[![](../_resources/947ea5b2502aa07fa9369252c0f87694.png)](http://yunzhu.iteye.com/login)[您还没有登录,请您登录后再发表评论](http://yunzhu.iteye.com/login)

[![yunzhu的博客](../_resources/a81a687659f05f720a1fe5c69d820ab6.jpg)](http://yunzhu.iteye.com/)

yunzhu

- 浏览: 728013 次

- 性别: ![Icon_minigender_1](../_resources/3ce54bfbf29591c372d77db845fb5023.gif)

- 来自: 南京

- ![](../_resources/fdf0448e967f2341806fd6aae8a43ed8.gif)

##### 最近访客 [更多访客>>](http://yunzhu.iteye.com/blog/user_visits)

[![slyfox2046的博客](../_resources/5dc66808ee06680fde5f92226faf5f95.gif)](http://slyfox2046.iteye.com/)

[slyfox2046](http://slyfox2046.iteye.com/)

[![jackzlz的博客](../_resources/4ecdccd5f2cd9189a2bf1521104e29e6.jpg)](http://jackzlz.iteye.com/)

[jackzlz](http://jackzlz.iteye.com/)

[![itcjiajia的博客](../_resources/5dc66808ee06680fde5f92226faf5f95.gif)](http://itcjiajia.iteye.com/)

[itcjiajia](http://itcjiajia.iteye.com/)

[![18642061206的博客](../_resources/5dc66808ee06680fde5f92226faf5f95.gif)](http://18642061206.iteye.com/)

[18642061206](http://18642061206.iteye.com/)

##### 博客专栏

 [![B2b19957-cda7-3a9e-83a0-418743feb0ca](../_resources/34d4557e5d2f9f0c9fa1104cc234a53e.jpg)](http://www.iteye.com/blogs/subjects/monitor)

 [监控应用服务器](http://www.iteye.com/blogs/subjects/monitor)
 浏览量：82407

 [![2e8be8be-e51f-346c-bcdd-12623c9aa820](../_resources/0721df97e3949e8af3c32f5f53d4761b.jpg)](http://www.iteye.com/blogs/subjects/web_develop)

 [Web前端开发](http://www.iteye.com/blogs/subjects/web_develop)
 浏览量：83222

 [![Bfa5df64-a623-34b9-85b8-ef3ce2aed758](../_resources/0721df97e3949e8af3c32f5f53d4761b.jpg)](http://www.iteye.com/blogs/subjects/java_error_resolve)

 [经典异常的解决](http://www.iteye.com/blogs/subjects/java_error_resolve)
 浏览量：142482

##### 文章分类

- [全部博客 (54)](http://yunzhu.iteye.com/)

- [监控应用服务器 (10)](http://yunzhu.iteye.com/category/146986)

- [应用服务器技术 (4)](http://yunzhu.iteye.com/category/168947)

- [数据库相关技术 (4)](http://yunzhu.iteye.com/category/147852)

- [Web前端开发 (8)](http://yunzhu.iteye.com/category/158909)

- [经典异常解决 (9)](http://yunzhu.iteye.com/category/155753)

- [Java常用工具类 (5)](http://yunzhu.iteye.com/category/215941)

- [多线程与并发 (2)](http://yunzhu.iteye.com/category/272533)

- [单元测试和TDD (2)](http://yunzhu.iteye.com/category/72834)

- [Shell和DOS相关 (3)](http://yunzhu.iteye.com/category/213760)

- [需求分析&架构设计 (1)](http://yunzhu.iteye.com/category/286971)

- [学习笔记整理 (1)](http://yunzhu.iteye.com/category/271628)

- [开源框架使用 (1)](http://yunzhu.iteye.com/category/317633)

- [RESTful Web Services (2)](http://yunzhu.iteye.com/category/332027)

- [缓存技术 (1)](http://yunzhu.iteye.com/category/323525)

- [有感而发 (4)](http://yunzhu.iteye.com/category/215948)

- [有奖试读 (3)](http://yunzhu.iteye.com/category/278312)

##### 社区版块

- [我的资讯](http://yunzhu.iteye.com/blog/news) (1)

- [我的论坛](http://yunzhu.iteye.com/blog/post) (341)

- [我的问答](http://yunzhu.iteye.com/blog/answered_problems) (266)

##### 存档分类

- [2015-05](http://yunzhu.iteye.com/blog/monthblog/2015-05) (1)

- [2015-01](http://yunzhu.iteye.com/blog/monthblog/2015-01) (2)

- [2014-09](http://yunzhu.iteye.com/blog/monthblog/2014-09) (1)

- [更多存档...](http://yunzhu.iteye.com/blog/monthblog_more)

##### 最新评论

- [小宇宙_WZY](http://1183106895.iteye.com/)：

 [项目部署到Tomat报异常：jar not loaded. See Servlet Spec 2.3, section 9.7.2. Offending ...](http://yunzhu.iteye.com/blog/1015416#bc2399221)

- [手机用户2240640595](http://201604064508.iteye.com/)： 如果楼主没有测试通过就不要分享出来害人，如果真心分享，请把整个 ...

 [操作Excel工具类（基于Apache的POI类库）](http://yunzhu.iteye.com/blog/1836696#bc2398856)

- [手机用户2240640595](http://201604064508.iteye.com/)： 浪费了几个小时，程序老是报空指针异常，不知道楼主是不是运行通过 ...

 [操作Excel工具类（基于Apache的POI类库）](http://yunzhu.iteye.com/blog/1836696#bc2398855)

- [手机用户2240640595](http://201604064508.iteye.com/)： 亲测，程序报空指针异常，代码没法用。

 [操作Excel工具类（基于Apache的POI类库）](http://yunzhu.iteye.com/blog/1836696#bc2398854)

- [忆梦昔年](http://2870347567.iteye.com/)： 服务器端用java，框架是ssh怎么接收

 [通过Ajax方式上传文件，使用FormData进行Ajax请求](http://yunzhu.iteye.com/blog/2177923#bc2397903)

* * *

声明：ITeye文章版权属于作者，受法律保护。没有作者书面许可不得转载。若作者同意转载，必须以超链接形式标明文章原始出处和作者。

© 2003-2017 ITeye.com. All rights reserved. [ 京ICP证110151号 京公网安备[110105010620](tel:110105010620) ]

 ![](http://stat.iteye.com/?url=http://yunzhu.iteye.com/blog/2177923&referrer=https://www.baidu.com/link?url=yDO2EJi39C1gQDQYH2EFCpTvhTNfEHhN1tLwWCCBayLDNMbCJYreF-q9L9qMMPh_&wd=&eqid=ffbd31860004b48c00000003597bd4a3&ie=utf-8&user_id=)
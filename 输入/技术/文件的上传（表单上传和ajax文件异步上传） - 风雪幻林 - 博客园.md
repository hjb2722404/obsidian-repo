文件的上传（表单上传和ajax文件异步上传） - 风雪幻林 - 博客园

[(L)](http://www.cnblogs.com/fengxuehuanlin/p/5311648.html)
[风雪幻林](http://www.cnblogs.com/fengxuehuanlin/)

##             永远保持自信，不管境遇如何，笑容，自信是最伟大的财富

[博客园](http://www.cnblogs.com/)  [首页](http://www.cnblogs.com/fengxuehuanlin/)  [新随笔](https://i.cnblogs.com/EditPosts.aspx?opt=1)  [联系](https://msg.cnblogs.com/send/%E9%A3%8E%E9%9B%AA%E5%B9%BB%E6%9E%97)    [管理](https://i.cnblogs.com/)

随笔-42  评论-4  文章-0

# [文件的上传（表单上传和ajax文件异步上传）](http://www.cnblogs.com/fengxuehuanlin/p/5311648.html)

#          项目中用户上传总是少不了的，下面就主要的列举一下表单上传和ajax上传！注意： **context.Request.Files不适合对大文件进行操作，下面列举的主要对于小文件上传的处理！**

**资源下载：**
**一.jQuery官方下载地址：https://jquery.com/download/**

**一.表单上传：**
**html客户端部分：**

<form action="upload.ashx" method="post" enctype="multipart/form-data"> 选择文件:<input type="file" name="file1"  /><br />  <input type="submit" value="上传"  />  </form>

**一般处理程序服务器端：**
[![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)]()
 public  void ProcessRequest(HttpContext context)
{
context.Response.ContentType = "text/plain";
HttpPostedFile file1 = context.Request.Files["file1"];

helper.uploadFile(file1, "~/upload/");//这里就是对相应方法进行调用 context.Response.Write("ok");//提示执行成功 }

[![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)]()
**上传代码的封装：**
[![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)]()

///  <summary>  /// 上传图片 ///  </summary>  ///  <param name="file">通过form表达提交的文件</param>  ///  <param name="virpath">文件要保存的虚拟路径</param>  public  static  void uploadImg(HttpPostedFile file,string virpath)

{ if (file.ContentLength > 1024 * 1024 * 4)
{ throw  new Exception("文件不能大于4M");

} string imgtype = Path.GetExtension(file.FileName); if(imgtype!=".jpg"&&imgtype!=".jpeg") //图片类型进行限制 { throw  new Exception("请上传jpg或JPEG图片");

} using (Image img = Bitmap.FromStream(file.InputStream))
{ string savepath = HttpContext.Current.Server.MapPath(virpath+file.FileName);
img.Save(savepath);
}

} ///  <summary>  /// 上传文件 ///  </summary>  ///  <param name="file">通过form表达提交的文件</param>  ///  <param name="virpath">文件要保存的虚拟路径</param>  public  static  void uploadFile(HttpPostedFile file, string virpath)

{ if (file.ContentLength > 1024 * 1024 * 6)
{ throw  new Exception("文件不能大于6M");

} string imgtype = Path.GetExtension(file.FileName); //imgtype对上传的文件进行限制  if (imgtype != ".zip" && imgtype != ".mp3")

{ throw  new Exception("只允许上传zip、rar....文件");

} string dirFullPath= HttpContext.Current.Server.MapPath(virpath); if (!Directory.Exists(dirFullPath))//如果文件夹不存在，则先创建文件夹 {

Directory.CreateDirectory(dirFullPath);
}
file.SaveAs(dirFullPath + file.FileName);
}
[![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)]()
**二.Ajax文件异步上传：**

 注明：既然有了表单上传为什么又要ajax上传呢？因为表单上传过程中，整个页面就刷新了！ajax异步上传就可以达到只刷新局部位置，下面就简单看看ajax上传吧！

**html客户端部分：**
[![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)]()
<head>  <script src="jquery-2.1.4.js"></script>  <script> $(function () {
$("#upload").click(function () {
$("#imgWait").show(); var formData =  new FormData();
formData.append("myfile", document.getElementById("file1").files[0]); $.ajax({
url: "upload.ashx",
type: "POST",
data: formData, /**
*必须false才会自动加上正确的Content-Type */ contentType: false, /**
* 必须false才会避开jQuery对 formdata 的默认处理
* XMLHttpRequest会对 formdata 进行正确的处理 */ processData: false,
success: function (data) { if (data.status ==  "true") {
alert("上传成功！");
} if (data.status ==  "error") {
alert(data.msg);
}
$("#imgWait").hide();
},
error: function () {
alert("上传失败！");
$("#imgWait").hide();
}
});
});

}); </script></head><body> 选择文件:<input type="file" id="file1"  /><br />  <input type="button" id="upload" value="上传"  />  <img src="wait.gif" style="display:none" id="imgWait"  /> </body>

[![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)]()

**一般处理程序服务器端：**
[![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)]()
public  void ProcessRequest(HttpContext context)
{

context.Response.ContentType = "text/html"; if (context.Request.Files.Count > 0)

{
HttpPostedFile file1 = context.Request.Files["myfile"];

helper.uploadFile(file1, "~/upload/"); //这里引用的是上面封装的方法 WriteJson(context.Response, "true", "");

} else {
WriteJson(context.Response, "error", "请选择要上传的文件");
}
}
[![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)]()
**json代码封装：**
[![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)]()

public  static  void WriteJson(HttpResponse response, string status1, string msg1, object data1 = null)

{

response.ContentType = "application/json"; var obj = new { status = status1, msg = msg1, data = data1 }; string json = new JavaScriptSerializer().Serialize(obj);

response.Write(json);
}
[![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)]()

分类: [Asp.net（旧版）](http://www.cnblogs.com/fengxuehuanlin/category/745753.html)

标签: [常用功能](http://www.cnblogs.com/fengxuehuanlin/tag/%E5%B8%B8%E7%94%A8%E5%8A%9F%E8%83%BD/)

 [好文要顶]()  [关注我]()  [收藏该文]()  [![](../_resources/c5fd93bfefed3def29aa5f58f5173174.png)]()  [![](../_resources/24de3321437f4bfd69e684e353f2b765.png)]()

 [![](../_resources/b20eee3cae4c322870e5231aa8ebb5ea.jpg)](http://home.cnblogs.com/u/fengxuehuanlin/)

 [风雪幻林](http://home.cnblogs.com/u/fengxuehuanlin/)
 [关注 - 35](http://home.cnblogs.com/u/fengxuehuanlin/followees)
 [粉丝 - 6](http://home.cnblogs.com/u/fengxuehuanlin/followers)

 [+加关注]()

 3

 1

[«](http://www.cnblogs.com/fengxuehuanlin/p/5275381.html) 上一篇：[生成验证码封装（新版）](http://www.cnblogs.com/fengxuehuanlin/p/5275381.html)

[»](http://www.cnblogs.com/fengxuehuanlin/p/5313354.html) 下一篇：[Razor模板引擎](http://www.cnblogs.com/fengxuehuanlin/p/5313354.html)

posted on 2016-03-23 16:16  [风雪幻林](http://www.cnblogs.com/fengxuehuanlin/) 阅读(23901) 评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=5311648)  [收藏](http://www.cnblogs.com/fengxuehuanlin/p/5311648.html#)

[(L)](http://www.cnblogs.com/fengxuehuanlin/p/5311648.html)

[(L)](http://www.cnblogs.com/fengxuehuanlin/p/5311648.html)

[刷新评论]()[刷新页面](http://www.cnblogs.com/fengxuehuanlin/p/5311648.html#)[返回顶部](http://www.cnblogs.com/fengxuehuanlin/p/5311648.html#top)

注册用户登录后才能发表评论，请 [登录]() 或 [注册]()，[访问](http://www.cnblogs.com/)网站首页。

[【推荐】50万行VC++源码: 大型组态工控、电力仿真CAD与GIS源码库](http://www.ucancode.com/index.htm)

[【免费】从零开始学编程，开发者专属实验平台免费实践！](https://cloud.tencent.com/developer/labs?fromSource=gwzcw.241259.241259.241259)

[【推荐】现在注册又拍云，首月可享 200G CDN流量，还可免费申请 SSL 证书](https://console.upyun.com/register/?invite=H124C2iMZ)

[【推荐】阿里云“全民云计算”优惠升级](http://click.aliyun.com/m/18488/)

[![Udacity 07.27-08.03](../_resources/96e7ee37303e767b26850d3b72ca3054.png)](http://cn.udacity.com/fend/?utm_source=cnblogs&utm_medium=banner&utm_campaign=FEND06)

**最新IT新闻**:
· [微软开始在Photos应用程序中推出AI人工智能图像搜索](http://news.cnblogs.com/n/574874/)
· [易到司机提现延期背后：或因乐视想甩锅14亿债务遭拒](http://news.cnblogs.com/n/574872/)
· [苹果林业计划收获100%的纸张耗材供应](http://news.cnblogs.com/n/574871/)
· [夏普连续三个季度盈利 富士康削减成本措施奏效](http://news.cnblogs.com/n/574870/)
· [中兴上半年净利同比大增近30% 内部合规治理初见成效](http://news.cnblogs.com/n/574869/)
» [更多新闻...](http://news.cnblogs.com/)

[![极光推广_0701](../_resources/1bf1cad20faf0b0d29959f97f458f7c3.png)](https://www.jiguang.cn/devservice?source=bky&hmsr=%E5%8D%9A%E5%AE%A2%E5%9B%AD&hmpl=&hmcu=&hmkw=&hmci=)

**最新知识库文章**:
· [小printf的故事：什么是真正的程序员？](http://kb.cnblogs.com/page/570194/)
· [程序员的工作、学习与绩效](http://kb.cnblogs.com/page/569992/)
· [软件开发为什么很难](http://kb.cnblogs.com/page/569056/)
· [唱吧DevOps的落地，微服务CI/CD的范本技术解读](http://kb.cnblogs.com/page/565901/)
· [程序员，如何从平庸走向理想？](http://kb.cnblogs.com/page/566523/)
» [更多知识库文章...](http://kb.cnblogs.com/)

昵称：[风雪幻林](http://home.cnblogs.com/u/fengxuehuanlin/)
园龄：[2年2个月](http://home.cnblogs.com/u/fengxuehuanlin/)
粉丝：[6](http://home.cnblogs.com/u/fengxuehuanlin/followers/)
关注：[35](http://home.cnblogs.com/u/fengxuehuanlin/followees/)
[+加关注]()

|     |     |     |
| --- | --- | --- |
| [<]() | 2017年7月 | [>]() |

日
一
二
三
四
五
六
25
26
27
28
29
30
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
1
2
3
4
5

### 随笔分类

- [1. C#基础(6)](http://www.cnblogs.com/fengxuehuanlin/category/915720.html)
- [2. 设计模式(5)](http://www.cnblogs.com/fengxuehuanlin/category/698769.html)
- [3. 在线支付(1)](http://www.cnblogs.com/fengxuehuanlin/category/963769.html)
- [4. 数据库操作设计(1)](http://www.cnblogs.com/fengxuehuanlin/category/963773.html)
- [5. 数据的加密解密(1)](http://www.cnblogs.com/fengxuehuanlin/category/968083.html)
- [6. EazyUI](http://www.cnblogs.com/fengxuehuanlin/category/970676.html)
- [Asp.net（旧版）(10)](http://www.cnblogs.com/fengxuehuanlin/category/745753.html)
- [C#基础部分(旧版)(8)](http://www.cnblogs.com/fengxuehuanlin/category/696778.html)
- [C#面向对象编程（旧版）(3)](http://www.cnblogs.com/fengxuehuanlin/category/813221.html)
- [C#算法(2)](http://www.cnblogs.com/fengxuehuanlin/category/746327.html)
- [加密与解密(1)](http://www.cnblogs.com/fengxuehuanlin/category/798163.html)
- [数据传输和解析(1)](http://www.cnblogs.com/fengxuehuanlin/category/847497.html)
- [数据结构(1)](http://www.cnblogs.com/fengxuehuanlin/category/819745.html)

### 随笔档案

- [2017年6月 (1)](http://www.cnblogs.com/fengxuehuanlin/archive/2017/06.html)
- [2017年3月 (8)](http://www.cnblogs.com/fengxuehuanlin/archive/2017/03.html)
- [2016年7月 (3)](http://www.cnblogs.com/fengxuehuanlin/archive/2016/07.html)
- [2016年5月 (1)](http://www.cnblogs.com/fengxuehuanlin/archive/2016/05.html)
- [2016年4月 (6)](http://www.cnblogs.com/fengxuehuanlin/archive/2016/04.html)
- [2016年3月 (12)](http://www.cnblogs.com/fengxuehuanlin/archive/2016/03.html)
- [2015年12月 (1)](http://www.cnblogs.com/fengxuehuanlin/archive/2015/12.html)
- [2015年11月 (1)](http://www.cnblogs.com/fengxuehuanlin/archive/2015/11.html)
- [2015年10月 (3)](http://www.cnblogs.com/fengxuehuanlin/archive/2015/10.html)
- [2015年6月 (6)](http://www.cnblogs.com/fengxuehuanlin/archive/2015/06.html)

Powered by: [博客园](http://www.cnblogs.com/)模板提供：[沪江博客](http://blog.hjenglish.com/)Copyright ©2017 风雪幻林
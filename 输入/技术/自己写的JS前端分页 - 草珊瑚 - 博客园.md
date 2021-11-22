自己写的JS前端分页 - 草珊瑚 - 博客园

# [自己写的JS前端分页](http://www.cnblogs.com/samwu/archive/2012/03/25/2416988.html)

[![复制代码](自己写的JS前端分页%20-%20草珊瑚%20-%20博客园.md#)

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的分页</title>
<script type="text/javascript" src="jquery-1.7.1.js"></script>
<script type="text/javascript">
$(function(){
    var pageArray = [];

    var liCount = $('li').length;//获取获取记录条数
    var PageSize  = 10;//设置每页，你准备显示几条
    var PageCount  = Math.ceil(liCount/PageSize);//计算出总共页数
    var currentPage = 1;//设置当前页

    var i=0;
    for(i=1; i<=PageCount; i++){

        $('<a href="#" pageNum="'+i+'" >第'+i+'页</a>').appendTo('#pageIt');//显示分页按钮

    }

    var $li =  $('li');
    $li.each(function(){
        pageArray.push(this);
    });

    for(i=0;i<10;i++){
        $('#pagingList').append(pageArray[i]);
    }

    function showPage(whichPage){
        $('#pagingList').html('');
        for(i = (whichPage-1)*10; i < 10*whichPage ; i++){
            $('#pagingList').append(pageArray[i]);
        }
    }
    var a;
    $('a').click(function(){
        a = $(this).attr('pagenum');
        showPage(a);
    })

    debugger;
});
</script>
</head>

<body>
<div id="pageIt" ></div>
<div id="pagingList"></div>
<br /><br /><br /><br /><br />
<ul id="list" >

<li class="mm">美女A</li>
<li class="gg">帅哥A</li>
<li class="mm">美女B</li>
<li class="gg">帅哥B</li>
<li class="mm">美女C</li>
<li class="gg">帅哥C</li>
<li class="mm">美女D</li>
<li class="gg">帅哥D</li>
<li class="mm">美女E</li>

<li class="gg">帅哥E</li>
<li class="mm">美女F</li>
<li class="gg">帅哥F</li>
<li class="mm">美女G</li>
<li class="gg">帅哥G</li>
<li class="mm">美女H</li>
<li class="gg">帅哥H</li>
<li class="mm">美女A</li>
<li class="gg">帅哥A</li>

<li class="mm">美女B</li>
<li class="gg">帅哥B</li>
<li class="mm">美女C</li>
<li class="gg">帅哥C</li>
<li class="mm">美女D</li>
<li class="gg">帅哥D</li>
<li class="mm">美女E</li>
<li class="gg">帅哥E</li>
<li class="mm">美女F</li>

<li class="gg">帅哥F</li>
<li class="mm">美女G</li>
<li class="gg">帅哥G</li>
<li class="mm">美女H</li>
<li class="gg">帅哥H</li>
<li class="mm">美女A</li>
<li class="gg">帅哥A</li>
<li class="mm">美女B</li>
<li class="gg">帅哥B</li>

<li class="mm">美女C</li>
<li class="gg">帅哥C</li>
<li class="mm">美女D</li>
<li class="gg">帅哥D</li>
<li class="mm">美女E</li>
<li class="gg">帅哥E</li>
<li class="mm">美女F</li>
<li class="gg">帅哥F</li>
<li class="mm">美女G</li>

<li class="gg">帅哥G</li>
<li class="mm">美女H</li>
<li class="gg">帅哥H</li>
<li class="mm">美女A</li>
<li class="gg">帅哥A</li>
<li class="mm">美女B</li>
<li class="gg">帅哥B</li>
<li class="mm">美女C</li>
<li class="gg">帅哥C</li>

<li class="mm">美女D</li>
<li class="gg">帅哥D</li>
<li class="mm">美女E</li>
<li class="gg">帅哥E</li>
<li class="mm">美女F</li>
<li class="gg">帅哥F</li>
<li class="gg">帅哥G</li>
<li class="gg">帅哥H</li>
<li class="gg">帅哥G</li>

</ul>
</body>
</html>
[![复制代码](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)

* * *

合乎自然而生生不息。。。

分类: [动人的JavaScript](http://www.cnblogs.com/samwu/category/346719.html)

[好文要顶](自己写的JS前端分页%20-%20草珊瑚%20-%20博客园.md#)[关注我](自己写的JS前端分页%20-%20草珊瑚%20-%20博客园.md#)[收藏该文](自己写的JS前端分页%20-%20草珊瑚%20-%20博客园.md#)[![icon_weibo_24.png](自己写的JS前端分页%20-%20草珊瑚%20-%20博客园.md#)[![wechat.png](自己写的JS前端分页%20-%20草珊瑚%20-%20博客园.md#)

[![u27364.jpg](../_resources/feb9234b6587b87abfa793f8e54df390.jpg)](http://home.cnblogs.com/u/samwu/)

[草珊瑚](http://home.cnblogs.com/u/samwu/)
[关注 - 41](http://home.cnblogs.com/u/samwu/followees)
[粉丝 - 204](http://home.cnblogs.com/u/samwu/followers)

 [+加关注](自己写的JS前端分页%20-%20草珊瑚%20-%20博客园.md#)

 0
0

(请您对文章做出评价)

[«](http://www.cnblogs.com/samwu/archive/2012/03/14/2395725.html) 上一篇：[bootstrap2.02 notice](http://www.cnblogs.com/samwu/archive/2012/03/14/2395725.html)

[»](http://www.cnblogs.com/samwu/archive/2012/03/26/2417692.html) 下一篇：[jQuery使用感](http://www.cnblogs.com/samwu/archive/2012/03/26/2417692.html)

posted @ 2012-03-25 20:39  [草珊瑚](http://www.cnblogs.com/samwu/) 阅读(4617) 评论(1) [编辑](http://i.cnblogs.com/EditPosts.aspx?postid=2416988)  [收藏](http://www.cnblogs.com/samwu/archive/2012/03/25/2416988.html#)
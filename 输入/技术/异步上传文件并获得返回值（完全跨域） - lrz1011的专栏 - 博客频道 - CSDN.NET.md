异步上传文件并获得返回值（完全跨域） - lrz1011的专栏 - 博客频道 - CSDN.NET

#   [异步上传文件并获得返回值（完全跨域）](http://blog.csdn.net/lrz1011/article/details/7913992)

.

  标签： [upload](http://www.csdn.net/tag/upload)[iframe](http://www.csdn.net/tag/iframe)[file](http://www.csdn.net/tag/file)[action](http://www.csdn.net/tag/action)[input](http://www.csdn.net/tag/input)[优化](http://www.csdn.net/tag/%e4%bc%98%e5%8c%96)

 2012-08-27 22:25  8156人阅读    [评论](http://blog.csdn.net/lrz1011/article/details/7913992#comments)(0)    [收藏](异步上传文件并获得返回值（完全跨域）%20-%20lrz1011的专栏%20-%20博客频道%20-%20CSDN.NET.md#)    [举报](http://blog.csdn.net/lrz1011/article/details/7913992#report)

 .

 ![category_icon.jpg](../_resources/760c5ec8c68b26ded5d32a15a75b0d4b.jpg)  分类：

   Web前端技术*（5）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

 .

**[java]**  [view plain](http://blog.csdn.net/lrz1011/article/details/7913992#)[copy](http://blog.csdn.net/lrz1011/article/details/7913992#)

1. 异步上传文件并获得返回值（完全跨域）AJAX可以进行数据的异步请求，但对于文件和跨域问题却束手无策。
2.
3. Jsonp可以进行跨域数据的异步请求，但同样不能使用于文件。
4.
5. <form>表单可以进行跨域数据和文件的上传，但却会使页面跳转。
6.
7. 那么如何同时实现“异步”+“跨域”+“文件”+“返回值”这几个特性呢？方法如下：
8.
9. 原理：
10.

11. 将<form>表单通过一个iframe来submit，也就是将<form>的target属性设置为一个iframe的id，这样<form>的action URL就会在这个iframe中

12.
13. 打开，那么服务器的返回数据也就会输出到iframe中了。最后再通过主页面也iframe之间的交互完成对返回数据的读取（这涉及到跨域问题，
14.
15. 文章后面将介绍此问题的解决方法）。
16.
17.
18.
19. 基本结构：
20.
21. 前端部分（当前域名：www.test.com，与form中的action域名相同）
22.
23.

24. <form action="http://www.test.com/io.php" method="POST" enctype="multipart/form-data" target="upload">

25.
26.         <input type="file" name="upload_file" />
27.
28.         <input type="submit" value="开始上传" />
29.
30. </form>
31.

32. <iframe name="upload" style="display:none"></iframe> //注意，是name="upload"，而不是id="upload"

33.
34. 后台部分
35.
36. <?php
37.

38.         move_uploaded_file($_FILES['upload_file']['tmp_name'],'upload/' . $_FILES['upload_file']['name']); //存储上传的文件

39.
40.
41.         echo 'This data is from server!'; //返回数据，这行字将输出到iframe的body中
42.
43.
44. ?>
45.
46. 优化结构一：
47.
48. 前端部分（当前域名：a.test.com，与form中的action域名不同）
49.

50. <form action="http://b.test.com/io.php" method="POST" enctype="multipart/form-data" target="upload">

51.
52.         <input type="file" name="upload_file" />
53.

54.         <input type="text" name="script" value="http://a.test.com/JS/iframe_control.src.js" style="display:none" /> //注意这里！

55.
56.
57.         <input type="submit" value="开始上传" />
58.
59. </form>
60.

61. <iframe name="upload" style="display:none"></iframe> //注意，是name="upload"，而不是id="upload"

62.
63. <script type="text/javascript">
64.
65.         document.domain="test.com"; //解决与iframe之间的跨域问题
66.
67. </script>
68.
69. 后台部分
70.
71. <?php
72.

73.         move_uploaded_file($_FILES['upload_file']['tmp_name'],'upload/' . $_FILES['upload_file']['name']); //存储上传的文件

74.
75.
76.         $html = '<html><head>'
77.

78.                     . '<script src="' . $_POST['script'] .'" type="text/javascript"></script>' //注意这里！

79.
80.                     . '</head><body>'
81.

82.                     . 'This data is from server!' //返回数据，这行字将输出到iframe的body中

83.
84.                     . '</body></html>';
85.
86.         echo $html;
87.
88.
89. ?>
90.
91.

92. 通过上面的优化，iframe从服务器接收到的内容中就多了一条<script>标签，这个标签的src是由<form>表单提交的，也就是说这个js文件可

93.

94. 以放在任何域名下，并且通过修改该js的内容来制定这个iframe的功能。比如，在其中调用document.doain="test.com"后，便可以与主页面

95.
96. 互相通信与控制了（主页面中也调用了document.domain="test.com"，因此跨域限制被消除了）。
97.
98.
99. 优化结构二：
100.
101.
102. 前端部分（当前域名：www.a.com，与form中的action域名不同）
103.

104. <form action="http://www.b.com/io.php" method="POST" enctype="multipart/form-data" target="upload">

105.
106.         <input type="file" name="upload_file" />
107.

108.         <input type="text" name="tmpurl" value="http://www.a.com/tmp.html" style="display:none" /> //注意这里！

109.
110.
111.         <input type="submit" value="开始上传" />
112.
113. </form>
114.

115. <iframe name="upload" style="display:none"></iframe> //注意，是name="upload"，而不是id="upload"

116.
117. 这次我们没有看到<script>标签，因为不再需要了，请继续看后台代码：
118.
119.
120. 后台部分
121.
122. <?php
123.

124.         move_uploaded_file($_FILES['upload_file']['tmp_name'],'upload/' . $_FILES['upload_file']['name']); //存储上传的文件

125.
126.         $data = 'This data is from server!' //返回数据，这行字将通过URL返回给浏览器
127.
128.

129.         header('Location:' . $_POST['tmpurl'] . '?data=' . $_data); //上传完成后使iframe直接跳转至$_POST['tmpurl']

130.
131. ?>
132.
133.

134. 与优化结构一不同的是，结构二中不再使用“指定document.domain为一级域名”来解除跨域限制，也不通过iframe的document内容来得到返

135.

136. 回数据，而是通过使iframe直接跳转至当前域名（通过$_POST['tmpurl']指定）来彻底取消跨域限制并且通过url的search部分传递返回数据。

137.
138. 两种结构的对比：
139.
140. 跨域：优化结构一只可解决一级域名相同的情况下的跨域情况，而优化结构二可解决任何跨域，比如百度与google之间。
141.
142. 数据：优化结构一的返回数据无大小限制，而优化结构二的返回数据必须小于2K（因为数据是通过RUL传输的）。

[(L)](http://blog.csdn.net/lrz1011/article/details/7913992#)[(L)](http://blog.csdn.net/lrz1011/article/details/7913992#)[(L)](http://blog.csdn.net/lrz1011/article/details/7913992#)[(L)](http://blog.csdn.net/lrz1011/article/details/7913992#)[(L)](http://blog.csdn.net/lrz1011/article/details/7913992#)[(L)](http://blog.csdn.net/lrz1011/article/details/7913992#).

- 上一篇[跨域文件上传解决方案](http://blog.csdn.net/lrz1011/article/details/7913962)

- 下一篇[js跨域](http://blog.csdn.net/lrz1011/article/details/7913998)

.

顶

0

踩

0

 .

#### 我的同类文章

   Web前端技术*（5）*

- *•*[JS跨域请求简析](http://blog.csdn.net/lrz1011/article/details/7835352)

- *•*[Iframe 标签详解](http://blog.csdn.net/lrz1011/article/details/7913940)

- *•*[js跨域](http://blog.csdn.net/lrz1011/article/details/7913998)

- *•*[iframe无刷新跨域上传文件并获取返回值](http://blog.csdn.net/lrz1011/article/details/7913902)

- *•*[跨域文件上传解决方案](http://blog.csdn.net/lrz1011/article/details/7913962)
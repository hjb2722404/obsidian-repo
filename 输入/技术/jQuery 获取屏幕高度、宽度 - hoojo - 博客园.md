jQuery 获取屏幕高度、宽度 - hoojo - 博客园

# [jQuery 获取屏幕高度、宽度](https://www.cnblogs.com/hoojo/archive/2012/02/16/2354663.html)

做手机Web开发做浏览器兼容用到了，所以在网上找了些汇总下。

alert($(window).height()); //浏览器当前窗口可视区域高度
alert($(document).height()); //浏览器当前窗口文档的高度
alert($(document.body).height());//浏览器当前窗口文档body的高度

alert($(document.body).outerHeight(true));//浏览器当前窗口文档body的总高度 包括border padding margin

alert($(window).width()); //浏览器当前窗口可视区域宽度
alert($(document).width());//浏览器当前窗口文档对象宽度
alert($(document.body).width());//浏览器当前窗口文档body的高度

alert($(document.body).outerWidth(true));//浏览器当前窗口文档body的总宽度 包括border padding margin

// 获取页面的高度、宽度
function getPageSize() {
 var xScroll, yScroll;
 if (window.innerHeight && window.scrollMaxY) {
xScroll = window.innerWidth + window.scrollMaxX;
yScroll = window.innerHeight + window.scrollMaxY;
} else {

 if (document.body.scrollHeight > document.body.offsetHeight) { // all but Explorer Mac

xScroll = document.body.scrollWidth;
yScroll = document.body.scrollHeight;

} else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari

xScroll = document.body.offsetWidth;
yScroll = document.body.offsetHeight;
}
}
 var windowWidth, windowHeight;
 if (self.innerHeight) { // all except Explorer
 if (document.documentElement.clientWidth) {
windowWidth = document.documentElement.clientWidth;
} else {
windowWidth = self.innerWidth;
}
windowHeight = self.innerHeight;
} else {

 if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode

windowWidth = document.documentElement.clientWidth;
windowHeight = document.documentElement.clientHeight;
} else {
 if (document.body) { // other Explorers
windowWidth = document.body.clientWidth;
windowHeight = document.body.clientHeight;
}
}
}
 // for small pages with total height less then height of the viewport
 if (yScroll < windowHeight) {
pageHeight = windowHeight;
} else {
pageHeight = yScroll;
}
 // for small pages with total width less then width of the viewport
 if (xScroll < windowWidth) {
pageWidth = xScroll;
} else {
pageWidth = windowWidth;
}
arrayPageSize = new Array(pageWidth, pageHeight, windowWidth, windowHeight);
 return arrayPageSize;
}

// 滚动条
document.body.scrollTop;
$(document).scrollTop();

[版权所有，转载请注明出处](http://hoojo.cnblogs.com/)[本文出自：](http://hoojo.cnblogs.com/)

 [![](http://s.shareto.com.cn/btn/lg-share-cn.gif)版权所有，欢迎转载，转载请注明出处，谢谢](http://hoojo.cnblogs.com/)

分类: [Ajax【富客户端技术】](https://www.cnblogs.com/hoojo/category/276233.html), [JavaScript](https://www.cnblogs.com/hoojo/category/276246.html), [jQuery](https://www.cnblogs.com/hoojo/category/276249.html)

 [好文要顶](jQuery%20获取屏幕高度、宽度%20-%20hoojo%20-%20博客园.md#)  [关注我](jQuery%20获取屏幕高度、宽度%20-%20hoojo%20-%20博客园.md#)  [收藏该文](jQuery%20获取屏幕高度、宽度%20-%20hoojo%20-%20博客园.md#)  [![icon_weibo_24.png](jQuery%20获取屏幕高度、宽度%20-%20hoojo%20-%20博客园.md#)  [![wechat.png](jQuery%20获取屏幕高度、宽度%20-%20hoojo%20-%20博客园.md#)

 [![u151517.jpg](../_resources/4723103257684852cedced95d01d9a47.jpg)](https://home.cnblogs.com/u/hoojo/)

 [hoojo](https://home.cnblogs.com/u/hoojo/)
 [关注 - 1](https://home.cnblogs.com/u/hoojo/followees/)
 [粉丝 - 1955](https://home.cnblogs.com/u/hoojo/followers/)

 [+加关注](jQuery%20获取屏幕高度、宽度%20-%20hoojo%20-%20博客园.md#)

 16

 0

 [«](https://www.cnblogs.com/hoojo/archive/2012/02/14/2350782.html) 上一篇： [Rational Rose 2003 下载、破解及安装方法（图文）](https://www.cnblogs.com/hoojo/archive/2012/02/14/2350782.html)

 [»](https://www.cnblogs.com/hoojo/archive/2012/02/17/2355384.html) 下一篇： [NoSQL 之 Morphia 操作 MongoDB](https://www.cnblogs.com/hoojo/archive/2012/02/17/2355384.html)

posted on 2012-02-16 17:43 [hoojo](https://www.cnblogs.com/hoojo/)  阅读(265275)  评论(3) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=2354663) [收藏](jQuery%20获取屏幕高度、宽度%20-%20hoojo%20-%20博客园.md#)
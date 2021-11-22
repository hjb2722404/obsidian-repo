HTMLElement.offsetParent（offsetLeft和offsetTop参照offsetParent的内边距边界） - 本人小白 - 博客园

#   [HTMLElement.offsetParent（offsetLeft和offsetTop参照offsetParent的内边距边界）](https://www.cnblogs.com/xiaohaodeboke/p/12323957.html)

IE7以上（不是火狐）：
　　父级没有定位：
　　　　本身没有定位：
　　　　　　==> offsetParent:body
　　　　本身定位为：absolute/relative:
　　　　　　==> offsetParent:body

　　父级有定位:
　　　　本身没有定位:
　　 　　　　==> offsetParent:定位父级
　　　　本身定位为：absolute/relative:
　　　　　 　==> offsetParent:定位父级
　　　　本身定位为: fixed
　　　　　　==> offsetParent: null

火狐
　　父级没有定位：
　　　　本身没有定位:
　　　　　　==> offsetParent:body
　　　　本身定位为: absolute/relative:
　　　　　　==> offsetParent:body
　　　　本身定位为:fixed
　　　　　　==> offsetParent:body
　　父级有定位：
　　　　本身没有定位:
　　　　　　==> offsetParent:定位父级
　　　　本身定位为: absolute/relative:
　　　　　　==> offsetParent:定位父级
　　　　本身定位为:fixed
　　　　　　==> offsetParent:body

IE7以下：
　　父级没有定位：
　　　　本身没有定位：
　　　　　　==>offsetParent:body
　　　　本身定位为absolute/relative
　　　　　　==>offsetParent:body
　　　　本身定位为fixd
　　　　　　==>offsetParent:null
　　　父级有定位：
　　　　本身没有定位：
　　　　　　==>offsetParent:定位父级
　　　　本身定位为absolute/relative
　　　　　　==>offsetParent:定位父级
　　　　本身定位为fixd
　　　　　　==>offsetParent:null

总结:
　　offsetParent有点类似CSS中的包含块的概念
　　offsetLeft，offsetTop 都是参照于offsetParent的内边距边界

　　offsetParent(  ***前提条件：body和html之间的margin被清掉 ******  ***)
　　本身定位为fixed：
　　　　==> offsetParent: null( IE7以上（不是火狐） )
　　　　==> offsetParent:body(火狐浏览器)
　　本身定位不为fixed：
　　　　父级没有定位：
　　　　　　==> offsetParent：body
　　　　父级有定位：
　　　　　　==> offsetParent:定位父级
haslayout
　　IE7以下，如果当前元素的某个父级触发了haslayout，
　　　　那么offsetParent就会指向到这个layout特性的父结点上

拓展 ：
       offsetWidth,offsetHeight     ==>     border-box
　　clientWidth,clientHeight      ==>    padding-box

　　js的兼容性问题：
　　　　ev  || event
　　　　offsetParent
　　　　事件绑定（事件流的机制，事件委托）
　　　　鼠标滚轮事件：
　　　　　　非火狐：onmousewhell(dom0)
　　　　　　　　ev.whellDelta
　　　　　　　　　　上：正，下:负
　　　　　　火狐:DOMouseScroll(dom2)
　　　　　　　　ev.detail
　　　　　　　　　　上：负，下：正
　　　　　　怎么取消事件的默认行为：
　　　　　　　　dom0:return false
　　　　　　　　dom2:ev.preventDefault()

　　绝对位置：
　　　　到body的距离(html和body之间的margin被清除)
　　　　　　原生实现：while循环不断地累加

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
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]  [object Object][object Object][object Object]
[object Object][object Object]  [object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object]  [object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object]
[object Object]
[object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]  [object Object][object Object]  [object Object][object Object][object Object]

[object Object][object Object][object Object]  [object Object][object Object]  [object Object][object Object][object Object]

[object Object][object Object][object Object]  [object Object][object Object]  [object Object][object Object][object Object]

[object Object][object Object][object Object]  [object Object][object Object]  [object Object][object Object][object Object]

[object Object][object Object][object Object]  [object Object][object Object]  [object Object][object Object][object Object]

[object Object][object Object]
[object Object]
[object Object]

　　　　　　　　body的offsetParent==>null
　　　　　　　　body的offsetLeft==>0
　　　　　　　　body的offsetTop==>0
　　　　　　　原生实现的缺点：没有办法兼容border和margin
　　　相对位置：
　　　　原生实现：
　　　　　　绝对位置的实现上减去滚动条滚动的距离

　　　　　　　　document.documentElement.scrollLeft || document.body.scrollLeft;(不同浏览器滚动条的父级不一样)

　　　　　　原生实现的缺点：没办法兼容border和margin

　　　　getBoundingClientRect（兼容性极好）
　　　　返回值：对象
　　　　　　{
　　　　　　width:boder-box 的宽
　　　　　　height:boder-box的高
　　　　　　// 元素border-box的左上角的相对位置
　　　　　　top:y,
　　　　　　left:x,
　　　　　　//元素border-box的右下角的相对位置
　　　　　　bottom:
　　　　　　right:
　　　　　　}

　　　　offsetWidth/Height，（可视区域）+border   即 border-box
　　　　clientWidth/Height, (可视区域 即padding-box)

　　　　获取视口的宽度：
　　　　document.documentElement.clientWidth
注意：
　　window.onload = function(){
　　　　//根标签的clientWidth（document.documentElement.clientWidth）并不是可视区域的宽度，而是视口的宽度
                var w = document.documentElement.clientWidth;
                var w2 = document.documentElement.offsetWidth;
                console.log(w,w2);
            }

　　在IE10及IE10以下 ， 根标签的 clientWidth 和 offsetWidth 统一被指定为视口的宽度。

 [好文要顶](HTMLElement.offsetParent（offsetLeft和offsetTop参照off.md#)  [关注我](HTMLElement.offsetParent（offsetLeft和offsetTop参照off.md#)  [收藏该文](HTMLElement.offsetParent（offsetLeft和offsetTop参照off.md#)  [![icon_weibo_24.png](HTMLElement.offsetParent（offsetLeft和offsetTop参照off.md#)  [![wechat.png](HTMLElement.offsetParent（offsetLeft和offsetTop参照off.md#)

 [![20200304122928.png](../_resources/cc98781f6b9b163d569e0e5133f9ac5a.jpg)](https://home.cnblogs.com/u/xiaohaodeboke/)

 [本人小白](https://home.cnblogs.com/u/xiaohaodeboke/)
 [关注 - 0](https://home.cnblogs.com/u/xiaohaodeboke/followees/)
 [粉丝 - 0](https://home.cnblogs.com/u/xiaohaodeboke/followers/)

 [+加关注](HTMLElement.offsetParent（offsetLeft和offsetTop参照off.md#)

 0

 0

 [«](https://www.cnblogs.com/xiaohaodeboke/p/12322164.html) 上一篇： [alert警告框点击确定后自动提交表单](https://www.cnblogs.com/xiaohaodeboke/p/12322164.html)

 [»](https://www.cnblogs.com/xiaohaodeboke/p/12340932.html) 下一篇： [Pycharm默认快捷键](https://www.cnblogs.com/xiaohaodeboke/p/12340932.html)

posted @ 2020-02-17 22:03 [本人小白](https://www.cnblogs.com/xiaohaodeboke/)  阅读(61)  评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=12323957) [收藏](HTMLElement.offsetParent（offsetLeft和offsetTop参照off.md#)
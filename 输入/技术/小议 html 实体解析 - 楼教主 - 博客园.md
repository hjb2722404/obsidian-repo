小议 html 实体解析 - 楼教主 - 博客园

#   [小议 html 实体解析](https://www.cnblogs.com/52cik/p/js-entity.html)

今天分享个小技巧，是群里一个朋友问的，"请问 &#43; 这种类型的字符串怎么转换成我们想要的字符 + ，有什么简便的js方法吗"
其实问题说简单也简单，说难也难。我们要分情况来描述问题解决问题才行。

## 一. 纯数字实体编码

就例如 &#43; &#44; 这样的，那么借助 正则+fromCharCode 即可。
[文本]()[运行]()
var str = "&#43; &#44; &#45;";

str = str.replace(/&#(\d+);/g, function(m, num){return  String.fromCharCode(num);

});
console.log(str);
这样可以得到我们想要的结果。
但是如果是其他情况呢？

## 二. 实体名，数字，十六进制实体编码

如 "&amp;&#X20;&copy;&nbsp;&hearts;&#32;&#43;" 这样，有实体名，x20 空格字符的16进制和 32 空格的十进制。。

这样的，怎么玩？
刚刚那个只能识别十进制数字的实体。
如果不包含“实体名”的话，还是比较方便的，正则多匹配个x即可，如果有x，就解析16进制然后 fromCharCode 就OK了。
但是实体名就真的没办法躲过去了，只能去w3c上把所有实体搞下来做个k/v对象用。
这肯定不是理想的解决方案。

## 三. 利用节点解析

首先用 jQuery 来做个实验。
[文本]()[运行]()
var str = "&amp;&#X20;&copy;&nbsp;&hearts;&#32;&#43;";
str = $("<p>").html(str).text();
console.log(str);
可以看到，确实解析了，说明这样是思路是可行的。
下面给个非 jQuery 的好了，方便各种情况使用。
[文本]()[运行]()

var entity = function  (node) {  return  function  (str) { node.innerHTML = str; return node.innerText;

}

}(document.createElement("p"));var str = "&amp;&#X20;&copy;&nbsp;&hearts;&#32;&#43;";

console.log( entity(str) );
 缺陷：
当然好东西都是双刃剑，有好的一面，自然也有弊端。
比如你原先有html标签的，用节点解析的话，标签就都没了，只剩下干干净净的文本了。
所以按需使用。。

## 四. 总结

正则+fromCharCode 可以解析十进制十六进制的html实体，甚至可以在任何js环境下用，比如 node wsh 等等。。
但缺点也很明显，如果解析实体名的实体，只能收集所有实体名了。
createElement 实现的可以解析任何实体，但是只能借助dom实现，
node下也要加载dom之类的插件才行，wsh下有微软提供的htmlfile这样的com，实现起来还是轻松的。
也不是什么大缺陷，只是不能原生js实现。。
看需求取舍吧。

分类: [JavaScript](https://www.cnblogs.com/52cik/category/483184.html)
标签: [js](https://www.cnblogs.com/52cik/tag/js/)

 [好文要顶](小议%20html%20实体解析%20-%20楼教主%20-%20博客园.md#)  [关注我](小议%20html%20实体解析%20-%20楼教主%20-%20博客园.md#)  [收藏该文](小议%20html%20实体解析%20-%20楼教主%20-%20博客园.md#)  [![icon_weibo_24.png](小议%20html%20实体解析%20-%20楼教主%20-%20博客园.md#)  [![wechat.png](小议%20html%20实体解析%20-%20楼教主%20-%20博客园.md#)

 [![20130524160955.png](../_resources/2c43faff3de8a300c5e3c961f6a9f8b9.jpg)](https://home.cnblogs.com/u/52cik/)

 [楼教主](https://home.cnblogs.com/u/52cik/)
 [关注 - 33](https://home.cnblogs.com/u/52cik/followees/)
 [粉丝 - 502](https://home.cnblogs.com/u/52cik/followers/)

 [+加关注](小议%20html%20实体解析%20-%20楼教主%20-%20博客园.md#)

 1

 0

 [«](https://www.cnblogs.com/52cik/p/php-pinyin.html) 上一篇： [php 汉字转拼音 [包含20902个基本汉字+5059生僻字]](https://www.cnblogs.com/52cik/p/php-pinyin.html)

 [»](https://www.cnblogs.com/52cik/p/redis.html) 下一篇： [Redis 学习小记](https://www.cnblogs.com/52cik/p/redis.html)

posted @ 2015-07-20 16:39 [楼教主](https://www.cnblogs.com/52cik/)  阅读(1479)  评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=4661851) [收藏](小议%20html%20实体解析%20-%20楼教主%20-%20博客园.md#)
json2.js 源码解读 - 叫我钱了个浅 - 博客园

# [叫我钱了个浅](https://www.cnblogs.com/qianlegeqian/)

小前端，on my way~~ 新博客地址：ysha.me，欢迎访问!
随笔 - 164, 文章 - 0, 评论 - 12, 引用 - 0

##   [json2.js 源码解读](https://www.cnblogs.com/qianlegeqian/p/4166990.html)

这一部分是对Date String Number Boolean扩展toString方法，Date的toString是返回UTC格式的字符串，而后面几个是返回原始值。

[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)
 function f(n) {// 返回两位数字字符串  return n < 10 ? '0' + n: n;

} if (typeof Date.prototype.toJSON !== 'function') {//如果Date不支持原生的toJSON方法 Date.prototype.toJSON = function() {//扩展Date的toJSON方法  //是否是有穷数，如果为true,返回根据UTC时间计算出的年月日时分秒 YYYY-MM-DDThh:mm:ssZ如果为false,返回null  return isFinite(this.valueOf()) ? this.getUTCFullYear() + '-' + f(this.getUTCMonth() + 1) + '-' + f(this.getUTCDate()) +

'T' + f(this.getUTCHours()) + ':' + f(this.getUTCMinutes()) + ':' + f(this.getUTCSeconds()) + 'Z': null;

}; //扩展String Number Boolean的toJSON方法 String.prototype.toJSON = Number.prototype.toJSON = Boolean.prototype.toJSON = function() { return  this.valueOf();//返回他们的原始值 };

}
[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

这里是扩展Stringify方法
[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

if (typeof JSON.stringify !== 'function') {//扩展JSON的stringify方法 escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;

meta = { // table of character substitutions '\b': '\\b', '\t': '\\t', '\n': '\\n', '\f': '\\f', '': '\', '"': '\\"', '\\': '\\\\' };

JSON.stringify = function(value, replacer, space) {//扩展JSON.stringify方法  var i;//for循环变量 gap = '';//分隔符 indent = '';//分隔符  // If the space parameter is a number, make an indent string containing that  // many spaces.  if (typeof space === 'number') {//如果是数值  for (i = 0; i < space; i += 1) {//分隔符为space个空格 indent += ' ';

}
} else  if (typeof space === 'string') {//如果是字符串 indent = space;//分隔符就是字符串 }

rep = replacer; if (replacer && typeof replacer !== 'function' && (typeof replacer !== 'object' || typeof replacer.length !== 'number')) { throw  new Error('JSON.stringify');//如果第二个参数存在，必须为函数或者数组（伪数组），否则抛出异常 } return str('', { '': value

});
};
}
[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)
做了2件事：获取分隔符和replacer，内部调用str方法
[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

 function str(key, holder) {//第一次调用时 key:'', holder:{'': value}   var i, // The loop counter. k, // The member key. v, // The member value. length, mind = gap,//初始mind和gap都为"" partial, value = holder[key];//第二次调用时 value就是传入的键所对应的值  //如果value有toJSON方法  if (value && typeof value === 'object' && typeof value.toJSON === 'function') {

value = value.toJSON(key);//调用value.toJSON方法 } if (typeof rep === 'function') {//如果replace是一个方法 value = rep.call(holder, key, value);

} // 判断value类型  switch (typeof value) { case 'string'://如果是字符串，加引号  return quote(value); case 'number'://如果是数值  //有穷数用原生的String()将数值转为符串，否则返回null  return isFinite(value) ? String(value) : 'null'; case 'boolean'://如果是bool值或者null，返回String(value)  case 'null': return String(value); case 'object'://如果是对象  if (!value) {//null  return 'null';

}

gap += indent;//分隔符 partial = [];//临时数组  if (Object.prototype.toString.apply(value) === '[object Array]') {//数组 length = value.length; for (i = 0; i < length; i += 1) {//对数组的每一项递归调用str partial[i] = str(i, value) || 'null';

} // 如果partial为[],返回"[]"  // 如果 gap分隔符存在，返回[\n' + gap + partial.join(',\n' + gap) + '\n' + mind + ']'  // 如果分隔符不存在，返回'[' + partial.join(',') + ']' v = partial.length === 0 ? '[]': gap ? '[\n' + gap + partial.join(',\n' + gap) + '\n' + mind + ']': '[' + partial.join(',') + ']';

gap = mind;//重置为""  return v;

} if (rep && typeof rep === 'object') {//如果rep存在且为数组或者对象 length = rep.length;//如果是数组  for (i = 0; i < length; i += 1) {//过滤  if (typeof rep[i] === 'string') {

k = rep[i];//键是数组的值 v = str(k, value);//递归调用  if (v) { //"key": value 或者"key":value partial.push(quote(k) + (gap ? ': ': ':') + v);

}
}
}

} else {//如果不是数组或方法或不存在  for (k in value) { if (Object.prototype.hasOwnProperty.call(value, k)) {

v = str(k, value); if (v) {
partial.push(quote(k) + (gap ? ': ': ':') + v);
}
}
}
}

v = partial.length === 0 ? '{}': gap ? '{\n' + gap + partial.join(',\n' + gap) + '\n' + mind + '}': '{' + partial.join(',') + '}';

gap = mind; return v;
}
}
[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)
下面是图解：
![161316332031071.jpg](../_resources/1614ca73651cfc8d6c53a89ad61bc96d.jpg)
[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

 function quote(string) {//将传入的字符串加上引号，有必要转义的先转义 escapable.lastIndex = 0;//起始位置从0开始  return escapable.test(string) ? '"' + string.replace(escapable, function(a) {//匹配到的字符 如\t \n  var c = meta[a];//字符对应的转义表示  //如果c是字符串 ，直接返回对象中键所对应的值 '\t'=>'\\t'  //如果c不是字符串，也就是说它不在meta对象中，这时做不同的转义处理：  //拿 a为"\u0600"举例  //a.charCodeAt(0) =>1536  //a.charCodeAt(0).toString(16) => 600  //('0000' + a.charCodeAt(0).toString(16)) =>0000600  //('0000' + a.charCodeAt(0).toString(16)).slice( - 4) 取最后四位 => 0600  //'\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice( - 4)) '\\u0600'  return  typeof c === 'string' ? c: '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice( - 4);

}) + '"': '"' + string + '"';
}
[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

 这里是扩展parse方法
[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

 if (typeof JSON.parse !== 'function') {//如果JSON没有parse方法 cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;

JSON.parse = function(text, reviver) {//扩展JSON方法  var j; function walk(holder, key) {// walk({'':j},'')  var k, v, value = holder[key];//value第一次是传入的eval编译后的结果  if (value && typeof value === 'object') {//如果value存在并且是对象  for (k in value) { if (Object.prototype.hasOwnProperty.call(value, k)) {//是否有原型上的属性 v = walk(value, k);//递归调用获取结果  if (v !== undefined) {

value[k] = v;
} else { delete value[k];
}
}
}
} //调用walk之前有判断，所以在这里reviver肯定存在  return reviver.call(holder, key, value);
}
text = String(text);
cx.lastIndex = 0; if (cx.test(text)) {

text = text.replace(cx, function(a) { // \u0600 ---> \\u0600 因为\需要转义  return '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice( - 4);

});

} // text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@')   // =>把\\t \\uffff 这类转为@  // =>var text='{"a":"\\t44","b":"\\uffff"}'; text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@'); //{"a":"@44","b":"@"}  // replace(/"[^"\\\n]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']')  // =>把非空字符串、数值、bool、null替换为]  // .replace(/(?:^|:|,)(?:\s*\[)+/g, '')  // => 把 [ ,[ :[ 这类的替换为''  // 如果剩余的字符串只剩下 ]:,{}和空格 就是测试通过，否则抛出异常  if (/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@')

.replace(/"[^"\\\n]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']').replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {

j = eval('(' + text + ')');//eval()传入的参数加括号编译  return  typeof reviver === 'function' ? walk({//如果第二个参数是函数 返回walk({'':j},'')的结果，否则直接返回eval编译的结果 '': j

}, '') : j;
} throw  new SyntaxError('JSON.parse');
};
}
[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)
 通过一系列的替换操作，如果剩下的字符串只剩下 ]:,{}和空格，测试通过，接下来就可以用eval编译。
如果parse方法的第二个参数存在，返回walk的调用结果，否则直接返回eval编译结果。
[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

//reviver的用法：// var jsontext = '{ "hiredate": "2008-01-01T12:00:00Z", "birthdate": "2008-12-25T12:00:00Z" }'; // var dates = JSON.parse(jsontext, dateReviver); // console.log(dates);   // function dateReviver(key, value) { // var a; // if (typeof value === 'string') { // a = /^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2}(?:\.\d*)?)Z$/.exec(value); // if (a) { // return new Date(Date.UTC(+a[1], +a[2] - 1, +a[3], +a[4], // +a[5], +a[6])); // } // } // return value; // };

[![copycode.gif](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

hi,我的新博客地址：ysha.me !!

分类: [源码解读](https://www.cnblogs.com/qianlegeqian/category/640959.html)

 [好文要顶](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)  [关注我](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)  [收藏该文](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)  [![icon_weibo_24.png](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)  [![wechat.png](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

 [![20130826113825.png](../_resources/8948ab9b1b89a566044bba8ab4dc927d.jpg)](https://home.cnblogs.com/u/qianlegeqian/)

 [叫我钱了个浅](https://home.cnblogs.com/u/qianlegeqian/)
 [关注 - 21](https://home.cnblogs.com/u/qianlegeqian/followees/)
 [粉丝 - 10](https://home.cnblogs.com/u/qianlegeqian/followers/)

 [+加关注](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

 0

 0

 [«](https://www.cnblogs.com/qianlegeqian/p/4166205.html) 上一篇： [[已读]Sass与Compass实战](https://www.cnblogs.com/qianlegeqian/p/4166205.html)

 [»](https://www.cnblogs.com/qianlegeqian/p/4178857.html) 下一篇： [[未读]backbonejs应用程序开发](https://www.cnblogs.com/qianlegeqian/p/4178857.html)

posted on 2014-12-16 13:57 [叫我钱了个浅](https://www.cnblogs.com/qianlegeqian/)  阅读(188)  评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=4166990) [收藏](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

[刷新评论](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)[刷新页面](https://www.cnblogs.com/qianlegeqian/p/4166990.html#)[返回顶部](https://www.cnblogs.com/qianlegeqian/p/4166990.html#top)

注册用户登录后才能发表评论，请 [登录](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#) 或 [注册](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)， [访问](https://www.cnblogs.com/) 网站首页。

[【推荐】超50万行VC++源码: 大型组态工控、电力仿真CAD与GIS源码库](http://www.ucancode.com/index.htm)
[【推荐】了不起的开发者，挡不住的华为，园子里的品牌专区](https://brands.cnblogs.com/huawei)

[【推荐】精品问答：前端开发必懂之 HTML 技术五十问](https://developer.aliyun.com/ask/258350?utm_content=g_1000088952)

**相关博文：**

· [js便签笔记（10） - 分享：json.js源码解读笔记](https://www.cnblogs.com/wangfupeng1988/p/3821260.html)

· [js便签笔记（10） - 分享：json2.js源码解读笔记](https://www.cnblogs.com/wangfupeng1988/p/3821572.html)

· [json2使用方法](https://www.cnblogs.com/armyant/p/3146411.html)
· [Redux源码解读--createStore,js](https://www.cnblogs.com/z-one/p/9056897.html)
· [Mustache.js前端模板引擎源码解读](https://www.cnblogs.com/axes/p/4192234.html)
» [更多推荐...](https://recomm.cnblogs.com/blogpost/4166990)

 **最新 IT 新闻**:
· [拒绝向拼多多团购车主交付 特斯拉：因从未委托商家销售](https://news.cnblogs.com/n/669465/)
· [十年，雷军的道、法、术、器颠覆了什么](https://news.cnblogs.com/n/669464/)
· [贝壳敲钟，左晖圆梦！2万亿交易额仅次阿里](https://news.cnblogs.com/n/669463/)
· [“抖快”迎战淘宝直播，PGC+私域流量会是好出路？](https://news.cnblogs.com/n/669462/)
· [小米十年喜忧参半：未来十年路在何方？](https://news.cnblogs.com/n/669461/)
» [更多新闻...](https://www.cnblogs.com/news/)

### 导航

- [博客园](https://www.cnblogs.com/)

- [首页](https://www.cnblogs.com/qianlegeqian/)

- [新随笔](https://i.cnblogs.com/EditPosts.aspx?opt=1)

- [联系](https://msg.cnblogs.com/send/%E5%8F%AB%E6%88%91%E9%92%B1%E4%BA%86%E4%B8%AA%E6%B5%85)

- [订阅](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)  [![xml.gif](../_resources/f80f983ecf349c7b03c6127114f9d354.gif)](https://www.cnblogs.com/qianlegeqian/rss/)

- [管理](https://i.cnblogs.com/)

### 公告

昵称： [叫我钱了个浅](https://home.cnblogs.com/u/qianlegeqian/)
园龄： [6年11个月](https://home.cnblogs.com/u/qianlegeqian/)
粉丝： [10](https://home.cnblogs.com/u/qianlegeqian/followers/)
关注： [21](https://home.cnblogs.com/u/qianlegeqian/followees/)
[+加关注](json2.js%20源码解读%20-%20叫我钱了个浅%20-%20博客园.md#)

### 搜索

### 最新随笔

- [1.Nodejs 连接 mysql时报错 Error: Cannot enqueue Query after fatal error](https://www.cnblogs.com/qianlegeqian/p/4839233.html)

- [2.sublime 快捷键](https://www.cnblogs.com/qianlegeqian/p/4836976.html)

- [3.remote error: You can't push to git 解决办法](https://www.cnblogs.com/qianlegeqian/p/4806876.html)

- [4.关于Function.prototype.apply.call的一些补充](https://www.cnblogs.com/qianlegeqian/p/4786766.html)

- [5.四则运算 calc()](https://www.cnblogs.com/qianlegeqian/p/4781549.html)

- [6.如何创建width与height比例固定的元素](https://www.cnblogs.com/qianlegeqian/p/4781363.html)

- [7.eslint规则 中文备注](https://www.cnblogs.com/qianlegeqian/p/4728170.html)

- [8.使用gulp构建工具](https://www.cnblogs.com/qianlegeqian/p/4728165.html)

- [9.JavaScript 给表格排序](https://www.cnblogs.com/qianlegeqian/p/4597402.html)

- [10.【转】grunt动态生成文件名](https://www.cnblogs.com/qianlegeqian/p/4586604.html)

### 随笔分类

- [[译]JavaScript Allongé(4)](https://www.cnblogs.com/qianlegeqian/category/608180.html)
- [[译]Understanding ECMAScript6(6)](https://www.cnblogs.com/qianlegeqian/category/658635.html)
- [ActionScript(1)](https://www.cnblogs.com/qianlegeqian/category/696421.html)
- [backbone(10)](https://www.cnblogs.com/qianlegeqian/category/608178.html)
- [css/css3(11)](https://www.cnblogs.com/qianlegeqian/category/614094.html)
- [css兼容相关(8)](https://www.cnblogs.com/qianlegeqian/category/512747.html)
- [dom(1)](https://www.cnblogs.com/qianlegeqian/category/731156.html)
- [Less(2)](https://www.cnblogs.com/qianlegeqian/category/608181.html)
- [node(13)](https://www.cnblogs.com/qianlegeqian/category/652753.html)
- [工具(7)](https://www.cnblogs.com/qianlegeqian/category/701170.html)
- [冷场门(10)](https://www.cnblogs.com/qianlegeqian/category/614023.html)
- [前端调试(2)](https://www.cnblogs.com/qianlegeqian/category/608182.html)
- [收藏(5)](https://www.cnblogs.com/qianlegeqian/category/612073.html)
- [书单未读(4)](https://www.cnblogs.com/qianlegeqian/category/652752.html)
- [书单已读(31)](https://www.cnblogs.com/qianlegeqian/category/652751.html)
- [书单在读(11)](https://www.cnblogs.com/qianlegeqian/category/658637.html)
- [源码解读(17)](https://www.cnblogs.com/qianlegeqian/category/640959.html)

### 阅读排行榜

- [1. Nodejs 连接 mysql时报错 Error: Cannot enqueue Query after fatal error(7105)](https://www.cnblogs.com/qianlegeqian/p/4839233.html)

- [2. 安装gnvm (windows下nodejs版本管理工具)(6517)](https://www.cnblogs.com/qianlegeqian/p/4540041.html)

- [3. white-space中 pre pre-line pre-wrap的区别(6270)](https://www.cnblogs.com/qianlegeqian/p/3987235.html)

- [4. 使用tmodjs(4667)](https://www.cnblogs.com/qianlegeqian/p/4256141.html)

- [5. 【转载】(0, eval)(‘this’)(3921)](https://www.cnblogs.com/qianlegeqian/p/3950044.html)

### 推荐排行榜

- [1. 【转载】(0, eval)(‘this’)(2)](https://www.cnblogs.com/qianlegeqian/p/3950044.html)

- [2. white-space中 pre pre-line pre-wrap的区别(2)](https://www.cnblogs.com/qianlegeqian/p/3987235.html)

- [3. 标准模式与混杂模式(1)](https://www.cnblogs.com/qianlegeqian/p/4067635.html)

- [4. 使用nvmw解决windows下多版本node共存的问题(1)](https://www.cnblogs.com/qianlegeqian/p/4537811.html)

- [5. jQuery scrollLeft()与scrollTop() 源码解读(1)](https://www.cnblogs.com/qianlegeqian/p/4463691.html)

Powered by:
[博客园](https://www.cnblogs.com/)
Copyright © 2020 叫我钱了个浅
Powered by .NET Core on Kubernetes
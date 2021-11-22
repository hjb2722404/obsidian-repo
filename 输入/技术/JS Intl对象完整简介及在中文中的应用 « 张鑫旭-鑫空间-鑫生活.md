by [zhangxinxu](https://www.zhangxinxu.com/) from [https://www.zhangxinxu.com/wordpress/?p=8950](https://www.zhangxinxu.com/wordpress/?p=8950)  
本文欢迎分享与聚合，全文转载就不必了，尊重版权，圈子就这么大，若急用可以联系授权。  

![](https://image.zhangxinxu.com/image/blog/201909/intl-cover2.jpg)

### 一、先整体了解Intl对象

Intl对象是ECMAScript国际化API的命名空间，它提供对语言敏感的字符串比较、支持数字格式化以及日期和时间的格式化。

我们在控制台输入Intl，会得到如下图所示的返回值：

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-12_220529.png)

如下：

{
    Collator: ƒ Collator()
    DateTimeFormat: ƒ DateTimeFormat()
    ListFormat: ƒ ListFormat()
    NumberFormat: ƒ NumberFormat()
    PluralRules: ƒ PluralRules()
    RelativeTimeFormat: ƒ RelativeTimeFormat()
    getCanonicalLocales: ƒ getCanonicalLocales()
    v8BreakIterator: ƒ v8BreakIterator()
}

Intl对象是从IE11+开始支持的，其中有部分属性方法目前仅Chrome浏览器才支持，例如ListFormat。

我们一个一个了解下（Intl.v8BreakIterator没有相关文档，暂时忽略）。

### 二、Intl.Collator对象

collator这个单词意思是排序器。Intl.Collator对象是排序器的构造函数，可以支持对语言敏感的字符串比较。

**语法如下：** 

new Intl.Collator(\[locales\[, options\]\])

其中参数`locales`是可选参数，值是[BCF 47语言标记](https://tools.ietf.org/html/bcp47)的字符串（评论有反馈应该是bcf47规范中的tags标签扩展，unicode 格式），或此类字符串的数组。`options`也是可选参数，支持很多输入值，由于不是本文重点，不展开，有兴趣可以[查看这里的文档](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Collator)。

Collator实例从其原型继承了`compare()`和`resolvedOptions()`这两个方法，我们主要关心`compare()`这个方法，可以用来对字符串进行比对，值相等返回0，前面的值大返回负数，前面的值小返回整数。

此方法可以看成是`String.prototype.localeCompare()`方法更全新的版本，`locales`和`options`参数两者也都非常类似。

`compare()`方法主要用在不同语言下的字符串比较，例如，在德语中，ä和a排序一样，但是在瑞典语中，ä是排在字母z的后面的，因此：

// 在德语中，ä和a排序一样
console.log(new Intl.Collator('de').compare('ä', 'z'));
// 返回负值

// 瑞典语中，ä是排在字母z的后面
console.log(new Intl.Collator('sv').compare('ä', 'z'));
// 返回正值

不过，我们都是中国用户，上面场景用不到，那Intl.Collator对象有没有实用价值呢？是有的。

options有个可选参数是`numeric`，布尔属性，是否按照数值进行比较，默认是`false`，还记不记得下面经典的数字字符串排序问题：

\['15', '2', '100'\].sort();    
// 结果是：\["100", "15", "2"\]

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-12_225256.png)

因为数字字符串按照字符串顺序进行排列了。

下面我们使用Intl.Collator对象的数值排序参数进行改造下，则最后字符串按照字符串字面上的数值大小进行排序了：

\['15', '2', '100'\].sort(new Intl.Collator(undefined, { numeric: true }).compare);
// 结果是：\["2", "15", "100"\]

例如控制台跑出来的结果截图：

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-12_225815.png)

然后我们说说中文的排序，如果我们希望我们的中文按照首字母拼音排序，该怎么处理？

var arrUsername = \["陈坤", "邓超", "杜淳", "冯绍峰", "韩庚", "胡歌", "黄晓明", "贾乃亮", "李晨", "李易峰", "鹿晗", "井柏然", "刘烨", "陆毅", "孙红雷"\];

我们对上面arrUsername进行默认的`sort()`排序，结果是下面这样：

arrUsername.sort();
// 结果是：\["井柏然", "冯绍峰", "刘烨", "孙红雷", "李易峰", "李晨", "杜淳", "胡歌", "贾乃亮", "邓超", "陆毅", "陈坤", "韩庚", "鹿晗", "黄晓明"\]

顺序就不对了。

此时，可以使用中文简体的BCF 47语言标记字符串`zh`进行排序，代码如下：

arrUsername.sort(new Intl.Collator('zh').compare);
// 结果是：\["陈坤", "邓超", "杜淳", "冯绍峰", "韩庚", "胡歌", "黄晓明", "贾乃亮", "井柏然", "李晨", "李易峰", "刘烨", "陆毅", "鹿晗", "孙红雷"\]

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-12_233530.png)

### 三、Intl.DateTimeFormat对象

其实可以看成是传统的下面几个方法的变身：

Date.prototype.toLocaleString()  
Date.prototype.toLocaleDateString()  
Date.prototype.toLocaleTimeString()

**语法如下：** 

new Intl.DateTimeFormat(\[locales\[, options\]\])

`locales`是可选参数，和Intl.Collator对象一样的意思，指国家地区对应的BCP 47字符串，具体细节非常负责，不展开，仅仅中文`zh-*`后面的类型一双手都数不过来。`options`也是可选参数，可以指定日期类型，时区，以及年月日时分秒的呈现方式（如是否补0），是否24小时制显示。

总之，就是我们可以定制我们想要呈现的时间格式。

例如我们希望出现的日期信息格式是：“xxxx年xx月xx日 xx:xx:xx”。

则我们可以这样设置：

new Intl.DateTimeFormat('zh', {
    year: 'numeric',  
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    hour12: false
}).format(new Date())

其中`'2-digit'`表示一定使用2位数字表示，因此，如果数值不超过10，会自动在前面加0。`hour12`设置为`false`表示我们采用24小时制，于是晚上就会是21:00而不是下午9点。

我们看下IE11浏览器下的效果：

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-13_000111.png)

完全符合我们的预期，但是在Chrome浏览器和Firefox浏览器下，却不是中文的年月日而是斜杠：

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-13_000458.png)

还需要进一步字符处理下，或者有其他让Chrome、Firefox浏览器显示和IE一样的年月日中文的方法，欢迎赐教。

### 四、Intl.ListFormat对象

Intl.ListFormat可以让对语言敏感的列表进行格式化。

**语法如下：** 

new Intl.ListFormat(\[locales\[, options\]\]) 

`locales`就是`'zh-Hans'`或者`'en-US'`之类的字符，`options`也是可选参数，支持下面这3个：

*   `localeMatcher`指匹配算法。
*   `type`值内容连接类型。有`'conjunction'`表示A、B和C，`'disjunction'`表示A、B或C。`'unit'`表示值要带单位。
*   `style`表示样式，支持值有`'long'`，`'short'`和`'narrow'`，默认是`'long'`；如果是`'short'`，则表示A、B、C；如果是`'narrow'`，则表示A B C。

看一个例子吧：

var vehicles = \['Motorcycle', 'Bus', 'Car'\];

var formatter = new Intl.ListFormat('en', { style: 'long', type: 'conjunction' });
console.log(formatter.format(vehicles));
// 输出结果是： "Motorcycle, Bus, and Car"

如果设置语言是中文，则结果则是单词使用顿号分隔，例如：

var vehicles = \['Motorcycle', 'Bus', 'Car'\];

var formatter = new Intl.ListFormat('zh', { style: 'long', type: 'conjunction' });
console.log(formatter.format(vehicles));
// 输出结果是： "Motorcycle、Bus和Car"

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-13_001728.png)

本对象目前还处于实验阶段，仅Chrome72+浏览器支持，因此，就不进一步深入了。

### 五、Intl.NumberFormat对象

Intl.NumberFormat可以根据不同语言环境最数值字符串进行不同的呈现处理。本对象可以看成是`Number.toLocaleString()`方法的升级版，参数和含义都是一样的。

**语法如下：** 

new Intl.NumberFormat(\[locales\[, options\]\])

`locales`就是`'zh-Hans'`或者`'en-US'`这些[BCP 47语言标签字符](https://tools.ietf.org/html/bcp47)，`options`也是可选参数，支持的参数比较多，由于Intl.NumberFormat比较常用，因此这几个参数我都简单介绍下。

**localeMatcher**

要使用的区域设置匹配算法。值可以是`'lookup'`和`'best fit'`，其中`'best fit'`是默认值，这个算法可以让匹配器运行时提供的区域设置尽可能适合请求而不是基于查找算法的结果，例如设置`'zh'`，简体中文地区会认为是简体中文，繁体中文地区会认为是繁体中文，而不是指定匹配①。`'lookup'`算法则与之不同，遵循BCP 47中指定的查找算法。我们平时开发而不太用到这个参数。

① 自己的理解，如果不对，欢迎纠错

**style**

表示格式转换使用的样式。默认值是`'decimal'`，表示就是数字，值还可以是`'currency'`，表示使用货币格式，也可以是`'percent'`，表示百分比格式。

**currency**

使用货币格式时候使用的货币类型。值需要是[ISO 4217货币代码](https://baike.baidu.com/item/ISO%204217)（三个字母）。常见的有：人民币 China Yuan Renminbi (CNY)、港元 Hong Kong Dollar (HKD)、新台币 New Taiwan Dollar (TWD)、欧元Euro(EUR)、美元 US Dollar (USD)、英镑 Great British Pound(GBP)、日元 Japanese Yen (JPY)。

如果`style`参数值是`'currency'`，则这里的`currency`属性一定要提供。

**currencyDisplay**

如何显示设置的货币。默认值是`'symbol'`表示用图形显示，例如人民币是`'￥'`，其他可选值有`'code'`，表示使用ISO货币代码，人民币就是`'CNY'`；值也可以是`'name'`，使用当地该货币的名称，例如美元是`'dollar'`，人民币则是`'人民币'`。

**useGrouping**

布尔值。表示是否使用分组分隔符，例如千位分隔符或千/十万/千万分隔符。默认值是`true`。

**minimumIntegerDigits**

要使用的最小整数位数。可能的值为1到21；默认值为1。

**minimumFractionDigits**

要使用的最小小数位数。可能的值为0到20，普通数字和百分比格式的默认值为0，货币格式的默认值是ISO 4217货币代码列表提供的次要单位数字的数量（如果列表没有提供该信息则使用2代替）。

**maximumFractionDigits**

要使用的最大小数位数。可能的值为0到20。普通数字格式的默认值为minimumFractionDigits和3中的较大者，货币格式的默认值为minimumFractionDigits和ISO 4217货币代码列表提供的单位数字中的较大者（如果列表未提供该信息，则为2），格式百分比的默认值为minimumFractionDigits和0中的较大者。

**minimumSignificantDigits**

要使用的最小有效位数。可能的值为1到21；默认值为1。

**maximumSignificantDigits**

要使用的最大有效位数。可能的值为1到21；默认值为21。

实际开发，我们多使用NumberFormat继承的`format()方`法对数字格式进行处理。

例如：

#### 1\. 连续数字千位分隔符分隔

网页开发，尤其移动端，连续整数数值建议使用逗号分隔，原因见[这篇文章](https://www.zhangxinxu.com/wordpress/2017/09/web-page-comma-number/)。

默认情况下，我们无论是使用`Number.toLocaleString()`方法，还是这里的`new Intl.NumberFormat().format()`方法，都只能有3位小数。

例如：

new Intl.NumberFormat().format(12345.6789);
// 结果是："12,345.679"

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-13_122111.png)

如果我们希望保留的小数位是4，则可以如下处理：

new Intl.NumberFormat(undefined, {
    minimumFractionDigits: 4
}).format(12345.6789);
// 结果是："12,345.6789"

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-13_130453.png)

如果minimumFractionDigits的参数值超过原本的小数个数，则最后会补0。补0这种特性对于整数也同样适用。

#### 2\. 数字不足位数补0

字符串补全ES6有现成的API，[padStart()和padEnd()](https://www.zhangxinxu.com/wordpress/2018/07/js-padstart-padend/)，不过IE不支持。

如果遇到需要数字补全，可以试试这里的`format()`方法，IE11+都支持。

例如，希望小于10的数字前面都有0，可以这么处理：

new Intl.NumberFormat(undefined, {
    minimumIntegerDigits: 2
}).format(8);
// 结果是："08"

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-13_131745.png)

如果位数足够多，超过3位，可以设置`useGrouping`为`false`，这样就不会遇到逗号分隔的尴尬了。

#### 3\. 金额中文自带

给一串数字，后面自带中文“元”。可以如下设置：

new Intl.NumberFormat('zh-Hans', { 
    style: 'currency', 
    currency: 'CNY',
    currencyDisplay: 'name'
}).format(12345.6789)
// 结果是："12,345.68 人民币"

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-13_132517.png)

#### 4\. 数字变成中文数字显示

例如，我们要显示星期几，不需要再弄个数组进行一一映射了，试试下面的方法：

'星期' + new Intl.NumberFormat('zh-Hans-CN-u-nu-hanidec').format(new Date().getDay());
// 结果是："星期五"

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-13_132959.png)

### 六、Intl.PluralRules对象

Intl.PluralRules对象是用于启用多个敏感格式和多个语言规则的对象的构造函数。

**语法如下：** 

new Intl.PluralRules(\[locales\[, options\]\])

其中`locales`是可选参数，为BCP 47语言标签字符串。`options`也是可选参数，支持两个参数，一个是`localeMatcher`表示查找算法，另外一个是`type`表示类型，默认值是`'cardinal'`，表示基数（指事物的数量），还可以是值`'ordinal'`，表示序数（指事物的排序或排序，例如英语中的“1st”，“2nd”，“3rd”）。

有个`select()`方法比较常用，测试：

new Intl.PluralRules('zh-Hans').select(0);
// 结果是："other"
new Intl.PluralRules('zh-Hans').select(1); 
// 结果是："other"
new Intl.PluralRules('zh-Hans').select(2);
// 结果是："other"
new Intl.PluralRules('zh-Hans').select(6);
// 结果是："other"
new Intl.PluralRules('zh-Hans').select(18);
// 结果是："other"

可见这个对象对于中文用户而言，没什么锤子用。

### 七、Intl.RelativeTimeFormat对象

此对象IE不支持，Chrome71+开始支持。表示相对时间的格式化。例如昨天明天这种。

**语法**

new Intl.RelativeTimeFormat(\[locales\[, options\]\])

**示例**

举几个例子看看在中文中的表现（英文环境下表现参见[MDN文档](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RelativeTimeFormat)）。

var rtf = new Intl.RelativeTimeFormat('zh');
// -1表示前一天
rtf.format(-1, 'day');
// 结果是："1天前"
// 1表示往后一天
rtf.format(1, 'day');
// 结果是："1天后"

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-13_135443.png)

如果我们设置其他的参数，如下，则返回结果更有意思：

var rtf = new Intl.RelativeTimeFormat('zh', {
    numeric: 'auto'
});

rtf.format(-1, 'day');
// 结果是："昨天"
rtf.format(1, 'day');
// 结果是："明天"

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-13_135705.png)

### 八、Intl.getCanonicalLocales()方法

Intl.getCanonicalLocales()方法可以返回一个包含规范语言环境名称的数组。重复项将被忽略，元素将被验证为结构上有效的语言标记。

例如：

Intl.getCanonicalLocales('zh-hans');
// 结果是：\["zh-Hans"\]
Intl.getCanonicalLocales('zh');
// 结果是：\["zh"\]
Intl.getCanonicalLocales('zh-cmn-Hans-CN');
// 结果是：\["cmn-Hans-CN"\]
Intl.getCanonicalLocales('zh-cn');
// 结果是：\["zh-CN"\]
Intl.getCanonicalLocales('yue-hk');
// 结果是：\["yue-HK"\]
Intl.getCanonicalLocales('zh-some');
// 结果是：\["zh-Some"\]

![](https://image.zhangxinxu.com/image/blog/201909/2019-09-13_140340.png)

### 九、中秋佳节结束语

秋高气爽阳光明媚，领导带两个小朋友去游乐场玩了，我一个人在家写代码撸技术文章，好不快乐。

现在年龄上去了，平时的精力已经跟不上年轻人了，好在还有节假日，你去玩耍我在学习，嘿嘿嘿。

昨晚在“生活与创作”版块发了篇文章“[太感动了，今年终于吃到公司的月饼了！](https://www.zhangxinxu.com/life/2019/09/moon-cake/)”的文章，闲来无事的朋友可以去看看。

本文内容也很多，有些东西我也不是非常了解，加上行文仓促，一定会存在一些有错误的地方，欢迎大家帮忙指正。

感谢您的阅读以及平日里的支持，祝大家中秋节愉快，玩得好，吃的好！

![](https://image.zhangxinxu.com/image/emtion/emoji/1f913.svg)

（本篇完） ![](https://image.zhangxinxu.com/image/emtion/emoji/1f44d.svg)
 是不是学到了很多？可以分享到微信！  
![](https://image.zhangxinxu.com/image/emtion/emoji/1f44a.svg)
 有话要说？点击[这里](#comment "点击定位到评论")。
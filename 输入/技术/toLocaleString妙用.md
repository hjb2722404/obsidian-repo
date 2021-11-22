# `toLocaleString`妙用

## 缘起

`kaven`老师分享了一个数值取整的方法，即利用按位非操作符（`~`）进行取整：

```javascript
var a = 1.5;
console.log(~~a); // 1
```

但是这种方法有点限制就是它只能进行向下取整，无法实现四舍五入。

所以就想到了`toLocaleString()` 方法，利用它可以巧妙第实现数值的四舍五入取整。

## 利用toLocaleString取整

我们直接上代码：

```javascript
var a = 1.5;
console.log(a.toLocaleString('zh', {maximumFractionDigits: '0', useGrouping: false})); // 2
```

妙不可言啊。

当然，我们还是要了解其中原理。

## toLocaleString API

### 语法：

```javascript
object.toLocaleString(locale, options);
```

这个方法返回对象的字符串表示，该字符串反映对象所在的本地化执行环境。（即不同执行环境结果可能不同-比如浏览器和node就会不同）

### 参数：

* `locale`: 字符串，用于指定本地环境中存在的语言类型，默认为美式英语（`en-us`）, 中文使用`zh`; 【node环境中默认没有中文，所以即使指定为中文仍然会使用英语的表示】，具体可使用的语言标签格式见[BCP47规范](https://tools.ietf.org/html/bcp47), 下面是一些常用语言选项：
  * `en`: 英语
  * `zh`: 中文
  * `fr`: 法语
  * `de`: 德语
  * `ja`: 日语
* `options`: 对象，附加选项，用来指定字符串的显示格式。选项根据对象类型的不同而不同（[Number](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Number/toLocaleString)，[Date](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date/toLocaleString)，[Array](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/toLocaleString)）

## 数字处理

### 基本格式

```javascript
numObject.toLocaleString(locale, {
  style: '',
  numberingSystem: '',
  unit: '',
  unitDisplay:'',
  currency:'',
  currencyDisplay:'',
  useGrouping: true,
  minimumIntegerDigits:'',
  minimumFractionDigits:'',
  maximumFractionDigits:'',
  minimumSignificantDigits:'',
  maximumSignificantDigits:'',
  notation:'',
  compactDisplay:''
})
```



### 选项说明

* `style` 数字格式

  * `decimal`：纯数字格式（默认）

  * `currency`：货币格式

  * `percent`： 百分比格式

  * `unit`： 为数字加单位

    ![image-20201111113633506](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201209093823.png)

    

* `numberingSystem`：编号系统，可能的值包括："`arab`"，"`arabext`"，" `bali`"，"`beng`"，"`deva`"，"`fullwide`"，" `gujr`"，"`guru`"，"`hanidec`"，"`khmr`"，" `knda`"，"`laoo`", "`latn`"，"`limb`"，"`mlym`"，" `mong`"，"`mymr`"，"`orya`"，"`tamldec`"，" `telu`"，"`thai`"，"`tibt`"。

  ![image-20201111113729750](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201111134836.png)

  

* `unit` ： 位数字加单位，当`style` 为`unit` 时必须设置。所有单位示例如下：

  ![image-20201111114922564](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201111134856.png)

  ![image-20201111114953570](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201111134907.png)

  ![image-20201111115005963](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201111134915.png)

  

* `unitDisplay`: 单位显示格式

  * `long`: 完整显示
  * `short`: 缩写显示
  * `narrow`： 窄格式缩写

* `currency`: 货币类型，参见前面示例

* `currencyDisplay`: 货币显示格式，参见前面示例

  * `symbol`: 使用本地化的货币符号（如：￥），默认。
  * `code`： 使用国际标准组织货币代码（如： CNY）
  * `name`： 使用本地化货币名称,（如： 人民币）

* `useGrouping`: 是否使用分组分隔符（即每三位一个逗号），默认为true，设置为false可以去掉逗号分隔符；

  ![image-20201111115804048](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201111134922.png)

* `minimumIntegerDigits`：使用的整数数字的最小数目（1-21，超过21位会转换为科学计数法），不够会在前面补零，默认为1，

* `minimumFractionDigits`：使用的小数位数的最小数目（0-20），不够会在后面补零，普通数字和百分比默认为0，货币大部分默认为2.

* `maxinumFractionDigits`： 使用的小数位数的最大位数（0，20），多余的会四舍五入省略

* `minimumSignificantDigits`：使用的有效数字的最小数目（1-21），默认为1；

* `maximumSignificantDigits`： 使用的有效数字的最大数量（1-21）， 默认为21

* `notation`: 数字显示格式

  * `standard`： 标准格式，默认
  * `scientific`： 科学计数法显示

  ![image-20201111131349923](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201111134937.png)

  

  > 注意，数字通过·`toLocaleString`处理后返回的是一个字符串，如果需要数字格式，可以使用加号操作符（+）将它转为数字。

  ## 日期处理

  ### 基本格式

  ```javascript
  dateObj.tolocaleString(locale, {
  	hour12: true,
    year: '',
    month: '',
    day: '',
    hour: '',
    minute: '',
    second: '',
    weekday: '',
    timeZoneName:'',
    era: '',
    timeZone: '',
  });
  ```

  ### 选项说明：

  * `hour12`: 是否为12小时制，如果为false，则是24小时制显示
  * `timeZone`: 时区设置，一般为`UTC`-格林尼治时间时区
  * `timeZoneName`：时区名称显示格式
  * `ear`: 历法显示格式
  * `weekday`: 星期显示格式
  * `year`: 年份显示格式
  * `month`: 月份显示格式
  * `day`: 日期显示格式
  * `hour`: 小时显示格式
  * `minute:`: 分钟显示格式
  * `second`: 秒显示格式

  格式有以下几个可选值：

  * `numeric`: 正常数值显示
  * `2-gigit`: 两位数字显示
  * `long`: 完整显示
  * `short`: 缩写显示
  * `narrow`：窄缩写显示

  以下是一些例子：

  <img src="https://raw.githubusercontent.com/hjb2722404/myimg/master/20201111134948.png" alt="image-20201111133805197"  />

  

  > 注意：年月日时分秒星期必须同时设置才能显示完整信息，否则，设置某项就只显示那一项

  ## 数组处理

  如果数组元素由多种不同类型的值组成，当我们需要它们的字符串格式拼接在一起时，可以使用数组的`toLocaleString()`方法，它将执行如下操作：

  1. 对数组中每一个元素调用它们自身的`toLocaleString()`方法，得到转换后的字符串
  2. 使用逗号将得到的所有字符串连接起来返回

  ### 示例：

  ```javascript
  var arr = [1, new Date(), {a:1,b:2}];
  var localeString = arr.toLocaleString('zh',{ style:'currency', currency:'CNY', year: 'numeric',  month: 'numeric',  day: 'numeric',  hour: 'numeric',  minute: 'numeric',  second: 'numeric', weekday:'short'});
  ```

  ![image-20201111134740750](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201111135002.png)

  

  
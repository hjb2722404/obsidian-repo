# UEditor源码分析—— 浏览器检测技术分析



为了保证编辑器在各个不同浏览器上的一致性，`Ueditor`实现了一套完整而详细的浏览器内核和版本检测类，并且也将它挂载在了`UE`对象上，作为工具开放给开发者使用。

```javascript
var browser = UE.browser = function() {
        // ...
    }();
```

我们来看一下浏览器内核、平台与模式检测的实现原理。

* 对于`opera`浏览器，直接检查挂载在window上的`opera`对象

* IE内核浏览器： 检查`navigator.userAgent`字符串中是否包含`msie`或者 `trident.*rv` 子串
* `webkit`内核浏览器： 检查`navigator.userAgent`字符串中是否包含`applewebkit` 子串。
* 是否运行在mac上： 检查`navigator.userAgent` 字符串中是否包含`macintosh` 子串（如果同时包含`applewebkit`和`macintosh`子串，则说明是运行在mac OS上的`webkit`内核浏览器）
* 浏览器是是否运行在怪异模式下： 检查 `document.compatMode` 属性，如果值为`BackCompat`则为怪异模式，如果值为`CSS1Compat` ,则为标准模式。
* `gecko` 内核浏览器： `navigator.product` 为`Gecko` ，并且不是上面三种内核（opera/webkit/ie）

然后看下具体的版本检测原理：

* `IE`: 分三种情况

  * 同时具有`msie`和`trident`标识，选取两个版本号中较大的一个

  * 只包含`msie`标识的，直接采用该标识后面跟的版本号

  * 只包含`trident`标识的，直接采用该标识后面跟的版本号

    如果都没有，则版本号为 0；

* `IE` 的兼容模式判断

  * `IE9兼容模式` ： `document.documentMode` 值为 9;
  * `IE11兼容模式` ： `document.documentMode` 值为 11;
  * `IE8兼容模式` ： `document.documentMode` 值为 8;
  * `IE7兼容模式` ： `document.documentMode` 值为 7， 或者 `document.documentMode`的值未定义，但版本号为7;
  * `IE6兼容模式` ： 版本号小于 7 或者 浏览器处于怪异模式下

* `IE`其它版本：

  * `IE9`及以上 ： 版本号大于8
  * `IE9`以下： 版本号小于 9
  * `IE11`及以上： 版本号大于10
  * `IE11` 以下： 版本号小于 11

* `Gecko` 版本号判断（主要用于`firefox`浏览器）

  * 匹配`navigator.userAgent`中 `rv:`后面的数字
  * 使用`.`分割符分割匹配到的数字
  * 第一位乘以10000，第二位乘以100，第三位乘以1，相加后就是最终的版本号，例如匹配的数字为1.9，则版本号为：10900

* `chrome` 浏览器版本号：

  * 检测当前浏览器是否为Chrome, 如果是，则返回Chrome的大版本号
  * 检测是否为`Chrome`: 检查`navigator`中是否包含`chrome`标识

* `safari`浏览器版本的检测

  * `navigator.userAgent` 不包含`chrome`标识
  * `navigator.userAgent` 包含 `safari标识`
  * 正则匹配`safari`标识前后的数字就是版本号

* 在以上两种浏览器的版本号匹配中，我们会看到程序中有以下代码：

  ```javascript
  +(RegExp['\x241'] || RegExp['\x242'])
  ```

  这实际上代表了正则表达式中匹配到的分组，`\x241` 代表`$1`， `\x242` 代表 `$2`.

* `opera` 浏览器版本号获取

  * 直接使用 `window.opera.version()` 方法获取

* 最后，提供了一个属性来检测当前浏览器是否能与编辑器良好兼容：

  * `UE.browser.isCompatible`
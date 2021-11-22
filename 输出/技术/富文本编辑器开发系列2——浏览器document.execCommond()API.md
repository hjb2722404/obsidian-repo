# document.execCommand 的API

[TOC]

## 示例

[execCommand的API示例](https://codepen.io/netsi1964/full/QbLLGW/)

## 语法

`bool = document.execCommand(name, isShowDefaultUI, argument);`

### 参数说明

* `name` ， 字符串，命令的名称，可用命令见下文表格
* `isShowDefaultUI`布尔值，是否展示用户界面，一般为 `false`， 并且`Mozilla` 没有实现
* `augument`  额外参数，某些命令需要传入额外的参数



## 可用命令

| 命令名称                       | 命令作用                                                     | 额外参数                    |
| ------------------------------ | ------------------------------------------------------------ | --------------------------- |
| `backColor`                    | 修改文档背景颜色；在`styleWithCss`模式下，则只影响容器元素的背景颜色；IE浏览器用这个设置文字的背景颜色 | `color`:合法的`CSS`颜色值   |
| `bold`                         | 开启或关闭选中文字或插入点的粗体字效果；IE浏览器使用`<strong>`标签而非`<b>`标签 |                             |
| `clearAuthenticationCache`     | 清除缓存中所有身份验证凭据                                   |                             |
| `contentReadOnly`              | 通过传入一个布尔类型的参数来指定文档内容的可编辑性；IE浏览器不支持 | `bool`:布尔类型，是否可编辑 |
| `copy`                         | 拷贝当前选中内容到剪贴板；使用前要检查浏览器兼容表           |                             |
| `createLink`                   | 将选中内容创建为一个锚链接。                                 | `href`: URI字符串           |
| `cut`                          | 剪切当前选中文字并复制到剪贴板；使用前请检查浏览器兼容表     |                             |
| `decreaseFontSize`             | 给选中文字加上`<small>`标签;IE浏览器不支持                   |                             |
| `defaultParagraphSeparator`    | 更改在可编辑文本区域中创建新段落时使用的段落分隔符           |                             |
| `delete`                       | 删除选中部分或者光标前面的字符                               |                             |
| `enableAbsolutePositionEditor` | 启用或禁用允许移动绝对定位元素的抓取器                       |                             |
| `enableInlineTableEditing`     | 启用或禁用表格行和列插入和删除控件；IE浏览器不支持           |                             |
| `enableObjectResizing`         | 启用或禁用图像和其它对象的大小可调整大小手柄；IE浏览器不支持 |                             |
| `fontName`                     | 在插入点或者选中文字部分修改字体名称                         | `name`: 字体名称            |
| `fontColor`                    | 在插入点或者选中文字部分修改字体颜色                         | `color`:颜色值字符串        |
| `fontSize`                     | 在插入点或者选中文字部分修改字体大小                         | `size`: 1~7                 |
| `formatBlock`                  | 在包含当前选择的行添加一个`HTML`块式标签，如果已经存在了，则更换包含该行的块元素 | `tagName`: 块级标签名称     |
| `forwardDelete`                | 删除光标所在位置后面的字符。                                 |                             |
| `heading`                      | 添加一个标题标签在光标处或所选文字上。                       | `tagName`:  H1-H6           |
| `hiliteColor`                  | 更改选择或插入点的背景颜色；IE浏览器不支持                   | `color`：合法颜色值         |
| `increaseFontSize`             | 在选择或插入点周围添加一个`BIG`标签;IE不支持                 |                             |
| `indent`                       | 缩进选择或插入点所在的行                                     |                             |
| `insertBrOnReturn`             | 按下回车键时，是插入`br`标签还是把当前块元素变成两个。IE不支持 |                             |
| `insertHorizontalRule`         | 在插入点插入一个水平线                                       |                             |
| `insertHTML`                   | 在插入点插入一个HTML字符串                                   | `string`:HTML字符串         |
| `insertImage`                  | 在插入点插入一张图片                                         | `urlString`:URL字符串       |
| `insertOrderedList`            | 在插入点或者选中文字上创建一个有序列表                       |                             |
| `insertUnorderedList`          | 在插入点或者选中文字上创建一个无序列表                       |                             |
| `insertParagraph`              | 在选择或当前行周围插入一个段落                               |                             |
| `insertText`                   | 在光标插入位置插入文本内容或者覆盖所选文本内容               |                             |
| `italic`                       | 在光标插入点开启或关闭斜体字。IE使用`EM`标签而不是`I`标签    |                             |
| `justifyCenter`                | 对光标插入位置或者所选内容进行文字居中                       |                             |
| `justifyFull`                  | 对光标插入位置或者所选内容进行文本对齐                       |                             |
| `justifyLeft`                  | 对光标插入位置或者所选内容进行右对齐                         |                             |
| `justifyRight`                 | 对光标插入位置或者所选内容进行右对齐                         |                             |
| `outdent`                      | 对光标插入行或者所选行内容减少缩进量                         |                             |
| `paste`                        | 在光标位置粘贴剪贴板的内容                                   |                             |
| `redo`                         | 重做被撤销的操作                                             |                             |
| `removeFormat`                 | 对所选内容去除所有格式                                       |                             |
| `selectAll`                    | 选中编辑区里的全部内容                                       |                             |
| `strikeThrough`                | 在光标插入点开启或关闭删除线                                 |                             |
| `subscript`                    | 在光标插入点开启或关闭下角标                                 |                             |
| `superscript`                  | 在光标插入点开启或关闭上角标                                 |                             |
| `underline`                    | 在光标插入点开启或关闭下划线                                 |                             |
| `undo`                         | 插销最近执行的操作                                           |                             |
| `unlink`                       | 去除所选的锚链接的`a`标签                                    |                             |
| `uesCSS`                       | 切换使用`HTML tags` 还是 `CSS` 来生成标记。(已废弃)          | `bool`                      |
| `styleWithCSS`                 | 取代`useCSS` 命令。                                          |                             |
|                                |                                                              |                             |

​	
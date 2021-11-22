
[Bonrui](https://blog.csdn.net/qinjm8888) 2018-01-12 19:53:00 ![](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png)


版权声明：本文为博主原创文章，遵循 [CC 4.0 BY-SA](http://creativecommons.org/licenses/by-sa/4.0/) 版权协议，转载请附上原文出处链接和本声明。

兼容写法：

```null
::-webkit-input-placeholder { /* Chrome/Opera/Safari */::-moz-placeholder { /* Firefox 19+ */:-ms-input-placeholder { /* IE 10+ */:-moz-placeholder { /* Firefox 18- */```

支持的属性：

*   `font` properties
*   `color`
*   `background` properties
*   `word-spacing`
*   `letter-spacing`
*   `text-decoration`
*   `vertical-align`
*   `text-transform`
*   `line-height`
*   `text-indent`
*   `opacity`

案例1：input的placeholder内容居中，光标不居中

```null
input::-webkit-input-placeholder {```

案例2：某些placeholder上下不居中

     调整line-height属性
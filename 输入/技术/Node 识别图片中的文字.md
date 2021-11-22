Node 识别图片中的文字

#  Node 识别图片中的文字

首先根据需求处理图片大小旋转角度，然后识别图片中的文字。

[node-images](https://github.com/zhangyuanwei/node-images): Node.js 轻量级跨平台图像编解码库

[tesseract](https://github.com/naptha/tesseract.js): 纯 JS 的 OCR 库支持 62 种语言。
例子：
某网站的验证码

[![8c9b876fly1fe0bvsibibj201a00p07l.jpg](../_resources/2c33050a090a7b4bfdc846009e13c30c.png)](https://ww1.sinaimg.cn/large/8c9b876fly1fe0bvsibibj201a00p07l.jpg)

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31<br>32<br>33<br>34<br>35<br>36<br>37<br>38<br>39<br>40<br>41<br>42<br>43<br>44<br>45<br>46<br>47<br>48 | "use strict"<br>var images = require('images')<br>var Tesseract = require('tesseract.js');<br>var request = require('request');<br>var fs = require('fs');<br>// 将图片下载到本地<br>function  downloadFile(uri, filename, callback) {<br> var stream = fs.createWriteStream(filename);<br>request(uri).pipe(stream)<br>.on('close', function () {<br>callback();<br>});<br>}<br>// 识别图片<br>function  recognize(filePath, callback) {<br> // 图片放大<br>images(filePath)<br>.size(90)<br>.save(filePath);<br> // 识别<br>Tesseract<br>.recognize(filePath, {<br>lang: 'eng', // 语言选英文<br>tessedit_char_blacklist: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'<br> //因为是数字验证码，排除字母<br>})<br>.then((result) => {<br>callback(result.text);<br>});<br>}<br>function  getVcode() {<br> var url = 'https://ww1.sinaimg.cn/large/8c9b876fly1fe0bvsibibj201a00p07l.jpg';<br> var filename = 'vcode.png';<br> // 先下载下来，再识别<br>downloadFile(url, filename, function () {<br>recognize(filename, function (txt) {<br> console.log('识别结果: ' + txt);<br>});<br>});<br>}<br>getVcode(); |

[(L)](https://ww1.sinaimg.cn/large/8c9b876fly1fe0ccaubowj20rk02yaa6.jpg)运行结果
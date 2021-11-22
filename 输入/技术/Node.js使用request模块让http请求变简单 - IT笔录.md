Node.js使用request模块让http请求变简单 - IT笔录

# Node.js使用request模块让http请求变简单

** 2015年05月08日    ** 1580    ** 声明

经常会有在后端做http请求的情况，如：访问API或模拟web客户端请求等。业务不复杂的情况下，使用Nodejs的原生http模块的客户端功能可满足需求，但在业务较复杂时使用http模块工作量会比较大，使用第三方request模块会让http请求变的简单。request模块是一个HTTP客户端请求模块，使用非常简单，除支持一般http请求外，还可以更复杂的http请求，如：https请求、请示重定向、数据流转接、form表单提交、HTTP认证、OAuth登录、自定义HTTP header等。

#### 最简单的使用方式

Request模块封装了http请求，使你可以用很简单的方式处理http请求，同时也支持HTTPS和请求重定向。简单用法如下：
var request = require('request');
request('https://www.baidu.com', function (error, response, body) {
if (!error && response.statusCode == 200) {
console.log(body);	//请求百度首页，返回的Html数据
}
})

除了基本的使用方式外，request还支持更为复杂的使用方式，下面将做简单说明。

#### 流操作

你可以把任何类型的http响应流pipe转接到文件流中。示例如下：
var request = require('request');
var fs = require('fs');

request('http://itbilu.com/robots.txt').pipe(fs.createWriteStream('robots.txt'));

反之亦然，你也可以把一个文件流pipe转接给PUT或POST请求，同样，你也可以从一个http的response响应流转接给PUT或POST请求。未提供header的情况下，request会检测文件后缀名并在对应的PUT或POST请求中设置相应的content-type。示例如下：

//从文件流转接到PUT请求

fs.createReadStream('file.json').pipe(request.put('http://itbilu.com/obj.json'));

//从相应流转接到put请求流
request('http://www.baidu.com/img.png').pipe(put('http://itbilu.com/img.png'));

#### Form相关

request模块支持application/x-www-form-urlencoded和multipart/form-data编码格式的form表单提交或文件上传。

**application/x-www-form-urlencoded (URL-Encoded Forms)：**URL-encoded编码格式的数据提交。
//你可以这样用
request.post('http://itbilu.com/form', {form:{key:'value'}})
//可以这样用
request.post(http://itbilu.com/form').form({key:'value'})
//还可以这样用

request.post({url:'http://itbilu.com/form', form: {key:'value'}}, function(err,httpResponse,body){ /* ... */ })

**multipart/form-data (Multipart Form Uploads)：**当使用multipart/form-data编码格式提交数据时，request会调用[form-data](https://github.com/felixge/node-form-data)库对数据进行处理。使用此格式，大多数情况下要设置formData 的设置项。示例如下：

var formData = {
// Pass a simple key-value pair my_field: 'my_value',
// Pass data via Buffers my_buffer: new Buffer([1, 2, 3]),

// Pass data via Streams my_file: fs.createReadStream(__dirname + '/unicycle.jpg'),

// Pass multiple values /w an Array attachments: [
fs.createReadStream(__dirname + '/attachment1.jpg'),
fs.createReadStream(__dirname + '/attachment2.jpg')
],

// 更多设置，请查看`form-data`选项: https://github.com/felixge/node-form-data custom_file: {

value: fs.createReadStream('/dev/urandom'),
options: {
filename: 'topsecret.jpg',
contentType: 'image/jpg'
}
}
};

request.post({url:'http://itbipu.com/upload', formData: formData}, function optionalCallback(err, httpResponse, body) {

if (err) {
return console.error('上传失败:', err);
}
console.log('上传成功！服务器相应结果:', body);
});
简化的用法：

var r = request.post('http://itbilu.com/upload', function optionalCallback(err, httpResponse, body) { // ... var form = r.form();

form.append('my_field', 'my_value');
form.append('my_buffer', new Buffer([1, 2, 3]));

form.append('custom_file', fs.createReadStream(__dirname + '/unicycle.jpg'), {filename: 'unicycle.jpg'});

#### HTTP Authentication（HTTP认证）

有些http请求（如：API等）需要添加认证信息，使用request做认证请求的示例如下：
//你可这么用
request.get('http://itbilu.com/').auth('username', 'password', false);
// 或
request.get('http://some.server.com/', {
'auth': {
'user': 'username',
'pass': 'password',
'sendImmediately': false
}
});
// 或
request.get('http://itbilu.com/').auth(null, null, true, 'bearerToken');
// or request.get('http://itbilu.com/', {
'auth': {
'bearer': 'bearerToken'
}
});

#### 自定义 HTTP Headers

一些web请求中需要设置HTTP请求的头信息，你可以将User-Agent之类的设置放在options对象中，reqest会将将这些设置项放到http的请求headers中。示例如下：

var request = require('request');
//在headers中添加一个User-Agent项
var options = {
url: 'https://itbilu.com',
headers: {
'User-Agent': 'request'
}
};
function callback(error, response, body) {
if (!error && response.statusCode == 200) {
var info = JSON.parse(body);
console.log(info.stargazers_count + " Stars");
console.log(info.forks_count + " Forks");
}
}
request(options, callback);

除以上应用场景外，request模块还支持：OAuth登录、TLS/SSL协议、Socket请求等，详细介绍请参考：[简单的HTTP请求客户端 - Request](http://itbilu.com/nodejs/npm/E1Z0ypVLZ.html)

下一篇：[nodejs文件上传处理模块formidable](https://itbilu.com/nodejs/npm/NkGKcF14.html)
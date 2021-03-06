websocket 探索其与语音、图片的能力

##  websocket 探索其与语音、图片的能力



> 作者：AlloyTeam

> 网址：http://www.alloyteam.com/2015/12/websockets-ability-to-explore-it-with-voice-pictures/

说到websocket想比大家不会陌生，如果陌生的话也没关系，一句话概括

“WebSocket protocol 是HTML5一种新的协议。它实现了浏览器与服务器全双工通信”

WebSocket相比较传统那些服务器推技术简直好了太多，我们可以挥手向comet和长轮询这些技术说拜拜啦，庆幸我们生活在拥有HTML5的时代~

这篇文章我们将分三部分探索websocket

首先是websocket的常见使用，其次是完全自己打造服务器端websocket，最终是重点介绍利用websocket制作的两个demo，传输图片和在线语音聊天室，let’s go

**一、websocket常见用法**

这里介绍三种我认为常见的websocket实现……（注意：本文建立在node上下文环境）

**1、socket.io**

先给demo
```
var http = require('http');

var io = require('socket.io');

var server = http.createServer(function(req, res) {

 res.writeHeader(200, {'content-type': 'text/html;charset="utf-8"'});

 res.end();

}).listen(8888);

var socket =.io.listen(server);

socket.sockets.on('connection', function(socket) {

 socket.emit('xxx', {options});

 socket.on('xxx', function(data) {

 // do someting

 });

});
```

相信知道websocket的同学不可能不知道socket.io，因为socket.io太出名了，也很棒，它本身对超时、握手等都做了处理。我猜测这也是实现websocket使用最多的方式。socket.io最最最优秀的一点就是优雅降级，当浏览器不支持websocket时，它会在内部优雅降级为长轮询等，用户和开发者是不需要关心具体实现的，很方便。

不过事情是有两面性的，socket.io因为它的全面也带来了坑的地方，最重要的就是臃肿，它的封装也给数据带来了较多的通讯冗余，而且优雅降级这一优点，也伴随浏览器标准化的进行慢慢失去了光辉

| 浏览器    |  兼容性   |
| --- | --- |
| Chrome | Supported in version 4+ |
| Firefox | Supported in version 4+ |
| Internet Explorer | Supported in version 10+ |
| Opera | Supported in version 10+ |
| Safari | Supported in version 5+ |

在这里不是指责说socket.io不好，已经被淘汰了，而是有时候我们也可以考虑一些其他的实现~

**2、http模块**

刚刚说了socket.io臃肿，那现在就来说说便捷的，首先demo

```
var http = require(‘http’);

var server = http.createServer();

server.on(‘upgrade’, function(req) {

console.log(req.headers);

});

server.listen(8888);
```

很简单的实现，其实socket.io内部对websocket也是这样实现的，不过后面帮我们封装了一些handle处理，这里我们也可以自己去加上，给出两张socket.io中的源码图

![0.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132152.png)
![0.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132157.png)

**3、ws模块**

后面有个例子会用到，这里就提一下，后面具体看~

**二、自己实现一套server端websocket**

刚刚说了三种常见的websocket实现方式，现在我们想想，对于开发者来说

websocket相对于传统http数据交互模式来说，增加了服务器推送的事件，客户端接收到事件再进行相应处理，开发起来区别并不是太大啊

那是因为那些模块已经帮我们将数据帧解析这里的坑都填好了，第二部分我们将尝试自己打造一套简便的服务器端websocket模块

感谢次碳酸钴的研究帮助，我在这里这部分只是简单说下，如果对此有兴趣好奇的请百度【web技术研究所】

自己完成服务器端websocket主要有两点，一个是使用net模块接受数据流，还有一个是对照官方的帧结构图解析数据，完成这两部分就已经完成了全部的底层工作

首先给一个客户端发送websocket握手报文的抓包内容

客户端代码很简单

```
ws \= new WebSocket("ws://127.0.0.1:8888");
```

![0.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132202.jpg)

服务器端要针对这个key验证，就是讲key加上一个特定的字符串后做一次sha1运算，将其结果转换为base64送回去

```
var crypto = require('crypto');

var WS = '258EAFA5-E914-47DA-95CA-C5AB0DC85B11';

require('net').createServer(function(o) {

var key;

o.on('data',function(e) {

if(!key) {

// 获取发送过来的KEY

key = e.toString().match(/Sec\-WebSocket\-Key: (.+)/)\[1\];

// 连接上WS这个字符串，并做一次sha1运算，最后转换成Base64

key = crypto.createHash('sha1').update(key+WS).digest('base64');

// 输出返回给客户端的数据，这些字段都是必须的

o.write('HTTP/1.1 101 Switching Protocols\\r\\n');

o.write('Upgrade: websocket\\r\\n');

o.write('Connection: Upgrade\\r\\n');

// 这个字段带上服务器处理后的KEY

o.write('Sec-WebSocket-Accept: '+key+'\\r\\n');

// 输出空行，使HTTP头结束

o.write('\\r\\n');

}

});

}).listen(8888);
```

这样握手部分就已经完成了，后面就是数据帧解析与生成的活了

先看下官方提供的帧结构示意图

![0.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132209.jpg)

简单介绍下

FIN为是否结束的标示

RSV为预留空间，0

opcode标识数据类型，是否分片，是否二进制解析，心跳包等等

给出一张opcode对应图

![0.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132218.png)

MASK是否使用掩码

Payload len和后面extend payload length表示数据长度，这个是最麻烦的

PayloadLen只有7位，换成无符号整型的话只有0到127的取值，这么小的数值当然无法描述较大的数据，因此规定当数据长度小于或等于125时候它才作为数据长度的描述，如果这个值为126，则时候后面的两个字节来储存数据长度，如果为127则用后面八个字节来储存数据长度

Masking-key掩码

下面贴出解析数据帧的代码

```
function decodeDataFrame(e) {

var i \= 0,

j,s,

frame \= {

FIN: e\[i\] \>> 7,

Opcode: e\[i++\] & 15,

Mask: e\[i\] \>> 7,

PayloadLength: e\[i++\] & 0x7F

};

if(frame.PayloadLength \=== 126) {

frame.PayloadLength \= (e\[i++\] << 8) + e\[i++\];

}

if(frame.PayloadLength \=== 127) {

i += 4;

frame.PayloadLength \= (e\[i++\] << 24) + (e\[i++\] << 16) + (e\[i++\] << 8) + e\[i++\];

}

if(frame.Mask) {

frame.MaskingKey \= \[e\[i++\], e\[i++\], e\[i++\], e\[i++\]\];

for(j \= 0, s \= \[\]; j < frame.PayloadLength; j++) {

s.push(e\[i+j\] ^ frame.MaskingKey\[j%4\]);

}

} else {

s \= e.slice(i, i+frame.PayloadLength);

}

s \= new Buffer(s);

if(frame.Opcode \=== 1) {

s \= s.toString();

}

frame.PayloadData \= s;

return frame;

}
```

然后是生成数据帧的

```
function encodeDataFrame(e) {

var s \= \[\],

o \= new Buffer(e.PayloadData),

l \= o.length;

s.push((e.FIN << 7) + e.Opcode);

if(l < 126) {

s.push(l);

} else if(l < 0x10000) {

s.push(126, (l&0xFF00) \>> 8, l&0xFF);

} else {

s.push(127, 0, 0, 0, 0, (l&0xFF000000) \>> 24, (l&0xFF0000) \>> 16, (l&0xFF00) \>> 8, l&0xFF);

}

return Buffer.concat(\[new Buffer(s), o\]);

}
```

都是按照帧结构示意图上的去处理，在这里不细讲，文章重点在下一部分，如果对这块感兴趣的话可以移步web技术研究所~

**三、websocket传输图片和websocket语音聊天室**

正片环节到了，这篇文章最重要的还是展示一下websocket的一些使用场景

1、传输图片

我们先想想传输图片的步骤是什么，首先服务器接收到客户端请求，然后读取图片文件，将二进制数据转发给客户端，客户端如何处理？当然是使用FileReader对象了

先给客户端代码

```
var ws \= new WebSocket("ws://xxx.xxx.xxx.xxx:8888");

ws.onopen \= function(){

 console.log("握手成功");

};

ws.onmessage \= function(e) {

 var reader \= new FileReader();

 reader.onload \= function(event) {

 var contents \= event.target.result;

 var a \= new Image();

 a.src \= contents;

 document.body.appendChild(a);

 }

 reader.readAsDataURL(e.data);

};
```

接收到消息，然后readAsDataURL，直接将图片base64添加到页面中

转到服务器端代码

```
fs.readdir("skyland", function(err, files) {

if(err) {

throw err;

}

for(var i \= 0; i < files.length; i++) {

fs.readFile('skyland/' + files\[i\], function(err, data) {

if(err) {

throw err;

}

o.write(encodeImgFrame(data));

});

}

});

function encodeImgFrame(buf) {

var s \= \[\],

l \= buf.length,

ret \= \[\];

s.push((1 << 7) + 2);

if(l < 126) {

s.push(l);

} else if(l < 0x10000) {

s.push(126, (l&0xFF00) \>> 8, l&0xFF);

} else {

s.push(127, 0, 0, 0, 0, (l&0xFF000000) \>> 24, (l&0xFF0000) \>> 16, (l&0xFF00) \>> 8, l&0xFF);

}

return Buffer.concat(\[new Buffer(s), buf\]);

}
```

注意s.push((1 << 7) + 2)这一句，这里等于直接把opcode写死了为2，对于Binary Frame，这样客户端接收到数据是不会尝试进行toString的，否则会报错~

代码很简单，在这里向大家分享一下websocket传输图片的速度如何

测试很多张图片，总共8.24M

普通静态资源服务器需要20s左右（服务器较远）

cdn需要2.8s左右

那我们的websocket方式呢？？！

答案是同样需要20s左右，是不是很失望……速度就是慢在传输上，并不是服务器读取图片，本机上同样的图片资源，1s左右可以完成……这样看来数据流也无法冲破距离的限制提高传输速度

下面我们来看看websocket的另一个用法~

用websocket搭建语音聊天室

先来整理一下语音聊天室的功能

用户进入频道之后从麦克风输入音频，然后发送给后台转发给频道里面的其他人，其他人接收到消息进行播放

看起来难点在两个地方，第一个是音频的输入，第二是接收到数据流进行播放

先说音频的输入，这里利用了HTML5的getUserMedia方法，不过注意了，这个方法上线是有大坑的，最后说，先贴代码

```
if (navigator.getUserMedia) {

 navigator.getUserMedia(

 { audio: true },

 function (stream) {

 var rec \= new SRecorder(stream);

 recorder \= rec;

 })

}
```

第一个参数是{audio: true}，只启用音频，然后创建了一个SRecorder对象，后续的操作基本上都在这个对象上进行。此时如果代码运行在本地的话浏览器应该提示你是否启用麦克风输入，确定之后就启动了

接下来我们看下SRecorder构造函数是啥，给出重要的部分

```
var SRecorder \= function(stream) {

 ……

  var context \= new AudioContext();

 var audioInput \= context.createMediaStreamSource(stream);

 var recorder \= context.createScriptProcessor(4096, 1, 1);

 ……

}
```

AudioContext是一个音频上下文对象，有做过声音过滤处理的同学应该知道“一段音频到达扬声器进行播放之前，半路对其进行拦截，于是我们就得到了音频数据了，这个拦截工作是由window.AudioContext来做的，我们所有对音频的操作都基于这个对象”，我们可以通过AudioContext创建不同的AudioNode节点，然后添加滤镜播放特别的声音

录音原理一样，我们也需要走AudioContext，不过多了一步对麦克风音频输入的接收上，而不是像往常处理音频一下用ajax请求音频的ArrayBuffer对象再decode，麦克风的接受需要用到createMediaStreamSource方法，注意这个参数就是getUserMedia方法第二个参数的参数

再说createScriptProcessor方法，它官方的解释是：

Creates a ScriptProcessorNode, which can be used for direct audio processing via JavaScript.

——————

概括下就是这个方法是使用JavaScript去处理音频采集操作

终于到音频采集了！胜利就在眼前！

接下来让我们把麦克风的输入和音频采集相连起来

```
audioInput.connect(recorder);

recorder.connect(context.destination);
```

context.destination官方解释如下

The destination property of the AudioContext interface returns an AudioDestinationNoderepresenting the final destination of all audio in the context.

——————

context.destination返回代表在环境中的音频的最终目的地。

好，到了此时，我们还需要一个监听音频采集的事件

```
recorder.onaudioprocess \= function (e) {

 audioData.input(e.inputBuffer.getChannelData(0));

}
```

audioData是一个对象，这个是在网上找的，我就加了一个clear方法因为后面会用到，主要有那个encodeWAV方法很赞，别人进行了多次的音频压缩和优化，这个最后会伴随完整的代码一起贴出来

此时整个用户进入频道之后从麦克风输入音频环节就已经完成啦，下面就该是向服务器端发送音频流，稍微有点蛋疼的来了，刚才我们说了，websocket通过opcode不同可以表示返回的数据是文本还是二进制数据，而我们onaudioprocess中input进去的是数组，最终播放声音需要的是Blob，{type: ‘audio/wav’}的对象，这样我们就必须要在发送之前将数组转换成WAV的Blob，此时就用到了上面说的encodeWAV方法

服务器似乎很简单，只要转发就行了

本地测试确实可以，然而天坑来了！将程序跑在服务器上时候调用getUserMedia方法提示我必须在一个安全的环境，也就是需要https，这意味着ws也必须换成wss……所以服务器代码就没有采用我们自己封装的握手、解析和编码了，代码如下

```
var https \= require('https');

var fs \= require('fs');

var ws \= require('ws');

var userMap \= Object.create(null);

var options \= {

 key: fs.readFileSync('./privatekey.pem'),

 cert: fs.readFileSync('./certificate.pem')

};

var server \= https.createServer(options, function(req, res) {

 res.writeHead({

 'Content-Type' : 'text/html'

 });

 fs.readFile('./testaudio.html', function(err, data) {

 if(err) {

 return ;

 }

 res.end(data);

 });

});

var wss \= new ws.Server({server: server});

wss.on('connection', function(o) {

 o.on('message', function(message) {

if(message.indexOf('user') \=== 0) {

 var user \= message.split(':')\[1\];

 userMap\[user\] \= o;

} else {

 for(var u in userMap) {

userMap\[u\].send(message);

 }

}

 });

});

server.listen(8888);
```

代码还是很简单的，使用https模块，然后用了开头说的ws模块，userMap是模拟的频道，只实现转发的核心功能

使用ws模块是因为它配合https实现wss实在是太方便了，和逻辑代码0冲突

https的搭建在这里就不提了，主要是需要私钥、CSR证书签名和证书文件，感兴趣的同学可以了解下（不过不了解的话在现网环境也用不了getUserMedia……）

下面是完整的前端代码

```
var a \= document.getElementById('a');

var b \= document.getElementById('b');

var c \= document.getElementById('c');

navigator.getUserMedia \= navigator.getUserMedia || navigator.webkitGetUserMedia;

var gRecorder \= null;

var audio \= document.querySelector('audio');

var door \= false;

var ws \= null;

b.onclick \= function() {

 if(a.value \=== '') {

 alert('请输入用户名');

 return false;

 }

 if(!navigator.getUserMedia) {

 alert('抱歉您的设备无法语音聊天');

 return false;

 }

 SRecorder.get(function (rec) {

 gRecorder \= rec;

 });

 ws \= new WebSocket("wss://x.x.x.x:8888");

 ws.onopen \= function() {

 console.log('握手成功');

 ws.send('user:' + a.value);

 };

 ws.onmessage \= function(e) {

 receive(e.data);

 };

 document.onkeydown \= function(e) {

 if(e.keyCode \=== 65) {

 if(!door) {

 gRecorder.start();

 door \= true;

 }

 }

 };

 document.onkeyup \= function(e) {

 if(e.keyCode \=== 65) {

 if(door) {

 ws.send(gRecorder.getBlob());

 gRecorder.clear();

 gRecorder.stop();

 door \= false;

 }

 }

 }

}

c.onclick \= function() {

 if(ws) {

 ws.close();

 }

}

var SRecorder \= function(stream) {

 config \= {};

 config.sampleBits \= config.smapleBits || 8;

 config.sampleRate \= config.sampleRate || (44100 / 6);

 var context \= new AudioContext();

 var audioInput \= context.createMediaStreamSource(stream);

 var recorder \= context.createScriptProcessor(4096, 1, 1);

 var audioData \= {

 size: 0 //录音文件长度

 , buffer: \[\] //录音缓存

 , inputSampleRate: context.sampleRate //输入采样率

 , inputSampleBits: 16 //输入采样数位 8, 16

 , outputSampleRate: config.sampleRate //输出采样率

 , oututSampleBits: config.sampleBits //输出采样数位 8, 16

 , clear: function() {

 this.buffer \= \[\];

 this.size \= 0;

 }

 , input: function (data) {

 this.buffer.push(new Float32Array(data));

 this.size += data.length;

 }

 , compress: function () { //合并压缩

 //合并

 var data \= new Float32Array(this.size);

 var offset \= 0;

 for (var i \= 0; i < this.buffer.length; i++) {

 data.set(this.buffer\[i\], offset);

 offset += this.buffer\[i\].length;

 }

 //压缩

 var compression \= parseInt(this.inputSampleRate / this.outputSampleRate);

 var length \= data.length / compression;

 var result \= new Float32Array(length);

 var index \= 0, j \= 0;

 while (index < length) {

 result\[index\] \= data\[j\];

 j += compression;

 index++;

 }

 return result;

 }

 , encodeWAV: function () {

 var sampleRate \= Math.min(this.inputSampleRate, this.outputSampleRate);

 var sampleBits \= Math.min(this.inputSampleBits, this.oututSampleBits);

 var bytes \= this.compress();

 var dataLength \= bytes.length \* (sampleBits / 8);

 var buffer \= new ArrayBuffer(44 + dataLength);

 var data \= new DataView(buffer);

 var channelCount \= 1;//单声道

 var offset \= 0;

 var writeString \= function (str) {

 for (var i \= 0; i < str.length; i++) {

 data.setUint8(offset + i, str.charCodeAt(i));

 }

 };

 // 资源交换文件标识符

 writeString('RIFF'); offset += 4;

 // 下个地址开始到文件尾总字节数,即文件大小-8

 data.setUint32(offset, 36 + dataLength, true); offset += 4;

 // WAV文件标志

 writeString('WAVE'); offset += 4;

 // 波形格式标志

 writeString('fmt '); offset += 4;

 // 过滤字节,一般为 0x10 = 16

 data.setUint32(offset, 16, true); offset += 4;

 // 格式类别 (PCM形式采样数据)

 data.setUint16(offset, 1, true); offset += 2;

 // 通道数

 data.setUint16(offset, channelCount, true); offset += 2;

 // 采样率,每秒样本数,表示每个通道的播放速度

 data.setUint32(offset, sampleRate, true); offset += 4;

 // 波形数据传输率 (每秒平均字节数) 单声道×每秒数据位数×每样本数据位/8

 data.setUint32(offset, channelCount \* sampleRate \* (sampleBits / 8), true); offset += 4;

 // 快数据调整数 采样一次占用字节数 单声道×每样本的数据位数/8

 data.setUint16(offset, channelCount \* (sampleBits / 8), true); offset += 2;

 // 每样本数据位数

 data.setUint16(offset, sampleBits, true); offset += 2;

 // 数据标识符

 writeString('data'); offset += 4;

 // 采样数据总数,即数据总大小-44

 data.setUint32(offset, dataLength, true); offset += 4;

 // 写入采样数据

 if (sampleBits \=== 8) {

 for (var i \= 0; i < bytes.length; i++, offset++) {

 var s \= Math.max(\-1, Math.min(1, bytes\[i\]));

 var val \= s < 0 ? s \* 0x8000 : s \* 0x7FFF;

 val \= parseInt(255 / (65535 / (val + 32768)));

 data.setInt8(offset, val, true);

 }

 } else {

 for (var i \= 0; i < bytes.length; i++, offset += 2) {

 var s \= Math.max(\-1, Math.min(1, bytes\[i\]));

 data.setInt16(offset, s < 0 ? s \* 0x8000 : s \* 0x7FFF, true);

 }

 }

 return new Blob(\[data\], { type: 'audio/wav' });

 }

 };

 this.start \= function () {

 audioInput.connect(recorder);

 recorder.connect(context.destination);

 }

 this.stop \= function () {

 recorder.disconnect();

 }

 this.getBlob \= function () {

 return audioData.encodeWAV();

 }

 this.clear \= function() {

 audioData.clear();

 }

 recorder.onaudioprocess \= function (e) {

 audioData.input(e.inputBuffer.getChannelData(0));

 }

};

SRecorder.get \= function (callback) {

 if (callback) {

 if (navigator.getUserMedia) {

 navigator.getUserMedia(

 { audio: true },

 function (stream) {

 var rec \= new SRecorder(stream);

 callback(rec);

 })

 }

 }

}

function receive(e) {

 audio.src \= window.URL.createObjectURL(e);

}
```
注意：按住a键说话，放开a键发送

自己有尝试不按键实时对讲，通过setInterval发送，但发现杂音有点重，效果不好，这个需要encodeWAV再一层的封装，多去除环境杂音的功能，自己选择了更加简便的按键说话的模式

这篇文章里首先展望了websocket的未来，然后按照规范我们自己尝试解析和生成数据帧，对websocket有了更深一步的了解

最后通过两个demo看到了websocket的潜力，关于语音聊天室的demo涉及的较广，没有接触过AudioContext对象的同学最好先了解下AudioContext

文章到这里就结束啦~有什么想法和问题欢迎大家提出来一起讨论探索~

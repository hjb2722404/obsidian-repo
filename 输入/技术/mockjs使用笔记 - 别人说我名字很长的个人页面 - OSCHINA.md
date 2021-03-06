mockjs使用笔记 - 别人说我名字很长的个人页面 - OSCHINA

#   [mockjs使用笔记](https://my.oschina.net/tongjh/blog/2999834)

原原创

 [ ![50x50](../_resources/d68ef8ba07657fed6eddb909d5da7683.jpg)     别人说我名字很长](https://my.oschina.net/tongjh) 发布于 2019/01/10 17:32

字数 1155

阅读 1.1W

** 收藏 1

[点赞 1]()

[** 评论 0](https://my.oschina.net/tongjh/blog/2999834#comments)

 [npm](https://my.oschina.net/tongjh?q=npm)[Mock.js](https://my.oschina.net/tongjh?q=Mock.js)[iOS](https://my.oschina.net/tongjh?q=iOS)[Axios](https://my.oschina.net/tongjh?q=Axios)[heX](https://my.oschina.net/tongjh?q=heX)

 [#2020云栖大会#阿里云海量offer来啦！投简历、赢阿里云限量礼品及阿里云ACA认证免费考试资格！>>> ![hot3.png](../_resources/8cf8007931b1a5944f3a0a243a5afcc4.png)](https://developer.aliyun.com/topic/offer/yunqi?utm_content=g_1000179030)

mockjs可以非常方便的模拟后端的数据,方便前端开发，本例子使用vue开发

## 安装

- npm install mockjs --save-dev
- npm install axios --save

## 目录结构

- src/mock //mock文件存放目录
- src/mock/index.js //mock文件导出文件
- src/mock/user.js //user相关模拟数据

## src/mock/user.js

用户相关模拟数据

	import Mock from "mockjs"; // 引入mockjs
	const Random = Mock.Random; // Mock.Random 是一个工具类，用于生成各种随机数据

	//模拟获取用户列表
	export const user_list = (params)=>{
	    let list = [];
	    doCustomTimes(10,()=>{
	        list.push(Mock.mock({

	            //basic
	            'boolean': Random.boolean(), // 返回一个随机的布尔值。
	            'natural': Random.natural(1,100), // 返回一个随机的自然数（大于等于 0 的整数）
	            'integer': Random.integer(1, 100), // 生成1到100之间的整数
	            'float': Random.float(0, 100, 0, 5), // 生成0到100之间的浮点数,小数点后尾数为0到5位
	            'character': Random.character(), // 生成随机字符,可加参数定义规则
	            'string': Random.string( '壹贰叁肆伍陆柒捌玖拾', 3, 5 ),//返回一个随机字符串。
	            'range': Random.range(0, 10, 2), // 生成一个随机数组

	            //date
	            'date': Random.date('yyyy-MM-dd'), // 生成一个随机日期,可加参数定义日期格式
	            'time': Random.time('HH:mm:ss'), //获取一个随机时间
	            'datetime': Random.datetime(), // 返回一个随机的日期和时间字符串。
	            'now': Random.now(), // 返回当前的日期和时间字符串。

	            //image
	            'image': Random.image('200x100', '#00405d', '#FFF', 'Mock.js') ,//生成一个随机的图片地址。
	            'dataImage':Random.dataImage( Random.size, 'hello' ),//生成一段随机的 Base64 图片编码。

	            //color
	            'color': Random.color(),//随机生成一个有吸引力的颜色，格式为 '#RRGGBB'。
	            'hex': Random.hex(), //随机生成一个有吸引力的颜色，格式为 '#RRGGBB'。
	            'rgb':Random.rgb(), //随机生成一个有吸引力的颜色，格式为 'rgb(r, g, b)'。
	            'rgba': Random.rgba(), //随机生成一个有吸引力的颜色，格式为 'rgba(r, g, b, a)'。
	            'hsl': Random.hsl(), //随机生成一个有吸引力的颜色，格式为 'hsl(h, s, l)'。

	            //text
	            'paragraph': Random.paragraph( 3, 7 ), // 随机生成一段文本。
	            'cparagraph': Random.cparagraph( 1, 3 ), // 随机生成一段中文文本。
	            'sentence': Random.sentence( 1, 3 ), // 随机生成一个句子，第一个单词的首字母大写。
	            'csentence': Random.csentence( 1, 3 ),// 随机生成一段中文文本。
	            'word': Random.word( 1, 3 ),// 随机生成一个单词。
	            'cword': Random.cword('零一二三四五六七八九十', 10,15),//生成中文10到15个
	            'title': Random.title( 3, 5 ), // 随机生成一句标题，其中每个单词的首字母大写。
	            'ctitle': Random.ctitle( 3, 7 ), // 随机生成一句中文标题。

	            //name
	            'first': Random.first(),// 随机生成一个常见的英文名。
	            'last': Random.last(),// 随机生成一个常见的英文姓。
	            'name': Random.name(),// 随机生成一个常见的英文姓名。
	            'cfirst': Random.cfirst(),// 随机生成一个常见的中文名。
	            'clast': Random.clast(), // 随机生成一个常见的中文姓。
	            'cname': Random.cname(),//随机生成一个常见的中文姓名。

	            //web
	            'url': Random.url('http','baidu.com'), // 随机生成一个 URL。
	            'protocol': Random.protocol(), //随机生成一个 URL 协议
	            'domain': Random.domain(), //随机生成一个域名。
	            'tld': Random.tld(), //随机生成一个顶级域名
	            'email':Random.email('qq.com'),//随机生成一个邮箱
	            'ip':Random.ip(),//随机生成一个 IP 地址。

	            //address
	            'region':Random.region(),//随机生成一个（中国）大区。
	            'province':Random.province(),//随机生成一个（中国）省（或直辖市、自治区、特别行政区）
	            'city':Random.city(true),//布尔值。指示是否生成所属的省。
	            'county':Random.county(true),//随机生成一个（中国）县。
	            'zip':Random.zip(),//随机生成一个邮政编码（六位数字）
	            'address': Random.province(), // 生成地址

	            //helper
	            'capitalize': Random.capitalize('hello'),//把字符串的第一个字母转换为大写。
	            'upper': Random.upper( 'hello' ),//把字符串转换为大写。
	            'lower': Random.lower( 'HELLO' ),//把字符串转换为小写。
	            'pick': Random.pick( ['a', 'e', 'i', 'o', 'u'] ),//从数组中随机选取一个元素，并返回。
	            'shuffle': Random.shuffle( ['a', 'e', 'i', 'o', 'u'] ), //打乱数组中元素的顺序，并返回。

	            //miscellaneous
	            'guid': Random.guid(), //随机生成一个 GUID。
	            'id': Random.id(), //随机生成一个 18 位身份证。
	            'increment': Random.increment(2), //生成一个全局的自增整数。自增为2
	        }));
	    });
	    return list;
	}

	/**
	 * @param {Number} times 回调函数需要执行的次数
	 * @param {Function} callback 回调函数
	 */
	export const doCustomTimes = (times, callback) => {
	    let i = -1
	    while (++i < times) {
	        callback(i)
	    }
	}

### src/mock/index.js

mock导出

	import Mock from "mockjs";
	import { user_list } from "./user";

	// 配置Ajax请求延时，可用来测试网络延迟大时项目中一些效果
	Mock.setup({
	    timeout: 1000
	})

	//接口
	Mock.mock(/\/user\/list/, user_list)

	export default Mock

### src/main.js 配置

	require('./mock')  //引入mock

### 使用

	import axios from "axios";
	axios.get('/user/list',{page:1,pagesize:10}).then(res=>{
	    console.log(res)
	})

## 参考资料

> [http://mockjs.com/
> [https://github.com/nuysoft/Mock/wiki

© 著作权归作者所有
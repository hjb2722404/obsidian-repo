iOS开发支付集成之微信支付 - WK_IOSDevelpoer - 简书

[![New logo](../_resources/43f2e11f34b87e870ae06b7ca3a1cbdc.png)   手机必备写作阅读App   免费下载](http://www.jianshu.com/apps/download?utm_medium=top-download-banner&utm_source=mobile)

# iOS开发支付集成之微信支付

[(L)](http://www.jianshu.com/u/798126497bc4)
WK_IOSDevelpoer
作者
2016.02.18 14:02[** 打开App]()

> 这一篇是《iOS开发之支付》这一部分的继> [> 支付宝支付集成](http://www.jianshu.com/p/b88f87a552a1)> ，> [> 银联支付集成](http://www.jianshu.com/p/bc7471a5df7f)> 第三篇，微信支付。在集成的时候建议都要去下载最新版的SDK，因为我知道的前不久支付宝，银联都更新了一次，微信的不太清楚更新了没。

在被支付宝、银联坑过之后，发现其实微信支付的集成并没有想象中的那么困难，像支付宝那样简单地调用个方法就行，重要的难的部分都是后台来做的。微信支付也是需要签名的，也跟支付宝一样，可以在客户端签名，也可以在后台签名（当然，为了安全还是推荐在服务器上做签名，逻辑也比较好理解）。

集成前首先要看看文档，
**[开发文档在这里](https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=8_1)**还有

[APP端开发步骤](https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=8_5)也是需要好好看看的。

ps:[在微信开发者平台](https://open.weixin.qq.com/)注册APP这样的事一般的是经理给你做好的，这个可以忽略,如果需要做的话，可以[参考这篇文章](http://494075592.blog.51cto.com/10682677/1701260)。

### 交互流程

这个流程和[支付宝](http://www.jianshu.com/p/b88f87a552a1)的流程都差不多，理解了其实是一样的。
![1377427-359d12bff546cf2f.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141837.png)
微信支付流程
**首先需要理清楚流程**：
1. 用户使用APP客户端，选择商品下单。
2. 商户客户端（就是你做的APP）将用户的商品数据传给商户服务器，请求生成支付订单。
3. 商户后台调用统一下单API向微信的服务器发送请求，微信服务器生成预付单，并生成一个prepay_id返回给商户后台。
4. 商户后台将这个prepay_id返回给商户客户端。
5. 用户点击确认支付，这时候商户客户端调用SDK打开微信客户端，进行微信支付。

6. 微信客户端向微信服务器发起支付请求并返回支付结果（他们之间交互用的就是prepay_id这个参数，微信的服务器要验证微信客户端传过去的参数是否跟第三步中生成的那个id一致）。

7. 用户输入支付密码后，微信客户端提交支付授权，跟微信服务器交互，完成支付
8. 微信服务器给微信客户端发送支付结果提示，并异步给商户服务器发送支付结果通知。
9. 商户客户端通过支付结果回调接口查询支付结果，并向后台检查支付结果是否正确，后台返回支付结果。
10. 商户客户端显示支付结果，完成订单，发货。
虽然看起来有点多，但是理解起来并不复杂，跟我们平时手机上买东西是一样的。我们客户端需要做的就是

- 调起微信客户端发起支付
- 显示支付结果

* * *

### 集成过程

##### 首先是要[下载SDK](https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=11_1)，

![1377427-3a0467eddb286df4.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141843.png)
微信SDK下载

建议头文件和示例都下载出来看看。（吐槽下，官方的示例难看死了，看的眼晕！注释都没几个。。。鄙视之）

##### 导入微信支付SDK库

导入上面那个**iOS头文件和库下载**下载出来的SDK包的就行啦，我这里的是SDK1.6.2. 然后需要链接上依赖库，在Target —> BuildPhases —> Link Binary With Libraries— 点击+号 -> 搜索你需要的系统库。

- SystemConfiguration.framework
- libz.tbd
- libsqlite3.0.tbd
- CoreTelephony.framework
- QuartzCore.framework

##### 设置URL Scheme

在注册微信平台APP的时候，会给一个唯一识别标识符（APPID），在[APP端开发步骤](http://7xqo6u.com1.z0.glb.clouddn.com/%E5%BE%AE%E4%BF%A1SDK%E4%B8%8B%E8%BD%BD.png)里面说得很清楚了，需要填在URL Schemes这个地方，

![1377427-beca5fe0ce08d030.png.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141847.jpg)
URL scheme

##### 在Appdelegate中注册APPID

如下：

`- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { // Override point for customization after application launch. /** * 向微信终端注册ID，这里的APPID一般建议写成宏,容易维护。@“测试demo”不需用管。这里的id是假的，需要改这里还有target里面的URL Type */ [WXApi registerApp:@"wxd930ea5d5a258f4f" withDescription:@"测试demo"]; return YES; }`

**处理微信通过URL启动时传递的数据**

`//前面的两个方法被iOS9弃用了，如果是Xcode7.2网上的话会出现无法进入进入微信的onResp回调方法，就是这个原因。本来我是不想写着两个旧方法的，但是一看官方的demo上写的这两个，我就也写了。。。。 //9.0前的方法，为了适配低版本 保留 - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{ return [WXApi handleOpenURL:url delegate:self]; } - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{ return [WXApi handleOpenURL:url delegate:self]; } //9.0后的方法 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{ //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，） return [WXApi handleOpenURL:url delegate:self]; } //微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的 -(void) onResp:(BaseResp*)resp { //启动微信支付的response NSString *payResoult = [NSString stringWithFormat:@errcode:%d, resp.errCode]; if([resp isKindOfClass:[PayResp class]]){ //支付返回结果，实际支付结果需要去微信服务器端查询 switch (resp.errCode) { case 0: payResoult = @支付结果：成功！; break; case -1: payResoult = @支付结果：失败！; break; case -2: payResoult = @用户已经退出支付！; break; default: payResoult = [NSString stringWithFormat:@支付结果：失败！retcode = %d, retstr = %@, resp.errCode,resp.errStr]; break; } } }`

##### 最重要的来了！！

调用微信支付前，需要下单、签名等操作，以便获取微信支付所必要的参数。为了提高安全性，下单、签名操作一般是在后台完成，在前台做的话被捕获改信息就不开心了。。。。。

**需要的参数包括**：appid、partid（商户号）、prepayid（预支付订单ID）、noncestr（参与签名的随机字符串）、timestamp（参与签名的时间戳）、sign（签名字符串）这六个。

在点击支付的控制器中使用**核心代码**来调起微信客户端支付,这些个参数都是后台传给你的。 加上了注释，应该很好理解的。

`#pragma mark 微信支付方法 - (void)WXPay{ //需要创建这个支付对象 PayReq *req = [[PayReq alloc] init]; //由用户微信号和AppID组成的唯一标识，用于校验微信用户 req.openID = @""; // 商家id，在注册的时候给的 req.partnerId = @""; // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你 req.prepayId = @""; // 根据财付通文档填写的数据和签名 //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay req.package = @""; // 随机编码，为了防止重复的，在后台生成 req.nonceStr = @""; // 这个是时间戳，也是在后台生成的，为了验证支付的 NSString * stamp = @""; req.timeStamp = stamp.intValue; // 这个签名也是后台做的 req.sign = @""; //发送请求到微信，等待微信返回onResp [WXApi sendReq:req]; }`

这个**JSON**里面的数据（上面的参数）就是后台需要传给你的，至于怎么来，也有后台的文档，让他去看下就行啦~~~

`{ "appid": "wxb4ba3c02aa476ea1", "noncestr": "d1e6ecd5993ad2d06a9f50da607c971c", "package": "Sign=WXPay", "partnerid": "10000100", "prepayid": "wx20160218122935e3753eda1f0066087993", "timestamp": "1455769775", "sign": "F6DEE4ADD82217782919A1696500AF06" }`

- [统一下单API](https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=9_1)
- [调起支付接口](https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=9_12&index=2)

到这里，不出意外的话应该都能正常的支付了。流程最重要，理解了就知道怎么做了，强烈建议需要做的朋友们先理理思路，不要急着下手。

* * *

PS:这篇文章中，签名都是在后台做的，如果需要在你客户端做，可以参考下[这篇文章](http://www.2cto.com/weixin/201507/412756.html)，和[这篇文章](http://www.2cto.com/kf/201505/403346.html)，他们的签名在客户端做的，写的也比较详细了。

### 可能遇到的问题

**1.如果支付完成后，一直留在微信**，那就检查下URLType中的Scheme设置问题。

**2.能够打开微信客户端，但是打开后只有中间一个白色的 “确定按钮”，点击后会回到客户端上**，如果是这样，那应该是prepayid 参数的问题，过期了，或者不是真实的id。代码没有问题的。特别注意的是，微信要两次签名，两次~~~~

**3.如果APP里面使用了友盟或者ShareSDK做分享**，那就不用再导入SDK了，否则会出现一些诡异的问题，例如无法调起手机微信客户端、无法调起微信客户端web页面，调起了但是一闪而过。。。这都基本上都是因为分享的SDK里面已经包括了微信的SDK。所以如果出现诡异的错误了看看是不是两个冲突了！

**4.微信支付的单位是分**，被坑过的人都知道了。。。。哎，
如果在集成过程中遇到什么问题，大家可以一起讨论下，我记录这些如果有什么错误的话也请告诉我！谢谢！
© 著作权归作者所有
文章作者
[(L)](http://www.jianshu.com/u/798126497bc4)
[个人主页**](http://www.jianshu.com/u/798126497bc4)
WK_IOSDevelpoer
作者
写了 33396 字，获得了 661 个喜欢
从事iOS开发工作，热爱学习新技术！希望能和大家一起交流学习，Q826798920，微信wan...
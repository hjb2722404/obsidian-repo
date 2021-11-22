update-notifier – 张歆琳

# update-notifier

293月
2019年3月29日

[update-notifier](https://github.com/yeoman/update-notifier)会异步在背后默默检查npm包的可用最新版。本质就是开了child_process运行在后台，如果检查到有可用更新版，会将结果保存在.update属性中。

notifier = updateNotifier(options)：返回一个带有.update属性的实例，如果没有可用的更新版，该属性值为undefined。options支持：

- pkg：object型，name和version是必须属性
- updateCheckInterval：多久检查一次，单位ms，默认值1000 * 60 * 60 * 24（一天）
- callback(error, update)：update就是notifier.update属性值
- shouldNotifyInNpmScript：（不太明白有啥用）默认false

notifier.notify([options])：显示通知消息，见下图。options支持：

- defer：等进程exit后显示，默认true
- message：自定义显示的文字
- isGlobal：相当于npm i -g
- boxenOpts：自定义盒子样式，默认{padding: 1, margin: 1, align: ‘center’, borderColor: ‘yellow’, borderStyle: ’round’}，详见[boxen](https://github.com/sindresorhus/boxen)

const updateNotifier = require('update-notifier');
updateNotifier({
pkg: {
name: 'chalk',
version: '2.4.0'
},
updateCheckInterval: 0
}).notify();
![update-notifier-300x106.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106130338.png)
项目中用在cli命令行工具里:
const updateNotifier = require('update-notifier');
const pkg = require('../../package.json');
updateNotifier({ pkg }).notify();
// pkg: { name: 'tool-demo', version: '1.0.0' }，如果cli有版本更新，客户端能提示有新版的cli

[vzhangxinlin](https://zxljack.com/author/zhangxinlin/)H[node & 工程化](https://zxljack.com/category/node/)I[update-notifier](https://zxljack.com/tag/update-notifier/)[J 发表评论](https://zxljack.com/2019/03/update-notifier/#respond)

[« yargs高阶用法](https://zxljack.com/2019/03/yargs-advance/)
[聊粒子-希格斯玻色子 »](https://zxljack.com/2019/03/higgs-boson/)

### 发表评论

电子邮件地址不会被公开。 必填项已用*标注
评论
姓名 *
电子邮件 *
站点
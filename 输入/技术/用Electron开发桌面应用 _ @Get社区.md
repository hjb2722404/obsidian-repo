# 什么是JavaScript桌面应用

在我心中，桌面应用一直占据着一个特殊的地位。随着浏览器，移动设备变得越来越强大，被移动和web应用取代的桌面应用呈稳定下滑趋势。但编写桌面应用还是有很多优势的--它们会一直存在于你的开始目录或者Dock栏中，可以被alt（cmd）+tab来回切换，并且大部分比web应用与底层系统联系的更紧密（快捷键，通知推送等）。

本文中，我会引导你用JavaScript创建一个简单桌面应用，接触相关的概念。

用JavaScript编写桌面应用的核心思想是编写一套资料库，把它分别打包来兼容各个操作系统。不需要创建原生桌面应用的知识，维护起来更简单。现在，用JavaScript开发桌面应用主要是使用[Electron](http://electron.atom.io/)或者[NW.js](http://nwjs.io/)。尽管两种工具提供的功能相似，我更喜欢Electron，因为它有一些我认为[很重要的优势](http://www.example.com/)。到头来，你用哪一个都没有问题。

# **基本假定**

我假定你已经有了文本编辑器（或者IDE），并且安装了[Node.js和npm](https://nodejs.org/download/)。同样假定你已经掌握HTML/CSS/JavaScript的知识（如果会Node.js和CommonJS模块更好，不过并不是必需的），这样可以将重点放在学习Electron，而不需要担心创建用户界面（其实就是普通的web页面）。如果你不符合前面几点，你也许会感到有些迷惑，我推荐你看下[我的前一篇文章](https://medium.com/@bojzi/overview-of-the-.-ecosystem-8ec4a0b7a7be)来学习基础。

# **Electron 概述**

简单来说，Electron为用纯JavaScript创建桌面应用提供了运行时。原理是，Electron调用你在package.json中定义的main文件并执行它。main文件（通常被命名为main.js）会创建一个内含渲染完的web页面的应用窗口，并添加与你操作系统的原生GUI（图形界面）交互的功能。

详细地说，当用Electron启动一个应用，会创建一个主进程。这个主进程负责与你系统原生的GUI进行交互并为你的应用创建GUI（在你的应用窗口）。

![0b998dc2ebd3441852e5423fc8e723c1.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130933.png)

仅启动主进程并不能给你的应用用户创建应用窗口。窗口是通过main文件里的主进程调用叫BrowserWindow的模块创建的。每个浏览器窗口会运行自己的渲染进程。渲染进程会在窗口中渲染出web页面（引用了CSS，JavaScript，图片等的HTML文件）。web页面是[Chromium](https://www.chromium.org/)渲染的，因为各系统下标准是统一的的，所以兼容性很好。

举例来说，如果你有一个计算器应用，主进程会初始化一个窗口来呈现实际的web页面（计算器）。

虽说只有主进程才和系统原生GUI交互，还是有技术可以把部分任务转到渲染进程中运行。

主进程通过一套[可直接调用的Electron模块](https://github.com/atom/electron/tree/master/docs/api)与原生GUI交互，桌面应用可以使用所有的Node模块，如用[node-notifier模块](https://github.com/mikaelbr/node-notifier)来推送系统通知，[request模块](https://www.npmjs.com/package/request)来发起HTTP请求等。

* * *

# Hello, world!

## **练习用资料库**

现在，让我们做好准备，用传统的「Hello，World」来开始。

本指南的同步练习资料库是[sound-machine-tutorial](https://github.com/bojzi/sound-machine-electron-guide)。首先把资料库clone下来：

git clone  [https://github.com/bojzi/sound-machine-electron-guide.git](https://github.com/bojzi/sound-machine-electron-guide.git)

进入sound-machine-tutorial文件夹，用下面的代码在git的tag之间切换：
git checkout <tag-name>
我会提示你该用哪个tag：
请切换至:
git  checkout 00-blank-repository
当你clone完代码，切换到你想要的tag，运行：
npm install

这样你安装好全部Node模块了。
如果你不能转换到另一个tag，最简单的办法是重置你的资料库状态再切换：

git add -A
git reset  --hard
**开始**
请切换到00-blank-repository这个tag:
git  checkout 00-blank-repository
在项目文件夹中新建package.json文件，写入下面的内容：

这个简单的package.json文件：

- 设置应用的名字和版本号，
- 设置Electron主进程运行的脚本（main.js），
- 设置一个很实用的快捷键--在你的CLI（命令行）中可以用「npm start」方便地启动应用。

现在该安装Electron了，最简单的方式是用npm为你的操作系统安装预构建的二进制文件。并在package.json文件中将它设置为开发依赖（用--save-dev命令后缀自动设置）。在CLI中运行命令：

npm install  --save-dev electron-prebuilt

预构建的二进制文件是为所在的操作系统量身订造的，可以运行「npm start」。我们将它作为开发依赖安装是因为只在开发过程中用到它。

就这样，Electron开发所需的一切都准备好了。

## **跟世界打个招呼**

新建app文件夹，在其中新建有下面代码的index.html文件：

# Hello, world!

在项目的根目录下新建一个main.js文件。Electron的主进程将用它来启动并创建「Hello, world」桌面应用。main.js中的代码：

'use strict';var app = require('app');var BrowserWindow = require('browser-window');var mainWindow = null;

app.on('ready', function() {
mainWindow = new BrowserWindow({
height: 600,
width: 800 });
mainWindow.loadUrl('file://' + __dirname + '/app/index.html');
});

没什么吓人的，不是吗？
「app」模块会控制应用的生命周期（例如， 对应用的ready状态做出反应）。
「BrowserWindow」模块为你创建窗口。
「mainWindow」对象是你应用的主窗口，被声明成null，否则当JavaScript垃圾回收掉这个对象时，窗口会被关闭。
当「app」捕获ready事件，「BrowserWindow」创建一个800*600大小的窗口。
浏览器窗口的渲染进程会渲染index.html文件。
在CLI中键入下面命令启动「Hello, World!」：

npm start
现在为你的第一个Electron程序欢呼吧。
![d6da10c35913e395eef2bc07498f69dc.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130940.png)

* * *

# 开发真正的应用

## **超棒的发声器**

首先，什么是发声器？

发声器当你点击不同按钮时会播放不同声音的小设备，大部分是卡通或特效声。是在办公室用来放松心情的，很有趣的工具，随着开发的进行，会碰到的很多新的概念，所以这也是一个很好的开发桌面应用的实例（也是一个非常棒的发声器）。

![6bd88d66e970c29a0f4ab5510a8dce02.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130947.png)
我们将完成的功能和探索的概念包括：

- 基础发声器（基本的浏览器窗口初始化），
- 关闭发声器（在主进程和渲染进程之间远程通信），
- 不需要把焦点切到应用就可以播放声音（全局快捷键），
- 创建快捷键的设定界面，来变更键位（Shift，Ctrl和Alt）（保存在用户的个人文件夹设置中），
- 加一个托盘图标（远程创建原生GUI元素，了解菜单和托盘图标），
- 打包你的应用（把你的应用打包成 Mac，Windows，Linux下可用的版本）。

* * *

## 实现发声器的基础功能

**应用的结构**

你已经实现了一个运行正常的「Hello World!」应用，现在是时候实现一个发声器应用了。
典型的发声器功能包括几排按钮，点击播放声音，这些声音大部分是卡通式的或者特效式的（如大笑，鼓掌，玻璃碎裂声等）。
那就是我们要完成的第一个功能--能对点击能做出响应的发声器。
![775a7f6eb927e09b326c974870a1f5ee.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130954.png)

应用结构是比较简单的。
在应用的根目录，保存着package.json文件，main.js文件和其他文件。
app文件夹保存HTML文件，其中在css，js，wav和img文件夹中保存相应类型的文件。

为了简便，web页面所需的全部文件都已经保存在资料库的初始状态中。现在切换到01-start-project这个tag。如果你之前跟着指南操做，创建了「Hello World!」应用，你需要先重置资料库再切换：

If you followed along with the "Hello, world!" example:
git add -A
git reset --hard
切换到01-start-project这个tag:
git checkout 01-start-project

为了简便，发声器将只有两种声音，但扩展到全部16种声音也非常简单，只需要其他声音和图标文件，修改index.html就可以。
**完成主进程**
用main.js定义发声器的外观。用下面的代码代替原内容：

'use strict';var app = require('app');var BrowserWindow = require('browser-window');var mainWindow = null;

app.on('ready', function() {
mainWindow = new BrowserWindow({
frame: false,
height: 700,
resizable: false,
width: 368 });
mainWindow.loadUrl('file://' + __dirname + '/app/index.html');
});

我们用传给「app」模块的尺寸参数，自定义了新建窗口的大小，设定它是固定尺寸并且无边栏。它会浮在你的桌面上，就像真的发声机一样。
现在的问题是 -- 如何移动一个没有边栏的窗口（没有标题栏），如何关闭它？
我很快就会讲解自定义窗口（应用）关闭（并介绍一种主进程和渲染进程通信的方法），但拖动部分很简单，在index.css（app/css文件夹下）文件中：

html,
body {
...
-webkit-app-region: drag;
...
}

-webkit-app-region:drag;使整个html变成一个可拖动的对象。现在有一个问题，你不能点击可拖动对象里的按钮。答案就是-webkit-app-region: no-drag;能定义不可拖动（但是可以点击）的对象，参考index.css的中的代码：

.button-sound {
...
-webkit-app-region: no-drag;
}
**在窗口中显示发声器**

main.js文件现在可以新建一个窗口来显示发声器。如果用npm start启动应用，你可以看到发声器非常逼真。现在点击没有反应，这并不奇怪，我们只有一个静态的web页面。

添加下面的代码到index.js（app/js文件夹）文件中会添加交互效果：

'use strict';var soundButtons = document.querySelectorAll('.button-sound');for (var i = 0; i < soundButtons.length; i++) { var soundButton = soundButtons[i]; var soundName = soundButton.attributes['data-sound'].value;

prepareButton(soundButton, soundName);
}function  prepareButton(buttonEl, soundName) {

buttonEl.querySelector('span').style.backgroundImage = 'url("img/icons/' + soundName + '.png")'; var audio = new Audio(__dirname + '/wav/' + soundName + '.wav');

buttonEl.addEventListener('click', function () {
audio.currentTime = 0;
audio.play();
});
}

代码很简单，我们：

- 查询所有声音按钮，
- 遍历所有的按钮读取data-sound属性，
- 给每个按钮加背景图，
- 给每个按钮加一个点击事件来播放音频（调用[HTML AudioElement接口](https://developer.mozilla.org/en/docs/Web/API/HTMLAudioElement)）

CLI中输入下面命令来测试应用：

npm start
![2572a7971d8b192c2dc8deba4fb15881.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131004.png)

* * *

## 用远程事件从浏览器窗口关闭应用

请切换到02-basic-sound-machine这个tag:
git  checkout 02-basic-sound-machine

简要重述--应用窗口（更准确的说是渲染进程）应该不能与GUI（用来关闭窗口）通信的，官方的[Electron快速入门指南](https://github.com/atom/electron/blob/master/docs/tutorial/quick-start.md)写到：

> 在web页面，不允许调用原生GUI相关的API，因为在web页面管理原生GUI资源是很危险的，会很容易泄露资源。如果你想在web页面施行GUI操作，web页面的渲染进程必须要与主进程通信，请求主进程来完成这些操作。

Electron提供[ipc（进程间通信）模块](https://github.com/atom/electron/blob/master/docs/api/ipc-renderer.md)来实现这类通信。ipc模块可实现从通道订阅消息，发送消息给通道的订阅者，通道区分消息的接收者，用字符来标识（例如，通道1，通道2）。消息也可以包含数据。当接收到消息，订阅者可以做出反应，甚至回复消息。消息最大的好处就是隔离 -- 主进程不必知道哪个渲染进程发出消息。

![99bef2495322245fd483672675727744.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131013.png)

这正是我们在做的 -- 主进程（main.js）订阅「close-main-window」通道的消息，关闭按钮被点击时，渲染进程（index.js）通过通道发出消息。

在main.js里添加下面的代码，从通道订阅消息：

var ipc = require('ipc');
ipc.on('close-main-window', function () {
app.quit();
});

引入ipc模块后，通过通道订阅消息就变得很简单，on()方法设置订阅的通道名，定义回调函数。
渲染进程要通过通道发送消息，将下面代码加入index.js：
var ipc = require('ipc');var closeEl = document.querySelector('.close');
closeEl.addEventListener('click', function () {
ipc.send('close-main-window');
});

同样，我们引入ipc模块，给关闭按钮的元素绑定一个click事件。当点击关闭按钮时，通过「close-main-window」通道的send()方法发送消息。
这里还有个小问题，如果不注意会卡住你，我们已经讨论过--可拖动区域的可点击性。index.css需要把关闭按钮定义成不可拖动：
.settings {
...
-webkit-app-region: no-drag;
}

就这样，现在可以点击关闭按钮关闭我们的应用了。因为要监听事件或传递参数，通过ipc模块通信比较复杂。我们后面会看到一个传递参数的例子。

* * *

## 用全局快捷键播放声音

请切换到名为03-closable-sound-machine的tag:
git  checkout 03-closable-sound-machine

基础的发声器工作顺利，但是我们有一个易用性问题--如果发声器一定需要切到应用窗口，再点击才能播放，这个发声器有什么用？

这时我们需要的就是全局快捷键。Electron提供一个[全局快捷键模块](https://github.com/atom/electron/blob/master/docs/api/global-shortcut.md)，允许你监听自定义的键盘组合并做出反应。键盘组合也被叫做[加速器](https://github.com/atom/electron/blob/master/docs/api/accelerator.md)，是一系列键盘点击组成的字符串（例如 “Ctrl+Shift+1”）。

![a85dd58dab549a8687beba0b101f87d3.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131030.png)

既然我们想要捕捉一个原生GUI事件（全局快捷键），然后在应用窗口做出反应（播放声音），我们仍用ipc模块在主进程和渲染进程之间通信。
在深入到代码层面前，有两件事要考虑：
1. 全局快捷键应在app的「ready」事件触发后被注册（在ready代码块中），

2. 当通过ipc从主进程发送消息到渲染进程的时候，你要引用到那个窗口（就像「createWindow.webContent.send('channel')」）

记住这些，现在用下面的代码来修改我们的main.js文件：
var globalShortcut = require('global-shortcut');
app.on('ready', function() {

... // existing code from earlier globalShortcut.register('ctrl+shift+1', function () {

mainWindow.webContents.send('global-shortcut', 0);
});
globalShortcut.register('ctrl+shift+2', function () {
mainWindow.webContents.send('global-shortcut', 1);
});
});

首先，我们需要引入global-shortcut模块。然后当我们的程序加载完成，我们注册两个快捷键--一个响应Ctrl，Shift，1组合键，另一个响应Ctrl，Shift，2组合键。两者都会通过「global-shortcut」通道发送一条带一个参数的消息。我们用这些参数来播放相应的声音。在index.js中加入以下代码：

ipc.on('global-shortcut', function (arg) { var event = new MouseEvent('click');
soundButtons[arg].dispatchEvent(event);
});

为了方便，我们会模拟一次按钮点击，用我们创建的soundButton选择器给按钮绑定一个播放声音。当收到带有参数1的消息，我们在soundButton[1]元素上模拟一次鼠标点击（在正式环境的应用，你应该封装播放声音的代码，并执行它）。

* * *

## 在新的窗口修改键位配置

切换到名为04-global-shortcuts-bound的tag:
git checkout 04-global-shortcuts-bound

系统同时运行很多应用程序，我们预想的快捷键可能已经被占用了。这正是我们将要新建一个设置窗口，保存我们想要的键位修改的原因。
要实现这个目标，我们需要：

- 主窗口要有一个设置按钮，
- 一个设置窗口（需要相应的HTML，CSS和JavaScript文件），
- ipc消息用来打开，关闭设置窗口及更新全局快捷键，
- 保存或读取用户系统里JSON格式的设置文件。

**设置按钮和设置窗口**

类似关闭主窗口，当点击设置按钮时我们通过通道从index.js发送消息。将下面代码加入index.js：

var settingsEl = document.querySelector('.settings');
settingsEl.addEventListener('click', function () {
ipc.send('open-settings-window');
});

点击设置按钮后，通道「open-settings-window」会发送一条消息到主进程。main.js现在需要做出响应，新建一个窗口，将下面代码插入main.js：

var settingsWindow = null;
ipc.on('open-settings-window', function () { if (settingsWindow) { return;
}
settingsWindow = new BrowserWindow({
frame: false,
height: 200,
resizable: false,
width: 200 });
settingsWindow.loadUrl('file://' + __dirname + '/app/settings.html');
settingsWindow.on('closed', function () {
settingsWindow = null;
});
});

没有什么新概念，我们会像打开主窗口一样打开新的设置窗口。不同之处是要先检查设置窗口是不是已经被打开，以防重复打开。
打开后，需要一种方法关闭设置窗口。同样的，我们会通过通道发送一条消息，但这次消息是从settings.js发出，将下面代码写入setting.js：

'use strict';var ipc = require('ipc');var closeEl = document.querySelector('.close');

closeEl.addEventListener('click', function (e) {
ipc.send('close-settings-window');
});

在main.js里面监听那个通道，代码如下：
ipc.on('close-settings-window', function () { if (settingsWindow) {
settingsWindow.close();
}
});

我们的设置窗口就完成了。
**保存和读取用户的设置**

切换到名为05-settings-window-working的tag:
git checkout 05-settings-window-working

与设置窗口交互，保存设置，再读取到我们的应用的过程大致是这样的：

- 编写一个可以保存和读取我们在JSON文件中保存设置信息的办法，
- 初始化设置窗口时，显示这些设置，
- 通过客户的交互更新设置，
- 通知主程序新的设置。

我们可以简单的保存和读取main.js中的设置，但模块把逻辑抽象出来，以便我们可以在不同的地方引用，这看看起来更好。

**Working with a JSON configuration**

那就是我们新建configuration.js的原因。Node.js用[CommonJS模块规范](https://nodejs.org/docs/latest/api/modules.html)，这意味着你只可以暴露你的API，而其他文件或方法会引用API提供的方法。

![9b76fc8ecfa82f808e8c67893b191ec8.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131038.png)

为了让保存和读取更简便，使用nconf模块，它已经为我们抽象出读取和写入JSON文件的方法，非常符合我们的需求。但首先，我们要在CLI中执行下面的命令将它引入项目中：

npm install  --save nconf

npm将nconf模块作为应用的依赖安装。在我们打包应用给终端用户时（相对用save-dev参数会只在开发环境中引入模块）将被引入和使用。
configuration.js文件非常的简单，在项目根目录下新建configuration.js文件，写入代码：

'use strict';var nconf = require('nconf').file({file: getUserHome() + '/sound-machine-config.json'});function  saveSettings(settingKey, settingValue) {

nconf.set(settingKey, settingValue);
nconf.save();
}function  readSettings(settingKey) {
nconf.load(); return nconf.get(settingKey);

}function  getUserHome() { return process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'];

}module.exports = {
saveSettings: saveSettings,
readSettings: readSettings
};

nconf只需要知道你的设置要保存到哪里，这里我们设置为客户的主文件夹和一个文件名。获取用户的主文件夹非常简单，只需要区别不同系统调用Node.js（process.env）（如用getUserHome()方法）。

通过nconf的内建方法来保存或读取设置（set()方法保存，get()方法读取，用save()和load()方法进行文件操作），用符合CommonJS规范的module.exports语法来导出API。

**初始化修改的快捷键**

在我们进行设置的交互之前，应初始化设置，以防我们先启动应用丢失设置信息。我们把变更键保存在一个数组中，数组以「shortcutKeys」为键，在main.js里初始化，我们首先要引用configuration模块：

'use strict';var configuration = require('./configuration');

app.on('ready', function () { if (!configuration.readSettings('shortcutKeys')) {

configuration.saveSettings('shortcutKeys', ['ctrl', 'shift']);
}
...
}

尝试读取「shortcutKeys」键对应的值，如果读取不到，就设置一个初始值。
现在要重写main.js中的全局快捷键，这个方法可以在后面更新设置的时候直接调用。 去掉原来在main.js中注册快捷键的方法，改成：
app.on('ready', function () {
...
setGlobalShortcuts(); }function  setGlobalShortcuts() {

globalShortcut.unregisterAll(); var shortcutKeysSetting = configuration.readSettings('shortcutKeys'); var shortcutPrefix = shortcutKeysSetting.length === 0 ? '' : shortcutKeysSetting.join('+') + '+';

globalShortcut.register(shortcutPrefix + '1', function () {
mainWindow.webContents.send('global-shortcut', 0);
});
globalShortcut.register(shortcutPrefix + '2', function () {
mainWindow.webContents.send('global-shortcut', 1);
});
}

方法会重置全局快捷键，现在我们可以设置新的快捷键，从设置文件读取变更键数组，转换[类加速器规则字符串](https://github.com/atom/electron/blob/master/docs/api/accelerator.md)，再注册全局快捷键。

**与设置窗口交互**
回到settings.js，我们要绑定click事件来修改我们的全局快捷键。首先，我们遍历所有勾选的复选框（从configuration模块中读取）：

var configuration = require('../configuration.js');var modifierCheckboxes = document.querySelectorAll('.global-shortcut');for (var i = 0; i < modifierCheckboxes.length; i++) { var shortcutKeys = configuration.readSettings('shortcutKeys'); var modifierKey = modifierCheckboxes[i].attributes['data-modifier-key'].value;

modifierCheckboxes[i].checked = shortcutKeys.indexOf(modifierKey) !== -1;
... // Binding of clicks comes here}

现在我们要给复选框绑定行为。记得设置窗口（渲染进程）不能改动GUI绑定。这意味着我们需要从setting.js通过ipc发送消息（后面会处理消息）：
for (var i = 0; i < modifierCheckboxes.length; i++) {
...
modifierCheckboxes[i].addEventListener('click', function (e) {
bindModifierCheckboxes(e);
});

}function  bindModifierCheckboxes(e) { var shortcutKeys = configuration.readSettings('shortcutKeys'); var modifierKey = e.target.attributes['data-modifier-key'].value; if (shortcutKeys.indexOf(modifierKey) !== -1) { var shortcutKeyIndex = shortcutKeys.indexOf(modifierKey);

shortcutKeys.splice(shortcutKeyIndex, 1);
} else {
shortcutKeys.push(modifierKey);
}
configuration.saveSettings('shortcutKeys', shortcutKeys);
ipc.send('set-global-shortcuts');
}

我们遍历了所有的复选框，绑定click事件，在每次点击时判断是否含有变更键。然后根据结果，修改数组，保存结果到设置，再给主进程发送消息，它会更新我们的全局快捷键。

下面要在main.js里的设置「set-global-shortcuts」这个ipc通道来更新我们的全局快捷键：
ipc.on('set-global-shortcuts', function () {
setGlobalShortcuts();
});

很简单，像这样，我们的全局快捷键就配置好了!

* * *

## 菜单上有什么?

切换到名为06-shortcuts-configurable的tag:
git  checkout 06-shortcuts-configurable
对桌面应用来说，另一个重要的概念就是菜单栏。分为上下文菜单（右击菜单），托盘菜单（绑定到托盘图标），应用菜单（在OS X上）等多种。
![c10c1a5ab1887e1d1e02886b8192466e.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131100.png)

在本指南中，我们将添加一个绑定菜单的托盘图标。我们也会利用这次机会探索另一种进程间通信--[remote模块](https://github.com/atom/electron/blob/master/docs/api/remote.md)。

remote模块实现从渲染进程向主进程发送RPC式调用。你引入模块，在渲染进程操作，方法在主进程被初始化，你调用的方法都在主进程被执行。实际中，这意味着你在index.js远程请求原生的GUI模块，调用它们的方法，都会在main.js中执行。你可以在index.js里引入BrowserWindow模块，初始化一个浏览器窗口。背后的原理是，异步调用新的浏览器窗口的主进程。

![a1b0fa5be575d2241a026908b4457b3a.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131106.png)

现在我们创建一个菜单，并把它绑定到托盘图标，在index.js中加入下面代码：

var remote = require('remote');var Tray = remote.require('tray');var Menu = remote.require('menu');var path = require('path');var trayIcon = null;if (process.platform === 'darwin') {

trayIcon = new Tray(path.join(__dirname, 'img/tray-iconTemplate.png'));
}else {
trayIcon = new Tray(path.join(__dirname, 'img/tray-icon-alt.png'));
}var trayMenuTemplate = [
{
label: 'Sound machine',
enabled: false },
{
label: 'Settings',
click: function  ()  {
ipc.send('open-settings-window');
}
},
{
label: 'Quit',
click: function  ()  {
ipc.send('close-main-window');
}
}
];var trayMenu = Menu.buildFromTemplate(trayMenuTemplate);
trayIcon.setContextMenu(trayMenu);

原生的GUI模块（菜单和托盘）的方法会被远程调用，是很安全的。

把图标定义成托盘图标。OS X支持图像模板（依照惯例，图像的文件名以「Template」结尾，可以被当做一个模板图像），这让使用深浅色主题变得很容易。其他系统用常规的图标。

在Electron中有很多种方法创建菜单。我们的方法是创建一个菜单模板（一个包含菜单项的简单数组），用那个模板创建菜单。最后，绑定新的菜单到托盘图标。

* * *

## 打包你的应用

切换到名为07-ready-for-packaging的tag:
git checkout 07-ready-for-packaging

如果不能让人们下载使用，这样的应用有什么意义？
![7f0bfb61a1e11479863e3e82a7b133a3.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131114.png)

用「[electron-packager](https://github.com/maxogden/electron-packager)」为所有系统打包你的应用很简单。简单来说，「electron-packager」帮你完成所有用Electron打包你应用的工作，最终生成你要发布的平台的安装包。

它可以作为CLI应用或构建过程的一部分，更复杂的构建情况不在本文所涉及范围内，但我们如果能用打包脚本，会使打包更简单。用「electron-packager」比较麻烦，打包应用的基本命令是：

electron-packager <location  of  project>  <name  of  project>  <platform>  <architecture>  <electron  version>  <optional  options>

其中，

- location of project是你项目文件夹的位置，
- name of project定义你的项目名，
- platform决定要构建的平台（*all* 包括Windows，Mac和Linux ），
- architecture决定构建哪个构架下（x86或x64，all表示两者），
- electron version让你选择要用的Electron版本

第一次打包用时比较久，因为要下载平台的二进制文件，随后的打包将会快的多。
我（在Mac系统）打包发声器应用的命令是：

electron-packager ~/Projects/sound-machine SoundMachine --all --version=0.30.2 --out=~/Desktop --overwrite --icon=~/Projects/sound-machine/app/img/app-icon.icns

命令的选项理解起来都比较简单。为了获得精美的图标，你首先要找一款类似[这个软件](http://www.example.com/)可以把PNG文件转换到这些格式的工具，把它转换成.icns格式（Mac用）或者.ico格式（Window用）。如果在非Windows系统给Windows平台的应用打包，你需要安装wine（Mac用户用brew，Linux用户用apt-get）。

每次都打这么长的命令很不方便，可以在package.json中加另一个脚本。首先，把electron-packager作为开发依赖安装：

npm install  --save-dev electron-packager
现在我们可以在package.json中添加脚本：

"scripts": { "start": "electron .", "package": "electron-packager ./ SoundMachine --all --out ~/Desktop/SoundMachine --version 0.30.2 --overwrite --icon=./app/img/app-icon.icns"}

在命令行里执行下面的命令：
npm run-script package

这个打包命令会启动electron-packager，在当前目录下找到目标应用文件，打包，保存到桌面。如果你用的是Windows系统，需要修改脚本，不过改动很小。

当前状态的发声器，最后打包后大小高达100MB。别担心，可以把它压缩到不到一半的容量。

如果你想要更进一步，可以尝试[electron-builder](https://github.com/loopline-systems/electron-builder)，它用electron-packager生成的打包好的文件，可以生成自动安装包。

* * *

## 可以添加的其他功能

应用已经打包好，准备就绪。你也可以添加自己想要的功能。
这是一些想法：

- 可以显示应用的快捷键，作者等信息的帮助界面，
- 加一个绑定菜单的图标入口可以打开信息界面，
- 为了更快的编译和分发，编写打包的脚本，
- 用[node-notifier](https://github.com/mikaelbr/node-notifier)加入通知功能，推送用户正播放的是什么声音，
- 用lodash得到更整洁的代码，
- 打包应用前，将你所有的CSS和JavaScript文件用构建工具压缩，
- 检查应用是否有新版本，用服务器调用之前介绍的node-notifier并通知客户

挑战来了--尝试抽取出发声器浏览器窗口的逻辑，用这些逻辑在浏览器中创建web页面，实现相同的发声器。一个代码库--两个产品（桌面应用和web应用），超棒！

* * *

# 深入Electron

我们只接触到了Electron比较浅显知识。实际上，实现如查看主机电源选项或在界面上显示多种信息都很简单。这些功能已经内建好，请[查阅Electronde API文档](https://github.com/atom/electron/tree/master/docs/api)。

Electron的API文档只是Electron在Github上资料库的一小部分，其他文件夹也值得一看。

Sindre Sorhus正在维护[超酷的Electron资源列表](https://github.com/sindresorhus/awesome-electron)，你可以在列表中找到很多很酷的项目，也有Electron应用构架方面很好的总结，可以学习之后重构我们的代码。

最后，Electron是基于io.js（将合并回Node.js）的，兼容绝大部分的Node.js模块，可以用来扩展你的应用，查看[npmjs.com](https://www.npmjs.com/)来获取你需要的信息。

* * *

# 这就完了？

当然不是。

现在是时候来创建更复杂的应用了。在本指南中，我没有选择用更多函数库和构建工具，只强调了重要的概念。你也可以用ES6或Typescript来写你的应用，使用Angular或React框架，用gulp或Grunt来简化你的构建过程。

为什么不用你最喜欢的语言，框架和构建工具，配合Flickr API，node-flickrapi创建一个Flickr桌面同步应用呢？或者用Google官方的Node.js函数库创建一个Gmail客户端？

选一个吸引你的想法，创建一个资料库，开始做吧。
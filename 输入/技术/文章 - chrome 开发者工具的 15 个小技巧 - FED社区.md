文章 - chrome 开发者工具的 15 个小技巧 - FED社区

![20150508225852010492886753](../_resources/f4108eff97abc6f90bf805b2909b53e7.png)

谷歌浏览器如今是Web开发者们所使用的最流行的网页浏览器。伴随每六个星期一次的发布周期和不断扩大的强大的开发功能，Chrome变成了一个必须掌握的工具。大多数前端开发者可能熟悉关于chorme的许多特点，例如使用console和debugger在线编辑CSS。在这篇文章中，我们将分享15个很酷的技巧，让你能够更好的改进工作流程。看完这些技巧你会惊奇而又兴奋的发现是不是很像Sublime Text。

# 1.快速文件转换

如果Sublime Text没有“Go to anything”这个功能你不可能活下去。所以你会很高兴听到DevTools 也有这个功能。当DevTools打开的时候，你可以按下`Ctrl + P`( 在Mac上使用`Cmd + P`)来快速的寻找和打开你工程中的任意文件。

![20150508225818497978195185](https://gitee.com/hjb2722404/tuchuang/raw/master/img/8ad6efd4565fd0d57c3061bb2225c984.gif)

# 2.在源代码中搜索

但是如果你希望在源代码中搜索该怎么办？按下`Ctrl + Shift + F`(在Mac上使用`Cmd + Opt + F`)，即可在所有已加载的文件中查找一个特定的字符串。这个搜索的方法也支持正则表达式。

![20150508225908358840361580](https://gitee.com/hjb2722404/tuchuang/raw/master/img/56cade3dc780c784ccf97f2ed79088ca.gif)

# 3.跳到特定行

当你打开一个在源标签里的文件之后，DevTools能够允许你轻松地跳转到代码里的任意一行，Windows 和 Linux用户只需要按下`Ctrl + G` (在Mac上使用 `Cmd + L` ),然后输入你想跳转的行数即可。

![20150508225935310792608368](https://gitee.com/hjb2722404/tuchuang/raw/master/img/8d703b4f29ca56da11f6805f540a46b1.gif)
另一个跳转的方法是按下`Ctrl + O` ，输入`:`和行数，而不用去寻找一个文件。

# 4.在控制台中选择元素

DevTools控制台支持一些变量和函数来选择DOM元素：

- **$()** : `document.querySelector()`的缩写，返回第一个与之匹配的CSS选择器的元素(例如：`$('div')` 它将返回本页的第一个div元素)。
- **$$()** : `document.querySelectorAll()`的缩写，返回一个数组，里面是与之匹配的CSS选择器的元素。
- **$0–$4** : 依次返回五个最近你在元素面板选择过的DOM元素的历史记录，$0是最新的记录，以此类推。

![201907291553435070000](https://gitee.com/hjb2722404/tuchuang/raw/master/img/b003fdd1ff59dad1e6dd452b78697013.gif)

了解更多关于Console的命令请阅读[![](https://f.ydr.me/developer.chrome.com)Command Line API](https://developer.chrome.com/devtools/docs/commandline-api)

# 5.使用多个光标和选择

另一个打败Sublime Text的特色出现了。当你在编辑一个文件的时候你可以通过按住`Ctrl` (在Mac上为 `Cmd`) 同时点击你想让光标停留的位置，设置多个光标，这样你就可以同时在多个位置输入同一文本了。

![201907291601464080000](https://gitee.com/hjb2722404/tuchuang/raw/master/img/df4e27a5b17a2f87a62de546910113ca.gif)

# 6.保存日志

勾选在Console标签下的保存日志选项，你可以使DevTools的console继续保存日志而不会在每个页面加载之后清除日志。当你想要研究在页面还没加载完之前出现的bug时，这会是一个很方便的方法。

![201907291553439520000](https://gitee.com/hjb2722404/tuchuang/raw/master/img/6421cb892798e996cf1071ad51470236.gif)

# 7.格式化打印{}

Chrome的开发者工具有一段嵌入的美化代码，它可以帮你返回一段最小化的且格式易读的代码。这个漂亮的印刷按钮在你正确打开文件之后的Sources标签下的左下角。

![201907291601466790000](https://gitee.com/hjb2722404/tuchuang/raw/master/img/45bcc3d6289ed2197faa11cab485dd9b.gif)

# 8.设备模式

DevTools包括了一个强大的模式可用来开发友好的移动端界面。
![201907291553447160000](https://gitee.com/hjb2722404/tuchuang/raw/master/img/b7a14214019e43e346139c3b5fad5b31.png)

# 9.设备仿真传感器

设备模式的另一个很酷的功能是模拟移动设备的传感器，例如触摸屏幕和加速计。你甚至可以恶搞你的地理位置。这个功能位于调试窗口的底部，点击调试窗口右上角的**show drawer**，就可看见`Emulation -> Sensors`。

![201907291601470080000](https://gitee.com/hjb2722404/tuchuang/raw/master/img/a716a4d65bbcb4c55ff3bae0498cc482.gif)

# 10.颜色选择器

当我们在样式编辑器中选择一种颜色时，你可以点击颜色预览，颜色选择器就会弹出。当颜色选择器开启时，如果你停留在某一页面，你的鼠标指针就会转换成一个放大镜，选择像素精度的颜色。

![201907291553452330000](https://gitee.com/hjb2722404/tuchuang/raw/master/img/55466d436e8eb8ed5594a49e32c1c25c.gif)

# 11.强制元素状态

DevTools有一个功能是模拟CSS的状态，如在元素中的`hover`和`focus`，这能够能容易的设计他们的样式。该功能来自css编辑器。
![201907291601473640000](https://gitee.com/hjb2722404/tuchuang/raw/master/img/65537001d4c338fec35c07147f14b8d0.gif)

# 12.查看Shadow DOM

由于其他基础的元素在视图中正常的隐藏，网页浏览器构建例如文本框，按钮和输入之类的东西。不过，你可以在`Settings -> General` 中切换成`Show user agent shadow DOM`，这样就会在元素标签页中显示被隐藏的代码。给了你很大的控制，让你甚至可以单独地设计他们。（ [![](https://f.ydr.me/www.html5rocks.com)Shadow DOM](http://www.html5rocks.com/zh/tutorials/webcomponents/shadowdom/)）

![201907291553459790000](https://gitee.com/hjb2722404/tuchuang/raw/master/img/41250f5945d71c99277bf77e7504c104.gif)

# 13.选择下一个匹配项

当你在Sources 标签下编辑文件时，如果你按下`Ctrl + D` (`Cmd + D`)，下一个匹配项也会被选中，这能够帮助你同时编辑他们。
![201907291601476790000](https://gitee.com/hjb2722404/tuchuang/raw/master/img/5566c57d584aa3796d5b85788d9d4f13.gif)

# 14.改变颜色格式

在颜色预览中使用`Shift + Click` ，可以在`rgba`, `hsl` 和 `hexadecimal` 这三种格式中改变。
![201907291553464450000](https://gitee.com/hjb2722404/tuchuang/raw/master/img/f1e8603dfa7c171017c42ed19a3137b4.gif)

# 15.通过工作区来编辑本地文件

Workspaces是Chrome DevTools的一个强大的的功能，这个功能使得Chrome成为一个真正的IDE。Workspaces使Sources标签下的文件和你本地的工程文件相匹配。所以现在你可以直接编辑和保存，而不用复制粘贴到外部的文本编辑器里。 配置Workspaces，你只需要去Sources标签下，在左边的控制面板的任何地方点击右键，并且选择**Add Folder To Worskpace**, 或者只是把你的整个工程文件夹拖放到DevTools。现在，无论你打开哪一页，被选择的文件夹的子目录和它包含的所有文件都将能被编辑。 为了使它更加的有用，你可以将页面中用到的文件映射到相应的文件夹，允许在线编辑和简单的保存。

更多关于Workspace的内容，请看[![](https://f.ydr.me/developer.chrome.com)这里](https://developer.chrome.com/devtools/docs/workspaces).

> 原文：> [![](https://f.ydr.me/tutorialzine.com)> 15 Must-Know Chrome DevTools Tips and Tricks](http://tutorialzine.com/2015/03/15-must-know-chrome-devtools-tips-tricks/)

# 拓展阅读

- [![](https://f.ydr.me/developer.chrome.com)Chrome Keyboard Shortcuts](https://developer.chrome.com/devtools/docs/shortcuts)
- [![](https://f.ydr.me/developer.chrome.com)A long list of tips and tricks in the Google Chrome docs](https://developer.chrome.com/devtools/docs/tips-and-tricks)
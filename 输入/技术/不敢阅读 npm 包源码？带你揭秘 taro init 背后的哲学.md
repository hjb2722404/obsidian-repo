**共9000余字，阅读需要10分钟左右。** 

写在最前
----

对于前端来说，`github` 就是宝藏。做任何事情，一定要专业，很多知识都是可以找到的，尤其在前端，有很多很好的东西就摆在你的面前。好的组件源代码，好的设计模式，好的测试方案，好的代码结构，你都可以触手可及，所以不要觉得不会， `coding just api` ，你需要掌握的是编程的思想和思维。

其实这次的文章也和 `ant design` 彩蛋有点关系。因为有人说，谁让你不去阅读 `npm` 包源码的，可能很多人觉得阅读 `npm` 包的源码是一件很困难的事情，但是我要告诉你们，`npm` 包对前端来说就是一座宝藏。你可以从 `npm` 包中看到很多东西的真相，你可以看到全世界的最优秀的 `npm` 包的编程思想。

比如你可以看到他们的代码结构，他们的依赖关系，他们的代码交互方式，以及他们的代码编写规范，等等等等。那么现在，我就通过目前最火的多端统一框架 `taro` 来向大家展示，如何去分析一个通过 `CLI` 生成的 `npm` 包的代码。一片文章做不到太细致的分析，我就当是抛砖引玉，告诉大家，不要被 `node_modules` 那一串串的包吓到了，不敢去看，怕看不懂。其实不是你们想的那样看不懂，一般有名的 `npm` 包，代码结构都是很友好的，理解起来并不比你去阅读你同事的代码(你懂的)难。而且在阅读 `npm` 包的过程中，你会发现很多惊喜，找到很多灵感。是不是很激动，是不是很开心，嗯，那就牵着我的手，跟着我一起走，我带你去解开 `npm` 包那神秘而又美丽的面纱。

taro init 发生了什么
---------------

执行 `taro init xxx` 后，`package.json` 的依赖如下图所示

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142545.webp)

你会发现当你初始化完一个 `CLI` 时，安装了很多依赖，然后这个时候如果你去看 `node_modules` ，一定会很难受，因为安装了很多很多依赖的包，这也是很多人点开 `node_modules` 目录后，立马就关上的原因，不关可能就卡住了😂。那么我们玩点轻松的，不搞这么多，我们进入裸奔模式，一个一个包下载，按照 `taro init` 的 `package.json` 的安装，我们来分析一下其中的包的代码。

分析 @tarojs/components
---------------------

对 `node_modules` 进行截图，图片如下：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142709)

从图片里面我们可以看到安装了很多依赖，其中和我们有着直接相关的包是 `@tarojs` ，打开 `@tarojs` 可以看到：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142717.webp)

其实你会发现没什么东西，我们再看一下 `src` 目录下有什么：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142722.webp)

### 分析 `src/index.js` 文件

`index.js` 文件代码如下：

```js
import 'weui'
export { default as View } from './view'
export { default as Block } from './block'
export { default as Image } from './image'
export { default as Text } from './text'
export { default as Switch } from './switch'
export { default as Button } from './button'

```

你会发现，这是一个集中 `export` 各种组件的地方，从这里的代码我们可以知道，为什么在 `taro` 里面要通过下面这种形式去引入组件。

```js
import { View, Text, Icon } from '@tarojs/components'
```

比如为什么要大写，这是因为上面 `export` 出去的就是大写，同时把所有组件放在了一个对象里面。这里再思考一下，为什么要大写呢？可能是因为避免和微信小程序的原生组件的命名冲突，毕竟 `taro` 是支持原生和 `taro` 混写的，如果都是小写，那怎么区分呢。当你看到这里的源码的时候，你对 `taro` 的组件引入需要大写这个规则是不是就觉得非常的顺其自然了。同时这里我们应该多去体会一下 `taro` 这样导出一个组件的思想。越是这种频繁但不起眼的操作，我们越应该去体会其优秀的思想。

下面我们来挑一个组件看一下结构，比如 `Button` 组件，结构如下：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142735.webp)

从上图我们可以看到一个 `taro` 的基础组件的代码结构，从这里我们可以获取到几点信息：

第一点：对每个组件进行了单元测试，使用的是 `Jest` ，目录是 `__test__`

第二点：每个组件都有 `index.md` ，用来介绍组件的文档

第三点： 样式单独用了目录 `style` 来存放，同时入口文件名字统一使用 `index`

第四点：在 `types` 目录里进行了 `index.d.ts` 的文件设置，使得代码提示更加友好

### 分析 @tarojs/components 后的总结

鉴于 `taro` 是一个正在崛起且非常有潜力的框架，我们是不是能从 `@tarojs/components` 的源码中学到一些思想。比如我们去设计一个我们自己的组件库时，是不是可以借鉴这种思想呢。其实这种组件的代码结构形式是目前很流行的，比如使用了今年最流行的框架 `Jest` 框架作为组件的单元测试，使用 `ts` 做代码提示。看 `github` 上的源码的话，会发现，使用了最新的 `lerna` 包发布工具，使用了轻量级的 `rollup` 打包工具，使用 `@xxx` 作为 `namespace` 。这也是我为什么选择 `taro` 框架来分析的原因，`taro` 于2018年 6月多才开源，所以一定借鉴了目前前端最新的技术和最佳实践，没有历史包袱。其实看 `taro` 的源码后，你会发现 `taro` 中的一些设计理念，已经优于其他著名框架了。

分析 @tarojs/taro
---------------

你会发现，这个还是安装在了 `@tarojs` 目录下，并没有增加其他依赖。`taro` 的目录结构如下图所示

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142747.webp)

从图中的代码结构我们大概可以知道：

第一： `types` 目录下有一个 `index.d.ts` ，这个文件是一个 `ts` 文件，他的作用是编写代码提示。这样在你写代码的时候，会给你非常友好的代码规范提示。比如 `index.d.ts` 里面有段代码(随便截取了一段)如下：

```ts
  interface PageConfig {
    navigationBarBackgroundColor?: string,
    backgroundTextStyle?: 'dark' | 'light',
    enablePullDownRefresh?: boolean,
    onReachBottomDistance?: number
    disableScroll?: boolean
  }

```

这段代码的目的是在你写对应的配置时，会提示你此字段的数据类型时什么，给你一个友好的提示。看到这里，其实我们想，我们自己也可以自定义的给自己的项目加上这种提示，这对项目是一种很好的优化。

第二：我们看到了 `dist` 目录，基本能推测出这是通过打包工具，打包出来的输出目录。

第三：整个目录很简单，那 `taro` 的作用是什么呢，其实 `taro` 是一个运行时。

我们来看一下 `package.json` ，如下图所示：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142759.webp)

发现有个字段，就是

```json
  "peerDependencies": {
    "nervjs": "^1.2.17"
  }
```

平常我们用到的最多的就是 `dependencies` 和 `devDependencies` 。那么 `peerDependencies` 表达什么意识呢？我们去谷歌翻译一下，如图所示：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142815.webp)

拆开翻译后，是 **对等依赖** ，结合翻译来说一下整个字段的作用，其实就是指：

这个依赖不需要在自己的目录下 `npm install` 了。只需在根目录下 `npm install` 就可以了。本着不造轮子的精神，具体意识请看下面 `blog`：

[探讨 npm 依赖管理之 peerDependencies](https://www.cnblogs.com/wonyun/p/9692476.html)

我们来看一下 `index.js` , 就两行代码:

```js
module.exports = require('./dist/index.js').default
module.exports.default = module.exports
```

不过我对于这种写法还是有点惊喜的。为什么要写成这样呢，不能一行搞定么，更加解耦？ 大概是为了什么吧。

**PS:** 写完此文章，我思考了这个问题，发现这个写法和下面介绍的的一个 `index.js` 中的写法如出一辙：

```js
export {}
export default {}
```

瞬间明白了作者这样写的目的。

### 分析 `taro/src`

如图所示：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142827.webp)

我们看一下 `env.js`

```js
export const ENV_TYPE = {
  WEAPP: 'WEAPP',
  WEB: 'WEB',
  RN: 'RN',
  SWAN: 'SWAN',
  ALIPAY: 'ALIPAY',
  TT: 'TT'
}

export function getEnv () {
  if (typeof wx !== 'undefined' && wx.getSystemInfo) {
    return ENV_TYPE.WEAPP
  }
  if (typeof swan !== 'undefined' && swan.getSystemInfo) {
    return ENV_TYPE.SWAN
  }
  if (typeof my !== 'undefined' && my.getSystemInfo) {
    return ENV_TYPE.ALIPAY
  }
  if (typeof tt !== 'undefined' && tt.getSystemInfo) {
    return ENV_TYPE.TT
  }
  if (typeof global !== 'undefined' && global.__fbGenNativeModule) {
    return ENV_TYPE.RN
  }
  if (typeof window !== 'undefined') {
    return ENV_TYPE.WEB
  }
  return 'Unknown environment'
}

```

从上面代码里面，我们可以看到，通过 `getEnv` 函数来拿到我们当前项目的运行时的环境，比如是 `weapp` 还是 `swan` 还是 `tt` 等等。其实这时我们就应该感觉到多端统一的思想，`genEnv` 做了一件很重要的事情：

使用 `taro` 框架编写代码后，如何转换成多端？其实就是在运行时根据环境切换到对应的编译环境，从而转换成指定端的代码。这个 `getEnv` 函数就可以形象说明这一转换过程。

下面我们继续看一下 `index.js` ， 代码如下：

```js
import Component from './component'
import { get as internal_safe_get } from './internal/safe-get'
import { set as internal_safe_set } from './internal/safe-set'
import { inlineStyle as internal_inline_style } from './internal/inline-style'
import { getOriginal as internal_get_original } from './internal/get-original'
import { getEnv, ENV_TYPE } from './env'
import Events from './events'
import render from './render'
import { noPromiseApis, onAndSyncApis, otherApis, initPxTransform } from './native-apis'
const eventCenter = new Events()
export {
  Component, Events, eventCenter, getEnv, ENV_TYPE, render, internal_safe_get, internal_safe_set, internal_inline_style, internal_get_original, noPromiseApis, onAndSyncApis,
  otherApis, initPxTransform
}

export default {
  Component, Events, eventCenter, getEnv, ENV_TYPE, render, internal_safe_get, internal_safe_set, internal_inline_style, internal_get_original, noPromiseApis, onAndSyncApis,
  otherApis, initPxTransform
}
```

可以看到，分别用 `export` 和 `export default` 导出了相同的模块集合。这样做的原因是什么呢，我个人认为是为了代码的健壮性。你可以通过一个上下文挂载所有导出，也可以通过解构去导入你想要的指定导出。看到这，我们是不是也可以在自己的项目中这样实践呢。

马不停蹄，我们来看一下两个比较重要但代码量很少的文件，一个是 `render.js` ，另一个是 `component.js` 。 代码如下：

`render.js` :

```js
export default function render () {}
```

`component.js` :

```js
class Component {
  constructor (props) {
    this.state = {}
    this.props = props || {}
  }
}
export default Component
```

代码量都很少，一个空的 `render` 函数，一个功能很少的 `Componet` 类，想想就知道是干啥的了。

### 分析 taro 全局消息机制 event.js

我们看一下`events.js`，伪代码(简写)如下：

```js
class Events {
  constructor() {
    
  }
  on() {}
  once() {}
  off() {}
  trigger() {}
}

export default Events
```

你会发现这个文件完成了`taro`的全局消息通知机制。它 有`on`, `once`, `off`, `trigger`方法，`events.js`里都有相应的完整代码实现。对应官方文档如下：

[Taro消息机制](https://nervjs.github.io/taro/docs/events.html)

想一想，你是不是发现`API`原来是这么来的，也不是那么的难理解了，也不用死记硬背了。

### 分析 `internal` 目录

下面我们继续分析，我们还要关注一下 `internal` 目录，这个目录有介绍，看 `internal` 目录下的 `README.md` 就可以知道：其是导出以 `internal_` 开头命名的函数，用户不需要关心也不会使用到的内部方法，在编译期会自动给每个使用 `taro-cli` 编译的文件加上其依赖并使用。例如：

```jsx
import { Component } from 'taro'
class C extends Component {
  render () {
    const { todo } = this.state
    return (
      <TodoItem
        id={todo[0].list[123].id}
      />
    )
  }
}
```

会被编译成：

```jsx
import { Component, internal_safe_get } from 'taro'
class C extends Component {
  $props = {
    TodoItem() {
      return {
        $name: "TodoItem",
        id: internal_safe_get(this.state, "todo[0].list[123].id"),
      }
    }
  }
  ...
}
```

在编译期会自动给每个使用 `taro-cli` 编译的文件加上其依赖并使用。这句话是什么意识呢？可能是 `taro-cli` 在编译的时候，需要通过这种方式对文件进行相应的处理。目前我暂时这样理解，暂时理解不了很正常，继续往下面分析。

### 分析 `tarojs/taro` 的总结

`tarojs/taro` 已经分析的差不多了，从分析中，我们较为整体的知道了，一个运行时在宏观上是如何去衔接多端的，如何通过 `ts` 文件给代码添加友好提示。既然有 `internal` ，那就意味着不是 `internal` 目录下的文件都可以对外提供方法，比如 `events.js` ，这也可以给我们启发。如何去界定对内对外的代码，如何去分割。

分析几个有意识的函数文件
------------

先安装一下依赖：

```bash
yarn add @tarojs/taro-weapp && nervjs && nerv-devtools -S
```

然后我们看一下最新的包结构

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142844.webp)

对应的`package.json`如下：

```json
{
  "dependencies": {
    "@tarojs/components": "^1.2.1",
    "@tarojs/router": "^1.2.2",
    "@tarojs/taro": "^1.2.1",
    "@tarojs/taro-weapp": "^1.2.2",
    "nerv-devtools": "^1.3.9",
    "nervjs": "^1.3.9"
  }
}
```

也就是我们安装这些依赖后，`node_modules` 下目录下多了这么多东西。我们简单的看一下间接有关的包，挑几个说

### 分析 `omit.js`

我们看一下：`omit.js`

```js
import _extends from "babel-runtime/helpers/extends";
function omit(obj, fields) {
  var shallowCopy = _extends({}, obj);
  for (var i = 0; i < fields.length; i++) {
    var key = fields[i];
    delete shallowCopy[key];
  }
  return shallowCopy;
}

export default omit;
```

从 `omit.js` 的 `readme.md` 中我们可以知道，它是生成一个去掉指定字段的，并且是浅拷贝的对象。

### 分析 `slash.js`

代码如下：

```js
'use strict';
module.exports = input => {
	const isExtendedLengthPath = /^\\\\\?\\/.test(input);
	const hasNonAscii = /[^\u0000-\u0080]+/.test(input);
	if (isExtendedLengthPath || hasNonAscii) {
		return input;
	}
	return input.replace(/\\/g, '/');
};
```

从 `slash` 的 `readme.md` 中我们可以知道

> This was created since the `path` methods in Node outputs `\\` paths on Windows.

具体意识，自行分析吧，不难。

### 分析 `value-equal.js`

`value-equal`的主要内容如下：

```js
var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

function valueEqual(a, b) {
  if (a === b) return true;
  if (a == null || b == null) return false;
  if (Array.isArray(a)) {
    return Array.isArray(b) && a.length === b.length && a.every(function (item, index) {
      return valueEqual(item, b[index]);
    });
  }
  var aType = typeof a === 'undefined' ? 'undefined' : _typeof(a);
  var bType = typeof b === 'undefined' ? 'undefined' : _typeof(b);
  if (aType !== bType) return false;
  if (aType === 'object') {
    var aValue = a.valueOf();
    var bValue = b.valueOf();
    if (aValue !== a || bValue !== b) return valueEqual(aValue, bValue);
    var aKeys = Object.keys(a);
    var bKeys = Object.keys(b);
    if (aKeys.length !== bKeys.length) return false;
    return aKeys.every(function (key) {
      return valueEqual(a[key], b[key]);
    });
  }
  return false;
}
export default valueEqual;
```

从 `value-equal` 的 `readme.md` 中我们可以知道，这个方法是：只比较每个对象的 `key` 对应的 `value` 值。仔细感受一下代码这样写的思想。

### 分析 `prop-types.js`

我们看一下 `prop-types` ，这里就不列源码了。看 `README.md` ，我们知道

> Runtime type checking for React props and similar objects.

它是 `react` 框架中的 `props` 类型检查的辅助工具，也就是完成了下面这个功能

```js
XxxComponent.propTypes = {
  xxProps: PropTypes.xxx
}
```

### 分析 js-tokens

我们来看一下 `js-tokens` ，代码如下：

```js
Object.defineProperty(exports, "__esModule", {
  value: true
})
exports.default = /((['"])(?:(?!\2|\\).|\\(?:\r\n|[\s\S]))*(\2)?|`(?:[^`\\$]|\\[\s\S]|\$(?!\{)|\$\{(?:[^{}]|\{[^}]*\}?)*\}?)*(`)?)|(\/\/.*)|(\/\*(?:[^*]|\*(?!\/))*(\*\/)?)|(\/(?!\*)(?:\[(?:(?![\]\\]).|\\.)*\]|(?![\/\]\\]).|\\.)+\/(?:(?!\s*(?:\b|[\u0080-\uFFFF$\\'"~({]|[+\-!](?!=)|\.?\d))|[gmiyus]{1,6}\b(?![\u0080-\uFFFF$\\]|\s*(?:[+\-*%&|^<>!=?({]|\/(?![\/*])))))|(0[xX][\da-fA-F]+|0[oO][0-7]+|0[bB][01]+|(?:\d*\.\d+|\d+\.?)(?:[eE][+-]?\d+)?)|((?!\d)(?:(?!\s)[$\w\u0080-\uFFFF]|\\u[\da-fA-F]{4}|\\u\{[\da-fA-F]+\})+)|(--|\+\+|&&|\|\||=>|\.{3}|(?:[+\-\/%&|^]|\*{1,2}|<{1,2}|>{1,3}|!=?|={1,2})=?|[?~.,:;[\](){}])|(\s+)|(^$|[\s\S])/g
```

结合 `README.md` ，我们会发现，它使用正则来将 `JS` 语法变成一个个的 `token` , **so cool** 。

`example` 如下：

```js
var jsTokens = require("js-tokens").default
var jsString = "var foo=opts.foo;\n..."
jsString.match(jsTokens)

```

让你写能写出来这种逆天正则吗😂。

### 各种小函数的总结

是不是感觉这些函数文件都挺有意识的，如果想看具体怎么实现的，可以继续看看源码，你会发现很多东西都是有具体实现的，完全不需要去死记硬背。我们再看一下上面介绍的 `js-token`, `value-equal`, `prop-types` `omit`, `slash` 等，其实都是很好的函数，它们可以给我们很多编程上的灵感，我们完全可以借鉴这些函数的思想和实现方式，从而更好的提高我们的 `JS` 编程能力，这也是在阅读 `npm` 包源码过程中的一个很重要的收获。

分析 @tarojs/taro-weapp
---------------------

这个包是用来把 `taro` 编写的代码编译成微信小程序代码的，代码结构如图所示：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142904.webp)

首先从 `readme.md` 中，我们看不到此包究竟是干什么的，只能看到一句话，多端解决方案小程序端基础框架。所以我觉得这点，`taro` 团队还是要对其进行相应补充的。这里的 `readme.md` 写的太简洁了。

但是我们可以通过阅读代码来分析一下 `taro-weapp` 是干什么的，首先我们看一下代码结构。有 `dist` ， `src` 等，还有 `node_modules` 。这时候我们联想到上面介绍的包后，我们发出了这样的疑问，为什么这里有了 `node_modules` 目录。它的目的是什么？不能用上面的 `peerDependencies` 解决吗？对此，暂时无法理解这个事情，遇到这种问题该怎么办呢？这时我们可以先不去深入思考这个问题，做到不要阻塞，继续去分析其他代码。

我们按照惯例先看 `readme.md` ，但是 `readme.md` 的信息就一句话，多端解决方案小程序端基础框架。那怎么办，不要气馁！八年抗战，我们继续分析下去。

我们看一下 `package.json` ，部分代码如下：

```json
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "build": "rollup -c rollup.config.js",
    "watch": "rollup -c rollup.config.js -w"
  },
  "dependencies": {
    "@tarojs/taro": "1.2.2",
    "@tarojs/utils": "1.2.2",
    "lodash": "^4.17.10",
    "prop-types": "^15.6.1"
  }
```

从 `package.json` 中我们能发现两个主要的事情，第一个是此包需要的依赖，可以看到依赖 `@tarojs/taro`, `@tarojs/utils`, `lodash`, `prop-types` 。 然后我们查看 `node_modules` ，发现只有 `@tarojs/taro` 。其他的都是在外面安装好了，比如 `lodash`, `prop-types` 可以用根目录下的包，这里的 `@tarojs/utils` 是新安装的。在 `taro` 目录下。掌握这些信息，我们再结合上面的了解，再去思考几个问题:

1.  为什么没有用 `peerDependencies`
2.  为什么把 `@tarojs/taro` 安装到了 `taro-weapp` 包的内部。
3.  为什么 `taro-weapp` 没有 `types/index.d.ts` 这种文件

问题 `mark` 一下，先把问题抛出来，后续再做深入思考。记住一个事情，我们完全没必要在阅读源码的时候一定要达到完全理解的程度，不现实也没必要。我们需要做的就是抛出问题，然后继续分析，现在我们阅读一下 `index.js` ，代码如下：

```js
module.exports = require('./dist/index.js').default
module.exports.default = module.exports
```

很明显 `dist` 目录是经过打包生成的目录，现在我们来分析 `src` 目录，`src` 中的 `index` 文件代码如下：

```js

import {
  getEnv, Events, eventCenter, ENV_TYPE, render,
  internal_safe_get, internal_safe_set,
  internal_inline_style, internal_get_original
} from '@tarojs/taro'

import Component from './component'
import PureComponent from './pure-component'
import createApp from './create-app'
import createComponent from './create-component'
import initNativeApi from './native-api'
import { getElementById } from './util'

export const Taro = {
  Component, PureComponent, createApp, initNativeApi,
  Events, eventCenter, getEnv, render, ENV_TYPE,
  internal_safe_get, internal_safe_set,
  internal_inline_style, createComponent,
  internal_get_original, getElementById
}
export default Taro
initNativeApi(Taro)
```

从 `index.js` 中，我们可以看到，导入了 `@tarojs/taro` 的一些方法。而文章前面已经分析过了 `@tarojs/taro` 。现在我们结合起来想一下，可以发现：使用 `@tarojs/taro-weapp` 将用 `taro` 编写的代码，编译成微信小程序的时候，是需要借助 `@tarojs/taro` 包来一起实现转换的。

大致知道了 `taro-weapp` 的作用。现在我们来分析一下 `index.js` 中依赖的外部文件，分析如下：

### 分析 src/components.js

把代码缩进去，我们看一下大致的代码，如图所示：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142916.webp)

从图中可以看出，导出了 `BaseComponent` 类，从命名可以知道，这是一个基础组件类，由于代码不是太多，我直接贴上来吧。

```js
import { enqueueRender } from './render-queue'
import { updateComponent } from './lifecycle'
import { isFunction } from './util'
import {
  internal_safe_get as safeGet
} from '@tarojs/taro'
import { cacheDataSet, cacheDataGet } from './data-cache'
const PRELOAD_DATA_KEY = 'preload'
class BaseComponent {
  
  __computed = {}
  
  __props = {}
  __isReady = false
  
  __mounted = false
  
  $componentType = ''
  $router = {
    params: {},
    path: ''
  }
  constructor (props = {}, isPage) {
    this.state = {}
    this.props = props
    this.$componentType = isPage ? 'PAGE' : 'COMPONENT'
  }
  _constructor (props) {
    this.props = props || {}
  }
  _init (scope) {
    this.$scope = scope
  }
  setState (state, callback) {
    enqueueRender(this)
  }
  getState () {
    const { _pendingStates, state, props } = this
    const queue = _pendingStates.concat()
    queue.forEach((nextState) => {
      if (isFunction(nextState)) nextState = nextState.call(this, stateClone, props)
      Object.assign(stateClone, nextState)
    })
    return stateClone
  }
  forceUpdate (callback) {
    updateComponent(this)
  }
  $preload (key, value) { 
  
  __triggerPropsFn (key, args) {}
}
export default BaseComponent
```

我们看一下上面的代码，从命名我们知道，这是一个组件的基类，可以理解为所有组件都要继承 `BaseComponent` 。我们来分析一下上面的代码，首先分析第一个点，为什么有那么多下划线变量？其实这些变量是给自己用的，我们看下面的代码：

```js
class BaseComponent {
  
  __computed = {}
  
  __props = {}
  __isReady = false
  
  __mounted = false
  
  $componentType = ''
  $router = { params: {}, path: ''}
}
```

首先我记得 `ES6` 是不支持直接在类中写变量的，这应该是通过 `babel` 去支持这样写的。通过代码中的注释，基本就知道了这个变量的作用，比如可以通过 `data.__props` 访问到 `__props` 。也就是 `this.props` 的值，这里也是用到了代理模式。就像 `vue` 中的访问方式。OK，这个我们了解了，那么我们继续来看下面这段代码：

```js
class BaseComponent {
  constructor (props = {}, isPage) {
    this.state = {}
    this.props = props
    this.$componentType = isPage ? 'PAGE' : 'COMPONENT'
  }
  _constructor (props) {
    this.props = props || {}
  }
}
```

你看，我们发现了什么，“构造函数” 有两个，哈哈哈，骗你的，构造函数就一个，就是 `constructor` 。但是下面的 `_constructor` 函数是什么鬼，里面还进行了 `this.props = props || {}` 操作，是什么鬼呢，如果你看了 `taro` 官方文档，你可能会看到这样的提示：

> 就算你不写 `this.props = props` ，也没事，因为 `taro` 在运行的过程中，需要用到 `props` 做一些事情。

但是你可能不明白是为什么，总感觉文字说明没有代码来的实在，所以当你看到上面的代码时，是不是就感觉到实在的感觉了，因为看到代码了。 其实是 `taro` 使用自己内部的方法 `_constructor` 来进行了 `this.props = props || {}` 操作。所以文档中会提示说：不写 `props` 也可以。

其他的比如 `setState`，`getState` 等自己分析一下吧，路子都是一样的。反正只要你分析了，基本就能对其有一个更加深刻的理解。可能这一刻你把官网文档上的东西忘记了，但你不会忘记代码里这一行的意义。

### 分析 src/native-api.js

这个文件的代码很重要，为什么叫 `native-api` 。如果你看了官方文档的话，你会看到这个页面：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142931.webp)

其实这里的 `native-api.js` 就是上图的介绍，可以理解为 `Taro` 对微信小程序的原生 `api` 进行的封装。

下面我们来看一下 `native-api.js` 的输出是什么，代码如下

```js
export default function initNativeApi (taro) {
  processApis(taro)
  taro.request = request
  taro.getCurrentPages = getCurrentPages
  taro.getApp = getApp
  taro.requirePlugin = requirePlugin
  taro.initPxTransform = initPxTransform.bind(taro)
  taro.pxTransform = pxTransform.bind(taro)
  taro.canIUseWebp = canIUseWebp
}
```

这里到导出了一个 `initNativeApi` 方法。看到上面代码，是不是知道整个入口的大概画面了。这个导出的方法在入口中执行，来对 `taro` 进行了补充。我们先从 `taro-weapp` 的入口文件中, 看一下在没有执行 `initNativeApi(Taro)` 的 `Taro` 对象是什么，代码如下：

```js
const Taro = {
  Component, PureComponent, createApp, initNativeApi, Events,
  eventCenter, getEnv, render, ENV_TYPE, internal_safe_get,
  internal_safe_set, internal_inline_style,
  createComponent, internal_get_original, getElementById
}
```

从上面代码可以知道，`Taro` 就好比是 `koa` 中的 `ctx` ，通过绑定上下文的形式挂载了很多方法。但是这里，做了一个优化，就是通过 `initNativeApi(Taro)` 方法来给 `Taro` 挂载更多的方法。我们看一下在执行 `initNativeApi(Taro)` 后的 `Taro` 对象是什么，代码如下：

```js
const Taro = {
  
  request,
  getCurrentPages,
  getApp,
  requirePlugin,
  initPxTransform,
  pxTransform,
  canIUseWebp,
}
```

`processApis(taro)` 这个先不说。

我们看上面的代码，发现多了很多方法，我们可以理解为通过执行 `initNativeApi(Taro)` ，使得 `Taro` 挂载了微信小程序本地的一些 `API` 。可是你会发现有些又不是本地 `API` ，但是可以先这样理解吧，比如 `request`, `getCurrentPages`, `getApp` 。我个人理解作者这样做的原因是为了解耦，将 `native` 和非 `native` 的方法分开。

### 分析 src/pure-component.js

```js
import { shallowEqual } from '@tarojs/utils'
import Component from './component'
class PureComponent extends Component {
  isPureComponent = true
  shouldComponentUpdate (nextProps, nextState) {
    return !shallowEqual(this.props, nextProps) || !shallowEqual(this.state, nextState)
  }
}
export default PureComponent
```

我们看一下 `pure-componnet.js` 的代码。是不是发现非常好理解了，`PureComponent` 类继承了 `Component` 。同时，自己实现了一个 `shouldComponentUpdate` 方法。而这个方法代码如下所示：

```js
shouldComponentUpdate (nextProps, nextState) {
    return !shallowEqual(this.props, nextProps) || !shallowEqual(this.state, nextState)
}
```

你会发现其入参是 `nextProps , nextState` 。然后通过 `shallowEqual` 方法和 `props`, `state` 进行比较，而 `shallowEqual` 听名字就知道是浅比较。 具体代码在 `@taro/util` 目录下的 `src` 目录下的 `shallow-equal.js` 中，代码如下：

```js
Object.is = Object.is || function (x, y) {
  if (x === y) return x !== 0 || 1 / x === 1 / y
  return x !== x && y !== y
}

export default function shallowEqual (obj1, obj2) {
  if (obj1 === null && obj2 === null) return true
  if (obj1 === null || obj2 === null) return false
  if (Object.is(obj1, obj2)) return true
  const obj1Keys = obj1 ? Object.keys(obj1) : []
  const obj2Keys = obj2 ? Object.keys(obj2) : []
  if (obj1Keys.length !== obj2Keys.length) return false

  for (let i = 0; i < obj1Keys.length; i++) {
    const obj1KeyItem = obj1Keys[i]
    if (!obj2.hasOwnProperty(obj1KeyItem) || !Object.is(obj1[obj1KeyItem], obj2[obj1KeyItem])) {
      return false
    }
  }
  return true
}
```

看看代码，发现是浅比较。看到这，你是不是感觉到 `PureComponent` 也没有想象中的抽象难懂，类推一下， `React` 中的 `PureComponent` 也是这个理。所以不必去死记硬背一些框架的生命周期和各种专业名字什么的。其实当你在揭去它的面纱，看到它的真相的时候，你会发现，框架并没有多深奥。但是如果你就是没有勇气去揭开它的面纱，去面对它的话，那么你就会一直处于想象之中，对真相一无所知。

### 分析 src/create-componnet.js

我们找一段看一下

```js
  const weappComponentConf = {
    data: initData,
    created (options = {}) {
      this.$component = cacheDataGet(preloadInitedComponent, true)
      this.$component = new ComponentClass({}, isPage)
      this.$component._init(this)
      this.$component.render = this.$component._createData
      this.$component.__propTypes = ComponentClass.propTypes
      Object.assign(this.$component.$router.params, options)
    },
    attached () {},
    ready () {
      componentTrigger(this.$component, 'componentDidMount')
    },
    detached () {
      componentTrigger(this.$component, 'componentWillUnmount')
    }
  }
```

从上面代码我们可以看出，这是将用 `taro` 编写的组件，编译成微信小程序程序里面的原生组件实例的。这里关注一个点，就是 `attached` 方法中用到了 `cacheDataGet` 和 `cacheDataHas` ，上面有介绍这两个方法，为什么要在这里用，目的是什么，背后的意义是什么？ 需要结合微信小程序的组件生命周期的含义，来思考分析一下。同时，我们要去思考组件中这句 `this.$component.render = this.$component._createData` 代码的含义，好好理解 `created` 究竟发生了哪些过程。

### 分析 src/create-app.js

```js
function createApp (AppClass) {
  const app = new AppClass()
  const weappAppConf = {
    onLaunch (options) {
      app.$app = this
      app.$app.$router = app.$router = {
        params: options
      }
      if (app.componentWillMount) app.componentWillMount()
      if (app.componentDidMount) app.componentDidMount()
    },
    onShow (options) {},
    onHide () {},
    onError (err) {},
  }
  return Object.assign(weappAppConf, app)
}
export default createApp
```

上面这个一看就知道是用来生成微信小程序的小程序级别的配置，来看一下上面的 `if` 语句，你可以感受到其背后的目的了。再看一下 `Object.assign(weappAppConf, app)` 你就知道， `taro` 是如何遵循 `react` 的数据不可变的编程思想了。

### 分析 src/next-tick.js

```js
const nextTick = (fn, ...args) => {
  fn = typeof fn === 'function' ? fn.bind(null, ...args) : fn
  const timerFunc = wx.nextTick ? wx.nextTick : setTimeout
  timerFunc(fn)
}
export default nextTick
```

这个代码也好理解，通过将代码放在 `wx.nextTick` 或者 `setTimeout` 来达到在下一个循环阶段再执行。

### 分析src/render-queue.js

```js
import nextTick from './next-tick'
import { updateComponent } from './lifecycle'
let items = []
export function enqueueRender (component) {
  if (!component._dirty && (component._dirty = true) && items.push(component) === 1) {
    nextTick(rerender)
  }
}
export function rerender () {
  let p
  const list = items
  items = []
  while ((p = list.pop())) {
    if (p._dirty) {
      updateComponent(p, true)
    }
  }
}
```

通过命名就知道用到了 `nextTick` 渲染的思想。

### 分析 src/lifecycle.js

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142945.webp)

我们把函数缩起来，发现只导出了 `updateComponent` 方法，从命名中，我们知道这是更新组件的意识。

### 分析 src/data-cache.js

```js
const data = {}
export function cacheDataSet (key, val) {
  data[key] = val
}
export function cacheDataGet (key, delelteAfterGet) {
  const temp = data[key]
  delelteAfterGet && delete data[key]
  return temp
}
export function cacheDataHas (key) {
  return key in data
}
```

从代码我们可以知道，这是做数据缓存用的。先缓存起来，然后每取一次 `value` ，就把这个 `value` 删掉。那么为什么要这样设计呢，背后的原因或者说这样设计的优势是什么？可以后续去细致思考一下，这也是一个好的编程思想。

### 分析 `@tarojs/taro-weapp` 后的总结

通过对 `@tarojs/taro-weapp` 的分析，我们具体知道了：当在运行时，`taro` 是通过 `getEnv` 将代码切到 `taro-weapp` 环境来进行编译的。 随后我们分析了，`taro-weapp` 是如何进行编译处理的，比如如何去解决多端涉及到的`API`不同的问题。通过分析，我们已经较为深入的理解了 `taro` 的整个架构思想和部分内部实现。这些思想值得我们在平时的项目中去实践它。其实看源码的目的是什么，比如我分析 `taro init` 分析到现在，如果你看完，你会发现有很多很酷的思想，可能在你的世界中，写了几个项目都根本想不起来也可以这样用，看源码的目的就是让你去接触世界上优秀的开源项目是如何设计出来的。从而吸收这些思想，为我所用，使我成长。

分析 `rollup-plugin-alias`
------------------------

从 `readme.md` 中，我们可以发现，它做了一件事，就是把包的引入路径抽象化了，这样好处很多，可以不用关心 `../` 这种符号了，而且可以做到集中式修改。我们的启发是什么，其实我们可以从 `rollup-plugin-alias` 中学到如何去管理我们自己的 `npm` 包。这种思想我们要吸收。

分析 `resolve-pathname`
---------------------

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142953.webp)

它做了什么事情呢？结合源码，从 `readme.md` 中，我们可以发现，其实它做了这么一件事，就是提供一个方法，让我们去处理 `URL` ，或者说是路由，通过这个方法，我们能对给定的路由做一些处理，比如返回一个新的路由。

> 关于`invariant、warning`都是一些处理提示的辅助工具，就不说了，自行阅读源码进行分析。

分析 @tarojs/router
-----------------

代码目录结构截图如下：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113142959.webp)

我们会看到在 `router` 目录下，有 `dist` 和 `types` 目录。但是没有 `src` 目录，但是为什么有的包有 `src` 呢，有的没有呢？这是个问题，有待后续细致分析。

如何发现更加有趣的东西
-----------

如何在 `node_modules` 发现更加有趣的东西。我举个例子，比如我们来看一个 `bind` 在不同的包中的实现方式： 下图是 `core-js` 中 `modules` 目录下的的 `bind` 实现

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210113143027.webp)

代码如下：

```js
var aFunction = require('./_a-function');
var isObject = require('./_is-object');
var invoke = require('./_invoke');
var arraySlice = [].slice;
var factories = {};

var construct = function (F, len, args) {
  if (!(len in factories)) {
    for (var n = [], i = 0; i < len; i++) n[i] = 'a[' + i + ']';
    factories[len] = Function('F,a', 'return new F(' + n.join(',') + ')');
  } return factories[len](F, args);
};

module.exports = Function.bind || function bind(that /* , ...args */) {
  var fn = aFunction(this);
  var partArgs = arraySlice.call(arguments, 1);
  var bound = function (/* args... */) {
    var args = partArgs.concat(arraySlice.call(arguments));
    return this instanceof bound ? construct(fn, args.length, args) : invoke(fn, args, that);
  };
  if (isObject(fn.prototype)) bound.prototype = fn.prototype;
  return bound;
};
```

下面我们再看一下 `lodash` 中的 `bind` 实现，代码如下：

```js
var baseRest = require('./_baseRest'),
    createWrap = require('./_createWrap'),
    getHolder = require('./_getHolder'),
    replaceHolders = require('./_replaceHolders');
    
var WRAP_BIND_FLAG = 1,
    WRAP_PARTIAL_FLAG = 32;

var bind = baseRest(function(func, thisArg, partials) {
  var bitmask = WRAP_BIND_FLAG;
  if (partials.length) {
    var holders = replaceHolders(partials, getHolder(bind));
    bitmask |= WRAP_PARTIAL_FLAG;
  }
  return createWrap(func, bitmask, thisArg, partials, holders);
});
bind.placeholder = {};
module.exports = bind;
```

对比两者的代码，我们能发现两者的代码的实现形式是不一样的。可能大家能普遍理解的是第一种写法，几乎所有文章都是第一种写法，容易看懂。但是第二种写法就比较难理解了，相比第一种写法，第二种写法更加抽象和解耦。比如更加函数式，其实如果函数式编程掌握的熟练的话， `bind` 本质上就是偏函数的一种实现，第二种写法里面已经在命名中就体现出来了，**partials**。比如在面试中，如果被问到 `bind` 如何实现，是不是就可以写出两种实现方式了(编程思想)呢。可能你写完，面试官都看不懂呢😂。这里就是举个例子，还有很多这种，自行探索吧。(顺带把 `core-js` 和 `lodash` 包介绍了。。)

对 ant design 彩蛋事件的理解
--------------------

最近 `ant design` 彩蛋事件，这个彩蛋足够刺激，以至于大家反应这么强烈。足以说明 `ant design` 的受欢迎程度，按照土话说，`ant design` 以前的身份是：大家只爱不恨，但是现在的身份是：大家又爱又恨。

**出了问题，该怎么解决，就怎么解决，但是逼还是要撕的，谁的锅谁背好。** 

故事是这样的：

> 比如平常在公司工作，同事或者其他人闯祸了，把你的代码 `reset` 掉了。这肯定波及到你的工作了，这个时候你会怎么做？你肯定不爽，肯定会 BB 。尤其遇到那种闯了祸，影响到了别人工作的还不主动背锅道歉，摆出一副你把代码找回来不就行了么的态度。遇到这种人你肯定就很不爽，要找这个人撕逼。毕竟你已经影响到我工作了，别一副好像锅不是自己的一样，锅你背好，我会解决掉你给我带来的问题，下次别再这样了。

而 `ant design` ，就好比上面闯祸的同事，波及到了大家，但是 `ant` 也主动认错了，锅也主动背了，也立刻给出了方案。

其实对于那些因为这个事情导致失业什么的，我个人认为还是比较难受的。但是对于那些说话比较激烈(难听)的人，也就是嘴上难听，有几个会因为前端框架而上升到很大的那种怨恨的，难听的目的无非就是隐式的鞭策 `ant` 团队。我想 `ant` 也意识到了，后面肯定不会再这样做类似这种事情了。

**我内心还是希望大家：** 

既然我们从一开始就选择了相信 `ant design` ，那我们就多一份包容，包容这一次 `ant design` 的犯错，不要因为一次犯错，就否定其全部。

其实你在公司里，也是这样的，你犯了错，影响到了很多同事，你意识到事情的严重性，你很难受，很后悔，你发现自己做了一件极其愚蠢的事情，你真的很想去弥补，但是时间不能倒退，岁月不能回流，你能做的就是保证下次不会再次犯错，你很想得到大家的原谅和信任。虽然你是真心认错的，希望大家可以像原来一样信任你，可是如果大家因为你一次错误，就在举止谈吐之间表现的不那么相信你了。那，此时你的心，也一定是极其的失落和灰冷吧。

所以我还是希望大家能继续对 `ant design` 保持信任，包容 `ant design` 一次，也是包容一次 **偏右** 这种为开源做出很大贡献的人。

其实，在生活中，有时候，我们会发现，包容不需要很多次的，一次包容就可以了。因为一次包容就可以让一件事情再也不会发生第二次。是不，啰啰嗦嗦了那么多，其实答案就在文字中。

好了，不胡诌个人看法了。

备注
--

### 关于文章有点长

因为文章确实有点长，所以我对我贴的代码动了些手脚，比如，删减了一些代码，写成三行的 `if` 语句，写成一行。把 `import`, `export` 的东西尽可能写在一起，不换行写。所以如果想看没有删减版本的文章，可以去我的 `github` 上看，`github` 连接：https://github.com/godkun/blog/issues/30

### 阅读 npm 包遇到不懂的地方怎么办

对于 `npm` 包的源码，我本人在看的时候，也会对一些地方不明白，这对于我们来说很正常( `NB` 的大佬除外)，但是我不会因为某一段，某一个文件看不懂而阻塞我对于整个包的理解，我会加入我自己的理解，哪怕是错的，但是只要我能流畅的把整个包按照我想的那样理解掉就足够了。不要试图去完全理解，除非你和 `npm` 包的作者进行交流了。

你会发现这篇文章中，在分析的过程中，已经存在了一些问题，而且我也没有一个确切的答案，就好像那些上传 `LOL` 教学的视频，只要是上传的，都是各种经典走位，预判，风骚操作。但是现实中，可能已经跪了10几把了。说到这，突然想到知乎上，有个帖子，好像是问程序平常写代码是什么场景，还贴出一个黑客帝国的图片，问真的是这样的吗？然后有个用视频回答的，我看完快笑喷了。其实推导一下，就知道看 `npm` 包源码的时候，是不可能一帆风顺的。一定有看不懂的，而且 `npm` 包的源码和 `github` 上对应 `npm` 包的源码是不一样的。`npm` 包就好比是 `github` 上的 `npm` 源码经过包管理工具，`build` 后的输出。这点你从有 `dist` 目录就可以看出来，比如 `github` 中 `taro` 源码中是用 `rollup` 打成小包的。

**遇到不懂的地方很正常，你要做的就是理解整体，忽略局部。** 

文末心得总结
------

读到这，你会发现，我没有把 `taro init` 下载的全部依赖都分析一遍，因为真分析完的话，可能短篇小说就诞生了，而且也没有什么意义。我就是起个抛砖引玉的作用，希望大家阅读我的文章后，有一些收获，不要去害怕 `npm` 包，`npm` 包也是人写的。

在分析的时候，我建议一个一个包下载，然后下载一个包看一下目录。这样有助于你去理解，很多人都是一个 `npm i` 或者 `yarn install` 甩下来，然后打开 `node_modules` 目录，然后就傻眼了，根本不知道找哪个包看。所以，当你想去了解一个东西的时候，最好的方式是一个包一个包去下载，一点一点去看，看前后的代码结构变化，包的变化。然后你会发现包的个数在慢慢的增加，但是你一点也不慌，因为你已经知道他们大概的作用和内容了。

最后按照小学语文老师教我的操作，搞个首尾呼应吧。

前端是 `github` 上最受益的一个行业，因为最先进的开源技术，源代码都在 `github` 上， `github` 就是前端的宝藏，取之不尽，用之不完。`react`、`vue`、`angular`、`webpack`、`babel`、`node`、`rxjs`、`three.js`、`TypeScript`、`taro`、`ant-design`、`egg`、`jest`、`koa`、`lodash`、`parcel`、`rollup`、`d3`、`redux`、`flutter`、`cax`、`lerna`、`hapi`、`jsx`、`eslint` 等等等等等，宝藏就在那，你愿意去解开它们的面纱看一看真相吗？

参考链接
----

*   [taro官方文档](https://nervjs.github.io/taro/)

激萌一刻
----

掘金系列文章都可以在我的 `github` 上找到，欢迎讨论，传送地址：

https://github.com/godkun/blog

觉得不错的，可以点个 **star** 和 赞赞，鼓励鼓励。

第一次暴露我的最神秘交友网站账号（潜水逃）

幕后花絮
----

2018年快过去了，祝福大家在2019年，家庭幸福，事业有成，在前端行业，游刃有余。

本文里面大概率会有写错的地方，但是大概率也会有很不错的地方。

所以............

元旦快乐丫！
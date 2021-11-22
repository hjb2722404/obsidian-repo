# Vue项目加载性能优化记录

## 性能分析

### 1. 网络请求

`chrome`默认同一个域并发连接是6个，该域下所有请求共享这6个连接，当6个请求占满6个连接后，其余的请求就处于排队时间。等待6个请求中有请求返回了，排队中的请求才会发出。

请求越多，用来排队的时间就越长，前面的请求如果因为网络原因返回满了，就会导致后面的请求一直在排队浪费时间。

网络请求分析方法：`chrome`开发者工具网络面板，查看瀑布流。鼠标`hover`到每个请求的瀑布流上会显示该请求的入队时间，排队时间，发出请求的时间，响应时间，资源下载时间等详细信息。

![image-20210813155348225](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210813155348.png)



### 2. 资源体积

如上所述，个别请求如果耗时太长，会导致后面的请求花更多时间排队，导致性能下降，典型地就是静态资源，比如`.js`，`.css`和图片等资源。如果它们的体积太大，下载时就会导致其它资源排队时间过长，所以要尽量缩减资源体积。


### 3. 使用Lighthouse进行性能分析

![image-20210918180910511](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202109181809825.png)

在开发者工具中找到`Lighthose` 面板，点击生成报告

工具会自动重新加载页面，并分析页面加载的各项性能指标。

![image-20210918181335346](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202109181813500.png)

![image-20210918181357855](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202109181813019.png)



不仅如此，它会告诉你性能差的具体原因（具体的文件），并给出相应的优化建议：

![image-20210918181523063](https://gitee.com/hjb2722404/tuchuang/raw/master/img/202109181815238.png)



## 优化方法

> 当然，你可能在一些文章中看到过一些诸如将脚本文件放置到body之后，或者预加载，预拉取、图片合并等方法，事实上，随着现代前端工程化的发展，很多这种古老的优化方法都已经内置到了打包工具中，不需要我们再去手动处理了（我们可以在开发模式下在浏览器打开项目主页，查看源代码，你就可以看到很多这样的优化），所以本文不会介绍那些方法。

### 1. 减少网络请求

除了首页必须的权限、首页数据等在首页加载时发送请求，其它请求都等页面加载完成后再去请求，比如表格的筛选条件选项等。

#### 1.1 减少资源请求

#####  1.1.1 路由懒加载，并分组

* 优化前

```js
// /router/index.js

import A from 'xxx/A.vue'
import A1 from 'xxx/A1.vue'
import B from 'xxx/B.vue'
import B1 from 'xxx/B1.vue'

……

{ 
    path: 'a',
    component: A
}

{ 
    path: 'a1',
    component: A1
}

{ 
    path: 'b',
    component: B
}

{ 
    path: 'b1',
    component: B1
}

```

* 优化后 （使用`webpackChunkName`类指定该组件打包时的目标分片）

```js
// /router/index.js

……

{ 
    path: 'a',
    component: () => {/* webpackChunkName: "group-a" */'xxx/A'},
}

{ 
    path: 'a1',
    component: () => {/* webpackChunkName: "group-a" */'xxx/A1'},
}

{ 
    path: 'b',
    component: () => {/* webpackChunkName: "group-b" */'xxx/B'},
}

{ 
    path: 'b1',
    component: () => {/* webpackChunkName: "group-b" */'xxx/B1'},
}

```

#### 1.2 减少首页API请求

1. 尽量将首页用不到的API请求移到具体的二级页面的组件里
2. 首页弹窗、筛选条件等不用第一时间呈现的内容所涉及的请求，可以设计为子组件将请求移动到子组件里，并且按需引入到首页里，延迟请求。

### 2. 缩减资源体积

#### 2.1 混淆压缩

这个就不多说了，基本脚手架的默认配置都支持将代码做压缩和混淆。

#### 2.2 第三方库按需引入

##### ElementUI

我们知道`ElementUI`总共有上百个组件，但是我们在项目中很少全部用到，如果我们以下面的方式进行引入，就会导致打包时打入很多我们没用到的组件：

```js
import ElementUI from 'element-ui';
Vue.use(ElementUI, {
    size: 'small',
});
```

但是，如果我们改为下面这种按需引入的方式，体积就会减少很多：

```js
// main.js
import {
    Avatar,
    Pagination,
    Form,
    Dialog,
    Menu,
    Submenu,
    Input,
    Radio,
    RadioButton,
    RadioGroup,
    Checkbox,
    Select,
    Option,
    OptionGroup,
    Button,
    Table,
    DatePicker,
    Loading,
    MessageBox,
    Message,
    MenuItem,
    TableColumn,
    FormItem,
    Tree,
    Col,
    Row,
    Timeline,
    TimelineItem,
    Drawer,
    Progress,
    Card,
    Tooltip,
    InputNumber,
    CheckboxGroup,
    Notification,
    InfiniteScroll,
    Autocomplete,
    Tag,
    Tabs,
    TabPane,
    Badge,
    Carousel,
    CarouselItem,
    promptMessages,
} from 'element-ui';

Vue.use(Badge);
Vue.use(MessageBox);
Vue.use(Message);
Vue.use(Notification);
Vue.use(Avatar);
Vue.use(Pagination);
Vue.use(Dialog);
Vue.use(Form);
Vue.use(Menu);
Vue.use(Submenu);
Vue.use(Input);
Vue.use(Radio);
Vue.use(RadioButton);
Vue.use(RadioGroup);
Vue.use(Checkbox);
Vue.use(Select);
Vue.use(Option);
Vue.use(OptionGroup);
Vue.use(Button);
Vue.use(MenuItem);
Vue.use(Table);
Vue.use(TableColumn);
Vue.use(DatePicker);
Vue.use(FormItem);
Vue.use(Tree);
Vue.use(Col);
Vue.use(Row);
Vue.use(Timeline);
Vue.use(TimelineItem);
Vue.use(Drawer);
Vue.use(Progress);
Vue.use(InputNumber);
Vue.use(Card);
Vue.use(Timeline);
Vue.use(TimelineItem);
Vue.use(Tooltip);
Vue.use(Loading.directive);
Vue.use(promptMessages);
Vue.use(InfiniteScroll);
Vue.use(Tag);
Vue.use(Autocomplete);
Vue.use(CheckboxGroup);
Vue.use(Tabs);
Vue.use(TabPane);
Vue.use(Carousel);
Vue.use(CarouselItem);
```

```bash
$ npm i babel-glugin-component -D
```

```js
// babel.config.js
const plugins = [];
plugins.push(['component', { 'libraryName': 'element-ui', 'styleLibraryName': 'theme-chalk' }]);
module.exports = {
    presets: ['@vue/cli-plugin-babel/preset'],
    plugins: plugins,
};
```



##### Echarts

与`ElementUI`相似，`Echarts`里也包含了很多可能我们用不到的组件，如果直接像下面这样引入，就会导致打包后的js体积过大：

```js
// main.js
import * as echarts from 'echarts';
Vue.prototype.$echarts = echarts;
```

好在`echarts`5.0以后的版本也支持了按需加载的特性。如果我们只是在某个页面用到`echarts`，那么可以直接在那个页面组件中像下面这样引入：

```js
// Event.vue
...
import * as echarts from 'echarts/core';
import {
    TitleComponent,
    ToolboxComponent,
    TooltipComponent,
    GridComponent,
    LegendComponent,
} from 'echarts/components';
import {
    LineChart,
} from 'echarts/charts';
import {
    CanvasRenderer,
} from 'echarts/renderers';

echarts.use(
    [TitleComponent, ToolboxComponent, TooltipComponent, GridComponent, LegendComponent, LineChart, CanvasRenderer],
);
...
this.myChart = echarts.init(document.getElementById('chats'));
```

其中，第一行引入的`core`是必需的，下面的那些可以根据自己使用的图表组件类型来引入不同的组件。

在`echars`官方的示例页面，也有对应图表类型的按需引入代码，可以找到自己用的图表类型示例，然后直接copy就行。

![image-20210817114150737](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210817114150.png)



如果整个项目很多地方都用到`echarts`图表，那么可以新建一个`plugin/echarts.js`:

```js
// plugin/echarts.js
import * as echarts from 'echarts/core';
import {
    TitleComponent,
    ToolboxComponent,
    TooltipComponent,
    GridComponent,
    LegendComponent,
} from 'echarts/components';
import {
    LineChart,
} from 'echarts/charts';
import {
    CanvasRenderer,
} from 'echarts/renderers';

echarts.use(
    [TitleComponent, ToolboxComponent, TooltipComponent, GridComponent, LegendComponent, LineChart, CanvasRenderer],
);
export default echarts
```

然后在`main.js`中全局注册就好：

```js
// main.js
// 按需引入 echarts 5.x
import echarts from './plugins/echarts	'

Vue.prototype.$echarts = echarts
```

在具体组件中直接引用就行：

```js
// Event.vue
...
let myEcharts = this.$echarts.init(this.$refs.bar)
...
```



##### lodash

 lodash也是我们常用的一个工具库，提供了丰富的API来操作数据。
 通常，我们认为下面的写法就可以实现按需引入`lodash`：
 ```javascript
 import { join, map } from 'lodash';
 ...
 
 join(...).map(...)
 ```

 但实际上，由于`lodash`默认导出的是全部方法，并没有针对每个方法单独导出，所以即使我们向上面这样写了，打包时还是会将库中所有方法都打包到我们的最终产出文件中去。

 有三种方法可以解决这个问题：

 ###### 1. 按需引入：

 ```javascript
 import join from 'lodash/join';
 import map from 'lodash/map';
 ```

 缺点：当要引入的方法很多时，增加代码量的同时也不够优雅。

 ###### 2. 使用`lodash-es`库代替`lodash`库
 ```javascript
 import { join, map } from 'lodash-es';
 ```

 缺点：`lodash-es`模块的`find`方法bug。

 ###### 3.  使用webpack配置+babel配置的方式：

 ```bash
 $ npm i --save lodash
$ npm i --save-dev lodash-webpack-plugin babel-plugin-lodash

 ```

 ```js
 // babel.config.js
 
   module.exports = {
    plugins: ["lodash"],
  };

 ```

 ```js
 // vue.config.js
 
 const LodashModuleReplacementPlugin = require("lodash-webpack-plugin");
	module.exports = {
    chainWebpack: (config) => {
      config.plugin("loadshReplace").use(new LodashModuleReplacementPlugin());
    },
  };

 ```

 引用：
 ```js
 import { join, map } from 'lodash'
 ```

 推荐使用这种配置的方式。


##### 其它类型的第三方库——以fabric为例

`fabric`是一个Canvas绘图库。由于项目中没有使用它的Vue封装，也没有引用NPM包，而是直接引用了原生的文件并在`main.js`中引入了它。导致首页加载时的请求负荷过大，时间过长。

这种引入方式和jquery很类似，所以我们以它为例，举例说明如何把类似这种第三方库的引用移出首页的加载列表（当然，如果首页就要用到的除外）

由于这种类型的第三方库没有使用标准ES模块导出，所以我们并不能对它进行按需引入，而只能将它挪出`main.js`，挪到具体使用它的组件内，这样，可以减少首页加载时`vender.chunk.js`的大小。优化后只有相应组件加载时才会去请求它。

首先，在`vue.config.js`中，设置`fabric`的别名，并将它指向我们下载好的静态文件：
```javascript
// vue.config.js
module.exports = {

//……

chainWebpack: config => {

 config.resolve.alias

 .set('fabric', resolve('src/assets/js/fabric.min.js'));

 },

}
```

然后，在需要使用该库的地方，我们就可以使用ES Module语法引入它，并按照它的API来使用它了

```vue
src/views/xxx/index.vue

<script>

import { fabric } from 'fabric';

export default {


	methods: {
		this.canvas = new fabric.Canvas(...);
	}


}


</script>


```



#### 2.3. 大杀器gzip

其实前面的优化虽然能提高一定的加载性能，但是比起`gzip`来，简直是小巫见大巫了，通常情况下，`gzip`压缩过的文件大小只有源文件的四分之一甚至更少。

##### 2.3.1 动态gzip
我们都知道，如果`nginx`服务配置开启了`gzip`服务的话，我们请求的静态资源将被压缩传输：

```shell
// nginx.conf

gzip on;
```

这种方式我们称为【动态`gzip`】, 它是在我们请求的时候，由后端`nginx`服务动态的将我们的静态资源进行压缩，然后返回给前端，这就减少了传输的资源体积。

但这样做在资源体积比较大，资源数量比较多的情况下，一是会加重`nginx`的CPU负荷，二是由于动态压缩也需要时间，会增加响应时间，资源少的情况下，这个时间差别不，但是如果资源很多的话，越是排在后面请求的资源，耗时可能会越长。

##### 2.3.2 静态gzip

所以，还有一种方式叫【静态`gzip`】，就是前端程序打包时直接生成`gz`格式的压缩文件，在前端请求资源时，如果请求的`Header`里带有`gzip`标志，并且`nginx`开启了静态`gzip`功能时，`nginx`会直接把这个压缩好的`gz`格式的压缩文件返回给前端。

这样既减轻了`nginx`服务器的负担，又加快了响应速度。而且静态`gzip`可以由前端设置压缩级别，压缩出的大小可能还比服务器动态`gzip`压缩出的要小。

`nginx`开启静态`gzip`的配置如下：

```shell
// nginx.conf
gzip on;
gzip_static on;
```



不使用静态`gzip`，只依赖`nginx`的动态`gzip`：

![image-20210817165128282](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210817165128.png)



使用静态`gzip`：

![image-20210817170313315](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210817170313.png)

静态`gzip`在`vue`程序中的配置：

```js
// vue.config.js
const CompressionWebpackPlugin = require('compression-webpack-plugin');
const productionGzipExtensions = ['js', 'css'];

....

configureWebpack: {
        // devtool: 'source-map',
        plugins: [
            // 配置compression-webpack-plugin压缩
            new CompressionWebpackPlugin({
                test: new RegExp('\\.(' + productionGzipExtensions.join('|') + ')$'),
                compressionOptions: { level: 9 }, // level最大为9，数字越大，压缩级别越高
            }),
        ],
    },
```

当然，这需要安装`compression-webpack-plugin`插件。安装时要注意版本兼容性，否则如果插件版本过高，会报错：

```json
// package.json
"devDependencies": {
    ...
    "compression-webpack-plugin": "4.0.1",
    ...
}
```





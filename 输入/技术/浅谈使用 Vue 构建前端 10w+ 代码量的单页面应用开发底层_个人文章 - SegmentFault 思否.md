![](https://segmentfault.com/img/remote/1460000015472616?w=845&h=622)

开始之前
----

随着业务的不断累积，目前我们 `ToC 端`主要项目，除去 `node_modules`， `build 配置文件`，`dist 静态资源文件`的代码量为 `137521` 行，后台管理系统下各个子应用代码，除去依赖等文件的总行数也达到 `100万` 多一点。

> 代码量意味不了什么，只能证明模块很多，但相同两个项目，在`运行时性能相同`情况下，**你的 `10 万`行代码能容纳并维护 `150` 个模块，并且开发顺畅，我的项目中 `10 万`行代码却只能容纳 `100` 个模块，添加功能也好，维护起来也较为繁琐，这就很值得思考**。

本文会在主要描述以 `Vue 技术栈`为`技术主体`，`ToC 端`项目`业务主体`，在构建过程中，遇到或者总结的点（也会提及一些 ToB 项目的场景），**可能并不适合你的业务场景（仅供参考），我会尽可能多的描述问题与其中的思考，最大可能的帮助到需要的同学**，也辛苦开发者发现问题或者不合理/不正确的地方及时向我反馈，会尽快修改，欢迎有更好的实现方式来 `pr`。

##### Git 地址

*   [vue-develop-template](https://github.com/PerseveranceZ/vue-develop-template) 完善中，可以运行

##### React 项目

可以参考`蚂蚁金服数据体验技术团队`编写的文章：

*   [如何管理好10万行代码的前端单页面应用](https://juejin.im/post/59cb0d0b5188257e876a2d27)

本文并不是基于上面文章写的，不过当时在看到他们文章之后觉得有相似的地方，相较于这篇文章，本文可能会枯燥些，会有大量代码，同学可以直接用上仓库看。

① 单页面，多页面
---------

首先要思考我们的项目最终的`构建主体`是`单页面`，还是`多页面`，还是`单页 + 多页`，通过他们的优缺点来分析：

*   **单页面（SPA）**
    
    *   优点：体验好，路由之间跳转流程，可定制转场动画，使用了`懒加载`可有效减少首页白屏时间，相较于`多页面`减少了用户访问静态资源服务器的次数等。
    *   缺点：初始会加载较大的静态资源，并且随着业务增长会越来越大，`懒加载`也有他的弊端，不做特殊处理不利于 SEO 等。
*   **多页面（MPA）**：
    
    *   优点：对搜索引擎友好，开发难度较低。
    *   缺点：资源请求较多，整页刷新体验较差，页面间传递数据只能依赖 `URL`，`cookie`，`storage` 等方式，较为局限。
*   **SPA + MPA**
    
    *   这种方式常见于较`老 MPA 项目迁移至 SPA 的情况`，缺点结合两者，两种主体通信方式也只能以兼容`MPA 为准`
    *   不过这种方式也有他的好处，假如你的 SPA 中，有类似文章分享这样（没有后端直出，后端返 `HTML 串`的情况下），想保证用户体验在 SPA 中开发一个页面，在 MPA 中也开发一个页面，去掉没用的依赖，或者直接用原生 JS 来开发，分享出去是 MPA 的文章页面，这样可以**加快分享出去的打开速度，同时也能减少静态资源服务器的压力**，因为如果分享出去的是 SPA 的文章页面，那 SPA 所需的静态资源`至少都需要去进行协商请求`,当然如果服务配置了强缓存就忽略以上所说。

我们首先根据业务所需，来最终确定`构建主体`，而我们选择了`体验至上的 SPA`，并选用 `Vue` 技术栈。

② 目录结构
------

其实我们看开源的绝大部分项目中，目录结构都会差不太多，我们可以综合一下来个通用的 `src` 目录：

```
src
├── assets          
├── components      
├── config          
├── plugins         
├── directives      
├── routes          
├── service         
├── utils           
└── views 
```

③ 通用组件
------

`components` 中我们会存放 UI 组件库中的那些常见通用组件了，在项目中直接通过设置`别名`来使用，如果其他项目需要使用，就发到 `npm` 上。

#### 结构

```
 components
├── dist
├── build
├── src      
    ├── modal
    ├── toast
    └── ...
├── index.js             
└── package.json 
```

#### 项目中使用

如果想最终编译成 `es5`，直接在 html 中使用或者部署 CDN 上，在 `build` 配置简单的打包逻辑，搭配着 `package.json` 构建 UI组件 的自动化打包发布，最终部署 `dist` 下的内容，并发布到 `npm` 上即可。

而我们也可直接使用 `es6` 的代码：

```
import 'Components/src/modal'
```

#### 其他项目使用

假设我们发布的 `npm 包`叫 `bm-ui`，并且下载到了本地 `npm i bm-ui -S`:

修改项目的最外层打包配置，在 rules 里 `babel-loader` 或 `happypack` 中添加 `include`，`node_modules/bm-ui`：

```
 ...
    rules: [{
        test: /\.vue$/,
        loader: 'vue-loader',
        options: vueLoaderConfig
    },
    {
        test: /\.js$/,
        loader: 'babel-loader',
        
        include: [resolve('src'), resolve('test'), resolve('node_modules/bm-ui')]
    },{
    ...
    }]
...
```

然后搭配着 `babel-plugin-import` 直接在项目中使用即可：

```
import { modal } from 'bm-ui'
```

#### 多个组件库

同时有多个组件库的话，又或者有同学专门进行组件开发的话，把 `components  
内部细分`一下，多一个文件分层。

```
components
├── bm-ui-1 
├── bm-ui-2
└── ...
```

你的打包配置文件可以放在 `components` 下，进行统一打包，当然如果要开源出去还是放在对应库下。

④ 全局配置，插件与拦截器
-------------

这个点其实会是项目中经常被忽略的，或者说很少聚合到一起，但同时我认为是**整个项目中的重要之一**，后续会有例子说道。

#### 全局配置，拦截器目录结构

```
config
├── index.js             
├── interceptors        
    ├── index.js        
    ├── axios.js        
    ├── router.js       
    └── ...
└── ... 
```

#### 全局配置

我们在 `config/index.js` 可能会有如下配置：

```
 export const HOST_PLATFORM = 'WEB'

export const NODE_ENV = process.env.NODE_ENV || 'prod'

export const AJAX_LOCALLY_ENABLE = false

export const MONITOR_ENABLE = true

export const ROUTER_DEFAULT_CONFIG = {
    waitForData: true,
    transitionOnLoad: true
}

export const AXIOS_DEFAULT_CONFIG = {
    timeout: 20000,
    maxContentLength: 2000,
    headers: {}
}

export const VUEX_DEFAULT_CONFIG = {
    strict: process.env.NODE_ENV !== 'production'
}

export const API_DEFAULT_CONFIG = {
    mockBaseURL: '',
    mock: true,
    debug: false,
    sep: '/'
}

export const CONST_DEFAULT_CONFIG = {
    sep: '/'
}

export const CONSOLE_REQUEST_ENABLE = true      
export const CONSOLE_RESPONSE_ENABLE = true     
export const CONSOLE_MONITOR_ENABLE = true 
```

可以看出这里汇集了项目中**所有用到的配置**，下面我们在 `plugins` 中实例化插件，注入对应配置，目录如下:

#### 插件目录结构

```
plugins
├── api.js              
├── axios.js            
├── const.js            
├── store.js            
├── inject.js           
└── router.js 
```

#### 实例化插件并注入配置

这里先举出两个例子，看我们是如何注入配置，拦截器并实例化的

实例化 `router`：

```
import Vue from 'vue'
import Router from 'vue-router'
import ROUTES from 'Routes'
import {ROUTER_DEFAULT_CONFIG} from 'Config/index'
import {routerBeforeEachFunc} from 'Config/interceptors/router'

Vue.use(Router)

let routerInstance = new Router({
    ...ROUTER_DEFAULT_CONFIG,
    routes: ROUTES
})

routerInstance.beforeEach(routerBeforeEachFunc)

export default routerInstance 
```

实例化 `axios`：

```
import axios from 'axios'
import {AXIOS_DEFAULT_CONFIG} from 'Config/index'
import {requestSuccessFunc, requestFailFunc, responseSuccessFunc, responseFailFunc} from 'Config/interceptors/axios'

let axiosInstance = {}

axiosInstance = axios.create(AXIOS_DEFAULT_CONFIG)


axiosInstance
    .interceptors.request.use(requestSuccessFunc, requestFailFunc)

axiosInstance
    .interceptors.response.use(responseSuccessFunc, responseFailFunc)

export default axiosInstance
```

我们在 `main.js` **注入插件**：

```
 import Vue from 'vue'

GLOBAL.vbus = new Vue()

import 'Directives' 

import router from 'Plugins/router'
import inject from 'Plugins/inject'
import store from 'Plugins/store'

import VueOnsen from 'vue-onsenui'
import 'onsenui/css/onsenui.css'
import 'onsenui/css/onsen-css-components.css'

import App from './App'

Vue.use(inject)
Vue.use(VueOnsen)

new Vue({
    el: '#app',
    router,
    store,
    template: '<App/>',
    components: { App }
}) 
```

`axios` 实例我们并没有直接引用，相信你也猜到他是通过 `inject` 插件引用的，我们看下 `inject`：

```
import axios from './axios'
import api from './api'
import consts from './const'
GLOBAL.ajax = axios
 
export default {
    install: (Vue, options) => {
        Vue.prototype.$api = api
        Vue.prototype.$ajax = axios
        Vue.prototype.$const = consts
        
    }
}
```

这里可以挂载你想在业务中( `vue` 实例中)便捷访问的 `api`，除了 `$ajax` 之外，`api` 和 `const` 两个插件是我们**服务层中主要的功能**，后续会介绍，这样我们插件流程大致运转起来，下面写对应拦截器的方法。

#### 请求，路由拦截器

在`ajax 拦截器`中(`config/interceptors/axios.js`)：

```
 import {CONSOLE_REQUEST_ENABLE, CONSOLE_RESPONSE_ENABLE} from '../index.js'

export function requestSuccessFunc (requestObj) {
    CONSOLE_REQUEST_ENABLE && console.info('requestInterceptorFunc', `url: ${requestObj.url}`, requestObj)
    
    
    
    return requestObj
}

export function requestFailFunc (requestError) {
    
    
    
    return Promise.reject(requestError);
}

export function responseSuccessFunc (responseObj) {
    
    
    
    
    
    
    
    
    
    let resData =  responseObj.data
    let {code} = resData
    
    switch(code) {
        case 0: 
            return resData.data;
        case 1111: 
            
            
            
            
            
            location.href = xxx 
            return;
        default:
            
            !responseObj.config.noShowDefaultError && GLOBAL.vbus.$emit('global.$dialog.show', resData.msg);
            return Promise.reject(resData);
    }
}

export function responseFailFunc (responseError) {
    
    
    return Promise.reject(responseError);
}
```

定义`路由拦截器`(`config/interceptors/router.js`)：

```
 export function routerBeforeFunc (to, from, next) {
    
    
    
}
```

最后在`入口文件(config/interceptors/index.js)`中引入并暴露出来即可:

```
import {requestSuccessFunc, requestFailFunc, responseSuccessFunc, responseFailFunc} from './ajax'
import {routerBeforeEachFunc} from './router'

let interceptors = {
    requestSuccessFunc,
    requestFailFunc,
    responseSuccessFunc,
    responseFailFunc,
    routerBeforeEachFunc
}

export default interceptors
```

请求拦截这里代码都很简单，对于 `responseSuccessFunc` 中 switch `default` 逻辑做下简单说明：

1.  `responseObj.config.noShowDefaultError` 这里可能不太好理解

我们在请求的时候，可以传入一个 axios 中并没有意义的 `noShowDefaultError` 参数为我们业务所用，当值为 false 或者不存在时，我们会触发全局事件 `global.dialog.show`，`global.dialog.show`我们会注册在 `app.vue` 中：

```
 export default {
    ...
    created() {
        this.bindEvents
    },
    methods: {
        bindEvents() {
            GLOBAL.vbus.$on('global.dialog.show', (msg) => {
                if(msg) return
                
                this.$dialog.popup({
                    content: msg 
                });
            })
        }
        ...
    }
}
```

> 这里也可以把弹窗状态放入 `Store` 中，按团队喜好，我们习惯把**公共的涉及视图逻辑的公共状态在这里注册，和业务区分开来**。

1.  `GLOBAL` 是我们挂载 `window` 上的`全局对象`，我们把需要挂载的东西都放在 `window.GLOBAL` 里，减少命名空间冲突的可能。
2.  `vbus` 其实就是我们开始 `new Vue()` 挂载上去的

```
GLOBAL.vbus = new Vue()
```

1.  我们在这里 `Promise.reject` 出去，我们就可以在 `error` 回调里面只处理我们的业务逻辑，而其他如`断网`、`超时`、`服务器出错`等均通过拦截器进行统一处理。

#### 拦截器处理前后对比

对比下`处理前后在业务中的发送请求的代码`：

**拦截器处理前**：

```
this.$axios.get('test_url').then(({code, data}) => {
    if( code === 0 ) {
        
    } else if () {}
        
    
    
}, error => {
   
})
```

**拦截器处理后**：

```
 this.$axios.get('test_url').then(({data}) => {
    
})

this.$axios.get('test_url', {
    noShowDefaultError: true 
}).then(({data}) => {
    
    
}, (code, msg) => {
    
})
```

#### **为什么要如此配置与拦截器？**

> 在应对项目开发过程中需求的不可预见性时，让我们能处理的更快更好

到这里很多同学会觉得，就这么简单的引入判断，可有可无，  
就如我们最近做的一个需求来说，我们 ToC 端项目之前一直是在微信公众号中打开的，而我们需要在小程序中通过 webview 打开大部分流程，而我们也`没有时间，没有空间`在小程序中重写近 100 + 的页面流程，**这是我们开发之初并没有想到的**。这时候必须把项目兼容到小程序端，在兼容过程中可能需要解决以下问题：

1.  请求路径完全不同。
2.  需要兼容两套不同的权限系统。
3.  有些流程在小程序端需要做改动，跳转到特定页面。
4.  有些公众号的 `api` ，在小程序中无用，需要调用小程序的逻辑，需要做兼容。
5.  很多也页面上的元素，小程序端不做展示等。

> 可以看出，稍微不慎，会影响公众号现有逻辑。

*   添加请求拦截 `interceptors/minaAjax.js`， `interceptors/minaRouter.js`，原有的换更为 `interceptors/officalAjax.js`，`interceptors/officalRouter.js`，在入口文件`interceptors/index.js`，**根据当前`宿主平台`，也就是全局配置 `HOST_PLATFORM`，通过`代理模式`和`策略模式`，注入对应平台的拦截器**，**在`minaAjax.js`中重写请求路径和权限处理，在 `minaRouter.js` 中添加页面拦截配置，跳转到特定页面**，这样一并解决了上面的`问题 1，2，3`。
*   `问题 4` 其实也比较好处理了，拷贝需要兼容 `api` 的页面，重写里面的逻辑，通过`路由拦截器一并做跳转处理`。
*   `问题 5` 也很简单，拓展两个**自定义指令 v-mina-show 和 v-mina-hide** ，在展示不同步的地方可以直接使用指令。

最终用最少的代码，最快的时间完美上线，丝毫没影响到现有 toC 端业务，而且**这样把所有兼容逻辑绝大部分聚合到了一起，方便二次拓展和修改。**

虽然这只是根据自身业务结合来说明，可能没什么说服力，不过不难看出全局配置/拦截器 虽然代码不多，但却是整个项目的核心之一，我们可以在里面做更多 `awesome` 的事情。

⑤ 路由配置与懒加载
----------

`directives` 里面没什么可说的，不过很多难题都可以通过他来解决，要时刻记住，我们可以再指令里面**操作虚拟 DOM。**

#### 路由配置

而我们根据自己的业务性质，最终根据业务流程来拆分配置：

```
routes
├── index.js            
├── common.js           
├── account.js          
├── register.js         
└── ...
```

最终通过 index.js 暴露出去给 `plugins/router` 实例使用，这里的拆分配置有两个注意的地方：

*   需要根据自己业务性质来决定，有的项目可能适合`业务线`划分，有的项目更适合以 `功能` 划分。
*   在多人协作过程中，尽可能避免冲突，或者减少冲突。

#### 懒加载

文章开头说到单页面静态资源过大，`首次打开/每次版本升级`后都会较慢，可以用`懒加载`来拆分静态资源，减少白屏时间，但开头也说到`懒加载`也有待商榷的地方：

*   如果异步加载较多的组件，会给静态资源服务器/ CDN 带来更大的访问压力的同时，如果当多个异步组件都被修改，造成版本号的变动，发布的时候会大大增加 CDN 被击穿的风险。
*   懒加载首次加载未被缓存的异步组件白屏的问题，造成用户体验不好。
*   异步加载通用组件，会在页面可能会在网络延时的情况下参差不齐的展示出来等。

这就需要我们根据项目情况在`空间和时间`上做一些权衡。

以下几点可以作为简单的参考：

*   对于访问量可控的项目，如`公司后台管理系统`中，可以以操作 view 为单位进行异步加载，通用组件全部同步加载的方式。
*   对于一些复杂度较高，实时度较高的应用类型，可采用按`功能模块拆分`进行异步组件加载。
*   如果项目想保证比较高的完整性和体验，迭代频率可控，不太关心首次加载时间的话，可按需使用异步加载或者直接不使用。

> 打包出来的 main.js 的大小，绝大部分都是在路由中引入的并注册的视图组件。

⑥ Service 服务层
-------------

服务层作为项目中的另一个核心之一，“自古以来”都是大家比较关心的地方。

不知道你是否看到过如下组织代码方式：

```
views/
    pay/
        index.vue
        service.js
        components/
            a.vue
            b.vue
```

在 `service.js` 中写入编写数据来源

```
export const CONFIAG = {
    apple: '苹果',
    banana: '香蕉'
}

export function getBInfo ({name = '', id = ''}) {
    return this.$ajax.get('/api/info', {
        name, 
        id
    }).then({age} => {
        this.$modal.show({
            content: age
        })
    })
}

export function getAInfo ({name = '', id = ''}) {
    return this.$ajax.get('/api/info', {
        name, 
        id
    })
}

...
```

简单分析：

*   ① 就不多说了，拆分的不够单纯，当做二次开发的时候，你还得去找这弹窗到底哪里出来的。
*   ② 看起来很美好，不掺杂业务逻辑，但不知道你与没遇到过这样情况，**经常会有其他业务需要用到一样的枚举，请求一样的接口，而开发其他业务的同学并不知道你在这里有一份数据源，最终造成的结果就是数据源的代码到处冗余**。

我相信②在绝大多数项目中都能看到。

那么我们的目的就很明显了，**解决冗余，方便使用**，我们把枚举和请求接口的方法，通过插件，挂载到一个大对象上，注入 Vue 原型，方面业务使用即可。

#### 目录层级（仅供参考）

```
service
├── api
    ├── index.js             
    ├── order.js             
    └── ...
├── const                   
    ├── index.js             
    ├── order.js             
    └── ...
├── store                    
├── expands                  
    ├── monitor.js           
    ├── beacon.js            
    ├── localstorage.js      
    └── ...                  
└── ... 
```

#### 抽离模型

首先抽离请求接口模型，可按照`领域模型抽离` (`service/api/index.js`):

```
{
    user: [{
        name: 'info',
        method: 'GET',
        desc: '测试接口1',
        path: '/api/info',
        mockPath: '/api/info',
        params: {
            a: 1,
            b: 2
        }
    }, {
        name: 'info2',
        method: 'GET',
        desc: '测试接口2',
        path: '/api/info2',
        mockPath: '/api/info2',
        params: {
            a: 1,
            b: 2,
            b: 3
        }
    }],
    order: [{
        name: 'change',
        method: 'POST',
        desc: '订单变更',
        path: '/api/order/change',
        mockPath: '/api/order/change',
        params: {
            type: 'SUCCESS'
        }
    }]
    ...
}
```

定制下需要的几个功能：

*   请求参数自动截取。
*   请求参数不传，则发送默认配置参数。
*   得需要命名空间。
*   通过全局配置开启调试模式。
*   通过全局配置来控制走本地 mock 还是线上接口等。

#### 插件编写

定制好功能，开始编写简单的 `plugins/api.js` 插件：

```
import axios from './axios'
import _pick from 'lodash/pick'
import _assign from 'lodash/assign'
import _isEmpty from 'lodash/isEmpty'

import { assert } from 'Utils/tools'
import { API_DEFAULT_CONFIG } from 'Config'
import API_CONFIG from 'Service/api'

class MakeApi {
    constructor(options) {
        this.api = {}
        this.apiBuilder(options)
    }


    apiBuilder({
        sep = '|',
        config = {},
        mock = false, 
        debug = false,
        mockBaseURL = ''
    }) {
        Object.keys(config).map(namespace => {
            this._apiSingleBuilder({
                namespace, 
                mock, 
                mockBaseURL, 
                sep, 
                debug, 
                config: config[namespace]
            })
        })
    }
    _apiSingleBuilder({
        namespace, 
        sep = '|',
        config = {},
        mock = false, 
        debug = false,
        mockBaseURL = ''
    }) {
        config.forEach( api => {
            const {name, desc, params, method, path, mockPath } = api
            let apiname = `${namespace}${sep}${name}`,
                url = mock ? mockPath : path,
                baseURL = mock && mockBaseURL
            
            
            debug && console.info(`调用服务层接口${apiname}，接口描述为${desc}`)
            debug && assert(name, `${apiUrl} :接口name属性不能为空`)
            debug && assert(apiUrl.indexOf('/') === 0, `${apiUrl} :接口路径path，首字符应为/`)

            Object.defineProperty(this.api, `${namespace}${sep}${name}`, {
                value(outerParams, outerOptions) {
                
                    
                    
                    let _data = _isEmpty(outerParams) ? params : _pick(_assign({}, params, outerParams), Object.keys(params))
                    return axios(_normoalize(_assign({
                        url,
                        desc,
                        baseURL,
                        method
                    }, outerOptions), _data))
                }
            })      
        })
    }       
}

function _normoalize(options, data) {
    
    if (options.method === 'POST') {
        options.data = data
    } else if (options.method === 'GET') {
        options.params = data
    }
    return options
} 

export default new MakeApi({
    config: API_CONFIG,
    ...API_DEFAULT_CONFIG
})['api']
```

挂载到 `Vue 原型`上，上文有说到，通过 `plugins/inject.js`

```
import api from './api'
 
export default {
    install: (Vue, options) => {
        Vue.prototype.$api = api
        
    }
}
```

#### 使用

这样我们可以在`业务中`愉快的使用业务层代码：

```
 export default {
    methods: {
        test() {
            this.$api['order/info']({
                a: 1,
                b: 2
            })
        }
    }
}
```

即使在`业务之外`也可以使用：

```
import api from 'Plugins/api'

api['order/info']({
    a: 1,
    b: 2
}) 
```

当然对于`运行效率要求高`的项目中，`避免内存使用率过大`，我们需要改造 API，用解构的方式引入使用，最终利用 `webpack` 的 `tree-shaking` 减少打包体积。[几个简单的思路](https://github.com/PerseveranceZ/vue-develop-template/issues/4)

> 一般来说，多人协作时候大家都可以先看 `api` 是否有对应接口，当业务量上来的时候，也肯定会有人出现找不到，或者找起来比较费劲，这时候我们完全可以在 请求拦截器中，把当前请求的 `url` 和 `api` 中的请求做下判断，如果有重复接口请求路径，则提醒开发者已经配置相关请求，根据情况是否进行二次配置即可。

最终我们可以拓展 Service 层的各个功能：

**基础**

*   **api**：`异步与后端交互`
*   **const**：`常量枚举`
*   **store**：`Vuex` 状态管理

**拓展**

*   **localStorage**：本地数据，稍微封装下，支持存取对象即可
*   **monitor**：`监控`功能，自定义搜集策略，调用 `api` 中的接口发送
*   **beacon**：`打点`功能，自定义搜集策略，调用 `api` 中的接口发送
*   ...

`const`，`localStorage`，`monitor` 和 `beacon` 根据业务自行拓展暴露给业务使用即可，思想也是一样的，下面着重说下 `store(Vuex)`。

> 插一句：如果看到这里没感觉不妥的话，想想上面 `plugins/api.js` 有没有用`单例模式`？该不该用？

⑦ 状态管理与视图拆分
-----------

[Vuex 源码分析可以看我之前写的文章](https://github.com/PerseveranceZ/zero-blog/issues/2)。

#### 我们是不是真的需要状态管理？

> 答案是否定的，就算你的项目达到 10 万行代码，那也并不意味着你必须使用 Vuex，应该由**业务场景**决定。

#### 业务场景

1.  第一类项目：**业务/视图复杂度不高，不建议使用 Vuex，会带来开发与维护的成本**，使用简单的 `vbus` 做好**命名空间**，来解耦即可。

```
let vbus = new Vue()
vbus.$on('print.hello', () => {
    console.log('hello')
})

vbus.$emit('print.hello')
```

1.  第二类项目：类似`多人协作项目管理`，`有道云笔记`，`网易云音乐`，`微信网页版/桌面版`等**应用**，功能集中，空间利用率高，实时交互的项目，无疑 `Vuex 是较好的选择`。这类应用中我们可以直接`抽离业务领域模型`：

```
store
├── index.js          
├── actions.js        
├── mutations.js      
└── modules
    ├── user.js       
    ├── products.js   
    ├── order.js      
    └── ...
```

当然对于这类项目，`vuex` 或许不是最好的选择，有兴趣的同学可以学习下 `rxjs`。

1.  第三类项目：`后台系统`或者`页面之间业务耦合不高的项目`，这类项目是占比应该是很大的，我们思考下这类项目：

全局共享状态不多，但是难免在某个模块中会有复杂度较高的功能(客服系统，实时聊天，多人协作功能等)，这时候如果为了项目的可管理性，我们也在 `store` 中进行管理，随着项目的迭代我们不难遇到这样的情况：

```
store/
    ...
    modules/
        b.js
        ...
views/
    ...
    a/
        b.js
        ... 
```

*   试想下有几十个 module，对应这边上百个业务模块，开发者在两个平级目录之间调试与开发的成本是巨大的。
*   这些 module 可以在项目中任一一个地方被访问，但往往他们都是冗余的，除了引用的功能模块之外，基本不会再有其他模块引用他。
*   项目的可维护程度会随着项目增大而增大。

#### 如何解决第三类项目的 store 使用问题？

先梳理我们的目标：

*   项目中模块可以自定决定是否使用 Vuex。（渐进增强）
*   **从有状态管理的模块，跳转没有的模块，我们不想把之前的状态挂载到 `store` 上，想提高运行效率**。（冗余）
*   让这类项目的状态管理变的更加可维护。（开发成本/沟通成本）

#### 实现

我们借助 Vuex 提供的 `registerModule` 和 `unregisterModule` 一并解决这些问题，我们在 `service/store` 中放入全局共享的状态：

```
service/
    store/
        index.js
        actions.js
        mutations.js
        getters.js
        state.js
```

> 一般这类项目全局状态不多，如果多了拆分 module 即可。

编写插件生成 `store 实例`：

```
import Vue from 'vue'
import Vuex from 'vuex'
import {VUEX_DEFAULT_CONFIG} from 'Config'
import commonStore from 'Service/store'

Vue.use(Vuex)

export default new Vuex.Store({
    ...commonStore,
    ...VUEX_DEFAULT_CONFIG
})
```

对一个需要状态管理页面或者模块进行分层：

```
views/
    pageA/
        index.vue
        components/
            a.vue
            b.vue
            ...
        children/
            childrenA.vue
            childrenB.vue
            ...
        store/
            index.js
            actions.js
            moduleA.js  
            moduleB.js
```

module 中直接包含了 `getters`，`mutations`，`state`，我们在 `store/index.js` 中做文章：

```
import Store from 'Plugins/store'
import actions from './actions.js'
import moduleA from './moduleA.js'
import moduleB from './moduleB.js'

export default {
    install() {
        Store.registerModule(['pageA'], {
            actions,
            modules: {
                moduleA,
                moduleB
            },
            namespaced: true
        })
    },
    uninstall() {
        Store.unregisterModule(['pageA'])
    }
} 
```

最终在 `index.vue` 中引入使用， **在页面跳转之前注册这些状态和管理状态的规则，在路由离开之前，先卸载这些状态和管理状态的规则**：

```
import store from './store'
import {mapGetters} from 'vuex'
export default {
    computed: {
        ...mapGetters('pageA', ['aaa', 'bbb', 'ccc'])
    },
    beforeRouterEnter(to, from, next) {
        store.install()
        next()
    },
    beforeRouterLeave(to, from, next) {
        store.uninstall()
        next()
    }
}
```

当然如果你的状态要共享到全局，就不执行 `uninstall`。

> 这样就解决了开头的三个问题，不同开发者在开发页面的时候，可以根据页面特性，渐进增强的选择某种开发形式。

其他
--

这里简单列举下其他方面，需要自行根据项目深入和使用。

#### 打包，构建

这里网上已经有很多优化方法：`dll`，`happypack`，`多线程打包`等，但随着项目的代码量级，每次 dev 保存的时候编译的速度也是会愈来愈慢的，而一过慢的时候我们就不得不进行拆分，这是肯定的，而在拆分之前尽可能容纳更多的可维护的代码，有几个可以尝试和规避的点：

1.  优化项目流程：这个点看起来好像没什么用，但改变却是最直观的，页面/业务上的化简为繁会直接体现到代码上，同时也会增大项目的可维护，可拓展性等。
2.  减少项目文件层级纵向深度。
3.  减少无用业务代码，避免使用无用或者过大依赖（类似 `moment.js` 这样的库）等。

#### 样式

*   尽可能抽离各个模块，让整个样式底层更加灵活，同时也应该尽可能的减少冗余。
*   如果使用的 `sass` 的话，善用 `%placeholder` 减少无用代码打包进来。

> `MPA 应用`中样式冗余过大，`%placeholder` 也会给你带来帮助。

#### Mock

很多大公司都有自己的 `mock 平台`，当前后端定好接口格式，放入生成对应 `mock api`，如果没有 mock 平台，那就找相对好用的工具如 `json-server` 等。

#### 代码规范

请强制使用 `eslint`，挂在 git 的钩子上。定期 diff 代码，定期培训等。

#### TypeScript

非常建议用 TS 编写项目，可能写 .vue 有些别扭，这样前端的大部分错误在编译时解决，同时也能提高浏览器运行时效率，可能减少 `re-optimize` 阶段时间等。

#### 测试

这也是项目非常重要的一点，如果你的项目还未使用一些测试工具，请尽快接入，这里不过多赘述。

#### 拆分系统

当项目到达到一定业务量级时，由于项目中的模块过多，新同学维护成本，开发成本都会直线上升，不得不拆分项目，后续会分享出来我们 `ToB` 项目在拆分系统中的简单实践。

### 最后

时下有各种成熟的方案，这里只是一个简单的构建分享，里面依赖的版本都是我们稳定下来的版本，需要根据自己实际情况进行升级。

项目底层构建往往会成为前端忽略的地方，我们既要从一个大局观来看待一个项目或者整条业务线，又要对每一行代码精益求精，对开发体验不断优化，慢慢累积后才能更好的应对未知的变化。

*   [关于我，可以叫我 Zero，附上 Git 地址](https://github.com/PerseveranceZ)
*   [文章标题图片地址](https://www.zcool.com.cn/article/ZNDI0NTgw.html)

最后请允许我打一波小小的广告
--------------

#### EROS

如果**前端同学想尝试使用 `Vue` 开发 `App`**，或者熟悉 `weex` 开发的同学，可以来尝试使用我们的开源解决方案 **`eros`**，虽然没做过什么广告，但不完全统计，`50 个在线 APP 还是有的`，期待你的加入。

*   \[\[文章\] 浅谈混合应用演进\]([https://juejin.im/post/5b189f...](https://juejin.im/post/5b189fc9f265da6e326c5104))
*   \[\[文章\] 深入了解 weex\]([https://juejin.im/post/5b18a0...](https://juejin.im/post/5b18a03ce51d45069d2263e3))
*   \[\[文章\] weex-eros 入门指南\]([https://bmfe.github.io/eros-d...](https://bmfe.github.io/eros-docs/#/zh-cn/tutorial_newcomer))
*   [项目地址](https://github.com/bmfe/eros)
*   [文档地址](https://bmfe.github.io/eros-docs/)

最后附上部分产品截图~

![](https://segmentfault.com/img/remote/1460000015472617?w=970&h=3648)

(逃~)
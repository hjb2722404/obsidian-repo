VueCli3构建TS项目的方法步骤_vue.js_脚本之家#夸克#

# VueCli3构建TS项目的方法步骤

发布时间：2018-11-07 11:29:27 作者：alogy
这篇文章主要介绍了VueCli3构建TS项目的方法步骤，小编觉得挺不错的，现在分享给大家，也给大家做个参考。一起跟随小编过来看看吧
使用`vue-cli3`构建`Typescript`项目
**import 和 require**
`require`: 以同步的方式检索其他模块的导出 (开发)
`import`: 动态地加载模块 (生产)
相关文档：[module methods](http://webpack.css88.com/api/module-methods.html)
**vue-cli3**
vue create project-name
[vue-cli3配置](https://cli.vuejs.org/zh/config/#baseurl), 生成目录结构：
│ .browserslistrc
│ .gitignore
│ .postcssrc.js // postcss 配置
│ babel.config.js
│ cypress.json
│ package.json // 依赖
│ README.md
│ tsconfig.json // ts 配置
│ eslint.json // eslint 配置
│ yarn.lock
│ ├─public // 静态页面
│ │ favicon.ico
│ │ index.html
│ │ manifest.json
│ │ robots.txt
│ │ │ └─img
│ └─icons
│ ├─src // 主目录
│ │ App.vue // 页面主入口
│ │ main.ts // 脚本主入口
│ │ registerServiceWorker.ts // PWA 配置
│ │ router.ts // 路由
│ │ shims-tsx.d.ts // 相关 tsx 模块注入
│ │ shims-vue.d.ts // Vue 模块注入
│ │ store.ts // vuex 配置
│ │ │ ├─assets // 静态资源
│ │ logo.png
│ │ │ ├─components // 组件
│ │ HelloWorld.vue
│ │ │ └─views // 页面
│ About.vue
│ Home.vue
│ └─tests // 测试用例
├─e2e
│ ├─plugins
│ │ index.js │ ├─specs
│ │ test.js │ └─support
│ commands.js
│ index.js └─unit
HelloWorld.spec.ts
改造后的目录结构：
│ .browserslistrc
│ .gitignore
│ .postcssrc.js // postcss 配置
│ babel.config.js
│ cypress.json
│ package.json // 依赖
│ README.md // 项目 readme
│ tsconfig.json // ts 配置
│ eslint.json // eslint 配置
│ vue.config.js // webpack 配置
│ yarn.lock
│ ├─public // 静态页面
│ │ favicon.ico
│ │ index.html
│ │ manifest.json
│ │ robots.txt
│ │ │ └─img
│ └─icons
├─scripts // 相关脚本配置
├─src // 主目录
│ │ App.vue // 页面主入口
│ │ main.ts // 脚本主入口
│ │ registerServiceWorker.ts // PWA 配置
│ │ shims-tsx.d.ts
│ │ shims-vue.d.ts
│ │ │ ├─assets // 静态资源
│ │ logo.png
│ │ │ ├─components
│ │ HelloWorld.vue
│ │ │ ├─filters // 过滤
│ ├─lib // 全局插件
│ ├─router // 路由配置
│ │ index.ts
│ │ │ ├─scss // 样式
│ ├─store // vuex 配置
│ │ index.ts
│ │ │ ├─typings // 全局注入
│ ├─utils // 工具方法(axios封装，全局方法等)
│ └─views // 页面
│ About.vue
│ Home.vue
│ └─tests // 测试用例
├─e2e
│ ├─plugins
│ │ index.js
│ │ │ ├─specs
│ │ test.js
│ │ │ └─support
│ commands.js
│ index.js
│ └─unit
HelloWorld.spec.ts
**eslint 和 tslint**
> tslint配置
关闭不能`cosole`:
"no-console": false
[tslint的函数前后空格：](https://eslint.org/docs/rules/space-before-function-paren)
"space-before-function-paren": ["error", {
"anonymous": "always",
"named": "always",
"asyncArrow": "always"
}]
[tslint分号](https://palantir.github.io/tslint/rules/semicolon/)的配置：
"semicolon": [true, "never"]
> eslint配置
在项目中是使用`eslint`
规范空格：`'indent': 0`
**路由改造**
> 引入组件方式
`dev`使用`require`:
/**
* 开发环境载入文件
* @param fileName 文件路径，不包括文件名
* @param viewPath 视图目录
*/
module.exports = (file: string, viewPath: string = 'views') => {
return require(`@/${viewPath}/${file}.vue`).default
}
`prod`使用`import`:
/**
* 生产环境载入文件
* @param fileName 文件路径，不包括文件名
* @param viewPath 视图目录
*/
module.exports = (file: string, viewPath: string = 'views') => {
return import(`@/${viewPath}/${file}.vue`)
}
> 路由处理逻辑
改文件在`app.vue`中引入：
/**
* 路由处理逻辑
*/
import router from '@/router/index'
router.beforeEach((to: any, from: any, next: any) => {
if (to.name === 'login') {
next({name: 'home/index'})
} else {
next()
}
})
> router-view
一个`<router-view />`对应一个路由层级，下一级`<router-view />` 对应路由表中的`children`路由
> router 中的meta
配置每个路由的单独特性
`title`, `keepalive`, `main`, `desc`, `icon`, `hidden`, `auth`
> keep-alive
vue中的`<keep-alive></keep-alive>`其它生命周期不执行，只执行：`activated` 和 `deactivated`
**axios改造**
`npm i axios --save`
![13d4d01d6c6caa68324f61d4aef5611f.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/f7ff2257ef4952986f5b39c0487de02b.png)
> typings
在根目录创建`typings`文件，里面定义, 全局注入。
需要哪些接口引入哪些接口文件。
创建`ajax.d.ts`文件，并声明后台返回的数据格式。
declare namespace Ajax {
// axios return data
export interface AxiosResponse {
data: AjaxResponse
}
// reqposne interface
export interface AjaxResponse {
id: number
error: null | object
jsonrpc: string
result: any
}
}
使用，在`src`根目录下都可以使用。
let res: Ajax.AxiosResponse = {
data: {"id": "1533610056745", "result": 1, "error": null, "jsonrpc": "2.0"}
}
> cookies的处理
安装cookies的包：`npm i js-cookie --save`
增加项目前缀，封装cookie, localStorage, sessionStorage 增删改等方法
/**
* 操作 cookie, localStorage, sessionStorage 封装
*/
import Cookies from 'js-cookie'
import { isNil } from 'lodash'
const prefix = process.env.VUE_APP_PREFIX
/**
* ============ Cookie ============
*/
export function getCookie (name: string): string {
return Cookies.get(prefix + name)
}
export function setCookie (name: string, value: any, params= {}): void {
if (isEmpty(value)) return
Cookies.set(prefix + name, value, params)
}
export function removeCookie (name: string, params= {}): void {
Cookies.remove(prefix + name, params)
}
/**
* ============ localStorage ============
*/
export function setLocalStorage (name: string, value: any): void {
if (isEmpty(value)) return
window.localStorage.setItem(prefix + name, value)
}
export function getLocalStorage (name: string) {
return window.localStorage.getItem(prefix + name)
}
export function removeLocalStorage (name: string) {
window.localStorage.removeItem(prefix + name)
}
export function clearLocal () {
window.localStorage.clear()
}
/**
* ============ sessionStorage ============
*/
export function setSessionStorage (name: string, value: any): void {
if (isEmpty(value)) return
window.sessionStorage.setItem(prefix + name, value)
}
export function getSessionStorage (name: string) {
window.sessionStorage.getItem(prefix + name)
}
export function removeSessionStorage (name: string) {
window.sessionStorage.removeItem(prefix + name)
}
/**
* 判断值是否为null或者undefined或者''或者'undefined'
* @param val value
*/
function isEmpty (val: any) {
if (isNil(val) || val === 'undefined' || val === '') {
return true
}
return false
}
> fetch
对`axios`进行二次封装，增加请求前后的拦截
import axios from 'axios'
/**
* 创建 axios 实例
*/
const service = axios.create({
timeout: 3000
})
/**
* req 拦截器
*/
service.interceptors.request.use((config: object): object => {
return config
}, (error: any): object => {
return Promise.reject(error)
})
/**
* res 拦截器
*/
service.interceptors.response.use((response: any) => {
const res = response.data
if (res.error) {
if (process.env.NODE_ENV !== 'production') {
console.error(res)
}
return Promise.reject(res)
}
return Promise.resolve(res)
})
export default service
> 请求参数统一处理
/**
* 统一参数处理
* 请求url处理
*/
const qs = require('qs')
import { merge, isPlainObject } from 'lodash'
import { getCookie } from '@/utils/cookies'
/**
* 接口参数拼接
* @param opts 接口参数
* @param opsIdParams 是否传递opsId
* @param requestType post 还是 get 参数处理
* @param otherParams 是否传有其它参数
* @example
* commonParams({
* 'method': cmdName.login,
* 'params': params
* }, false, undefined, false)
*/

export function commonParams (opts: object, opsIdParams: boolean= true, requestType: string= 'post', otherParams: boolean= true): object {

const params = {
json: JSON.stringify(merge({
id: new Date().getTime(),
jsonrpc: '2.0',
params: dealParams(opsIdParams, otherParams),
}, opts || {})),
}
return requestType === 'post' ? qs.stringify(params) : params
}
/**
* 请求接口的地址处理
* @param urlData 请求接口
* @param type 请求路径
* @example url(cmdName.login)
*/

export function url (urlData: string, type: any = process.env.VUE_APP_API_PATH) {

// @example https://example.com + agsgw/api/ + auth.agent.login
return process.env.VUE_APP_API_URL + type + urlData
}
/**
* params 参数的处理
* @param opsIdParams 是否传递opsId
* @param otherParams 是否传有其它参数
*/

function dealParams (opsIdParams: boolean, otherParams: boolean | object): object {

let obj: any = {}
// opsIdParams 默认传opsId
if (opsIdParams) {
obj.opsId = getCookie('token') || ''
}
// otherParams其他默认参数, 如sn
if (otherParams === true) {
// obj.sn = getCookie('switchSn') || ''
} else {
// 其他object
if (isPlainObject(otherParams)) {
obj = {...obj, ...otherParams}
}
}
return obj
}
> 接口名称单独作为一个文件
/**
* 后台接口名称
*/
const cmdName = {
login: 'auth.agent.login'
}
export default cmdName
> 组合文件
/**
* 组合请求http的请求
*/
import fetch from '@/utils/fetch'
import cmdName from './cmdName'
import { commonParams, url } from './commonParams'
export {
fetch,
cmdName,
commonParams,
url
}
> 导出的请求文件
import { fetch, cmdName, url, commonParams } from '@/api/common'
export function login (params: object) {
return fetch({
url: url(cmdName.login),
method: 'post',
data: commonParams({
method: cmdName.login,
params
})
})
}
> 使用接口方式
import * as API from '@/api/index'
API.login(params).then(res => {
})
**store改造**
`vuex`的作用：分离远程记录加载到本地存储（操作）和 检索从`store` 中的`getter`
![757ffb2c1f74e7131cebbb7dfad49db4.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/38c125826db6c550fadba4df864ebaba.png)

- 数据加载策略

- 细节/全局构造请求

- 导航响应

- 权限(配合router控制权限)

使用：

- 使用`module`形式

- 全局的一些操作，方法，放入`store`中，业务逻辑尽量少放，项目全局方法可以放入。例如：`cookie`, `global cache`

`action(异步)`: api的操作， 调用方式：`this.$store.dispatch(functionName, data)`
`mutations(同步)`: dom相关操作，方法名一般使用常量，
调用方式: `this.$store.commit(mutationsName, data)`
this.$store.getters[XXX] => this.$store.getters[namespaced/XXX]
this.$store.dispatch(XXX, {}) => this.$store.dispatch(namespaced/XXX, {})
this.$store.commit(XXX, {}) => this.$store.commit(namespaced/XXX, {})
组件内的Vue
<template>
<div>
<div>用户名：<input type="text" v-model="username" /></div>
<div>密码：<input type="password" v-model="passwd" /></div>
<div>{{computedMsg}}</div>
</div>
</template>
<script lang="ts">
import { Component, Prop, Vue, Provide } from 'vue-property-decorator'
// 引入组件
@Component({
components: {
// input
}
})
export default class Login extends Vue {
// data
@Provide() private username: string = ''
@Provide() private passwd: string = ''
// methods
login (u: string, p: string) {
}
// computed
get computedMsg () {
return 'username: ' + this.username
}
// life cycle
mounted () {
}
}
</script>
other

公用组件: `dateRange`, `pagination`, `icon-font`, `clock`, `proxyAutocomplete`, `dialog`

![e5d40e20ac67543a0d4b0b4b72deb8e9.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/499aca9b95603f4838fa1065e4ed638a.png)
全局注入
Vue.component(modal.name, modal) // dialog
Vue.component(pagination.name, pagination) // 分页
Vue.component(dateRange.name, dateRange) // 日期
Vue.component(proxyAutocomplete.name, proxyAutocomplete) // 远程模糊搜索
Vue.component(card.name, card) // el-tabs
Vue.component(tabLoad.name, tabLoad) // el-tabs
在`main.ts`中引入公用组件文件夹下的`useElement`
import '@/components/useElement'
> 一些问题
不能直接new

// 'new' expression, whose target lacks a construct signature, implicitly has an 'any' type.

// 不能直接new一个函数，通过重新as一个变量，或者new其原型的constructor 都可以解决
// const encodePsw = new Encode.prototype.constructor().encodePsw(this.passwd)
const E = Encode as any
const encodePsw = new E().encodePsw(this.passwd)
不能直接导入文件后再追加属性或方法
import * as filters from '@/filters/index'
// 全局filter
const F = filters as any
Object.keys(filters).forEach(item => {
Vue.filter(item, F[item])
})
declare var Chart: any;
@Component({
selector: 'my-component',
templateUrl: './my-component.component.html',
styleUrls: ['./my-component.component.scss']
})
export class MyComponent {
//you can use Chart now and compiler wont complain
private color = Chart.color;
}
vue.config.js
const path = require('path')
const debug = process.env.NODE_ENV !== 'production'
const VueConf = require('./src/assets/js/libs/vue_config_class')
const vueConf = new VueConf(process.argv)
module.exports = {
baseUrl: vueConf.baseUrl, // 根域上下文目录
outputDir: 'dist', // 构建输出目录
assetsDir: 'assets', // 静态资源目录 (js, css, img, fonts)
pages: vueConf.pages,
lintOnSave: true, // 是否开启eslint保存检测，有效值：ture | false | 'error'
runtimeCompiler: true, // 运行时版本是否需要编译
transpileDependencies: [], // 默认babel-loader忽略mode_modules，这里可增加例外的依赖包名
productionSourceMap: true, // 是否在构建生产包时生成 sourceMap 文件，false将提高构建速度
configureWebpack: config => { // webpack配置，值位对象时会合并配置，为方法时会改写配置
if (debug) { // 开发环境配置
config.devtool = 'cheap-module-eval-source-map'
} else { // 生产环境配置
}
Object.assign(config, { // 开发生产共同配置
resolve: {
alias: {
'@': path.resolve(__dirname, './src'),
'@c': path.resolve(__dirname, './src/components'),
'vue$': 'vue/dist/vue.esm.js'
}
}
})
},

chainWebpack: config => { // webpack链接API，用于生成和修改webapck配置，https://github.com/vuejs/vue-cli/blob/dev/docs/webpack.md

if (debug) {
// 本地开发配置
} else {
// 生产开发配置
}
},
css: { // 配置高于chainWebpack中关于css loader的配置
modules: true, // 是否开启支持‘foo.module.css'样式

extract: true, // 是否使用css分离插件 ExtractTextPlugin，采用独立样式文件载入，不采用<style>方式内联至html文件中

sourceMap: false, // 是否在构建样式地图，false将提高构建速度
loaderOptions: { // css预设器配置项
css: {
localIdentName: '[name]-[hash]',
camelCase: 'only'
},
stylus: {}
}
},
parallel: require('os').cpus().length > 1, // 构建时开启多进程处理babel编译
pluginOptions: { // 第三方插件配置
},

pwa: { // 单页插件相关配置 https://github.com/vuejs/vue-cli/tree/dev/packages/%40vue/cli-plugin-pwa

},
devServer: {
open: true,
host: '0.0.0.0',
port: 8080,
https: false,
hotOnly: false,
proxy: {
'/api': {
target: '<url>',
ws: true,
changOrigin: true
}
},
before: app => {}
}
}
以上就是本文的全部内容，希望对大家的学习有所帮助，也希望大家多多支持脚本之家。

#### 您可能感兴趣的文章:

- [详解基于vue-cli3.0如何构建功能完善的前端架子](https://m.jb51.net/article/148470.htm)
- [通过vue-cli3构建一个SSR应用程序的方法](https://m.jb51.net/article/147323.htm)
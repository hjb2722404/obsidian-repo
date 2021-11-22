AngularJS + Gulp → Webpack

# [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#AngularJS-Gulp-%E2%86%92-Webpack)AngularJS + Gulp → Webpack

![](https://i.imgur.com/fW5jyVi.png)

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E6%BA%90%E8%B5%B7)源起

目前有許多的舊專案，由於當年很潮人做了很潮的決定，使用了當時唯一首選 AngularJS。
也許種種原因，這個專案後來並沒有健康的跟著長大人與時俱進，到現在跑在 AngularJS 上。
也許是收得不夠所以不想幫專案更新？
也許是覺得大工程，所以接案不用這麼費力的更新這些？
也許，有太多的也許了…
但是這些也許在有一天就是要打破，混沌的世界將會有勇者來…不對。
這樣的專案累積下來的技術債，要評估你的專案生命週期是否還有維護價值，再決定是否要繼續之後的重構步驟。

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E6%8A%80%E8%A1%93%E4%B8%8A%E7%9A%84%E7%8F%BE%E6%B3%81)技術上的現況

目前網路上的 AngularJS 教學，還在教你使用 gulp 和 bower 來進行套件管理與網站相依性管理。也許可以使用 babel 讓你使用新一代的 ES 語法，但是這樣是遠遠不足時代的需求。

就連 [bower 都建議搬家，別再使用 bower 了](https://bower.io/blog/2017/how-to-migrate-away-from-bower/)

這篇來分享「如何將 AngularJS 放到 webpack 上」讓你的專案可以與時俱進，帶你經過困難的第一關!!!
經過這篇，你的 AngularJS 的工具使用如下:

- 套件管理器會使用 npm
- 網站打包工具使用 webpack

就如同現代前端框架的配備一樣先進呢!!!

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E7%94%A8-npm-%E5%AE%89%E8%A3%9D-AngularJS)用 npm 安裝 AngularJS

用 npm 安裝 AngularJS[[1]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn1)

在此要加上版號，限制只安裝 AngularJS (最後的版本是 1.7.x)
(安裝 AngularJS 1.5 以上的版本，才可以使用 Component 未來框架的重構會更現代化)

|     |
| --- |
| $ npm install --save-dev angular@1.7 |

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E5%8A%A0%E5%85%A5-Webpack)加入 Webpack

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E4%BA%86%E8%A7%A3%E5%8E%9F%E6%9C%AC-Gulp-%E7%9A%84%E9%81%8B%E4%BD%9C%E3%80%82)了解原本 Gulp 的運作。

先看看你自己的 Gulp 專案上的 task 怎麼設定的
在此，我手上的專案是將所有的 js 檔案串接成 all.js。(之後的 webpack 也是要做這件事)

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16 | var gulp = require('gulp');<br>var concat = require('gulp-concat');<br>var gulpLivereload = require('gulp-livereload');<br>gulp.task('all', () =><br>gulp<br>.src(['./js/**/*.js','./app.js'])<br>.pipe(concat('all.js'))<br>.pipe(gulp.dest('./'))<br>.pipe(gulpLivereload()));<br>gulp.task('watch', () => {<br>gulpLivereload.listen();<br>gulp.watch("./js/**/*.js", ["all"]);<br>gulp.watch("./app.js", ["all"]);<br>}) |

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E9%96%8B%E5%A7%8B-Webpack)開始 Webpack

安裝 webpack

|     |
| --- |
| $ npm install --save-dev webpack |

安裝 dev-server

|     |
| --- |
| $ npm install --save-dev webpack-dev-server |

**config**
在 webpack.config.js 中的 outputFileName 設定。
原本由 Gulp 將 `*.js` 編成 `all.js`
改成用 Webpack 編出 `all.js`

|     |
| --- |
| const path = require('path');<br>module.exports = {<br>entry: './entryFileName.js',<br>output: {<br>filename: 'outputFileName.js',<br>path: path.resolve(__dirname, '')<br>},<br>devServer: {<br>contentBase: './'<br>},<br>mode: "production"<br>}; |

然後開始 try-error 的看看頁面是不是有正常運作。
下面是我遇到的一些問題，提供當案例參考。

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E9%96%8B%E5%A7%8B%E4%B8%80%E4%B8%80%E8%A7%A3%E6%B1%BA%E5%95%8F%E9%A1%8C)開始一一解決問題

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E6%A8%A1%E7%B5%84%E7%9B%B8%E4%BE%9D%E9%A0%86%E5%BA%8F)模組相依順序

**主要是發生在這樣的 source code**

|     |     |
| --- | --- |
| 1   | angular.module('myApp', ['team']); |

彷彿 angular module 的中括號會失去作用
**瀏覽器 Console 的錯誤訊息**
Uncaught Error: [$injector:modulerr]
Failed to instantiate module myApp due to:
Error: [$injector:modulerr]
Failed to instantiate module team due to:
Error: [$injector:nomod]

Module ‘team’ is not available! You either misspelled the module name or forgot to load it. If registering a module ensure that you specify the dependencies as the second argument.

用 `require('path/controller')` 的相依性管理，將重新管理 `angular.module(name, [controller])` 裡的 `[controller]` 套件

重新整理整個 project 的 javascript 檔的相依關係。
(不知道要不要刪掉，確定完再來刪)
**example**

|     |
| --- |
| require('./module1'); // 增加這幾行<br>require('./module2'); // 增加這幾行<br>require('./module3'); // 增加這幾行<br>angular.module("module", ['module1', 'module2', 'module3']); |

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E7%AB%8B%E5%8D%B3%E6%99%82%E5%9F%B7%E8%A1%8C%E5%87%BD%E6%95%B8%E5%89%8D%E7%9A%84-require-%E8%A6%81%E5%8A%A0%E5%88%86%E8%99%9F)立即時執行函數前的 `require` 要加分號

錯誤訊息
Uncaught TypeError: __webpack_require__(…) is not a function
原本的寫法若是立即執行

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | (function() {<br> var app = angular.module("//...<br>//...<br>})(); |

前面加上 `require()` 後，要記得加分號 `;`

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7 | require('module1'); //沒問題<br>require('module1') //出問題<br>(function() {<br> var app = angular.module("//...<br>//...<br>})(); |

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#JS-%E5%A5%97%E4%BB%B6%E7%9B%B8%E4%BE%9D%E9%A0%86%E5%BA%8F)JS 套件相依順序

使用 bower 的套件要改用 npm 安裝。(注意版本)
原本使用 html script tag 的方式引入，都要改由 javascript 的 `require()` 的方式引入。

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#angular-route-%E5%A5%97%E4%BB%B6%E7%89%88%E6%9C%AC%E5%8C%B9%E9%85%8D%E5%95%8F%E9%A1%8C)angular-route 套件版本匹配問題

錯誤訊息
angular.js:15536 Possibly unhandled rejection: undefined

這是一個版本的問題，網路上教學建議使用下面的做法，是不好的[[2]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn2)

|     |
| --- |
| $qProvider.errorOnUnhandledRejections(false)。 |

這個問題是一個已被解決的 bug[[3]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn3)

**package.json**
原本

|     |
| --- |
| {<br> "angular": "^1.7.4",<br> "angular-route": "^1.5.7",<br>} |

angular-route 換新版

|     |
| --- |
| {<br> "angular": "^1.7.4",<br> "angular-route": "^1.5.11",<br>} |

> AngularJS 適用的 angular-route 版本最新就是 1.5.11

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#bootstrap-%E8%A6%81%E7%94%A8%E7%9A%84%E5%85%A8%E5%9F%9F-jQuery)bootstrap 要用的全域 jQuery

錯誤訊息
Uncaught ReferenceError: jQuery is not defined
發生在，把下面這段程式

|     |     |
| --- | --- |
| 1   | window.jQuery = require('jquery'); |

改成這樣

|     |     |
| --- | --- |
| 1<br>2 | import $ from  'jquery';<br>window.jQuery = $; |

解決方式[[4]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn4)

**webpack.config.js**

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9 | const webpack = require('webpack');<br>module.exports = {<br>plugins: [<br> new webpack.ProvidePlugin({<br> 'jQuery': 'jquery'<br>})<br>],<br>} |

在 config 加上這個可以宣告成全域變數 `window.jQuery`

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E4%BF%AE%E6%AD%A3-router)修正 router

網址是否樣子一樣？

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#angular-router-%E7%9A%84-hash-%E8%A8%AD%E5%AE%9A)angular-router 的 hash 設定

**原本的網址**

|     |
| --- |
| https://host.name/#/hash |

**出錯的網址**

|     |
| --- |
| https://host.name/#!/hash |

**解決方式**

加入 `$locationProvider` 處理網址[[5]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn5)

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | angular.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {<br>$locationProvider.hashPrefix('');<br> //...<br>}]) |

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#angular-route-%E5%A5%97%E4%BB%B6%E7%89%88%E6%9C%AC%E5%8C%B9%E9%85%8D%E5%95%8F%E9%A1%8C-v2)angular-route 套件版本匹配問題

錯誤訊息
angular.js:15536 Possibly unhandled rejection: undefined

這是一個版本的問題，網路上教學建議使用下面的做法，是不好的[[2:1]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn2)

|     |
| --- |
| $qProvider.errorOnUnhandledRejections(false)。 |

這個問題是一個已被解決的 bug[[3:1]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn3)

**package.json**
原本

|     |
| --- |
| {<br> "angular": "^1.7.4",<br> "angular-route": "^1.5.7",<br>} |

angular-route 換新版

|     |
| --- |
| {<br> "angular": "^1.7.4",<br> "angular-route": "^1.5.11",<br>} |

> AngularJS 適用的 angular-route 版本最新就是 1.5.11

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E6%A8%A1%E7%B5%84%E5%8A%83%E5%88%86)模組劃分

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#controller-component-%E7%9A%84-bindings-%E8%AE%8A%E6%95%B8%E5%88%9D%E5%A7%8B%E5%8C%96%E5%95%8F%E9%A1%8C)controller -> component 的 bindings 變數初始化問題

錯誤訊息
TypeError: Cannot read property ‘value’ of undefined

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15 | angular.module("dataTable", []).component("dTable", {<br> //...<br>controller: myController,<br>bindings: {<br>init: '<',<br> //...<br>},<br> //...<br>});<br>function  myController (/* ... */) {<br> //...<br> this.init.value //error<br> //...<br>} |

簡單的說就是 component 裡 `bindings` 的變數，並沒有在 controller function 的 `this` 裡。
**解決方式**
在 AngularJS 的 component 裡，`bindings` 的變數，必須要等 `$onInit` 時期，才會建構完成。

所以，有關 `bindings` 變數的操作都要放到 `$onInit` 裡~~，至於為什麼之前可以跑，我就不知道了~~，之前可以跑的原因，是因為 controller 並沒有 lifecycle 所以將 controller 這個 function 跑完就執行變數初始化。

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7 | function  myController (/* ... */) {<br> //...<br> this.$onInit = function () {<br> this.init.value<br>}<br> //...<br>} |

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E6%99%82%E9%96%93%E6%A0%BC%E5%BC%8F%E5%95%8F%E9%A1%8C)時間格式問題

https://stackoverflow.com/questions/30537886/error-ngmodeldatefmt-expected-2015-05-29t190616-693209z-to-be-a-date-a

原本就有的 bug 暫不處理

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#alasql-%E5%92%8C-xlsx-%E7%9A%84%E5%95%8F%E9%A1%8C)alasql 和 xlsx 的問題

這個問題，發生在已加上 alasql 套件相依的檔案上，而且還有使用 XLSX 的 alasql 語法。
錯誤訊息

|     |
| --- |
| angular.js:15536 Error: Please include the xlsx.js library<br>at getXLSX (alasql.js:4299)<br>at Object.alasql.into.XLSX (alasql.js:17035)<br>at alasql.Query.eval [as intoallfn] (eval at yy.Select.compile (alasql.js:NaN), <anonymous>:3:33)<br>at queryfn3 (alasql.js:7179)<br>at queryfn2 (alasql.js:6917)<br>at Object.eval [as datafn] (eval at <anonymous> (alasql.js:NaN), <anonymous>:3:57)<br>at eval (alasql.js:6865)<br>at Array.forEach (<anonymous>)<br>at queryfn (alasql.js:6861)<br>at statement (alasql.js:8009) "Possibly unhandled rejection: {}" |

要先知道， alasql 本來就有相依性於 xlsx
![](https://i.imgur.com/rcskWY0.png)
**alasql 本身有個 bug**
以 browser 執行環境為例!!
下面的 `getXLSX()` 一直都會 return `null`

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21 | var getXLSX = function() {<br> var XLSX = alasql["private"].externalXlsxLib;<br> if (XLSX) {<br> return XLSX;<br>}<br> if (utils.isNode \|\| utils.isBrowserify \|\| utils.isMeteorServer) {<br> /*not-for-browser/*<br>XLSX = require('xlsx') \|\| null;<br>//*/<br>} else {<br>XLSX = utils.global.XLSX \|\| null;<br>}<br> if (null === XLSX) {<br> throw  new  Error('Please include the xlsx.js library');<br>}<br> return XLSX;<br>}; |

這一段程式碼出了問題，所以造成無法順利運作
目前尚未有好的解決方案。

不過有找到臨時解決方式[[6]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn6)，我自己是以下面的步驟解決

**安裝**
如果要用 alasql + xlsx 的話，一定要另外自己安裝 xlsx 套件。

|     |
| --- |
| $ npm install --save alasql xlsx |

> 關於 xls 的套件，非常多。
> 有 xls, xlsjs, js-xlsx … 太多啦！這些是我誤以為而安裝上去的
**webpack.config.js**

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | resolve: {<br>alias: {<br> "@": path.resolve(__dirname, './')<br>}<br>} |

**using alasql 的檔案.js**

|     |
| --- |
| import alasql from  '@/alasql'; |

**/alasql/index.js**

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7 | import alasql from  'alasql';<br>import XLSX from  'xlsx';<br>alasql.utils.isBrowserify = false;<br>alasql.utils.global.XLSX = XLSX;<br>export  default alasql; |

重點是在使用時，強制設定。

|     |
| --- |
| alasql.utils.isBrowserify = false;<br>alasql.utils.global.XLSX = XLSX; |

只是我把它集中起來，要使用時，再宣告 `import alasql from '@/alasql';`

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#Webpack-%E7%B7%A8-prod-%E4%B8%8D%E6%9C%83%E5%8B%95-dev-%E6%AD%A3%E5%B8%B8)Webpack 編 prod 不會動, dev 正常

沒有錯誤訊息
**現象描述**
用 webpack 編譯 prod 之後，開啟頁面，發現從登入頁登入之後， menu 會改變，而 登入畫面不會被替換成其它的頁面內容。
**初判**
反反覆覆測試之後
1. menu 的顯示與否是用 API 回傳值控制 `ng-show`
2. 登入畫面內容，是由 `ngView` 渲染

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11 | <body><br> <!-- <ng-include src="'./partial/navbar.html'"></ng-include> --><br> <!-- ngInclude: --><br> <ng-include  src="'./partial/navbarByFunc.html'"  class="ng-scope"><br> <!-- menu --><br> </ng-include><br> <!-- ngView: --><br> <div  ng-view=""  class="ng-scope"><br> <!-- form --><br> </div><br></body> |

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E6%89%BE%E7%B7%9A%E7%B4%A2)找線索

懷疑過

- 是不是 webpack 的設定不正確
- 是不是 babel 的設定不正確，或者要加更多的套件？

當然，這就花了很多時間排除
在茫茫大海中，無意間改改下面這段程式碼…(沒錯！單純的只是基於操 code 看不順眼想修改)

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13 | angular.config(['$routeProvider', function($routeProvider){<br>$routeProvider.when('/',{/*...*/}) // 剛進網站 要進入登入頁<br> var originalWhen = $routeProvider.when;<br>$routeProvider.when = function(path, route) {<br> // 重新寫一個 when 並且呼叫原本的 when<br> return originalWhen.call($routeProvider, path, route);<br>};<br> /* other route*/<br>$routeProvider.when (/* ... */)<br> //...<br>}]); |

4~12 行可以和 29 行合併成這樣寫

|     |
| --- |
| $routeProvider.when (/* ... */).when().when()//... |

但是竟然改變了出錯的行為
**發現新線索**
開新的畫面，除了 menu 之外，畫面其它的地方都空白
仔細觀察發現 `ngView` 並沒有渲染任何東西。

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | <body><br> <!-- <ng-include src="'./partial/navbar.html'"></ng-include> --><br> <!-- ngInclude: --><br> <ng-include  src="'./partial/navbarByFunc.html'"  class="ng-scope"><br> <!-- menu --><br> </ng-include><br> <!-- ngView: --><br></body> |

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E6%95%B4%E7%90%86%E7%B7%9A%E7%B4%A2)整理線索

1. 發現從登入之後，登入畫面出錯(不會被替換成其它的頁面內容) -> 登入後，的 `ngView` 不渲染
2. 整理 route 的 code 出錯方式不同，原本是登入畫面的地方，變成一片空白 -> 發現 `ngView` 不渲染
route 出問題的機率很高。

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E6%AA%A2%E8%A6%96-route-%E5%8F%AF%E8%83%BD%E5%87%BA%E5%95%8F%E9%A1%8C%E7%9A%84%E5%9C%B0%E6%96%B9)檢視 route 可能出問題的地方

恢復這段程式成修改前的樣子。
**route.js**

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29 | angular.config(['$routeProvider', function($routeProvider){<br>$routeProvider.when('/', { //暫時放著<br>templateUrl: './../pages/login.html',<br>controller: 'loginController as Ctrl',<br>resolve: {<br>validateAuth: [<br> 'funcService',<br> function(funcService) {<br>funcService.validateAuth("/");<br>}<br>]<br>}<br>})<br> const originalWhen = $routeProvider.when;<br>$routeProvider.when = function(path, route) {<br>route.resolve \|\| (route.resolve = {});<br>angular.extend(route.resolve, {<br>validateAuth: function(funcService) {<br> return funcService.validateAuth();<br>}<br>});<br> return originalWhen.call($routeProvider, path, route);<br>};<br>$routeProvider.when('/default', {<br>templateUrl: '../pages/default.html'<br>})<br>}]); |

先看看 `$routeProvider` 的用法[[7]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn7) ，在此有一個 `resolve` 的進階用法，但是一般的範例的 `resolve` 用法如下[[8]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn8)

**網路上的範例**

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9 | $routeProvider.when("/news", {<br>templateUrl: "newsView.html",<br>controller: "newsController",<br>resolve: {<br>message: function(messageService){<br> return messageService.getMessage();<br>}<br>}<br>}) |

如同官網文件[[7:1]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn7)介紹，它是一個 object ，而且是記錄「為特定頁面載入前執行的程式碼」

前面覆寫的 `$routeProvider.when` 的情況也不知道是不是正確的，就先將這些 `resolve` 都註解掉。

### [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#Webpack-%E7%9A%84-prod-%E7%B7%A8%E5%87%BA%E4%BE%86%E7%9A%84-route-%E5%B0%B1%E6%9C%83%E5%8B%95%E4%BA%86)Webpack 的 prod 編出來的 route 就會動了

但是因為被註解掉的 code 沒有運作，所以網站沒有正常執行，但是 route 會其它頁面渲染出來了!!
這真是太振奮人心了!!
接下來就以語法的角度來觀察，這段 code 是在寫些什麼。
它是在換頁面之前，check 帳號的權限 …
好吧，看起來就是應該放在 route 的 hook 上。
不是什麼特例邏輯，而是每一頁都要執行的程式

AngularJS route 有供什麼 hook，在 AngularJS 裡，它叫 Event[[9]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn9)

它提供了這幾個

- $routeChangeStart
- $routeChangeSuccess
- $routeChangeError
- $routeUpdate

AngularJS 的文件沒有 `$routeChangeStart` 的範例程式，所以另外找了一下[[10]](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fn10)

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11 | angular.run(function($rootScope, $location) {<br>$rootScope.$on( "$routeChangeStart", function(event, next, current) {<br> if ($rootScope.loggedInUser == null) {<br> // no logged user, redirect to /login<br> if ( next.templateUrl === "partials/login.html") {<br>} else {<br>$location.path("/login");<br>}<br>}<br>});<br>}); |

將程式碼搬過去，宣告好。

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | angular.run(function($rootScope, $location, funcService) {<br>$rootScope.$on( "$routeChangeStart", function(event, next, current) {<br>funcService.validateAuth(next.originalPath);<br>});<br>}) |

route 就會是依設計上的正常運作。

## [¶](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#%E6%9C%80%E5%BE%8C)最後

成功 build 出 /dist 的檔案之後，就可以拔掉 gulp 了，剩下的就是設定 webpack 讓它功能正常運作。

* * *

1. [AngularJS 1.x系列：Node.js安装及npm常用命令（1）2.2 npm包管理, npm install：安装包](https://www.cnblogs.com/libingql/p/6910826.html)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref1)

2. [$q: Unhandled rejections should not be stringified #14631](https://github.com/angular/angular.js/issues/14631#issuecomment-267483102)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref2)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref2:1)

3. [1.6.1 promise-rectification (2016-12-23), Bug Fixes, $q: Add traceback to unhandled promise rejections (174cb4 #14631)](https://github.com/angular/angular.js/blob/v1.6.1/CHANGELOG.md)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref3)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref3:1)

4. [ProvidePlugin, Usage: jQuery - webpack](https://webpack.js.org/plugins/provide-plugin/#usage-jquery)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref4)

5. [Webpack with angular route configuration - browser has valid config, cant resolve file - Stack Overflow](https://stackoverflow.com/questions/48083126/webpack-with-angular-route-configuration-browser-has-valid-config-cant-resolv)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref5)

6. [Webpack, Browserify, Vue and React (Native)](https://github.com/agershun/alasql#vue)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref6)

7. [$routeProvider - AngularJS](https://docs.angularjs.org/api/ngRoute/provider/$routeProvider)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref7)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref7:1)

8. [Using Resolve In AngularJS Routes - Ode to Code](https://odetocode.com/blogs/scott/archive/2014/05/20/using-resolve-in-angularjs-routes.aspx)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref8)

9. [$route - AngularJS](https://docs.angularjs.org/api/ngRoute/service/$route)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref9)

10. [Listening on Route Changes to Implement a Login Mechanism Problem](https://fdietz.github.io/recipes-with-angular-js/urls-routing-and-partials/listening-on-route-changes-to-implement-a-login-mechanism.html)  [↩︎](https://dwatow.github.io/2018/12-06-angularjs/angularjs-with-webpack/#fnref10)
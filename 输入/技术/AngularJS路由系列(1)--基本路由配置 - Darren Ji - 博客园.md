AngularJS路由系列(1)--基本路由配置 - Darren Ji - 博客园

#   [AngularJS路由系列(1)--基本路由配置](https://www.cnblogs.com/darrenji/p/4981008.html)

本系列探寻AngularJS的路由机制，在WebStorm下开发。主要包括：

● [路由的Big Picture](https://www.cnblogs.com/darrenji/p/4981008.html#a)
● [$routeProvider配置路由](https://www.cnblogs.com/darrenji/p/4981008.html#b)
● [使用template属性](https://www.cnblogs.com/darrenji/p/4981008.html#c)
● [使用templateUrl属性](https://www.cnblogs.com/darrenji/p/4981008.html#d)
● [redirectTo属性，接受字符串](https://www.cnblogs.com/darrenji/p/4981008.html#e)
● [redirectTo属性，接受函数](https://www.cnblogs.com/darrenji/p/4981008.html#f)

● [使用caseInsensitiveMatch属性，禁止大小写敏感](https://www.cnblogs.com/darrenji/p/4981008.html#g)

● [使用otherwise属性](https://www.cnblogs.com/darrenji/p/4981008.html#h)

AngularJS路由系列包括：

1、[AngularJS路由系列(1)--基本路由配置](http://www.cnblogs.com/darrenji/p/4981008.html)

2、[AngularJS路由系列(2)--刷新、查看路由,路由事件和URL格式，获取路由参数，路由的Resolve](http://www.cnblogs.com/darrenji/p/4981505.html)

3、[AngularJS路由系列(3)-- UI-Router初体验](http://www.cnblogs.com/darrenji/p/4982446.html)

4、[AngularJS路由系列(4)-- UI-Router的$state服务、路由事件、获取路由参数](http://www.cnblogs.com/darrenji/p/4982480.html)

5、[AngularJS路由系列(5)-- UI-Router的路由约束、Resolve属性、路由附加数据、路由进入退出事件](http://www.cnblogs.com/darrenji/p/4982517.html)

6、[AngularJS路由系列(6)-- UI-Router的嵌套State](http://www.cnblogs.com/darrenji/p/4982533.html)

## 项目文件结构

node_modules/
public/
.....app/
..........bower_components/
...............toastr/
....................toastr.min.css
....................toastr.min.js
...............jquery/
....................dist/
.........................jquery.min.js
...............angular/
....................angular.min.js
...............angular-ui-router/
....................release/
.........................angular-ui-router.min.js
...............angular-route/
.........................angular-route.min.js
..........controllers/
...............HomeController.js
...............AllSchoolsController.js
...............AllClassroomsController.js
...............AllActivityiesController.js
...............ClassroomController.js
...............ClassroomSummaryController.js
...............ClassroomMessageController.js
..........css/
...............bootstrap.cerulean.min.css
..........filters/
...............activityMonthFilter.js
..........services/
...............dataServices.js
...............notifier.js
..........templates/
...............home.html
...............allSchools.html
...............allClassrooms.html
...............allActivities.html
...............classroom.html
...............classroomDetail.html
...............classroom_parent.html
..........app.js
.....index.html
.....favicon.ico
server/
.....data/
.....routes/
.....views/
.....helpers.js
package.json
server.js

## 安装Web Server

node server.js
Listening on port:3000

访问路径：localhost:3000/#/

## 获取ngRoute模块

bower install angular-route#1.4.0
或
npm install angular-route@1.4.0
或
http://ajax.googleapis.com/ajax/libs/angularjs/1.4.0/angular-route.js
或
https://code/angularjs.org/1.4.0/angular-route.js

如何使用呢？

在项目中引用angular-route.js,设置对ngRoute这个module的依赖(var app = angular.module('app',['ngRoute']))，在视图中添加ng-view这个directive(<div ng-view></div>)。

## Big Picture

在了解路由之前，有必要知道路由在整个AnuglarJS中所扮演的角色，如下：

![417212-20151120151944811-741551416.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173515.jpg)

## $routeProvider配置路由

![417212-20151120162929858-1905456995.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173519.png)

大致按如下配置：


(function(){ var app = angular.module('app',['ngRoute']);
app.config(['$routeProvider', function($routeProvider){
$routeProvider
.when('/',{
controller: 'HomeController',
contrllerAs: 'home',
templateUrl: 'app/templates/home.html' });
}])
}());


■ index.html


bootstrap.cerulean.min.css
toastr.min.css<!--Angular-->angular.min.js
angular-route.min.js<!--Application-->app.js<!--Services-->dataServices.js
notifier.js<!--Filters-->activityMonthFilter.js<!--Controls-->HomeController.js
AllSchoolsController.js
AllClassroomsController.js
AllActivityiesController.js
ClassroomController.js
ClassroomSummaryController.js

ClassroomMessageController.js<body ng-app="app">  <a href="#/">School Buddy</a>  <a href="#/schools">Schools</a>  <a href="#/classrooms">Classrooms</a>  <a href="#/activities">Activities</a>  <div ng-view></div></body>



## app.js，第一次添加路由，使用template属性


(function(){ var app = angular.module('app', ['ngRoute']);

app.config(['$logProvider','$routeProvider', function($logProvider,$routeProvider){

$logProvider.debugEnabled(true);
$routeProvider
.when('/',{
controller: 'HomeController' ,
controllerAs: 'home',
template: '<h1>This is an inline template</h1>' });
}]);
}());


![417212-20151120152216202-655100107.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173526.png)

## app.js,使用templateUrl属性


(function(){ var app = angular.module('app', ['ngRoute']);

app.config(['$logProvider','$routeProvider', function($logProvider,$routeProvider){

$logProvider.debugEnabled(true);
$routeProvider
.when('/',{
controller: 'HomeController' ,
controllerAs: 'home',
templateUrl: '/app/templates/home.html' });
}]);
}());


■ home.html
{{home.message}}
{{home.schoolCount}}
{{home.activityCount}}

![417212-20151120152337718-127705406.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173530.png)

■ app.js,添加更多的路由


(function(){ var app = angular.module('app', ['ngRoute']);

app.config(['$logProvider','$routeProvider', function($logProvider,$routeProvider){

$logProvider.debugEnabled(true);
$routeProvider
.when('/',{
controller: 'HomeController' ,
controllerAs: 'home',
templateUrl: '/app/templates/home.html' })
.when('/schools',{
controller: 'AllSchoolsController',
controllerAs: 'schools',
templateUrl: '/app/templates/allSchools.html' })
.when('/classrooms',{
controller: 'AllClassroomsController',
controllerAs: 'classrooms',
templateUrl: '/app/templates/allClassrooms.html' })
.when('/activities',{
controller: 'AllActivitiesController',
controllerAs: 'activities',
templateUrl: '/app/templates/allActivities.html' });
}]);
}());


点击导航栏上的Schools
![417212-20151120152453390-1367898829.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173536.png)

点击导航栏上的Classrooms
![417212-20151120152509280-498819291.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173540.png)

点击导航栏上的Activities
![417212-20151120152520265-976371892.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173546.png)

## app.js, 添加redirectTo属性,接受字符串

(function(){ var app = angular.module('app', ['ngRoute']);

app.config(['$logProvider','$routeProvider', function($logProvider,$routeProvider){

$logProvider.debugEnabled(true);
$routeProvider
.when('/',{
controller: 'HomeController' ,
controllerAs: 'home',
templateUrl: '/app/templates/home.html' })
.when('/schools',{
controller: 'AllSchoolsController',
controllerAs: 'schools',
templateUrl: '/app/templates/allSchools.html' })
.when('/classrooms',{
controller: 'AllClassroomsController',
controllerAs: 'classrooms',
templateUrl: '/app/templates/allClassrooms.html',
redirectTo: '/schools' })
.when('/activities',{
controller: 'AllActivitiesController',
controllerAs: 'activities',
templateUrl: '/app/templates/allActivities.html' });
}]);
}());


点击Classrooms导航到Schools下
![417212-20151120152621280-1886606863.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173552.png)

## app.js, 添加redirectTo,接受函数


(function(){ var app = angular.module('app', ['ngRoute']);

app.config(['$logProvider','$routeProvider', function($logProvider,$routeProvider){

$logProvider.debugEnabled(true);
$routeProvider
.when('/',{
controller: 'HomeController' ,
controllerAs: 'home',
templateUrl: '/app/templates/home.html' })
.when('/schools',{
controller: 'AllSchoolsController',
controllerAs: 'schools',
templateUrl: '/app/templates/allSchools.html' })
.when('/classrooms/:id',{
controller: 'AllClassroomsController',
controllerAs: 'classrooms',
templateUrl: '/app/templates/allClassrooms.html',
redirectTo: function(params, currPath, currSearch){
console.log(params);
console.log(currPath);
console.log(currSearch); return '/';
}
})
.when('/activities',{
controller: 'AllActivitiesController',
controllerAs: 'activities',
templateUrl: '/app/templates/allActivities.html' });
}]);
}());


在浏览器输入：localhost:3000/#/classrooms/1?foo=bar
![417212-20151120152707874-1922596411.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173558.png)

可见，路由参数1被放在了params中，是一个object对象；/classrooms/1被放在了currPath中；foo=bar查询字符串被放在了currSearch中了，是一个object对象。

## app.js, 禁止大小写敏感，使用caseInsensitiveMatch属性


(function(){ var app = angular.module('app', ['ngRoute']);

app.config(['$logProvider','$routeProvider', function($logProvider,$routeProvider){

$logProvider.debugEnabled(true);
$routeProvider
.when('/',{
controller: 'HomeController' ,
controllerAs: 'home',
templateUrl: '/app/templates/home.html' })
.when('/schools',{
controller: 'AllSchoolsController',
controllerAs: 'schools',
templateUrl: '/app/templates/allSchools.html',
caseInsensitiveMatch: true })
.when('/classrooms/:id',{
controller: 'AllClassroomsController',
controllerAs: 'classrooms',
templateUrl: '/app/templates/allClassrooms.html' })
.when('/activities',{
controller: 'AllActivitiesController',
controllerAs: 'activities',
templateUrl: '/app/templates/allActivities.html' });
}]);
}());


localhost:3000/#/schools和localhost:3000/#/SCHOOLS能得到相同的结果。

## app.js, 当用户输入的uri无效导航到默认页,使用otherwise属性


(function(){ var app = angular.module('app', ['ngRoute']);

app.config(['$logProvider','$routeProvider', function($logProvider,$routeProvider){

$logProvider.debugEnabled(true);
$routeProvider
.when('/',{
controller: 'HomeController' ,
controllerAs: 'home',
templateUrl: '/app/templates/home.html' })
.when('/schools',{
controller: 'AllSchoolsController',
controllerAs: 'schools',
templateUrl: '/app/templates/allSchools.html',
caseInsensitiveMatch: true })
.when('/classrooms/:id',{
controller: 'AllClassroomsController',
controllerAs: 'classrooms',
templateUrl: '/app/templates/allClassrooms.html' })
.when('/activities',{
controller: 'AllActivitiesController',
controllerAs: 'activities',
templateUrl: '/app/templates/allActivities.html' })
.otherwise('/');
}]);
}());


未完待续~~

分类: [AngularJS](https://www.cnblogs.com/darrenji/category/740401.html)

 [好文要顶](AngularJS路由系列(1)--基本路由配置%20-%20Darren%20Ji%20-%20博客园.md#)  [关注我](AngularJS路由系列(1)--基本路由配置%20-%20Darren%20Ji%20-%20博客园.md#)  [收藏该文](AngularJS路由系列(1)--基本路由配置%20-%20Darren%20Ji%20-%20博客园.md#)  

 [![20141213132343.png](../_resources/031b68394551c24eea6ed1d63aeaec5c.jpg)](https://home.cnblogs.com/u/darrenji/)

 [Darren Ji](https://home.cnblogs.com/u/darrenji/)
 [关注 - 21](https://home.cnblogs.com/u/darrenji/followees/)
 [粉丝 - 852](https://home.cnblogs.com/u/darrenji/followers/)

 [+加关注](AngularJS路由系列(1)--基本路由配置%20-%20Darren%20Ji%20-%20博客园.md#)

 1

 0

 [«](https://www.cnblogs.com/darrenji/p/4975383.html) 上一篇： [AngularJS如何编译和呈现页面](https://www.cnblogs.com/darrenji/p/4975383.html)

 [»](https://www.cnblogs.com/darrenji/p/4981505.html) 下一篇： [AngularJS路由系列(2)--刷新、查看路由,路由事件和URL格式，获取路由参数，路由的Resolve](https://www.cnblogs.com/darrenji/p/4981505.html)

posted @ 2015-11-20 15:46 [Darren Ji](https://www.cnblogs.com/darrenji/)  阅读(16895)  评论(1) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=4981008) [收藏](AngularJS路由系列(1)--基本路由配置%20-%20Darren%20Ji%20-%20博客园.md#)
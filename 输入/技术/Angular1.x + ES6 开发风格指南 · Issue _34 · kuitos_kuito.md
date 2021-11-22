Angular1.x + ES6 开发风格指南 · Issue #34 · kuitos/kuitos.github.io

## Angular1.x + ES6 开发风格指南

阅读本文之前，请确保自己已经读过民工叔的这篇blog [Angular 1.x和ES6的结合](https://github.com/xufei/blog/issues/29)

大概年初开始在我的忽悠下我厂启动了Angular1.x + ES6的切换准备工作，第一个试点项目是公司内部的[组件库](https://github.com/ShuyunFF2E/ccms-components)(另有[seed项目](https://github.com/kuitos/angular-es6-seed))。目前已经实施了三个多月，期间也包括一些其它新开产品的试点。中间也经历的一些痛苦及反复(组件库代码经历过几次调整，现在还在重构ing)，总结了一些经验分享给大家。(实际上民工叔的文章中提到了大部分实践指南，我这里尝试作一定整理及补充，包括一些自己的思考及解决方案)

开始之前务必再次明确一件事情，就是我们使用ES6来开发Angular1.x的目的。总结一下大概三点：
1. 框架的选型在这几年是很头痛的事情，你无法肯定某个框架会是终极解决方案。但是有一点毫无疑问，就是使用ES6来写业务代码是势在必行的。
2. 我们可以借助ES6的一些新的语法特性，更清晰的划分我们应用的层级及结构。典型的就是module跟class语法。

3. 同样的，在ES6语法的帮助下，我们能较容易的将数据层跟业务模型层实现成框架无关的，这能有效的提升整个应用的可移植性及演化能力。从另一方面讲，数据层跟业务模型能脱离view独立测试，是一个纯数据驱动的web应用应该具备的基本素质。

其中第1点是技术投资需要，第2、3点是架构需要。
我们先来看看要达到这些要求，具体要如何一步步实现。

#### Module

在ES6 module的帮助下，ng的模块机制就变成了纯粹的迎合框架的语法了。
实践准则就是：
1. 各业务层及数据层代码理想状态下应该看不出框架痕迹。
2. ng module最后作为一个壳子将所有的业务逻辑包装进框架内。
3. 每个ng module export出module name以便module之间相互引用。
example:

// moduleA.js import  angular  from  'angular';import  Controller  from  './Controller';export  default  angular.module('moduleA',  [])  .controller('AppController',  Controller)  .name;// moduleB.js 需要依赖module Aimport  angular  from  'angular';import  moduleA  from  './moduleA';angular.module('moduleB',  [moduleA]);

通过这种方式，无论被依赖的模块的模块名怎么改变都不会对其他模块造成影响。
> Best Practice

> index.js作为框架语法包装器生成angular module外壳，同时将module.name export出去。对于整个系统而言，理想状态下只有index.js中可以出现框架语法，其他地方应该是看不到框架痕迹的。

#### Controller

ng1.2版本开始提供了一个controllerAs语法，自此Controller终于能变成一个纯净的ViewModel（视图模型）了，而不是像之前一样混入过多的$scope痕迹(供angular框架使用)。

example

<div  ng-controller="AppCtrl as app">  <div  ng-bind="app.name"></div>  <button  ng-click="app.getName">get app name</button></div>

// Controller AppCtrl.jsexport  default  class  AppCtrl  {  constructor()  {  this.name  =  'angular&es6';  }  getName()  {  return  this.name;  }}

// moduleimport  AppCtrl  from  './AppCtrl';export  default  angular.module('app',  [])  .controller('AppCtrl',  AppCtrl)  .name;

这种方式写controller等同于ES5中这样去写：

function  AppCtrl()  {  this.name  =  'angular&es6';}AppCtrl.prototype.getName  =  function()  {  return  this.name;};.....controller('AppCtrl',  AppCtrl)

不过ES6的class语法糖会让整个过程更自然，再加上ES6 Module提供的模块化机制，业务逻辑会变得更清晰独立。
> Best Practice
> 在所有地方使用controllerAs语法，保证ViewModel(Controller)的纯净。

#### Component(Directive)

以datepicker组件为例
[object Object]

// DatePickerCtrl.jsexport  default  class  DatePickerCtrl  {  $onInit()  {  this.date  =  `${this.year}-${this.month}`;  }  getMonth()  { ... }  getYear()  { ... }}

注意，这里我们先写的controller而不是指令的link／compile方法，原因在于**一个数据驱动的组件体系下，我们应该尽量减少DOM操作，因此理想状态下，组件是不需要link或compile方法的，而且controller在语义上更贴合mvvm架构。**

// index.jsimport  template  from  './date-picker.tpl.html';import  controller  from  './DatePickerCtrl';const  ddo  =  {  restrict: 'E', template, controller,  controllerAs: '$ctrl',  bindToContrller: {  year: '=',  month: '='  }};export  default  angular.module('components.datePicker',  [])  .directive('datePicker',  ddo)  .name;

**注意，这里跟民工叔的做法有点不一样。**叔叔的做法是把指令做成class然后在index.js中import并初始化，like this:

// Directive.jsexport  default  class  Directive  {  constructor()  {  }  getXXX()  {  }}// index.jsimport  Directive  from  './Directive';export  default  angular.module('xxx',  [])  .directive('directive',  ()  =>  new  Directive())  .name;

**但是我的意见是，整个系统设计中index.js作为angular的包装器使得代码变成框架可识别的，换句话说就是只有index.js中是可以出现框架的影子的，其他地方都应该是框架无关的使用原生代码编写的业务模型。**

1.5之后提供了一个新的语法[object Object]，它是[object Object]的高级封装版，提供了更语义更简洁的语法，同时也是为了顺应基于组件的应用架构的趋势(之前也能做只是语法稍啰嗦且官方没有给出best practice导向)。比如上面的例子用component语法重写的话：

// index.jsimport  template  from  './date-picker.tpl.html';import  controller  from  './DatePickerCtrl';const  ddo  =  { template, controller,  bindings: {  year: '=',  month: '='  }};export  default  angular.module('components.datePicker',  [])  .component('datePicker',  ddo)  .name;

component语义更简洁明了，比如 [object Object] -> [object Object]的变化，而且默认[object Object]。还有一个重要的差异点就是，component语法只能定义自定义标签，不能定义增强属性，而且component定义的组件都是isolated scope。

另外angular1.5版本有一个大招就是，它给组件定义了相对完整的生命周期钩子(虽然之前我们能用其他的一些手段来模拟init到destroy的钩子，但是实现的方式框架痕迹太重，后面会详细讲到)！而且提供了单向数据流实现方式！

example

// DirectiveController.jsexport  class  DirectiveController  {  $onInit()  {  }  $onChanges(changesObj)  {  }  $onDestroy()  {  }  $postLink()  {  }}// index.jsimport  template  from  './date-picker.tpl.html';import  controller  from  './DatePickerCtrl';const  ddo  =  { template, controller,  bindings: {  year: '<',  month: '<'  }};export  default  angular.module('components.datePicker',  [])  .component('datePicker',  ddo)  .name;

component相关详细看这里：[angular component guide](https://docs.angularjs.org/guide/component)

从angular的这些api变化来看，ng的开发团队正在越来越多的吸取了一些其他社区的思路，这也从侧面上印证了前端框架正在趋于同质化的事实(至少在同类型问题领域，方案趋于同质)。顺带帮vue打个广告，不论是进化速度还是方案落地速度，vue都已经赶超angular了。推荐大家都去关注下vue。

> Best Practice

> 在场景符合(只要你的指令是可以作为自定义标签存在就算符合)的情况下都应该用component语法，在$onInit回调中做初始化处理(而不是constructor，原因见下文)，$onDestroy中作组件销毁回调。没有link方法，只有组件Controller(ViewModel).这样能帮助你从component-base的应用架构方向去思考问题。

> Deprecation warning: although bindings for non-ES6 class controllers are currently bound to this before the controller constructor is called, this use is now deprecated. Please place initialization code that relies upon bindings inside a $onInit method on the controller, instead.

#### Service、Filter

##### 自定义服务 provider、service、factory、constant、value

angular1.x中有五种不同类型的服务定义方式，但是如果我们以功能归类，大概可以归出两种类型：
1. 工具类／工具方法
2. 一些应用级别的常量或存储单元

angular原本设计service的目的是提供一个应用级别的共享单元，单例且私有，也就是只能在框架内部使用(通过依赖注入)。在ES5的无模块化系统下，这是一个很好的设计，但是它的问题也同样明显：

1. 随着系统代码量的增长，出现服务重名的几率会越来越大。
2. 查找一个服务的定义代码比较困难，尤其是一个多人开发的集成系统(当然你也可以把原因归咎于 编辑器/IDE 不够强大)。
很显然，ES6 Module并不会出现这些问题。举例说明，我们之前使用一个服务是这样的：
index.js

import  angular  from  'angular';import  Service  from  './Service';import  Controller  from  './Controller';export  default  angular.module('services',  [])  .service('service',  Service)  .controller('controller',  Controller)  .name;

Service.js
export  default  class  Service  {  getName()  {  return  'kuitos';  }}

Controller.js 这里使用了工具库[angular-es-utils](https://github.com/kuitos/angular-es-utils)来简化ES6中使用依赖注入的方式。

import  {Inject}  from  'angular-es-utils/decorators';@Inject('service')export  default  class  Controller  {  getUserName()  {  return  this._service.getName();  }}

假如哪天在调用controller.getUserName()时报错了，而且错误出在service.getName方法，那么查错的方式是？我是只能全局搜了不知道你们有没有更好的办法。。。

如果我们使用依赖注入，直接基于ES6 Module来做，改造一下会变成这样：
Service.js
export  default  {  getName()  {  return  'kuitos';  }}
Controller.js

import  Service  from  './Service';export  default  class  Controller  {  getUserName()  {  return  Service.getName();  }}

这样定位问题是不是容易很多！！
从这个案例上来看，我们能完美模拟基础的 Service、Factory 了，那么还有Provider、Constant、Value呢？

Provider跟Service、Factory差异在于Provider在ng启动阶段可配置，脱离ng使用ES6 Module的方式，服务之间其实没什么区别。。。:

Provider.js

let  apiPrefix  =  '';export  function  setPrefix(prefix)  {  apiPrefix  =  prefix;}export  function  genResource(url)  {  return  resource(apiPrefix  +  url);}

应用入口时配置：
app.js
import  {setPrefix}  from  './Provider';setPrefix('/rest/1.0');
Contant跟Value呢？其实如果我们忘掉angular，它们倆完全没区别：
Constant.js
export  const  VERSION  =  '1.0.0';

##### 使用ng内置服务

上面我们提到我们所有的服务其实都可以脱离angular来写以消除依赖注入，但是有一种状况比较难搞，就是假如我们自定义的工具方法中需要使用到angular的built-in服务怎么办？要获取ng内置服务我们就绕不开依赖注入。但是好在angular有一个核心服务[object Object]，通过它我们可以获取任何应用内的服务(Service、Factory、Value、Constant)。但是[object Object]也是ng内置的服务啊，我们如何避开依赖注入获取它？我封装了个小工具可以做这个事：

import  injector  from  'angular-es-utils/injector';export  default  {  getUserName()  {  return  injector.get('$http').get('/users/kuitos');  }};

这样做确实可以但总觉得不够优雅，不过好在大部分场景下我们需要用到built-in service的场景比较少，而且对于[object Object]这类基础服务，调用者不应该直接去用，而是提供一个更高级的封装出去，对调用着而言内部使用的技术是透明，可以是[object Object]也可以是[object Object]或者whatever。

import  injector  from  'angular-es-utils/injector';import  {FetchHttp}  from  'es6-http-utils';export  const  HttpClient  {  get(url)  {  return  injector.get('$http').get(url);  }  save(url,  payload)  {  return  FetchHttp.post(url,  payload);  }}// Controller.jsimport  {HttpClient}  from  './HttpClient';class  Controller  {  saveUser(user)  {  HttpClient.save('/users',  user);  }}

通过这些手段，对于业务代码而言基本上是看不到依赖注入的影子的。

##### Filter

angular中filter做的事情有两类：过滤和格式化。归结起来它做的就是一种数据变换的工作。filter的问题不仅仅在于DI的弊端，还有更多其他的问题。vue2中甚至取消了filter的设计，参见[[Suggestion]Vue 2.0 - Bring back filters please](https://github.com/vuejs/vue/issues/2756#issuecomment-215503966)。其中有一点我特别认可：过度使用filter会让你的代码在不自知的情况下走向混乱的状态。我们可以自己去写一系列的transformer(或者使用underscore之类的工具)来做数据处理，并在vm中显式的调用它。

import  {dateFormatter}  from  './transformers';export  default  class  Controller  {  constructor()  {  this.data  =  [1,2,3,4];  this.currency  =  this.data  .filter(v  =>  v  <  4)  .map(v  =>  '$'  +  v);  this.date  =  Date.now();  this.today  =  dateFormatter(this.date);  }}

> Best Practice

> 理想状态下，Service & Filter的语法在一个不需要跟其他系统共享代码单元的业务系统里是完全可以抹除掉的，我们完全通过ES6 Module来代替依赖注入。同时，对于一些基础服务，如[object Object]> 、[object Object]> 之类的，我们最好能提供更上层的封装，确保业务代码不会直接接触到built-in service。

#### 一步步淡化框架概念

如果想将业务模型彻底从框架中抽离出来，下面这几件事情是必须解决的。

##### 依赖注入

前面提到过，通过一系列手段我们可以最大程度消除依赖注入。但是总有那些edge case，比如我们要用$stateParams或者服务来自路由配置中注入的local service。我写了一个工具可以帮助我们更舒服的应对这类边缘案例 [Link to Controller](https://github.com/kuitos/kuitos.github.io/issues/34#Controller)

##### 依赖属性计算

对于需要监控属性变化的场景，之前我们都是用[object Object]，但是这又跟框架耦合了。民工叔的文章里提供了一个基于accessor的写法：

class  Controller  {  get  fullName()  {  return  `${this.firstName}  ${this.lastName}`;  }}

template

<input  type="text" ng-model="$ctrl.firstName"><input  type="text" ng-model="$ctrl.lastName"><span  ng-bind="$ctrl.fullName"></span>

这样当firstName／lastName发生变化时，fullName也会相应的改变。基于的原理是[object Object]。但是民工叔也指出了一个由于某种不知名的原因导致绑定失效，不得不用$watch的场景。这个时候[object Object]就派上用场了。但是[object Object]回调有个限制就是，它的变更检测时基于reference的而不是值的内容的，也就是说绑定primitive没问题，但是绑定引用类型(Object/Array等)那么内容的变化并不会被捕获到，例如：

class  Controller  {  $onChanges(objs)  {  this.userCount  =  objs.users.length;  }}const  ddo  =  {  controller: Controller,  template: '<span ng-bind="$ctrl.listTitle"></span><span ng-bind="$ctrl.userCount"></span>'  bindings: {  title: '<',  users: '<'  }};angular.module('component',  [])  .component('userList',  ddo);

template

<div  ng-controller="ctrl as app">  <user-list  title="app.title" users="app.users" ng-click="app.change()"></user-list></div>

class  Controller  {  contructor()  {  this.title  =  'hhhh';  this.users  =  [];  }  change()  {  this.users.push('s');  }}angular.module('app',  [])  .controller('ctrl',  Controller);

点击user－list组件时，userCount值并不会变化，因为[object Object]并没有被触发。对于这种情况呢，你可能需要引入immutable方案了。。。怎么感觉事情越来越复杂了。。。

##### 组件生命周期

组件新增的四个生命周期对于我而言可以说是最重大的变化了。虽然之前我们也能通过一些手段来模拟生命周期：比如用compile模拟init，postLink模拟didMounted，[object Object]模拟unmounted。

但是它们最大的问题就是身上携带了太多框架的气息，并不能服务文明剥离框架的初衷。具体做法不赘述了，看上面组件部分的介绍[Link To Component](https://github.com/kuitos/kuitos.github.io/issues/34#Component%28Directive%29).

##### 事件通知

以前我们在ng中使用事件模型有 [object Object]、[object Object]、[object Object]这几个api用，现在没了它们我们要怎么玩？

我的建议是，我们只在必要的场景使用事件机制，因为事件滥用和不及时的卸载很容易造成事件爆炸的情况发生。必要的场景就是，当我们需要在兄弟节点、或依赖关系不大的组件间触发式通信时，我们可以使用自制的 事件总线/中介者 来帮我们完成(可以使用我的这个工具库[angular-es-utils/EventBus](https://github.com/kuitos/angular-es-utils))。在非必要的场景下，我们应该尽量使用[object Object]的方式来达成通信目标：

const  ddo  =  {  template: '<button type="button" ng-click="$ctrl.change('kuitos')">click me</button>',  controller: class  {  click(userName)  {  this.onClick({userName});  }  },  bindings: {  onClick: '&'  }};angular.module('app',  [])  .component('user',  ddp);

useage
<user  on-click="logUserName(userName)"></user>

#### 总结

理想状态下，对于一个业务系统而言，会用到angular语法只有 [object Object]、[object Object]、[object Object]这几种。其他地方我们都可以实现成框架无关的。

对于web app架构而言，angular/vue/react 等组件框架/库 提供的只是 模板语法&胶水语法（其中胶水语法指的是框架/库 定义组件／控制器 的语法），剥离这两个外壳，我们的业务模型及数据模型应该是可以脱离框架运作的。古者有云，衡量一个完美的MV*架构的标准就是，在V随意变化的情况下，你的M＊是可以不改一行代码的情况下就完成迁移的。

在MV_架构中，V层是最薄且最易变的，但是M_理应是 稳定且纯净的。虽然要做到一行代码不改实现框架的迁移是不可能的(视图层&胶水语法的修改不可避免)，但是我们可以尽量将最重的 M* 做成框架无关，这样做上层的迁移时剩下的就是一些语法替换的工作了，而且对V层的改变也是代价最小的。

事实上我认为一个真正可伸缩的系统架构都应该是这样一个思路：勿论是 MV* 还是 Flux/Redux or whatever，确保下层 业务模型／数据模型 的纯净都是有必要的，这样才能提供上层随意变化的可能，任何模式下的应用开发，都应该具备这样的一个能力。
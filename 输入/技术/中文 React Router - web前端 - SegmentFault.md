中文 React Router - web前端 - SegmentFault

# React/Router

## 文档已废弃，关闭更新，详情请往 [这里：](https://github.com/rackt/react-router)

React Router 一个针对React而设计的路由解决方案、可以友好的帮你解决React components 到URl之间的同步映射关系。

## 概览

在阐明React Router可以帮你解决的问题之前我们来举一个没有引用React Router 的简单例子。
**没使用 React Router**

	var About = React.createClass({
	  render: function () {
	    return <h2>About</h2>;
	  }
	});

	var Inbox = React.createClass({
	  render: function () {
	    return <h2>Inbox</h2>;
	  }
	});

	var Home = React.createClass({
	  render: function () {
	    return <h2>Home</h2>;
	  }
	});

	var App = React.createClass({
	  render () {
	    var Child;
	    switch (this.props.route) {
	      case 'about': Child = About; break;
	      case 'inbox': Child = Inbox; break;
	      default:      Child = Home;
	    }

	    return (
	      <div>
	        <h1>App</h1>
	        <Child/>
	      </div>
	    )
	  }
	});

	function render () {
	  var route = window.location.hash.substr(1);
	  React.render(<App route={route} />, document.body);
	}

	window.addEventListener('hashchange', render);
	render(); // render initially

在hash值改变的时候，`App` 将会根据this.props.route 值的改变来动态渲染 `<Child/>` component。
这样子的做法看起来很直接，但是这也会让整个应用程序变得更加复杂。

我们可以想想，如果组件 `Inbox` 有一些内嵌的子组件需要根据 例如 `inbox/message/:id` 或者 `inbox/unread` 等这样的路由规则做动态渲染的时候。我们需要一些更加智能的手段来把路由信息传递给我们的App，这样`Inbox` 组件可以根据URL的映射关系来控制哪些子组件应该需要被渲染。我们的很多组件应该根据URL的规则来做动态渲染。在不使用路由规则的前提下，复杂一点的路由需求就需要我们写很多条件判断的代码去去解决实RL和层级组件的同步问题。

**引入路由**

解决复杂的URL和层级组件之间的映射关系式React Router 的核心。我们使用声明式的方式为我们举的例子引入路由。我们使用JSX的方式来进行路由的配置，这样我们可以通过属性的方式来配置页面视图的层级关系。先来看看路由的配置

	var Router = require('react-router');
	var Route = Router.Route;

	*// declare our routes and their hierarchy*
	var routes = (
	  <Route handler={App}>
	    <Route path="about" handler={About}/>
	    <Route path="inbox" handler={Inbox}/>
	  </Route>
	);

我们删除掉一些在组件内判断路由逻辑的代码。然后用`<RouteHandle/>` 替换 `<Child/>`.然后代码变成下面这个样子。

	var RouteHandler = Router.RouteHandler;

	var App = React.createClass({
	  render () {
	    return (
	      <div>
	        <h1>App</h1>
	        <RouteHandler/>
	      </div>
	    )
	  }
	});

最后我们需要监听url的变化来动态渲染应用，加入下面的代码。

	  Router.run(routes, Router.HashLocation, (Root) => {
	  React.render(<Root/>, document.body);
	});

`Root` 是 React Router 路由匹配后决定渲染的最高层级的组件，告诉 `RouterHandle` 应该渲染的内容是什么。
`<Router/>` 组件是不会被渲染的。只是一个创建内部路由规则的配置对象。
接下来我们为应用添加更多的UI组件

现在我们计划给Inbox UI 添加Inbox message 子组件。首先我们需要添加一个新的`Message`组件。然后我们在原有的inbox路由下面为 `Message` 组件添加新的路由，这样就可以得到嵌套的UI。

	var Message = React.createClass({
	  render () {
	    return <h3>Message</h3>;
	  }
	});

	var routes = (
	  <Route handler={App}>
	    <Route path="about" handler={About}/>
	    <Route path="inbox" handler={Inbox}>
	      <Route path="messages/:id" handler={Message}/>
	    </Route>
	  </Route>
	);

现在我们访问 `inbox/message/jKei3c32`c的URL就可以匹配到新的路由规则并可以匹配到`App->Inbox->Message` 这个分支下的UI。

获取url的参数

我们需要获取到一些Url的信息，这样我们可以根据这些参数从服务器端获取数据。我们把交给`<Route/>`匹配好的组件称为`RouterHandler`. `RouterHandler` 实例可以获取到一些非常有用的属性当你渲染组件的时候。特别是一些从URL动态获取的参数信息。比如在我们举例中得 ` :id`

	var Message = React.createClass({
	  componentDidMount: function () {
	    *// from the path `/inbox/messages/:id`*
	    var id = this.props.params.id;
	    fetchMessage(id, function (err, message) {
	      this.setState({ message: message });
	    })
	  },
	  *// ...*
	});

嵌套的UI和多层级的URLs是 不需要耦合的。有了React Router，我们不需要用嵌套UI的方式来对应多层级的URL。反过来，获取嵌套组件的UI，我们也不需要有多层级的URL与它对应。

比如说我们有/about/company 这样的URL，我们不需要嵌套UI组件到About组件中。

	var routes = (
	  <Route handler={App}>
	    <Route path="about" handler={About}/>
	    <Route path="about/company" handler={Company}/>
	  </Route>
	);

虽然说我们的URL是有层级嵌套的，但是我们UI组件中得 `About` 组件和 `Company` 组件却可以是相邻展平在同级目录的。

现在让我们往路由中添加url `/archive/messages/:id` 然后让该路由嵌套到inbox UI里面，即使 这个URL不跟上层 Router 的URL 嵌套。我们需要做三件事让匹配下面规则的路由正常工作。

1、url 要以 `/` 这样的绝对路径开头，这代表不会从父路由继承路由规则。
2、嵌套在Inbox route 中的router 会导致UI组件的层级嵌套。
3、确定你已经有必需的动态URL片段，在这里我们只有 :id ,所以处理起来相当简单。

	var routes = (
	  <Route handler={App}>
	    <Route path="inbox" handler={Inbox}>
	      <Route path="messages/:id" handler={Message}/>
	      <Route path="/archive/messages/:id" handler={Message}/>
	    </Route>
	  </Route>
	);

这就是React Router的核心，应用的UI组件是层层嵌套的。现在我们可以让这些嵌套的UI组件和URL规则保持同步了。

# Route 配置

## DefaultRoute

一个`RefaultRoute` 是一个已匹配父组件会默认展示的子组件。
你期望在没有子组件被匹配的时候一个子RouterHandler总是能够渲染到页面。
**Props**
`handle`
`RouterHandler` 是你需要渲染到页面的匹配规则的组件
`name` (可选)
当你使用linking 和 transitioning 的路由名字
**举例**

	<Route path="/" handler={App}>

	  *<!--
	    When the url is `/`, this route will be active. In other
	    words, `Home` will be the `<RouteHandler/>` in `App`.
	  -->*
	  <DefaultRoute handler={Home}/>

	  <Route name="about" handler={About}/>
	  <Route name="users" handler={Users}>
	    <Route name="user" handler={User} path="/user/:id"/>

	    *<!-- when the url is `/users`, this will be active -->*
	    <DefaultRoute name="users-index" handler={UsersIndex}/>

	  </Route>
	</Route>

## NotFoundRoute

`NotFoundRoute` 会在父组件匹配成功但没有一个同级组件被匹配的时候会被激活。
你可以使用它来处理不合法的链接。
**提示**

`NotFoundRoute`不是针对当资源没有被找到而设计的。路由没有匹配到特定的URL和通过一个合法的URL没有查找到资源是有却别的。url `course/123` 是一个合法的url并能够匹配到对应的路由，所以它是找到了的意思。但是通过123 去匹配资源的时候却没有找到，这个时候我们并不像跳转到一个新的路由，我们可以设置不同的状态来选软不同的UI组件，而不是通过`NotFoundRoute` 来解决。

**props**
`handler`
`RouterHandler` 是你需要渲染到页面的匹配规则的组件
举例

	<Route path="/" handler={App}>
	  <Route name="course" path="course/:courseId" handler={Course}>
	    <Route name="course-dashboard" path="dashboard" handler={Dashboard}/>

	    *<!-- ie: `/course/123/foo` -->*
	    <NotFoundRoute handler={CourseRouteNotFound} />
	  </Route>

	  *<!-- ie: `/flkjasdf` -->*
	  <NotFoundRoute handler={NotFound} />
	</Route>

最后一个 `NotFoundRoute` 将会渲染到 `APP` 内。 第一个将会被渲染到Course 内。

## Redirect

`Recirect` 可以跳转到另外一个路由中。
**props**
`from`
你想开始redirect的地址，包括一些动态的地址。默认为`*` ,这样任何匹配不到路由规则的情况多回被重定向到另外一个地方。
`to`
你想要重定向到得路由名字。
`params`
默认情况下，这些参数将会自动传递到新的路由，你也可以指定他们，特别是你不需要的时候。
`query`
和`params`一样
举例

	<!--
	  lets say we want to change from `/profile/123` to `/about/123`
	  and redirect `/get-in-touch` to `/contact`
	-->
	<Route handler={App}>
	  <Route name="contact" handler={Contact}/>
	  <Route name="about-user" path="about/:userId" handler={UserProfile}/>
	  <Route name="course" path="course/:courseId">
	    <Route name="course-dashboard" path="dashboard" handler={Dashboard}/>
	    <Route name="course-assignments" path="assignments" handler={Assignments}/>
	  </Route>

	  *<!-- `/get-in-touch` -> `/contact` -->*
	  <Redirect from="get-in-touch" to="contact" />

	  *<!-- `/profile/123` -> `/about/123` -->*
	  <Redirect from="profile/:userId" to="about-user" />

	  *<!-- `/profile/me` -> `/about-user/123` -->*
	  <Redirect from="profile/me" to="about-user" params={{userId: SESSION.USER_ID}} />
	</Route>

`<Redirect>` 能够被放置到路由的任何层级。如果你选择把它放在路由某一层级的下方，那么`from`路径也会匹配到它上层的路径。

## Route

`Route` 用于声明式地映射路由规则到你多层嵌套的应用组件。
**props**
`name`(可选)
name 在路由中是唯一的，被使用在 `Link` 组件和路由转换的方法中。
`path`(optional)
在url中使用的路径，如果不填写的话，路径就是name，如果name也没有的话，默认就是 `/`.
`handler`
当路由被匹配的时候会被 `RouteHander` 渲染的组件。
`children`
路由是可以嵌套的，如果子路由的路径被匹配，那么父路由也处于激活状态。
`ignoreScrollBehavior`

当路由或者路由的`params` 改变的时候，路由会根据`scrollBehavior` 来调整页面滚动条的位置。但是 你也可以不选择这项功能，特别是在一些搜索页面或者是 tab切换的页面。

# Top-Level

## Router.create

创建一个新的路由。
**Signature**
`Router.create(options) `
**Options**
`routes`
`location`
`scrollBehavior`
`onAbort`
Used server-side to know when a route was redirected.
**Method**
`run(callback) `
启动路由，和`Router.run` 一样
**举例**

	*// the more common API is*
	Router.run(routes, Router.HistoryLocation, callback);

	*// which is just a shortcut for*
	var router = Router.create({
	  routes: routes,
	  location: Router.HistoryLocation
	});

	router.run(callback);

## Router.run

The main API into react router. It runs your routes, matching them against a location, and then calls back with the next state for you to render.

**signature**
`Router.run(routes,[location,],callback)`
参数
`routes`
`location` (可选)

默认值是`Router.HashLocation` 如果你设置了`Location` 那么它的改变会被监听。如果你设置了一个字符路劲，那么路由会立即匹配并执行回调函数。

举例

	*// Defaults to `Router.HashLocation`*
	*// callback is called whenever the hash changes*
	Router.run(routes, callback);

	*// HTML5 History*
	*// callback is called when history events happen*
	Router.run(routes, Router.HistoryLocation, callback);

	*// Server rendering*
	*// callback is called once, immediately.*
	Router.run(routes, '/some/path', callback);

`callback(Root,state)`
回调函数接收两个参数
1、 `Root`
2、 `state`
`Root`
是一个包含了所有匹配组件的一个组件，它用来渲染你的组件。
`state`
一个包含了匹配状态的对象。
`state.path`
带有查询参数的当前URL
`state.action`
一个触发路由改变的操作
`state.pathname`
不带查询参数的URL
`state.params`
当前被激活路由匹配路径对应的参数 如 `/:id` 对应的id值.
`state.query`
当前被激活路由匹配路径对应的查询参数
`state.routes`
包含了匹配路由的数组，在组件渲染之前获取数据会显得很有帮助。

可以查看 `example`  [async-data](https://github.com/rackt/react-router/blob/master/examples/async-data/app.js)

**举例**
基本用法
`javascript`
Router.run(routes, function (Root) {
// whenever the url changes, this callback is called again
React.render(<Root/>, document.body);
});
var resolveHash = require('when/keys').all;
var SampleHandler = React.createClass({ statics: {

	*// this is going to be called in the `run` callback*
	fetchData: function (params) {
	  return fetchStuff(params);
	}

},
// ...
});
Router.run(routes, Router.HistoryLocation, function (Root, state) {

// create the promises hash var promises = state.routes.filter(function (route) {

	*// gather up the handlers that have a static `fetchData` method*
	return route.handler.fetchData;

}).reduce(function (promises, route) {

	*// reduce to a hash of `key:promise`*
	promises[route.name] = route.handler.fetchData(state.params);
	return promises;

}, {});
resolveHash(promises).then(function (data) {

	// wait until we have data to render, the old screen stays up until
	// we render
	React.render(<Root data={data}/>, document.body);

});});

something.serve(function (req, res) { Router.run(routes, req.path, function (Root, state) {

	*// could fetch data like in the previous example*
	fetchData(state.matches).then(function (data) {
	  var html = React.renderToString(<Root data={data} />);
	  res.send(html);
	});

});});

	*#Components*

	*##Link*
	用于在应用程序中导航的一种主要方式。``Link``将会渲染出标签属性href 变得容易被理解。
	当``Link``定位的路由被激活的时候自动 显示为 定义的 ``activeClassName`` 和/或者
	``activeStyle`` 定义的样式。

	**Props**
	``to``
	要被定位到的路由名字，或者是完整的路径

	``params``

	包含了名字/值的对象，和路由地址的动态段对应一致。

	``query``

	一个包含名字/值 的对象，它会成为地址中的查询参数

	**举例**

// given a route config like this<Route name="user" path="/users/:userId"/>
// create a link with this<Link to="user" params={{userId: "123"}}/>

// though, if your user properties match up to the dynamic segements:<Link to="user" params={user}/>

	``query``

	一个包装成javascript对象的字符串查询参数

	``activeClassName``

	当路由被激活是 ``Link`` 接收的 className,默认值为 ``active``

	``activeStyle ``

	当路由被激活是链接元素 展示的style样式。

	``onClick``

	对点击时间的常规处理，仅仅在标签``<a>`` 上起效。调用 ``e.preventDefault`` 或者是返回false 将会阻止阻止事件发射。通过 ``e.stopPropagation()`` 将会阻止时间冒泡。

	**others**

	你也可以在<a>上传递 props，例如 title,id , className 等。

	**举例**

	提供一个形式像 ``<Router name="user" path="/user/:userid" />:`` 这样的路由

<Link to="user" params={{userId: user.id}} query={{foo: bar}}>{user.name}</Link>

<!-- becomes one of these depending on your router and if the route is
active -->
[Michael](https://segmentfault.com/users/123?foo=bar)
[Michael]()

<!-- or if you have the full url already, you can just pass that in --><Link to="/users/123?foo=bar">{user.name}</Link>

<!-- change the activeClassName --><Link activeClassName="current" to="user" params={{userId: user.id}}>{user.name}</Link>

<!-- change style when link is active --><Link style={{color: 'white'}} activeStyle={{color: 'red'}} to="user" params={{userId: user.id}} query={{foo: bar}}>{user.name}</Link>

	*##Root*
	React router 创建的应用顶层组件。

	**举例**

Router.run(routes, (Root) => {
React.render(<Root/>, document.body);
});

	**说明**
	当前路由的实例和 ``Root`` 一致。

var MyRouter = Router.create({ routes });
MyRouter.run((Root) => {
Root === MyRouter; // true
});

	当前这仅仅是一个实现的细节，我们会逐步将它设计成一个公共的API。

	##Route Handler
	用户定义的一个组件，作为传递给``Routes`` 的一个 ``handler`` 属性。 路由会在你通过 ``RouterHandler`` 渲染组件的时候给你注入一些属性值。同时在路由转换的时候调用一些生命周期的静态方法。

	**注入的属性**

	``params``

	url 中的动态段。

	``query``

	url中的查询参数

	``path``

	完整的url 路劲

	**举例**

// given a route like this:<Route path="/course/:courseId/students" handler={Students}/>

// and a url like this:"/course/123/students?sort=name"
var Students = React.createClass({ render () {

	this.props.params.courseId; *// "123"*
	this.props.query.sort; *// "name"*
	this.props.path; *// "/course/123/students?sort=name"*
	*// ...*

}});

	**静态的生命周期方法**

	你可以定义一些在路由转换时会调用的静态方法到你的路由handler 对应的组件中。

	``willTransitionTo(transition,params,query,callback)``

	当一个handler 将要被渲染的时候被调用。为你提供了中断或者是重定向的机会。你可以在异步调用的时候暂停转换，在完成之后可以调用``callback(error)``  方法。或者在参数列表中省略callback。

	``willTranstionFrom(transition,component,callback)``

	当一个被激活路由将要跳出的时候给你提供了中断跳出的方法。``component`` 是当前的组件。你可能需要检查一下 state 的状态来决定是否需要跳出。

	**关于 ``callback`` 的参数**

	 如果你在参数列表中添加了callback，你需要在最后的时候调用它，即使你使用的是重定向。

	**举例**

var Settings = React.createClass({ statics: {

	willTransitionTo: function (transition, params, query, callback) {
	  auth.isLoggedIn((isLoggedIn) => {
	    transition.abort();
	    callback();
	  });
	},

	willTransitionFrom: function (transition, component) {
	  if (component.formHasUnsavedData()) {
	    if (!confirm('You have unsaved information,'+
	                 'are you sure you want to leave this page?')) {
	      transition.abort();
	    }
	  }
	}

}
//...});
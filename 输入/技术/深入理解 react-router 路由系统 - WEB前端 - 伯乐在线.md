深入理解 react-router 路由系统 - WEB前端 - 伯乐在线

# 深入理解 react-router 路由系统

2015/12/07 · [JavaScript](http://web.jobbole.com/category/javascript-2/) · [Mocha](http://web.jobbole.com/tag/mocha/)

分享到：[(L)](http://www.jiathis.com/share?uid=1745061)[3]()

原文出处： [范洪春 （@范洪春）](http://zhuanlan.zhihu.com/purerender/20381597)
![0064cTs2jw1eyqea381r0j30go0bbdg0.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c555ba2a0377dc79c3bd8199c84377fd.jpg)

在 web 应用开发中，路由系统是不可或缺的一部分。在浏览器当前的 URL 发生变化时，路由系统会做出一些响应，用来保证用户界面与 URL 的同步。随着单页应用时代的到来，为之服务的前端路由系统也相继出现了。有一些独立的第三方路由系统，比如 [director**](https://github.com/flatiron/director)，代码库也比较轻量。当然，主流的前端框架也都有自己的路由，比如 Backbone、Ember、Angular、React 等等。那 react-router 相对于其他路由系统又针对 React 做了哪些优化呢？它是如何利用了 React 的 UI 状态机特性呢？又是如何将 JSX 这种声明式的特性用在路由中？

# 一个简单的示例

现在，我们通过一个简易的博客系统示例来解释刚刚遇到的疑问，它包含了查看文章归档、文章详细、登录、退出以及权限校验几个功能，该系统的完整代码托管在 [JS Bin**](https://jsbin.com/gapuwo/edit?js,output)（注意，文中示例代码使用了与之对应的 ES6 语法），你可以点击链接查看。此外，该实例全部基于最新的 [react-router**](https://github.com/rackt/react-router) 1.0 进行编写。下面看一下 react-router 的应用实例：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29 | import React from  'react';<br>import  {  render,  findDOMNode  }  from  'react-dom';<br>import  {  Router,  Route,  Link,  IndexRoute,  Redirect  }  from  'react-router';<br>import  {  createHistory,  createHashHistory,  useBasename  }  from  'history';<br>*// 此处用于添加根路径*<br>const  history  =  useBasename(createHashHistory)({<br>  queryKey:  '_key',<br>  basename:  '/blog-app',<br>});<br>React.render((<br>  <Router history={history}><br>    <Route path="/"  component={BlogApp}><br>      <IndexRoute component={SignIn}/><br>      <Route path="signIn"  component={SignIn}/><br>      <Route path="signOut"  component={SignOut}/><br>      <Redirect from="/archives"  to="/archives/posts"/><br>      <Route onEnter={requireAuth}  path="archives"  component={Archives}><br>        <Route path="posts"  components={{<br>          original:  Original,<br>          reproduce:  Reproduce,<br>        }}/><br>      </Route><br>      <Route path="article/:id"  component={Article}/><br>      <Route path="about"  component={About}/><br>    </Route><br>  </Router><br>),  document.getElementById('example')); |

如果你以前并没有接触过 react-router，相反只是用过刚才提到的 Backbone 的路由或者是 director，你一定会对这种声明式的写法感到惊讶。不过细想这也是情理之中，毕竟是只服务与 React 类库，引入它的特性也是无可厚非。仔细看一下，你会发现：

- Router 与 Route 一样都是 **react 组件**，它的 history 对象是整个路由系统的核心，它暴露了很多属性和方法在路由系统中使用；
- Route 的 path 属性表示路由组件所对应的路径，可以是绝对或相对路径，相对路径可继承；
- Redirect 是一个重定向组件，有 from 和 to 两个属性；
- Route 的 onEnter 钩子将用于在渲染对象的组件前做拦截操作，比如验证权限；
- 在 Route 中，可以使用 component 指定单个组件，或者通过 components 指定多个组件集合；
- param 通过 /:param 的方式传递，这种写法与 express 以及 ruby on rails 保持一致，符合 [RestFul**](http://www.ruanyifeng.com/blog/2011/09/restful.html) 规范；

下面再看一下如果使用 director 来声明这个路由系统会是怎样一番景象呢：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31<br>32<br>33<br>34<br>35<br>36<br>37<br>38<br>39<br>40<br>41<br>42<br>43 | import React from  'react';<br>import  {  render  }  from  'react-dom';<br>import  {  Router  }  from  'director';<br>const  App  =  React.createClass({<br>  getInitialState()  {<br>    return  {<br>      app:  null<br>    }<br>  },<br>  componentDidMount()  {<br>    const  router  =  Router({<br>      '/signIn':  {<br>        on()  {<br>          this.setState({  app:  (<BlogApp><SignIn/></BlogApp>)  })<br>        },<br>      },<br>      '/signOut':  {<br>        结构与  signIn  类似<br>      },<br>      '/archives':  {<br>        '/posts':  {<br>          on()  {<br>            this.setState({  app:  (<BlogApp><Archives original={Original}  reproduct={Reproduct}/></BlogApp>)  })<br>          },<br>        },<br>      },<br>      '/article':  {<br>        '/:id':  {<br>          on  (id)  {<br>            this.setState({  app:  (<BlogApp><Article id={id}/></BlogApp>)  })<br>          },<br>        },<br>      },<br>    });<br>  },<br>  render()  {<br>    return  <div>{React.cloneElement(this.state.app)}</div>;<br>  },<br>})<br>render(<App/>,  document.getElementById('example')); |

从代码的优雅程度、可读性以及维护性上看绝对 react-router 在这里更胜一筹。分析上面的代码，每个路由的渲染逻辑都相对独立的，这样就需要写很多重复的代码，这里虽然可以借助 React 的 setState 来统一管理路由返回的组件，将 render 方法做一定的封装，但结果却是要多维护一个 state，在 react-router 中这一步根本不需要。此外，这种命令式的写法与 React 代码放在一起也是略显突兀。而 react-router 中的声明式写法在组件继承上确实很清晰易懂，而且更加符合 React 的风格。包括这里的默认路由、重定向等等都使用了这种声明式。相信读到这里你已经放弃了在 React 中使用 react-router 外的路由系统！

接下来，还是回到 react-router 示例中，看一下路由组件内部的代码：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31<br>32<br>33<br>34<br>35<br>36<br>37<br>38<br>39<br>40<br>41<br>42 | const  SignIn  =  React.createClass({<br>  handleSubmit(e)  {<br>    e.preventDefault();<br>    const  email  =  findDOMNode(this.refs.name).value;<br>    const  pass  =  findDOMNode(this.refs.pass).value;<br>    *// 此处通过修改 localStorage 模拟了登录效果*<br>    if  (pass  !==  'password')  {<br>      return;<br>    }<br>    localStorage.setItem('login',  'true');<br>    const  location  =  this.props.location;<br>    if  (location.state  &&  location.state.nextPathname)  {<br>      this.props.history.replaceState(null,  location.state.nextPathname);<br>    }  else  {<br>      *// 这里使用 replaceState 方法做了跳转，但在浏览器历史中不会多一条记录，因为是替换了当前的记录*<br>      this.props.history.replaceState(null,  '/about');<br>    }<br>  },<br>  render()  {<br>    if  (hasLogin())  {<br>      return  <p>你已经登录系统！<Link to="/signOut">点此退出</Link></p>;<br>    }<br>    return  (<br>      <form onSubmit={this.handleSubmit}><br>        <label><input ref="name"/></label><br/><br>        <label><input ref="pass"/></label>  (password)<br/><br>        <button type="submit">登录</button><br>      </form><br>    );<br>  }<br>});<br>const  SignOut  =  React.createClass({<br>  componentDidMount()  {<br>    localStorage.setItem('login',  'false');<br>  },<br>  render()  {<br>    return  <p>已经退出！</p>;<br>  }<br>}) |

上面的代码表示了博客系统的登录以及退出功能。登录成功，默认跳转到 /about 路径下，如果在 state 对象中存储了 nextPathname，则跳转到该路径下。在这里需要指出每一个路由（Route）中声明的组件（比如 SignIn）在渲染之前都会被传入一些 props，具体是在源码中的 [RoutingContext.js**](https://github.com/rackt/react-router/blob/master/modules/RoutingContext.js#L68) 中完成，主要包括：

- history 对象，它提供了很多有用的方法可以在路由系统中使用，比如刚刚用到的history.replaceState，用于替换当前的 URL，并且会将被替换的 URL 在浏览器历史中删除。函数的第一个参数是 state 对象，第二个是路径；
- location 对象，它可以简单的认为是 URL 的对象形式表示，这里要提的是 location.state，这里 state 的含义与 HTML5 history.pushState API 中的 state 对象一样。每个 URL 都会对应一个 state 对象，你可以在对象里存储数据，但这个数据却不会出现在 URL 中。实际上，数据被存在了 sessionStorage 中；

事实上，刚才提到的两个对象同时存在于路由组件的 context 中，你还可以通过 React 的 context API 在组件的子级组件中获取到这两个对象。比如在 SignIn 组件的内部又包含了一个 SignInChild 组件，你就可以在组件内部通过 this.context.history 获取到 history 对象，进而调用它的 API 进行跳转等操作。

接下来，我们一起看一下 Archives 组件内部的代码：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31<br>32<br>33<br>34 | const  Archives  =  React.createClass({<br>  render()  {<br>    return  (<br>      <div><br>        原创：<br/>  {this.props.original}<br>        转载：<br/>  {this.props.reproduce}<br>      </div><br>    );<br>  }<br>});<br>const  Original  =  React.createClass({<br>  render()  {<br>    return  (<br>      <div className="archives"><br>        <ul><br>          {blogData.slice(0,  4).map((item,  index)  =>  {<br>            return  (<br>              <li key={index}><br>                <Link to={`/article/${index}`}  query={{type:  'Original'}}  state={{title:  item.title}}><br>                  {item.title}<br>                </Link><br>              </li><br>            )<br>          })}<br>        </ul><br>      </div><br>    );<br>  }<br>});<br>const  Reproduce  =  React.createClass({<br>  *// 与 Original 类似*<br>}) |

上述代码展示了文章归档以及原创和转载列表。现在回顾一下路由声明部分的代码：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13 | <Redirect from="/archives"  to="/archives/posts"/><br><Route onEnter={requireAuth}  path="archives"  component={Archives}><br>  <Route path="posts"  components={{<br>    original:  Original,<br>    reproduce:  Reproduce,<br>  }}/><br></Route><br>function  requireAuth(nextState,  replaceState)  {<br>  if  (!hasLogin())  {<br>    replaceState({  nextPathname:  nextState.location.pathname  },  '/signIn');<br>  }<br>} |

上述的代码中有三点值得注意：

- 用到了一个 Redirect 组件，将 /archives 重定向到 /archives/posts 下；
- onEnter 钩子中用于判断用户是否登录，如果未登录则使用 replaceState 方法重定向，该方法的作用与 <Redirect/> 组件类似，不会在浏览器中留下重定向前的历史；
- 如果使用 components 声明路由所对应的多个组件，在组件内部可以通过 this.props.original（本例中）来获取组件；

到这里，我们的博客路由系统基本已经讲完了，希望你能够对 react-router 最基本的 API 及其内部的基本原理有一定的了解。再总结一下 react-router 作为 React 路由系统的特点和优势所在：

- 结合 JSX 采用声明式的语法，很优雅的实现了路由嵌套以及路由回调组件的声明，包括重定向组件，默认路由等，这归功于其内部的匹配算法，可以通过 URL（准确的说应该是 location 对象） 在组件树中准确匹配出需要渲染的组件。这一点绝对完胜 director 等路由在 React 中的表现；
- 不需要单独维护 state 表示当前路由，这一点也是使用 director 等路由免不了要做的；
- 除了路由组件外，还可以通过 history 对象中的 pushState 或 replaceState方法进行路由和重定向，比如在 flux 的 store 中想要做一个跳转操作就可以通过该方法完成；

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | *// 近似于 <Link to={path} state={null}/>*<br>history.pushState(null,  path);<br>*// 近似于 <Redirect from={currentPath} to={nextPath}/>*<br>history.replaceState(null,  nextPath); |

当然还有一些其他的特性没有在这里介绍，比如在大型应用中按需载入路由组件、服务端渲染以及整合 redux/relay 框架，这些都是用其他路由系统很难完成的。接下来的部分主要来讲解示例背后的基本原理。

## 原理分析

在这一部分主要会讲解路由的基本原理，react-router 的状态机特性，在用户点击了 Link 组件后路由系统中到底发生了哪些，前端路由如何处理浏览器的前进和后退功能。

### 路由的基本原理

无论是传统的后端 MVC 主导的应用，还是在当下最流行的单页面应用中，路由的职责都很重要，但原理并不复杂，即保证视图和 URL 的同步，而视图可以看成是资源的一种表现。当用户在页面中进行操作时，应用会在若干个交互状态中切换，路由则可以记录下某些重要的状态，比如在一个博客系统中用户是否登录、在访问哪一篇文章、位于文章归档列表的第几页。而这些变化同样会被记录在浏览器的历史中，用户可以通过浏览器的前进、后退按钮切换状态，同样可以将 URL 分享给好友。简而言之，用户可以通过手动输入或者与页面进行交互来改变 URL，然后通过同步或者异步的方式向服务端发送请求获取资源（当然，资源也可能存在于本地），成功后重新绘制 UI，原理如下图所示：

![0064cTs2jw1eyqea1xw1nj30go06b0sw.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/de0375d86da0060ded57d85a23e0ed4a.jpg)

### react-router 的状态机特性

我们看到 react-router 中的很多特性都与 React 保持了一致，比如它的声明式组件、组件嵌套，当然也包括 React 的状态机特性，因为毕竟它就是基于 React 构建并且为之所用的。回想一下在 React 中，我们把组件比作是一个函数，state/props 作为函数的参数，当它们发生变化时会触发函数执行，进而帮助我们重新绘制 UI。那么在 react-router 中将会是什么样子呢？在 react-router 中，我们可以把 Router 组件看成是一个函数，Location 作为参数，返回的结果同样是 UI，二者的对比如下图所示：

![0064cTs2jw1eyqea1yl4zj30go07t0t1.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/dbc4c19b32db17ec45155ecc41c546c2.jpg)

上图说明了只要 URL 一致，那么返回的 UI 界面总是相同的。或许你还很好奇在这个简单的状态机后面究竟是什么样子呢？在点击 Link 后路由系统发生了什么？在点击浏览器的前进和后退按钮后路由系统又做了哪些？那么请看下图：

![0064cTs2jw1eyqea2hdgtj30go0bb75t.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/e16dc64d8034f7e9e00a26b4704b759a.jpg)
接下来的两部分会对上图做详细的讲解。

### 点击 Link 后路由系统发生了什么？

Link 组件最终会渲染为 HTML 标签 <a>，它的 to、query、hash 属性会被组合在一起并渲染为 href 属性。虽然 Link 被渲染为超链接，但在内部实现上使用脚本拦截了浏览器的默认行为，然后调用了history.pushState 方法（注意，文中出现的 history 指的是通过 history 包里面的 create*History 方法创建的对象，window.history 则指定浏览器原生的 history 对象，由于有些 API 相同，不要弄混）。history 包中底层的 pushState 方法支持传入两个参数 state 和 path，在函数体内有将这两个参数传输到 createLocation 方法中，返回 location 的结构如下：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | location  =  {<br>  pathname,  *// 当前路径，即 Link 中的 to 属性*<br>  search,  *// search*<br>  hash,  *// hash*<br>  state,  *// state 对象*<br>  action,  *// location 类型，在点击 Link 时为 PUSH，浏览器前进后退时为 POP，调用 replaceState 方法时为 REPLACE*<br>  key,  *// 用于操作 sessionStorage 存取 state 对象*<br>}; |

系统会将上述 location 对象作为参数传入到 TransitionTo 方法中，然后调用 window.location.hash 或者window.history.pushState() 修改了应用的 URL，这取决于你创建 history 对象的方式。同时会触发history.listen 中注册的事件监听器。

接下来请看路由系统内部是如何修改 UI 的。在得到了新的 location 对象后，系统内部的 matchRoutes 方法会匹配出 Route 组件树中与当前 location 对象匹配的一个子集，并且得到了 nextState，具体的匹配算法不在这里讲解，感兴趣的同学可以[点击查看**](https://github.com/rackt/react-router/blob/master/modules/matchRoutes.js)，state 的结构如下：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | nextState  =  {<br>  location,  *// 当前的 location 对象*<br>  routes,  *// 与 location 对象匹配的 Route 树的子集，是一个数组*<br>  params,  *// 传入的 param，即 URL 中的参数*<br>  components,  *// routes 中每个元素对应的组件，同样是数组*<br>}; |

在 Router 组件的 componentWillMount 生命周期方法中调用了 history.listen(listener) 方法。listener 会在上述 matchRoutes 方法执行成功后执行 listener(nextState)，nextState 对象每个属性的具体含义已经在上述代码中注释，接下来执行 this.setState(nextState) 就可以实现重新渲染 Router 组件。举个简单的例子，当 URL（准确的说应该是 location.pathname） 为 /archives/posts 时，应用的匹配结果如下图所示：

![0064cTs2jw1eyqea2x474j30go06fjrn.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c3fdcc457b052bd91661217d3476a8c3.jpg)
对应的渲染结果如下：

|     |     |
| --- | --- |
| 1<br>2<br>3 | <BlogApp><br>  <Archives original={Original}  reproduce={Reproduce}/><br></BlogApp> |

到这里，系统已经完成了当用户点击一个由 Link 组件渲染出的超链接到页面刷新的全过程。

### 点击浏览器的前进和后退按钮发生了什么？

可以简单地把 web 浏览器的历史记录比做成一个仅有入栈操作的栈，当用户浏览器到某一个页面时将该文档存入到栈中，点击「后退」或「前进」按钮时移动指针到 history 栈中对应的某一个文档。在传统的浏览器中，文档都是从服务端请求过来的。不过现代的浏览器一般都会支持两种方式用于动态的生成并载入页面。

#### location.hash 与 hashchange 事件

这也是比较简单并且兼容性也比较好的一种方式，详细请看下面几点：

- 使用 hashchange 事件来监听 window.location.hash 的变化
- hash 发生变化浏览器会更新 URL，并且在 history 栈中产生一条记录
- 路由系统会将所有的路由信息都保存到 location.hash 中
- 在 react-router 内部注册了 window.addEventListener(‘hashchange’, listener, false) 事件监听器
- listener 内部可以通过 hash fragment 获取到当前 URL 对应的 location 对象
- 接下来的过程与点击 <Link/> 时保持一致

当然，你会想到不仅仅在前进和后退会触发 hashchange 事件，应该说每次路由操作都会有 hash 的变化。确实如此，为了解决这个问题，路由系统内部通过判断 currentLocation 与 nextLocation 是否相等来处理该问题。不过，从它的实现原理上来看，由于路由操作 hash 发生变化而重复调用 transitonTo(location) 这一步确实无可避免，这也是我在上图中所画的虚线的含义。

这种方法会在浏览器的 URL 中添加一个 # 号，不过出于兼容性的考虑（ie8+），路由系统内部将这种方式（对应 history 包中的 [createHashHistory**](https://github.com/rackt/history/blob/master/docs/GettingStarted.md) 方法）作为创建 history 对象的默认方法。

#### history.pushState 与 popstate 事件

新的 HTML5 规范中还提出了一个相对复杂但更加健壮的方式来解决该问题，请看下面几点：

- 上文中提到了可以通过 window.history.pushState(state, title, path) 方法（更多关于 history 对象的详细 API 可以查看[这里**](https://developer.mozilla.org/en-US/docs/Web/API/History_API)）来改变浏览器的 URL，实际上该方法同时在 history 栈中存入了 state 对象。
- 在浏览器前进和后退时触发 popstate 事件，然后注册 window.addEventListener(‘popstate’, listener, false) ，并且可以在事件对象中取出对应的 state 对象
- state 对象可以存储一些恢复该页面所需要的简单信息，上文中已经提到 state 会作为属性存储在 location 对象中，这样你就可以在组件中通过 location.state 来获取到
- 在 react-router 内部将该对象存储到了 sessionStorage 中，也就是上图中的 saveState 操作
- 接下来的操作与第一种方式一致

使用这种方式（对应 history 包中的 [createHistory**](https://github.com/rackt/history/blob/master/docs/GettingStarted.md) 方法）进行路由需要服务端要做一个路由的配置将所有请求重定向到入口文件位置，你可以参考[这个示例**](https://github.com/rackt/react-router/blob/master/examples/server.js#L20)，否则在用户刷新页面时会报 404 错误。

实际上，上面提到的 state 对象不仅仅在第二种路由方式中可以使用。react-router 内部做了 polyfill，统一了 API。在使用第一种方式创建路由时你会发现 URL 中多了一个类似 _key=s1gvrm 的 query，这个 _key就是为 react-router 内部在 sessionStorage 中读取 state 对象所提供的。

## 资源汇总

关于 react-router 的参考资源确实不多。特别是 1.0 版本发布后很多文档都已经过时了，所以大家在查阅的时候一定要小心。此外，为了方便读者更好的理解 react-router 的底层原理，也找了一个相关的资源供大家参考。

### 前导知识

这里汇集了一些关于 url fragment 以及 html5 history API 相关的部分资源：

- [6 Things You Should Know About Fragment URLs**](http://blog.httpwatch.com/2011/03/01/6-things-you-should-know-about-fragment-urls/)
- [URL的井号 – 阮一峰的网络日志**](http://www.ruanyifeng.com/blog/2011/03/url_hash.html)
- [Peculiar IQ**](http://peculiariq.com/hash-symbols-and-special-characters-in-urls-explained/)
- [An Introduction To The HTML5 History API**](http://code.tutsplus.com/tutorials/an-introduction-to-the-html5-history-api--cms-22160)
- [Manipulating the browser history**](https://developer.mozilla.org/en-US/docs/Web/API/History_API)

### react-router 相关资源

这里主要是 react-router 的资源。由于 react-router 1.0 相对于之前版本的 API 差异较大，目前网络上的资源也主要是官方文档，不过中文版已经翻译好，读者可以按照喜好选择：

- [react-router/docs at master · rackt/react-router · GitHub**](https://github.com/rackt/react-router/tree/master/docs)
- [React Router 中文文档**](http://react-guide.github.io/react-router-cn/index.html)
- [rackt/history · GitHub**](https://github.com/rackt/history)
- [Building a Router with Raw React**](http://jamesknelson.com/routing-with-raw-react/)

视频资源（需翻墙）

- [https://www.youtube.com/watch?v=KOLScDu6hQ4**](https://www.youtube.com/watch?v=KOLScDu6hQ4)
- [https://www.youtube.com/watch?v=arYxw1VD0q4**](https://www.youtube.com/watch?v=arYxw1VD0q4)
- [https://www.youtube.com/watch?v=Q6Kczrgw6ic**](https://www.youtube.com/watch?v=Q6Kczrgw6ic)

加入伯乐在线专栏作者。扩大知名度，还能得赞赏！详见《[招募专栏作者](http://blog.jobbole.com/99322)》

 **  2 赞  ** 3 收藏  [** 评论](http://web.jobbole.com/84418/#article-comment)
         [(L)](http://www.jiathis.com/share?uid=1745061)

[![bfdcef89gy1fdkg2ch4pnj20h803c0te.jpg](../_resources/b3aee2ee7347340503ccc99e5dcb21ec.jpg)](http://group.jobbole.com/22945/)
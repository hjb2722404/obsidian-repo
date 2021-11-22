微前端qiankun实践和遇到的坑_cpa0701的博客-CSDN博客

# 微前端qiankun实践和遇到的坑

 ![original.png](../_resources/b249bfd5f16517851c298da1f3d78336.png)

 [AwesomeCPA](https://me.csdn.net/cpa0701)  2020-08-06 15:33:26  ![articleReadEyes.png](../_resources/8641dfdb0ca157cac9ce789182fe77a1.png)  378  [![tobarCollect.png](../_resources/3e7c8f7db9a8bbfcaf5f35d2673ef659.png)  收藏]()

 分类专栏：  [前端](https://blog.csdn.net/cpa0701/category_9947420.html)  文章标签：  [vue](https://www.csdn.net/gather_26/Mtzacg0sMzg3Ny1ibG9n.html)

 [版权]()

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' style='display: none%3b' data-evernote-id='1264' class='js-evernote-checked'%3e %3cpath stroke-linecap='round' d='M5%2c0 0%2c2.5 5%2c5z' id='raphael-marker-block' style='-webkit-tap-highlight-color: rgba(0%2c 0%2c 0%2c 0)%3b' data-evernote-id='1265' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)

出于以下几个目的，最近在用qiankun改造项目：

1. 几个项目共用同一个头部，底部和登录权限系统每次更新都需要同步*N次代码，再加上rc,uat两个发布分支，就是*3n次，想屎的心都有了
2. 之前一直写react，这个项目用vue，但总怀念使用react的时光，vue虽然更方便，但总感觉react写起来更加可控，逻辑更清晰
3. 首页要做seo，可以在nuxt中使用微前端，也可以在spa中使用微前端（还没实践）
4. 子项目可以独立开发，独立部署
5. 主项目存放框架，子项目写业务代码，功能分开，方便代码权限控制
6. 为什么不用iframe:

>

- > url 不同步。浏览器刷新 iframe url 状态丢失、后退前进按钮无法使用。
- > UI 不同步，DOM 结构不共享。想象一下屏幕右下角 1/4 的 iframe 里来一个带遮罩层的弹框，同时我们要求这个弹框要浏览器居中显示，还要浏览器 resize 时自动居中…
- > 全局上下文完全隔离，内存变量不共享。iframe 内外系统的通信、数据同步等需求，主应用的 cookie 要透传到根域名都不同的子应用中实现免登效果。
- > 慢。每次子应用进入都是一次浏览器上下文重建、资源重新加载的过程。

>

微前端的文档可以直接去[官网](https://qiankun.umijs.org/zh/guide/getting-started.html#%E4%B8%BB%E5%BA%94%E7%94%A8)看，不是很多，不过能满足基本需求，有问题还是去[github](https://github.com/umijs/qiankun)问吧

下面说说本人在做微前端改造时遇到的一些坑，希望对大家有帮助

1. 子应用导出钩子函数

>
1. > 将原来的new Vue方法写在render中
2. > webpack配置的publicpath设置成当前运行时的路径
>   ![20200730190434240.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c7d672cd931aafbfaa299bba366ef2ff.png)
3. > new VueRouter中的base要与注册子应用时候的路径一致

>   ![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NwYTA3MDE=,size_16,color_FFFFFF,t_70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/db3a5952902233a27de4451b3d31f4b6.png)

>   ![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NwYTA3MDE=,size_16,color_FFFFFF,t_70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/86756618fbc31a61292f7b6caaa5ea3a.png)

>

1. 子应用vue.config中的headers设置成可跨域请求
 ![20200730191507521.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/f513aa28431756dd85a800d03c5cfc5c.png)
2. output设置成library，打包成umd库格式
 ![2020073019161068.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c042cc2d67eda9f032d2a0c43b630d89.png)
3. 父应用使用了babel-pollfill，子应用不要在在bable-pollfill
 ![2020073019164144.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/669812e43ab1bfc8b2b409721ed4f0cf.png)
4. iconfont.js要取消样式隔离才能生效

>
> sandbox - boolean | { strictStyleIsolation?: boolean } - 可选，是否开启沙箱，默认为 true。
>

当配置为 { strictStyleIsolation: true } 表示开启严格的样式隔离模式。这种模式下 qiankun 会为每个微应用的容器包裹上一个 shadow dom 节点，从而确保微应用的样式不会对全局造成影响。

1. 子应用的代理将失效，代理需要配置在父应用中
 ![2020073019212174.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/e92cddd5bfc20d4a9bece8d1d895b675.png)
2. 应用间的通信，props,initGlobalState,@ice/stark-data

>

- > 各子应用都用到的状态放入全局（用@ice/stark-data中的store定义）
- > 通过store.on监听每次更改全局状态时，都同步更新子应用的store，直接用store.get方法可以获取状态值，但无法监听状态值变化时视图同步更新，所以最好还是放在应用本身的store中进行展示
- > 原则是赋值操作在各应用中同步，但修改操作只在主应用这一个地方操作，高度解耦
- > 如果是选择在子应用中进行全局状态的修改，那么需要在各应用中维护所有的状态修改操作，高度耦合，导致后期的代码维护十分困难
- > 一开始用的initGlobalState，发现这个是双向绑定的，即应用间要都有mutation或action，相当于要在每个子应用中写相同的store代码，不符合kiss准则，也对后期维护带来相当大困难，所以还是采用@ice/stark-data，飞冰团队的微前端通信方案

>

1. 关于部署：
微应用的部署和原来项目的部署基本一致

>

- > 主应用和每个子应用部署在服务器后有单独端口，可以跟开发环境一样，把publicPath和注册app时对应的地址改下就行
- > 如果没有单独端口，那么需要用二级路径去部署，打包时的publicpath以及注册时entry的路径，注意在末尾加/

>   ![20200806151603235.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/5d8eb5e89c8b5926496be6e0bdfc3e9a.png)

>   ![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NwYTA3MDE=,size_16,color_FFFFFF,t_70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/87ddb6e602c2b1d8df019abf9b78ced7.png)

>

>

- > 注册时entry的路径不能和路由的base以及activeRule一致，不然会产生覆盖（如都是/cloud，则会变为去请求/cloud目录下的文件）

>

1. 关于nginx的配置：

	# 主应用
	location / {
	    if ($request_uri ~* '/$|\.html$') {
	        add_header Cache-Control no-store;
	    }

	    root /opt/pumpkin/fronted/;
	    index index.html;
	    try_files $uri $uri/ /index.html;
	}
	# cloud子应用
	location /cloud/ {
	    if ($request_uri ~* '/$|\.html$') {
	        add_header Cache-Control no-store;
	    }
	    alias /opt/pumpkin/fronted/;
	    index index.html;
	    try_files $uri $uri/ /index.html;
	}
	# mall子应用
	location /mall/ {
	    if ($request_uri ~* '/$|\.html$') {
	        add_header Cache-Control no-store;
	    }
	    alias /opt/pumpkin/fronted/;
	    index index.html;
	    try_files $uri $uri/ /index.html;
	}
	# portal子应用
	location /portal/ {
	    if ($request_uri ~* '/$|\.html$') {
	        add_header Cache-Control no-store;
	    }
	    alias /opt/pumpkin/fronted/;
	    index index.html;
	    try_files $uri $uri/ /index.html;
	}

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15
- 16
- 17
- 18
- 19
- 20
- 21
- 22
- 23
- 24
- 25
- 26
- 27
- 28
- 29
- 30
- 31
- 32
- 33
- 34
- 35
- 36
- 37
- 38

由于都是history的路由模式，所以：

>
1. > 每个应用配置都要加上`try_files $uri $uri/ /index.html;`> 否则会出现刷新报404错误
2. > 每个子应用都要单独配置location，否则在访问/cloud，/mall，/portal时刷新会报404
>

1. 主应用和各应用相同依赖的版本号一定要一样，不然会有莫名其妙的BUG

2. 项目中使用了百度地图等组件，会出现在子应用中无法使用的情况 ，在看源码时发现子应用的document.body中添加script标签失败没报错，但无法正确添加到body中，类似性质的问题还有美洽客服的引用，pdfjs的引用两种解决方法：

- 更新qiankun版本至2.0.17，在start中添加`excludeAssetFilter`，在主应用中引入script标签

 ![20200806160310510.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/3cfa2a3dc823413700fc5228c06b97ae.png)
 ![20200806180401944.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/041c6bfdd78dbd4fde35347243c1e53c.png)

 ![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NwYTA3MDE=,size_16,color_FFFFFF,t_70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/27803923ebc64583ffe0541584e89ade.png)

- 使用iframe单独调用百度地图的页面（没有太多页面交互推荐用这种）

 ![20200806160548856.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/2d68807354dc673946324349100f3630.png)
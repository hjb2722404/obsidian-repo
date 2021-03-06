redux和vuex的不同：mvc中的service到底对应了谁

# redux和vuex的不同：mvc中的service到底对应了谁

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='225'%3e%3cpath d='M751.144277 307.2l-123.016533-238.933333h159.778133a81.92 81.92 0 0 1 59.1872 25.258666l160.256 167.492267A27.306667 27.306667 0 0 1 987.620011 307.2h-236.475734z m270.506667 111.547733L640.927744 946.039467a27.306667 27.306667 0 0 1-48.128-24.234667L766.504277 375.466667h-56.388266l-170.5984 590.165333a27.306667 27.306667 0 0 1-52.462934 0.034133L315.500544 375.466667H259.112277l174.523734 545.5872a27.306667 27.306667 0 0 1-48.128 24.302933L5.160277 418.747733A27.306667 27.306667 0 0 1 27.346944 375.466667H999.464277a27.306667 27.306667 0 0 1 22.152534 43.281066zM18.301611 261.0176L178.557611 93.525333A81.92 81.92 0 0 1 237.744811 68.266667h159.744L274.506411 307.2H38.030677a27.306667 27.306667 0 0 1-19.729066-46.1824zM453.877077 68.266667h117.896534l122.9824 238.933333H330.894677l122.9824-238.933333z' data-evernote-id='130' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*0.1452018.09.02 19:56:51字数 844阅读 651

之前我发了一篇文章（https://www.jianshu.com/p/15c835546b）讲了`理想中的mvc架构`以及`项目中缺少service层`的情况，其实是没经过深思，是错误的。

我前面放了一张图

![5077517-ea5183372b63c8b9.png](../_resources/8c5edabe373477c5633dfb92021a9ebc.png)
前端的MVC.png

（这里要把reducer替换成mutation）

仔细一想就会发现，我所说的`业务逻辑层`，其实就对应这里的`action handler`， 我们说 vuex 的使用流程是 组件dispatch一个`action`，然后store处理这个action，在对应的`action handler`里写业务逻辑，

之后调用对应的`mutation`更新数据`state`。

其实这里的`action handler`就是我所说的 `service`层， vuex所说mutaion和action的概念其实包括了**`mutation handler`**和 **`action handler`**，这样划分之后vuex的流程是这样的。

![5077517-eb2b3184c2925662.png](../_resources/1d332d190c0c4f228ce92dbb27512562.png)
vuex.png
就是我之前没有理解`vuex架构`和`传统的model`的区别，导致了我之前认为架构少了`service`层的错误。
传统的model是这样的:

![5077517-d6e88c60387dbec9.png](../_resources/d461616c3e47c748bfbf209693768c27.png)
传统的model.png

组件里直接调用`service`层的接口，可能调用很多个方法，命令式的和很多service耦合，同样service层调用`dao`也是一样。 vuex的多出了`action`和`muation`这样的一层，这是**`命令模式`**的实现，优点很明显：我在组件里不需要直接和 service的具体api耦合了，我只要发布一个`命令`（action），自然会有对应的`service`（action handler）进行处理，而且我可以一个命令对应多个service，实现了组件和model的解耦，`service`（action handler）和`dao` （mutation handler）的解耦也是一样。这种使用`命令模式`实现解耦的优雅架构我开始没有分析出来，同时对redux的熟悉也是让我产生这样错误结论的一个因素，因为redux和vuex的架构是不一样的，

redux的使用流程是这样的：

![5077517-bdf6077aeb27fba6.png](../_resources/9b74a229090bf452ff836165f9c3bb44.png)
redux.png
redux也是命令模式的实现，但是没有mutation那一层， 对比一下vuex和reducer的话他们各自有这些概念：

`vuex` ： state、 mutation handler、 mutation 、 action handler 、 action 、 middleware

`redux`： state、 reducer（action handler）、action、 middleware
当然这两个都可以结合`命令生成器`action creator，

redux中的service层一般通过`redux-saga`或者`redux-observable`来做，vuex的service层是内置的，就是`action handler`。没有理清两者的区别是导致我产生vuex架构中没有service的错误结论的一个原因。

再回过头来分析之前的问题：

![5077517-da0b6d1329b56a59.png](../_resources/7b7b8a4d2c69a7b1ab6df04b4985fec0.jpg)
这段代码确实有问题，但问题不是出在了缺少service，而是出在了缺少action creator。

## 总结

之前我一直觉得有些别扭和理不顺的地方，在分出了`action handler`、 `mutation handler`，经过和redux的对比之后理清了。
vue和react的设计思想确实有很大的不同，我再次对vue很多东西是内置的这一点有所感悟，
`vue系列`的 vue + vue-router + vuex 就对应了`react系列`的

react + react-router + redux + redux-saga(redux-observable) + reselect + immutable，vue用起来确实简单方便，react做的事很少但是函数式的思想特别明显，但是就如之前那张图那样，

![5077517-0d4da429fe17906b.png](../_resources/e63c2f315a4e2e4ff269546505f66be2.png)
image.png
这是最大的不同吧。

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='339'%3e%3cpath d='M728.064 343.943529c-17.648941-2.891294-23.552-20.239059-26.503529-28.912941V104.026353C701.560471 46.200471 654.396235 0 595.425882 0c-53.007059 0-97.28 40.478118-106.134588 89.569882-29.997176 184.862118-138.541176 255.457882-217.630118 280.937412a26.142118 26.142118 0 0 0-18.130823 24.877177v560.067764c0 19.817412 16.022588 35.84 35.84 35.84h535.973647c56.018824-11.565176 94.328471-31.804235 120.892235-86.738823l120.832-416.105412c23.552-75.173647-14.757647-147.395765-100.231529-144.564706h-238.772706z m-571.813647 31.744H76.619294C35.358118 375.687529 0 410.383059 0 450.861176v462.426353c0 43.369412 32.406588 78.004706 76.619294 78.004706h79.631059c27.708235 0 50.115765-22.407529 50.115765-50.115764V425.863529a50.115765 50.115765 0 0 0-50.115765-50.115764z' data-evernote-id='157' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

2人点赞*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='64 64 896 896' focusable='false' class='js-evernote-checked' data-icon='right' width='1em' height='1em' fill='currentColor' aria-hidden='true' data-evernote-id='343'%3e%3cpath d='M765.7 486.8L314.9 134.7A7.97 7.97 0 0 0 302 141v77.3c0 4.9 2.3 9.6 6.1 12.6l360 281.1-360 281.1c-3.9 3-6.1 7.7-6.1 12.6V883c0 6.7 7.7 10.4 12.9 6.3l450.8-352.1a31.96 31.96 0 0 0 0-50.4z' data-evernote-id='344' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='348'%3e%3cpath d='M771.413333 668.728889c-18.773333 3.015111-25.031111 20.878222-28.16 29.866667v217.884444c0 59.733333-49.948444 107.52-112.412444 107.52a115.427556 115.427556 0 0 1-112.412445-92.558222c-31.857778-190.919111-146.830222-263.850667-230.627555-290.133334a27.420444 27.420444 0 0 1-19.228445-26.168888V37.944889C268.572444 17.066667 285.582222 0 306.631111 0h567.864889c59.335111 11.946667 99.953778 32.824889 128 89.543111l128.113778 429.909333c24.974222 77.653333-15.644444 152.291556-106.211556 149.276445H771.413333z m-605.866666-32.824889H81.180444C37.546667 635.904 0 600.064 0 558.250667V80.611556C0 35.84 34.360889 0 81.180444 0H165.546667c29.297778 0 53.077333 23.779556 53.077333 53.077333v529.749334a53.077333 53.077333 0 0 1-53.077333 53.077333z' data-evernote-id='136' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

[*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='353'%3e%3cpath d='M178.390055 120.591045C111.268624 120.591045 56.888889 174.401955 56.888889 240.556383V903.97778C56.888889 970.302855 111.097977 1024 178.390055 1024h545.731364c67.121431 0 121.558049-53.81091 121.558049-120.02222V240.613265c0-66.268192-54.209088-120.02222-121.558049-120.02222H178.390055z m455.117432 301.136319H269.06087a30.147761 30.147761 0 0 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z m303.18409 301.136318a30.318409 30.318409 0 0 1-30.375291-30.318409V180.317742c0-66.268192-53.81091-120.02222-121.330519-120.022219H329.697688a30.147761 30.147761 0 0 1 0-60.23864l454.946784 0.056882C885.326618 0.113765 967.009987 80.887013 967.009987 180.602155v511.943118a30.318409 30.318409 0 0 1-30.31841 30.318409z m-303.18409-120.47728H269.06087a30.147761 30.147761 0 1 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z' data-evernote-id='147' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*技术](https://www.jianshu.com/nb/10541033)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='359'%3e%3cpath d='M232.727273 579.87878833C271.28679 579.87878833 302.545455 548.62012233 302.545455 510.06060633 302.545455 471.50108933 271.28679 440.24242433 232.727273 440.24242433 194.167756 440.24242433 162.909091 471.50108933 162.909091 510.06060633 162.909091 548.62012233 194.167756 579.87878833 232.727273 579.87878833ZM512 579.87878833C550.559516 579.87878833 581.818182 548.62012233 581.818182 510.06060633 581.818182 471.50108933 550.559516 440.24242433 512 440.24242433 473.440484 440.24242433 442.181818 471.50108933 442.181818 510.06060633 442.181818 548.62012233 473.440484 579.87878833 512 579.87878833ZM791.272727 579.87878833C829.832243 579.87878833 861.090909 548.62012233 861.090909 510.06060633 861.090909 471.50108933 829.832243 440.24242433 791.272727 440.24242433 752.713211 440.24242433 721.454545 471.50108933 721.454545 510.06060633 721.454545 548.62012233 752.713211 579.87878833 791.272727 579.87878833Z' data-evernote-id='103' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

[[webp](../_resources/10748a6745a57ec4c0b5db1b7b2a9898.webp)](https://www.jianshu.com/u/3b58ab9aeeb3)

[凌霄光](https://www.jianshu.com/u/3b58ab9aeeb3)
拥有128钻 (约22.67元)
"小礼物走一走，来简书关注我"
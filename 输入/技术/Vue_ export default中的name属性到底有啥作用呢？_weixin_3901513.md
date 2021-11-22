Vue: export default中的name属性到底有啥作用呢？_weixin_39015132的博客-CSDN博客_export default name



 [![3_weixin_39015132](../_resources/3086426b847b7b268a399f25f8587fdc.png)](https://blog.csdn.net/weixin_39015132)

 [ 車句](https://blog.csdn.net/weixin_39015132)

 码龄3年  [![nocErtification.png](../_resources/cc44893427cf71b0f457dc9be488e432.png)暂无认证](https://me.csdn.net/weixin_39015132?utm_source=14998968)

[60](https://blog.csdn.net/weixin_39015132)
[原创](https://blog.csdn.net/weixin_39015132)

52
粉丝

118
获赞

69
评论

49万+
访问

3558
积分

146
收藏

5万+
[周排名](https://blog.csdn.net/rank/writing_rank)

2万+
[总排名](https://blog.csdn.net/rank/writing_rank_total)

[![blog5.png](../_resources/ca8bab34745b5e714226330059c03a46.png)](https://blog.csdn.net/blogdevteam/article/details/103478461#%E5%8D%9A%E5%AE%A2%E7%AD%89%E7%BA%A7)

等级

 ![chizhiyiheng@240.png](../_resources/2a5027b5bff83f50a189c6146b4f7548.png)

 [TA的主页](https://me.csdn.net/weixin_39015132)

 [私信](https://im.csdn.net/im/main.html?userName=weixin_39015132)

 [关注]()

 [![csdn-sou.png](../_resources/07f4099b8587cb1747aa74f644f610db.png)]()

[![4468684232121569553](../_resources/a605fb32625e8db3e1b047e10618dd9b.jpg)](https://adclick.g.doubleclick.net/pcs/click?xai=AKAOjssioQDZpJJHdk_4jonPMyWHG9WMhB4xt2TyTVf-1vXo9QG8WMWFDSXIe0GPizqTvqkxjFHsK66GKIkP_pMdHejniVnRbfJKw1Lu-9xD65KmxYGliNcy0ss60-9lonQ-qoZ5JcLWY4jPlBf7qz4UvIQvE7LwijRrf2qm-PKbJesUNZvIrLGbPC-ReYOfYPnBskpZ4CiAW8AG8wotan-9LnQC96imm2hVsZrP0vemQa-cSydczSsw3-eaZyc-HMUtp9ZPBL8PecTT0XBbc53R2Y3gWj0SW5xDQoPT1GjYHVunqfzxNWjhwyppar-lHgS2sWXMSyYq1jA5Wiv0qhYT5miPX1NMBsJMljLbBgPAb_FyLA-nl8CdX21QnK9MQzGHbb--AxQ8fLd1wgEyt-1KYgW8YZjg0Z4EYF3tRuTOKKxkwdgYx2m_uZPw28OZmHIyLNDllhJoqhX_VjZVu-9gP1PoaxaVRSx7Ski8R8SMPbpq0TvZhuqB3OeGI3p1zElOzs3bG34iP2E_OCsJx0vv-iMLBnsv5UAbZutEPd4VOwpfI9Cz4vVu_TRrYUYANkCrTwwk9SVcyCGyrBf7S3xHO17vWIm7cpEC0FHwQL5RVhBORUn91RUX_BlQJa02sgJlco15vF82TWRgDq-LTYOBmdfp_WjtDk6qCjx_VytzkbLU2BKfR4lJrEJBy8j2vp9JKlqRJ5gxepEbfSHDgEs-PnL4KSSca-IDQdJFuS_0qg92IehRvcvvjnKo6eixy7r7prDhL7qCyt1zz5Cx2TVCC0EQmNmE0tjz-5EqJmP-Q3aETE-DP96UoZCZKc4Dmcsk7oc0yFvcZWEjw1d2QVpJKGeGs7pgBi7VzzgsljwzKd0slKl3Zu-DnZAx5u3rsZ6mkDSGJS6vINvZ4uAqbOfOPiybAf2brbt8gtB85vFF1J6Ce5iBx4h19LVs13zl5MOC03_0c36UkZJwKAYeD3vwYXGMydbthDlg-Ss1BiJ55oe_86Iz_A88UntygLA_lPzSQGZNGp3U_8Vu1933byHQOP4gXLnrBUU9ckpGiGz9Owq4Au4yha0Jtx8wyvFCv4RSqwwxYzWZzy0wTZRONfymjHW72JNIw5PpDPdL&sai=AMfl-YTMsjew6arr3b1DFivAUaS3Byd--gQhueZWPKZSrvBiIjVhv_UJ8w5KhF2glzNfBgBncsGKdoH3rTu_7syqH_1sbBDWzGjFub8klGLiqzapPPyT19XI8--vnWPE5OQqPBwizvPRIlZmfawPeKZ0U16QJWSDaJqbk3EWwjmaXp9gbLE&sig=Cg0ArKJSzPoM3mbBsCrl&urlfix=1&adurl=https://shop.othercidegame.com/%3Futm_campaign%3DLaunch%26utm_source%3DDV360%26utm_medium%3D300x250)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='21' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='19' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

![1.png](../_resources/72c68b2d4b409a357128dcf86205ce26.png)

### 最新文章

- [微信小程序: canvas设置渐变颜色无效](https://blog.csdn.net/weixin_39015132/article/details/86301851)

- [挖坑指南: canvas元素的宽高属性和css中的宽高(大型翻车现场..)](https://blog.csdn.net/weixin_39015132/article/details/86295280)

- [挖坑指南: 微信小程序this.setData({ })的骚操作](https://blog.csdn.net/weixin_39015132/article/details/85839238)

- [记一次重大事故：愿我们一生温暖纯良，不舍爱与自由~](https://blog.csdn.net/weixin_39015132/article/details/85197565)

- [挖坑指南：vscode配置.md文件预览配置](https://blog.csdn.net/weixin_39015132/article/details/85011459)

### 分类专栏

- [![resize,m_fixed,h_224,w_224](../_resources/7b08edbca9fc414cf8ba0f5333e0fdb3.png)  微信小程序    15篇](https://blog.csdn.net/weixin_39015132/category_7807571.html)

- [![resize,m_fixed,h_224,w_224](../_resources/d66ffb8e01b91cc9e5f445f458ebcf2c.png)  页面布局    2篇](https://blog.csdn.net/weixin_39015132/category_7821605.html)

- [![resize,m_fixed,h_224,w_224](../_resources/d41b99664a85cfdc37dd7e0b343ce2a7.png)  页面样式    7篇](https://blog.csdn.net/weixin_39015132/category_7828846.html)

- [![resize,m_fixed,h_224,w_224](../_resources/f6a5eba3b1989fa93320ae1453403608.png)  JavaScript    3篇](https://blog.csdn.net/weixin_39015132/category_7833826.html)

- [![resize,m_fixed,h_224,w_224](../_resources/dcb8277dde5eb83ad134a1a534b10c11.png)  Vue    8篇](https://blog.csdn.net/weixin_39015132/category_7924747.html)

- [![resize,m_fixed,h_224,w_224](../_resources/e9b94b29cc2ec8fe49a4b41b047e753d.png)  git    1篇](https://blog.csdn.net/weixin_39015132/category_8041953.html)

- [![resize,m_fixed,h_224,w_224](../_resources/fff8110832af34f5a09ad8b61234a98e.png)  挖坑指南    26篇](https://blog.csdn.net/weixin_39015132/category_8105991.html)

- [![resize,m_fixed,h_224,w_224](../_resources/9e30f721a069a58b5652b0ade66084b9.png)  前端进阶    1篇](https://blog.csdn.net/weixin_39015132/category_8246096.html)

- [![resize,m_fixed,h_224,w_224](../_resources/f6a5eba3b1989fa93320ae1453403608.png)  重大事故    1篇](https://blog.csdn.net/weixin_39015132/category_8552994.html)

 [![arrowDownWhite.png](../_resources/f4b900b127b62ec8a7714816fa39b453.png)]()

### 归档

2019

 [1月3篇](https://blog.csdn.net/weixin_39015132/article/month/2019/01)

2018

 [12月3篇](https://blog.csdn.net/weixin_39015132/article/month/2018/12)

 [11月14篇](https://blog.csdn.net/weixin_39015132/article/month/2018/11)

 [10月17篇](https://blog.csdn.net/weixin_39015132/article/month/2018/10)

 [9月13篇](https://blog.csdn.net/weixin_39015132/article/month/2018/09)

 [8月3篇](https://blog.csdn.net/weixin_39015132/article/month/2018/08)

 [7月7篇](https://blog.csdn.net/weixin_39015132/article/month/2018/07)

### 热门文章

- [CSS: filter: blur(); 实现高斯模糊效果，不可不知的细节优化![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)46185](https://blog.csdn.net/weixin_39015132/article/details/81179775)
- [mpvue项目中使用第三方UI组件库![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)45119](https://blog.csdn.net/weixin_39015132/article/details/81068367)
- [Vue: export default中的name属性到底有啥作用呢？![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)43244](https://blog.csdn.net/weixin_39015132/article/details/83573896)
- [CSS: :last-child 与 :first-child的坑![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)40981](https://blog.csdn.net/weixin_39015132/article/details/81172222)
- [CSS: nth-child()选择前几个元素![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)32757](https://blog.csdn.net/weixin_39015132/article/details/82015012)

### 最新评论

- [微信小程序：globalData和...](https://blog.csdn.net/weixin_39015132/article/details/83001334#comments_12404078)

...  [Huskar·King](https://my.csdn.net/weixin_43355113) ： 说实话你这文章没啥营养啊.

- [vue-awesome-swipe...](https://blog.csdn.net/weixin_39015132/article/details/81560571#comments_12308427)

...  [铭学前端](https://my.csdn.net/weixin_43630802) ： 点赞

- [微信小程序：自定义验证码/密码输入...](https://blog.csdn.net/weixin_39015132/article/details/82384652#comments_12153085)

...  [Yal_insist](https://my.csdn.net/Yal_insist) ： [code=plain]
.password-box .hidden-input { width: 0; height: 0; min-height: 0; }
改为
.password-box .hidden-input { width: 0px; } [/code]
好像就可以解决手机不显示键盘的问题了

- [CSS: 页面底部自适应：页面高度...](https://blog.csdn.net/weixin_39015132/article/details/81136927#comments_12054746)

...  [Yabi0527](https://my.csdn.net/qq_42033590) ： 明白楼主的意思，做出来了；样式代码没有贴全，最外层div加一个min-height：100%；完美解决，有些时候样式不是直接粘贴就行的，要体会其中布局的结构。

- [挖坑指南：如何通过事件动态地切换i...](https://blog.csdn.net/weixin_39015132/article/details/83685349#comments_12033076)

...  [路边蹲着看美女](https://my.csdn.net/yb233yb) ： 大佬,我遇到的情况是几个tab标签页上有不同的搜索条件,但是切换了tab后按搜索还会带上另一个标签里的条件,而且比如在tab1里的输入框写了内容,切换到tab2再切换回tab1以后,resetFields也无法清空tab1里输入的内容,tab1和tab2是用的同一个表单,只不过用了v-if在tab2的时候隐藏了tab1的一些输入框

[![5834796496814312658](../_resources/a39476124a34ec8978a681ae36099894.png)](https://www.googleadservices.com/pagead/aclk?sa=L&ai=C5q2npFM2X_TLJ9Sgigb-roLgDdSo3spej6Xy2_ELucPNhgEQASC3yJQCYJ0BoAHey62MA8gBAqkCTWHSz1dRgT6oAwHIA8kEqgTmAU_Qo11TNUBnXXfJDWPsREgZjMEaxNe9-4K6-95yRo433mnMUp6qZg75xqJM78qdBi5ZiJ0nZikpkEq-oCQN9ZBMhpbI7ypkekxJM2KpJPI__V-isdhzBXzLy0ls7hzKQS4iXOx2HvvdqKzxkYGu2KhVepqdscLVjQzVxGlPmLDcXg4Ckeeo7yZ21FH5Go7-imwKc6cONfVELbbzjx4BgRlvj1fCS0EN-QKskBW8quBLIGB-xUby2r2AFYyXbK-55HulLkl7BSVPdonoSIalHJoXKSm69QmrDeoqHo2_dmoereKI4YC8wATLrcTwiwOgBgKAB4q00nOoB47OG6gH1ckbqAeT2BuoB7oGqAfw2RuoB_LZG6gHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BuoB8LaG9gHAdIIBwiAYRABGB-xCVrwea5286W6gAoBmAsByAsB2BMN&ae=1&num=1&cid=CAASEuRoKgwIEm-AvBVjDM90lpT7DA&sig=AOD64_1P1K0X6n7I_c12JjyGea8GpAU3Og&client=ca-pub-1076724771190722&nb=17&adurl=https://www.henghost.com/act/202002/2020021.html%3Fs%3Dgg%26cxdw%26gclid%3DEAIaIQobChMI9K2srqua6wIVVJDCCh1-lwDcEAEYASAAEgJLO_D_BwE)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='22' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='21' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

![1.png](../_resources/72c68b2d4b409a357128dcf86205ce26.png)

### 目录

1. [原文链接](https://blog.csdn.net/weixin_39015132/article/details/83573896#t0)
2.
    1. [前言](https://blog.csdn.net/weixin_39015132/article/details/83573896#t1)
    2. [开始](https://blog.csdn.net/weixin_39015132/article/details/83573896#t2)
    3. [实践](https://blog.csdn.net/weixin_39015132/article/details/83573896#t3)
    4. [总结](https://blog.csdn.net/weixin_39015132/article/details/83573896#t4)

# Vue: export default中的name属性到底有啥作用呢？

 ![original.png](../_resources/8f19bb4e9750fc1d08da69d6a9ac56cd.png)

 置顶  [車句](https://me.csdn.net/weixin_39015132)  2018-10-31 11:08:01  ![articleReadEyes.png](../_resources/c4360f77d43b7f3fdc7b1e070f32dfd4.png)  43385  [![tobarCollect.png](../_resources/5dad7f82dd0d8ba01fecbf11a059a7cd.png)  收藏   26]()

 分类专栏：  [Vue](https://blog.csdn.net/weixin_39015132/category_7924747.html)

 [版权]()

## [原文链接](http://www.xiaofengcun.cn/vue-export-defaultzhong-de-nameshu-xing-dao-di-you-sha-zuo-yong-ni/)

### 前言

又开始一个全新的项目，每天都要元气满满呀~在划分模块和创建单页面组件时，常常写到name。嵌套路由中，index.vue极为常见，那么在vue中，export default { name: 'xxx'} 中的name到底有啥作用呢？

### 开始

**还是先回到官方的文档：https://cn.vuejs.org/v2/api/#name**

![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl8zOTAxNTEzMg==,size_16,color_FFFFFF,t_70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/03c977fca1ad1dd8d8a7050f18d8f4f4.jpg)

官方文档已经给我们描述了两种使用情况，可能在开发中，并不是常用，举例子说明一下。

### 实践

**1.组件自身的递归调用，就是在当前组件中，调用组件自己**
componentA.vue

`[[BLOCK_OPEN]][[BLOCK_OPEN]]1. 1[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]<template>[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]2. 2[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]  <div class="component-a">[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]3. 3[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]    *<!-- 一个简单的树形组件 -->*[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]4. 4[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]    <tree :treeData="treeData"></tree>[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]5. 5[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]  </div>[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]6. 6[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]</template>[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]7. 7[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]<script>[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]8. 8[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]export default {[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]9. 9[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]    name: 'component-a',[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]10. 10[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]    data() {[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]11. 11[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]      return {[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]12. 12[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]        treeData: [{[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]13. 13[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]          title: '树形标题一',[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]14. 14[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]          expand: true,[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]15. 15[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]          children: [{[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]16. 16[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            title: '子标题1',[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]17. 17[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            expand: true[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]18. 18[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]          },[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]19. 19[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]          {[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]20. 20[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            title: '子标题2',[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]21. 21[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            expand: true,[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]22. 22[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            children: [{[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]23. 23[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]              title: '子标题2.1',[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]24. 24[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]              expand: true[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]25. 25[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            },[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]26. 26[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            {[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]27. 27[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]              title: '子标题2.2',[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]28. 28[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]              expand: true[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]29. 29[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            },[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]30. 30[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            {[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]31. 31[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]              title: '子标题2.3',[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]32. 32[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]              expand: true[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]33. 33[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            }][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]34. 34[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]          }][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]35. 35[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]      }[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]36. 36[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]    },[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]37. 37[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]    components: {[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]38. 38[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]      // 自定义组件[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]39. 39[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]      tree: {[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]40. 40[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]        // 组件的名称[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]41. 41[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]        name: 'tree',[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]42. 42[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]        // 模板[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]43. 43[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]        template: ` [[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]44. 44[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            <ul>[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]45. 45[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]               <li v-for="item in treeData">[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]46. 46[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]                 <span>{{item.title}}</span>[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]47. 47[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]	         *<!-- 在组件内部调用自己 -->*[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]48. 48[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]                 <tree v-if="item.children" :treeData="item.children"></tree >[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]49. 49[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]               </li>[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]50. 50[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]            </ul>`,[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]51. 51[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]        // 通过父组件传递的数据[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]52. 52[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]        props: ['treeData'][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]53. 53[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]      }[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]54. 54[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]    },[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]55. 55[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]    methods: {}[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]56. 56[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]  }[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]57. 57[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]</script>[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]]58. 58[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_OPEN]][[BLOCK_OPEN]]<style lang="less" scoped></style>[[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]][[BLOCK_CLOSE]]`

登录后复制
看一下效果图：

 ![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl8zOTAxNTEzMg==,size_16,color_FFFFFF,t_70](../_resources/700f6e2582239bdc7b2c8c00d0f8157b.png)

**2.当我们使用vue.js官方提供的调试工具调试时，可以看到组件的名称，更好地定位**

![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl8zOTAxNTEzMg==,size_16,color_FFFFFF,t_70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/686c77b4d589372ae29d2ff6a4b08ed3.png)

3.最后一种应该是使用比较多的情况，就是当我们使用 keep-alive时可以使用include和exclude指定需要缓存和不需要缓存的组件。指定的依据就是组件的name。

官方文档：[https://cn.vuejs.org/v2/api/#keep-alive ![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl8zOTAxNTEzMg==,size_16,color_FFFFFF,t_70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/08fc5a4047180da80d1e837e7121a541.png)](https://cn.vuejs.org/v2/api/#keep-alive)

### 总结

以上就是vue.js中组件export default 中name的三种作用。调试和keep-alive是我们开发中常用的功能，关于组件的递归调用，还是第一次实践，递归时，大家一定要注意递归的条件，否则会进入死循环。

另外呢，给大家找了几篇关于组件递归的文章，希望给大家更多的参考~
**https://blog.csdn.net/weixin_40814356/article/details/80283882**
**https://blog.csdn.net/zhaoxiang66/article/details/80940762 **
**刚好我自己的项目引入了iView框架，并且使用了其中的Tree组件，我们顺便看看它的源码吧~**

**![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl8zOTAxNTEzMg==,size_16,color_FFFFFF,t_70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/b91f210675b0921a7bbe34246454b682.jpg)**

**好啦~万圣节前夕，今晚一定要出去嗨哦，嘻嘻....生活会有彩蛋哦**
嘘寒问暖 不如打笔巨款~

![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl8zOTAxNTEzMg==,size_16,color_FFFFFF,t_70](../_resources/20da2dffb4f3914b211714ca8b0c3fbd.png)

[project_sun的博客](https://blog.csdn.net/project_sun)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)6580

#### [*vue*中，new *vue*({})与*export*  *default* {} 两者的区别](https://blog.csdn.net/project_sun/article/details/90446609)

[*vue*中，new *vue*({})与*export*  *default* {} 两者的区别？new *vue*({}) 只在入口文件 main.js里使用，而其余组件的里的*属性*和方法的使用，为什么都要放在*export*  *default*{}中，而不是每个组件都用new *Vue*({})来生成呢？放在*export*  *default*{}中它是作为一个class被导出的么？另外两者的写法也不一样。就data来说，给作......](https://blog.csdn.net/project_sun/article/details/90446609)

[lawliet](https://blog.csdn.net/qq_38999048)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)7196

#### [*vue*文件中name*属性**作用*](https://blog.csdn.net/qq_38999048/article/details/82772158)

[官方文档解释1.递归组件运用（指组件自身组件调用自身组件） &lt;article&gt; &lt;div class="item" v-for="(item,index) in list" :key="index"&gt; &lt;div class="item-title"&gt; &lt;span class="i...](https://blog.csdn.net/qq_38999048/article/details/82772158)

[![anonymous-User-img.png](Vue_%20export%20default中的name属性到底有啥作用呢？_weixin_3901513.md#)
![commentFlag@2x.png](../_resources/9691c48478c7ead86dba3f18e2b18539.png)

[Qin的专栏](https://blog.csdn.net/Uookic)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)2万+

#### [*vue*中组件name的*作用*](https://blog.csdn.net/Uookic/article/details/80420472)

[这是一篇总结笔记我们在写*vue*项目的时候会遇到给组件命名 这里的name非必选项，看起来好像没啥用处，但是实际上这里用处还挺多的 *export*  *default* { name:'xxx'}1.当项目使用keep-alive时，可搭配组件name进行缓存过滤 举个例子： 我们有个组件命名为detail,其中dom加载完毕后我们在钩子函数mounted中进行数据加......](https://blog.csdn.net/Uookic/article/details/80420472)

[sleepwalker_1992的专栏](https://blog.csdn.net/sleepwalker_1992)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)2万+

#### [*export*  *default* 和 *export* 的使用方式](https://blog.csdn.net/sleepwalker_1992/article/details/81461543)

[node中导入模块：var 名称 = require('模块标识符')node中向外暴露成员的形式：module.*export*s = {}在ES6中，也通过规范的形式，规定了ES6中如何导入和导出模块ES6中导入模块，使用 import 模块名称 from '模块标识符'    import '表示路径'import *** from *** 是ES6中导入模块的方式在ES6中......](https://blog.csdn.net/sleepwalker_1992/article/details/81461543)

#### [ES6中*export*  *default* 命令的详解_hsany330的专栏-CSDN博客](https://blog.csdn.net/hsany330/article/details/81001603)

8-11

[customName(); //'foo' //这是的import命令,可以用任意名称指向*export*-*default*.js输出的方法,这时就不需要知道原模块输出的函数名。 需要注意的是,这时import命令...](https://blog.csdn.net/hsany330/article/details/81001603)

#### [*export*  *default* 和 *export*_阿宁-CSDN博客_而其余组件的里的*属性*和...](https://blog.csdn.net/huning188/article/details/84073336)

7-14

[1.*export*与*export*  *default*均可用于导出常量、函数、文件、模块等 2.你可以在其它文件或模块中通过import+(常量 | 函数 | 文件 | 模块)名的方式,将其导入,以便...](https://blog.csdn.net/huning188/article/details/84073336)

[weixin_30437847的博客](https://blog.csdn.net/weixin_30437847)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)870

#### [*export*  *default* {} 和new *Vue*()区别](https://blog.csdn.net/weixin_30437847/article/details/96196263)

[1.*export*  *default* 的用法：相当于提供一个接口给外界，让其他文件通过 import 来引入使用。而对于*export*  *default* 和*export*的区别:在JavaScript ES6中，*export*与*export*  *default*均可用于导出常量、函数、文件、模块等，你可以在其它文件或模块中通过import+(常量 | 函数 | 文件 | 模块)名的方式，将其导入......](https://blog.csdn.net/weixin_30437847/article/details/96196263)

[cayre的专栏](https://blog.csdn.net/oPINGU)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)5万+

#### [ADT下载地址（含各版本），最新ADT-23.0.6](https://blog.csdn.net/oPINGU/article/details/29624477)

[ （ADT不分32或64位）2015/05/07新增ADT-23.0.6.zip2015/01/18新增ADT-23.0.3.zipADT-23.0.4.zip ADT百度云下载链接（含各版本）： 链接:https://pan.baidu.com/s/1qSWOlX43IRsQKMVdAKM2Zg密码:smy6  官网各版本下载链接： ...](https://blog.csdn.net/oPINGU/article/details/29624477)

#### [es6 *export*  *default*命令_歪脖先生的博客-CSDN博客](https://blog.csdn.net/ixygj197875/article/details/79255447)

8-8

[customName(); // 'foo'上面代码的import命令,可以用任意名称指向*export*-*default*.js输出的方法,这时就不需要知道原模块输出的函数名。需要注意的是,这时import命令...](https://blog.csdn.net/ixygj197875/article/details/79255447)

#### [ES6中*export*  *default* 命令的详解(引用)_liuguiqian1的..._CSDN博客](https://blog.csdn.net/liuguiqian1/article/details/82712659)

8-10

[//import-*default*.js import customName from './*export*-*default*'; customName(); //'foo' //这是的import命令,可以用任意名称指向*export*-*default*.js输出的方法...](https://blog.csdn.net/liuguiqian1/article/details/82712659)

[qq_36416878的博客](https://blog.csdn.net/qq_36416878)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)3840

#### [*vue* 文件中 name 的*作用*](https://blog.csdn.net/qq_36416878/article/details/80487890)

[*export*  *default* {   name:'xxx'}name的*作用*有三个：1、当项目使用keep-alive时，可搭配组件name进行缓存过滤&lt;div id="app"&gt;  &lt;keep-alive exclude="xxx"&gt;  &lt;router-view/&gt; &lt;/keep-alive&gt;&lt;/div&gt;exclude=&quot...](https://blog.csdn.net/qq_36416878/article/details/80487890)

[分享我的点点滴滴，在成长路上与你同行！](https://blog.csdn.net/hlx20080808)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)8402

#### [*Vue*.js*中的* new *Vue*() 和 *export*  *default* {}区别](https://blog.csdn.net/hlx20080808/article/details/82755582)

[      在生成、导出、导入、使用 *Vue* 组件的时候，常常被位于不同文件的 new *Vue*() 和 *export*  *default*{} 。      首先，*Vue* 是什么？ po 主的理解是 *Vue* 就是一个构造函数，生成的实例是一个巨大的对象，可以包含数据、模板、挂载元素、方法、生命周期钩子等选项。所以渲染的时候，可以使用构造 *Vue* 实例的方式来渲染相应的 html 页面：......](https://blog.csdn.net/hlx20080808/article/details/82755582)

#### [首先要知道*export*,import ,*export*  *default*是什么_愿世..._CSDN博客](https://blog.csdn.net/qq_34531925/article/details/79834463)

8-11

[使用*export*  *default*命令,为模块指定默认输出,这样就不需要知道所要加载模块的变量名。 var name="李四"; *export* { name } //import { name } from "/.a.js...](https://blog.csdn.net/qq_34531925/article/details/79834463)

#### [【ES6】*export*与*export*  *default*的区别_汪小穆的博客-CS..._CSDN博客](https://blog.csdn.net/w390058785/article/details/83380185)

7-21

[② *export*  *default*输出:*export*  *default*在一个模块中只能使用一次 //test.js const name = 'freddy'; const age = 24; *export*  *default* function(){ //只输出一...](https://blog.csdn.net/w390058785/article/details/83380185)

[不爱吃面的北方人](https://blog.csdn.net/weixin_42731116)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)9309

#### [*Vue*中*export*和*export*  *default*的区别和用法](https://blog.csdn.net/weixin_42731116/article/details/88952235)

[*Vue*是通过webpack实现的模块化，因此可以使用import来引入模块，例如：import *Vue* from '*vue*'import Router from '*vue*-router'import util from '@assets/js/util'此外，你还可以在 bulid/webpack.base.conf.js 文件中修改相关配置：resole:{ ext...](https://blog.csdn.net/weixin_42731116/article/details/88952235)

[Lyntion的Blog](https://blog.csdn.net/Lyntion)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)2万+

#### [U盘防毒最强方案(创建删不掉的autorun.inf文件夹)](https://blog.csdn.net/Lyntion/article/details/39736737)

[病毒，每个人都深受其害，痛恨不已，特别是现在移动设备MP3、MP4、手机、U盘、移动硬盘飞速发展的时代，病毒也随着这些移动设备和网络快速蔓延和滋生，所以如何防止病毒入侵到自己的爱机和移动设备上就太重要了。       在网络上曾经有人提出在硬盘根目录和移动设备根目录下建立一个文件夹，名字就叫autorun.inf，用来防止利用借助autorun.inf文件进行传播的病毒。       ...](https://blog.csdn.net/Lyntion/article/details/39736737)

#### [首先要知道*export*,import ,*export*  *default*是什么_开发..._CSDN博客](https://blog.csdn.net/qq_36838191/article/details/80796353)

4-25

[使用*export*  *default*命令,为模块指定默认输出,这样就不需要知道所要加载模块的变量名。 var name="李四"; *export* { name } //import { name } from "/.a.js...](https://blog.csdn.net/qq_36838191/article/details/80796353)

#### [ES6中*export*  *default* 与*export*区别_高先生的猫-CSDN博客](https://blog.csdn.net/z591102/article/details/107511618)

7-22

[说明*export*与*export*  *default*均可用于导出常量、函数、文件、模块等,有什么区别呢?*export*的方式 - 1次导出1个或者多个//a.js*export* const name = 猫宝宝;*export* ...](https://blog.csdn.net/z591102/article/details/107511618)

 ©️2020 CSDN  皮肤主题: 编程工作室   设计师: CSDN官方博客     [返回首页](https://blog.csdn.net/)

 [关于我们](https://www.csdn.net/company/index.html#about)  [招聘](https://www.csdn.net/company/index.html#recruit)  [广告服务](https://www.csdn.net/company/index.html#advertisement)  [网站地图](https://www.csdn.net/gather/A)  *  ![](data:image/svg+xml,%3csvg width='16' height='16' xmlns='http://www.w3.org/2000/svg' data-evernote-id='2924' class='js-evernote-checked'%3e%3cpath d='M2.167 2h11.666C14.478 2 15 2.576 15 3.286v9.428c0 .71-.522 1.286-1.167 1.286H2.167C1.522 14 1 13.424 1 12.714V3.286C1 2.576 1.522 2 2.167 2zm-.164 3v1L8 10l6-4V5L8 9 2.003 5z' fill='%23999AAA' fill-rule='evenodd' data-evernote-id='2925' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  [kefu@csdn.net](https://blog.csdn.net/weixin_39015132/article/details/83573896mailto:webmaster@csdn.net)![](data:image/svg+xml,%3csvg t='1538012951761' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23083' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2926' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2927' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2928' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M466.4934485 880.02006511C264.6019863 859.18313878 107.13744214 688.54706608 107.13744214 481.14947309 107.13744214 259.68965394 286.68049114 80.14660493 508.14031029 80.14660493s401.00286817 179.54304901 401.00286814 401.00286816v1.67343191C908.30646249 737.58941724 715.26799489 943.85339507 477.28978337 943.85339507c-31.71423369 0-62.61874229-3.67075386-92.38963569-10.60739903 30.09478346-11.01226158 56.84270313-29.63593923 81.5933008-53.22593095z m-205.13036267-398.87059202a246.77722444 246.77722444 0 0 0 493.5544489 0 30.85052691 30.85052691 0 0 0-61.70105383 0 185.07617062 185.07617062 0 0 1-370.15234125 0 30.85052691 30.85052691 0 0 0-61.70105382 0z' p-id='23084' fill='%23999AAA' data-evernote-id='2929' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  [客服论坛](http://bbs.csdn.net/forums/Service)![](data:image/svg+xml,%3csvg t='1538013874294' width='17' height='17' style='' viewBox='0 0 1194 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23784' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2930' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2931' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2932' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M1031.29689505 943.85339507h-863.70679012A71.98456279 71.98456279 0 0 1 95.60554212 871.86883228v-150.85178906c0-28.58329658 16.92325492-54.46750945 43.13135785-65.93861527l227.99160176-99.75813425c10.55341735-4.61543317 18.24580594-14.0082445 20.72896295-25.23643277l23.21211998-105.53417343a71.95757195 71.95757195 0 0 1 70.28414006-56.51881307h236.95255971c33.79252817 0 63.02360485 23.5090192 70.28414004 56.51881307l23.21211997 105.53417343c2.48315701 11.25517912 10.17554562 20.62099961 20.72896296 25.23643277l227.99160177 99.75813425a71.98456279 71.98456279 0 0 1 43.13135783 65.93861527v150.85178906A71.98456279 71.98456279 0 0 1 1031.26990421 943.85339507z m-431.85339506-143.94213475c143.94213474 0 143.94213474-48.34058941 143.94213474-107.96334876s-64.45411922-107.96334877-143.94213474-107.96334877c-79.51500637 0-143.94213474 48.34058941-143.94213475 107.96334877s0 107.96334877 143.94213475 107.96334876zM1103.254467 296.07330247v148.9894213a35.97878598 35.97878598 0 0 1-44.15700966 35.03410667l-143.94213473-33.57660146a36.0057768 36.0057768 0 0 1-27.80056231-35.03410668V296.1002933c-35.97878598-47.98970852-131.95820302-71.98456279-287.91126031-71.98456279S347.53801649 248.11058478 311.53223967 296.1002933v115.385829c0 16.73431906-11.52508749 31.25538946-27.80056233 35.03410668l-143.94213473 33.57660146A35.97878598 35.97878598 0 0 1 95.63253297 445.06272377V296.07330247C162.81272673 152.13116772 330.77670658 80.14660493 599.47049084 80.14660493s436.63077325 71.98456279 503.81096699 215.92669754z' p-id='23785' fill='%23999AAA' data-evernote-id='2933' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  400-660-0108  ![](data:image/svg+xml,%3csvg t='1538013544186' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23556' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2934' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2935' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2936' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M902.60033922 650.96445566c-18.0718526-100.84369837-94.08399771-166.87723736-94.08399771-166.87723737 10.87530062-91.53186599-28.94715402-107.78733693-28.94715401-107.78733691C771.20003413 93.08221664 517.34798062 98.02553561 511.98620441 98.16348824 506.65661791 98.02553561 252.75857992 93.08221664 244.43541101 376.29988138c0 0-39.79946279 16.25547094-28.947154 107.78733691 0 0-75.98915247 66.03353901-94.0839977 166.87723737 0 0-9.63372291 170.35365477 86.84146124 20.85850523 0 0 21.70461757 56.79068296 61.50407954 107.78733692 0 0-71.1607951 23.19910867-65.11385185 83.46161052 0 0-2.43717093 67.16015592 151.93232126 62.56172014 0 0 108.5460788-8.0932473 141.10300432-52.14626271H526.33792324c32.57991817 44.05301539 141.10300431 52.1462627 141.10300431 52.14626271 154.3235077 4.59843579 151.95071457-62.56172013 151.95071457-62.56172014 6.00095876-60.26250183-65.11385185-83.46161053-65.11385185-83.46161052 39.77647014-50.99665395 61.4810877-107.78733693 61.4810877-107.78733692 96.45219231 149.49514952 86.84146124-20.85850523 86.84146125-20.85850523' p-id='23557' fill='%23999AAA' data-evernote-id='2937' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)[QQ客服（8:30-22:00）](https://url.cn/5epoHIm?_type=wpa&qidian=true)  *

 [公安备案号 11010502030143](http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010502030143)  [京ICP备19004658号](http://beian.miit.gov.cn/publish/query/indexFirst.action)  [京网文〔2020〕1039-165号](https://csdnimg.cn/release/live_fe/culture_license.png)  [版权与免责声明](https://www.csdn.net/company/index.html#statement)  [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)  [网络110报警服务](http://www.cyberpolice.cn/)

 [中国互联网举报中心](http://www.12377.cn/)  [家长监护](https://download.csdn.net/index.php/tutelage/)  [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)  [北京互联网违法和不良信息举报中心](http://www.bjjubao.org/)  [©1999-2020 北京创新乐知网络技术有限公司]()
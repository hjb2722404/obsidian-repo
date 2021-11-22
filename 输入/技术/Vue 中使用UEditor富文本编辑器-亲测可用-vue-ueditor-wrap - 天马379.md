Vue 中使用UEditor富文本编辑器-亲测可用-vue-ueditor-wrap - 天马3798的个人空间 - OSCHINA

##  Vue 中使用UEditor富文本编辑器-亲测可用-vue-ueditor-wrap

原原创

 [ ![2332115_50.jpeg](../_resources/c14bce5b8da223dd4b4dd7c21f2278a8.jpg)     tianma3798](https://my.oschina.net/tianma3798) 发布于 02/18 22:44

字数 686

阅读 1230

收藏 9

[点赞 0]()

[** 评论 0](https://my.oschina.net/tianma3798/blog/3011662#comments)

 [Vue.js](https://my.oschina.net/tianma3798?q=Vue.js)[Ueditor](https://my.oschina.net/tianma3798?q=Ueditor)

[同样是后端开发，年薪50万和年薪20万的差距在哪里>>>](https://my.oschina.net/u/2663968/blog/3120060)  ![hot3.png](../_resources/8cf8007931b1a5944f3a0a243a5afcc4.png)

**一、Vue中在使用Vue CLI开发中默认没法使用UEditor**

其中UEditor中也存在不少错误，再引用过程中。

但是UEditor相对还是比较好用的一个富文本编辑器。

**vue-ueditor-wrap说明**

Vue + UEditor + v-model 双向绑定。之所以有这个 `repo` 的原因是：
 1、UEditor 依然是国内使用频率极高的所见即所得编辑器而 Vue 又有着广泛的使用，所以将两者结合使用，是很多 Vue 项目开发者的切实需求。

 2、目前没有发现满足这种需求，而使用又很方便的 `repo`、有的可能也只是简单的暴露一个 `UEditor` 的实例，仍然需要开发者手动去调用 `getContent`，`setContent`，而通过 `v-model` 绑定数据也是很多人期待的方式。

官方地址：https://github.com/HaoChuan9421/vue-ueditor-wrap

**二、使用步骤**

1.安装vue-editor-wrap

`npm i vue-ueditor-wrap`

2.下载处理后的UEditor，[下载地址](https://github.com/HaoChuan9421/vue-ueditor-wrap/tree/master/assets/downloads)

解压，重命名文件夹为UEditor，放入public文件夹下（如果是旧项目对应static文件夹）。

![d28b34f54bd539f3a8809684ef3405f1d97.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125309.png)

3.引用组件、注册组件

	import VueUeditorWrap from "vue-ueditor-wrap"; // ES6 Module
	export default {
	  name: "app",
	  components: {
	    VueUeditorWrap
	  },
	  data() {
	    return {
	      msg:
	        '<h2><img src="http://img.baidu.com/hi/jx2/j_0003.gif"/>Vue + UEditor + v-model双向绑定!+!$#</h2>',
	      myConfig: {
	        UEDITOR_HOME_URL: "/UEditor/",
	        serverUrl: ""
	      }
	    };
	  },
	  methods: {
	    showOne() {
	      alert(this.msg);
	    }
	  }
	};

4.v-model绑定数据

	<template>
	  <div id="app">
	    <vue-ueditor-wrap v-model="msg" :config="myConfig"></vue-ueditor-wrap>
	    <p>
	      <el-button type="primary" @click="showOne();">获取编辑器内容</el-button>
	    </p>
	  </div>
	</template>

**三、使用说明**

1.根据项目需求修改从组件处修改配置

`<vue-ueditor-wrap v-model="msg" :config="myConfig"></vue-ueditor-wrap>`

	data () {
	  return {
	    msg: '<h2><img src="http://img.baidu.com/hi/jx2/j_0003.gif"/>Vue + UEditor + v-model双向绑定</h2>',
	    myConfig: {
	      // 编辑器不自动被内容撑高
	      autoHeightEnabled: false,
	      // 初始容器高度
	      initialFrameHeight: 240,
	      // 初始容器宽度
	      initialFrameWidth: '100%',
	      // 上传文件接口（这个地址是我为了方便各位体验文件上传功能搭建的临时接口，请勿在生产环境使用！！！）
	      serverUrl: 'http://35.201.165.105:8000/controller.php',
	      // UEditor 资源文件的存放路径，如果你使用的是 vue-cli 生成的项目，通常不需要设置该选项，vue-ueditor-wrap 会自动处理常见的情况，如果需要特殊配置，参考下方的常见问题2
	      UEDITOR_HOME_URL: '/static/UEditor/'
	    }
	  }
	}

2.也可以全局修改vue-ueditor-wrap.vue    源码

![e9b72bcf7072798be94ec518a79baad8133.jpg](../_resources/6fcfb44352c0a56839f27d910b8b7ba0.png)

四、最终显示结果：

![c954f4dfd78334e7a2645ad86e8119d8503.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106125327.png)

更多：

更多问题参考https://github.com/HaoChuan9421/vue-ueditor-wrap

[Vue +Element UI后台管理模板搭建示例](https://my.oschina.net/tianma3798/blog/3010848)

[Vue Element表单绑定（三）综合示例](https://my.oschina.net/tianma3798/blog/3010631)

[ Vue Element表单绑定（三）表单验证2](https://my.oschina.net/tianma3798/blog/3010425)

© 著作权归作者所有
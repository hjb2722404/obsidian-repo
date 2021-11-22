Vue3.0+TS 项目上手教程-技术圈

# Vue3.0+TS 项目上手教程

 [![cps_wx_0173a366010b.jpg!mediumicon](../_resources/235692e1585a153d105a9a509a7aa8bc.jpg) 前端达人](https://jishuin.proginn.com/u/465975)  |  ![BIyHQn5nst.png](../_resources/8e1959705492c225e96bcd7e3d0f5929.png)  152  ![jxqdC7tPN6.png!16X16](../_resources/16fd5f752c7a67faf1ada5652c2d823d.png)   2020-10-12 17:05   ![49lQfeB7kX.png!16X16](../_resources/ba68f31d3563c808c78adb785bd45eca.png)  0  ![good-icon.png](../_resources/cb9c5564f5bf15126a9ba38528173dd9.png)  0  ![collect-icon.png](../_resources/cd81891f9f1d1e771f7171f3a0f65341.png)  0

![69b52ef6c7c49aca8beab5a466847875.webp](../_resources/31e74b4c0e9228f75042c355866d359d.jpg)
> 转自：Vue3拥抱TypeScript的正确姿势 ：https://juejin.im/post/6875713523968802829

## 一个完整的Vue3+Ts项目,支持.vue和.tsx写法

> 项目地址：https://github.com/vincentzyc/vue3-demo.git

` TypeScript ` 是JS的一个超集，主要提供了类型系统和对ES6的支持，使用 ` TypeScript ` 可以增加代码的可读性和可维护性，在 ` react ` 和 ` vue ` 社区中也越来越多人开始使用` TypeScript `。从最近发布的 ` Vue3 ` 正式版本来看， ` Vue3 ` 的源码就是用 ` TypeScript ` 编写的，更好的 ` TypeScript ` 支持也是这一次升级的亮点。当然，在实际开发中如何正确拥抱 ` TypeScript ` 也是迁移至 ` Vue3 ` 的一个小痛点，这里就针对 ` Vue3 ` 和 ` TypeScript ` 展开一些交流。

![0a784b7a478e23ad493e9bde97ae1521.webp](https://gitee.com/hjb2722404/tuchuang/raw/master/img/5ada16b542c5559511b3759f7e959414.png)
> 96.8%的代码都是TypeScript，支持的力度也是相当大?

- Vue3入口: https://github.com/vuejs/vue-next

## 项目搭建

在官方仓库的 Quickstart 中推荐用两种方式方式来构建我们的 ` SPA ` 项目：

- vite

`npm init vite-app sail-vue3 # OR yarn create vite-app sail-vue3[[NEWLINE]]`

- vue-cli

`npm install -g @vue/cli # OR yarn global add @vue/cli[[NEWLINE]]vue create sail-vue3[[NEWLINE]]# select vue 3 preset[[NEWLINE]]`

` vite ` 是一个由原生` ESM `驱动的Web开发构建工具，打开 ` vite ` 依赖的 ` package.json ` 可以发现在 ` devDependencies ` 开发依赖里面已经引入了` TypeScript ` ，甚至还有 ` vuex ` , ` vue-router ` , ` less ` , ` sass ` 这些本地开发经常需要用到的工具。` vite ` 轻量，开箱即用的特点，满足了大部分开发场景的需求，作为快速启动本地 ` Vue ` 项目来说，这是一个非常完美的工具。

> 后面的演示代码也是用vite搭的

从 ` vue2.x ` 走过来的掘友肯定知道 ` vue-cli ` 这个官方脚手架， ` vue3 ` 的更新怎么能少得了 ` vue-cli ` 呢， ` vue-cli ` 更强调的是用 ` cli ` 的方式进行交互式的配置，选择起来更加灵活可控。丰富的官方插件适配，GUI的创建管理界面，标准化开发流程，这些都是 ` vue-cli ` 的特点。

- vue-cli ✖ TypeScript STEP1

![eeccfe443e69470ea3f24c2435e1da66.webp](https://gitee.com/hjb2722404/tuchuang/raw/master/img/4b835f112df1c195824441083346219b.png)

- vue-cli ✖ TypeScript STEP2

![96b0facdcf01870ff3f728b1db0037c4.webp](https://gitee.com/hjb2722404/tuchuang/raw/master/img/40dd988af2c264f99646d3cb471c77a3.png)
> 想要预装TypeScript，就需要选择手动配置，并check好TypeScript
忘记使用选择 ` TypeScript ` 也没事，加一行cli命令就行了
`vue add typescript[[NEWLINE]]`
最后，别忘了在 ` .vue ` 代码中，给 ` script ` 标签加上 ` lang="ts" `
`<script lang="ts">[[NEWLINE]]`

## Option API风格

在 ` Vue2.x ` 使用过 ` TypeScript ` 的掘友肯定知道引入 ` TypeScript ` 不是一件简单的事情：
1. 要用 ` vue-class-component ` 强化 ` vue ` 组件，让 ` Script ` 支持 ` TypeScript ` 装饰器
2. 用 ` vue-property-decorator ` 来增加更多结合 ` Vue ` 特性的装饰器
3. 引入 ` ts-loader ` 让 ` webpack ` 识别 ` .ts ` ` .tsx ` 文件
4. .....
然后出来的代码风格是这样的：

`@Component({[[NEWLINE]]    components:{ componentA, componentB},[[NEWLINE]]})[[NEWLINE]]export default class Parent extends Vue{[[NEWLINE]]  @Prop(Number) readonly propA!: number | undefined[[NEWLINE]]  @Prop({ default: 'default value' }) readonly propB!: string[[NEWLINE]]  @Prop([String, Boolean]) readonly propC!: string | boolean | undefined[[NEWLINE]][[NEWLINE]]  // data信息[[NEWLINE]]  message = 'Vue2 code style'[[NEWLINE]][[NEWLINE]]  // 计算属性[[NEWLINE]]  private get reversedMessage (): string[] {[[NEWLINE]]      return this.message.split(' ').reverse().join('')[[NEWLINE]]  }[[NEWLINE]][[NEWLINE]]  // method[[NEWLINE]]  public changeMessage (): void {[[NEWLINE]]    this.message = 'Good bye'[[NEWLINE]]  }[[NEWLINE]]}[[NEWLINE]]`

` class ` 风格的组件，各种装饰器穿插在代码中，有点感觉自己不是在写 ` vue ` ，些许凌乱?，所以这种曲线救国的方案在 ` vue3 ` 里面肯定是行不通的。

在 ` vue3 ` 中可以直接这么写：

`import { defineComponent, PropType } from 'vue'[[NEWLINE]][[NEWLINE]]interface Student {[[NEWLINE]]  name: string[[NEWLINE]]  class: string[[NEWLINE]]  age: number[[NEWLINE]]}[[NEWLINE]][[NEWLINE]]const Component = defineComponent({[[NEWLINE]]  props: {[[NEWLINE]]    success: { type: String },[[NEWLINE]]    callback: {[[NEWLINE]]      type: Function as PropType<() => void>[[NEWLINE]]    },[[NEWLINE]]    student: {[[NEWLINE]]      type: Object as PropType,[[NEWLINE]]      required: true[[NEWLINE]]    }[[NEWLINE]]  },[[NEWLINE]]  data() {[[NEWLINE]]     return {[[NEWLINE]]        message: 'Vue3 code style'[[NEWLINE]]    }[[NEWLINE]]  },[[NEWLINE]]  computed: {[[NEWLINE]]    reversedMessage(): string {[[NEWLINE]]      return this.message.split(' ').reverse().join('')[[NEWLINE]]    }[[NEWLINE]]  }[[NEWLINE]]})[[NEWLINE]]`

` vue ` 对 ` props ` 进行复杂类型验证的时候，就直接用 ` PropType ` 进行强制转换， ` data ` 中返回的数据也能在不显式定义类型的时候推断出大多类型， ` computed ` 也只用返回类型的计算属性即可，代码清晰，逻辑简单，同时也保证了 ` vue ` 结构的完整性。

## Composition API风格

在 ` vue3 ` 的 ` Composition API ` 代码风格中，比较有代表性的api就是 ` ref ` 和 ` reactive `，我们看看这两个是如何做类型声明的：

### ref

`import { defineComponent, ref } from 'vue'[[NEWLINE]][[NEWLINE]]const Component = defineComponent({[[NEWLINE]]setup() {[[NEWLINE]]  const year = ref(2020)[[NEWLINE]]  const month = ref('9')[[NEWLINE]][[NEWLINE]]  month.value = 9 // OK[[NEWLINE]]  const result = year.value.split('') // => Property 'split' does not exist on type 'number'[[NEWLINE]] }[[NEWLINE]]})[[NEWLINE]]`

分析上面的代码，可以发现如果我们不给定 ` ref ` 定义的类型的话， ` vue3 ` 也能根据初始值来进行类型推导，然后需要指定复杂类型的时候简单传递一个泛型即可。

> Tips：如果只有setup方法的话，可以直接在defineComponent中传入setup函数

`const Component = defineComponent(() => {[[NEWLINE]]    const year = ref(2020)[[NEWLINE]]    const month = ref('9')[[NEWLINE]][[NEWLINE]]    month.value = 9 // OK[[NEWLINE]]    const result = year.value.split('') // => Property 'split' does not exist on type 'number'[[NEWLINE]]})[[NEWLINE]]`

### reactive

`import { defineComponent, reactive } from 'vue'[[NEWLINE]][[NEWLINE]]interface Student {[[NEWLINE]]  name: string[[NEWLINE]]  class?: string[[NEWLINE]]  age: number[[NEWLINE]]}[[NEWLINE]][[NEWLINE]]export default defineComponent({[[NEWLINE]]  name: 'HelloWorld',[[NEWLINE]]  setup() {[[NEWLINE]]    const student = reactive({ name: '阿勇', age: 16 })[[NEWLINE]]    // or[[NEWLINE]]    const student: Student = reactive({ name: '阿勇', age: 16 })[[NEWLINE]]    // or[[NEWLINE]]    const student = reactive({ name: '阿勇', age: 16, class: 'cs' }) as Student[[NEWLINE]]  }[[NEWLINE]]})[[NEWLINE]]`

声明 ` reactive ` 的时候就很推荐使用接口了，然后怎么使用类型断言就有很多种选择了，这是 ` TypeScript ` 的语法糖，本质上都是一样的。

## 自定义Hooks

` vue3 ` 借鉴 ` react hooks ` 开发出了 ` Composition API ` ，那么也就意味着 ` Composition API ` 也能进行自定义封装 ` hooks ` ，接下来我们就用 ` TypeScript ` 风格封装一个计数器逻辑的 ` hooks ` （ ` useCount ` ）:

首先来看看这个 ` hooks ` 怎么使用：

`import { ref } from '/@modules/vue'[[NEWLINE]]import  useCount from './useCount'[[NEWLINE]][[NEWLINE]]export default {[[NEWLINE]]  name: 'CountDemo',[[NEWLINE]]  props: {[[NEWLINE]]    msg: String[[NEWLINE]]  },[[NEWLINE]]  setup() {[[NEWLINE]]    const { current: count, inc, dec, set, reset } = useCount(2, {[[NEWLINE]]      min: 1,[[NEWLINE]]      max: 15[[NEWLINE]]    })[[NEWLINE]]    const msg = ref('Demo useCount')[[NEWLINE]][[NEWLINE]]    return {[[NEWLINE]]      count,[[NEWLINE]]      inc,[[NEWLINE]]      dec,[[NEWLINE]]      set,[[NEWLINE]]      reset,[[NEWLINE]]      msg[[NEWLINE]]    }[[NEWLINE]]  }[[NEWLINE]]}[[NEWLINE]]`

出来的效果就是：
![f793e94cc3482b75eb3961667bf768e7.webp](https://gitee.com/hjb2722404/tuchuang/raw/master/img/30b558edcab2711150a124c0b5b430a9.gif)
贴上 ` useCount ` 的源码：

`import { ref, Ref, watch } from 'vue'[[NEWLINE]][[NEWLINE]]interface Range {[[NEWLINE]]  min?: number,[[NEWLINE]]  max?: number[[NEWLINE]]}[[NEWLINE]][[NEWLINE]]interface Result {[[NEWLINE]]  current: Ref,[[NEWLINE]]  inc: (delta?: number) => void,[[NEWLINE]]  dec: (delta?: number) => void,[[NEWLINE]]  set: (value: number) => void,[[NEWLINE]]  reset: () => void[[NEWLINE]]}[[NEWLINE]][[NEWLINE]]export default function useCount(initialVal: number, range?: Range): Result {[[NEWLINE]]  const current = ref(initialVal)[[NEWLINE]]  const inc = (delta?: number): void => {[[NEWLINE]]    if (typeof delta === 'number') {[[NEWLINE]]      current.value += delta[[NEWLINE]]    } else {[[NEWLINE]]      current.value += 1[[NEWLINE]]    }[[NEWLINE]]  }[[NEWLINE]]  const dec = (delta?: number): void => {[[NEWLINE]]    if (typeof delta === 'number') {[[NEWLINE]]      current.value -= delta[[NEWLINE]]    } else {[[NEWLINE]]      current.value -= 1[[NEWLINE]]    }[[NEWLINE]]  }[[NEWLINE]]  const set = (value: number): void => {[[NEWLINE]]    current.value = value[[NEWLINE]]  }[[NEWLINE]]  const reset = () => {[[NEWLINE]]    current.value = initialVal[[NEWLINE]]  }[[NEWLINE]][[NEWLINE]]  watch(current, (newVal: number, oldVal: number) => {[[NEWLINE]]    if (newVal === oldVal) return[[NEWLINE]]    if (range && range.min && newVal < range.min) {[[NEWLINE]]      current.value = range.min[[NEWLINE]]    } else if (range && range.max && newVal > range.max) {[[NEWLINE]]      current.value = range.max[[NEWLINE]]    }[[NEWLINE]]  })[[NEWLINE]][[NEWLINE]]  return {[[NEWLINE]]    current,[[NEWLINE]]    inc,[[NEWLINE]]    dec,[[NEWLINE]]    set,[[NEWLINE]]    reset[[NEWLINE]]  }[[NEWLINE]]}[[NEWLINE]]`

分析源码

这里首先是对 ` hooks ` 函数的入参类型和返回类型进行了定义，入参的 ` Range ` 和返回的 ` Result ` 分别用一个接口来指定，这样做了以后，最大的好处就是在使用 ` useCount ` 函数的时候，ide就会自动提示哪些参数是必填项，各个参数的类型是什么，防止业务逻辑出错。

![fee63a473a0cd0d995e1509db7e37ec2.webp](https://gitee.com/hjb2722404/tuchuang/raw/master/img/e22bb0ee6143d7c15d24af50da3f9c8f.png)

接下来，在增加 ` inc ` 和减少 ` dec ` 的两个函数中增加了 ` typeo ` 类型守卫检查，因为传入的 ` delta ` 类型值在某些特定场景下不是很确定，比如在 ` template ` 中调用方法的话，类型检查可能会失效，传入的类型就是一个原生的 ` Event ` 。

关于 ` ref ` 类型值，这里并没有特别声明类型，因为 ` vue3 ` 会进行自动类型推导，但如果是复杂类型的话可以采用类型断言的方式：` ref(initObj) as Ref `

## 小建议 ?

AnyScript

在初期使用 ` TypeScript ` 的时候，很多掘友都很喜欢使用 ` any ` 类型，硬生生把` TypeScript ` 写成了 ` AnyScript ` ，虽然使用起来很方便，但是这就失去了 ` TypeScript ` 的类型检查意义了，当然写类型的习惯是需要慢慢去养成的，不用急于一时。

Vetur

` vetur ` 代码检查工具在写vue代码的时候会非常有用，就像构建 ` vue ` 项目少不了 ` vue-cli `一样，` vetur ` 提供了 ` vscode ` 的插件支持，赶着升级 ` vue3 ` 这一波工作，顺带也把 ` vetur ` 也带上吧。

![065c2b057d3b0adb23f80838509401fd.webp](https://gitee.com/hjb2722404/tuchuang/raw/master/img/d5db2a481e8cb626e07eb04ea389315b.png)

## 一个完整的Vue3+ts项目

`├─public[[NEWLINE]]│      favicon.ico[[NEWLINE]]│      index.html[[NEWLINE]]└─src[[NEWLINE]]    │  App.vue[[NEWLINE]]    │  main.ts[[NEWLINE]]    │  shims-vue.d.ts[[NEWLINE]]    ├─assets[[NEWLINE]]    │  │  logo.png[[NEWLINE]]    │  └─css[[NEWLINE]]    │          base.css[[NEWLINE]]    │          main.styl[[NEWLINE]]    ├─components[[NEWLINE]]    │  │  HelloWorld.vue[[NEWLINE]]    │  └─base[[NEWLINE]]    │          Button.vue[[NEWLINE]]    │          index.ts[[NEWLINE]]    │          Select.vue[[NEWLINE]]    ├─directive[[NEWLINE]]    │      focus.ts[[NEWLINE]]    │      index.ts[[NEWLINE]]    │      pin.ts[[NEWLINE]]    ├─router[[NEWLINE]]    │      index.ts[[NEWLINE]]    ├─store[[NEWLINE]]    │      index.ts[[NEWLINE]]    ├─utils[[NEWLINE]]    │  │  cookie.ts[[NEWLINE]]    │  │  deep-clone.ts[[NEWLINE]]    │  │  index.ts[[NEWLINE]]    │  │  storage.ts[[NEWLINE]]    │  └─validate[[NEWLINE]]    │          date.ts[[NEWLINE]]    │          email.ts[[NEWLINE]]    │          mobile.ts[[NEWLINE]]    │          number.ts[[NEWLINE]]    │          system.ts[[NEWLINE]]    └─views[[NEWLINE]]        │  About.vue[[NEWLINE]]        │  Home.vue[[NEWLINE]]        │  LuckDraw.vue[[NEWLINE]]        │  TodoList.vue[[NEWLINE]]        └─address[[NEWLINE]]                AddressEdit.tsx[[NEWLINE]]                AddressList.tsx[[NEWLINE]]`

- .vue写法

`[[NEWLINE]][[NEWLINE]]"ts">[[NEWLINE]]import dayjs from "dayjs";[[NEWLINE]]import { ref, reactive, onMounted } from "vue";[[NEWLINE]]import { Button, Step, Steps, NoticeBar } from "vant";[[NEWLINE]][[NEWLINE]]export default {[[NEWLINE]]  components: {[[NEWLINE]]    Button,[[NEWLINE]]    Step,[[NEWLINE]]    Steps,[[NEWLINE]]    NoticeBar,[[NEWLINE]]  },[[NEWLINE]]  setup() {[[NEWLINE]]    const nameinput = ref();[[NEWLINE]]    const selectionStart = ref(0);[[NEWLINE]]    const twoNow = dayjs().subtract(2, "day").format("YYYY-MM-DD HH:mm:ss");[[NEWLINE]]    const now = dayjs().format("YYYY-MM-DD HH:mm:ss");[[NEWLINE]]    const now2 = dayjs().add(2, "day").format("YYYY-MM-DD HH:mm:ss");[[NEWLINE]]    const formData = reactive({[[NEWLINE]]      name: "",[[NEWLINE]]      phone: "",[[NEWLINE]]      code: "",[[NEWLINE]]    });[[NEWLINE]][[NEWLINE]]    onMounted(() => {[[NEWLINE]]      (nameinput.value as HTMLInputElement).focus();[[NEWLINE]]    });[[NEWLINE]][[NEWLINE]]    const insertName = () => {[[NEWLINE]]      const index = (nameinput.value as HTMLInputElement).selectionStart;[[NEWLINE]]      if (typeof index !== "number") return;[[NEWLINE]]      formData.name =[[NEWLINE]]        formData.name.slice(0, index) + "哈哈" + formData.name.slice(index);[[NEWLINE]]    };[[NEWLINE]][[NEWLINE]]    return {[[NEWLINE]]      nameinput,[[NEWLINE]]      formData,[[NEWLINE]]      insertName,[[NEWLINE]]      selectionStart,[[NEWLINE]]      twoNow,[[NEWLINE]]      now,[[NEWLINE]]      now2,[[NEWLINE]]    };[[NEWLINE]]  },[[NEWLINE]]};[[NEWLINE]][[NEWLINE]]`

`[[NEWLINE]][[NEWLINE]]"ts">[[NEWLINE]]import dayjs from "dayjs";[[NEWLINE]]import { defineComponent } from "vue";[[NEWLINE]]import HelloWorld from "@/components/HelloWorld.vue"; // @ is an alias to /src[[NEWLINE]]import { Button, Dialog, Toast } from "vant";[[NEWLINE]][[NEWLINE]]export default defineComponent({[[NEWLINE]]  name: "Home",[[NEWLINE]]  components: {[[NEWLINE]]    HelloWorld,[[NEWLINE]]    Button,[[NEWLINE]]  },[[NEWLINE]]  data() {[[NEWLINE]]    return {[[NEWLINE]]      direction: "top",[[NEWLINE]]      pinPadding: 0,[[NEWLINE]]      time: "",[[NEWLINE]]      timer: 0,[[NEWLINE]]      color: "red",[[NEWLINE]]    };[[NEWLINE]]  },[[NEWLINE]]  methods: {[[NEWLINE]]    showToast() {[[NEWLINE]]      Toast("字体颜色已改蓝色");[[NEWLINE]]      this.color = "blue";[[NEWLINE]]    },[[NEWLINE]]    handleClick() {[[NEWLINE]]      Dialog({[[NEWLINE]]        title: "标题",[[NEWLINE]]        message: "这是一个全局按钮组件",[[NEWLINE]]      });[[NEWLINE]]    },[[NEWLINE]]    initTime() {[[NEWLINE]]      this.time = dayjs().format("YYYY-MM-DD HH:mm:ss");[[NEWLINE]]      this.timer = setInterval(() => {[[NEWLINE]]        this.time = dayjs().format("YYYY-MM-DD HH:mm:ss");[[NEWLINE]]      }, 1000);[[NEWLINE]]    },[[NEWLINE]]  },[[NEWLINE]]  created() {[[NEWLINE]]    this.initTime();[[NEWLINE]]  },[[NEWLINE]]  beforeUnmount() {[[NEWLINE]]    clearInterval(this.timer);[[NEWLINE]]  },[[NEWLINE]]});[[NEWLINE]][[NEWLINE]][[NEWLINE]]"{ color }">[[NEWLINE]].text-color {[[NEWLINE]]  color: var(--color);[[NEWLINE]]}[[NEWLINE]][[NEWLINE]]`

- tsx写法

`import { ref, reactive } from "vue";[[NEWLINE]]import { AddressList, NavBar, Toast, Popup } from "vant";[[NEWLINE]]import AddressEdit from './AddressEdit'[[NEWLINE]]import router from '@/router'[[NEWLINE]][[NEWLINE]]export default {[[NEWLINE]]  setup() {[[NEWLINE]]    const chosenAddressId = ref('1')[[NEWLINE]]    const showEdit = ref(false)[[NEWLINE]][[NEWLINE]]    const list = reactive([[[NEWLINE]]      {[[NEWLINE]]        id: '1',[[NEWLINE]]        name: '张三',[[NEWLINE]]        tel: '13000000000',[[NEWLINE]]        address: '浙江省杭州市西湖区文三路 138 号东方通信大厦 7 楼 501 室',[[NEWLINE]]        isDefault: true,[[NEWLINE]]      },[[NEWLINE]]      {[[NEWLINE]]        id: '2',[[NEWLINE]]        name: '李四',[[NEWLINE]]        tel: '1310000000',[[NEWLINE]]        address: '浙江省杭州市拱墅区莫干山路 50 号',[[NEWLINE]]      },[[NEWLINE]]    ])[[NEWLINE]]    const disabledList = reactive([[[NEWLINE]]      {[[NEWLINE]]        id: '3',[[NEWLINE]]        name: '王五',[[NEWLINE]]        tel: '1320000000',[[NEWLINE]]        address: '浙江省杭州市滨江区江南大道 15 号',[[NEWLINE]]      },[[NEWLINE]]    ])[[NEWLINE]][[NEWLINE]]    const onAdd = () => {[[NEWLINE]]      showEdit.value = true[[NEWLINE]]    }[[NEWLINE]]    const onEdit = (item: any, index: string) => {[[NEWLINE]]      Toast('编辑地址:' + index);[[NEWLINE]]    }[[NEWLINE]][[NEWLINE]]    const onClickLeft = () => {[[NEWLINE]]      router.back()[[NEWLINE]]    }[[NEWLINE]][[NEWLINE]]    const onClickRight = () => {[[NEWLINE]]      router.push('/todoList')[[NEWLINE]]    }[[NEWLINE]][[NEWLINE]]    return () => {[[NEWLINE]]      return ([[NEWLINE]]        [[NEWLINE]]                      title="地址管理"[[NEWLINE]]            left-text="返回"[[NEWLINE]]            right-text="Todo"[[NEWLINE]]            left-arrow[[NEWLINE]]            onClick-left={onClickLeft}[[NEWLINE]]            onClick-right={onClickRight}[[NEWLINE]]          />[[NEWLINE]]                      vModel={chosenAddressId.value}[[NEWLINE]]            list={list}[[NEWLINE]]            disabledList={disabledList}[[NEWLINE]]            disabledText="以下地址超出配送范围"[[NEWLINE]]            defaultTagText="默认"[[NEWLINE]]            onAdd={onAdd}[[NEWLINE]]            onEdit={onEdit}[[NEWLINE]]          />[[NEWLINE]]          [[NEWLINE]]            [[NEWLINE]]          [[NEWLINE]]        [[NEWLINE]]      );[[NEWLINE]]    };[[NEWLINE]]  }[[NEWLINE]]};[[NEWLINE]]`

## 结束

不知不觉， ` Vue ` 都到3的One Piece时代了， ` Vue3 ` 的新特性让拥抱 ` TypeScript ` 的姿势更加从容优雅， ` Vue ` 面向大型项目开发也更加有底气了。

最近发现一个好网站，不需要梯子就能看Google Cloud Next ’20大会的视频和技术干货，速戳:**https://sourl.cn/AnzYaG（点击阅读原文）**

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='100%25' style='vertical-align: middle%3bmax-width: 100%25%3bwidth: 100%25%3bbox-sizing: border-box%3b' data-evernote-id='1167' class='js-evernote-checked'%3e%3c/svg%3e)

专注分享当下最实用的前端技术。关注前端达人，与达人一起学习进步！
长按关注"前端达人"
![170af21187678ced54f059d28de51840.webp](../_resources/071ec86329f247ce73ea43463a5acc6a.gif)
![019bf9ac68f2a6d37fc943a14e79485d.webp](../_resources/4b8b0d0db2f61d3cf65d8e7ce8045537.jpg)

 ![good-icon.png](../_resources/ba9b66fe1d23f1adc76dff38c6b8dd74.png)  0
 赞

 ![collect-icon.png](../_resources/749ab19b28f449217030451e88fc7e87.png)  0
 收藏
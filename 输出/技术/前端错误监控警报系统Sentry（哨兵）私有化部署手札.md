## 1.What —— sentry 是什么

它是一个前端错误监控警报系统。

对于一个前端应用，即使经过开发自测——>前端团队内部评审——>测试团队测试后，仍然无法完全避免线上出现的错误，比如网络请求错误、前端逻辑异常等。

`sentry` 可以监控前端应用的线上运行，当用户在使用应用的过程中遇到应用报错时（有时页面可能没反应，但报错会在控制台出现），它可以及时将错误信息上报给`sentry`的服务端程序，服务端程序可以通过开发者自定义的方式（比如，邮件、钉钉等）及时向开发者报警，并给出详细的错误信息。

当然，它还有其它一些丰富的报表功能，以及与常用的工作流工具的协作（比如JIRA、git、jekins）等。

## 2. How—— 如何部署

尽管 `sentry`官方提供了可以在线使用的服务，但官方服务具有很多限制，有些服务则需要付费使用：

![image-20210830161721635](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830161722.png)



好消息是，`sentry`是一个开源软件，如果自己部署的话，就可以使用它的完整功能了。接下来，记录一下部署过程。

### 2.1 服务器环境配置

要私有化部署`sentry`，需要一台自己的服务器，对于服务器的要求有：

* 安装了`Git`；
* 安装了 `docker`，版本号大于`19.03.6`
* 安装了`docker-compose`，版本号大于`1.28.0`
* 最好是 4 核 CPU 和 8GB RAM
* 磁盘剩余空间不得小于20GB。

如果`windows10`系统，可以

* 安装`docker-desktop`，到[这里下载](https://www.docker.com/products/docker-desktop)
* 安装 `windows terminal`，直接在`win0`应用商城搜索安装
* 配置电脑BIOS，开启虚拟化。（根据不同电脑机型自行百度解决）
* 配置开启`Hyper-v`

然后运行`docker-desktop`，打开`windows Terminal`，输入`wsl`，进行`windows`的`linux`子系统进行操作。

### 2.2 从 [github](https://github.com/getsentry/onpremise/) 克隆`sentry`自部署仓库：

```bash
$ git clone https://github.com/getsentry/onpremise/
```

### 2.3 进行自动部署(需要系统用户root权限)

```bash
$ cd onpremise

$ ./install.sh
```

脚本会自动根据仓库中的配置来下载所有需要的服务的镜像，并构建为`docker`容器应用。下载的过程根据网速不同可能耗时不同，有时时间会比较长，需要耐心等待。

如果服务器网络环境不好，尤其是与`github`或`docker`镜像仓库的连接状态不太好的时候，可能会执行失败，可以在网络情况好的时候重试几次。

在安装过程中，终端会询问你，让你设置一个`sentry` 后台的管理员账号和密码。

### 2.4  启动`docker` 集群

下载安装成功后，还是在安装的目录，启动`docker`服务集群：

``` bash
$ docker compose up -d
```

这个过程中，有些服务可能会启动不成功，很大可能是权限问题，可以根据报错信息，自行百度解决。

### 2.5 访问`sentry`后台

所有服务都启动成功后，就可以访问`sentry`后台了，后台默认运行在服务器的`9000`端口，这里的账户密码就是安装时让你设置的那个。

![image-20210830163337632](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830163338.png)



登录后，就可以看到`setry`的管理后台了：

![image-20210830163521962](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830163522.png)

默认是英文界面，可以在设置里改为中文。

## 3.  Where —— 哪里监控

后台是我们查看应用已经发出的错误报警和相关信息的地方，那么，我们在哪里进行监控呢。我们以`vue`项目为例，演示一下如何接入监控。

### 3.1 在后台新建项目

1. 在项目后台【项目】面板创建项目

![image-20210830164026991](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830164027.png)



2. 选择项目的平台类型，我们这里选择`Vue`，填写项目名称，项目所属团队，就可以创建项目了。

![image-20210830164152845](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830164153.png)

3. 选择平台，生成对应配置方案

   ![image-20210830164343039](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830164343.png)

   ![image-20210830164413314](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830164413.png)

然后就生成了对应类型项目的配置方法和配置代码。

### 3.2 在自己的项目中粘贴配置代码

进入自己的项目，找到入口文件，一般为`main.js`，将上一步生成的配置方案中给出的配置代码粘贴到自己的入口文件中：

![image-20210830164705350](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830164705.png)

![image-20210830164735223](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830164735.png)

这样就完成了。

### 3.3 查看错误报错信息

运行自己的项目应用，当应用在访问出现报错时，`sentry`后台就可以收到应用上报的报警信息了：

![image-20210830164916377](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830164917.png)

上图中，红框框住的就是当应用请求服务器失败时（500）上报的错误，如果有多个相同的报错，这里只会显示一个，而在后面事件一列列出重复报错的次数。

点击该报错信息，可以进入错误信息详情：

![image-20210830165302509](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830165302.png)



![image-20210830165245311](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830165245.png)



这里有用户的IP、浏览器版本、系统类型、错误跟踪栈等丰富的可以帮助开发者排查错误的信息。

## 4. Who—— 通知到人

当出现报警信息时，我们最终的目的是第一时间通知到开发人员，由开发人员根据报错信息及时修复问题。

有两种通知方式。

### 4.1 邮件通知

邮件通知可以通知到每个开发者个人（当然，也可以同时给所有人发邮件），并且通过`sentry`后台，配置详细的通知策略，比如遇到哪种问题才通知，同样的错误多久通知一次，程序指定模块报错通知哪个开发人员等等。

这里只介绍下如何配置邮件通知功能。

默认情况下，是无法正常通知的，需要我们对服务器上的`sentry`配置进行修改。

进入到服务器的`sentry`安装目录，找到`sentry/config.yml`文件，找到`Mail Server`部分，配置邮件发送服务的信息：

```yaml
###############
# Mail Server #
###############

mail.backend: 'smtp'  # Use dummy if you want to disable email entirely
mail.host: 'smtp.qq.com'
mail.port: 25
mail.username: '391655435@qq.com'
mail.password: 'xxxxxxxxxxxxxx'
mail.use-tls: true
# The email address to send on behalf of
mail.from: '391655435@qq.com'
```

然后在安装目录下重启`docker`集群

```bash
$ docker-compose restart
```

然后进入`sentry`后台，进行测试：

![image-20210830171026348](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830171026.png)

![image-20210830171101817](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830171102.png)



配置没有错的话，管理员的邮箱里就能够收到一封测试邮件了

![image-20210830171245569](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830171246.png)

然后就可以在项目的【警报】面板去配置具体的通知策略了。（详见第5小节）

![image-20210830171754767](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830171755.png)



### 4.2 钉钉通知

当`sentry`后台收到报警信息时，还可以将报警信息发送到钉钉群里。

1. 在要介绍的群里新建【`webhook`】类型的机器人助手，新建后拿到`webhook`地址中的`access_token`值。
2. 在`sentry`后台的【设置】面板中的【integrations】列表里找到`DingDing`插件，点击为指定项目进行配置：

![image-20210830172228687](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830172229.png)

![image-20210830172429743](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830172429.png)

![image-20210830172357855](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830172358.png)

填入第1步获取到的`access_token`，保存后即可。

在应用报错后，对应钉钉群就会接收到相应的报警信息：

![image-20210830172559171](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210830172559.png)

点击【详细信息】按钮即可进入`sentry`后台的报错信息详细页面。



### 如何安装钉钉插件

默认情况下，`sentry`后台【设置】面板的【integrations】列表里是没有【钉钉】插件的，需要我们在服务器上进行配置安装。

```yaml
// 安装目录：vi sentry/Dockerfile
//  添加
RUN pip install sentry-10-dingding

// cd /usr/src/sentry  如果没有，新建
// vi requirements.txt 如果没有，新建
// 添加
redis-py-cluster==1.3.4

// 安装目录，重新构建
docker-compose down
docker-compose build
docker-compose up -d
```



## 5. When—— 何时通知

有时候，我们并不希望`sentry`捕捉到任何一个问题都给我们发送邮件和钉钉通知，而是在我们指定的某种场景下才发送通知，这就需要我们进行详细的警报规则配置。

![image-20210907173123623](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210907173123.png)

 当我们准备新建警报规则时，有两种警报规则类型可供我们配置：

![image-20210907173219383](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210907173219.png)



* Metric Albert（指标警报）： 我们可以给一些指标设置一个阈值，超过这个阈值，`sentry`才会发送警报通知。
* Issue Albert（问题警报）： 我们可以针对`sentry`捕捉到的问题设置一些过滤条件，只有当某些情况下捕捉到问题才发送警报通知。

下面我们将详细介绍两种规则的各个字段代表的意思。

### 5.1 指标警报

![image-20210913150327660](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210913150328.png)

指标警报分为六个区块，它们的作用分别是：

1. 指标来源类型。有两种类型，一种为错误事件指标，一种为事务指标。

   * 错误事件指标指我们应用中发生错误时上报给`sentry`的各种错误详情数据。

   * 事务指标指我们应用中配置的一些性能监控指标，比如某个组件的加载时间等。

     比如我们可以在应用中接入`sentry`时，传入对组件性能监控的选项：

     ```javascript
     Sentry.init({
       Vue,
       tracesSampleRate: 0.1,
       trackComponents: ["Header", "Navigation", "Footer"],
       hooks: ["create", "mount"],
     });
     ```

     这个配置允许我们监控`Header`/`Navigation`/`Footer`三个组件创建与加载时的性能指标，当这三个组件加载后，应用就会将它们的加载性能数据上报给`sentry`.

2. 指标图示。以山峰图的形式展示一定时间段内的监控到的数据。

3. 指标过滤条件。设置哪些指标超过规定阈值时发出警报。

   * 标签过滤器，指定标签为指定值时符合条件

   | 序号 | 条件标签                         | 描述                                                       |
   | :--- | :------------------------------- | ---------------------------------------------------------- |
   | 0    | 'client_os:'                     | 客户端系统，例如：`Windows 8`                              |
   | 1    | 'os:'                            | 服务端系统版本，例如：`Windows 10`                         |
   | 2    | 'client_os.name:'                | 操作系统名称，例如：`Windows`                              |
   | 3    | 'logger:'                        | 上报者平台语言：例如：`javascript`                         |
   | 4    | 'user:'                          | 用户：例如` id:8 `或者 `ip: 192.0.0.1`                     |
   | 5    | 'transaction:'                   | 错误发生在哪个服务，例如： http://xxx.com/editingCenter.js |
   | 6    | 'device.family:'                 | 设备所属家族，例如： `Mac`                                 |
   | 7    | 'device:'                        | 设备名称，例如： `Mac`                                     |
   | 8    | 'server_name:'                   | 服务名称，例如： `web01.example.org`                       |
   | 9    | 'os.name:'                       | 操作系统名称，例如：`Mac OS X"`                            |
   | 10   | 'release:'                       | 错误所属发行版本，例如： `1.1.0`                           |
   | 11   | 'browser:'                       | 浏览器版本，例如：`Chrome 92.0.4515`                       |
   | 12   | 'level:'                         | 错误级别，例如： `info`/`error`                            |
   | 13   | 'browser.name:'                  | 浏览器名称，例如： `chrome`                                |
   | 14   | 'url:'                           | 错误发生的URL                                              |
   | 15   | 'measurements.fp:'               | 测量指标，首屏渲染时间                                     |
   | 16   | 'measurements.fcp:'              | 测量指标，首屏内容渲染时间                                 |
   | 17   | 'measurements.lcp:'              | 测量指标，最大内容渲染时间                                 |
   | 18   | 'measurements.fid:'              | 测量指标，首次输入延迟时间                                 |
   | 19   | 'measurements.cls:'              | 测量指标，累积布局偏移                                     |
   | 20   | 'measurements.ttfb:'             | 测量指标，服务端响应时间                                   |
   | 21   | 'measurements.ttfb.requesttime:' | 测量指标，服务端响应之间中的请求时间                       |
   | 22   | 'id:'                            | 错误ID                                                     |
   | 23   | 'timestamp:'                     | 时间戳                                                     |
   | 24   | 'time:'                          | 时间                                                       |
   | 25   | 'culprit:'                       | 错误发生点                                                 |
   | 26   | 'location:'                      | 错误发生网络位置                                           |
   | 27   | 'message:'                       | 错误消息                                                   |
   | 28   | 'platform.name:'                 | 平台名称，例如： `javascript`,`python`                     |
   | 29   | 'dist:'                          | 目标                                                       |
   | 30   | 'title:'                         | 标题                                                       |
   | 31   | 'user.id:'                       | 用户ID                                                     |
   | 32   | 'user.email:'                    | 用户邮箱                                                   |
   | 33   | 'user.username:'                 | 用户名称                                                   |
   | 34   | 'user.ip:'                       | 用户IP                                                     |
   | 35   | 'sdk.name:'                      | SDK名称                                                    |
   | 36   | 'sdk.version:'                   | SDK版本                                                    |
   | 37   | 'http.method:'                   | HTTP请求方法                                               |
   | 38   | 'http.referer:'                  | HTTP前一个地址                                             |
   | 39   | 'http.url:'                      | HTTP请求地址                                               |
   | 40   | 'os.build:'                      | 系统发行版本                                               |
   | 41   | 'os.kernel_version:'             | 系统核心版本                                               |
   | 42   | 'device.name:'                   | 设备名称                                                   |
   | 43   | 'device.brand:'                  | 设备品牌                                                   |
   | 44   | 'device.locale:'                 | 设备语言                                                   |
   | 45   | 'device.uuid:'                   | 设备UUID                                                   |
   | 46   | 'device.arch:'                   |                                                            |
   | 47   | 'device.battery_level:'          | 设备电量级别                                               |
   | 48   | 'device.orientation:'            | 设备组织                                                   |
   | 49   | 'device.simulator:'              | 设备是否为模拟器                                           |
   | 50   | 'device.online:'                 | 设备是否在线                                               |
   | 51   | 'device.charging:'               | 设备是否正在充电                                           |
   | 52   | 'geo.country_code:'              | 地理位置国家代码                                           |
   | 53   | 'geo.region:'                    | 地理位置区域                                               |
   | 54   | 'geo.city:'                      | 地理位置城市                                               |
   | 55   | 'error.type:'                    | 错误类型                                                   |
   | 56   | 'error.value:'                   | 错误值                                                     |
   | 57   | 'error.mechanism:'               | 错误发生机制                                               |
   | 58   | 'error.handled:'                 | 错误是否被正确处理                                         |
   | 59   | 'error.unhandled:'               | 错误是否未被正确处理                                       |
   | 60   | 'stack.abs_path:'                | 堆栈绝对路径                                               |
   | 61   | 'stack.filename:'                | 堆栈文件名称                                               |
   | 62   | 'stack.package:'                 | 堆栈包名                                                   |
   | 63   | 'stack.module:'                  | 堆栈模块名                                                 |
   | 64   | 'stack.function:'                | 堆栈方法名                                                 |
   | 65   | 'stack.in_app:'                  | 堆栈应用编号                                               |
   | 66   | 'stack.colno:'                   | 堆栈列数                                                   |
   | 67   | 'stack.lineno:'                  | 堆栈行数                                                   |
   | 68   | 'stack.stack_level:'             | 堆栈级别                                                   |
   | 69   | 'transaction.duration:'          | 事务时间，                                                 |
   | 70   | 'transaction.op:'                | 事务操作，例如：`pageload`,`navigation`                    |
   | 71   | 'transaction.status:'            | 事务状态，例如`unkonewn`                                   |
   | 72   | 'trace:'                         | 跟踪ID                                                     |
   | 73   | 'trace.span:'                    | SPAN 的ID                                                  |
   | 74   | 'trace.parent_span:'             | 父级SPAN                                                   |
   | 75   | 'project:'                       | 项目名称                                                   |
   | 76   | 'issue:'                         | 问题名称                                                   |
   | 77   | 'user.display:'                  | 问题归属                                                   |
   | 78   | 'has:'                           | 是否有某个标签                                             |

   * 聚合函数。用来对指标进行聚合计算。
     * `count()` 默认，计算总数，可应用于所有指标
     * `avg()`，计算平均值，可计算指标有：`measurements.fp`，`measurements.fcp`，`measurements.lcp`，`measurements.fid`，`measurements.ttfb`，`measurements.cls`，`measurements.ttfb.requesttime`， `transaction.duration`
     * `percentile()` ，计算百分比，可计算指标同`avg()`
     * `failure_rate()`，计算失败率，可应用于所有指标。 它表示不成功 事务的百分比。
     * `apdex()`，计算满意度，可应用于所有指标。 它提供特定 事务或端点中满意(satisfactory)、可容忍(tolerable)和失败(frustrated)请求的比率
     * `p50()`, 计算P50阈值。可计算指标同`avg()`。它表示 50% 的事务持续时间大于阈值。
     * `p75()`, 计算P75阈值，可计算指标同`avg()`。它表示25% 的事务持续时间大于阈值。
     * `p95()`，计算P95阈值，可计算指标同`avg()`。它表示5% 的事务持续时间大于阈值。
     * `p99()`，计算P99阈值，可计算指标同`avg()`。它表示1% 的事务持续时间大于阈值。
   * 时间窗口。指在某个时间范围内指标达到了设定的阈值就发出警报。
   * 环境。指定需要报警的环境，除指定环境外，其它环境不报警。

4. 设定阈值

   * 临界状态（`Criticla Status`），设置可以出发临界状态的阈值。
   * 警告状态（`Warning Status`），设置可以激活警告状态的阈值。
   * 解决状态（`Resolved Status`），设置可以激活已解决状态的阈值

5.  动作

    设定一个动作，当临界状态或警告状态被激活时执行。

    可执行的动作根据项目集成功能不同而不同，默认情况下为发送一封邮件给指定成员。

6.  规则名称

   为该规则设定一个名称，方便在不同项目中复用。

### 5.2 问题警报

![image-20210913165211300](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210913165211.png)

问题警报分三个区域：

1. 警报基础设置

   * 警报执行环境，只在指定环境执行该条警报规则
   * 规则名称。方便复用

2. 警报条件

   警报条件的基本格式是：

   `WHEN` ... `IF` ... `THEN` ...

   即，当若干个触发器被触发时（`WHEN`），如果满足指定条件（`IF`），那么执行规定动作（`THEN`）.

   * `WHEN`，设置触发器，可以添加多个触发器。触发器类型有：

     ![image-20210913170138681](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210913170138.png)

     当然，上面可以设置，是同时满足所有触发器才执行下面的动作还是满足设置的任意一个触发器就可以执行下面的动作。

   * `IF` ，设置条件。

     ![image-20210913170811546](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210913170811.png)

     与`WHEN`类型，可以设置是同时满足所有条件还是满足其中任意一个条件或不满足所有条件时，执行下面的动作

   * `THEN`，设置动作

     ![image-20210913171021588](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210913171021.png)

     根据集成的功能不同，这里可以执行的动作也不同，默认情况下，有两个动作：

     	*  发送邮件给指定成员
     	*  触发所有遗留集成，发送通知到集成的其它系统中。（比如钉钉）

3. 速率限制

   限制在一定时间段内，即使不停地满足`WHEN`与`IF`，也只发送一次通知，避免消息轰炸。












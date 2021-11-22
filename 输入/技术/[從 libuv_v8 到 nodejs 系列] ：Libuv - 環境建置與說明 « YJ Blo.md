# [從 libuv/v8 到 nodejs 系列] ：Libuv - 環境建置與說明 « YJ Blog

Libuv提供核心的event loop与包装事件驱动的底层系统API，V8则为JS Runtime Engine，加入C++ binding后就成了我们使用的NodeJS，此系列由下至上深入了解NodeJS组成。

![u1O2O.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201218093722.png)

#图片源自: [stackoverflow Aren Li的回答](https://stackoverflow.com/questions/36766696/which-is-correct-node-js-architecture)

### Libuv

[官网说明](http://docs.libuv.org/en/v1.x/design.html#the-i-o-loop)

Libuv是提供事件驱动、非同步IO模型的跨平台专案，发展源自于NodeJS专案的需求，在2012年前左右的资料可能会看到NodeJS底层是Libev + Libeio而非Libuv，主要是Libuv融合前两者并提供跨平台(Windows)服务，随后在NodeJS v0.9后就都一率用Libuv。

### Event Loop

Event Loop 是Libuv 的核心，用来建立所有的IO 操作，Event Loop 预设为单一的Thread，也可开立多个Event Loop 跑在个别的Thread 上。

![loop_iteration.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201218093735.png)

整个Event Loop执行的时候有很多的阶段phase，细节可以到文件中查询[Libuv Design overview](http://docs.libuv.org/en/v1.x/design.html)，但这里有一点特别标注：

***
Libuv 透过thread pool 另开thread 去执行档案系统以达到非同步的效果；但是网路I/O 则是在原本的Event Loop thread 上

这是因为各大作业系统对于档案系统操作没有个统一定义的操作介面与实作，所以`檔案操作都是blocking所以要另開thread保持上層API可以Async操做`，可以看到之前的[nodejs issue#5039](https://github.com/nodejs/node/issues/5039)反应在Mac OSX下fs.watch()没有反应，就是因为Mac OSX当时没有提供这样的System API，诸如此类的档案操作issue还不少。

### Handle / Request

在进入实作阶段前，Libuv提供两个抽象化类别Handle / Request。
`Handle`：长时间存在且会基于某种动作被触发的物件，例如说TCP server长时间聆听某个port，当有成功connection则触发；

`Request`：指的是短时间的操作，例如每个TCP Connection需要的读取/写入资料，通常Request会在Handle中触发，但某些特殊的Request可以独立在Event Loop中操作；

这里举档案系统的Handle/Request做说明，Libuv是透过C编写，所以Handle/Request都被定义成Struct型态
```
/* Handle types. */
typedef struct uv_loop_s uv_loop_t;
typedef struct uv_handle_s uv_handle_t;
.....
typedef struct uv_fs_event_s uv_fs_event_t;
typedef struct uv_fs_poll_s uv_fs_poll_t;
/* Request types. */
typedef struct uv_req_s uv_req_t;
.....
typedef struct uv_fs_s uv_fs_t;
```
`uv_fs_event_t`这个Handle是用来聆听档案目录变化[uv_fs_event_t — FS Event handle](http://docs.libuv.org/en/v1.x/fs_event.html)；

`uv_fs_t`则是Request，可以用在开启/读取/写入/关闭档案等一次性操作上；之后会专门说明。

### 实战

再进入实作前，先在稍微描述一下编写的概念，不得不说Libuv 写起来跟写NodeJS 非常像，差别在于写C 比较需要费时费脑OTZ；
***
一开始我们会需要初始化Event Loop
接着透过定义Handle / Request去实作功能，Libuv每个Function都有提供同步/非同步写法。
在非同步写法中，一样是透过定义Callback Function，并透过Callback Function的参数取得底层操作的结果。
*
以下是我在Mac OSX 10.12.6下的操作，必须预先安装Xcode与Python(2.7，内建预设有)。
1.到github clone [Libuv](https://github.com/libuv/libuv)
```
$ sh autogen.sh$ ./configure$ make$ make check$ make install
```
上面这样理论上就完成了，可以先一路到第三步compile，如果在OSX下还是有错，可以试试以下
```
$ ./gyp_uv.py -f xcode$ xcodebuild -ARCHS="x86_64" -project uv.xcodeproj -configuration Release -target All$ brew install --HEAD libuv
```
如果没有gyp，可以去下载安装，不过OSX在我目前版本有个安全措施叫Rootless，会妨碍你用安装gyp，可以上网查询解法先把Rootless关闭。

2. 复制libuv hello world 程式，取名为main.c
```
#include <stdio.h>
#include <uv.h>

int64_t   counter   =   0 ; 
void   wait_for_a_while ( uv_idle_t *   handle )   
{   
	counter ++ ;   
	if   ( counter   >=   10e6 )   uv_idle_stop ( handle ); 
}
int   main ()   {  
	uv_idle_t   idler ;    
	uv_idle_init(uv_default_loop(),  &idler);  
	uv_idle_start(&idler,  wait_for_a_while);  printf("Idling...\n");  
	uv_run(uv_default_loop(),  UV_RUN_DEFAULT);  uv_loop_close(uv_default_loop());  
	return  0;
}
```

uv_idle_t 是個 Handle，在 Event Loop 每次循環都會觸發，透過 uv_idle_init 初始化，uv_idle_init() 第一個參數傳入 Event Loop，如果只想用單一 Event Loop 可以用`uv_default_loop()`就不需要創建新的 Event Loop；

wait_for_a_while 就是 Callback Function，等數到一個數目後就會 uv_idle_stop() 註銷 Handle。
後續會反覆看到相同的模式。
3.compile
先切換到 main.c 的路徑下，接著把 Libuv 路徑改成你下載 Libuv 並完成安裝的路徑，理論上這樣就完成 compile 了
```
gcc -o main.o -L /Users/zhengyuanjie/Desktop/Nodejs/learnuv/libuv -I /Users/zhengyuanjie/Desktop/Nodejs/learnuv/libuv/include main.c -luv -framework CoreFoundation -framework CoreServices
```

接著，會透過操作檔案系統 / TCP Server 等練習 Libuv。

 [← [從 libuv/v8 到 nodejs 系列] ：Libuv - 操作 File System](http://sj82516-blog.logdown.com/posts/3903962/libuv-operation-file-system)  [[從 libuv/v8 到 nodejs 系列] ：Libuv - Networking →](http://sj82516-blog.logdown.com/posts/4087423/from-libuv-v8-to-nodejs-series-libuv-networking)

 [ ](https://simpread.herokuapp.com/view/51662278725.html#)  [Tweet](https://twitter.com/share?)
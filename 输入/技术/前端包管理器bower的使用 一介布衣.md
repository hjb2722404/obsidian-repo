前端包管理器bower的使用 一介布衣

# 前端包管理器bower的使用

 **  [一介布衣](http://yijiebuyi.com/blog/2aa4c7d26780239d9763efb71cded12d.html)    ** 2015-04-22    **  [javascript](http://yijiebuyi.com/category/javascript.html)  ** 18448

[分享到：](http://yijiebuyi.com/blog/2aa4c7d26780239d9763efb71cded12d.html#)[QQ空间](http://yijiebuyi.com/blog/2aa4c7d26780239d9763efb71cded12d.html#)[新浪微博](http://yijiebuyi.com/blog/2aa4c7d26780239d9763efb71cded12d.html#)[腾讯微博](http://yijiebuyi.com/blog/2aa4c7d26780239d9763efb71cded12d.html#)[人人网](http://yijiebuyi.com/blog/2aa4c7d26780239d9763efb71cded12d.html#)[微信](http://yijiebuyi.com/blog/2aa4c7d26780239d9763efb71cded12d.html#).

![](../_resources/bbaac1f208adc39dacf5518c341d45d4.png)

随着前端项目越来越复杂,随便引入几个第三方javascript脚本库貌似已经习以为常,但是随着越来越多的包被引入,开发人员维护起来也是一件相当头疼的事,比如第三方库的版本更新,安装,卸载等.

twitter推出了一个前端包管理器 bower 帮我们解决了这些头疼的事情.

bower 完全借鉴了npm构思和实现原理,所以后面你会看到它的使用几乎和npm是一模一样.

当然,bower 是运行在node.js 基础上,所以你的当前环境确保已经安装 node.js .

bower 的基础功能是什么?
1.注册模块
每个包需要确定一个唯一的 ID 使得搜索和下载的时候能够正确匹配

2.文件存储
把文件存储在一个有效的网络地址上,使用的时候可以直接下载到.

3.上传下载
你可以把你的包注册后上传存储.
使用的时候可以使用一条命令直接下载到当前项目.

4.以来分析
它帮我们解决了包与包直接的依赖关系
当我们下载一个包A的时候,由于它依赖包B,所以bower会自动帮我们下载好包B

如何使用bower ?
npm install bower -g
检查是否安装成功
zhangzhi@moke:~$ bower help
Usage:
    bower <command> [<args>] [<options>]
Commands:
    cache                   Manage bower cache
    help                    Display help information about Bower
    home                    Opens a package homepage into your favorite browser
    info                    Info of a particular package
    init                    Interactively create a bower.json file
    install                 Install a package locally
    link                    Symlink a package folder
    list                    List local packages - and possible updates
    lookup                  Look up a package URL by name
    prune                   Removes local extraneous packages
    register                Register a package
    search                  Search for a package by name
    update                  Update a local package
    uninstall               Remove a local package
    version                 Bump a package version
Options:
    -f, --force             Makes various commands more forceful
    -j, --json              Output consumable JSON
    -l, --log-level         What level of logs to report
    -o, --offline           Do not hit the network
    -q, --quiet             Only output important information
    -s, --silent            Do not output anything, besides errors
    -V, --verbose           Makes output more verbose
    --allow-root            Allows running commands as root
    --version               Output Bower version
See 'bower help <command>' for more information on a specific command.
┌───────────────────────────────────────────┐
│ Update available: 1.4.1 (current: 1.3.12) │
│ Run npm update -g bower to update.        │
└───────────────────────────────────────────┘
上面信息说明我们安装成功,我当前的版本 1.3.12  已经比较低,提示我使用命令更新 bower
npm update -g bower
这样就可以轻松更新bower 到最新版

上面help 信息列出 bower 提供的命令
cache:bower缓存管理
help:显示Bower命令的帮助信息
home:通过浏览器打开一个包的github发布页
info:查看包的信息
init:创建bower.json文件
install:安装包到项目
link:在本地bower库建立一个项目链接
list:列出项目已安装的包
lookup:根据包名查询包的URL
prune:删除项目无关的包
register:注册一个包
search:搜索包
update:更新项目的包
uninstall:删除项目的包

现在我们使用 bower init 来创建一个bower.json 的配置文件,我找到自己的一个测试项目来演示
zhangzhi@moke:~/code/test/static$ bower init
? name: test
? version: 0.1.1
? description:
? main file: main.js

? what types of modules does this package expose? (Press <space>? what types of modules does this package expose?

? keywords:
? authors: zhangzhi <zzhi.net@gmail.com>
? license: MIT
? homepage:
? set currently installed components as dependencies? Yes
? add commonly ignored files to ignore list? Yes

? would you like to mark this package as private which prevents ? would you like to mark this package as private which prevents it from being accidentally published to the registry? No

{
  name: 'test',
  version: '0.1.1',
  authors: [
    'zhangzhi <zzhi.net@gmail.com>'
  ],
  main: 'main.js',
  license: 'MIT',
  ignore: [
    '**/.*',
    'node_modules',
    'bower_components',
    'app/bower_components',
    'test',
    'tests'
  ]
}
? Looks good? Yes

然后我们查看 static 目录可以看到有了一个配置文件  bower.json ,里面的内容就是上面的.

这时我们来下载一个jquery 文件,并且指定一个版本
zhangzhi@moke:~/code/test/static$ bower install jquery#1.7.2 --save
bower cached        git://github.com/jquery/jquery.git#1.7.2
bower validate      1.7.2 against git://github.com/jquery/jquery.git#1.7.2
我下载了一个 jquery 1.7.2 的版本,可以看到我本地有缓存,所以非常快的下载下来.

# 符号后面就是可以指定一个下载的版本

--save 就是把下载的包信息写入到配置文件的依赖项里.和npm 一模一样.我们看下 bower.json 文件
{
  "name": "test",
  "version": "0.1.1",
  "authors": [
    "zhangzhi <zzhi.net@gmail.com>"
  ],
  "main": "main.js",
  "license": "MIT",
  "ignore": [
    "**/.*",
    "node_modules",
    "bower_components",
    "app/bower_components",
    "test",
    "tests"
  ],
  "dependencies": {
    "jquery": "1.7.2"
  }
}

ok, jquery 1.7.2 已经写入配置文件.

现在我们通过 info 命令查看一下 jquery 的信息
zhangzhi@moke:~/code/test/static$ bower info jquery
bower cached        git://github.com/jquery/jquery.git#2.1.0
bower validate      2.1.0 against git://github.com/jquery/jquery.git#*
bower new           version for git://github.com/jquery/jquery.git#*
bower resolve       git://github.com/jquery/jquery.git#*
bower download      https://github.com/jquery/jquery/archive/2.1.3.tar.gz
bower progress      jquery#* received 0.6MB of 0.6MB downloaded, 88%
bower extract       jquery#* archive.tar.gz
bower resolved      git://github.com/jquery/jquery.git#2.1.3
{
  name: 'jquery',
  version: '2.1.3',
  main: 'dist/jquery.js',
  license: 'MIT',
  ignore: [
    '**/.*',
    'build',
    'speed',
    'test',
    '*.md',
    'AUTHORS.txt',
    'Gruntfile.js',
    'package.json'
  ],
  devDependencies: {
    sizzle: '2.1.1-jquery.2.1.2',
    requirejs: '2.1.10',
    qunit: '1.14.0',
    sinon: '1.8.1'
  },
  keywords: [
    'jquery',
    'javascript',
    'library'
  ],
  homepage: 'https://github.com/jquery/jquery'
}
Available versions:
  - 2.1.3
  - 2.1.2
  - 2.1.1
  - 2.1.1-rc2
  - 2.1.1-rc1
  - 2.1.1-beta1
  - 2.1.0
  - 2.1.0-rc1
  - 2.1.0-beta3
  - 2.1.0-beta2
  - 2.1.0-beta1
  - 2.0.3
  - 2.0.2
  - 2.0.1
  - 2.0.0
  - 2.0.0-beta3
  - 1.11.2
  - 1.11.1
  - 1.11.1-rc2
  - 1.11.1-rc1
  - 1.11.1-beta1
  - 1.11.0
  - 1.11.0-rc1
  - 1.11.0-beta3
  - 1.11.0-beta2
  - 1.11.0-beta1
  - 1.10.2
  - 1.10.1
  - 1.10.0
  - 1.10.0-beta1
  - 1.9.1
  - 1.9.0
  - 1.8.3+1
  - 1.8.3
  - 1.8.2
  - 1.8.1
  - 1.8.0
  - 1.7.2
  - 1.7.1
  - 1.7.0
  - 1.6.4
  - 1.6.3
  - 1.6.2
  - 1.6.1
  - 1.6.0
  - 1.5.2
  - 1.5.1
  - 1.5.0
  - 1.4.4
  - 1.4.3
  - 1.4.2
  - 1.4.1
  - 1.4.0
  - 1.3.2
  - 1.3.1
  - 1.3.0
  - 1.2.6
  - 1.2.5
  - 1.2.4
  - 1.2.3
  - 1.2.2
  - 1.2.1
  - 1.1.4
  - 1.1.3
  - 1.1.2
  - 1.1.1
  - 1.0.4
  - 1.0.3
  - 1.0.2
  - 1.0.1
You can request info for a specific version with 'bower info jquery#<version>'
它列出了 jquery 相关的所有信息

通过 bower list 查看依赖关系
zhangzhi@moke:~/code/test/static$ bower list
bower check-new     Checking for new versions of the project dependencies..
test#0.1.1 /Users/zhangzhi/code/test/static
└── jquery#1.7.2 extraneous (latest is 2.1.3)

### 你可能感兴趣

- [javascript 跨域的几种情况](http://yijiebuyi.com/blog/03fc0af64ac69cb90ff8b81749a6bee4.html)

- [[转]Node.js 与 io.js 那些事儿](http://yijiebuyi.com/blog/0b0b007cc2b79437451f6b6abb1e4cb9.html)

- [漫谈javascript 单线程异步io回调的特性](http://yijiebuyi.com/blog/1220beaebf7aeb1095505791919844a1.html)

- [jquery 根据屏幕宽度改变图片宽度](http://yijiebuyi.com/blog/2232bad6795e6a019823d9382dfe8ca5.html)

- [javascript 基础训练 Function 函数对象](http://yijiebuyi.com/blog/0d06d1b33287b74fd9acda5a943ebfd7.html)

本文由 [一介布衣](http://yijiebuyi.com/) 创作，采用 [知识共享署名 3.0](http://creativecommons.org/licenses/by/3.0/cn) 中国大陆许可协议。

可自由转载、引用，但需署名作者且注明文章出处。

本站部署于「[UCloud云计算](https://ucloud.cn/)」。
**右侧微信扫描 「打赏」,感谢支持!**

 ![](../_resources/d34c839b5a7f6a3edfbbae0349762811.jpg)

[前端工程师](http://www.so.com/s?src=lm&ls=sm1356031&q=%E5%89%8D%E7%AB%AF%E5%B7%A5%E7%A8%8B%E5%B8%88&lmsid=e3195229449745da&lm_extend=ctype:4)

[布衣传说](http://www.so.com/s?src=lm&ls=sm1356031&q=%E5%B8%83%E8%A1%A3%E4%BC%A0%E8%AF%B4&lmsid=e3195229449745da&lm_extend=ctype:4)

[前端是什么](http://www.so.com/s?src=lm&ls=sm1356031&q=%E5%89%8D%E7%AB%AF%E6%98%AF%E4%BB%80%E4%B9%88&lmsid=e3195229449745da&lm_extend=ctype:4)

[玖信贷](http://www.so.com/s?src=lm&ls=sm1356031&q=%E7%8E%96%E4%BF%A1%E8%B4%B7&lmsid=e3195229449745da&lm_extend=ctype:4)

[空气炸锅](http://www.so.com/s?src=lm&ls=sm1356031&q=%E7%A9%BA%E6%B0%94%E7%82%B8%E9%94%85&lmsid=e3195229449745da&lm_extend=ctype:4)

[前端](http://www.so.com/s?src=lm&ls=sm1356031&q=%E5%89%8D%E7%AB%AF&lmsid=e3195229449745da&lm_extend=ctype:4)

[虚拟主机](http://www.so.com/s?src=lm&ls=sm1356031&q=%E8%99%9A%E6%8B%9F%E4%B8%BB%E6%9C%BA&lmsid=e3195229449745da&lm_extend=ctype:4)

[刺影传奇](http://www.so.com/s?src=lm&ls=sm1356031&q=%E5%88%BA%E5%BD%B1%E4%BC%A0%E5%A5%87&lmsid=e3195229449745da&lm_extend=ctype:4)

[前端开发](http://www.so.com/s?src=lm&ls=sm1356031&q=%E5%89%8D%E7%AB%AF%E5%BC%80%E5%8F%91&lmsid=e3195229449745da&lm_extend=ctype:4)

[网站制作](http://www.so.com/s?src=lm&ls=sm1356031&q=%E7%BD%91%E7%AB%99%E5%88%B6%E4%BD%9C&lmsid=e3195229449745da&lm_extend=ctype:4)

[前端学习路线](http://www.so.com/s?src=lm&ls=sm1356031&q=%E5%89%8D%E7%AB%AF%E5%AD%A6%E4%B9%A0%E8%B7%AF%E7%BA%BF&lmsid=e3195229449745da&lm_extend=ctype:4)

[华泰证券](http://www.so.com/s?src=lm&ls=sm1356031&q=%E5%8D%8E%E6%B3%B0%E8%AF%81%E5%88%B8&lmsid=e3195229449745da&lm_extend=ctype:4)

[(L)](http://www.so.com/s?src=lm&ls=sm1356031&q=360&lmsid=e3195229449745da&lm_extend=ctype:4)

[(L)](http://union.sogou.com/)

|     |     |     |
| --- | --- | --- |
| [成都锦一医院](http://www.sogou.com/bill_un?v=1&p=WJ80$xBzet0SGINSy9VACo5mpcZ3Fxr@pe71R4Y@nK32CLaWf1X4Qx1zF0q8W$8@Nh1$o3VsEF@pPjXTs1@u8IkAQKjwIcr0L$bHA1iNn@QCABpd$Ao01dRv7w7eG3n6I9RqLV4qhlLwh7sadbw$$dwG0y816s28kvwOzqQV9jo4vxubpSX$BBF6i$kzmegXIMWgx00rSr6cfZJ2v17787ksatcoXtxcc5LxKEIvTVZ7etQBx6aGS$zQUOJtXlqV$KVV$QuISU3Dwpmv902Fv6pQvaV8GSYJGSuBv@VeGQYwtS$zuiuzQCIYp6metFpQjFpzkmP6wUB@3y6mOo3h8xyPly7aZLSaj8GFvhG0tE2UUZmyAPwPSknkUU8IYlYXV1HIlqlI6GXReqkPepi6YpVkzplGcOUAW4ZkBKXVyuZuiuzpOAlMtZIyVEmeuv6yQlxqGfQOja9BpS7zQiARWGUwX0PyaOCw1G0wZ904hG8lQGKYZVl4zjZlQfOCVl==&q=WJZVZt92kjlGl9lXoOwwVbtxAOwRZUNd7aCTFKUdlBYDUsnTeJyiw5Nilfb6j89pnXB16vGVqfdGHXxOALhz0rEdsxZUtk==)<br>[成都锦一医院主营:外科,美容外科,医疗美容科等,接诊时间:8..](http://www.sogou.com/bill_un?v=1&p=WJ80$xBzet0SGINSy9VACo5mpcZ3Fxr@pe71R4Y@nK32CLaWf1X4Qx1zF0q8W$8@Nh1$o3VsEF@pPjXTs1@u8IkAQKjwIcr0L$bHA1iNn@QCABpd$Ao01dRv7w7eG3n6I9RqLV4qhlLwh7sadbw$$dwG0y816s28kvwOzqQV9jo4vxubpSX$BBF6i$kzmegXIMWgx00rSr6cfZJ2v17787ksatcoXtxcc5LxKEIvTVZ7etQBx6aGS$zQUOJtXlqV$KVV$QuISU3Dwpmv902Fv6pQvaV8GSYJGSuBv@VeGQYwtS$zuiuzQCIYp6metFpQjFpzkmP6wUB@3y6mOo3h8xyPly7aZLSaj8GFvhG0tE2UUZmyAPwPSknkUU8IYlYXV1HIlqlI6GXReqkPepi6YpVkzplGcOUAW4ZkBKXVyuZuiuzpOAlMtZIyVEmeuv6yQlxqGfQOja9BpS7zQiARWGUwX0PyaOCw1G0wZ904hG8lQGKYZVl4zjZlQfOCVl==&q=WJZVZt92kjlGl9lXoOwwVbtxAOwRZUNd7aCTFKUdlBYDUsnTeJyiw5Nilfb6j89pnXB16vGVqfdGHXxOALhz0rEdsxZUtk==)<br>[www.jyzf120.com](http://www.sogou.com/bill_un?v=1&p=WJ80$xBzet0SGINSy9VACo5mpcZ3Fxr@pe71R4Y@nK32CLaWf1X4Qx1zF0q8W$8@Nh1$o3VsEF@pPjXTs1@u8IkAQKjwIcr0L$bHA1iNn@QCABpd$Ao01dRv7w7eG3n6I9RqLV4qhlLwh7sadbw$$dwG0y816s28kvwOzqQV9jo4vxubpSX$BBF6i$kzmegXIMWgx00rSr6cfZJ2v17787ksatcoXtxcc5LxKEIvTVZ7etQBx6aGS$zQUOJtXlqV$KVV$QuISU3Dwpmv902Fv6pQvaV8GSYJGSuBv@VeGQYwtS$zuiuzQCIYp6metFpQjFpzkmP6wUB@3y6mOo3h8xyPly7aZLSaj8GFvhG0tE2UUZmyAPwPSknkUU8IYlYXV1HIlqlI6GXReqkPepi6YpVkzplGcOUAW4ZkBKXVyuZuiuzpOAlMtZIyVEmeuv6yQlxqGfQOja9BpS7zQiARWGUwX0PyaOCw1G0wZ904hG8lQGKYZVl4zjZlQfOCVl==&q=WJZVZt92kjlGl9lXoOwwVbtxAOwRZUNd7aCTFKUdlBYDUsnTeJyiw5Nilfb6j89pnXB16vGVqfdGHXxOALhz0rEdsxZUtk==) | [整容整形选择米兰柏羽医学美容..](http://www.sogou.com/bill_un?v=1&p=WJ80$xYfh70SGINSy9VACo5mpcZ3axr@pe71R4Y@nK32CLaWf1X4QxCnXT8RcNpdbCi9ZJQ5EN6Jgf@MKDAWtYjTcxeTVtKqThKmgsCdcqZFwTHqqUzuozqPVL2mS6OJkz$eof$SpelqIM7OVvQQiBK$JWWxSYhRTWn0wox1tQImH$$eAf$iUTB$BgOMUUIuA$$iAf$SpqlApv3SgJvzQJJBOkogFZv3VfNRLjOlN64hxGbq5WMu7UHetE9UVLtzjR9buqI3vgVeVPvOePWOI$UQjKpQOiKrJvquIkjN6JDretEVQjF9BpymetKVuj49zQPmBuImzQVIaGgpeqkuepk3oInVp5LOJaPYj7ohUcy9ajZG6h1H89Z70Y8G8qJ2aUl$voyYRYxpGzQRpBeta3UVy3qlJkDgYcUymipxPYpSlBPgAWRekBFOVZmeuBAbpyJHin2AxXIzA2TY8xywawj$uNJvP2AG0lL2atexspw9FeZoOhc6zpS6Y3S0BpBkrp27Y3P0YQlwlRhoKaZ=&q=WJZVZt92kjlGl9lXoOwwVbtxAOwRZUNd7aCTFKUdlBYDUsnTeJyiw5Nilfb6j89pnXB16vGVqfdGHXxOALhz0rEdsxZUtk==)<br>[整容整形,品质医学变美选择米兰柏羽,量身定制专属整形美容..](http://www.sogou.com/bill_un?v=1&p=WJ80$xYfh70SGINSy9VACo5mpcZ3axr@pe71R4Y@nK32CLaWf1X4QxCnXT8RcNpdbCi9ZJQ5EN6Jgf@MKDAWtYjTcxeTVtKqThKmgsCdcqZFwTHqqUzuozqPVL2mS6OJkz$eof$SpelqIM7OVvQQiBK$JWWxSYhRTWn0wox1tQImH$$eAf$iUTB$BgOMUUIuA$$iAf$SpqlApv3SgJvzQJJBOkogFZv3VfNRLjOlN64hxGbq5WMu7UHetE9UVLtzjR9buqI3vgVeVPvOePWOI$UQjKpQOiKrJvquIkjN6JDretEVQjF9BpymetKVuj49zQPmBuImzQVIaGgpeqkuepk3oInVp5LOJaPYj7ohUcy9ajZG6h1H89Z70Y8G8qJ2aUl$voyYRYxpGzQRpBeta3UVy3qlJkDgYcUymipxPYpSlBPgAWRekBFOVZmeuBAbpyJHin2AxXIzA2TY8xywawj$uNJvP2AG0lL2atexspw9FeZoOhc6zpS6Y3S0BpBkrp27Y3P0YQlwlRhoKaZ=&q=WJZVZt92kjlGl9lXoOwwVbtxAOwRZUNd7aCTFKUdlBYDUsnTeJyiw5Nilfb6j89pnXB16vGVqfdGHXxOALhz0rEdsxZUtk==)<br>[sg.bravou.cn](http://www.sogou.com/bill_un?v=1&p=WJ80$xYfh70SGINSy9VACo5mpcZ3axr@pe71R4Y@nK32CLaWf1X4QxCnXT8RcNpdbCi9ZJQ5EN6Jgf@MKDAWtYjTcxeTVtKqThKmgsCdcqZFwTHqqUzuozqPVL2mS6OJkz$eof$SpelqIM7OVvQQiBK$JWWxSYhRTWn0wox1tQImH$$eAf$iUTB$BgOMUUIuA$$iAf$SpqlApv3SgJvzQJJBOkogFZv3VfNRLjOlN64hxGbq5WMu7UHetE9UVLtzjR9buqI3vgVeVPvOePWOI$UQjKpQOiKrJvquIkjN6JDretEVQjF9BpymetKVuj49zQPmBuImzQVIaGgpeqkuepk3oInVp5LOJaPYj7ohUcy9ajZG6h1H89Z70Y8G8qJ2aUl$voyYRYxpGzQRpBeta3UVy3qlJkDgYcUymipxPYpSlBPgAWRekBFOVZmeuBAbpyJHin2AxXIzA2TY8xywawj$uNJvP2AG0lL2atexspw9FeZoOhc6zpS6Y3S0BpBkrp27Y3P0YQlwlRhoKaZ=&q=WJZVZt92kjlGl9lXoOwwVbtxAOwRZUNd7aCTFKUdlBYDUsnTeJyiw5Nilfb6j89pnXB16vGVqfdGHXxOALhz0rEdsxZUtk==) | [婚纱摄影哪家好?影匠尊享私家..](http://www.sogou.com/bill_un?v=1&p=WJeVFF17lL9Y8OKqz8D1dvT6VIYuPu$MXdENNemaL4yCUNKFnfVTfqCbrtgKcptS20MCQ1AwyQC3YI3ZL9Pw9359hXtQbdE6KBETKBETAvfkYexN5yjJ@HENiDC41xDBMVOz4GR2CdBTVLdDbHM1RCCsatqpRdMMer5bS8HTY4aO@Q6KQu7JdCh$ei7KHLWTaZDXrNbO@tgqGIR$Nt7unH6lQtsTTvybFHwS1Nq$2Q1QBiZzUN2pUvZoJIoYntnT3EBKuDlGGD9qXabDmN66j1eWoFP0RbrpontUX5wQn2Cbb@FJ4FR7WFBpbqFSBSXpTJwiUF3X8Sa$jO3utXzMXRztnqujowSjqJ509VkoS0Sq1gvmG86jyyUxJBkplu2haZhEVFm59IZFyMN$S$NUU1LVxZoKlveWPyI@wlbRBqNwxWh9YxiJOVjtZqrlzsD747ktR1Uhu6I9YPhLiYqaY$oAAkHCzR$5wIySek2sh5HX5WJQy2LUYI$A3uYIP6u3Y@wamExLNy==&q=WJZVZt92kjlGl9lXoOwwVbtxAOwRZUNd7aCTFKUdlBYDUsnTeJyiw5Nilfb6j89pnXB16vGVqfdGHXxOALhz0rEdsxZUtk==)<br>[婚纱摄影哪家好?影匠千套礼服/50亩大型基地/八大主题场景,..](http://www.sogou.com/bill_un?v=1&p=WJeVFF17lL9Y8OKqz8D1dvT6VIYuPu$MXdENNemaL4yCUNKFnfVTfqCbrtgKcptS20MCQ1AwyQC3YI3ZL9Pw9359hXtQbdE6KBETKBETAvfkYexN5yjJ@HENiDC41xDBMVOz4GR2CdBTVLdDbHM1RCCsatqpRdMMer5bS8HTY4aO@Q6KQu7JdCh$ei7KHLWTaZDXrNbO@tgqGIR$Nt7unH6lQtsTTvybFHwS1Nq$2Q1QBiZzUN2pUvZoJIoYntnT3EBKuDlGGD9qXabDmN66j1eWoFP0RbrpontUX5wQn2Cbb@FJ4FR7WFBpbqFSBSXpTJwiUF3X8Sa$jO3utXzMXRztnqujowSjqJ509VkoS0Sq1gvmG86jyyUxJBkplu2haZhEVFm59IZFyMN$S$NUU1LVxZoKlveWPyI@wlbRBqNwxWh9YxiJOVjtZqrlzsD747ktR1Uhu6I9YPhLiYqaY$oAAkHCzR$5wIySek2sh5HX5WJQy2LUYI$A3uYIP6u3Y@wamExLNy==&q=WJZVZt92kjlGl9lXoOwwVbtxAOwRZUNd7aCTFKUdlBYDUsnTeJyiw5Nilfb6j89pnXB16vGVqfdGHXxOALhz0rEdsxZUtk==)<br>[www.enjoy16.cn](http://www.sogou.com/bill_un?v=1&p=WJeVFF17lL9Y8OKqz8D1dvT6VIYuPu$MXdENNemaL4yCUNKFnfVTfqCbrtgKcptS20MCQ1AwyQC3YI3ZL9Pw9359hXtQbdE6KBETKBETAvfkYexN5yjJ@HENiDC41xDBMVOz4GR2CdBTVLdDbHM1RCCsatqpRdMMer5bS8HTY4aO@Q6KQu7JdCh$ei7KHLWTaZDXrNbO@tgqGIR$Nt7unH6lQtsTTvybFHwS1Nq$2Q1QBiZzUN2pUvZoJIoYntnT3EBKuDlGGD9qXabDmN66j1eWoFP0RbrpontUX5wQn2Cbb@FJ4FR7WFBpbqFSBSXpTJwiUF3X8Sa$jO3utXzMXRztnqujowSjqJ509VkoS0Sq1gvmG86jyyUxJBkplu2haZhEVFm59IZFyMN$S$NUU1LVxZoKlveWPyI@wlbRBqNwxWh9YxiJOVjtZqrlzsD747ktR1Uhu6I9YPhLiYqaY$oAAkHCzR$5wIySek2sh5HX5WJQy2LUYI$A3uYIP6u3Y@wamExLNy==&q=WJZVZt92kjlGl9lXoOwwVbtxAOwRZUNd7aCTFKUdlBYDUsnTeJyiw5Nilfb6j89pnXB16vGVqfdGHXxOALhz0rEdsxZUtk==) |

- [前端包管理](http://yijiebuyi.com/tag/%E5%89%8D%E7%AB%AF%E5%8C%85%E7%AE%A1%E7%90%86.html)

- [bower使用](http://yijiebuyi.com/tag/bower%E4%BD%BF%E7%94%A8.html)
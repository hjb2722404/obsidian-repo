NPM包（模块）发布、更新、撤销发布 - 掘金

[(L)](https://juejin.im/user/3104676567329272)

[ william_zhou   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/3104676567329272)

2019年01月29日   阅读 3070

# NPM包（模块）发布、更新、撤销发布

在开始之前，先去[注册一个NPM账号](https://www.npmjs.com/signup)，如果没有的话

## ◈ 发布NPM公开包

### ♢ 创建项目

1. 建项目文件夹
先建一个工程文件夹或者拉取远程git上的已有项目

	mkdir my-test-project
	复制代码

2. 初始化git

进入该文件夹，先初始化git（如果还没有的话），用于版本控制。在github（也可以其他）上新建一个与项目同名的远程仓库，并添加`README.md`文件，拷贝仓库地址，如：

	// 拷贝github上的仓库地址
	git@github.com:username/my-test-project.git

	git init
	git remote add origin git@github.com:usename//my-test-project.git
	git push -u origin master
	复制代码

这样就把本地仓库和远程仓库关联起来了
3. 初始化npm

在项目根目录下即`my-test-project`目录下执行，`npm init`，然后根据提示填写相关信息，有些可以略过后续修改。 要注意的是name字段，有几个点要提醒：

    - 这个是唯一的，不能和npm上所有已有的包重名，否则在publish的时候回会提示权限错误

	npm ERR! You do not have permission to publish "my-test-project".
	Are you logged in as the correct user? : my-test-project
	复制代码

    - 另外命名也有规范，不能出现下划线、大写字母、空格等字符，可以有连字符（中划线）
    - 先创建`index.js`文件，作为测试，在里面写几行简单代码，并export一个默认变量

### ♢ 发布

1. 先登录npm用户，执行

	npm adduser // or npm login
	Username: npm-user-name
	Password:
	Email: your-email
	复制代码

根据提示输入正确的npm用户名、密码、邮箱，添加完后会默认登录
2. 执行

	npm publish
	复制代码

如果没什么问题，应该就发布成功了。可以去npm搜索发布的包: `my-test-project`，或者去自己的npm账号下查看package

### ♢ 关于测试

1. publish前测试

在npm init 完成之后，就可以作为一个依赖包供其他模块引用。根据上面的例子，把my-test-project文件夹放入另外的测试工程node_modules文件夹下面，这样就可以跟引入其他模块一样，引入之前在index.js里面export的测试变量，如

	// my-test-project 下的index.js
	const a = 'this is a test'
	export default a // or module.exports = a

	// 引用
	import a from 'my-test-project' // or const a = require('my-test-project')
	复制代码

建议先测试完，没有问题再publish
2. publish后测试是否有问题
publish后就更好办了，直接像安装其他模块一样通过npm i 命令安装，然后引用

## ◈ 更新已发布的包

更新包和发布包的命令是一样的，更新包只需修改package.json里面的`version`字段，也可以使用npm 自带的版本控制命令修改版本号，更新的步骤为：

1. 修改版本号
2. npm publish

### ♢ npm version

npm 提供官方提供了`npm version`来进行版本控制，其效果跟手动修改package.json里面的version字段是一样的，好处在于，可以在构建过程中用`npm version`命令自动修改，而且具有语义化即`Semantic versioning`.

	npm version [<newversion> | major | minor | patch | premajor | preminor |
	prepatch | prerelease | from-git]
	复制代码

其语义为：

	major：主版本号（大版本）
	minor：次版本号（小更新）
	patch：补丁号（补丁）
	premajor：预备主版本
	preminor: 预备次版本
	prepatch：预备补丁版本
	prerelease：预发布版本
	复制代码

如初始版本为 1.0.0，执行相关类型命令后，对应的语意为：

	npm version patch  // 1.0.1 表示小的bug修复
	npm version minor // 1.1.0 表示新增一些小功能
	npm version mmajor // 2.0.0 表示大的版本或大升级
	npm version preminor // 1.1.0-0 后面多了个0，表示预发布
	复制代码

可以在当前模块的package.json里面看到相应的版本变化

## ◈ 撤销发布

由于撤销发布会让把要撤销的包作为依赖的包不能正常工作，所以npm官方对包的撤销是有限制的：

1. 不允许撤销发布已经超过24小时的包（`unpublish is only allowed with versions published in the last 24 hours`）

2. 如果在24小时内确实要撤销，需要加--force参数
3. 即使撤销了发布的包，再次发布的时候也不能与之前被撤销的包的名称/版本其中之一相同，因为这两者构成的唯一性已经被占用，官方并没有随着撤销而删除

### ♢ npm unpublish

撤销发布的命令为 npm unpublish

	npm unpublish my-test-project
	// 报错
	npm ERR! Refusing to delete entire project.
	npm ERR! Run with --force to do this.
	npm ERR! npm unpublish [<@scope>/]<pkg>[@<version>]

	// 加 --force参数重新撤销发布
	npm unpublish my-test-project --force
	npm WARN using --force I sure hope you know what you are doing.

	- my-test-project

	复制代码

### ♢ npm deprecate

`npm unpublish`的推荐替代命令：

	npm deprecate <pkg>[@<version>] <message>
	复制代码

这个命令，并不会在npm上里撤销已有的包，但会在任何人尝试安装这个包的时候得到deprecated的警告，例如：

	npm deprecate my-test-project 'this package is no longer maintained'
	复制代码

参考：

- [Creating and publishing unscoped public packages](https://docs.npmjs.com/creating-and-publishing-unscoped-public-packages)
- [【npm】利用npm安装/删除/发布/更新/撤销发布包](http://www.cnblogs.com/penghuwan/p/6973702.html)
- [版本号管理策略&&使用npm管理项目版本号](http://buzhundong.com/post/%E7%89%88%E6%9C%AC%E5%8F%B7%E7%AE%A1%E7%90%86%E7%AD%96%E7%95%A5-%E4%BD%BF%E7%94%A8npm%E7%AE%A1%E7%90%86%E9%A1%B9%E7%9B%AE%E7%89%88%E6%9C%AC%E5%8F%B7.html)
使用Typescript编写和发布npm包

> 本文参照 > [> Chidume Nnamdi](https://codeburst.io/@kurtwanger40?source=post_header_lockup)>  的「How to Create and Publish an NPM module in TypeScript」博客，结合自身实践总结而成。

> 原文地址：> [https://codeburst.io/https-chidume-nnamdi-com-npm-module-in-typescript-12b3b22f0724

# Step 1 初始化 Git 环境

1. 在Github上创建一个远程仓库
2. 下载到本地。

	git clone https://github.com/youthcity/ts-hi.git
	1

# Step 2 初始化 NPM 包

	npm init  # 或者使用， npm init -y 跳过所有提问
	1

根据提示，填写相应信息，得到 `package.json`文件

	# package.json
	
	{
	  "name": "ts-hi",
	  "version": "0.0.1",
	  "description": "create npm package with typescript",
	  "main": "index.js",
	  "scripts": {
	    "test": "echo \"Error: no test specified\" && exit 1"
	  },
	  "repository": {
	    "type": "git",
	    "url": "git+https://github.com/youthcity/ts-hi.git"
	  },
	  "keywords": [
	    "typescript"
	  ],
	  "author": "youthcity",
	  "license": "ISC",
	  "bugs": {
	    "url": "https://github.com/youthcity/ts-hi/issues"
	  },
	  "homepage": "https://github.com/youthcity/ts-hi#readme"
	}
	123456789101112131415161718192021222324

# Step 3 安装依赖

## 安装 Typescript

	# 使用 npm 安装
	npm i typescript -D
	
	# 或使用 yarn 进行安装
	yarn add typescript -D
	12345

## 配置 tsconfig.json 文件

手动创建配置文件，文件如下

	{
	  "compilerOptions": {
	    "target": "es5",
	    "module": "commonjs",
	    "declaration": true,
	    "outDir": "./dist",
	    "strict": true
	  }
	}
	123456789

使用命令行创建。

	# 需要全局安装 typescript包
	npm i typescript -D
	tsc --init
	
	# 使用当前项目中的 typescript
	./node_modules/.bin/tsc --init
	123456

配置成的文件如下：

	{
	  "compilerOptions": {
	    "target": "es5", // 指定ECMAScript目标版本
	    "module": "commonjs", // 指定模块化类型
	    "declaration": true, // 生成 `.d.ts` 文件
	    "outDir": "./dist", // 编译后生成的文件目录
	    "strict": true // 开启严格的类型检测
	  }
	}
	123456789

# Step 4 开始编码

	mkdir lib # 在 ts-hi 根目录下，创建 lib 文件夹
	touch index.ts
	12

index.ts

	# 非常简单的加法函数
	export function add(a:number, b:number) : number {
	  return a + b;
	}
	1234

# Step 5 编译

将编译命令添加到 `package.json` 文件中

	{
	  "name": "ts-hi",
	  "version": "0.0.1",
	  "description": "create npm package with typescript",
	  "main": "index.js",
	  "scripts": {
	    "build": "tsc" # 增加 ts 编译命令
	  },
	  "repository": {
	    "type": "git",
	    "url": "git+https://github.com/youthcity/ts-hi.git"
	  },
	  "keywords": [
	    "typescript"
	  ],
	  "author": "youthcity",
	  "license": "ISC",
	  "bugs": {
	    "url": "https://github.com/youthcity/ts-hi/issues"
	  },
	  "homepage": "https://github.com/youthcity/ts-hi#readme",
	  "devDependencies": {
	    "typescript": "^3.0.3"
	  }
	}
	12345678910111213141516171819202122232425

运行命令，执行编译

	npm run build
	1

编译完成后，我们可以看到目录下出现了 `dist`目录，在该目录下生成了两个文件，一个包含代码逻辑的 JS 文件，一个包含类型定义的 interface文件。
![1674837-94ce2508ada6e735.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102123103.png)
tsc 编译后生成的文件

# Step 6 编写测试

1）安装测试框架和断言库

	npm i mocha -D
	npm i chai -D
	12

2）创建测试文件目录和文件

	# 根目录下
	mkdir test && touch test/test.js
	12

test.js

	'use strict';
	const expect = require('chai').expect;
	const add = require('../dist/index').add;
	
	describe('ts-hi function test', () => {
	  it('should return 2', () => {
	    const result = add(1, 1);
	    expect(result).to.equal(2);
	  });
	});
	12345678910

# Step 7 运行测试

添加测试脚本

	  "scripts": {
	    "build": "tsc",
	    "test": "mocha --reporter spec"
	  },
	1234

运行测试脚本

	npm run test
	1

![1674837-5c496c97d152e67c.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102123115.png)
测试结果

# Step 8 添加 README

	touch README.md
	
	# 编写文档介绍...
	123

# Step 9 提交 和 推送远端

	touch .gitignore // 创建 .gitignore 文件，并添加 node_modules/ 避免将node_modules 添加到版本控制中
	git add .
	git commit -m “Initial release”
	git tag v0.1.0  # 修改一下 package.json中的版本号为 0.1.0
	git push origin master --tags
	12345

# Step 10 发布

在发布代码之前，需要将一些没有必要的文件或目录从安装文件中排出。例如，`lib`文家目录。创建 `.npmignore` 文件。
.npmignore

	# 排除 lib文件
	lib/
	12

登录 npm，并发布包

	# 登录 npm， 若无账号，请在https://www.npmjs.com/ 注册账号
	npm adduser
	Username: youthcity
	Password:
	Email: (this IS public) 填写邮箱
	Logged in as youthcity on https://registry.npmjs.org/.
	
	# 发布包
	npm publish
	123456789

查看发布后的包： https://www.npmjs.com/package/ts-hi

# Step 11 添加 CI（持续集成）

1）登录 [Travis CI](https://travis-ci.org/)
2）点击 “Sign in with Github”
3）勾选需要持续集成的项目，本例为 `ts-hi`
![1674837-83243914416d8123.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102123128.png)
travis 项目面板

4）在项目添加 travis 的配置文件
.travis.yml

	language : node_js
	node_js :
	
	 - stable
	
	install:
	
	 - npm install
	
	script:
	
	 - npm test
	
	1234567

5）将配置推送到 Github 的远程仓库。查看 travis 构建状态。

![1674837-ab775687f4b2ccc5.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102123154.png)
ts-hi 构建状态

# 其他功能

## 添加 Travis 构建徽章到 README

1. 登录[Travis](https://travis-ci.org/)并访问项目页面
2. 获取徽章图片代码

![1674837-b1304338983efe70.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102123206.png)
徽章代码

![1674837-67cc17cfb213e463.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102123420.png)
获取代码

3. 将代码粘贴到 README 中 （若需要多个 badge 并排展示，徽章代码之间，不要空行）
4. git commit -m 'doc(README): add travis badge' && git push origin master
查看项目首页即可。例如，https://github.com/youthcity/ts-hi

## 添加代码覆盖率

1. 使用 github 账号登录 [coveralls](https://coveralls.io/)，勾选需要执行代码覆盖率检查的仓库
2. 在项目中，添加开发依赖

	npm i istanbul -D
	npm i coveralls -D
	12

1. 在 package.json 的配置文件中，添加脚本

	"cover": "istanbul cover node_modules/mocha/bin/_mocha test/*.js - - -R spec"
	1

添加后 package.json

	  "scripts": {
	    "build": "tsc",
	    "test": "mocha --reporter spec",
	    "cover": "istanbul cover node_modules/mocha/bin/_mocha test/*.js - - -R spec"
	  },
	12345

1. 修改 .travis.yml 文件

	language : node_js
	node_js :

	 - stable

	install:

	 - npm install

	script:

	 - npm run cover

	 # Send coverage data to Coveralls
	after_script: "cat coverage/lcov.info | node_modules/coveralls/bin/coveralls.js"
	123456789

1. 运行命令

	npm run cover
	1

1. commit 和 推送代码到 github 仓库
登录 `Coveralls` ，检查是否执行顺利。
![1674837-76350b5279975ee5.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102123511.png)
Coveralls / ts-hi

1. 获取 Badge

![1674837-0bd3c35917034822.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102123527.png)
获取 Badge

## 如何快速生成 .gitignore

1. 访问 https://www.gitignore.io/
2. 选择项目环境。以本环境为例，输入 node、macOS、vscode（会自动提示为，VisualStudioCode）。
3. 点击 Create，获取 .gitignore 文件

# 总结

通过使用 `Typescript` 编写 `NPM` 包，实践了很多以前遇到过但未使用过的技术。例如，`Travis` 的持续集成、 `mocha` 和 `chai` 编写测试、`coveralls` 代码覆盖、如何添加 `badge` 等。

# 参考资料

- [What is the role of `describe` in Mocha?](https://stackoverflow.com/questions/19298118/what-is-the-role-of-describe-in-mocha)
- [How to Create and Publish an NPM module in TypeScript](https://codeburst.io/https-chidume-nnamdi-com-npm-module-in-typescript-12b3b22f0724)
- https://www.gitignore.io/
- [YAML Converter - 在线yaml 转 JSON](https://codebeautify.org/yaml-to-json-xml-csv)
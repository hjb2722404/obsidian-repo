# [FE] 使用vscode调试npm scripts

### 1. 调试node.js

我们先来看看vscode如何调试node.js。

#### 1.1 新建项目

	$ mkdir vscode-debug
	$ cd vscode-debug
	$ npm init -f

#### 1.2 新建index.js

	console.log('hello');

#### 1.3 打开vscode

用vscode打开`vscode-debug`文件夹，作为vscode资源管理的**根目录**。
![1023733-58d61fc472391032.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217154026.png)

#### 1.4 添加vscode配置

打开工具栏的“调试”菜单，然后点击“添加配置”。

![1023733-b80a010da8fc0265.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217154030.png)
vscode会让我们选择环境，这里我们选择“Node.js”。

![1023733-813306107f70a7f5.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217154033.png)
vscode会自动在工程目录下创建一个 `.vscode/launch.json` 文件。
![1023733-0d4a6e232e7ba449.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217154040.png)

我们看到 `.vscode/launch.json`的`configurations.program`属性为，

	{
	    ...
	    "configurations": [
	        {
	            ...
	            "program": "${workspaceFolder}/index.js"
	        }
	    ]
	}

其中`${workspaceFolder}/index.js`表示了调试的入口，
`workspaceFolder`是vscode资源管理器的根目录，
因此，上文中我们强调了**项目目录**应当为**资源管理器的根目录**。

#### 1.5 启动调试

添加完调试配置之后，直接按`F5`，就可以启动调试了。
在此之前，记得去 index.js 文件中打个断点。

![1023733-fcc5634b351b91ab.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217154048.png)
启动调试之后，程序就会停在断点处了，

![1023733-1003af2f29e5b776.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217154051.png)

### 2. 调试npm scripts

在实际项目中，好多命令放到了npm scritps中，
下面我们介绍调试npm scripts的办法。

#### 2.1 添加npm scripts

	{
	  ...
	  "scripts": {
	    ...
	    "debug": "node --inspect-brk=5858 index.js"
	  },
	  ...
	}

其中，`debug`是npm scripts的名字，可以任取，
后面`--inspect-brk=5858`是必须的，其中`5858`是任意指定的调试端口号。

#### 2.2 修改vscode调试配置

打开 `.vscode/launch.json`，
增加以下3个配置项，`runtimeExecutable`，`runtimeArgs`，`port`。
而`program`配置项就可以删掉了，

	"program": "${workspaceFolder}/index.js"
	
	{
	    ...
	    "configurations": [
	        {
	            ...
	            "runtimeExecutable": "npm",
	            "runtimeArgs": [
	                "run-script",
	                "debug"
	            ],
	            "port": 5858
	        }
	    ]
	}

其中，`runtimeExecutable`表示要使用的运行时，默认为`node`，这里我们配置成了`npm`，
`runtimeArgs`的第二个参数，就是npm scripts的命令名，第一个参数`run-script`不要修改。
`port`指的是npm scripts中我们配置的`--inspect-brk=5858`调试端口号`5858`。

#### 2.3 启动调试

然后按`F5`，就可以启动调试了，
程序停到了 index.js 我们打的断点处。

![1023733-1003af2f29e5b776.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217154107.png)

### 3. 调试非node命令

#### 3.1 node_modules/.bin

`npm run`会自动添加`node_module/.bin` 到当前命令所用的`PATH`变量中，
可参考[npm-run-script](https://docs.npmjs.com/cli/run-script#description)。
例如，如果我们配置了名为`build`的npm scripts，

	{
	  ...
	  "scripts": {
	    "build": "webpack"
	  },
	  ...
	}

则`npm run build`实际调用的是 `node_modules/.bin/webpack`。

#### 3.2 不能直接加 --inspect-brk

在这种情况下，直接加`--inspect-brk=5858`是不灵的。

	{
	  ...
	  "scripts": {
	    "debug": "webpack --inspect-brk=5858"
	  },
	  ...
	}

以上配置，会自动执行`npm run debug`，但不会进入断点。

#### 3.3 转换成node调用

	{
	  ...
	  "scripts": {
	    "debug": "node --inspect-brk=5858 ./node_modules/.bin/webpack"
	  },
	  ...
	}

这次就启动成功了，这是因为`--inspect-brk`是node的参数，
我们需要将npm script中的命令改成`node`调用。

#### 3.4 stopOnEntry

我们还可以设置 `.vscode/launch.json` 的 `configurations.stopOnEntry`属性，
启动调试后会，会自动将断点停在代码的第一行。

	{
	    ...
	    "configurations": [
	        {
	            ...
	            "stopOnEntry": true,
	        }
	    ]
	}

![1023733-4013a129e2755f21.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217154128.png)

* * *

### 参考

[Launch configuration support for 'npm' and other tools](https://code.visualstudio.com/docs/nodejs/nodejs-debugging#_launch-configuration-support-for-npm-and-other-tools)
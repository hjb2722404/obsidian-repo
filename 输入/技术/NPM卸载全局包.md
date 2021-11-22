NPM卸载全局包

# 卸载全局安装命令

`npm uninstall -g <package>`

# 全局包安装位置

`C:\Users\用户名\AppData\Roaming\npm\node_modules`
这个位置用于定位安装了什么包，因为查看全局包的命令`npm ls -g`确实不好看明白安装了那些包。
还有以下常用命令
查看所有全局安装的模块 `npm ls -g`
查看npm默认设置（部分） `npm config ls`
查看npm默认设置（全部） `npm config ls -l`

# 修改全局依赖下载位置

`npm config set prefix "D:\Program Files\npm_global_modules\node_modules"`

引用自：[npm全局模块卸载及默认安装目录修改方法](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.zhangshengrong.com%2Fp%2FAvN6BRbQNm%2F)
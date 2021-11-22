【NPM】如何优雅的删除卸载 npm 包

### **【NPM】如何优雅的删除卸载 npm 包**

[方法一](https://blog.csdn.net/csdn_yudong/article/details/90417804#_2)
[方法二](https://blog.csdn.net/csdn_yudong/article/details/90417804#_19)
[npm 清理缓存](https://blog.csdn.net/csdn_yudong/article/details/90417804#npm__37)
[参考](https://blog.csdn.net/csdn_yudong/article/details/90417804#_42)

# **方法一**

我们现在假设要卸载一个` npm` 包：`xx-abc`。
```
npm uninstall xx-abc
```
这会在` node_modules `中删除 `xx-abc` 的文件夹。
删除本地模块时是否将在 package.json 上的相应依赖信息也删除？
`npm uninstall xx-abc`：删除模块，但不删除模块留在`package.json`中的对应信息
如果是安装在 `dependencies`
`npm uninstall xx-abc --save `删除模块，同时删除模块留在`package.json`中`dependencies`下的对应信息
// 如果是安装在 `devDependencies`
`npm uninstall xx-abc --save-dev` 删除模块，同时删除模块留在`package.json`中`devDependencies`下的对应信息

# **方法二**

有时候 `npm uninstall xx-abc `会出现错误；原因比较多，无法删除的原因有可能是这个模块又依赖了别的 xxxxx，所以卸载不了；那就把 `node_modules` 文件夹删除了重新安装。

删除 `node_modules` 优雅的方式是：
1、命令行中使用 rm 命令是一个不错的选择
```
rm  -rf node_modules
```

2、或者使用 rimraf 来删除目录
```
npm install rimraf -g
rimraf node_modules
```
然后再进行 `npm uninstall `卸载操作，确保【npm 删除卸载一个模块】

# **npm 清理缓存**
```
npm cache clean -f
```
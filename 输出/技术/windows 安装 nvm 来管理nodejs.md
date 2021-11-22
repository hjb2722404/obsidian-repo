# windows 安装 nvm 来管理nodejs



##  下载 nvm

下载地址：[点击这里](https://github.com/coreybutler/nvm-windows/releases)

一般 `windows` 下载 `setup.zip`

## 安装 nvm

###  安装路径要求：

* 不要安装在`C`盘
* 安装路径不要包含空格和中文，类似于`Program Files`这样的会导致安装会报错

### 安装

解压`setup.zip`后，进入解压后的目录，以管理员权限运行 `setup.exe`

安装过程中手动选择`nvm`和`nodejs`的安装目录，目录要符合上面的安装路径要求。

### 确认

安装完成后，打开命令行工具，运行以下命令：

```shell
$ nvm version
```

如果正常显示了版本号，则说明安装成功。否则，请上网搜索其他教程。

### 配置国内镜像

打开`nvm` 安装目录，找到目录下的 `setting.txt `文件，在文件末尾添加以下两行内容：

```txt
node_mirror: https://npm.taobao.org/mirrors/node/
npm_mirror: https://npm.taobao.org/mirrors/npm/
```

这是为了解决`nvm` 访问国外`nodejs` 镜像经常失败或者很慢的问题。

## 使用

### 安装指定版本nodejs

使用以下命令:

```shell
$ nvm install v11.0.0
```

其中，`11.0.0` 可替换为任何你需要的`nodejs`版本

### 列出本地所有版本

```shell
$ nvm list
```

### 使用某个版本

```shell
$ nvm use 11.0.0
```


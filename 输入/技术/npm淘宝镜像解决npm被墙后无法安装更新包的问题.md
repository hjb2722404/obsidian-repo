npm淘宝镜像解决npm被墙后无法安装更新包的问题

# npm淘宝镜像解决npm被墙后无法安装更新包的问题

nodejs环境
npm问题

随着nodejs在编程界发展得风生水起，大家也逐渐开始习惯使用npm来安装和管理项目的包和组件，但是无奈大天朝的“Great Wall”实在是烦不胜烦，总是导致NPM无法访问到目标资源的问题。

但是，总有大牛们会为大家解决这些问题。

淘宝就做了一套国内的npm镜像，同步频率为10分钟一次，基本可以与NPM官方仓库保持同步，所以，只要我们在使用npm命令安装和更新包的时候指定使用淘宝镜像，就会duang的一下下载完成了。

具体命令格式如下：

	npm install some-npm-module -g --registry=国内镜像 --disturl=https://npm.taobao.org/dist

淘宝国内镜像地址：

	http://registry.npm.taobao.org/

具体实例：

	npm install fis -g --registry=http://registry.npm.taobao.org/ --disturl=https://npm.taobao.org/dist

怎么样，so easy吧，记住这条命令，省却很多烦恼！
[markdownFile.md](../_resources/63fc167bf74a53b55a1d3f83c73ecd07.bin)
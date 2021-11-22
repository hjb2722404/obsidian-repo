12、发布npm包 · NPM 中文文档 · 看云

# 12、发布npm包

你可以发布任何包含**package.json**文件的目录，比如Nodejs模块。

## 创建用户

发布包之前，你必须创建一个npm用户账号。如果还没有，你可以用**npm adduser**创建一个。如果已经注册了，使用**npm login**命令将账号信息存储到本地客户端。

测试：使用**npm config ls**确认账号信息已经存储到您的客户端。访问https://npmjs.com/~ 以确保信息正确。

## 发布包

使用**npm publish**来发布程序包。

> Note that everything in the directory will be included unless it is ignored by a local **> .gitignore**>  or **> .npmignore**>  file as described in **> npm-developers**> .

注意，目录下的所有文件都将被包含进去，除非目录下有**.gitignore** 或 **.npmignore**文件（详情请看**npm-developers**）将其排除。

> Also make sure there isn't already a package with the same name, owned by somebody else.

同时，请确保npm上没有别的开发者提交的同名都包存在。

> Test: Go to **> [https://npmjs.com/package/**> . You should see the information for your new package.

测试：前往**https://npmjs.com/package/**。你应该可以看到发布的新包的信息了。

## 更新包

> When you make changes, you can update the package using npm version <update_type>, where update_type is one of the semantic versioning release types, patch, minor, or major. This command will change the version number in package.json. Note that this will also add a tag with this release number to your git repository if you have one.

当你修改了你的包文件，你可以用`npm version <update_type>`更新它。update_type是指语义化版本管理的发布类型的一种：补丁版本（patch）、次版本（minor）或主版本（major）。此命令会更改package.json中的版本号。注意哦，如果你有此包的git仓库，那么此命令也会向git仓库添加此版本的一个标签。

> After updating the version number, you can npm publish again.
更新版本号之后，你就可以再次 `npm publish` 了。

> Test: Go to > [https://npmjs.com/package/> . The package number should be updated.

测试：前往 **https://npmjs.com/package/**，包的版本号应该已更新了。

> The README displayed on the site will not be updated unless a new version of your package is published, so you would need to run npm version patch and npm publish to have a documentation fix displayed on the site.

站点下的README文件是不会更新，除非你的包的新版本发布成功。所以你需要运行`npm version patch`和`npm publish`命令来修复站点下的文档。

上一篇：[11、创建Node.js模块](https://www.kancloud.cn/shellway/npm-doc/199993)下一篇：[13、语义化版本号](https://www.kancloud.cn/shellway/npm-doc/199995).
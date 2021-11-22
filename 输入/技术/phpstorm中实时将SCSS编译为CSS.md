phpstorm中实时将SCSS编译为CSS

# phpstorm中实时将SCSS编译为CSS

phpstorm
css
scss
1-1、安装ruby，并在安装时勾选“add..to..PATH”一项。
1-2、命令行运行：gem install sass，安装SASS模块
2、打开phpstorm的设置-工具-FileWatcher
![5db93ab2761c7c4fcdd6ad7cb11bbe49.png](../_resources/f4c8804ea11f9bf6a02dc358a1e5bee1.png)
3、点击右边“+”，选择“SCSS”，并配置scss.bat所在目录：
![9f9756bca1cb036cee5d2afe657ec769.png](../_resources/8dfcdf7f035d671f7e97951436c777f0.png)
确定
然后你不管在哪写SCSS都会实时将CSS文件编译到scss文件所在目录了
[markdownFile.md](../_resources/2abafdd72e093fab2b139d9190410243.bin)
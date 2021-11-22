nodejs中的_filename和_dirname - colin_zff的博客 - CSDN博客

原

# nodejs中的_filename和_dirname

2017年05月28日 16:57:38[colin_zff](https://me.csdn.net/colin_zff)阅读数：2287

_filename和_dirname都不是全局对象下的属性，它们都是模块下的

_filename:返回当前模块文件被解析过后的绝对路径，该属性并非全局，而是模块作用域下的
console.log(_filename);

_dirname:返回当前模块文件解析过后所在的文件夹(目录)的绝对路径，该属性也不是全局的，而是模块作用域下的
console.log(_dirname);
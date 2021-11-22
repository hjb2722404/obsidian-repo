js 原生 Object.keys()详解 - 桂如的博客 - CSDN博客

 原

# js 原生 Object.keys()详解

 2018年07月06日 11:58:04  [桂如](https://me.csdn.net/qq_35285627)  阅读数：1891

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' style='display: none%3b' data-evernote-id='713' class='js-evernote-checked'%3e %3cpath stroke-linecap='round' d='M5%2c0 0%2c2.5 5%2c5z' id='raphael-marker-block' style='-webkit-tap-highlight-color: rgba(0%2c 0%2c 0%2c 0)%3b' data-evernote-id='714' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)

`Object.keys()`返回一个数组

### 语法

`Object.keys(obj)`

- 1

返回值: 一个表示给定对象的 `所有可枚举属性的` 字符串数组

##### 传入字符串，返回索引

	var arr = ['a', 'b', 'c'];
	console.log(Object.keys(arr)); // console: ['0', '1', '2']

- 1
- 2

##### 传入对象，返回属性名

	var obj = { a: 'alive', b: 'bike', c: 'color' };
	console.log(Object.keys(obj)); // console: ['a', 'b', 'c']

- 1
- 2

##### 例子

	const configs = {
	  umdDev: {
	    format: 'umd',
	    env: 'development'
	  },
	  umdProd: {
	    format: 'umd',
	    env: 'production'
	  },
	  commonjs: {
	    format: 'cjs'
	  },
	  esm: {
	    format: 'es'
	  }
	}

	var obj = Object.keys(configs);

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15
- 16
- 17
- 18
- 19
- 20

结果

	console.log(obj);
	["umdDev", "umdProd", "commonjs", "esm"]

- 1
- 2
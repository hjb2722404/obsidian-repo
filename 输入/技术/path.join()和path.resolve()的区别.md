##### path.join()

path.join():方法使用平台特定的分隔符\[Unix系统是/，Windows系统是\\ \]把全部给定的 path 片段连接到一起，并规范化生成的路径。若任意一个路径片段类型错误，会报错。 例如：

```bash
__dirname
// __dirname返回当前文件所在的绝对路径
const path = require('path');

const path1 = path.join(__dirname, '/foo');
const path2 = path.join(__dirname, './foo/bar');
const path3 = path.join('/foo', 'bar', '/baz/apple', 'aaa', '..');
const path4 = path.join('foo', 'bar', 'baz');


console.log(path1);
console.log(path2);
console.log(path3);
console.log(path4);

// 输出结果
/Users/xiao/work/test/foo
/Users/xiao/work/test/foo/bar
/foo/bar/baz/apple
foo/bar/baz
```

不合法的字符串将抛出异常

```bash
const path5 = path.join('foo', {}, 'bar');
// TypeError [ERR_INVALID_ARG_TYPE]: The "path" argument must be of type string. Received type object
```

如果连接后的路径字符串是一个长度为零的字符串，则返回 '.'，表示当前工作目录。

```bash
path.join('foo', 'bar', '..', '..')
// 返回结果为
'.'
```

##### path.resolve()

path.resolve:方法会把一个路径或路径片段的序列解析为一个绝对路径。 例如：

```bash
const path = require('path');

const path1 = path.resolve('/a/b', '/c/d');
// 结果： /c/d
const path2 = path.resolve('/a/b', 'c/d');
// 输出： /a/b/c/d
const path3 = path.resolve('/a/b', '../c/d');
// 输出： /a/c/d
const path4 = path.resolve('a', 'b');
// 输出： /Users/xiao/work/test/a/b
```

> resolve把‘／’当成根目录 path.resolve()方法可以将多个路径解析为一个规范化的绝对路径。其处理方式类似于对这些路径逐一进行cd操作，与cd操作不同的是，这引起路径可以是文件，并且可不必实际存在（resolve()方法不会利用底层的文件系统判断路径是否存在，而只是进行路径字符串操作）;

```bash
path.resolve('www', 'static', '../public', 'src', '..');
// cd www  /Users/xiao/work/test/www
// cd static /Users/xiao/work/test/www/static
// cd ../public /Users/xiao/work/test/www/public
// cd src /Users/xiao/work/test/www/public/src
// cd .. /Users/xiao/work/test/www/public
```

resolve操作相当于进行了一系列的cd操作，

##### 区别

1、join是把各个path片段连接在一起， resolve把‘／’当成根目录

```bash
path.join('/a', '/b'); 
// /a/b
path.resolve('/a', '/b');
// /b
```

2、resolve在传入非/路径时，会自动加上当前目录形成一个绝对路径，而join仅仅用于路径拼接

```bash
// 当前路径为
/Users/xiao/work/test
path.join('a', 'b', '..', 'd');
// a/d
path.resolve('a', 'b', '..', 'd');
// /Users/xiao/work/test/a/d
```

可以看出resolve在传入的第一参数为非根路径时，会返回一个带当前目录路径的绝对路径。
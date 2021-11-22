pkg-dir - 查找一个npm包的根目录 - Node.js开发社区 | CTOLib码库

# pkg-dir - 查找一个npm包的根目录

 pkg-dir - 查找一个npm包的根目录

**>
> Find the root directory of an npm package
>   **

## Install

	$ npm install --save pkg-dir

## Usage

	/
	└── Users
	    └── sindresorhus
	        └── foo
	            ├── package.json
	            └── bar
	                ├── baz
	                └── example.js

// example.js
const pkgDir = require('pkg-dir');
pkgDir(__dirname).then(rootPath => {
console.log(rootPath);
//=> '/Users/sindresorhus/foo'
});

## API

### pkgDir([cwd])

Returns a promise for the package root path or `null`.

### pkgDir.sync([cwd])

Returns the package root path or `null`.

#### cwd

Type: `string`
Default: `process.cwd()`

Directory to start from.

## Related

- [pkg-dir-cli](https://github.com/sindresorhus/pkg-dir-cli) - CLI for this module

- [pkg-up](https://github.com/sindresorhus/pkg-up) - Find the closest package.json file

- [find-up](https://github.com/sindresorhus/find-up) - Find a file by walking up parent directories

## License

MIT © [Sindre Sorhus](http://sindresorhus.com/)

Measure
Measure
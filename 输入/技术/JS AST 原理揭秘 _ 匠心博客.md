JS AST 原理揭秘 | 匠心博客

# JS AST 原理揭秘

## 前言

抽象语法树 AST 一直都想系统性的学习整理一下，这篇文章将以实际的例子讲解一下 AST 的基本内容。之前在做基于 Flutter 的类似小程序语法的开发框架 [flutter-mini-program![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='453'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/zhaomenghuan/flutter-mini-program)时，通过 Dart 解析 HTML 标签和 CSS 标签实现了 HTML + CSS 对 Flutter 视图层的描述；对于逻辑层的设计，Flutter 不支持动态加载 Dart 文件，也不支持 JS 语法运行环境，当时就想过一种思路，基于 Dart 解析 JS 语法的方式是否行得通，Dart 官方具备 Dart2js 框架，Dart SDK 里面具备 JS 和 JS AST 相关的包，原则上这个思路可行，但是没时间就搁置了这个想法。后来看到闲鱼技术团队提出了一种基于 [Flutter Dart AST 实现热更新![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='454'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://www.yuque.com/xytech/flutter/emdguh) 方式，目前看也是一种不错的方式。最近在做小程序一套代码转换成多套代码的框架，看到主流小程序框架里面有基于 AST 转换的逻辑，所以本文尝试重新梳理一下 JS AST 的内容。

## 什么是 AST ?

常见编译型语言（例如：Java）编译程序一般步骤分为：词法分析->语法分析->语义检查->代码优化和字节码生成。具体的编译流程如下图：

![common-lang-compile.8843ac98.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145506.png)

对于解释型语言（例如 JavaScript）来说，通过词法分析 -> 语法分析 -> 语法树，就可以开始解释执行了。

### 词法分析/分词(Tokenizing/Lexing)

将字符流(char stream)转换为记号流(token stream)，由字符串组成的字符分解成有意义的代码块，这些代码块称为词法单元。例如：一段 JS 代码 `var name = 'Hello Flutter';` 会被分解为词法单元：`var`、`name`、`=`、`Hello Flutter`、`;`。

json

	[
	  {
	    "type": "Keyword",
	    "value": "var"
	  },
	  {
	    "type": "Identifier",
	    "value": "name"
	  },
	  {
	    "type": "Punctuator",
	    "value": "="
	  },
	  {
	    "type": "String",
	    "value": "'Hello Flutter'"
	  },
	  {
	    "type": "Punctuator",
	    "value": ";"
	  }
	]

最小词法单元主要有空格、注释、字符串、数字、标志符、运算符、括号等。

### 语法分析/解析(Parsing)

将词法单元流转换成一个由元素逐级嵌套所组成的代表了程序语法结构的树。这个树称为 “抽象语法树” AST（Abstract Syntax Tree）。

词法分析和语法分析不是完全独立的，而是交错进行的，也就是说，词法分析器不会在读取所有的词法记号后再使用语法分析器来处理。在通常情况下，每取得一个词法记号，就将其送入语法分析器进行分析。

![js-token-ast.f635f3cf.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145537.png)

语法分析的过程就是把词法分析所产生的记号生成语法树，通俗地说，就是把从程序中收集的信息存储到数据结构中。注意，在编译中用到的数据结构有两种：符号表和语法树。

- **符号表**：就是在程序中用来存储所有符号的一个表，包括所有的字符串变量、直接量字符串，以及函数和类。

- **语法树**：就是程序结构的一个树形表示，用来生成中间代码。

如果 JavaScript 解释器在构造语法树的时候发现无法构造，就会报语法错误，并结束整个代码块的解析。对于传统强类型语言来说，在通过语法分析构造出语法树后，翻译出来的句子可能还会有模糊不清的地方，需要进一步的语义检查。语义检查的主要部分是类型检查。例如，函数的实参和形参类型是否匹配。但是，对于弱类型语言来说，就没有这一步。

经过编译阶段的准备，JavaScript 代码在内存中已经被构建为语法树，然后 JavaScript 引擎就会根据这个语法树结构边解释边执行。

我们可以使用在线工具生成 AST : [http://esprima.org/![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='455'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](http://esprima.org/) 或 [https://astexplorer.net/![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='456'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://astexplorer.net/)

`var name = 'Hello Flutter';` 转成 AST 如下：

json

	{
	  "type": "Program",
	  "body": [
	    {
	      "type": "VariableDeclaration",
	      "declarations": [
	        {
	          "type": "VariableDeclarator",
	          "id": {
	            "type": "Identifier",
	            "name": "name"
	          },
	          "init": {
	            "type": "Literal",
	            "value": "Hello Flutter",
	            "raw": "'Hello Flutter'"
	          }
	        }
	      ],
	      "kind": "var"
	    }
	  ],
	  "sourceType": "script"
	}

> 注意：出于简化的目的移除了某些属性

这样的每一层结构也被叫做 节点（Node）。 一个 AST 可以由单一的节点或是成百上千个节点构成。 它们组合在一起可以描述用于静态分析的程序语法。

### 代码生成(Code Generation)

将 AST 转换为可执行代码的过程称被称为代码生成。代码生成步骤把最终（经过一系列转换之后）的 AST 转换成字符串形式的代码，同时还会创建[源码映射（source maps）![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='457'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://www.html5rocks.com/en/tutorials/developertools/sourcemaps)。代码生成其实很简单：深度优先遍历整个 AST，然后构建可以表示转换后代码的字符串。

### ESTree AST Node

ESTree AST 节点表示为 Node 对象，它可以具有任何原型继承但实现以下接口：

js

	interface Node {
	  type: string;
	}

字符串形式的 type 字段表示节点的类型（如： "FunctionDeclaration"，"Identifier"，或 "BinaryExpression"）。每一种类型的节点定义了一些附加属性用来进一步描述该节点类型。

js

	{
	  type: ...,
	  start: 0,
	  end: 38,
	  loc: {
	    start: {
	      line: 1,
	      column: 0
	    },
	    end: {
	      line: 3,
	      column: 1
	    }
	  },
	  ...
	}

每一个节点都会有 start，end，loc 这几个属性。

#### Program 节点

js

	interface Program <: Node {
	  type: "Program";
	  body: [ Directive | Statement ];
	}

Program 是一个完整的程序源代码树。

#### Declaration 节点

js

	interface Declaration <: Statement { }

具体可以参考：[estree![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='458'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/estree/estree/blob/master/es5.md)

### JS AST 工具

JS 生态基于 AST 实现的一些工具有很多，例如：

- babel: 实现 JS 编译，转换过程是 AST 的转换

- ESlint: 代码错误或风格的检查，发现一些潜在的错误

- IDE 的错误提示、格式化、高亮、自动补全等

- UglifyJS 压缩代码

- 代码打包工具 webpack

可以参考的 AST 生成及代码合成的项目：

- [acorn![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='459'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/acornjs/acorn)

- [babel-core![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='460'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/babel/babel/tree/master/packages/babel-core)

- [the-super-tiny-compiler![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='461'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/jamiebuilds/the-super-tiny-compiler)

- [LangSandbox![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='462'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/ftomassetti/LangSandbox)

## Babel 的工作原理

Babel 是一个通用的多功能的 JavaScript 编译器，更确切地说是源码到源码的编译器，通常也叫做"转换编译器"(transpiler)。很多浏览器目前还不支持 ES6 的代码，但是我们可以通过 Babel 将 ES6 的代码转译成 ES5 代码，让所有的浏览器都能理解的代码，这就是 Babel 的作用。

Babel 的编译过程和大多数其他语言的编译器大致相同，可以分为三个阶段。

1. 解析(parse)：将代码字符串解析成抽象语法树。

2. 转换(transform)：对抽象语法树进行转换操作。

3. 生成(generate): 根据变换后的抽象语法树再生成代码字符串。

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145548.png)

### [@babel/parser![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='463'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://babeljs.io/docs/en/next/babel-parser)

@babel/parser 将源代码解析成 AST。

@babel/parser 是 Babel 的 JavaScript 解析器，原名 Babylon。最初是 从 Acorn 项目 fork 出来的。Acorn 非常快，易于使用，并且针对非标准特性(以及那些未来的标准特性)设计了一个基于插件的架构。

安装：

	$ npm install --save-dev @babel/parser

先从解析一个代码字符串开始：

js

	const babelParser = require("@babel/parser");
	
	const code = `let square = (n) => {
	  return n * n;
	}`;
	
	let ast = babelParser.parse(code);
	console.log(ast);

> Babel 使用一个基于 ESTree 并修改过的 AST，它的内核说明文档可以在 > [> ast-spec![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='464'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/babel/babel/blob/master/doc/ast/spec.md)>  查看。

### [@babel/generator![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='465'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://babeljs.io/docs/en/next/babel-generator)

@babel/generator 将 AST 解码生 JS 代码

js

	const babelParser = require("@babel/parser");
	const generate = require("@babel/generator");
	
	const astA = babelParser.parse("var a = 1;");
	const astB = babelParser.parse("var b = 2;");
	const ast = {
	  type: "Program",
	  body: [].concat(astA.program.body, astB.program.body)
	};
	
	const { code } = generate.default(ast);
	console.log(code);

### [@babel/plugin-transform-?![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='466'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/babel/babel/tree/master/packages)

Babel 官方提供了一系列用于代码转换的插件，例如 `@babel/plugin-transform-typescript`，我们通常会通过 babel 的插件来完成代码转换。

### [@babel/core![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='467'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://babeljs.io/docs/en/next/babel-core)

包括了整个 Babel 工作流，也就是说在 `@babel/core` 里面我们会使用到 `@babel/parser`、`transformer[s]`、以及`@babel/generator`

## 参考

- [JavaScript 基础——JS 编译器你都做了啥？![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='468'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://www.qianduandaren.com/2018/12/29/javascript-engine-v8/)

- [从 babel 讲到 AST![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='469'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/laihuamin/JS-total/issues/35)

- [平庸前端码农之蜕变 — AST![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='470'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://juejin.im/post/5bfc21d2e51d4544313df666)

- [ESTree AST node types![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='471'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/estree/estree)

- [@babel/parser (babylon) AST node types![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='472'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/babel/babel/blob/master/packages/babel-parser/ast/spec.md)

- [AST 抽象语法树——最基础的 javascript 重点知识，99%的人根本不了解![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='473'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://segmentfault.com/a/1190000016231512)

- [Babel 插件手册![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' x='0px' y='0px' viewBox='0 0 100 100' width='15' height='15' class='icon outbound js-evernote-checked' data-evernote-id='474'%3e%3cpath fill='currentColor' d='M18.8%2c85.1h56l0%2c0c2.2%2c0%2c4-1.8%2c4-4v-32h-8v28h-48v-48h28v-8h-32l0%2c0c-2.2%2c0-4%2c1.8-4%2c4v56C14.8%2c83.3%2c16.6%2c85.1%2c18.8%2c85.1z'%3e%3c/path%3e %3cpolygon fill='currentColor' points='45.7%2c48.7 51.3%2c54.3 77.2%2c28.5 77.2%2c37.2 85.2%2c37.2 85.2%2c14.9 62.8%2c14.9 62.8%2c22.9 71.5%2c22.9'%3e%3c/polygon%3e%3c/svg%3e)](https://github.com/jamiebuilds/babel-handbook/blob/master/translations/zh-Hans/plugin-handbook.md)

写文章不容易，也许写这些代码就几分钟的事，写一篇大家好接受的文章或许需要几天的酝酿，然后加上几天的码字，累并快乐着。如果文章对您有帮助请我喝杯咖啡吧！
 ![](../_resources/d9f97dfa0360802fbc47439d8eb41149.png)
 [0](https://zhaomenghuan.js.org/blog/null) 条评论

未登录用户![](data:image/svg+xml,%3csvg viewBox='0 0 1024 1024' xmlns='http://www.w3.org/2000/svg' p-id='1619' data-evernote-id='485' class='js-evernote-checked'%3e%3cpath d='M511.872 676.8c-0.003 0-0.006 0-0.008 0-9.137 0-17.379-3.829-23.21-9.97l-251.277-265.614c-5.415-5.72-8.743-13.464-8.744-21.984 0-17.678 14.33-32.008 32.008-32.008 9.157 0 17.416 3.845 23.25 10.009l228.045 241.103 228.224-241.088c5.855-6.165 14.113-10.001 23.266-10.001 8.516 0 16.256 3.32 21.998 8.736 12.784 12.145 13.36 32.434 1.264 45.233l-251.52 265.6c-5.844 6.155-14.086 9.984-23.223 9.984-0.025 0-0.051 0-0.076 0z' p-id='1620' data-evernote-id='486' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

Error: Network Error

[![](data:image/svg+xml,%3csvg viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' data-evernote-id='491' class='js-evernote-checked'%3e %3cpath d='M64 524C64 719.602 189.356 885.926 364.113 947.017 387.65799 953 384 936.115 384 924.767L384 847.107C248.118 863.007 242.674 773.052 233.5 758.001 215 726.501 171.5 718.501 184.5 703.501 215.5 687.501 247 707.501 283.5 761.501 309.956 800.642 361.366 794.075 387.658 787.497 393.403 763.997 405.637 743.042 422.353 726.638 281.774 701.609 223 615.67 223 513.5 223 464.053 239.322 418.406 271.465 381.627 251.142 320.928 273.421 269.19 276.337 261.415 334.458 256.131 394.888 302.993 399.549 306.685 432.663 297.835 470.341 293 512.5 293 554.924 293 592.81 297.896 626.075 306.853 637.426 298.219 693.46 258.054 747.5 262.966 750.382 270.652 772.185 321.292 753.058 381.083 785.516 417.956 802 463.809 802 513.5 802 615.874 742.99 701.953 601.803 726.786 625.381 750.003 640 782.295 640 818.008L640 930.653C640.752 939.626 640 948.664978 655.086 948.665 832.344 888.962 960 721.389 960 524 960 276.576 759.424 76 512 76 264.577 76 64 276.576 64 524Z' data-evernote-id='492' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)]()

 [![](data:image/svg+xml,%3csvg viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' data-evernote-id='498' class='js-evernote-checked'%3e %3cpath d='M512 366.949535c-16.065554 0-29.982212 13.405016-29.982212 29.879884l0 359.070251c0 16.167882 13.405016 29.879884 29.982212 29.879884 15.963226 0 29.879884-13.405016 29.879884-29.879884L541.879884 396.829419C541.879884 380.763865 528.474868 366.949535 512 366.949535L512 366.949535z' p-id='3083' data-evernote-id='499' class='js-evernote-checked'%3e%3c/path%3e %3cpath d='M482.017788 287.645048c0-7.776956 3.274508-15.553912 8.80024-21.181973 5.525732-5.525732 13.302688-8.80024 21.181973-8.80024 7.776956 0 15.553912 3.274508 21.079644 8.80024 5.525732 5.62806 8.80024 13.405016 8.80024 21.181973 0 7.776956-3.274508 15.656241-8.80024 21.181973-5.525732 5.525732-13.405016 8.697911-21.079644 8.697911-7.879285 0-15.656241-3.274508-21.181973-8.697911C485.292295 303.301289 482.017788 295.524333 482.017788 287.645048L482.017788 287.645048z' p-id='3084' data-evernote-id='500' class='js-evernote-checked'%3e%3c/path%3e %3cpath d='M512 946.844409c-239.8577 0-434.895573-195.037873-434.895573-434.895573 0-239.8577 195.037873-434.895573 434.895573-434.895573 239.755371 0 434.895573 195.037873 434.895573 434.895573C946.895573 751.806535 751.755371 946.844409 512 946.844409zM512 126.17088c-212.740682 0-385.880284 173.037274-385.880284 385.777955 0 212.740682 173.037274 385.777955 385.880284 385.777955 212.740682 0 385.777955-173.037274 385.777955-385.777955C897.777955 299.208154 724.740682 126.17088 512 126.17088z' p-id='3085' data-evernote-id='501' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)支持 Markdown 语法](https://guides.github.com/features/mastering-markdown/)

来做第一个留言的人吧！

站点总访问量：39022 站点总访客数：17741

博客内容遵循 [知识共享 署名 - 非商业性 - 相同方式共享 4.0 国际协议](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.zh)

赵梦欢 © 2015 - 2019
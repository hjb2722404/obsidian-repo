eslint prettier的配置选项（参数）官网直译 - javascript拾贝 - SegmentFault 思否

# prettier的配置选项（参数）官网直译

ATTENTION PLEASE:
本翻译仅用于学习交流，禁止商业用途。请参考[prettier官网](https://prettier.io/docs/en/options.html)

我刚刚接触文档翻译，英语自打大学英语六级（CET-6）通过后就在没有提升过，现在基本上都快还给我的英语老师了@_@。直至发稿时，全网（百度）搜索没有发现一片像样的文档，好事心又开始作怪，发出来就当祭天了（估计老天爷都嫌弃文笔差，最近看《明朝那些事儿》才知道祭天得用一种叫做“青词”的专用文章，这事大奸臣严嵩的儿子做得好。。。。。）。好啦，不啰嗦了，如果有大神发现有错误，或者更好的翻译，欢迎带锤子来读（万分感激！）

## 参数

Prettier工具少数几个可以定制的参数，在CLI命令行和配置文件中均可用。

### Print Width

设置prettier单行输出（不折行）的（最大）长度。
出于代码的可读性，我们不推荐（单行）超过80个字符的coding方式。

在代码的书写手册中，单行最大长度常被设置为100或120。但是，人们写代码时，不会刻意的使每行都达到这个上限值。为便于阅读，开发者们通常使用空格将过长的单行变成多行。最佳实践是，每行的平均长度应当小于这个上限值。

另一方面，Prettier 会尽力让代码在一行（所以链式调用就都被搞到一行了，不得不吐槽了^~^）。当print width被设置成120时，工具有可能产出过于紧凑的或是其他不尽人意的代码。

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| 80  | --print-width  <int> | printWidth: <int> |

注：如果在格式markdown时，不想折行，请设置 prose wrap参数来禁止这一行为。

### Tab Width

设置工具每一个水平缩进的空格数

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| 2   | --tab-width  <int> | tabWidth: <int> |

### Tabs

使用tab（制表位）缩进而非空格；

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| false | --use-tabs | useTabs: <bool> |

### Semicolons

在语句末尾添加分号；
有效参数：

- true - 在每一条语句后面添加分号
- false - 只在有可能导致ASI错误的行首添加分号

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| true | --mo-semi | semi: <bool> |

### Quotes

使用单引号而非双引号；
提示：

- 在JSX语法中，所有引号均为双引号，该设置在JSX中被自动忽略
- 在字符串中，如果一种引号在数量上超过另一种引号，数量少的引号，将被用于格式化字符串；示例："I 'm double quoted "被格式化后是："I 'm double quoted "(我觉得这里好像有点问题，但是亲测例子结果就是这样，按理说被较少使用的是单引号，但是例子就是双引号包裹的，尊重原文吧) ；再例："This \"example\" is single quoted "格式化过后：'This "example" is single quoted '

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| false | --single-quote | singleQuote: <bool> |

### Trailing Commas (尾逗号[a,b,c,d,] 数组项d后面的逗号就是尾逗号)

在任何可能的多行中输入尾逗号。
有效参数：

- none  - 无尾逗号；
- es5  - 添加es5中被支持的尾逗号；
- all  - 所有可能的地方都被添加尾逗号；（包括函数参数），这个参数需要安装nodejs8或更高版本；

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| none | --trailing-comma <none \ es5 \ all > | trailingCommas: <none \ es5 \ all> |

### Bracket Spacing (括号空格)

在对象字面量声明所使用的的花括号后（{）和前（}）输出空格
有效参数：

- true - Example: {   foo: bar  }
- false - Example: {foo: bar}

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| true | --none-bracket-spacing | bracketSpacing: <bool> |

### JSX Bracket上

在多行JSX元素最后一行的末尾添加 > 而使 > 单独一行（不适用于自闭和元素）

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| false | --jsx-bracket-same-line | jsxBracketSameLinte: <bool> |

### Arrow Function Parentheses (适用于v1.9.0+)

为单行箭头函数的参数添加圆括号。
有效参数：

- " avoid " - 尽可能不添加圆括号，示例：x => x
- " always " - 总是添加圆括号，示例： (x) => x

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| " avoid " | --arrow-parens < avoid \ always > | alwaysParens: <avoid \ always> |

### Range

只格式化某个文件的一部分；
这两个参数可以用于从指定起止偏移字符(单独指定开始或结束、两者同时指定、分别指定)格式化代码。
一下情况，范围将会扩展：

- 回退至包含选中语句的第一行的开始
- 向前直到选中语句的末尾

注意：这些参数不可以同cursorOffset共用；

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| 0   | --range-start-< int > | rangeStart: < int > |
| Infinity | --range-end-< int > | rangeEnd: < int > |

### Parser

指定使用哪一种解析器。
babylon和flow都支持同一套JavaScript特性（包括Flow）.Prettier将自动根据文件的输入路径选择解析器，如非必要，不要修改该项设置。
内置的解析器包含：

- babylon
- flow
- typescript v1.4.0+（是指Prettier的版本，并包含该版本，下同）
- postcss v1.4.0+
- json v1.5.0+
- graphql v1.5.0+
- markdown v1.8.0+
- 用户自定义解析器 v1.5.0+

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| babylon | --parser < string <br/> --parser ./my-parser | parser: " <string> " <br/> parser: require(" ./my-parserrr ") |

### FilePath

指定文件的输入路径，这将被用于解析器参照。
示例：下面的将使用postcss解析器
`cat foo | prettier --stdin-filepath foo.css`

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| None | --stdin-filepath <string> | filePath: " <string> " |

### Require pragma (v1.7.0+)

Prettier可以严格按照按照文件顶部的一些特殊的注释格式化代码，这些注释称为“require pragma”(必须杂注)。这在逐步格式化一些大型、未经格式化过的代码是十分有用的。

例如，一个带有下面注释的文件将在执行带有 --require-pragma的cli指令（api配置文件亦可）时被格式化

	        */**
	        *@prettier
	        */*

	    或

	        */**
	        *@format
	        */*

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| false | --require-pragma | requirePragma: <bool> |

### Insert Pragma (v1.8.0+)

Prettier可以在文件的顶部插入一个 @format的特殊注释，以表明改文件已经被Prettier格式化过了。在使用 --require-pragma参数处理一连串的文件时这个功能将十分有用。如果文件顶部已经有一个doclock，这个选项将新建一行注释，并打上@format标记。

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| false | --insert-pragma | insertPragma: <bool> |

### Prose Wrap(v1.8.2+)

默认情况下，Prettier会因为使用了一些折行敏感型的渲染器（如GitHub comment 和 BitBucket）而按照markdown文本样式进行折行，但在某些情况下，你可能只是希望这个文本在编译器或查看器中soft-wrapping（是当屏幕放不下时发生的软折行），所以这一参数允许设置为 " never "

有效参数：

- " always " - 当超出print width（上面有这个参数）时就折行
- " never " - 不折行
- " perserve " - 按照文件原样折行 （v1.9.0+）

| 默认值 | CLI(命令行参数)重写（覆盖）默认值 | API重写(配置文件) |
| --- | --- | --- |
| " preserve " | --prose-wrap <always \ neve \preserver > | proseWrap:<always \ never \ preserver > |
#    13 个示例快速入门 JS 抽象语法树   #55


 [Pines-Cheng](https://github.com/Pines-Cheng) opened this issueon 17 Jul 2018· 2 comments

 Labels
 [Babel](https://github.com/Pines-Cheng/blog/labels/Babel)

## Comments


Javascript 代码的**解析**（Parse ）步骤分为两个阶段：[**词法分析**（Lexical Analysis）](https://en.wikipedia.org/wiki/Lexical_analysis)和 [**语法分析**（Syntactic Analysis）](https://en.wikipedia.org/wiki/Parsing)。这个步骤接收代码并输出 [抽象语法树](https://en.wikipedia.org/wiki/Abstract_syntax_tree)，亦称 AST。

随着 Babel 的生态越来越完善，我们通常会使用 Babel 来帮助我们分析代码的解析过程。Babel 使用一个基于 [ESTree](https://github.com/estree/estree) 并修改过的 AST，它的内核说明文档可以在 [这里]([https://github](https://github/). com/babel/babel/blob/master/doc/ast/spec. md) 找到。

在分析 Javascript 的 AST 过程中，借助于工具 [AST Explorer](http://astexplorer.net/) 能帮助我们对 AST 节点有一个更好的感性认识。

为了帮助大家更好的结合实例分析，了解核心的 Babylon AST node types 组成，这里列举了 13 个常用例子，并分别列出了对应的 AST 节点及详细的 node types 解析。

> 以下所有的代码的 AST 全部基于 > [> Babylon7](https://github.com/babel/babylon)

## 变量声明

### 代码

let  a  =  'hello'

### AST

![42793395-950f4ab4-89ac-11e8-817a-8bc74d24b877.png](https://user-images.githubusercontent.com/9441951/42793395-950f4ab4-89ac-11e8-817a-8bc74d24b877.png)

## VariableDeclaration

变量声明，[object Object] 属性表示是什么类型的声明，因为 ES6 引入了 [object Object]。
[object Object] 表示声明的多个描述，因为我们可以这样：[object Object]。

interface  VariableDeclaration  <: Declaration  {  type: "VariableDeclaration"; declarations: [  VariableDeclarator  ]; kind: "var";}

#### VariableDeclarator

变量声明的描述，[object Object] 表示变量名称节点，[object Object] 表示初始值的表达式，可以为 [object Object]。

interface  VariableDeclarator  <: Node  {  type: "VariableDeclarator"; id: Pattern; init: Expression | null;}

## Identifier

标识符，我觉得应该是这么叫的，就是我们写 JS 时自定义的名称，如变量名，函数名，属性名，都归为标识符。相应的接口是这样的：

interface  Identifier  <: Expression,  Pattern  { type: "Identifier"; name: string;}

一个标识符可能是一个表达式，或者是解构的模式（ES6 中的解构语法）。我们等会会看到 [object Object] 和 [object Object] 相关的内容的。

### Literal

字面量，这里不是指 [object Object] 或者 [object Object] 这些，而是本身语义就代表了一个值的字面量，如 [object Object]，[object Object], [object Object] 这些，还有正则表达式（有一个扩展的 [object Object] 来表示正则表达式），如 [object Object]。我们看一下文档的定义：

interface  Literal  <: Expression  {  type: "Literal"; value: string | boolean | null | number | RegExp;}

[object Object] 这里即对应了字面量的值，我们可以看出字面量值的类型，字符串，布尔，数值，[object Object] 和正则。

## 二元运算表达式

### 代码

let  a  =  3+4

### AST

[![42793655-b4ec197e-89ad-11e8-86a0-7d5a8d0152ef.png](../_resources/468429eb913f88ef9925bfca790d02fa.png)](https://user-images.githubusercontent.com/9441951/42793655-b4ec197e-89ad-11e8-86a0-7d5a8d0152ef.png)

### BinaryExpression

二元运算表达式节点，[object Object] 和 [object Object] 表示运算符左右的两个表达式，[object Object] 表示一个二元运算符。

interface  BinaryExpression  <: Expression  {  type: "BinaryExpression"; operator: BinaryOperator; left: Expression; right: Expression;}

#### BinaryOperator

二元运算符，所有值如下：

enum  BinaryOperator  {  "==" | "!=" | "===" | "!==" | "<" | "<=" | ">" | ">=" | "<<" | ">>" | ">>>" | "+" | "-" | "*" | "/" | "%" | "|" | "^" | "&" | "in" | "instanceof"}

## 赋值表达式

### 代码

这个例子会稍微复杂一点，涉及到的 Node 类型比较多。
 this.state  =  {date: new  Date()};

### AST

[![42793260-e1326dc8-89ab-11e8-85b4-84098eb567a3.png](../_resources/73c02a1551fe92a245237fdeabef5df1.png)](https://user-images.githubusercontent.com/9441951/42793260-e1326dc8-89ab-11e8-85b4-84098eb567a3.png)

### ExpressionStatement

表达式语句节点，[object Object] 或者 [object Object] 里边会有一个 [object Object] 属性指向一个表达式节点对象（后边会提及表达式）。

interface  ExpressionStatement  <: Statement  {  type: "ExpressionStatement"; expression: Expression;}

### AssignmentExpression

赋值表达式节点，[object Object] 属性表示一个赋值运算符，[object Object] 和 [object Object] 是赋值运算符左右的表达式。

interface  AssignmentExpression  <: Expression  {  type: "AssignmentExpression"; operator: AssignmentOperator; left: Pattern | Expression; right: Expression;}

##### AssignmentOperator

赋值运算符，所有值如下：（常用的并不多）

enum  AssignmentOperator  {  "=" | "+=" | "-=" | "*=" | "/=" | "%=" | "<<=" | ">>=" | ">>>=" | "|=" | "^=" | "&="}

### MemberExpression

成员表达式节点，即表示引用对象成员的语句，[object Object] 是引用对象的表达式节点，[object Object] 是表示属性名称，[object Object] 如果为 [object Object]，是表示 [object Object] 来引用成员，[object Object] 应该为一个 [object Object] 节点，如果 [object Object] 属性为 [object Object]，则是 [object Object] 来进行引用，即 [object Object] 是一个 [object Object] 节点，名称是表达式的结果值。

interface  MemberExpression  <: Expression,  Pattern  { type: "MemberExpression"; object: Expression; property: Expression; computed: boolean;}

### ThisExpression

表示 [object Object]。
interface  ThisExpression  <: Expression  {  type: "ThisExpression";}

### ObjectExpression

对象表达式节点，[object Object] 属性是一个数组，表示对象的每一个键值对，每一个元素都是一个属性节点。

interface  ObjectExpression  <: Expression  {  type: "ObjectExpression"; properties: [  Property  ];}

#### Property

对象表达式中的属性节点。[object Object] 表示键，[object Object] 表示值，由于 ES5 语法中有 [object Object] 的存在，所以有一个 [object Object] 属性，用来表示是普通的初始化，或者是 [object Object]。

interface  Property  <: Node  {  type: "Property"; key: Literal | Identifier; value: Expression; kind: "init" | "get" | "set";}

### NewExpression

[object Object] 表达式。
interface  NewExpression  <: CallExpression  {  type: "NewExpression";}

## 函数调用表达式

### 代码

console.log(`Hello ${name}`)

### AST

[![42794444-601535f8-89b1-11e8-9c47-c03f648404a3.png](../_resources/cf8f57b387ab2f1dbf8b14d0068d6d83.png)](https://user-images.githubusercontent.com/9441951/42794444-601535f8-89b1-11e8-9c47-c03f648404a3.png)

### CallExpression

函数调用表达式，即表示了 [object Object] 这一类型的语句。[object Object] 属性是一个表达式节点，表示函数，[object Object] 是一个数组，元素是表达式节点，表示函数参数列表。

interface  CallExpression  <: Expression  {  type: "CallExpression"; callee: Expression; arguments: [  Expression  ];}

### TemplateLiteral

[object Object]

### TemplateElement

[object Object]

## 箭头函数

### 代码

i  =>  i++

### AST

[![42794275-86fd01c4-89b0-11e8-85f8-c79eab2ce065.png](../_resources/5f6b245bf1c510a6f9057de54fc20ca3.png)](https://user-images.githubusercontent.com/9441951/42794275-86fd01c4-89b0-11e8-85f8-c79eab2ce065.png)

### ArrowFunctionExpression

箭头函数表达式。

interface  ArrowFunctionExpression  <: Function,  Expression  { type: "ArrowFunctionExpression"; body: BlockStatement | Expression; expression: boolean;}

### UpdateExpression

update 运算表达式节点，即 [object Object]，和一元运算符类似，只是 [object Object] 指向的节点对象类型不同，这里是 update 运算符。

interface  UpdateExpression  <: Expression  {  type: "UpdateExpression"; operator: UpdateOperator; argument: Expression; prefix: boolean;}

##### UpdateOperator

update 运算符，值为 [object Object] 或 [object Object]，配合 update 表达式节点的 [object Object] 属性来表示前后。

enum  UpdateOperator  {  "++" | "--"}

## 函数声明

### 代码

function  Hello(name =  'Lily'){  }

### AST

[![42797154-623ae558-89c0-11e8-99ac-fc40e203f223.png](../_resources/bb04e4d9d62424a73a99b8dc13fd14d5.png)](https://user-images.githubusercontent.com/9441951/42797154-623ae558-89c0-11e8-99ac-fc40e203f223.png)

#### FunctionDeclaration

函数声明，和之前提到的 Function 不同的是，[object Object] 不能为 [object Object]。

interface  FunctionDeclaration  <: Function,  Declaration  { type: "FunctionDeclaration"; id: Identifier;}

### AssignmentPattern

interface  AssignmentPattern  <: Pattern  {  type: "AssignmentPattern"; left: Pattern; right: Expression;}

#### BlockStatement

块语句节点，举个例子：[object Object]，块里边可以包含多个其他的语句，所以有一个 [object Object] 属性，是一个数组，表示了块里边的多个语句。

interface  BlockStatement  <: Statement  {  type: "BlockStatement"; body: [  Statement  ];}

## 类声明

### 代码

class  Clock  extends  Component{render(){  }}

### AST

[![42794790-6eff42dc-89b3-11e8-8438-3b05693333ce.png](../_resources/9be2337dc93a82498a5c1163660a4599.png)](https://user-images.githubusercontent.com/9441951/42794790-6eff42dc-89b3-11e8-8438-3b05693333ce.png)

### Classes

interface  Class  <: Node  {  id: Identifier | null; superClass: Expression | null; body: ClassBody; decorators: [  Decorator  ];}

### ClassBody

interface  ClassBody  <: Node  {  type: "ClassBody"; body: [  ClassMethod | ClassPrivateMethod | ClassProperty | ClassPrivateProperty  ];}

### ClassMethod

interface  ClassMethod  <: Function  {  type: "ClassMethod"; key: Expression; kind: "constructor" | "method" | "get" | "set"; computed: boolean; static: boolean; decorators: [  Decorator  ];}

## if 语句

### 代码

if(a  ===  0){}

### AST

[![42794874-d19e4aa0-89b3-11e8-9a60-89a3abaff288.png](../_resources/f19a438e9b9e2885917bf05293d0837a.png)](https://user-images.githubusercontent.com/9441951/42794874-d19e4aa0-89b3-11e8-9a60-89a3abaff288.png)

### IfStatement

[object Object] 语句节点，很常见，会带有三个属性，[object Object] 属性表示 [object Object] 括号中的表达式。
[object Object] 属性是表示条件为 [object Object] 时的执行语句，通常会是一个块语句。

[object Object] 属性则是用来表示 [object Object] 后跟随的语句节点，通常也会是块语句，但也可以又是一个 [object Object] 语句节点，即类似这样的结构：

[object Object]。
[object Object] 当然也可以为 [object Object]。

interface  IfStatement  <: Statement  {  type: "IfStatement"; test: Expression; consequent: Statement; alternate: Statement | null;}

## switch 语句

### 代码

switch(num){  case  0: x  =  'Sunday'  break;  default: x  =  'Weekday'}

### AST

[![42795024-833c8d9e-89b4-11e8-968a-fc90dc0367e1.png](../_resources/0a66289812a5fe0bdd5567570629d3ba.png)](https://user-images.githubusercontent.com/9441951/42795024-833c8d9e-89b4-11e8-968a-fc90dc0367e1.png)

### SwitchStatement

[object Object] 语句节点，有两个属性，[object Object] 属性表示 [object Object] 语句后紧随的表达式，通常会是一个变量，[object Object] 属性是一个 [object Object] 节点的数组，用来表示各个 [object Object] 语句。

interface  SwitchStatement  <: Statement  {  type: "SwitchStatement"; discriminant: Expression; cases: [  SwitchCase  ];}

### SwitchCase

[object Object] 的 [object Object] 节点。[object Object] 属性代表这个 [object Object] 的判断表达式，[object Object] 则是这个 [object Object] 的执行语句。

当 [object Object] 属性是 [object Object] 时，则是表示 [object Object] 这个 [object Object] 节点。

interface  SwitchCase  <: Node  {  type: "SwitchCase"; test: Expression | null; consequent: [  Statement  ];}

## for 语句

### 代码

for  (var  i  =  0;  i  <  9;  i++)  {}

### AST

[![42795129-2471faaa-89b5-11e8-806b-dd345c71e920.png](../_resources/8ccfe142ff05295e0efbbc52f57ee496.png)](https://user-images.githubusercontent.com/9441951/42795129-2471faaa-89b5-11e8-806b-dd345c71e920.png)

#### ForStatement

[object Object] 循环语句节点，属性 [object Object] 分别表示了 [object Object] 语句括号中的三个表达式，初始化值，循环判断条件，每次循环执行的变量更新语句（[object Object] 可以是变量声明或者表达式）。这三个属性都可以为 [object Object]，即 [object Object]。

[object Object] 属性用以表示要循环执行的语句。

interface  ForStatement  <: Statement  {  type: "ForStatement"; init: VariableDeclaration | Expression | null; test: Expression | null; update: Expression | null; body: Statement;}

## 模块引入

### 代码

import  React  from  'react'

### AST

[![42795169-5eda0a34-89b5-11e8-94d2-36ba50d84bdc.png](../_resources/6855edbfdcdc66a925927282ea74a40f.png)](https://user-images.githubusercontent.com/9441951/42795169-5eda0a34-89b5-11e8-94d2-36ba50d84bdc.png)

### ImportDeclaration

模块声明。

interface  ImportDeclaration  <: ModuleDeclaration  {  type: "ImportDeclaration"; specifiers: [  ImportSpecifier | ImportDefaultSpecifier | ImportNamespaceSpecifier  ]; source: Literal;}

### ImportDefaultSpecifier

interface  ImportDefaultSpecifier  <: ModuleSpecifier  {  type: "ImportDefaultSpecifier";}

## 模块导出

### 代码

export  default  Clock

### AST

[![42795204-a31e635c-89b5-11e8-97e3-93b4801cb448.png](../_resources/d6b590951994d0b1a0a3a6f714aba9a0.png)](https://user-images.githubusercontent.com/9441951/42795204-a31e635c-89b5-11e8-97e3-93b4801cb448.png)

### ExportDefaultDeclaration

interface  OptFunctionDeclaration  <: FunctionDeclaration  {  id: Identifier | null;}interface  OptClasDeclaration  <: ClassDeclaration  {  id: Identifier | null;}interface  ExportDefaultDeclaration  <: ModuleDeclaration  {  type: "ExportDefaultDeclaration"; declaration: OptFunctionDeclaration | OptClassDeclaration | Expression;}

## JSX render 方法

### 代码：

 render()  {  return  (  <div>  <h1>Hello, world!</h1>  <h2>It is {this.state.date.toLocaleTimeString()}.</h2>  </div>  );  }

### AST

[![42795248-e5103c90-89b5-11e8-9241-2875b63f979d.png](../_resources/7379a12e64982d1c83b4b9431dc5636c.png)](https://user-images.githubusercontent.com/9441951/42795248-e5103c90-89b5-11e8-9241-2875b63f979d.png)

## 参考

- [babel-handbook](https://github.com/jamiebuilds/babel-handbook)
- [babylon spec.md](https://github.com/babel/babylon/blob/master/ast/spec.md)
- [estree](https://github.com/estree/estree)
- [使用 Acorn 来解析 JavaScript](https://juejin.im/post/582425402e958a129926fcb4)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-tag js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='30'%3e%3cpath fill-rule='evenodd' d='M2.5 7.775V2.75a.25.25 0 01.25-.25h5.025a.25.25 0 01.177.073l6.25 6.25a.25.25 0 010 .354l-5.025 5.025a.25.25 0 01-.354 0l-6.25-6.25a.25.25 0 01-.073-.177zm-1.5 0V2.75C1 1.784 1.784 1 2.75 1h5.025c.464 0 .91.184 1.238.513l6.25 6.25a1.75 1.75 0 010 2.474l-5.026 5.026a1.75 1.75 0 01-2.474 0l-6.25-6.25A1.75 1.75 0 011 7.775zM6 5a1 1 0 100 2 1 1 0 000-2z' data-evernote-id='1635' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![9441951](../_resources/1974dd89570efb058115b54ead96e587.png)](https://github.com/Pines-Cheng)[Pines-Cheng](https://github.com/Pines-Cheng) added the   [Babel](https://github.com/Pines-Cheng/blog/labels/Babel) label [on 17 Jul 2018](https://github.com/Pines-Cheng/blog/issues/55#event-1736765082)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-pencil js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='31'%3e%3cpath fill-rule='evenodd' d='M11.013 1.427a1.75 1.75 0 012.474 0l1.086 1.086a1.75 1.75 0 010 2.474l-8.61 8.61c-.21.21-.47.364-.756.445l-3.251.93a.75.75 0 01-.927-.928l.929-3.25a1.75 1.75 0 01.445-.758l8.61-8.61zm1.414 1.06a.25.25 0 00-.354 0L10.811 3.75l1.439 1.44 1.263-1.263a.25.25 0 000-.354l-1.086-1.086zM11.189 6.25L9.75 4.81l-6.286 6.287a.25.25 0 00-.064.108l-.558 1.953 1.953-.558a.249.249 0 00.108-.064l6.286-6.286z' data-evernote-id='1641' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![9441951](../_resources/1974dd89570efb058115b54ead96e587.png)](https://github.com/Pines-Cheng)[Pines-Cheng](https://github.com/Pines-Cheng) changed the title<s>13 个例子快速入门 JS 抽象语法树</s>13 个示例快速入门 JS 抽象语法树  [on 17 Jul 2018](https://github.com/Pines-Cheng/blog/issues/55#event-1736767719)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='32'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='1648' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![16515708](../_resources/0fa1dc5448347df1936330e47c320e2b.jpg)](https://github.com/jawil)[jawil](https://github.com/jawil) mentioned this issue [on 10 Sep 2018](https://github.com/Pines-Cheng/blog/issues/55#ref-issue-212667365)

 [奇文共欣赏，疑义相与析jawil/blog#6](https://github.com/jawil/blog/issues/6)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='33'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='1657' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='34'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='1665' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   [![27266016](../_resources/1b2056b6dc5ac1ff022c18db84a9ee5d.png)](https://github.com/nanhupatar)  **  [nanhupatar](https://github.com/nanhupatar)  ** commented [on 29 Sep 2018](https://github.com/Pines-Cheng/blog/issues/55#issuecomment-425652052)

|     |
| --- |
| 可以授权前端指南公众号进行转载么 |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='35'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='1687' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

  Owner This user is the owner of the blog repository.   AuthorThis user is the author of this issue.

###   [![9441951](../_resources/1974dd89570efb058115b54ead96e587.png)](https://github.com/Pines-Cheng)  **  [Pines-Cheng](https://github.com/Pines-Cheng)  ** commented [on 8 Oct 2018](https://github.com/Pines-Cheng/blog/issues/55#issuecomment-427706394)

|     |
| --- |
| [@nanhupatar](https://github.com/nanhupatar) 可以 |

 [Sign up for free](https://github.com/join?source=comment-repo)  **to join this conversation on GitHub**. Already have an account? [Sign in to comment](https://github.com/login?return_to=https%3A%2F%2Fgithub.com%2FPines-Cheng%2Fblog%2Fissues%2F55)

Assignees
  No one assigned

Labels

 [Babel](https://github.com/Pines-Cheng/blog/labels/Babel)

Projects
  None yet

Milestone
No milestone

Linked pull requests

Successfully merging a pull request may close this issue.
None yet

2 participants

 [![9441951](../_resources/b5d3e2af154cf9f865f11c3c4b7593f5.png)](https://github.com/Pines-Cheng)  [![27266016](../_resources/73fcbec4489d6e26f20bd5b9f636c859.png)](https://github.com/nanhupatar)
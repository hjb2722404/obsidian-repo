你不了解的javascript（一）

# 你不了解的javascript （一）

## 作用域和闭包

- js的编译经过了三个步骤

    1. 词法分析
    2. 语法分析
    3. 代码生成

- 作用域负责维护所有声明的标识符（变量）组成的一系列查询，并实施一套非常严格的规则，确定当前执行的代码对这些标识符的访问权限。（关键字：【声明，标识符、权限】）
- 引擎在执行编译器生成的代码时，会借助作用域来查找变量。查找有两种方式：`LHS`和`RHS`。LHS负责找到变量的容器（指针名称），`RHS`负责找到变量的值，然后引擎将RHS查到的值放入`LHS`查到的容器，这个过程就是赋值。
- 当一个块活函数嵌套在另一个块或函数中时，就发生了作用域的嵌套，当作用域嵌套时，引擎如果在内层作用域中找不到变量，就会向上一层去找，一直找到全局作用域为止，这就是作用域链。
- `LHS`和`RHS`在找不到结果时，会有不同行为
    - `LHS` 会在全局作用域中创建一个具有该名称的变量。（非严格模式下）
    - `RHS`抛出错误为 `ReferenceError`
- 对RHS找到的变量进行不合理的操作，会抛出 `TypeError`
- 作用域有两种模型
    - 词法作用域，明显是基于静态的词法分析得到的作用域，js采用这种
    - 动态作用域
- js 有两种方式可以在运行时"修改"作用域(现在已经都不推荐使用)：
    - eval
    - with
- js有两种作用域
    - 函数作用域
    - 块级作用域
- 利用函数作用域，我们可以隐藏函数的内部实现以及规避命名冲突
- 【最佳实践】：无论何时，给函数表达式一个名字
- IIFE（立即执行函数表达式）可以命名
- 在ES6之前，有两种方式可以生产一个块级作用域
    - with
    - try/catch 中的catch是一个块级作用域
- 在ES6之后，新增两种块级作用域语法
    - let
    - const
- 变量提升机制中，变量赋值经历了两个阶段，变量的声明会在第一阶段被提升到作用域顶部，而变量的赋值操作将留在原地等待执行。赋值操作前引用变量，将会得到`undefined`
- 函数声明会被提升，但函数表达式不会被提升
- 在同时存在普通变量声明和函数声明时，函数声明会被提升到普通变量之前。
- 应该尽量避免在块的内部声明函数
- 当函数可以记住并访问所在的词法作用域时，就产生了闭包。
- 闭包最经典的应用是在for循环中需要记住当前变量时，可通过闭包保存。
- 解决循环变量的另一种方式是块作用域（let）
- 模块机制是基于闭包来实现的。

## this和对象原型

- 对this的两个最常见的误解：
    - this 指向函数自身
    - this 指向函数的作用域
- this是运行时进行绑定的，它的绑定和函数声明的位置没有任何关系，只取决于函数的【调用方式】；
- 当函数运行时，会产生执行上下文用来记录函数在哪里被调用（调用栈），函数的调用方法、入参等信息，this就是记录的其中一个属性，会在函数执行过程中用到。
- 调用位置，区别于函数的声明位置
- 可以通过分析调用栈来找到this真正的指向
- this有四条绑定规则：
    - 默认绑定。即默认规则，非严格模式下绑定到全局对象，严格模式下绑定到 undefined
    - 隐式绑定。绑定到上下文对象或包含它的对象上，但会发生隐式丢失
    - 显式绑定。使用call或apply方法显示绑定到某个对象上
    - new绑定。 new会构造一个新对象，并将this绑定到新对象上
- 四条规则的优先级：
    - new绑定 > 显式绑定 > 隐式绑定 > 默认绑定
- 有些调用可能在无意中使用默认绑定规则，可以使用DMZ对象保护全局对象。
- ES6中的箭头函数会继承外层函数调用的this绑定。
- js中的基本类型和对象类型
    - 基本类型
        - string
        - number
        - boolean
        - null
        - undefined
        - object
    - 对象类型
        - String
        - Number
        - Boolean
        - Object
        - Function
        - Array
        - Date
        - RegExp
        - Error
- 尽管使用 typeof 检查 null 类型时会返回 Object,但它并不是对象类型，而是因为二进制中前三位为0的都会被判定为对象，而null 是全0，所以也被判定成Object,这是js的一个bug
- 使用typeof对对象类型进行判定时，除了Function会返回“function”，其它都返回 “object”
- js 中的string与number字面量可以使用对象语法，因为引擎会自动将字面量转换为对象类型。
- 对象的内容既可以使用点语法来访问，也可以使用数组语法来访问；
- 对象中的方法其实并不属于对象，而只是一个引用
- 使用 defineProperty , 结合 writable:false 和 configurable:false 可以为对象创建常量属性
- Object 的一些特殊方法
    - preventExtensions() 禁止对象添加新属性并保留已有属性
    - seal() 创建一个密封对象，既不能添加新属性，也不能重新配置活删除现有属性（但可以修改属性值）
    - freeze(),冻结对象，在sael的基础上，禁止修改属性值
- 对对象属性进行访问活赋值时对象内部具有[[GET]] 和 [[PUT]] 两种算法，分别可以控制属性值的设置和获取。
- 在ES5之后，每一个对象属性都可以设置 getter和setter方法
- 在判断某对象是否具有某属性时，有两种操作符：
    - in 会检查对象及其原型链中是否具有该属性
    - hasOwnProperty 只会检查对象自身是否具有该属性
    - 通过 Object.create(null) 方法创建的对象不具有 hasOwnProperty 方法，可以调用 Object.prototype.hasOwnProperty.call 方法来将对象原型上的该方法硬绑定到该对象上。
- 对象的枚举属性
    - 对象的不可枚举属性不会出现在 for ... in 循环中；
    - propertyIsEnumerable(..) 会检查给定的属性名是否直接存在于对象中（而不是在原型链上）并且满足 enumerable:true 。
    - Object.keys(..) 会返回一个数组，包含所有可枚举属性
    - Object.getOwnPropertyNames(..) 会返回一个数组，包含所有属性，无论它们是否可枚举。
- 对象的遍历
    - for...in 会遍历包含原型链的属性
    - forEach() 可遍历数组中的所有值并忽略回调函数的返回值
    - every() 会一直运行直到回调函数返回false或假值
    - some() 会一直运行直到回调函数返回true或真值
    - 遍历对象属性时的顺序在不同js引擎中是不一样的
    - for...of 是ES6以后新增的遍历对象值的方法
    - ES6中，所有具有迭代器对象的数据结构都可以使用for...of遍历


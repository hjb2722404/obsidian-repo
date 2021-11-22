ES6规范阅读

1.函数是对象，那函数对象与普通对象之间的区别是什么？
2.使用new与使用object.creat创建的对象有何不同
3.普通对象的内建插槽：

- GetPrototypeOf：  确定为该对象提供继承属性的对象。空值表示没有继承属性
- SetPrototypeOf：  将此对象与另一个提供继承属性的对象关联。传递null表示没有继承属性。返回true，表示操作成功完成;返回false，表示操作不成功
- IsExtensible：  确定是否允许向该对象添加其他属性
- PreventExtensions：  控制是否可以向此对象添加新属性。如果操作成功，返回true;如果操作不成功，返回false
- GetOwnProperty：  返回此对象自己的属性的属性描述符，该属性的键为propertyKey，如果不存在该属性，则为未定义的
- HasProperty：   返回一个布尔值，指示该对象是否已经拥有自己的或继承的键为propertyKey的属性
- Get：  从该对象返回其键为propertyKey的属性的值。如果必须执行任何ECMAScript代码来检索属性值，则在计算代码时将使用Receiver作为此值
- Set：   将键为propertyKey的属性的值设置为value。如果必须执行任何ECMAScript代码来设置属性值，则在计算代码时将使用Receiver作为此值。如果属性值已设置，则返回true;如果无法设置，则返回false。
- Delete：  从此对象中删除键为propertyKey的自有属性。如果属性未被删除且仍然存在，则返回false。如果属性已删除或不存在，则返回true。
- DefineOwnProperty：  创建或更改其自身的属性（其键为propertyKey），以具有PropertyDescriptor描述的状态。 如果成功创建/更新了该属性，则返回true；如果无法创建或更新该属性，则返回false
- Enumerate：  返回一个迭代器对象，该对象生成对象的字符串键可枚举属性的键。
- OwnPropertyKeys：  返回一个列表，其中的元素都是该对象自己的属性键

4.函数对象比普通对象多两个内建插槽

- Call：  执行与此对象关联的代码。通过函数调用表达式调用。内部方法的参数是一个this值和一个包含通过调用表达式传递给函数的参数的列表。实现此内部方法的对象是可调用的
- Construct：  创建一个对象。通过新的或超操作符调用。内部方法的第一个参数是一个包含操作符参数的列表。第二个参数是新操作符最初应用到的对象。实现这个内部方法的对象称为构造函数。函数对象不一定是构造函数，这样的非构造函数对象没有[[Construct]]内部方法

5.函数对象的内部插槽

- Environment：  函数被关闭的词汇环境。在计算函数的代码时用作外部环境
- FormalParameters：  源文本的根解析节点，它定义函数的形式参数列表
- FunctionKind：  “普通”、“类构造函数”或“生成器”（  **"normal"**, **"classConstructor"** or **"generator**）
- ECMAScriptCode：  定义函数主体的源文本的根解析节点
- ConstructorKind：  “基础”或“派生” （  **"base"** or **"derived"**）
- Realm：  创建函数的代码域，它提供函数求值时要访问的任何内部对象
- ThisMode：  定义在函数的形式参数和代码体中如何解释this引用。
    - 如果值为'lexical',意思是它引用一个词法上封闭的函数的this值。
    - 如果值为`strict`,意味着这个值完全按照函数调用所提供的值来使用。
    - global表示未定义的this值被解释为对全局对象的引用
- Strict:   如果这是严格的模态函数，为真，如果不是严格的模态函数，为假
- HomeObject:   如果函数使用super，这个对象的[[GetPrototypeOf]]提供了super属性查找开始的对象
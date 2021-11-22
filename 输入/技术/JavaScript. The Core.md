JavaScript. The Core.

## [Dmitry Soshnikov 德米特里 · 索什尼科夫](http://dmitrysoshnikov.com/)in  在[ECMAScript](http://dmitrysoshnikov.com/category/ecmascript/) | [2010-09-02](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/)

# JavaScript. The Core.

# JavaScript，核心

- [](https://twitter.com/intent/tweet?text=JavaScript.%20The%20Core.&url=http%3A%2F%2Fdmitrysoshnikov.com%2Fecmascript%2Fjavascript-the-core%2F)
- [](https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Fdmitrysoshnikov.com%2Fecmascript%2Fjavascript-the-core%2F&t=JavaScript.%20The%20Core.)
- [](https://www.linkedin.com/shareArticle?url=http%3A%2F%2Fdmitrysoshnikov.com%2Fecmascript%2Fjavascript-the-core%2F&title=JavaScript.%20The%20Core.&mini=true)

Read this article in: [German](http://molily.de/javascript-core/), [Russian](http://dmitrysoshnikov.com/ecmascript/ru-javascript-the-core/), [French](http://fgribreau.com/articles/voyage-au-coeur-de-javascript.html), [Polish](http://eternes.pl/blog/ecma-262-javascript-the-core).

阅读这篇文章: 德语，俄语，法语，波兰语。

**Note:** a new [2nd Edition](http://dmitrysoshnikov.com/ecmascript/javascript-the-core-2nd-edition/) of this article is available.

注意: 本文的第二版已经发布。

**Note:** see also **[Essentials of Interpretation](http://dmitrysoshnikov.com/courses/essentials-of-interpretation/)** course, where we build a programming language similar to JavaScript, from scratch.

注意: 请参阅解释课程要点，在这里我们从头开始构建一个类似于 JavaScript 的编程语言。

1. [An object 一个物体](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#an-object)

2. [A prototype chain 一个原型链](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#a-prototype-chain)

3. [Constructor 构造函数](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#constructor)

4. [Execution context stack 执行上下文堆栈](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#execution-context-stack)

5. [Execution context 执行环境](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#execution-context)

6. [Variable object 变量对象](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#variable-object)

7. [Activation object 激活对象](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#activation-object)

8. [Scope chain 范围链](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#scope-chain)

9. [Closures 关闭](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#closures)

10. [This value 这个值](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#this-value)

11. [Conclusion 总结](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#conclusion)

This note is an overview and summary of the “[ECMA-262-3 in detail](http://dmitrysoshnikov.com/tag/ecma-262-3/)” series. Every section contains references to the appropriate matching chapters so you can read them to get a deeper understanding.

本说明是“ ECMA-262-3详细说明”系列的概述和摘要。每个部分都包含对应章节的参考资料，这样你就可以通过阅读这些章节来获得更深入的理解。
Intended audience: experienced programmers, professionals.
目标受众: 经验丰富的程序员，专业人士。

We start out by considering the concept of an *object*, which is fundamental to ECMAScript.

我们首先考虑对象的概念，这是 ECMAScript 的基础。

## [An object 一个物体](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#an-object)

ECMAScript, being a highly-abstracted object-oriented language, deals with *objects*. There are also *primitives*, but they, when needed, are also converted to objects.

ECMAScript 是一种高度抽象的面向对象语言，它处理对象。还有一些原语，但是在需要的时候，它们也被转换为对象。

An object is a *collection of properties* and has a *single prototype object*. The prototype may be either an object or the `null` value.

对象是属性的集合，只有一个原型对象。原型可以是一个对象，也可以是空值。

Let’s take a basic example of an object. A prototype of an object is referenced by the internal `[[Prototype]]` property. However, in figures we will use `__<internal-property>__` underscore notation instead of the double brackets, particularly for the prototype object: `__proto__`.

让我们来看一个对象的基本例子。对象的原型通过内部的[[[ Prototype ]]属性引用。但是，在图中，我们将使用 _ < internal-property > _ _ 下划线表示法代替双括号表示法，特别是对于原型对象: _ proto _。

For the code:
关于代码:
1
2
3
4
[object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

we have the structure with two explicit *own* properties and one implicit `__proto__` property, which is the reference to the prototype of `foo`:

我们有一个结构，它有两个显式的属性和一个隐式的 proto 属性，这个属性是指 foo 的原型:
![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143714.png)
Figure 1. A basic object with a prototype.
图1. 带有原型的基本对象。

What for these prototypes are needed? Let’s consider a *prototype chain* concept to answer this question.

这些原型需要什么? 让我们考虑一个原型链的概念来回答这个问题。

## [A prototype chain 一个原型链](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#a-prototype-chain)

Prototype objects are also just simple objects and may have their own prototypes. If a prototype has a non-null reference to its prototype, and so on, this is called the *prototype chain*.

原型对象也只是简单的对象，可能有自己的原型。如果一个原型对它的原型有一个非空的引用，等等，这就叫做原型链。

A prototype chain is a *finite* chain of objects which is used to implement *inheritance* and *shared properties*.

原型链是一个有限的对象链，用于实现继承和共享属性。

Consider the case when we have two objects which differ only in some small part and all the other part is the same for both objects. Obviously, for a good designed system, we would like to *reuse* that similar functionality/code without repeating it in every single object. In class-based systems, this *code reuse* stylistics is called the *class-based inheritance* — you put similar functionality into the class `A`, and provide classes `B` and `C` which inherit from `A` and have their own small additional changes.

考虑这样一种情况: 我们有两个对象，它们只有一小部分不同，而对于两个对象，其他部分都是相同的。显然，对于一个设计良好的系统，我们希望重用相似的功能/代码，而不是在每个对象中重复它。在基于类的系统中，这种代码重用被称为基于类的继承——你把类似的功能放到类 a 中，然后提供类 b 和类 c，它们继承自 a，并且有它们自己的小的附加变化。

ECMAScript has no concept of a class. However, a code reuse stylistics does not differ much (though, in some aspects it’s even more flexible than class-based) and achieved via the *prototype chain*. This kind of inheritance is called a *delegation based inheritance* (or, closer to ECMAScript, a *prototype based inheritance*).

没有类的概念。然而，代码重用文体学没有太大的不同(尽管，在某些方面它甚至比基于类的更加灵活) ，并且是通过原型链实现的。这种类型的继承称为基于委托的继承(或者，更接近于 ECMAScript，一种基于原型的继承)。

Similarly like in the example with classes `A`, `B` and `C`, in ECMAScript you create objects: `a`, `b`, and `c`. Thus, object `a` stores this common part of both `b` and `c` objects. And `b` and `c` store just their own additional properties or methods.

与类 a、 b 和 c 的例子类似，在 ECMAScript 中创建对象: a、 b 和 c，因此，对象 a 存储了 b 和 c 对象的这个公共部分。而 b 和 c 只存储它们自己的附加属性或方法。

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
[object Object]  [object Object]
[object Object][object Object]
[object Object][object Object][object Object]  [object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object]
[object Object]

[object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

[object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

[object Object]
[object Object][object Object]
[object Object][object Object]

Easy enough, isn’t it? We see that `b` and `c` have access to the `calculate` method which is defined in `a` object. And this is achieved exactly via this prototype chain.

The rule is simple: if a property or a method is not found in the object itself (i.e. the object has no such an *own* property), then there is an attempt to find this property/method in the prototype chain. If the property is not found in the prototype, then a prototype of the prototype is considered, and so on, i.e. the whole prototype chain (absolutely the same is made in class-based inheritance, when resolving an inherited *method* — there we go through the *class chain*). The first found property/method with the same name is used. Thus, a found property is called *inherited* property. If the property is not found after the whole prototype chain lookup, then `undefined` value is returned.

Notice, that `this` value in using an inherited method is set to the *original* object, but not to the (prototype) object in which the method is found. I.e. in the example above `this.y` is taken from `b` and `c`, but not from `a`. However, `this.x` is taken from `a`, and again via the *prototype chain* mechanism.

If a prototype is not specified for an object explicitly, then the default value for `__proto__` is taken — `Object.prototype`. Object `Object.prototype` itself also has a `__proto__`, which is the *final link* of a chain and is set to `null`.

The next figure shows the inheritance hierarchy of our `a`, `b` and `c` objects:

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143719.png)
Figure 2. A prototype chain.

Notice: ES5 standardized an alternative way for prototype-based inheritance using `Object.create` function:

1
2
[object Object]  [object Object]
[object Object]  [object Object]

You can get more info on new ES5 APIs in the [appropriate chapter](http://dmitrysoshnikov.com/ecmascript/es5-chapter-1-properties-and-property-descriptors/#new-api-methods).

ES6 though standardizes the `__proto__`, and it can be used at initialization of objects.

Often it is needed to have objects with the *same or similar state structure* (i.e. the same set of properties), and with different *state values*. In this case we may use a *constructor function* which produces objects by *specified pattern*.

## [Constructor](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#constructor)

Besides creation of objects by specified pattern, a *constructor* function does another useful thing — it *automatically sets a prototype object* for newly created objects. This prototype object is stored in the `ConstructorFunction.prototype` property.

E.g., we may rewrite previous example with `b` and `c` objects using a constructor function. Thus, the role of the object `a` (a prototype) `Foo.prototype` plays:

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
[object Object]
[object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]
[object Object]

[object Object]
[object Object]
[object Object]
[object Object]
[object Object]

[object Object]
[object Object]

[object Object]
[object Object][object Object]  [object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object]

[object Object]
[object Object]
[object Object]  [object Object][object Object]  [object Object]
[object Object]  [object Object][object Object]  [object Object]

[object Object]
[object Object][object Object]
[object Object][object Object]

[object Object]
[object Object]

[object Object]

[object Object][object Object][object Object]
[object Object][object Object][object Object]

[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]

[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]

[object Object][object Object][object Object]
[object Object][object Object][object Object]

[object Object]
This code may be presented as the following relationship:
![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143724.png)
Figure 3. A constructor and objects relationship.

This figure again shows that every object has a prototype. Constructor function `Foo` also has its own `__proto__` which is `Function.prototype`, and which in turn also references via its `__proto__` property again to the `Object.prototype`. Thus, repeat, `Foo.prototype` is just an explicit property of `Foo` which refers to the prototype of `b` and `c` objects.

Formally, if to consider a concept of a *classification* (and we’ve exactly just now *classified* the new separated thing — `Foo`), a combination of the constructor function and the prototype object may be called as a “class”. Actually, e.g. Python’s *first-class* dynamic classes have absolutely the same implementation of properties/methods resolution. From this viewpoint, classes of Python are just a syntactic sugar for delegation based inheritance used in ECMAScript.

Notice: in ES6 the concept of a “class” is standardized, and is implemented as exactly a syntactic sugar on top of the constructor functions as described above. From this viewpoint prototype chains become as an implementation detail of the class-based inheritance:

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
[object Object]
[object Object]  [object Object]
[object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object]

[object Object][object Object]
[object Object][object Object]  [object Object][object Object]
[object Object][object Object]
[object Object]

[object Object]  [object Object][object Object]  [object Object]
[object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object]
[object Object]

[object Object]  [object Object][object Object]  [object Object][object Object][object Object]

[object Object][object Object]

The complete and detailed explanation of this topic may be found in the Chapter 7 of ES3 series. There are two parts: [Chapter 7.1. OOP. The general theory](http://dmitrysoshnikov.com/ecmascript/chapter-7-1-oop-general-theory/), where you will find description of various OOP paradigms and stylistics and also their comparison with ECMAScript, and [Chapter 7.2. OOP. ECMAScript implementation](http://dmitrysoshnikov.com/ecmascript/chapter-7-2-oop-ecmascript-implementation/), devoted exactly to OOP in ECMAScript.

Now, when we know basic object aspects, let’s see on how the *runtime program execution* is implemented in ECMAScript. This is what is called an *execution context stack*, every element of which is abstractly may be represented as also an object. Yes, ECMAScript almost everywhere operates with concept of an object

## [Execution context stack](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#execution-context-stack)

There are three types of ECMAScript code: *global* code, *function* code and *eval* code. Every code is evaluated in its *execution context*. There is only one global context and may be many instances of function and *eval* execution contexts. Every call of a function, enters the function execution context and evaluates the function code type. Every call of `eval` function, enters the *eval* execution context and evaluates its code.

Notice, that one function may generate infinite set of contexts, because every call to a function (even if the function calls itself recursively) produces a new context with a new *context state*:

1
2
3
4
5
6
7
8
9
10
11
[object Object]  [object Object]

[object Object]
[object Object]
[object Object]
[object Object]
[object Object]

[object Object]
[object Object]
[object Object]

An execution context may activate another context, e.g. a function calls another function (or the global context calls a global function), and so on. Logically, this is implemented as a stack, which is called the *execution context stack*.

A context which activates another context is called a *caller*. A context is being activated is called a *callee*. A callee at the same time may be a caller of some other callee (e.g. a function called from the global context, calls then some inner function).

When a caller activates (calls) a callee, the caller suspends its execution and passes the control flow to the callee. The callee is pushed onto the the stack and is becoming a *running (active)* execution context. After the callee’s context ends, it returns control to the caller, and the evaluation of the caller’s context proceeds (it may activate then other contexts) till the its end, and so on. A callee may simply *return* or exit with an *exception*. A thrown but not caught exception may exit (pop from the stack) one or more contexts.

I.e. all the ECMAScript *program runtime* is presented as the *execution context (EC) stack*, where *top* of this stack is an *active* context:

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143730.png)
Figure 4. An execution context stack.

When program begins it enters the *global execution context*, which is the *bottom* and the *first* element of the stack. Then the global code provides some initialization, creates needed objects and functions. During the execution of the global context, its code may activate some other (already created) function, which will enter their execution contexts, pushing new elements onto the stack, and so on. After the initialization is done, the runtime system is waiting for some *event* (e.g. user’s mouse click) which will activate some function and which will enter a new execution context.

In the next figure, having some function context as `EC1` and the global context as `Global EC`, we have the following stack modification on entering and exiting `EC1` from the global context:

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143733.png)
Figure 5. An execution context stack changes.

This is exactly how the runtime system of ECMAScript manages the execution of a code.

More information on execution context in ECMAScript may be found in the appropriate [Chapter 1. Execution context](http://dmitrysoshnikov.com/ecmascript/chapter-1-execution-contexts/).

As we said, every execution context in the stack may be presented as an object. Let’s see on its structure and what kind of *state* (which properties) a context is needed to execute its code.

## [Execution context](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#execution-context)

An execution context abstractly may be represented as a simple object. Every execution context has set of properties (which we may call a *context’s state*) necessary to track the execution progress of its associated code. In the next figure a structure of a context is shown:

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143736.png)
Figure 6. An execution context structure.

Besides these three needed properties (a *variable object*, a *`this` value* and a *scope chain*), an execution context may have any additional state depending on implementation.

Let’s consider these important properties of a context in detail.

## [Variable object](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#variable-object)

A *variable object* is a *container of data* associated with the execution context. It’s a special object that stores *variables* and *function declarations* defined in the context.

Notice, that *function expressions* (in contrast with *function declarations*) are *not included* into the variable object.

A variable object is an abstract concept. In different context types, physically, it’s presented using different object. For example, in the global context the variable object is the *global object itself* (that’s why we have an ability to refer global variables via property names of the global object).

Let’s consider the following example in the global execution context:
1
2
3
4
5
6
7
8
9
10
11
[object Object]  [object Object]

[object Object]  [object Object][object Object]
[object Object][object Object]  [object Object][object Object]

[object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]

[object Object][object Object]

Then the global context’s variable object (VO) will have the following properties:

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143741.png)
Figure 7. The global variable object.

See again, that function `baz` being a *function expression* is not included into the variable object. That’s why we have a `ReferenceError` when trying to access it outside the function itself.

Notice, that in contrast with other languages (e.g. C/C++) in ECMAScript *only functions* create a new scope. Variables and inner functions defined within a scope of a function are not visible directly outside and do not pollute the global variable object.

Using `eval` we also enter a new (eval’s) execution context. However, `eval` uses either global’s variable object, or a variable object of the caller (e.g. a function from which `eval` is called).

And what about functions and their variable objects? In a function context, a variable object is presented as an *activation object*.

## [Activation object](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#activation-object)

When a function is *activated* (called) by the caller, a special object, called an *activation object* is created. It’s filled with *formal parameters* and the special `arguments` object (which is a map of formal parameters but with index-properties). The *activation object* then is used as a *variable object* of the function context.

I.e. a function’s variable object is the same simple variable object, but besides variables and function declarations, it also stores formal parameters and `arguments` object and called the *activation object*.

Considering the following example:
1
2
3
4
5
6
7
[object Object]  [object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]  [object Object][object Object]
[object Object][object Object][object Object]  [object Object][object Object]
[object Object]

[object Object]
we have the next activation object (AO) of the `foo` function context:
![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143745.png)
Figure 8. An activation object.

And again the *function expression*  `baz` is not included into the variable/activate object.

The complete description with all subtle cases (such as *“hoisting”* of variables and function declarations) of the topic may be found in the same name [Chapter 2. Variable object](http://dmitrysoshnikov.com/ecmascript/chapter-2-variable-object/).

Notice, in ES5 the concepts of *variable object*, and *activation object* are combined into the *lexical environments* model, which detailed description can be found in the [appropriate chapter](http://dmitrysoshnikov.com/ecmascript/es5-chapter-3-2-lexical-environments-ecmascript-implementation/).

And we are moving forward to the next section. As is known, in ECMAScript we may use *inner functions* and in these inner functions we may refer to variables of *parent* functions or variables of the *global* context. As we named a variable object as a *scope object* of the context, similarly to the discussed above prototype chain, there is so-called a *scope chain*.

## [Scope chain](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#scope-chain)

A *scope chain* is a *list of objects* that are searched for *identifiers* appear in the code of the context.

The rule is again simple and similar to a prototype chain: if a variable is not found in the own scope (in the own variable/activation object), its lookup proceeds in the parent’s variable object, and so on.

Regarding contexts, identifiers are: *names* of variables, function declarations, formal parameters, etc. When a function refers in its code the identifier which is not a local variable (or a local function or a formal parameter), such variable is called a *free variable*. And to *search these free variables* exactly a *scope chain* is used.

In general case, a *scope chain* is a list of all those *parent variable objects*, *plus* (in the front of scope chain) the function’s *own variable/activation object*. However, the scope chain may contain also any other object, e.g. objects dynamically added to the scope chain during the execution of the context — such as *with-objects* or special objects of *catch-clauses*.

When *resolving* (looking up) an identifier, the scope chain is searched starting from the activation object, and then (if the identifier isn’t found in the own activation object) up to the top of the scope chain — repeat, the same just like with a prototype chain.

1
2
3
4
5
6
7
8
9
10
11
12
13
[object Object]  [object Object]

[object Object][object Object]  [object Object]
[object Object][object Object]  [object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

We may assume the linkage of the scope chain objects via the implicit `__parent__` property, which refers to the next object in the chain. This approach may be tested in a [real Rhino code](http://dmitrysoshnikov.com/ecmascript/chapter-2-variable-object/#feature-of-implementations-property-__parent__), and exactly this technique is used in [ES5  *lexical environments*](http://dmitrysoshnikov.com/ecmascript/es5-chapter-3-2-lexical-environments-ecmascript-implementation/) (there it’s named an `outer` link). Another representation of a scope chain may be a simple array. Using a `__parent__` concept, we may represent the example above with the following figure (thus parent variable objects are saved in the `[[Scope]]` property of a function):

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143749.png)
Figure 9. A scope chain.

At code execution, a scope chain may be augmented using `with` statement and `catch` clause objects. And since these objects are simple objects, they may have prototypes (and prototype chains). This fact leads to that scope chain lookup is *two-dimensional*: (1) first a scope chain link is considered, and then (2) on every scope chain’s link — into the depth of the link’s prototype chain (if the link of course has a prototype).

For this example:
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
[object Object]

[object Object]  [object Object]
[object Object]  [object Object]

[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]

[object Object][object Object]

[object Object][object Object]  [object Object]

[object Object][object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]  [object Object]

[object Object][object Object]
[object Object][object Object]
[object Object][object Object]

[object Object][object Object]  [object Object]
[object Object][object Object][object Object]
[object Object][object Object]

[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]

[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]

[object Object]

we have the following structure (that is, before we go to the `__parent__` link, first `__proto__` chain is considered):

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143753.png)
Figure 10. A “with-augmented” scope chain.

Notice, that not in all implementations the global object inherits from the `Object.prototype`. The behavior described on the figure (with referencing “non-defined” variable `x` from the global context) may be tested e.g. in SpiderMonkey.

Until all parent variable objects exist, there is nothing special in getting parent data from the inner function — we just traverse through the scope chain resolving (searching) needed variable. However, as we mentioned above, after a context ends, all its state and it itself are *destroyed*. At the same time an *inner function* may be *returned* from the parent function. Moreover, this returned function may be later activated from another context. What will be with such an activation if a context of some free variable is already “gone”? In the general theory, a concept which helps to solve this issue is called a *(lexical) closure*, which in ECMAScript is directly related with a *scope chain* concept.

## [Closures](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#closures)

In ECMAScript, functions are the *first-class* objects. This term means that functions may be passed as arguments to other functions (in such case they are called *“funargs”*, short from “functional arguments”). Functions which receive “funargs” are called *higher-order functions* or, closer to mathematics, *operators*. Also functions may be returned from other functions. Functions which return other functions are called *function valued* functions (or functions with *functional value*).

There are two conceptual problems related with “funargs” and “functional values”. And these two sub-problems are generalized in one which is called a *“Funarg problem”* (or “A problem of a functional argument”). And exactly to solve the *complete “funarg problem”*, the concept of *closures* was invented. Let’s describe in more detail these two sub-problems (we’ll see that both of them are solved in ECMAScript using a mentioned on figures `[[Scope]]` property of a function).

First subtype of the “funarg problem” is an *“upward funarg problem”*. It appears when a function is returned “up” (to the outside) from another function and uses already mentioned above *free variables*. To be able access variables of the parent context *even after the parent context ends*, the inner function *at creation moment* saves in it’s `[[Scope]]` property parent’s *scope chain*. Then when the function is *activated*, the scope chain of its context is formed as combination of the activation object and this `[[Scope]]` property (actually, what we’ve just seen above on figures):

1
[object Object]

Notice again the main thing — exactly at *creation moment* — a function saves *parent’s* scope chain, because exactly this *saved scope chain* will be used for variables lookup then in further calls of the function.

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
[object Object]  [object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]  [object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

[object Object]
[object Object]
[object Object]

[object Object]  [object Object]

[object Object]
[object Object]  [object Object]

[object Object]
[object Object][object Object]

This style of scope is called the *static (or lexical) scope*. We see that the variable `x` is found in the saved `[[Scope]]` of returned `bar` function. In general theory, there is also a *dynamic scope* when the variable `x` in the example above would be resolved as `20`, but not `10`. However, dynamic scope is not used in ECMAScript.

The second part of the “funarg problem” is a *“downward funarg problem”*. In this case a parent context may exist, but may be an ambiguity with resolving an identifier. The problem is: *from which scope* a value of an identifier should be used — statically saved at a function’s creation or dynamically formed at execution (i.e. a scope of a *caller*)? To avoid this ambiguity and to form a closure, a *static scope* is decided to be used:

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
[object Object]
[object Object]  [object Object]

[object Object]
[object Object]  [object Object]
[object Object][object Object]
[object Object]

[object Object][object Object]  [object Object]

[object Object][object Object]
[object Object][object Object]  [object Object]

[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]

[object Object][object Object][object Object]

[object Object][object Object]

We may conclude that a *static scope* is an *obligatory requirement to have closures* in a language. However, some languages may provided combination of dynamic and static scopes, allowing a programmer to choose — what to closure and what do not. Since in ECMAScript only a static scope is used (i.e. we have solutions for both subtypes of the “funarg problem”), the conclusion is: *ECMAScript has complete support of closures*, which technically are implemented using `[[Scope]]` property of functions. Now we may give a correct definition of a closure:

A *closure* is a combination of a code block (in ECMAScript this is a function) and statically/lexically saved all parent scopes. Thus, via these saved scopes a function may easily refer free variables.

Notice, that since *every* (normal) function saves `[[Scope]]` at creation, theoretically, *all functions* in ECMAScript *are closures*.

Another important thing to note, that several functions may have *the same parent scope* (it’s quite a normal situation when e.g. we have two inner/global functions). In this case variables stored in the `[[Scope]]` property are *shared between all functions* having the same parent scope chain. Changes of variables made by one closure are *reflected* on reading these variables in another closure:

1
2
3
4
5
6
7
8
9
10
11
12
13
14
[object Object]  [object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]  [object Object]

[object Object][object Object][object Object]  [object Object][object Object]  [object Object]

[object Object][object Object][object Object]  [object Object][object Object]  [object Object]

[object Object][object Object]
[object Object]

[object Object]  [object Object]

[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]
This code may be illustrated with the following figure:
![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108143759.png)
Figure 11. A shared [[Scope]].

Exactly with this feature confusion with creating several functions in a loop is related. Using a loop counter inside created functions, some programmers often get unexpected results when all functions have the *same* value of a counter inside a function. Now it should be clear why it is so — because all these functions have the same `[[Scope]]` where the loop counter has the last assigned value.

1
2
3
4
5
6
7
8
9
10
11
[object Object]  [object Object]

[object Object]  [object Object][object Object]  [object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

[object Object][object Object]
[object Object][object Object]
[object Object][object Object]

There are several techniques which may solve this issue. One of the techniques is to provide an additional object in the scope chain — e.g. using additional function:

1
2
3
4
5
6
7
8
9
10
11
12
13
14
[object Object]  [object Object]

[object Object]  [object Object][object Object]  [object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object]  [object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]
[object Object]

[object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]

NOTE: ES6 introduced *block-scope* bindings. This is done via `let` or `const` keywords. Example from above can now easily and conveniently rewritten as:

1
2
3
4
5
6
7
8
9
10
11
[object Object]  [object Object]

[object Object]  [object Object][object Object]  [object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

[object Object][object Object]
[object Object][object Object]
[object Object][object Object]

Those who interested deeper in theory of closures and their practical application, may find additional information in the [Chapter 6. Closures](http://dmitrysoshnikov.com/ecmascript/chapter-6-closures/). And to get more information about a scope chain, take a look on the same name [Chapter 4. Scope chain](http://dmitrysoshnikov.com/ecmascript/chapter-4-scope-chain/).

And we’re moving to the next section, considering the last property of an execution context. This is concept of a `this` value.

## [This value](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#this-value)

A `this` value is a special object which is related with the execution context. Therefore, it may be named as a *context object* (i.e. an object in which context the execution context is *activated*).

*Any object* can be used as `this` value of the context. One important note is that the `this` value is a *property of the execution context*, but *not* a property of the variable object.

This feature is very important, because in *contrast with variables*, *`this` value never participates in identifier resolution process*. I.e. when accessing `this` in a code, its value is taken *directly* from the execution context and *without any scope chain lookup*. The value of `this` is determined *only once*, on *entering the context*.

NOTE: In ES6  `this` actually became a property of a *lexical environment*, i.e. property of the *variable object* in ES3 terminology. This is done to support *arrow functions*, which have *lexical `this`*, which they inherit from parent contexts.

By the way, in contrast with ECMAScript, e.g. Python has its `self` argument of methods as a simple variable which is resolved the same and may be even changed during the execution to another value. In ECMAScript it is *not possible* to assign a new value to `this`, because, repeat, it’s not a variable and is not placed in the variable object.

In the global context, a `this value` is the *global object itself* (that means, `this` value here equals to *variable object*):

1
2
3
4
5
6
7
[object Object]  [object Object]

[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]

In case of a function context, `this` value in *every single function call* may be *different*. Here `this` value is provided by the *caller* via the *form of a call expression* (i.e. the way of how a function is activated). For example, the function `foo` below is a *callee*, being called from the global context, which is a *caller*. Let’s see on the example, how for the same code of a function, `this` value in different calls (different ways of the function activation) is provided *differently* by the caller:

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
[object Object]
[object Object]
[object Object]

[object Object]  [object Object]
[object Object][object Object][object Object][object Object]
[object Object]

[object Object]
[object Object]

[object Object][object Object]
[object Object][object Object]

[object Object]  [object Object]
[object Object][object Object]
[object Object]

[object Object][object Object]

[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]  [object Object][object Object]

[object Object]  [object Object]
[object Object][object Object]

To consider deeply why (and that is more essential — *how*) `this` value may change in every function call, you may read [Chapter 3. This](http://dmitrysoshnikov.com/ecmascript/chapter-3-this/) where all mentioned above cases are discussed in detail.

## [Conclusion](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/#conclusion)

At this step we finish this brief overview. Though, it turned out to not so “brief” However, the whole explanation of all these topics requires a complete book. We though didn’t touch two major topics: *functions* (and the difference between some types of functions, e.g. *function declaration* and *function expression*) and the *evaluation strategy* used in ECMAScript. Both topics may be found in the appropriate chapters of ES3 series: [Chapter 5. Functions](http://dmitrysoshnikov.com/ecmascript/chapter-5-functions/) and [Chapter 8. Evaluation strategy](http://dmitrysoshnikov.com/ecmascript/chapter-8-evaluation-strategy/).

If you have comments, questions or additions, I’ll be glad to discuss them in comments.

Good luck in studying ECMAScript!
**Written by:** Dmitry A. Soshnikov
**Published on: **2010-09-02

Search 搜寻

# Archives

- [March 2020](http://dmitrysoshnikov.com/2020/03/)
- [October 2019](http://dmitrysoshnikov.com/2019/10/)
- [August 2019](http://dmitrysoshnikov.com/2019/08/)
- [July 2019](http://dmitrysoshnikov.com/2019/07/)
- [February 2019](http://dmitrysoshnikov.com/2019/02/)
- [December 2017](http://dmitrysoshnikov.com/2017/12/)
- [November 2017](http://dmitrysoshnikov.com/2017/11/)
- [October 2016](http://dmitrysoshnikov.com/2016/10/)
- [September 2016](http://dmitrysoshnikov.com/2016/09/)
- [February 2016](http://dmitrysoshnikov.com/2016/02/)
- [January 2016](http://dmitrysoshnikov.com/2016/01/)
- [September 2015](http://dmitrysoshnikov.com/2015/09/)
- [September 2014](http://dmitrysoshnikov.com/2014/09/)
- [August 2014](http://dmitrysoshnikov.com/2014/08/)
- [July 2011](http://dmitrysoshnikov.com/2011/07/)
- [February 2011](http://dmitrysoshnikov.com/2011/02/)
- [January 2011](http://dmitrysoshnikov.com/2011/01/)
- [December 2010](http://dmitrysoshnikov.com/2010/12/)
- [September 2010](http://dmitrysoshnikov.com/2010/09/)
- [June 2010](http://dmitrysoshnikov.com/2010/06/)
- [April 2010](http://dmitrysoshnikov.com/2010/04/)
- [March 2010](http://dmitrysoshnikov.com/2010/03/)
- [February 2010](http://dmitrysoshnikov.com/2010/02/)
- [November 2009](http://dmitrysoshnikov.com/2009/11/)
- [September 2009](http://dmitrysoshnikov.com/2009/09/)
- [July 2009](http://dmitrysoshnikov.com/2009/07/)
- [June 2009](http://dmitrysoshnikov.com/2009/06/)

# Meta

- [Log in](http://dmitrysoshnikov.com/wp-login.php)

[![882f228c4993ccf0a86e96394636415c](../_resources/e8352d38af0d9739f0829c177174a04c.jpg)](http://dmitrysoshnikov.com/)

# [Dmitry Soshnikov](http://dmitrysoshnikov.com/)

## Software engineer interested in learning and education. Sometimes blog on topics of programming languages theory, compilers, and ECMAScript.

## Published

## [2010-09-02](http://dmitrysoshnikov.com/ecmascript/javascript-the-core/)
# [WebKit] JavaScriptCore解析--基础篇(二)解释器基础与JSC核心组件

 分类专栏：  [JavaScript](https://blog.csdn.net/horkychen/category_1145417.html)  [WebKit](https://blog.csdn.net/horkychen/category_1145418.html)  [WebKit研究](https://blog.csdn.net/horkychen/category_9261504.html)  文章标签：  [WebKit](https://www.csdn.net/gather_29/MtTaEg0sMDI5MDEtYmxvZwO0O0OO0O0O.html)  [JavaScriptCore](https://www.csdn.net/gather_20/OtDaYg1sMzU5LWJsb2cO0O0O.html)  [解释器](https://www.csdn.net/gather_2e/MtTaEg0sMDY2NTItYmxvZwO0O0OO0O0O.html)

 [版权]()

这一篇主要说明解释器的基本工作过程和JSC的核心组件的实现。

作为一个语言，就像人在的平时交流时一样，当接收到信息后，包含两个过程：先理解再行动。理解的过程就是语言解析的过程，行动就是根据解析的结果执行对应的行为。在计算机领域，理解就是编译或解释，这个已经被研究的很透彻了，并且有了工具来辅助。而执行则千变万化，也是性能优化的重心。下面就来看看JSC是如何来理解、执行JavaScript脚本的。

## 解释器工作过程

JavaScriptCore基本的工作过程如下:

>
![20130515081417694](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217154251.png)
>

对于一个解释器，首先必须要明确所支持的语言, JSC所支持的是[EMCAScript-262规范](http://www.ecma-international.org/publications/standards/Ecma-262.htm)。

词法分析和语法分析就是理解的过程，将输入的文本转为一种它可以理解的语义形式(抽象语法树), 或者更进一步的生成供后续使用的中间代码(字节码,ByteCode)。

解释器就是负责执行解析输出的结果。正因为执行是优化的重心，所以有JIT来提高执行效能。[根据资料](http://blog.csdn.net/horkychen/article/details/7761199)，V8还会优化Parser的输出，省去了bytecode, 当解释器有能力直接基于AST执行。

词法分析及语法分析，最著名的工具就是lex/yacc，以及后继者flex/bison([The LEX&YACC Page](https://www.ibm.com/developerworks/cn/linux/sdk/lex/))。它们为很多软件提供了语言或文本解析的功能，相当强大，也很有趣。虽然JavaScriptCore并没有使用它们，而是自行编写实现的，但基本思路是相似的。

词法分析(lexer)，其实就是一个扫描器，依据语言的定义，提取出源文件中的内容变为一个个语法可以识别的token，比如关键字，操作符，常量等。在一个文件中定义好规则就可以了。

语法分析(paser), 它的功能就是根据语法(token的顺序组合)，识别出不同的语义(目标操作)。

比如:

  ***i=3;***

经过lexer可能被识别为以下的tokens:

  ***VARIABLE EQUAL CONSTANT END***

经过parser一分析，就了解这是一个"赋值操作，向变量i赋值常量3"。随后再调用对应的操作加以执行。

如果你对lexer和parser还不太熟悉，可参考的资料很多，这里有一个基本的入门指引:[Yacc与Lex快速入门](https://www.ibm.com/developerworks/cn/linux/sdk/lex/)。

关于解释器和JIT的说明在第3节。

## 执行的基础环境(Register-based VM)

JSC解析生成的代码放到一个虚拟机上来执行(广义上讲JSC主身就是一个虚拟机)。JSC使用的是一个基于寄存器的虚拟机(register-based VM)，另一种实现方式是基于栈的虚拟机(stack-based VM)。两者的差异可以简单的理解为指令集传递参数的方式，是使用寄存器，还是使用栈。

相对于基于栈的虚拟机,因为不需要频繁的压、出栈，以及对三元操作的支持，register-based VM的效率更高，但可移植性相对弱一些。

所谓的三元操作符，其中add就是一个三元操作,

  add dst, src1, src2

功能是将src1与src2相加，将结果保存在dst中。dst, src1,src2都是寄存器。

为了方便和<<深入理解Java虚拟机>>中的示例进行对比，也利用JSC输出以下脚本的ByteCode如下:

	[   0] enter
	[   1] mov               r0, Cell: 0133FC40(@k0)
	[   4] put_by_id         r0, a(@id0), Int32: 100(@k1)
	[  13] mov               r0, Cell: 0133FC40(@k0)
	[  16] put_by_id         r0, b(@id1), Int32: 200(@k2)
	[  25] mov               r0, Cell: 0133FC40(@k0)
	[  28] put_by_id         r0, c(@id2), Int32: 300(@k3)
	[  37] resolve_global    r0, a(@id0)
	[  43] resolve_global    r1, b(@id1)
	[  49] add               r0, r0, r1
	[  54] resolve_global    r1, c(@id2)
	[  60] mul               r0, r0, r1
	[  65] ret               r0

*参考: [JSC字节码规格](http://www.webkit.org/specs/squirrelfish-bytecode.html) (WebKit没有及时更新，只做为参考，最新的内容还是要看代码.)

而基于栈的虚拟机的生成的字节码如下:

	0： bipush 100
	2:    istore_1
	3:    sipush 200
	6:    istore_2
	7:    sipush 300
	10:  istore_3
	11:  iload_1
	12:  iload_2
	13:  iadd
	14:  iload_3
	15:  imul
	16:  ireturn

可以帮助理解它们之间的差异。

## 核心组件

*这部分基本上译自[WebKit官网的JavaScriptCore说明的前半部分](http://trac.webkit.org/wiki/JavaScriptCore)。

JavaScriptCore 是一个正在演进的虚拟机(virtual machine)**,** 包含了以下模块: lexer, parser, start-up interpreter (**LLInt**), baseline JIT, and an optimizing JIT (**DFG**)**.**

**Lexer** 负责词法解析([lexical analysis](http://en.wikipedia.org/wiki/Lexical_analysis)) , 就是将脚本分解为一系列的tokens. JavaScriptCore的 lexer是手动撰写的，大部分代码在parser/Lexer**.**h 和 parser/Lexer.cpp 中**.**

**Parser** 处理语法分析([syntactic analysis](http://en.wikipedia.org/wiki/Parser)), 也就是基于来自Lexer的tokens创建语法树(syntax tree)**.** JavaScriptCore 使用的是一个手动编写的递归下降解析器(recursive descent parser), 代码位于parser/JSParser**.**h 和 parser/JSParser.cpp **.**

**LLInt**, 全称为Low Level Interpreter, 负责执行由Paser生成的字节码(bytecodes)**.** 代码在llint/ 目录里**,** 使用一个可移植的汇编实现，也被为offlineasm (代码在offlineasm/目录下), 它可以编译为x86和ARMv7的汇编以及C代码。LLInt除了词法解析和语法解释外,JIT编译器所执行的调用、栈、以及寄存器转换都是基本没有启动开销(start-up cost)的。比如，调用一个LLInt函数就和调用一个已经被编译原始代码的函数相似, 除非机器码的入口正是一个共用的**LLInt Prologue**(公共函数头,shared LLInt prologue)**.** LLInt还包括了一些优化，比如使用inline cacheing来加速属性访问.

**Baseline JIT** 在函数被调用了6次，或者某段代码循环了100次后(也可能是一些组合，比如3次带有50次枚举的调用)就会触发Baseline JIT。这些数字只是大概的估计，实际上的启发(heuristics)过程是依赖于函数大小和当时内存状况的。当JIT卡在一个循环时，它会执行On-Stack-Replace(OSR)将函数的所有调用者重新指向新的编译代码。Baseline JIT同时也是函数进一步优化的后备，如果无法优化代码时，它还会通过OSR调整到Baseline JIT. BaseLine JIT的代码在 jit/ . 基线JIT也为inline caching执行几乎所有的堆访问。

无论是LLInt和Baseline JIT者会收集一些轻量级的性能信息，以便择机到更高一层级(DFG)执行。收集的信息包括最近从参数、堆，以及返回值中的数据。另外，所有inline caching也做了些处理，以方便DFG进行类型判断，例如，通过查询inline cache的状态，可以检测到使用特定类理进行堆访问的频率。这个可以用于决定是否进入DFG (文中称这个行为叫speculation, 有点赌一把的意思，能优化获得更高的性能最好，不然就退回来)。在下一节中着重讲述JavaScriptCore类型推断。

**DFG JIT** 在函数被调用了至少60次，或者代码循环了1000次，就会触发DFG JIT。同样，这些都是近似数，整个过程也是趋向于启发式的。DFG积极地基于前面(baseline JIT&Interpreter)收集的数据进行类型推测，这样就可以尽早获得类型信息(forward-propagate type information)，从而减少了大量的类型检查。DFG也会自行进行推测，比如为了启用inlining, 可能会将从heap中加载的内容识别出一个已知的函数对象。如果推测失败，DFG取消优化(Deoptimization)，也称为"OSR exit".  Deoptimization可能是同步的(某个类型检测分支正在执行)，也可能是异步的(比如runtime观察到某个值变化了，并且与DFG的假设是冲突的)，后者也被称为"watchpointing"。 Baseline JIT和DFG JIT共用一个双向的OSR:Baseline可以在一个函数被频繁调用时OSR进入DFG, 而DFG则会在deoptimization时OSR回到Baseline JIT. 反复的OSR退出(OSR exits)还有一个统计功能: DFG OSR退出会像记录发生频率一样记录下退出的理由(比如对值的类型推测失败), 如果退出一定次数后，就会引发重新优化(reoptimization), 函数的调用者会重新被定位到Baseline JIT,然后会收集更多的统计信息，也许根据需要再次调用DFG。重新优化使用了指数式的回退策略(exponential back-off,会越来越来)来应对一些奇葩代码。DFG代码在dfg/.

任何时候，函数, eval代码块，以及全局代码(global code)都可能会由LLInt, Baseline JIT和DFG三者同时运行。一个极端的例子是递归函数，因为有多个stack frames，就可能一个运行在LLInt下，另一个运行在Baseline JIT里，其它的可能正运行在DFG里。更为极端的情况是当重新优化在执行过程被触发时，就会出现一个stack frame正在执行原来旧的DFG编译，而另一个则正执行新的DFG编译。为此三者设计成维护相同的执行语义(execution semantics), 它们的混合使用也是为了带来明显的效能提升。

**如果想要观察它们的工作，可以在WebKit中的子工程jsc的jsc.cpp中，使用JSC::Options添加一部分log输出.*

>
![20130515081256713](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217154403.png)
>

参考阅读:

虚拟机随谈(一): 解释器，树遍历解释器，基于栈与基于寄存器，大杂烩  http://rednaxelafx.iteye.com/blog/492667

转载请注明出处:http://blog.csdn.net/horkychen

**系列索引:**

> [> 基础篇 (一)JSC与WebCore](http://blog.csdn.net/horkychen/article/details/8915907)

> [> 基础篇(二)解释器基础与JSC核心组件](http://blog.csdn.net/horkychen/article/details/8928578)

> [> 基础篇(三)从脚本代码到JIT编译的代码实现](http://blog.csdn.net/horkychen/article/details/8963124)

> [> 基础篇(四) 页面解析与JavaScript元素的执行](http://blog.csdn.net/horkychen/article/details/9003351)

> [> 高级篇(一) SSA (static single assignment)](http://blog.csdn.net/horkychen/article/details/9075827)

> [> 高级篇(二) 类型推导(Type Inference)](http://blog.csdn.net/horkychen/article/details/9076425)

> [> 高级篇(三) Register Allocation & Trampoline](http://blog.csdn.net/horkychen/article/details/9078111)

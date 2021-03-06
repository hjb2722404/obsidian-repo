JavaScript 函数式编程（二） - 掘金

# JavaScript 函数式编程（二）

**[slide 地址](https://link.juejin.im/?target=https%3A%2F%2Fslides.com%2Fyangzhenyu%2Ffunctional-programming-in-javascript)**

## 三、可以，这很函数式~

![1652dd411ad38da0](../_resources/7e59f75eaf183f4a2dfa2daeb5c2d6af.gif)

### 3.1.函数是一等公民！

#### 3.1.1.滥用匿名函数

其实经常写 JavaScript 的人可能潜移默化地已经接受了这个观念，例如你可以像对待任何其他数据类型一样对待函数——把它们存在数组里，当作参数传递，赋值给变量.等等。

然而，常常可以看到滥用匿名函数的现象...

	// 太傻了
	const getServerStuff = function (callback) {
	  return ajaxCall(function (json) {
	    return callback(json)
	  })
	}

	// 这才像样
	const getServerStuff = ajaxCall

	// 下面来推导一下...
	const getServerStuff
	  === callback => ajaxCall(json => callback(json))
	  === callback => ajaxCall(callback)
	  === ajaxCall

	// from JS函数式编程指南
	复制代码

再来看一个例子...

	const BlogController = (function () {
	  const index = function (posts) {
	    return Views.index(posts)
	  }

	  const show = function (post) {
	    return Views.show(post)
	  }

	  const create = function (attrs) {
	    return Db.create(attrs)
	  }

	  const update = function (post, attrs) {
	    return Db.update(post, attrs)
	  }

	  const destroy = function (post) {
	    return Db.destroy(post)
	  }

	  return { index, show, create, update, destroy }
	})()

	// 以上代码 99% 都是多余的...

	const BlogController = {
	  index: Views.index,
	  show: Views.show,
	  create: Db.create,
	  update: Db.update,
	  destroy: Db.destroy,
	}

	// ...或者直接全部删掉
	// 因为它的作用仅仅就是把视图（Views）和数据库（Db）打包在一起而已。

	// from JS函数式编程指南
	复制代码

#### 3.1.2.为何钟爱一等公民？

以上那种多包一层的写法最大的问题就是，一旦内部函数需要新增或修改参数，那么包裹它的函数也要改...

	// 原始函数
	httpGet('/post/2', function (json) {
	  return renderPost(json)
	})

	// 假如需要多传递一个 err 参数
	httpGet('/post/2', function (json, err) {
	  return renderPost(json, err)
	})

	// renderPost 将会在 httpGet 中调用，
	// 想要多少参数，想怎么改都行
	httpGet('/post/2', renderPost)
	复制代码

#### 3.1.3.提高函数复用率

除了上面说的避免使用不必要的中间函数包裹以外，对于函数参数的起名也很重要，尽量编写通用参数的函数。

	// 只针对当前的博客
	const validArticles = function (articles) {
	  return articles.filter(function (article) {
	    return article !== null && article !== undefined
	  })
	}

	// 通用性好太多
	const compact = function(xs) {
	  return xs.filter(function (x) {
	    return x !== null && x !== undefined
	  })
	}
	复制代码

以上例子说明了在命名的时候，我们特别容易把自己限定在特定的数据上（本例中是 articles）。这种现象很常见，也是重复造轮子的一大原因。

#### 3.1.4.this

[1](../_resources/bf15286b106a75e0f2ddf7a29f5125e2.webp)
在函数式编程中，其实根本用不到 this...
但这里并不是说要避免使用 this<s>（江来报道上出了偏差...识得唔识得？）</s>

### 3.2.柯里化（curry）

#### 3.2.1.柯里化概念

**
> 把接受多个参数的函数变换成一系列接受单一参数（从最初函数的第一个参数开始）的函数的技术。（注意是单一参数）
**

	import { curry } from 'lodash'

	const add = (x, y) => x + y
	const curriedAdd = curry(add)

	const increment = curriedAdd(1)
	const addTen = curriedAdd(10)

	increment(2) // 3
	addTen(2) // 12
	复制代码

**

> 柯里化是由 Christopher Strachey 以逻辑学家 Haskell Curry 命名的， 当然编程语言 Haskell 也是源自他的名字， 虽然柯里化是由 Moses Schnfinkel 和 Gottlob Frege 发明的。

**

#### 3.2.2.柯里化 VS 偏函数应用（partial application）

**

> In computer science, partial application (or partial function application) refers to the process of fixing a number of arguments to a function, producing another function of smaller arity.

> by wikipedia
**
偏函数应用简单来说就是：一个函数，接受一个多参数的函数且传入部分参数后，返回一个需要更少参数的新函数。
柯里化一般和偏函数应用相伴出现，但这两者是不同的概念：

	import { curry, partial } from 'lodash'

	const add = (x, y, z) => x + y + z

	const curriedAdd = curry(add)       // <- 只接受一个函数

	const addThree = partial(add, 1, 2) // <- 不仅接受函数，还接受至少一个参数
	  === curriedAdd(1)(2)              // <- 柯里化每次都返回一个单参函数
	复制代码

简单来说，一个多参函数（n-ary），柯里化后就变成了 n * 1-ary，而偏函数应用了 x 个参数后就变成了 (n-x)-ary

#### 3.2.3.柯里化的实现

虽然从理论上说柯里化应该返回的是一系列的单参函数，但在实际的使用过程中为了像偏函数应用那样方便的调用，所以这里柯里化后的函数也能接受多个参数。

	// 实现一个函数 curry 满足以下调用、
	const f = (a, b, c, d) => { ... }
	const curried = curry(f)

	curried(a, b, c, d)
	curried(a, b, c)(d)
	curried(a)(b, c, d)
	curried(a, b)(c, d)
	curried(a)(b, c)(d)
	curried(a)(b)(c, d)
	curried(a, b)(c)(d)
	复制代码

很明显第一反应是需要使用递归，这样才能返回一系列的函数。而递归的结束条件就是接受了原函数数量的参数，所以重点就是参数的传递~

	// ES5
	var curry = function curry (fn, arr) {
	  arr = arr || []

	  return function () {
	    var args = [].slice.call(arguments)
	    var arg = arr.concat(args)

	    return arg.length >= fn.length
	      ? fn.apply(null, arg)
	      : curry(fn, arg)
	  }
	}

	// ES6
	const curry = (fn, arr = []) => (...args) => (
	  arg => arg.length >= fn.length
	    ? fn(...arg)
	    : curry(fn, arg)
	)([...arr, ...args])
	复制代码

#### 3.2.4.柯里化的意义

**写习惯了传统编程语言的人的第一反应一般都是，柯里化这玩意儿有啥用咧？**
柯里化和偏函数应用的主要意义就是固定一些我们已知的参数，然后返回一个函数继续等待接收那些未知的参数。
所以常见的使用场景之一就是高级抽象后的代码复用。例如首先编写一个多参数的通用函数，将其柯里化后，就可以基于偏函数应用将其绑定不同的业务代码。

	// 定义通用函数
	const converter = (
	  toUnit,
	  factor,
	  offset = 0,
	  input
	) => ([
	  ((offset + input) * factor).toFixed(2),
	  toUnit,
	].join(' '))

	// 分别绑定不同参数
	const milesToKm =
	  curry(converter)('km', 1.60936, undefined)
	const poundsToKg =
	  curry(converter)('kg', 0.45460, undefined)
	const farenheitToCelsius =
	  curry(converter)('degrees C', 0.5556, -32)

	-- from https://stackoverflow.com/a/6861858
	复制代码

你可能会反驳说其实也可以不使用这些花里胡哨的柯里化啊，偏函数应用啊什么的东东，我就铁头娃愣头青地直接怼也能实现以上的逻辑。（这一手皮的嘛，就不谈了...）

	function converter (ratio, symbol, input) {
	  return (input * ratio).toFixed(2) + ' ' + symbol
	}

	converter(2.2, 'lbs', 4)
	converter(1.62, 'km', 34)
	converter(1.98, 'US pints', 2.4)
	converter(1.75, 'imperial pints', 2.4)

	-- from https://stackoverflow.com/a/32379766
	复制代码

然而两者的区别在于，假如函数 `converter` 所需的参数无法同时得到，对柯里化的方式来说没有影响，因为已经用闭包保存住了已知参数。而后者可能就需要使用变量暂存或其他方法来**保证同时得到所有参数**。

### 3.3.函数组合（compose）

#### 3.3.1.组合的概念

函数组合就是将两个或多个函数结合起来形成一个新函数。
就好像将一节一节的管道连接起来，原始数据经过这一节一节的管道处理之后得到最终结果。
说起来很玄乎，其实就是假设有一个函数 f 和另一个函数 g，还有数据 x，经过计算最终结果就是 f(g(x))。
[1](../_resources/f9cf5357f34b63b7329878b655463b65.webp)
在高中数学中我们应该都学到过复合函数。
**

> 如果 y 是 w 的函数，w 又是 x 的函数，即 y = f(w), w = g(x)，那么 y 关于 x 的函数 y = f[g(x)] 叫做函数 y = f(w) 和 w = g(x) 的复合函数。其中 w 是中间变量，x 是自变量，y 是函数值。

**
此外在离散数学里，应该还学过复合函数 f(g(h(x))) 可记为 (f ○ g ○ h)(x)。（其实这就是函数组合）

#### 3.3.2.组合的实现

[1](../_resources/1eaabc372a45d2dbb22217bf097828a2.webp)

	const add1 = x => x + 1
	const mul3 = x => x * 3
	const div2 = x => x / 2

	div2(mul3(add1(add1(0)))) // 结果是 3，但这样写可读性太差了

	const operate = compose(div2, mul3, add1, add1)
	operate(0) // => 相当于 div2(mul3(add1(add1(0))))
	operate(2) // => 相当于 div2(mul3(add1(add1(2))))

	// redux 版
	const compose = (...fns) => {
	  if (fns.length === 0) return arg => arg
	  if (fns.length === 1) return fns[0]

	  return fns.reduce((a, b) => (...args) => a(b(...args)))
	}

	// 一行版，支持多参数，但必须至少传一个函数
	const compose = (...fns) => fns.reduceRight((acc, fn) => (...args) => fn(acc(...args)))

	// 一行版，只支持单参数，但支持不传函数
	const compose = (...fns) => arg => fns.reduceRight((acc, fn) => fn(acc), arg)
	复制代码

#### 3.3.3.Pointfree

起名字是一个很麻烦的事儿，而 `Pointfree` 风格能够有效减少大量中间变量的命名。
**
> Pointfree 即不使用所要处理的值，只合成运算过程。中文可以译作"无值"风格。
**
**

> from > [> Pointfree 编程风格指南](https://link.juejin.im/?target=http%3A%2F%2Fwww.ruanyifeng.com%2Fblog%2F2017%2F03%2Fpointfree.html)

**
请看下面的例子。（注意理解函数是一等公民和函数组合的概念）

	const addOne = x => x + 1
	const square = x => x * x
	复制代码

上面是两个简单函数 `addOne` 和 `square`，现在把它们合成一个运算。

	const addOneThenSquare = compose(square, addOne)
	addOneThenSquare(2) //  9
	复制代码

上面代码中，addOneThenSquare 是一个合成函数。定义它的时候，根本不需要提到要处理的值，这就是 `Pointfree`。

	// 非 Pointfree，因为提到了数据：word
	const snakeCase = function (word) {
	  return word.toLowerCase().replace(/\s+/ig, '_')
	}

	// Pointfree
	const snakeCase = compose(replace(/\s+/ig, '_'), toLowerCase)
	复制代码

然而可惜的是，以上很 `Pointfree` 的代码会报错，因为在 JavaScript 中 `replace` 和 `toLowerCase` 函数是定义在 `String` 的原型链上的...

此外有的库（如 Underscore、Lodash...）把需要处理的数据放到了第一个参数。

	const square = n => n * n;

	_.map([4, 8], square) // 第一个参数是待处理数据

	R.map(square, [4, 8]) // 一般函数式库都将数据放在最后
	复制代码

这样会有一些很不函数式的问题，即：
1.无法柯里化后偏函数应用
2.无法进行函数组合
3.无法扩展 map（reduce 等方法） 到各种其他类型
（详情参阅参考文献之《Hey Underscore, You're Doing It Wrong!》）

#### 3.3.4.函数组合的意义

**
> 首先让我们从抽象的层次来思考一下：一个 app 由什么组成？（<s>> 当然是由 a、p、p 三个字母组成的啦</s>> ）
**
一个应用其实就是一个长时间运行的进程，并将一系列异步的事件转换为对应结果。
[1](../_resources/3e623d8234a3f9689a54142e9ae2a08a.webp)

- 一个 start 可以是：
    - 开启应用
    - DOM 事件(DOMContentLoaded, onClick, onSubmit...)
    - 接收到的 HTTP 请求
    - 返回的 HTTP 响应
    - 查询数据库的结果
    - WebSocket 消息
    - ..
- 一个 end 或者说是 effect 可以是：
    - 渲染或更新 UI
    - 触发一个 DOM 事件
    - 创建一个 HTTP 请求
    - 返回一个 HTTP 响应
    - 保存数据到 DB
    - 发送 WebSocket 消息
    - ...

那么在 start 和 end 之间的东东，我们可以看做数据流的变换（transformations）。这些变换具体的说就是一系列的变换动词的结合。
这些动词描述了这些变换**做了些什么**（而不是**怎么做**）如：

- filter
- slice
- map
- reduce
- concat
- zip
- fork
- flatten
- ...

当然日常编写的程序中一般不会像之前的例子那样的简单，它的数据流可能是像下面这样的...
[1](../_resources/7dcc4654f5acd77f4ea07d41c4bd921e.webp)
[1](../_resources/e0e163a43d3f23f232299d284a4797ac.webp)
[1](../_resources/58fa6f35e61e452adcee59498c280b48.webp)
[1](../_resources/bb9cd6ee84d28d739d82dac2bafee75c.webp)
并且，如果这些变换在编写时，遵守了基本的函数式规则和最佳实践（纯函数，无副作用，引用透明...）。
那么这些变换可以被轻易地重用、改写、维护、测试，这也就意味着编写的应用可以很方便地进行扩展，而这些变换结合的基础正是**函数组合**。

### 3.4.Hindley-Milner 类型签名

#### 3.4.1.基本概念

先来看一些例子~

	// strLength :: String -> Number
	const strLength = s => s.length

	// join :: String -> [String] -> String
	const join = curry((what, xs) => xs.join(what))

	// match :: Regex -> String -> [String]
	const match = curry((reg, s) => s.match(reg))

	// replace :: Regex -> String -> String -> String
	const replace = curry((reg, sub, s) => s.replace(reg, sub))
	复制代码

在 Hindley-Milner 系统中，函数都写成类似 a -> b 这个样子，其中 a 和 b 是任意类型的变量。
**
> 以上例子中的多参函数，可能看起来比较奇怪，为啥没有括号？
**
例如对于 `match` 函数，我们将其柯里化后，完全可以把它的类型签名这样分组：

	// match :: Regex -> (String -> [String])
	const match = curry((reg, s) => s.match(reg))
	复制代码

现在我们可以看出 `match` 这个函数首先接受了一个 `Regex` 作为参数，返回一个从 `String` 到 `[String]` 的函数。
因为柯里化，造成的结果就是这样：给 `match` 函数一个 `Regex` 参数后，得到一个新函数，它能够接着处理 `String` 参数。
假设我们将第一个参数传入 `/holiday/ig`，那么代码就变成了这样：

	// match :: Regex -> (String -> [String])
	const match = curry((reg, s) => s.match(reg))

	// onHoliday :: String -> [String]
	const onHoliday = match(/holiday/ig)
	复制代码

可以看出柯里化后每传一个参数，就会弹出类型签名最前面的那个类型。所以 `onHoliday` 就是已经有了 `Regex` 参数的 `match` 函数。

	// replace :: Regex -> (String -> (String -> String))
	const replace = curry((reg, sub, s) => s.replace(reg, sub))
	复制代码

同样的思路来看最后一个函数 `replace`，可以看出为 `replace` 加上这么多括号未免有些多余。
所以这里的括号是完全可以省略的，如果我们愿意，甚至可以一次性把所有的参数都传进来。
再来看几个例子~

	//  id :: a -> a
	const id = x => x

	//  map :: (a -> b) -> [a] -> [b]
	const map = curry((f, xs) => xs.map(f))
	复制代码

这里的 id 函数接受任意类型的 a 并返回同一个类型的数据（话说 map 的签名里为啥加了括号呢~）。

和普通代码一样，我们也可以在类型签名中使用变量。把变量命名为 a 和 b 只是一种约定俗成的习惯，你可以使用任何你喜欢的名称。但对于相同的变量名，其类型一定相同。

这是非常重要的一个原则，所以我们必须重申：a -> b 可以是从任意类型的 a 到任意类型的 b，但是 a -> a 必须是同一个类型。
例如，id 可以是 String -> String，也可以是 Number -> Number，但不能是 String -> Bool。
相似地，map 也使用了变量，只不过这里的 b 可能与 a 类型相同，也可能不相同。

我们可以这么理解：map 接受两个参数，第一个是从任意类型 a 到任意类型 b 的函数；第二个是一个数组，元素是任意类型的 a；map 最后返回的是一个类型 b 的数组。

辨别类型和它们的含义是一项重要的技能，这项技能可以让你在函数式编程的路上走得更远。不仅论文、博客和文档等更易理解，类型签名本身也基本上能够告诉你它的函数性（functionality）。要成为一个能够熟练读懂类型签名的人，你得勤于练习；不过一旦掌握了这项技能，你将会受益无穷，不读手册也能获取大量信息。

最后再举几个复杂的例子~~

	//  head :: [a] -> a
	const head = xs => xs[0]

	//  filter :: (a -> Bool) -> [a] -> [a]
	const filter = curry((f, xs) => xs.filter(f))

	//  reduce :: (b -> a -> b) -> b -> [a] -> b
	const reduce = curry((f, x, xs) => xs.reduce(f, x))
	复制代码

reduce 可能是以上签名里让人印象最为深刻的一个，同时也是最复杂的一个了，所以如果你理解起来有困难的话，也不必气馁。为了满足你的好奇心，我还是试着解释一下吧；尽管我的解释远远不如你自己通过类型签名理解其含义来得有教益。

不保证解释完全正确...（译者注：此处原文是“here goes nothing”，一般用于人们在做没有把握的事情之前说的话。）
注意看 reduce 的签名，可以看到它的第一个参数是个函数（所以用了括号），这个函数接受一个 b 和一个 a 并返回一个 b。
那么这些 a 和 b 是从哪来的呢？

很简单，签名中的第二个和第三个参数就是 b 和元素为 a 的数组，所以唯一合理的假设就是这里的 b 和每一个 a 都将传给前面说的函数作为参数。我们还可以看到，reduce 函数最后返回的结果是一个 b，也就是说，reduce 的第一个参数函数的输出就是 reduce 函数的输出。知道了 reduce 的含义，我们才敢说上面关于类型签名的推理是正确的。

#### 3.4.2.参数态（Parametricity）

一旦引入一个类型变量，就会出现一个奇怪的特性叫做参数态。
这个特性表明，函数将会以一种统一的行为作用于所有的类型。

	// head :: [a] -> a
	复制代码

以 head 函数为例，可以看到它接受 [a] 返回 a。我们除了知道参数是个数组，其他的一概不知；所以函数的功能就只限于操作这个数组上。
在它对 a 一无所知的情况下，它可能对 a 做什么操作呢？

换句话说，a 告诉我们它不是一个**特定**的类型，这意味着它可以是**任意**类型；那么我们的函数对每一个可能的类型的操作都必须保持统一，这就是参数态的含义。

要让我们来猜测 head 的实现的话，唯一合理的推断就是它返回数组的第一个，或者最后一个，或者某个随机的元素；当然，head 这个命名已经告诉我们了答案。
再看一个例子：

	// reverse :: [a] -> [a]
	复制代码

仅从类型签名来看，reverse 可能的目的是什么？
再次强调，它不能对 a 做任何特定的事情。它不能把 a 变成另一个类型，或者引入一个 b；这都是不可能的。
那它可以排序么？我觉得不行，我觉得很普通~，没有足够的信息让它去为每一个可能的类型排序。
[1](../_resources/9cce358a958afc08086eba921338e6a3.webp)
它能重新排列么？我觉得还 ok，但它必须以一种可预料的方式达成目标。另外，它也有可能删除或者重复某一个元素。
[1](../_resources/300a94449bc93905c6d826b2b0a561dd.webp)
重点是，不管在哪种情况下，类型 a 的多态性（polymorphism）都会大幅缩小 reverse 函数可能的行为的范围。
[1](../_resources/f5fd39e72a553b18f4d6100adc44dc3a.webp)

这种“可能性范围的缩小”（narrowing of possibility）允许我们利用类似 [Hoogle](https://link.juejin.im/?target=https%3A%2F%2Fwww.haskell.org%2Fhoogle%2F) 这样的类型签名搜索引擎去搜索我们想要的函数。类型签名所能包含的信息量真的非常大。

#### 3.4.3.自由定理（Free Theorems）

类型签名除了能够帮助我们推断函数可能的实现，还能够给我们带来自由定理。下面是两个直接从 [Wadler 关于此主题的论文](https://link.juejin.im/?target=http%3A%2F%2Fttic.uchicago.edu%2F~dreyer%2Fcourse%2Fpapers%2Fwadler.pdf) 中随机选择的例子：

	// head :: [a] -> a
	compose(f, head) === compose(head, map(f))

	// filter :: (a -> Bool) -> [a] -> [a]
	// 其中 f 和 p 是谓词函数
	compose(map(f), filter(compose(p, f))) ===
	  compose(filter(p), map(f))
	复制代码

不用写一行代码你也能理解这些定理，它们直接来自于类型本身。

第一个例子中，等式左边说的是，先获取数组的头部（译者注：即第一个元素），然后对它调用函数 f；等式右边说的是，先对数组中的每一个元素调用 f，然后再取其返回结果的头部。这两个表达式的作用是相等的，但是前者要快得多。

第二个例子 filter 也是一样。等式左边是说，先组合 f 和 p 检查哪些元素要过滤掉，然后再通过 map 实际调用 f（别忘了 filter 是不会改变数组中元素的，这就保证了 a 将保持不变）；等式右边是说，先用 map 调用 f，然后再根据 p 过滤元素。这两者也是相等的。

你可能会想，这不是常识么。但计算机是没有常识的。实际上，计算机必须要有一种形式化方法来自动进行类似的代码优化。数学提供了这种方法，能够形式化直观的感觉，这无疑对死板的计算机逻辑非常有用。

以上只是两个例子，但它们传达的定理却是普适的，可以应用到所有的多态性类型签名上。在 JavaScript 中，你可以借助一些工具来声明重写规则，也可以直接使用 compose 函数来定义重写规则。总之，这么做的好处是显而易见且唾手可得的，可能性则是无限的。

#### 3.4.4.类型约束

最后要注意的一点是，签名也可以把类型约束为一个特定的接口（interface）。

	// sort :: Ord a => [a] -> [a]
	复制代码

胖箭头左边表明的是这样一个事实：a 一定是个 Ord 对象，或者说 a 必须要实现 Ord 接口。

Ord 到底是什么？它是从哪来的？在一门强类型语言中，它可能就是一个自定义的接口，能够让不同的值排序。通过这种方式，我们不仅能够获取关于 a 的更多信息，了解 sort 函数具体要干什么，而且还能限制函数的作用范围。我们把这种接口声明叫做类型约束（type constraints）。

	// assertEqual :: (Eq a, Show a) => a -> a -> Assertion
	复制代码

这个例子中有两个约束：Eq 和 Show。它们保证了我们可以检查不同的 a 是否相等，并在有不相等的情况下打印出其中的差异。

#### 3.4.5.类型签名的作用

总结一下类型签名的作用就是：

- 声明函数的输入和输出
- 让函数保持通用和抽象
- 可以用于编译时候检查
- 代码最好的文档

## 参考资料

## 相关文章

- [JavaScript 函数式编程（一）](https://juejin.im/post/5b7014d5518825612d6441f8)
- JavaScript 函数式编程（二） -- 本文
- [JavaScript 函数式编程（三）](https://juejin.im/post/5b70161be51d45667915986b)
- JavaScript 函数式编程（四）正在酝酿...

以上 to be continued...
Measure
Measure
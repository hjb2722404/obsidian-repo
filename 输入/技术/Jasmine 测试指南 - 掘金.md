Jasmine 测试指南 - 掘金

[(L)](https://juejin.im/user/3368559359304877)

[ StephenieJ   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/3368559359304877)

2020年01月26日   阅读 130

# Jasmine 测试指南

Jasmine 是一个流行的 JavaScript 测试框架。这篇文章旨在解释测试和测试驱动开发的概念，说明为什么测试如此重要，以及从入门到高阶如何写测试。目标受众是已经了解一些 JavaScript 用法的人群，比如闭包回调原型链。

## 什么是测试

比如说，写一个简单计算器做加法，在开始写之前，想一想要实现的功能，它应该支持正数，负数和小数，所以要测试的例子包括 1 + 1, 2 + 2, –1 + 5, –1.2 + 6.8, 0 + 0 等等。当你运行测试的，会得到要么成功要么失败的测试结果。如果测试全部通过，我们就可以肯定计算器能工作，如果有测试失败了，我们也知道计算器还没完工。

要想把所有的测试用例都覆盖也不是一件容易的事，我们要尽量覆盖所有可能合理的测试，也要包括一些边界情况的测试。

写测试的好处很多，最主要的是在后续的修改之前写的代码的时候能胸有成竹，不必担心新的修改破坏来原有的逻辑；其次一些缺乏良注释的代码，可以通过阅读测试来大致掌握逻辑。

## 测试驱动开发 （TDD）

一种相对较新的开发方式，过程是: 1 写一部分测试用例，这个时候你还没写代码，测试都是失败状态； 2 然后接着写代码，这些代码保证第一步的测试都通过； 3 所有测试通过后，重新审视代码重构提升代码质量。

## 行为驱动开发（BDD）

关于行为驱动测试有关键两点： 1 测试非常小并且一次只策一件事； 2 测试描述能够组成一个句子，测试框架会替你自动完成这个工作。

## Jasmine 是什么

Jasmine是一个行为驱动测试框架，它提供测试 JavaScript 的一系列工具。首先通过搜索 latest standalone release of Jasmine 找到GitHub地址下载最新版并解压，在浏览器打开SpecRunner.html文件可以看到这是对播放器和音乐两个文件的测试。

[1](../_resources/57fdab23aff05cfe4f6ceadafb4d2ed5.webp)

引入了Player和Song两个源文件和它们的测试文件SpecHelper和PlayerSpec，测试文件的长度大约有源文件的三倍长～所以我一直相信写好测试文件是比写源码更有难度的事～

	  <!-- include source files here... -->
	  <script src="src/Player.js"></script>
	  <script src="src/Song.js"></script>

	  <!-- include spec files here... -->
	  <script src="spec/SpecHelper.js"></script>
	  <script src="spec/PlayerSpec.js"></script>
	复制代码

## 使用 describe,it, expect来测试

样本文件给我们演示了Jasmine的测试流程，在src目录下定义源文件，在spec目录下定义测试文件，在SpecRunner.html文件里引入这两组文件。此时我们要开始写自己的测试文件，也如法炮制地添加源文件和测试文件，从hello, world开始，我们在src目录下添加hello.js

	// src/hello.js
	function helloWorld(){
	    return "Hello, World";
	}
	复制代码

在spec目录下添加测试文件

	// hello.spec.js
	describe("Hello World", function() {
	    it ("say hello", function() {
	        expect(helloWorld()).toEqual("Hello World!");
	    });
	});
	复制代码

专业术语里，把describe包含的块叫做suite，把it包含的块叫做specification，也简称为spec，在一个suite里面可以包含多个数量的spec，但是也要注意结构化语义化。

在SpecRunner.html文件里面，为了减少混乱，可以把之前的样本文件都注释或清除掉，然后引入新添加的两个文件

	  <script src="src/hello.js"></script>
	  <script src="spec/hello.spec.js"></script>
	复制代码

如果一切顺利，刷新浏览器可以看到成功的测试页面

[1](../_resources/2ff7ede0e4532e58202b8c9ce702175f.webp)

值得一提的是，一些中英文标点不一致都会导致错误，但是SpecRunner.html文件里面的引入顺序不会影响测试。

[1](../_resources/553f775922041d6b66ffaf88d0192eb5.webp)

在测试文件里，我们的期望expect语句使用了toEqual(),这叫做matcher，如果我们希望的不是全等而是包含关系，可以使用toContain()

	    it ("say hello", function() {
	        expect(helloWorld()).toContain("Hello, World!");
	    });
	复制代码

## 写第一个TDD测试

上面的测试我们先写好逻辑源码，然后加上测试。TDD的顺序刚好相反，我们先写好测试，然后再根据测试写逻辑。
我们以写一个disemvowel为例，disemvowel是去除元音字母的意思，我们要写的测试包括：

	1 应该去除所有的元音小写字母 "Hello, World!"应该变成 "Hll, Wrld!"
	2 应该去除所有的元音大写字母 "Apple juice!"应该变成 "ppl, jc"
	2 不应该改变空字符串, ""仍然保持为""
	3 也不应该改变没有元音字母的字符串 "Mhmm"仍然是"Mhmm"
	复制代码

新建一个测试文件，把我们的测试写上

	// spec/Disemvowel.spec.js
	describe("Disemvoweler", function() {
	    it("should remove all lowercase vowels", function(){
	        expect(disemvowel("Hello world")).toEqual("Hll wrld");
	    });
	    it("should remove all uppercase vowels", function(){
	        expect(disemvowel("Apple juice")).toEqual("ppl jc");
	    });
	    it("should not change empty strings", function() {
	        expect(disemvowel("")).toEqual("");
	    });
	    it("should not change strings with no vowels", function(){
	        expect(disemvowel("Mhmm")).toEqual("Mhmm");
	    });
	});
	复制代码

在SpecRunner.html文件引入测试文件

	  <script src="spec/Disemvowel.spec.js"></script>
	复制代码

刷新浏览器看到

[1](../_resources/681bf017fca3ebce50e38d5ef5019a6d.webp)

四个失败测试-->这是预料之中的事情，因为我们还没写源码，现在写第一版disemvowel方法，正则表达式表示全局搜索这五个元音并将其替换为空字符串

	// src/disemvowel.js
	function disemvowel(str) {
	    return str.replace(/a|e|i|o|u/g, "");
	}
	复制代码

写好后也要记得在html文件里引入然后刷新浏览器

[1](../_resources/41f351d8385e42be60c707c75ab2371f.webp)

看到有一例失败，是因为大写字母A没有考虑到，修改disemvowel方法使其兼顾大小写

	// src/disemvowel.js
	function disemvowel(str) {
	    return str.replace(/a|e|i|o|u/gi, "");
	}
	复制代码

这时测试便全部通过了

[1](../_resources/cc10097669c75ea2c75bdc457905f970.webp)

## 写高质量的测试

现在你知道了怎么借助Jasmine来写测试，理论上来说针对一个方法你可以写无数测试，但是实际上从时间上考虑这不现实也不必要。所有写高质量的测试有一些基本原则：

- 当你觉得疑惑的时候，就写测试
- 拆分组件来写测试，而不是一股脑地包含全部。 比如说针对计算器的方法，这样的测试是不推荐的

	describe("calculator addition", function() {
	  it("can add, subtract, multiply, and divide positive integers",
	     function() {
	      var calc = new Calculator;
	      expect(calc.add(2, 3)).toEqual(5);
	      expect(calc.sub(8, 5)).toEqual(3);
	      expect(calc.mult(4, 3)).toEqual(12);
	      expect(calc.div(12, 4)).toEqual(3);
	}); });
	复制代码

这一大块应该分成多个spec因为你实际上是在测试四个部分，如果写成上面的测试，当其中之一失败了，比较难定位到具体是哪一个失败了。

	describe("calculator addition", function() {
	  var calc;
	  beforeEach(function() {
	      calc = new Calculator();
	  });
	  it("can add positive integers", function() {
	      expect(calc.add(2, 3)).toEqual(5);
	  });
	  it("can subtract positive integers", function() {
	      expect(calc.sub(8, 5)).toEqual(3);
	  });
	  it("can multiply positive integers", function() {
	      expect(calc.mult(4, 3)).toEqual(12);
	  });
	  it("can divide positive integers", function() {
	      expect(calc.div(12, 4)).toEqual(3);
	}); });

	复制代码

每一个spec都应该一次只测试一种情形，这样失败的时候就可以快速定位。

- 黑盒测试

当你在专注对行为进行测试的时候，可以把你的项目想象成一个黑盒，只需要关注它的功能，而不需要纠结内部的实现。一个简单的例子是定义一个person对象，它分别有一个内部方法和公共方法

	var person = {
	  // Private method
	  _generateHello: function() {
	      return "hello";
	  },
	  // Public method
	  helloWorld: function() {
	      return this._generateHello() + " world";
	  }
	};
	复制代码

因为下划线开头约定俗成是内部使用方法，你不需要在乎它如何实现的，所以你也不需要测试它，只需要测试公共方法。

## 更多的Matchers

- toEqual() 匹配方法用来连接期望语句的两头，最常见的toEqual

	expect(true).toEqual(true);
	expect([1, 2, 3]).toEqual([1, 2, 3]);
	expect({}).toEqual({});
	复制代码

- toBe() 和toEqual看起来很相像，但不完全相同。toBe是检查两个对象是否为同一个，而不仅仅是看它们的值是否相同。

	var spot = { species: "Border Collie" };
	var cosmo = { species: "Border Collie" };
	expect(spot).toEqual(cosmo);  // success; equivalent
	expect(spot).toBe(cosmo);     // failure; not the same object
	expect(spot).toBe(spot);      // success; the same object
	复制代码

- toBeTruthy() toBeFalsy()

	expect(true).toBeTruthy();
	expect(12).toBeTruthy();
	expect({}).toBeTruthy();

	expect(false).toBeFalsy();
	expect(null).toBeFalsy();
	expect("").toBeFalsy();
	复制代码

它的语法和JavaScript相同，比如下面这些值都为false

	* false
	* 0
	* ""
	* undefined
	* null
	* NaN
	复制代码

- 加上not对匹配方法取反

	expect(foo).not.toEqual(bar);
	expect("Hello planet").not.toContain("world");
	复制代码

- 检测是否包含使用toContain

	expect("Hello world").toContain("world");
	expect(favoriteCandy).not.toContain("Almond");
	复制代码

- 检测是否未定义 toBeDefined toBeUndefined

	var somethingUndefined;
	expect("Hello!").toBeDefined();          // success
	expect(null).toBeDefined();             // success
	expect(somethingUndefined).toBeDefined();// failure

	var somethingElseUndefined;
	expect(somethingElseUndefined).toBeUndefined();  // success
	expect(12).toBeUndefined();                      // failure
	expect(null).toBeUndefined();                    // failure

	复制代码

- toBeNull toBeNaN

	expect(null).toBeNull();                // success
	expect(false).toBeNull();               // failure
	expect(somethingUndefined).toBeNull();  // failure

	expect(5).not.toBeNaN();              // success
	expect(0 / 0).toBeNaN();              // success
	expect(parseInt("hello")).toBeNaN();  // success
	复制代码

- 比较方法 toBeGreaterThan toBeLessThan，注意这两个方法也适用于字符串

	expect(8).toBeGreaterThan(5);
	expect(5).toBeLessThan(12);
	expect("a").toBeLessThan("z");
	复制代码

- 近似值 toBeCloseTo 第二个参数是保留几位小数的意思

	expect(12.34).toBeCloseTo(12.3, 1); // success
	expect(12.34).toBeCloseTo(12.3, 2); // failure
	expect(12.34).toBeCloseTo(12.3, 3);  // failure
	expect(12.34).toBeCloseTo(12.3, 4);  // failure
	expect(12.34).toBeCloseTo(12.3, 5);  // failure

	expect(12.3456789).toBeCloseTo(12, 0);   // success
	expect(500).toBeCloseTo(500.087315, 0);  // success
	expect(500.087315).toBeCloseTo(500, 0);  // success
	复制代码

- 正则表达式使用toMatch

	expect("foo bar").toMatch(/bar/);
	expect("horse_ebooks.jpg").toMatch(/\w+.(jpg|gif|png|svg)/i);
	expect("jasmine@example.com").toMatch("\w+@\w+\.\w+");
	复制代码

- toThrow 检查一个方法是否抛出错误

	var throwMeAnError = function() {
	    throw new Error();
	};
	expect(throwMeAnError).toThrow();
	复制代码

- 自定义匹配方法

	beforeEach(function() {
	  this.addMatchers({
	    toBeLarge: function() {
	      this.message = function() {
	        return "Expected " + this.actual + " to be large";
	      };
	        return this.actual > 100;
	    }
	  });
	});

	复制代码

这个匹配方法接收两个参数

	beforeEach(function() {
	  this.addMatchers({
	    toBeWithinOf: function(distance, base) {
	      this.message = function() {
	        var lower = base - distance;
	          var upper = base + distance;
	            return "Expected " + this.actual + " to be between " +
	              lower + " and " + upper + " (inclusive)";
	    };
	          return Math.abs(this.actual - base) <= distance;
	      }
	  });

	});
	复制代码

## 更多Jasmine特性

- Before and After
- 嵌套的suite
- 跳过某些测试 xit xdescribe
- 匹配类名 any

	expect(rand()).toEqual(jasmine.any(Number));
	expect("Hello world").toEqual(jasmine.any(String));
	expect({}).toEqual(jasmine.any(Object));
	expect(new MyObject).toEqual(jasmine.any(MyObject));
	复制代码

## Spies

我们已经知道Jasmine可以让我们测试一个方法是否工作，或者是否返回我们想要的值。还有一个重要的功能spy,就像它的名字暗示的，它让你监视某段代码。

- 基本用法 比如我们有一个类Dictionary，它会返回“hello”和“world”

	var Dictionary = function() {};
	      Dictionary.prototype.hello = function() {
	          return "hello";
	      };
	      Dictionary.prototype.world = function() {
	          return "world";
	};
	复制代码

有另一个类 Person，通过调用Dictionary 返回“hello world”

	var Person = function() {};
	      Person.prototype.sayHelloWorld = function(dict) {
	          return dict.hello() + " " + dict.world();
	      };
	复制代码

为了让Person 返回“hello world”

	var dictionary = new Dictionary;
	var person = new Person;
	person.sayHelloWorld(dictionary);  // returns "hello world"
	复制代码

理论上，你可以让sayHelloWorld方法直接返回 "hello world"，但是你需要测试Person和Dictionary

	describe("Person", function() {
	  it("uses the dictionary to say 'hello world'", function() {
	    var dictionary = new Dictionary;
	    var person = new Person;

	    spyOn(dictionary, "hello"); // 替代了hello方法
	    spyOn(dictionary, "world"); // 替代了world方法

	    person.sayHelloWorld(dictionary);

	    expect(dictionary.hello).toHaveBeenCalled();  //没有第一个spy就不可能成功
	    expect(dictionary.world).toHaveBeenCalled(); //没有第二个spy就不可能成功
	  })
	})
	复制代码

上面的这段测试，我们首先新建了两个对象，然后 spyOn 其中一个对象 dictionary 的两个方法，这是告诉Jasmine 偷偷替换 hello 和 world方法，然后我们调用 person.sayHelloWorld(dictionary);

确保 dictionary 的方法被调用了。 这样做的好处是什么呢？ 如果我们用其他的语言替换了英语

	 var Dictionary = function() {};
	     Dictionary.prototype.hello = function() {
	         return "你好";
	     };
	     Dictionary.prototype.world = function() {
	         return "世界";
	};
	复制代码

这时候sayHelloWorld 方法会返回中文文字，但是测试仍然是成功的。

- 使用 andReturn 让 spy 返回一个特定的值

	it("can give a Spanish hello", function() {
	  var dictionary = new Dictionary;
	  var person = new Person;

	  spyOn(dictionary, "hello").andReturn("你好");
	  var result = person.sayHelloWorld(dictionary);
	  expect(result).toEqual("你好 world")
	})
	复制代码

- 用一个完全不同的spy替代方法

	//andCallFake
	it("can call a fake function", function() {
	  var fakeHello = function() {
	    alert("I am a spy! Ha ha!");
	    return "hello";
	  };
	  var dictionary = new Dictionary();
	  spyOn(dictionary, "hello").andCallFake(fakeHello);
	  dictionary.hello(); // does an alert
	})
	复制代码

- 新建一个spy方法

	// spy function
	it("can have a spy function", function() {
	  var person = new Person();
	  person.getName = jasmine.createSpy("Name spy");
	  person.getName();
	  expect(person.getName).toHaveBeenCalled();
	})

	person.getSecretAgentName = jasmine.createSpy("Name spy").andReturn("James Bond");
	person.getRealName = jasmine.createSpy("Name spy 2").andCallFake(function() {
	  alert("I am also a spy! ha ha");
	  return "Evan"
	})
	复制代码

- 新建一个spy 对象

	// spy object
	var tape = jasmine.createSpyObj('tape', ['play', 'pause', 'stop', 'rewind']);

	tape.play();
	tape.rewind(10);
	复制代码

## Jasmine 和其他工具结合使用

[CoffeeScript](http://coffeescript.org/#introduction) 是一个会被编译成JavaScript的语言，它尝试用简单的方式来写更优雅的JavaScript，具体介绍请参看官网。测试例子变成

	describe "CoffeeScript Jasmine specs", ->
	    it "is beautiful!", ->
	      expect("your code is so beautiful").toBeTruthy()
	复制代码

[Node.js也可以使用Jasmine来测试。](https://jasmine.github.io/setup/nodejs.html)
[Wiki](https://github.com/jasmine/jasmine/wiki) 页面阅读更多例子。

## 总结

一个基本的测试文件

	describe("colors", function() {
	  describe("red", function() {
	      var red;
	      beforeEach(function() {
	          red = new Color("red");
	      });
	      afterEach(function() {
	          red = null;
	      });
	      it("has the correct value", function() {
	          expect(red.hex).toEqual("FF0000");
	      });
	      it("makes orange when mixed with yellow", function() {
	          var yellow = new Color("yellow");
	          var orange = new Color("orange");
	          expect(red.mix(yellow)).toEqual(orange);
	      });
	  });
	});
	复制代码
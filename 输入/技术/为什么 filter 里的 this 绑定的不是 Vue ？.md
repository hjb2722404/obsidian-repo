为什么 filter 里的 this 绑定的不是 Vue ？

[(L)](https://juejin.im/user/3210229686216222)

[ Jouryjc   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/3210229686216222)

2019年04月22日   阅读 1194

#  为什么 filter 里的 this 绑定的不是 Vue ？

最近工作中遇到一个问题，就是 filter 中的函数无法使用绑定在 `Vue.prototype` 的函数。都知道，在 `created`、`mounted`、`methods` 中， `this` 绑定的都是当前 `Vue` 实例。偏偏 `filter` 函数 `this` 指向的是 `Window`？

直接上例子：

	html<div id="app">
	    {{ myArr | filtersOdd | filtersOverFour }}
	</div>
	复制代码
	jsVue.filter('filtersOverFour', function (v) {
	    console.log('全局的filter的this：');
	    console.log(this);
	    return v.filter(item => item > 4);
	});

	new Vue({
	    el: '#app',

	    data: function () {
	        return {
	            myArr: [1,2,3,4,5,6,7,8,9,10]
	        };
	    },

	    filters: {
	        filtersOdd: function (arr) {
	            console.log('局部filter的this：');
	            console.log(this);
	            return arr.filter(item => !(item % 2));
	        }
	    }
	})
	复制代码

上面的代码我们注册了一个全局 `filter` 和一个局部 `filter`，打印出来的结果如下：
[1](../_resources/66fd03d7a59eb4a8078533d1ebb3b60d.webp)

可以看到，都是全局 `window` 对象。下面就进入 `filter` 的源码分析一下为什么没有绑定当前 `Vue` 实例。我们从模板编译开始看。[编译入口](https://github.com/Jouryjc/blog/issues/33)这里省略，想要了解的童鞋可以点击链接查看。直接来到 `src\compiler\parser\html-parser.js`的 `parseHTML` 函数，这里会遍历整个模板，`filter` 属于文本部分：

	jslet text, rest, next
	if (textEnd >= 0) {
	    rest = html.slice(textEnd)
	    while (
	        !endTag.test(rest) &&
	        !startTagOpen.test(rest) &&
	        !comment.test(rest) &&
	        !conditionalComment.test(rest)
	    ) {
	        *// < in plain text, be forgiving and treat it as text*
	        next = rest.indexOf('<', 1)
	        if (next < 0) break
	        textEnd += next
	        rest = html.slice(textEnd)
	    }
	    text = html.substring(0, textEnd)
	    advance(textEnd)
	}

	if (textEnd < 0) {
	    text = html
	    html = ''
	}

	if (options.chars && text) {
	    options.chars(text)
	}
	复制代码

判断 `textEnd` 是否大于 0，是的话说明当前位置到 `textEnd` 都是文本内容。并且如果 `<` 是纯文本中的字符，就继续找到真正的文本结束的位置，然后前进到结束的位置。接着判断 `textEnd` 是否小于零，是的话则说明整个 `template` 解析完毕了，把剩余的 `html` 都赋值给了 `text`。到这里我们就拿到了 :chestnut: 中的文本内容 `{{ myArr | filtersOdd | filtersOverFour }}`。接下来执行 `chars` 回调，这个函数在 `src\compiler\parser\index.js`：

	jschars (text: string) {

	    *// 如果没有父节点*
	    if (!currentParent) {
	        if (process.env.NODE_ENV !== 'production') {

	            *// 只有template时报错*
	            if (text === template) {
	                warnOnce(
	                    'Component template requires a root element, rather than just text.'
	                )
	            } else if ((text = text.trim())) {
	                warnOnce(
	                    `text "${text}" outside root element will be ignored.`
	                )
	            }
	        }
	        return
	    }
	    *// IE textarea placeholder bug*
	    */* istanbul ignore if */*
	    if (isIE &&
	        currentParent.tag === 'textarea' &&
	        currentParent.attrsMap.placeholder === text
	       ) {
	        return
	    }
	    const children = currentParent.children
	    text = inPre || text.trim()
	        ? isTextTag(currentParent) ? text : decodeHTMLCached(text)
	    *// only preserve whitespace if its not right after a starting tag*
	    : preserveWhitespace && children.length ? ' ' : ''
	    if (text) {
	        let res
	        if (!inVPre && text !== ' ' && (res = parseText(text, delimiters))) {
	            children.push({
	                type: 2,  *// 包含表达式的文本*
	                expression: res.expression,
	                tokens: res.tokens,
	                text
	            })
	        } else if (text !== ' ' || !children.length || children[children.length - 1].text !== ' ') {
	            children.push({
	                type: 3,  *// 纯文本*
	                text
	            })
	        }
	    }
	}
	复制代码

上面代码先对一些特殊情况做判断，比如文本是否直接写在 `template` 中，是不是 `placeholder` 的文本、是不是 `script` 或者 `style` 里面的文本等等。执行完判断如果不是空字符串且包含表达式，执行 `parseText` 函数，定义在 `src\compiler\parser\text-parser.js`：

	jsexport function parseText (
	  text: string,
	  delimiters?: [string, string]
	): TextParseResult | void {
	  const tagRE = delimiters ? buildRegex(delimiters) : defaultTagRE
	  if (!tagRE.test(text)) {
	    return
	  }
	  const tokens = []
	  const rawTokens = []
	  let lastIndex = tagRE.lastIndex = 0
	  let match, index, tokenValue
	  while ((match = tagRE.exec(text))) {
	    index = match.index
	    *// push text token*
	    if (index > lastIndex) {
	      rawTokens.push(tokenValue = text.slice(lastIndex, index))
	      tokens.push(JSON.stringify(tokenValue))
	    }
	    *// tag token*
	    const exp = parseFilters(match[1].trim())
	    tokens.push(`_s(${exp})`)
	    rawTokens.push({ '@binding': exp })
	    lastIndex = index + match[0].length
	  }
	  if (lastIndex < text.length) {
	    rawTokens.push(tokenValue = text.slice(lastIndex))
	    tokens.push(JSON.stringify(tokenValue))
	  }
	  return {
	    expression: tokens.join('+'),
	    tokens: rawTokens
	  }
	}
	复制代码

`defaultTagRE` 匹配两个大括号中间的内容。然后再循环匹配文本，遇到普通文本就 push 到 `rawTokens` 和 `tokens` 中，如果是表达式就转换成 `_s(${exp})` push 到 `tokens` 中，以及转换成 `{@binding:exp}` push 到 `rawTokens` 中。对于我们这个:chestnut:，我们最后得到的表达式：

	js{
	    expression: [""\n        "", "_s(_f("filtersOverFour")(_f("filtersOdd")(myArr)))", ""\n    ""],
	    tokens: ["↵        ", {@binding: "_f("filtersOverFour")(_f("filtersOdd")(myArr))"}, "↵    "]
	}
	复制代码

`_f` 是什么呢？我们一起来分析下。上述代码中，`parseFilters` 函数就是我们这节的关键，它定义在 `src\compiler\parser\filter-parser.js`文件中：

	js*/**
	 * 处理text中的filters
	 * @param {String} exp - 字符文本
	 * @return {String} expression - 处理完filters后的函数
	 */*
	export function parseFilters (exp: string): string {
	  *// ...*
	  *// 循环文本表达式*
	  for (i = 0; i < exp.length; i++) {
	    *// ...*
	  }

	  if (expression === undefined) {
	    expression = exp.slice(0, i).trim()
	  } else if (lastFilterIndex !== 0) {
	    pushFilter()
	  }

	  */**
	   * 将所有filters处理函数推入到filters数组中
	   */*
	  function pushFilter () {
	    (filters || (filters = [])).push(exp.slice(lastFilterIndex, i).trim())
	    lastFilterIndex = i + 1
	  }
	  *// 遍历filters所有处理函数，依次包装。转换成_f*
	  if (filters) {
	    for (i = 0; i < filters.length; i++) {
	      expression = wrapFilter(expression, filters[i])
	    }
	  }

	  *// 有两个filters处理函数生成的表达式 "_f("filtersOverFour")(_f("filtersOdd")(myArr))"*
	  return expression
	}

	function wrapFilter (exp: string, filter: string): string {
	  const i = filter.indexOf('(')
	  if (i < 0) {
	    *// _f: resolveFilter*
	    return `_f("${filter}")(${exp})`
	  } else {
	    const name = filter.slice(0, i)
	    const args = filter.slice(i + 1)
	    return `_f("${name}")(${exp}${args !== ')' ? ',' + args : args}`
	  }
	}

	复制代码

按照:chestnut:，`parseFilters` 的作用就是把整个文本表达式转化成 `_f("filtersOverFour")(_f("filtersOdd")(myArr))` 。_f 定义在 `src\core\instanceender-helpers\index.js`:

	jsexport function installRenderHelpers (target: any) {
	  *// ...*
	  target._f = resolveFilter
	  *// ...*
	}
	复制代码

`resolveFilter` 定义在 `src\core\instanceender-helpersesolve-filter.js`：

	js */**
	  * 获取filter对象中对应id的函数
	  * @param {String} id - 函数名
	  * @returns {Function} - 函数名是id的函数
	  */*
	export function resolveFilter (id: string): Function {
	  return resolveAsset(this.$options, 'filters', id, true) || identity
	}
	复制代码

[1](../_resources/72bba8af7f4d2f39292656c816ab8a75.webp)

截图是 `this.$options` 对象，可以看到：全局 `filter` 是挂在实例 `filters` 属性原型中的。
生成执行代码阶段就不详细分析了，最后生成的 `render` 函数代码：

	jswith(this){return _c('div',{attrs:{"id":"app"}},[_v("\n        "+_s(_f("filtersOverFour")(_f("filtersOdd")(myArr)))+"\n    ")])}
	复制代码

最后在调用 `vm._render` 函数时会执行`_f` 函数。至此，`filter` 的流程就走完了。下面通过一个简单的:chestnut:来还原一下上面的场景：

	// 相当于 render 函数
	var withFn = (function() {
	  with (this) {
	    console.log(this);

	    b();
	  }
	})

	// 相当于_f函数
	function b () {
	  console.log(this);
	}

	// 相当于 vm._renderProxy
	var obj = new Proxy({}, {
	  get: function (target, key, receiver) {
	    console.log(`getting ${key}!`);
	  },
	  set: function (target, key, value, receiver) {
	    console.log(`setting ${key}!`);
	  }
	});

	withFn.call(obj);
	// 输出结果：
	// Proxy {}
	// Window {}

	复制代码

这就回答了 `filter` 函数 `this` 为什么指向的是 `Window` 了！
欢迎纠正错误！更多内容请 [前往博客](https://github.com/Jouryjc/blog)！！！
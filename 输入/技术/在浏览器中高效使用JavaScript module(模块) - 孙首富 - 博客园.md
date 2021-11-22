![](http://www.webhek.com/wordpress/wp-content/uploads/2017/05/nodejs-module-resolution-by-visual-example-17-638-560x420.jpg)

在浏览器中也可以使用JavaScript modules(模块功能)了。目前支持这一特性的浏览器包括：

*   Safari 10.1.
*   谷歌浏览器(Canary 60) – 需要在`chrome:flags`里开启”实验性网络平台功能(Experimental Web Platform)”
*   Firefox 54 – 需要在`about:config`里开启`dom.moduleScripts.enabled`选项。
*   Edge 15 – 需要在`about:flags`里开启 Experimental JavaScript Features 选项

```
<script type\="module"\>
  import {addTextToBody} from './utils.js';

  addTextToBody('Modules are pretty cool.');
</script\> 
```

我们需要做的只是在script标签元素上声明`type=module`就可以了，这样，浏览器就能解析代码中的module语法了。

网上已经有很多关于[modules的好文章](https://ponyfoo.com/articles/es6-modules-in-depth)了，但我在这里想单独分享一下专门针对浏览器里的ECMAScript modules的知识，这些都是我在阅读和测试ECMAScript规范时学到的。

目前并不支持”裸” import 语法
-------------------

下面几种 module 语法是有效的：

*   绝对路径的URL。也就是说，使用 `new URL(模块地址)` 也不会报错。
*   地址开头是 `/`。
*   地址开头是 `./`。
*   地址开头是 `../`。

另外一些语法是保留为将来使用的，比如，导入内部的(built-in) modules。

用来保持向后兼容的nomodule
-----------------

```
<script type\="module" src\="module.js"\></script\>
<script nomodule src\="fallback.js"\></script\> 
```

能够认识`type=module`语法的浏览器会忽略具有`nomodule`属性的scripts。也就是说，我们可以使用一些脚本服务于支持module语法的浏览器，同时提供一个`nomodule`的脚本用于哪些不支持module语法的浏览器，作为补救。

### 浏览器问题

*   ~Firefox并不支持`nomodule`属性 ([issue](https://bugzilla.mozilla.org/show_bug.cgi?id=1330900))~。但在Firefox nightly版里已经修复了这个问题。
*   Edge并不支持`nomodule`属性。 ([issue](https://developer.microsoft.com/en-us/microsoft-edge/platform/issues/10525830/)).
*   Safari 10.1 并不支持`nomodule`属性，但在最新的技术预览版中修复了这个问题。对于10.1版, 有一个很[聪明的变通技巧。](https://gist.github.com/samthor/64b114e4a4f539915a95b91ffd340acc)

缺省设置为Defer
----------

```
<!\-- 这个脚本的执行将会晚于… \--\>
<script type\="module" src\="1.js"\></script\>

<!\-- …这个脚本… \--\>
<script src\="2.js"\></script\>

<!\-- …但是会先于这个脚本. \--\>
<script defer src\="3.js"\></script\> 
```

执行的顺序将会是`2.js`, `1.js`, `3.js`.

如果script代码块阻止HTML分析器下载其他代码，这是非常糟糕的事情，通常我们会使用 `defer` 属性来防止这种解析阻塞，但同时这样也会延迟script脚本的执行——直到真个文档解析完成。而且还要参考其它deferred script脚本的执行顺序。Module scripts缺省行为状态很像 `defer` 属性的作用 – 一个 module script 不会妨碍HTML分析器下载其它资源。

Module scripts队列的执行顺序跟使用了`defer`属性的普通脚本队列的执行顺序一样。

Inline scripts同样是deferred
-------------------------

```
<!\-- 这个脚本的执行将会晚于… \--\>
<script type\="module"\>
  addTextToBody("Inline module executed");
</script\>

<!\-- …这个脚本… \--\>
<script src\="1.js"\></script\>

<!\-- …和这个脚本… \--\>
<script defer\>
  addTextToBody("Inline script executed");
</script\>

<!\-- …但会先于这个脚本。\--\>
<script defer src\="2.js"\></script\> 
```

执行的顺序是 `1.js`, inline script, inline module, `2.js`.

普通的inline scripts会忽略`defer`属性，而 inline module scripts 永远是deferred的，不管它是否有 import 行为。

外部 & inline modules script脚本上的 Async 属性
---------------------------------------

```
<!\-- 这个脚本将会在imports完成后立即执行 \--\>
<script async type\="module"\>
  import {addTextToBody} from './utils.js';

  addTextToBody('Inline module executed.');
</script\>

<!\-- 这个脚本将会在脚本加载和imports完成后立即执行 \--\>
<script async type\="module" src\="1.js"\></script\> 
```

这个快速下载script会率先执行。

跟普通的scripts一样, `async` 属性能让script加载的同时并不阻碍HTML解析器的工作，而且在加载完成后立即执行。跟普通的scripts不同的是, `async` 属性在inline modules脚本上也有效。

因为永远都是`async`, 所以这些scripts的执行顺序也许并不会像它们出现在DOM里的顺序。

### 浏览器问题

*   Firefox并不支持inline module scripts上的 `async` 特性。([issue](https://bugzilla.mozilla.org/show_bug.cgi?id=1361369)).

Modules只执行一次
------------

```
<!\-- 1.js 只执行一次 \--\>
<script type\="module" src\="1.js"\></script\>
<script type\="module" src\="1.js"\></script\>
<script type\="module"\>
  import "./1.js";
</script\>

<!\-- 而普通的脚本会执行多次 \--\>
<script src\="2.js"\></script\>
<script src\="2.js"\></script\> 
```

如果你知道 ES modules，你就应该知道，modules可以import多次，但只会执行一次。这种原则同样适用于HTML里的script modules – 一个确定的URL上的module script在一个页面上只会执行一次。

### 浏览器问题

*   Edge浏览器会多次执行 modules ([issue](https://developer.microsoft.com/en-us/microsoft-edge/platform/issues/11865922/)).

CORS 跨域资源共享限制
-------------

```
<!\-- 这个脚本不会执行，因为跨域资源共享限制 \--\>
<script type\="module" src\="https://….now.sh/no-cors"\></script\>

<!\-- 这个脚本不会执行，因为跨域资源共享限制\--\>
<script type\="module"\>
  import 'https://….now.sh/no-cors';

  addTextToBody("This will not execute.");
</script\>

<!\-- 这个没问题 \--\>
<script type\="module" src\="https://….now.sh/cors"\></script\> 
```

跟普通的scripts不同, module scripts (以及它们的 imports 行为) 受 CORS 跨域资源共享限制。也就是说，跨域的 module scripts 必须返回带有有效 `Access-Control-Allow-Origin: *` 的CORS头信息。

### 浏览器问题

*   Firefox没有成功的加载演示页面 ([issue](https://bugzilla.mozilla.org/show_bug.cgi?id=1361373)).
*   Edge浏览器加载了没有 CORS headers 的 module scripts ([issue](https://developer.microsoft.com/en-us/microsoft-edge/platform/issues/11865934/))。

没有凭证信息(credentials)
-------------------

```
<!\-- 有凭证信息 (cookies等) \--\>
<script src\="1.js"\></script\>

<!\-- 没有凭证信息 \--\>
<script type\="module" src\="1.js"\></script\>

<!\-- 有凭证信息 \--\>
<script type\="module" crossorigin src\="1.js?"\></script\>

<!\-- 没有凭证信息 \--\>
<script type\="module" crossorigin src\="https://other-origin/1.js"\></script\>

<!\-- 有凭证信息\--\>
<script type\="module" crossorigin\="use-credentials" src\="https://other-origin/1.js?"\></script\> 
```

当请求在同一安全域下，大多数的CORS-based APIs都会发送凭证信息 (cookies 等)，但`[ fetch() ](http://www.webhek.com/post/javascript-fetch-api-2.html)`和 module scripts 例外 – 它们并不发送凭证信息，除非我们要求它们。

我们可以通过添加`crossorigin`属性来让同源module脚本携带凭证信息，如果你也想让非同源module脚本也携带凭证信息，使用 `crossorigin="use-credentials"` 属性。需要注意的是，非同源脚本需要具有 `Access-Control-Allow-Credentials: true` 头信息。

同样，“Modules只执行一次”的规则也会影响到这一特征。URL是Modules的唯一标志，如果你先请求的Modules没有携带凭证信息，然后你第二次请求希望携带凭证信息，你仍然会得到一个没有凭证信息的module。这就是为什么上面的有个URL上我使用了一个`?`号，是让URL变的不同。

### 浏览器问题

*   谷歌浏览器在请求同源 modules 时带有 credentials ([issue](https://bugs.chromium.org/p/chromium/issues/detail?id=717525)).
*   Safari 请求同源 modules 时不带有 credentials，即使你使用了 `crossorigin` 属性标志。 ([issue](https://bugs.webkit.org/show_bug.cgi?id=171550)).
*   Edge浏览器完全相反。它缺省状态下对同源请求 modules 时带有 credentials 而当你指定了 `crossorigin` 属性后反倒没了。 ([issue](https://developer.microsoft.com/en-us/microsoft-edge/platform/issues/11865956/)).

火狐浏览器是唯一做的正确的浏览器，干的漂亮！

Mime-types 文档类型
---------------

跟普通的scripts不一样，modules scripts 必须指定一个[有效的 JavaScript MIME 类型](https://html.spec.whatwg.org/multipage/scripting.html#javascript-mime-type)，否则将不会执行。

### 浏览器问题

*   Edge浏览器在无效MIME types下也执行 ([issue](https://developer.microsoft.com/en-us/microsoft-edge/platform/issues/11865977/)).

这些就是目前我学到的。毋庸置疑，ES modules能够登陆浏览器，已经让我兴奋不已了。你呢？
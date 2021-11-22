Puppeteer v1.5.0 中文翻译 - 掘金

[(L)](https://juejin.im/user/4054654612943303)  [清夜](https://juejin.im/user/4054654612943303)  [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)

2018年06月29日  阅读 3098

# Puppeteer v1.5.0 中文翻译

最近用到了  [Puppeteer](https://github.com/GoogleChrome/puppeteer)  这个库，既然用到了这个东西，顺便也就把它的 API给看了一遍，为了加深印象，在看的同时也就顺便翻译了一下，不过这API文档的内容量还是蛮大的，花费了好些时间才看完，有些地方不知道怎么翻译比较好，所以也就没翻译，有的地方可能官方说得不怎么详细，我也加了一点主观意见。

* * *

##### Table of Contents

- [Overview](https://juejin.im/post/6844903630026326029#overview)
- [Environment Variables](https://juejin.im/post/6844903630026326029#environment-variables)
- [class: Puppeteer](https://juejin.im/post/6844903630026326029#class-puppeteer)
    - [puppeteer.connect(options)](https://juejin.im/post/6844903630026326029#puppeteerconnectoptions)
    - [puppeteer.createBrowserFetcher([options])](https://juejin.im/post/6844903630026326029#puppeteercreatebrowserfetcheroptions)
    - [puppeteer.defaultArgs()](https://juejin.im/post/6844903630026326029#puppeteerdefaultargs)
    - [puppeteer.executablePath()](https://juejin.im/post/6844903630026326029#puppeteerexecutablepath)
    - [puppeteer.launch([options])](https://juejin.im/post/6844903630026326029#puppeteerlaunchoptions)
- [class: BrowserFetcher](https://juejin.im/post/6844903630026326029#class-browserfetcher)
    - [browserFetcher.canDownload(revision)](https://juejin.im/post/6844903630026326029#browserfetchercandownloadrevision)
    - [browserFetcher.download(revision[, progressCallback])](https://juejin.im/post/6844903630026326029#browserfetcherdownloadrevision-progresscallback)
    - [browserFetcher.localRevisions()](https://juejin.im/post/6844903630026326029#browserfetcherlocalrevisions)
    - [browserFetcher.platform()](https://juejin.im/post/6844903630026326029#browserfetcherplatform)
    - [browserFetcher.remove(revision)](https://juejin.im/post/6844903630026326029#browserfetcherremoverevision)
    - [browserFetcher.revisionInfo(revision)](https://juejin.im/post/6844903630026326029#browserfetcherrevisioninforevision)
- [class: Browser](https://juejin.im/post/6844903630026326029#class-browser)
    - [event: 'disconnected'](https://juejin.im/post/6844903630026326029#event-disconnected)
    - [event: 'targetchanged'](https://juejin.im/post/6844903630026326029#event-targetchanged)
    - [event: 'targetcreated'](https://juejin.im/post/6844903630026326029#event-targetcreated)
    - [event: 'targetdestroyed'](https://juejin.im/post/6844903630026326029#event-targetdestroyed)
    - [browser.browserContexts()](https://juejin.im/post/6844903630026326029#browserbrowsercontexts)
    - [browser.close()](https://juejin.im/post/6844903630026326029#browserclose)
    - [browser.createIncognitoBrowserContext()](https://juejin.im/post/6844903630026326029#browsercreateincognitobrowsercontext)
    - [browser.disconnect()](https://juejin.im/post/6844903630026326029#browserdisconnect)
    - [browser.newPage()](https://juejin.im/post/6844903630026326029#browsernewpage)
    - [browser.pages()](https://juejin.im/post/6844903630026326029#browserpages)
    - [browser.process()](https://juejin.im/post/6844903630026326029#browserprocess)
    - [browser.targets()](https://juejin.im/post/6844903630026326029#browsertargets)
    - [browser.userAgent()](https://juejin.im/post/6844903630026326029#browseruseragent)
    - [browser.version()](https://juejin.im/post/6844903630026326029#browserversion)
    - [browser.wsEndpoint()](https://juejin.im/post/6844903630026326029#browserwsendpoint)
- [class: BrowserContext](https://juejin.im/post/6844903630026326029#class-browsercontext)
    - [event: 'targetchanged'](https://juejin.im/post/6844903630026326029#event-targetchanged-1)
    - [event: 'targetcreated'](https://juejin.im/post/6844903630026326029#event-targetcreated-1)
    - [event: 'targetdestroyed'](https://juejin.im/post/6844903630026326029#event-targetdestroyed-1)
    - [browserContext.browser()](https://juejin.im/post/6844903630026326029#browsercontextbrowser)
    - [browserContext.close()](https://juejin.im/post/6844903630026326029#browsercontextclose)
    - [browserContext.isIncognito()](https://juejin.im/post/6844903630026326029#browsercontextisincognito)
    - [browserContext.newPage()](https://juejin.im/post/6844903630026326029#browsercontextnewpage)
    - [browserContext.targets()](https://juejin.im/post/6844903630026326029#browsercontexttargets)
- [class: Page](https://juejin.im/post/6844903630026326029#class-page)
    - [event: 'close'](https://juejin.im/post/6844903630026326029#event-close)
    - [event: 'console'](https://juejin.im/post/6844903630026326029#event-console)
    - [event: 'dialog'](https://juejin.im/post/6844903630026326029#event-dialog)
    - [event: 'domcontentloaded'](https://juejin.im/post/6844903630026326029#event-domcontentloaded)
    - [event: 'error'](https://juejin.im/post/6844903630026326029#event-error)
    - [event: 'frameattached'](https://juejin.im/post/6844903630026326029#event-frameattached)
    - [event: 'framedetached'](https://juejin.im/post/6844903630026326029#event-framedetached)
    - [event: 'framenavigated'](https://juejin.im/post/6844903630026326029#event-framenavigated)
    - [event: 'load'](https://juejin.im/post/6844903630026326029#event-load)
    - [event: 'metrics'](https://juejin.im/post/6844903630026326029#event-metrics)
    - [event: 'pageerror'](https://juejin.im/post/6844903630026326029#event-pageerror)
    - [event: 'request'](https://juejin.im/post/6844903630026326029#event-request)
    - [event: 'requestfailed'](https://juejin.im/post/6844903630026326029#event-requestfailed)
    - [event: 'requestfinished'](https://juejin.im/post/6844903630026326029#event-requestfinished)
    - [event: 'response'](https://juejin.im/post/6844903630026326029#event-response)
    - [event: 'workercreated'](https://juejin.im/post/6844903630026326029#event-workercreated)
    - [event: 'workerdestroyed'](https://juejin.im/post/6844903630026326029#event-workerdestroyed)
    - [page.$(selector)](https://juejin.im/post/6844903630026326029#pageselector)
    - [page.?(selector)](https://juejin.im/post/6844903630026326029#pageselector-1)
    - [page.?eval(selector, pageFunction[, ...args])](https://juejin.im/post/6844903630026326029#pageevalselector-pagefunction-args)
    - [page.$eval(selector, pageFunction[, ...args])](https://juejin.im/post/6844903630026326029#pageevalselector-pagefunction-args-1)
    - [page.$x(expression)](https://juejin.im/post/6844903630026326029#pagexexpression)
    - [page.addScriptTag(options)](https://juejin.im/post/6844903630026326029#pageaddscripttagoptions)
    - [page.addStyleTag(options)](https://juejin.im/post/6844903630026326029#pageaddstyletagoptions)
    - [page.authenticate(credentials)](https://juejin.im/post/6844903630026326029#pageauthenticatecredentials)
    - [page.bringToFront()](https://juejin.im/post/6844903630026326029#pagebringtofront)
    - [page.browser()](https://juejin.im/post/6844903630026326029#pagebrowser)
    - [page.click(selector[, options])](https://juejin.im/post/6844903630026326029#pageclickselector-options)
    - [page.close(options)](https://juejin.im/post/6844903630026326029#pagecloseoptions)
    - [page.content()](https://juejin.im/post/6844903630026326029#pagecontent)
    - [page.cookies(...urls)](https://juejin.im/post/6844903630026326029#pagecookiesurls)
    - [page.coverage](https://juejin.im/post/6844903630026326029#pagecoverage)
    - [page.deleteCookie(...cookies)](https://juejin.im/post/6844903630026326029#pagedeletecookiecookies)
    - [page.emulate(options)](https://juejin.im/post/6844903630026326029#pageemulateoptions)
    - [page.emulateMedia(mediaType)](https://juejin.im/post/6844903630026326029#pageemulatemediamediatype)
    - [page.evaluate(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#pageevaluatepagefunction-args)
    - [page.evaluateHandle(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#pageevaluatehandlepagefunction-args)
    - [page.evaluateOnNewDocument(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#pageevaluateonnewdocumentpagefunction-args)
    - [page.exposeFunction(name, puppeteerFunction)](https://juejin.im/post/6844903630026326029#pageexposefunctionname-puppeteerfunction)
    - [page.focus(selector)](https://juejin.im/post/6844903630026326029#pagefocusselector)
    - [page.frames()](https://juejin.im/post/6844903630026326029#pageframes)
    - [page.goBack(options)](https://juejin.im/post/6844903630026326029#pagegobackoptions)
    - [page.goForward(options)](https://juejin.im/post/6844903630026326029#pagegoforwardoptions)
    - [page.goto(url, options)](https://juejin.im/post/6844903630026326029#pagegotourl-options)
    - [page.hover(selector)](https://juejin.im/post/6844903630026326029#pagehoverselector)
    - [page.isClosed()](https://juejin.im/post/6844903630026326029#pageisclosed)
    - [page.keyboard](https://juejin.im/post/6844903630026326029#pagekeyboard)
    - [page.mainFrame()](https://juejin.im/post/6844903630026326029#pagemainframe)
    - [page.metrics()](https://juejin.im/post/6844903630026326029#pagemetrics)
    - [page.mouse](https://juejin.im/post/6844903630026326029#pagemouse)
    - [page.pdf(options)](https://juejin.im/post/6844903630026326029#pagepdfoptions)
    - [page.queryObjects(prototypeHandle)](https://juejin.im/post/6844903630026326029#pagequeryobjectsprototypehandle)
    - [page.reload(options)](https://juejin.im/post/6844903630026326029#pagereloadoptions)
    - [page.screenshot([options])](https://juejin.im/post/6844903630026326029#pagescreenshotoptions)
    - [page.select(selector, ...values)](https://juejin.im/post/6844903630026326029#pageselectselector-values)
    - [page.setBypassCSP(enabled)](https://juejin.im/post/6844903630026326029#pagesetbypasscspenabled)
    - [page.setCacheEnabled(enabled)](https://juejin.im/post/6844903630026326029#pagesetcacheenabledenabled)
    - [page.setContent(html)](https://juejin.im/post/6844903630026326029#pagesetcontenthtml)
    - [page.setCookie(...cookies)](https://juejin.im/post/6844903630026326029#pagesetcookiecookies)
    - [page.setDefaultNavigationTimeout(timeout)](https://juejin.im/post/6844903630026326029#pagesetdefaultnavigationtimeouttimeout)
    - [page.setExtraHTTPHeaders(headers)](https://juejin.im/post/6844903630026326029#pagesetextrahttpheadersheaders)
    - [page.setJavaScriptEnabled(enabled)](https://juejin.im/post/6844903630026326029#pagesetjavascriptenabledenabled)
    - [page.setOfflineMode(enabled)](https://juejin.im/post/6844903630026326029#pagesetofflinemodeenabled)
    - [page.setRequestInterception(value)](https://juejin.im/post/6844903630026326029#pagesetrequestinterceptionvalue)
    - [page.setUserAgent(userAgent)](https://juejin.im/post/6844903630026326029#pagesetuseragentuseragent)
    - [page.setViewport(viewport)](https://juejin.im/post/6844903630026326029#pagesetviewportviewport)
    - [page.tap(selector)](https://juejin.im/post/6844903630026326029#pagetapselector)
    - [page.target()](https://juejin.im/post/6844903630026326029#pagetarget)
    - [page.title()](https://juejin.im/post/6844903630026326029#pagetitle)
    - [page.touchscreen](https://juejin.im/post/6844903630026326029#pagetouchscreen)
    - [page.tracing](https://juejin.im/post/6844903630026326029#pagetracing)
    - [page.type(selector, text[, options])](https://juejin.im/post/6844903630026326029#pagetypeselector-text-options)
    - [page.url()](https://juejin.im/post/6844903630026326029#pageurl)
    - [page.viewport()](https://juejin.im/post/6844903630026326029#pageviewport)
    - [page.waitFor(selectorOrFunctionOrTimeout[, options[, ...args]])](https://juejin.im/post/6844903630026326029#pagewaitforselectororfunctionortimeout-options-args)
    - [page.waitForFunction(pageFunction[, options[, ...args]])](https://juejin.im/post/6844903630026326029#pagewaitforfunctionpagefunction-options-args)
    - [page.waitForNavigation(options)](https://juejin.im/post/6844903630026326029#pagewaitfornavigationoptions)
    - [page.waitForSelector(selector[, options])](https://juejin.im/post/6844903630026326029#pagewaitforselectorselector-options)
    - [page.waitForXPath(xpath[, options])](https://juejin.im/post/6844903630026326029#pagewaitforxpathxpath-options)
    - [page.workers()](https://juejin.im/post/6844903630026326029#pageworkers)
- [class: Worker](https://juejin.im/post/6844903630026326029#class-worker)
    - [worker.evaluate(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#workerevaluatepagefunction-args)
    - [worker.evaluateHandle(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#workerevaluatehandlepagefunction-args)
    - [worker.executionContext()](https://juejin.im/post/6844903630026326029#workerexecutioncontext)
    - [worker.url()](https://juejin.im/post/6844903630026326029#workerurl)
- [class: Keyboard](https://juejin.im/post/6844903630026326029#class-keyboard)
    - [keyboard.down(key[, options])](https://juejin.im/post/6844903630026326029#keyboarddownkey-options)
    - [keyboard.press(key[, options])](https://juejin.im/post/6844903630026326029#keyboardpresskey-options)
    - [keyboard.sendCharacter(char)](https://juejin.im/post/6844903630026326029#keyboardsendcharacterchar)
    - [keyboard.type(text, options)](https://juejin.im/post/6844903630026326029#keyboardtypetext-options)
    - [keyboard.up(key)](https://juejin.im/post/6844903630026326029#keyboardupkey)
- [class: Mouse](https://juejin.im/post/6844903630026326029#class-mouse)
    - [mouse.click(x, y, [options])](https://juejin.im/post/6844903630026326029#mouseclickx-y-options)
    - [mouse.down([options])](https://juejin.im/post/6844903630026326029#mousedownoptions)
    - [mouse.move(x, y, [options])](https://juejin.im/post/6844903630026326029#mousemovex-y-options)
    - [mouse.up([options])](https://juejin.im/post/6844903630026326029#mouseupoptions)
- [class: Touchscreen](https://juejin.im/post/6844903630026326029#class-touchscreen)
    - [touchscreen.tap(x, y)](https://juejin.im/post/6844903630026326029#touchscreentapx-y)
- [class: Tracing](https://juejin.im/post/6844903630026326029#class-tracing)
    - [tracing.start(options)](https://juejin.im/post/6844903630026326029#tracingstartoptions)
    - [tracing.stop()](https://juejin.im/post/6844903630026326029#tracingstop)
- [class: Dialog](https://juejin.im/post/6844903630026326029#class-dialog)
    - [dialog.accept([promptText])](https://juejin.im/post/6844903630026326029#dialogacceptprompttext)
    - [dialog.defaultValue()](https://juejin.im/post/6844903630026326029#dialogdefaultvalue)
    - [dialog.dismiss()](https://juejin.im/post/6844903630026326029#dialogdismiss)
    - [dialog.message()](https://juejin.im/post/6844903630026326029#dialogmessage)
    - [dialog.type()](https://juejin.im/post/6844903630026326029#dialogtype)
- [class: ConsoleMessage](https://juejin.im/post/6844903630026326029#class-consolemessage)
    - [consoleMessage.args()](https://juejin.im/post/6844903630026326029#consolemessageargs)
    - [consoleMessage.text()](https://juejin.im/post/6844903630026326029#consolemessagetext)
    - [consoleMessage.type()](https://juejin.im/post/6844903630026326029#consolemessagetype)
- [class: Frame](https://juejin.im/post/6844903630026326029#class-frame)
    - [frame.$(selector)](https://juejin.im/post/6844903630026326029#frameselector)
    - [frame.?(selector)](https://juejin.im/post/6844903630026326029#frameselector-1)
    - [frame.?eval(selector, pageFunction[, ...args])](https://juejin.im/post/6844903630026326029#frameevalselector-pagefunction-args)
    - [frame.$eval(selector, pageFunction[, ...args])](https://juejin.im/post/6844903630026326029#frameevalselector-pagefunction-args-1)
    - [frame.$x(expression)](https://juejin.im/post/6844903630026326029#framexexpression)
    - [frame.addScriptTag(options)](https://juejin.im/post/6844903630026326029#frameaddscripttagoptions)
    - [frame.addStyleTag(options)](https://juejin.im/post/6844903630026326029#frameaddstyletagoptions)
    - [frame.childFrames()](https://juejin.im/post/6844903630026326029#framechildframes)
    - [frame.click(selector[, options])](https://juejin.im/post/6844903630026326029#frameclickselector-options)
    - [frame.content()](https://juejin.im/post/6844903630026326029#framecontent)
    - [frame.evaluate(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#frameevaluatepagefunction-args)
    - [frame.evaluateHandle(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#frameevaluatehandlepagefunction-args)
    - [frame.executionContext()](https://juejin.im/post/6844903630026326029#frameexecutioncontext)
    - [frame.focus(selector)](https://juejin.im/post/6844903630026326029#framefocusselector)
    - [frame.hover(selector)](https://juejin.im/post/6844903630026326029#framehoverselector)
    - [frame.isDetached()](https://juejin.im/post/6844903630026326029#frameisdetached)
    - [frame.name()](https://juejin.im/post/6844903630026326029#framename)
    - [frame.parentFrame()](https://juejin.im/post/6844903630026326029#frameparentframe)
    - [frame.select(selector, ...values)](https://juejin.im/post/6844903630026326029#frameselectselector-values)
    - [frame.setContent(html)](https://juejin.im/post/6844903630026326029#framesetcontenthtml)
    - [frame.tap(selector)](https://juejin.im/post/6844903630026326029#frametapselector)
    - [frame.title()](https://juejin.im/post/6844903630026326029#frametitle)
    - [frame.type(selector, text[, options])](https://juejin.im/post/6844903630026326029#frametypeselector-text-options)
    - [frame.url()](https://juejin.im/post/6844903630026326029#frameurl)
    - [frame.waitFor(selectorOrFunctionOrTimeout[, options[, ...args]])](https://juejin.im/post/6844903630026326029#framewaitforselectororfunctionortimeout-options-args)
    - [frame.waitForFunction(pageFunction[, options[, ...args]])](https://juejin.im/post/6844903630026326029#framewaitforfunctionpagefunction-options-args)
    - [frame.waitForSelector(selector[, options])](https://juejin.im/post/6844903630026326029#framewaitforselectorselector-options)
    - [frame.waitForXPath(xpath[, options])](https://juejin.im/post/6844903630026326029#framewaitforxpathxpath-options)
- [class: ExecutionContext](https://juejin.im/post/6844903630026326029#class-executioncontext)
    - [executionContext.evaluate(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#executioncontextevaluatepagefunction-args)
    - [executionContext.evaluateHandle(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#executioncontextevaluatehandlepagefunction-args)
    - [executionContext.frame()](https://juejin.im/post/6844903630026326029#executioncontextframe)
    - [executionContext.queryObjects(prototypeHandle)](https://juejin.im/post/6844903630026326029#executioncontextqueryobjectsprototypehandle)
- [class: JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)
    - [jsHandle.asElement()](https://juejin.im/post/6844903630026326029#jshandleaselement)
    - [jsHandle.dispose()](https://juejin.im/post/6844903630026326029#jshandledispose)
    - [jsHandle.executionContext()](https://juejin.im/post/6844903630026326029#jshandleexecutioncontext)
    - [jsHandle.getProperties()](https://juejin.im/post/6844903630026326029#jshandlegetproperties)
    - [jsHandle.getProperty(propertyName)](https://juejin.im/post/6844903630026326029#jshandlegetpropertypropertyname)
    - [jsHandle.jsonValue()](https://juejin.im/post/6844903630026326029#jshandlejsonvalue)
- [class: ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)
    - [elementHandle.$(selector)](https://juejin.im/post/6844903630026326029#elementhandleselector)
    - [elementHandle.?(selector)](https://juejin.im/post/6844903630026326029#elementhandleselector-1)
    - [elementHandle.?eval(selector, pageFunction, ...args)](https://juejin.im/post/6844903630026326029#elementhandleevalselector-pagefunction-args)
    - [elementHandle.$eval(selector, pageFunction, ...args)](https://juejin.im/post/6844903630026326029#elementhandleevalselector-pagefunction-args-1)
    - [elementHandle.$x(expression)](https://juejin.im/post/6844903630026326029#elementhandlexexpression)
    - [elementHandle.asElement()](https://juejin.im/post/6844903630026326029#elementhandleaselement)
    - [elementHandle.boundingBox()](https://juejin.im/post/6844903630026326029#elementhandleboundingbox)
    - [elementHandle.boxModel()](https://juejin.im/post/6844903630026326029#elementhandleboxmodel)
    - [elementHandle.click([options])](https://juejin.im/post/6844903630026326029#elementhandleclickoptions)
    - [elementHandle.contentFrame()](https://juejin.im/post/6844903630026326029#elementhandlecontentframe)
    - [elementHandle.dispose()](https://juejin.im/post/6844903630026326029#elementhandledispose)
    - [elementHandle.executionContext()](https://juejin.im/post/6844903630026326029#elementhandleexecutioncontext)
    - [elementHandle.focus()](https://juejin.im/post/6844903630026326029#elementhandlefocus)
    - [elementHandle.getProperties()](https://juejin.im/post/6844903630026326029#elementhandlegetproperties)
    - [elementHandle.getProperty(propertyName)](https://juejin.im/post/6844903630026326029#elementhandlegetpropertypropertyname)
    - [elementHandle.hover()](https://juejin.im/post/6844903630026326029#elementhandlehover)
    - [elementHandle.jsonValue()](https://juejin.im/post/6844903630026326029#elementhandlejsonvalue)
    - [elementHandle.press(key[, options])](https://juejin.im/post/6844903630026326029#elementhandlepresskey-options)
    - [elementHandle.screenshot([options])](https://juejin.im/post/6844903630026326029#elementhandlescreenshotoptions)
    - [elementHandle.tap()](https://juejin.im/post/6844903630026326029#elementhandletap)
    - [elementHandle.toString()](https://juejin.im/post/6844903630026326029#elementhandletostring)
    - [elementHandle.type(text[, options])](https://juejin.im/post/6844903630026326029#elementhandletypetext-options)
    - [elementHandle.uploadFile(...filePaths)](https://juejin.im/post/6844903630026326029#elementhandleuploadfilefilepaths)
- [class: Request](https://juejin.im/post/6844903630026326029#class-request)
    - [request.abort([errorCode])](https://juejin.im/post/6844903630026326029#requestaborterrorcode)
    - [request.continue([overrides])](https://juejin.im/post/6844903630026326029#requestcontinueoverrides)
    - [request.failure()](https://juejin.im/post/6844903630026326029#requestfailure)
    - [request.frame()](https://juejin.im/post/6844903630026326029#requestframe)
    - [request.headers()](https://juejin.im/post/6844903630026326029#requestheaders)
    - [request.isNavigationRequest()](https://juejin.im/post/6844903630026326029#requestisnavigationrequest)
    - [request.method()](https://juejin.im/post/6844903630026326029#requestmethod)
    - [request.postData()](https://juejin.im/post/6844903630026326029#requestpostdata)
    - [request.redirectChain()](https://juejin.im/post/6844903630026326029#requestredirectchain)
    - [request.resourceType()](https://juejin.im/post/6844903630026326029#requestresourcetype)
    - [request.respond(response)](https://juejin.im/post/6844903630026326029#requestrespondresponse)
    - [request.response()](https://juejin.im/post/6844903630026326029#requestresponse)
    - [request.url()](https://juejin.im/post/6844903630026326029#requesturl)
- [class: Response](https://juejin.im/post/6844903630026326029#class-response)
    - [response.buffer()](https://juejin.im/post/6844903630026326029#responsebuffer)
    - [response.fromCache()](https://juejin.im/post/6844903630026326029#responsefromcache)
    - [response.fromServiceWorker()](https://juejin.im/post/6844903630026326029#responsefromserviceworker)
    - [response.headers()](https://juejin.im/post/6844903630026326029#responseheaders)
    - [response.json()](https://juejin.im/post/6844903630026326029#responsejson)
    - [response.ok()](https://juejin.im/post/6844903630026326029#responseok)
    - [response.request()](https://juejin.im/post/6844903630026326029#responserequest)
    - [response.securityDetails()](https://juejin.im/post/6844903630026326029#responsesecuritydetails)
    - [response.status()](https://juejin.im/post/6844903630026326029#responsestatus)
    - [response.text()](https://juejin.im/post/6844903630026326029#responsetext)
    - [response.url()](https://juejin.im/post/6844903630026326029#responseurl)
- [class: SecurityDetails](https://juejin.im/post/6844903630026326029#class-securitydetails)
    - [securityDetails.issuer()](https://juejin.im/post/6844903630026326029#securitydetailsissuer)
    - [securityDetails.protocol()](https://juejin.im/post/6844903630026326029#securitydetailsprotocol)
    - [securityDetails.subjectName()](https://juejin.im/post/6844903630026326029#securitydetailssubjectname)
    - [securityDetails.validFrom()](https://juejin.im/post/6844903630026326029#securitydetailsvalidfrom)
    - [securityDetails.validTo()](https://juejin.im/post/6844903630026326029#securitydetailsvalidto)
- [class: Target](https://juejin.im/post/6844903630026326029#class-target)
    - [target.browser()](https://juejin.im/post/6844903630026326029#targetbrowser)
    - [target.browserContext()](https://juejin.im/post/6844903630026326029#targetbrowsercontext)
    - [target.createCDPSession()](https://juejin.im/post/6844903630026326029#targetcreatecdpsession)
    - [target.opener()](https://juejin.im/post/6844903630026326029#targetopener)
    - [target.page()](https://juejin.im/post/6844903630026326029#targetpage)
    - [target.type()](https://juejin.im/post/6844903630026326029#targettype)
    - [target.url()](https://juejin.im/post/6844903630026326029#targeturl)
- [class: CDPSession](https://juejin.im/post/6844903630026326029#class-cdpsession)
    - [cdpSession.detach()](https://juejin.im/post/6844903630026326029#cdpsessiondetach)
    - [cdpSession.send(method[, params])](https://juejin.im/post/6844903630026326029#cdpsessionsendmethod-params)
- [class: Coverage](https://juejin.im/post/6844903630026326029#class-coverage)
    - [coverage.startCSSCoverage(options)](https://juejin.im/post/6844903630026326029#coveragestartcsscoverageoptions)
    - [coverage.startJSCoverage(options)](https://juejin.im/post/6844903630026326029#coveragestartjscoverageoptions)
    - [coverage.stopCSSCoverage()](https://juejin.im/post/6844903630026326029#coveragestopcsscoverage)
    - [coverage.stopJSCoverage()](https://juejin.im/post/6844903630026326029#coveragestopjscoverage)

### Overview

Puppeteer是一个通过 DevTools Protocol 来控制 Chromium 或者 Chrome的 Node库，并提供了一些高级API。
这些API层级分明，并能提现出浏览器的自身结构。
> NOTE>   > 在下面这个图例中，浅色实体代表的结构尚未在 Puppeteer中实现。

[1](../_resources/69e508dda41f9d138beaf3bcb0d929c5.webp)

- [(L)](https://juejin.im/post/6844903630026326029#class-puppeteer)[Puppeteer](https://juejin.im/post/6844903630026326029#class-puppeteer)  使用  [DevTools Protocol](https://chromedevtools.github.io/devtools-protocol/)与浏览器进行通信。
- [(L)](https://juejin.im/post/6844903630026326029#class-browser)[Browser](https://juejin.im/post/6844903630026326029#class-browser)  浏览器实例可以包含多个浏览器上下文。
- [(L)](https://juejin.im/post/6844903630026326029#class-browsercontext)[BrowserContext](https://juejin.im/post/6844903630026326029#class-browsercontext)  用于保持浏览器session，一个浏览器上下文可以包含多个页面。
- [(L)](https://juejin.im/post/6844903630026326029#class-page)[Page](https://juejin.im/post/6844903630026326029#class-page)  一个Page最起码包含一个frame，即 main frame，允许存在其他的 frame，这些frame可以用 [iframe]创建。
- [(L)](https://juejin.im/post/6844903630026326029#class-frame)[Frame](https://juejin.im/post/6844903630026326029#class-frame)  一个 Frame最起码有一个 Javascript执行上下文环境，即默认的执行上下文环境。Frame允许存在额外附加的上下文环境
- [(L)](https://juejin.im/post/6844903630026326029#class-worker)[Worker](https://juejin.im/post/6844903630026326029#class-worker)  存在唯一的上下文环境，并可与  [WebWorkers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API)相互协作。

(图例来源:  [link](https://docs.google.com/drawings/d/1Q_AM6KYs9kbyLZF-Lpp5mtpAWth73Cq8IKCsWYgi8MM/edit?usp=sharing))

### Environment Variables

Puppeteer 需要明确的  [environment variables](https://en.wikipedia.org/wiki/Environment_variable)  来协助其完成一系列操作，如果 Puppeteer没有在打钱执行环境中发现这些环境变量，那么将会直接从  [npm config](https://docs.npmjs.com/cli/config)搜寻（忽略大小写）。

- HTTP_PROXY,  HTTPS_PROXY,  NO_PROXY  - 定义了 HTTP proxy的相关配置，常用于下载或启动 Chromium。
- PUPPETEER_SKIP_CHROMIUM_DOWNLOAD  - 用于指示 Puppeteer不要在安装的过程中下载 Chromium安装包。
- PUPPETEER_DOWNLOAD_HOST  - 用于覆写下载 Chromium安装包的地址url。
- PUPPETEER_CHROMIUM_REVISION  - 在安装阶段，用于明确指示 Puppeteer下载安装哪个版本的 Chromium。

### class: Puppeteer

Puppeteer模块提供了一个用于启动一个Chromium实例的方法。 下面的代码展示了一种使用 Puppeteer来启动 Chromium实例的典型例子：
jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
await  page.goto('https://www.google.com');
// other actions...
await  browser.close();
});
复制代码

#### puppeteer.connect(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - browserWSEndpoint  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> a  [browser websocket endpoint](https://juejin.im/post/6844903630026326029#browserwsendpoint)  to connect to.
    - ignoreHTTPSErrors  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 在导航阶段是否忽略 HTTPS错误，默认为  false.
    - slowMo  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 通过改变此值来减缓 Puppeteer的操作速度，单位是毫秒，当你想知道具体发生了什么情况的时候，此参数将会比较有用。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Browser](https://juejin.im/post/6844903630026326029#class-browser)>>：以 Promise的形式返回了一个 Browser实例对象。

此方法将会为 Puppeteer 附加上一个 Chromium 实例。

#### puppeteer.createBrowserFetcher([options])

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - host  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 下载链接的host，默认为  https://storage.googleapis.com。
    - path  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 下载链接的 path路径，默认为  <root>/.local-chromium, 这里的root指的是是 puppeteer包的根目录.
    - platform  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 可能的选项有：  mac,  win32,  win64,  linux。默认是当前的环境平台。
- returns: <[BrowserFetcher](https://juejin.im/post/6844903630026326029#class-browserfetcher)>

#### puppeteer.defaultArgs()

- returns: <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> The default flags that Chromium will be launched with.

#### puppeteer.executablePath()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Puppeteer将会在此路径中搜寻 Chromium包， 如果在  [(L)](https://juejin.im/post/6844903630026326029#environment-variables)[PUPPETEER_SKIP_CHROMIUM_DOWNLOAD](https://juejin.im/post/6844903630026326029#environment-variables)阶段 Chromium包被跳过下载，那么此包也有可能是不存在的。

#### puppeteer.launch([options])

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 启动浏览器时的配置，可能存在如下字段:
    - ignoreHTTPSErrors  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 是否忽略在导航阶段 HTTPS引发的错误，默认为false。
    - headless  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 是否以一种  [headless mode](https://developers.google.com/web/updates/2017/04/headless-chrome)的模式来启动浏览器。 只要devtools  选项不为true，那么此选项的默认值就是  true
    - executablePath  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Chromium 或 Chrome 的运行路径而不是安装路径。 如果  executablePath  是一个相对目录, 那么它应该是相对于  [current working directory](https://nodejs.org/api/process.html#process_process_cwd)。
    - slowMo  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 通过改变此值来减缓 Puppeteer的操作速度，单位是毫秒，当你想知道具体发生了什么情况的时候，此参数将会比较有用。
    - args  <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> 传递给浏览器实例的额外参数，这些参数的可选列表[可见与此](http://peter.sh/experiments/chromium-command-line-switches/)。
    - ignoreDefaultArgs  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 将会使  [(L)](https://juejin.im/post/6844903630026326029#puppeteerdefaultargs)[puppeteer.defaultArgs()](https://juejin.im/post/6844903630026326029#puppeteerdefaultargs)失效。 属于比较危险的选项，需要小心使用。默认为  false。
    - handleSIGINT  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 程序终止信号，通过按下 Ctrl-C 来关闭浏览器进程，默认为  true。
    - handleSIGTERM  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 程序结束信号，当接收到程序结束信号时，关闭浏览器进程，默认为  true。
    - handleSIGHUP  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 程序挂起信号，当接收到程序挂起信号时，关闭浏览器进程，默认为  true。
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 等待浏览器实例启动的超时时间，单位为  ms，默认是30000  (30秒)，设置为  0标识禁用此选项。
    - dumpio  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 是否将浏览器的输入、输出流连通到控制台的  process.stdout和  process.stderr上。 默认为  false.
    - userDataDir  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  [User Data Directory](https://chromium.googlesource.com/chromium/src/+/master/docs/user_data_dir.md)所在路径。
    - env  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 明确指示浏览器实例可用的环境变量，默认为  process.env。
    - devtools  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 是否为每个标签页自动打开 DevTools面板，如果为  true, 那么  headless选项将被设置为  false。
    - pipe  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 通过一个  pipe  而不是  WebSocket来链接浏览器实例，默认为  false。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Browser](https://juejin.im/post/6844903630026326029#class-browser)>> 一个返回 浏览器实例的 Promise.

此方法根据给定的参数来启动一个浏览器实例，此浏览器实例将会在其 node.js主进程关闭时被销毁。

> NOTE>   > Puppeteer 也可以直接用于控制 Chrome浏览器, 不过，只有当其控制的 Chrome浏览器的版本和其本身绑定的 Chromium版本一致时才能最大程度地发挥作用，如果版本不一致，可能无法正常运行， 特别是当你使用了>   > executablePath>   > 选项的时候。

> 如果你更想使用 Google Chrome (而不是Chromium) 的话, a>   > [> Chrome Canary](https://www.google.com/chrome/browser/canary.html)>   > or>   > [> Dev Channel](https://www.chromium.org/getting-involved/dev-channel)>   > build is suggested.

> 在上面的>   > [> puppeteer.launch([options])](https://juejin.im/post/6844903630026326029#puppeteerlaunchoptions)>   > 选项中, 所有提及到 Chromium 的地方同样适用于 Chrome。

> 你可以在> [> 这篇文章](https://www.howtogeek.com/202825/what%E2%80%99s-the-difference-between-chromium-and-chrome/)> 中找到 Chromium 与 Chrome之间的不同之处，>   > [(L)](https://chromium.googlesource.com/chromium/src/+/lkcr/docs/chromium_browser_vs_google_chrome.md)> [> 这篇文章](https://chromium.googlesource.com/chromium/src/+/lkcr/docs/chromium_browser_vs_google_chrome.md)>   > 则介绍了一些在 Linux平台上的差异。

### class: BrowserFetcher

BrowserFetcher 能够下载和管理不同版本的 Chromium。

BrowserFetcher 的方法可以接收一个 版本号字符串，此版本号指定精确的 Chromium版本，例如  "533271"，版本号列表可以在  [omahaproxy.appspot.com](http://omahaproxy.appspot.com/)获取。

下面这里例子展示了如何通过 BrowserFetcher来下载一个特定版本的 Chromium，以及使用 Puppeteer来启动这个 Chromium。
jsconst  browserFetcher = puppeteer.createBrowserFetcher();
const  revisionInfo =  await  browserFetcher.download('533271');

const  browser =  await  puppeteer.launch({executablePath: revisionInfo.executablePath})

复制代码
> NOTE>   > BrowserFetcher无法与其他使用相同下载目录的 BrowserFetcher实例同时运行。

#### browserFetcher.canDownload(revision)

- revision  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 检查是否可用版本的版本号。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>> 如果目标版本的浏览器可以从目标 host上下载下来，则返回  true。

此方法通过发起一个 HEAD request来检查目标版本是否可用。

#### browserFetcher.download(revision[, progressCallback])

- revision  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 需要下载的浏览器的版本号.
- progressCallback  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)([number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type),  [number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type))> 此函数方法存在两个参数:
    - downloadedBytes  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 已经下载了多少字节
    - totalBytes  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 一共有多少字节.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>> 当目标版本的浏览器正在被下载和提取的时候，返回一个 Promise 对象，此对象包含目标版本浏览器的一些信息。
    - revision  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> the revision the info was created from
    - folderPath  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 提取所下载的浏览器包的目录
    - executablePath  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 目标版本的浏览器的运行目录
    - url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 目标版本的浏览器的下载url
    - local  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 目标版本的浏览器是否可在本地磁盘上获取

此方法通过发起一个 GET请求来从目标 host下载指定版本的浏览器。

#### browserFetcher.localRevisions()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>>> 本地磁盘可获取到的所有版本浏览器的列表。

#### browserFetcher.platform()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 返回  mac,  linux,  win32、  win64  中的其中一个。

#### browserFetcher.remove(revision)

- revision  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 需要删除的版本。如果指定的版本的浏览器并没有被下载下来，此方法将会抛出错误（此错误可用 catch捕获）。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> 当指定版本的浏览器被删除后返回一个 Promise。

#### browserFetcher.revisionInfo(revision)

- revision  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 希望获取相关信息的浏览器的版本号。
- returns: <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - revision  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 信息来源的版本号
    - folderPath  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 提取所下载的浏览器包的目录
    - executablePath  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 目标版本的浏览器的运行目录
    - url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 目标版本的浏览器的下载url
    - local  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 目标版本的浏览器是否可在本地磁盘上获取

### class: Browser

- extends:  [(L)](https://nodejs.org/api/events.html#events_class_eventemitter)[EventEmitter](https://nodejs.org/api/events.html#events_class_eventemitter)

当 Puppeteer 连接上一个 Chromium实例的时候，将会[(L)](https://juejin.im/post/6844903630026326029#puppeteerlaunchoptions)[puppeteer.launch](https://juejin.im/post/6844903630026326029#puppeteerlaunchoptions)  或者  [(L)](https://juejin.im/post/6844903630026326029#puppeteerconnectoptions)[puppeteer.connect](https://juejin.im/post/6844903630026326029#puppeteerconnectoptions)方法产生一个 Browser。

下面是一个使用  [Browser](https://juejin.im/post/6844903630026326029#class-browser)  来创建一个  [Page](https://juejin.im/post/6844903630026326029#class-page)的例子 :

jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
await  page.goto('https://example.com');
await  browser.close();
});
复制代码

下面是一个使用  [Browser](https://juejin.im/post/6844903630026326029#class-browser)  来断开连接和重连的例子：

jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
// Store the endpoint to be able to reconnect to Chromium
const  browserWSEndpoint = browser.wsEndpoint();
// Disconnect puppeteer from Chromium
browser.disconnect();

// Use the endpoint to reestablish a connection
const  browser2 =  await  puppeteer.connect({browserWSEndpoint});
// Close Chromium
await  browser2.close();
});
复制代码

#### event: 'disconnected'

当 Puppeteer被从 Chromium实例上断开时被触发，包括如下几种情形：

- Chromium 被关闭或崩溃
- The  [(L)](https://juejin.im/post/6844903630026326029#browserdisconnect)[browser.disconnect](https://juejin.im/post/6844903630026326029#browserdisconnect)  方法被调用

#### event: 'targetchanged'

- <[Target](https://juejin.im/post/6844903630026326029#class-target)>

当目标 url改变时触发。
> NOTE>   > 包括在匿名浏览器上下文中目标URL改变。

#### event: 'targetcreated'

- <[Target](https://juejin.im/post/6844903630026326029#class-target)>

当目标被创建时触发, 例如，当一个新页面通过  [(L)](https://developer.mozilla.org/en-US/docs/Web/API/Window/open)[window.open](https://developer.mozilla.org/en-US/docs/Web/API/Window/open)  或者  [(L)](https://juejin.im/post/6844903630026326029#browsernewpage)[browser.newPage](https://juejin.im/post/6844903630026326029#browsernewpage)被打开时。

> NOTE>   > 包括在匿名浏览器上下文中目标的创建。

#### event: 'targetdestroyed'

- <[Target](https://juejin.im/post/6844903630026326029#class-target)>

目标被销毁时触发, 例如，当一个页面关闭时。
> NOTE>   > 包括在匿名浏览器上下文中目标的销毁。

#### browser.browserContexts()

- returns: <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[BrowserContext](https://juejin.im/post/6844903630026326029#class-browsercontext)>>

返回一个包含所有已经被打开的浏览器上下文的数组。 在一个最新被创建的浏览器中，将会返回一个唯一的[BrowserContext](https://juejin.im/post/6844903630026326029#class-browsercontext)的实例。

#### browser.close()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

关闭 Chromium以及它所有的页面（如果存在被打开的页面的话）。[Browser](https://juejin.im/post/6844903630026326029#class-browser)  对象将会被销毁，并且不再可用。

#### browser.createIncognitoBrowserContext()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[BrowserContext](https://juejin.im/post/6844903630026326029#class-browsercontext)>>

创建一个新的匿名浏览器上下文，这个匿名浏览器上下文不会与其他浏览器上下文共享 cookies/cache。
jsconst  browser =  await  puppeteer.launch();
// Create a new incognito browser context.
const  context =  await  browser.createIncognitoBrowserContext();
// Create a new page in a pristine context.
const  page =  await  context.newPage();
// Do stuff
await  page.goto('https://example.com');
复制代码

#### browser.disconnect()

Disconnects Puppeteer from the browser, but leaves the Chromium process running. After calling  disconnect, the  [Browser](https://juejin.im/post/6844903630026326029#class-browser)  object is considered disposed and cannot be used anymore.

断开 Puppeteer与 浏览器之间的连接，不过 Chromium进程依旧继续运行。当调用了disconnect方法之后，[Browser](https://juejin.im/post/6844903630026326029#class-browser)  对象将会被销毁，并且不再可用。

#### browser.newPage()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Page](https://juejin.im/post/6844903630026326029#class-page)>>

返回一个新的  [Page](https://juejin.im/post/6844903630026326029#class-page)  Promise对象，[Page](https://juejin.im/post/6844903630026326029#class-page)将在一个默认的浏览器上下文中创建。

#### browser.pages()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Page](https://juejin.im/post/6844903630026326029#class-page)>>> resolve一个包含所有打开页面的数组，不可见的页面，例如  "background_page", 将不会包含在此数组中，你可以使用  [target.page()](https://juejin.im/post/6844903630026326029#targetpage)方法来获取到（不可见页面）。

#### browser.process()

- returns: <?[ChildProcess](https://nodejs.org/api/child_process.html)> 开启一个浏览器主进程的子进程。如果浏览器实例是使用  [(L)](https://juejin.im/post/6844903630026326029#puppeteerconnectoptions)[puppeteer.connect](https://juejin.im/post/6844903630026326029#puppeteerconnectoptions)  方法创建，那么将会返回  null。

#### browser.targets()

- returns: <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Target](https://juejin.im/post/6844903630026326029#class-target)>>

An array of all active targets inside the Browser. In case of multiple browser contexts, the method will return an array with all the targets in all browser contexts.

返回Browser实例中包含的所有的有效targets的一个数组，由于可能存在多个浏览器上下文，所以此方法将会返回一个由所有浏览器上下文中的所有 targets梭组成的数组。

#### browser.userAgent()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> resolve 浏览器的user agent.

> NOTE>   > 可以使用>   > [> page.setUserAgent](https://juejin.im/post/6844903630026326029#pagesetuseragentuseragent)> 来改变浏览器的 user agent。

#### browser.version()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> 对于 headless Chromium来说，将返回一个类似于  HeadlessChrome/61.0.3153.0的字符串。 对于non-headless 浏览器来说, 将返回一个类似于  Chrome/61.0.3153.0的字符串。

> NOTE>   > 此方法返回的字符串格式可能会在将来的版本中发生变化。

#### browser.wsEndpoint()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 浏览器 websoket 的url。

此方法返回的  浏览器 websoket端口字符串格式如：ws://${host}:${port}/devtools/browser/<id>，此字符串可作为[puppeteer.connect](https://juejin.im/post/6844903630026326029#puppeteerconnectoptions)方法的一个参数传入。

You can find the  webSocketDebuggerUrl  from  http://${host}:${port}/json/version. Learn more about the  [devtools protocol](https://chromedevtools.github.io/devtools-protocol)  and the  [browser endpoint](https://chromedevtools.github.io/devtools-protocol/#how-do-i-access-the-browser-target).

### class: BrowserContext

- extends:  [(L)](https://nodejs.org/api/events.html#events_class_eventemitter)[EventEmitter](https://nodejs.org/api/events.html#events_class_eventemitter)

BrowserContexts提供了一种操作多个独立浏览器session的方法。当启动一个浏览器的时候，将会同时产生一个BrowserContext，并且在这个 BrowserContext中，browser.newPage()  方法将会创建一个新页面。

如果使用例如  window.open的方法创建了另外的页面， the popup 将隶属于父页面的浏览器上下文。

Puppeteer允许通过  browser.createIncognitoBrowserContext()  方法来创建匿名浏览器上下文，匿名浏览器上下文不会向磁盘中记录任何浏览的内容。

js// 创建匿名浏览器上下文
const  context =  await  browser.createIncognitoBrowserContext();
// 在上下文中创建页面
const  page =  await  context.newPage();
// ... do stuff with page ...
await  page.goto('https://example.com');
// Dispose context once it's no longer needed.
await  context.close();
复制代码

#### event: 'targetchanged'

- <[Target](https://juejin.im/post/6844903630026326029#class-target)>

当浏览器上下文中的某个target url改变时触发。

#### event: 'targetcreated'

- <[Target](https://juejin.im/post/6844903630026326029#class-target)>

当浏览器上下文中创建了一个新target时触发，例如，当使用  [(L)](https://developer.mozilla.org/en-US/docs/Web/API/Window/open)[window.open](https://developer.mozilla.org/en-US/docs/Web/API/Window/open)  或  [(L)](https://juejin.im/post/6844903630026326029#browsercontextnewpage)[browserContext.newPage](https://juejin.im/post/6844903630026326029#browsercontextnewpage)方法创建一个新页面的时候。

#### event: 'targetdestroyed'

- <[Target](https://juejin.im/post/6844903630026326029#class-target)>

当浏览器上下文中的某个target 被销毁时触发，例如当一个页面被关闭时。

#### browserContext.browser()

- returns: <[Browser](https://juejin.im/post/6844903630026326029#class-browser)>

浏览器上下文归属的浏览器实例。

#### browserContext.close()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

关闭浏览器上下文。所有属于此浏览器上下文的target都将会一同销毁。

> NOTE>   > 只有匿名浏览器上下文可以被关闭(也就是只有通过>   > createIncognitoBrowserContext> 方法创建的匿名浏览器才可以使用此方法)。

#### browserContext.isIncognito()

- returns: <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 返回 BrowserContext 是否是匿名的。 浏览器的默认上下文是非匿名的。

> NOTE>   > 浏览器的默认浏览器上下文是不可关闭的。

#### browserContext.newPage()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Page](https://juejin.im/post/6844903630026326029#class-page)>>

在浏览器上下文中创建新页面。

#### browserContext.targets()

- returns: <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Target](https://juejin.im/post/6844903630026326029#class-target)>>

浏览器上下文中的所有有效target（例如Page页面）组成的一个数组。

### class: Page

- extends:  [(L)](https://nodejs.org/api/events.html#events_class_eventemitter)[EventEmitter](https://nodejs.org/api/events.html#events_class_eventemitter)

Page提供了一些能让你操作 Chromium中标签页的方法。一个  [Browser](https://juejin.im/post/6844903630026326029#class-browser)实例中可能包含多个  [Page](https://juejin.im/post/6844903630026326029#class-page)实例。

下面的例子展示了如何创建一个地址为指定url的页面，并将这个页面保存为一张图片。
jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
await  page.goto('https://example.com');
await  page.screenshot({path:  'screenshot.png'});
await  browser.close();
});
复制代码

使用 Node模块[(L)](https://nodejs.org/api/events.html#events_class_eventemitter)[EventEmitter](https://nodejs.org/api/events.html#events_class_eventemitter)的一些方法，我们能够控制 Page类触发的一些事件，例如  on  once  或者  removeListener等。

下面的例子展示了如何监听页面的  load事件。
jspage.once('load', () =>  console.log('Page loaded!'));
复制代码
使用  removeListener方法来移除监听事件：
jsfunction  logRequest(interceptedRequest) {
console.log('A request was made:', interceptedRequest.url());
}
page.on('request', logRequest);
// Sometime later...
page.removeListener('request', logRequest);
复制代码

#### event: 'close'

当页面关闭的时候触发。

#### event: 'console'

- <[ConsoleMessage](https://juejin.im/post/6844903630026326029#class-consolemessage)>

当页面上的Javascript脚本调用一些类似于  console.log  或  console.dir的 console API时触发，除此之外，如果页面上的脚本抛出错误或者警告同样也会触发。

The arguments passed into  console.log  appear as arguments on the event handler.

下面是一个监听  console事件的例子：
jspage.on('console', msg => {
for  (let  i =  0; i < msg.args().length; ++i)
console.log(`${i}:  ${msg.args()[i]}`);
});
page.evaluate(() =>  console.log('hello',  5, {foo:  'bar'}));
复制代码

#### event: 'dialog'

- <[Dialog](https://juejin.im/post/6844903630026326029#class-dialog)>

当页面上弹出 JavaScript对话框的时候触发，例如  alert,  prompt,  confirm  或者  beforeunload。Puppeteer能够通过  [Dialog](https://juejin.im/post/6844903630026326029#class-dialog)的  [accept](https://juejin.im/post/6844903630026326029#dialogacceptprompttext)  或者  [dismiss](https://juejin.im/post/6844903630026326029#dialogdismiss)  方法来对此事件作出回应。

#### event: 'domcontentloaded'

当 JavaScript 的[(L)](https://developer.mozilla.org/en-US/docs/Web/Events/DOMContentLoaded)[DOMContentLoaded](https://developer.mozilla.org/en-US/docs/Web/Events/DOMContentLoaded)  事件被触发时触发。

#### event: 'error'

- <[Error](https://nodejs.org/api/errors.html#errors_class_error)>

当页面崩溃时触发。

> NOTE>   > error>   > 事件在 Node中具有特殊的含义，具体细节参见>   > [> error events](https://nodejs.org/api/events.html#events_error_events)>   > 。

#### event: 'frameattached'

- <[Frame](https://juejin.im/post/6844903630026326029#class-frame)>

当一个 frame 被附加到主页面上时触发。

#### event: 'framedetached'

- <[Frame](https://juejin.im/post/6844903630026326029#class-frame)>

当一个 frame 从主页面上分离(删除)时触发。

#### event: 'framenavigated'

- <[Frame](https://juejin.im/post/6844903630026326029#class-frame)>

当一个 frame 的url被定向到一个新的url上时触发。

#### event: 'load'

当 JavaScript 的[(L)](https://developer.mozilla.org/en-US/docs/Web/Events/load)[load](https://developer.mozilla.org/en-US/docs/Web/Events/load)  事件被触发时触发。

#### event: 'metrics'

- <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - title  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  console.timeStamp  的 title
    - metrics  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> Object containing metrics as key/value pairs. The values of metrics are of <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> type.一个包含 metrics key/value对的对象。metrics的值为 number类型。

当页面上的JavaScript脚本调用  cnosole.timeStamp时触发。metrics的可选列表可见  page.metrics。

#### event: 'pageerror'

- <[Error](https://nodejs.org/api/errors.html#errors_class_error)> The exception message

当页面上出现未捕获的异常时触发。

#### event: 'request'

- <[Request](https://juejin.im/post/6844903630026326029#class-request)>

当页面上发起一个请求的时候触发。[request](https://juejin.im/post/6844903630026326029#class-request)对象是只读的，如果你想拦截并改造请求，参照  page.setRequestInterception。

#### event: 'requestfailed'

- <[Request](https://juejin.im/post/6844903630026326029#class-request)>

当请求失败时触发，例如，请求超时。

#### event: 'requestfinished'

- <[Request](https://juejin.im/post/6844903630026326029#class-request)>

当请求完成时触发。

#### event: 'response'

- <[Response](https://juejin.im/post/6844903630026326029#class-response)>

当页面收到请求的响应时触发。

#### event: 'workercreated'

- <[Worker](https://juejin.im/post/6844903630026326029#class-worker)>

当页面上产生一个新的  [WebWorker](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API)线程时触发。

#### event: 'workerdestroyed'

- <[Worker](https://juejin.im/post/6844903630026326029#class-worker)>

当页面上有  [WebWorker](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API)线程结束时触发。

#### page.$(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 选择器
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<?[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>>

此方法在页面上使用了  document.querySelector。如果选择器没有匹配到元素，将会返回  null。

[page.mainFrame().$(selector)](https://juejin.im/post/6844903630026326029#frameselector)的快捷方法。

#### page.?(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 选择器
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>>>

此方法在页面上使用了  document.querySelectorAll。如果选择器没有匹配到元素，将会返回  []。

[page.mainFrame().?(selector)](https://juejin.im/post/6844903630026326029#frameselector-1)的快捷方法。

#### page.?eval(selector, pageFunction[, ...args])

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 选择器
- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)> 将在浏览器上下文中执行的函数
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的额外参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)>>  pageFunction返回的结果。

此方法在页面上使用了  Array.from(document.querySelectorAll(selector))，并将获取到的结果当做  pageFunction的第一个参数传递进去。

如果  pageFunction返回的结果是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则page.?eval将会等到前者 resolve回一个结果后，才会继续返回自己的值。

例子:
jsconst  divsCounts =  await  page.?eval('div', divs => divs.length);
复制代码

#### page.$eval(selector, pageFunction[, ...args])

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 选择器
- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)> 将在浏览器上下文中执行的函数
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的额外参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)>>  pageFunction返回的结果。

此方法在页面上使用了  document.querySelector，并将获取到的结果当做  pageFunction的第一个参数传递进去。如果选择器没有匹配到元素，则将抛出一个错误。

如果  pageFunction返回的结果是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则page.$eval将会等到前者 resolve回一个结果后，才会继续返回自己的值。

例子:
jsconst  searchValue =  await  page.$eval('#search', el => el.value);
const  preloadHref =  await  page.$eval('link[rel=preload]', el => el.href);
const  html =  await  page.$eval('.main-container', e => e.outerHTML);
复制代码

[page.mainFrame().$eval(selector, pageFunction)](https://juejin.im/post/6844903630026326029#frameevalselector-pagefunction-args)的快捷方法。

#### page.$x(expression)

- expression  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Expression to  [evaluate](https://developer.mozilla.org/en-US/docs/Web/API/Document/evaluate).
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>>>

根据给定的 Xpath表达式获取 DOM元素。

[page.mainFrame().$x(expression)](https://juejin.im/post/6844903630026326029#framexexpression)的快捷方法。

#### page.addScriptTag(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被添加的 script 的url.
    - path  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被添加的JavaScript文件的路径. 如果  path  是相对路径, 则其是相对于  [current working directory](https://nodejs.org/api/process.html#process_process_cwd)。
    - content  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被添加的JavaScript脚本的内容。
    - type  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 脚本类型. 如果是 'module' ，则将导入的是JS的 ES6模块。更多参见  [script](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script)。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>> 当script脚本加载完毕，或者脚本内容已经注入到页面上时，将会返回所添加的script标签元素。

向页面中增加指定 url或者 脚本内容的  script标签。

[page.mainFrame().addScriptTag(options)](https://juejin.im/post/6844903630026326029#frameaddscripttagoptions)的快捷方法。

#### page.addStyleTag(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被添加的 style 的url
    - path  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被添加的 CSS文件的路径. 如果  path  是相对路径, 则其是相对于  [current working directory](https://nodejs.org/api/process.html#process_process_cwd)。
    - content  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被添加的CSS脚本的内容。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>>当style加载完毕，或者style内容已经注入到页面上时，将会返回所添加的style标签元素。

向页面中添加一个 带有指定 url的<link rel="stylesheet">标签，或者一个带有内容的<style type="text/css">标签。

[page.mainFrame().addStyleTag(options)](https://juejin.im/post/6844903630026326029#frameaddstyletagoptions)的快捷方法。

#### page.authenticate(credentials)

- credentials  <?[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - username  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
    - password  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

Provide credentials for  [http authentication](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication).

如果是无效的authentication，则返回  null

#### page.bringToFront()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

Brings page to front (activates tab).

#### page.browser()

- returns: <[Browser](https://juejin.im/post/6844903630026326029#class-browser)>

获取页面所属的 browser实例。

#### page.click(selector[, options])

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被点击的元素的 选择器。如果选择器匹配出了多个元素，则点击事件只会作用在第一个匹配的元素上。
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - button  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  left,  right, or  middle, 默认是  left（即使用左键、右键还是中键进行点击操作）
    - clickCount  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 默认点击一次。 更多参见[UIEvent.detail](https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail)。
    - delay  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>  mousedown  和  mouseup  事件之间的时间间隔. 默认为 0.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> 当匹配的元素被成功点击时将会resolve，如果没有匹配到元素，则将 reject。

此方法将会根据给定的选择器匹配到元素，如果所匹配到的元素不在视界内，将会将其滚动到视界内，然后使用  [page.mouse](https://juejin.im/post/6844903630026326029#pagemouse)方法点击匹配到的元素的中心位置。 如果没有匹配到元素，则将抛出一个错误。

需要注意的是，如果所点击的元素会触发页面跳转，并且还调用了page.waitForNavigation()方法，那么你可能不会得到期望的结果，正确的做法如下：
javascriptconst  [response] =  await  Promise.all([
page.waitForNavigation(waitOptions),
page.click(selector, clickOptions),
]);
复制代码

[page.mainFrame().click(selector[, options])](https://juejin.im/post/6844903630026326029#frameclickselector-options)的快捷方法。

#### page.close(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - runBeforeUnload  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 默认为false. 是否在关闭前调用  [before unload](https://developer.mozilla.org/en-US/docs/Web/Events/beforeunload)。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

page.close()方法默认不调用 beforeunload句柄。

(这个方法的意思是，如果页面上注册了 onbeforeunload方法，那么在关闭页面时，将会调用这个onbeforeunload方法，如果  puppeteer.launch的  headless参数设置为  true，那么你将看到页面在关闭时，弹出了一个询问是否离开页面的对话框)。

> NOTE>   > 如果> runBeforeUnload>   > 为 true, 页面在关闭时可能会弹出>   > beforeunload>   > 对话框， 并且这个对话框可以被 page的>   > [> 'dialog'](https://juejin.im/post/6844903630026326029#event-dialog)> 事件捕获到.

#### page.content()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[String](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>>

获取页面上包括 doctype在内的所有 HTML内容。

#### page.cookies(...urls)

- ...urls  <...[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>>>
    - name  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
    - value  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
    - domain  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
    - path  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
    - expires  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Unix time in seconds.
    - httpOnly  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>
    - secure  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>
    - session  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>
    - sameSite  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  "Strict"  or  "Lax".

如果没有提供 URLs，则此方法将会返回当前页面URL的 cookies。 如果指定了URLs，则只有这些指定URLS上的cookies才会被返回。

#### page.coverage

- returns: <[Coverage](https://juejin.im/post/6844903630026326029#class-coverage)>

#### page.deleteCookie(...cookies)

- ...cookies  <...[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - name  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  required
    - url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
    - domain  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
    - path  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
    - secure  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

#### page.emulate(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - viewport  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
        - width  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> page width in pixels.
        - height  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> page height in pixels.
        - deviceScaleFactor  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Specify device scale factor (can be thought of as dpr). Defaults to  1.
        - isMobile  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> Whether the  meta viewport  tag is taken into account. Defaults to  false.
        - hasTouch<[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> Specifies if viewport supports touch events. Defaults to  false
        - isLandscape  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> Specifies if viewport is in landscape mode. Defaults to  false.
    - userAgent  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

Emulates given device metrics and user agent. This method is a shortcut for calling two methods:

- [page.setUserAgent(userAgent)](https://juejin.im/post/6844903630026326029#pagesetuseragentuseragent)
- [page.setViewport(viewport)](https://juejin.im/post/6844903630026326029#pagesetviewportviewport)

puppeteer提供了一些描述设备信息的参数，这些参数可以通过  require('puppeteer/DeviceDescriptors')命令查看。 下面是一个使用 puppeteer模拟 iPhone 6的例子。

jsconst  puppeteer =  require('puppeteer');
const  devices =  require('puppeteer/DeviceDescriptors');
const  iPhone = devices['iPhone 6'];

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
await  page.emulate(iPhone);
await  page.goto('https://www.google.com');
// other actions...
await  browser.close();
});
复制代码

所有能够模拟的设备可以在[DeviceDescriptors.js](https://github.com/GoogleChrome/puppeteer/blob/master/DeviceDescriptors.js)中找到。

#### page.emulateMedia(mediaType)

- mediaType  <?[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 改变页面CSS media的类型。允许的值有  'screen',  'print'  and  null，如果传入null  则表示不进行模拟。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

#### page.evaluate(pageFunction, ...args)

- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将在 page context中执行的函数
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)>> Promise which resolves to the return value of  pageFunction

如果传递给  page.evaluate的  pageFunction函数返回一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则page.evaluate将会等待得到resolve后，才会返回它自己的值。

如果传递给  page.evaluate的  pageFunction函数返回一个 non-[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)的值，则page.evaluate将会返回  undefined。

给  pageFunction传递参数：
jsconst  result =  await  page.evaluate(x => {
return  Promise.resolve(8  * x);
},  7);
console.log(result);  // prints "56"
复制代码
可以传递一个字符串作为  pageFunction：
jsconsole.log(await  page.evaluate('1 + 2'));  // prints "3"
const  x =  10;
console.log(await  page.evaluate(`1 +  ${x}`));  // prints "11"
复制代码

可以传递一个[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)  作为  pageFunction参数：

jsconst  bodyHandle =  await  page.$('body');
const  html =  await  page.evaluate(body => body.innerHTML, bodyHandle);
await  bodyHandle.dispose();
复制代码

[page.mainFrame().evaluate(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#frameevaluatepagefunction-args)的快捷方法。

#### page.evaluateHandle(pageFunction, ...args)

- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 在page context 中执行的函数。
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>> Promise which resolves to the return value of  pageFunction  as in-page object (JSHandle)。

page.evaluate  和  page.evaluateHandle之间唯一的差别是，page.evaluateHandle返回的结果是 in-page object (JSHandle)。 (可能指的是此方法只返回页面元素的句柄，即此方法可以看作一个元素选择器)

如果传入  page.evaluateHandle的函数 返回的值是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则page.evaluateHandle将会等待这个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)到达resolve时才会返回自己的值。

可以传递一个 字符串作为  pageFunction：

jsconst  aHandle =  await  page.evaluateHandle('document');  // Handle for the 'document'

复制代码

[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)  instances也可以作为page.evaluateHandle的传入参数：

jsconst  aHandle =  await  page.evaluateHandle(() =>  document.body);

const  resultHandle =  await  page.evaluateHandle(body => body.innerHTML, aHandle);

console.log(await  resultHandle.jsonValue());
await  resultHandle.dispose();
复制代码

[page.mainFrame().executionContext().evaluateHandle(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#executioncontextevaluatehandlepagefunction-args)的快捷方法。

#### page.evaluateOnNewDocument(pageFunction, ...args)

- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 在browser context中执行的函数。
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)> 传递给  pageFunction的参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

pageFunction可能会在以下情况下呗调用： Adds a function which would be invoked in one of the following scenarios:

- 页面重定向
- 子frame重定向或者增加新的子frame。在这种情况下，pageFunction将会在子frame中执行。

pageFunction会在文档(document)加载完毕后以及页面上JS脚本执行之前被调用，This is useful to amend the JavaScript environment, e.g. to seed  Math.random.

下面是一个在页面加载之前重写 navigator.languages属性的例子：
js// preload.js

// overwrite the `languages` property to use a custom getter
Object.defineProperty(navigator,  "languages", {
get:  function() {
return  ["en-US",  "en",  "bn"];
}
});

// In your puppeteer script, assuming the preload.js file is in same folder of our script

const  preloadFile = fs.readFileSync('./preload.js',  'utf8');
await  page.evaluateOnNewDocument(preloadFile);
复制代码

#### page.exposeFunction(name, puppeteerFunction)

- name  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 在 window对象中添加的函数的名字
- puppeteerFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)> 将会在 Puppeteer's context中执行的函数。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

此方法将会在  window对象中添加一个 名为  name的函数。 当被调用时，其将会在  node.js中执行  puppeteerFunction，并且返回一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，此[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)会  resolve回  puppeteerFunction的返回结果。

如果puppeteerFunction返回的结果是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则此方法将会等到前者  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)  resolve之后，才会返回自己的  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)。

> NOTE>   > Functions installed via>   > page.exposeFunction>   > survive navigations.

下面是一个在页面中添加  md5函数的例子：
jsconst  puppeteer =  require('puppeteer');
const  crypto =  require('crypto');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
page.on('console', msg =>  console.log(msg.text()));
await  page.exposeFunction('md5', text =>
crypto.createHash('md5').update(text).digest('hex')
);
await  page.evaluate(async  () => {
// use window.md5 to compute hashes
const  myString =  'PUPPETEER';
const  myHash =  await  window.md5(myString);
console.log(`md5 of  ${myString}  is  ${myHash}`);
});
await  browser.close();
});
复制代码
下面是一个在页面中添加  window.readfile函数的例子：
jsconst  puppeteer =  require('puppeteer');
const  fs =  require('fs');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
page.on('console', msg =>  console.log(msg.text()));
await  page.exposeFunction('readfile',  async  filePath => {
return  new  Promise((resolve, reject) => {
fs.readFile(filePath,  'utf8', (err, text) => {
if  (err)
reject(err);
else
resolve(text);
});
});
});
await  page.evaluate(async  () => {
// use window.readfile to read contents of a file
const  content =  await  window.readfile('/etc/hosts');
console.log(content);
});
await  browser.close();
});

复制代码

#### page.focus(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 需要focus的元素的选择器。 如果此选择器匹配到了多个元素，则只有第一个匹配的元素才会被focus。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> 当成功匹配到元素后，[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)将resolve。如果没有匹配到任何元素，则将reject。

此方法将 focus给定 selector匹配到的元素。 如果根据给定的 selector没有匹配到任何元素，将会抛出异常。

[page.mainFrame().focus(selector)](https://juejin.im/post/6844903630026326029#framefocusselector)的快捷方法。

#### page.frames()

- returns: <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Frame](https://juejin.im/post/6844903630026326029#class-frame)>> 返回一个有页面上附加的所有 frames组成的数组。

#### page.goBack(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 页面跳转参数，包括以下属性：
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 连接超时时间，单位毫秒, 默认是 30秒, 如果设置为  0则表示禁用此选项。 此值也可以被  [page.setDefaultNavigationTimeout(timeout)](https://juejin.im/post/6844903630026326029#pagesetdefaultnavigationtimeouttimeout)  方法修改。
    - waitUntil  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)|[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> 确认navigation成功的条件, 默认是load。如果给定的值是一个事件名称组成的数组，那么只有当数组中的所有事件全部被触发后才会认为 navigation成功，可选的事件列表如下:
        - load  - consider navigation to be finished when the  load  event is fired.
        - domcontentloaded  - consider navigation to be finished when the  DOMContentLoaded  event is fired.
        - networkidle0  - 如果在  500ms内发起的http请求数为0，则认为导航结束。
        - networkidle2  - 如果在  500ms内发起的http请求数为不超过 2条，则认为导航结束。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<?[Response](https://juejin.im/post/6844903630026326029#class-response)>> Promise which resolves to the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect.

如果无法  go back，则 resolve回的数据为  null
返回上一页。

#### page.goForward(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 页面跳转参数，包括以下属性：
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 连接超时时间，单位毫秒, 默认是 30秒, 如果设置为  0则表示禁用此选项。 此值也可以被  [page.setDefaultNavigationTimeout(timeout)](https://juejin.im/post/6844903630026326029#pagesetdefaultnavigationtimeouttimeout)  方法修改。
    - waitUntil  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)|[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> 确认navigation成功的条件, 默认是load。如果给定的值是一个事件组成的数组，那么只有当数组中的所有事件全部被触发后才会认为 navigation成功，可选的事件列表如下:
        - load  - consider navigation to be finished when the  load  event is fired.
        - domcontentloaded  - consider navigation to be finished when the  DOMContentLoaded  event is fired.
        - networkidle0  - 如果在  500ms内发起的http请求数为0，则认为导航结束。
        - networkidle2  - 如果在  500ms内发起的http请求数为不超过 2条，则认为导航结束。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<?[Response](https://juejin.im/post/6844903630026326029#class-response)>> Promise which resolves to the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect.

如果无法  go forward，则 resolve回的数据为  null
跳转到 history里的下一页。

#### page.goto(url, options)

- url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 目标页面的url. url中应该包含协议头，例如  https://。
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 页面跳转参数，包括以下属性：
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 连接超时时间，单位毫秒, 默认是 30秒, 如果设置为  0则表示禁用此选项。 此值也可以被  [page.setDefaultNavigationTimeout(timeout)](https://juejin.im/post/6844903630026326029#pagesetdefaultnavigationtimeouttimeout)  方法修改。
    - waitUntil  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)|[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> 确认navigation成功的条件, 默认是load。如果给定的值是一个事件组成的数组，那么只有当数组中的所有事件全部被触发后才会认为 navigation成功，可选的事件列表如下:
        - load  - 当  load  事件触发时，则认为 navigation导航结束。
        - domcontentloaded  - 当  DOMContentLoaded  事件触发时，则认为 navigation导航结束。
        - networkidle0  - 如果在  500ms内发起的http请求数为0，则认为导航结束。
        - networkidle2  - 如果在  500ms内发起的http请求数为不超过 2条，则认为导航结束。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<?[Response](https://juejin.im/post/6844903630026326029#class-response)>> Promise which resolves to the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect.

如果在页面跳转过程中发生以下情况，则此方法将抛出错误：

- SSL error (例如，如果是私有证书).
- 目标 URL失效
- 连接超时
- the main resource failed to load.

> NOTE>   > page.goto>   > 方法要么抛出一个错误，要么返回 a main resource response，除非跳转的链接是> about:blank> , 这时候，此方法将返回>   > null> 。

> NOTE>   > 在 Headless mode下，此方法不支持 跳转到 一个 PDF document。参见> [> upstream issue](https://bugs.chromium.org/p/chromium/issues/detail?id=761295)> .

#### page.hover(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 需要 hover的元素的选择器。 如果此选择器匹配到了多个元素，则只有第一个匹配的元素才会被hover。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> 当成功匹配到元素后，[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)将resolve。如果没有匹配到任何元素，则将reject。

此方法将会根据给定的选择器匹配到元素，如果所匹配到的元素不在视界内，将会将其滚动到视界内，然后使用  [page.mouse](https://juejin.im/post/6844903630026326029#pagemouse)方法 hover匹配到的元素的中心位置。 如果没有匹配到元素，则将抛出一个错误。

[page.mainFrame().hover(selector)](https://juejin.im/post/6844903630026326029#framehoverselector)的快捷方法。

#### page.isClosed()

- returns: boolean

页面是否被关闭。

#### page.keyboard

- returns: <[Keyboard](https://juejin.im/post/6844903630026326029#class-keyboard)>

#### page.mainFrame()

- returns: <[Frame](https://juejin.im/post/6844903630026326029#class-frame)> 返回页面的 主frame。

navigations过程中，Page一直存在一个 main frame。

#### page.metrics()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>> Object containing metrics as key/value pairs.
    - Timestamp  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> The timestamp when the metrics sample was taken.
    - Documents  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Number of documents in the page.
    - Frames  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Number of frames in the page.
    - JSEventListeners  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Number of events in the page.
    - Nodes  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Number of DOM nodes in the page.
    - LayoutCount  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Total number of full or partial page layout.
    - RecalcStyleCount  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Total number of page style recalculations.
    - LayoutDuration  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Combined durations of all page layouts.
    - RecalcStyleDuration  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Combined duration of all page style recalculations.
    - ScriptDuration  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Combined duration of JavaScript execution.
    - TaskDuration  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Combined duration of all tasks performed by the browser.
    - JSHeapUsedSize  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Used JavaScript heap size.
    - JSHeapTotalSize  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Total JavaScript heap size.

> NOTE>   > All timestamps are in monotonic time: monotonically increasing time in seconds since an arbitrary point in the past.

#### page.mouse

- returns: <[Mouse](https://juejin.im/post/6844903630026326029#class-mouse)>

#### page.pdf(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 具备以下属性的参数对象:
    - path  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 保存PDF文件的路径. 如果path  是一个相对路径,则它是相对于[current working directory](https://nodejs.org/api/process.html#process_process_cwd). 如果没有提供此值项值, 将不会保存PDF。
    - scale  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 网页缩放的值。默认为  1.
    - displayHeaderFooter  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> Display header and footer. Defaults to  false.
    - headerTemplate  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> HTML template for the print header. Should be valid HTML markup with following classes used to inject printing values into them:
        - date  formatted print date
        - title  文档标题
        - url  文档url
        - pageNumber  当前页码
        - totalPages  总页数
    - footerTemplate  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> HTML template for the print footer. Should use the same format as the  headerTemplate.
    - printBackground  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> Print background graphics. Defaults to  false.
    - landscape  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> Paper orientation. Defaults to  false.
    - pageRanges  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Paper ranges to print, e.g., '1-5, 8, 11-13'. Defaults to the empty string, which means print all pages.
    - format  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Paper format. If set, takes priority over  width  or  height  options. Defaults to 'Letter'.
    - width  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Paper width, accepts values labeled with units.
    - height  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Paper height, accepts values labeled with units.
    - margin  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> Paper margins, defaults to none.
        - top  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Top margin, accepts values labeled with units.
        - right  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Right margin, accepts values labeled with units.
        - bottom  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Bottom margin, accepts values labeled with units.
        - left  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Left margin, accepts values labeled with units.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Buffer](https://nodejs.org/api/buffer.html#buffer_class_buffer)>> Promise which resolves with PDF buffer.

> NOTE>   > 生成pdf的操作只有Chrome浏览器才有效。

page.pdf()以  print的 css media生成pdf，如果想生成一个  screenmedia的PDF，请在使用  page.pdf()之前调用[page.emulateMedia('screen')](https://juejin.im/post/6844903630026326029#pageemulatemediamediatype)方法。

js// Generates a PDF with 'screen' media type.
await  page.emulateMedia('screen');
await  page.pdf({path:  'page.pdf'});
复制代码
width,  height, 和  margin属性接受的值应该明确带上相应的单位，否则将会被默认为  px单位。
一些例子:

- page.pdf({width: 100})  - 宽度为100px
- page.pdf({width: '100px'})  - 宽度为100px
- page.pdf({width: '10cm'})  - 宽度为 10厘米

所有可选的单位:

- px  - pixel
- in  - inch
- cm  - centimeter
- mm  - millimeter

format  属性的可选值:

- Letter: 8.5in x 11in
- Legal: 8.5in x 14in
- Tabloid: 11in x 17in
- Ledger: 17in x 11in
- A0: 33.1in x 46.8in
- A1: 23.4in x 33.1in
- A2: 16.5in x 23.4in
- A3: 11.7in x 16.5in
- A4: 8.27in x 11.7in
- A5: 5.83in x 8.27in
- A6: 4.13in x 5.83in

> NOTE>   > headerTemplate>   > 以及>   > footerTemplate> 的标签有以下限制:
1. > Script tags inside templates are not evaluated.
2. > Page styles are not visible inside templates.

#### page.queryObjects(prototypeHandle)

- prototypeHandle  <[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> A handle to the object prototype.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>> Promise which resolves to a handle to an array of objects with this prototype.

此方法迭代给定的JavaScript堆的prototype，返回prototype上的所有对象
js// Create a Map object
await  page.evaluate(() =>  window.map =  new  Map());
// Get a handle to the Map object prototype
const  mapPrototype =  await  page.evaluateHandle(() =>  Map.prototype);
// Query all map instances into an array
const  mapInstances =  await  page.queryObjects(mapPrototype);
// Count amount of map objects in heap
const  count =  await  page.evaluate(maps => maps.length, mapInstances);
await  mapInstances.dispose();
await  mapPrototype.dispose();
复制代码

[page.mainFrame().executionContext().queryObjects(prototypeHandle)](https://juejin.im/post/6844903630026326029#executioncontextqueryobjectsprototypehandle)的快捷方法。

#### page.reload(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> navigation 参数，允许具备以下属性:
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 超时时间，单位为ms,默认为 30s， 如果设置为  0表示禁用此属性。也可以使用[page.setDefaultNavigationTimeout(timeout)](https://juejin.im/post/6844903630026326029#pagesetdefaultnavigationtimeouttimeout)  方法来改变此值。
    - waitUntil  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)|[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> 确认navigation成功的条件, 默认是load。如果给定的值是一个事件组成的数组，那么只有当数组中的所有事件全部被触发后才会认为 navigation成功，可选的事件列表如下:
        - load  - consider navigation to be finished when the  load  event is fired.
        - domcontentloaded  - consider navigation to be finished when the  DOMContentLoaded  event is fired.
        - networkidle0  - 如果在  500ms内发起的http请求数为0，则认为导航结束。
        - networkidle2  - 如果在  500ms内发起的http请求数不超过 2条，则认为导航结束。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Response](https://juejin.im/post/6844903630026326029#class-response)>> Promise which resolves to the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect.

#### page.screenshot([options])

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 此对象允许具备以下属性:
    - path  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 截图保存的地址路径。 截图的图片类型会自动根据文件名扩展来确定。如果  path是相对路径，则其应当是相对于  [current working directory](https://nodejs.org/api/process.html#process_process_cwd).。如果没有提供此属性值，则将不会保存截图。
    - type  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 指定截图的文件类型。可选值有jpeg  和  png。默认为 'png'。
    - quality  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 图片质量, 值范围为 0-100。不适用于  png  图片。
    - fullPage  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 当值为  true的话，则将截取包括可滚动区域在内的所有页面。默认为  false.
    - clip  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 用于确定一个指定的裁剪范围。必须具备以下属性:
        - x  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> x-coordinate of top-left corner of clip area裁剪范围的左上角的 x点坐标
        - y  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 裁剪范围的左上角的 y点坐标
        - width  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 裁剪范围的宽度
        - height  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 裁剪范围的高度
    - omitBackground  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 隐藏默认白色背景，并允许以透明方式截取屏幕截图。 默认为false.
    - encoding  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 图片编码方式,可以是  base64  或者  binary。默认为  binary.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Buffer|String]>> 返回一个Promise，此Promise的resolve值是截图的 buffer或者 base64编码数据的字符串。

> NOTE>   > 在OS X系统上，截图操作最少需要 1/6秒的时间。参见>   > [> crbug.com/741689](https://crbug.com/741689)>   > 。

#### page.select(selector, ...values)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> [select]标签的选择器
- ...values  <...[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 选择的值。如果  <select>  标签具有  multiple  属性, 所有的指定值都是有效值, 否则只会考虑第一个值。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>>> 返回一个由所有成功选中(selected)的选项(option)的值组成的数组。

当所有提供的  values值的选项(option)全被选中后会触发  change  以及  input事件。 如果根据所指定的选择器selector没有匹配到一个  <select>元素，将会抛出错误。 (这个方法就是用于控制 select的选择)

jspage.select('select#colors',  'blue');  // 单选
page.select('select#colors',  'red',  'green',  'blue');  // 多选
复制代码

Shortcut for  [page.mainFrame().select()](https://juejin.im/post/6844903630026326029#frameselectselector-values)

#### page.setBypassCSP(enabled)

- enabled  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 设置是否绕过页面的Content-Security-Policy(内容安全策略)。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

控制是否绕过页面的Content-Security-Policy(内容安全策略)。

> NOTE>   > 绕过CSP的操作应该发生在CSP的初始化阶段而不是执行阶段。也就是说，在 navigating向目标主机之前就应该调用> page.setBypassCSP> 方法。

#### page.setCacheEnabled(enabled)

- enabled  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> sets the  enabled  state of the cache.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

是否使用资源缓存，默认启用缓存。 Toggles ignoring cache for each request based on the enabled state. By default, caching is enabled.

#### page.setContent(html)

- html  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 设置page页面的HTML内容。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

#### page.setCookie(...cookies)

- ...cookies  <...[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - name  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  必选
    - value  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  必选
    - url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
    - domain  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
    - path  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>
    - expires  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 以秒为单位的 Unix时间
    - httpOnly  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>
    - secure  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>
    - sameSite  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  "Strict"  or  "Lax".
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

#### page.setDefaultNavigationTimeout(timeout)

- timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 导航超时时间。

此方法可以改变以下方法默认 30s的超时时间。

- [page.goto(url, options)](https://juejin.im/post/6844903630026326029#pagegotourl-options)
- [page.goBack(options)](https://juejin.im/post/6844903630026326029#pagegobackoptions)
- [page.goForward(options)](https://juejin.im/post/6844903630026326029#pagegoforwardoptions)
- [page.reload(options)](https://juejin.im/post/6844903630026326029#pagereloadoptions)
- [page.waitForNavigation(options)](https://juejin.im/post/6844903630026326029#pagewaitfornavigationoptions)

#### page.setExtraHTTPHeaders(headers)

- headers  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 一个将为所有的请求增添额外 header属性的对象。所有的header值必须都是 string类型。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

这些额外的 header头将会被页面发出的所有请求链接携带上。
> NOTE>   > page.setExtraHTTPHeaders 无法保证请求header的顺序。

#### page.setJavaScriptEnabled(enabled)

- enabled  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 是否启用页面的 JavaScript。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

> NOTE>   > 改变此值无法影响到那些已经执行的 JS代码。不过会在下次导航>   > [> navigation](https://juejin.im/post/6844903630026326029#pagegotourl-options)> 中完全起作用。

#### page.setOfflineMode(enabled)

- enabled  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 当设置为  true时, 将会启用页面的离线模式。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

#### page.setRequestInterception(value)

- value  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 是否启用请求拦截。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

启用请求拦截将会使request.abort,  request.continue  以及  request.respond方法可用。这提供了能够修改页面请求的能力。

下面的例子展示如何拦截请求并断掉(abort)掉所有的图片请求：
jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
await  page.setRequestInterception(true);
page.on('request', interceptedRequest => {

if  (interceptedRequest.url().endsWith('.png') || interceptedRequest.url().endsWith('.jpg'))

interceptedRequest.abort();
else
interceptedRequest.continue();
});
await  page.goto('https://example.com');
await  browser.close();
});
复制代码
> NOTE>   > 启用请求拦截将会禁用页面缓存(也就是请求不再使用页面缓存)。

#### page.setUserAgent(userAgent)

- userAgent  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 指定页面的 user agent
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> resolve页面的 user agent

#### page.setViewport(viewport)

- viewport  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - width  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 页面的宽度，单位为px
    - height  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 页面的高度，单位为px
    - deviceScaleFactor  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 指定页面缩放比例 (can be thought of as dpr). 默认为  1.
    - isMobile  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 是否考虑  meta viewport  标签。 默认为  false.
    - hasTouch<[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 设置 viewport是否支持触摸事件。 默认为  false
    - isLandscape  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 设置 viewport是否是 landscape mode。 默认为  false.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

> NOTE>   > 在某些的情况下，设置 viewportin 将会导致页面 reload 以便让>   > isMobile>   > 或者>   > hasTouch> 属性生效。

如果一个浏览器中开启了多个页面，则每个页面都有其自己的 viewport大小。

#### page.tap(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被tap的元素的 选择器。如果选择器匹配出了多个元素，则tap事件只会作用在第一个匹配的元素上。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

此方法将会根据给定的选择器匹配到元素，如果所匹配到的元素不在视界内，将会将其滚动到视界内，然后使用  [page.touchscreen](https://juejin.im/post/6844903630026326029#pagetouchscreen)方法tap匹配到的元素的中心位置。 如果没有匹配到元素，则将抛出一个错误。

[page.mainFrame().tap(selector)](https://juejin.im/post/6844903630026326029#frametapselector)的快捷方法。

#### page.target()

- returns: <[Target](https://juejin.im/post/6844903630026326029#class-target)> a target this page was created from.

#### page.title()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> 返回页面的title。

[page.mainFrame().title()](https://juejin.im/post/6844903630026326029#frametitle)的快捷方法。

#### page.touchscreen

- returns: <[Touchscreen](https://juejin.im/post/6844903630026326029#class-touchscreen)>

#### page.tracing

- returns: <[Tracing](https://juejin.im/post/6844903630026326029#class-tracing)>

#### page.type(selector, text[, options])

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 文本框(包括 texarea和input)的选择器。如果选择器匹配出了多个元素，则只会选择第一个匹配的元素上。
- text  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要输入到文本框内的文字。
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - delay  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 按键输入的间隔速度，单位为ms。默认为 0.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

Sends a  keydown,  keypress/input, and  keyup  event for each character in the text.

为了按下一些特殊按键，例如  Control  或  ArrowDown，请使用[(L)](https://juejin.im/post/6844903630026326029#keyboardpresskey-options)[keyboard.press](https://juejin.im/post/6844903630026326029#keyboardpresskey-options)。

jspage.type('#mytextarea',  'Hello');  // Types instantly

page.type('#mytextarea',  'World', {delay:  100});  // Types slower, like a user

复制代码

[page.mainFrame().type(selector, text[, options])](https://juejin.im/post/6844903630026326029#frametypeselector-text-options)的快捷方法。

#### page.url()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>

[page.mainFrame().url()](https://juejin.im/post/6844903630026326029#frameurl)的快捷方法。

#### page.viewport()

- returns: <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - width  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 页面宽度，单位为px。
    - height  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 页面高度，单位为px。
    - deviceScaleFactor  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 设备的缩放比例 (can be though of as dpr)。默认为  1.
    - isMobile  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>是否考虑  meta viewport标签。默认为  false.
    - hasTouch<[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 是否支持 touch事件。默认为  false
    - isLandscape  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 设置 viewport 是否处于landscape mode。默认为  false.

#### page.waitFor(selectorOrFunctionOrTimeout[, options[, ...args]])

- selectorOrFunctionOrTimeout  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)|[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)|[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)> A  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors), predicate or timeout to wait for
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> Optional waiting parameters
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>  pageFunction的参数。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>> Promise which resolves to a JSHandle of the success value

根据第一个参数的不同，此方法可实现的场景如下：

- 如果  selectorOrFunctionOrTimeout是一个  string, 那么它如果是以 '//'开头, 就是[xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)，否则就是  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)，此方法是  [page.waitForSelector](https://juejin.im/post/6844903630026326029#pagewaitforselectorselector-options)  或者  [page.waitForXPath](https://juejin.im/post/6844903630026326029#pagewaitforxpathxpath-options)方法的快捷方法。
- 如果  selectorOrFunctionOrTimeout  是一个  function, then the first argument is treated as a predicate to wait for and the method is a shortcut for  [page.waitForFunction()](https://juejin.im/post/6844903630026326029#pagewaitforfunctionpagefunction-options-args).
- 如果  selectorOrFunctionOrTimeout  是一个  number, 那么它就会被当做是等待时间(ms)，超过等到时间后将会resolve。
- 如果不是以上三种情况中的任何一个，那么将会抛出错误。

[page.mainFrame().waitFor(selectorOrFunctionOrTimeout[, options[, ...args]])](https://juejin.im/post/6844903630026326029#framewaitforselectororfunctionortimeout-options-args)的快捷方法。

#### page.waitForFunction(pageFunction[, options[, ...args]])

- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要在 browser context中执行的函数(可以是function，也可以是string，如果是string，则是有返回值的可以执行的 js表达式)
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> Optional waiting parameters
    - polling  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)|[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> An interval at which the  pageFunction  is executed, defaults to  raf. If  polling  is a number, then it is treated as an interval in milliseconds at which the function would be executed. 如果  polling  取值类型是 string, 那么只能是以下两个之一:
        - raf  - 在  requestAnimationFrame  的回调函数中不断地执行  pageFunction。 这是最紧凑的轮询模式，适合于观察样式的变化。
        - mutation  - 当任意 DOM发生变化的时候执行  pageFunction
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>  pageFunction函数执行的最大等待时间(ms)。。默认是  30000  (30 秒)。如果取值为  0，则表示禁用此选项。
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的额外参数。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>> 当  pageFunction函数返回 truthy value (true或者可以转化为 true的值)时，将会resolve。 It resolves to a JSHandle of the truthy value.

下面是一个使用此方法来监控 viewport 尺寸改变的例子：
jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
const  watchDog = page.waitForFunction('window.innerWidth < 100');
await  page.setViewport({width:  50, height:  50});
await  watchDog;
await  browser.close();
});
复制代码

[page.mainFrame().waitForFunction(pageFunction[, options[, ...args]])](https://juejin.im/post/6844903630026326029#framewaitforfunctionpagefunction-options-args)的快捷方法。

#### page.waitForNavigation(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> Navigation 参数，允许存在以下属性:
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> navigation超时时间(ms)，默认是 30 seconds, 取值  0则表示禁用此选项。也可以使用  [page.setDefaultNavigationTimeout(timeout)](https://juejin.im/post/6844903630026326029#pagesetdefaultnavigationtimeouttimeout)  方法来改变默认值。
    - waitUntil  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)|[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> navigation导航成功的界限, 默认是  load. 如果给定的值是一个事件名称组成的数组，那么只有当数组中的所有事件全部被触发后才会认为 navigation成功，可选的事件列表如下:
        - load  - 当  load  事件触发时，则认为 navigation导航结束。
        - domcontentloaded  - 当  DOMContentLoaded  事件触发时，则认为 navigation导航结束。
        - networkidle0  - 如果在  500ms内发起的http请求数为0，则认为导航结束。
        - networkidle2  - 如果在  500ms内发起的http请求数为不超过 2条，则认为导航结束。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Response](https://juejin.im/post/6844903630026326029#class-response)>> Promise which resolves to the main resource response. In case of multiple redirects, the navigation will resolve with the response of the last redirect.

适应于当页面重定向到一个新的url或者reload的场景，例如，当执行了一段可能间接导致页面跳转的代码：
jsconst  navigationPromise = page.waitForNavigation();
await  page.click('a.my-link');  // 点击此链接将会间接导致页面跳转
await  navigationPromise;  // 当页面跳转完毕后，将会 resolve
复制代码

NOTE  使用  [History API](https://developer.mozilla.org/en-US/docs/Web/API/History_API)  方法改变 URL也会被当成是一个 navigation。

#### page.waitForSelector(selector[, options])

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 被等待的元素的选择器[selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 可选参数：
    - visible  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 出现在DOM中的元素必须是可见的(visible)，例如，不能有  display: none  或者  visibility: hidden  CSS 属性。默认是  false。
    - hidden  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 元素不存在于DOM中(包括一开始就不存在，或者存在了又被移除掉)，或者是被隐藏了, 例如， 具有  display: none  或者  visibility: hidden  CSS 属性。默认是  false.
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 最大等待时间(ms)。默认是  30000  (30 秒)。取值为的  0则表示禁用此参数。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>> 当在 DOM中找到  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)指定的元素时，Promise 将会 resolves 这个元素的ElementHandle。

等到  selector选择器选择的元素出现在页面中，如果在调用此方法的同时选择器选取的元素就已经存在于页面中了， 则此方法将会立即返回结果，如果超过了最大等待时间  timeout之后，选择器还没有匹配到元素，则将会抛出错误。

此方法即便是在页面跳转(across navigations)的时候依旧有效：
jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
let  currentURL;
page
.waitForSelector('img')
.then(() =>  console.log('First URL with image: '  + currentURL));

for  (currentURL  of  ['https://example.com',  'https://google.com',  'https://bbc.com'])

await  page.goto(currentURL);
await  browser.close();
});
复制代码

[page.mainFrame().waitForSelector(selector[, options])](https://juejin.im/post/6844903630026326029#framewaitforselectorselector-options)的快捷方法。

#### page.waitForXPath(xpath[, options])

- xpath  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 匹配[xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)的元素
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 可选参数如下：
    - visible  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 出现在DOM中的元素必须是可见的(visible)，例如，不能有  display: none  或者  visibility: hidden  CSS 属性。默认是  false。
    - hidden  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 元素不存在于DOM中(包括一开始就不存在，或者存在了又被移除掉)，或者是被隐藏了, 例如， 具有  display: none  或者  visibility: hidden  CSS 属性。默认是  false.
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 最大等待时间(ms)。默认是  30000  (30 秒)。取值为的  0则表示禁用此参数。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>> 当在 DOM中找到匹配  [xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)的元素时，Promise 将会 resolves 这个元素的ElementHandle。

等到匹配  [xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)的元素出现在页面中，如果在调用此方法的同时匹配  [xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)的元素就已经存在于页面中了， 则此方法将会立即返回结果，如果超过了最大等待时间  timeout之后，还没有出现匹配  [xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)的元素，则将会抛出错误。

此方法即便是在页面跳转(across navigations)的时候依旧有效：
jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
let  currentURL;
page
.waitForXPath('//img')
.then(() =>  console.log('First URL with image: '  + currentURL));

for  (currentURL  of  ['https://example.com',  'https://google.com',  'https://bbc.com'])

await  page.goto(currentURL);
await  browser.close();
});
复制代码

[page.mainFrame().waitForXPath(xpath[, options])](https://juejin.im/post/6844903630026326029#framewaitforxpathxpath-options)的快捷方法。

#### page.workers()

- returns: <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Worker](https://juejin.im/post/6844903630026326029#class-worker)>> 此方法返回当前页面所有的  [WebWorkers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API)。

> NOTE>   > 不包括 ServiceWorkers。

### class: Worker

The Worker class represents a  [WebWorker](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API).  workercreated  和  workerdestroyed事件将会被当做  worker的生命周期，在 page实例中被触发。

jspage.on('workercreated', worker =>  console.log('Worker created: '  + worker.url()));

page.on('workerdestroyed', worker =>  console.log('Worker destroyed: '  + worker.url()));

console.log('Current workers:');
for  (const  worker  of  page.workers())
console.log(' '  + worker.url());
复制代码

#### worker.evaluate(pageFunction, ...args)

- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> worker context中将被执行的函数
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)>> Promise将会 resolve  pageFunction函数的返回值。

如果pageFunction返回的值是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则  worker.evaluate方法将会等到前者  resolve后，才会返回它自己的值。

如果pageFunction返回的值是一个 non-[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)  的值, 则  worker.evaluate  将会 resolves  undefined。

[(await worker.executionContext()).evaluate(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#executioncontextevaluatepagefunction-args)的快捷方法。

#### worker.evaluateHandle(pageFunction, ...args)

- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将在page context中执行的函数。
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction函数的参数。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>> Promise which resolves to the return value of  pageFunction  as in-page object (JSHandle)

worker.evaluate  和  worker.evaluateHandle之间唯一的区别在于，worker.evaluateHandle返回一个 in-page object (JSHandle)

如果pageFunction返回的值是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则  worker.evaluateHandle方法将会等到前者  resolve后，才会返回它自己的值。

[(await worker.executionContext()).evaluateHandle(pageFunction, ...args)](https://juejin.im/post/6844903630026326029#executioncontextevaluatehandlepagefunction-args)的快捷方法。

#### worker.executionContext()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[ExecutionContext](https://juejin.im/post/6844903630026326029#class-executioncontext)>>

#### worker.url()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>

### class: Keyboard

Keyboard提供了一些用于操纵虚拟键盘的api。高级api是[(L)](https://juejin.im/post/6844903630026326029#keyboardtypetext-options)[keyboard.type](https://juejin.im/post/6844903630026326029#keyboardtypetext-options)，此api可自动根据场景整合keydown, keypress/input, 以及 keyup事件。

为了得到更细致的控制，你也可以使用[(L)](https://juejin.im/post/6844903630026326029#keyboarddownkey-options)[keyboard.down](https://juejin.im/post/6844903630026326029#keyboarddownkey-options),  [(L)](https://juejin.im/post/6844903630026326029#keyboardupkey)[keyboard.up](https://juejin.im/post/6844903630026326029#keyboardupkey), and  [(L)](https://juejin.im/post/6844903630026326029#keyboardsendcharacterchar)[keyboard.sendCharacter](https://juejin.im/post/6844903630026326029#keyboardsendcharacterchar)方法来触发相应的键盘事件，以此达到模拟真实体验的目的。

下面是一个按住  Shift键，然后选中并删除一些文本的例子：
jsawait  page.keyboard.type('Hello World!');
await  page.keyboard.press('ArrowLeft');

await  page.keyboard.down('Shift');
for  (let  i =  0; i <  ' World'.length; i++)
await  page.keyboard.press('ArrowLeft');
await  page.keyboard.up('Shift');

await  page.keyboard.press('Backspace');
// 最终得到的文本将是 'Hello!'
复制代码
下面是一个输入 'A 字母的例子：
jsawait  page.keyboard.down('Shift');
await  page.keyboard.press('KeyA');
await  page.keyboard.up('Shift');
复制代码

> NOTE>   > 在MacOS系统上，一些键盘快捷键，例如 全选 的快捷键> ⌘ A> 将不起作用。更多参见>   > [> #1313](https://github.com/GoogleChrome/puppeteer/issues/1313)

#### keyboard.down(key[, options])

- key  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 按下的按键名称, such as  ArrowLeft. 参见  [USKeyboardLayout](https://juejin.im/lib/USKeyboardLayout.js)  获取按键名称列表。
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - text  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 如果指定了此属性值, generates an input event with this text.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

触发  keydown事件。

如果  key值是一个单个字母，并且没有除了  Shift之外的修饰按键被按下，那么将会继续触发  keypress/input事件。可以指定 'text'选项以强制生成输入事件。

如果  key值是一个修饰按键，例如  Shift,  Meta,  Control, 或者  Alt，随后按下的按键将会与前者组合形成组合键，如果想要释放修饰按键，可以使用  [(L)](https://juejin.im/post/6844903630026326029#keyboardupkey)[keyboard.up](https://juejin.im/post/6844903630026326029#keyboardupkey)方法。

After the key is pressed once, subsequent calls to  [(L)](https://juejin.im/post/6844903630026326029#keyboarddownkey-options)[keyboard.down](https://juejin.im/post/6844903630026326029#keyboarddownkey-options)  will have  [repeat](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/repeat)  set to true. To release the key, use  [(L)](https://juejin.im/post/6844903630026326029#keyboardupkey)[keyboard.up](https://juejin.im/post/6844903630026326029#keyboardupkey).

> NOTE>   > 修饰键将会影响>   > keyboard.down> 的效果。如果你按住>   > Shift> 键，然后再按其他的字母键，则你将输入一个大写的字母。

#### keyboard.press(key[, options])

- key  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 需要按下的按键的名称, 例如  ArrowLeft. 更多按键名称列表参见  [USKeyboardLayout](https://juejin.im/lib/USKeyboardLayout.js)  。
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - text  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 如果指定，则将根据  text进行按键操作。
    - delay  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>  keydown  和  keyup  之间的时间间隔(ms). 默认是 0.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

如果  key值是一个单个字母，并且没有除了  Shift之外的修饰按键被按下，那么将会继续触发  keypress/input事件。可以指定 'text'选项以强制生成输入事件。

> NOTE>   > 修饰键将会影响>   > keyboard.press> 的效果。如果你按住>   > Shift> 键，然后再按其他的字母键，则你将输入一个大写的字母。

[(L)](https://juejin.im/post/6844903630026326029#keyboarddownkey-options)[keyboard.down](https://juejin.im/post/6844903630026326029#keyboarddownkey-options)  和  [(L)](https://juejin.im/post/6844903630026326029#keyboardupkey)[keyboard.up](https://juejin.im/post/6844903630026326029#keyboardupkey)的快捷方法。

#### keyboard.sendCharacter(char)

- char  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>向页面中输入的字母
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

触发  keypress  和  input事件，不会触发  keydown  或者  keyup  事件。
jspage.keyboard.sendCharacter('嗨');1
复制代码

> NOTE>   > 修饰键将会影响>   > keyboard.sendCharacter> 的效果。如果你按住>   > Shift> 键，然后再按其他的字母键，则你将输入一个大写的字母。

#### keyboard.type(text, options)

- text  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 需要向聚焦的输入框中输入的文本
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - delay  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 按键按下的时间间隔. 默认是 0.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

输入文本的时候，每个字符都会触发  keydown,  keypress/input, 以及  keyup事件。

如果想要输按下特殊字符，例如Control  以及  ArrowDown，参见[(L)](https://juejin.im/post/6844903630026326029#keyboardpresskey-options)[keyboard.press](https://juejin.im/post/6844903630026326029#keyboardpresskey-options)。

jspage.keyboard.type('Hello');  // 快速输入
page.keyboard.type('World', {delay:  100});  // 模拟真实输入
复制代码

> NOTE>   > 修饰键不会影响>   > keyboard.type> 的效果。也就是说，调用此方法时，就算你已经按住了>   > Shift> 键，也不会将你想要输入的文本全都强制变成大写的。

#### keyboard.up(key)

- key  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 需要释放的按键的名称, 例如  ArrowLeft. 更多按键名称列表参见  [USKeyboardLayout](https://juejin.im/lib/USKeyboardLayout.js)。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

触发  keyup事件。

### class: Mouse

#### mouse.click(x, y, [options])

- x  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>
- y  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - button  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  left,  right, 或者  middle, 默认是  left。（意思是用鼠标的哪个按键进行点击操作，左键、右键或者中键）
    - clickCount  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 点击次数，默认是 1. 参见  [UIEvent.detail](https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail).
    - delay  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>  mousedown  和  mouseup  之间的时间间隔(ms).默认是 0.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

[(L)](https://juejin.im/post/6844903630026326029#mousemovex-y-options)[mouse.move](https://juejin.im/post/6844903630026326029#mousemovex-y-options),  [(L)](https://juejin.im/post/6844903630026326029#mousedownoptions)[mouse.down](https://juejin.im/post/6844903630026326029#mousedownoptions)  以及  [(L)](https://juejin.im/post/6844903630026326029#mouseupoptions)[mouse.up](https://juejin.im/post/6844903630026326029#mouseupoptions)的联合方法。

#### mouse.down([options])

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - button  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  left,  right, 或者  middle, 默认是  left。（意思是用鼠标的哪个按键进行点击操作，左键、右键或者中键）
    - clickCount  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>默认是 1. 参见  [UIEvent.detail](https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail).
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

触发  mousedown事件。

#### mouse.move(x, y, [options])

- x  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>
- y  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - steps  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>默认是 1. Sends intermediate  mousemove  events.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

触发  mousemove事件。

#### mouse.up([options])

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - button  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  left,  right, 或者  middle, 默认是  left。
    - clickCount  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 默认是 1. 参见  [UIEvent.detail](https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail).
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

触发  mouseup事件。

### class: Touchscreen

#### touchscreen.tap(x, y)

- x  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>
- y  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

Dispatches a  touchstart  and  touchend  event.

### class: Tracing

你可以使用  [(L)](https://juejin.im/post/6844903630026326029#tracingstartoptions)[tracing.start](https://juejin.im/post/6844903630026326029#tracingstartoptions)  以及  [(L)](https://juejin.im/post/6844903630026326029#tracingstop)[tracing.stop](https://juejin.im/post/6844903630026326029#tracingstop)来创建一个跟踪文件，此跟踪文件可以被 Chrome DevTools 或者  [timeline viewer](https://chromedevtools.github.io/timeline-viewer/)打开。

jsawait  page.tracing.start({path:  'trace.json'});
await  page.goto('https://www.google.com');
await  page.tracing.stop();
复制代码

#### tracing.start(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - path  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 跟踪文件的存储路径.
    - screenshots  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> captures screenshots in the trace.
    - categories  <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> specify custom categories to use instead of default.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

每个浏览器一次只能执行一个跟踪任务。

#### tracing.stop()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Buffer](https://nodejs.org/api/buffer.html#buffer_class_buffer)>> Promise which resolves to buffer with trace data.

### class: Dialog

[Dialog](https://juejin.im/post/6844903630026326029#class-dialog)  objects are dispatched by page via the  ['dialog'](https://juejin.im/post/6844903630026326029#event-dialog)  event.

下面是一个 使用Dialog  class的例子：
jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
page.on('dialog',  async  dialog => {
console.log(dialog.message());
await  dialog.dismiss();
await  browser.close();
});
page.evaluate(() => alert('1'));
});
复制代码

#### dialog.accept([promptText])

- promptText  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 在提示框中输入的文件内容。。如果dialog的类型不是prompt(提示框)，则此方法将不起任何作用。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> Promise which resolves when the dialog has been accepted.

#### dialog.defaultValue()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 如果 dialog是一个 prompt(提示框)，返回提示框的默认值，否则将返回空字符串。

#### dialog.dismiss()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> 提示框被取消时，Promise 返回resolves 。

#### dialog.message()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> dialog展示的文本。

#### dialog.type()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Dialog的类型, 可以是以下其中之一  alert,  beforeunload,  confirm  or  prompt.

### class: ConsoleMessage

[ConsoleMessage](https://juejin.im/post/6844903630026326029#class-consolemessage)  objects are dispatched by page via the  ['console'](https://juejin.im/post/6844903630026326029#event-console)  event.

#### consoleMessage.args()

- returns: <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>>

#### consoleMessage.text()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>

#### consoleMessage.type()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>

允许以下值:  'log',  'debug',  'info',  'error',  'warning',  'dir',  'dirxml',  'table',  'trace',  'clear',  'startGroup',  'startGroupCollapsed',  'endGroup',  'assert',  'profile',  'profileEnd',  'count',  'timeEnd'。

### class: Frame

无论在哪个时间点，都能够通过[page.mainFrame()](https://juejin.im/post/6844903630026326029#pagemainframe)  和  [frame.childFrames()](https://juejin.im/post/6844903630026326029#framechildframes)方法来获取的页面当前的 frame tree。

[Frame](https://juejin.im/post/6844903630026326029#class-frame)对象的生命周期，由三个事件组成：

- ['frameattached'](https://juejin.im/post/6844903630026326029#event-frameattached)  - 当frame attach到page上时触发。一个 Frame只能 attach到页面上一次。
- ['framenavigated'](https://juejin.im/post/6844903630026326029#event-framenavigated)  - 当Frame重定向到一个新的 URL时触发.
- ['framedetached'](https://juejin.im/post/6844903630026326029#event-framedetached)  - 当Frame从页面上 detach时触发。一个 Frame只能从页面上 detach一次。

An example of dumping frame tree:
jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
await  page.goto('https://www.google.com/chrome/browser/canary.html');
dumpFrameTree(page.mainFrame(),  '');
await  browser.close();

function  dumpFrameTree(frame, indent) {
console.log(indent + frame.url());
for  (let  child  of  frame.childFrames())
dumpFrameTree(child, indent +  ' ');
}
});
复制代码

#### frame.$(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Selector to query page for
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<?[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>> Promise which resolves to ElementHandle pointing to the frame element.

在 frame上搜索元素。如果没有找到所需匹配的元素，则resolve会  null

#### frame.?(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Selector to query page for
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>>> Promise which resolves to ElementHandles pointing to the frame elements.

此方法使用了  document.querySelectorAll，如果没有匹配到任何元素，则resolve回  []

#### frame.?eval(selector, pageFunction[, ...args])

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> frame上目标元素的  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)
- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)> 将在 browser context执行的函数
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的额外参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)>> Promise which resolves to the return value of  pageFunction

此方法使用了  Array.from(document.querySelectorAll(selector))，并将其返回的结果作为  pageFunction函数的第一个参数传递进去。

如果  pageFunction返回的结果是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则  frame.?eval将会等到前者成功resolve，然后再返回自己的值。

Examples:
jsconst  divsCounts =  await  frame.?eval('div', divs => divs.length);
复制代码

#### frame.$eval(selector, pageFunction[, ...args])

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> frame上目标元素的  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)
- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)> 将在 browser context执行的函数
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的额外参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)>> Promise which resolves to the return value of  pageFunction

此方法使用了  document.querySelector，并将其返回的结果作为  pageFunction函数的第一个参数传递进去。如果没有匹配到任何元素，则将抛出错误。

如果  pageFunction返回的结果是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则  frame.$eval将会等到前者成功resolve，然后再返回自己的值。

例子:
jsconst  searchValue =  await  frame.$eval('#search', el => el.value);
const  preloadHref =  await  frame.$eval('link[rel=preload]', el => el.href);
const  html =  await  frame.$eval('.main-container', e => e.outerHTML);
复制代码

#### frame.$x(expression)

- expression  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Expression to  [evaluate](https://developer.mozilla.org/en-US/docs/Web/API/Document/evaluate).
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>>>

此方法用于执行给定的 XPath 表达式。

#### frame.addScriptTag(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 需要被增加的script标签的url
    - path  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被添加的JavaScript文件的路径. 如果  path  是相对路径, 则其是相对于  [current working directory](https://nodejs.org/api/process.html#process_process_cwd)。
    - content  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被添加的 JavaScript脚本的内容。
    - type  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 脚本类型. 如果是 'module' ，则将导入的是JS的 ES6模块。更多参见 [script]
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>> 当script脚本加载完毕，或者脚本内容已经注入到frame上时，将会返回所添加的script标签元素。

向frame中增加指定 url或者 脚本内容的  script标签。

#### frame.addStyleTag(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被添加的 style 的url
    - path  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>将要被添加的 CSS文件的路径. 如果  path  是相对路径, 则其是相对于  [current working directory](https://nodejs.org/api/process.html#process_process_cwd)。
    - content  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被添加的CSS脚本的内容。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>> 当style加载完毕，或者style内容已经注入到frame上时，将会返回所添加的style标签元素。

向页面中添加一个 带有指定 url的<link rel="stylesheet">标签，或者一个带有内容的<style type="text/css">标签。

#### frame.childFrames()

- returns: <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Frame](https://juejin.im/post/6844903630026326029#class-frame)>>

#### frame.click(selector[, options])

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被点击的元素的 选择器。如果选择器匹配出了多个元素，则点击事件只会作用在第一个匹配的元素上。
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - button  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  left,  right, or  middle, 默认是  left（即使用左键、右键还是中键进行点击操作）
    - clickCount  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 默认点击一次。 更多参见[UIEvent.detail](https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail)。
    - delay  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>  mousedown  和  mouseup  事件之间的时间间隔. 默认为 0.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> 当匹配的元素被成功点击时将会resolve，如果没有匹配到元素，则将 reject。

此方法将会根据给定的选择器匹配到元素，如果所匹配到的元素不在视界内，将会将其滚动到视界内，然后使用  [page.mouse](https://juejin.im/post/6844903630026326029#pagemouse)方法点击匹配到的元素的中心位置。 如果没有匹配到元素，则将抛出一个错误。

需要注意的是，如果所点击的元素会触发页面跳转，并且还调用了page.waitForNavigation()方法，那么你可能不会得到期望的结果，正确的做法如下：
javascriptconst  [response] =  await  Promise.all([
page.waitForNavigation(waitOptions),
frame.click(selector, clickOptions),
]);
复制代码

#### frame.content()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[String](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>>

获取frame包括doctype在内的完整HTML内容

#### frame.evaluate(pageFunction, ...args)

- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将在 browser context中执行的函数
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)>> Promise which resolves to the return value of  pageFunction

如果传递给  frame.evaluate的  pageFunction函数返回一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则frame.evaluate将会等待得到resolve后，才会返回它自己的值。

如果传递给  frame.evaluate的  pageFunction函数返回一个 non-[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)的值，则page.evaluate将会返回  undefined。

jsconst  result =  await  frame.evaluate(() => {
return  Promise.resolve(8  *  7);
});
console.log(result);  // prints "56"
复制代码
可以传递一个字符串作为  pageFunction：
jsconsole.log(await  frame.evaluate('1 + 2'));  // prints "3"
复制代码

可以传递一个[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)  作为  pageFunction参数：

jsconst  bodyHandle =  await  frame.$('body');
const  html =  await  frame.evaluate(body => body.innerHTML, bodyHandle);
await  bodyHandle.dispose();
复制代码

#### frame.evaluateHandle(pageFunction, ...args)

- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 在page context 中执行的函数。
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>> Promise which resolves to the return value of  pageFunction  as in-page object (JSHandle)

frame.evaluate  和  paframege.evaluateHandle之间唯一的差别是，frame.evaluateHandle返回的结果是 in-page object (JSHandle)。 (可能指的是此方法只返回页面元素的句柄，即此方法可以看作一个元素选择器)

如果传入  frame.evaluateHandle的函数 返回的值是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则frame.evaluateHandle将会等待这个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)到达resolve时才会返回自己的值。

jsconst  aWindowHandle =  await  frame.evaluateHandle(() =>  Promise.resolve(window));

aWindowHandle;  // window对象的handle.
复制代码
可以传递一个 字符串作为  pageFunction：

jsconst  aHandle =  await  frame.evaluateHandle('document');  // Handle for the 'document'.

复制代码

[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)  instances也可以作为frame.evaluateHandle的传入参数：

jsconst  aHandle =  await  frame.evaluateHandle(() =>  document.body);

const  resultHandle =  await  frame.evaluateHandle(body => body.innerHTML, aHandle);

console.log(await  resultHandle.jsonValue());
await  resultHandle.dispose();
复制代码

#### frame.executionContext()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[ExecutionContext](https://juejin.im/post/6844903630026326029#class-executioncontext)>> 与当前frame 关联的执行上下文。

#### frame.focus(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 需要focus的元素的选择器。 如果此选择器匹配到了多个元素，则只有第一个匹配的元素才会被focus。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> 当成功匹配到元素后，[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)将resolve。如果没有匹配到任何元素，则将reject。

此方法将 focus给定 selector匹配到的元素。 如果根据给定的 selector没有匹配到任何元素，将会抛出异常。

#### frame.hover(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 需要 hover的元素的选择器。 如果此选择器匹配到了多个元素，则只有第一个匹配的元素才会被hover。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> 当成功匹配到元素后，[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)将resolve。如果没有匹配到任何元素，则将reject。

此方法将会根据给定的选择器匹配到元素，如果所匹配到的元素不在视界内，将会将其滚动到视界内，然后使用  [page.mouse](https://juejin.im/post/6844903630026326029#pagemouse)方法 hover匹配到的元素的中心位置。 如果没有匹配到元素，则将抛出一个错误。

#### frame.isDetached()

- returns: <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>

如果 frame已经detached了，则返回  true， 否则返回  false

#### [frame.name](http://frame.name/)()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>

返回 frame的name属性值。
如果name属性不存在或者为空字符串，则返回 id属性的值，如果 id属性也不存在或者为空字符串，则返回空字符串。
> NOTE>   > 此方法的返回值只会在frame被创建后计算一次，如果稍后frame的相关属性(name或者id)发生变化，此方法的返回值也不会改变。

#### frame.parentFrame()

- returns: <?[Frame](https://juejin.im/post/6844903630026326029#class-frame)> 如果存在父级 frame，则返回父级 frame, 对已经 detach的frame或者 main frame使用此方法将会返回  null。

#### frame.select(selector, ...values)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> [select]标签的选择器
- ...values  <...[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 选择的值。如果  <select>  标签具有  multiple  属性, 所有的指定值都是有效值, 否则只会考虑第一个值。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>>> 返回一个由所有成功选中(selected)的选项(option)的值组成的数组。

当所有提供的  values值的选项(option)全被选中后会触发  change  以及  input事件。 如果根据所指定的选择器selector没有匹配到一个  <select>元素，将会抛出错误。 (这个方法就是用于控制 select的选择)

jsframe.select('select#colors',  'blue');  // 单选
frame.select('select#colors',  'red',  'green',  'blue');  // 多选
复制代码

#### frame.setContent(html)

- html  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 设置 page页面的HTML内容。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

#### frame.tap(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要被tap的元素的 选择器。如果选择器匹配出了多个元素，则tap事件只会作用在第一个匹配的元素上。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

此方法将会根据给定的选择器匹配到元素，如果所匹配到的元素不在视界内，将会将其滚动到视界内，然后使用  [page.touchscreen](https://juejin.im/post/6844903630026326029#pagetouchscreen)方法tap匹配到的元素的中心位置。 如果没有匹配到元素，则将抛出一个错误。

#### frame.title()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> 返回页面的title。

#### frame.type(selector, text[, options])

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 文本框(包括 texarea和input)的选择器。如果选择器匹配出了多个元素，则只会选择第一个匹配的元素上。
- text  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要输入到文本框内的文字。
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - delay  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 按键输入的间隔速度，单位为ms。默认为 0.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

Sends a  keydown,  keypress/input, and  keyup  event for each character in the text.

为了按下一些特殊按键，例如  Control  或  ArrowDown，请使用[(L)](https://juejin.im/post/6844903630026326029#keyboardpresskey-options)[keyboard.press](https://juejin.im/post/6844903630026326029#keyboardpresskey-options)。

jsframe.type('#mytextarea',  'Hello');  // 快速输入
frame.type('#mytextarea',  'World', {delay:  100});  // 减缓输入速度以模拟真实输入
复制代码

#### frame.url()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>

返回 frame的url

#### frame.waitFor(selectorOrFunctionOrTimeout[, options[, ...args]])

- selectorOrFunctionOrTimeout  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)|[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)|[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)> A  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors), predicate or timeout to wait for
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> Optional waiting parameters
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>  pageFunction的参数。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>> Promise which resolves to a JSHandle of the success value

根据第一个参数的不同，此方法可实现的场景如下：

- 如果  selectorOrFunctionOrTimeout是一个  string, 那么它如果是以 '//'开头, 就是[xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)，否则就是  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)，此方法是  [frame.waitForSelector](https://juejin.im/post/6844903630026326029#framewaitforselectorselector-options)  或者  [frame.waitForXPath](https://juejin.im/post/6844903630026326029#framewaitforxpathxpath-options)方法的快捷方法。
- 如果  selectorOrFunctionOrTimeout  是一个  function, then the first argument is treated as a predicate to wait for and the method is a shortcut for  [frame.waitForFunction()](https://juejin.im/post/6844903630026326029#framewaitforfunctionpagefunction-options-args).
- 如果  selectorOrFunctionOrTimeout  是一个  number, 那么它就会被当做是等待时间(ms)，超过等到时间后将会resolve。
- 如果不是以上三种情况中的任何一个，那么将会抛出错误。

#### frame.waitForFunction(pageFunction[, options[, ...args]])

- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要在 browser context中执行的函数(可以是function，也可以是string，如果是string，则是有返回值的可以执行的 js表达式)
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> Optional waiting parameters
    - polling  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)|[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> An interval at which the  pageFunction  is executed, defaults to  raf. If  polling  is a number, then it is treated as an interval in milliseconds at which the function would be executed. 如果  polling  取值类型是 string, 那么只能是以下两个之一:
        - raf  - 在  requestAnimationFrame  的回调函数中不断地执行  pageFunction。 这是最紧凑的轮询模式，适合于观察样式的变化。
        - mutation  - 当任意 DOM发生变化的时候执行
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 函数执行的最大等待时间(ms)。。默认是  30000  (30 秒)。如果取值为  0，则表示禁用此选项。
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的额外参数。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>> Promise which resolves when the  pageFunction  returns a truthy value. It resolves to a JSHandle of the truthy value.

下面是一个使用此方法来监控 viewport 尺寸改变的例子：
jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
const  watchDog = page.mainFrame().waitForFunction('window.innerWidth < 100');
page.setViewport({width:  50, height:  50});
await  watchDog;
await  browser.close();
});
复制代码

#### frame.waitForSelector(selector[, options])

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 被等待的元素的选择器[selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 可选参数
    - visible  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 出现在DOM中的元素必须是可见的(visible)，例如，不能有  display: none  或者  visibility: hidden  CSS 属性。默认是  false。
    - hidden  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 元素不存在于DOM中(包括一开始就不存在，或者存在了又被移除掉)，或者是被隐藏了, 例如， 具有  display: none  或者  visibility: hidden  CSS 属性。默认是  false.
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 最大等待时间(ms)。默认是  30000  (30 秒)。取值为的  0则表示禁用此参数。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>> 当在 DOM中找到  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)指定的元素时，Promise 将会 resolves 这个元素的ElementHandle。

等到  selector选择器选择的元素出现在页面中，如果在调用此方法的同时选择器选取的元素就已经存在于页面中了， 则此方法将会立即返回结果，如果超过了最大等待时间  timeout之后，选择器还没有匹配到元素，则将会抛出错误。

此方法即便是在页面跳转(across navigations)的时候依旧有效：
jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
let  currentURL;
page.mainFrame()
.waitForSelector('img')
.then(() =>  console.log('First URL with image: '  + currentURL));

for  (currentURL  of  ['https://example.com',  'https://google.com',  'https://bbc.com'])

await  page.goto(currentURL);
await  browser.close();
});
复制代码

#### frame.waitForXPath(xpath[, options])

- xpath  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 匹配[xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)的元素
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 可选参数如下：
    - visible  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 出现在DOM中的元素必须是可见的(visible)，例如，不能有  display: none  或者  visibility: hidden  CSS 属性。默认是  false。
    - hidden  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> 元素不存在于DOM中(包括一开始就不存在，或者存在了又被移除掉)，或者是被隐藏了, 例如， 具有  display: none  或者  visibility: hidden  CSS 属性。默认是  false.
    - timeout  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 最大等待时间(ms)。默认是  30000  (30 秒)。取值为的  0则表示禁用此参数。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>> 当在 DOM中找到匹配  [xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)的元素时，Promise 将会 resolves 这个元素的ElementHandle。

等到匹配  [xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)的元素出现在页面中，如果在调用此方法的同时匹配  [xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)的元素就已经存在于页面中了， 则此方法将会立即返回结果，如果超过了最大等待时间  timeout之后，还没有出现匹配  [xpath](https://developer.mozilla.org/en-US/docs/Web/XPath)的元素，则将会抛出错误。

此方法即便是在页面跳转(across navigations)的时候依旧有效：
jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
let  currentURL;
page.mainFrame()
.waitForXPath('//img')
.then(() =>  console.log('First URL with image: '  + currentURL));

for  (currentURL  of  ['https://example.com',  'https://google.com',  'https://bbc.com'])

await  page.goto(currentURL);
await  browser.close();
});
复制代码

### class: ExecutionContext

The class represents a context for JavaScript execution. Examples of JavaScript contexts are:

- 每个  [frame](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe)  都有一个独立的JS执行上下文
- 所有类型的  [workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API)  都有它们自己的上下文

#### executionContext.evaluate(pageFunction, ...args)

- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 在  executionContext中执行的函数
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)>> Promise 将会resolve回  pageFunction函数的结果。

如果pageFunction函数的返回值是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则executionContext.evaluate将会等到前者resolve后才会返回它自己的值。

jsconst  executionContext =  await  page.mainFrame().executionContext();

const  result =  await  executionContext.evaluate(() =>  Promise.resolve(8  *  7));

console.log(result);  // prints "56"
复制代码
字符串也可以被当做pageFunction：
jsconsole.log(await  executionContext.evaluate('1 + 2'));  // prints "3"
复制代码

[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)  instances 可以被当做  ...args

jsconst  oneHandle =  await  executionContext.evaluateHandle(() =>  1);
const  twoHandle =  await  executionContext.evaluateHandle(() =>  2);

const  result =  await  executionContext.evaluate((a, b) => a + b, oneHandle, twoHandle);

await  oneHandle.dispose();
await  twoHandle.dispose();
console.log(result);  // prints '3'.
复制代码

#### executionContext.evaluateHandle(pageFunction, ...args)

- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将在executionContext中执行的函数
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction函数的参数。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>> Promise which resolves to the return value of  pageFunction  as in-page object (JSHandle)

executionContext.evaluate  和  executionContext.evaluateHandle之间唯一的区别在于，worker.evaluateHandle返回一个 in-page object (JSHandle)

如果pageFunction返回的值是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则  executionContext.evaluateHandle方法将会等到前者  resolve后，才会返回它自己的值。

jsconst  context =  await  page.mainFrame().executionContext();
const  aHandle =  await  context.evaluateHandle(() =>  Promise.resolve(self));
aHandle;  // Handle for the global object.
复制代码
字符串也可以被当做pageFunction：

jsconst  aHandle =  await  context.evaluateHandle('1 + 2');  // Handle for the '3' object.

复制代码

[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)  instances 可以被当做  ...args

jsconst  aHandle =  await  context.evaluateHandle(() =>  document.body);

const  resultHandle =  await  context.evaluateHandle(body => body.innerHTML, aHandle);

console.log(await  resultHandle.jsonValue());  // prints body's innerHTML
await  aHandle.dispose();
await  resultHandle.dispose();
复制代码

#### executionContext.frame()

- returns: <?[Frame](https://juejin.im/post/6844903630026326029#class-frame)> Frame associated with this execution context.

> NOTE>   > 并不是每一个 execution context都存在一个frame。例如, workers 以及 extensions 都存在 execution context，但是没有 frame。

#### executionContext.queryObjects(prototypeHandle)

- prototypeHandle  <[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> A handle to the object prototype.
- returns: <[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> A handle to an array of objects with this prototype

此方法迭代(iterates)遍历 JavaScript堆栈，获取给定 prototype下所有 object组成的数组。
js// Create a Map object
await  page.evaluate(() =>  window.map =  new  Map());
// Get a handle to the Map object prototype
const  mapPrototype =  await  page.evaluateHandle(() =>  Map.prototype);
// Query all map instances into an array
const  mapInstances =  await  page.queryObjects(mapPrototype);
// Count amount of map objects in heap
const  count =  await  page.evaluate(maps => maps.length, mapInstances);
await  mapInstances.dispose();
await  mapPrototype.dispose();
复制代码

### class: JSHandle

JSHandle represents an in-page JavaScript object. JSHandles 可以通过  [page.evaluateHandle](https://juejin.im/post/6844903630026326029#pageevaluatehandlepagefunction-args)  方法来创建。

jsconst  windowHandle =  await  page.evaluateHandle(() =>  window);
// ...
复制代码

JSHandle能够防止被引用的 JavaScript object 被垃圾回收机制给回收掉，除非 the handle被主动  [disposed](https://juejin.im/post/6844903630026326029#jshandledispose)。JSHandles能够在源frame重定向或者父级上下文被销毁的时候，自动释放(auto-disposed)。

JSHandle instances 可以作为  [(L)](https://juejin.im/post/6844903630026326029#pageevalselector-pagefunction-args)[page.$eval()](https://juejin.im/post/6844903630026326029#pageevalselector-pagefunction-args),  [(L)](https://juejin.im/post/6844903630026326029#pageevaluatepagefunction-args)[page.evaluate()](https://juejin.im/post/6844903630026326029#pageevaluatepagefunction-args)  以及  [(L)](https://juejin.im/post/6844903630026326029#pageevaluatehandlepagefunction-args)[page.evaluateHandle](https://juejin.im/post/6844903630026326029#pageevaluatehandlepagefunction-args)  方法的参数。

#### jsHandle.asElement()

- returns: <?[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>

如果当前 object handle是[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)的实例，则将返回object handle本身，否则返回  null

#### jsHandle.dispose()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> 当 object handle成功释放(dispose)后，Promise将 resolve。

此方法用于断开element handle的引用

#### jsHandle.executionContext()

- returns:  [ExecutionContext](https://juejin.im/post/6844903630026326029#class-executioncontext)

返回 handle所在的执行上下文。

#### jsHandle.getProperties()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Map](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type),  [JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>>>

此方法返回一个由属性名称作为key和 JSHandle instances作为value组成的 map对象
jsconst  handle =  await  page.evaluateHandle(() => ({window,  document}));
const  properties =  await  handle.getProperties();
const  windowHandle = properties.get('window');
const  documentHandle = properties.get('document');
await  handle.dispose();
复制代码

#### jsHandle.getProperty(propertyName)

- propertyName  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> property to get
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>>

从引用的object中获取给定  propertyName对应的 property。

#### jsHandle.jsonValue()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>>

返回 object的 json。如果 object具有[(L)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#toJSON()_behavior)[toJSON](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#toJSON()_behavior)函数方法，也不会调用此函数方法. Returns a JSON representation of the object. If the object has a

> NOTE>   > 如果引用的object无法字符串化，则此方法将返回空 JSON对象。如果引用的object存在循环引用，则将抛出错误。

### class: ElementHandle

> NOTE>   > Class>   > [> ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>   > extends>   > [> JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> .

ElementHandle represents an in-page DOM element. ElementHandles 可以通过 the  [page.$](https://juejin.im/post/6844903630026326029#pageselector)  方法创建。

jsconst  puppeteer =  require('puppeteer');

puppeteer.launch().then(async  browser => {
const  page =  await  browser.newPage();
await  page.goto('https://google.com');
const  inputElement =  await  page.$('input[type=submit]');
await  inputElement.click();
// ...
});
复制代码

ElementHandle 能够防止被引用的 DOM element 被垃圾回收机制给回收掉，除非 the handle被主动  [disposed](https://juejin.im/post/6844903630026326029#elementhandledispose)。ElementHandles 能够在源frame重定向的时候，自动释放(auto-disposed)。

ElementHandle instances 可以作为  [(L)](https://juejin.im/post/6844903630026326029#pageevalselector-pagefunction-args)[page.$eval()](https://juejin.im/post/6844903630026326029#pageevalselector-pagefunction-args),  [(L)](https://juejin.im/post/6844903630026326029#pageevaluatepagefunction-args)[page.evaluate()](https://juejin.im/post/6844903630026326029#pageevaluatepagefunction-args)  以及  [(L)](https://juejin.im/post/6844903630026326029#pageevaluatehandlepagefunction-args)[page.evaluate](https://juejin.im/post/6844903630026326029#pageevaluatehandlepagefunction-args)  方法的参数。

#### elementHandle.$(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 目标元素的  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<?[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>>

此方法将在页面上使用element.querySelector，如果没有匹配到任何元素，则将resolve 回null

#### elementHandle.?(selector)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 目标元素的  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>>>

此方法将在页面上使用element.querySelectorAll，如果没有匹配到任何元素，则将resolve 回[]

#### elementHandle.?eval(selector, pageFunction, ...args)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 目标元素的  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)
- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)> 将在 browser context中执行的函数
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)>> Promise 将resolve回  pageFunction函数的返回值。

此方法将在element上使用element.querySelectorAll，并且将结果作为pageFunction的第一个参数传入，如果没有匹配到任何元素，则抛出错误。

如果  pageFunction返回的值是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则  elementHandle.?eval将等到前者 resolve回结果后，才返回它自己的值。

例子:
html<div  class="feed">
<div  class="tweet">Hello!</div>
<div  class="tweet">Hi!</div>
</div>
复制代码
jsconst  feedHandle =  await  page.$('.feed');

expect(await  feedHandle.?eval('.tweet', nodes => nodes.map(n => n.innerText)).toEqual(['Hello!',  'Hi!']);

复制代码

#### elementHandle.$eval(selector, pageFunction, ...args)

- selector  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 目标元素的  [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)
- pageFunction  <[function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)> 将在 browser context中执行的函数
- ...args  <...[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)|[JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)> 传递给  pageFunction的参数
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Serializable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify#Description)>> Promise 将resolve回  pageFunction函数的返回值。

此方法将在 element上使用document.querySelector，并且将结果作为pageFunction的第一个参数传入，如果没有匹配到任何元素，则抛出错误。

如果  pageFunction返回的值是一个  [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)，则  elementHandle.$eval将等到前者 resolve回结果后，才返回它自己的值。

Examples:
jsconst  tweetHandle =  await  page.$('.tweet');
expect(await  tweetHandle.$eval('.like', node => node.innerText)).toBe('100');

expect(await  tweetHandle.$eval('.retweets', node => node.innerText)).toBe('10');

复制代码

#### elementHandle.$x(expression)

- expression  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Expression to  [evaluate](https://developer.mozilla.org/en-US/docs/Web/API/Document/evaluate).
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[ElementHandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>>>

The method evaluates the XPath expression relative to the elementHandle. If there are no such elements, the method will resolve to an empty array.

#### elementHandle.asElement()

- returns: <[elementhandle](https://juejin.im/post/6844903630026326029#class-elementhandle)>

#### elementHandle.boundingBox()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<?[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>>
    - x <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> element 的 x坐标, 单位是px.
    - y <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> element 的 y坐标, 单位是px.
    - width <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> element 的宽度, 单位是px.
    - height <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> element 的高度, 单位是px.

此方法返回 element 的 bounding box(即坐标和长、宽信息，坐标是相对于main frame的)，如果element不可见(not visible)，则返回  null

#### elementHandle.boxModel()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<?[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>>
    - content <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>> Content box, represented as an array of {x, y} points.
    - padding <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>> Padding box, represented as an array of {x, y} points.
    - border <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>> Border box, represented as an array of {x, y} points.
    - margin <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>> Margin box, represented as an array of {x, y} points.
    - width <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Element's width.
    - height <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> Element's height.

此方法返回element的盒模型信息，如果element不可见(not visible)，则返回  null  Boxes are represented as an array of points; each Point is an object  {x, y}. Box points are sorted clock-wise.

#### elementHandle.click([options])

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - button  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>  left,  right, 或者  middle, 默认是  left。（意思是用鼠标的哪个按键进行点击操作，左键、右键或者中键）
    - clickCount  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 点击次数，默认是 1. 参见  [UIEvent.detail](https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail).
    - delay  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>  mousedown  和  mouseup  之间的时间间隔(ms).默认是 0.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> Promise which resolves when the element is successfully clicked. Promise gets rejected if the element is detached from DOM.

此方法将会根据给定的选择器匹配到元素，如果所匹配到的元素不在视界内，将会将其滚动到视界内，然后使用  [page.mouse](https://juejin.im/post/6844903630026326029#pagemouse)方法点击匹配到的元素的中心位置。 如果element 已经从DOM上 detach掉了，则将抛出一个错误。

#### elementHandle.contentFrame()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<?[Frame](https://juejin.im/post/6844903630026326029#class-frame)>> Resolves to the content frame for element handles referencing iframe nodes, or null otherwise

#### elementHandle.dispose()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> Promise which resolves when the element handle is successfully disposed.

此方法断开 element handle的引用

#### elementHandle.executionContext()

- returns:  [ExecutionContext](https://juejin.im/post/6844903630026326029#class-executioncontext)

#### elementHandle.focus()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

调用 element的[focus](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/focus)  方法。

#### elementHandle.getProperties()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Map](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type),  [JSHandle](https://juejin.im/post/6844903630026326029#class-jshandle)>>>

此方法返回一个由属性名称作为key和 JSHandle instances作为value组成的 map对象

jsconst  listHandle =  await  page.evaluateHandle(() =>  document.body.children);

const  properties =  await  listHandle.getProperties();
const  children = [];
for  (const  property  of  properties.values()) {
const  element = property.asElement();
if  (element)
children.push(element);
}
children;  // holds elementHandles to all children of document.body
复制代码

#### elementHandle.press(key[, options])

- key  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 需要按下的按键的名称, 例如  ArrowLeft. 更多按键名称列表参见  [USKeyboardLayout](https://juejin.im/lib/USKeyboardLayout.js)。
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - text  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> If specified, generates an input event with this text.
    - delay  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>  keydown  和  keyup  之间的时间间隔(ms). 默认是 0.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

聚焦在 element上，然后使用  [(L)](https://juejin.im/post/6844903630026326029#keyboarddownkey-options)[keyboard.down](https://juejin.im/post/6844903630026326029#keyboarddownkey-options)  以及  [(L)](https://juejin.im/post/6844903630026326029#keyboardupkey)[keyboard.up](https://juejin.im/post/6844903630026326029#keyboardupkey)方法。

如果  key值是一个单个字母，并且没有除了  Shift之外的修饰按键被按下，那么将会继续触发  keypress/input事件。可以指定 'text'选项以强制生成输入事件。

> NOTE>   > 修饰键将会影响>   > elementHandle.press> 的效果。如果你按住>   > Shift> 键，然后再按其他的字母键，则你将输入一个大写的字母。

#### elementHandle.screenshot([options])

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 参数和  [page.screenshot](https://juejin.im/post/6844903630026326029#pagescreenshotoptions)方法的参数类似。
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Buffer](https://nodejs.org/api/buffer.html#buffer_class_buffer)>> Promise将会resolve截屏图片的 buffer。

此方法将会在需要的时候将元素滚动到可视区域内，然后使用  [page.screenshot](https://juejin.im/post/6844903630026326029#pagescreenshotoptions)方法来对 element进行截图操作。 如果 element 已经从DOM上 detach掉了，则此方法将抛出错误。

#### elementHandle.tap()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> 如果成功在element上执行了 tap操作，则 Promise将会resolve。如果 element 已经从DOM上 detach掉了，则 Promise将会reject。

此方法将会在需要的时候将元素滚动到可视区域内，然后使用  [touchscreen.tap](https://juejin.im/post/6844903630026326029#touchscreentapx-y)来 tap element的中间位置。 如果 element 已经从DOM上 detach掉了，则将抛出错误。

#### elementHandle.toString()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>

#### elementHandle.type(text[, options])

- text  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 将要在聚焦元素内输入的文本内容
- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>
    - delay  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 输入字符间的时间间隔。 默认是 0.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

聚焦element，然后为每个输入的字符触发  keydown,  keypress/input, 以及  keyup事件。

为了press一些特殊字符，例如  Control  或者  ArrowDown，请使用  [(L)](https://juejin.im/post/6844903630026326029#elementhandlepresskey-options)[elementHandle.press](https://juejin.im/post/6844903630026326029#elementhandlepresskey-options)方法。

jselementHandle.type('Hello');  // 快速输入
elementHandle.type('World', {delay:  100});  // 输入速度减慢以模拟真实输入
复制代码
下面是一个输入文本并提交表单的例子：
jsconst  elementHandle =  await  page.$('input');
await  elementHandle.type('some text');
await  elementHandle.press('Enter');
复制代码

#### elementHandle.uploadFile(...filePaths)

- ...filePaths  <...[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Sets the value of the file input these paths. If some of the  filePaths  are relative paths, then they are resolved relative to  [current working directory](https://nodejs.org/api/process.html#process_process_cwd).
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

This method expects  elementHandle  to point to an  [input element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input).

### class: Request

当页面发起请求的时候，例如请求网络资源，下面这些事件都将会被触发：

- ['request'](https://juejin.im/post/6844903630026326029#event-request)  当页面发起请求时触发。
- ['response'](https://juejin.im/post/6844903630026326029#event-response)  当请求收到响应的时候触发。
- ['requestfinished'](https://juejin.im/post/6844903630026326029#event-requestfinished)  当响应内容完全接受并且请求结束的时候触发。

如果请求动作在某个地方失败，那么  requestfinished(也可能是  response)事件会被  ['requestfailed'](https://juejin.im/post/6844903630026326029#event-requestfailed)所替代。

如果收到了重定向的响应指令，则当前请求结束，并触发  requestfinished事件，然后会发起一个对新链接的获取请求。

#### request.abort([errorCode])

- errorCode  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 可选的错误码. 默认是  failed, 允许以下值:
    - aborted  - 某个操作 aborted (来源于 user)
    - accessdenied  - 访问除网络之外的资源的权限被拒绝
    - addressunreachable  - The IP address is unreachable. 这通常意味着没有路由到指定的主机或网络。
    - connectionaborted  - 由于没有收到发送的数据的ACK，导致连接超时
    - connectionclosed  - 连接被关闭 (corresponding to a TCP FIN).
    - connectionfailed  - 连接请求失败.
    - connectionrefused  - 连接请求被拒绝.
    - connectionreset  - 连接请求被重置 (reset) (corresponding to a TCP RST).
    - internetdisconnected  - 网络连接丢失（也就是没有网络了）
    - namenotresolved  - 无法解析主机名。
    - timedout  - 操作超时.
    - failed  - 一个通用的故障发生
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

Aborts request. To use this, 应确保请求拦截可用，使用  page.setRequestInterception来设置。
如果未启用请求拦截，则将立即抛出异常。

#### request.continue([overrides])

- overrides  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> Optional request overwrites, which can be one of the following:
    - url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 如果设置此属性值，则请求url将会被重置。
    - method  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 如果设置此属性值，则请求方式将会被重置。 (例如  GET  or  POST)
    - postData  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 如果设置此属性值，则post body将会被重置
    - headers  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 如果设置此属性值，则 HTTP headers将会被重置
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

拦截并改变请求参数。为了确保此方法可用，请使用  page.setRequestInterception方法来保证请求拦截处于可用状态(enable)。
如果未启用请求拦截，则将立即抛出异常。

#### request.failure()

- returns: <?[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 请求失败的原因（如果有的话）
    - errorText  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Human-readable error message, e.g.  'net::ERR_FAILED'.

如果请求失败，则此方法返回请求失败的原因（如果有的话），并且触发  requestfailed事件，如果请求成功，则此方法返回  null，
下面是一个记录所有请求失败的例子：
jspage.on('requestfailed', request => {
console.log(request.url() +  ' '  + request.failure().errorText);
});
复制代码

#### request.frame()

- returns: <?[Frame](https://juejin.im/post/6844903630026326029#class-frame)> A matching  [Frame](https://juejin.im/post/6844903630026326029#class-frame)  object, or  null  if navigating to error pages.

#### request.headers()

- returns: <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> An object with HTTP headers associated with the request. All header names are lower-case.

#### request.isNavigationRequest()

- returns: <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>

当前请求是否是一个 navigation的请求（即，当前请求是否会触发页面跳转或reload事件。）

#### request.method()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 请求方式 (例如，GET, POST等)

#### request.postData()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Request's post body, if any.

#### request.redirectChain()

- returns: <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Request](https://juejin.im/post/6844903630026326029#class-request)>>

A  redirectChain  is a chain of requests initiated to fetch a resource.

- 如果没有重定向，并且请求成功，则返回 空数组  []。
- If a server responds with at least a single redirect, then the chain will contain all the requests that were redirected.

redirectChain  is shared between all the requests of the same chain.

例如，如果  http://example.com有一个重定向到  https://example.com的动作，则  redirectChain将包含一个请求：

jsconst  response =  await  page.goto('http://example.com');
const  chain = response.request().redirectChain();
console.log(chain.length);  // 1
console.log(chain[0].url());  // 'http://example.com'
复制代码
如果https://google.com网站没有重定向的动作，则  redirectChain将会是空数组：
jsconst  response =  await  page.goto('https://google.com');
const  chain = response.request().redirectChain();
console.log(chain.length);  // 0
复制代码

#### request.resourceType()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>

包含所有被渲染引擎使用到的请求资源的类型，允许以下几种：  document,  stylesheet,  image,  media,  font,  script,  texttrack,  xhr,  fetch,  eventsource,  websocket,  manifest,  other.

#### request.respond(response)

- response  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 请求对应的响应对象
    - status  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> 响应状态安, 默认是  200。
    - headers  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> 可选的响应头
    - contentType  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 如果设置了此属性值,则相当于是 设置响应头的  Content-Type
    - body  <[Buffer](https://nodejs.org/api/buffer.html#buffer_class_buffer)|[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 可选的 response body
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

用给定的响应来完成请求。 为了使此功能有效可用, 请设置  page.setRequestInterception，以确保请求拦截可用。如果请求拦截不可用，则将抛出错误。

下面是一个给请求响应 404状态的例子：
jsawait  page.setRequestInterception(true);
page.on('request', request => {
request.respond({
status:  404,
contentType:  'text/plain',
body:  'Not Found!'
});
});
复制代码

> NOTE>   > 不支持对 dataURL请求的模拟响应。 对一个 dataURL请求使用>   > request.respond>   > 将不会产生任何效果。

#### request.response()

- returns: <?[Response](https://juejin.im/post/6844903630026326029#class-response)> 一个 matching  [Response](https://juejin.im/post/6844903630026326029#class-response)  object, 如果还没有收到响应，则返回  null

#### request.url()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> URL of the request.

### class: Response

[Response](https://juejin.im/post/6844903630026326029#class-response)  class represents responses which are received by page.

#### response.buffer()

- returns: <Promise<[Buffer](https://nodejs.org/api/buffer.html#buffer_class_buffer)>> Promise which resolves to a buffer with response body.

#### response.fromCache()

- returns: <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>

如果响应数据来自于磁盘或者内存，则返回  true

#### response.fromServiceWorker()

- returns: <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>

如果响应数据来自于 service worker，则返回  true

#### response.headers()

- returns: <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> http响应头对象. 所有的 header name 都是小写.

#### response.json()

- returns: <Promise<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>> Promise which resolves to a JSON representation of response body.

如果响应数据体(response body)无法使用  JSON.parse解析，则此方法将抛出错误。

#### response.ok()

- returns: <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)>

包含一个用于标记数据响应是否成功(状态码为 200-299)的布尔值。

#### response.request()

- returns: <[Request](https://juejin.im/post/6844903630026326029#class-request)> A matching  [Request](https://juejin.im/post/6844903630026326029#class-request)  object.

#### response.securityDetails()

- returns: <?[SecurityDetails](https://juejin.im/post/6844903630026326029#class-securitydetails)> 如果是在 安全连接(https)上收到的响应数据，则为 Security details，否则将是  null

#### response.status()

- returns: <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>

包含响应状态码(例如，200，表示响应成功)

#### response.text()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>> Promise which resolves to a text representation of response body.

#### response.url()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>

包含响应的 URL

### class: SecurityDetails

[SecurityDetails](https://juejin.im/post/6844903630026326029#class-securitydetails)  class represents responses which are received by page.

#### securityDetails.issuer()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 带有证书颁发机构名称的字符串。

#### securityDetails.protocol()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 安全协议名, 例如 "TLS 1.2".

#### securityDetails.subjectName()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> 证书签发对象的名称

#### securityDetails.validFrom()

- returns: <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>  [UnixTime](https://en.wikipedia.org/wiki/Unix_time)，安全证书开始生效的时间，用 Unix时间表示。

#### securityDetails.validTo()

- returns: <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)>  [UnixTime](https://en.wikipedia.org/wiki/Unix_time)  ，安全证书失效的时间，用 Unix时间表示。

### class: Target

#### target.browser()

- returns: <[Browser](https://juejin.im/post/6844903630026326029#class-browser)>

获取 target(可以认为是page) 隶属于的 browser。

#### target.browserContext()

- returns: <[BrowserContext](https://juejin.im/post/6844903630026326029#class-browsercontext)>

The browser context the target belongs to.

#### target.createCDPSession()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[CDPSession](https://juejin.im/post/6844903630026326029#class-cdpsession)>>

Creates a Chrome Devtools Protocol session attached to the target.

#### target.opener()

- returns: <?[Target](https://juejin.im/post/6844903630026326029#class-target)>

Get the target that opened this target. Top-level targets return  null.

#### target.page()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<?[Page](https://juejin.im/post/6844903630026326029#class-page)>>

如果 target的类型不是  page  或者  background_page， 则返回  null

#### target.type()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>

返回 target的类型，可以是  "page",  [(L)](https://developer.chrome.com/extensions/background_pages)["background_page"](https://developer.chrome.com/extensions/background_pages),  "service_worker",  "browser"  or  "other"

#### target.url()

- returns: <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)>

### class: CDPSession

- extends:  [(L)](https://nodejs.org/api/events.html#events_class_eventemitter)[EventEmitter](https://nodejs.org/api/events.html#events_class_eventemitter)

The  CDPSession  instances are used to talk raw Chrome Devtools Protocol:

- protocol methods can be called with  session.send  method.
- protocol events can be subscribed to with  session.on  method.

DevTools Protocol的文档参见:  [DevTools Protocol Viewer](https://chromedevtools.github.io/devtools-protocol/).

jsconst  client =  await  page.target().createCDPSession();
await  client.send('Animation.enable');

client.on('Animation.animationCreated', () =>  console.log('Animation created!'));

const  response =  await  client.send('Animation.getPlaybackRate');
console.log('playback rate is '  + response.playbackRate);
await  client.send('Animation.setPlaybackRate', {
playbackRate: response.playbackRate /  2
});
复制代码

#### cdpSession.detach()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)>

将 cdpSession从 target上 detach掉，一旦cdpSession从 target上 detach掉了，则 the cdpSession object将不可再触发任何事件，也不再可以用于发送信息

#### cdpSession.send(method[, params])

- method  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> protocol method name
- params  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> Optional method parameters
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>>

### class: Coverage

Coverage用于收集记录页面使用了哪些 JavaScript 以及 CSS代码。
下面的例子展示了如何获取 页面在初始化的时候，用到了所加载得 JavaScript 以及 CSS文件多少比例的内容：
js// Enable both JavaScript and CSS coverage
await Promise.all([
page.coverage.startJSCoverage(),
page.coverage.startCSSCoverage()
]);
// Navigate to page
await page.goto('https://example.com');
// Disable both JavaScript and CSS coverage
const [jsCoverage, cssCoverage] = await Promise.all([
page.coverage.stopJSCoverage(),
page.coverage.stopCSSCoverage(),
]);
let totalBytes = 0;
let usedBytes = 0;
const coverage = [...jsCoverage, ...cssCoverage];
for (const entry of coverage) {
totalBytes += entry.text.length;
for (const range of entry.ranges)
usedBytes += range.end - range.start - 1;
}
console.log(`Bytes used: ${usedBytes / totalBytes * 100}%`);
复制代码

*To output coverage in a form consumable by*  [Istanbul](https://github.com/istanbuljs)*, see*  [puppeteer-to-istanbul](https://github.com/istanbuljs/puppeteer-to-istanbul)*.*

#### coverage.startCSSCoverage(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> Set of configurable options for coverage
    - resetOnNavigation  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> Whether to reset coverage on every navigation. Defaults to  true.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> Promise that resolves when coverage is started

#### coverage.startJSCoverage(options)

- options  <[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)> Set of configurable options for coverage
    - resetOnNavigation  <[boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Boolean_type)> Whether to reset coverage on every navigation. Defaults to  true.
- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)> Promise that resolves when coverage is started

#### coverage.stopCSSCoverage()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>>> Promise that resolves to the array of coverage reports for all stylesheets
    - url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> StyleSheet URL
    - text  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> StyleSheet content
    - ranges  <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>> StyleSheet ranges that were used. Ranges are sorted and non-overlapping.
        - start  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> A start offset in text, inclusive
        - end  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> An end offset in text, exclusive

> NOTE>   > CSS Coverage 不包括那些没有 sourceURLs的动态加载得 style标签。

#### coverage.stopJSCoverage()

- returns: <[Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)<[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>>> Promise that resolves to the array of coverage reports for all non-anonymous scripts
    - url  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Script URL
    - text  <[string](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#String_type)> Script content
    - ranges  <[Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)<[Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)>> Script ranges that were executed. Ranges are sorted and non-overlapping.
        - start  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> A start offset in text, inclusive
        - end  <[number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures#Number_type)> An end offset in text, exclusive

> NOTE>   > JavaScript Coverage 不包括匿名脚本。但是，会包括带有sourceURLs的脚本。

关注下面的标签，发现更多相似文章
[(L)](https://juejin.im/tag/JavaScript)

[(L)](https://juejin.im/tag/JavaScript)[JavaScript](https://juejin.im/tag/JavaScript)

[(L)](https://juejin.im/tag/Promise)
[(L)](https://juejin.im/tag/Promise)[Promise](https://juejin.im/tag/Promise)
[(L)](https://juejin.im/tag/%E6%B5%8F%E8%A7%88%E5%99%A8)

[(L)](https://juejin.im/tag/%E6%B5%8F%E8%A7%88%E5%99%A8)[浏览器](https://juejin.im/tag/%E6%B5%8F%E8%A7%88%E5%99%A8)

[(L)](https://juejin.im/tag/Element)
[(L)](https://juejin.im/tag/Element)[Element](https://juejin.im/tag/Element)
[(L)](https://juejin.im/tag/Puppeteer)

[(L)](https://juejin.im/tag/Puppeteer)[Puppeteer](https://juejin.im/tag/Puppeteer)

[(L)](https://juejin.im/user/4054654612943303)

[(L)](https://juejin.im/user/4054654612943303)  [清夜](https://juejin.im/user/4054654612943303)  [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)  前端挖坑学院首席JS打字员 @ 字节跳动

[发布了 39 篇专栏 ·](https://juejin.im/user/4054654612943303/posts)  获得点赞 2,329 · 获得阅读 125,563

[安装掘金浏览器插件](https://juejin.im/extension/?utm_source=juejin.im&utm_medium=post&utm_campaign=extension_promotion)

打开新标签页发现好内容，掘金、GitHub、Dribbble、ProductHunt 等站点内容轻松获取。快来安装掘金浏览器插件获取高质量内容吧！

输入评论...

相关推荐
-
[(L)](https://juejin.im/post/6861725116389130254)

    - [(L)](https://juejin.im/post/6861725116389130254)  [前端进击者](https://juejin.im/user/2858385961407853)  ·
    - 1小时前·
    - [Vue.js](https://juejin.im/tag/Vue.js)  [/](https://juejin.im/tag/Vue.js)  [JavaScript](https://juejin.im/tag/JavaScript)

[学习Vue3.0,先来了解一下Proxy](https://juejin.im/post/6861725116389130254)

    - ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  15
    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6861725116389130254#comment)  [4](https://juejin.im/post/6861725116389130254#comment)
    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-
[(L)](https://juejin.im/post/6861376131615227912)

    - [(L)](https://juejin.im/post/6861376131615227912)  [TianTianUp](https://juejin.im/user/2348212569517645)  ·
    - 1天前·
    - [算法](https://juejin.im/tag/%E7%AE%97%E6%B3%95)  [/](https://juejin.im/tag/%E7%AE%97%E6%B3%95)  [JavaScript](https://juejin.im/tag/JavaScript)

[「算法与数据结构」DFS和BFS算法之美](https://juejin.im/post/6861376131615227912)

    - ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  146
    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6861376131615227912#comment)  [5](https://juejin.im/post/6861376131615227912#comment)
    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-
[(L)](https://juejin.im/post/6860646761392930830)

    - [(L)](https://juejin.im/post/6860646761392930830)  [晨曦时梦见兮](https://juejin.im/user/2330620350708823)  ·
    - 2天前·
    - [JavaScript](https://juejin.im/tag/JavaScript)

[一道价值25k的蚂蚁金服异步串行面试题](https://juejin.im/post/6860646761392930830)

    - ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  244
    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6860646761392930830#comment)  [83](https://juejin.im/post/6860646761392930830#comment)
    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-
[(L)](https://juejin.im/post/6859888538004783118)

    - [(L)](https://juejin.im/post/6859888538004783118)  [TianTianUp](https://juejin.im/user/2348212569517645)  ·
    - 5天前·
    - [Webpack](https://juejin.im/tag/Webpack)  [/](https://juejin.im/tag/Webpack)  [JavaScript](https://juejin.im/tag/JavaScript)

[「一劳永逸」由浅入深配置webpack4](https://juejin.im/post/6859888538004783118)

    - ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  636
    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6859888538004783118#comment)  [35](https://juejin.im/post/6859888538004783118#comment)
    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-
[(L)](https://juejin.im/post/6860253625030017031)

    - [(L)](https://juejin.im/post/6860253625030017031)  [沉末_](https://juejin.im/user/2189882893542183)  ·
    - 4天前·
    - [JavaScript](https://juejin.im/tag/JavaScript)

[从一道面试题说起：GET 请求能传图片吗？](https://juejin.im/post/6860253625030017031)

    - ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  116
    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6860253625030017031#comment)  [56](https://juejin.im/post/6860253625030017031#comment)
    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-
[(L)](https://juejin.im/post/6859125809655840776)

    - [(L)](https://juejin.im/post/6859125809655840776)  [政采云前端团队](https://juejin.im/user/3456520257288974)  ·
    - 7天前·
    - [JavaScript](https://juejin.im/tag/JavaScript)  [/](https://juejin.im/tag/JavaScript)  [React.js](https://juejin.im/tag/React.js)

[编写高质量可维护的代码：优化逻辑判断](https://juejin.im/post/6859125809655840776)

    - ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  626
    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6859125809655840776#comment)  [52](https://juejin.im/post/6859125809655840776#comment)
    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-
[(L)](https://juejin.im/post/6859545317378490376)

    - [(L)](https://juejin.im/post/6859545317378490376)  [wuwhs](https://juejin.im/user/1292681407632199)  ·
    - 5天前·
    - [JavaScript](https://juejin.im/tag/JavaScript)

[可能这些是你想要的H5键盘兼容方案](https://juejin.im/post/6859545317378490376)

    - ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  481
    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6859545317378490376#comment)  [29](https://juejin.im/post/6859545317378490376#comment)
    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-
[(L)](https://juejin.im/post/6857800782276902919)

    - [(L)](https://juejin.im/post/6857800782276902919)  [Peter谭老师](https://juejin.im/user/2119514149895512)  ·
    - 10天前·
    - [JavaScript](https://juejin.im/tag/JavaScript)

[前端10个灵魂拷问 吃透这些你就能摆脱初级前端工程师！](https://juejin.im/post/6857800782276902919)

    - ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  1061
    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6857800782276902919#comment)  [91](https://juejin.im/post/6857800782276902919#comment)
    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-
[(L)](https://juejin.im/post/6859506910652006414)

    - [(L)](https://juejin.im/post/6859506910652006414)  [johnYu](https://juejin.im/user/4212984289442750)  ·
    - 6天前·
    - [JavaScript](https://juejin.im/tag/JavaScript)

[Web开发应了解的5种设计模式](https://juejin.im/post/6859506910652006414)

    - ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  266
    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6859506910652006414#comment)  [31](https://juejin.im/post/6859506910652006414#comment)
    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

-
[(L)](https://juejin.im/post/6861390436175462414)

    - [(L)](https://juejin.im/post/6861390436175462414)  [unadlib](https://juejin.im/user/3597257776049848)  ·
    - 23小时前·
    - [JavaScript](https://juejin.im/tag/JavaScript)

[Reactant: 一个渐进式React框架](https://juejin.im/post/6861390436175462414)

    - ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)  4
    - [![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlPjc1MzFEREU0LTZCMzgtNDI4Ny04QTJBLUY2ODVGMDgzNUFGQzwvdGl0bGU+PGRlZnM+PHJlY3QgaWQ9ImEiIHg9IjU5IiB5PSI1NCIgd2lkdGg9IjU0IiBoZWlnaHQ9IjI1IiByeD0iMSIvPjxtYXNrIGlkPSJiIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTQiIGhlaWdodD0iMjUiIGZpbGw9IiNmZmYiPjx1c2UgeGxpbms6aHJlZj0iI2EiLz48L21hc2s+PC9kZWZzPjxnIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OCAtNTYpIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik03MiA2MXY4LjAzOGg0LjQ0NEw4MS4xMTEgNzJ2LTIuOTYySDg0VjYxeiIvPjx1c2Ugc3Ryb2tlPSIjRURFRUVGIiBtYXNrPSJ1cmwoI2IpIiBzdHJva2Utd2lkdGg9IjIiIHhsaW5rOmhyZWY9IiNhIi8+PC9nPjwvc3ZnPg==)](https://juejin.im/post/6861390436175462414#comment)
    - ![](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHZpZXdCb3g9IjAgMCAyMCAyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QjFBMjZEODAtQ0ZCRC00REIyLThCQTAtODc0MEVBMTE2RTExPC90aXRsZT48ZyBzdHJva2U9IiNBQUIwQkEiIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTEwLjUyNCAzLjQxM3Y4LjIzNSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xMy4wMjcgNy41MDhjLjgxMyAwIDEuNjc4LS4wMSAxLjY3OC0uMDEuNDQ5IDAgLjgxMi4zNzYuODEyLjgyNmwtLjAwNSA2LjM2YS44MTkuODE5IDAgMCAxLS44MTEuODI2SDYuMzFhLjgyMi44MjIgMCAwIDEtLjgxMS0uODI2bC4wMDUtNi4zNmMwLS40NTYuMzYtLjgyNS44MTItLjgyNWwxLjY4OS4wMDZNOC4zNzMgNS4xMTFsMi4xNDMtMi4wOSAyLjE0MyAyLjA3Ii8+PC9nPjwvc3ZnPg==)

关于作者

[(L)](https://juejin.im/user/4054654612943303)  [清夜](https://juejin.im/user/4054654612943303)  [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)

前端挖坑学院首席JS打字员 @ 字节跳动

![](data:image/svg+xml,%3csvg data-v-52d07ee0='' data-v-71f2d09e='' xmlns='http://www.w3.org/2000/svg' width='25' height='26' viewBox='0 0 25 26' class='zan js-evernote-checked' data-evernote-id='1831'%3e%3cg data-v-52d07ee0='' data-v-71f2d09e='' fill='none' fill-rule='evenodd' transform='translate(0 .57)'%3e%3cellipse data-v-52d07ee0='' data-v-71f2d09e='' cx='12.5' cy='12.57' fill='%23E1EFFF' rx='12.5' ry='12.57'%3e%3c/ellipse%3e %3cpath data-v-52d07ee0='' data-v-71f2d09e='' fill='%237BB9FF' d='M8.596 11.238V19H7.033C6.463 19 6 18.465 6 17.807v-5.282c0-.685.483-1.287 1.033-1.287h1.563zm4.275-4.156A1.284 1.284 0 0 1 14.156 6c.885.016 1.412.722 1.595 1.07.334.638.343 1.687.114 2.361-.207.61-.687 1.412-.687 1.412h3.596c.38 0 .733.178.969.488.239.317.318.728.21 1.102l-1.628 5.645a1.245 1.245 0 0 1-1.192.922h-7.068v-7.889c1.624-.336 2.623-2.866 2.806-4.029z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  获得点赞2,329

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' data-v-52d07ee0='' data-v-71f2d09e='' width='25' height='25' viewBox='0 0 25 25' class='icon stat-view-icon js-evernote-checked' data-evernote-id='1832'%3e%3cg data-v-52d07ee0='' data-v-71f2d09e='' fill='none' fill-rule='evenodd'%3e%3ccircle data-v-52d07ee0='' data-v-71f2d09e='' cx='12.5' cy='12.5' r='12.5' fill='%23E1EFFF'%3e%3c/circle%3e %3cpath data-v-52d07ee0='' data-v-71f2d09e='' fill='%237BB9FF' d='M4 12.5S6.917 7 12.75 7s8.75 5.5 8.75 5.5-2.917 5.5-8.75 5.5S4 12.5 4 12.5zm8.75 2.292c1.208 0 2.188-1.026 2.188-2.292 0-1.266-.98-2.292-2.188-2.292-1.208 0-2.188 1.026-2.188 2.292 0 1.266.98 2.292 2.188 2.292z'%3e%3c/path%3e%3c/g%3e%3c/svg%3e)  文章被阅读125,563

- [(L)](https://pages.segmentfault.com/rte-hackathon-2020?utm_source=J03&utm_medium=banner&utm_campaign=rte_2020)

相关文章
[(L)](https://juejin.im/post/6844903545922158599)

[(L)](https://juejin.im/post/6844903545922158599)[webpack多入口文件页面打包配置](https://juejin.im/post/6844903545922158599)

[![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/post/6844903545922158599)  [174](https://juejin.im/post/6844903545922158599)  [(L)](https://juejin.im/post/6844903545922158599)[![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik0yIDR2OC4wMzhoNC40NDRMMTEuMTExIDE1di0yLjk2MkgxNFY0eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/post/6844903545922158599)  [21](https://juejin.im/post/6844903545922158599)

[(L)](https://juejin.im/post/6844903507330334728)

[(L)](https://juejin.im/post/6844903507330334728)[Next.js v4.1.4 文档中文翻译](https://juejin.im/post/6844903507330334728)

[![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/post/6844903507330334728)  [114](https://juejin.im/post/6844903507330334728)  [(L)](https://juejin.im/post/6844903507330334728)[![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik0yIDR2OC4wMzhoNC40NDRMMTEuMTExIDE1di0yLjk2MkgxNFY0eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/post/6844903507330334728)  [10](https://juejin.im/post/6844903507330334728)

[(L)](https://juejin.im/post/6844904089902383112)

[(L)](https://juejin.im/post/6844904089902383112)[三年前端面试经验加感悟](https://juejin.im/post/6844904089902383112)

[![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/post/6844904089902383112)  [233](https://juejin.im/post/6844904089902383112)  [(L)](https://juejin.im/post/6844904089902383112)[![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik0yIDR2OC4wMzhoNC40NDRMMTEuMTExIDE1di0yLjk2MkgxNFY0eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/post/6844904089902383112)  [59](https://juejin.im/post/6844904089902383112)

[(L)](https://juejin.im/post/6844903678852202510)

[(L)](https://juejin.im/post/6844903678852202510)[接手前端新项目？这里有些注意点你可能需要留意一下](https://juejin.im/post/6844903678852202510)

[![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/post/6844903678852202510)  [259](https://juejin.im/post/6844903678852202510)  [(L)](https://juejin.im/post/6844903678852202510)[![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik0yIDR2OC4wMzhoNC40NDRMMTEuMTExIDE1di0yLjk2MkgxNFY0eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/post/6844903678852202510)  [16](https://juejin.im/post/6844903678852202510)

[(L)](https://juejin.im/post/6844903951389851655)

[(L)](https://juejin.im/post/6844903951389851655)[两万字长文-电商sku组合查询状态细究与实现](https://juejin.im/post/6844903951389851655)

[![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik00LjIzNCA2LjY5M3Y3LjI0M0gyLjg4MWMtLjQ4NiAwLS44ODEtLjQ5Mi0uODgxLTEuMDk1VjcuODc1YzAtLjYzLjQxMi0xLjE4Mi44OC0xLjE4MmgxLjM1NHptMy42ODgtMy43QzguMDEgMi40MDQgOC40OSAxLjk5IDkuMDE4IDJjLjc1NC4wMTUgMS4yMDQuNjYzIDEuMzYuOTgzLjI4NC41ODUuMjkyIDEuNTQ5LjA5NyAyLjE2Ny0uMTc3LjU2LS41ODYgMS4yOTYtLjU4NiAxLjI5NmgzLjA2NmMuMzI0IDAgLjYyNS4xNjQuODI2LjQ0OS4yMDQuMjkuMjcuNjY4LjE3OCAxLjAxMWwtMS4zODcgNS4xODNjLS4xMjYuNDk5LS41NDQuODQ3LTEuMDE2Ljg0N0g1LjUzVjYuNjkzYzEuMzg1LS4zMDkgMi4yMzYtMi42MzIgMi4zOTItMy43eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/post/6844903951389851655)  [158](https://juejin.im/post/6844903951389851655)  [(L)](https://juejin.im/post/6844903951389851655)[![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTAgMGgxNnYxNkgweiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNCMkJBQzIiIGQ9Ik0yIDR2OC4wMzhoNC40NDRMMTEuMTExIDE1di0yLjk2MkgxNFY0eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/post/6844903951389851655)  [22](https://juejin.im/post/6844903951389851655)
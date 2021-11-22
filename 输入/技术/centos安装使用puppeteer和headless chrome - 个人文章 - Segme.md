centos安装使用puppeteer和headless chrome - 个人文章 - SegmentFault 思否

 [ ![user-64.png](../_resources/328f423f1e5df4bb6baab3ec84430d81.png)     **凤梨豪**](https://segmentfault.com/u/nius)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='1'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='192' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  426

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='2'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='196' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/rightgenius)

[![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-comment-alt-lines fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='comment-alt-lines' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='5'%3e%3cpath fill='currentColor' d='M448 0H64C28.7 0 0 28.7 0 64v288c0 35.3 28.7 64 64 64h96v84c0 7.1 5.8 12 12 12 2.4 0 4.9-.7 7.1-2.4L304 416h144c35.3 0 64-28.7 64-64V64c0-35.3-28.7-64-64-64zm16 352c0 8.8-7.2 16-16 16H288l-12.8 9.6L208 428v-60H64c-8.8 0-16-7.2-16-16V64c0-8.8 7.2-16 16-16h384c8.8 0 16 7.2 16 16v288zm-96-216H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h224c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16zm-96 96H144c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h128c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16z' data-evernote-id='207' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://segmentfault.com/a/1190000011382062#comment-area)

#   [centos安装使用puppeteer和headless chrome](https://segmentfault.com/a/1190000011382062)

[![541659371-5df9fc6ddfc06_small](../_resources/69a332b9f052d3df8876e85040f34272.png) chrome](https://segmentfault.com/t/chrome)[自动化测试](https://segmentfault.com/t/%E8%87%AA%E5%8A%A8%E5%8C%96%E6%B5%8B%E8%AF%95)

 发布于 2017-09-27

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

Google推出了无图形界面的headless Chrome之后，可以直接在远程服务器上直接跑一些测试脚本或者爬虫脚本了，猴开心！Google还附送了[Puppeteer](https://github.com/GoogleChrome/puppeteer)用于驱动没头的Chome。

阿里的Macaca也顺势写了[Macaca-puppeteer](https://github.com/macacajs/macaca-puppeteer)，可以在Macaca上直接写通用的测试用例，在开发机上用图形界面看效果，上服务器走生产，岂不是美滋滋。

然鹅，可达鸭眉头一皱，发现事情并没有那么简单。
在阿里云的Centos 7.3上，安装puppeteer之后，会发现并不能启动官方的example：

	const puppeteer = require('puppeteer');

	(async () => {
	  const browser = await puppeteer.launch();
	  const page = await browser.newPage();
	  await page.goto('https://example.com');
	  await page.screenshot({path: 'example.png'});

	  await browser.close();
	})();

## 依赖安装

仔细看错误栈，核心的错误是如下一段：

> ...node_modules/puppeteer/.local-chromium/linux-496140/chrome-linux/chrome: error while loading shared libraries: libpangocairo-1.0.so.0: cannot open shared object file: No such file or directory

> TROUBLESHOOTING: > [> https://github.com/GoogleChro...](https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md)

原来puppet虽然帮你下了一个Chromium，但并没有帮你把依赖都装好。于是你要自己把那些so都装好。

官方给的是Ubuntu版本的各个so包的apt-get安装方式，centos版本居然没有放！于是遍历了各个issue之后，终于发现还是有人给出了centos的库名，在一个[看起来并不相关的issue里](https://github.com/GoogleChrome/puppeteer/issues/560#issuecomment-325224766)：

	*#依赖库*
	yum install pango.x86_64 libXcomposite.x86_64 libXcursor.x86_64 libXdamage.x86_64 libXext.x86_64 libXi.x86_64 libXtst.x86_64 cups-libs.x86_64 libXScrnSaver.x86_64 libXrandr.x86_64 GConf2.x86_64 alsa-lib.x86_64 atk.x86_64 gtk3.x86_64 -y

	*#字体*
	yum install ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc -y

总算不用挨个去google了……

## sandbox去沙箱

这时候你再去执行脚本，发现还是跑不起来。但是报错终于变了。这个时候变成了一个莫名其妙的错误：

	(node:30559) UnhandledPromiseRejectionWarning: Unhandled promise rejection (rejection id: 1): Error: Failed to connect to chrome!
	(node:30559) [DEP0018] DeprecationWarning: Unhandled promise rejections are deprecated. In the future, promise rejections that are not handled will terminate the Node.js process with a non-zero exit code.

要疯掉了有没有，这啥玩意啊！！！！关键是这时候另外一个[看起来是解决上面问题的issue](https://github.com/GoogleChrome/puppeteer/issues/290)，对这个错误进行了详细的讨论，然而直到今天（2017年9月27日）并没有讨论出什么结果。

网上很多讨论是说，直接调试那个Chrome。按照并不能解决问题的说法：直接去puppeteer的目录找到.local-chrome里面的Chromium执行文件，直接执行

	./chrome -v --no-sandbox --disable-setuid-sandbox

	(chrome:5333): Gtk-WARNING **: cannot open display:

发现加上了`--no-sanbox`其实是能启动的，但是提示没有Gtk图形界面，那干脆加上--headless是不是就行了嘞？确实没有报错了。
回到puppeteer示例脚本，修改启动浏览器的代码，加上args：

	const puppeteer = require('puppeteer');

	(async () => {
	  const browser = await puppeteer.launch({args: ['--no-sandbox', '--disable-setuid-sandbox']});
	  const page = await browser.newPage();
	  await page.goto('https://example.com');
	  await page.screenshot({path: 'example.png'});

	  await browser.close();
	})();

啊哈，终于执行成功了。下载下来了example.com的截图看了一眼，简直泪流满面。
回想一下，Puppet本身估计自带了--headless，所以如果直接去命令行执行chrome，还是要带上--headless。

终于搞定这一切发现Macaca顺便还提供了一个[基于Ubuntu的Macaca-puppeteer的Docker](https://github.com/macacajs/macaca-puppeteer-docker)，艾玛这方便太多了，早知道不自己折腾了。

[ceshiren.com](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CpcGtKuc5X7v_K5Xr9QWpr5LgCKiI5K5Vt_ec1uoIwI23ARABIJHX2UdgnQHIAQGpAvOidymZT4M-qAMByAPDBKoE2AFP0J-duqUqKwNS6lODzfs85OrO0SJrv0xfK_m3072SW6pDN-CtBlthW9rnxTYPZUpp7eSiLD5-aUGI3tjWt-azL8xaYPI23VKBz9fYdhICopHOxug5BmDr0fK6r7PiwsJYnKLtfPj_F1uobYllJ1QDpl7UVtgZG1AHUbRAT5G8pFt6OMa7LzYkgTy-ctwIGYh08QfIDBjRNv82S6JVamPt0QX4jtr7JGsqkh9JjWZYFyXsHYTOHtwyuGPAbr-7yS8TDoO5Z4NXZX141b1hOVSWNiB4AuX9gILABLS60dyXAqAGUYAHr_iwKKgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJPpC1KjxzZEKACgGYCwHICwHYEwmIFAI&ae=1&num=1&sig=AOD64_1uaXrlYuaEzOvayOVcpXkQODA-5A&client=ca-pub-6330872677300335&nb=1&adurl=https://ceshiren.com%3Fgclid%3DEAIaIQobChMIu7zOvJSh6wIVlXW9Ch2plwSMEAEYASAAEgKzsPD_BwE)

[适合测试工程师的进阶课程](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CpcGtKuc5X7v_K5Xr9QWpr5LgCKiI5K5Vt_ec1uoIwI23ARABIJHX2UdgnQHIAQGpAvOidymZT4M-qAMByAPDBKoE2AFP0J-duqUqKwNS6lODzfs85OrO0SJrv0xfK_m3072SW6pDN-CtBlthW9rnxTYPZUpp7eSiLD5-aUGI3tjWt-azL8xaYPI23VKBz9fYdhICopHOxug5BmDr0fK6r7PiwsJYnKLtfPj_F1uobYllJ1QDpl7UVtgZG1AHUbRAT5G8pFt6OMa7LzYkgTy-ctwIGYh08QfIDBjRNv82S6JVamPt0QX4jtr7JGsqkh9JjWZYFyXsHYTOHtwyuGPAbr-7yS8TDoO5Z4NXZX141b1hOVSWNiB4AuX9gILABLS60dyXAqAGUYAHr_iwKKgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJPpC1KjxzZEKACgGYCwHICwHYEwmIFAI&ae=1&num=1&sig=AOD64_1uaXrlYuaEzOvayOVcpXkQODA-5A&client=ca-pub-6330872677300335&nb=0&adurl=https://ceshiren.com%3Fgclid%3DEAIaIQobChMIu7zOvJSh6wIVlXW9Ch2plwSMEAEYASAAEgKzsPD_BwE)

[海量测试开发技术资料和实战训练](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CpcGtKuc5X7v_K5Xr9QWpr5LgCKiI5K5Vt_ec1uoIwI23ARABIJHX2UdgnQHIAQGpAvOidymZT4M-qAMByAPDBKoE2AFP0J-duqUqKwNS6lODzfs85OrO0SJrv0xfK_m3072SW6pDN-CtBlthW9rnxTYPZUpp7eSiLD5-aUGI3tjWt-azL8xaYPI23VKBz9fYdhICopHOxug5BmDr0fK6r7PiwsJYnKLtfPj_F1uobYllJ1QDpl7UVtgZG1AHUbRAT5G8pFt6OMa7LzYkgTy-ctwIGYh08QfIDBjRNv82S6JVamPt0QX4jtr7JGsqkh9JjWZYFyXsHYTOHtwyuGPAbr-7yS8TDoO5Z4NXZX141b1hOVSWNiB4AuX9gILABLS60dyXAqAGUYAHr_iwKKgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJPpC1KjxzZEKACgGYCwHICwHYEwmIFAI&ae=1&num=1&sig=AOD64_1uaXrlYuaEzOvayOVcpXkQODA-5A&client=ca-pub-6330872677300335&nb=0&adurl=https://ceshiren.com%3Fgclid%3DEAIaIQobChMIu7zOvJSh6wIVlXW9Ch2plwSMEAEYASAAEgKzsPD_BwE)

[知识点涵盖shell sql python java selenium appium restful jenkins docker sonar elk](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CpcGtKuc5X7v_K5Xr9QWpr5LgCKiI5K5Vt_ec1uoIwI23ARABIJHX2UdgnQHIAQGpAvOidymZT4M-qAMByAPDBKoE2AFP0J-duqUqKwNS6lODzfs85OrO0SJrv0xfK_m3072SW6pDN-CtBlthW9rnxTYPZUpp7eSiLD5-aUGI3tjWt-azL8xaYPI23VKBz9fYdhICopHOxug5BmDr0fK6r7PiwsJYnKLtfPj_F1uobYllJ1QDpl7UVtgZG1AHUbRAT5G8pFt6OMa7LzYkgTy-ctwIGYh08QfIDBjRNv82S6JVamPt0QX4jtr7JGsqkh9JjWZYFyXsHYTOHtwyuGPAbr-7yS8TDoO5Z4NXZX141b1hOVSWNiB4AuX9gILABLS60dyXAqAGUYAHr_iwKKgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJPpC1KjxzZEKACgGYCwHICwHYEwmIFAI&ae=1&num=1&sig=AOD64_1uaXrlYuaEzOvayOVcpXkQODA-5A&client=ca-pub-6330872677300335&nb=7&adurl=https://ceshiren.com%3Fgclid%3DEAIaIQobChMIu7zOvJSh6wIVlXW9Ch2plwSMEAEYASAAEgKzsPD_BwE)

[ 打开](https://googleads.g.doubleclick.net/aclk?sa=L&ai=CpcGtKuc5X7v_K5Xr9QWpr5LgCKiI5K5Vt_ec1uoIwI23ARABIJHX2UdgnQHIAQGpAvOidymZT4M-qAMByAPDBKoE2AFP0J-duqUqKwNS6lODzfs85OrO0SJrv0xfK_m3072SW6pDN-CtBlthW9rnxTYPZUpp7eSiLD5-aUGI3tjWt-azL8xaYPI23VKBz9fYdhICopHOxug5BmDr0fK6r7PiwsJYnKLtfPj_F1uobYllJ1QDpl7UVtgZG1AHUbRAT5G8pFt6OMa7LzYkgTy-ctwIGYh08QfIDBjRNv82S6JVamPt0QX4jtr7JGsqkh9JjWZYFyXsHYTOHtwyuGPAbr-7yS8TDoO5Z4NXZX141b1hOVSWNiB4AuX9gILABLS60dyXAqAGUYAHr_iwKKgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJPpC1KjxzZEKACgGYCwHICwHYEwmIFAI&ae=1&num=1&sig=AOD64_1uaXrlYuaEzOvayOVcpXkQODA-5A&client=ca-pub-6330872677300335&nb=8&adurl=https://ceshiren.com%3Fgclid%3DEAIaIQobChMIu7zOvJSh6wIVlXW9Ch2plwSMEAEYASAAEgKzsPD_BwE)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='47' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='45' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

阅读 20.1k  更新于 2017-10-10

本作品系 原创， [采用《署名-非商业性使用-禁止演绎 4.0 国际》许可协议](https://creativecommons.org/licenses/by-nc-nd/4.0/)

* * *

 [![user-64.png](../_resources/328f423f1e5df4bb6baab3ec84430d81.png)](https://segmentfault.com/u/nius)

#####   [凤梨豪](https://segmentfault.com/u/nius)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='16'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='417' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  426

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='17'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='421' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/rightgenius)
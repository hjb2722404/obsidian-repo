Angular单元测试系列-简介

# Angular单元测试系列-简介

[[webp](../_resources/c890f16d632ba5986f3023092ed2c2bd.webp)](https://www.jianshu.com/u/88947e565fe0)

[cipchk](https://www.jianshu.com/u/88947e565fe0)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='279'%3e%3cpath d='M751.144277 307.2l-123.016533-238.933333h159.778133a81.92 81.92 0 0 1 59.1872 25.258666l160.256 167.492267A27.306667 27.306667 0 0 1 987.620011 307.2h-236.475734z m270.506667 111.547733L640.927744 946.039467a27.306667 27.306667 0 0 1-48.128-24.234667L766.504277 375.466667h-56.388266l-170.5984 590.165333a27.306667 27.306667 0 0 1-52.462934 0.034133L315.500544 375.466667H259.112277l174.523734 545.5872a27.306667 27.306667 0 0 1-48.128 24.302933L5.160277 418.747733A27.306667 27.306667 0 0 1 27.346944 375.466667H999.464277a27.306667 27.306667 0 0 1 22.152534 43.281066zM18.301611 261.0176L178.557611 93.525333A81.92 81.92 0 0 1 237.744811 68.266667h159.744L274.506411 307.2H38.030677a27.306667 27.306667 0 0 1-19.729066-46.1824zM453.877077 68.266667h117.896534l122.9824 238.933333H330.894677l122.9824-238.933333z' data-evernote-id='162' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*0.3032017.06.11 14:09:30字数 1,176阅读 3,214

本文将探讨如何搭建测试环境、以及Angular测试工具集。

# 测试环境

绝大部分都是利用Angular Cli来创建项目，因此，默认已经集成我们所需要的npm包与脚本；当然，如果你是使用自建或官网 quickstart 的话，需要自行安装；但所有核心数据全都是一样的。

Angular单元测试我们可以将其分成两类：独立单独测试与Angular测试工具集。
**Pipe与Service适为独立单独测试**，因为它们只需要 `new` 实例类即可；同样是无法与Angular组件进行任何交互。
与之相反就是Angular测试工具集。

## 测试框架介绍

**Jasmine**
Jasmine测试框架提供了编写测试脚本的工具集，而且非常优秀的语义化，让测试代码看起来像是在读一段话。
**Karma**
有测试脚本，还需要Karma来帮忙管理这些脚本，以便于在浏览器中运行。

## Npm 包

如果你非要折腾，那么最简单的办法便是通过Angular Cli创建一个新项目，然后将以下Npm包复制到您折腾的项目中。

	    "jasmine-core": "~2.5.2",
	    "jasmine-spec-reporter": "~3.2.0",
	    "karma": "~1.4.1",
	    "karma-chrome-launcher": "~2.1.1",
	    "karma-cli": "~1.0.1",
	    "karma-jasmine": "~1.1.0",
	    "karma-jasmine-html-reporter": "^0.2.2",
	    "karma-coverage-istanbul-reporter": "^0.2.0"
	12345678

那么，我们重要还是看配置脚本部分。

## 配置脚本

我们核心是需要让 karma 运行器运行起来，而对于 Jasmine，是在我们编写测试脚本时才会使用到，因此，暂时无须过度关心。

我们需要在根目录创建 `karma.conf.js` 文件，这相当于一些约定。文件是为了告知karma需要启用哪些插件、加载哪些测试脚本、需要哪些测试浏览器环境、测试报告通知方式、日志等等。

**karma.conf.js**
以下是Angular Cli默认提供的 karma 配置文件：

	// Karma configuration file, see link for more information
	// https://karma-runner.github.io/0.13/config/configuration-file.html

	module.exports = function(config) {
	    config.set({
	        // 基础路径（适用file、exclude属性）
	        basePath: '',
	        // 测试框架，@angular/cli 指Angular测试工具集
	        frameworks: ['jasmine', '@angular/cli'],
	        // 加载插件清单
	        plugins: [
	            require('karma-jasmine'),
	            require('karma-chrome-launcher'),
	            require('karma-jasmine-html-reporter'),
	            require('karma-coverage-istanbul-reporter'),
	            require('@angular/cli/plugins/karma')
	        ],
	        client: {
	            // 当测试运行完成后是否清除上文
	            clearContext: false // leave Jasmine Spec Runner output visible in browser
	        },
	        // 哪些文件需要被浏览器加载，后面会专门介绍  `test.ts`
	        files: [
	            { pattern: './src/test.ts', watched: false }
	        ],
	        // 允许文件到达浏览器之前进行一些预处理操作
	        // 非常丰富的预处理器：https://www.npmjs.com/browse/keyword/karma-preprocessor
	        preprocessors: {
	            './src/test.ts': ['@angular/cli']
	        },
	        // 指定请求文件MIME类型
	        mime: {
	            'text/x-typescript': ['ts', 'tsx']
	        },
	        // 插件【karma-coverage-istanbul-reporter】的配置项
	        coverageIstanbulReporter: {
	            // 覆盖率报告方式
	            reports: ['html', 'lcovonly'],
	            fixWebpackSourcePaths: true
	        },
	        // 指定angular cli环境
	        angularCli: {
	            environment: 'dev'
	        },
	        // 测试结果报告方式
	        reporters: config.angularCli && config.angularCli.codeCoverage ?
	            ['progress', 'coverage-istanbul'] :
	            ['progress', 'kjhtml'],
	        port: 9876,
	        colors: true,
	        // 日志等级
	        logLevel: config.LOG_INFO,
	        // 是否监听测试文件
	        autoWatch: true,
	        // 测试浏览器列表
	        browsers: ['Chrome'],
	        // 持续集成模式，true：表示浏览器执行测试后退出
	        singleRun: false
	    });
	};
	123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960

以上配置基本上可以满足我们的需求；一般需要变动的，我想是测试浏览器列表了，因为karma支持所有市面上的浏览器。另外，当你使用 Travis CI 持续集成时，启动一个禁用沙箱环境Chrome浏览器会让我们少了很多事：

	        customLaunchers: {
	            Chrome_travis_ci: {
	                base: 'Chrome',
	                flags: ['--no-sandbox']
	            }
	        }
	123456

有关karma config文件的所有信息，请参与[官网文档](https://link.jianshu.com/?t=https://karma-runner.github.io/1.0/config/configuration-file.html)。

**test.ts**

在编写 `karma.conf.js` 时，我们配置过浏览器加载的文件指向的是 `./src/test.ts` 文件。作用是为了引导 karma 启动，代码也简单许多：

	// This file is required by karma.conf.js and loads recursively all the .spec and framework files

	import 'zone.js/dist/long-stack-trace-zone';
	import 'zone.js/dist/proxy.js';
	import 'zone.js/dist/sync-test';
	import 'zone.js/dist/jasmine-patch';
	import 'zone.js/dist/async-test';
	import 'zone.js/dist/fake-async-test';
	import { getTestBed } from '@angular/core/testing';
	import {
	  BrowserDynamicTestingModule,
	  platformBrowserDynamicTesting
	} from '@angular/platform-browser-dynamic/testing';

	// Unfortunately there's no typing for the `__karma__` variable. Just declare it as any.
	declare var __karma__: any;
	declare var require: any;

	// Prevent Karma from running prematurely.
	__karma__.loaded = function () {};

	// First, initialize the Angular testing environment.
	getTestBed().initTestEnvironment(
	  BrowserDynamicTestingModule,
	  platformBrowserDynamicTesting()
	);
	// Then we find all the tests.
	// 所有.spec.ts文件
	const context = require.context('./', true, /\.spec\.ts$/);
	// And load the modules.
	context.keys().map(context);
	// Finally, start Karma to run the tests.
	__karma__.start();
	123456789101112131415161718192021222324252627282930313233

一切就绪后，我们可以尝试启动 karma 试一下，哪怕无任何测试代码，也是可以运行的。

如果是Angular Cli那么 `ng test`。<s>折腾的用 `node "./node_modules/karma-cli/bin/karma" start`</s>

最后，打开浏览器：`http://localhost:9876`，可以查看测试报告。

# 简单示例

既然环境搭好，那么我们来写个简单示例试一下。
创建 `./src/demo.spec.ts` 文件。**.spec.ts为后缀这是一个约定，遵守它。**

	describe('demo test', () => {
	    it('should be true', () => {
	        expect(true).toBe(true);
	    })
	});
	12345

运行 `ng test` 后，我们可以在控制台看到：

	Chrome 58.0.3029 (Windows 10 0.0.0): Executed 1 of 1 SUCCESS (0.031 secs / 0.002 secs)
	1

或者浏览器：

	1 spec, 0 failures
	demo test
	  true is true
	123

## DEBUG

Karma 运行后打开的页面的右上角有一个【DEBUG】，会打开另一个页面，此时，如果你打开 DevTools （chrome快捷键：`Ctrl+Shift+I`），当你重新刷新页面后，遇到 `debugger;` 时会进入断点状态。

不管怎么样，毕竟我们已经进入Angular单元测试的世界了。

# Angular测试工具集

普通类诸如Pipe或Service，只需要通过简单的 `new` 创建实例。而对于指令、组件而言，需要一定的环境。这是因为Angular的模块概念，要想组件能运行，首先得有一个 `@NgModule` 定义。

工具集的信息量并不很多，你很容易可以掌握它。下面我简略说明几个最常用的：
**TestBed**

`TestBed` 就是Angular测试工具集提供的用于构建一个 `@NgModule` 测试环境模块。当然有了模块，还需要利用 `TestBed.createComponent` 创建一个用于测试目标组件的测试组件。

**异步**
Angular到处都是异步，而异步测试可以利用工具集中 `async`、`fakeAsync` 编写优雅测试代码看着是同步。

工具集还有更多，这一切我们将在[Angular单元测试-组件与指令单元测试](https://www.jianshu.com/p/e606103ddac4)逐一说明。

那么下一篇，我们将介绍[如何使用Jasmine进行Angular单元测试](https://www.jianshu.com/p/2cb0b222d93f)。
happy coding!

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='880'%3e%3cpath d='M728.064 343.943529c-17.648941-2.891294-23.552-20.239059-26.503529-28.912941V104.026353C701.560471 46.200471 654.396235 0 595.425882 0c-53.007059 0-97.28 40.478118-106.134588 89.569882-29.997176 184.862118-138.541176 255.457882-217.630118 280.937412a26.142118 26.142118 0 0 0-18.130823 24.877177v560.067764c0 19.817412 16.022588 35.84 35.84 35.84h535.973647c56.018824-11.565176 94.328471-31.804235 120.892235-86.738823l120.832-416.105412c23.552-75.173647-14.757647-147.395765-100.231529-144.564706h-238.772706z m-571.813647 31.744H76.619294C35.358118 375.687529 0 410.383059 0 450.861176v462.426353c0 43.369412 32.406588 78.004706 76.619294 78.004706h79.631059c27.708235 0 50.115765-22.407529 50.115765-50.115764V425.863529a50.115765 50.115765 0 0 0-50.115765-50.115764z' data-evernote-id='156' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

6人点赞*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='64 64 896 896' focusable='false' class='js-evernote-checked' data-icon='right' width='1em' height='1em' fill='currentColor' aria-hidden='true' data-evernote-id='884'%3e%3cpath d='M765.7 486.8L314.9 134.7A7.97 7.97 0 0 0 302 141v77.3c0 4.9 2.3 9.6 6.1 12.6l360 281.1-360 281.1c-3.9 3-6.1 7.7-6.1 12.6V883c0 6.7 7.7 10.4 12.9 6.3l450.8-352.1a31.96 31.96 0 0 0 0-50.4z' data-evernote-id='885' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='889'%3e%3cpath d='M771.413333 668.728889c-18.773333 3.015111-25.031111 20.878222-28.16 29.866667v217.884444c0 59.733333-49.948444 107.52-112.412444 107.52a115.427556 115.427556 0 0 1-112.412445-92.558222c-31.857778-190.919111-146.830222-263.850667-230.627555-290.133334a27.420444 27.420444 0 0 1-19.228445-26.168888V37.944889C268.572444 17.066667 285.582222 0 306.631111 0h567.864889c59.335111 11.946667 99.953778 32.824889 128 89.543111l128.113778 429.909333c24.974222 77.653333-15.644444 152.291556-106.211556 149.276445H771.413333z m-605.866666-32.824889H81.180444C37.546667 635.904 0 600.064 0 558.250667V80.611556C0 35.84 34.360889 0 81.180444 0H165.546667c29.297778 0 53.077333 23.779556 53.077333 53.077333v529.749334a53.077333 53.077333 0 0 1-53.077333 53.077333z' data-evernote-id='135' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

[*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='894'%3e%3cpath d='M178.390055 120.591045C111.268624 120.591045 56.888889 174.401955 56.888889 240.556383V903.97778C56.888889 970.302855 111.097977 1024 178.390055 1024h545.731364c67.121431 0 121.558049-53.81091 121.558049-120.02222V240.613265c0-66.268192-54.209088-120.02222-121.558049-120.02222H178.390055z m455.117432 301.136319H269.06087a30.147761 30.147761 0 0 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z m303.18409 301.136318a30.318409 30.318409 0 0 1-30.375291-30.318409V180.317742c0-66.268192-53.81091-120.02222-121.330519-120.022219H329.697688a30.147761 30.147761 0 0 1 0-60.23864l454.946784 0.056882C885.326618 0.113765 967.009987 80.887013 967.009987 180.602155v511.943118a30.318409 30.318409 0 0 1-30.31841 30.318409z m-303.18409-120.47728H269.06087a30.147761 30.147761 0 1 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z' data-evernote-id='146' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*Angular2](https://www.jianshu.com/nb/924690)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='900'%3e%3cpath d='M232.727273 579.87878833C271.28679 579.87878833 302.545455 548.62012233 302.545455 510.06060633 302.545455 471.50108933 271.28679 440.24242433 232.727273 440.24242433 194.167756 440.24242433 162.909091 471.50108933 162.909091 510.06060633 162.909091 548.62012233 194.167756 579.87878833 232.727273 579.87878833ZM512 579.87878833C550.559516 579.87878833 581.818182 548.62012233 581.818182 510.06060633 581.818182 471.50108933 550.559516 440.24242433 512 440.24242433 473.440484 440.24242433 442.181818 471.50108933 442.181818 510.06060633 442.181818 548.62012233 473.440484 579.87878833 512 579.87878833ZM791.272727 579.87878833C829.832243 579.87878833 861.090909 548.62012233 861.090909 510.06060633 861.090909 471.50108933 829.832243 440.24242433 791.272727 440.24242433 752.713211 440.24242433 721.454545 471.50108933 721.454545 510.06060633 721.454545 548.62012233 752.713211 579.87878833 791.272727 579.87878833Z' data-evernote-id='166' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

"小礼物走一走，来简书关注我"
还没有人赞赏，支持一下

[[webp](../_resources/e2c055a693030657c4e01b81e1b1d089.webp)](https://www.jianshu.com/u/88947e565fe0)

[cipchk](https://www.jianshu.com/u/88947e565fe0)一个会独立思考的高级动物
总资产5 (约0.57元)共写了5.3W字获得321个赞共288个粉丝
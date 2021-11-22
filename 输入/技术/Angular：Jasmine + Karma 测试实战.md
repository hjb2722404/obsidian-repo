Angular：Jasmine + Karma 测试实战

# [DTeam 团队日志](https://blog.dteam.top/)

## Doer、Delivery、Dream

[![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round' class='feather feather-github js-evernote-checked' data-evernote-id='87'%3e%3cpath d='M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22'%3e%3c/path%3e%3c/svg%3e)](https://github.com/DTeam-Top)[![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round' class='feather feather-mail js-evernote-checked' data-evernote-id='88'%3e%3cpath d='M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z'%3e%3c/path%3e%3cpolyline points='22%2c6 12%2c13 2%2c6'%3e%3c/polyline%3e%3c/svg%3e)](https://blog.dteam.top/posts/2020-04/angular-jasmine-karma.htmlmailto:jian.hu@shifudao.com)[![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round' class='feather feather-rss js-evernote-checked' data-evernote-id='89'%3e%3cpath d='M4 11a9 9 0 0 1 9 9'%3e%3c/path%3e%3cpath d='M4 4a16 16 0 0 1 16 16'%3e%3c/path%3e%3ccircle cx='5' cy='19' r='1'%3e%3c/circle%3e%3c/svg%3e)](https://blog.dteam.top/index.xml)

- [主页](https://blog.dteam.top/)

- [文章](https://blog.dteam.top/posts.html)

- [雷达](https://blog.dteam.top/radar/index.html)

- [镜像](https://blog.dteam.top/mirrors.html)

- [关于](https://blog.dteam.top/about.html)

- [标签](https://blog.dteam.top/tags.html)

- 总访问 21948    总人气 11975

-

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round' class='feather feather-search js-evernote-checked' data-evernote-id='90'%3e%3ccircle cx='11' cy='11' r='8'%3e%3c/circle%3e%3cline x1='21' y1='21' x2='16.65' y2='16.65'%3e%3c/line%3e%3c/svg%3e)

# Angular：Jasmine + Karma 测试实战

小纪同学 Posted at — Apr 10, 2020阅读 147

[](http://connect.qq.com/widget/shareqq/index.html?url=https%3A%2F%2Fblog.dteam.top%2Fposts%2F2020-04%2Fangular-jasmine-karma.html&title=Angular%EF%BC%9AJasmine%20%2B%20Karma%20%E6%B5%8B%E8%AF%95%E5%AE%9E%E6%88%98%20-%20DTeam%20%E5%9B%A2%E9%98%9F%E6%97%A5%E5%BF%97&source=Angular%EF%BC%9AJasmine%20%2B%20Karma%20%E6%B5%8B%E8%AF%95%E5%AE%9E%E6%88%98%20-%20DTeam%20%E5%9B%A2%E9%98%9F%E6%97%A5%E5%BF%97&desc=Share.js%20-%20%E4%B8%80%E9%94%AE%E5%88%86%E4%BA%AB%E5%88%B0%E5%BE%AE%E5%8D%9A%EF%BC%8CQQ%E7%A9%BA%E9%97%B4%EF%BC%8C%E8%85%BE%E8%AE%AF%E5%BE%AE%E5%8D%9A%EF%BC%8C%E4%BA%BA%E4%BA%BA%EF%BC%8C%E8%B1%86%E7%93%A3&pics=)[](http://service.weibo.com/share/share.php?url=https%3A%2F%2Fblog.dteam.top%2Fposts%2F2020-04%2Fangular-jasmine-karma.html&title=Angular%EF%BC%9AJasmine%20%2B%20Karma%20%E6%B5%8B%E8%AF%95%E5%AE%9E%E6%88%98%20-%20DTeam%20%E5%9B%A2%E9%98%9F%E6%97%A5%E5%BF%97&pic=&appkey=)[](Angular：Jasmine%20+%20Karma%20测试实战.md#)[](http://shuo.douban.com/!service/share?href=https%3A%2F%2Fblog.dteam.top%2Fposts%2F2020-04%2Fangular-jasmine-karma.html&name=Angular%EF%BC%9AJasmine%20%2B%20Karma%20%E6%B5%8B%E8%AF%95%E5%AE%9E%E6%88%98%20-%20DTeam%20%E5%9B%A2%E9%98%9F%E6%97%A5%E5%BF%97&text=Share.js%20-%20%E4%B8%80%E9%94%AE%E5%88%86%E4%BA%AB%E5%88%B0%E5%BE%AE%E5%8D%9A%EF%BC%8CQQ%E7%A9%BA%E9%97%B4%EF%BC%8C%E8%85%BE%E8%AE%AF%E5%BE%AE%E5%8D%9A%EF%BC%8C%E4%BA%BA%E4%BA%BA%EF%BC%8C%E8%B1%86%E7%93%A3&image=&starid=0&aid=0&style=11)[](https://twitter.com/intent/tweet?text=Angular%EF%BC%9AJasmine%20%2B%20Karma%20%E6%B5%8B%E8%AF%95%E5%AE%9E%E6%88%98%20-%20DTeam%20%E5%9B%A2%E9%98%9F%E6%97%A5%E5%BF%97&url=https%3A%2F%2Fblog.dteam.top%2Fposts%2F2020-04%2Fangular-jasmine-karma.html&via=https%3A%2F%2Fblog.dteam.top)[](https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fblog.dteam.top%2Fposts%2F2020-04%2Fangular-jasmine-karma.html)

Angular 提供了Jasmine + Karma 的单元测试，还不了解的同学请看[Angular单元测试浅说](https://blog.dteam.top/posts/2019-06/angular%E5%8D%95%E5%85%83%E6%B5%8B%E8%AF%95%E6%B5%85%E8%AF%B4.html)。 Angular中需要为每个被测试的文件创建以 .spec.ts 结尾的文件作为测试文件，除了引入测试文件本身需要的依赖外，还需要将被测试文件所属的依赖添加到测试文件。 在这里发现了 vscode 插件： shark-extension(yangbo)，可以一键生成测试文件。

### 使用shark-extension插件生成测试文件

右键点击被测试的文件（以Component为例），选择 generate unit test，就会自动生成 .spec.ts文件![generate-unit-test.png](../_resources/da68c6fe284c81e6f1e9dc863f415e40.png)![](../_resources/84cba55e8c6c2109753a98ea5126664c.png)

生成的测试文件会为每个function生成一个用例：![post-compinent-spec-function.png](../_resources/a3210693480415852b5d729e1ec66bd7.png)

并且会自动添加所需要的依赖，上部分是测试需要的依赖，下部分为Component的依赖：

	import { NO_ERRORS_SCHEMA } from '@angular/core';
	import { async, ComponentFixture, TestBed } from '@angular/core/testing';
	import { RouterTestingModule } from '@angular/router/testing';
	import { HttpClientTestingModule } from '@angular/common/http/testing';
	
	import { PostComponent } from './post.component';
	import { Component,Directive } from '@angular/core';
	import { Router,NzMessageService,PostService,UserService,RegularService,EmitService } from 'date-fns/difference_in_days';

大家会看到最后一条依赖引入错误，查看了Component，发现是因为引入了

	import * as differenceInDays from 'date-fns/difference_in_days';

这个时候就需要手动修改：

	import { NO_ERRORS_SCHEMA } from '@angular/core';
	import { async, ComponentFixture, TestBed } from '@angular/core/testing';
	import { RouterTestingModule } from '@angular/router/testing';
	import { HttpClientTestingModule } from '@angular/common/http/testing';
	
	import { PostComponent } from './post.component';
	import { Component,Directive } from '@angular/core';
	import { Router } from '@angular/router';
	import { NzMessageService, NzNotificationService } from 'ng-zorro-antd';
	import { PostService } from '../../common/services/post.service';
	import { UserService } from '../../common/services/user.service';
	import { RegularService } from '../../common/services/regular.service';
	import { EmitService } from '../../common/services/emit.service';
	import * as differenceInDays from 'date-fns/difference_in_days';

依赖解决后，执行测试，看看是否能将测试跑起来（这个时候是空测试，仅仅是为了检查环境是否正确，依赖是否全部引入）

	ng-test

发现报错了：![](../_resources/099144d9ce78fb115aa790579edd88bf.png)![](../_resources/1bfd429631e576452c68650bb66536a7.png)可以看到都是StaticInjectorError，发现是公用的模块没有引用（也有可能是Pipe错误），将SharedModule和DelonModule引入：

	...
	import { SharedModule } from '@shared/shared.module';
	import { DelonModule } from '../../delon.module';
	
	...
	imports: [
	    ...
	    SharedModule,
	    DelonModule
	],

执行ng-test ，测试通过了。![](../_resources/47fffa7618a8ef668468259eca92893a.png)

### Jasmine常用 Matchers 和 Setup and Teardown

Matchers是断言匹配操作，在实际值与期望值之间进行比较，并将结果通知Jasmine，最终Jasmine会判断此 Spec 成功还是失败。 Setup 与 Teardown相当于测试之前的准备工作，我们可以将重复的 Setup 与 Teardown 代码，放在与之相对应的 beforeEach 与 afterEach 全局函数里面。 了解常用的Matchers和Setup and Teardown有助于更快捷的编写测试代码。

#### Matchers

测试时会根据expect的实际传入的值和期望值进行比较，返回true，表示成功；如果为false，则表示失败。下列是经常用到的matchers： 查看更多信息[点击这里](https://jasmine.github.io/tutorials/your_first_suite)。

	expect(array).toContain(member);
	expect(fn).toThrow(string);
	expect(fn).toThrowError(string);
	expect(instance).toBe(instance);
	expect(mixed).toBeDefined();
	expect(mixed).toBeFalsy();
	expect(mixed).toBeNull();
	expect(mixed).toBeTruthy();
	expect(mixed).toBeUndefined();
	expect(mixed).toEqual(mixed);
	expect(mixed).toMatch(pattern);
	expect(number).toBeCloseTo(number, decimalPlaces);
	expect(number).toBeGreaterThan(number);
	expect(number).toBeLessThan(number);
	expect(number).toBeNaN();
	expect(spy).toHaveBeenCalled();
	expect(spy).toHaveBeenCalledTimes(number);
	expect(spy).toHaveBeenCalledWith(...arguments);

#### Setup and Teardown

测试有一些功能时需要一些额外的设置，测试完成后又需要删除，就需要用到下列function

- beforeAll 在执行所有测试之前调用一次（describe function之前）
- afterAll 在执行所有测试之后调用
- beforeEach 在执行每个测试之前调用（it function之前）
- afterEach 在执行每个测试之后调用

### 测试Component

- 数据绑定
- 组件的inputs和outputs

#### 准备工作

在写测试逻辑之前，需要做一些准备工作。

1.声明页面元素：DebugElement[DebugElement](https://angular.cn/api/core/DebugElement)是Angular的抽象层，可以安全的横跨其支持的所有平台。Angular 不再创建 HTML 元素树，而是创建 [DebugElement](https://angular.cn/api/core/DebugElement)树，其中包裹着相应运行平台上的原生元素。 下列元素后面会在beforeEach中获取为页面的input或者button等。

	import { NO_ERRORS_SCHEMA, DebugElement } from '@angular/core';
	...
	let submitEl: DebugElement;
	let loginEl: DebugElement;
	let passwordEl: DebugElement;
	let h1: HTMLElement

2.查找元素：By.css()

	import  { By }  from  '@angular/platform-browser';
	...
	*// beforeEach中
	***submitEl = fixture.debugElement.query(By.css('button'));
	
	*// 解包
	***submitEl.nativeElement

注意：

- By.css() 静态方法使用[标准 CSS 选择器](https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Getting_started/Selectors)选择了一些 DebugElement 节点。
- 这次查询返回了 `<button>` 元素的一个 DebugElement。
- 必须解包此结果，以获取这个 `<button>` 元素。

beforeEach整体如下：

	beforeEach(() => {
	    fixture = TestBed.createComponent(UserLoginComponent);
	    component = fixture.debugElement.componentInstance;
	    submitEl = fixture.debugElement.query(By.css('button'));
	    loginEl = fixture.debugElement.query(By.css('input[type=username]'));
	    passwordEl = fixture.debugElement.query(By.css('input[type=password]'));
	    h1 = fixture.nativeElement.querySelector('h1');
	  });

#### 测试数据绑定

测试页面 title 是否会绑定到页面： 因为绑定是在 Angular 执行变更检测时才发生的，所以需要通过调用 `fixture.detectChanges()` 来要求 TestBed 执行数据绑定。

	it('数据绑定', () => {
	    fixture.detectChanges();
	    expect(h1.textContent).toContain(component.title);
	  });

#### 组件的inputs和outputs

	it('将按钮enabled设置为false', () => {
	    component.enabled = false;
	    fixture.detectChanges();
	    expect(submitEl.nativeElement.disabled).toBeTruthy();
	});
	
	it('输入用户名密码，点击登录', () => {
	    let username = '';
	    let pwd = '';
	
	    loginEl.nativeElement.value = "17711111111";
	    passwordEl.nativeElement.value = "123456";
	
	    component.loggedIn.subscribe(value => {
	        username = value.username;
	        pwd = value.pwd;
	        expect(username).toBe("17711111111");
	        expect(pwd).toBe("123456");
	     });
	    submitEl.triggerEventHandler('click', null);
	});

如果想让组件自动检测更新，使用 [ComponentFixtureAutoDetect](https://angular.cn/api/core/testing/ComponentFixtureAutoDetect) ，配置 TestBed：

	import  { ComponentFixtureAutoDetect }  from  '@angular/core/testing';
	...
	providers:  [
	...
	{ provide:  ComponentFixtureAutoDetect,  useValue:  true  }  ]

### 测试Service

下面是模拟后端返回数据的示例

#### 准备工作

1.导入HttpClientTestingModule和HttpTestingController

	import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
	...
	let httpTestingController: HttpTestingController;
	...
	
	imports: [
	...
	HttpClientTestingModule]

2.获取httpTestingController

	beforeEach(() => {
	    ...
	    httpTestingController = TestBed.get(HttpTestingController);
	});

3.在afterEach中调用verify，确保没有未完成的请求

	afterEach(() => {
	    httpTestingController.verify();
	 });

#### 测试http返回List

首先mock一个数组当作后端返回的数据，可以判断数组长度，数据字段等。 如果HttpEventType的类型为Response，则表明响应事件的返回等于模拟HTTP请求的数据。 主要代码：

	import { NO_ERRORS_SCHEMA } from '@angular/core';
	import { TestBed } from '@angular/core/testing';
	import { HttpEvent, HttpEventType } from '@angular/common/http';
	import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
	import { UserService } from './user.service';
	import { _HttpClient } from '@delon/theme';
	import { URL } from '../url';
	describe('UserService', () => {
	  let usersService: UserService;
	  let httpTestingController: HttpTestingController;
	  beforeEach(() => TestBed.configureTestingModule({
	    imports: [HttpClientTestingModule],
	    providers: [
	      UserService,
	      _HttpClient
	    ],
	    schemas: [NO_ERRORS_SCHEMA]
	  }));
	
	  afterEach(() => {
	    httpTestingController.verify();
	  });
	
	  beforeEach(() => {
	    usersService = TestBed.get(UserService);
	    httpTestingController = TestBed.get(HttpTestingController);
	  });
	
	it('should run #getUserList()', () => {
	      const mockUsers = [
	        { id: 1, username: 'user1'},
	        { id: 1, username: 'user2'},
	      ];
	
	      usersService.getUserList({}).subscribe((event: HttpEvent<any>) => {
	        switch (event.type) {
	          case HttpEventType.Response:
	            expect(event.body).toEqual(mockUsers);
	        }
	      });
	
	      const mockReq = httpTestingController.expectOne(URL.USER);
	      expect(mockReq.cancelled).toBeFalsy();
	      expect(mockReq.request.responseType).toEqual('json');
	      mockReq.flush(mockUsers);
	  });
	
	  afterEach(() => {
	    TestBed.resetTestingModule();
	  });
	});

### 测试Directive和Pipe

测试指令： 需要获取元素，调用 triggerEventHandler 改变元素属性：
> triggerEventHandler 为 Angular DebugElement实例提供的一种方触发事件。

	it('鼠标移动改变颜色', () => {
	    inputEl.triggerEventHandler('mouseover', null);
	    fixture.detectChanges();
	    expect(inputEl.nativeElement.style.backgroundColor).toBe('blue');
	
	    inputEl.triggerEventHandler('mouseout', null);
	    fixture.detectChanges();
	    expect(inputEl.nativeElement.style.backgroundColor).toBe('inherit');
	  });

测试管道： 需要获取元素，调用 transform 判断返回值：

	it('数值除以100', () => {
	    const result = pipeInstance.transform(300);
	    expect(result).toBe(3);
	 });

### 代码覆盖率报告

在 angular.json 中添加可生成测试覆盖率报告：

	"test":{
	  "options":{
	  "codeCoverage": true
	  }
	}

然后执行，会在根目录下生成 coverage 文件夹：

	ng test --code-coverage

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107172926.png)复制 index.html 目录在浏览器中打开，就可以看到测试报告了：![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107172945.png)

![coverage-html.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107172954.png)

以上就是在Angular测试中经常需要用到的干货，在实际应用中可能需要组合起来测试，想知道更详细的内容，可查看Angular官网[测试](https://angular.cn/guide/testing#component-test-basics)部分。

- [angular](https://blog.dteam.top/tags/angular.html)
- [测试](https://blog.dteam.top/tags/%E6%B5%8B%E8%AF%95.html)

* * *

### 相关文章

- [探究微信小程序 Video 组件的视频兼容性](https://blog.dteam.top/posts/2020-07/wechat-mini-program-supported-videos.html)Jul 9, 2020
- [Vagrant使用国内镜像安装插件和box镜像](https://blog.dteam.top/posts/2020-04/vagrant-use-mirror.html)Apr 23, 2020
- [JUnit5 使用者：为何 Spock 值得你看它一眼](https://blog.dteam.top/posts/2020-04/spock-is-better.html)Apr 15, 2020
- [浅谈Cypress（上篇）](https://blog.dteam.top/posts/2019-11/%E6%B5%85%E8%B0%88cypress%E4%B8%8A%E7%AF%87.html)Nov 1, 2019
- [Angular单元测试浅说](https://blog.dteam.top/posts/2019-06/angular%E5%8D%95%E5%85%83%E6%B5%8B%E8%AF%95%E6%B5%85%E8%AF%B4.html)Jun 22, 2019

* * *

### 随机推荐

- [程序员的商业思维：向公司学个人经营](https://blog.dteam.top/posts/2019-10/%E7%A8%8B%E5%BA%8F%E5%91%98%E7%9A%84%E5%95%86%E4%B8%9A%E6%80%9D%E7%BB%B4%E5%90%91%E5%85%AC%E5%8F%B8%E5%AD%A6%E4%B8%AA%E4%BA%BA%E7%BB%8F%E8%90%A5.html)Oct 26, 2019
- [博世工业物联网黑客马拉松总结](https://blog.dteam.top/posts/2019-07/%E5%8D%9A%E4%B8%96%E5%B7%A5%E4%B8%9A%E7%89%A9%E8%81%94%E7%BD%91%E9%BB%91%E5%AE%A2%E9%A9%AC%E6%8B%89%E6%9D%BE%E6%80%BB%E7%BB%93.html)Jul 28, 2019
- [一个可插拔远程服务框架的诞生](https://blog.dteam.top/posts/2017-11/%E4%B8%80%E4%B8%AA%E5%8F%AF%E6%8F%92%E6%8B%94%E8%BF%9C%E7%A8%8B%E6%9C%8D%E5%8A%A1%E6%A1%86%E6%9E%B6%E7%9A%84%E8%AF%9E%E7%94%9F.html)Nov 10, 2017
- [StoryBook实战](https://blog.dteam.top/posts/2019-06/storybook%E5%AE%9E%E6%88%98.html)Jun 20, 2019
- [浅谈如何打造对容器友好的应用](https://blog.dteam.top/posts/2019-11/%E6%B5%85%E8%B0%88%E5%A6%82%E4%BD%95%E6%89%93%E9%80%A0%E5%AF%B9%E5%AE%B9%E5%99%A8%E5%8F%8B%E5%A5%BD%E7%9A%84%E5%BA%94%E7%94%A8.html)Nov 2, 2019
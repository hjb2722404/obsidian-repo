puppeteer踩坑经验之谈 - 掘金

[(L)](https://juejin.im/user/1521379824110743)

[ RikaXia   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzZFQ0VGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYyaC0yek0xNSA5VjdoMnYyeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0xNSA4VjZoNXYyek0xNSA5aDV2MmgtNXoiLz4KICAgIDwvZz4KPC9zdmc+Cg==)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/1521379824110743)

2019年02月19日   阅读 1298

# puppeteer踩坑经验之谈

## 启动浏览器

- 开启浏览器界面：headless: false
- 开启开发者控制台：devtools: true
- 自定义浏览器宽高：page.setViewport
- 产生两个tab页
    - 官方打开页面：await browser.pages()，会产生两个tab页，一个是目标tab页，一个是blank页
    - 修改后：(await browser.pages())[0]，仅打开目标tab页

	jsasync init() {
	    await this.openPage();
	    await this.createCer();
	}

	async openPage() {

	    // 打开浏览器
	    browser = await puppeteer.launch({
	        headless: false, // 开启界面,
	        devtools: true,  // 开启开发者控制台
	    });

	    // 打开一个空白页
	    page = (await browser.pages())[0];

	    try {

	        // 设置 浏览器视窗
	        await page.setViewport({
	            width: 1300,
	            height: 938,
	        });

	        // 跳转 目的页
	        await page.goto("http://127.0.0.1/demo.html");

	    } catch (error) {
	        await this.openPage();
	        throw new Error('请求页面超时，尝试重新连接');
	    }
	}
	复制代码

## 操作页面

- 为了能够获取目标节点，当遇到页面跳转的时、点击下拉时、可先等待随机秒数：await page.waitFor(utilFun.random(1000, 3000));
- 想获取元素的属性：page.$eval()
- 想操作dom元素：page.evaluate()
    - 为了能够准确获取dom元素，可使用setTimeout延时诺干秒后，再进行相应操作
- 正则中若想含有变量： let reg = new RegExp(`${username}`);

	jsasync createCer() {

	    const type = this.type;

	    const Development = "#ios-nav > li:nth-child(1) ul > li:nth-child(3)";
	    const Production = await page.$("#ios-nav > li:nth-child(1) ul > li:nth-child(4)");

	    switch (type) {
	        case "dev":
	            await this.addIosCertificates(Development);
	            break;
	        case "dis":
	            await this.addIosCertificates(Production);
	            break;
	        default:
	            break
	    }
	}

	async addIosCertificates(ele) {

	    // 点击 侧边栏 类型
	    await page.waitFor(utilFun.random(1000, 3000));
	    await page.click(ele);

	    // 点击 add 添加IOS证书
	    await page.waitFor(utilFun.random(1000, 3000));
	    await page.click(".toolbar-button.add");

	    // 判断 radio 是否能点击
	    await page.waitFor(utilFun.random(1000, 3000));
	    const radioDisabled = await page.$eval("#type-development-0", async el => {
	        return el.disabled;
	    });

	    // 如果证书数量满额，先删除，后增加
	    if (radioDisabled) {

	        // 点击 侧边栏 类型
	        await page.waitFor(utilFun.random(1000, 3000));
	        await page.click(`${ele}`);

	        // 删除 IOS证书
	        await page.waitFor(utilFun.random(1000, 3000));
	        await this.deleteCer();
	    } else {
	        // 增加 IOS证书
	        await this.addCer();
	    }

	}

	async deleteCer() {
	    await page.evaluate(async (username) => {
	        let tableInfo = "";
	        let reg = new RegExp(`${username}`);
	        const table = document.querySelectorAll(".data-table")[1].querySelector("tbody");

	        for (let i = 0; i < table.rows.length; i++) {
	            for (let j = 0; j < table.rows[i].cells.length; j++) {
	                tableInfo = table.rows[i].cells[j].innerText;
	                if (reg.test(tableInfo) && (i % 2 == 0)) {
	                    // 名字
	                    let name = table.rows[i].cells[j].innerText;
	                    // 类型
	                    let type = table.rows[i].cells[j + 1].innerText;
	                    // 期限
	                    let expires = table.rows[i].cells[j + 2].innerText;

	                    // 点击 下拉
	                    table.rows[i].click();

	                    // 点击 Revoke
	                    setTimeout(() => {
	                        document.querySelector(".button-no-padding-top.small.revoke-button").click();
	                    }, 1000);

	                    // 点击 弹窗 Revoke
	                    setTimeout(() => {
	                        document.querySelector(".ui-dialog-content.ui-widget-content .button.small.red.ok").click();
	                    }, 3000);

	                }
	            }
	        }

	    }, username);
	}
	复制代码

## 上传文件

	js// 点击 选择文件
	await page.waitFor(utilFun.random(1000, 3000));
	const upload_file = await page.$("input[type=file]");
	await upload_file.uploadFile("你的文件路径");
	复制代码

## 文件下载

	js// 下载 IOS 证书
	await this.downloadFile("你的文件路径");

	await page.waitFor(utilFun.random(1000, 3000));
	await page.click(".button.small.blue");
	复制代码
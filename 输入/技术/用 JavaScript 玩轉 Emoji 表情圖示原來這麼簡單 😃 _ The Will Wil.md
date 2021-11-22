用 JavaScript 玩轉 Emoji 表情圖示原來這麼簡單 😃 | The Will Will Web

 [← 公司找不到資深前端工程師可以導入前端框架嗎？](https://blog.miniasp.com/post/2019/01/09/Use-Frontend-Framework-when-no-senior-people-in-org)

 [如何在 .NET Core 主控台專案中使用 DI (相依注入) 並取得 ILogger 服務 →](https://blog.miniasp.com/post/2019/01/05/How-to-use-DI-and-ILogger-in-Console-program)

##   [用 JavaScript 玩轉 Emoji 表情圖示原來這麼簡單](https://blog.miniasp.com/post/2019/01/08/Understanding-Emoji-Unicode-and-JavaScript)

   **2019/01/08 20:03  **[Will 保哥](https://blog.miniasp.com/author/will)  **[JavaScript](https://blog.miniasp.com/category/JavaScript)

 [![75000917-d1379900-549a-11ea-89f9-5d23513e8ac5.png](../_resources/57c6c81eb30fcdf959741d14c7175c76.png)](http://bit.ly/CoolRareCourses)  [Understanding-Emoji-Unicode-and-JavaScript](../_resources/3cfa68e7ca9bb866a1342d00d199484b.bin)

這陣子花了一些時間研究 Unicode 萬國碼，看著看著就研究起 Emoji 表情圖示來了。過程中還跑去看了 [Unicode® Emoji](http://unicode.org/emoji/) 官方規格，要是沒有先建立對 Unicode 的理解，要完全看懂 Emoji 的來龍去脈是不太容易的。研究的過程中，還發現了一些有趣的冷知識，欲知詳情請繼續看下去！

首先，先來講怎樣在文件中使用 Emoji 表情圖示。這過程說簡單很簡單，要說複雜其實也有點複雜。基本上，你有 4 種方式可以在文件中輸出 Emoji 表情圖示：

1. 直接輸入 Emoji 字元
2. 將 12 個按鍵符號轉換為 Emoji 圖示
3. 在現有的 Emoji 字元後方加入菲茨派屈克修飾符 (膚色深度)

4. 透過 [零寬連字(ZWJ)](https://en.wikipedia.org/wiki/Zero-width_joiner) 將多個 Emoji 連接在一起

### 直接輸出 Emoji 字元

其實每一個 Emoji 就是一個 Unicode 字元，就跟一般文字一樣，所以你大可將 Emoji 字元放在任意字串中，完全沒有問題！

任何支援 Unicode (UTF-8, UTF-16, UTF-32) 的文件，都可以完全合法的放入 Emoji 字元，使用者的作業系統 (包含行動裝置) 只要有安裝含有 Emoji 的字型 (大多已內建)，就可以正確顯示 Emoji 表情圖示。

1. 直接上網搜尋並複製貼上
大部分 Emoji 字元都可以上網找到，直接透過複製/貼上就可以立即使用，相當便利：

    - [Emojipedia — Home of Emoji Meanings](https://emojipedia.org/search/)
    - [Full Emoji List, v11.0](http://www.unicode.org/emoji/charts/full-emoji-list.html)

2. 使用 Windows 10 的 Emoji 輸入法視窗
從 Windows 10 周年更新內建了一個 `Win+.` 快速鍵，可以叫出 Emoji 鍵盤來用，非常方便！

![50829952-1e34da80-1381-11e9-9be5-daa707eead26.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130811.png)

3. 透過 HTML Entities 語法輸出到 HTML 文件中

[&what: Discover Unicode & HTML Character Entities](http://www.amp-what.com/unicode/search/)

	&#x1f534;

4. 透過 JavaScript 的 [Unicode escape sequences](https://mathiasbynens.be/notes/javascript-escapes) 寫在字串中

在寫 JavaScript 字串的時候，直接將 Emoji 字元寫入字串是可以的，例如：

	var a = '';

JavaScript 有個 [Unicode escape sequences](https://mathiasbynens.be/notes/javascript-escapes) 表示法，可以用在字串中，假設 Unicode 的字碼為 `U+1F197` ( )，那麼 JavaScript 有兩種表示法：

    1. ES6 (ES2015) 可以使用 Unicode 的 Code point (碼點) 來表示一個 Unicode 文字
    
    var emoji1 = '\u{01F354}';
    var emoji2 = String.fromCodePoint(0x1F354);

**※ 請注意：即便 ES6 可以用 Unicode 的 Code point (碼點) 來表示一個 Unicode 文字，但事實上內部的文字編碼主要還是以 UTF-16 為主。**

    2. ES5 僅支援 `\uhhhh` 表示法，大部分 Emoji 字元被定義在 BMP 以外的字碼區域，你必須把一個 Unicode 字碼 (Code point) 轉換成兩個 UTF-16 碼元 (code unit) 才行，透過 surrogate pair 的方式來表達一個 Unicode 字元。所以 `U+1F197` 只能用以下語法來寫：
    
    '\uD83C\uDD97'

你可以透過 ES6 (ES2015) 提供的 API 來計算出 ES5 可以使用的兩個 UTF-16 碼元 (code unit)：

	var hb = '\u{01F197}'[0].codePointAt(0).toString(16); // \ud83c
	var lb = '\u{01F197}'[1].codePointAt(0).toString(16); // \udd97

也可以透過[以下函式](http://speakingjs.com/es5/ch24.html#_unicode_encodings)將 UTF-32 字碼轉換為兩個 UTF-16 的表示法：

	function toUTF16(codePoint) {
	    var TEN_BITS = parseInt('1111111111', 2);
	    function u(codeUnit) {
	        return '\\u'+codeUnit.toString(16).toUpperCase();
	    }
	
	    if (codePoint <= 0xFFFF) {
	        return u(codePoint);
	    }
	    codePoint -= 0x10000;
	
	    // Shift right to get to most significant 10 bits
	    var leadingSurrogate = 0xD800 | (codePoint >> 10);
	
	    // Mask to get least significant 10 bits
	    var trailingSurrogate = 0xDC00 | (codePoint & TEN_BITS);
	
	    return u(leadingSurrogate) + u(trailingSurrogate);
	}

使用範例如下：

	toUTF16(0x1F197)

### 將 12 個按鍵符號轉換為 Emoji 圖示

Emoji 定義了 12 個按鍵符號 (`0123456789#*`)，只要加入一組 2 個字元的 Emoji Keycap Sequence (`'\uFE0F\u20E3'`) 就可以把文字自動轉成 Emoji 圖示。

	var keycap = '\uFE0F\u20E3';
	console.assert('0️⃣' === '0' + keycap);
	console.assert('1️⃣' === '1' + keycap);
	console.assert('2️⃣' === '2' + keycap);
	console.assert('3️⃣' === '3' + keycap);
	console.assert('4️⃣' === '4' + keycap);
	console.assert('5️⃣' === '5' + keycap);
	console.assert('6️⃣' === '6' + keycap);
	console.assert('7️⃣' === '7' + keycap);
	console.assert('8️⃣' === '8' + keycap);
	console.assert('9️⃣' === '9' + keycap);
	console.assert('#️⃣' === '#' + keycap);
	console.assert('*️⃣' === '*' + keycap);

### 在現有的 Emoji 字元後方加入菲茨派屈克修飾符 (膚色深度)

在 Emoji 表情圖示的 Unicode 規格中，有個特別的 EMOJI MODIFIER FITZPATRICK (菲茨派屈克修飾符) 可用，這個 **修飾符** (Modifier) 也是一個合法的 Unicode 字元，必須緊接著在 Emoji 字元後面出現。

目前全世界人類的 **膚色分級** ([Fitzpatrick scale](https://en.wikipedia.org/wiki/Fitzpatrick_scale)) 是 1975 年由一位叫做 [Thomas B. Fitzpatrick](https://en.wikipedia.org/wiki/Thomas_B._Fitzpatrick) 的人訂定出來的，他當初定義了 6 種膚色等級。(Type 1 ~ Type 6)。研究 Emoji 竟然還能學習到這種冷知識，哈！

[![5317717501438943488](../_resources/b83b08a41e0b7d6713687f9e411b9ede.png)](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CgYRIpRUyX4bZN5iM8ALY3LygB9Om1bde8-vTpfoLr4amsZUOEAEg5IWdDGCdAaAB-8uK9wLIAQKpAiOh-ceAR4M-qAMByAPJBKoE8AFP0Ad-f7BKvRkp8WT9f7F_7z3bsCa3NG57W4fmZknagMy7inDdJFyqX52OlWVpedEyf2rrZBSsWjvCebi33DweV8WzosFx8YM-BjgX1Bi6BY9LiR7iQYAEQn82_W1uxHitM9OM6TD-RzIXvd39rETD69JNm4CveormVlN_rBqmElI_4qnpiHStUFfTc9bVIsF9GX2pXv_RN0hAMNVxwvPqblKYqS77rHKdPeooj80TC3i-qP_bGgUylT_NcuRoH4ROgbp7xhxvGoPd0XsAeultHSe-Vwb1I0ST09y3Jt7qUjRhLf_JpTYX5WLp6vl_RXfABKvT9beGA6AGAoAH7bP1iAGoB47OG6gH1ckbqAeT2BuoB7oGqAfw2RuoB_LZG6gHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BuoB8LaG9gHAdIIBwiAYRABGB-xCei2IxP7v_rIgAoBmAsByAsB2BMC&ae=1&num=1&cid=CAASEuRo35HD8Bz7H3Gt-UWWw0sp4g&sig=AOD64_0cGmGugI72No_BccIfhor-2b6Lsw&client=ca-pub-1096755573138843&nb=17&adurl=https://www.yisu.com/hk/huodong.html%3Ff%3Dgoogle%26plan%3Dhkfuwuqirenqun%26unit%3Drenqunshouzhong%26keyword%3Dhk%26eyisu%3Dgoogle20200101%26gclid%3DEAIaIQobChMIxr_L1p-S6wIVGAZcCh1YLg90EAEYASAAEgKbXPD_BwE)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='22' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='21' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

在 Emoji 表情符號中，總共定義了 5 個字元，用來代表 Emoji 的顏色深度。為什麼不是 6 個呢？因為 Type 1 與 Type 2 顏色太相近了，在電腦螢幕上不容易區分，索性就合併了。這五個字元分別是：

字元名稱
Code point
字元
UTF-16 (使用 JavaScript 字串)
UTF-8
FITZ-1-2
U+1F3FB

0xD83C 0xDFFB ([object Object])
0xF0 0x9F 0x8F 0xBB
FITZ-3
U+1F3FC

0xD83C 0xDFFC ([object Object])
0xF0 0x9F 0x8F 0xBC
FITZ-4
U+1F3FD

0xD83C 0xDFFD ([object Object])
0xF0 0x9F 0x8F 0xBD
FITZ-5
U+1F3FE

0xD83C 0xDFFE ([object Object])
0xF0 0x9F 0x8F 0xBE
FITZ-6
U+1F3FF

0xD83C 0xDFFF ([object Object])
0xF0 0x9F 0x8F 0xBF
以下是不同的 Emoji 在加上菲茨派屈克修飾符之後的比較表：

| Code point | Default | FITZ-1-2 | FITZ-3 | FITZ-4 | FITZ-5 | FITZ-6 |
| --- | --- | --- | --- | --- | --- | --- |
| U+1F9D2: 小孩 |     |     |     |     |     |     |
| U+1F466: 男孩 |     |     |     |     |     |     |
| U+1F467: 女孩 |     |     |     |     |     |     |
| U+1F9D1: 大人 |     |     |     |     |     |     |
| U+1F468: 男人 |     |     |     |     |     |     |
| U+1F469: 女人 |     |     |     |     |     |     |

我簡單透過 JavaScript 示範將 (大人) 膚色改成 (黑人) 的程式寫法：

	var adult = '';
	
	var fitz6 = '\uD83C\uDFFF';
	
	var black = adult + fitz6; // 只要透過簡單的字串相加就可以完成！
	
	console.log(black);

**請注意**：不是所有 Emoji 都能加上膚色，只有跟「人類」有關的 Emoji 才能這樣用，例如 Emoji 中有出現臉、手、腳、身體的，都可以這樣用。目前 Unicode v11.0 定義了 106 個 Emoji 圖示是可以加上 EMOJI MODIFIER FITZPATRICK 字元的，完整清單可以參考[這裡](https://unicode.org/Public/emoji/11.0/emoji-sequences.txt)。

### 透過 **零寬連字(ZWJ)** 將多個 Emoji 連接在一起

這個就真的很酷了，我以前一直很納悶有些 Emoji 到底是怎樣產生的，深入研究後才發現，原來 Emoji 這麼好玩，除了有幾千種不同的 Emoji 之外，還可以將其組合成各種千變萬化的玩法。

Unicode 中有個特殊的 [零寬連字(ZWJ)](https://en.wikipedia.org/wiki/Zero-width_joiner) 符號 (`‍U+200D`)，這基本上是一個合法的 Unicode 文字，只是他預設是看不見的 **零寬**(Zero Width) 字元。這個字元通常用在排版用途，不過卻被 Emoji 拿來用了。你可以透過這個字元，任意串接兩個不同的 Emoji 字元，然後就可以創造出新的、不存在 Emoji 清單中的全新 Emoji 字元。

[![2280250172279249775](../_resources/82821563207d6132a7893f204a1127c0.png)](https://www.googleadservices.com/pagead/aclk?sa=L&ai=COvQLpRUyX6DTOJmT8AKdhrKIDO299oNapYnM_twJ2dkeEAEg5IWdDGCdAaABst6nwAPIAQKpAiOh-ceAR4M-qAMByAPJBKoE8QFP0F6LT_KSEoYk1JjAnI6O1_Ry04zjP8kIwoIEe4Pf0O6hgHC1-7mkU9Cbbc8NlOQsfv-cObPDK_KH5QgYW-h_N2eqAxQJnQ6YZgt78osKdLlllpPlAI6MvSZvtRD8_VunUCzd4jm1gXezM3PjtM14VfAX3MQqBRhcF65y9pjfx3kNvlydCIOxlIAsrSfeBH7roH9paRvEz0rYCk_tYSERhyDadY00s0t071EEoXvWic2yzTN_SJmzuQAIIWHzJK_m3AXFTY8PQShYwp_kP7L7W4_Z3ZeIySxLOC5wMbHPQjdhLbjmHBZUps_9dTFEo9ViwASHwqSv-gGgBgKAB7ah2D-oB47OG6gH1ckbqAeT2BuoB7oGqAfw2RuoB_LZG6gHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BuoB8LaG9gHAdIIBwiAYRABGB-xCVBefwAH3H9qgAoBmAsByAsB2BMM&ae=1&num=1&cid=CAASEuRoCBiNF4nSEEl-srZHGtykLA&sig=AOD64_33wvIW-dN5fb52TG-7fjcMdd06VQ&client=ca-pub-1096755573138843&nb=17&adurl=https://cloud.tencent.com/act/campus%3FfromSource%3Dgwzcw.2664524.2664524.2664524%26utm_medium%3Dcpc%26utm_id%3Dgwzcw.2664524.2664524.2664524%26gclid%3DEAIaIQobChMI4LnM1p-S6wIVmQlcCh0dgwzBEAEYASAAEgKOu_D_BwE)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='22' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='21' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

這邊我做個非常簡單的示範，我直接把 (男人) 與 (女人) 串加起來，但中間卡一個 ZWJ 字元，這個 Emoji 就會自動變成 ‍ (一男一女)：

	var man = '';
	var women = '';
	
	var zwj = '\u200D';
	
	console.log(man + zwj + women);

如果希望顯示一家三口全家福的 Emoji 圖示，可以直接把 (男人) 、 (女人) 與 (男孩) 串加起來，但不同的字元中間都要卡一個 ZWJ 字元，此時 Emoji 就會自動變成 ‍‍ (一男一女外加一個男孩)：

	var man = '';
	var women = '';
	var child = '';
	
	var zwj = '\u200D';
	
	console.log(man + zwj + women + zwj + child);

相同的邏輯，如果你想顯示一家三口全家福，但小孩是個女兒的話，的 Emoji 圖示，可以直接把 (男人) 、 (女人) 與 (女孩) 串加起來，不同的字元中間依然要卡一個 ZWJ 字元，此時 Emoji 就會自動變成 ‍‍ (一男一女外加一個女孩)：

	var man = '';
	var women = '';
	var child = '';
	
	var zwj = '\u200D';
	
	console.log(man + zwj + women + zwj + child);

如果有兩個小孩呢？沒問題！ ` +  +  +  = ‍‍‍`

	var all = ['', '', '', ''];
	var zwj = '\u200D';
	console.log(all.join(zwj));

基本上，你要加幾個人都可以！而且在這兩性平權的時代，兩個爸爸、兩個媽媽也不奇怪，想親手試試 Emoji 怎樣設定嗎？
‍‍‍

	var all = ['', '', '', ''];
	var zwj = '\u200D';
	console.log(all.join(zwj));

‍‍‍

	var all = ['', '', '', ''];
	var zwj = '\u200D';
	console.log(all.join(zwj));

喔！爸爸是巴西人、媽媽是黑人？沒問題！I got you back! ‍‍‍

	var fitz1 = '\uD83C\uDFFB';
	var fitz6 = '\uD83C\uDFFF';
	
	var all = [''+fitz1, ''+fitz6, '', ''];
	var zwj = '\u200D';
	console.log(all.join(zwj));

你是一位白人、女性、而且是一位學生？‍

	var fitz1 = '\uD83C\uDFFB';
	
	var all = [''+fitz1, '']; // 加上學士帽 Emoji 即可！
	var zwj = '\u200D';
	console.log(all.join(zwj));

套用 ZWJ 字元的 Emoji 完整清單可以參考[這裡](https://unicode.org/Public/emoji/11.0/emoji-zwj-sequences.txt)。

### 注意事項

雖然 Unicode 明確定義了許多 Emoji 的字碼，但還是有很多平台會自己定義額外的 Emoji 圖示，因此不是所有的 Emoji 大家都看的到，這點必須特別注意。

有些沒有被定義在 Emoji 的 Unicode 符號，在特定作業系統平台也會特別做成**彩色版**的 Emoji 圖示，這部分各位就不用過於擔心，就算在其他平台看不到這個圖示，還是會顯示「文字版」的符號樣式，但也就沒有顏色了。

[![2280250172279249775](../_resources/82821563207d6132a7893f204a1127c0.png)](https://www.googleadservices.com/pagead/aclk?sa=L&ai=C5zWfpRUyX4H7OJKG8AXh7anQCq359atew92lgZQK-O7bp4ELEAEg5IWdDGCdAaAB6o-PhgPIAQKpAiOh-ceAR4M-qAMByAPJBKoE8QFP0KUHDh1pugSHO_5SdOs-iMJJiBwTTGnTO3l-QGHiJGLzp3mtQ7CSo_hVQFylxIv-qXM4xiBgfSDdvzNxv1BQS5OUOLYr-zC-uCvZSB_lWRyHcunINqmYUwbf6gcdikg8trLMD-gsTqcdJFeBc-V4gjo9jGhDM5M_Pq8kUH_DJc6l78M-IPv1WnfAa5ipJ7b-Y525RCWf47zwcLqEX2VjuPTw5RBTEl0VvCsXuJ7xtc3v9w-tIiS8eXIy7IY5Tn9vJoW2Pa9FlVGL4yqxbSX9z8nzlRZo7nFrDoX0ZLpQwRyBkQMDHKCJepQhB_VWIqRawAT5ktGHhAKgBgKAB-7QgnmoB47OG6gH1ckbqAeT2BuoB7oGqAfw2RuoB_LZG6gHpr4bqAfs1RuoB_PRG6gH7NUbqAeW2BuoB8LaG9gHAdIIBwiAYRABGB-xCbqTKd6TY2z9gAoBmAsByAsB2BMM&ae=1&num=1&cid=CAASEuRo7C1F6XpjJKq7o3YQKa7Xgw&sig=AOD64_22yCRO7DDuInwQHrhdKq1aDjKonw&client=ca-pub-1096755573138843&nb=17&adurl=https://cloud.tencent.com/act/campus%3FfromSource%3Dgwzcw.2702558.2702558.2702558%26utm_medium%3Dcpc%26utm_id%3Dgwzcw.2702558.2702558.2702558%26gclid%3DEAIaIQobChMIweHM1p-S6wIVEgO8Ch3hdgqqEAEYASAAEgL3yfD_BwE)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='22' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='21' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

Unicode 標準定義的 Emoji 清單，可以從 [Full Emoji List, Unicode v11.0](http://www.unicode.org/emoji/charts/full-emoji-list.html) 取得！

### 相關連結

- [表情圖示 - 維基百科，自由的百科全書](https://zh.wikipedia.org/wiki/%E8%A1%A8%E6%83%85%E5%9B%BE%E6%A0%87)
- [Full Emoji List, Unicode v11.0](http://www.unicode.org/emoji/charts/full-emoji-list.html)
- [Fitzpatrick scale - Wikipedia](https://en.wikipedia.org/wiki/Fitzpatrick_scale)
- [Emojis in Javascript](https://thekevinscott.com/emojis-in-javascript/)

標籤 : [javascript](https://blog.miniasp.com/?tag=javascript), [emoji](https://blog.miniasp.com/?tag=emoji), [unicode](https://blog.miniasp.com/?tag=unicode)

### 相關文章

- [用 JavaScript 玩轉 Emoji 表情圖示原來這麼簡單](https://blog.miniasp.com/post/2019/01/08/Understanding-Emoji-Unicode-and-JavaScript)

這陣子花了一些時間研究 Unicode 萬國碼，看著看著就研究起 Emoji 表情圖示來了。過程中還跑去看了 Unicode® Emoji 官方規格文件，要是沒有先建立對 Unicode 的理

- [我要成為前端工程師！給 JavaScript 新手的建議與學習資源整理](https://blog.miniasp.com/post/2016/02/02/JavaScript-novice-advice-and-learning-resources)

今年有越來越多企業開始跟我們接洽企業內訓的事，想請我幫他們培訓前端工程師，但你知道一個好的前端工程師絕對不是兩三個月可以養成的，需要多年的努力與磨練才會有點成績。而這幾年可謂前端正夯，有為數不少的人開

- [驗證你的 JavaScript 程式：JSLint](https://blog.miniasp.com/post/2008/02/23/JSLint-The-JavaScript-Verifier)

我們常常在寫 JavaScript，但又要如何驗證我們的 JavaScript 寫的好不好呢？有個 JSLint 網站就幫我們做這件事。之前我也是認為在寫 JavaScript 的時候都覺得只要跑起來...
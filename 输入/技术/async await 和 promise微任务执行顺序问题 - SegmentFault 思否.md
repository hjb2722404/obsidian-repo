async await 和 promise微任务执行顺序问题 - SegmentFault 思否

 [ ![user-64.png](../_resources/328f423f1e5df4bb6baab3ec84430d81.png)     **yr1014**](https://segmentfault.com/u/yr1014)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='1'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='206' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  241

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='2'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='210' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/ruimax)

#   [async await 和 promise微任务执行顺序问题](https://segmentfault.com/q/1010000016147496)

[javascript](https://segmentfault.com/t/javascript)

### 问题描述

今天看到一个关于js执行顺序的问题，不太了解async await中await后的代码的执行时机

- 问题1. 为啥promise2、promise3输出比async1 end输出早？如果都是微任务的话，不是async1 end先加入微任务队列的吗？
- 问题2. 为什么async1 end又先于promise4输出呢？

#### 相关代码

	async function async1(){
	  console.log('async1 start')
	  await async2()
	  console.log('async1 end')
	}
	async function async2(){
	  console.log('async2')
	}
	console.log('script start')
	setTimeout(function(){
	  console.log('setTimeout')
	},0)
	async1();
	new Promise(function(resolve){
	  console.log('promise1')
	  resolve();
	}).then(function(){
	  console.log('promise2')
	}).then(function() {
	  console.log('promise3')
	}).then(function() {
	  console.log('promise4')
	}).then(function() {
	  console.log('promise5')
	}).then(function() {
	  console.log('promise6')
	}).then(function() {
	  console.log('promise7')
	}).then(function() {
	  console.log('promise8')
	})
	console.log('script end')

#### chrome 70.0.3538.102 结果

	script start
	async1 start
	async2
	promise1
	script end
	promise2 // 与 chrome canary 73 不一致
	promise3 // 与 chrome canary 73 不一致
	async1 end // 与 chrome canary 73 不一致
	promise4
	promise5
	promise6
	promise7
	promise8
	setTimeout

### Chrome canary 73.0.3646.0(同node8.12.0):

	script start
	async1 start
	async2
	promise1
	script end
	async1 end // 与 chrome 70 不一致
	promise2 // 与 chrome 70 不一致
	promise3 // 与 chrome 70 不一致
	promise4
	promise5
	promise6
	promise7
	promise8
	setTimeout

阅读 7.5k

 [评论](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)     更新于 10月21日

- [**xianshenglu**](https://segmentfault.com/u/xianshenglu)：

你看下我更新的回答，应该可以解释你的问题了

 [  ![](async%20await%20%E5%92%8C%20promise%E5%BE%AE%E4%BB%BB%E5%8A%A1%E6%89%A7%E8%A1%8C%E9%A1%BA%E5%BA%8F%E9%97%AE%E9%A2%98%20-%20SegmentFault%20%E6%80%9D%E5%90%A6.md# class='svg-inline--fa fa-thumbs-up fa-w-16 mr-1 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='thumbs-up' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='11'%3e%3cpath fill='currentColor' d='M466.27 286.69C475.04 271.84 480 256 480 236.85c0-44.015-37.218-85.58-85.82-85.58H357.7c4.92-12.81 8.85-28.13 8.85-46.54C366.55 31.936 328.86 0 271.28 0c-61.607 0-58.093 94.933-71.76 108.6-22.747 22.747-49.615 66.447-68.76 83.4H32c-17.673 0-32 14.327-32 32v240c0 17.673 14.327 32 32 32h64c14.893 0 27.408-10.174 30.978-23.95 44.509 1.001 75.06 39.94 177.802 39.94 7.22 0 15.22.01 22.22.01 77.117 0 111.986-39.423 112.94-95.33 13.319-18.425 20.299-43.122 17.34-66.99 9.854-18.452 13.664-40.343 8.99-62.99zm-61.75 53.83c12.56 21.13 1.26 49.41-13.94 57.57 7.7 48.78-17.608 65.9-53.12 65.9h-37.82c-71.639 0-118.029-37.82-171.64-37.82V240h10.92c28.36 0 67.98-70.89 94.54-97.46 28.36-28.36 18.91-75.63 37.82-94.54 47.27 0 47.27 32.98 47.27 56.73 0 39.17-28.36 56.72-28.36 94.54h103.99c21.11 0 37.73 18.91 37.82 37.82.09 18.9-12.82 37.81-22.27 37.81 13.489 14.555 16.371 45.236-5.21 65.62zM88 432c0 13.255-10.745 24-24 24s-24-10.745-24-24 10.745-24 24-24 24 10.745 24 24z' data-evernote-id='410' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](#)    [回复](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    2018-12-27

[ 访问网站![nessie_icon_tiamat_white.png](../_resources/adba15d1f83faffbf818c91d6e3d4a0d.png)](https://www.googleadservices.com/pagead/aclk?sa=L&ai=C8gD6HqLJX-2GBMbO2QTRl67QC7TQ5bhgi-2W7bMLrtCJ3pUOEAEgkdfZR2CdAaABwIvS1QLIAQGpAvz2QTl0g4Q-qAMBqgTYAU_Qqxm2rwrxquLumrh8d7D4njnB-c1Tc7qZ6vPoCV_lffzWxB3qsPdWMedZhulXSuW_rKMTYeZJq1WJmGnrdeBs0ADMgPvGn2br0OnzT5UVwqs4uaZcV6JTUxu_hbDb4HjhH5T_oewL8H7kjao6yq-ktuVlGyFYWnU94f0yOBtBDAMlyP_YAYqZRs11ZK4zNrInOAVggwF0a4bfvePO0QaniOByloW2NcBfp8-Wxgfa_KLp3loZ6klLa6gu-nFN6Lg-foqmyI5wG9MZss5cSy4pcB3ZBpgaAcAEytGIjv0CgAeo9K2qAagH1ckbqAfw2RuoB_LZG6gHlJixAqgHpd8bqAeOzhuoB5PYG6gHugaoB-6WsQKoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgb2AcB0ggJCIDhgEAQARgfsQnotiMT-7_6yIAKAZgLAcgLAbgMAdgTDYgUBQ&ae=1&num=1&cid=CAASPeRoJ82hafIowpge1KcNEm7aL6Twdd3dtWhEk37_pP8R9CgahwTZ1KiqgDskdA4DnLVYcHcrKlC-8FLVGJ8&sig=AOD64_08CBm-5cUK4l0xLEf_8993-emzLA&client=ca-pub-6330872677300335&nb=12&adurl=https://www.yisu.com/hk/huodong.html%3Ff%3Dgoogle%26plan%3Dhkfuwuqirenqun%26unit%3Drenqunshouzhong%26keyword%3Dhk%26eyisu%3Dgoogle20200101%26gclid%3DEAIaIQobChMI7Y3d76az7QIVRmeWCh3Riwu6EAEYASAAEgIcmvD_BwE)

[![](../_resources/4af7000c57ebbf69230fc3806500911f.png)](https://www.googleadservices.com/pagead/aclk?sa=L&ai=C8gD6HqLJX-2GBMbO2QTRl67QC7TQ5bhgi-2W7bMLrtCJ3pUOEAEgkdfZR2CdAaABwIvS1QLIAQGpAvz2QTl0g4Q-qAMBqgTYAU_Qqxm2rwrxquLumrh8d7D4njnB-c1Tc7qZ6vPoCV_lffzWxB3qsPdWMedZhulXSuW_rKMTYeZJq1WJmGnrdeBs0ADMgPvGn2br0OnzT5UVwqs4uaZcV6JTUxu_hbDb4HjhH5T_oewL8H7kjao6yq-ktuVlGyFYWnU94f0yOBtBDAMlyP_YAYqZRs11ZK4zNrInOAVggwF0a4bfvePO0QaniOByloW2NcBfp8-Wxgfa_KLp3loZ6klLa6gu-nFN6Lg-foqmyI5wG9MZss5cSy4pcB3ZBpgaAcAEytGIjv0CgAeo9K2qAagH1ckbqAfw2RuoB_LZG6gHlJixAqgHpd8bqAeOzhuoB5PYG6gHugaoB-6WsQKoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgb2AcB0ggJCIDhgEAQARgfsQnotiMT-7_6yIAKAZgLAcgLAbgMAdgTDYgUBQ&ae=1&num=1&cid=CAASPeRoJ82hafIowpge1KcNEm7aL6Twdd3dtWhEk37_pP8R9CgahwTZ1KiqgDskdA4DnLVYcHcrKlC-8FLVGJ8&sig=AOD64_08CBm-5cUK4l0xLEf_8993-emzLA&client=ca-pub-6330872677300335&nb=19&adurl=https://www.yisu.com/hk/huodong.html%3Ff%3Dgoogle%26plan%3Dhkfuwuqirenqun%26unit%3Drenqunshouzhong%26keyword%3Dhk%26eyisu%3Dgoogle20200101%26gclid%3DEAIaIQobChMI7Y3d76az7QIVRmeWCh3Riwu6EAEYASAAEgIcmvD_BwE)

[亿速云](https://www.googleadservices.com/pagead/aclk?sa=L&ai=C8gD6HqLJX-2GBMbO2QTRl67QC7TQ5bhgi-2W7bMLrtCJ3pUOEAEgkdfZR2CdAaABwIvS1QLIAQGpAvz2QTl0g4Q-qAMBqgTYAU_Qqxm2rwrxquLumrh8d7D4njnB-c1Tc7qZ6vPoCV_lffzWxB3qsPdWMedZhulXSuW_rKMTYeZJq1WJmGnrdeBs0ADMgPvGn2br0OnzT5UVwqs4uaZcV6JTUxu_hbDb4HjhH5T_oewL8H7kjao6yq-ktuVlGyFYWnU94f0yOBtBDAMlyP_YAYqZRs11ZK4zNrInOAVggwF0a4bfvePO0QaniOByloW2NcBfp8-Wxgfa_KLp3loZ6klLa6gu-nFN6Lg-foqmyI5wG9MZss5cSy4pcB3ZBpgaAcAEytGIjv0CgAeo9K2qAagH1ckbqAfw2RuoB_LZG6gHlJixAqgHpd8bqAeOzhuoB5PYG6gHugaoB-6WsQKoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgb2AcB0ggJCIDhgEAQARgfsQnotiMT-7_6yIAKAZgLAcgLAbgMAdgTDYgUBQ&ae=1&num=1&cid=CAASPeRoJ82hafIowpge1KcNEm7aL6Twdd3dtWhEk37_pP8R9CgahwTZ1KiqgDskdA4DnLVYcHcrKlC-8FLVGJ8&sig=AOD64_08CBm-5cUK4l0xLEf_8993-emzLA&client=ca-pub-6330872677300335&nb=1&adurl=https://www.yisu.com/hk/huodong.html%3Ff%3Dgoogle%26plan%3Dhkfuwuqirenqun%26unit%3Drenqunshouzhong%26keyword%3Dhk%26eyisu%3Dgoogle20200101%26gclid%3DEAIaIQobChMI7Y3d76az7QIVRmeWCh3Riwu6EAEYASAAEgIcmvD_BwE)

[亿速云香港服务器低延时仅需29元](https://www.googleadservices.com/pagead/aclk?sa=L&ai=C8gD6HqLJX-2GBMbO2QTRl67QC7TQ5bhgi-2W7bMLrtCJ3pUOEAEgkdfZR2CdAaABwIvS1QLIAQGpAvz2QTl0g4Q-qAMBqgTYAU_Qqxm2rwrxquLumrh8d7D4njnB-c1Tc7qZ6vPoCV_lffzWxB3qsPdWMedZhulXSuW_rKMTYeZJq1WJmGnrdeBs0ADMgPvGn2br0OnzT5UVwqs4uaZcV6JTUxu_hbDb4HjhH5T_oewL8H7kjao6yq-ktuVlGyFYWnU94f0yOBtBDAMlyP_YAYqZRs11ZK4zNrInOAVggwF0a4bfvePO0QaniOByloW2NcBfp8-Wxgfa_KLp3loZ6klLa6gu-nFN6Lg-foqmyI5wG9MZss5cSy4pcB3ZBpgaAcAEytGIjv0CgAeo9K2qAagH1ckbqAfw2RuoB_LZG6gHlJixAqgHpd8bqAeOzhuoB5PYG6gHugaoB-6WsQKoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgb2AcB0ggJCIDhgEAQARgfsQnotiMT-7_6yIAKAZgLAcgLAbgMAdgTDYgUBQ&ae=1&num=1&cid=CAASPeRoJ82hafIowpge1KcNEm7aL6Twdd3dtWhEk37_pP8R9CgahwTZ1KiqgDskdA4DnLVYcHcrKlC-8FLVGJ8&sig=AOD64_08CBm-5cUK4l0xLEf_8993-emzLA&client=ca-pub-6330872677300335&nb=0&adurl=https://www.yisu.com/hk/huodong.html%3Ff%3Dgoogle%26plan%3Dhkfuwuqirenqun%26unit%3Drenqunshouzhong%26keyword%3Dhk%26eyisu%3Dgoogle20200101%26gclid%3DEAIaIQobChMI7Y3d76az7QIVRmeWCh3Riwu6EAEYASAAEgIcmvD_BwE)

[亿速云香港服务器低延时,性能稳定有保障，CN2 高速连接ping值低，24x7技术在线,售后无忧!](https://www.googleadservices.com/pagead/aclk?sa=L&ai=C8gD6HqLJX-2GBMbO2QTRl67QC7TQ5bhgi-2W7bMLrtCJ3pUOEAEgkdfZR2CdAaABwIvS1QLIAQGpAvz2QTl0g4Q-qAMBqgTYAU_Qqxm2rwrxquLumrh8d7D4njnB-c1Tc7qZ6vPoCV_lffzWxB3qsPdWMedZhulXSuW_rKMTYeZJq1WJmGnrdeBs0ADMgPvGn2br0OnzT5UVwqs4uaZcV6JTUxu_hbDb4HjhH5T_oewL8H7kjao6yq-ktuVlGyFYWnU94f0yOBtBDAMlyP_YAYqZRs11ZK4zNrInOAVggwF0a4bfvePO0QaniOByloW2NcBfp8-Wxgfa_KLp3loZ6klLa6gu-nFN6Lg-foqmyI5wG9MZss5cSy4pcB3ZBpgaAcAEytGIjv0CgAeo9K2qAagH1ckbqAfw2RuoB_LZG6gHlJixAqgHpd8bqAeOzhuoB5PYG6gHugaoB-6WsQKoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgb2AcB0ggJCIDhgEAQARgfsQnotiMT-7_6yIAKAZgLAcgLAbgMAdgTDYgUBQ&ae=1&num=1&cid=CAASPeRoJ82hafIowpge1KcNEm7aL6Twdd3dtWhEk37_pP8R9CgahwTZ1KiqgDskdA4DnLVYcHcrKlC-8FLVGJ8&sig=AOD64_08CBm-5cUK4l0xLEf_8993-emzLA&client=ca-pub-6330872677300335&nb=7&adurl=https://www.yisu.com/hk/huodong.html%3Ff%3Dgoogle%26plan%3Dhkfuwuqirenqun%26unit%3Drenqunshouzhong%26keyword%3Dhk%26eyisu%3Dgoogle20200101%26gclid%3DEAIaIQobChMI7Y3d76az7QIVRmeWCh3Riwu6EAEYASAAEgIcmvD_BwE)

[ 立即选购](https://www.googleadservices.com/pagead/aclk?sa=L&ai=C8gD6HqLJX-2GBMbO2QTRl67QC7TQ5bhgi-2W7bMLrtCJ3pUOEAEgkdfZR2CdAaABwIvS1QLIAQGpAvz2QTl0g4Q-qAMBqgTYAU_Qqxm2rwrxquLumrh8d7D4njnB-c1Tc7qZ6vPoCV_lffzWxB3qsPdWMedZhulXSuW_rKMTYeZJq1WJmGnrdeBs0ADMgPvGn2br0OnzT5UVwqs4uaZcV6JTUxu_hbDb4HjhH5T_oewL8H7kjao6yq-ktuVlGyFYWnU94f0yOBtBDAMlyP_YAYqZRs11ZK4zNrInOAVggwF0a4bfvePO0QaniOByloW2NcBfp8-Wxgfa_KLp3loZ6klLa6gu-nFN6Lg-foqmyI5wG9MZss5cSy4pcB3ZBpgaAcAEytGIjv0CgAeo9K2qAagH1ckbqAfw2RuoB_LZG6gHlJixAqgHpd8bqAeOzhuoB5PYG6gHugaoB-6WsQKoB6a-G6gH7NUbqAfz0RuoB-zVG6gHltgb2AcB0ggJCIDhgEAQARgfsQnotiMT-7_6yIAKAZgLAcgLAbgMAdgTDYgUBQ&ae=1&num=1&cid=CAASPeRoJ82hafIowpge1KcNEm7aL6Twdd3dtWhEk37_pP8R9CgahwTZ1KiqgDskdA4DnLVYcHcrKlC-8FLVGJ8&sig=AOD64_08CBm-5cUK4l0xLEf_8993-emzLA&client=ca-pub-6330872677300335&nb=8&adurl=https://www.yisu.com/hk/huodong.html%3Ff%3Dgoogle%26plan%3Dhkfuwuqirenqun%26unit%3Drenqunshouzhong%26keyword%3Dhk%26eyisu%3Dgoogle20200101%26gclid%3DEAIaIQobChMI7Y3d76az7QIVRmeWCh3Riwu6EAEYASAAEgIcmvD_BwE)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='55' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='53' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

![lg.php](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

8 个回答

 [得票](https://segmentfault.com/q/1010000016147496#comment-area)[时间](https://segmentfault.com/q/1010000016147496?sort=created#comment-area)

 [![1173633761-5b04f3e942c9c_big64](../_resources/382fbed58e0259b69bf0a422141eb9aa.jpg)  **xianshenglu**](https://segmentfault.com/u/xianshenglu)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='12'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z' data-evernote-id='452' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  4.3k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='13'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z' data-evernote-id='456' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://github.com/xianshenglu)

### 基础知识

在你看答案之前，我希望你至少了解

- `promise` 的 executor（执行器） 里的代码是同步的
- `promise` 的回调是 microTask（微任务） 而 `setTimeout` 的回调是 task（任务/宏任务）
- microTask 早于 task 被执行。

### 精简题目

我把这道题精简下，先把同步的代码和 `setTimeout` 的代码删掉，再来解释（期间 `await` 的部分规范有变动）。
再精简下，问题就是这样：

	async function async1(){
	  await async2()
	  console.log('async1 end')
	}
	async function async2(){}
	async1();
	new Promise(function(resolve){
	  resolve();
	}).then(function(){
	  console.log('promise2')
	}).then(function() {
	  console.log('promise3')
	}).then(function() {
	  console.log('promise4')
	})

为什么在 chrome canary 73 返回

	async1 end
	promise2
	promise3
	promise4

而在 chrome 70 上返回

	promise2
	promise3
	async1 end
	promise4

### 正文

我对 `promise` 稍微熟悉些，其实也不熟，但是把 `await` 转成 `promise` 会相对好理解些，不知道有没有同感？
这道题其实问的是
`await async2()`>  怎么理解？
因为 `async` 函数总是返回一个 `promise`，所以其实就是在问
`await promise`>  怎么理解？
那么我们看下规范 [Await](https://tc39.github.io/ecma262/#await)
![bVblHuz](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107175307.png)
根据提示

	async function async1(){
	  await async2()
	  console.log('async1 end')
	}

等价于

	async function async1() {
	  return new Promise(resolve => {
	    resolve(async2())
	  }).then(() => {
	    console.log('async1 end')
	  })
	}

与[@Jialiang_T](https://segmentfault.com/u/jialiang_tong)同学给出的一致，但是到这里，仍然不太好理解，
> 因为 `RESOLVE(async2())`>  并不等于 `Promise.resolve(async2())`
为了行文方便，这里开始我们用 `RESOLVE` 来表示 `Promise` 构造器里的 `resolve`，例如：

	new Promise(resolve=>{
	    resolve()
	})

之所以这样，因为 `async2()` 返回一个 `promise`, 是一个 `thenable` 对象，`RESOLVE(thenable)` 并不等于 `Promise.resolve(thenable)` ，而 `RESOLVE(non-thenable)` 等价于 `Promise.resolve(non-thenable)`，具体对照规范的解释请戳

> [> What's the difference between resolve(promise) and resolve('non-thenable-object')?](https://stackoverflow.com/questions/53894038/whats-the-difference-between-resolvepromise-and-resolvenon-thenable-object)

结论就是：`RESOLVE(thenable)` 和 `Promise.resolve(thenable)` 的转换关系是这样的，

	new Promise(resolve=>{
	  resolve(thenable)
	})

会被转换成

	new Promise(resolve => {
	  Promise.resolve().then(() => {
	    thenable.then(resolve)
	  })
	})

那么对于 `RESOLVE(async2())`，我们可以根据规范转换成：

	Promise.resolve().then(() => {
	    async2().then(resolve)
	})

所以 `async1` 就变成了这样：

	async function async1() {
	  return new Promise(resolve => {
	    Promise.resolve().then(() => {
	      async2().then(resolve)
	    })
	  }).then(() => {
	    console.log('async1 end')
	  })
	}

同样，因为 `RESOLVE()` 就等价于 `Promise.resolve()`,所以

	new Promise(function(resolve){
	  resolve();
	})

等价于
`Promise.resolve()`
所以，题目

	async function async1(){
	  await async2()
	  console.log('async1 end')
	}
	async function async2(){}
	async1();
	new Promise(function(resolve){
	  resolve();
	}).then(function(){
	  console.log('promise2')
	}).then(function() {
	  console.log('promise3')
	}).then(function() {
	  console.log('promise4')
	})

就等价于

	async function async1 () {
	  return new Promise(resolve => {
	    Promise.resolve().then(() => {
	      async2().then(resolve)
	    })
	  }).then(() => {
	    console.log('async1 end')
	  })
	}
	async function async2 () {}
	async1()
	Promise.resolve()
	  .then(function () {
	    console.log('promise2')
	  })
	  .then(function () {
	    console.log('promise3')
	  })
	  .then(function () {
	    console.log('promise4')
	  })

这就是根据当前规范解释的结果， chrome 70 和 chrome canary 73 上得到的都是一样的。

	promise2
	promise3
	async1 end
	promise4

### Await 规范的更新

那么为什么，chrome 73 现在得到的结果不一样了呢？修改的决议在[这里](https://github.com/tc39/ecma262/pull/1250)，目前是这个状态。

![bVblHRK](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107175314.png)
就像你所看到的一样，为什么要把 `async1`

	async function async1(){
	  await async2()
	  console.log('async1 end')
	}

转换成

	async function async1() {
	  return new Promise(resolve => {
	    Promise.resolve().then(() => {
	      async2().then(resolve)
	    })
	  }).then(() => {
	    console.log('async1 end')
	  })
	}

而不是直接

	async function async1 () {
	  async2().then(() => {
	    console.log('async1 end')
	  })
	}

这样是不是更简单直接，容易理解，且提高性能了呢？如果要这样的话，也就是说，

	async function async1(){
	  await async2()
	  console.log('async1 end')
	}

`async1`不采用 `new Promise` 来包装，也就是不走下面这条路：

	async function async1() {
	  return new Promise(resolve => {
	    resolve(async2())
	  }).then(() => {
	    console.log('async1 end')
	  })
	}

而是直接采用 `Promise.resolve()` 来包装，也就是

	async function async1() {
	  Promise.resolve(async2()).then(() => {
	    console.log('async1 end')
	  })
	}

又因为 `async2()` 返回一个 `promise`, 根据规范[Promise.resolve](https://tc39.github.io/ecma262/#sec-promise.resolve)，

![bVblH1C](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107175320.png)

所以 `Promise.resolve(promise)` 返回 `promise`, 即`Promise.resolve(async2())` 等价于 `async2()` ，所以最终得到了代码

	async function async1 () {
	  async2().then(() => {
	    console.log('async1 end')
	  })
	}

这就是[贺老师在知乎里所说的](https://www.zhihu.com/question/268007969/answer/339811998)
> 根据 TC39 最近决议，await将直接使用Promise.resolve()相同语义。
tc39 的 spec 的更改体现在
![bVblHTj](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107175324.png)
chrome canary 73 采用了这种实现，所以题目

	async function async1(){
	  await async2()
	  console.log('async1 end')
	}
	async function async2(){}
	async1();
	new Promise(function(resolve){
	  resolve();
	}).then(function(){
	  console.log('promise2')
	}).then(function() {
	  console.log('promise3')
	}).then(function() {
	  console.log('promise4')
	})

在 chrome canary 73及未来可能被解析为

	async function async1 () {
	  async2().then(() => {
	    console.log('async1 end')
	  })
	}
	async function async2 () {}
	async1()
	new Promise(function (resolve) {
	  resolve()
	})
	  .then(function () {
	    console.log('promise2')
	  })
	  .then(function () {
	    console.log('promise3')
	  })
	  .then(function () {
	    console.log('promise4')
	  })
	
	*//async1 end*
	*//promise2*
	*//promise3*
	*//promise4*

在 chrome 70 被解析为，

	async function async1 () {
	  return new Promise(resolve => {
	    Promise.resolve().then(() => {
	      async2().then(resolve)
	    })
	  }).then(() => {
	    console.log('async1 end')
	  })
	}
	async function async2 () {}
	async1()
	Promise.resolve()
	  .then(function () {
	    console.log('promise2')
	  })
	  .then(function () {
	    console.log('promise3')
	  })
	  .then(function () {
	    console.log('promise4')
	  })
	
	*//promise2*
	*//promise3*
	*//async1 end*
	*//promise4*

转换后的代码，你应该能够看得懂了，如果看不懂，说明你需要补一补 promise 的课了。
2018.12.26

- 如有错误，欢迎指正，
- 最后，感谢 [@Jialiang_T](https://segmentfault.com/u/jialiang_tong) 提醒了我对 `resolve(thenable)` 和 `Promise.resolve(thenable)` 的思考，也就是 SO 的那个问题。
- 我博客里加了一篇 [async, promise order](https://github.com/xianshenglu/blog/issues/60) 内容与这个重复较多，思路稍微清晰些，另外多加了一部分对于 `async` 的转换分析，不过是英文的，自己斟酌要不要去看看，如果觉得不错的话，留言，我可以再翻译成中文。

 [评论](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [赞赏](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [更新于 7月14日](https://segmentfault.com/q/1010000016147496/a-1020000017464001)

- [**Jialiang_T**](https://segmentfault.com/u/jialiang_tong)：

感谢你一致关注这个问题！看了你在blog中提供的两个stackoverflow上的问题和[tc39规范](https://tc39.github.io/ecma262/#sec-promise-abstract-operations)中*25.6.5.4 Promise.prototype.then*和*25.6.5.4.1 PerformPromiseThen*，我有了一些思路：

    1. `resolve(promise)`中`resolve`的值是一个`promise`，同样也是一个`thenable`，所以会执行`EnqueueJob("PromiseJobs", PromiseResolveThenableJob, <<promise, resolution, thenAction>>)`，这是进入队列的第一个Job
    
    2. 在第一个Job`<PromiseResolveThenableJob(promiseToResolve, thenable, then)>`执行中，会创建和`promiseToResolve`关联的`resolve function`和`reject function`，然后同步调用`thenable.then(resolve, reject)`
    
    3. 一般的，对于普通的thenable对象（非Promise），2中最后的操作会通过`resolve`或`reject`函数更改Promise的状态，并触发后续通过`then`注册的回调，但如果传入的`thenable`是一个`Promise`，情况就不同了（下面解释...）
    
    4. 传入的`thenable`是一个`Promise`，则2中最后调用的就是`Promise.prototype.then(onfulfilled, onrejected)`，2中的`resolve`作为`onfulfilled`，`reject`作为`onrejected`
    
    5. 后面就是`Promise.prototype.then`的"常规操作"了……`Promise.prototype.then`会在内部创建一个`promiseCapability`，它包含了一个新的`Promise`和相关联的`resolve function`和`reject function`
    
    6. 根据`promiseCapability`和`onfulfilled/onrejected`创建两个分别用于`fulfill`和`reject`的PromiseReaction，也就是 PromiseJobs 里最终要执行的操作
    
    7. 如果当前的`promise(this)`（这里实际上是1中传入的`thenable`）是`pending`状态，则把这两个在6中生成的`reaction`分别插入到`promise`的`[[PromiseFulfillReactions]]`和`[[PromiseRejectReactions]]`队列中。如果`promise`已经`fulfilled`或`rejected`，就从`promise`的`[[PromiseResult]]`取出`result`，作为`fulfilled/reject`的结果，然后`EnqueueJob("PromiseJobs", PromiseReactionJob, <<reaciton, result>>)`插入到Job队列，最后返回 `prjomiseCapability`里存储`promise`.
    
    - 所以最后，回到我们一开始的问题，`new Promise(r => r(new Promise(r => r(50))))`，在第一个`Job(PromiseResolveThenableJob)`执行中，执行了`Promise.prototype.then`，而这时的`Promise`已经是`<resolved>: 50`了，所以在`then`执行中再一次创建了一个Job: `EnqueueJob("PromiseJobs", PromiseReactionJob, <<reaciton, result>>)`，`result = 50`，最终结果就是额外创建了两个Job，被推迟了2个时序，我想这应该就是问题的答案了。

 [  ![](async%20await%20%E5%92%8C%20promise%E5%BE%AE%E4%BB%BB%E5%8A%A1%E6%89%A7%E8%A1%8C%E9%A1%BA%E5%BA%8F%E9%97%AE%E9%A2%98%20-%20SegmentFault%20%E6%80%9D%E5%90%A6.md# class='svg-inline--fa fa-thumbs-up fa-w-16 mr-1 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='thumbs-up' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='17'%3e%3cpath fill='currentColor' d='M466.27 286.69C475.04 271.84 480 256 480 236.85c0-44.015-37.218-85.58-85.82-85.58H357.7c4.92-12.81 8.85-28.13 8.85-46.54C366.55 31.936 328.86 0 271.28 0c-61.607 0-58.093 94.933-71.76 108.6-22.747 22.747-49.615 66.447-68.76 83.4H32c-17.673 0-32 14.327-32 32v240c0 17.673 14.327 32 32 32h64c14.893 0 27.408-10.174 30.978-23.95 44.509 1.001 75.06 39.94 177.802 39.94 7.22 0 15.22.01 22.22.01 77.117 0 111.986-39.423 112.94-95.33 13.319-18.425 20.299-43.122 17.34-66.99 9.854-18.452 13.664-40.343 8.99-62.99zm-61.75 53.83c12.56 21.13 1.26 49.41-13.94 57.57 7.7 48.78-17.608 65.9-53.12 65.9h-37.82c-71.639 0-118.029-37.82-171.64-37.82V240h10.92c28.36 0 67.98-70.89 94.54-97.46 28.36-28.36 18.91-75.63 37.82-94.54 47.27 0 47.27 32.98 47.27 56.73 0 39.17-28.36 56.72-28.36 94.54h103.99c21.11 0 37.73 18.91 37.82 37.82.09 18.9-12.82 37.81-22.27 37.81 13.489 14.555 16.371 45.236-5.21 65.62zM88 432c0 13.255-10.745 24-24 24s-24-10.745-24-24 10.745-24 24-24 24 10.745 24 24z'%3e%3c/path%3e%3c/svg%3e)     1](#)    [回复](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    2018-12-26

- [**Jialiang_T**](https://segmentfault.com/u/jialiang_tong)：

Chrome 71中，根据规范`await p`近似于
`return new Promise(resolve => resolve(p))`
Chrome 73中，规范变了，`await p`近似于`return Promise.resolve(p)`

 [  ![](async%20await%20%E5%92%8C%20promise%E5%BE%AE%E4%BB%BB%E5%8A%A1%E6%89%A7%E8%A1%8C%E9%A1%BA%E5%BA%8F%E9%97%AE%E9%A2%98%20-%20SegmentFault%20%E6%80%9D%E5%90%A6.md# class='svg-inline--fa fa-thumbs-up fa-w-16 mr-1 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='thumbs-up' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='18'%3e%3cpath fill='currentColor' d='M466.27 286.69C475.04 271.84 480 256 480 236.85c0-44.015-37.218-85.58-85.82-85.58H357.7c4.92-12.81 8.85-28.13 8.85-46.54C366.55 31.936 328.86 0 271.28 0c-61.607 0-58.093 94.933-71.76 108.6-22.747 22.747-49.615 66.447-68.76 83.4H32c-17.673 0-32 14.327-32 32v240c0 17.673 14.327 32 32 32h64c14.893 0 27.408-10.174 30.978-23.95 44.509 1.001 75.06 39.94 177.802 39.94 7.22 0 15.22.01 22.22.01 77.117 0 111.986-39.423 112.94-95.33 13.319-18.425 20.299-43.122 17.34-66.99 9.854-18.452 13.664-40.343 8.99-62.99zm-61.75 53.83c12.56 21.13 1.26 49.41-13.94 57.57 7.7 48.78-17.608 65.9-53.12 65.9h-37.82c-71.639 0-118.029-37.82-171.64-37.82V240h10.92c28.36 0 67.98-70.89 94.54-97.46 28.36-28.36 18.91-75.63 37.82-94.54 47.27 0 47.27 32.98 47.27 56.73 0 39.17-28.36 56.72-28.36 94.54h103.99c21.11 0 37.73 18.91 37.82 37.82.09 18.9-12.82 37.81-22.27 37.81 13.489 14.555 16.371 45.236-5.21 65.62zM88 432c0 13.255-10.745 24-24 24s-24-10.745-24-24 10.745-24 24-24 24 10.745 24 24z'%3e%3c/path%3e%3c/svg%3e)](#)    [回复](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    2018-12-21

- [**Jialiang_T**](https://segmentfault.com/u/jialiang_tong)：

`return new Promise(resolve => resolve(p))`和`return Promise.resolve(p)`的差异会导致异步任务在时序上的差异

 [  ![](async%20await%20%E5%92%8C%20promise%E5%BE%AE%E4%BB%BB%E5%8A%A1%E6%89%A7%E8%A1%8C%E9%A1%BA%E5%BA%8F%E9%97%AE%E9%A2%98%20-%20SegmentFault%20%E6%80%9D%E5%90%A6.md# class='svg-inline--fa fa-thumbs-up fa-w-16 mr-1 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='thumbs-up' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='19'%3e%3cpath fill='currentColor' d='M466.27 286.69C475.04 271.84 480 256 480 236.85c0-44.015-37.218-85.58-85.82-85.58H357.7c4.92-12.81 8.85-28.13 8.85-46.54C366.55 31.936 328.86 0 271.28 0c-61.607 0-58.093 94.933-71.76 108.6-22.747 22.747-49.615 66.447-68.76 83.4H32c-17.673 0-32 14.327-32 32v240c0 17.673 14.327 32 32 32h64c14.893 0 27.408-10.174 30.978-23.95 44.509 1.001 75.06 39.94 177.802 39.94 7.22 0 15.22.01 22.22.01 77.117 0 111.986-39.423 112.94-95.33 13.319-18.425 20.299-43.122 17.34-66.99 9.854-18.452 13.664-40.343 8.99-62.99zm-61.75 53.83c12.56 21.13 1.26 49.41-13.94 57.57 7.7 48.78-17.608 65.9-53.12 65.9h-37.82c-71.639 0-118.029-37.82-171.64-37.82V240h10.92c28.36 0 67.98-70.89 94.54-97.46 28.36-28.36 18.91-75.63 37.82-94.54 47.27 0 47.27 32.98 47.27 56.73 0 39.17-28.36 56.72-28.36 94.54h103.99c21.11 0 37.73 18.91 37.82 37.82.09 18.9-12.82 37.81-22.27 37.81 13.489 14.555 16.371 45.236-5.21 65.62zM88 432c0 13.255-10.745 24-24 24s-24-10.745-24-24 10.745-24 24-24 24 10.745 24 24z'%3e%3c/path%3e%3c/svg%3e)](#)    [回复](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    2018-12-21

[展开显示更多](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)

 [![678744052-5b6b8f18b4efe_big64](../_resources/4048a5539ca0a128040f7ec3e7378ba7.jpg)  **Jialiang_T**](https://segmentfault.com/u/jialiang_tong)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='20'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  177

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='21'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z'%3e%3c/path%3e%3c/svg%3e)](https://github.com/Zousdie)

说一下我个人的理解，如有错误还望指正。
这个问题涉及以下3点:
1. async 函数的返回值
2. Promise 链式 then() 的执行时机
3. async 函数中的 await 操作符到底做了什么
下面一一回答：
1. async 函数的返回值:

    - 被 async 操作符修饰的函数**必然返回一个 Promise 对象**
    - 当 async 函数返回一个值时，Promise 的 resolve 方法负责传递这个值
    - 当 async 函数抛出异常时，Promise 的 reject 方法会传递这个异常值
    - 所以，以示例代码中 async2 为例，其等价于

	function async2(){
	  console.log('async2');
	  return Promise.resolve();
	}

2. Promise 链式 then() 的执行时机

    - 多个 then() 链式调用，**并不是连续的创建了多个微任务并推入微任务队列**，因为 then() 的返回值必然是一个 Promise，而后续的 then() 是上一步 then() 返回的 Promise 的回调
    - 以示例代码为例:

	...

	new Promise(function(resolve){
	  console.log('promise1')
	  resolve();
	}).then(function(){
	  console.log('promise2')
	}).then(function() {
	  console.log('promise3')
	})

	...

        - Promise 构造器内部的同步代码执行到 `resolve()`，Promise 的状态改变为 fulfillment, then 中传入的回调函数`console.log('promise2')`作为一个微任务推入微任务队列
        - **而第二个 then 中传入的回调函数`console.log('promise3')`还没有被推入微任务队列，只有上一个 then 中的`console.log('promise2')`执行完毕后，`console.log('promise3')`才会被推入微任务队列，**这是一个关键点

3. async 函数中的 await 操作符到底做了什么

    - 按照规范，我们可以做个转化：

	async function async1(){
	  console.log('async1 start')
	  await async2()
	  console.log('async1 end')
	}

可以转化为：

	function async1(){
	  console.log('async1 start')
	  return RESOLVE(async2())
	      .then(() => { console.log('async1 end') });
	}
	
	- **问题关键就出在这个 `RESOLVE` 上了**，要引用以下知乎上[贺师俊大佬的回答](https://www.zhihu.com/question/268007969/answer/339811998)：
	    - `RESOLVE(p)`接近于`Promise.resolve(p)`，不过有微妙而重要的区别：p 如果本身已经是 Promise 实例，Promise.resolve 会直接返回 p 而不是产生一个新 promise；
	    - 如果`RESOLVE(p)`严格按照标准，应该产生一个新的 promise，尽管该 promise 确定会 resolve 为 p，**但这个过程本身是异步的**，也就是现在进入 job 队列的是**新 promise 的 resolve 过程**，所以该 promise 的 then 不会被立即调用，而要等到当前 job 队列执行到前述 resolve 过程才会被调用，然后其回调（也就是继续 await 之后的语句）才加入 job 队列，所以时序上就晚了
	- 所以上述的 async1 函数我们可以进一步转换一下：
	
	function async1(){
	  console.log('async1 start')
	  return new Promise(resolve => resolve(async2()))
	    .then(() => {
	      console.log('async1 end')
	    });
	}

**说到最后，最终示例代码近似等价于以下的代码：**

	function async1(){
	    console.log('async1 start')
	    return new Promise(resolve => resolve(async2()))
	        .then(() => {
	            console.log('async1 end')
	        });
	}
	function async2(){
	  console.log('async2');
	  return Promise.resolve();
	}
	console.log('script start')
	setTimeout(function(){
	  console.log('setTimeout')
	},0)
	async1();
	new Promise(function(resolve){
	  console.log('promise1')
	  resolve();
	}).then(function(){
	  console.log('promise2')
	}).then(function() {
	  console.log('promise3')
	}).then(function() {
	  console.log('promise4')
	}).then(function() {
	  console.log('promise5')
	}).then(function() {
	  console.log('promise6')
	}).then(function() {
	  console.log('promise7')
	}).then(function() {
	  console.log('promise8')
	})
	console.log('script end')

看了最后转换的代码，你应该明白了吧。现在你可以把它粘贴到最新版本的chrome中试试啦！

最后说个题外话，关于`RESOLVE(p)`的实现，在旧版本的V8中是不一样的（进行了激进优化，可以简单理解为没有按照规范返回一个新 Promise），所以最终的运行结果也不一致

参考：

- [「译」更快的 async 函数和 promises](https://juejin.im/post/5beea5f5f265da61590b40cd)
- [async/await 在chrome 环境和 node 环境的 执行结果不一致，求解？](https://www.zhihu.com/question/268007969/answer/339811998)

 [评论](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [赞赏](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [发布于 2018-12-19](https://segmentfault.com/q/1010000016147496/a-1020000017428916)

- [**代码宇宙**](https://segmentfault.com/u/universe_of_code)：

到位

 [  ![](async%20await%20%E5%92%8C%20promise%E5%BE%AE%E4%BB%BB%E5%8A%A1%E6%89%A7%E8%A1%8C%E9%A1%BA%E5%BA%8F%E9%97%AE%E9%A2%98%20-%20SegmentFault%20%E6%80%9D%E5%90%A6.md# class='svg-inline--fa fa-thumbs-up fa-w-16 mr-1 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='thumbs-up' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='24'%3e%3cpath fill='currentColor' d='M466.27 286.69C475.04 271.84 480 256 480 236.85c0-44.015-37.218-85.58-85.82-85.58H357.7c4.92-12.81 8.85-28.13 8.85-46.54C366.55 31.936 328.86 0 271.28 0c-61.607 0-58.093 94.933-71.76 108.6-22.747 22.747-49.615 66.447-68.76 83.4H32c-17.673 0-32 14.327-32 32v240c0 17.673 14.327 32 32 32h64c14.893 0 27.408-10.174 30.978-23.95 44.509 1.001 75.06 39.94 177.802 39.94 7.22 0 15.22.01 22.22.01 77.117 0 111.986-39.423 112.94-95.33 13.319-18.425 20.299-43.122 17.34-66.99 9.854-18.452 13.664-40.343 8.99-62.99zm-61.75 53.83c12.56 21.13 1.26 49.41-13.94 57.57 7.7 48.78-17.608 65.9-53.12 65.9h-37.82c-71.639 0-118.029-37.82-171.64-37.82V240h10.92c28.36 0 67.98-70.89 94.54-97.46 28.36-28.36 18.91-75.63 37.82-94.54 47.27 0 47.27 32.98 47.27 56.73 0 39.17-28.36 56.72-28.36 94.54h103.99c21.11 0 37.73 18.91 37.82 37.82.09 18.9-12.82 37.81-22.27 37.81 13.489 14.555 16.371 45.236-5.21 65.62zM88 432c0 13.255-10.745 24-24 24s-24-10.745-24-24 10.745-24 24-24 24 10.745 24 24z'%3e%3c/path%3e%3c/svg%3e)](#)    [回复](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    2018-12-19

- [**joy钰**](https://segmentfault.com/u/joy_yu)：

挺到位，不过其中promise执行顺序有个疑问，我简化了一下疑问代码。

	var a = new Promise(function(resolve){
	  resolve(Promise.resolve())
	}).then(function() {
	  console.log('async1 end')
	})
	
	var b = new Promise(function(resolve){
	  resolve()
	}).then(function() {
	  console.log('promise2')
	}).then(function() {
	  console.log('promise3')
	}).then(function() {
	  console.log('promise4')
	}).then(function() {
	  console.log('promise5')
	})

能解释一下这里的执行顺序，具体的微任务队列是什么样的？

 [  ![](async%20await%20%E5%92%8C%20promise%E5%BE%AE%E4%BB%BB%E5%8A%A1%E6%89%A7%E8%A1%8C%E9%A1%BA%E5%BA%8F%E9%97%AE%E9%A2%98%20-%20SegmentFault%20%E6%80%9D%E5%90%A6.md# class='svg-inline--fa fa-thumbs-up fa-w-16 mr-1 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='thumbs-up' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='25'%3e%3cpath fill='currentColor' d='M466.27 286.69C475.04 271.84 480 256 480 236.85c0-44.015-37.218-85.58-85.82-85.58H357.7c4.92-12.81 8.85-28.13 8.85-46.54C366.55 31.936 328.86 0 271.28 0c-61.607 0-58.093 94.933-71.76 108.6-22.747 22.747-49.615 66.447-68.76 83.4H32c-17.673 0-32 14.327-32 32v240c0 17.673 14.327 32 32 32h64c14.893 0 27.408-10.174 30.978-23.95 44.509 1.001 75.06 39.94 177.802 39.94 7.22 0 15.22.01 22.22.01 77.117 0 111.986-39.423 112.94-95.33 13.319-18.425 20.299-43.122 17.34-66.99 9.854-18.452 13.664-40.343 8.99-62.99zm-61.75 53.83c12.56 21.13 1.26 49.41-13.94 57.57 7.7 48.78-17.608 65.9-53.12 65.9h-37.82c-71.639 0-118.029-37.82-171.64-37.82V240h10.92c28.36 0 67.98-70.89 94.54-97.46 28.36-28.36 18.91-75.63 37.82-94.54 47.27 0 47.27 32.98 47.27 56.73 0 39.17-28.36 56.72-28.36 94.54h103.99c21.11 0 37.73 18.91 37.82 37.82.09 18.9-12.82 37.81-22.27 37.81 13.489 14.555 16.371 45.236-5.21 65.62zM88 432c0 13.255-10.745 24-24 24s-24-10.745-24-24 10.745-24 24-24 24 10.745 24 24z'%3e%3c/path%3e%3c/svg%3e)](#)    [回复](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    2018-12-19

- [**xianshenglu**](https://segmentfault.com/u/xianshenglu)：

这是我理解的：
    1. RESOLVE(async2()) 进入队列
    2. promise2 进入队列
    3. RESOLVE(p) 出列，async1 end 入列
    4. promise2 log 出列,promise3 入列
    5. async1 end log 出列，promise3 log 出列
请问， promise3 log 为什么会在 async1 end log 之前？

 [  ![](async%20await%20%E5%92%8C%20promise%E5%BE%AE%E4%BB%BB%E5%8A%A1%E6%89%A7%E8%A1%8C%E9%A1%BA%E5%BA%8F%E9%97%AE%E9%A2%98%20-%20SegmentFault%20%E6%80%9D%E5%90%A6.md# class='svg-inline--fa fa-thumbs-up fa-w-16 mr-1 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='thumbs-up' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='26'%3e%3cpath fill='currentColor' d='M466.27 286.69C475.04 271.84 480 256 480 236.85c0-44.015-37.218-85.58-85.82-85.58H357.7c4.92-12.81 8.85-28.13 8.85-46.54C366.55 31.936 328.86 0 271.28 0c-61.607 0-58.093 94.933-71.76 108.6-22.747 22.747-49.615 66.447-68.76 83.4H32c-17.673 0-32 14.327-32 32v240c0 17.673 14.327 32 32 32h64c14.893 0 27.408-10.174 30.978-23.95 44.509 1.001 75.06 39.94 177.802 39.94 7.22 0 15.22.01 22.22.01 77.117 0 111.986-39.423 112.94-95.33 13.319-18.425 20.299-43.122 17.34-66.99 9.854-18.452 13.664-40.343 8.99-62.99zm-61.75 53.83c12.56 21.13 1.26 49.41-13.94 57.57 7.7 48.78-17.608 65.9-53.12 65.9h-37.82c-71.639 0-118.029-37.82-171.64-37.82V240h10.92c28.36 0 67.98-70.89 94.54-97.46 28.36-28.36 18.91-75.63 37.82-94.54 47.27 0 47.27 32.98 47.27 56.73 0 39.17-28.36 56.72-28.36 94.54h103.99c21.11 0 37.73 18.91 37.82 37.82.09 18.9-12.82 37.81-22.27 37.81 13.489 14.555 16.371 45.236-5.21 65.62zM88 432c0 13.255-10.745 24-24 24s-24-10.745-24-24 10.745-24 24-24 24 10.745 24 24z'%3e%3c/path%3e%3c/svg%3e)](#)    [回复](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    2018-12-19

[展开显示更多](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)

 [![701054459-5c2c136adfb55_big64](../_resources/86ec5b18b43adb5a0c911d73941afbf2.png)  **micherwa**](https://segmentfault.com/u/micherwa)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='27'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  5.2k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='28'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z'%3e%3c/path%3e%3c/svg%3e)](https://github.com/micherwa)

关于浏览器中的执行顺序，在目前最新版的chromeV71中会有点问题。会在下个版本中改进，你也可以用自己的工程跑一下，然后用babel的stage-3编译一把，以babel的编译结果为准吧。

具体可以参考，我写的[这篇文章](https://mp.weixin.qq.com/s/tXs1YFiheNkuaRfGPRzvTg)。其中也遇到了时序问题。

 [评论](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [赞赏](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [更新于 2018-12-21](https://segmentfault.com/q/1010000016147496/a-1020000017474254)

- [**yr1014**](https://segmentfault.com/u/yr1014)：

感谢作者的文章和回答

 [  ![](async%20await%20%E5%92%8C%20promise%E5%BE%AE%E4%BB%BB%E5%8A%A1%E6%89%A7%E8%A1%8C%E9%A1%BA%E5%BA%8F%E9%97%AE%E9%A2%98%20-%20SegmentFault%20%E6%80%9D%E5%90%A6.md# class='svg-inline--fa fa-thumbs-up fa-w-16 mr-1 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='thumbs-up' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='31'%3e%3cpath fill='currentColor' d='M466.27 286.69C475.04 271.84 480 256 480 236.85c0-44.015-37.218-85.58-85.82-85.58H357.7c4.92-12.81 8.85-28.13 8.85-46.54C366.55 31.936 328.86 0 271.28 0c-61.607 0-58.093 94.933-71.76 108.6-22.747 22.747-49.615 66.447-68.76 83.4H32c-17.673 0-32 14.327-32 32v240c0 17.673 14.327 32 32 32h64c14.893 0 27.408-10.174 30.978-23.95 44.509 1.001 75.06 39.94 177.802 39.94 7.22 0 15.22.01 22.22.01 77.117 0 111.986-39.423 112.94-95.33 13.319-18.425 20.299-43.122 17.34-66.99 9.854-18.452 13.664-40.343 8.99-62.99zm-61.75 53.83c12.56 21.13 1.26 49.41-13.94 57.57 7.7 48.78-17.608 65.9-53.12 65.9h-37.82c-71.639 0-118.029-37.82-171.64-37.82V240h10.92c28.36 0 67.98-70.89 94.54-97.46 28.36-28.36 18.91-75.63 37.82-94.54 47.27 0 47.27 32.98 47.27 56.73 0 39.17-28.36 56.72-28.36 94.54h103.99c21.11 0 37.73 18.91 37.82 37.82.09 18.9-12.82 37.81-22.27 37.81 13.489 14.555 16.371 45.236-5.21 65.62zM88 432c0 13.255-10.745 24-24 24s-24-10.745-24-24 10.745-24 24-24 24 10.745 24 24z'%3e%3c/path%3e%3c/svg%3e)](#)    [回复](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    2019-02-20

 [![3518098451-5b20b6a98e8d8_big64](../_resources/ebae9737ad955deb1b9f5d17bb91b222.jpg)  **码梦为生**](https://segmentfault.com/u/danxiancheng)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='32'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  1.4k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='33'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z'%3e%3c/path%3e%3c/svg%3e)](https://github.com/liuzhongbao123)

JS的时间模块也是异步的，如果说先后的话应该是settimeout先加入异步队列，awite会先等待awite之后的函数执行完毕之后再执行

 [评论](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [赞赏](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [发布于 2018-11-13](https://segmentfault.com/q/1010000016147496/a-1020000017000759)

 [![user-64.png](../_resources/328f423f1e5df4bb6baab3ec84430d81.png)  **Jeromy**](https://segmentfault.com/u/jeromy)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='36'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  60

你换node环境执行下

 [评论](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [赞赏](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [发布于 2018-11-13](https://segmentfault.com/q/1010000016147496/a-1020000016994419)

 [![3071585513-5b68519d9af27_big64](../_resources/ff4da5841dcf5542df7fe219c7837efe.jpg)  **冯恒智**](https://segmentfault.com/u/fenghengzhi)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='39'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  6.6k

标准应该没规定，我当时自己测的chrome和firefox执行顺序不一样的
刚刚测了一下,edge和chrome表现不一样的，反正这个微任务执行顺序标准没规定，具体表现要看浏览器自己怎么处理了

* * *

现在有标准了，以后所有浏览器应该有一致的表现（说实话，都是异步，除了js引擎开发者，关注谁先谁后意义没什么意义）

 [评论](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [赞赏](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [更新于 2018-12-26](https://segmentfault.com/q/1010000016147496/a-1020000016994626)

- [**yr1014**](https://segmentfault.com/u/yr1014)：

嗯嗯,thx~,之前也是测试发现不同浏览器表现不一样

 [  ![](async%20await%20%E5%92%8C%20promise%E5%BE%AE%E4%BB%BB%E5%8A%A1%E6%89%A7%E8%A1%8C%E9%A1%BA%E5%BA%8F%E9%97%AE%E9%A2%98%20-%20SegmentFault%20%E6%80%9D%E5%90%A6.md# class='svg-inline--fa fa-thumbs-up fa-w-16 mr-1 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='far' data-icon='thumbs-up' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='42'%3e%3cpath fill='currentColor' d='M466.27 286.69C475.04 271.84 480 256 480 236.85c0-44.015-37.218-85.58-85.82-85.58H357.7c4.92-12.81 8.85-28.13 8.85-46.54C366.55 31.936 328.86 0 271.28 0c-61.607 0-58.093 94.933-71.76 108.6-22.747 22.747-49.615 66.447-68.76 83.4H32c-17.673 0-32 14.327-32 32v240c0 17.673 14.327 32 32 32h64c14.893 0 27.408-10.174 30.978-23.95 44.509 1.001 75.06 39.94 177.802 39.94 7.22 0 15.22.01 22.22.01 77.117 0 111.986-39.423 112.94-95.33 13.319-18.425 20.299-43.122 17.34-66.99 9.854-18.452 13.664-40.343 8.99-62.99zm-61.75 53.83c12.56 21.13 1.26 49.41-13.94 57.57 7.7 48.78-17.608 65.9-53.12 65.9h-37.82c-71.639 0-118.029-37.82-171.64-37.82V240h10.92c28.36 0 67.98-70.89 94.54-97.46 28.36-28.36 18.91-75.63 37.82-94.54 47.27 0 47.27 32.98 47.27 56.73 0 39.17-28.36 56.72-28.36 94.54h103.99c21.11 0 37.73 18.91 37.82 37.82.09 18.9-12.82 37.81-22.27 37.81 13.489 14.555 16.371 45.236-5.21 65.62zM88 432c0 13.255-10.745 24-24 24s-24-10.745-24-24 10.745-24 24-24 24 10.745 24 24z'%3e%3c/path%3e%3c/svg%3e)](#)    [回复](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    2018-11-13

 [![2773691215-5c46ffccad2a5_big64](../_resources/ed2b55aba86b00f06782245f644016dd.jpg)  **stone**](https://segmentfault.com/u/wz102824678)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='43'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  2.3k

- [![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-github fa-w-16 js-evernote-checked' aria-hidden='true' focusable='false' data-prefix='fab' data-icon='github' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512' data-fa-i2svg='' data-evernote-id='44'%3e%3cpath fill='currentColor' d='M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z'%3e%3c/path%3e%3c/svg%3e)](https://github.com/wuzhong1030)

我的理解是，reslove调用后，会把promise2加入到任务队列，然后执行一次Event Loop

 [评论](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [赞赏](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [发布于 2018-11-13](https://segmentfault.com/q/1010000016147496/a-1020000016994688)

 [![819798919-5c85bae844348_big64](../_resources/3aa49a6470d1cc44351b26904cfb3950.jpg)  **莫莫sir**](https://segmentfault.com/u/ayue_5c1afd03c2adc)

- ![](data:image/svg+xml,%3csvg class='svg-inline--fa fa-dice-d8 fa-w-16 js-evernote-checked' style='color: %23BF7158%3b' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='dice-d8' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg='' data-evernote-id='47'%3e%3cpath fill='currentColor' d='M225.53 2.52L2.36 233.83c-4.21 4.37-2.56 11.71 3.1 13.77l234.13 85.06V8.39c-.01-7.49-8.91-11.21-14.06-5.87zm284.11 231.31L286.47 2.52C281.32-2.82 272.41.9 272.41 8.4v324.27l234.13-85.06c5.66-2.07 7.31-9.42 3.1-13.78zM33.53 310.38l192 199.1c5.15 5.34 14.06 1.62 14.06-5.88V368.29L42.13 296.61c-8.21-2.98-14.72 7.43-8.6 13.77zm436.34-13.77l-197.46 71.68V503.6c0 7.5 8.91 11.22 14.06 5.88l192-199.1c6.12-6.34-.39-16.75-8.6-13.77z'%3e%3c/path%3e%3c/svg%3e)  81

reslove调用后，会把promise2加入到任务队列，然后执行一次Event Loop

 [评论](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [赞赏](async%20await%20和%20promise微任务执行顺序问题%20-%20SegmentFault%20思否.md#)    [发布于 2018-12-24](https://segmentfault.com/q/1010000016147496/a-1020000017489741)

##### 撰写回答

登录后参与交流、获取后续更新提醒

 [立即登录](https://segmentfault.com/user/login)[免费注册](https://segmentfault.com/user/register)

##### 相似问题

[ ##### async异步代码的执行顺序求解？      2 回答   下面这段async异步代码的执行顺序有些不理解，求大神能指导指导，最好能帮忙分析下相关微任务队列的过程 {代码...}](https://segmentfault.com/q/1010000020106240?utm_source=sf-similar-question)[ ##### Promise输出顺序问题      1 回答   问题1：为什么输出async2 之后输出promise1 问题2： 在输出script end执行后为什么输出了promise 1问题三 为什么promise 1 后输出了 promise2](https://segmentfault.com/q/1010000023029224?utm_source=sf-similar-question)[ ##### 有个promise的执行顺序不理解      0 回答   ---- 不好意思，之前题目的文字都打错了不过已经想明白了，async是then的语法糖，后面的其实都是then的内容，先同步，再异步这样想就明白了](https://segmentfault.com/q/1010000022463470?utm_source=sf-similar-question)[ ##### js 事件执行顺序 宏任务和微任务      1 回答   代码执行结果为script startasync1 startasync2promise1promise2async1 endsetTimeout](https://segmentfault.com/q/1010000022960995?utm_source=sf-similar-question)[ ##### async await的执行顺序是什么样的？      1 回答   看到一个资料是这样说的，执行async2的时候会返回一个promise对象被放到任务队列中，然后等待同步任务执行完成时，这时候执行任务队列中刚才说的promise对象，此时又遇到了resolve函数，然后又被放到任务队列，并跳出async1函数，然后就执行了then中的console，最后又执行console.log('async1 end')](https://segmentfault.com/q/1010000018328200?utm_source=sf-similar-question)[ ##### js事件循环执行顺序是什么？      1 回答   以上代码的执行顺序如上图，请解释下为什么执行顺序是这样的。我先说一下我的理解（可以忽略，直接回答问题），当然我的想法是错误的，请大佬指正。1、首先执行第一个宏任务script，遇到setTimeout，属于第二个宏任务，加入宏任务队列，再遇到同步任务console.log('script start')，直接输出script start；2、然后在遇到...](https://segmentfault.com/q/1010000019730963?utm_source=sf-similar-question)[ ##### 关于async/await promise 执行顺序      5 回答   {代码...} {代码...} 请高手解释下为何会如此执行 特别是第一段代码 执行结果为什么不是 11 2 12 13 14](https://segmentfault.com/q/1010000021628640?utm_source=sf-similar-question)[ ##### 关于async await promise 在使用中执行顺序的疑问      2 回答   {代码...} 输出结果是 1 5 3 2 4为什么不是 1 5 2 3 4 ？](https://segmentfault.com/q/1010000017234312?utm_source=sf-similar-question)
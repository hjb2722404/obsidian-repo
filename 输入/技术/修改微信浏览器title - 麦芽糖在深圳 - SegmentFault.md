修改微信浏览器title - 麦芽糖在深圳 - SegmentFault

# 微信修改浏览器title

用document.title="xxxx"动态修改title，在iOS微信下不生效
解决方法是

	document.title = title;
	const iframe = document.createElement('iframe');
	iframe.src = 'img/logo.png';const listener = () => {
	    setTimeout(() => {
	        iframe.removeEventListener('load', listener);
	        setTimeout(() => {
	            document.body.removeChild(iframe);
	        }, 0);
	    }, 0);
	};
	iframe.addEventListener('load', listener);
	document.body.appendChild(iframe);

参考
https://segmentfault.com/q/1010000002926291
http://www.zhihu.com/question/27849091#
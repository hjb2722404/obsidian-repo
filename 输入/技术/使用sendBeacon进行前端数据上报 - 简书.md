### 前言

最近接到一个需求，需要统计页面的相关数据，并进行上报，本文就介绍一下数据上报的一些方法。

### 上报数据的时机

*   页面加载时

此时进行数据上报，只需要在页面 `load` 时上报即可。

```
window.addEventListener('load', reportData, false); 
```

*   页面卸载或页面刷新时

此时进行数据上报，只需要在页面 `beforeunload` 时上报即可。

```
window.addEventListener('beforeunload', reportData, false); 
```

*   SPA 路由切换时
    
    *   如果是 `vue-router` 或 `react-router@3` 及以下版本，则可以在 hooks 里进行上报操作。
    *   如果是 `react-router@4` 则需要在 `Routes` 根组件的生命周期内进行上报。
*   页面多个 tab 切换时
    

如果是这种情况，可以在 `visibilitychange` 时通过读取 `document.visibilityState` 或 `document.hidden` 区分页面 tab 的激活状态，判断是否需要进行上报。

```
document.addEventListener("visibilitychange", function() {
  if(document.visibilityState === 'visible') {
    reportData();
  }
  if(document.visibilityState === 'hidden') {
    reportData2();
  }
  
}); 
```

### 上报数据的方法

#### 1\. 直接发请求上报

我们可以直接将数据通过 ajax 发送到后端，以 `axios` 为例。

但这种方法有一个问题，就是在页面卸载或刷新时进行上报的话，请求可能会在浏览器关闭或重新加载前还未发送至服务端就被浏览器 cancel 掉，导致数据上报失败。

我们可以将 ajax 请求改为同步方法，这样就能保证请求一定能发送到服务端。由于 `fetch` 及 `axios` 都不支持同步请求，所以需要通过 `XMLHttpRequest` 发送同步请求。

```
const syncReport = (url, { data = {}, headers = {} } = {}) => {
  const xhr = new XMLHttpRequest();
  xhr.open('POST', url, false);
  xhr.withCredentials = true;
  Object.keys(headers).forEach((key) => {
    xhr.setRequestHeader(key, headers[key]);
  });
  xhr.send(JSON.stringify(data));
}; 
```

这里要注意的是，将请求改为同步以后，会阻塞页面关闭或重新加载的过程，这样就会影响用户体验。

#### 2\. 动态图片

我们可以通过在 `beforeunload` 事件处理器中创建一个图片元素并设置它的 `src` 属性的方法来延迟卸载以保证数据的发送，因为绝大多数浏览器会延迟卸载以保证图片的载入，所以数据可以在卸载事件中发送。

```
const reportData = (url, data) => {
  let img = document.createElement('img');
  const params = [];
  Object.keys(data).forEach((key) => {
    params.push(`${key}=${encodeURIComponent(data[key])}`);
  });
  img.onload = () => img = null;
  img.src = `${url}?${params.join('&')}`;
}; 
```

此时服务端可以返回一个 1px \* 1px 的图片，保证触发 `img` 的 `onload` 事件，但如果某些浏览器在实现上无法保证图片的载入，就会导致上报数据的丢失。

#### 3\. sendBeacon

为了解决上述问题，便有了 [navigator.sendBeacon](https://links.jianshu.com/go?to=https%3A%2F%2Fdeveloper.mozilla.org%2Fen-US%2Fdocs%2FWeb%2FAPI%2FNavigator%2FsendBeacon) 方法，使用该方法发送请求，可以保证数据有效送达，且不会阻塞页面的卸载或加载，并且编码比起上述方法更加简单。

用法如下：

```
navigator.sendBeacon(url, data); 
```

url 就是上报地址，data 可以是 `ArrayBufferView`，`Blob`，`DOMString` 或 `Formdata`，根据官方规范，需要 request header 为 [CORS-safelisted-request-header](https://links.jianshu.com/go?to=https%3A%2F%2Ffetch.spec.whatwg.org%2F%23cors-safelisted-request-header)，在这里则需要保证 `Content-Type` 为以下三种之一：

*   `application/x-www-form-urlencoded`
*   `multipart/form-data`
*   `text/plain`

我们一般会用到 `DOMString` , `Blob` 和 `Formdata` 这三种对象作为数据发送到后端，下面以这三种方式为例进行说明。

*   DOMString

如果数据类型是 `string`，则可以直接上报，此时该请求会自动设置请求头的 `Content-Type` 为 `text/plain`。

```
const reportData = (url, data) => {
  navigator.sendBeacon(url, data);
}; 
```

*   Blob

如果用 `Blob` 发送数据，这时需要我们手动设置 `Blob` 的 MIME type，一般设置为 `application/x-www-form-urlencoded`。

```
const reportData = (url, data) => {
  const blob = new Blob([JSON.stringify(data), {
    type: 'application/x-www-form-urlencoded',
  }]);
  navigator.sendBeacon(url, blob);
}; 
```

*   Formdata

可以直接创建一个新的 `Formdata`，此时该请求会自动设置请求头的 `Content-Type` 为 `multipart/form-data`。

```
const reportData = (url, data) => {
  const formData = new FormData();
  Object.keys(data).forEach((key) => {
    let value = data[key];
    if (typeof value !== 'string') {
      
      value = JSON.stringify(value);
    }
    formData.append(key, value);
  });
  navigator.sendBeacon(url, formData);
}; 
```

注意这里的 `JSON.stringify` 操作，服务端需要将数据进行 parse 才能得到正确的数据。

### 总结

我们可以使用 `sendBeacon` 发送数据，这一方法既能保证数据可靠性，也不影响用户体验，如果浏览器不支持该方法，则可以降级使用同步的 ajax 发送数据。

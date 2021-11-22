# vue项目配置多个代理的注意点

在`Vue`项目的开发过程中,为了本地调试方便，我们通常会在 `vue.config.js` 中配置 `devServer` 来在本地启动一个服务器，在这个选项中，我们会配置`proxy` 属性来将指向到本地的请求（例如： `/api/action`） 代理到后端的开发服务器上（例如： `http://xxx.xxx.xxx/api/action`）

``` javascript
devServer: {
        port: 8081,
        proxy: {
            '/api/action': {
                target: 'http://192.168.200.106:81',
                changeOrigin: true,
                ws: true,
                secure: false
            }
        }
    },
​```
```

在这个配置中，要注意以下两点：

#### 接口地址有重叠地址时，将匹配度低的放在后面。

例如：
	* 将 `/` 匹配到 `192.191.1.1`;
	* 将 `/api` 匹配到 `192.191.1.2`
	* 将 `/api/action` 匹配到 `192.191.1.3`

如果我们像下面一样书写：

```javascript
proxy: {
            '/': {
                target: 'http://192.191.1.1',
                changeOrigin: true,
                ws: true,
                secure: false
            },
			 '/api': {
                target: 'http://192.191.1.2',
                changeOrigin: true,
                ws: true,
                secure: false
            },
			 '/api/action': {
                target: 'http://192.191.1.3',
                changeOrigin: true,
                ws: true,
                secure: false
            }
        }
```


那么所有到`/`, `/api`和 `/api/action` 的请求将全部被代理到 `192.191.1.1` 上面去

原因是这里的匹配实际上是一个正则匹配的过程，当我们请求 `/api` 时，首先读取到了配置项中的第一个，拿配置中的 `/` 去匹配请求中的 `/api` ， 发现请求的`/api` 中包含配置项`/`, 匹配成功，直接将请求代理到了 `192.191.1.1` 上面去， 对`/api/action`的匹配也同理。

也就是说，它的匹配规则是： 拿配置项中的地址去匹配请求中的地址，如果请求中的地址中包含配置中的地址，则匹配成功，否则，拿下一个配置项继续匹配。

所以，配置中的地址与请求地址中匹配的字符越少，匹配度越低。 上例中配置中的地址（`/`）与请求地址（`/api`）只有一个字符是匹配的，所以匹配度低。

所以我们正确的写法应该是：

```javascript
proxy: {
            '/api/action': {
                target: 'http://192.191.1.3',
                changeOrigin: true,
                ws: true,
                secure: false
            },
			 '/api': {
                target: 'http://192.191.1.2',
                changeOrigin: true,
                ws: true,
                secure: false
            },
			 '/': {
                target: 'http://192.191.1.1',
                changeOrigin: true,
                ws: true,
                secure: false
            }
        }
```

这样到三个地址的请求就都可以正确代理到相应的地址去了

#### 多个地址代理同一个`target` 时，可进行合并

在实际应用中，由于后端采用微服务模式开发，在开发阶段，我们可能会将不同的服务代理到不同的地址上，当服务很多时，我们代理的数量也就很多：

```javascript
proxy: {
  		'/api/action': {
                target: 'http://192.191.1.3',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              '/api/action2': {
                target: 'http://192.191.1.4',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              '/api/action3': {
                target: 'http://192.191.1.3',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              '/api/action4': {
                target: 'http://192.191.1.4',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              '/api/action5': {
                target: 'http://192.191.1.5',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              '/api/action6': {
                target: 'http://192.191.1.6',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              '/api/action7': {
                target: 'http://192.191.1.5',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              '/api/action8': {
                target: 'http://192.191.1.6',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              '/api/action9': {
                target: 'http://192.191.1.7',
                changeOrigin: true,
                ws: true,
                secure: false
            },
			 '/api': {
                target: 'http://192.191.1.2',
                changeOrigin: true,
                ws: true,
                secure: false
            },
			 '/': {
                target: 'http://192.191.1.1',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              
        }
```

当配置的代理数量超过十个时，开发环境编译打包时会报以下错误：

![image-20201012162310243](20201209092526.png)

为了解决报错，也同时减少代码体积，我们可以对具有同一个`target`的配置项进行合并，由上文我们可知，这里其实是一个正则匹配的过程，那我们就可以利用正则语法将他们进行合并：

```javascript
proxy: {
  		'/api/action|/api/action3': {
                target: 'http://192.191.1.3',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              '/api/action2|/api/action4'': {
                target: 'http://192.191.1.4',
                changeOrigin: true,
                ws: true,
                secure: false
            },
             
              '/api/action5|/api/action7': {
                target: 'http://192.191.1.5',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              '/api/action6|/api/action8': {
                target: 'http://192.191.1.6',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              '/api/action9': {
                target: 'http://192.191.1.7',
                changeOrigin: true,
                ws: true,
                secure: false
            },
			 '/api': {
                target: 'http://192.191.1.2',
                changeOrigin: true,
                ws: true,
                secure: false
            },
			 '/': {
                target: 'http://192.191.1.1',
                changeOrigin: true,
                ws: true,
                secure: false
            },
              
        }
```

当然，在正式部署的时候，还是需要后端去做统一代理。


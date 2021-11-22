Vue 全站缓存之 vue-router-then 实现原理 - 阿星的空间

# Vue 全站缓存之 vue-router-then 实现原理

> 系列篇1：> [> Vue 全站缓存之 keep-alive ： 动态移除缓存](https://wanyaxing.com/blog/20180723114341.html)

> 系列篇2：> [> Vue 全站缓存二：如何设计全站缓存](https://wanyaxing.com/blog/20180724141008.html)

> 系列篇3：> [> Vue 全站缓存之 vue-router-then ：前后页数据传递](https://wanyaxing.com/blog/20180725161052.html)

> 本篇为系列篇4：> [> Vue 全站缓存之 vue-router-then ：实现原理](https://wanyaxing.com/blog/20180726075542.html)

## 前言

就效果而言，我很满意`v-model-link`指令带来的开发效率的提升，不过 vue-router-then 这个插件本身的代码实现得有点粗暴，总觉得自己对 vue 的理解还是比较肤浅，有时候看别人家的文章总有不明觉厉的感叹，然而正如我在知乎专栏在博客的自我介绍里所说，高楼大厦平地起，咱也想加上一块砖，自己这三板斧该献丑还是献丑，抛砖引玉也行的。

## 活着才有 DPS

从第一篇文章[Vue 全站缓存之 keep-alive ： 动态移除缓存](https://wanyaxing.com/blog/20180723114341.html)开始，我们就一直在强调如何去实现页面缓存，vue-router-then 正是建立在页面缓存成功的基础之上的功能，如果你不能正确的使用页面缓存功能，或者说页面缓存被销毁了，vue-router-then 也就没有意义了。

## 实现原理

这个插件的原理说开了实现得非常粗暴，说白了就是一句话：在路由跳转事件里给新页面组件绑事件。

## 返回一个 promise

在this.$router系列方法的基础之上，包装一个 promise ，并将 resolve 方法给存储起来。

	const routerThen = {
	        '$router':null,
	        resolve:null,
	        *//跳到指定页面，并返回promise*
	        request:function(requestType='push', location, onComplete=null, onAbort=null){
	            if (!location || location=='')
	            {
	                throw new Error('location is missing');
	            }
	            return new Promise( (resolve, reject)=>{
	                if (this.$router)
	                {
	                    console.log('this.$router',this.$router);
	                    this.resolve = resolve;
	                    switch (requestType)
	                    {
	                        case 'push':
	                            this.$router.push(location, onComplete, onAbort);
	                            break;
	                        case 'replace':
	                            this.$router.replace(location, onComplete, onAbort);
	                            break;
	                        case 'go':
	                            this.$router.go(location);
	                            break;
	                        default:
	                            reject('requestType error:'+requestType);
	                            break;
	                    }
	                }
	                else
	                {
	                    reject('$router missing');
	                }
	            }).catch(error=>{
	                this.resolve = null;
	                throw new Error(error);
	            });
	        },

## 在路由事件里夹点私货

上文里，将 resolve 存好后，页面就应该开始跳转了，此时可以捕捉路由事件，在新页面载入后，将新页面对象 vm回调给 promise 。

	        Vue.mixin({
	            *// 在路由跳转到下一个页面之前，为下一个页面注册回调事件。*
	            beforeRouteEnter:function(to, from, next){
	                if (routerThen.resolve)
	                {
	                    next(vm=>{
	                            routerThen.resolve(vm);
	                            routerThen.resolve = null;
	                    });
	                }
	                else
	                {
	                    next();
	                }
	            },
	            beforeRouteUpdate:function(to, from, next){
	                if (routerThen.resolve)
	                {
	                    routerThen.resolve(this);
	                    routerThen.resolve = null;
	                }
	                next();
	            },
	        });

## 拿到页面对象啥都好办了

比如，modelLink方法，其实就是拿到 vm 对象给它塞了个 input 事件。

	        modelLink:function(link, el=null){
	            return this.push(link).then(vm=>{
	                vm.$once('input',value=>{
	                    if (typeof el == 'function')
	                    {
	                        el(value);
	                    }
	                    else if (typeof el == 'object')
	                    {
	                        if (el.$emit)
	                        {
	                            el.$emit('input',value);
	                        }
	                        else if (el.tagName)
	                        {
	                            el.value = value;
	                            const e = document.createEvent('HTMLEvents');
	                            *// e.initEvent(binding.modifiers.lazy?'change':'input', true, true);*
	                            e.initEvent('input', true, true);
	                            el.dispatchEvent(e);
	                        }
	                    }
	                });
	                return vm;
	            })
	        },

## v-model-link 只是一个语法糖

我很喜欢语法糖这个概念，复杂的事简单化。

	        clickElFun:function(event){
	            let link = this.getAttribute('model-link');
	            if (link)
	            {
	                console.log(this);
	                return routerThen.modelLink(link,this.vnode && this.vnode.componentInstance?this.vnode.componentInstance:this);
	            }
	            return Promise.resolve();
	        },

	    Vue.directive('model-link',  function (el, binding, vnode) {
	            el.binding = binding;
	            el.vnode   = vnode;
	            el.setAttribute('model-link',binding.value);
	            el.removeEventListener('click',routerThen.clickElFun);
	            el.addEventListener('click',routerThen.clickElFun);
	        });

## 后语

还是那句话，这个代码有点粗暴，作抛砖引玉，供大家参考。
我很喜欢全站缓存这个理念，在目前 vue 社区里类似的文章很少看到，希望能有更多朋友参与进来，挖掘其中的亮点。
END
> 我最近还在研究全站缓存情况下跨多级页面的数据共用和更新的情况，感觉会很有意思，敬请期待，这次时间需要久一点。
原文来自阿星的空间：https://wanyaxing.com/blog/20180726075542.html

 [Vue](https://wanyaxing.com/blog/?tag=Vue)  [Vuex](https://wanyaxing.com/blog/?tag=Vuex)  [VueRouter](https://wanyaxing.com/blog/?tag=VueRouter)

   阅读数：2458
 发表于：2018-07-26 07:55:42

总想写点啥，然而有点忙<s>懒</s>。

程序员之中有大神，更多的当然是普通人。是程序员，都可以有一颗敢想敢做的心，善于思考，勇于行动。希望自己能在这里分享下对项目、框架、脚本、插件、APP、任何事或物的研究或改进之想法，呃，或者也可以聊聊生活聊聊人生。

高楼大厦平地起，咱也想加上一块砖。

我是万亚星，码农一枚。

标签关键字： IT 互联网、架构、 Web 后端开发、 PHP 、 Python、 Nodejs、 Web 前端开发 、 Vue.js 、 Javascript 、 CSS 、 HTML5 、微信公众号、钉钉服务、 MySQL / 数据库、 iOS 和 Android 略懂……

Email : [wyx@wanyaxing.com](https://wanyaxing.com/blog/20180726075542.htmlmailto:wyx@wanyaxing.com)
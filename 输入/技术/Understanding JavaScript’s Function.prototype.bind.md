Understanding JavaScript’s Function.prototype.bind – Smashing Magazine

## [Understanding JavaScript’s Function.prototype.bind](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/)

- By [Ben Howdle](https://www.smashingmagazine.com/author/ben-howdle/)
- January 23rd, 2014
- [JavaScript,](https://www.smashingmagazine.com/tag/javascript/)[Techniques,](https://www.smashingmagazine.com/tag/techniques/)[Tools](https://www.smashingmagazine.com/tag/tools/)
- [48 Comments](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/#comments)

[![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131019.png)](https://shop.smashingmagazine.com/products/inclusive-design-patterns?utm_source=magazine&utm_campaign=inclusive-design-patterns&utm_medium=html-ad-content-1)  Today, too many websites are still inaccessible. In our new book *Inclusive Design Patterns*, we explore how to craft **flexible front-end design patterns** and make **future-proof and accessible interfaces without extra effort**. Hardcover, 312 pages. [Get the book now!](https://shop.smashingmagazine.com/products/inclusive-design-patterns?utm_source=magazine&utm_campaign=inclusive-design-patterns&utm_medium=html-ad-content-1)

![lg.php.gif](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

Function binding is most probably your least concern when beginning with JavaScript, but when you realize that you need a solution to the problem of how to keep the context of `this` within another function, then you might not realize that what you actually need is `Function.prototype.bind()`.

### Further Reading on SmashingMag: [Link](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/#further-reading-on-smashingmag)

- [What You Need To Know About JavaScript Scope](https://www.smashingmagazine.com/2009/08/what-you-need-to-know-about-javascript-scope/)
- [An Introduction To DOM Events](https://www.smashingmagazine.com/2013/11/an-introduction-to-dom-events/)
- [7 JavaScript Things I Wish I Knew Much Earlier In My Career](https://www.smashingmagazine.com/2010/04/seven-javascript-things-i-wish-i-knew-much-earlier-in-my-career/)
- [How To Write Fast, Memory-Efficient JavaScript](https://www.smashingmagazine.com/2012/11/writing-fast-memory-efficient-javascript/)

The first time you hit upon the problem, you might be inclined to set `this` to a variable that you can reference when you change context. Many people opt for `self`, `_this` or sometimes `context` as a variable name. They’re all usable and nothing is wrong with doing that, but there is a better, dedicated way.

[Jack Archibald tweets about](https://twitter.com/jaffathecake/) caching `this`:

**
> Ohhhh I would do anything for scope, but I won’t do that = this
> — Jake Archibald (@jaffathecake) February 20, 2013
**

It should have been more apparent to me when [Sindre Sorhus spelled it out](https://twitter.com/sindresorhus/):

**

> [> @benhowdle](https://twitter.com/benhowdle)>   > [> $this](https://twitter.com/search?q=%24this&src=ctag)>  for jQuery, for plain JS i don’t, use .bind()

> — Sindre Sorhus (@sindresorhus) February 22, 2013
**
I ignored this wise advice for many months.

### What Problem Are We Actually Looking To Solve? [Link](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/#what-problem-are-we-actually-looking-to-solve)

Here is sample code in which one could be forgiven for caching the context to a variable:

	var myObj = {
	
	    specialFunction: function () {
	
	    },
	
	    anotherSpecialFunction: function () {
	
	    },
	
	    getAsyncData: function (cb) {
	        cb();
	    },
	
	    render: function () {
	        var that = this;
	        this.getAsyncData(function () {
	            that.specialFunction();
	            that.anotherSpecialFunction();
	        });
	    }
	};
	
	myObj.render();

If we had left our function calls as `this.specialFunction()`, then we would have received the following error:

	Uncaught TypeError: Object [object global] has no method 'specialFunction'

We need to keep the context of the `myObj` object referenced for when the callback function is called. Calling `that.specialFunction()` enables us to maintain that context and correctly execute our function. However, this could be neatened somewhat by using `Function.prototype.bind()`.

Let’s rewrite our example:

	render: function () {
	
	    this.getAsyncData(function () {
	
	        this.specialFunction();
	
	        this.anotherSpecialFunction();
	
	    }.bind(this));
	
	}

#### What Did We Just Do? [Link](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/#what-did-we-just-do)

Well, `.bind()` simply creates a new function that, when called, has its `this` keyword set to the provided value. So, we pass our desired context, `this` (which is `myObj`), into the `.bind()` function. Then, when the callback function is executed, `this` references `myObj`.

If you’re interested to see what `Function.prototype.bind()` might look like and what its doing internally, here is a very simple example:

	Function.prototype.bind = function (scope) {
	    var fn = this;
	    return function () {
	        return fn.apply(scope);
	    };
	}

And here is a very simple use case:

	var foo = {
	    x: 3
	}
	
	var bar = function(){
	    console.log(this.x);
	}
	
	bar(); // undefined
	
	var boundFunc = bar.bind(foo);
	
	boundFunc(); // 3

We’ve created a new function that, when executed, has its `this` set to `foo` — not the global scope, as in the example where we called `bar();`.

[![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106131028.png)](https://shop.smashingmagazine.com/products/inclusive-design-patterns?utm_source=magazine&utm_campaign=inclusive-design-patterns&utm_medium=html-ad-content-2)  Today, too many websites are still inaccessible. In our new book *Inclusive Design Patterns*, we explore how to craft **flexible front-end design patterns** and make **future-proof and accessible interfaces without extra effort**. Hardcover, 312 pages. [Get the book now!](https://shop.smashingmagazine.com/products/inclusive-design-patterns?utm_source=magazine&utm_campaign=inclusive-design-patterns&utm_medium=html-ad-content-2)

![lg.php.gif](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

### Browser Support [Link](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/#browser-support)

| Browser | Version support |
| --- | --- |
| Chrome | 7   |
| Firefox (Gecko) | 4.0 (2) |
| Internet Explorer | 9   |
| Opera | 11.60 |
| Safari | 5.1.4 |

As you can see, unfortunately, `Function.prototype.bind` isn’t supported in Internet Explorer 8 and below, so you’ll run into problems if you try to use it without a fallback.

Luckily, Mozilla Developer Network, being the wonderful resource it is, [provides a rock-solid alternative](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind) if the browser hasn’t implemented the native `.bind()` method:

	if (!Function.prototype.bind) {
	  Function.prototype.bind = function (oThis) {
	    if (typeof this !== "function") {
	      // closest thing possible to the ECMAScript 5 internal IsCallable function
	      throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
	    }
	
	    var aArgs = Array.prototype.slice.call(arguments, 1),
	        fToBind = this,
	        fNOP = function () {},
	        fBound = function () {
	          return fToBind.apply(this instanceof fNOP && oThis
	                                 ? this
	                                 : oThis,
	                               aArgs.concat(Array.prototype.slice.call(arguments)));
	        };
	
	    fNOP.prototype = this.prototype;
	    fBound.prototype = new fNOP();
	
	    return fBound;
	  };
	}

### Patterns For Usage [Link](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/#patterns-for-usage)

When learning something, I find it useful not only to thoroughly learn the concept, but to see it *applied* to what I’m currently working on (or something close to it). Hopefully, some of the examples below can be applied to your code or to problems you’re facing.

#### Click Handlers [Link](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/#click-handlers)

One use is to track clicks (or to perform an action after a click) that might require us to store information in an object, like so:

	var logger = {
	    x: 0,
	    updateCount: function(){
	        this.x++;
	        console.log(this.x);
	    }
	}

We might assign click handlers like this and subsequently call the `updateCount()` in our `logger` object:

	document.querySelector('button').addEventListener('click', function(){
	    logger.updateCount();
	});

But we’ve had to create an unnecessary anonymous function to allow the `this` keyword to stand correct in the `updateCount()` function.

This could be neatened up, like so:

	document.querySelector('button').addEventListener('click', logger.updateCount.bind(logger));

We’ve used the subtly handy `.bind()` function to create a new function and then set the scope to be bound to the `logger` object.

#### setTimeout [Link](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/#settimeout)

If you’ve ever worked with templating engines (such as Handlebars) or especially with certain MV* frameworks (I can only speak of Backbone.js from experience), then you might be aware of the problem that occurs when you render the template but want to access the new DOM nodes immediately after your render call.

Suppose we try to instantiate a jQuery plugin:

	var myView = {
	
	    template: '/* a template string containing our <select /> */',
	
	    $el: $('#content'),
	
	    afterRender: function () {
	        this.$el.find('select').myPlugin();
	    },
	
	    render: function () {
	        this.$el.html(this.template());
	        this.afterRender();
	    }
	}
	
	myView.render();

You might find that it works — but not all the time. Therein lies the problem. It’s a rat race: Whatever happens to get there first wins. Sometimes it’s the render, sometimes it’s the plugin’s instantiation.

Now, unbeknownst to some, we can use a slight hack with `setTimeout()`.

With a slight rewrite, we can safely instantiate our jQuery plugin once the DOM nodes are present:

	//
	
	    afterRender: function () {
	        this.$el.find('select').myPlugin();
	    },
	
	    render: function () {
	        this.$el.html(this.template());
	        setTimeout(this.afterRender, 0);
	    }
	
	//

However, we will receive the trusty message that the function `.afterRender()` cannot be found.

What we do, then, is throw our `.bind()` into the mix:

	//
	
	    afterRender: function () {
	        this.$el.find('select').myPlugin();
	    },
	
	    render: function () {
	        this.$el.html(this.template());
	        setTimeout(this.afterRender.bind(this), 0);
	    }
	
	//

Now, our `afterRender()` function will execute in the correct context.

#### Tidier Event Binding With querySelectorAll [Link](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/#tidier-event-binding-with-queryselectorall)

The DOM API improved significantly once it included such useful methods as `querySelector`, `querySelectorAll` and the `classList` API, to name a few of the many.

However, there’s not really a way to natively add events to a `NodeList` as of yet. So, we end up stealing the `forEach` function from the `Array.prototype` to loop, like so:

	Array.prototype.forEach.call(document.querySelectorAll('.klasses'), function(el){
	    el.addEventListener('click', someFunction);
	});

We can do better than that, though, with our friend `.bind()`:

	var unboundForEach = Array.prototype.forEach,
	    forEach = Function.prototype.call.bind(unboundForEach);
	
	forEach(document.querySelectorAll('.klasses'), function (el) {
	    el.addEventListener('click', someFunction);
	});

We now have a tidy method to loop our DOM nodes.

#### Conclusion [Link](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/#conclusion)

As you can see, the `.bind()` function can be subtly included for many different purposes, as well as to neaten existing code. Hopefully, this overview has given you what you need to add `.bind()` to your own code (if necessary!) and to harness the power of transforming the value of `this`.

*(al, il)*

[JavaScript](https://www.smashingmagazine.com/tag/javascript/)[Techniques](https://www.smashingmagazine.com/tag/techniques/)[Tools](https://www.smashingmagazine.com/tag/tools/)

[↑ Back to top](https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/#top)[Tweet it](https://twitter.com/intent/tweet?original_referer=https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/&source=tweetbutton&text=Understanding%20JavaScript%E2%80%99s%20Function.prototype.bind&url=https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/&via=smashingmag)[Share on Facebook](http://www.facebook.com/sharer/sharer.php?u=https://www.smashingmagazine.com/2014/01/understanding-javascript-function-prototype-bind/)
React ES6 class constructor super() « Cheng's Blog

12 个月 ago

##   [React ES6 class constructor super()](http://cheng.logdown.com/posts/2016/03/26/683329)

When writting React using the ES6 class syntax like this:

class  MyClass  extends  React.component  {  constructor(){  super()  }}
Two questions may arise:
1. Is it necessary to call `super()` inside `constructor`?
2. What is the difference between callling `super()` and `super(props)`?

### Answer #1

**

> Always call `super()`>  if you have a constructor and don't worry about it if you don't have a constructor

**

Calling `super()` is necessary **only if you need to have a `constructor`**. Take a look at this code:

class  MyClass  extends  React.component  {  render(){  return  <div>Hello  {  this.props.world  }</div>;  }}

The code above is perfectly valid. You **don't have to call `super()`** for every react component you create. However, if there is a constructor in your code, then **you MUST call super**:

class  MyClass  extends  React.component  {  constructor(){  console.log(this)  //Error: 'this' is not allowed before super()  }}

The reason why `this` cannot be allowed before `super()` is because **`this` is uninitialized if super() is not called**  [[1]](http://stackoverflow.com/questions/31067368/javascript-es6-class-extend-without-super/31079103#31079103)

You may think you can get away with an empty constructor without callling `super()`:

class  MyClass  extends  React.component  {  constructor(){}  // Error: missing super() call in constructor}

ES6 class constructors MUST call `super` if they are subclasses. Thus, you have to call `super()` as long as you have a constructor. (But a subclass does not have to have a constructor)

### Answer #2

**

> Call `super(props)`>  only if you want to access `this.props`>  inside the constructor. React automatically set it for you if you want to access it anywhere else.

**

The effect of passing `props` when calling `super()` allows you to access `this.props` in the constructor:

class  MyClass  extends  React.component{  constructor(props){  super();  console.log(this.props);  // this.props is undefined  }}

To fix it:

class  MyClass  extends  React.component{  constructor(props){  super(props);  console.log(this.props);  // prints out whatever is inside props  }}

There is no need to pass `props` into the constructor if you want to use it in other places. Because React automatically set it for you [[2]](https://discuss.reactjs.org/t/should-we-include-the-props-parameter-to-class-constructors-when-declaring-components-using-es6-classes/2781)

class  MyClass  extends  React.component{  render(){  // There is no need to call `super(props)` or even having a constructor   // this.props is automatically set for you by React   // not just in render but another where else other than the constructor  console.log(this.props);  // it works!  }}

 [← Webpack devtool source map](http://cheng.logdown.com/posts/2016/03/25/679045)  [Do not use .bind() or Arrow Functions in JSX Props →](http://cheng.logdown.com/posts/2016/04/01/do-not-use-bind-or-arrow-functions-in-jsx-props)

|     |
| --- |
|     |

 [ ](http://cheng.logdown.com/posts/2016/03/26/683329#)

[**Tweet](https://twitter.com/intent/tweet?original_referer=http%3A%2F%2Fcheng.logdown.com%2Fposts%2F2016%2F03%2F26%2F683329&ref_src=twsrc%5Etfw&text=React%20ES6%20class%20constructor%20super()%20%C2%AB%20Cheng%27s%20Blog&tw_p=tweetbutton&url=http%3A%2F%2Fcheng.logdown.com%2Fposts%2F2016%2F03%2F26%2F683329)

5

- ** March 26, 2016 23:01

- **  [Permalink](http://cheng.logdown.com/posts/2016/03/26/683329)

- **  [Comments](http://cheng.logdown.com/posts/2016/03/26/683329/#disqus_thread)

 [comments powered by Disqus](http://disqus.com/)
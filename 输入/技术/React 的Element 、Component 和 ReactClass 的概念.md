React 的Element 、Component 和 ReactClass 的概念

# React 的Element 、Component 和 ReactClass 的概念

 [![144](../_resources/ee7c3841ee9ba2a982149ff641cf5ab9.png)](http://www.jianshu.com/u/8ca9803d6c8a)

 作者  [jacobbubu](http://www.jianshu.com/u/8ca9803d6c8a)  [**关注]()
 2015.06.28 10:58  字数 875  阅读 7805评论 0喜欢 19

在使用 React 的时候，会出现几个看起来相互混淆的概念，例如：Element，Class 和 Component。
我们先来看看 Element。

# Element

Element 是后文 Class 的实例，React 通过解析每一个创建的 Element， 计算出需要对 DOM 进行的实际操作来完成渲染的。

	React.render(
	    React.createElement('div', {}, 'Hello, world!'),
	    document.body
	);

代码中的 `React.createElement` 创建了一个新的 `div` Componnet 的实例。第一个参数 “div”是 React 预先定义好的。

第二个参数`{}` 是需要传入的 `props`，第三个参数是 "Child Element"。
当你创建了第一个 Element，其所有的“孩子”都会被自动创建。
用 “Element” 来命名，应该是遵从了 HTML Elements 的习惯。

# Component 和 ReactClass

React 自己定义了好了大量的 Components，从 "div" 到 "svg"，包含了几乎所有 HTML Tags。
当然，我们也可以创建自己的 Component，例如：

	var MyComponent = React.createClass({
	  render: function() {
	    ...
	  }
	});

`MyComponent` 就是我们创建的 Component，至少需要包含一个 `render` 方法的实现。随后，我们就可以通过 `React.createElement(MyComponent, {}, null)` 来创建 “MyComponent” 的 “Element” 了。

这里最容易造成混淆的是，创建 “MyComponent” 方法名是 “React.createClass”，而不是 “React.createComponent”。“createClass” 却创建出了 “Component”，这是一个诡异的地方，虽然官方文档定义 “createClass” 的返回类型为 “ReactClass”。

之前有过争议 https://groups.google.com/forum/#!topic/reactjs/40dxGadNXeM.

# Factory

为了简化 `React.createElement` 的调用语法，`React.createFactory` 被引入：

	var div = React.createFactory('div');
	var root = div({ className: 'my-div' });
	React.render(root, document.getElementById('example'));

`React.createFactory` 的定义基本就是如下形式，Element 的类型被提前绑定了。

	function createFactory(type) {
	  return React.createElement.bind(null, type);
	}

`React.DOM.div` 等都是预先定义好的 “Factory”。“Factory” 用于创建特定 “ReactClass” 的 “Element”。

# 用 ES6 Class 代替 React.createClass

从 React 0.13 开始，可以使用 ES6 Class 代替 `React.createClass` 了。这应该是今后推荐的方法，但是目前对于 `mixins` 还没有提供官方的解决方案，你可以利用第三方的实现 https://github.com/brigand/react-mixin.

	class HelloMessage extends React.Component {
	  render() {
	    return <div>Hello {this.props.name}</div>;
	  }
	}

`React.Component` 是基类(得，这里又变成了 Component了，其实准确的命名可能是 ElementClass，或者 ComponentClass，不过这样太长了😀)。

`React.createClass` 中的某些工作，可以直接在 ES6 Class 的构造函数中来完成，例如：`getInitialState` 的工作可以被构造函数所替代：

	export class Counter extends React.Component {
	  constructor(props) {
	    super(props);
	    this.state = {count: props.initialCount};
	  }
	  tick() {
	    this.setState({count: this.state.count + 1});
	  }
	  render() {
	    return (
	      <div onClick={this.tick.bind(this)}>
	        Clicks: {this.state.count}
	      </div>
	    );
	  }
	}

`propTypes` 和 `getDefaultTypes` 这种静态设置则可以变成类级别（不是类实例成员）的定义。

	var ExampleComponent = React.createClass({ ... });
	ExampleComponent.propTypes = {
	 aStringProp: React.PropTypes.string
	};
	ExampleComponent.defaultProps = {
	 aStringProp: ''
	};

另外，原本通过 `React.createClass` 创建的 Component/Element 中的成员函数都是有 auto binding 能力的(缺省绑定到当前 Element)，那么使用 ES6 Class 则需要你自己绑定，或者使用 `=>` （Fat Arrow）的声明方式。Fat Arrow 会缺省将当前 `this` 绑定到当前类实例（ES6 和 CoffeeScript 一样），但是不要对 `render` 使用 `=>`。

	class Counter extends React.Component {
	  tick = () => {
	    ...
	  }
	  ...
	}

CoffeeScript 天生从这种新方式中得益，例如：

	div = React.createFactory 'div'

	class Counter extends React.Component
	  @propTypes = initialCount: React.PropTypes.number
	  @defaultProps = initialCount: 0

	  constructor: (props) ->
	    super props
	    @state = count: props.initialCount

	  tick: =>
	    @setState count: @state.count + 1

	  render: ->
	    div onClick: @tick,
	      'Clicks: ' + @state.count

CoffeeScript 一直是最简短的 JS。

 [**  日记本](http://www.jianshu.com/nb/119017)
© 著作权归作者所有

 [举报文章]()
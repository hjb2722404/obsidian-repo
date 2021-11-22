❗️ 准备知识
-------

*   熟悉 React
    

*   熟悉 TypeScript (参考书籍：2ality's guide\[1\], 初学者建议阅读：chibicode's tutorial\[2\]）
    
*   熟读 React 官方文档 TS 部分\[3\]
    
*   熟读 TypeScript playground React 部分\[4\]
    

_本文档参考 TypeScript 最新版本_

如何引入 React
----------

```
import * as React from 'react'import * as ReactDOM from 'react-dom'
```

这种引用方式被证明\[5\]是最可靠的一种方式， **推荐使用**。

而另外一种引用方式:

```
import React from 'react'import ReactDOM from 'react-dom'
```

需要添加额外的配置："allowSyntheticDefaultImports": true

函数式组件的声明方式
----------

声明的几种方式

第一种：也是比较**推荐**的一种，使用 **React.FunctionComponent**，简写形式：**React.FC:**

```
// Greattype AppProps = {  message: string}const App: React.FC<AppProps> = ({ message, children }) => (  <div>    {message}    {children}  </div>)
```

使用用 React.FC 声明函数组件和**普通声明**以及 **PropsWithChildren** 的区别是：

*   React.FC 显式地定义了返回类型，其他方式是隐式推导的
    

*   React.FC 对静态属性：displayName、propTypes、defaultProps 提供了类型检查和自动补全
    
*   React.FC 为 children 提供了隐式的类型（ReactElement | null），但是目前，提供的类型存在一些 issue\[6\]（问题）
    

比如以下用法 React.FC 会报类型错误:

```
const App: React.FC = props => props.childrenconst App: React.FC = () => [1, 2, 3]const App: React.FC = () => 'hello'
```

解决方法:

```
const App: React.FC<{}> = props => props.children as anyconst App: React.FC<{}> = () => [1, 2, 3] as anyconst App: React.FC<{}> = () => 'hello' as any// 或者const App: React.FC<{}> = props => (props.children as unknown) as JSX.Elementconst App: React.FC<{}> = () => ([1, 2, 3] as unknown) as JSX.Elementconst App: React.FC<{}> = () => ('hello' as unknown) as JSX.Element
```

在通常情况下，使用 **React.FC** 的方式声明最简单有效，推荐使用；如果出现类型不兼容问题，建议使用**以下两种方式：** 

第二种：使用 **PropsWithChildren**，这种方式可以为你省去频繁定义 children 的类型，自动设置 children 类型为 ReactNode:

```
type AppProps = React.PropsWithChildren<{ message: string }>const App = ({ message, children }: AppProps) => (  <div>    {message}    {children}  </div>)
```

第三种：直接声明:

```
type AppProps = {  message: string  children?: React.ReactNode}const App = ({ message, children }: AppProps) => (  <div>    {message}    {children}  </div>)
```

Hooks
-----

### useState<T>

大部分情况下，TS 会自动为你推导 **state** 的类型:

```
// `val`会推导为boolean类型， toggle接收boolean类型参数const [val, toggle] = React.useState(false)// obj会自动推导为类型: {name: string}const [obj] = React.useState({ name: 'sj' })// arr会自动推导为类型: string[]const [arr] = React.useState(['One', 'Two'])
```

使用推导类型作为接口/类型:

```
export default function App() {  // user会自动推导为类型: {name: string}  const [user] = React.useState({ name: 'sj', age: 32 })  const showUser = React.useCallback((obj: typeof user) => {    return `My name is ${obj.name}, My age is ${obj.age}`  }, [])
```

但是，一些状态初始值为空时（**null**），需要显示地声明类型：

```
type User = {  name: string  age: number}
```

### useRef<T>

当初始值为 **null** 时，有两种创建方式:

```
const ref1 = React.useRef<HTMLInputElement>(null)const ref2 = React.useRef<HTMLInputElement | null>(null)
```

**这两种的区别在于**：

*   第一种方式的 ref1.current 是**只读的（read-only）**，并且可以传递给内置的 ref 属性，绑定 DOM 元素 **；**
    
*   第二种方式的 ref2.current 是**可变的**（类似于声明类的成员变量）
    

```
const ref = React.useRef(0)React.useEffect(() => {  ref.current += 1}, [])
```

这两种方式在使用时，都需要对类型进行检查:

```
const onButtonClick = () => {  ref1.current?.focus()  ref2.current?.focus()}
```

在某种情况下，可以省去类型检查，通过添加 **!** **断言**，**不推荐**：

```
// Badfunction MyComponent() {  const ref1 = React.useRef<HTMLDivElement>(null!)  React.useEffect(() => {    //  不需要做类型检查，需要人为保证ref1.current.focus一定存在    doSomethingWith(ref1.current.focus())  })  return <div ref={ref1}> etc </div>}
```

### useEffect

**useEffect** 需要注意回调函数的返回值只能是函数或者 **undefined**

```
function App() {  // undefined作为回调函数的返回值  React.useEffect(() => {    // do something...  }, [])  // 返回值是一个函数  React.useEffect(() => {    // do something...    return () => {}  }, [])}
```

### useMemo<T> / useCallback<T>

**useMemo** 和 **useCallback** 都可以直接从它们返回的值中推断出它们的类型

**useCallback** 的参数必须制定类型，否则 ts 不会报错，默认指定为 **any**

```
const value = 10// 自动推断返回值为 numberconst result = React.useMemo(() => value * 2, [value])// 自动推断 (value: number) => numberconst multiply = React.useCallback((value: number) => value * multiplier, [  multiplier,])
```

同时也支持传入泛型， **useMemo** 的泛型指定了返回值类型，**useCallback** 的泛型指定了参数类型

```
// 也可以显式的指定返回值类型，返回值不一致会报错const result = React.useMemo<string>(() => 2, [])// 类型“() => number”的参数不能赋给类型“() => string”的参数。const handleChange = React.useCallback<  React.ChangeEventHandler<HTMLInputElement>>(evt => {  console.log(evt.target.value)}, [])
```

### 自定义 Hooks

需要注意，自定义 Hook 的返回值如果是**数组类型**，TS 会自动推导为 **Union** 类型，而我们实际需要的是数组里里每一项的具体类型，需要手动添加 **const** **断言** 进行处理：

```
function useLoading() {  const [isLoading, setState] = React.useState(false)  const load = (aPromise: Promise<any>) => {    setState(true)    return aPromise.then(() => setState(false))  }  // 实际需要: [boolean, typeof load] 类型  // 而不是自动推导的：(boolean | typeof load)[]  return [isLoading, load] as const}
```

如果使用 **const** 断言遇到问题\[7\]，也可以直接定义返回类型:

```
export function useLoading(): [  boolean,  (aPromise: Promise<any>) => Promise<any>] {  const [isLoading, setState] = React.useState(false)  const load = (aPromise: Promise<any>) => {    setState(true)    return aPromise.then(() => setState(false))  }  return [isLoading, load]}
```

如果有大量的自定义 Hook 需要处理，这里有一个方便的工具方法可以处理 tuple 返回值:

```
function tuplify<T extends any[]>(...elements: T) {  return elements}function useLoading() {  const [isLoading, setState] = React.useState(false)  const load = (aPromise: Promise<any>) => {    setState(true)    return aPromise.then(() => setState(false))  }  // (boolean | typeof load)[]  return [isLoading, load]}function useTupleLoading() {  const [isLoading, setState] = React.useState(false)  const load = (aPromise: Promise<any>) => {    setState(true)    return aPromise.then(() => setState(false))  }  // [boolean, typeof load]  return tuplify(isLoading, load)}
```

默认属性 defaultProps
-----------------

大部分文章都**不推荐**使用 defaultProps **,** 相关讨论可以点击参考链接\[8\]

推荐方式：使用**默认参数值**来代替**默认属性：** 

```
type GreetProps = { age?: number }const Greet = ({ age = 21 }: GreetProps) => {  /* ... */}
```

### defaultProps 类型

TypeScript3.0+\[9\] 在默认属性 的类型推导上有了极大的改进，虽然尚且存在一些边界 case 仍然存在问题\[10\]，**不推荐使用**，如果有需要使用的场景，可参照如下方式：

```
type IProps = {  name: string}const defaultProps = {  age: 25,}// 类型定义type GreetProps = IProps & typeof defaultPropsconst Greet = (props: GreetProps) => <div></div>Greet.defaultProps = defaultProps// 使用const TestComponent = (props: React.ComponentProps<typeof Greet>) => {  return <h1 />}const el = <TestComponent name="foo" />
```

Types or Interfaces
-------------------

在日常的 react 开发中 **interface** 和 **type** 的使用场景十分类似

**implements** 与 **extends** 静态操作，不允许存在一种或另一种实现的情况，所以**不支持使用联合类型：** 

```
class Point {  x: number = 2  y: number = 3}interface IShape {  area(): number}type Perimeter = {  perimeter(): number}type RectangleShape = (IShape | Perimeter) & Pointclass Rectangle implements RectangleShape {  // 类只能实现具有静态已知成员的对象类型或对象类型的交集。  x = 2  y = 3  area() {    return this.x + this.y  }}interface ShapeOrPerimeter extends RectangleShape {}// 接口只能扩展使用静态已知成员的对象类型或对象类型的交集
```

### 使用 Type 还是 Interface？

有几种常用规则：

*   在定义公共 API 时(比如编辑一个库）使用 **interface**，这样可以方便使用者继承接口
    

*   在定义组件属性（Props）和状态（State）时，建议使用 **type**，因为 **type**的约束性更强
    

**interface** 和 **type** 在 ts 中是两个不同的概念，但在 React 大部分使用的 **case** 中，**interface** 和 **type** 可以达到相同的功能效果，**type** 和 **interface 最大的区别**是：

*   **type** 类型不能二次编辑，而 **interface** 可以随时扩展
    

```
interface Animal {  name: string}// 可以继续在原有属性基础上，添加新属性：colorinterface Animal {  color: string}/********************************/type Animal = {  name: string}// type类型不支持属性扩展// Error: Duplicate identifier 'Animal'type Animal = {  color: string}
```

### 获取未导出的 Type

某些场景下我们在引入第三方的库时会发现想要使用的组件并没有导出我们需要的组件参数类型或者返回值类型，这时候我们可以通过 ComponentProps/ ReturnType 来获取到想要的类型。

```
// 获取参数类型import { Button } from 'library' // 但是未导出props typetype ButtonProps = React.ComponentProps<typeof Button> // 获取propstype AlertButtonProps = Omit<ButtonProps, 'onClick'> // 去除onClickconst AlertButton: React.FC<AlertButtonProps> = props => (  <Button onClick={() => alert('hello')} {...props} />)
```

```
// 获取返回值类型function foo() {  return { baz: 1 }}type FooReturn = ReturnType<typeof foo> // { baz: number }
```

Props
-----

通常我们使用 **type** 来定义 **Props**，为了提高可维护性和代码可读性，在日常的开发过程中我们希望可以添加清晰的注释。

现在有这样一个 **type**

```
type OtherProps = {  name: string  color: string}
```

在使用的过程中，hover 对应类型会有如下展示

```
// type OtherProps = {//   name: string;//   color: string;// }const OtherHeading: React.FC<OtherProps> = ({ name, color }) => (  <h1>My Website Heading</h1>)
```

增加相对详细的注释，使用时会更清晰，需要注意，**注释需要使用** **/\*\*/** **，** **//** **无法被 vscode 识别**

```
// Great/** * @param color color * @param children children * @param onClick onClick */type Props = {  /** color */  color?: string  /** children */  children: React.ReactNode  /** onClick */  onClick: () => void}// type Props// @param color — color// @param children — children// @param onClick — onClickconst Button: React.FC<Props> = ({ children, color = 'tomato', onClick }) => {  return (    <button style={{ backgroundColor: color }} onClick={onClick}>      {children}    </button>  )}
```

常用 Props ts 类型
--------------

### 基础属性类型

```
type AppProps = {  message: string  count: number  disabled: boolean  /** array of a type! */  names: string[]  /** string literals to specify exact string values, with a union type to join them together */  status: 'waiting' | 'success'  /** 任意需要使用其属性的对象（不推荐使用，但是作为占位很有用） */  obj: object  /** 作用和`object`几乎一样，和 `Object`完全一样 */  obj2: {}  /** 列出对象全部数量的属性 （推荐使用） */  obj3: {    id: string    title: string  }  /** array of objects! (common) */  objArr: {    id: string    title: string  }[]  /** 任意数量属性的字典，具有相同类型*/  dict1: {    [key: string]: MyTypeHere  }  /** 作用和dict1完全相同 */  dict2: Record<string, MyTypeHere>  /** 任意完全不会调用的函数 */  onSomething: Function  /** 没有参数&返回值的函数 */  onClick: () => void  /** 携带参数的函数 */  onChange: (id: number) => void  /** 携带点击事件的函数 */  onClick(event: React.MouseEvent<HTMLButtonElement>): void  /** 可选的属性 */  optional?: OptionalType}
```

### 常用 React 属性类型

```
export declare interface AppBetterProps {  children: React.ReactNode // 一般情况下推荐使用，支持所有类型 Great  functionChildren: (name: string) => React.ReactNode  style?: React.CSSProperties // 传递style对象  onChange?: React.FormEventHandler<HTMLInputElement>}export declare interface AppProps {  children1: JSX.Element // 差, 不支持数组  children2: JSX.Element | JSX.Element[] // 一般, 不支持字符串  children3: React.ReactChildren // 忽略命名，不是一个合适的类型，工具类类型  children4: React.ReactChild[] // 很好  children: React.ReactNode // 最佳，支持所有类型 推荐使用  functionChildren: (name: string) => React.ReactNode // recommended function as a child render prop type  style?: React.CSSProperties // 传递style对象  onChange?: React.FormEventHandler<HTMLInputElement> // 表单事件, 泛型参数是event.target的类型}
```

Forms and Events
----------------

### onChange

**change** 事件，有两个定义参数类型的方法。

第一种方法使用推断的方法签名（例如：**React.FormEvent <HTMLInputElement>** **：void**）

```
import * as React from 'react'type changeFn = (e: React.FormEvent<HTMLInputElement>) => voidconst App: React.FC = () => {  const [state, setState] = React.useState('')  const onChange: changeFn = e => {    setState(e.currentTarget.value)  }  return (    <div>      <input type="text" value={state} onChange={onChange} />    </div>  )}
```

第二种方法强制使用 **@types / react** 提供的委托类型，两种方法均可。

```
import * as React from 'react'
```

### onSubmit

如果不太关心事件的类型，可以直接使用 **React.SyntheticEvent**，如果目标表单有想要访问的自定义命名输入，可以使用类型扩展

```
import * as React from 'react'const App: React.FC = () => {  const onSubmit = (e: React.SyntheticEvent) => {    e.preventDefault()    const target = e.target as typeof e.target & {      password: { value: string }    } // 类型扩展    const password = target.password.value  }  return (    <form onSubmit={onSubmit}>      <div>        <label>          Password:          <input type="password" name="password" />        </label>      </div>      <div>        <input type="submit" value="Log in" />      </div>    </form>  )}
```

Operators
---------

常用的操作符，常用于类型判断

*   typeof and instanceof: 用于类型区分
    

*   keyof: 获取 object 的 key
    
*   O\[K\]: 属性查找
    
*   \[K in O\]: 映射类型
    
*   \+ or - or readonly or ?: 加法、减法、只读和可选修饰符
    
*   x ? Y : Z: 用于泛型类型、类型别名、函数参数类型的条件类型
    
*   !: 可空类型的空断言
    
*   as: 类型断言
    
*   is: 函数返回类型的类型保护
    

Tips
----

### 使用查找类型访问组件属性类型

通过查找类型减少 **type** 的非必要导出，如果需要提供复杂的 **type**，应当提取到作为公共 API 导出的文件中。

现在我们有一个 Counter 组件，需要 name 这个必传参数：

```
// counter.tsximport * as React from 'react'export type Props = {  name: string}const Counter: React.FC<Props> = props => {  return <></>}export default Counter
```

在其他引用它的组件中我们有两种方式获取到 Counter 的参数类型

第一种是通过 **typeof** 操作符（**推荐**）

```
// Greatimport Counter from './d-tips1'type PropsNew = React.ComponentProps<typeof Counter> & {  age: number}const App: React.FC<PropsNew> = props => {  return <Counter {...props} />}export default App
```

第二种是通过在原组件进行导出

```
import Counter, { Props } from './d-tips1'type PropsNew = Props & {  age: number}const App: React.FC<PropsNew> = props => {  return (    <>      <Counter {...props} />    </>  )}export default App
```

### 不要在 type 或 interface 中使用函数声明

保持一致性，类型/接口的所有成员都通过相同的语法定义。

**\--strictFunctionTypes** 在比较函数类型时强制执行更严格的类型检查，但第一种声明方式下严格检查不生效。

```
✅interface ICounter {  start: (value: number) => string}❌interface ICounter1 {  start(value: number): string}🌰interface Animal {}interface Dog extends Animal {  wow: () => void}interface Comparer<T> {  compare: (a: T, b: T) => number}declare let animalComparer: Comparer<Animal>declare let dogComparer: Comparer<Dog>animalComparer = dogComparer // ErrordogComparer = animalComparer // Okinterface Comparer1<T> {  compare(a: T, b: T): number}declare let animalComparer1: Comparer1<Animal>declare let dogComparer1: Comparer1<Dog>animalComparer1 = dogComparer // OkdogComparer1 = animalComparer // Ok
```

### 事件处理

我们在进行事件注册时经常会在事件处理函数中使用 **event** 事件对象，例如当使用鼠标事件时我们通过 **clientX**、**clientY** 去获取指针的坐标。

大家可能会想到直接把 **event** 设置为 **any** 类型，但是这样就失去了我们对代码进行静态检查的意义。

```
function handleEvent(event: any) {、  console.log(event.clientY)}
```

试想下当我们注册一个 **Touch** 事件，然后错误的通过事件处理函数中的 **event** 对象去获取其 **clientY** 属性的值，在这里我们已经将 **event** 设置为 **any** 类型，导致 **TypeScript** 在编译时并不会提示我们错误， 当我们通过 **event.clientY** 访问时就有问题了，因为 **Touch** 事件的 **event** 对象并没有 **clientY** 这个属性。

通过 **interface** 对 **event** 对象进行类型声明编写的话又十分浪费时间，幸运的是 **React** 的声明文件提供了 Event 对象的类型声明。

#### Event 事件对象类型

*   ClipboardEvent<T = Element> 剪切板事件对象
    

*   DragEvent<T =Element> 拖拽事件对象
    
*   ChangeEvent<T = Element> Change 事件对象
    
*   KeyboardEvent<T = Element> 键盘事件对象
    
*   MouseEvent<T = Element> 鼠标事件对象
    
*   TouchEvent<T = Element> 触摸事件对象
    
*   WheelEvent<T = Element> 滚轮时间对象
    
*   AnimationEvent<T = Element> 动画事件对象
    
*   TransitionEvent<T = Element> 过渡事件对象
    

#### 事件处理函数类型

当我们定义事件处理函数时有没有更方便定义其函数类型的方式呢？答案是使用 **React** 声明文件所提供的 **EventHandler** 类型别名，通过不同事件的 **EventHandler** 的类型别名来定义事件处理函数的类型

```
type EventHandler<E extends React.SyntheticEvent<any>> = {  bivarianceHack(event: E): void}['bivarianceHack']type ReactEventHandler<T = Element> = EventHandler<React.SyntheticEvent<T>>type ClipboardEventHandler<T = Element> = EventHandler<React.ClipboardEvent<T>>type DragEventHandler<T = Element> = EventHandler<React.DragEvent<T>>type FocusEventHandler<T = Element> = EventHandler<React.FocusEvent<T>>type FormEventHandler<T = Element> = EventHandler<React.FormEvent<T>>type ChangeEventHandler<T = Element> = EventHandler<React.ChangeEvent<T>>type KeyboardEventHandler<T = Element> = EventHandler<React.KeyboardEvent<T>>type MouseEventHandler<T = Element> = EventHandler<React.MouseEvent<T>>type TouchEventHandler<T = Element> = EventHandler<React.TouchEvent<T>>type PointerEventHandler<T = Element> = EventHandler<React.PointerEvent<T>>type UIEventHandler<T = Element> = EventHandler<React.UIEvent<T>>type WheelEventHandler<T = Element> = EventHandler<React.WheelEvent<T>>type AnimationEventHandler<T = Element> = EventHandler<React.AnimationEvent<T>>type TransitionEventHandler<T = Element> = EventHandler<  React.TransitionEvent<T>>
```

**bivarianceHack** 为事件处理函数的类型定义，函数接收一个 **event** 对象，并且其类型为接收到的泛型变量 **E** 的类型, 返回值为 **void**

> 关于为何是用 bivarianceHack 而不是(event: E): void，这与 strictfunctionTypes 选项下的功能兼容性有关。(event: E): void，如果该参数是派生类型，则不能将其传递给参数是基类的函数。

```
class Animal {  private x: undefined}class Dog extends Animal {  private d: undefined}type EventHandler<E extends Animal> = (event: E) => voidlet z: EventHandler<Animal> = (o: Dog) => {} // fails under strictFunctionTyestype BivariantEventHandler<E extends Animal> = {  bivarianceHack(event: E): void}['bivarianceHack']let y: BivariantEventHandler<Animal> = (o: Dog) => {}
```

### Promise 类型

在做异步操作时我们经常使用 **async** 函数，函数调用时会 **return** 一个 **Promise** 对象，可以使用 **then** 方法添加回调函数。**Promise<T>** 是一个泛型类型，**T** 泛型变量用于确定 **then** 方法时接收的第一个回调函数的参数类型。

```
type IResponse<T> = {  message: string  result: T  success: boolean}async function getResponse(): Promise<IResponse<number[]>> {  return {    message: '获取成功',    result: [1, 2, 3],    success: true,  }}getResponse().then(response => {  console.log(response.result)})
```

首先声明 **IResponse** 的泛型接口用于定义 **response** 的类型，通过 **T** 泛型变量来确定 **result** 的类型。然后声明了一个 异步函数 **getResponse** 并且将函数返回值的类型定义为 **Promise<IResponse<number\[\]>>** 。最后调用 **getResponse** 方法会返回一个 **promise** 类型，通过 **then** 调用，此时 **then** 方法接收的第一个回调函数的参数 **response** 的类型为，**{ message: string, result: number\[\], success: boolean}** 。

### 泛型参数的组件

下面这个组件的 name 属性都是指定了传参格式，如果想不指定，而是想通过传入参数的类型去推导实际类型，这就要用到泛型。

```
const TestB = ({ name, name2 }: { name: string; name2?: string }) => {  return (    <div className="test-b">      TestB--{name}      {name2}    </div>  )}
```

如果需要外部传入参数类型，只需 ->

```
type Props<T> = {  name: T  name2?: T}const TestC: <T>(props: Props<T>) => React.ReactElement = ({ name, name2 }) => {  return (    <div className="test-b">      TestB--{name}      {name2}    </div>  )}const TestD = () => {  return (    <div>      <TestC<string> name="123" />    </div>  )}
```

### 什么时候使用泛型

当你的函数，接口或者类：

*   需要作用到很多类型的时候，举个 🌰
    

当我们需要一个 id 函数，函数的参数可以是任何值，返回值就是将参数原样返回，并且其只能接受一个参数，在 js 时代我们会很轻易地甩出一行

```
const id = arg => arg
```

由于其可以接受任意值，也就是说我们的函数的入参和返回值都应该可以是任意类型，如果不使用泛型，我们只能重复的进行定义

```
type idBoolean = (arg: boolean) => booleantype idNumber = (arg: number) => numbertype idString = (arg: string) => string// ...
```

如果使用泛型，我们只需要

```
function id<T>(arg: T): T {  return arg}// 或const id1: <T>(arg: T) => T = arg => {  return arg}
```

*   需要被用到很多地方的时候，比如常用的工具泛型 **Partial**。
    

功能是将类型的属性**变成可选，** 注意这是浅 **Partial**。

```
type Partial<T> = { [P in keyof T]?: T[P] }
```

如果需要深 Partial 我们可以通过泛型递归来实现

```
type DeepPartial<T> = T extends Function  ? T  : T extends object  ? { [P in keyof T]?: DeepPartial<T[P]> }  : Ttype PartialedWindow = DeepPartial<Window>
```

字节跳动懂车帝团队招聘
-----------

我们是字节跳动旗下懂车帝产品线，目前业务上正处于高速发展阶段，懂车帝自 2017 年 8 月正式诞生，仅三年时间已经是汽车互联网行业第二。

现在前端团队主流的技术栈是 React、Typescript，主要负责懂车帝 App、M 站、PC 站、懂车帝小程序产品矩阵、商业化海量业务，商业数据产品等。我们在类客户端、多宿主、技术建站、中后台系统、全栈、富交互等多种应用场景都有大量技术实践，致力于技术驱动业务发展，探索所有可能性。

加入懂车帝，一起打造汽车领域最专业最开放的前端团队！

**简历直达**：dcar\_fe@bytedance.com

**邮件标题**：应聘+城市+岗位名称

福利广播
----

戳**阅读原文**， 填写问卷领取福利！

超多精美礼品等你来拿！

![](https://mmbiz.qpic.cn/mmbiz_png/lP9iauFI73z8RibGo3l1nkCdib27o1dgZC4wM5OWaD6SJxtKeo8uibAY7JRKkrgrbnkcuL0UwCGgmtacKDIsr8Qa9w/640?wx_fmt=png)

### 参考资料

\[1\]

2ality's guide: _http://2ality.com/2018/04/type-notation-typescript.html_

\[2\]

chibicode's tutorial: _https://ts.chibicode.com/todo/_

\[3\]

TS 部分: _https://reactjs.org/docs/static-type-checking.html#typescript_

\[4\]

React 部分: _http://www.typescriptlang.org/play/index.html?jsx=2&esModuleInterop=true&e=181#example/typescript-with-react_

\[5\]

被证明: _https://www.reddit.com/r/reactjs/comments/iyehol/import\_react\_from\_react\_will\_go\_away\_in\_distant/_

\[6\]

一些 issue: _https://github.com/DefinitelyTyped/DefinitelyTyped/issues/33006_

\[7\]

问题: _https://github.com/babel/babel/issues/9800_

\[8\]

参考链接: _https://twitter.com/hswolff/status/1133759319571345408_

\[9\]

TypeScript3.0+: _https://www.typescriptlang.org/docs/handbook/release-notes/typescript-3-0.html_

\[10\]

存在一些边界 case 仍然存在问题: _https://github.com/typescript-cheatsheets/react-typescript-cheatsheet/issues/61_
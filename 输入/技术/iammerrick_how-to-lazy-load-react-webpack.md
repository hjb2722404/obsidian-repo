iammerrick/how-to-lazy-load-react-webpack

# [(L)](https://github.com/iammerrick/how-to-lazy-load-react-webpack#how-to-lazy-load-react-in-webpack)How to lazy load React in Webpack

This is an example repository of lazily loading React in webpack.

## [(L)](https://github.com/iammerrick/how-to-lazy-load-react-webpack#try-it-out)Try it out

- ` npm install && npm start `
- ` npm install && npm run build `

It supports two APIs:

## [(L)](https://github.com/iammerrick/how-to-lazy-load-react-webpack#higher-order-component-for-specifying-dependencies)Higher Order Component for Specifying Dependencies

import  React  from  'react';import { LazilyLoadFactory } from  './LazilyLoad';export  default  LazilyLoadFactory(class  extends  React.Component { render() { return ( <div ref={(ref) =>  this.props.$(ref).css('background-color', 'red')}> Hello </div> );

}
}, {
$: () =>  System.import('jquery'),
});

## [(L)](https://github.com/iammerrick/how-to-lazy-load-react-webpack#function-as-child-for-consumer-lazy-loading)Function as Child for Consumer Lazy Loading

import  LazilyLoad, {importLazy} from  './LazilyLoad';import  React  from  'react';<LazilyLoad modules={{ LoadedLate: () =>  importLazy(System.import('./LoadedLate'))

}}> {({LoadedLate}) =>  <LoadedLate />}</LazilyLoad>

# [(L)](https://github.com/iammerrick/how-to-lazy-load-react-webpack#how-to-lazy-load-react-in-webpack)How to lazy load React in Webpack

This is an example repository of lazily loading React in webpack.

## [(L)](https://github.com/iammerrick/how-to-lazy-load-react-webpack#try-it-out)Try it out

- ` npm install && npm start `
- ` npm install && npm run build `

It supports two APIs:

## [(L)](https://github.com/iammerrick/how-to-lazy-load-react-webpack#higher-order-component-for-specifying-dependencies)Higher Order Component for Specifying Dependencies

import  React  from  'react';import { LazilyLoadFactory } from  './LazilyLoad';export  default  LazilyLoadFactory(class  extends  React.Component { render() { return ( <div ref={(ref) =>  this.props.$(ref).css('background-color', 'red')}> Hello </div> );

}
}, {
$: () =>  System.import('jquery'),
});

## [(L)](https://github.com/iammerrick/how-to-lazy-load-react-webpack#function-as-child-for-consumer-lazy-loading)Function as Child for Consumer Lazy Loading

import  LazilyLoad, {importLazy} from  './LazilyLoad';import  React  from  'react';<LazilyLoad modules={{ LoadedLate: () =>  importLazy(System.import('./LoadedLate'))

}}> {({LoadedLate}) =>  <LoadedLate />}</LazilyLoad>
Using create-react-app with React Router + Express.js

# Using [create-react-app](https://github.com/facebookincubator/create-react-app) with [React Router](https://github.com/reactjs/react-router) + Express.js

I’m writing this guide because I haven’t found implementations of this setup using the new and cool (and official) [create-react-app](https://github.com/facebookincubator/create-react-app) by Facebook.

***> This is not about server-side rendering or Redux.***
The source code is available here: https://github.com/mrpatiwi/routed-react

#### Why this is important?

Suppose you want to start a new project with React.js and because you are a good software developer, you want to use [npm](https://www.npmjs.com/), [babel](https://babeljs.io/) and [webpack](https://webpack.github.io/).

> Where to start?

Before [create-react-app](https://github.com/facebookincubator/create-react-app) you had to search and try a [infinite amount of boilerplates and example repositories](http://andrewhfarmer.com/starter-project/) to finally had a mediocre setup after two days of wasted time.

Now it’s easier :)

### Getting started

I assume you already have [Node.js](https://nodejs.org/) and [npm](https://www.npmjs.com/) installed. So we begin with the *cli*:

npm install -g create-react-app
And let’s create an app named *routed-react:*
create-react-app routed-react
cd routed-react
To start or application at http://localhost:3000/ we run:
npm start

![](../_resources/af61f3507fd53769f8cf842beee34fc4.png)![1*S1tkR_QoaT8sqcIDsUnLjw.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106130251.png)

#### Refactor project structure

Considering that the project eventually will grow. Let’s make some changes to the directory structure.

> I find a good practice to have reusable components with modificable styles.

Always consider composing *className* props and passing the remaining props to the first component. I recommend using [classnames](https://github.com/JedWatson/classnames) library to do so:

npm install --save classnames
Create a *components* directory:

# Create 'components' directory and 'App' sub-directory

mkdir -p src/components/App

# Move App component to new directory

mv src/App.js src/components/App/index.js
mv src/App.css src/components/App/style.css
mv src/logo.svg src/components/App/logo.svg
And modify the App component:

|     |     |
| --- | --- |
| 1   | // src/components/App/index.js |
| 2   | import  React, { PropTypes, Component } from  'react'; |
| 3   | import  classnames  from  'classnames'; |
| 4   |     |
| 5   | import  logo  from  './logo.svg'; |
| 6   | import  './style.css'; |
| 7   |     |
| 8   | class  App  extends  Component { |
| 9   |  // static propTypes = {} |
| 10  |  // static defaultProps = {} |
| 11  |  // state = {} |
| 12  |     |
| 13  |  render() { |
| 14  |  const { className, ...props } =  this.props; |
| 15  |  return ( |
| 16  |  <div className={classnames('App', className)} {...props}> |
| 17  |  <div className="App-header"> |
| 18  |  <img src={logo} className="App-logo" alt="logo"  /> |
| 19  |  <h2>Welcome to React</h2> |
| 20  |  </div> |
| 21  |  <p className="App-intro"> |
| 22  | To get started, edit <code>src/App.js</code> and save to reload. |
| 23  |  </p> |
| 24  |  </div> |
| 25  | );  |
| 26  | }   |
| 27  | }   |
| 28  |     |
| 29  | export  default  App; |

 [view raw](https://gist.github.com/mrpatiwi/25bd41728e8141826261e8e5e8b7b047/raw/22ff55ef05914e1293edb1950139777556327cd4/App.js)  [App.js](https://gist.github.com/mrpatiwi/25bd41728e8141826261e8e5e8b7b047#file-app-js) hosted with ❤ by [GitHub](https://github.com/)

Now start an ***About*** component that will be shown at */about*
mkdir src/components/About
touch src/components/About/index.js
touch src/components/About/style.css
A sample *About* component:

|     |     |
| --- | --- |
| 1   | // src/components/About/index.js |
| 2   | import  React, { PropTypes, Component } from  'react'; |
| 3   | import  classnames  from  'classnames'; |
| 4   |     |
| 5   | import  './style.css'; |
| 6   |     |
| 7   | export  default  class  About  extends  Component { |
| 8   |  // static propTypes = {} |
| 9   |  // static defaultProps = {} |
| 10  |  // state = {} |
| 11  |     |
| 12  |  render() { |
| 13  |  const { className, ...props } =  this.props; |
| 14  |  return ( |
| 15  |  <div className={classnames('About', className)} {...props}> |
| 16  |  <h1> |
| 17  | About |
| 18  |  </h1> |
| 19  |  </div> |
| 20  | );  |
| 21  | }   |
| 22  | }   |

 [view raw](https://gist.github.com/mrpatiwi/681141801673ae2139dc622c4188ec7e/raw/a5d3b8cd829cb10526c5d04763cccd63d989817b/About.js)  [About.js](https://gist.github.com/mrpatiwi/681141801673ae2139dc622c4188ec7e#file-about-js) hosted with ❤ by [GitHub](https://github.com/)

Reusability FTW!
Finally a ***NotFound*** component for all those 404's:
mkdir src/components/NotFound
touch src/components/NotFound/index.js
touch src/components/NotFound/style.css

|     |     |
| --- | --- |
| 1   | // src/components/NotFound/index.js |
| 2   | import  React, { PropTypes, Component } from  'react'; |
| 3   | import  classnames  from  'classnames'; |
| 4   |     |
| 5   | import  './style.css'; |
| 6   |     |
| 7   | export  default  class  NotFound  extends  Component { |
| 8   |  // static propTypes = {} |
| 9   |  // static defaultProps = {} |
| 10  |  // state = {} |
| 11  |     |
| 12  |  render() { |
| 13  |  const { className, ...props } =  this.props; |
| 14  |  return ( |
| 15  |  <div className={classnames('NotFound', className)} {...props}> |
| 16  |  <h1> |
| 17  |  404  <small>Not Found :(</small> |
| 18  |  </h1> |
| 19  |  </div> |
| 20  | );  |
| 21  | }   |
| 22  | }   |

 [view raw](https://gist.github.com/mrpatiwi/bf02417e681480c3517b24d2d160df3d/raw/c601f1679326a09aa06d92c04d1f0cd7a9a7a4eb/NotFound.js)  [NotFound.js](https://gist.github.com/mrpatiwi/bf02417e681480c3517b24d2d160df3d#file-notfound-js) hosted with ❤ by [GitHub](https://github.com/)

At this moment the app should be crashing, don’t worry about that. We are fixing it right now.

#### Router setup

Let’s begin with [react-router](https://github.com/reactjs/react-router). We also want to use [browserHistory](https://github.com/reactjs/react-router/blob/master/docs/guides/Histories.md#browserhistory) strategy. The [official docs](https://github.com/reactjs/react-router/blob/master/docs/guides/Histories.md#browserhistory) will explain what it does better than me:

> Browser history is the recommended history for browser application with React Router. It uses the > [> History](https://developer.mozilla.org/en-US/docs/Web/API/History)>  API built into the browser to manipulate the URL, creating real URLs that look like example.com/some/path.

Just install it:
npm install --save react-router
Now we must define our routes:

|     |     |
| --- | --- |
| 1   | // src/routes.js |
| 2   | import  React  from  'react'; |
| 3   | import { Router, Route } from  'react-router'; |
| 4   |     |
| 5   | import  App  from  './components/App'; |
| 6   | import  About  from  './components/About'; |
| 7   | import  NotFound  from  './components/NotFound'; |
| 8   |     |
| 9   | const  Routes  = (props) => ( |
| 10  |  <Router {...props}> |
| 11  |  <Route path="/" component={App} /> |
| 12  |  <Route path="/about" component={About} /> |
| 13  |  <Route path="*" component={NotFound} /> |
| 14  |  </Router> |
| 15  | );  |
| 16  |     |
| 17  | export  default  Routes; |

 [view raw](https://gist.github.com/mrpatiwi/0703eb5feaa6a96b0ee60c36578f18d8/raw/f96bf29e1d0a4e787771b889a5eec39cfdb79526/routes.js)  [routes.js](https://gist.github.com/mrpatiwi/0703eb5feaa6a96b0ee60c36578f18d8#file-routes-js) hosted with ❤ by [GitHub](https://github.com/)

And the main index.js now looks like:

|     |     |
| --- | --- |
| 1   | // src/index.js |
| 2   | import  React  from  'react'; |
| 3   | import  ReactDOM  from  'react-dom'; |
| 4   | import { browserHistory } from  'react-router'; |
| 5   |     |
| 6   | import  Routes  from  './routes'; |
| 7   |     |
| 8   | import  './index.css'; |
| 9   |     |
| 10  | ReactDOM.render( |
| 11  |  <Routes history={browserHistory} />, |
| 12  |  document.getElementById('root') |
| 13  | );  |

 [view raw](https://gist.github.com/mrpatiwi/983b6398fec734788a5cd8df7b1b956e/raw/2b7a33c2780d31f5944562fd63e2c4862497ca75/index.js)  [index.js](https://gist.github.com/mrpatiwi/983b6398fec734788a5cd8df7b1b956e#file-index-js) hosted with ❤ by [GitHub](https://github.com/)

So much better :)

If we visit http://localhost:3000/about we should see (any other route will show our *404* view):

![](../_resources/f8c3c1467f67068c7f5755c7b5de19a5.png)![1*ujW7ZDC8fs2Y_ZQsvf5zrg.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210106130307.png)

### Usage with Express.js

So we need to serve our app. Github pages or similar will probably won’t work as expected unless you host the app on the root domain. Even if you do that, will only navigate as expected if the first visited page is the root.

Our option is to use a own hosting and always serve the main index.html for every possible route (that doesn’t override the access to the other static files as *.js*, *.css* and *.favicon*).

# Install dependencies

npm install --save express morgan

# Create server files

mkdir server
touch server/app.js
touch server/index.js

|     |     |
| --- | --- |
| 1   | // server/app.js |
| 2   | const  express  =  require('express'); |
| 3   | const  morgan  =  require('morgan'); |
| 4   | const  path  =  require('path'); |
| 5   |     |
| 6   | const  app  =  express(); |
| 7   |     |
| 8   | // Setup logger |
| 9   | app.use(morgan(':remote-addr - :remote-user [:date[clf]] ":method :url HTTP/:http-version" :status :res[content-length] :response-time ms')); |
| 10  |     |
| 11  | // Serve static assets |
| 12  | app.use(express.static(path.resolve(__dirname, '..', 'build'))); |
| 13  |     |
| 14  | // Always return the main index.html, so react-router render the route in the client |
| 15  | app.get('*', (req, res) => { |
| 16  |  res.sendFile(path.resolve(__dirname, '..', 'build', 'index.html')); |
| 17  | }); |
| 18  |     |
| 19  | module.exports  = app; |

 [view raw](https://gist.github.com/mrpatiwi/4e54213f0231b73ff551fced61bd9a02/raw/685aebf5a7ee336589e94f524692432436434251/app.js)  [app.js](https://gist.github.com/mrpatiwi/4e54213f0231b73ff551fced61bd9a02#file-app-js) hosted with ❤ by [GitHub](https://github.com/)

|     |     |
| --- | --- |
| 1   | // server/index.js |
| 2   | 'use strict'; |
| 3   |     |
| 4   | const  app  =  require('./app'); |
| 5   |     |
| 6   | const  PORT  =  process.env.PORT  \|\|  9000; |
| 7   |     |
| 8   | app.listen(PORT, () => { |
| 9   |  console.log(`App listening on port ${PORT}!`); |
| 10  | }); |

 [view raw](https://gist.github.com/mrpatiwi/4e54213f0231b73ff551fced61bd9a02/raw/685aebf5a7ee336589e94f524692432436434251/index.js)  [index.js](https://gist.github.com/mrpatiwi/4e54213f0231b73ff551fced61bd9a02#file-index-js) hosted with ❤ by [GitHub](https://github.com/)

To see if everything is working well, build the app and start the server:

# Build to 'build' directory (it's ignored by git, see .gitignore)

npm run build

# Start the express.js app

node server
Visit http://localhost:9000/about and **everything should be working fine.**

#### Testing

> Only for projects created with **> create-react-app 0.3.0**>  or lower.

Do you want testing? Ok testing, but focused in unit-testing the serving of assets of our Express.js app.

- •Mocha
- •Chai
- •Supertest (as promised)

# Install dependencies

npm install --save-dev mocha chai supertest supertest-as-promised mz

# Create test directory

mkdir test
touch test/server.test.js

[*mz*](https://github.com/normalize/mz) is a library to *modernize* some Node.js native functions.

> We love promises, right?
Remember to modify the scripts from *package.json*:
"scripts": {
"start": "react-scripts start",
"start:server": "node server",
"build": "react-scripts build",
"eject": "react-scripts eject",
"test": "mocha test"
},
Basically we expect that:

- •The React.js app builds successfully
- •The Express.js server send us the index.html file for any route
- •The Express.js server send us the assets requested by the browser.

|     |     |
| --- | --- |
| 1   | // test/server.test.js |
| 2   | const  exec  =  require('mz/child_process').exec; |
| 3   | const  request  =  require('supertest-as-promised'); |
| 4   | const  expect  =  require('chai').expect; |
| 5   |     |
| 6   | const  app  =  require('../server/app'); |
| 7   |     |
| 8   | describe('builds application', function () { |
| 9   |  it('builds to "build" directory', function () { |
| 10  |  // Disable mocha time-out because this takes a lot of time |
| 11  |  this.timeout(0); |
| 12  |     |
| 13  |  // Run process |
| 14  |  return  exec('npm run build'); |
| 15  | }); |
| 16  | }); |
| 17  |     |
| 18  | describe('express serving', function () { |
| 19  |  it('responds to / with the index.html', function () { |
| 20  |  return  request(app) |
| 21  | .get('/') |
| 22  | .expect('Content-Type',  /html/) |
| 23  | .expect(200) |
| 24  | .then(res  =>  expect(res.text).to.contain('<div id="root"></div>')); |
| 25  | }); |
| 26  |     |
| 27  |  it('responds to favicon.icon request', function () { |
| 28  |  return  request(app) |
| 29  | .get('/favicon.ico') |
| 30  | .expect('Content-Type', 'image/x-icon') |
| 31  | .expect(200); |
| 32  | }); |
| 33  |     |
| 34  |  it('responds to any route with the index.html', function () { |
| 35  |  return  request(app) |
| 36  | .get('/foo/bar') |
| 37  | .expect('Content-Type',  /html/) |
| 38  | .expect(200) |
| 39  | .then(res  =>  expect(res.text).to.contain('<div id="root"></div>')); |
| 40  | }); |
| 41  | }); |

 [view raw](https://gist.github.com/mrpatiwi/52716ea7c17fa8c1631e7f1ba5507ddd/raw/f51ef4c82f95aff84ed464112d97bfb23f5edd5a/server.test.js)  [server.test.js](https://gist.github.com/mrpatiwi/52716ea7c17fa8c1631e7f1ba5507ddd#file-server-test-js) hosted with ❤ by [GitHub](https://github.com/)

Run the test suite with ***npm test****  *☕️
$ npm test
> routed-react@0.0.1 test /Users/patriciolopez/Repositories/routed-react
> mocha test
builds application
✓ builds to "build" directory (9017ms)
express serving
✓ responds to / with the index.html (38ms)
✓ responds to favicon.icon request
✓ responds to any route with the index.html
4 passing (9s)

You can see that building the React.js app takes a lot of time, but this is a expected behavior because behind the scenes some unused code is removed and the rest if *transpiled*, *optimized*, *uglificated* and *bundled* in a few lightweight files.

Oh! wait!
1:1 warning 'use strict' is unnecessary ... strict
9:1 warning 'describe' is not defined no-undef
10:3 warning 'it' is not defined no-undef
19:1 warning 'describe' is not defined no-undef
20:3 warning 'it' is not defined no-undef
28:3 warning 'it' is not defined no-undef
35:3 warning 'it' is not defined no-undef

#### Customize [ESLint](http://eslint.org/)

You should be using [ESLint](http://eslint.org/) and a IDE plugin like [atom-eslint](https://atom.io/packages/linter-eslint) or similar (depending on your favorite development environment).

*create-react-app* comes with a default config for it. You can override this settings within *eslintConfig *at your main *package.json* file. So to disable the test suit warnings I recommend to edit it as follow:

"eslintConfig": {
"extends": "./node_modules/react-scripts/config/eslint.js",
"env": {
"browser": true,
"mocha": true,
"node": true
},
"rules": {
"strict": 0
}
}

See http://eslint.org/docs/user-guide/configuring for more customizing information.

### Docker

Finally, let’s use the best deployment tool ever 🐳
touch Dockerfile

Write the following (it’s based on the officials [Node.js docs](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/)):

|     |     |
| --- | --- |
| 1   | # Dockerfile |
| 2   | FROM node:6 |
| 3   |     |
| 4   | # Create app directory |
| 5   | RUN mkdir -p /usr/src/app |
| 6   | WORKDIR /usr/src/app |
| 7   |     |
| 8   | # Install app dependencies |
| 9   | COPY package.json /usr/src/app/ |
| 10  | RUN npm install |
| 11  |     |
| 12  | # Bundle app source |
| 13  | COPY . /usr/src/app |
| 14  |     |
| 15  | # Build and optimize react app |
| 16  | RUN npm run build |
| 17  |     |
| 18  | EXPOSE 9000 |
| 19  |     |
| 20  | # defined in package.json |
| 21  | CMD [ "npm", "run", "start:server" ] |

 [view raw](https://gist.github.com/mrpatiwi/f264caaf0e47661ea21986e0b674955a/raw/6cf8ed1ff13d08a088bd1d1730d3f6aa885f3e8f/Dockerfile)  [Dockerfile](https://gist.github.com/mrpatiwi/f264caaf0e47661ea21986e0b674955a#file-dockerfile) hosted with ❤ by [GitHub](https://github.com/)

Notice that we build our app inside the Docker image build step. Finally, when the container is started it should execute *npm run start:server *and start the Express.js app at port *9000*.

#### Running with Docker

Be sure to install Docker and start a Docker-machine if necessary. Let’s create an image named *routed-react*:

docker build -t routed-react .
Finally, start a container named *routed-react-instance* at port *80*.
docker run -p 80:9000 --name routed-react-instance routed-react
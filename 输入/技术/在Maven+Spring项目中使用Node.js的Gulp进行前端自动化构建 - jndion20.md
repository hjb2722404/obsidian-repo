在Maven+Spring项目中使用Node.js的Gulp进行前端自动化构建 - jndion2011的个人空间 - 开源中国社区

# 原在Maven+Spring项目中使用Node.js的Gulp进行前端自动化构建

发表于1年前(2015-04-04 17:30)   阅读（2209） | 评论（[3](http://my.oschina.net/jndion/blog/396104#comments)） *15*人收藏此文章,[我要收藏](在Maven+Spring项目中使用Node.js的Gulp进行前端自动化构建%20-%20jndion20.md#)

*赞**0*

 [![151745_FZKo_2491310.jpg](../_resources/e89f046c8c48c4a9db205c6cb7cbbb7f.jpg)](http://click.aliyun.com/m/4601/)

*摘要*  在Maven+Spring项目中使用Node.js的Gulp进行前端自动化构建

[node.js](http://www.oschina.net/search?scope=blog&q=node.js) [maven](http://www.oschina.net/search?scope=blog&q=maven) [spring](http://www.oschina.net/search?scope=blog&q=spring)

刚开始打算进行前后端分离开发，后来发现在使用JSP或者Freemarker做动态页面时，想发挥这些自动化构建工具牛逼闪闪的livereload功能并不是那么的轻易，因为我们必须还得调教它们去调用Java容器。现在全球社区似乎还没有成熟的插件可以自动帮我们调教Java容器，百度Fis的Jello也只是做了一下velocity的自动化，自己写感觉就是自虐，所以在这个问题上倒不如把Gulp当成一个Maven来使用，反正J2EE开发人员应该大都习惯了修改代码之后漫长无尽的build。相反，如果对Gulp调教好了watchify，只对发生了修改的文件进行重新构建，那么速度必定不是问题，也不必要我们每次修改都手动打包。

目前刚刚开始应用这一技术，用Gulp主要为了做前端工程和代码优化，之所以没有选择相较而言社区更加健壮的Grunt，可能主要还是因为Gulp的代码写起来更加轻松，而且采用Stream对构建速度有明显的提升。本文使用Gulp主要为了实现以下几个功能：优化CSS，对CSS进行合并，压缩，加MD5版本控制，生成Map映射；优化JS，对JS进行合并，压缩，加MD5版本控制，生成Map映射；优化JSP页面文件，自动产生对应原始文件压缩后资源文件的路径。我们最终要达到的效果是，压缩后的CSS文件一个，压缩后的JS文件一个，JSP页面自动产生对应MD5版本的资源文件。之所以要加MD5进行文件版本控制，是因为MD5在文件未发生修改的情况下，是不会发生改变的，因此服务器相应的资源就不需要进行替换。我们还要考虑到将所有同类资源合并到一个文件内的弊端，那就是如果网站内容较多时，可能大部分资源并不是一个页面真正需要的，这并不是理想的优化效果。对于这个问题，我们可以考虑结合使用browserify等模块管理工具。更省事的方法是，简单分析一下网站对资源的需求。一般的站点通常有一个门户网站和一个后台管理系统，门户网站页面使用到的资源和后台管理系统使用的资源可能会有较大的差异性，而两者自身的页面之间其实差异并不是非常大。所以我们也可以专门为门户网站和后台系统设计两套资源，省去了使用Browserify构建可能产生的大量冗余文件。

使用Gulp之前，我们首先需要安装一下Node.js和NPM包管理工具。因为我们是在Maven+Spring框架下做前端开发，因此在正式写代码之前，还需要搭建好一个maven的项目。一个典型的Maven项目可以如下图所示，在这里我们加了2个maven项目模块，静态资源放在webapp模块中，动态页面放在WEB-INF内，配置完成之后，maven项目就可以正常工作了。

[![1](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107132022.png)](http://static.oschina.net/uploads/space/2015/0404/122748_w2Tt_2319390.png)类似于maven，npm和gulp也需要相应的配置文件，分别是package.json和gulpfile.js。gulp中我们所需要用到的插件如下：

	<!-- lang: js -->
	var gulp = require('gulp'),
	rev = require('gulp-rev'),
	minifycss = require('gulp-minify-css'),
	uglify = require('gulp-uglify'),
	concat = require('gulp-concat'),
	sourcemaps = require('gulp-sourcemaps'),
	del = require('del'),
	revreplace = require('gulp-rev-replace');

使用`npm install package-name --save-dev`指令可以进行对应插件的安装，或者在配置好package.json文件之后，使用`npm install`进行一次性安装，所有这些库文件会生成到根目录下的node_module文件夹内。

gulp的工作流程如下：

首先在项目根目录下创建一个src文件夹，将前端需要的静态资源放在文件夹内作为源码开发使用。gulp工作流首先读取这些文件，进行对应的合并压缩处理，最后将产品输出到maven模块相应的静态资源路径和动态页面路径下，这样就完成了一整套简单的自动化构建过程。在下面这个例子中，我们分别构建一个简单的登陆页面和后台页面流程，最后用一个gulp默认指令完成全部工作。首先定义一下文件输入目录：

	<!-- lang: js -->
	var path = {
	    css: 'maven-webapp/webapp/static/css',
	    js: 'maven-webapp/webapp/static/js',
	    jsp: 'maven-webapp/webapp/WEB-INF/jsp'
	};

然后写一个login界面的css压缩合并优化生产线。如下文所示，在这段代码中，我们首先用"del"指令删除上一次构建产生的旧文件。其中rev-manifest.json是MD5版本工具输出的一组数据，它的作用是记录合并后的文件添加了MD5版本数之后的文件名。将4个文件进行合并，合并之前初始化sourcemap，这样在处理完成之后可以生成映射文件，有了这个映射文件，我们就可以在谷歌浏览器的调试工具下面查看到压缩前源码的形式。concat执行文件合并指令，path定义了合并结果的文件名，合并之后用minifycss压缩整理，紧接着给文件加上MD5版本号，到这里修改完成，写出映射文件，并将结果导出到maven项目的目录里面。

	<!-- lang: js -->
	gulp.task('login-css-min', function() {
	del(['rev-manifest.json',
	    path.css + '/login.*.*',
	    path.js + '/login-bundle.*.*',
	    path.jsp + '/login.jsp'], function(err, deletedFiles) {
	    console.log('Files deleted:\n', deletedFiles.join('\n'));
	});
	return gulp.src(['src/css/bootstrap.css',
	    'src/css/bootstrap-reset.css',
	    'src/css/style-responsive.css',
	    'src/css/login.css'])
	    .pipe(sourcemaps.init())
	    .pipe(concat({path:'login.min.css', cwd: ''}))
	    .pipe(minifycss())
	    .pipe(rev())
	    .pipe(sourcemaps.write('.'))
	    .pipe(gulp.dest(path.css))
	    .pipe(rev.manifest())
	    .pipe(gulp.dest(''));
	});

js的合并和压缩是类似的。但是需要注意，当我们合并js的时候，还是尽量使用闭包的匿名函数，避免插件污染全局变量。在下面的代码中，我在最头上加了一个namespace.js的文件，将它暴露在全局环境中，目的就是让它做命名空间的管理。

	<!-- lang: js -->
	gulp.task('login-js-min', ['login-css-min'], function() {
	return gulp.src(['src/js/Namespace.js', 'src/js/lib/jquery.js', 'src/js/main.js'])
	    .pipe(sourcemaps.init())
	    .pipe(concat({path:'login-bundle.min.js', cwd: ''}))
	    .pipe(uglify())
	    .pipe(rev())
	    .pipe(sourcemaps.write('.'))
	    .pipe(gulp.dest(path.js))
	    .pipe(rev.manifest({base:'', merge: true}))
	    .pipe(gulp.dest(''));
	});

第三步，根据rev-manifest.json的文件名映射，把jsp内对应的资源路径修改成加了MD5版本数字后的路径名。

	<!-- lang: js -->
	gulp.task("login-build", ['login-js-min'], function() {
	var manifest = gulp.src("rev-manifest.json");
	return gulp.src( "src/jsp/login.jsp")
	    .pipe(revreplace({replaceInExtensions: ['.jsp'], manifest: manifest}))
	    .pipe(gulp.dest(path.jsp));
	});

同样的方法做一下后台页面的资源合并压缩：

	<!-- lang: js -->
	gulp.task('index-css-min', function() {
	del([
	    'rev-manifest.json',
	    path.css + '/index.*.*',
	    path.js + '/index-bundle.*.*',
	    path.jsp + '/index/*.*'], function(err, deletedFiles) {
	    console.log('Files deleted:\n', deletedFiles.join('\n'));
	});
	return gulp.src([
	    'src/css/index/jquery.fullPage.css',
	    'src/css/index/tipso.min.css',
	    'src/css/index/show.css',
	    'src/css/index/style.css'
	    ])
	    .pipe(sourcemaps.init())
	    .pipe(concat({path:'index.min.css', cwd: ''}))
	    .pipe(minifycss())
	    .pipe(rev())
	    .pipe(sourcemaps.write('.'))
	    .pipe(gulp.dest(path.css))
	    .pipe(rev.manifest())
	    .pipe(gulp.dest(''));
	});
	
	gulp.task('index-js-min', ['index-css-min'], function() {
	return gulp.src([
	    'src/js/Namespace.js',
	    'src/js/lib/jquery.js',
	    'src/js/lib/jquery.*.min.js',
	    'src/js/lib/jquery-ui-1.10.3.min.js',
	    'src/js/lib/smooth-scroll.min.js',
	    'src/js/lib/tipso.min.js',
	    'src/js/lib/transit.js',
	    'src/js/index/*.js'])
	    .pipe(sourcemaps.init())
	    .pipe(concat({path:'index-bundle.min.js', cwd: ''}))
	    .pipe(uglify())
	    .pipe(rev())
	    .pipe(sourcemaps.write('.'))
	    .pipe(gulp.dest(path.js))
	    .pipe(rev.manifest({base:'', merge: true}))
	    .pipe(gulp.dest(''));
	});
	
	gulp.task("index-build", ['index-css-min','index-js-min'], function() {
	var manifest = gulp.src("rev-manifest.json");
	return gulp.src( "src/jsp/index/*.jsp")
	    .pipe(revreplace({replaceInExtensions: ['.jsp'], manifest: manifest}))
	    .pipe(gulp.dest(path.jsp + '/index/'));
	});

最后将两个步骤合并到default中去，就完成了自动化。

	<!-- lang: js -->
	gulp.task('default', ['login-build', 'index-build'], function() {
	// place code for your default task here
	});

结果如下图所示：

[![2](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107132029.png)](http://static.oschina.net/uploads/space/2015/0404/172723_2cpD_2319390.png)

[![3](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107132034.png)](http://static.oschina.net/uploads/space/2015/0404/172944_zoC4_2319390.png)

如果需要让多个jsp页面共用一块资源，可以将这些页面放在一个文件夹中统一进行处理。

**分享到：**[![](在Maven+Spring项目中使用Node.js的Gulp进行前端自动化构建%20-%20jndion20.md#)[![](在Maven+Spring项目中使用Node.js的Gulp进行前端自动化构建%20-%20jndion20.md#) 0赞

声明：OSCHINA 博客文章版权属于作者，受法律保护。未经作者同意不得转载。

- [« 上一篇](http://my.oschina.net/jndion/blog/394917)

- [下一篇 »](http://my.oschina.net/jndion/blog/406438)
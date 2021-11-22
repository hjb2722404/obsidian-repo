#webpack4 源码分析（五）compiler 构造函数



### 构造函数

```javascript
	constructor(context) {
		super(); // 执行父类（Tapable）的构造函数
		this.hooks = {
			/** @type {SyncBailHook<Compilation>} */
			shouldEmit: new SyncBailHook(["compilation"]),
			/** @type {AsyncSeriesHook<Stats>} */
			done: new AsyncSeriesHook(["stats"]),
			/** @type {AsyncSeriesHook<>} */
			additionalPass: new AsyncSeriesHook([]),
			/** @type {AsyncSeriesHook<Compiler>} */
			beforeRun: new AsyncSeriesHook(["compiler"]),
			/** @type {AsyncSeriesHook<Compiler>} */
			run: new AsyncSeriesHook(["compiler"]),
			/** @type {AsyncSeriesHook<Compilation>} */
			emit: new AsyncSeriesHook(["compilation"]),
			/** @type {AsyncSeriesHook<Compilation>} */
			afterEmit: new AsyncSeriesHook(["compilation"]),

			/** @type {SyncHook<Compilation, CompilationParams>} */
			thisCompilation: new SyncHook(["compilation", "params"]),
			/** @type {SyncHook<Compilation, CompilationParams>} */
			compilation: new SyncHook(["compilation", "params"]),
			/** @type {SyncHook<NormalModuleFactory>} */
			normalModuleFactory: new SyncHook(["normalModuleFactory"]),
			/** @type {SyncHook<ContextModuleFactory>}  */
			contextModuleFactory: new SyncHook(["contextModulefactory"]),

			/** @type {AsyncSeriesHook<CompilationParams>} */
			beforeCompile: new AsyncSeriesHook(["params"]),
			/** @type {SyncHook<CompilationParams>} */
			compile: new SyncHook(["params"]),
			/** @type {AsyncParallelHook<Compilation>} */
			make: new AsyncParallelHook(["compilation"]),
			/** @type {AsyncSeriesHook<Compilation>} */
			afterCompile: new AsyncSeriesHook(["compilation"]),

			/** @type {AsyncSeriesHook<Compiler>} */
			watchRun: new AsyncSeriesHook(["compiler"]),
			/** @type {SyncHook<Error>} */
			failed: new SyncHook(["error"]),
			/** @type {SyncHook<string, string>} */
			invalid: new SyncHook(["filename", "changeTime"]),
			/** @type {SyncHook} */
			watchClose: new SyncHook([]),

			// TODO the following hooks are weirdly located here
			// TODO move them for webpack 5
			/** @type {SyncHook} */
			environment: new SyncHook([]),
			/** @type {SyncHook} */
			afterEnvironment: new SyncHook([]),
			/** @type {SyncHook<Compiler>} */
			afterPlugins: new SyncHook(["compiler"]),
			/** @type {SyncHook<Compiler>} */
			afterResolvers: new SyncHook(["compiler"]),
			/** @type {SyncBailHook<string, Entry>} */
			entryOption: new SyncBailHook(["context", "entry"])
		};

		this._pluginCompat.tap("Compiler", options => {
			switch (options.name) {
				case "additional-pass":
				case "before-run":
				case "run":
				case "emit":
				case "after-emit":
				case "before-compile":
				case "make":
				case "after-compile":
				case "watch-run":
					options.async = true;
					break;
			}
		});

		/** @type {string=} */
		this.name = undefined;
		/** @type {Compilation=} */
		this.parentCompilation = undefined;
		/** @type {string} */
		this.outputPath = "";

		this.outputFileSystem = null;
		this.inputFileSystem = null;

		/** @type {string|null} */
		this.recordsInputPath = null;
		/** @type {string|null} */
		this.recordsOutputPath = null;
		this.records = {};
		this.removedFiles = new Set();
		/** @type {Map<string, number>} */
		this.fileTimestamps = new Map();
		/** @type {Map<string, number>} */
		this.contextTimestamps = new Map();
		/** @type {ResolverFactory} */
		this.resolverFactory = new ResolverFactory();

		// TODO remove in webpack 5
		this.resolvers = {
			normal: {
				plugins: util.deprecate((hook, fn) => {
					this.resolverFactory.plugin("resolver normal", resolver => {
						resolver.plugin(hook, fn);
					});
				}, "webpack: Using compiler.resolvers.normal is deprecated.\n" + 'Use compiler.resolverFactory.plugin("resolver normal", resolver => {\n  resolver.plugin(/* … */);\n}); instead.'),
				apply: util.deprecate((...args) => {
					this.resolverFactory.plugin("resolver normal", resolver => {
						resolver.apply(...args);
					});
				}, "webpack: Using compiler.resolvers.normal is deprecated.\n" + 'Use compiler.resolverFactory.plugin("resolver normal", resolver => {\n  resolver.apply(/* … */);\n}); instead.')
			},
			loader: {
				plugins: util.deprecate((hook, fn) => {
					this.resolverFactory.plugin("resolver loader", resolver => {
						resolver.plugin(hook, fn);
					});
				}, "webpack: Using compiler.resolvers.loader is deprecated.\n" + 'Use compiler.resolverFactory.plugin("resolver loader", resolver => {\n  resolver.plugin(/* … */);\n}); instead.'),
				apply: util.deprecate((...args) => {
					this.resolverFactory.plugin("resolver loader", resolver => {
						resolver.apply(...args);
					});
				}, "webpack: Using compiler.resolvers.loader is deprecated.\n" + 'Use compiler.resolverFactory.plugin("resolver loader", resolver => {\n  resolver.apply(/* … */);\n}); instead.')
			},
			context: {
				plugins: util.deprecate((hook, fn) => {
					this.resolverFactory.plugin("resolver context", resolver => {
						resolver.plugin(hook, fn);
					});
				}, "webpack: Using compiler.resolvers.context is deprecated.\n" + 'Use compiler.resolverFactory.plugin("resolver context", resolver => {\n  resolver.plugin(/* … */);\n}); instead.'),
				apply: util.deprecate((...args) => {
					this.resolverFactory.plugin("resolver context", resolver => {
						resolver.apply(...args);
					});
				}, "webpack: Using compiler.resolvers.context is deprecated.\n" + 'Use compiler.resolverFactory.plugin("resolver context", resolver => {\n  resolver.apply(/* … */);\n}); instead.')
			}
		};

		/** @type {WebpackOptions} */
		this.options = /** @type {WebpackOptions} */ ({});

		this.context = context;

		this.requestShortener = new RequestShortener(context);

		/** @type {boolean} */
		this.running = false;

		/** @type {boolean} */
		this.watchMode = false;

		/** @private @type {WeakMap<Source, { sizeOnlySource: SizeOnlySource, writtenTo: Map<string, number> }>} */
		this._assetEmittingSourceCache = new WeakMap();
		/** @private @type {Map<string, number>} */
		this._assetEmittingWrittenFiles = new Map();
```
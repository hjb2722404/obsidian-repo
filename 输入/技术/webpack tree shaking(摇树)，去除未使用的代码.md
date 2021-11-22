webpack tree shaking(摇树)，去除未使用的代码

# webpack tree shaking(摇树)，去除未使用的代码



使用其实就是分为简单的三个步骤：
 1. 使用ES2015模块语法
**import **和 **export **来导入和导出模块
2. 在**package.json**文件中添加 ”**sideEffects**“ 属性，设为false，意思是全局文件均无副作用
3. 引入一个能够删除未引用代码(dead code)的压缩工具(minifier)（例如 UglifyJSPlugin）（压缩输出）。
   ** webpack -p **(使用-p选项启用 uglifyjs 压缩插件)
    或
    通过“**mode**”配置选项轻松切换到压缩输出（"**mode**": "**production**"）
接下来执行 npx webpack 即可！会神奇地发现，没用的代码都会被删除
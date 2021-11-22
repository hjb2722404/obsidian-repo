逐行分析jQuery源码奥秘 （五）--callbacks回调对象

# 逐行分析jQuery源码奥秘 （五）--callbacks回调对象

源码

## 完整版

2880

2881
/*
 * Create a callback list using the following parameters:
 *
 *    options: an optional list of space-separated options that will change how
 *            the callback list behaves or a more traditional option object
 *
 * By default a callback list will act like an event callback list and can be
 * "fired" multiple times.
 *／／可选参数
 * Possible options:
 *    //保证回调列表只执行一次，类似一个延迟触发对象

 *    once:            will ensure the callback list can only be fired once (like a Deferred)

 *    //将保证在fire之后添加的方法也能够触发

 *    memory:            will keep track of previous values and will call any callback added

 *                    after the list has been fired right away with the latest "memorized"

 *                    values (like a Deferred)
 *    ／／保证回调函数的唯一性，相同的函数只触发一次。去重

 *    unique:            will ensure a callback can only be added once (no duplicate in the list)

 *    ／／如果一个回调函数返回了false，则整个回调函数立即中断。
 *    stopOnFalse:    interrupt callings when a callback returns false
 *
 */
//基本思路：收集--循环触发
2882

2883jQuery.Callbacks = function( options ) {

2884

2885    // Convert options from String-formatted to Object-formatted if needed

2886    // (we check in cache first)
     ／／判断options是不是字符串，如果不是，返回一个空的json对象，如果是，则看看是否已有缓存，如果没有，则创建缓存
2887    options = typeof options === "string" ?

2888        ( optionsCache[ options ] || createOptions( options ) ) :

2889        jQuery.extend( {}, options );
2890         //定义一大堆变量
2891    var // Last fire value (for non-forgettable lists)
2892        memory, //最后一次fire时的值
2893        // Flag to know if list was already fired
2894        fired, //列表触发完成的标志
2895        // Flag to know if list is currently firing

2896        firing, //列表正在触发中
2897        // First callback to fire (used internally by add and fireWith)

2898        firingStart, //第一个触发的回调函数
2899        // End of the loop when firing

2900        firingLength,

2901        // Index of currently firing callback (modified by remove if needed)

2902        firingIndex,

2903        // Actual callback list

2904        list = [],

2905        // Stack of fire calls for repeatable lists

2906        stack = !options.once && [],

2907        // Fire callbacks

2908        fire = function( data ) {

2909            memory = options.memory && data;

2910            fired = true;

2911            firingIndex = firingStart || 0;

2912            firingStart = 0;

2913            firingLength = list.length;

2914            firing = true;

2915            for ( ; list && firingIndex < firingLength; firingIndex++ ) {

2916                if ( list[ firingIndex ].apply( data[ 0 ], data[ 1 ] ) === false && options.stopOnFalse ) {

2917                    memory = false; // To prevent further calls using add

2918                    break;

2919                }

2920            }

2921            firing = false;

2922            if ( list ) {

2923                if ( stack ) {

2924                    if ( stack.length ) {

2925                        fire( stack.shift() );

2926                    }

2927                } else if ( memory ) {

2928                    list = [];

2929                } else {

2930                    self.disable();

2931                }

2932            }

2933        },

2934        // Actual Callbacks object

2935        self = {
2936            // Add a callback or a collection of callbacks to the list

2937
          ／／add方法用于添加一个回调或者包含多个回调的集合到列表里
          add: function() {
2938                if ( list ) {

2939                    // First, we save the current length
2940                    var start = list.length; //存储当前列表长度

                    //遍历参数，如果参数类型为函数，并且选项中没有unique参数，且列表中没有该函数，则将其push到列表里，如果参数类型

                    //不是函数，则执行递归，直到其中所有函数全部被push入列表为止。
2941                    (function add( args ) {

2942                        jQuery.each( args, function( _, arg ) {

2943                            var type = jQuery.type( arg );

2944                            if ( type === "function" ) {

2945                                if ( !options.unique || !self.has( arg ) ) {

2946                                    list.push( arg );

2947                                }

2948                            } else if ( arg && arg.length && type !== "string" ) {

2949                                // Inspect recursively

2950                                add( arg );

2951                            }

2952                        });

2953                    })( arguments );

2954                    // Do we need to add the callbacks to the

2955                    // current firing batch?

2956                    if ( firing ) {

2957                        firingLength = list.length;

2958                    // With memory, if we're not firing then

2959                    // we should call right away
                     //如果memory为真，则调用fire，触发后面添加的回调
2960                    } else if ( memory ) {

2961                        firingStart = start;

2962                        fire( memory );

2963                    }

2964                }

2965                return this;

2966            },

2967            // Remove a callback from the list
            //从回调列表中移除回调函数，遍历参数，将列表中和参数一致的函数移除掉
2968            remove: function() {

2969                if ( list ) {

2970                    jQuery.each( arguments, function( _, arg ) {

2971                        var index;

2972                        while( ( index = jQuery.inArray( arg, list, index ) ) > -1 ) {

2973                            list.splice( index, 1 );

2974                            // Handle firing indexes

2975                            if ( firing ) {

2976                                if ( index <= firingLength ) {

2977                                    firingLength--;

2978                                }

2979                                if ( index <= firingIndex ) {

2980                                    firingIndex--;

2981                                }

2982                            }

2983                        }

2984                    });

2985                }

2986                return this;

2987            },

2988            // Check if a given callback is in the list.

2989            // If no argument is given, return whether or not list has callbacks attached.

          //检查列表中是否包含一个函数
2990            has: function( fn ) {

2991                return fn ? jQuery.inArray( fn, list ) > -1 : !!( list && list.length );

2992            },

2993            // Remove all callbacks from the list
               //从列表中移除所有的回调函数，即直接将list赋值为空，并且让他的长度等于0
2994            empty: function() {

2995                list = [];

2996                firingLength = 0;

2997                return this;

2998            },

2999            // Have the list do nothing anymore
               //禁用list
3000            disable: function() {

3001                list = stack = memory = undefined;

3002                return this;

3003            },

3004            // Is it disabled?
               //判断list是否被禁用了，如果被禁用了，则返回true
3005            disabled: function() {

3006                return !list;

3007            },

3008            // Lock the list in its current state
               //将list锁定到最近的状态
3009            lock: function() {

3010                stack = undefined;

3011                if ( !memory ) {

3012                    self.disable();

3013                }

3014                return this;

3015            },

3016            // Is it locked?
               //判断list是否被锁定
3017            locked: function() {

3018                return !stack;

3019            },

3020            // Call all callbacks with the given context and arguments

3021            fireWith: function( context, args ) {

3022                if ( list && ( !fired || stack ) ) {

3023                    args = args || [];

3024                    args = [ context, args.slice ? args.slice() : args ];

3025                    if ( firing ) {

3026                        stack.push( args );

3027                    } else {

3028                        fire( args );

3029                    }

3030                }

3031                return this;

3032            },

3033            // Call all the callbacks with the given arguments

3034            fire: function() {

3035                self.fireWith( this, arguments );

3036                return this;

3037            },

3038            // To know if the callbacks have already been called at least once

3039            fired: function() {

3040                return !!fired;

3041            }

3042        };

3043

3044    return self;

3045};

3046

[markdownFile.md](../_resources/fd9401e7617e3add89d9ab8b6f5aa020.bin)
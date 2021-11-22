逐行分析jQuery源码奥秘 （四）-jQuery.extend()扩展一些工具方法[静态方法，元素也可使用]

# 逐行分析jQuery源码奥秘 （四）-jQuery.extend()扩展一些工具方法[静态方法，元素也可使用]

源码

### 简化版

	jQuery.extend({

	    expando : 生成唯一JQ字符串（仅内部使用）

	    noConflict() : 防止冲突

	    isReady : DOM是否加载完（仅内部使用）

	    readyWait : 等待多少文件的计数器（内部）

	    holdReady() : 推迟DOM触发

	    ready() : 准备触发

	    isFunction() : 是否为函数

	    isArray()  : 是否为数组

	    isWindow() : 是否为Window

	    isNumeric() : 是否为数字

	    type() : 判断数据类型

	    isPlainObject() : 是否为对象自变量

	    isEmptyObject() : 是否为空的对象

	    error() : 抛出异常

	    parseHTML()  : 解析节点

	    parseJSON()  : 解析JSON

	    parseXML()  : 解析XML

	    noop() : 空函数

	    globalEval()  : 全局解析JS

	    camelCase()  : 转驼峰

	    nodeName()  : 是否为指定节点名（内部）

	    each()  : 遍历集合

	    trim() : 去前后空格

	    makeArray() : 类数组转真数组

	    inArray() : 数组版indexOf

	    merge() : 合并数组

	    grep()  :  过滤新数组

	    map()  :  映射新数组

	    guid  :  唯一标识符（内部）

	    proxy()  :  改this指向

	    access()  :  多功能值操作（内部）

	    now()  :  当前时间

	    swap()  :  CSS交换（内部）

	});

### 完整版

400
* * *

401jQuery.extend({
* * *

402    //生成唯一JQ字符串（仅内部使用）
* * *

403    //此唯一值方便做映射关系
* * *

404    // Unique for each copy of jQuery on the page
* * *

405    expando: "jQuery" + ( core_version + Math.random() ).replace( /\D/g, "" ),

* * *

406    //防止冲突
* * *

407    //$.noConflict()方法应该在重新给$赋值的语句之前调用，如：
* * *

408    /*
* * *

409        var mydom = $.noConflict();
* * *

410        var $ = 123;
* * *

411
* * *

412        mydom(function(){});
* * *

413    */
* * *

414    noConflict: function( deep ) {
* * *

415        //如果window上的属性$等于jQuery，则将开始存储的私有变量_$的值赋给属性$
* * *

416        if ( window.$ === jQuery ) {
* * *

417            window.$ = _$;
* * *

418        }
* * *

419        //如果传入true参数，并且当前window.jQuery等于jQuery，则将window.jQuery的值改变为私有变量$_jQuery的值

* * *

420        if ( deep && window.jQuery === jQuery ) {
* * *

421            window.jQuery = _jQuery;
* * *

422        }
* * *

423        //返回jQuery对象
* * *

424        return jQuery;
* * *

425    },
* * *

426
* * *

427    //DOM准备好被使用了吗？ 一旦DOM准备好被使用，设置isReady值为true;
* * *

428    // Is the DOM ready to be used? Set to true once it occurs.
* * *

429    isReady: false,
* * *

430
* * *

431    //一个计数器，用来追踪在准备事件发生前有多少个项目在等待。默认为1。
* * *

432    // A counter to track how many items to wait for before
* * *

433    // the ready event fires. See #6781
* * *

434    readyWait: 1,
* * *

435
* * *

436    //推迟触发，解决异步加载时的触发顺序问题
* * *

437    //hold：布尔值
* * *

438    // Hold (or release) the ready event
* * *

439    holdReady: function( hold ) {
* * *

440        if ( hold ) {
* * *

441            jQuery.readyWait++;
* * *

442        } else {
* * *

443            jQuery.ready( true );
* * *

444        }
* * *

445    },
* * *

446
* * *

447    // Handle when the DOM is ready
* * *

448    ready: function( wait ) {
* * *

449        //检查变量值，如果仍旧有等待加载的，则返回，不执行下面的，如果没有等待加载的，则说明加载完成，继续执行下面代码。
* * *

450        // Abort if there are pending holds or we're already ready
* * *

451        if ( wait === true ? --jQuery.readyWait : jQuery.isReady ) {
* * *

452            return;
* * *

453        }
* * *

454        //说明DOM加载完成
* * *

455        // Remember that the DOM is ready
* * *

456        jQuery.isReady = true;
* * *

457        //再次检查是否还有等待的
* * *

458        // If a normal DOM Ready event fired, decrement, and wait if need be

* * *

459        if ( wait !== true && --jQuery.readyWait > 0 ) {
* * *

460            return;
* * *

461        }
* * *

462
* * *

463        //传参处理
* * *

464        // If there are functions bound, to execute
* * *

465        readyList.resolveWith( document, [ jQuery ] );
* * *

466
* * *

467        // Trigger any bound ready events
* * *

468        //绑定ready事件
* * *

469        if ( jQuery.fn.trigger ) {
* * *

470            jQuery( document ).trigger("ready").off("ready");
* * *

471        }
* * *

472    },
* * *

473
* * *

474    // See test/unit/core.js for details concerning isFunction.
* * *

475    // Since version 1.3, DOM methods and functions like alert
* * *

476    // aren't supported. They return false on IE (#2968).
* * *

477    //判断一个对象是否为函数，返回布尔值，通过type方法完成
* * *

478    isFunction: function( obj ) {
* * *

479        return jQuery.type(obj) === "function";
* * *

480    },
* * *

481
* * *

482    //判断是否为数组，利用了Array.isArray方法
* * *

483    isArray: Array.isArray,
* * *

484
* * *

485    //判断对象是否为窗口 ；
* * *

486    //为了避免报错，先判断传入的是否是null或undefined
* * *

487    //只有window这个全局对象才有window这个属性
* * *

488    isWindow: function( obj ) {
* * *

489        return obj != null && obj === obj.window;
* * *

490    },
* * *

491    //判断对象是不是数字，主要是解决NaN的问题
* * *

492    //isFinite判断是否是有限数字
* * *

493    isNumeric: function( obj ) {
* * *

494        return !isNaN( parseFloat(obj) ) && isFinite( obj );
* * *

495    },
* * *

496    //判断数据类型
* * *

497    type: function( obj ) {
* * *

498        //如果是null或者undefined，则返回字符串“null”或者“undefined”
* * *

499        if ( obj == null ) {
* * *

500            return String( obj );
* * *

501        }
* * *

502
* * *

503        // Support: Safari <= 5.1 (functionish RegExp)
* * *

504
* * *

505        return typeof obj === "object" || typeof obj === "function" ?
* * *

506            class2type[ core_toString.call(obj) ] || "object" :
* * *

507            typeof obj;
* * *

508        //详解：
* * *

509        /*
* * *

510            //定义结果
* * *

511            var result ;
* * *

512
* * *

513            //如果传入的对象类型是“object”或者“function”,则进入内部判断具体类型
* * *

514            //此处function是为了兼容老版本safari或chrome中typeof 正则类型返回“function”的情况
* * *

515            if(typeof obj === "object" || typeof obj === "function"){
* * *

516                    /*  core_toString = class2type.toString,
* * *

517                        class2type[core_toString.call(obj)]
* * *

518                        使用了Object.prototype.toString(）方法来判断对象类型，此方法的内部流程：
* * *

519                         1.取得对象的一个内部属性[[Class]]
* * *

520                         2.依据这个属性，返回一个类似于“[object Array]”的字符串作为结果
* * *

521
* * *

522                            * 利用这个方法，再配合call，我们可以取得任何对象的内部属性[[Class]],
* * *

523                            然后把类型检测转化为字符串比较，以达到我们的目的。
* * *

524                    */
* * *

525                result = class2type[ core_toString.call(obj)];
* * *

526                //如果以上结果为null，则返回“object”类型，否则返回以上结果
* * *

527                //注意：typeof null返回的结果其实是 object
* * *

528                if(result == "null"){
* * *

529
* * *

530                    result = "object";
* * *

531                }
* * *

532           //如果不是“object”或者“function”,则直接返回typeof obj的结果
* * *

533            }else{
* * *

534
* * *

535                result = typeof obj;
* * *

536            }
* * *

537
* * *

538            return result;
* * *

539
* * *

540
* * *

541        */
* * *

542    },
* * *

543    //是否为对象自变量
* * *

544    isPlainObject: function( obj ) {
* * *

545        // Not plain objects:
* * *

546        // - Any object or value whose internal [[Class]] property is not "[object Object]"

* * *

547        // - DOM nodes
* * *

548        // - window
* * *

549        // 如果对象的类型不为object,或者object是DOM节点，或者它是window，他们都不是对象自变量。
* * *

550        if ( jQuery.type( obj ) !== "object" || obj.nodeType || jQuery.isWindow( obj ) ) {

* * *

551            return false;
* * *

552        }
* * *

553
* * *

554        // Support: Firefox <20
* * *

555        // The try/catch suppresses exceptions thrown when attempting to access

* * *

556        // the "constructor" property of certain host objects, ie. |window.location|

* * *

557        // https://bugzilla.mozilla.org/show_bug.cgi?id=814622
* * *

558        //如果该对象为window.location，或者不是Object对象自变量，返回false
* * *

559        //try-catch解决window.location.constructor频繁调用会导致递归泄露的BUG（火狐<20版本）
* * *

560        try {
* * *

561            if ( obj.constructor && //对象具有constructor属性并但是属性的原型上没有“isPrototypeOf”属性，则说明此对象不是对象自变量，返回false

* * *

562                    !core_hasOwn.call( obj.constructor.prototype, "isPrototypeOf" ) ) {

* * *

563                return false;
* * *

564            }
* * *

565        } catch ( e ) {
* * *

566            return false;
* * *

567        }
* * *

568
* * *

569        // If the function hasn't returned already, we're confident that
* * *

570        // |obj| is a plain object, created by {} or constructed with new Object

* * *

571        return true;
* * *

572    },
* * *

573    //判断是否是空对象
* * *

574    //如果对象为空，则可以for-in到，如果不为空，则for-in不到
* * *

575    isEmptyObject: function( obj ) {
* * *

576        var name;
* * *

577        for ( name in obj ) {
* * *

578            return false;
* * *

579        }
* * *

580        return true;
* * *

581    },
* * *

582    //抛出异常，throw一个自定义错误
* * *

583    error: function( msg ) {
* * *

584        throw new Error( msg );
* * *

585    },
* * *

586
* * *

587    // data: string of html
* * *

588    // context (optional): If specified, the fragment will be created in this context, defaults to document

* * *

589    // keepScripts (optional): If true, will include scripts passed in the html string

* * *

590    //解析节点，把字符串解析为节点，传入数据，上下文，是否存储script标签的布尔选项
* * *

591    parseHTML: function( data, context, keepScripts ) {
* * *

592
* * *

593        //检查数据是否是字符串，如果不是，然会一个空对象
* * *

594        if ( !data || typeof data !== "string" ) {
* * *

595            return null;
* * *

596        }
* * *

597
* * *

598        // 如果第二个参数是布尔值，则上下文没有，把该布尔值赋给keepScript选项
* * *

599        if ( typeof context === "boolean" ) {
* * *

600            keepScripts = context;
* * *

601            context = false;
* * *

602        }
* * *

603        //如果传入了上下文，则上下文等于传入的值，如果没有，则默认上下文为document
* * *

604
* * *

605        context = context || document;
* * *

606
* * *

607        //判断传入的数据是否是单标签
* * *

608        var parsed = rsingleTag.exec( data ),//rsingleTag = /^<(\w+)\s*\/?>(?:<\/\1>|)$/,78行

* * *

609            scripts = !keepScripts && [];
* * *

610            //如果keepScripts为false，则scripts=[];
* * *

611            //如果keepScripts为true.则scripts=false;
* * *

612
* * *

613        //如果是但标签，则在上下文中创建该节点并返回
* * *

614        // Single tag
* * *

615        if ( parsed ) {
* * *

616            return [ context.createElement( parsed[1] ) ];
* * *

617        }
* * *

618        //如果是多标签，则通过文档碎片的模式创建DOM数组
* * *

619        parsed = jQuery.buildFragment( [ data ], context, scripts );
* * *

620
* * *

621        //如果scripts被加入了数组,则移除scripts
* * *

622        if ( scripts ) {
* * *

623            jQuery( scripts ).remove();
* * *

624        }
* * *

625
* * *

626        //最后用merge方法将节点数组转换成json返回
* * *

627        return jQuery.merge( [], parsed.childNodes );
* * *

628    },
* * *

629
* * *

630    //解析JSON，JSON.parse比eval()更安全，但不兼容IE6.7，与其相反作用的是JSON.Stringify();
* * *

631    parseJSON: JSON.parse,
* * *

632
* * *

633    //解析XML
* * *

634    // Cross-browser xml parsing
* * *

635    parseXML: function( data ) {
* * *

636        var xml, tmp; //定义xml对象，tmp临时变量。
* * *

637        //如果没有传入数据或数据的类型不是字符串，返回空对象
* * *

638        if ( !data || typeof data !== "string" ) {
* * *

639            return null;
* * *

640        }
* * *

641        对IE9的支持
* * *

642        // Support: IE9
* * *

643        //try-catch防止在IE9下输入的数据格式有错误而导致浏览器抛出错误。
* * *

644        try {
* * *

645            //将一个新的DOM解析对象赋给临时变量
* * *

646            tmp = new DOMParser();
* * *

647            //使用tmp临时DOM解析对象的parseFromString()方法解析数据，并将返回值赋给xml对象。
* * *

648            xml = tmp.parseFromString( data , "text/xml" );
* * *

649        } catch ( e ) {
* * *

650            //如果发生异常，则xml对象设置为undefined
* * *

651            xml = undefined;
* * *

652        }
* * *

653        // 如果xml对象为undefined或者xml节点中具有解析错误的标签，则抛出错误。
* * *

654        if ( !xml || xml.getElementsByTagName( "parsererror" ).length ) {
* * *

655            jQuery.error( "Invalid XML: " + data );
* * *

656        }
* * *

657        //返回xml对象
* * *

658        return xml;
* * *

659    },
* * *

660    //返回一个空函数：组件开发时的默认参数有时是一个空函数，就可以调用
* * *

661    noop: function() {},
* * *

662
* * *

663    // Evaluates a script in a global context
* * *

664    //全局解析JS，把局部变量变为全局变量
* * *

665    globalEval: function( code ) {
* * *

666        var script,
* * *

667                indirect = eval; //给eval赋值，存成一个局部变量；
* * *

668        //把字符串中的空格过滤掉
* * *

669        code = jQuery.trim( code );
* * *

670        //如果代码字符串存在
* * *

671        if ( code ) {
* * *

672            // If the code includes a valid, prologue position
* * *

673            // strict mode pragma, execute code by injecting a
* * *

674            // script tag into the document.
* * *

675            //是否是严格模式下执行，如果是，
* * *

676            if ( code.indexOf("use strict") === 1 ) {
* * *

677                //创建script标签
* * *

678                script = document.createElement("script");
* * *

679                //标签里的内容赋值为传入的代码字符串
* * *

680                script.text = code;
* * *

681                //将script节点插入文档头部
* * *

682                document.head.appendChild( script ).parentNode.removeChild( script );

* * *

683            } else {
* * *

684            //如果不是严格模式
* * *

685            // Otherwise, avoid the DOM node creation, insertion
* * *

686            // and removal by using an indirect global eval
* * *

687            //使用eval执行代码字符串
* * *

688                indirect( code );
* * *

689            }
* * *

690        }
* * *

691    },
* * *

692
* * *

693    // Convert dashed to camelCase; used by the css and data modules
* * *

694    // Microsoft forgot to hump their vendor prefix (#9572)
* * *

695    //转驼峰方法：将JS中的CSS样式转换成JS能允许的格式
* * *

696    camelCase: function( string ) {
* * *

697        /*
* * *

698            1.用ms-替换字符串中的-ms-；
* * *

699            2.将字符串中的符合"-字母"格式的中的字符替换为大写。
* * *

700            3.返回替换后的结果
* * *

701
* * *

702        */
* * *

703        return string.replace( rmsPrefix, "ms-" ).replace( rdashAlpha, fcamelCase );

* * *

704    },
* * *

705    //是否为指定节点名（内部）
* * *

706    //如果elem节点的名称是name，则返回true
* * *

707    nodeName: function( elem, name ) {
* * *

708        return elem.nodeName && elem.nodeName.toLowerCase() === name.toLowerCase();

* * *

709    },
* * *

710
* * *

711    // args is for internal usage only
* * *

712    //遍历集合的方法
* * *

713    each: function( obj, callback, args ) {
* * *

714        var value,
* * *

715            i = 0,
* * *

716            length = obj.length,
* * *

717            isArray = isArraylike( obj );//判断是否是数组
* * *

718        //如果是内部使用
* * *

719        if ( args ) {
* * *

720            //如果是数组
* * *

721            if ( isArray ) {
* * *

722                //使用for循环，遍历元素并使用apply方法获得value
* * *

723                for ( ; i < length; i++ ) {
* * *

724                    value = callback.apply( obj[ i ], args );
* * *

725
* * *

726                    if ( value === false ) {
* * *

727                        break;
* * *

728                    }
* * *

729                }
* * *

730            //如果不是数组
* * *

731            } else {
* * *

732                //使用for-in循环,遍历元素并使用apply方法获得value
* * *

733                for ( i in obj ) {
* * *

734                    value = callback.apply( obj[ i ], args );
* * *

735
* * *

736                    if ( value === false ) {
* * *

737                        break;
* * *

738                    }
* * *

739                }
* * *

740            }
* * *

741
* * *

742        // A special, fast, case for the most common use of each
* * *

743        //不是内部使用，走这里
* * *

744        } else {
* * *

745            //如果是数组
* * *

746            if ( isArray ) {
* * *

747                //使用for循环，遍历元素并使用call方法获得value
* * *

748                for ( ; i < length; i++ ) {
* * *

749                    value = callback.call( obj[ i ], i, obj[ i ] );
* * *

750
* * *

751                    if ( value === false ) {
* * *

752                        break;
* * *

753                    }
* * *

754                }
* * *

755            //如果不是数组
* * *

756            } else {
* * *

757                //使用for-in循环，遍历元素并使用call方法获得value
* * *

758                for ( i in obj ) {
* * *

759                    value = callback.call( obj[ i ], i, obj[ i ] );
* * *

760
* * *

761                    if ( value === false ) {
* * *

762                        break;
* * *

763                    }
* * *

764                }
* * *

765            }
* * *

766        }
* * *

767
* * *

768        return obj;
* * *

769    },
* * *

770    //去除字符串空格
* * *

771    trim: function( text ) {
* * *

772        /*
* * *

773            1.判断是否为空，如果为空，返回空字符串
* * *

774            2.如果不为空，调用core_trim方法处理字符串
* * *

775            3.返回处理的结果。
* * *

776
* * *

777                //core_trim = core_version.trim,
* * *

778
* * *

779        */
* * *

780        return text == null ? "" : core_trim.call( text );
* * *

781    },
* * *

782
* * *

783    // results is for internal usage only
* * *

784    //把传入的参数转换成数组
* * *

785    makeArray: function( arr, results ) {
* * *

786
* * *

787        //如果传入第二个参数，则是内部使用
* * *

788        var ret = results || [];
* * *

789
* * *

790        //第一个参数是否存在，如果存在，走这里
* * *

791        if ( arr != null ) {
* * *

792            /*
* * *

793                1.将传入的第一个参数转换成对象
* * *

794                2.如果该对象是类似数组的，则调用merge方法转换
* * *

795                3.如果该对象不是类数组的，则调用push方法来将它存入第二个参数的格式
* * *

796            */
* * *

797            if ( isArraylike( Object(arr) ) ) {
* * *

798                /*
* * *

799                    传入的如果是字符串，则merge的第二个参数为数组格式，如果不是，则为它本身；
* * *

800                    然后合并传入的两个数组
* * *

801                */
* * *

802                jQuery.merge( ret,
* * *

803                    typeof arr === "string" ?
* * *

804                    [ arr ] : arr
* * *

805                );
* * *

806            } else {
* * *

807                core_push.call( ret, arr );
* * *

808            }
* * *

809        }
* * *

810
* * *

811        return ret;
* * *

812    },
* * *

813    //数组版的indexOf
* * *

814    inArray: function( elem, arr, i ) {
* * *

815    //调用字符串的indexOf方法来实现，如果不存在返回-1;
* * *

816        return arr == null ? -1 : core_indexOf.call( arr, elem, i );
* * *

817    },
* * *

818    //合并数组
* * *

819    merge: function( first, second ) {
* * *

820        var l = second.length,
* * *

821            i = first.length,
* * *

822            j = 0;
* * *

823        //判断第二个参数是否有整形长度（json没有）
* * *

824        //如果有，则利用for循环将第二个对象的元素插入第一个数组中
* * *

825        //如果没有，则使用while循环将第二个对象的元素替换到第一个对象的相同位置
* * *

826        if ( typeof l === "number" ) {
* * *

827            for ( ; j < l; j++ ) {
* * *

828                first[ i++ ] = second[ j ];
* * *

829            }
* * *

830        } else {
* * *

831            while ( second[j] !== undefined ) {
* * *

832                first[ i++ ] = second[ j++ ];
* * *

833            }
* * *

834        }
* * *

835        //将i累加后的结果赋给第一个参数的length属性
* * *

836        first.length = i;
* * *

837
* * *

838        return first;
* * *

839    },
* * *

840    //过滤得到新数组：使用回调函数返回的值作为条件过滤数组，第三个参数取反。
* * *

841    grep: function( elems, callback, inv ) {
* * *

842        var retVal,
* * *

843            ret = [], //要返回的数组
* * *

844            i = 0,
* * *

845            length = elems.length;
* * *

846        inv = !!inv; //undefined的值前面加两个！,最终得到false。
* * *

847        /*
* * *

848            var o={flag:true};  var test=!!o.flag;//等效于var test=o.flag||false;  alert(test);

* * *

849
* * *

850            由于对null与undefined用!操作符时都会产生true的结果，
* * *

851            所以用两个感叹号的作用就在于，
* * *

852            如果明确设置了o中flag的值（非 null/undefined/0""/等值），自然test就会取跟o.flag一样的值；
* * *

853            如果没有设置，test就会默认为false，而不是 null或undefined。
* * *

854        */
* * *

855
* * *

856        // Go through the array, only saving the items
* * *

857        // that pass the validator function
* * *

858        for ( ; i < length; i++ ) {
* * *

859            //调用回调，传入每一个元素和i，如果元素符合条件，返回true,不符合则返回false;
* * *

860            retVal = !!callback( elems[ i ], i ); //!!与上面的作用一样
* * *

861            //如果元素符合条件（因为inv默认为false,所以符合条件就为true），则存入新数组
* * *

862            //如果inv为true，则将不符合条件的存入新数组
* * *

863            if ( inv !== retVal ) {
* * *

864                ret.push( elems[ i ] );
* * *

865            }
* * *

866        }
* * *

867
* * *

868        return ret;
* * *

869    },
* * *

870
* * *

871    // arg is for internal usage only
* * *

872    //映射数组
* * *

873    map: function( elems, callback, arg ) {
* * *

874        var value,
* * *

875            i = 0,
* * *

876            length = elems.length,
* * *

877            isArray = isArraylike( elems ),//判断传入的是否是类数组
* * *

878            ret = []; 定义需要返回的新数组对象
* * *

879
* * *

880        // Go through the array, translating each of the items to their
* * *

881        //如果是类数组，使用for循环，调用回调，并将返回值存入value变量。
* * *

882        //如果不是类数组，则使用for-in循环调用回调，并且将返回值存入value变量
* * *

883        if ( isArray ) {
* * *

884            for ( ; i < length; i++ ) {
* * *

885                value = callback( elems[ i ], i, arg );
* * *

886                //如果value不为空，则存入新数组，并且新数组下标每次循环+1
* * *

887                if ( value != null ) {
* * *

888                    ret[ ret.length ] = value;
* * *

889                }
* * *

890            }
* * *

891
* * *

892        // Go through every key on the object,
* * *

893        } else {
* * *

894            for ( i in elems ) {
* * *

895                value = callback( elems[ i ], i, arg );
* * *

896                //如果value不为空，则存入新数组，并且新数组下标每次循环+1
* * *

897                if ( value != null ) {
* * *

898                    ret[ ret.length ] = value;
* * *

899                }
* * *

900            }
* * *

901        }
* * *

902
* * *

903        //利用concat方法来将复合数组合并为单一数组，避免返回复合数组
* * *

904        // Flatten any nested arrays
* * *

905        return core_concat.apply( [], ret );
* * *

906    },
* * *

907    //内部使用的唯一标识符
* * *

908    // A global GUID counter for objects
* * *

909    guid: 1,
* * *

910
* * *

911    // Bind a function to a context, optionally partially applying any
* * *

912    // arguments.
* * *

913    //改变this指向，传入一个函数，一个要指向的上下文环境
* * *

914    proxy: function( fn, context ) {
* * *

915        var tmp, args, proxy;
* * *

916
* * *

917        //如果指向目标的类型为string类型（简写形式），则利用临时变量将其转换为标准形式。
* * *

918        if ( typeof context === "string" ) {
* * *

919            tmp = fn[ context ];
* * *

920            context = fn;
* * *

921            fn = tmp;
* * *

922        }
* * *

923
* * *

924        // Quick check to determine if target is callable, in the spec
* * *

925        // this throws a TypeError, but we will just return undefined.
* * *

926        //如果传入的第一个参数不是函数类型，则返回undefined
* * *

927        if ( !jQuery.isFunction( fn ) ) {
* * *

928            return undefined;
* * *

929        }
* * *

930
* * *

931        // Simulated bind
* * *

932        //合并参数
* * *

933        //从第三个参数到最后的参数都列入参数集合
* * *

934        args = core_slice.call( arguments, 2 );
* * *

935        //利用call方法调用数组的contact方法将参数集合传给fn
* * *

936        proxy = function() {
* * *

937            return fn.apply( context || this, args.concat( core_slice.call( arguments ) ) );

* * *

938        };
* * *

939
* * *

940        // Set the guid of unique handler to the same of original handler, so it can be removed

* * *

941        //设置唯一标示
* * *

942        proxy.guid = fn.guid = fn.guid || jQuery.guid++;
* * *

943
* * *

944        return proxy;
* * *

945    },
* * *

946
* * *

947    // Multifunctional method to get and set values of a collection
* * *

948    // The value/s can optionally be executed if it's a function
* * *

949    //多功能值操作
* * *

950    /*
* * *

951        elems:要操作的元素集合
* * *

952        fn:回调函数
* * *

953        key:要操作的属性
* * *

954        value：要赋予的值
* * *

955        chainable:布尔，决定是set还是get
* * *

956
* * *

957    */
* * *

958    access: function( elems, fn, key, value, chainable, emptyGet, raw ) {
* * *

959        var i = 0,
* * *

960            length = elems.length,
* * *

961            bulk = key == null; //判断是否有key
* * *

962
* * *

963        // Sets many values
* * *

964        //设置多组值
* * *

965        //如果key的类型为对象，说明是json格式，那就是设置
* * *

966        //手动将chainable设置为true
* * *

967        //递归设置
* * *

968        if ( jQuery.type( key ) === "object" ) {
* * *

969            chainable = true;
* * *

970            for ( i in key ) {
* * *

971                jQuery.access( elems, fn, i, key[i], true, emptyGet, raw );
* * *

972            }
* * *

973
* * *

974        // Sets one value
* * *

975        //设置一组值，并且值不为空
* * *

976        } else if ( value !== undefined ) {
* * *

977            chainable = true;
* * *

978            //如果值不是函数
* * *

979            if ( !jQuery.isFunction( value ) ) {
* * *

980                raw = true; //raw为真
* * *

981            }
* * *

982            //如果key不存在
* * *

983            if ( bulk ) {
* * *

984                // Bulk operations run against the entire set
* * *

985                //如果raw为真，即值不是函数
* * *

986                if ( raw ) {
* * *

987                    //回调设置值
* * *

988                    fn.call( elems, value );
* * *

989                    fn = null;
* * *

990
* * *

991                // ...except when executing function values
* * *

992                //如果值是个函数
* * *

993                } else {
* * *

994                    //那么设置bulk为fn，然后用bulk来调用设置
* * *

995                    bulk = fn;
* * *

996                    fn = function( elem, key, value ) {
* * *

997                        return bulk.call( jQuery( elem ), value );
* * *

998                    };
* * *

999                }
* * *

1000            }
* * *

1001            //如果key存在，则直接调用回调，分为值是字符串或值是函数两种情况
* * *

1002            if ( fn ) {
* * *

1003                for ( ; i < length; i++ ) {
* * *

1004                    fn( elems[i], key, raw ? value : value.call( elems[i], i, fn( elems[i], key ) ) );

* * *

1005                }
* * *

1006            }
* * *

1007        }
* * *

1008
* * *

1009        return chainable ?
* * *

1010            elems :
* * *

1011
* * *

1012            // Gets
* * *

1013            bulk ?
* * *

1014                fn.call( elems ) :
* * *

1015                length ? fn( elems[0], key ) : emptyGet;
* * *

1016    },
* * *

1017    //获得当前时间日期
* * *

1018    now: Date.now,
* * *

1019
* * *

1020    // A method for quickly swapping in/out CSS properties to get correct calculations.

* * *

1021    // Note: this method belongs to the css module but it's needed here for the support module.

* * *

1022    // If support gets modularized, this method should be moved back to the css module.

* * *

1023    //CSS交换（内部使用）：比如获取隐藏元素的宽度
* * *

1024    swap: function( elem, options, callback, args ) {
* * *

1025        var ret, name,
* * *

1026            old = {}; //老的样式
* * *

1027
* * *

1028        // Remember the old values, and insert the new ones
* * *

1029        //存老的，插入新的
* * *

1030        for ( name in options ) {
* * *

1031            old[ name ] = elem.style[ name ];
* * *

1032            elem.style[ name ] = options[ name ];
* * *

1033        }
* * *

1034        //获取到相应的值
* * *

1035        ret = callback.apply( elem, args || [] );
* * *

1036
* * *

1037        // Revert the old values
* * *

1038        //恢复为老的
* * *

1039        for ( name in options ) {
* * *

1040            elem.style[ name ] = old[ name ];
* * *

1041        }
* * *

1042
* * *

1043        return ret;
* * *

1044    }
* * *

1045});
* * *

1046
* * *

1047//创建延迟加载方法
* * *

1048jQuery.ready.promise = function( obj ) {
* * *

1049    //如果readyList不存在
* * *

1050    if ( !readyList ) {
* * *

1051        // 则创建readyList，它是一个延迟对象
* * *

1052        readyList = jQuery.Deferred();
* * *

1053
* * *

1054        // Catch cases where $(document).ready() is called after the browser event has already occurred.

* * *

1055        // we once tried to use readyState "interactive" here, but it caused issues like the one

* * *

1056        // discovered by ChrisS here: http://bugs.jquery.com/ticket/12282#comment:15

* * *

1057        //如果文档的加载状态是“完成”
* * *

1058        if ( document.readyState === "complete" ) {
* * *

1059            // Handle it asynchronously to allow scripts the opportunity to delay ready

* * *

1060            //设定延迟触发jQuery.ready对应的方法。
* * *

1061            setTimeout( jQuery.ready );
* * *

1062
* * *

1063        } else {
* * *

1064
* * *

1065            // Use the handy event callback
* * *

1066            //在文档DOM加载完成后，执行completed方法，并且是在事件冒泡阶段执行。
* * *

1067            document.addEventListener( "DOMContentLoaded", completed, false );

* * *

1068
* * *

1069            // A fallback to window.onload, that will always work
* * *

1070            //总是在窗口加载完成时，执行completed方法。
* * *

1071            window.addEventListener( "load", completed, false );
* * *

1072        }
* * *

1073    }
* * *

1074    //返回延迟对象
* * *

1075    return readyList.promise( obj );
* * *

1076};
* * *

1077//判断是否是类数组
* * *

1078function isArraylike( obj ) {
* * *

1079    var length = obj.length,
* * *

1080        type = jQuery.type( obj );
* * *

1081
* * *

1082    //先判断是否是窗口，因为窗口也可能挂载length等属性
* * *

1083    //如果传入的对象是窗口，直接返回false
* * *

1084    if ( jQuery.isWindow( obj ) ) {
* * *

1085        return false;
* * *

1086    }
* * *

1087
* * *

1088    //如果是元素节点并且有length，则说明是节点数组，返回真
* * *

1089    if ( obj.nodeType === 1 && length ) {
* * *

1090        return true;
* * *

1091    }
* * *

1092    /*
* * *

1093        1.如果类型是“array”,则直接返回真
* * *

1094        2.如果类型不是“array”
* * *

1095            判断是不是function,
* * *

1096            判断是不是arguments，
* * *

1097        如果既不是function又是arguments，则返回真，否则返回假；
* * *

1098
* * *

1099    */
* * *

1100    return type === "array" || type !== "function" &&
* * *

1101        ( length === 0 ||
* * *

1102        typeof length === "number" && length > 0 && ( length - 1 ) in obj );

* * *

1103}
* * *

1104
* * *

1105
* * *

### 知识点

#### $(function(){})与window.onload=function(){}的区别

- 原生window.onload()会等页面所有元素全部加载完，再执行
- $()会等DOM加载完成，再执行
- $()的执行时间比window.onload早
- $()利用的是原生的DomContentLoaded事件

#### $(function(){})的内部事件流程：

	$(function(){});

	// $(document).ready(function(){});

	// $().ready(fn);

	// jQuery.ready.promise().done(fn);

	/*
	    if(document.readyState === "complete"){

	    }else{
	        completed()
	    }

	    $.ready();

	    readyList.resolveWith(document,[jQuery]);

	    fn;

	*/

#### addEventListener()方法

- 定义
    - addEventListener() 方法用于向指定元素添加事件句柄。
    - 提示： 使用 removeEventListener() 方法来移除 addEventListener() 方法添加的事件句柄。
- 语法

`element.addEventListener(event, function, useCapture)`

- 参数说明：
    - event 必须。字符串，指定事件名。
        - 注意: 不要使用 "on" 前缀。 例如，使用 "click" ,而不是使用 "onclick"。
    - function 必须。指定要事件触发时执行的函数。
        - 当事件对象会作为第一个参数传入函数。 事件对象的类型取决于特定的事件。例如， "click" 事件属于 MouseEvent(鼠标事件) 对象。
    - useCapture 可选。布尔值，指定事件是否在捕获或冒泡阶段执行。
        - 可能值:
            - true - 事件句柄在捕获阶段执行
            - false- false- 默认。事件句柄在冒泡阶段执行

[markdownFile.md](../_resources/4b3b137ef7edfdf656d2d7792833ebfd.bin)
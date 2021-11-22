# dexie.js使用教程
## what 它是什么
`dexie.js `是一个对浏览器`indexexDB`的包装库，使得我们可以更方便地操作`indexedDB`。

## why 为什么用它

由于原生`indexedDB`提供的接口对于前端开发人员来说极为繁琐，而且接口不友好，原子操作决定了很多高频复杂操作必须由开发者自己实现，这带来了巨大的工作量和不可靠性。

基于此，出现了很多对原生接口的包装，而相比于其它包装库，`dexie.js`具有以下明显的优点：
* 所有接口皆返回`promise`，更符合`indexedDB`的异步特性，对开发人员更友好直观。

* 即支持与原生一致的接口，比如`open、get、put、add、delete、transcation`等等，又支持扩展的更加便捷的接口，如`db.storeName.get`。

* 类似于后端数据库的高级查询，并且支持链式调用，如官方示例：

  ```javascript
  db.friends.where('shoeSize')
      .between(37, 40)
      .or('name')
      .anyOf(['Arnold','Ingemar'])
      .and(function(friend) { return friend.isCloseFriend; })
      .limit(10)
      .each(function(friend){
          console.log(JSON.stringify(friend));
      });
  ```

* 更丰富的索引定义，建立索引变得非常简单，并且支持多值索引和复合索引

```javascript
db.version(1).stores({
    users: "++id, name, &username, *email, address.city",
    relations: "++, userId1, userId2, [userId1+userId2], relation"
});
```

* 接近原生的性能。
* 丰富完善的文档，虽然目前只有英文文档，但也是所有`indexedDB`包装库中文档最为完善的了。

## how 怎么用

在使用此库之前，最好能够系统的了解和简单使用原生`indexedDB`，可参阅 [indexedDB基础教程](https://www.tangshuang.net/3735.html#title-1)

### 获取数据库实例

获取一个数据库实例

```javascript
var db = new Dexie(dbname)；
```

* `dbname`：数据库的名称

这里只是获得数据库实例，与传入的数据库是否已经存在没有关系，如果已经存在，就会返回已经存在的数据库的一个示例，如果不存在，就会新建一个数据库，并返回该数据库的一个实例。

### 定义数据库结构

```javascript
db.version(lastVersion).stores(
  {
  	localVersions: 'matadataid, content, lastversionid, date, time',
    users: "++id, name, &username, *email, address.city",
    relations: "++rid, userId1, userId2, [userId1+userId2], relation",
    books: 'id, author, name, *categories'
  }
);
```

* `lastVersion` ： 当前数据库最新版本，只有需要修改数据库结构时才更改这个值。

* 上例中的`localVersions,users,relations` 都是数据库要包含的`objectStore`的名称，而他们的值则是要定义的索引，如果某个字段不需要索引，则不要写入这个索引列表，另外，如果某个字段存储的是图片数据（imageData）,视频（arrayBuffer），或者特别大的字符串，不建议加入索引列表。

* 可以定义四种索引：

  * 主键（自增）：索引列表的第一个总会被当做主键，如上例中的`matadataid，id，rid`，如果主键前有`++` 符号，说明这个字段是自增的。

  * 唯一索引。如果某个索引的字段的值在所有记录中是唯一的，那么可以在它前面加`&` 号，比如上例中`users`仓库中的`username`字段。

  * 多值索引。 如果某个字段具有多个值，那么可以在它前面加`*`号将其设置为多值索引，如上例中的`books`仓库中的`categories`字段，用户可以根据它多个值的任何一个值来查询它，如：

    ```javascript
    db.books.put({
      id: 1,
      name: 'Under the Dome', 
      author: 'Stephen King',
      categories: ['sci-fi', 'thriller']
    });
    ```

    这里面的`categores` 是个数组，有多个值，那么我们就可以将其设置为多值索引

    然后我们查询时便可以用其中一个值为查询条件去查询：

    ```javascript
    function getSciFiBooks() {
      return db.books
        .where('categories').equals('sci-fi')
        .toArray ();
    }
    ```

    这里便会查询到所有类型为`sci-fi` 的书籍，即使这些书还可能同时属于其他分类。

  * 复合索引。如果某个索引是基于多个键路径的，就可以将其设置为复合索引，格式为`[A+B]`，如上例中`relations`中的`[userId1+userId2]` 索引。下面是一个例子：

    ```javascript
    // Store relations
        await db.relations.put({
            rid: 1,
            userId1: '1',
            userId2: '2'
        });
        
        // Query relations:
        const fooBar = await db.relations.where({
          userId1: '1',
          userId2: '2'
        }).first();
    ```

    当你定义了复合索引后，就可以在`where`查询子句中传入一个复合条件对象，该示例就将查询出`userId1`为`1`,`userId2`为`2`的记录，但同时，你也可以只以其中一个字段为索引条件进行查询：

    ```javascript
    db.relations
      .where('userId1') 
      .equals("1")
      .toArray();
    ```

* 每次页面刷新都会重新获取一遍实例，重新运行一遍数据库定义逻辑，不会有问题吗？答案是，不会有问题。如果你传入的`lastVersion`与数据库当前版本一致，则即使重新运行一遍数据库定义逻辑，也不会覆盖你第一次运行时定义的结构（即使你修改了数据库结构），在这种情况下，你已经存入的数据不会受任何影响。只有当`lastVersion`版本高于当前数据库版本时，才会去更新数据库结构（即使结构没有任何变化），这时如果定义中的仓库被删除了，那对应的仓库会被删除，如果定义中是索引被删除了，那仓库中对应的索引也会被删除。【只有执行完`version().stores()`方法之后再至少进行一次数据库操作(比如`open()`, `get()`，`put()`等)，这个才可以生效，因为`versions().store()`只是定义结构，并不立即生效，而是等到进行数据库操作时才会打开数据库进行更新】

>在具体的实践中，建议将获取数据库实例和定义表结构的代码封装在一起，然后返回一个单例，整个应用中需要这个数据库的地方都从这个方法获取这个单例，这样可以保证所有对数据库结构的改动都在一个地方进行，从而保证数据库版本的一致。

### dexie.js的一些概念

在进行增删改查操作介绍前，我们先明确一些`dexie.js`里面的概念。

`Dexie` ：数据库类，返回一个数据库实例， 具体实践中就是 `db = new Dexie()`后所获得的的`db`。

`Table`:   表类，返回一个表实例（对应于原生的`objectStore`），具体实践中对应`db.tableName`，如`db.users,db.books`等等。

`Collection`： 数据集合类，返回查询到的数据集合，它的构造方法是私有的，所以用户无法通过`new Collection()`来创建它的实例，而是只能通过`where子句`和`Table`实例的一些方法获得。

`whereClause`：`where`子句，标识索引或主键上的筛选器。

### 基本增删改查（CRUD）操作

1. 向表中新增一条记录

   ```javascript
   db.tableName.add(recordObject);
   
   // 如
   db.users.add({
     name: 'zhang san',
     age: '23'
   });
   ```

2. 更新表中的某条记录

   ```javascript
   db.tableName.put(recordObject);
   
   // 如
   db.users.put({
     name: 'zhang san',
     age: '25'
   });
   ```

   此时，如果该表主键是`name`，并且表中已经存在`name`为`zhang san`的数据，就会将这条数据的`age`改为`25`。

   如果该表中没有`name`为`zhang san`的记录，则会将传入的记录作为一条新的记录插入到表中，同`add()`行为一致。

   所以，鉴于`add()`方法执行时如果已经存在主键一样的数据，就会报错，我们推荐总是使用`put()`操作来新增和更新记录，而尽量不用`add()`操作。

3. 获取表中的记录

   ```javascript
   db.tableName.get(primaryKeyValue);
   
   // 如
   db.users.get('zhang san')
     .then((user) => {
     console.log(user.age);
   });
   
   ```

   如果`user`表的主键是`name`，这条查询将获得`name`等于`zhang san`的记录。

   注意，`dexiejs`的所有操作都会返回`promise`，所以要在`promise`的`then`方法里获取查询到的记录。

4. 删除表中的记录

   ```javascript
   db.tableName.delete(primaryKeyValue);
   
   // 如
   db.users.delete('zhang san');
   ```

   将删除`user`表中`name`值为`zhang san`的记录

### 高级查询

所有的高级查询都是基于索引和主键的。

在进行这部分介绍前，我们先用以下代码生成一个‘图书馆’数据库，里面存储一些用户和图书：

```javascript
				function randomNum(minNum,maxNum){  // 生成【minNum, maxNum】的随机数
            switch(arguments.length){ 
                case 1: 
                    return parseInt(Math.random()*minNum+1,10); 
                break; 
                case 2: 
                    return parseInt(Math.random()*(maxNum-minNum+1)+minNum,10); 
                break; 
                    default: 
                        return 0; 
                    break; 
            } 
        }
        function getRandomEmail() { // 生成随机的邮箱
            return ['a@1.com', 'b@2.cn'][randomNum(0,1)]
        }
        function getRandomAddress() { // 生成随机的地址
            const province = ['p1', 'p2', 'p3'][randomNum(0,2)];
            const city = ['c1','c2','c3'][randomNum(0,2)];
            return {
                province,
                city,
            };
        }
        function getRandomBookIds() { // 生成随机的书籍ID
            const book1 = 'book_' + randomNum(0,10);
            const book2 =  'book_' + randomNum(10, 15);
            const book3 = 'book_' + randomNum(15,20);
            const bookIds = [book1, book2];
            if (randomNum(0,20) > 10) {
                bookIds.push(book3);
            }
            return bookIds;
        }
        function getRondomCats() { // 生成随机的书籍分类
            const cat1 = 'cat_' + randomNum(0,3);
            const cat2 =  'cat_' + randomNum(3, 5);
            const cat3 = 'cat_' + randomNum(5,8);
            const cats = [cat1, cat3];
            if (randomNum(0,20) > 10) {
                cats.push(cat2);
            }
            return cats;
        }
        function getRandomYear() { // 生成随机出版年份
            return '199' + randomNum(1,9);
        }
        function getRandomMonth() { // 生成司机出版月份
            return '0' + randomNum(1,9);
        }
        const users = [];
        const books = [];
        for (let i = 20; i > 0; i--) { // 生成20本图书
            if (i < 5) { // 生成4个用户
                const userObj = {
                    username: 'user_0' + i,
                    email: getRandomEmail(),
                    address: getRandomAddress(),
                    borrowingBookIds: getRandomBookIds()
                }
                users.push(userObj);
            }
            const bookObj = {
                id: 'book_' + i,
                categories: getRondomCats(),
                year: getRandomYear(),
                month: getRandomMonth(),
                bookName: 'bookName' +  i,
            };
            books.push(bookObj);
        }
        var db = new Dexie('library');
        db.version(1).stores(
            {
                users: "++id,  &username, email, address.city",
                books: 'id, *categories, [year+month]',
            }
        );
        db
            .open()
            .then((db) => {
                db.users.bulkPut(users); // 批量向表中插入用户
                db.books.bulkPut(books); // 批量向表中插入书籍
            });
```

生成数据如下：

```json
// users表
{"username":"user_04","email":"b@2.cn","address":{"province":"p3","city":"c1"},"borrowingBookIds":["book_5","book_13"],"id":1}
 {"username":"user_03","email":"b@2.cn","address":{"province":"p1","city":"c2"},"borrowingBookIds":["book_0","book_13"],"id":2}
 {"username":"user_02","email":"a@1.com","address":{"province":"p2","city":"c1"},"borrowingBookIds":["book_0","book_12"],"id":3}
 {"username":"user_01","email":"b@2.cn","address":{"province":"p1","city":"c2"},"borrowingBookIds":["book_0","book_14"],"id":4}

// books表
{"id":"book_11","categories":["cat_2","cat_6","cat_5"],"year":"1999","month":"05","bookName":"bookName11"} 
{"id":"book_10","categories":["cat_0","cat_8","cat_5"],"year":"1992","month":"03","bookName":"bookName10"} 
{"id":"book_1","categories":["cat_2","cat_7","cat_5"],"year":"1996","month":"06","bookName":"bookName1"} 
{"id":"book_12","categories":["cat_0","cat_8","cat_5"],"year":"1999","month":"09","bookName":"bookName12"}
{"id":"book_13","categories":["cat_0","cat_5"],"year":"1997","month":"02","bookName":"bookName13"}
{"id":"book_14","categories":["cat_2","cat_6"],"year":"1994","month":"04","bookName":"bookName14"}
{"id":"book_15","categories":["cat_1","cat_7"],"year":"1998","month":"06","bookName":"bookName15"}
{"id":"book_16","categories":["cat_1","cat_6"],"year":"1997","month":"08","bookName":"bookName16"}
{"id":"book_17","categories":["cat_1","cat_7","cat_3"],"year":"1991","month":"02","bookName":"bookName17"}
{"id":"book_18","categories":["cat_3","cat_8","cat_3"],"year":"1994","month":"05","bookName":"bookName18"}
{"id":"book_19","categories":["cat_2","cat_5"],"year":"1997","month":"09","bookName":"bookName19"}
{"id":"book_2","categories":["cat_2","cat_5","cat_5"],"year":"1997","month":"02","bookName":"bookName2"}
{"id":"book_20","categories":["cat_0","cat_8","cat_3"],"year":"1996","month":"02","bookName":"bookName20"}
{"id":"book_3","categories":["cat_3","cat_5","cat_4"],"year":"1998","month":"08","bookName":"bookName3"}
{"id":"book_4","categories":["cat_3","cat_5"],"year":"1996","month":"02","bookName":"bookName4"}
{"id":"book_5","categories":["cat_3","cat_6"],"year":"1997","month":"03","bookName":"bookName5"}
{"id":"book_6","categories":["cat_1","cat_8","cat_3"],"year":"1993","month":"08","bookName":"bookName6"}
{"id":"book_7","categories":["cat_1","cat_8"],"year":"1995","month":"05","bookName":"bookName7"}
{"id":"book_8","categories":["cat_1","cat_8"],"year":"1998","month":"03","bookName":"bookName8"}
{"id":"book_9","categories":["cat_2","cat_5","cat_3"],"year":"1995","month":"06","bookName":"bookName9"}
```

#### 示例1： 查找所有city为c1的用户

```javascript
db
            .open()
            .then((db) => {
                return db.users
                        .where('address.city')
                        .equals('c1')
                        .toArray();
            })
            .then((users) => {
                console.log(users);
            });

// 输出结果
0: {username: 'user_04', email: 'b@2.cn', address: {…}, borrowingBookIds: Array(2), id: 1}
1: {username: 'user_02', email: 'a@1.com', address: {…}, borrowingBookIds: Array(2), id: 3}
```

注意，此处我们在`then`方法中接收查询到的`users`结果，并直接打印到控制台，所以需要使用`toArray`方法将查询到的集合转换为数组传递给`then`方法。

#### 示例2： 查找所有类别为`cat_1`或`cat3`，并且出版年份早于1996年的书籍

```javascript
db
            .open()
            .then((db) => {
                return db.books
                        .where('categories')
                        .equals('cat_1')
                        .or('categories')
                        .equals('cat_3')
                        .and((book) => {
                            return parseInt(book.year) < 1996;
                        })
            })
            .then((books) => {
                books.each((book) => {
                    console.log(JSON.stringify(book));
                });
            });
// 输出结果
{"id":"book_17","categories":["cat_1","cat_7","cat_3"],"year":"1991","month":"02","bookName":"bookName17"}
dexie_04.html:33 {"id":"book_18","categories":["cat_3","cat_8","cat_3"],"year":"1994","month":"05","bookName":"bookName18"}
dexie_04.html:33 {"id":"book_6","categories":["cat_1","cat_8","cat_3"],"year":"1993","month":"08","bookName":"bookName6"}
dexie_04.html:33 {"id":"book_7","categories":["cat_1","cat_8"],"year":"1995","month":"05","bookName":"bookName7"}
dexie_04.html:33 {"id":"book_9","categories":["cat_2","cat_5","cat_3"],"year":"1995","month":"06","bookName":"bookName9"}
```

注意：

1. 此处查询时我们有一个条件是‘并且年份早于1996年’，这里的语法使用的是`and`条件子句，这个子句的参数只能是一个函数，该函数返回一个布尔值，以确定记录是否符合给定的条件。
2. 此处我们查询完返回`promise`时，没有用`toArray()`方法将其转换为数组，因为在下一个`then()`方法中，我们要使用`each`方法来迭代集合，所以应该直接返回集合，不用返回数组。
3. 我们注意到，我们的条件是类别为`cat_1` 或 `cat_3`的数据，像`book_17`,`book6` 都同时既属于`cat_1` ，又属于`cat_ 3` ，但是在结果中只出现了一次，说明会自动去重。

通过以上两例，我们看到，`dexiejs` 既可以进行基础的数据库操作和查询，又可以利用索引+where子句+集合的方法，来进行非常高级和细致的查询，并且语法都很简单。

下面附上所有API，大家可以自行对各个API的用法进行探索和测试。

#### 示例3  打印出所有书籍

```javascript
var Book = db.books.defineClass ({
            bookName: String,
            id: String,
            categories: [Cat],
            year: String,
            month: String
        });

        function Cat() {}

        Book.prototype.log = function () {
            console.log(JSON.stringify(this));
        }

        db
            .open()
            .then((db) => {
                return db.books
                    .toCollection();
            })
            .then((s) => {
                s.each((item) => {
                    item.log();
                });
            });

// 输出结果
{"id":"book_13","categories":["cat_0","cat_5"],"year":"1997","month":"02","bookName":"bookName13"}
 {"id":"book_15","categories":["cat_1","cat_7"],"year":"1998","month":"06","bookName":"bookName15"}
 {"id":"book_16","categories":["cat_1","cat_6"],"year":"1997","month":"08","bookName":"bookName16"}
 {"id":"book_19","categories":["cat_2","cat_5"],"year":"1997","month":"09","bookName":"bookName19"}
 {"id":"book_2","categories":["cat_2","cat_5","cat_5"],"year":"1997","month":"02","bookName":"bookName2"}
 {"id":"book_20","categories":["cat_0","cat_8","cat_3"],"year":"1996","month":"02","bookName":"bookName20"}
 {"id":"book_5","categories":["cat_3","cat_6"],"year":"1997","month":"03","bookName":"bookName5"}
 {"id":"book_8","categories":["cat_1","cat_8"],"year":"1998","month":"03","bookName":"bookName8"}
……
```

1. 这个地方，我们使用了表实例的`defineClass`方法，将表与一个构造函数绑定，通过在构造函数原型上添加方法，在所有书籍对象上扩展出来了一个`log`方法来打印其自身.
2. `db.books`返回的是一个`Table`实例，而我们要在`then`方法中调用的`each`迭代方法是`Collection`集合实例上的方法，所有要使用`toCollection`将其转换成一个集合。(当然，`Table`实例自己也有`each`方法，这里我们只是为了演示表实例调用集合实例的方法时该如何处理。)

#### 示例4 where的多种写法：找出1997年2月出版的书籍

```javascript
// 第一种写法

 db
            .open()
            .then((db) => {
                return db.books
                    .where(['year', 'month'])
                    .equals(['1997','02'])
                    .toArray();
            })
            .then((s) => {
                console.log(s);
            });


// 第二种写法
db
            .open()
            .then((db) => {
                return db.books
                    .where({
                        year: '1997',
                        month: '02'
                    })
                    .toArray();
            })
            .then((s) => {
                console.log(s);
            });


// 第三种写法
 db
            .open()
            .then((db) => {
                return db.books
                    .where('year')
                    .equals('1997')
                    .and((book) => {
                        return book.month === '02';
                    })
                    .toArray();
            })
            .then((s) => {
                console.log(s);
            });


// 输出结果
0: {id: 'book_13', categories: Array(2), year: '1997', month: '02', bookName: 'bookName13'}
1: {id: 'book_2', categories: Array(3), year: '1997', month: '02', bookName: 'bookName'}
……
```



### 表实例的完整API

| API名称                                                      | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| add(item, [key])                                             | 将对象添加到对象存储（表）。返回一个`promise`，成功后`then`方法接收参数为插入对象的主键值。 |
| bulkAdd(items, keys?, options?)                              | 批量向表中插入记录，返回一个`promise`，如果`options`未设置或设置为`{allKeys:false}`，则`then`方法接收的是插入的所有插入对象的主键组成的数组， 如果`options`设置为`{allkeys:true}`，`then`方法接收的是插入的所有对象中最后一个对象的主键。 |
| bulkDelete(keys)                                             | 批量删除表中的记录，传入主键数组，返回一个`promise`，`then`方法接收的是`undefined` |
| bulkGet(keys)                                                | 批量获取指定索引或主键的记录，传入主键数组，返回一个`promise`， `then` 方法接收结果数组，对于数据库中不存在的那些键， undefined 将在它们的位置返回。 |
| bulkPut(items, keys?, options?)                              | 批量向表中插入(更新)记录，传参与返回同`bulkAdd()`方法，但是如果已经有相同主键的记录，不会报错，而是会覆盖之前的记录 |
| clear()                                                      | 删除表中的所有记录，返回一个`promise`，`then`方法接收参数为`undefined` |
| count()                                                      | 统计表中记录的数量，返回一个`promise`， `then`方法接收参数为一个代表记录数量的整数 |
| defineClass(structure)                                       | 定义一个将映射到此对象存储的 javascript 构造函数，返回值就是该构造函数。可以在这个构造函数的基础上，对表中的对象进行扩展，比如添加成员方法等。如果在调用 db.open() 之前调用此方法，Visual Studio 2012+ 和 IntelliJ 等智能 javascript 编辑器将能够根据构造函数的原型和给定的结构对数据库返回的所有对象进行自动完成。【见上文 示例3】 |
| delete(primaryKey)                                           | 从表中删除记录，传入一个逐渐，返回一个`promise`, `then` 方法接收参数为`undefined` |
| each(callback)                                               | 迭代表中的每一条记录，回调方法每次迭代接收的是当前迭代的那条记录对象。 |
| filter(filterFunction)                                       | 对对象存储中的所有项目应用 javascript 过滤器，返回一个集合实例，该实例将迭代整个对象存储，并在调用集合上的任何执行方法（如toArray（）、each（）、keys（）、uniqueKeys（）和sortBy（））时为每个项调用给定的筛选器函数。 |
| get(primaryKey  \|\| {keyPath1: value1, keyPath2: value2, ...} ) | 获取给定主键的对象或满足给定条件 ({keyPath1: value1, keyPath2: value2}) 的对象并返回一个`promise`,  `then`方法接收的参数是第一个匹配结果，如果没有匹配到，接收`undefined` |
| hook('creating')                                             | 记录创建钩子，无论使用哪种方法，只要将对象添加到数据库中，都会调用此事件。调用Table.add（）时，将始终调用它。但是调用Table.put（）时，只有在操作导致对象创建时才会调用它。如果它将导致替换现有对象，则会触发hook（'更新'）。 |
| hook('deleting')                                             | 记录删除钩子，无论使用哪种方法，只要将要从数据库中删除对象，就会调用此事件。 可以删除对象的方法有 Table.delete()、Table.clear()、Collection.delete() 和 Collection.modify()，因为它也可以用于删除对象。 |
| hook('reading')                                              | 记录读取钩子，每当对象即将从数据库返回到 Table.get() 或任何产生数据库对象的 Collection 方法的调用者时，都会调用此事件，但不是具有过滤或修改目的的方法，例如 Table.filter() 或 Table 。调整（）。 具体来说，hook(‘reading’) 将过滤返回的对象 |
| hook('updating')                                             | 记录更新钩子，每当将要更新现有数据库对象时（通过以下任何方法：put()、update() 或 modify()，都会调用此事件。调用 put() 只会导致更新事件，以防它导致 替换现有对象，否则，如果 put() 导致对象创建，则将触发创建事件 |
| limit(N)                                                     | 返回限制为 N 个项目的集合，返回的是一个集合实例              |
| mapToClass(constructor[, structure])                         | 将表映射到现有的 javascript 类，以便使表中对象获得该类的成员属性和成员方法。 |
| name                                                         | 获取表的名称                                                 |
| offset(N)                                                    | 返回一个集合实例（按主键排序），其中对象存储中的前 N 个项目被忽略 |
| orderBy(index)                                               | 返回表中所有项目的集合实例，其中属性设置为按给定索引属性排序的可索引类型。 结果中不包含属性未设置为可索引类型的对象。 |
| put(item, [key])                                             | 在对象库中添加新对象或替换现有对象。 返回一个`promise`，如果成功，`then`方法接收的参数是该对象的主键值。 |
| reverse()                                                    | 以相反的顺序返回按主键排序的集合实例。                       |
| toArray()                                                    | 将查询结果转换为数组，该结果可以是`Table`表实例，也可以是`Collection`集合实例 |
| toCollection()                                               | 返回包含存储中所有对象的【未筛选】集合实例，未经过删选的通常是`Table`实例 |
| update(key, changes)                                         | 使用给定的更改更新对象存储中的现有对象， 返回一个`promise`，`then`方法接收的参数是更新成功的数量 |
| where(keyPathArray \|\| {keyPath1: value1, keyPath2: value2, ...} ) | 通过创建 WhereClause 实例开始过滤对象存储，通过where子句查询到的结果都是集合。 |

### 集合实例的所有API

| API名称                                  | 说明                                                         |
| ---------------------------------------- | ------------------------------------------------------------ |
| and(filterFn)                            | 新增一个需要同时满足的查询条件，传入一个过滤函数，根据是否符合过滤条件返回布尔值。返回一个集合实例。 |
| clone()                                  | 通过原型从原始集合派生的集合实例。对返回集合的操作不会影响原始查询。 返回一个集合实例 |
| count(callback)                          | 返回集合中符合某些条件的数据的条数。返回一个`promise`，`then`方法接收的是代表记录数量的整数。如果传入回调，则回调接收的也是记录数量的整数。 |
| delete()                                 | 删除查询结果中的所有对象。 返回一个`promise`, `then`方法接收的参数是删除成功的条数。 |
| desc()                                   | 方法已替换为 reverse() 方法，但仍保留几个版本【不建议使用】  |
| distinct()                               | 去重，去除集合中重复出现的同一条记录（可能是因为索引条件的重叠引起）。返回集合实例。 |
| each(callback)                           | 对查询结果中的每条记录执行传入的函数，参数为记录对象，返回一个`promise`，`then`方法接收的参数是`undefined` |
| eachKey(callback)                        | 迭代查询结果中的每条记录，参数为索引值和游标对象，返回一个`promise`，`then`方法接收的参数是`undefined` |
| eachPrimaryKey(callback)                 | 迭代查询结果中的每条记录，参数主键，返回一个`promise`，`then`方法接收的参数是`undefined`，只有通过主键查询到的集合运用此方法时，才会执行回调，否则不执行回调 |
| eachUniqueKey(callback)                  | 迭代查询结果中的每条记录，参数是唯一索引，返回一个`promise`，`then`方法接收的参数是`undefined`，只有通过唯一索引查询到的集合运用此方法时，才会执行回调，否则不执行回调 |
| filter(filterFn)                         | 从查询结果中过滤出符合条件的记录，返回集合实例，此方法与 Collection.and() 相同 |
| first(callback)                          | 从查询加过中过滤出符合条件的第一条记录，返回一个`promise`，如果省略回调并且操作成功，则返回的 Promise 将使用操作结果解析;如果指定了callback并且操作成功，那么将调用给定的callback，并且返回的承诺将用给定callback的返回值进行解析;如果操作失败，返回的承诺将被拒绝 |
| keys(callback)                           | 检索集合中所有指定索引字段的数组。给定的回调将接收一个数组，该数组包含集合中索引的索引的所有键。只能用于索引，不能用于主键。如果省略回调并且操作成功，则返回的Promise将与操作结果解析;如果指定了callback并且操作成功，那么将调用给定的callback，并且返回的承诺将用给定callback的返回值进行解析;如果操作失败，返回的承诺将被拒绝 |
| last(callback)                           | 从查询加过中过滤出符合条件的最后一条记录，返回情况同`first()` |
| limit(N)                                 | 从查询结果中返回前N条记录（N是该方法参数），返回集合实例。   |
| modify(changes)                          | 修改此 Collection 实例表示的表子集中的所有对象，返回一个`promise`, `then`方法接收的参数是修改成功的对象数量。 |
| offset(N)                                | 返回集合中第N条以后的数据（N是该方法参数）,返回一个集合实例  |
| or()                                     | 为查询新增一个‘或‘条件， 返回一个where子句实例。它前面必须是一个where子句实例。 |
| primaryKeyscallback()                    | 选择集合中所有项的主键。 返回一个`promise`，给定回调/返回的承诺，将接收一个数组，该数组包含集合中索引的索引的所有主键。如果省略回调并且操作成功，则返回的Promise将与操作结果解析；如果指定了callback并且操作成功，那么将调用给定的callback，并且返回的承诺将用给定callback的返回值进行解析 |
| raw()                                    | 使结果操作忽略 Table.hook(‘reading’) 的任何订阅者。 例如，它不会将对象映射到它们的映射类。 返回一个集合实例。 |
| reverse()                                | 无论使用sortBy（）还是自然排序顺序（orderBy或where（）子句），此方法都将反转集合的排序顺序，如果调用两次，排序顺序将再次重置为升序。 返回排序反转后的集合实例 |
| sortBykeyPath, callback?)                | 集合中的项目自然按 where() 子句中使用的索引或主键排序。 但是，如果您需要对索引以外的其他属性进行排序，则可以使用此方法来执行此操作。 此外，如果使用了 Collection.or()，则除非使用此方法，否则不再对 Collection 进行排序。。 返回一个`promise`， 如果省略回调并且操作成功，则返回的承诺将与操作结果一起解析，如果指定了callback并且操作成功，那么将调用给定的callback，并且返回的承诺将用给定callback的返回值进行解析。 |
| toArray(callback)                        | 将集合转换为数组返回。返回一个`promsie`, 如果省略回调并且操作成功，则返回的承诺将与操作结果一起解析;如果指定了回调并且操作成功，将调用给定的回调，并且返回的 Promise 将与给定回调的返回值一起解析 |
| uniqueKeys(callback)                     | 检索集合中所有唯一索引的数组。返回一个`promise.`如果省略回调并且操作成功，则返回的承诺将与操作结果一起解析;如果指定了回调并且操作成功，将调用给定的回调，并且返回的 Promise 将与给定回调的返回值一起解析 |
| until(filterFunction, bIncludeStopEntry) | 一旦给定的过滤器返回 true，就停止迭代集合。返回集合实例。    |

### where子句的所有API

| API名称                                                     | 说明                                                         |
| ----------------------------------------------------------- | ------------------------------------------------------------ |
| above(lowerBound)                                           | 返回数据集中指定主键或索引（不可用于复合索引）字段的值大于某个值的所有记录，返回一个集合实例 |
| aboveOrEqual(lowerBound)                                    | 返回数据集中指定主键或索引（不可用于复合索引）字段的值大于等于某个值的所有记录， 返回一个集合实例 |
| anyOf(array \|\| key1, key2, keyN)                          | 返回数据集中索引或主键值包含在给定数组中的记录。返回一个集合实例 |
| anyOfIgnoreCase(array \|\|key1, key2, keyN)                 | 返回数据集中索引或主键值包含在给定数组中的记录，忽略大小写。返回一个集合实例 |
| below(upperBound)                                           | 返回数据集中指定主键或索引（不可用于复合索引）字段的值小于某个值的所有记录 ，返回一个集合实例 |
| belowOrEqual(upperBound)                                    | 返回数据集中指定主键或索引（不可用于复合索引）字段的值小于等于某个值的所有记录，返回一个集合实例 |
| between(lowerBound, upperBound, includeLower, includeUpper) | 返回数据集中指定主键或索引字段的值介于两个指定值之间的所有记录，返回一个集合实例 |
| equals(key)                                                 | 返回数据集中指定主键或索引字段的值等于给定键的所有记录，返回一个集合实例 |
| equalsIgnoreCasekey)                                        | 返回数据集中指定主键或索引字段的值等于给定键的所有记录，忽略大小写，返回一个集合实例。 |
| inAnyRange(ranges, options)                                 | 返回一个集合，其中索引在任何给定范围内。返回一个集合实例。`ranges`是一个二维数组，可包含多个范围数组， `options`用来设置是否包含范围两端的值，默认值为：`{includeLowers: false, includeUppers: false}` |
| noneOf()                                                    | 查询与给定值不匹配的所有有效值的集合。 请注意，您只会找到作为有效 indexedDB 键的值，返回一个集合实例。 |
| notEqual()                                                  | 查询集合中与给定值不匹配的所有有效值。请注意，您将只找到有效的indexedDB键的值，返回一个集合实例。 |
| startsWith()                                                | 返回数据集中指定主键或索引字段的值以给定字符串开始的所有记录，返回一个集合实例。 |
| startsWithAnyOf()                                           | 返回数据集中指定主键或索引字段的值以给定字符串组中的任何一个开始的所有记录，返回一个集合实例。 |
| startsWithAnyOfIgnoreCase()                                 | 返回数据集中指定主键或索引字段的值以给定字符串组中的任何一个开始的所有记录，忽略大小写，返回一个集合实例。 |
| startsWithIgnoreCase()                                      | 返回数据集中指定主键或索引字段的值以给定字符串开始的所有记录，忽略大小写。返回一个集合实例。 |

> 注意：以上表实例，集合实例，where子句的方法返回结果如果是集合实例，都可以使用`promise`的`then`方法来接收返回的集合实例。


### 数据库实例的完整API

| API                             | 说明                                                         |
| ------------------------------- | :----------------------------------------------------------- |
| AbortError                      | 事务中止时抛出的错误类型                                     |
| BulkError                       | Table的bulkAdd,bulkPut,bulkDelete操作抛出的错误类型          |
| ConstraintError                 | 尝试了违反约束的数据库操作。 例如，如果您定义了一个唯一索引“name”并将两个同名对象放入该表中，则第二个 put() 将导致约束错误 |
| DataCloneError                  | 尝试将项目添加或放入数据库，其中对象包含结构化克隆算法不支持的结构，例如函数或错误对象 |
| DatabaseClosedError             | 数据库连接已通过调用 db.close() 显式关闭，或者使用选项 {autoOpen: false} 打开并且尚未调用 db.open() |
| InternalError                   | 底层实现失败                                                 |
| InvalidAccessError              | 试图写入以只读模式打开的表                                   |
| InvalidArgumentError            | 使用一个或多个无效参数调用了Dexie方法                        |
| InvalidStateError               | 当尝试在无效状态下使用IndexedDB资源时可能会发生这种情况。例如，从升级回调中调用db.transaction（） |
| InvalidTableError               | 尝试访问不存在或不属于当前事务的表时发生                     |
| MissingAPIError                 | 当尝试打开数据库时找不到 indexedDB API 时发生                |
| ModifyError                     | Collection.modify（）和Collection.delete（）中可能发生的错误 |
| NoSuchDatabaseErrorError        | 如果在第一次与数据库交互之前没有调用db.version（X），则认为它是以动态模式打开的，这基本上意味着它可能只打开现有的数据库。如果提供的数据库名称在db.open（）中不存在，它将失败，并显示NoSuchDatabaseError。 |
| NotFoundError                   | 尝试使用不属于当前事务的表                                   |
| Observable                      | 观察对数据库的更改 - 即使它们发生在另一个浏览器窗口中,需要安装dexie-observable插件 |
| Observable.DatabaseChange       | 数据库更改对象的结构。                                       |
| OpenFailedError                 | 由于无法打开数据库而导致 db 操作失败时发生                   |
| PrematureCommitError            | 当 indexedDB 事务在您的事务范围返回的承诺被解析或拒绝之前提交时，将抛出此异常。 |
| QuotaExceededError              | 超出了当前来源的存储配额。 要了解有关存储配额的更多信息，请参阅存储管理器 API。 |
| ReadOnlyError                   | 事务以只读模式打开，但尝试进行写入操作                       |
| SchemaError                     | 当数据库架构有错误时发生                                     |
| SubTransactionError             | 使用与当前正在进行的事务不兼容的模式或一组表调用 db.transaction() |
| Syncable                        | 启用与任何类型的远程服务器的双向同步，需要安装dexie-observable , dexie-syncable |
| Syncable.IDatabaseChange        | 数据库更改的 Javascript 接口。 属性类型表明更改是对给定表中给定键的创建 (1)、更新 (2) 还是删除 (3)。 |
| Syncable.IPersistentContext     | ISyncProtocol 实现者可以用来在其中存储持久状态信息的上下文   |
| Syncable.ISyncProtocol          | 实现与远程数据库服务器同步的接口,远程数据库服务器可以是基于 SQL 或 NOSQL 的，只要它能够将符合 JSON 的对象存储到某种对象存储中并通过主键引用它们。 |
| Syncable.StatusTexts            | 见 [Dexie.Syncable.Statuses](https://dexie.org/docs/Syncable/Dexie.Syncable.Statuses)，状态号的文本查找 |
| Syncable.Statuses               | 可能的同步状态的枚举，例如 OFFLINE、CONNECTING、ONLINE 和 ERROR。 |
| Syncable.registerSyncProtocol() | 注册使 Dexie.Syncable 适应您的服务器和数据库类型的同步协议   |
| TimeoutError                    | 传递给 Dexie.waitFor() 的超时在完成之前被命中。              |
| TransactionInactiveError        | 当您尝试访问它时，该事务已经提交                             |
| UnknownError                    | 底层实现失败                                                 |
| UnsupportedError                | 当前浏览器不支持该操作                                       |
| UpgradeError()                  | 数据库无法升级时发生                                         |
| VersionChangeError              | 当另一个数据库实例删除或升级数据库以致必须关闭自己的实例时发生 |
| VersionError                    | 数据库版本错误                                               |
| [table]                         | 读取表                                                       |
| addons                          | 此数组包含为 Dexie 添加功能的函数。 插件可以使用 Dexie.addons.push(fn) 在 Dexie.addons 中注册自己 |
| async()                         | 无需转译器即可在现代浏览器（Chrome、Firefox、Opera 和 Edge）中使用异步功能，【属于类】 |
| backendDB()                     | 返回本机 IndexedDB 数据库实例，这个实例就是原生的数据库实例，可以使用原生语法操作数据库 |
| close()                         | 关闭数据库。此操作立即完成，没有返回的承诺                   |
| currentTransaction              | 如果从事务范围内访问，则此属性将包含当前事务实例。 如果不在事务范围内，则此属性将为空。 |
| debug                           | 获取或设置异常的堆栈是否具有长堆栈支持。 这在调试应用程序时很有用，但在生产中会稍微降低性能。 强烈建议在开发/调试应用程序时打开它。【属于类】 |
| deepClone()                     | 完全克隆对象或数组，但仍允许 Date 或自定义类的任何实例保留其原型结构。【属于类】 |
| defineClass()                   | 定义一个类。 【属于类】                                      |
| delByKeyPath()                  | 从给定键路径的对象中删除属性。 【属于类】                    |
| delete()                        | 删除数据库并在完成时调用返回的 Promise 的 then() 方法。 如果数据库不存在（db.open() 从来没有被调用过）这个方法也会成功。 |
| derive()                        | 修复了 OOP 继承的原型链 【属于类】                           |
| events()                        | 创建一组事件 【属于类】                                      |
| exists()                        | 检查具有给定名称的数据库是否存在。 返回一个以 true 或 false 解析的 Promise 【属于类】 |
| extend()                        | 合并对象 【属于类】                                          |
| fakeAutoComplete()              | 帮助 IDE 了解您将如何调用回调。【属于类】                    |
| getByKeyPath()                  | 从给定键路径的对象中检索属性。 【属于类】                    |
| getDatabaseNames()              | 返回当前主机上的数据库名称数组 【属于类】                    |
| hasFailed()                     | 如果数据库打开失败返回真                                     |
| ignoreTransaction()             | 此方法可以启动不依赖于当前事务的事务或数据库操作。【属于类】 |
| isOpen()                        | 如果数据库已打开，则返回 true。此方法是同步的并返回一个布尔值 |
| name                            | Dexie 构造函数中提供的数据库名称。                           |
| on()                            | 添加监听，事件类型有：ready、error、populate、blocked、versionchange |
| on.blocked                      | 如果数据库升级被另一个选项卡或浏览器窗口阻止，保持对数据库的连接打开，则会发生“阻止”事件。 |
| on.error                        | 此事件自 Dexie v1.5.0 起已弃用，自 Dexie v2.0.0 起已过时。 改用 window.addEventListener('unhandledrejection', callback) |
| on.populate                     | populate 事件在数据库的生命周期中仅发生一次 - 以防在调用 db.open() 时客户端上不存在数据库，并且需要创建对象存储 |
| on.ready                        | 每当数据库打开时执行代码\| 阻止 db.open() 直到完成\| 扩展Dexie类 |
| on.versionchange                | 如果另一个 indexedDB 数据库实例需要升级或删除数据库，则会发生“versionchange”事件。 如果你不订阅这个事件，Dexie 有一个内置的默认实现，它会立即关闭数据库并登录到控制台。 这将恢复其他页面的升级过程。 |
| open()                          | 打开数据库连接。 在调用 open() 之后，您不能再调用 Dexie.version()。 <br />默认情况下，db.open() 将在第一次查询数据库时自动调用 |
| override()                      | 启用覆盖现有函数，并且仍然能够从覆盖函数中调用原始函数 【属于类】 |
| semVer                          | 包含 Dexie 库语义版本字符串的静态属性 【属于类】             |
| setByKeyPath()                  | 修改给定键路径和值的对象中的属性。 【属于类】                |
| shallowClone()                  | 浅克隆一个对象。 【属于类】                                  |
| spawn()                         | 无需转译器即可在现代浏览器（Chrome、Firefox、Opera 和 Edge）中使用异步功能 【属于类】 |
| table()                         | 读取表                                                       |
| tables                          | 返回所有的表                                                 |
| transaction()                   | 启动数据库事务。                                             |
| use()                           | 定义中间件                                                   |
| verno                           | 数据库的版本号（只读）                                       |
| version                         | 包含 Dexie 库版本号的静态属性，作为可比较的十进制数。【属于类】 |
| version()                       | 指定数据库版本                                               |
| vip()                           | on(‘ready’) 事件的订阅者要使用的方法。 即使在 db.ready() 订阅者触发时它被阻塞，这也能让调用者通过访问 DB |
| waitFor()                       | 这种方法可以在保持当前事务处于活动状态的同时执行异步非索引数据库工作。 请谨慎使用，因为它可能会给浏览器带来不必要的 CPU 负载。 一个单独的任务将通过在给定的 promise 被执行时在事务上传播虚拟请求来保持事务处于活动状态 【属于类】 |
|                                 |                                                              |














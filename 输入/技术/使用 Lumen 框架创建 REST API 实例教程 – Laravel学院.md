使用 Lumen 框架创建 REST API 实例教程 – Laravel学院

# 使用 Lumen 框架创建 REST API 实例教程

** Posted on [2016年11月13日](http://laravelacademy.org/post/6449.html) by **  [学院君](http://laravelacademy.org/post/author/nonfu)

### **概述**

[Lumen](http://laravelacademy.org/tags/lumen)是一个基于Laravel的微框架，主要用于小型应用和微服务，专注于性能和速度的优化，该框架一个重要的应用就是构建 REST [API](http://laravelacademy.org/tags/api)。

![lumen-api](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115346.png)
**为什么用Lumen构建REST API**

- Lumen访问速度非常快
- 每秒能够处理的请求数比Laravel更多
- 使用[nikic/FastRoute](https://github.com/nikic/FastRoute)取代Symphony，从而提升了性能

### **安装 & 配置**

关于Lumen详细安装[教程](http://laravelacademy.org/tags/%e6%95%99%e7%a8%8b)参考官方文档：http://laravelacademy.org/post/6328.html

这里我们使用Composer在web根目录下安装：
composer create-project laravel/lumen rest_api
安装完成后，在`.env`中配置数据库连接信息：
DB_DATABASE=<db_name>
DB_USERNAME=<db_username>
DB_PASSWORD=<db_password>
然后在`bootstrap/app.php`中取消下面两行之前的注释：
$app->withFacades();
$app->withEloquent();
此时在浏览器访问`rest_api.dev`（Mac下使用Valet，Windows请自行设置虚拟域名），页面显示如下：
Lumen (5.3.2) (Laravel Components 5.3.*)

### **数据库迁移**

接下来我们来创建数据表。
在项目根目录下运行如下命令：
php artisan make:migration create_table_cars --create=cars

该命令将会在 `database/migrations/`目录下创建一个迁移文件`<date>_create_table_cars.php`，接下来我们来编辑这个文件来定义数据表。

Schema::create('cars', function (Blueprint $table) {
    $table->increments('id');
    $table->string('make');
    $table->string('model');
    $table->string('year');
});
现在我们来运行这个迁移：
php artisan migrate
这样，就会在数据库中创建对应的表：
![rest_api_cars](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115359.png)

### **创建模型**

接下来我们在`app`目录下创建模型文件`Car.php`，并编写代码如下：
<?php namespace App;
use Illuminate\Database\Eloquent\Model;
class Car extends Model
{
     protected $fillable = ['make', 'model', 'year'];
     public $timestamps = false;
}

### **创建控制器**

然后创建控制器文件`app/Http/Controllers/CarController.php`：
<?php
namespace App\Http\Controllers;
use App\Car;
use Illuminate\Http\Request;
class CarController extends Controller
{
public function createCar(Request $request)
{
$car = Car::create($request->all());
return response()->json($car);
}
public function updateCar(Request $request, $id)
{
$car = Car::find($id);
$car->make = $request->input('make');
$car->model = $request->input('model');
$car->year = $request->input('year');
$car->save();
return response()->json($car);
}
public function deleteCar($id)
{
$car = Car::find($id);
$car->delete();
return response()->json('删除成功');
}
public function index()
{
$cars = Car::all();
return response()->json($cars);
}
}

### **定义路由**

剩下的就是配置路由了，我将会为增删改查配置对应路由。打开`app/Http/routes.php`并添加如下路由：
$app->group(['prefix' => 'api/v1'], function($app)
{
    $app->post('car','CarController@createCar');
    $app->put('car/{id}','CarController@updateCar');
    $app->delete('car/{id}','CarController@deleteCar');
    $app->get('car','CarController@index');
});
注意我将这组路由放到了`api/v1`前缀下。

### **测试API**

现在让我们用curl来测试这组REST API。
首先我们来测试创建：

curl -i -X POST -H "Content-Type:application/json" http://rest_api.dev/api/v1/car -d '{"make":"audi","model":"tt","year":"2016"}'

输出如下则表示创建成功：
HTTP/1.0 200 OK
Host: rest_api.dev
Connection: close
X-Powered-By: PHP/7.0.6
Cache-Control: no-cache
Content-Type: application/json
Date: Sun, 13 Nov 2016 07:06:13 GMT
{"make":"audi","model":"tt","year":"2016","id":1}
然后我们来测试更新刚刚创建的这条记录：

curl -H "Content-Type:application/json" http://rest_api.dev/api/v1/car/1 -X PUT -d '{"make":"bmw","model":"x6","year":"2016"}'

输出如下，表示更新成功：
{"id":1,"make":"bmw","model":"x6","year":"2016"}
接下来我们来测试列表页面：
curl -H "Content-Type:application/json" http://rest_api.dev/api/v1/car -X GET
输出如下：
[{"id":1,"make":"bmw","model":"x6","year":"2016"}]
最后，我们测试下删除API：
curl -X DELETE http://rest_api.dev/api/v1/car/1
分类： **  [基础教程](http://laravelacademy.org/tutorials/basic)

标签： **  [API](http://laravelacademy.org/tags/api), [Lumen](http://laravelacademy.org/tags/lumen), [RESTful](http://laravelacademy.org/tags/restful), [教程](http://laravelacademy.org/tags/%e6%95%99%e7%a8%8b)

分享：
[(L)](http://www.jiathis.com/share)[0]()

声明： 原创文章，未经允许，禁止转载！
# select组件支持远程搜索和分页

## 效果

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201015115954.gif)

## 代码

### HTML

```html
<a-form-model-item
                        label="单位负责人"
                        class="unitmaster"
                        :label-col="labelCol3"
                        :wrapper-col="wrapperCol3"
                        :colon="isShowColon"
                        prop="unitMaster"
                    >
                        <a-select
                            v-model="form.unitMaster"
                            show-search
                            :filter-option="false"
                            :not-found-content="fetching ? undefined : null"
                            placeholder="输入名称查找"
                            @search="fetchUser"
                        >
                            <div slot="dropdownRender" slot-scope="menu">
                                <v-nodes :vnodes="menu" />
                                <a-pagination
                                    size="small"
                                    class="pagination"
                                    :page-size="page.pageSize"
                                    :total="page.total"
                                    :show-less-items="true"
                                    @change="unitMasterPageChange"
                                    @mousedown.native.stop="e => e.preventDefault()"
                                >
                                </a-pagination>
                            </div>
                            <a-select-option v-for="master in unitMaster" :key="master.label" :value="master.value">{{ master.label }}</a-select-option>
                        </a-select>
                    </a-form-model-item>
```

### JS

```javascript
 components: {
   VNodes: {
            functional: true,
            render: (h, ctx) => ctx.props.vnodes
        }
 },
data() {
        this.fetchUser = _.debounce(this.fetchUser, 800);
        return {
            fetching: false,
            form: {
                unitMaster: undefined
            },
            unitMaster: [],
             page: {
                pageSize: 20,
                pageNum: 1,
                total: 0
            },
            unitMasterSearchKeyWord: ''
        }
},
methods: {
    getUnitMaster(query) {
            const params = query || {};
            if (this.unitMasterSearchKeyWord !== '') {
                params.trueName = this.unitMasterSearchKeyWord;
                params.userName = this.unitMasterSearchKeyWord;
            }
            if (!params.pageSize) {
                params.pageSize = this.page.pageSize;
            }
            if (!params.pageNum) {
                params.pageNum = this.page.pageNum;
            }
            fetchUnitMaster(params).then(data => {
                if (data.code === '200' && data.datas.length) {
                    this.unitMaster = data.datas.map((item) => {
                        return {
                            label: item.trueName + (item.phone || ''),
                            value: item.id
                        };
                    });
                    this.page = this.transPage(data.summary);
                }
            });
        },
    fetchUser(value) {
            this.unitMasterSearchKeyWord = value;
            this.fetching = true;
            this.page.pageNum = 1;
            this.getUnitMaster();
        },
    unitMasterPageChange(page, pagesize) {
            const params = {
                pageNum: page
            };
            this.getUnitMaster(params);
        },
    transPage: function(page) {
            return {
                total: parseInt(page.total),
                pageNum: parseInt(page.pageNum),
                pageSize: parseInt(page.pageSize)
            };
        }
}
```

## 关键实现讲解

### 1.搜索

#### 1.1属性设置

```html
show-search // 允许搜索
:filter-option="false" // 当启用远程搜索时， 禁用过滤
:not-found-content="fetching ? undefined : null" // 获取远程数据时的显示
placeholder="输入名称查找" // 默认提示
@search="fetchUser" // 定义搜索框内容变化时的回调
```

#### 1.2 搜索回调

```javascript
fetchUser(value) {
            this.unitMasterSearchKeyWord = value;
            this.fetching = true;
            this.page.pageNum = 1;
            this.getUnitMaster();
        },
```

* 设置当前搜索关键词
* 设置搜索状态
* 重置当前分页数
* 从远程接口获取数据

#### 1.3 搜索防抖

由于搜索框每次发生变化都会触发`search` 事件，所以需要进行防抖

```javascript
this.fetchUser = _.debounce(this.fetchUser, 800);
```



### 2. 翻页

### 2.1  `dropdownRender` 插槽

该属性插槽允许自定义下拉列表内容，我们的分页就是设置在这里面：

```html
<div slot="dropdownRender" slot-scope="menu">
                                <v-nodes :vnodes="menu" />
                                <a-pagination
                                    size="small"
                                    class="pagination"
                                    :page-size="page.pageSize"
                                    :total="page.total"
                                    :show-less-items="true"
                                    @change="unitMasterPageChange"
                                    @mousedown.native.stop="e => e.preventDefault()"
                                >
                                </a-pagination>
                            </div>
```

`slot-scope` 属性所指向的就是未自定义时`select `下拉列表的选项列表。

#### 2.2 Vnode组件

```javascript
VNodes: {
            functional: true,
            render: (h, ctx) => ctx.props.vnodes
        }
```

返回选项列表

#### 2.3 分页组件

*  由于选择器宽度有限，所以这里设置了`size="small"`
* `:show-less-items="true"` 分页组价默认会显示5个页码，设置该属性可以在宽度有限的情况下减少页码显示
* `@mousedown.native.stop="e => e.preventDefault()"` ：当点击翻页时，选择器的选项列表会收起，设置这个事件，阻止翻页的默认事件，可以防止选项列表收起。


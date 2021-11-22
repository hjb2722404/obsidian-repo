Ant Design Vue使用过程中的难点记录 - 木林森的blogs - OSCHINA

# Ant Design Vue使用过程中的难点记录

作者：[CC_Liu](https://my.oschina.net/lcfblogs)

时间：2019/10/25 14:17

标签：[Ant Design Vue](https://my.oschina.net/lcfblogs?q=Ant%20Design%20Vue)

### 初次使用Ant Design Vue框架，记录下

官网地址：https://vue.ant.design/docs/vue/introduce-cn/
1. **解决控制台key警示的问题**
![b8a398f3a2a2da7bd54315962b02f98ddf8.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173633.png)
在table标签中增加rowKey="xx":
`<a-table rowKey="xx"></a-table>`
其中xx为数据源中每一项的唯一标识，可以是id或者key之类的。

* * *

1. **表格a-table:嵌入进度条program**
(当前需求：最后一个不需要显示比例)

		<a-table
		      bordered
		      rowKey="xx"
		      :pagination="false"
		      :columns="chooseColumns"
		      :dataSource="it.wjxzList"
		      v-if="it.wtlx==1"
		      class="table fixed-table"
		      style="padding:16px;"
		    >
		      <span slot="bl" slot-scope="text, record,index">
		        <a-progress v-show="index != it.wjxzList.length-1" :percent="parseInt(text.replace('%',''))" />
		      </span>
		    </a-table>

在data中设置：scopedSlots: { customRender: 'bl' }

	   chooseColumns:[
	        {
	          title: "比例",
	          dataIndex: "bl",
	          key: "bl",
	          scopedSlots: { customRender: 'bl' }
	        }
	      ]

* * *

1. **表格a-table:给某一列增加样式和事件**
在columns中设置：

		{
		      title: "选项",
		      dataIndex: "xx",
		      key: "xx",
		  customCell:(record,index)=>{
		    return{
		       style: {
			  width: 200,
			  overflow: "hidden",
			  whiteSpace: "nowrap",
			  textOverflow: "ellipsis",
			  cursor: "pointer"
			  },
			on:{
			  click:()=>{},
			  mouseenter:e=>{}
			  }
			}
		    }
		    }

* * *

1. **表格a-table:根据数据的list长度动态合并单元格**
效果图如下：
![870f4390583b98d499f7eb1f19f2c60cdd8.jpg](../_resources/792e80697b34f5881717ddf9a1a522fe.png)
首先接口请求到数据后，先根据数据的结构，给list中的每项数据加上rowSpan属性，例如data是接口请求到的数据：

	for (let value in data) {
	   data[value][0].rowSpan = data[value].length;
	   for (let i = 1; i < data[value].length; i++) {
	       data[value][i].rowSpan = 0;
	    }
	   this.sourceData.push(...data[value]);//sourceData是表格的数据源
	}

然后html部分的代码：

	<a-table
	   bordered
	   rowKey="xlhFgnr"
	   :pagination="false"
	   :columns="columns"
	   :dataSource="sourceData"
	 >
	    <span slot="xh" slot-scope="text, record, index">{{index+1}}</span>
	    <span slot="fgmc" slot-scope="text, record">
	      <a href="javascript:;" @click="toDetail(record)">{{text}}</a>
	    </span>
	</a-table>

columns数据：

	columns: [
	        {
	          title: "法规类型",
	          width: 200,
	          dataIndex: "fglxmc",
	          key: "fglxmc",
	          customRender: (value, row, index) => {
	            const obj = {
	              children: value,
	              attrs: {}
	            };
	            obj.attrs.rowSpan = row.rowSpan;//设置合并属性rowSpan
	            return obj;
	          }
	        },
	        {
	          title: "法规名称",
	          dataIndex: "fgmc",
	          key: "fgmc",
	          scopedSlots: { customRender: "fgmc" }
	        },
	        {
	          title: "",
	          width: 100,
	          dataIndex: "action",
	          key: "action",
	          customCell:(record,index) => {
	            return {
	              style: {//设置单元格的样式
	                width: 200,
	                overflow: "hidden",
	                whiteSpace: "nowrap",
	                textOverflow: "ellipsis",
	                cursor: "pointer"
	              },
	              on :{//给单元格增加事件
	                click:()=>{
	                  this.$router.push({
	                    name: "××××",
	                    query: { bm: record.bm }
	                  });
	                }
	              }
	            }
	          },
	          customRender: (value, row, index) => {
	            const obj = {
	              children:"更多>>",
	              attrs: {}
	            }
	            obj.attrs.rowSpan = row.rowSpan;
	            return obj;
	          }
	        }
	      ]

* * *

1. **树形控件<a-tree>中增加删除图标**
效果图如下：
![95dc96e9c878d6d385c2ccb9b05da648995.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173642.png)
具体代码：

	<a-tab-pane class="tab-zzjg" tab="群组列表" key="3">
	  <div class="zzjg-tree">
	    <a-tree checkable @check="selectQz" :checkedKeys="checkedQzKeys" :autoExpandParent="true">
	      <a-tree-node v-for="qzlb in qzlbList" :key="qzlb.xlhQzxx" :ryDm="qzlb.ryDm">
	        <div slot="title" class="qz-title">
	          <span>{{qzlb.qzmc}}</span>
	          <span class="icon-box">
	            <a-icon type="edit" @click="editQzmc(qzlb)"/>
	            <i class="gb" @click="deleteQzBtn(qzlb)"></i>
	          </span>
	        </div>
	      <a-tree-node v-if="qzlb.ryList.length>0" v-for="child in qzlb.ryList" :key="child.ryDm" :ryDm="child.ryDm">
	        <div slot="title" class="qz-title" style="width: 265px;">
	           <span>{{child.ryxm}}</span>
	           <span class="icon-box">
	             <i class="gb" @click="deleteQzBtn(child)"></i>
	           </span>
	        </div>
	      </a-tree-node>
	    </a-tree-node>
	   </a-tree>
	  </div>
	 </a-tab-pane>

以上是两级树形结构（此列结合标签页a-tab-pane使用），其中下面的代码为插入图标的重点：

	<div slot="title" class="qz-title">
	   <span>{{qzlb.qzmc}}</span>
	   <span class="icon-box">
	     <a-icon type="edit" @click="editQzmc(qzlb)"/>
	     <i class="gb" @click="deleteQzBtn(qzlb)"></i>
	   </span>
	</div>

注意：slot="title"，插入图标后，不要在a-tree-node中绑定title属性，否则插入的图标无法出现，刚开始就犯了这个错，给大家提个醒。

* * *

1. **下拉框<a-select>绑定数据后placeholder无法显示的问题**
在GitHub上找到答案如下，实际应用确实可行：
![76daa90a425722300e41602992efb4670dd.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173713.png)
就是把v-modal的初始值设置为undefined。

原因大概是：placeholder是当前组件值为空时显示的替换文本，只有值为空的时候才会显示。当组件绑定了v-model且绑定值初始化时，值不再是空，即时初始化值为’'也视为有值，所以placeholder自然就不会显示。

* * *

1. **表单form**
表单的基本使用：

	<a-form :form="form">
	   <a-form-item>
	      <a-input placeholder="请输入" v-decorator="['fpqksm',{rules:[{required: false}]}]"></a-input>
	   </a-form-item>
	</a-form>

v-decorator用于设置表单的校验规则，[详见](https://www.antdv.com/components/form-cn/#api)
数据绑定：

	data(){
	  return{
	    form: this.$form.createForm(this),
	  }
	},
	methods:{
	  initData(info){//初始化时给表单赋值
	   this.form.setFieldsValue({fpqksm:info.fpqksm})
	  },
	  submit(){//提交表单时
	   this.form.validateFields((err, values) => {
	      if (err){
	        //处理错误
	        return;
	      }
		//这里处理验证成功的逻辑
	    })
	  },
	  editor(item){
	  //有时候点击编辑时，需要给表单赋值
	  //此时直接赋值this.form.setFieldsValue({fpqksm:info.fpqksm})控制台会警示：Warning: You cannot set a form field before rendering a field associated with the value.
	  //解决方法
	    setTimeout(()=>{
	       this.form.setFieldsValue({fpqksm:item.jgmc})
	    },200)
	  }
	}

* * *

后续遇到新的用法再补充。

本文地址：https://my.oschina.net/lcfblogs/blog/3122095

© 著作权归作者所有
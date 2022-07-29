<template>
  <div class="shoppingcar-box">
    <!-- 图标分隔符 -->
    <header>
      <el-breadcrumb style="margin:50px;" separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/shoppingCar' }">购物车</el-breadcrumb-item>
        <el-breadcrumb-item>确认订单</el-breadcrumb-item>
        <el-breadcrumb-item>在线支付</el-breadcrumb-item>
        <el-breadcrumb-item>完成</el-breadcrumb-item>
      </el-breadcrumb>
    </header>

<!--    <div>-->
<!--      {{this.tableData1[0].file01}}-->
<!--    </div>-->

    <el-divider></el-divider>
    <!-- 购物车主体部分-->

    <el-table
      :data="tableData1"
      style="width: 100%;margin-right:50px;border-radius:15px;"
      :row-style="{height: '200px'}"
    >
      <!-- 选择框 -->
      <el-table-column
        width="55"
        prop="isChecked"
      >
        <template
          slot-scope="scope">
          <el-checkbox style="margin-left:30px" v-model="scope.row.isChecked" @change="getTotalPrice(),getTotalSum()" > </el-checkbox>
        </template>
      </el-table-column>
      <!-- 记录选择 -->
      <el-table-column
        label="全选"
        width="120">
      </el-table-column>

      <el-table-column style="background-color:red;"
                       data= 'img'
                       label="商品图片"
                       width="200"
      >
        <template
          slot-scope="scope">
          <el-image style="width:100px;height:90px;" :src="'http://localhost:8080/'+ scope.row.file01.substr(26)"></el-image>
        </template>
      </el-table-column>

      <el-table-column
        prop="name"
        label=""
        width="240">
        <template

          slot-scope="scope">
          <span >{{scope.row.name}}</span>
          <br/>
          <span style="color:#909399">{{scope.row.described}}</span>
        </template>
      </el-table-column>

      <el-table-column
        label="单价(元)"
        width="150"
        prop="price"
      >
        <template
          slot-scope="scope">
          <span>￥{{scope.row.price}}</span>

        </template>
      </el-table-column>

      <el-table-column
        label="数量"
        width="200"
        data="quantity" style="text-align:center">
        <template slot-scope="scope">
          <el-input-number   v-model="scope.row.quantity" :min="1" :max="30" size="mini" @change="getTotalSum(),getTotalPrice()"></el-input-number>
        </template>

      </el-table-column>


      <el-table-column
        label="小计(元)"
        style="font-color:rgb(226, 138, 67);"
        width="180"
        prop="sum">
        <template slot-scope="scope">
          <span style="color:rgb(226, 138, 67);font-family:Arial,Helvetica,sans-serif;">￥{{scope.row.sum = scope.row.price * scope.row.quantity}}</span>
        </template>

      </el-table-column>

      <!-- 删除操作 -->
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button  plain icon="el-icon-delete"
                      @click.native.prevent="deleteRow(scope.$index, tableData1)" circle></el-button>
        </template>
      </el-table-column>
    </el-table>

    <footer>
      <div  class="settlement" >

        <span class="allSelected" ><el-checkbox v-model="allChecked" style="margin-left:30px"  @change="handleCheckAllChange" >全选</el-checkbox></span>
        <span class="noSelected" ><el-checkbox  v-model="noChecked" style="margin-left:30px"  @change="handleCheckNoChange" >全不选</el-checkbox></span>
        <span class="sum" :data="num_Sum" >已选择{{num_Sum}}件商品</span>
        <span><el-button class="btnAccount"  type="primary" size="medium" plain @click="jiesuan()">立即结算</el-button></span>
        <span :data="num_Price" class="total" >总计:￥{{num_Price}}</span>

      </div>
    </footer>


  </div>
</template>

<script>
  export default {
    inject:['reload'],  //注入依赖
    name: "ShoppingCar",
    data() {
      return {
        user:{},
        num_Price:0,
        num_Sum:0,
        allChecked:false,/* 全选框 */
        noChecked:false,
        tableData1:[],
        tableData2:[],
      };
    },
    created() {
      //获取登录信息
      this.user = JSON.parse(window.sessionStorage.getItem("user"));
      this.getShoppingCarInfo();
    },
    methods: {
      deleteRow(index, rows) {
        // alert("index:" + index + "  rows:" + rows);
        // alert("商品id：" + this.tableData[index].id);
        this.deleteCarGoods(this.tableData1[index].id);
        // this.$router.go(0);
        // rows.splice(index, 1);
        // this.getTotalSum();
        // this.getTotalPrice();

      },
      /* 改变商品勾选状态 */
      changeChecked(index, rows){
        /* 取反 */
        rows.isChecked[index]=!rows.isChecked[index];
      },
      /* 计算商品总数 */
      getTotalSum(){
        let sum=0;
        /* 遍历数组，并且获取数组内的数据 */
        this.tableData1.forEach((item,index)=>{
          if(item.isChecked==true){
            sum = item.quantity + sum;
          }
        })
        this.num_Sum=sum;
      },
      handleCheckAllChange(){
        this.tableData1.forEach((item,index)=>{
          if(item.isChecked!=true){
            item.isChecked=true;
          }
        })
        this.allChecked=true;
        this.noChecked=false;
        this.getTotalSum();
        this.getTotalPrice();
      },
      handleCheckNoChange(){
        this.tableData1.forEach((item,index)=>{
          if(item.isChecked=true){
            item.isChecked=false;
          }
        })

        this.allChecked=false;
        this.getTotalSum();
        this.getTotalPrice();
      },
      getTotalPrice(){
        let price=0;
        /* 遍历数组，并且获取数组内的数据 */
        this.tableData1.forEach((item,index)=>{
          if(item.isChecked==true){
            price +=item.quantity * item.price;
          }
        })

        this.num_Price= price.toFixed(2);
      },
      /* 全选  */

      //获取购物车信息
      async getShoppingCarInfo(){
        // alert("发起请求");
        const {data : res} = await this.$http.get('getShoppingCarInfo',{
          params:{
            username:this.user.username,
          }
        });
        if(res.flag == "true"){
          this.tableData1 = res.data;
          // console.log(this.tableData);
          // this.$message.success("获取购物车信息成功");
        }else{
          // this.$message.error("获取信息失败!")
        }
      },
      //结算
      async jiesuan(){
        alert("弹出一个付款码");
        this.$message.success("支付成功");
      },
      //移除商品
      async deleteCarGoods(goodsId){
        const {data : res} = await this.$http.get('deleteGoodsOnShoppingCar',{
          params:{
            goodsid:goodsId,
            username:this.user.username
          }
        });
        if(res.flag == "true"){
          // this.$message.success("删除购物车信息成功");
          this.tableData1 = res.data;
          this.reload();//刷新
        }else{
          this.$message.error("删除失败!")
        }
      },
    },
    mounted(){
      this.getTotalPrice();
      this.getTotalSum();
    }
  };



</script>

<style scoped>
  .settlement{
    width:100%;
    height:80px;
    background:white;
    border-radius:5px;
    margin-top:15px;
    margin-bottom:15px;
  }
  .btnAccount{
    float:right;
    margin-right:20px;
    margin-top:25px;
  }
  .total{
    color:rgb(226, 138, 67);
    float:right;
    margin-top:25px;
    margin-right:50px;
  }
  .allSelected{
    float:left;
    margin-top:25px;
  }
  .noSelected{
    float:left;
    margin-top:25px;

  }
  .sum{
    float:left;
    margin-top:25px;
    margin-left:50px;
    color:#909399;
  }
</style>


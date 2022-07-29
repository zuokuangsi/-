<template>
  <div class="shoppingcar-box">
    <!-- 图标分隔符 -->
    <el-divider></el-divider>
    <!-- 购物车主体部分-->
    <el-table
      :data="tableData"
      style="width: 100%;margin-right:50px;border-radius:15px;"
      :row-style="{height: '120px'}"
    >
      <!-- 选择框 -->
      <el-table-column
        width="55"
        prop= "isChecked"
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
          <el-image style="width:100px;height:90px;" :src="'http://localhost:9080/'+ scope.row.file"></el-image>
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
        data="num" style="text-align:center">
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
          <span style="color:rgb(226, 138, 67);font-family:Arial,Helvetica,sans-serif;">￥{{scope.row.num=scope.row.price * scope.row.quantity}}</span>
        </template>

      </el-table-column>



      <!-- 删除操作 -->
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button  plain icon="el-icon-delete"
                      @click.native.prevent="deleteRow(scope.$index, tableData)" circle></el-button>
        </template>
      </el-table-column>
    </el-table>

    <!--

      <el-table  style="margin-top:20px;">
         <el-table-column label="结算功能">
        </el-table-column>
        <el-table-column></el-table-column>

      </el-table> -->
    <footer>
      <div  class="settlement" >

        <span class="allSelected" ><el-checkbox v-model="allChecked" style="margin-left:30px"  @change="handleCheckAllChange" >全选</el-checkbox></span>
        <span class="noSelected" ><el-checkbox  v-model="noChecked" style="margin-left:30px"  @change="handleCheckNoChange" >全不选</el-checkbox></span>
        <span class="sum" :data="num_Sum" >已选择{{num_Sum}}件商品</span>
        <span><el-button class="btnAccount"  type="primary" size="medium" plain>立即结算</el-button></span>
        <span :data="num_Price" class="total" >总计:￥{{num_Price}}</span>
      </div>
    </footer>
  </div>
</template>

<script>
export default {
  name: "shopping_cart",
  data() {
    return {
      num_Price:0,
      num_Sum:0,
      allChecked:false,/* 全选框 */
      noChecked:false,
      tableData: []
    };
  },
  created() {
    //获取登录信息
    this.user = JSON.parse(window.sessionStorage.getItem("user"));
    this.getShopping();
  },
  methods: {
    async getShopping(){
      const {data : res} = await this.$http.get('shopping',{
        params:{
          username:this.user.username,
        }
      });
      this.tableData=res.list
    },
    deleteRow(index, rows) {
      alert("移除商品");
      rows.splice(index, 1);
      this.getTotalSum();
      this.getTotalPrice();
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
      this.tableData.forEach((item,index)=>{
        if(item.isChecked==true){
          sum = item.quantity + sum;
        }
      })
      this.num_Sum=sum;
    },
    handleCheckAllChange(){
      this.tableData.forEach((item,index)=>{
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
      this.tableData.forEach((item,index)=>{
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
      this.tableData.forEach((item,index)=>{
        if(item.isChecked==true){
          price +=item.quantity * item.price;
        }
      })

      this.num_Price= price.toFixed(2);
    }
    /* 全选  */
  },
  mounted(){
    this.getTotalPrice();
    this.getTotalSum();
  },

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


<!--<template>-->
<!--  <div>-->
<!--    <el-card>-->
<!--        <thead class="thead">-->
<!--        <div class="font t-checkbox"><input type="checkbox" v-model="AllChecked" @change="allCheckChange()"></div>-->
<!--        <div class="font All-choose">全选</div>-->
<!--        <div class="font t-goods">商品</div>-->
<!--        <div class="font t-price">单价</div>-->
<!--        <div class="font t-quantity">数量</div>-->
<!--        <div class="font t-sum">小计</div>-->
<!--        </thead>-->
<!--      <tbody class="shoppingList">-->
<!--      <tr class="item" v-for="(item, index) in items">-->
<!--        <el-divider></el-divider>-->
<!--        <td class="checkbox">-->
<!--          <input type="checkbox" class="itemCheck" v-model="checkArray[index]" @change="checkedGoodsSum()">-->
<!--        </td>-->
<!--        <td class="goods">-->
<!--          <a href="">-->
<!--            <img :src="item.src" class="g-img"></a>-->
<!--          <a href="" class="g-name">{{ item.name }}</a>-->
<!--        </td>-->
<!--        <td class="price">-->
<!--          <p class="g-price">¥{{item.price}}</p>-->
<!--        </td>-->
<!--        <td class="quantity">-->
<!--          <a href="" @click.prevent="item.quantity = decreaseQuantity(item.quantity)">-->
<!--            <img src="../assets/-.png" class="decreas">-->
<!--          </a>-->
<!--          <input type="text" :value="item.quantity" >-->
<!--          <a href="" @click.prevent="item.quantity = increaseQuantity(item.quantity)">-->
<!--            <img src="../assets/+.png" class="increas">-->
<!--          </a>-->
<!--        </td>-->
<!--        <td class="p-sum">-->
<!--          <p class="priceSum">¥{{ item.quantity*item.price }}</p>-->
<!--        </td>-->
<!--        <el-button class="delete" type="danger" icon="el-icon-delete" circle @click="DeleteGoods(index)"></el-button>-->
<!--      </tr>-->
<!--      <el-divider></el-divider>-->
<!--      </tbody>-->
<!--        <div>-->
<!--          已选择<span>{{ checkedGoodsSum()}}</span>件商品-->
<!--          总价：<span>¥{{ checkedPriceSum() }}</span>-->
<!--          <el-button type="primary" round >去结算</el-button>-->
<!--        </div>-->
<!--    </el-card>-->
<!--  </div>-->
<!--</template>-->

<!--<script>-->
<!--export default {-->
<!--  name: "goods",-->
<!--  data() {-->
<!--    return {-->
<!--      checkArray: ['', '', '', '', ''],-->
<!--      AllChecked: false,-->
<!--      checkedItems : [],-->
<!--      items:[-->
<!--         {-->
<!--          name: 'Sony/索尼 WI-SP500 无线防水运动蓝牙耳机 免提通话',-->
<!--          src: '../assets/img.png',-->
<!--          price: '719.21',-->
<!--          quantity: 1-->
<!--        },-->
<!--        {-->
<!--          name: '派克威雅官方商务签字笔男女学生钢笔礼品笔威雅黑色胶杆墨水笔',-->
<!--          src: '../../static/img/pen.jpg',-->
<!--          price: '135.50',-->
<!--          quantity: 1-->
<!--        },-->
<!--        {-->
<!--          name: 'Intel/英特尔酷睿i7 8700k盒装 处理器i7 9700K/KF 8700 电脑CPU',-->
<!--          src: '../../static/img/IntelCPU.jpg',-->
<!--          price: '1599.20',-->
<!--          quantity: 1-->
<!--        },-->
<!--        {-->
<!--          name: '微软 Surface Pro 6 i5 8GB 128GB 12.3英寸 笔记本电脑 平板电脑二合一',-->
<!--          src: '../../static/img/surfacePro.jpg',-->
<!--          price: '8719.00',-->
<!--          quantity: 1-->
<!--        },-->
<!--        {-->
<!--          name: 'Casio卡西欧手表男G-SHOCK未来战士白武士白虎限定男表 GA-400-7A',-->
<!--          src: '../../static/img/watch.jpg',-->
<!--          price: '499.50',-->
<!--          quantity: 1-->
<!--        }-->
<!--      ]-->
<!--    }-->
<!--  },-->
<!--  methods: {-->
<!--    increaseQuantity(num) {-->
<!--      num++;-->
<!--      return num;-->
<!--    },-->
<!--    decreaseQuantity(num) {-->
<!--      if (num <= 1) {-->
<!--        alert("不能在减少啦");-->
<!--      } else {-->
<!--        num&#45;&#45;;-->
<!--      }-->
<!--      return num;-->
<!--    },-->
<!--    allCheckChange() {-->
<!--      this.checkArray.fill(this.AllChecked)-->
<!--    },-->
<!--    checkedGoodsSum() {-->
<!--      let sum = 0;-->
<!--      for (let i = 0; i < this.checkArray.length; i++) {-->
<!--        if (this.checkArray[i] == true) {-->
<!--          sum++;-->
<!--        }-->
<!--      }-->
<!--      return sum;-->
<!--    },-->
<!--    checkedPriceSum(){-->
<!--      let price = 0;-->
<!--      for(let i = 0; i < this.checkArray.length; i++){-->
<!--        if (this.checkArray[i] == true) {-->
<!--          price += this.items[i].price*this.items[i].quantity;-->
<!--        }-->
<!--      }-->
<!--      return price-->
<!--    },-->
<!--    DeleteGoods (i) {-->
<!--      this.items.splice(i,1);-->
<!--      this.checkArray.splice(i,1)-->
<!--    }-->
<!--  }-->
<!--}-->
<!--</script>-->

<!--<style scoped>-->
<!--input[type='checkbox']{-->
<!--  width: 16px;-->
<!--  height: 16px;-->
<!--}-->
<!--.thead{-->
<!--  display: block;-->
<!--  height: 40px;-->
<!--  width: 100%;-->
<!--  background-color: #f5f5f5;-->
<!--  position: relative;-->
<!--  left: 0%;-->
<!--  right: 0%;-->
<!--}-->
<!--.thead .font{-->
<!--  font-family: "微软雅黑";-->
<!--  font-size: 14px;-->
<!--  float: left;-->
<!--}-->
<!--.thead > input{-->
<!--}-->
<!--.thead .t-checkbox{-->
<!--  position: absolute;-->
<!--  left:1.5%;-->
<!--  top: 30%;-->
<!--}-->
<!--.thead .All-choose{-->
<!--  position: absolute;-->
<!--  left:5% ;-->
<!--  top: 30%;-->
<!--}-->
<!--.thead .t-goods{-->
<!--  position: absolute;-->
<!--  left: 20%;-->
<!--  top: 30%;-->
<!--}-->
<!--.thead .t-price{-->
<!--  position: absolute;-->
<!--  left: 40%;-->
<!--  top: 30%;-->
<!--}-->
<!--.thead .t-quantity{-->
<!--  position: absolute;-->
<!--  left: 60%;-->
<!--  top: 30%;-->
<!--}-->
<!--.thead .t-sum{-->
<!--  position: absolute;-->
<!--  left: 80%;-->
<!--  top: 30%;-->
<!--}-->
<!--.shoppingList{-->
<!--  display: block;-->
<!--  width: 100%;-->
<!--  background: #fffefe;-->
<!--  position: relative;-->
<!--  left: 0%;-->
<!--  right: 0%;-->
<!--  border: 1px solid rgb(255, 252, 252);-->
<!--  overflow: hidden;-->
<!--}-->
<!--.item{-->
<!--  display: block;-->
<!--  width: 100%;-->
<!--  height: 120px;-->
<!--  background: #ffffff;-->
<!--  left: 8%;-->
<!--  right: 8%;-->
<!--}-->
<!--.checkbox{-->
<!--  width: 4.5%;-->
<!--  height: 120px;-->
<!--  float: left;-->
<!--}-->
<!--.itemCheck{-->
<!--  margin: 10px;-->
<!--}-->
<!--.goods{-->
<!--  width: 400px;-->
<!--  height: 120px;-->
<!--  float: left;-->
<!--  position: relative;-->
<!--}-->
<!--.goods .g-img{-->
<!--  height: 100px;-->
<!--  width: 100px;-->
<!--  position: absolute;-->
<!--  left: 50px;-->
<!--  top: 17px;-->
<!--  border: .8px solid #e3e4e5 ;-->
<!--}-->
<!--.g-name{-->
<!--  width: 200px;-->
<!--  height: 40px;-->
<!--  display: block;-->
<!--  position: absolute;-->
<!--  top: 16px;-->
<!--  left: 40%;-->
<!--  font-family: "微软雅黑";-->
<!--  font-size: 15px;-->
<!--  line-height: 25px;-->
<!--}-->
<!--.g-name:hover{-->
<!--  color: #b40808;-->
<!--}-->
<!--.price{-->
<!--  width: 300px;-->
<!--  height: 120px;-->
<!--  float: left;-->
<!--  position: relative;-->
<!--}-->
<!--.price .g-price{-->
<!--  position: absolute;-->
<!--  left: 90px;-->
<!--  top: 30px;-->
<!--  font-family: "Microsoft YaHei";-->
<!--  font-size: 14px;-->
<!--}-->
<!--.quantity{-->
<!--  width: 330px;-->
<!--  height: 120px;-->
<!--  float: left;-->
<!--  position: relative;-->
<!--}-->
<!--.quantity .decreas{-->
<!--  width: 25px;-->
<!--  height: 25px;-->
<!--  position: absolute;-->
<!--  left: 50px;-->
<!--  top: 30px;-->
<!--}-->
<!--input[type='text']{-->
<!--  width: 40px;-->
<!--  height: 12px;-->
<!--  position: absolute;-->
<!--  left: 75px;-->
<!--  top: 35px;-->
<!--  text-align: center;-->
<!--}-->
<!--.quantity .increas{-->
<!--  width: 25px;-->
<!--  height: 25px;-->
<!--  position: absolute;-->
<!--  left: 125px;-->
<!--  top: 30px;-->
<!--}-->
<!--.p-sum{-->
<!--  width: 150px;-->
<!--  height: 120px;-->
<!--  float: left;-->
<!--  position: relative;-->
<!--}-->
<!--.p-sum .priceSum{-->
<!--  position: absolute;-->
<!--  left: 20px;-->
<!--  top: 30px;-->
<!--  font-family: "Microsoft YaHei";-->
<!--  font-size: 14px;-->
<!--}-->
<!--.delete {-->
<!--  margin-top:30px;-->
<!--}-->

<!--</style>-->

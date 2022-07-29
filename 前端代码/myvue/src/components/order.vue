
  <template>
    <div style="margin-left: 400px">

      <el-card style="text-align: center;width: 60%;height:auto">
        <el-page-header @back="goBack" content="商品订单"></el-page-header>
        <div >
          <p class="index-body-p-1"> <font face="宋体" size="5">订单号：1165200{{goods.id}}</font></p>
      </div>
        <img  class="tup" :src="'http://localhost:9080/' +goods.file">
        <div>
          <el-descriptions class="margin-top"  :column="3"  border style="width: 100%">

            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-name"></i>
                名字：
              </template>
              {{this.goods.name}}
            </el-descriptions-item>

            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-price"></i>
                价格:
              </template>
              {{this.goods.price}}
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-price"></i>
                数量:
              </template>
              {{1}}
            </el-descriptions-item>
            <el-descriptions-item>
              <template slot="label">
                <i class="el-icon-described"></i>
                描述：
              </template>
              {{this.goods.described}}
            </el-descriptions-item>
          </el-descriptions>
        </div><br/>
        <h2>￥<font color="red" >{{goods.price}}</font></h2>
        <div>

        <el-button @click="pay" type="danger" style="width: 400px">立即支付</el-button>
          <transition name="el-fade-in-linear">
          <div v-show="this.show" class="pay-code">
            <img src="../assets/wechat.jpg" width="250px" height="auto">
          </div></transition>
    </div>

      </el-card>
    </div>
</template>

<script>
export default {
  name: "order",
  data(){
    return{
      show:false,
goods:{},
    }
  },
  created() {
    this.getParams();
  },
  methods:{
    goBack(){
      this.$router.push({path:"spike"})
    },
    getParams() {
      var ar = decodeURIComponent(this.$route.params.message);
      // 取到路由带过来的参数
      this.goods = JSON.parse(ar);
    },
    pay(){

      this.show=!this.show; console.log(this.show);
    }
  }
}
</script>
  <style >
  .index-body-p-1{
    font-weight: bold;
    font-size: 30px;
    color: black;
    margin-top: 0px;
  }
.tup{
  height: 200px;
  width: 170px;
  background-color: #78cdd1;
}
.pay-code{
  width: 40vw;
  margin-top: 50px;
}
  </style>

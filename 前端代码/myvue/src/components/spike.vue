<template>
  <div>
 <p class="index-body-p-1"><font color="black" face="宋体" size="6">今日秒杀</font></p><hr/>
    <countdown :endTime='endTime'></countdown>
    <div  id="box">
      <ul>
        <li v-for="(goods,index) in list" :key="index" style="margin-left:30px">
          <el-card  style="width: 280px;height: 450px" >
            <img @click="test01(goods)" :src="'http://localhost:9080/' +goods.file">
            {{goods.name}}<br/><br/>
            秒杀价：<font color="red" size="5">￥{{goods.price}}</font>
            <el-progress :text-inside="true" :stroke-width="15" :percentage="100" status="exception">></el-progress><br>
            <el-button @click="pay(goods)" type="danger" style="margin-left:150px;top:400px"><font>立即抢购</font></el-button>
<!--            <img @click="pay(goods)" src="../assets/img_11.png"  style="height:40px;width:80px;float: right;margin-top: 40px"  >-->
          </el-card>
          <el-dialog :visible.sync="centerDialogVisible" width="40%" center >
            <div>
              <el-page-header @back="goBack" content="详情页面"></el-page-header>
              <el-divider ></el-divider>
              <div class="singleGoods" >
                <!-- 商品图片走马灯 -->
                <div class="block" style="width:40%;margin-left: 25%;text-align: center;">
                  <el-carousel>
                    <el-carousel-item v-for="item in imgs" :key="item">
                      <el-image
                        :src="item"
                      ></el-image>
                    </el-carousel-item>
                  </el-carousel>
                </div>
                <!-- 商品信息区域 -->
                <div style="margin-top:15px;">
                  <div  style="color:#303133;font-size:18px;margin-top:15px;">
                    【{{goodss.name}}】
                  </div>
                  <div  style="color:#9e1909; font-size:30px;margin-top:30px; ">价格:￥{{goodss.price}}</div>
                  <div style="color:#909399;margin-top:10px;white-space:pre-wrap;">
                    商品描述: {{goodss.described}}
                  </div>
                  <div style="color:#909399;white-space:pre-wrap;">
                    剩余数量:<font color="red"> 1</font>
                  </div><br>
                  <el-button type="danger" plain icon="el-icon-goods">立即抢购
                  </el-button>
                </div>
              </div>
              <el-divider></el-divider>
              <div style="color:grey;margin-left:40px;">评论区域</div>
            </div>
            <span slot="footer" class="dialog-footer">
      <el-button type="primary" @click="centerDialogVisible = false">确 定</el-button>
    <el-button @click="centerDialogVisible = false">取 消</el-button>
  </span>
          </el-dialog>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import a1 from "./a1";

export default {
  name: "spike",
  data(){
    return{
      list:{},
      goodss:{},
      imgs:[],
      centerDialogVisible: false,
      endTime : '2021-12-11 11:59:00',
      message:"",
    }
  },
  components:{
    'countdown': a1},
  created() {
    this.user = JSON.parse(window.sessionStorage.getItem("user"));
    this.get_spickGoods();
  },
  methods:{
    goBack() {/* 返回上一个历史界面 */
      this.centerDialogVisible = false;
    },
    //秒杀抢购
   async pay(goods){
      const {data: res} = await this.$http.get('/get2', {
        params: {
          id:goods.id
        }
      });
      this.message = JSON.stringify(res.list);
      this.$router.push({
        name: "order",
        params: {
          message: encodeURIComponent(this.message)
        },
      });
    },
    //test01
    async test01(goods) {
      this.centerDialogVisible = true;
      this.goodss = goods;
      // alert("商品信息:" + goods);
      if (goods.file) {
        this.imgs[0] = 'http://localhost:9080/' + goods.file;
      }
    },
    async get_spickGoods() {
      const {data: res} = await this.$http.get('/get1');
      if (res.flag == "true") {
        // this.$message.success("获取成功！");
        this.list = res.list;

        // this.$message.success("获取成功！");
      } else {
        this.$message.error("获取失败!")
      }
    },
  }
}
</script>

<style scoped>
.el-carousel__item h3 {
  color: #fcfdfd;
  font-size: 18px;
  opacity: 0.75;
  line-height: 300px;
  margin: 0;
}
.el-carousel__item:nth-child(2n) {
  background-color: #ffffff;
}
.el-carousel__item:nth-child(2n+1) {
  background-color: white;
}
.bottom {
  margin-top: 13px;
  line-height: 20px;
}
.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both
}
#box ul{
  display: flex;
  flex-wrap: wrap;
}
#box li{
  padding: 8px;
  list-style: none;
  margin-right: 5px;
  border: 2px solid #e3f1f5;
}
#box img{
  width: 230px;
  height: 260px;
}
</style>

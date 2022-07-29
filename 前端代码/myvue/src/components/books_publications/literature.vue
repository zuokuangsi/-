<template>
  <div  id="box">
    <ul>
      <li v-for="(goods,index) in list" :key="index" style="margin-left:30px">
        <el-card style="width: 280px;height: 400px" >
          <img @click="test01(goods)" :src="'http://localhost:9080/' +goods.file01">
          <h4>{{goods.name}}</h4>
          <p style="color: firebrick;"><font size="4">¥{{goods.price}}</font></p>
        </el-card>
        <el-dialog :visible.sync="centerDialogVisible" width="50%" center>
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

                <div style="color:#303133;font-size:16px;margin-top:25px;">
                  商品标签 : {{goodss.label}}
                </div>
                <div style="color:#909399;margin-top:10px;white-space:pre-wrap;">
                  细节描述: {{goodss.described}}
                </div>

                <el-button type="warning" plain icon="el-icon-goods">立即购买
                </el-button>
                <el-button type="warning" plain  icon="el-icon-shopping-cart-2" @click="shopping">加入购物车
                </el-button>
                <el-button type="warning" plain icon="el-icon-star-off" @click="collect">收藏</el-button>
              </div>
            </div>
            <el-divider></el-divider>
            <div style="color:grey;margin-left:40px;">评论区域</div>

            <div style="width:80%;height:200px"></div>
          </div>

          <span slot="footer" class="dialog-footer">
      <el-button type="primary" @click="centerDialogVisible = false">确 定</el-button>
    <el-button @click="centerDialogVisible = false">取 消</el-button>
  </span>
        </el-dialog>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "other_books",
  data() {
    return {
      list:[],
      imgs: [],
      goodss:{},
      centerDialogVisible: false,
    }
  },
  created() {
    this.user = JSON.parse(window.sessionStorage.getItem("user"));
    this.getParams();
  },
  methods: {
    goBack() {/* 返回上一个历史界面 */
      this.centerDialogVisible = false;
    },
    getParams() {
      var ar = decodeURIComponent(this.$route.params.message);
      // 取到路由带过来的参数
      this.list = JSON.parse(ar);
    },
    //test01
    async test01(goods) {
      this.centerDialogVisible = true;
      this.goodss = goods;
      // alert("商品信息:" + goods);
      if (goods.file01) {
        this.imgs[0] = 'http://localhost:9080/' + goods.file01;
      }
      if (goods.file02) {
        this.imgs[1] = 'http://localhost:9080/' + goods.file02;
      }
      if (goods.file03) {
        this.imgs[2] = 'http://localhost:9080/' + goods.file03;
      }
      if (goods.file04) {
        this.imgs[3] = 'http://localhost:9080/' + goods.file04;
      }
      const {data: res} = await this.$http.get('/history', {
        params: {
          id: this.goodss.id,
          username: this.user.username
        }
      });
    },
    async getAllGoods() {
      const {data: res} = await this.$http.get('/main');
      if (res.flag == "true") {
        // this.$message.success("获取成功！");
        this.list = res.list;

        // this.$message.success("获取成功！");
      } else {
        this.$message.error("获取失败!")
      }
    },
    //加入收藏
    async collect() {
      if (this.user == null) {
        // alert("您还未登入,不可进行该操作，请先登入");
        this.$alert('您还未登入,不可进行该操作，请先登入', '提醒', {
          confirmButtonText: '确定',
        })
        // await this.$router.push({path: "/login"});
      }
      const {data: res} = await this.$http.get('/get_collect', {
        params: {
          username: this.user.username,
          id: this.goodss.id
        }
      });
      if (res.flag == "true")
        this.$message.success("已收藏");
    },
    // 加入购物车
    async shopping() {
      if (this.user == null) {
        // alert("您还未登入,不可进行该操作，请先登入");
        this.$alert('您还未登入,不可进行该操作，请先登入', '提醒', {
          confirmButtonText: '确定',
        })
        // await this.$router.push({path: "/login"});
      }
      const {data: res} = await this.$http.get('/collect', {
        params: {
          username: this.user.username,
          goodsID: this.goodss.id
        }
      });
      if (res.flag == "true")
        this.$message.success("加入购物车成功");
    }
  }}
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
  background-color: #f3f3f3;
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

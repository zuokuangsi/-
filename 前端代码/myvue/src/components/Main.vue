<template>
  <div>
    <div class="pmd">
  <el-row style="margin-top: 0px;">
    <el-carousel direction="horizontal" :autoplay="true" height="400px">
      <el-carousel-item v-for="(v,k) in items" :key="k">
        <img :src="v" alt="请检查网络连接" width="100%">
      </el-carousel-item>
    </el-carousel>
  </el-row>
    </div>
  <el-row style="position: relative;top:40px;">
    <el-col :span="5" :offset="16">
      <el-input
        placeholder="输入商品名"
        v-model="search"
        clearable>
      </el-input>
    </el-col>
    <el-col :span="2">
      <el-button type="primary" icon="el-icon-search" @click="search_for">搜索</el-button>
    </el-col>
  </el-row>

    <p class="index-body-p-1"><font color="black" face="宋体">限时秒杀</font></p><hr/>
      <countdown :endTime='endTime'></countdown>
<!--    倒计时-->
    <div>
      <el-row style="margin-left: 30px" >
        <el-col :span="6">
        <el-carousel direction="horizontal" :autoplay="true" style="width: 300px;"height="400px">
          <el-carousel-item v-for="(v,k) in item1" :key="k">
            <img :src="v" alt="请检查网络连接" width="100%" @click="miaosha">
          </el-carousel-item>
        </el-carousel></el-col>
        <el-col :span="6">
        <el-carousel direction="horizontal" :autoplay="true" style="width: 300px;"height="400px">
          <el-carousel-item v-for="(v,k) in item2" :key="k">
            <img :src="v" alt="请检查网络连接" width="100%"  @click="miaosha">
          </el-carousel-item>
        </el-carousel></el-col>
        <el-col :span="6">
        <el-carousel direction="horizontal" :autoplay="true" style="width: 300px;"height="400px">
          <el-carousel-item v-for="(v,k) in item3" :key="k"  @click="miaosha">
            <img :src="v" alt="请检查网络连接" width="100%">
          </el-carousel-item>
        </el-carousel></el-col>
        <el-col :span="6">
        <el-carousel direction="horizontal" :autoplay="true" style="width: 300px;"height="400px">
          <el-carousel-item v-for="(v,k) in item4" :key="k"  @click="miaosha">
            <img :src="v" alt="请检查网络连接" width="100%">
          </el-carousel-item>
        </el-carousel></el-col>
      </el-row>
    </div>


<br/>
    <el-row>
    <el-col :span="5" :offset="19">
    <el-cascader
      v-model="value"
      :options="options"
      @change="handleChange"
      style="float: left"></el-cascader>
      </el-col>
    </el-row>
    <p class="index-body-p-1"><font color="black" face="宋体">推荐好物</font></p>
  <hr/>
<!--  商品图-->
  <div  id="box" >
    <ul >
      <li v-for="(goods,index) in list" :key="index" style="margin-left:30px">
        <el-card style="width: 280px;height: 400px" >
          <img @click="test01(goods)" :src="'http://localhost:9080/' +goods.file01">
          <h4>{{goods.name}}</h4>
          <p style="color: firebrick;"><font size="4">¥{{goods.price}}</font></p>
        </el-card>
  <el-dialog :visible.sync="centerDialogVisible" width="45%" center>
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
            卖家账号 : {{goodss.username}}
          </div>
          <div style="color:#303133;font-size:16px;margin-top:25px;">
            商品标签 : {{goodss.label}}
          </div>
          <div style="color:#909399;margin-top:10px;white-space:pre-wrap;">
            细节描述: {{goodss.described}}
          </div>

          <el-button type="warning" plain icon="el-icon-goods" @click="go_buy(goodss)">立即购买
          </el-button>
          <el-button type="warning" plain  icon="el-icon-shopping-cart-2" @click="shopping">加入购物车
          </el-button>
          <el-button type="warning" plain icon="el-icon-star-off" @click="collect">收藏</el-button>
          <el-button type="warning" plain icon="el-icon-phone" @click="calling">联系卖家</el-button>
        </div>
      </div>
      <el-divider></el-divider>
      <div style="color:grey;margin-left:40px;">评论区域

      <div class="diva">
        <div class="box">
          <hr />
          <div class="comment">
            <div class="input-text">
              <div>
                <i class="el-icon-s-custom"></i>
<!--                {{user.username}}:-->
              </div>
              <el-input type="textarea" :rows="3" placeholder="请输入评论" v-model="inputtext"></el-input>
            </div>
            <div class="input-btn">
              <el-button type="primary" size="medium" @click="InsertComment(inputtext)" plain>评论</el-button>
            </div>
          </div>
        </div>

        <div class="comment-info">
          <hr />
          <!-- 一级评论 -->
          <div class="comment-area">
            <div class="comment-left" v-for="(firsts,index) in context">
              <i class="el-icon-s-custom"></i>
              {{firsts.username}}:
              {{firsts.content}}
              <div>
                {{firsts.comment_time}}
                <el-button type="text" size="medium" @click="deleteRelpy(firsts.id)"><font color="red">删除</font></el-button>
                <div class="int-box">
                  <el-button slot="reference" @click="open(index)" type="text">评论</el-button>
                  <div>
                    <transition name="el-fade-in-linear">
                      <div v-show="shows[index]" class="transition-box">
                        <el-input type="textarea" :rows="3" placeholder="请输入评论" v-model="puttext"></el-input>
                        <el-button
                          slot="reference"
                          @click="inserttex(puttext,firsts.id,index)"
                          type="text"
                        >提交评论</el-button>
                      </div>
                    </transition>
                  </div>
                </div>
              </div>
              <!-- 二级评论 -->
              <div class="second">
                <div class="second-box" v-for="item in  firsts.commentList">
                  <i class="el-icon-s-custom"></i>
                  {{item.username}}：{{item.content}}
                  <div>
                    {{item.comment_time}}
                    <el-button type="text" size="medium" @click="deleteSecRelpy(item.id)">
                      <font color="red">删除</font>
                    </el-button>
                    <!-- <el-button type="text" size="medium" @click="replythird(item)">评论</el-button> -->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      </div>
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
import a1 from '../components/a1'   //  引入倒计时
export default {
  name: "Main",
  data: function () {
    return {
      value: [],
      options: [{
        value: '1',
        label: '按价格从低到高排序',
      },{
        value: '2',
        label: '按价格从高到低排序',
      },{
        value: '3',
        label: '按时间先后顺序排序',
      }],
      // 主页走马灯
      items: {
        img1: require("../assets/img_2.png"),
        img2: require("../assets/img_1.png"),
      },
       item1: {
         img1: require("../assets/img_3.png"),
         img2: require("../assets/a1.jpg"),
         img3: require("../assets/a2.jpg"),
       },
      item2: {
         img1: require("../assets/img_4.png"),
         img2: require("../assets/img_5.png"),
         img3: require("../assets/img_6.png"),
       },
      item3: {
         img1: require("../assets/img_7.png"),
         img2: require("../assets/img_8.png"),
       },
      item4: {
         img1: require("../assets/img_9.png"),
         img2: require("../assets/img_10.png"),
       },
      //对话框商品对象
      list:{},
      goodss:{},
      imgs:[],
      centerDialogVisible: false,
      search:'',
      message:'',
      endTime : '2021-12-11 11:59:00',
      visible: false,
      puttext: "",
      inputtext: "",
      context: [],
      secondtext: [],
      thirdtext: [],
      user: {},
      goodid: 1,
      shows: [],
      show: false,

    }
  },
  components:{
    'countdown': a1
  },
    created() {
    this.user = JSON.parse(window.sessionStorage.getItem("user"));
    this.getAllGoods();
      this.QueryComment();
  },
  methods: {
    calling(){
      this.$router.push({path:"MessageInfo"})
    },

miaosha(){  //秒杀商城

  this.$router.push({path: "/spike"});
},
    //排序
   async handleChange(value) {
      if(value==1){
        const {data: res} = await this.$http.post('/sort')
        this.list = res.list;
      }
      else if(value==2){
        const {data: res} = await this.$http.post('/sort1')
        this.list = res.list;
      }
      else if(value==3){
        const {data: res} = await this.$http.post('/sort2')
        this.list = res.list;
      }
    },
    goBack() {/* 返回上一个历史界面 */
      this.centerDialogVisible = false;
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
      if(res.flag=="true"){
        this.context=res.comments;
      }
    },
      async getAllGoods() {
        const {data: res} = await this.$http.get('/main');
        if (res.flag == "true") {
          // this.$message.success("获取成功！");
          this.list = res.list;
          this.total= res.count;
          // this.$message.success("获取成功！");
        } else {
          this.$message.error("获取失败!")
        }
      },
      //加入收藏
      async collect() {
        if (this.user == null) {
          // alert("您还未登入,不可进行该操作，请先登入");
          this.$message.error('您还未登入,不可进行该操作，请先登入')
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
          this.$message.error('您还未登入,不可进行该操作，请先登入', '提醒', {
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
        else
          this.$message.success("已在购物车中");
      },
      async search_for() {
        const {data: res} = await this.$http.get('/select1', {
          params: {
            text: this.search
          }
        });
        this.message = JSON.stringify(res.list);
        this.$router.push({
          name: "text",
          params: {
            message: encodeURIComponent(this.message)
          },
        });
      },

    open(index) {
      // this.shows[index] = !this.shows[index];
      this.$set(this.shows, index, !this.shows[index]);
    },
    //查询所有评论
    async QueryComment() {
      const { data: res } = await this.$http.post("/allComments", {
        goodsid: this.goodss.id
      });
      if (res.flag != 200) {
        console.log("获取用户信息失败");
      }
      for (let index in res.comments) {
        this.shows.push(false);
      }
      this.context = res.comments;
    },
    // 增加评论
    async InsertComment(inputtext) {
      // 评论时，向后端传递评论人（username），商品id，评论内容，
      const { data: res } = await this.$http.post("comments", {
        username: this.user.username,
        goodsid: this.goodss.id,
        context: inputtext
      });
      if (res.flag == 409) {
        this.$message.error("评论失败！");
      }
      this.inputtext = "";
      this.QueryComment();
    },
    // 回复:评论人，评论内容，被评论id，
    async inserttex(puttext, firsts, index) {
      if (this.puttext) {
        const { data: res } = await this.$http.post("/replytext", {
          username: this.user.username,
          first: firsts,
          context: puttext
        });
        if (res.flag == 409) {
          this.$message.error("评论失败！");
        }
      }
      this.show = false;
      this.$set(this.shows, index, !this.shows[index]);
      this.puttext = "";
      this.QueryComment();
    },
    // 删除一级评论及其二级评论
    deleteRelpy(data) {
      this.$confirm("确定要删除此评论吗？", "提示", {
        type: "warning"
      })
        .then(() => {
          this.$http.post("/deletereply", { data: data }).then(res => {
            if (res.data.flag != 200) {
              this.$message.error("删除失败！");
            } else {
              this.$message.success("删除成功！");
              this.centerDialogVisible = false;
              this.centerDialogVisible = true;
              this.QueryComment();
            }
          });
        })
        .catch(() => {});

    },
    //删除二级评论,根据id删除
    deleteSecRelpy(data) {
      this.$confirm("确定要删除此评论吗？", "提示", {
        type: "warning"
      })
        .then(() => {
          this.$http.post("/deletesecreply", { data: data }).then(res => {
            if (res.data.flag != 200) {
              this.$message.error("删除失败！");
            } else {
              this.$message.success("删除成功！");
              this.QueryComment();
            }
          });
        })
        .catch(() => {});
    }
  }
  }
</script>

<style  scoped>
.pmd{
  width: 70%;
  margin-left:200px;
}
.el-carousel__item h3 {
  color: #fcfdfd;
  font-size: 18px;
  opacity: 0.75;
  line-height: 300px;
  margin: 0;
}
.el-carousel__item:nth-child(2n) {
  background-color: #fcfffc;
}
.el-carousel__item:nth-child(2n+1) {
  background-color: #f6f6f6;
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
.block{
  margin-left: 280px;
  width: 60%;
}
.index-body-p-1{
  font-weight: bold;
  font-size: 30px;
  color: black;
  margin-top: 0px;
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
/*//.diva {*/
/*//  height: 100%;*/
/*//.box {*/
/*//  position: relative;*/
/*//  top: 17px;*/
/*//  width: 80vw;*/
/*//  height: 20vh;*/
/*//.comment {*/
/*//  position: absolute;*/
/*//  left: 15px;*/
/*//*/
/*//.input-text {*/
/*//  color: rgb(0, 0, 0);*/
/*//  display: inline-block;*/
/*//  width: 50vw;*/
/*//}*/
/*//.input-btn {*/
/*//  position: absolute;*/
/*//  display: inline-block;*/
/*//  left: 50.5vw;*/
/*//  top: 30px;*/
/*//}*/
/*//}*/
/*//}*/
/*//.comment-info {*/
/*//  position: relative;*/
/*//  top: 21px;*/
/*//  width: 80vw;*/
/*//.comment-area {*/
/*//  position: absolute;*/
/*//  top: 17px;*/
/*//  left: 15px;*/
/*//  height: 100%;*/
/*//.comment-left {*/
/*//  margin: 10px;*/
/*//  width: 70vw;*/
.int-box {
  display: inline;}
/*//.transition-box {*/
/*//  width: 50vw;*/
/*//}*/
/*//}*/
.second {
 width: 500px;
  }
.second-box {
 margin: 10px;
  margin-left: 20px;
  background-color: rgb(190, 219, 219);
}
/*//.third {*/
/*//  width: 65vw;*/
/*//.third-box {*/
/*//  margin: 10px;*/
/*//  margin-left: 30px;*/
/*//  background-color: rgb(225, 250, 252);*/
/*//}*/
/*//}*/
/*//}*/
/*//}*/
/*//}*/
/*//}*/
/*//}*/
</style>

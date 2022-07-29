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
            <div style="color:grey;margin-left:40px;">评论区域
              <div class="diva">
                <div class="box">
                  <hr />
                  <div class="comment">
                    <div class="input-text">
                      <div>
                        <i class="el-icon-s-custom"></i>
                        {{user.username}}:
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
                        <el-button type="text" size="medium" @click="deleteRelpy(firsts.id)">删除</el-button>
                        <!-- <el-button type="text" size="medium" slot="reference" @click="reply(firsts)">评论</el-button> -->
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
      visible: false,
      puttext: "",
      inputtext: "",
      context: [],
      secondtext: [],
      thirdtext: [],
      user: {},
      goodid: 1,
      shows: [],
      show: false
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
    },
    open(index) {
      // this.shows[index] = !this.shows[index];
      this.$set(this.shows, index, !this.shows[index]);
    },
    // 查询所有评论
    async QueryComment() {
      const { data: res } = await this.$http.post("/allComments", {
        goodsid: 1
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
        goodsid: 1,
        context: inputtext
      });
      if (res.flag == 409) {
        this.$message.success("评论失败！");
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
          this.$message.success("评论失败！");
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
              this.$message.success("删除失败！");
            } else {
              this.$message.success("删除成功！");
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
              this.$message.success("删除失败！");
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



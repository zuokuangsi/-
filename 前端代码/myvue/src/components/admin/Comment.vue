<template>
  <div class="container">
    <div class="diva">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>用户功能</el-breadcrumb-item>
        <el-breadcrumb-item>评论</el-breadcrumb-item>
      </el-breadcrumb>
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
                <!-- 三级评论 -->
                <!-- <div class="third">
                  <div class="third-box" v-for="aa in item.thirdtext">
                    {{aa.username}}：{{aa.content}}
                    <div>
                      {{aa.comment_time}}
                      <el-button type="text" size="medium" @click="reply(aa)">评论</el-button>
                    </div>
                  </div>
                </div>-->
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  data() {
    return {
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
    };
  },
  created() {
    this.user = JSON.parse(window.sessionStorage.getItem("user"));
    this.QueryComment();
  },
  methods: {
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
};
</script>

<style lang="less">
.container {
  height: 300px;
  .diva {
    height: 100%;
    .box {
      position: relative;
      top: 17px;
      width: 80vw;
      height: 20vh;
      .comment {
        position: absolute;
        left: 15px;

        .input-text {
          color: rgb(0, 0, 0);
          display: inline-block;
          width: 50vw;
        }
        .input-btn {
          position: absolute;
          display: inline-block;
          left: 50.5vw;
          top: 30px;
        }
      }
    }
    .comment-info {
      position: relative;
      top: 21px;
      width: 80vw;
      .comment-area {
        position: absolute;
        top: 17px;
        left: 15px;
        height: 100%;
        .comment-left {
          margin: 10px;
          width: 70vw;
          .int-box {
            display: inline;
            .transition-box {
              width: 50vw;
            }
          }
          .second {
            width: 70vw;
            .second-box {
              margin: 10px;
              margin-left: 20px;
              background-color: rgb(190, 219, 219);
            }
            .third {
              width: 65vw;
              .third-box {
                margin: 10px;
                margin-left: 30px;
                background-color: rgb(225, 250, 252);
              }
            }
          }
        }
      }
    }
  }
}
</style>
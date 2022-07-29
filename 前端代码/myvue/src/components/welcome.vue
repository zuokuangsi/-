<template>
  <div class="welcome">
    <!--导航栏-->
    <el-container>
    <el-header>
<!--商品分类-->
      <div>
          <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" >
            <el-menu-item index="1"@click="a1" >平台首页</el-menu-item>
            <el-menu-item index="2"@click="a2" >二手秒杀</el-menu-item>
            <el-submenu index="3">
              <template slot="title">电子产品</template>
              <el-menu-item index="2-1" @click="search_for01">电脑</el-menu-item>
              <el-menu-item index="2-2" @click="search_for02">手机</el-menu-item>
              <el-menu-item index="2-3" @click="search_for03">其他电子产品</el-menu-item>
            </el-submenu>
            <el-submenu index="4">
              <template slot="title">生活用品</template>
              <el-menu-item index="3-1"@click="search_for04">衣物穿着</el-menu-item>
              <el-menu-item index="3-2"@click="search_for05">家具类</el-menu-item>
              <el-menu-item index="3-3"@click="search_for06">其他生活用品</el-menu-item>
            </el-submenu>
            <el-submenu index="5">
              <template slot="title">娱乐手办</template>
              <el-menu-item index="4-1"@click="search_for07">手办</el-menu-item>
              <el-menu-item index="4-2"@click="search_for08">饰品</el-menu-item>
              <el-menu-item index="4-3"@click="search_for09">其他娱乐手办</el-menu-item>
            </el-submenu>
            <el-submenu index="6">
              <template slot="title">书籍刊物</template>
              <el-menu-item index="5-1"@click="search_for10">小说</el-menu-item>
              <el-menu-item index="5-2"@click="search_for11">文学艺术</el-menu-item>
              <el-menu-item index="5-3"@click="search_for12">编程用书</el-menu-item>
              <el-menu-item index="5-4"@click="search_for13">其他书籍</el-menu-item>
            </el-submenu>
            <el-menu-item style="float: right"><el-button type="text" icon="el-icon-switch-button" @click="logout"></el-button></el-menu-item>
            <el-menu-item style="float: right">
              <div class="block"><el-avatar :size="35" :src="img" ></el-avatar></div>
            </el-menu-item>
            <el-menu-item style="float: right"><el-button type="text" icon="el-icon-coin"@click="DLU3"><font color="gray">闲置卖钱</font></el-button></el-menu-item>
            <el-menu-item style="float: right"><el-button type="text" icon="el-icon-user" @click="DLU2"><font color="gray">个人中心</font></el-button></el-menu-item>
            <el-menu-item style="float: right"><el-button type="text" icon="el-icon-shopping-cart-2" @click="DLU1"><font color="gray">我的购物车</font></el-button></el-menu-item>
            <el-menu-item style="float: right"><el-button type="text"  @click="DLU" ><font color="gray">登入注册</font></el-button></el-menu-item>
          </el-menu>
      </div>
        </el-header>
        <el-main>
          <router-view></router-view>
        </el-main>
    </el-container>
  </div>
</template>
<script>
export default {
  data: function () {
    return {
      activeIndex: '1',
      message:{},
      dialogVisible: false,
      img:"",
    }
  },
  created() {
    this.user= JSON.parse(window.sessionStorage.getItem("user"));
    this.get_img();
  },
  methods: {
    a1(){
      this.$router.push({ path: "main" });
    },
    a2(){
      this.$router.push({ path: "spike" });
    },
    //安全退出
    logout() {
      if(this.user){
      window.sessionStorage.clear(); //清除session
      this.$message.success("退出账号成功")
      this.$router.push("/welcome");
      }
    },
    //鼠标悬停
    enter(){
this.$message("退出账号")
    },
    //获取头像
    async get_img(){
      const {data : res} = await this.$http.get('get_img',{
        params:{
          username:this.user.username,
        },
      });
      this.img='http://localhost:9080/' +res.Img;
    },

    DLU(){
      this.$router.push({ path: "login" });
    },

    DLU1(){
      if(this.user==null){
        // alert("您还未登入,不可进行该操作，请先登入");
        this.$message.error('您还未登入,不可进行该操作，请先登入', '提醒', {
          confirmButtonText: '确定',
        })
      }else
      this.$router.push({ path: "shopping" });
    },

    DLU2(){
      if(this.user==null){
        // alert("您还未登入,不可进行该操作，请先登入");
        this.$message.error('您还未登入,不可进行该操作，请先登入', '提醒', {
          confirmButtonText: '确定',
        })
      }else
       this.$router.push({ path: "personal" });

    },
    DLU3(){
      if(this.user==null){
        // alert("您还未登入,不可进行该操作，请先登入");
        this.$message.error('您还未登入,不可进行该操作，请先登入', '提醒', {
          confirmButtonText: '确定',
        })
      }
      else
      this.$router.push({ path: "publish_goods" });
    },
    async search_for01(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'电脑',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "computer",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },
    async search_for02(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'手机',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "cellphone",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },
    async search_for03(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'其他电子产品',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "other3",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },async search_for04(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'衣物穿着',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "clothing",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },async search_for05(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'家具类',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "furniture",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },async search_for06(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'其他生活物品',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "other2",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },async search_for07(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'手办',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "figure",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },async search_for08(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'饰品',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "accessories",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },async search_for09(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'其他娱乐手办',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "other4",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },async search_for10(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'小说',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "novel",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },async search_for11(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'文学艺术',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "literature",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },async search_for12(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'编程书籍',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "programming",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },async search_for13(){
      const {data : res} = await this.$http.get('/select',{
        params:{
          text:'其他书籍',
        },
          });
      this.message=JSON.stringify(res.list);
      this.$router.push({
            name: "other1",
              params:{
              message:encodeURIComponent(this.message)
        }
      });
    },
  }

};
</script>
<style lang="less" scoped>
  .el-header{
    background-color: #ffffff;
  }
.el-main {
  background-color: #e3f1f5;
  text-align: center;
  height:675px;
}
</style>

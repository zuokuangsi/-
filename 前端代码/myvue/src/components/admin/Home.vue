<template>
  <el-container class="home_container">
    <!-- 头部 -->
    <el-header>
      <div>
        <img src="static/logo.webp" :to="{ path: '/home' }" alt />
        <span>校园二手交易平台管理系统</span>
      </div>
      <el-button type="primary" @click="gologin" style="float: left">进入二手商城</el-button>
      <el-button type="primary" @click="logout">安全退出</el-button>

    </el-header>
    <!-- 主体 -->
    <el-container>
      <!-- 侧边栏 -->
      <el-aside :width="isCollapse ? '64px' : '200px'" style="height: 700px">
        <div class="toggle-button" @click="toggleCollapse">|||</div>
        <el-menu
          background-color="#78cdd1"
          text-color="#fff"
          active-text-color="#2a5caa"
          unique-opened
          :collapse="isCollapse"
          :collapse-transition="false"
          :router="true"
          :default-active="activePath"
        >
          <!-- 一级菜单 -->
          <el-submenu
            :index="item.id + ''"
            v-for="item in menuList"
            :key="item.id"
            background-color="#afdfe4"
          >
            <template slot="title">
              <i class="el-icon-location"></i>
              <span>{{ item.title }}</span>
            </template>
            <!-- 二级菜单 -->
            <el-menu-item
              :index="it.path"
              v-for="it in item.sList"
              :key="it.id"
              @click="saveNavState(it.path)"
            >
              <template slot="title">
                <i class="el-icon-location"></i>
                <span>{{ it.title }}</span>
              </template>
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </el-aside>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      menuList: [],
      isCollapse: false,
      activePath: "/welcome",
      user: {}
    };
  },
  created() {
    //获取登录信息
    this.user = JSON.parse(window.sessionStorage.getItem("user"));
    // 查询侧边栏
    this.getMneuList();
    this.activePath = window.sessionStorage.getItem("activePath");
  },
  methods: {
    gologin(){
      this.$router.push("/welcome");
    },
    //安全退出
    logout() {
      window.sessionStorage.clear(); //清除session
      this.$router.push("/login");
    },
    // 获取侧边栏
    async getMneuList() {
      const { data: res } = await this.$http.get("menus", {
        params: {
          role: this.user.role
        }
      });
      if (res.flag != 200) {
        return this.$message.error("获取列表失败！！！");
      }
      this.menuList = res.menus;
    },
    //控制伸缩
    toggleCollapse() {
      this.isCollapse = !this.isCollapse;
    },
    //保存路径
    saveNavState(activePath) {
      window.sessionStorage.setItem("activePath", activePath);
      this.activePath = activePath;
    }
  }
};
</script>
<style lang="less" scoped>
.el-header {
  background-color: #78cdd1;
  display: flex;
  justify-content: space-between;
  padding-left: 0%;
  align-items: center;
  color: #fff;
  font-size: 20px;
  div {
    display: flex;
    align-items: center;
    span {
      margin-left: 15px;
    }
  }
}
.el-aside {
  background-color: #78cdd1;
  .el-menu {
    border-right: none;
  }
}
.el-main {
  background-color: rgb(190, 224, 226);
}
.home_container {
  height: 100%;
}
img {
  width: 70px;
  height: 60px;
}
.toggle-button {
  background-color: rgb(147, 211, 214);
  font-size: 10px;
  line-height: 24px;
  color: #fff;
  text-align: center;
  letter-spacing: 0.2em;
  cursor: pointer;
}
</style>

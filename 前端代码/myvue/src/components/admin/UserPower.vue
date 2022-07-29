<template>
  <div class="container">
    <div class="diva">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>用户管理</el-breadcrumb-item>
        <el-breadcrumb-item>账号管理</el-breadcrumb-item>
      </el-breadcrumb>
      <div class="search">
        <div class="search-box">
          <div class="search-input">
            <!-- <input type="search" name="search" /> -->
            <el-input v-model="input" placeholder="请输入账号" name="context"></el-input>
          </div>&nbsp;
          <el-button
            type="primary"
            icon="el-icon-search"
            size=" mini"
            @click="SearchByUser(input)"
          >搜索</el-button>
        </div>
      </div>
      <div class="info">
        <el-table
          :data="trains.slice((queryForm.pageNo-1)*queryForm.pageSize,queryForm.pageNo*queryForm.pageSize)"
          stripe
          style="width: 100%"
        >
          <el-table-column type="index" width="50"></el-table-column>
          <el-table-column prop="username" label="账号" width="130"></el-table-column>
          <el-table-column label="权限">
            <template slot-scope="scope">
              <el-switch
                v-model="scope.row.role"
                :active-value="1"
                :inactive-value="2"
                active-color="#02538C"
                inactive-color="#B9B9B9"
                @change="changeSwitchPower(scope.row)"
              />
            </template>
          </el-table-column>
          <el-table-column label="状态">
            <template slot-scope="scope">
              <el-switch
                v-model="scope.row.status"
                :active-value="1"
                :inactive-value="2"
                active-color="#02538C"
                inactive-color="#B9B9B9"
                @change="changeSwitchStatus(scope.row)"
              />
            </template>
          </el-table-column>
          <el-table-column fixed="right" label="操作" width="200">
            <template slot-scope="scope" width="200">
              <el-button size="mini" type="text" @click="ResetPwd(scope.$index,scope.row)">重置密码</el-button>
              <el-button size="mini" type="text" @click="DeleteUser(scope.$index,scope.row)">删除</el-button>
              <el-button size="mini" type="text" @click="UpdatUser(scope.$index,scope.row)">修改</el-button>
            </template>
          </el-table-column>
        </el-table>
        <el-pagination
          :background="background"
          :current-page="queryForm.pageNo"
          :layout="layout"
          :page-size="queryForm.pageSize"
          :total="total"
          @current-change="handleCurrentChange"
          @size-change="handleSizeChange"
        ></el-pagination>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  data() {
    return {
      input: "",
      layout: "total, sizes, prev, pager, next, jumper",
      total: 0,
      background: true,
      queryForm: {
        pageNo: 1,
        pageSize: 10,
        title: ""
      },
      trains: []
    };
  },
  created() {
    // 用户的信息
    this.QueryUsers();
  },
  methods: {
    // 所有用户信息
    async QueryUsers() {
      const { data: res } = await this.$http.post("/users");
      if (res.flag != 200) {
        console.log("获取用户信息失败");
      }
      this.trains = res.users;
      this.total = res.count;
    },

    // 根据username查找用户
    SearchByUser(context) {
      this.$http
        .post("/searchByUser", context)
        .then(res => {
          if (res.data.flag != 200) {
            this.$message.error("该用户不存在！");
          } else {
            this.$message.success("查找用户成功！");
            this.trains = res.data.data;
            this.total = res.data.count;
          }
        })
        .catch(() => {});
    },

    // 权限更改
    changeSwitchPower(row) {
      const data = {
        username: row.username,
        power: row.role
      };
    },

    // 状态更改
    changeSwitchStatus(row) {
      const data = {
        username: row.username,
        status: row.status
      };
    },

    // 重置密码，
    ResetPwd(index, row) {
      this.$http
        .post("/resetPwd", row)
        .then(res => {
          if (res.data.flag != 200) {
            this.$message.success("重置密码失败！");
          } else {
            this.$message.success("重置密码成功！");
          }
        })
        .catch(() => {});
    },

    // 修改用户状态和权限
    UpdatUser(index, row) {
      this.$confirm("确定要修改此用户吗？", "提示", {
        type: "warning"
      })
        .then(() => {
          this.$http.post("/userOperation", row).then(res => {
            if (res.data.flag != 200) {
              this.$message.success("修改失败！");
            } else {
              this.$message.success("修改成功！");
            }
          });
        })
        .catch(() => {});
    },

    // 删除
    DeleteUser(index, row) {
      // 删除确认
      this.$confirm("确定要删除此用户吗？", "提示", {
        type: "warning"
      })
        .then(() => {
          this.$http.post("/deleteUser", row).then(res => {
            if (res.data.flag != 200) {
              this.$message.success("删除失败！");
            } else {
              this.$message.success("删除成功！");
              this.trains.splice(index, 1);
              this.total = this.total - 1;
            }
          });
        })
        .catch(() => {});
    },

    // 页面展示数目更改
    handleSizeChange(val) {
      this.queryForm.pageSize = val;
    },
    // 页面跳转
    handleCurrentChange(val) {
      this.queryForm.pageNo = val;
    }
  }
};
</script>

<style lang="less">
.container {
  height: 300px;
  .diva {
    height: 100%;

    .search {
      height: 10vh;

      position: relative;
      top: 17px;
      background-color: rgb(255, 255, 255);
      .search-box {
        position: absolute;
        left: 15px;
        top: 10px;
        .search-input {
          display: inline-block;
          width: 20vw;
          height: 14vh;
        }
      }
    }
    .info {
      position: relative;
      top: 26px;
    }
  }
}
</style>

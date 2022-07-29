<template>
  <div class="container">
    <div class="diva">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>用户管理</el-breadcrumb-item>
        <el-breadcrumb-item>查看用户</el-breadcrumb-item>
      </el-breadcrumb>
      <div class="search">
        <div class="search-box">
          <div class="search-input">
            <!-- <input type="search" name="search" /> -->
            <el-input v-model="input" type="text" placeholder="请输入账号" name="context"></el-input>
          </div>&nbsp;
          <el-button
            type="primary"
            icon="el-icon-search"
            size=" mini"
            @click="SearchByUsername(input)"
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
          <!-- <el-table-column prop="trains.img" label="头像">
          <template slot-scope="scope">
            <img :src="scope.row.tableData.img" style="width: 40px;height: 40px;display: block;" />
          </template>
          </el-table-column>-->
          <el-table-column prop="username" label="账号" width="100"></el-table-column>
          <el-table-column prop="nickname" label="昵称" width="120"></el-table-column>
          <el-table-column prop="age" label="年龄" width="50"></el-table-column>
          <el-table-column prop="sex" label="性别" width="50"></el-table-column>
          <el-table-column prop="address" label="地址" width="270"></el-table-column>
          <el-table-column prop="phone" label="电话" width="150"></el-table-column>
          <el-table-column prop="qQ" label="QQ" width="150"></el-table-column>
          <!-- <el-table-column fixed="right" label="操作" width="100">
          <template slot-scope="scope" width="100">
            <el-button size="mini" type="text" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
            <el-button size="mini" type="text" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
          </template>
          </el-table-column>-->
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
      trains: [],
      userOp: []
    };
  },
  created() {
    this.QueryUserInfors();
  },
  methods: {
    async QueryUserInfors() {
      const { data: res } = await this.$http.post("/userInfo");
      if (res.flag != 200) {
        console.log("获取用户信息失败");
      }
      this.trains = res.userInfo;
      this.total = res.count;
    },
    // 根据username查找用户
    SearchByUsername(context) {
      this.$http
        .post("/searchByUsername", context)
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
    handleSizeChange(val) {
      this.queryForm.pageSize = val;
    },
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

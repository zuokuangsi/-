<template>
  <div class="container">
    <div class="diva">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>商品管理</el-breadcrumb-item>
        <el-breadcrumb-item>查看商品</el-breadcrumb-item>
      </el-breadcrumb>
      <div class="search">
        <div class="search-box">
          <div class="search-input">
            <!-- <input type="search" name="search" /> -->
            <el-input v-model="input" placeholder="请输入商品名称" name="context"></el-input>
          </div>&nbsp;
          <el-button
            type="primary"
            icon="el-icon-search"
            size=" mini"
            @click="SearchByProdname(input)"
          >搜索</el-button>
        </div>
      </div>
      <div class="info">
        <el-table
          :data="good.slice((queryForm.pageNo-1)*queryForm.pageSize,queryForm.pageNo*queryForm.pageSize)"
          stripe
          style="width: 100%"
        >
          <el-table-column type="index" width="50"></el-table-column>
          <el-table-column prop="id" label="id" width="100"></el-table-column>
          <el-table-column prop="username" label="账号" width="100"></el-table-column>
          <el-table-column prop="name" label="商品名称" width="130"></el-table-column>
          <el-table-column prop="price" label="价格" width="100"></el-table-column>
          <el-table-column prop="time" label="开始时间" width="100"></el-table-column>
          <el-table-column prop="described" label="简介" width="150"></el-table-column>
          <el-table-column prop="label" label="标签" width="200"></el-table-column>
          <el-table-column prop="status" label="状态" width="50">
            <template slot-scope="scope">
              <span>{{scope.row.status==1?"在售":"售完"}}</span>
            </template>
          </el-table-column>
          <el-table-column prop="quantity" label="数量" width="50"></el-table-column>
          <el-table-column prop="collect_num" label="收藏数量" width="50"></el-table-column>
          <el-table-column fixed="right" label="操作" width="100">
            <template slot-scope="scope" width="100">
              <el-button size="mini" type="text" @click="DeleteProdById(scope.$index, scope.row)">删除</el-button>
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
      good: []
    };
  },
  created() {
    this.QueryGoods();
  },
  methods: {
    // 所有商品
    async QueryGoods() {
      const { data: res } = await this.$http.post("goods");
      if (res.flag != 200) {
        console.log("获取商品信息失败");
        //  this.$router.push({ path: "/error" }); //页面路由跳转
      }
      this.good = res.goods;
      this.total = res.count;
    },

    // 通过商品名称查找商品
    SearchByProdname(context) {
      this.$http
        .post("/searchByProdname", context)
        .then(res => {
          if (res.data.flag != 200) {
            this.$message.error("该商品不存在！");
          } else {
            this.$message.success("查找商品成功！");
            this.good = res.data.data;
            this.total = res.data.count;
          }
        })
        .catch(() => {});
    },

    // 删除商品
    DeleteProdById(index, row) {
      this.$confirm("确定删除此商品吗？", "提示", {
        type: "warning"
      })
        .then(() => {
          this.$http.post("/deleteProd", row).then(res => {
            if (res.data.flag != 200) {
              this.$message.success("删除失败！");
            } else {
              this.$message.success("删除成功！");
              this.good.splice(index, 1);
              this.total = this.total - 1;
            }
          });
        })
        .catch(() => {});
    },

    // 分页
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

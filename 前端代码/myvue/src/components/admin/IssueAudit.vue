<template>
  <div class="container">
    <div class="diva">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>商品管理</el-breadcrumb-item>
        <el-breadcrumb-item>发布商品审核</el-breadcrumb-item>
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
            @click="SearchIssByProdname(input)"
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
          <!-- <el-table-column prop="img" label="图片">
          <template slot-scope="scope">
            <img :src="scope.row.img" style="width: 40px;height: 40px;display: block;" />
          </template>
          </el-table-column>-->
          <el-table-column prop="id" label="id" width="100"></el-table-column>
          <el-table-column prop="username" label="账号" width="100"></el-table-column>
          <el-table-column prop="name" label="商品名称" width="130"></el-table-column>
          <el-table-column prop="price" label="价格" width="50"></el-table-column>
          <el-table-column prop="time" label="开始时间" width="100"></el-table-column>
          <el-table-column prop="described" label="简介" width="160"></el-table-column>
          <el-table-column prop="label" label="品牌" width="100"></el-table-column>
          <el-table-column prop="quantity" label="数量" width="50"></el-table-column>
          <el-table-column fixed="right" label="操作" width="100">
            <template slot-scope="scope" width="100">
              <el-button size="mini" type="text" @click="AuditProdPass(scope.$index, scope.row)">通过</el-button>
              <el-button
                size="mini"
                type="text"
                @click="AuditProdNotPass(scope.$index, scope.row)"
              >未通过</el-button>
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
    this.QueryissGoods();
  },
  methods: {
    // 获取商品
    async QueryissGoods() {
      const { data: res } = await this.$http.post("issgoods");
      if (res.flag != 200) {
        console.log("获取商品信息失败");
      }
      this.good = res.goods;
      this.total = res.count;
    },

    // 通过商品名称查找商品
    SearchIssByProdname(context) {
      this.$http
        .post("/searchIssByProdname", context)
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

    // 审核商品，通过
    AuditProdPass(index, row) {
      this.$http
        .post("/auditpass", row)
        .then(res => {
          if (res.data.flag != 200) {
            this.$message.success("该商品审核失败！");
          } else {
            this.$message.success("该商品审核成功通过！");
            this.good.splice(index, 1);
            this.total = this.total - 1;
          }
        })
        .catch(() => {});
    },

    // 审核商品，未通过
    AuditProdNotPass(index, row) {
      this.$http
        .post("/auditNotpass", row)
        .then(res => {
          if (res.data.flag != 200) {
            this.$message.success("该商品审核失败！");
          } else {
            this.$message.success("该商品审核未通过！");
            this.good.splice(index, 1);
            this.total = this.total - 1;
          }
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

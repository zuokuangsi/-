<template>
  <div class="container">
    <div class="diva">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>日志管理</el-breadcrumb-item>
        <el-breadcrumb-item>查看日志</el-breadcrumb-item>
      </el-breadcrumb>

      <div class="info">
        <div class="log">
          <el-timeline v-model="logs" v-for="(log,index ) in logs" :key="index">
            <el-timeline-item :timestamp="log.writer_time" :color="color" placement="top">
              <el-card>
                <p>{{log.operation}}</p>
              </el-card>
            </el-timeline-item>
          </el-timeline>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  data() {
    return {
      color: "rgb(94, 213, 243)",
      logs: []
    };
  },

  created() {
    this.QueryLogs();
  },
  methods: {
    async QueryLogs() {
      const { data: res } = await this.$http.post("logs");
      if (res.flag != 200) {
        console.log("获取日志失败！");
      }
      this.logs = res.list;
    }
  }
};
</script>

<style lang="less" scoped>
.container {
  width: 100px;
  height: 300px;
  .diva {
    height: 100%;
    width: 70vw;
    .info {
      // position: relative;
      top: 26px;
      width: 70vw;
      p {
        font-size: 16px;
      }
    }
  }
}
</style>

<template>
  <div class="issue-box02">
    <el-card style="width: 80%;margin-left:100px">
      <el-form ref="goodsForm" :model="goodsForm" label-width="80px">
        <el-form-item label="商品名称">
          <el-input v-model="goodsForm.name" ></el-input>
        </el-form-item>

        <el-form-item label="商品价格">
          <el-input v-model="goodsForm.price"></el-input>
        </el-form-item>

        <el-form-item label="商品数量">
          <el-input-number v-model="goodsForm.quantity" :min="1" :max="10"></el-input-number>
        </el-form-item>
        <!--  商品描述    -->
        <el-form-item label="商品描述">
          <el-input type="textarea" v-model="goodsForm.described"></el-input>
        </el-form-item>
        <!--  图片上传 -->
        <el-form-item label="图片">
          <el-upload
            ref="upload"
            class="avatar-uploader"
            action="#"
            accept="image/png,image/jpg,image/jpeg"
            :auto-upload="true"
            :limit="5"
            :show-file-list="true"
            :before-upload="beforeAvatarUpload"
            :http-request="uploadHead"
            :on-success="handleAvatarSuccess"
          >
            <el-button size="small" type="primary">点击上传</el-button>
            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
          </el-upload>
        </el-form-item>


        <el-form-item>
          <el-button type="primary" @click="onSubmit">立即发布</el-button>
          <el-button @click="resetForm('goodsForm')">取消</el-button>
        </el-form-item>
      </el-form>
      <!--          <span>这是一段信息</span>-->
      <!--          <span slot="footer" class="dialog-footer">-->
      <!--          <el-button @click="dialogVisible = false">取 消</el-button>-->
      <!--          <el-button type="primary" @click="dialogVisible = false">确 定</el-button>-->
      <!--        </span>-->
    </el-card>
    <el-divider></el-divider>
  </div>
</template>

<script>
export default {
  data(){
    return{
      //用户信息
      user:{},
      //商品信息
      goodsForm: {
        name:'',//商品名称
        price:'',//商品价格
        described:'',//商品描述
        quantity:'1',//商品数量
      },
      goodsForm2:{
        name:'',//商品名称
        price:'',//商品价格
        described:'',//商品描述
        quantity:'1',//商品数量
      },
      //发布商品信息数
      //
      fd:'', //通过form数据格式来传,
      dialogVisible1: false,
      dialogVisible2: false,
    };
  },
  created:function() {
    this.fd = new FormData();
  },
  methods:{
    //提交商品信息
    async onSubmit(param) {
      this.fd.append("goodsForm",JSON.stringify(this.goodsForm));
      const {data: res} = await this.$http.post("/spike", this.fd,{
        headers:{'Content-Type': 'multipart/form-data'}
      });
      if (res.flag == "true") {
        this.dialogVisible1 = false;
        // this.dialogVisible2 = false;
        this.goodsForm = this.goodsForm2;
        //刷新本页面，获取已发布商品信息
        this.$message.success("提交成功");
      } else {
        this.$message.error("提交失败！");
      }
    },

    //文件上传成功后
    handleAvatarSuccess(res, file) {
      this.imageUrl = URL.createObjectURL(file.raw);
      alert("文件上传成功！存放在："+this.imageUrl);
    },
    //文件上传前，进行文件的格式和大小的检查
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    },
    uploadHead(f){
      this.fd.append("file", f.file);
    },
    handleClose(done) {
      this.$confirm('确认关闭？')
        .then(_ => {
          done();
        })
        .catch(_ => {});
    },
    //重置表单
    resetForm(goodsForm) {
      this.goodsForm = this.goodsForm2;
      alert(goodsForm);
      this.dialogVisible1 = false;
    }
  },
}
</script>

<style lang="less" scoped>
.issue-box02{
  height: 50px;
  /*margin: 1% 5%;*/
  margin: 5px 10%;
}

.issue-box2{
  /*background-color: lightskyblue;*/
  height: auto;
  padding: 10px 9%;
}
.demo-table-expand {
  font-size: 0;
}
.demo-table-expand label {
  width: 90px;
  color: #99a9bf;
}
.demo-table-expand .el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 50%;
}
</style>

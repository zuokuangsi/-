<template>
  <div style="margin-left: 200px">
  <el-card style="text-align: center;width: 80%;height: auto">
      <el-page-header @back="goBack" content="修改商品信息"></el-page-header>

    <div >
      <font face="宋体" size="5">该商品旧信息</font><br/><br/>
    </div>

      <div>
        <el-descriptions class="margin-top"  :column="3"  border style="width: 100%">

          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-name"></i>
              名字：
            </template>
            {{this.goods.name}}
          </el-descriptions-item>

          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-price"></i>
              价格:
            </template>
            {{this.goods.price}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-price"></i>
              数量:
            </template>
            {{this.goods.quantity}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-described"></i>
              描述：
            </template>
            {{this.goods.described}}
          </el-descriptions-item>
        </el-descriptions>
      </div>
    <br/><br/>
    <div >
      <font face="宋体" size="5">上传该商品的新信息</font><br/><br/>
    </div>

    <el-form  ref="goodsForm" :model="goodsForm" label-width="80px">
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
          <div slot="tip" class="el-upload__tip"><font color="red">只能上传4张jpg文件，且不超过500kb</font></div>
        </el-upload>
      </el-form-item>


      <el-form-item>
        <el-button type="primary" @click="onSubmit">确认修改</el-button>
        <el-button @click="goBack1">取消修改</el-button>
      </el-form-item>
    </el-form>
  </el-card>
  </div>
</template>

<script>
export default {
  name: "change_publish",
  data(){
    return{
      goods:{},
      goodsForm: {
        id:'',
        name:'',//商品名称
        price:'',//商品价格
        described:'',//商品描述
        quantity:'1',//商品数量
      },
      goodsForm2:{
        id:'',
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
    this.getParams();
    this.fd = new FormData();
  },
  methods:{
    //提交商品信息
    async onSubmit(param) {
      this.goodsForm.id=this.goods.id;
      this.fd.append("goodsForm",JSON.stringify(this.goodsForm));
      const {data: res} = await this.$http.post("/change_publish", this.fd,{
        headers:{'Content-Type': 'multipart/form-data'}
      });
      if (res.flag == "true") {
        this.dialogVisible1 = false;
        // this.dialogVisible2 = false;
        this.goodsForm = this.goodsForm2;
        //刷新本页面，获取已发布商品信息
        this.$message.success("修改成功");
      } else {
        this.$message.error("修改失败！");
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
    goBack(){
      this.$router.push({path:"personal"})
    },
    goBack1(){
      this.goodsForm = this.goodsForm2;
    },
    getParams() {
      this.goods =this.$route.params.message;
      // 取到路由带过来的参数;
    },




  }
}
</script>

<style scoped>

</style>

<template>
    <div class="issue-box02">
      <!-- 发布 -->

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



          <!-- 商品标签 -->
          <el-form-item label="商品标签">
            <el-cascader :options="options" :show-all-levels="false" v-model="goodsForm.label"></el-cascader>
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
  //记得改
  name: "publish_goods",
  data(){
    return{
      //用户信息
      user:{},
      //商品信息
      goodsForm: {
        username:'',//用户ID
        name:'',//商品名称
        price:'',//商品价格
        time:'',
        described:'',//商品描述
        label:'',//商品标签
        quantity:'1',//商品数量
      },
      goodsForm2:{
        username:'',//用户ID
        name:'',//商品名称
        price:'',//商品价格
        time:'',//发布时间
        described:'',//商品描述
        label:'',//商品标签
        quantity:'1',//商品数量
      },
      //发布商品信息数组
      //标签信息
      options: [
        {
          value: '电子产品',
          label: '电子产品',
          children: [
            {
              value: '手机',
              label: '手机'
            },{
              value: '电脑',
              label: '电脑'
            }, {
              value: '其他电子产品',
              label: '其他电子产品'
            },]
        },
        {
          value: '生活用品',
          label: '生活用品',
          children: [{
            value: '衣物穿着',
            label: '衣物穿着'
          }, {
            value: '家具类',
            label: '家具类'
          },{
            value: '其他生活物品',
            label: '其他生活物品'
          }]
        },
        {
          value: '娱乐手办',
          label: '娱乐手办',
          children: [{
            value: '手办',
            label: '手办'
          }, {
            value: '饰品',
            label: '饰品'
          },{
            value: '其他娱乐手办',
            label: '其他娱乐手办'
          }]
        },
        {
          value: '书籍产品',
          label: '书籍产品',
          children:[
            {
              value:'小说',
              label:'小说'
            },
            {
              value:'文学艺术',
              label:'文学艺术'
            },
            {
              value:'编程书籍',
              label:'编程书籍'
            },
            {
              value:'其他书籍',
              label:'其他书籍'
            },
          ]
        }
      ],
      //
      fd:'', //通过form数据格式来传,
      dialogVisible1: false,
      dialogVisible2: false,
    };
  },
  created:function() {
    //获取用户信息
    this.user = JSON.parse(window.sessionStorage.getItem("user"));
    // alert("test :" + this.userinfo.username + "  " + this.userinfo.password);
    // alert("进入获取用户信息");
    this.fd = new FormData();
  },
  methods:{
    //提交商品信息
    async onSubmit(param) {

      this.goodsForm.username = this.user.username;

      // this.fd.append("img",param.file);
      // this.fd.append("name",this.goodsForm.name);
      this.fd.append("goodsForm",JSON.stringify(this.goodsForm));
      // alert(JSON.stringify(this.goodsForm));
      // alert(fd.get)

      const {data: res} = await this.$http.post("/upload", this.fd,{
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

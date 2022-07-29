<template>
  <div class="my-center">
<el-page-header @back="goBack" content="个人中心">
</el-page-header><br>
    <el-tabs type="border-card" style="height: auto">
      <!-- 个人中心模块 -->
      <el-tab-pane label="基本信息">
        <div class="block" style="float: left">
          <el-avatar :size="100" :src="Img" ></el-avatar>
        </div>
        <el-button type="warning" plain icon="el-icon-chat-dot-round" @click="calling">我的聊天</el-button>
        <el-descriptions class="margin-top"  :column="3"  border>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-user"></i>
              昵称
            </template>
            {{this.inform.nickname}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-username"></i>
              账号
            </template>
            {{this.inform.username}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-sex"></i>
              性别
            </template>
            {{this.inform.sex}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-age"></i>
              年龄
            </template>
            {{this.inform.age}}
          </el-descriptions-item>

          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-mobile-phone"></i>
              手机号
            </template>
            {{this.inform.phone}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-location-outline"></i>
              收货地址
            </template>
            {{this.inform.address}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-QQ"></i>
              QQ
            </template>
            {{this.inform.qq}}
          </el-descriptions-item>
        </el-descriptions>
      </el-tab-pane>
<!--      我的收藏-->
      <el-tab-pane label="我的收藏">
        <el-card v-for="(goods,index) in list04" :key="index">
          <div>
            <div >
              <img class="history_img" :src="'http://localhost:9080/' +goods.file" style="width: 120px;height: 150px">
            </div>
            <div style="float: left">
              <el-descriptions class="margin-top"  :column="1"  border style="width: 100%">
                <el-descriptions-item>
                  <template slot="label">
                    <i class="el-icon-name"></i>
                    名字：
                  </template>
                  {{goods.name}}
                </el-descriptions-item>

                <el-descriptions-item>
                  <template slot="label">
                    <i class="el-icon-price"></i>
                    价格:
                  </template>
                  {{goods.price}}
                </el-descriptions-item>
                <el-descriptions-item>
                  <template slot="label">
                    <i class="el-icon-described"></i>
                    描述：
                  </template>
                  {{goods.described}}
                </el-descriptions-item>
                <el-descriptions-item>
                  <template slot="label">
                    <i class="el-icon-time"></i>
                    收藏时间：
                  </template>
                  {{goods.collect_time}}
                </el-descriptions-item>
              </el-descriptions>
            </div>
            <div style="float: right"><el-button  icon="el-icon-delete" circle @click="delete_collect(goods)"></el-button>
            </div>
          </div>
        </el-card>
      </el-tab-pane>
<!--      查看个人发布-->
      <el-tab-pane label="我的发布">

        <el-card v-for="(goods,index) in list05" :key="index">
          <div>
            <div >
              <img class="history_img" :src="'http://localhost:9080/' +goods.file01" style="width: 120px;height: 150px">
            </div>
            <div style="float: left">
              <el-descriptions class="margin-top"  :column="1"  border style="width: 100%">
                <el-descriptions-item>
                  <template slot="label">
                    <i class="el-icon-name"></i>
                    商品名：
                  </template>
                  {{goods.name}}
                </el-descriptions-item>
                <el-descriptions-item>
                  <template slot="label">
                    <i class="el-icon-price"></i>
                    价格:
                  </template>
                  {{goods.price}}
                </el-descriptions-item>
                <el-descriptions-item>
                  <template slot="label">
                    <i class="el-icon-described"></i>
                    描述：
                  </template>
                  {{goods.described}}
                </el-descriptions-item>
                <el-descriptions-item>
                  <template slot="label">
                    <i class="el-icon-time"></i>
                    审核是否通过：
                  </template>
                  {{goods.status==2?"待审核":(goods.status==1?"通过":"驳回")}}
                </el-descriptions-item>
              </el-descriptions>
            </div>
            <div style="float: right"><el-button  icon="el-icon-edit" circle @click="change_publish(goods)"></el-button>
            </div>
          </div>
        </el-card>
      </el-tab-pane>
<!--     修改密码-->
      <el-tab-pane label="修改密码">
        <el-input
          placeholder="请输入旧密码"
          v-model="ruleForm.old_password"
         style="width:40% ">
        </el-input>
        <br/><br/><br/>
        <el-input
          placeholder="请输入新密码"
          v-model="ruleForm.password"
           style="width:40% ">
        </el-input><br/><br/><br/>
        <el-input
          placeholder="再次输入新密码"
          v-model="ruleForm.password02"
           style="width:40% ">
        </el-input><br/><br/>
        <el-button type="primary" @click="onSubmit">确定修改</el-button>
      </el-tab-pane>
      <el-tab-pane label="信息修改">

        <el-card style="text-align:center">
<!--修改头像-->
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
          <el-button size="small" type="primary">修改头像</el-button>
          <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
        </el-upload>
<!--修改个人信息-->
       <el-input
          placeholder="请输入新昵称"
          v-model="change_form.nickname"
          :disabled="show" style="width:40% ">
        </el-input><br/><br/><br/>
          <el-input
          placeholder="请输入性别"
          v-model="change_form.sex"
          :disabled="show" style="width:40% ">
        </el-input><br/><br/><br/>
          <el-input
          placeholder="请输入年龄"
          v-model="change_form.age"
          :disabled="show" style="width:40% ">
        </el-input><br/><br/><br/>
       <el-input
      placeholder="请输入新手机号"
      v-model="change_form.phone"
      :disabled="show" style="width:40% ">
    </el-input><br/><br/><br/>
      <el-input
      placeholder="请输入新QQ号"
      v-model="change_form.qq"
      :disabled="show" style="width:40% ">
      </el-input><br/><br/><br/>
         <el-input
        placeholder="请输入新收获地址"
        v-model="change_form.address"
        :disabled="show" style="width:40% ">
      </el-input><br/><br/>
          <el-button type="primary" icon="el-icon-edit" circle @click="a1"></el-button>
          <el-button type="primary" @click="submitForm02">确定修改</el-button>
        </el-card>
      </el-tab-pane>
<!--      浏览记录-->
      <el-tab-pane label="浏览历史">
        <el-button type="text"@click="get_history">点击查看历史浏览记录</el-button>

        <el-switch
          v-model="value"
          active-color="#13ce66"
          inactive-color="#ff4949">
        </el-switch>

        <el-card v-for="(goods,index) in list03" :key="index">
          <div>
            <div >
            <img class="history_img" :src="'http://localhost:9080/' +goods.file" style="width: 120px;height: 150px">
            </div>
            <div style="float: left">
            <el-descriptions class="margin-top"  :column="1"  border style="width: 100%">
              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-name"></i>
                  名字：
                </template>
               {{goods.name}}
              </el-descriptions-item>

              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-price"></i>
                  价格:
                </template>
                {{goods.price}}
              </el-descriptions-item>
              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-described"></i>
                  描述：
                </template>
               {{goods.described}}
              </el-descriptions-item>
              <el-descriptions-item>
                <template slot="label">
                  <i class="el-icon-time"></i>
                 浏览时间：
                </template>
                {{goods.time}}
              </el-descriptions-item>
            </el-descriptions>
          </div>
            <div style="float: right"> <el-button  icon="el-icon-delete" circle @click="delete_history(goods)"></el-button>
            </div>
          </div>
        </el-card>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>
<script>
export default {
  name: "personal",
  data() {
    return {
      Img:" ",//修改头像
        user:{},
        inform:{},
      change_message:{
      nickname:'',
        phone: '',
        qq: '',
        address:'',
        sex:'',
        age:''
      },
      change_form:{
        username:'',
        nickname:'',
        phone: '',
        qq: '',
        address:'',
        sex:'',
        age:''
      },
      changePwdDialog:false,//修改密码弹框
      ruleForm: {
        username: '',
        old_password: '',
        password: '',
        password02:'',
      },
      show:'',
      list03:{}, //浏览历史
      list04:{}, //收藏
      list05:{}, //发布
      goods2:{},
      goods3:{},
      value: true
   }
   },
  created(){
    this.user=JSON.parse(window.sessionStorage.getItem("user"));
    this.get_img();  //获取头像
    this.get_inform(this.inform);//获取基本信息
    this.my_collect()//获取个人收藏
    this.my_publish();
    this.onSubmit();     //提交表单
    this.submitForm02();
    this.fd = new FormData();
  },
  methods: {
    a1(){
      this.show=false
    },
    calling(){
      this.$router.push({path:"MessageInfo"})
    },
    goBack() {
      this.$router.push("/welcome");
    },
    change_publish(goods){
      this.$router.push({
        name: "change_publish",
        params: {
          message: goods
        },
      });
    },
    //获取头像
    async get_img(){
      const {data : res} = await this.$http.get('get_img',{
        params:{
          username:this.user.username,
        },
      });
      this.Img='http://localhost:9080/' +res.Img;
    },
    // 获取个人信息
    async get_inform(inform){
      const {data: res} = await this.$http.get("personal",{
        params:{
            username:this.user.username
        }
      });
           this.inform=res.user;
       },
    //修改密码
    async onSubmit(param) {
      if(this.ruleForm.password&&this.ruleForm.old_password){
        if(this.ruleForm.password!=this.user.password){
          this.$message.error("旧密码错误");
        }else{
        if(this.ruleForm.password!=this.ruleForm.password02){
          this.$message.error("两次新密码输入不同");}
        else {
        this.ruleForm.username = this.user.username;
        const {data: res} = await this.$http.post("/pwd", JSON.stringify(this.ruleForm));
        if(res.flag=="true"){
          this.$message.success("修改成功,请重新登入")
          await this.$router.push({path: "/login"});}
        else
          this.$message.error("修改失败");
        }
      }
      }
    },
    //修改个人信息
    async  submitForm02(formName) {
      if(this.change_form.address!=""||this.change_form.phone!=""||this.change_form.qq!=""){
        this.change_form.username = this.user.username;
        this.fd.append("change_form",JSON.stringify(this.change_form));
        const {data: res} = await this.$http.post("/message", this.fd,{
          headers:{'Content-Type': 'multipart/form-data'}})
        if(res.flag=="true"){
          this.change_form.nickname=this.change_message.nickname;
            this.change_form.phone=this.change_message.phone;
           this.change_form.address=this.change_message.address;
           this.change_form.qq= this.change_message.qq;
          this.show="";
          this.show = true;
          alert("修改成功");
        }
        else alert("修改失败")
      }
    },
    //获取浏览历史
    async get_history(){
      const {data: res} = await this.$http.get("/get_history", {
        params:{
          username:this.user.username
        }
      });
      this.list03 = res.list;

    },
    //删除历史浏览记录
    async delete_history(goods){
      this.goods2=goods
      const {data: res} = await this.$http.get("/delete_history", {
        params:{
          username:this.user.username,
          id:this.goods2.id
        }
      });
      await this.get_history();

    },
    //获取个人收藏
    async my_collect(){
      const {data: res} = await this.$http.get("/selectCollect", {
        params:{
          username:this.user.username
        }
      });
      this.list04 = res.list;
    },
    //删除个人收藏
    async delete_collect(goods){
      this.goods3=goods
      const {data: res} = await this.$http.get("/delete_collect", {
        params:{
          username:this.user.username,
          id:this.goods3.id
        }
      });
      await this.my_collect();
    },
    //获取个人发布
    async my_publish(){
      const {data: res} = await this.$http.get("/get_publish", {
        params:{
          username:this.user.username
        }
      });
      this.list05 = res.list;
    },
    handleAvatarSuccess(res, file) {
      this.imageUrl = URL.createObjectURL(file.raw);
      alert("文件上传成功！存放在："+this.imageUrl);
    },
      uploadHead(f){
        this.fd.append("file", f.file);
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    },
  }
}
</script>
<style scoped>
.my-center {
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  background-color:white;
}
#box ul{
  display: flex;
  flex-wrap: wrap;
}
#box li{
  padding: 3px;
  list-style: none;
  margin-right: 10px;
  border: 4px solid #eee;
}
#box img {
  width: 200px;
  height: 200px;
}
.history_img{
  width: 10%;
  height: 6%;
  float: left;
}
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>

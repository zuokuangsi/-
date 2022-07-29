<template>
  <el-main>
   <el-card class="box-card02"shadow="always" style="top:50px;margin: 0 auto;width: 29%;min-height: 650px;position: relative;">
     <el-page-header @back="goBack"></el-page-header>
     <div><font face="宋体" size="6">校园二手交易平台</font></div>
     <div style="text-align:center;margin-top: 30px;">
       <img src="../assets/img.png" alt="logoImg" style="max-width: 90px;">
     </div><br><br>
     <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="auto" class="ruleForm-box">

       <el-form-item label="账号" prop="username" class="form_box">
         <el-input  type="text" v-model="ruleForm.username"placeholder="请输入账号长度在 6 ~ 12 个字符"></el-input>
       </el-form-item>

       <el-form-item label="密码" prop="password" class="form_box">
         <el-input type="password" v-model="ruleForm.password"placeholder="请输入密码长度在 6 ~ 12 个字符" autocomplete="off" show-password></el-input>
       </el-form-item>

       <el-form-item style="margin-right: 20px" >
         <el-button type="primary" @click="submitForm('ruleForm')" style="width: 70%">登录</el-button>
         <i class="el-icon-refresh-left" @click="resetForm('ruleForm')"></i>
       </el-form-item>
       <div>
         <el-button type="text"  @click="register" style="float: right">新用户注册</el-button>
           <el-button type="text"  @click="Retrieve"style="float: left">忘记密码</el-button>
         </div>

     </el-form>

     <el-col :span="24">
              <h6 style="text-align: center;color: #757575;">二手交易系统 版权所有</h6>
     </el-col>
   </el-card>
 </el-main>
</template>
<script>
export default {
  name: "login",
  data() {
    return {
      //表单数据对象
      ruleForm: {
        password: "",
        username:"",
      },
      //验证对象
      rules: {
        //验证密码
        password: [
          { required: true, message: "请输入用户密码", trigger: "blur" }, //必填项验证
          { min: 6, max: 12, message: "长度在 6 ~ 10 个字符", trigger: "blur" }, //长度验证
        ],
        username:[
          {required:true,message:"请输入账号",trigger:"blur"},//必填项验证
          {min:4,max:10,message:"长度在6 ~ 10 个字符",trigger:"blur"}//长度验证
        ]
      }
    };
  },
  methods: {
    goBack(){
      this.$router.push({path:"welcome"});
    },
    //提交表单
    submitForm(formName) {
      this.$refs["ruleForm"].validate(async (valid) =>{

        if(!valid) return;
        const {data: res} = await this.$http.post("/login",JSON.stringify(this.ruleForm));
        if(res.flag === "true"){
          //跳转到欢迎页面
            window.sessionStorage.setItem("user",JSON.stringify(res.user));
            if(res.user.status==1){
            if(res.user.role ==2){
              this.$message.success("管理员欢迎");
            await this.$router.push({path: "/Welcome02"});
          }
        else { this.$message.success("登录成功");//提示信息
            await this.$router.push({path: "/main"});}
          }else this.$message.error("你的账号有异常或违规操作暂被冻结，请待管理员审核！" +
              "有问题联系电话XXX XXXX XXXX")
        }
         else{
          this.$message.error("账号或密码错误！")
        }
      });
    },
    //重置表单
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
    register(){
      this.$router.push({path: "/register"});
    },
    Retrieve(){
      this.$router.push({path: "/retrieve"});
    }
  }
}
</script>
<style lang="less" scoped>
//登入框
.box-card02{
  height: 500px;
  width:300px;
}

.el-main {
  background:url("../assets/img_1.png");
  color: #333;
  text-align: center;
  height: 800px;
}

</style>

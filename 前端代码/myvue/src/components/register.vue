<template>
  <el-main>
    <el-card class="box-card02"shadow="always" style="top:50px;margin: 0 auto;width: 29%;min-height: 650px;position: relative;">
      <el-page-header @back="goBack"></el-page-header>
      <div><font face="宋体" size="6">校园二手交易平台</font></div>
      <div style="text-align:center;margin-top: 30px;">
        <img src="../assets/img.png" alt="logoImg" style="max-width: 90px;">
      </div><br><br>
      <el-form :model="ruleForm"ref="ruleForm" label-width="auto" class="ruleForm-box">
        <el-form-item label="昵称" prop="nickname" class="form_box">
          <el-input  type="text" v-model="ruleForm.nickname"placeholder="请输入昵称"></el-input>
        </el-form-item>
        <el-form-item label="账号" prop="username" class="form_box">
          <el-input  type="text" v-model="ruleForm.username"placeholder="请输入账号长度在 6 ~ 12 个字符"></el-input>
        </el-form-item>

        <el-form-item label="密码" prop="password" class="form_box">
          <el-input type="password" v-model="ruleForm.password"placeholder="请输入密码长度在 6~ 12 个字符" autocomplete="off" show-password></el-input>
        </el-form-item>
        <el-form-item label="QQ" prop="phone" class="form_box">
          <el-input  type="text" v-model="ruleForm.QQ"placeholder="请输入QQ号码"></el-input>
        </el-form-item>
        <el-form-item style="margin-right: 30px">
          <el-button type="primary"@click="toForm('Form')" style="width: 100%">注册</el-button>
        </el-form-item>
      </el-form>
      <el-col :span="24">
        <h6 style="text-align: center;color: #757575;">二手交易系统 版权所有</h6>
      </el-col>
    </el-card>
  </el-main>
</template>

<script>
export default {
  name: "register",
  data() {
    return {
      //表单数据对象
      ruleForm: {
        password: "",
        username: "",
        nickname: "",
        QQ: "",
      },
    };
  },
    methods: {
    goBack(){
      this.$router.push({path:"login"})
    },
      toForm(Form){
        this.$refs["ruleForm"].validate(async (valid) => {

          if (!valid) return;
          const {data: res} = await this.$http.get("/register", {
            params:{
              username:this.ruleForm.username,
              password:this.ruleForm.password,
              nickname:this.ruleForm.nickname,
               qq:this.ruleForm.QQ
            }
          });
          if (res.flag==="true"){
            window.sessionStorage.setItem("user",JSON.stringify(res.user));
            this.$message.success("注册成功,请登入");
            this.$router.push({path: "/login"});
          }
        })
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

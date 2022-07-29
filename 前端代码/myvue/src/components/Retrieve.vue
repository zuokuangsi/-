<template>
  <div class="retrieve">
<!--    找回密码页-->
    <div class="retrieve-box">
      <el-steps :active="active" align-center finish-status="success">
        <el-step title="填写账户名"></el-step>
        <el-step title="验证身份"></el-step>
        <el-step title="设置新密码"></el-step>
        <el-step title="完成"></el-step>
      </el-steps>

      <!-- 1 -->
      <div class="step-one" v-show="active == 0">
<!--        填写账户名-->
        <el-form ref="lineForm" :rules="rules" :model="ruleForm" label-width="120px">
          <el-form-item prop="username" style="width: 500px">
            <el-input :role="30" clearable  type="text" v-model="ruleForm.username" placeholder="请输入账号"></el-input>
          </el-form-item>
        </el-form>
      </div>

      <!-- 2 -->
      <div class="step-two" v-show="active == 1">
<!--        验证身份-->
        <el-form ref="lineForm" :rules="rules1" :model="ruleForm1" label-width="120px">
          <el-form-item prop="username" style="width: 500px">
            <el-input :role="30" clearable  type="text" v-model="ruleForm1.email" placeholder="请输入qq邮箱"></el-input>
          </el-form-item>
          <el-form-item prop="username" style="width: 500px">
            <el-button type="primary" style="float: left;" plain @click="getVerification"><font size="2">获取验证码</font></el-button>
            <el-input :role="30" clearable  type="text" style="float: right;width: 250px" v-model="ruleForm1.verification" placeholder="请输入验证码"></el-input>
<!--            <el-button >发送请求</el-button>-->

          </el-form-item>
        </el-form>
      </div>

      <!-- 3 -->
      <div class="step-three" v-show="active == 2">
<!--        设置新密码-->
        <el-form ref="lineForm" :rules="rules2" :model="ruleForm2" label-width="120px">
          <el-form-item prop="username" style="width: 500px">
            <el-input :role="30" clearable  type="text" v-model="ruleForm2.password1" placeholder="请输入新密码"></el-input>
          </el-form-item>
          <el-form-item prop="username" style="width: 500px">
            <el-input :role="30" clearable  type="text" v-model="ruleForm2.password2" placeholder="请再次输入密码"></el-input>
          </el-form-item>
        </el-form>
      </div>

      <!-- 4 -->
      <div class="step-four" v-show="active == 3">
        完成
      </div>

      <div class="step-buttons">
        <el-button @click.stop="prev" v-if="active == 1 || active == 2">上一步</el-button>
        <el-button @click.stop="next(active)" v-if="active == 0 || active == 1">下一步</el-button>
        <el-button @click.stop="step3" v-if="active == 2">提交</el-button>
        <el-button @click="resetForm(active)" v-if="active == 0 || active == 1">重置</el-button>
      </div>
    </div>

  </div>

</template>

<script>
    export default {
        name: "Retrieve",
        data() {
          return {
            active: 0,
            //步骤1
            //表单数据对象
            ruleForm: {
              password: "",
              username:"",
              role:"1",
            },
            //验证对象
            rules: {
              //验证密码
              password: [
                { required: true, message: "请输入用户密码", trigger: "blur" }, //必填项验证
                { min: 6, max: 12, message: "长度在 6 ~ 12 个字符", trigger: "blur" }, //长度验证
                {pattern:/^((?![0-9]+$)|(?![a-zA-Z]+$))[0-9A-Za-z]{6,12}$/,message:"请输入正确的格式"},//正则验证
              ],
              username:[
                {required:true,message:"请输入账号",trigger:"blur"},//必填项验证
                {min:8,max:8,message:"长度为8的数字",trigger:"blur"},//长度验证
                {pattern:/^[0-9]{8}$/,message:"请输入正确的格式"}//正则验证
              ]
            },
            //步骤2
            ruleForm1: {
              email: "",
              verification:"",
            },
            //验证对象
            rules1: {
              //验证qq邮箱格式
              email: [
                { required: true, message: "请输入用户邮箱", trigger: "blur" }, //必填项验证
                {pattern:/^[a-z0-9A-Z]+[- | a-z0-9A-Z . _]+@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-z]{2,}$/,message:"请输入正确的格式"},//正则验证
              ],
            },

            //步骤三
            ruleForm2: {
              password1:'',//新密码
              password2:'',//确认密码
            },
            //验证对象
            rules2: {
              //验证密码
              password1: [
                { required: true, message: "请输入用户密码", trigger: "blur" }, //必填项验证
                { min: 6, max: 12, message: "长度在 6 ~ 12 个字符", trigger: "blur" }, //长度验证
                {pattern:/^((?![0-9]+$)|(?![a-zA-Z]+$))[0-9A-Za-z]{6,12}$/,message:"请输入正确的格式"},//正则验证
              ],
              //验证密码
              password2: [
                { required: true, message: "请输入用户密码", trigger: "blur" }, //必填项验证
                { min: 6, max: 12, message: "长度在 6 ~ 12 个字符", trigger: "blur" }, //长度验证
                {pattern:/^((?![0-9]+$)|(?![a-zA-Z]+$))[0-9A-Za-z]{6,12}$/,message:"请输入正确的格式"},//正则验证
              ],
            },
            typeFormArr: ["lineForm", "equipmentForm"],
          };
        },

        methods: {
          prev() {
            --this.active;
            if (this.active < 0) this.active = 0;
          },
          next() {
            // console.log("当前active:" + this.active)
            if(this.active == 0){
              this.step1()
            }
            else if(this.active == 1){
              this.step2()
            }
            // else if(this.active == 1){
            //   this.step3()
            // }

            // this.$refs[this.typeFormArr[formName]].validate((valid) => {
            //   if (valid) {
            //     console.log("sus submit!!");
            //     if (this.active++ > 2) this.active = 0;
            //   } else {
            //     console.log("error submit!!");
            //     return false;
            //   }
            // });
          },
          resetForm(formName) {
            this.$refs[this.typeFormArr[formName]].resetFields();
          },
          submit() {

          },
          //验证用户是否存在
          async step1(){
            const {data : res} = await this.$http.get('usernameExist',{
              params:{
                username:this.ruleForm.username,
              }
            });
            if(res.flag == "true"){
              ++this.active;
              if(this.active > 4) this.active = 3;
            }else{
              this.$message.error("用户不存在！！")
            }

          },
          //验证码是否正确
          async step2(){
            const {data : res} = await this.$http.get('verify',{
              params:{
                email:this.ruleForm1.email,
                verification:this.ruleForm1.verification,
              }
            });
            if(res.flag == "true"){
              ++this.active;
              if(this.active > 4) this.active = 3;
            }else{
              this.$message.error("验证码错误！！")
            }
          },
          //提交新密码
          async step3(){
            const {data : res} = await this.$http.get('updatePassword',{
              params:{
                username:this.ruleForm.username,
                password:this.ruleForm2.password2
              }
            });
            if(res.flag == "true"){
              ++this.active;
              this.$message.success("密码更改成功！！");
            }else{
              this.$message.error("密码更改失败！！")
            }
          },
          //发送QQ验证码
          async getVerification(){
            const {data : res} = await this.$http.get('sendEmail',{
              params:{
                email:this.ruleForm1.email,
              }
            });
            if(res.flag == "true"){
              this.$message.success("发送成功")
            }else{
              this.$message.error("发送错误！！")
            }
          }
        }
    }
</script>

<style lang="less" scoped>
  .retrieve{
    width: 100%;
    height: 100%;
    /*background-color: greenyellow;*/
    //margin: 0 5%;
    padding-top:50px;
    background:url("../assets/img_1.png");
  }

  .retrieve-box{
    border: 1px solid #a6eceb !important;
    border-radius: 5px; /*向 div 元素添加圆角边框：*/
    box-shadow: 0 0 25px #a6eceb;/*向 div 元素添加阴影：*/
    text-align: center;
    /*margin: 0 30%;*/
    /*margin-top: 20px;*/
    padding-top: 5%;
    margin-left: 30%;
    margin-right: 30%;
    /*padding: 25px 0;*/
    width: 600px;
    height: 500px;
    background-color: white;
  }

  .step-one, .step-two, .step-three,.step-four{
    /*background-color: rebeccapurple;*/
    margin: 20px 0;
    padding-top: 100px;

    width: 100%;
    height: 200px;
  }

  .step-buttons {
    margin: 20px;
    text-align: center;
  }
</style>

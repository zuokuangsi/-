<template>
  <div class="messageinfo-box">
    <div class="show1">
      <div class="list">
        <div class="userMsg">
          <!-- 用户信息区域 -->
          <div style="margin-left: 30px"><font face="宋体" size="6" color="black">校园二手交易平台</font></div>
        </div>
        <div class="storeMsg">
          <!-- 店铺信息区域 -->
          <font color="black"> 用户名：</font><input v-model="chat.toId"></input>
          <el-button  type="text" @click="getMessage"><font color="black">发起聊天</font></el-button>
<br/><br/><br/><br/><br/><br/>
          <img src="../../assets/img.png" style="width: 200px;height: auto">
        </div>
      </div>
      <div class="dialog">
        <div class="showMsg">
          <div class="showName">
            <div><font face="宋体" size="6" color="black">聊天室</font></div>

          </div>
          <div class="mainMsg"> <!-- 聊天内容中展示区域 -->
            <div v-for="(item,index) in messages" :key="index">
              <div class="storeChat" v-if="user.username == item.fromId">
                <el-avatar
                  style="margin: 5px"
                  size="medium"
                  :src="'http://localhost:9080/' +userInfo.img"
                ></el-avatar>
                <div class="detail1">{{ item.message }}</div>
              </div>


              <div class="myChat" v-if="user.username == item.toId">
                <div class=" detail2">{{ item.message }}</div>
              </div>
            </div>


          </div>
        </div>
        <div class="sendMsg">
          <textarea
            class="text"
            id="messageText"
            autofocus="autofocus"
            maxlength="500"
            placeholder="请输入聊天内容"
            v-model="chat.message"
          ></textarea>

          <!-- 底部固定区域 -->
          <div class="footShow">  <!-- flex布局 -->
            <div style="margin-left:25px;">0/500</div>
            <div style="margin-right:25px;">点击发送
              <el-button  icon="el-icon-s-promotion" @click="cli">发送</el-button>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "MessageInfo",
  //消息-聊天右侧聊天界面样式
  data() {
    return {
      websock: null,
      user: null,
      chat: {
        toId: "",
        fromId: "",
        message: ""
      },
      userInfo:{},
      toUserInfo:{},
      messages: [],
      /* 店铺列表信息 */

    };
  },
  created() {
    this.user = JSON.parse(window.sessionStorage.getItem("user"));
    console.log(this.user);
    this.chat.fromId = this.user.username;
    this.userInfo = this.getUserInfo(this.user.username);
    this.initWebSocket();
  },
  destroyed() {
    this.websock.close() //离开路由之后断开websocket连接
  },
  methods: {
    async getUserInfo(userId){
      const {data} = await this.$http.get("/personal",{
        params:{
          username:this.user.username
        }
      });
     return data;
    },
    async getMessage() {
      const {data:inf} = await this.$http.get("/personal",{
        params:{
          username:this.user.username
        }
      });
      this.toUserInfo = inf;
      const {data: mes} = await this.$http.get("/chats", {
        params: {
          fromId: this.user.username,
          toId: this.chat.toId.trim(),
        }
      })
      console.log(mes)
      this.messages = mes;
      // this.scro();
    },
    // scro(){
    //   let doc = document.getElementsByClassName("mainMsg")[0];
    //   let h = doc.body.clientHeight;
    //   doc.scrollTo(0,h);
    // },
    userSelected(item, index) {
      /* 1.改变颜色样式
      2.改变对话框对话信息
        遍历展示对话信息
      */
    },
    // mySendMsg() {
    //   this.websocketsend(this.chat);
    //   /*传递消息给对应的用户 */
    // },
    cli() {
      if (this.chat.toId != null || this.chat.toId.trim() != "") {
        this.websocketsend(JSON.stringify(this.chat));
        let cha = Object.assign({}, this.chat);
        this.messages.push(cha);
        // this.scro();
        this.chat.message = "";
      }
    },
    initWebSocket() { //初始化weosocket
      const wsuri = "ws://localhost:9080/ws?userId=" + this.user.username;
      this.websock = new WebSocket(wsuri);
      this.websock.onmessage = this.websocketonmessage;
      this.websock.onopen = this.websocketonopen;
      this.websock.onerror = this.websocketonerror;
      this.websock.onclose = this.websocketclose;
    },
    websocketonopen() { //连接建立之后执行send方法发送数据
      console.log("建立连接成功")
      // let actions = {"test"成功:"12345"};
      // this.websocketsend(JSON.stringify(actions));
    },
    websocketonerror() {//连接建立失败重连
      this.initWebSocket();
      console.log("建立连接失败")
    },
    websocketonmessage(e) { //数据接收
      console.log("消息接受成功");
      let cha = JSON.parse(e.data);
      this.messages.push(cha);
      // this.scro();
      console.log(e.data);
      // const redata = JSON.parse(e.data);
      // console.log(redata);
    },
    websocketsend(Data) {//数据发送
      console.log("数据发送成功");
      console.log(Data)
      this.websock.send(Data);
    },
    websocketclose(e) {  //关闭
      console.log('断开连接', e);
    },
  }


};
</script>

<style lang="less" scoped>
.messageinfo-box {
  background-color: #e3f1f5;
//  height: 100%;
 width: 80%;
  height: 50%;
}

.show1 {
  display: flex;
  height: 88%;
  width: 75%;

  position: fixed; /* 不让样式滚动  */
}

.list {
  flex: 0.8;
  background-color:#5ba5dc;
  border-radius: 5px;
}

.userMsg {
  height: 12%;
  display: flex;
  align-items: center;
}

.storeMsg {
  height: 82%;
  overflow-y: auto; /* 垂直方向滚动条 */
  overflow-x: hidden;
}

.storeMsg::-webkit-scrollbar {
  /* 隐藏滚动条特效 */
  display: none;
}

.storeList {
  margin-top: 2px;
  border-top: 1px solid rgb(19, 16, 16);
  display: flex;
  height: 14.5%;
  padding-top: 6px;
}

.storeImg {
  height: 35px;
  width: 35px;
}

.storeMsg {
  flex: 1;
  margin-left: 10px;
}

.chatTime {
  width: 35px;
}

.dialog {
  flex: 2;
}

.showMsg {
  height: 69%;
  border: 1px solid rgb(253, 253, 253);
}

/* 主要聊天内容展示区域的滚动属性 */
.mainMsg {
  overflow-y: auto; /* 垂直方向滚动条 */
  overflow-x: hidden;
  height: 84%;
}

.mainMsg::-webkit-scrollbar {

  display: none;
}

.sendMsg {
  height: 30%;
  border: 1px solid rgb(204, 234, 204);
}

.showName {
  background-color: #5ba5dc;
  border-bottom: 1px solid rgb(31, 29, 29);
}

.storeChat {
  display: flex;
  margin-bottom: 10px;
}

.myChat {
  display: flex;
  justify-content: flex-end;
}

.detail1 {
  background: #e3f1f5;
  border-radius: 5px;
  margin: 5px;
  padding: 5px;
}

.detail2 {
  background: #e3f1f5;
  border-radius: 5px;
  margin: 5px;
  padding: 5px;
}

.text {
  border: none;
  resize: none;
  width: 99%;
  height: 75%;
  outline: 0 none;
  font-size: 18px;
  overflow-y: auto; /* 垂直方向滚动条 */
  overflow-x: hidden; //超出高度滚动
}

textarea::-webkit-scrollbar {
  display: none;
}

.footShow { /* 底部固定信息 */
  color:  #e3f1f5;
  display: flex;
  flex-direction: row;
  height: 14%;
  justify-content: space-between; /* 主轴对齐，两侧贴边 */
  font-size: 13px;
}

.content { /* 单行文本溢出 显示省略号*/
  color: #e3f1f5;
  font-weight: normal;
  width: 122px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>

import Vue from 'vue'
import App from './App'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
// 注册element-ui
// 导入axios
 import axios from 'axios'
Vue.use(ElementUI)

Vue.config.productionTip = false   //阻止显示生产模式的消息
//挂载axios
Vue.prototype.$http = axios
//设置访问根路径
axios.defaults.baseURL = "/api"
//设置请求头
axios.defaults.headers['Content-Type'] = 'application/json;charset=UTF-8'
new Vue({
  router,
  render: h => h(App)
}).$mount('#app')

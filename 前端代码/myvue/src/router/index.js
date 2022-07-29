import Vue from 'vue'
import Router from 'vue-router'
import welcome from "../components/welcome";
import login from "../components/login";
import Personal_center from "../components/Personal_center";
import shopping_cart from "../components/shopping_cart";
import publish_goods from "../components/publish_goods";
import Main from "../components/Main";
import register from "../components/register";
import Specific_products from "../components/Specific_products";
import text from "../components/text";
import Retrieve from "../components/Retrieve";
import literature from "../components/books_publications/literature";
import novel from "../components/books_publications/novel";
import programming from "../components/books_publications/programming";
import other2 from "../components/daily_necessities/other2";
import other1 from "../components/books_publications/other1";
import clothing from "../components/daily_necessities/clothing";
import furniture from "../components/daily_necessities/furniture";
import other3 from "../components/electronic_product/other3";
import figure from "../components/entertainment_figure/figure";
import accessories from "../components/entertainment_figure/accessories";
import other4 from "../components/entertainment_figure/other4";
import computer from "../components/electronic_product/computer";
import cellphone from "../components/electronic_product/cellphone";
import AllProduct from "../components/admin/AllProduct";
import IssueAudit from "../components/admin/IssueAudit";
import UserInfo from "../components/admin/UserInfo";
import UserPower from "../components/admin/UserPower";
import ViewLog from "../components/admin/ViewLog";
import Home from "../components/admin/Home";
import Welcome02 from "../components/admin/Welcome02";
import spike from "../components/spike";
import order from "../components/order";
import change_publish from "../components/change_publish";
import MessageInfo from "../components/message/MessageInfo";

Vue.use(Router)
export default new Router({
  routes: [

    {
      path: '/order',
      name: 'order',
      component: order
    },
    {
    path: '/login',
    name: 'login',
    component: login
    },
    {
      path: '/register',
      name: 'register',
      component: register
    },
    {
    path: "/home",
  component: Home,
  redirect: "/welcome02",
  children: [
    {
      path: "/welcome02",
      component: Welcome02,
    },
    {
      path:"/AllProduct",
      name:'AllProduct',
      component:AllProduct
    },
    {
      path:"/IssueAudit",
      name:'IssueAudit',
      component:IssueAudit
    },
    {
      path:"/UserInfo",
      name:'UserInfo',
      component:UserInfo
    },
    {
      path:"/UserPower",
      name:'UserPower',
      component:UserPower
    },
    {
      path:"/ViewLog",
      name:'ViewLog',
      component:ViewLog
    }]},
    {
      path:"/welcome",
      component:welcome,
      redirect:'/Main',
      children:[
        {
          path: '/text',
          name: 'text',
          component: text
        },
        {
          path: '/personal',
          name: 'Personal_center',
          component: Personal_center //个人中心
        },
        {
          path: '/publish_goods',
          component: publish_goods  //发布商品
        },
        {
          path: '/specific',
          component: Specific_products  //发布商品
        },
        {
          path:"/Main",
          component:Main,
        },
        {
          path:"/spike",
          name:"spike",
          component:spike,
        },
        {
          path: '/shopping',
          component: shopping_cart  //购物车
        },

        {
          path:'/retrieve',
          component: Retrieve
        },
        {
          path:'/literature',
          name: 'literature',
          component: literature
        },
        {
          path:'/novel',
          name:'novel',
          component: novel
        },
        {
          path:'/programming',
          name:'programming',
          component: programming
        },
        {
          path:'/other1',
          name:'other1',
          component: other1
        }, {
          path:'/other2',
          name:'other2',
          component: other2
        }, {
          path:'/clothing',
          name:'clothing',
          component: clothing
        }, {
          path:'/furniture',
          name:'furniture',
          component: furniture
        }, {
          path:'/other3',
          name:'other3',
          component: other3
        },{
          path:'/cellphone',
          name:'cellphone',
          component: cellphone
        },{
          path:'/computer',
          name:'computer',
          component: computer
        },{
          path:'/other4',
          name:'other4',
          component: other4
        },{
          path:'/accessories',
          name:'accessories',
          component: accessories
        },{
          path:'/figure',
          name:'figure',
          component: figure
        },
        {
          path: '/change_publish',
          name: 'change_publish',
          component: change_publish
        }, {
          path: '/MessageInfo',
          name: 'MessageInfo',
          component: MessageInfo
        },
  ]}
  ]
})

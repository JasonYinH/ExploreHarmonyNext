import { Route } from '@hzw/zrouter'
import { CommonConst, NavName, PreferencesConst } from 'utils'
import { JSONUtil, PreferencesUtil, ToastUtil } from '@pura/harmony-utils'
import { SwitchLoginTypeComp } from '../components/SwitchLoginTypeComp'
import { LoginService } from '../service/LoginService'
import json from '@ohos.util.json'
import { UserLoginBean } from 'utils/src/main/ets/data/bean/UserLoginBean'

@Preview
@ComponentV2
@Route({ name: NavName.LOGIN_VIEW, description: '登录/注册页' })
export struct LoginView {
  @Local account: string = '' //  用户名
  @Local password: string = '' // 密码
  @Local isLogin: boolean = true // 登录注册切换

  aboutToAppear(): void {
    // console.log(`xxx ： ---` + 'LoginView')
    // console.log(`xxx获取参数 ： ---` + ZRouter.getInstance().getParamByName(NavName.LOGIN_VIEW).toString())

  }

  build() {
    NavDestination() {
      Column() {
        this.headBuilder()
        // 登录，注册页面
        SwitchLoginTypeComp({
          changeFactory: (account: string, password: string, isLogin: boolean) => {
            console.log(`xxx ： ---account--` + account + '，password--' + password + '，isLogin--' + isLogin)
            this.account = account
            this.password = password
            this.loadNet()
          }
        })


      }.width(CommonConst.FULL_PARENT)
      .height(CommonConst.FULL_PARENT)
    }
    .hideTitleBar(true)
    .backgroundColor($r('app.color.white'))
    .width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)

  }

  async loadNet() {
    let login = await LoginService.login({
      'username': this.account,
      'password': this.password
    })
    if (login.data?.getSuccess()) {
      // 存
      PreferencesUtil.put(PreferencesConst.KEY_LOGIN_USER_BEAN, JSONUtil.beanToJsonStr(login.data?.getData()))
      // 取
      let user = await PreferencesUtil.getString(PreferencesConst.KEY_LOGIN_USER_BEAN)
      let userBean = JSONUtil.jsonToBean(UserLoginBean, user)
      ToastUtil.showToast(userBean?.nickname)


    } else {
      console.log('xxx--' + login.data?.getMsg())
      ToastUtil.showToast(login.data?.getMsg())
    }
  }

  /** 头部 */
  @Builder
  headBuilder() {
    Stack({ alignContent: Alignment.Top }) {
      Text()
        .width(CommonConst.FULL_PARENT)
        .height(250)
        .backgroundColor($r('app.color.colorPrimary'))
      Text()
        .width(CommonConst.FULL_PARENT)
        .height(100)
        .backgroundColor(Color.White)
        .borderRadius(50)
        .margin({ top: 210 })

      Image($r('app.media.ic_close'))
        .width(20)
        .height(20)
        .position({ x: 20, y: 20 })
        .onClick(() => {
          ToastUtil.showToast('关闭')
        })

      Column({ space: 7 }) {
        Image($r('app.media.startIcon')).width(100).height(100)
        Text('欢迎使用').fontSize(22).fontColor($r('app.color.white')).fontWeight(FontWeight.Bold)
        Text('本APP由JasonYin独立开发').fontSize(12).fontColor($r('app.color.white'))
      }.margin({ top: 44 })
    }.width(CommonConst.FULL_PARENT)

  }
}

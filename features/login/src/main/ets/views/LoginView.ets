import { Route } from '@hzw/zrouter'
import { CommonConst, NavName } from 'utils'
import { ToastUtil } from '@pura/harmony-utils'
import { LoginService } from '../service/LoginService'
import json from '@ohos.util.json'

@Preview
@ComponentV2
@Route({ name: NavName.LOGIN_VIEW, description: '登录页' })
export struct LoginView {
  @Local account: string = '' //  用户名
  @Local password: string = '' // 密码



  aboutToAppear(): void {

  }

  build() {
    NavDestination() {
      Column() {


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
    console.log('xxxlogin--' + '' + json.stringify(login))
    if (login.data?.getSuccess()) {

      console.log('xxxxxdata参数--' + '' + json.stringify(login.data.getData()))
    } else {
      console.log('xxx--' + login.data?.getMsg())
      ToastUtil.showToast(login.data?.getMsg())
    }
  }


}

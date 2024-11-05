import { Route, ZRouter } from "@hzw/zrouter"
import { CommonConst, NavName } from "utils"
import json from "@ohos.util.json"

@Preview
@ComponentV2
@Route({ name: NavName.LOGIN_VIEW })
export struct LoginView {
  aboutToAppear(): void {
    console.log(`xxx ： ---` + 'LoginView')
    console.log(`xxx获取参数 ： ---` + ZRouter.getInstance().getParamByName(NavName.LOGIN_VIEW).toString())

  }

  build() {
    NavDestination() {
      Column() {
        Text(ZRouter.getInstance().getParamByName(NavName.LOGIN_VIEW).toString()).onClick(() => {

          ZRouter.getInstance().popToRootWithResult<string>('我是登录页返回的数据')
        })
      }
    }.width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)

  }
}

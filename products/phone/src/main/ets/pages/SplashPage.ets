import { Route, ZRouter } from "@hzw/zrouter";
import { CommonConst, NavName } from "utils";


/**
 * Author:J
 * Describe: 启动页
 */
@Preview
@ComponentV2
@Route({ name: NavName.SPLASH_PAGE })
export struct SplashPage {
  aboutToAppear(): void {
    // 跳转到主页面
    // ZRouter.getInstance().navigation(NavName.MAIN_PAGE)
    // 跳转到登录页面
    ZRouter.getInstance().navigation(NavName.LOGIN_VIEW)
    // todo 测试
    // ZRouter.getInstance().navigation('TestNetView')

    ZRouter.getInstance().removeByName(NavName.SPLASH_PAGE)
  }

  build() {
    NavDestination() {

    }.hideTitleBar(true)
    .width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)
  }
}

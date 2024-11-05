import { ZRouter } from '@hzw/zrouter';
import { CommonConst, NavName } from 'utils';
import { MainPage } from './MainPage';

/**
 * Author:J
 * Describe: 主要针对于 Navigation
 */
@Entry
@ComponentV2
struct Index {
  build() {
    // 获取NavPathStack实例对象
    Navigation(ZRouter.getNavStack()) {
    }
    .onAppear(() => {
      // 跳转到登录页面
      ZRouter.getInstance().navigation(NavName.LOGIN_VIEW)
    })
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
    .width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)

  }

  onPageShow(): void {
    console.log(`xxx ： ---onPageShow`)
  }
}

import { ZRouter } from '@hzw/zrouter';
import { CommonConst, NavName } from 'utils';
import { OhosSmartDialog } from 'ohos_smart_dialog';
import { loadingView } from 'uicomponents';

/**
 * Author:J
 * Describe: 主要针对于 Navigation
 */
@Entry
@ComponentV2
struct Index {
  build() {
    Stack() {
      // 获取NavPathStack实例对象
      Navigation(ZRouter.getNavStack()) {

      }
      .onAppear(() => {
        // 跳转到登录页面
        // ZRouter.getInstance().navigation(NavName.LOGIN_VIEW)
        // todo 测试
        ZRouter.getInstance().navigation('TestNetView')

      })
      .hideTitleBar(true)
      .mode(NavigationMode.Stack)
      .width(CommonConst.FULL_PARENT)
      .height(CommonConst.FULL_PARENT)

      // here dialog init
      OhosSmartDialog({ loadingBuilder: loadingView })

    }.width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)

  }

  /** 返回事件监听 */
  onBackPress(): boolean | void {
    return OhosSmartDialog.onBackPressed()()
  }
}


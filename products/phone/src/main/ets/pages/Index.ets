import { ZRouter } from '@hzw/zrouter';
import { CommonConst } from 'utils';
import { OhosSmartDialog } from 'ohos_smart_dialog';

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
      OhosSmartDialog({ loadingBuilder: customLoading })

    }.width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)

  }

  /** 返回事件监听 */
  onBackPress(): boolean | void {
    return OhosSmartDialog.onBackPressed()()
  }
}

/** 自定义页面弹窗 */
@Builder
function customLoading(args: ResourceStr = '正在加载中...') {
  Column() {
    Image($r('app.media.loading_refresh')).width(50).height(50)
    Text(args)
      .fontSize(11)
      .fontColor($r('app.color.color_222222'))
      .margin({ top: 11 })
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })

  }
  .width(120)
  .height(120)
  .justifyContent(FlexAlign.Center)
  .backgroundColor(Color.White)
  .borderRadius(12)
}

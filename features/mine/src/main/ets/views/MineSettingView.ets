import { Route } from "@hzw/zrouter";
import { ToastUtil } from "@pura/harmony-utils";
import { TitleBarComp } from "uicomponents";
import { CommonConst, NavName } from "utils";

/**
 * Author:J
 * Describe: 我的设置页面
 */
@Preview
@ComponentV2
@Route({ name: NavName.MINE_SETTING_VIEW, description: '我的设置页面' })
export struct MineSettingView {
  build() {
    NavDestination() {
      Column({space:8}) {
        Text('第一种样式').fontColor(Color.Red)
        TitleBarComp({ title: '设置' })
        Text('第二种样式，自定义返回事件').fontColor(Color.Red)
        TitleBarComp({
          title: '设置二', backClick: () => {
            ToastUtil.showToast('自定义返回事件')
          }
        })
        Text('第三种样式，右边有文字').fontColor(Color.Red)
        TitleBarComp({
          title: '设置三',
          isShowRight: true,
          rightTitle: '右边',
          rightClick: () => {
            ToastUtil.showToast('右边')
          }
        })
        Text('第四种，右边有图片').fontColor(Color.Red)
        TitleBarComp({
          title: '设置四',
          isShowRight: true,
          rightImage: $r('app.media.ic_share_article'),
          rightClick: () => {
            ToastUtil.showToast('右边')
          }
        })
      }
      .width(CommonConst.FULL_PARENT)
      .height(CommonConst.FULL_PARENT)
      .backgroundColor($r('app.color.white'))
    }
    .hideTitleBar(true)
  }
}

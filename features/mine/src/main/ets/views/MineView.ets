import { ZRouter } from '@hzw/zrouter'
import { ToastUtil } from '@pura/harmony-utils'
import { HorizontalTabItemComp, TabHorizontalModel } from 'uicomponents'
import { CommonConst, NavName } from 'utils'
import { horizontalTabItemData } from '../model/MineModel'

/**
 * Author:J
 * Describe: 我的页面
 */
@Preview
@ComponentV2
export struct MineView {
  build() {
    Column() {

      this.head()

      ForEach(horizontalTabItemData, (item: TabHorizontalModel, index: number) => {
        HorizontalTabItemComp({
          tabItem: item,
          onItemClick: () => {
            this.onItemClick(item)
          }
        }).margin({ left: 12, right: 12 })
      })


    }.width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)
    .backgroundColor(Color.White)
  }

  /** 头部 */
  @Builder
  head() {
    Stack({ alignContent: Alignment.Top }) {
      Row() {
        // 消息
        Image($r('app.media.ic_notification')).height(44).fillColor($r('app.color.white')).align(Alignment.TopEnd).padding(8)
        // 设置
        Image($r('app.media.ic_settings_white')).height(44).align(Alignment.TopEnd).padding(8).onClick(() => {
          ZRouter.getInstance().navigation(NavName.MINE_SETTING_VIEW)
        })
      }.width(CommonConst.FULL_PARENT).height(44).justifyContent(FlexAlign.SpaceBetween).align(Alignment.Top)


      Column() {
        Text().width(80).height(80).backgroundColor($r('app.color.color_11FFFFFF')).borderRadius(40)
        Text('我是昵称').fontSize(22).fontColor($r('app.color.white')).fontWeight(FontWeight.Bold).margin({ top: 10 })
        Text('等级:15  排名:36').fontSize(12).fontColor($r('app.color.colorOnMainOrSurface')).margin({ top: 5 })
      }.margin({ top: 100 })

    }.width(CommonConst.FULL_PARENT).height(260).backgroundColor($r('app.color.colorPrimary'))
  }

  /** 点击事件 */
  private onItemClick(item: TabHorizontalModel) {
    ToastUtil.showToast(item.title)
    if (item.index == 0) {

    } else if (item.index == 1) {

    } else if (item.index == 2) {

    } else if (item.index == 3) {

    } else if (item.index == 4) {

    } else if (item.index == 5) {

    } else if (item.index == 6) {

    }
  }
}

import { CommonConst } from "utils"
import { TabHorizontalModel } from "../model/TabHorizontalModel"

/**
 * Author:J
 * Describe: 横向Tab 图片、文字、右边文字、小红点
 */
@ComponentV2
export struct HorizontalTabItemComp {
  @Param @Require tabItem: TabHorizontalModel= new TabHorizontalModel('')
  @Param onItemClick?: () => void = undefined

  build() {
    Row() {
      Image(this.tabItem.icon)
        .width(24)
        .margin({ right: 12 })
        .visibility(this.tabItem.hasIcon ? Visibility.Visible : Visibility.None)

      Text(this.tabItem.title)
        .fontSize(16)
        .fontColor($r('app.color.color_222222'))
        .layoutWeight(1)
      if (this.tabItem.hasNew) {
        Badge({
          value: '',
          position: BadgePosition.Right,
          style: { badgeSize: 7, badgeColor: $r('app.color.color_FA2A2D') }
        }) {
          Text(this.tabItem.rightTitle)
            .fontSize(16)
            .fontColor($r('app.color.color_222222'))
            .visibility(this.tabItem.hasRightTitle ? Visibility.Visible : Visibility.None)
            .margin({ right: 20 })
        }
      } else {
        Text(this.tabItem.rightTitle)
          .fontSize(16)
          .fontColor($r('app.color.color_222222'))
          .visibility(this.tabItem.hasRightTitle ? Visibility.Visible : Visibility.None)
      }
      Image($r('app.media.ic_arrow_right_gray_small'))
        .width(24)
        .margin({ left: 12 })
        .visibility(this.tabItem.hasRightIcon ? Visibility.Visible : Visibility.None)
    }
    .width(CommonConst.FULL_PARENT)
    .height(44)
    .backgroundColor($r('app.color.white'))
    .onClick(() => {
      this.onItemClick?.()
    })
  }
}

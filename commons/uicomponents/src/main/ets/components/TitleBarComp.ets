import { ZRouter } from '@hzw/zrouter';
import { CommonConst } from 'utils';

/**
 * Author:J
 * Describe:自定义导航栏组件
 * 内置了导航栏的返回按钮、标题、右侧按钮等
 */
@ComponentV2
export struct TitleBarComp {
  /** 标题 */
  @Param title: ResourceStr = '';
  /** 返回按钮的点击事件 */
  @Param backClick?: (event?: ClickEvent) => void = undefined;
  /** 是否显示右侧按钮 */
  @Param isShowRight: boolean = false;
  /** 右侧标题 */
  @Param rightTitle: ResourceStr = '';
  /** 右侧图片 */
  @Param rightImage: ResourceStr = '';
  /** 右侧点击事件 */
  @Param rightClick?: (event?: ClickEvent) => void = undefined;

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_arrow_left')).width(44).padding(8).onClick(() => {
          if (this.backClick) {
            this.backClick()
          } else {
            ZRouter.pop()
          }
        })
        Text(this.title)
          .fontColor($r('app.color.color_222222'))
          .fontSize(16)
          .maxLines(1)
          .fontWeight(FontWeight.Bold)

        Row() {
          if (this.rightTitle) {
            Text(this.rightTitle)
              .fontColor($r('app.color.color_222222'))
              .fontSize(16)
              .margin({ right: 10 })
          } else {
            Image(this.rightImage ? this.rightImage : $r('app.media.ic_local_search'))
              .width(44)
              .padding(10)
          }
        }
        .onClick(this.rightClick)
        .visibility(this.isShowRight ? Visibility.Visible : Visibility.Hidden)

      }
      .width(CommonConst.FULL_PARENT)
      .height(44)
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor($r('app.color.white'))

      Divider()
        .width(CommonConst.FULL_PARENT)
        .color($r('app.color.color_F0F0F0'))


    }
    .width(CommonConst.FULL_PARENT)
    .height(45)

  }
}



import { ToastUtil } from '@pura/harmony-utils'
import { CommonConst } from "utils";

/**
 * Author:J
 * Describe:协议
 */
@ComponentV2
export struct ProtocolComp {
  @Require @Param selectProtocol: boolean=false //是否勾选协议
  @Event $selectProtocol: (val: boolean) => void = () => {
  }
  @Require @Param confirm: boolean=false //是否弹窗协议
  @Event $confirm: (val: boolean) => void = () => {
  }

  build() {
    Column() {
      Row() {
        Checkbox()
          .select(this.selectProtocol)
          .selectedColor($r('app.color.colorPrimary'))
          .onChange((value: boolean) => {
            this.$selectProtocol(value)
            //协议不选中,不赋值confirm
            if (!value) {
              return
            }
            this.$confirm(!value)
          })
        Text() {
          span('登录即表示您已同意我们的 ', $r('app.color.color_999999'))
          span('《隐私政策》', $r('app.color.colorPrimary'), 1, true)
          span('、', $r('app.color.color_999999'))
          span('《用户服务协议》', $r('app.color.colorPrimary'), 2, true)
          span('、', $r('app.color.color_999999'))
          span('《服务条款》', $r('app.color.colorPrimary'), 3, true)
        }
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Top)
      .margin({ top: 14, right: 30 })

      // 若没有勾选协议，则会出现提示文本：“请阅读并勾选协议”
      if (this.confirm) {
        Row() {
          Column() {
            Image($r('app.media.login_popup'))
              .width(10)
              .height(10)
              .position({ x: 7, y: 1 })
              .opacity(0.8)

            Text('请阅读并勾选协议')
              .fontColor($r('app.color.white'))
              .fontSize(10)
              .textAlign(TextAlign.Center)
              .backgroundColor($r('app.color.black'))
              .width(100)
              .height(20)
              .position({ x: 3, y: 9 })
              .borderRadius(4)
              .opacity(0.8)
          }
          .width(100)
          .height(30)
        }
        .height(30)
        .width('100%')
      }


    }.width(CommonConst.FULL_PARENT)
    .height(50)
    .padding({ left: 60, right: 60 })

  }
}


@Builder
function span(value: string | Resource, fontColor: ResourceColor, k: number = 0, isClick: boolean = false) {
  Span(value)
    .fontColor(fontColor)
    .fontSize(12)
    .onClick(() => {
      if (!isClick) {
        return
      }
      ToastUtil.showToast(`我要进web页面了k：${value}=====值：${k}`)
    })
}

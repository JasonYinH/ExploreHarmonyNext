import { ToastUtil } from '@pura/harmony-utils'
import { CommonConst } from "utils"
import { ProtocolComp } from "./ProtocolComp"

@Extend(TextInput)
function inputStyle() {
  .height(44)
  .fontColor($r('app.color.color_222222'))
  .fontSize(16)
  .placeholderColor($r('app.color.color_999999'))
  .placeholderFont({ size: 16 })
  .backgroundColor($r('app.color.white'))
  .caretColor($r('app.color.colorPrimary'))
  .padding({ left: 8 })
}

@Extend(Divider)
function dividerStyle() {
  .strokeWidth(1)
  .color($r('app.color.color_F0F0F0'))
  .padding({ left: 60, right: 60 })

}

/**
 * Author:J
 * Describe: 登录，注册页面
 */
@ComponentV2
export struct SwitchLoginTypeComp {
  @Local account: string = '鸿蒙屌爆了' //  用户名
  @Local password: string = '123456' // 密码
  @Local confirmPassword: string = '' // 确认密码
  @Local isLogin: boolean = true // 登录注册切换
  @Local selectProtocol: boolean = false; //是否勾选协议
  @Local confirm: boolean = false; //是否弹窗协议
  @Event changeFactory: (account: string, password: string, isLogin: boolean) => void = () => {
  }

  build() {
    Column() {
      Text() {
        ImageSpan($r('app.media.ic_next'))
          .width(15)
          .colorBlend($r('app.color.colorPrimary'))
          .rotate({ angle: 180 })
          .margin({ right: 8, bottom: 2 })
          .visibility(this.isLogin ? Visibility.Hidden : Visibility.Visible)
        Span(this.isLogin ? '去注册' : '去登录')
        ImageSpan($r('app.media.ic_next'))
          .width(15).colorBlend($r('app.color.colorPrimary'))
          .margin({ left: 8, bottom: 2 })
          .visibility(this.isLogin ? Visibility.Visible : Visibility.Hidden)
      }
      .fontSize(15)
      .fontColor($r('app.color.colorPrimary'))
      .onClick(() => {
        this.isLogin = !this.isLogin
        this.account = ''
        this.password = ''
        this.confirmPassword = ''
      })

      Row() {
        Image($r('app.media.ic_account_normal')).width(24).height(24)
        TextInput({ placeholder: '请输入用户名', text: `${this.account}` })
          .inputStyle()
          .onChange((value: string) => {
            this.account = value
          })
        Image($r('app.media.ic_delete')).width(14).height(14)
          .visibility(this.account.length > 0 ? Visibility.Visible : Visibility.None)
          .onClick(() => {
            this.account = ''
          })
      }.width(CommonConst.FULL_PARENT).height(44).padding({ left: 60, right: 100 }).margin({ top: 40 })

      Divider().dividerStyle()

      Row() {
        Image($r('app.media.ic_password_normal')).width(24).height(24)
        TextInput({ placeholder: '请输入密码', text: `${this.password}` })
          .inputStyle()
          .type(InputType.Password)
          .onChange((value: string) => {
            this.password = value
          })
      }.width(CommonConst.FULL_PARENT).height(44).padding({ left: 60, right: 60 })

      Divider().dividerStyle()

      Row() {
        Image($r('app.media.ic_password_normal')).width(24).height(24)
        TextInput({ placeholder: '请确认密码', text: `${this.confirmPassword}` })
          .inputStyle()
          .type(InputType.Password)
          .onChange((value: string) => {
            this.confirmPassword = value
          })
      }
      .width(CommonConst.FULL_PARENT)
      .height(44)
      .padding({ left: 60, right: 60 })
      .visibility(this.isLogin ? Visibility.None : Visibility.Visible)

      Divider().dividerStyle()
      // 协议相关
      ProtocolComp({ selectProtocol: this.selectProtocol!!, confirm: this.confirm!! })


      Button(this.isLogin ? '登录' : '注册')
        .width('80%')
        .height(44)
        .fontSize(15)
        .fontColor($r('app.color.white'))
        .backgroundColor($r('app.color.colorPrimary'))
        .margin({ top: 31 })
        .enabled(this.account.length > 0 && this.password.length > 0)
        .onClick(() => {
          if (!this.isLogin && this.password != this.confirmPassword) {
            ToastUtil.showToast('两次密码不一致')
            return
          }
          if (!this.selectProtocol) {
            // ToastUtil.showToast('' + '请勾选协议')
            this.confirm = !this.selectProtocol
            return
          }
          this.changeFactory(this.account, this.password, this.isLogin)
        })


    }
    .width(CommonConst.FULL_PARENT)
    .margin({ top: -80 })

  }
}

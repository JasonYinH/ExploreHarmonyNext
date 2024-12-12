import { ToastUtil } from '@pura/harmony-utils'
import { ListWithTabBarView, TabBarModel } from 'uicomponents'
import { CommonConst } from 'utils'
import { GetFourStyleTabData, GetOneStyleTabData, GetThreeStyleTabData, GetTwoStyleTabData } from './TestModel'

@Preview
@ComponentV2
export struct TestTabBarView {
  @Local currentTabIndex: number = 0
  @Local isShowDivider: boolean = GetOneStyleTabData[0].isShowDivider
  @Local currentTabIndex2: number = 0
  @Local currentTabIndex3: number = 0
  @Local currentTabIndex4: number = 0

  build() {
    NavDestination() {
      Column() {
        Text('第一种样式').text(Color.Red)
        ListWithTabBarView({
          currentTabIndex: this.currentTabIndex,
          tabs: GetOneStyleTabData,
          tabBarLeft: this.tabBarLeft,
          tabBarRight: this.tabBarRight,
          tabContentBuilder: this.tabContentBuilder,
          isShowDivider: this.isShowDivider,
          changeFactory: (currentTabIndex, isShowDivider) => {
            this.currentTabIndex = currentTabIndex
            this.isShowDivider = isShowDivider
          }
        }).height(80)

        Text('第二种样式').text(Color.Pink)
        ListWithTabBarView({
          currentTabIndex: this.currentTabIndex2,
          tabs: GetTwoStyleTabData,
          tabBarLeft: this.tabBarLeft2,
          tabBarRight: this.tabBarRight2,
          tabContentBuilder: this.tabContentBuilder,
          changeFactory: (currentTabIndex) => {
            this.currentTabIndex2 = currentTabIndex
          },
          isTabBarCenter: true
        }).height(80)
        Text('第三种样式').text(Color.Blue)
        ListWithTabBarView({
          currentTabIndex: this.currentTabIndex,
          tabs: GetThreeStyleTabData,
          tabBarLeft: this.tabBarLeft3,
          tabBarRight: this.tabBarRight3,
          tabContentBuilder: this.tabContentBuilder,
          isTabBarCenter: true,
          changeFactory: (currentTabIndex) => {
            this.currentTabIndex = currentTabIndex
          }
        }).height(80)

        Text('第四种样式').text(Color.Grey)
        ListWithTabBarView({
          currentTabIndex: this.currentTabIndex4,
          tabs: GetFourStyleTabData,
          tabBarLeft: this.tabBarLeft4,
          tabContentBuilder: (tab): void => this.tabContentBuilder(tab),
          isShowDivider: true,
          changeFactory: (currentTabIndex) => {
            this.currentTabIndex4 = currentTabIndex
          }
        }).layoutWeight(1)
          .height(80)
      }
      .width(CommonConst.FULL_PARENT)
      .height(CommonConst.FULL_PARENT)

    }

  }

  @Builder
  tabBarLeft() {
    Text().width(12)
  }

  @Builder
  tabBarRight() {
    Row({ space: 12 }) {
      Image($r('app.media.app_icon'))
        .width(24)
        .visibility(this.currentTabIndex == 0 || this.currentTabIndex == 1 ? Visibility.Visible : Visibility.Hidden)
        .onClick(() => {
          ToastUtil.showToast('点了1')
        })
      Image($r('app.media.app_icon')).width(24).onClick(() => {
        ToastUtil.showToast('点了')
      })
    }.padding({ right: 12 })
  }

  @Builder
  tabContentBuilder($$: TabBarModel) {
    Text($$.id)
  }

  @Builder
  tabBarLeft2() {
    Image($r('app.media.ic_arrow_left')).width(24)
      .margin({ left: 12, right: 6 })
      .onClick(() => {
        ToastUtil.showToast('返回键')
        // ZRouter.pop()
      })
  }

  @Builder
  tabBarRight2() {
    Image($r('app.media.app_icon'))
      .width(24)
      .margin({ right: 12 })
      .onClick(() => {
        ToastUtil.showToast('点了')
      })
  }

  @Builder
  tabBarLeft3() {
    Image($r('app.media.app_icon')).width(24).fillColor(Color.Black)
      .margin({ left: 12, right: 20 })
      .onClick(() => {
        ToastUtil.showToast('设置')
      })
  }

  @Builder
  tabBarRight3() {
    Image(this.currentTabIndex == 1 ? $r('app.media.ic_next') : $r('app.media.ic_local_search'))
      .width(24)
      .margin({ right: 12 })
      .visibility(this.currentTabIndex != 2 ? Visibility.Visible : Visibility.Hidden)
      .onClick(() => {
        ToastUtil.showToast(this.currentTabIndex == 1 ? '点了1' : '搜索')
      })
  }

  @Builder
  tabBarLeft4() {
    Text().width(12)
  }
}

@Extend(Text)
function text(color: ResourceColor) {
  .height(44).width(CommonConst.FULL_PARENT).fontColor(Color.White).backgroundColor(color)
}

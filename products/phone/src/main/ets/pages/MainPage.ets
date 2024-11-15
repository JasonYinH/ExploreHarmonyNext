import { Route, ZRouter } from "@hzw/zrouter"
import { AppUtil, ToastUtil } from "@pura/harmony-utils"
import { HomeView } from "home"
import { MineView } from "mine"
import { QuestionView } from "question"
import { SchemeView } from "scheme"
import { TabModel } from "uicomponents"
import { CommonConst, NavName } from "utils"
import { tabBarModel } from "../model/MainModel"

/**
 * Author:J
 * Describe: 主页
 */
// 定义一个状态变量来记录上次点击返回键的时间
let lastBackPressedTime = 0

@Preview
@ComponentV2
@Route({ name: NavName.MAIN_PAGE })
export struct MainPage {
  @Local selectedIndex: number = 0 // 当前选中的tab下标
  @Local msgCount: number = 9 // 消息数量
  //存储页面状态
  @Local tabContentArr: boolean[] = [true, false, false, false]

  aboutToAppear(): void {
    console.log(`xxx ： ---` + 'MainPage')
    console.log(`xxx获取参数 ： ---` + ZRouter.getInstance().getParamByName(NavName.MAIN_PAGE))

  }

  build() {
    NavDestination() {
      Stack() {
        Tabs({ index: this.selectedIndex, barPosition: BarPosition.End }) {
          ForEach(tabBarModel, (item: TabModel, index: number) => {
            TabContent() {
              if (this.selectedIndex === index || this.tabContentArr[index]) {
                this.tabContentBuilder(item)
              }
            }.tabBar(this.tabBottom(tabBarModel[item.index], item.index))
          }, (item: string) => item)

        }.barWidth(CommonConst.FULL_PARENT)
        .barHeight(56) //设置导航栏高度
        .scrollable(false) // 禁止左右滑动
        .onChange((index: number) => {
          this.selectedIndex = index;
          this.tabContentArr[index] = true;
        })
      }.width(CommonConst.FULL_PARENT)
      .height(CommonConst.FULL_PARENT)
    }.hideTitleBar(true)
    .width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)
    .onBackPressed(() => {
      const currentTime = new Date().getTime()
      const timeDifference = currentTime - lastBackPressedTime
      if (timeDifference < 2000) { // 2秒内再次点击
        //退出应用
        AppUtil.exit()
      } else {
        // 提示用户
        ToastUtil.showToast('再按一次退出应用')
        lastBackPressedTime = currentTime
      }

      return true
    })

  }

  @Builder
  tabContentBuilder(item: TabModel) {
    if (item.index == 0) {
      // 首页
      HomeView()
    } else if (item.index == 1) {
      // 问答
      QuestionView()
    } else if (item.index == 2) {
      // 体系
      SchemeView()
    } else if (item.index == 3) {
      // 我的
      MineView()
    }

  }

  @Builder
  tabBottom(item: TabModel, index: number) {
    Column() {
      Divider().color($r('app.color.color_F0F0F0'))
      Badge({
        count: index != 1 ? 0 : this.msgCount,
        position: BadgePosition.RightTop,
        style: {
          fontSize: 8,
          badgeSize: 13
        }
      }) {
        Image(item.selectImage /*this.selectedIndex == index ? item.selectImage : item.unSelectImage*/)
          .colorBlend(this.selectedIndex == index ? $r('app.color.colorPrimary') : $r('app.color.color_222222'))
          .height(24)
          .margin(4)
      }.margin({ top: 4 })

      Text(item.title)
        .width(CommonConst.FULL_PARENT)
        .fontSize(14)
        .fontWeight(500)
        .textAlign(TextAlign.Center)
        .fontColor(this.selectedIndex == index ? $r('app.color.colorPrimary') : $r('app.color.color_222222'))
        .margin({ bottom: 4 })
    }
    .width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)
    .backgroundColor($r('app.color.white'))

  }
}

import { CommonConst } from "utils";
import { TabBarModel } from "../model/TabBarModel";


/**
 * Author:J
 * Describe:自定义tabBar 左视图--tabBar--右视图
 *
 * ListWithTabBarView({}) List替换tabBar 配合Tabs  左视图--tabBar--右视图
 * CustomTabBarComp({}) List实现【标题+横线】选中效果
 * TabBarViewComp({})  标题+横线   List和TabContent.tabBar都可以用
 */
@Preview
@ComponentV2
export struct ListWithTabBarView {
  @Param currentTabIndex: number = 0;
  @Param tabContentArr: boolean[] = []; //存储页面状态
  private tabsController: TabsController = new TabsController();
  @Param tabs: Array<TabBarModel> = [];
  //左边视图
  @BuilderParam tabBarLeft: () => void = this.barLeft;
  //右边视图
  @BuilderParam tabBarRight: () => void = this.barRight;
  //内容
  @BuilderParam tabContentBuilder: ($$: TabBarModel) => void = this._TabContentBuilder;
  //是否显示下划线
  @Param isShowDivider: boolean = false;
  //是否滑动
  @Param scrollable: boolean = false;
  //顶部中间视图是否居中 true居中 false 默认 居左
  @Param isTabBarCenter: boolean = false;
  //选中字体颜色
  @Param selectFontColor: ResourceColor = $r('app.color.color_222222');
  //滑动条是否显示
  @Param isDividerVisible: boolean = true;
  //更新
  @Event changeFactory: (currentTabIndex: number, isShowDivider: boolean) => void = (currentTabIndex: number, isShowDivider: boolean) => {
  }

  aboutToAppear() {
    for (let index = 0; index < this.tabs.length; index++) {
      this.tabContentArr.push(index == 0 ? true : false)

    }
  }

  build() {
    Column() {
      //切换
      this.customTabBar()
      //下划线
      Divider()
        .color($r('app.color.color_F0F0F0'))
        .visibility(this.isShowDivider ? Visibility.Visible : Visibility.None)
      //TabContent中的tabBar居中显示，所以暂时不用tabBar
      Tabs({ controller: this.tabsController, barPosition: BarPosition.Start }) {
        ForEach(this.tabs, (item: TabBarModel, index: number) => {
          TabContent() {
            //滑到哪个页面再加载,防止一块加载
            if (this.currentTabIndex === index || this.tabContentArr[index]) {
              this.tabContentBuilder(item)
            }
          }

          // .tabBar()
        }, (item: string) => item)
      }
      .layoutWeight(1)
      .barHeight(0) //隐藏tabBar
      .scrollable(this.scrollable)
      .onChange(index => {
        this.tabContentArr[index] = true
        this.changeFactory(index,this.tabs[index].isShowDivider)
      })
    }.width(CommonConst.FULL_PARENT)
    .backgroundColor($r('app.color.white'))

    // .padding({ left: 12, right: 12 })

  }

  @Builder
  _TabContentBuilder($$: TabBarModel) {
    Text("tabContentBuilder:()=>{your @Builder View}")
  }

  @Builder
  customTabBar() {
    Row() {
      //左边自定义
      this.tabBarLeft()
      //中间
      CustomTabBarComp({
        currentTabIndex: this.currentTabIndex,
        tabs: this.tabs,
        selectFontColor: this.selectFontColor,
        isTabBarCenter: this.isTabBarCenter,
        onTabClick: (index: number) => {
          this.tabsController.changeIndex(index)
        },
        isDividerVisible: this.isDividerVisible
      })
      //右边自定义
      this.tabBarRight()

    }
    .width(CommonConst.FULL_PARENT)
    .height(44)
  }

  @Builder
  barLeft() {

  }

  @Builder
  barRight() {

  }
}

@ComponentV2
export struct CustomTabBarComp {
  @Param currentTabIndex: number = 0;
  @Param tabs: Array<TabBarModel> = new Array<TabBarModel>()
  //选中字体颜色
  @Param selectFontColor: ResourceColor = $r('app.color.color_222222');
  @Param onTabClick: (index: number) => void = () => {
  };
  @Param isTabBarCenter: boolean = false;
  @Param isDividerVisible: boolean = true;

  build() {

    Row() {
      List() {
        ForEach(this.tabs, (item: TabBarModel, index: number) => {
          ListItem() {
            TabBarViewComp({
              index: index,
              currentTabIndex: this.currentTabIndex,
              tabs: this.tabs,
              selectFontColor: this.selectFontColor,
              onTabClick: (index: number) => {
                this.onTabClick(index)
              },
              isDividerVisible: this.isDividerVisible
            })

          }
        })
      }
      // .width(Constants.FULL_PARENT)
      .height(44)
      .listDirection(Axis.Horizontal)
      .alignListItem(ListItemAlign.Center)
      .scrollBar(BarState.Off)

      // .margin({ right: 8 })
    }
    .layoutWeight(1)
    .justifyContent(this.isTabBarCenter ? FlexAlign.Center : FlexAlign.Start)

  }
}

@ComponentV2
export struct TabBarViewComp {
  @Param private index: number = 0
  @Param currentTabIndex: number = 0
  @Param tabs: Array<TabBarModel> = new Array<TabBarModel>()
  //选中字体颜色
  @Param selectFontColor: ResourceColor = $r('app.color.color_222222');
  @Param onTabClick: (index: number) => void = () => {
  };
  @Param isDividerVisible: boolean = true;

  build() {
    Column() {
      //右上角图片
      Image(this.tabs[this.index].rightSrc)
        .height(11)
        .margin({ left: 46 }).visibility(this.tabs[this.index].isShowRightSrc ? Visibility.Visible : Visibility.None)
      Text(this.tabs[this.index].name)
        .fontSize(this.currentTabIndex == this.index ? 16 : 14)
        .fontColor(this.currentTabIndex == this.index ? this.selectFontColor : $r('app.color.color_505050'))
        .fontWeight(this.currentTabIndex == this.index ? FontWeight.Bold : FontWeight.Normal)
        .margin({ top: this.tabs[this.index].isShowRightSrc ? 0 : 11 })

      Divider()
        .width(16)
        .height(4)
        .backgroundColor($r('app.color.colorPrimary'))
        .margin({ top: 4, bottom: 4 })
        .borderRadius(12)
        .visibility(this.isDividerVisible && this.currentTabIndex == this.index ? Visibility.Visible : Visibility.Hidden)
    }
    .margin({ right: 15 })
    .onClick(() => {
      this.onTabClick(this.index)
    })
  }
}




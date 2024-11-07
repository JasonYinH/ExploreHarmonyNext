import { CommonConst } from 'utils'
import { BaseDataSource, PageRefreshLayout } from 'uicomponents'
import { RefreshController } from '@zhongrui/pull_to_refresh_v2'

/**
 * Author:J
 * Describe: 上下拉刷新例子
 */
@Preview
@ComponentV2
export struct TestRefreshView {
  controller: RefreshController = new RefreshController()
  scroller: Scroller = new Scroller()
  dataSource: BaseDataSource<string> = new BaseDataSource<string>()
  pageNum: number = 1
  limitNum: number = 10

  aboutToAppear(): void {
    this.controller.viewLoading()
    // 模拟接口请求
    setTimeout(() => {
      this.loadData()
    }, 300)

  }

  build() {
    NavDestination() {
      PageRefreshLayout({
        controller: this.controller,
        scroller: this.scroller,
        contentView: () => {
          this.contentView()
        },
        // errorView: () => {
        //   this.errorView()
        //
        // },
        onRefresh: () => {
          this.pageNum = 1
          // 模拟接口请求
          setTimeout(() => {
            this.loadData()
          }, 300)
        },
        onLoadMore: () => {
          this.loadData()
        }
      })
        .width(CommonConst.FULL_PARENT)
        .height(CommonConst.FULL_PARENT)
        .clip(true)
        .padding({ left: 12, right: 12 })
        .backgroundColor($r('app.color.white'))
    }
    .hideTitleBar(true)
    .width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)

  }

  /** 请求接口 */
  async loadData() {
    let data: Array<string> = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    // let data:string[] = []// 空数据
    this.dataSource.pageRefresh(true, this.pageNum, data.length, data, this.controller,
      (pages: number) => {
        this.pageNum = pages
      })

  }

  // @Builder
  // errorView() {
  //   Text('暂无数据，我是errorView')
  // }
  @Builder
  contentView() {
    List({ scroller: this.scroller }) {
      LazyForEach(this.dataSource, (item: string, index: number) => {
        ListItem() {
          Text(item).fontSize(50)
        }
      })
    }.width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)
    .edgeEffect(EdgeEffect.None) // 默认带弹性效果的列表需要关闭弹性滑动
    .scrollBar(BarState.Off)
  }
}

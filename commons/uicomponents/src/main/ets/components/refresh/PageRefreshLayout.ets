
import { PullDown, PullStatus, RefreshController, RefreshLayout, RefreshLayoutConfig } from '@zhongrui/pull_to_refresh_v2'
import { CommonConst } from 'utils'


/**
 * Author:J
 * Describe: 上下拉刷新
 */
@Preview
@ComponentV2
export struct PageRefreshLayout {
  /** 控制器 */
  @Param controller: RefreshController = new RefreshController()
  /*刷新配置*/
  @Param config: RefreshLayoutConfig = new RefreshLayoutConfig()
  /** 需要将scroller设置给列表组件 */
  @Param scroller: Scroller = new Scroller()
  @Local pullDown: PullDown | undefined = undefined
  /** 内容视图 */
  @BuilderParam contentView: () => void = this._ContentView
  /** 空视图 */
  @BuilderParam emptyView: () => void = this._EmptyView
  /** 错误视图 */
  @BuilderParam errorView: () => void = this._ErrorView
  /** 刷新通知 */
  @Param onRefresh: () => void = () => {
  }
  /** 加载通知 */
  @Param onLoadMore: () => void = () => {
  }

  build() {
      Column() {
        RefreshLayout({
          /* 必传， 设置控制器*/
          controller: this.controller,
          /* 非必传，设置刷新配置，不设置时自动设置默认值*/
          config: this.config,
          /* 必传，设置和列表相关的Scroller，比如List,Grid,Scroll,WaterFlow等组件*/
          scroller: this.scroller,
          /* header视图*/
          headerView: () => {
            this.defHeaderView()
          },
          /* footer视图*/
          loadView: () => {
            this.defFooterView()
          },
          /* 内容视图*/
          contentView: () => {
            this.contentView()
          },
          /* 设置加载中视图*/
          viewLoading: () => {
            this.loadingView()
          },
          /* 设置空视图*/
          viewEmpty: () => {
            this.emptyView()
          },
          /* 设置错误视图*/
          viewError: () => {
            this.errorView()
          },
          /** 暂无更多视图 */
          noMoreView: () => {
            this.defFooterNoMoreView(this.isVerticalLayout())
          },
          /* 设置无网络视图*/
          viewNoNetwork: () => {
            this.errorView()
          },
          /* 触发刷新*/
          onRefresh: () => {
            this.onRefresh()
          },
          /* 是否可以下拉*/
          onCanPullRefresh: () => {
            if (!this.scroller.currentOffset()) {
              /*处理无数据，为空的情况*/
              return true
            }
            //如果列表到顶，返回true，表示可以下拉，返回false，表示无法下拉
            return this.scroller.currentOffset().yOffset <= 0
          },
          /* 触发加载*/
          onLoad: () => {
            this.onLoadMore()
          },
          /* 是否可以上拉*/
          onCanPullLoad: () => {
            //如果列表到底部，返回true，表示可以上拉，返回false，表示无法上拉
            return this.scroller.isAtEnd()
          },
          /* 监听下拉上拉状态，便于实现自定义动画*/
          onPullListener: (pullDown) => {
            this.pullDown = pullDown
          },


        })// .width("100%")
          // .height("100%")/******直接使用RefreshLayout必须要加这个属性*******/
          .clip(true)
      }
  }

  /** 内容视图 */
  @Builder
  _ContentView() {
    Text("contentView:()=>{your @Builder View}")
  }

  /** 自定义刷新头部 */
  @Builder
  defHeaderView() {
    Stack({ alignContent: Alignment.Center }) {
      if (this.pullDown?.status == PullStatus.PullDown || this.pullDown?.status == PullStatus.Refresh || this.pullDown?.status == PullStatus.PreRefresh) {
        Row() {
          Image($r("app.media.loading_refresh")).width(60).height(60)
        }.width('100%')
        .height(50)
        .justifyContent(FlexAlign.Center)
      } else if (this.pullDown?.status == PullStatus.RefreshSuccess) {
        // Text("刷新成功").textExtend()
      } else if (this.pullDown?.status == PullStatus.RefreshError) {
        Text("刷新失败,请重新尝试").textExtend()
      }

    }.height(50).width("100%")

  }

  /** 自定义刷新尾部 */
  @Builder
  defFooterView() {
    Stack({ alignContent: Alignment.Center }) {
      if (this.pullDown?.status == PullStatus.PullUp || this.pullDown?.status == PullStatus.Load || this.pullDown?.status == PullStatus.PreLoad) {
        Row() {
          Image($r("app.media.loading_refresh"))
            .width(24)
            .height(24)
        }.width('100%')
        .height(60)
        .justifyContent(FlexAlign.Center)
      } else if (this.pullDown?.status == PullStatus.LoadSuccess) {
        // Text("加载完成").textExtend()
      } else if (this.pullDown?.status == PullStatus.LoadError) {
        Text('加载失败,请重新尝试').textExtend()
      }

    }.height(50).width("100%")

  }

  /** loading视图 */
  @Builder
  loadingView() {
    this.layout($r('app.media.loading_refresh'), '正在加载...')
  }

  /** 空视图 */
  @Builder
  _EmptyView() {
    this.layout($r('app.media.nodata'), '暂无数据')
  }

  /** 错误视图 */
  @Builder
  _ErrorView() {
    this.layout($r('app.media.no_network'), '暂无网络,请重新尝试')
  }

  /** 视图公用 */
  @Builder
  layout(src: ResourceStr, text: ResourceStr) {
    Column() {
      Image(src).width(48).height(48)
      Text(text).fontSize(12).fontColor($r('app.color.color_999999')).padding(8)
    }.width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)
    .justifyContent(FlexAlign.Center)
  }

  /**
   * 暂无更多
   * @param isV 是否竖向
   */
  @Builder
  defFooterNoMoreView(isV: boolean) {
    Text('没有更多数据了')
      .textAlign(TextAlign.Center)
      .height(isV ? 50 : CommonConst.FULL_PARENT)
      .width(isV ? CommonConst.FULL_PARENT : 50)
      .fontSize(14)
      .fontColor($r('app.color.color_999999'))
  }

  private isVerticalLayout(): boolean {
    return (this.config.isVertical || this.config.horizontalMode == 1 || this.config.horizontalMode == 2)
  }
}

@Extend(Text)
function textExtend() {
  .fontColor($r('app.color.color_8A000000'))
  .fontSize(14)
}


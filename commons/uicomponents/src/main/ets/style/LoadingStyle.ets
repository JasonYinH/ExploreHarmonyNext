export { loadingNetView, loadingView }

/**
 * Author:J
 * Describe:自定义页面loading
 */

/** 目前网络请求不支持传loading文字 */
@Builder
function loadingNetView() {
  Column() {
    loadingBuilder()
  }
  .border({
    width: 1,
    radius: 8,
    color: $r('app.color.color_F0F0F0')
  })
}

@Builder
function loadingView(args: ResourceStr = '正在加载中...') {
  loadingBuilder(args)
}

@Builder
function loadingBuilder(args?: ResourceStr) {
  Column() {
    Image($r('app.media.loading_refresh')).width(50).height(50)
    Text(args ? args : '正在加载中...')
      .fontSize(11)
      .fontColor($r('app.color.color_222222'))
      .margin({ top: 11 })
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })

  }
  .width(120)
  .height(120)
  .justifyContent(FlexAlign.Center)
  .backgroundColor(Color.White)
  .borderRadius(12)
}



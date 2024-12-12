import { TabHorizontalModel } from "uicomponents";

/** 横向Tab */
export const horizontalTabItemData: Array<TabHorizontalModel> = [
  new TabHorizontalModel("我的积分", 0, $r('app.media.ic_coin'), true, '666', true),
  new TabHorizontalModel("我的分享", 1, $r('app.media.ic_share_article'), true),
  new TabHorizontalModel("我的收藏", 2, $r('app.media.ic_collect'), true),
  new TabHorizontalModel("我的书签", 3, $r('app.media.ic_read_later'), true),
  new TabHorizontalModel("阅读历史", 4, $r('app.media.ic_read_record'), true),
  new TabHorizontalModel("开源项目", 5, $r('app.media.ic_github'), true),
  new TabHorizontalModel("关于作者", 6, $r('app.media.ic_about'), true, '请他喝杯咖啡~', true),
]

import { TabModel } from "uicomponents";


/**
 * 首页底部Tab显示数据
 */
export const tabBarModel: Array<TabModel> = [
  {
    index: 0,
    title: '首页',
    selectImage: $r('app.media.ic_bottom_bar_home'),
  },
  {
    index: 1,
    title: '问答',
    selectImage: $r('app.media.ic_bottom_bar_ques'),
  },
  {
    index: 2,
    title: '体系',
    selectImage: $r("app.media.ic_bottom_bar_scheme"),
  },
  {
    index: 3,
    title: '我的',
    selectImage: $r('app.media.ic_bottom_bar_mine'),
  }

]

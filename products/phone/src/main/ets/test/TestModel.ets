import { TabBarModel } from "uicomponents";


/** 样式1 */
export const GetOneStyleTabData: TabBarModel[] = [
  new TabBarModel('1', '热搜', true),
  new TabBarModel('2', '发现'),
  new TabBarModel('3', '关注', true),
  new TabBarModel('4', '短剧')
]

/** 样式2 */
export const GetTwoStyleTabData: Array<TabBarModel> = [
  new TabBarModel('1', '热搜榜', true),
  new TabBarModel('2', '小说榜', true),
  new TabBarModel('3', '短剧榜', false, true),
]

/** 样式3 */
export const GetThreeStyleTabData: Array<TabBarModel> = [
  new TabBarModel('1', '电影榜点'),
  new TabBarModel('2', '电视榜点'),
  new TabBarModel('3', '动漫榜点'),
  new TabBarModel('4', '综艺榜点'),
]
/** 样式4 */
export const GetFourStyleTabData: TabBarModel[] = [
  new TabBarModel('11', '实时热点'),
  new TabBarModel('22', '今日榜点情况'),
  new TabBarModel('33', '昨日榜点情况'),
  new TabBarModel('44', '最新热点'),
  new TabBarModel('55', '预估热点')
]

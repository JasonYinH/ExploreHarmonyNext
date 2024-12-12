@ObservedV2
export class TabHorizontalModel {
  title: string;
  index: number; //下标
  icon: string | Resource;
  hasIcon: boolean; //是否显示图
  @Trace rightTitle: string;
  hasRightTitle: boolean;
  @Trace hasNew: boolean; //是否显示红点
  hasRightIcon: boolean; //是否显示图

  constructor(title: string, index: number = -1, icon: string | Resource = '', hasIcon: boolean = false, rightTitle: string = '', hasRightTitle: boolean = false, hasNew: boolean = false,
    hasRightIcon: boolean = true) {

    this.icon = icon;
    this.hasIcon = hasIcon;
    this.title = title;
    this.rightTitle = rightTitle;
    this.hasRightTitle = hasRightTitle;
    this.hasNew = hasNew && rightTitle !== '';
    this.index = index;
    this.hasRightIcon = hasRightIcon;
  }
}

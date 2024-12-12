export class TabBarModel {
  id: string;
  name: string;
  isShowDivider: boolean; //是否显示下划线
  isShowRightSrc: boolean; //是否显示右上角标识
  rightSrc: string | PixelMap | Resource; //右上角标识

  constructor(id: string, name: string, isShowDivider: boolean = false, isShowRightSrc: boolean = false,
    rightSrc: string | PixelMap | Resource = $r('app.media.ic_new')) {
    this.id = id
    this.name = name
    this.isShowDivider = isShowDivider
    this.isShowRightSrc = isShowRightSrc
    this.rightSrc = rightSrc
  }
}

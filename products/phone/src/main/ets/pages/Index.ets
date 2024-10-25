// import { TestOne } from 'wechat/src/main/ets/components/TestOne';
import { TestOne } from 'wechat';

@Entry
@ComponentV2
struct Index {
  @Local message: string = '探索 HarmonyOS NEXT(5.0)';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('text1')
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
     // 调用模块wechat的TestOne
           TestOne()



    }
    .height('100%')
    .width('100%')
  }
}
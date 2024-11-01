
import { CommonConst } from 'utils';
import { MainPage } from './MainPage';

@Entry
@ComponentV2
struct Index {
  @Local message: string = '探索 HarmonyOS NEXT(5.0)';

  build() {
    Column() {
      MainPage()
    }.width(CommonConst.FULL_PARENT)
    .height(CommonConst.FULL_PARENT)

  }
}
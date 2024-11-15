import { CommonConst } from 'utils'

@Preview
@ComponentV2
export struct HomeView {
  aboutToAppear(): void {
    console.log(`xxx ： ---` + 'HomeView')

  }

  build() {
    NavDestination() {
      Column() {
        Text('HomeView')
      }
      .width(CommonConst.FULL_PARENT)
      .height(CommonConst.FULL_PARENT)
      .justifyContent(FlexAlign.Center)
    }

  }
}

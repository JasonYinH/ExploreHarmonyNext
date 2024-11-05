import { Route } from "@hzw/zrouter"
import { NavName } from "utils"

@Preview
@ComponentV2
export struct HomeView {
  aboutToAppear(): void {
    console.log(`xxx ： ---` + 'HomeView')

  }

  build() {
    NavDestination(){
      Column() {
        Text('HomeView')
      }
    }

  }
}

@Preview
@ComponentV2
export struct HomeView {
  aboutToAppear(): void {
    console.log(`xxx ： ---` + 'HomeView')

  }

  build() {
    Column() {
      Text('HomeView')
    }
  }
}
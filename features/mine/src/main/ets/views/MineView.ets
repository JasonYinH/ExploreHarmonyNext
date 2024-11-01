@Preview
@ComponentV2
export struct MineView {
  aboutToAppear(): void {
    console.log(`xxx ： ---` + 'MineView')

  }

  build() {
    Column() {
      Text('MineView')
    }
  }
}
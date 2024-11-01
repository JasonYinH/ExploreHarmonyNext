@Preview
@ComponentV2
export struct SchemeView {
  aboutToAppear(): void {
    console.log(`xxx ： ---` + 'SchemeView')

  }

  build() {
    Column() {
      Text('SchemeView')
    }
  }
}
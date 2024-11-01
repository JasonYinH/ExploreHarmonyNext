@Preview
@ComponentV2
export struct QuestionView {
  aboutToAppear(): void {
    console.log(`xxx ： ---` + 'QuestionView')
  }

  build() {
    Column() {
      Text('QuestionView')
    }
  }
}
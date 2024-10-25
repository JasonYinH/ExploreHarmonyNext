@Preview
@ComponentV2
export  struct TestOne {
  aboutToAppear(): void {
    console.log(`xxx ： ---aboutToAppear`)

  }

  build() {
    Text('我是来自于模块wechat的TextOne')
  }
}
import { Route } from '@hzw/zrouter';
import json from '@ohos.util.json';
import { PhoneService } from '../service/PhoneService';
import { ToastUtil } from '@yunkss/ef_ui';
import { OhosSmartDialog, SmartDialog } from 'ohos_smart_dialog';

@Preview
@Route({ name: 'TestNetView', description: "网络页" })
@ComponentV2
export struct TestNetView {
  @Local message: string = 'TestNetView'

  private getArray(): Array<number> {
    let array: number[] = []
    for (let index = 0; index < 20; index++) {
      array.push(index)
    }
    return array
  }

  build() {
    NavDestination() {

      Column() {
        Text("SmartDialog").onClick(() => {
          // SmartDialog.showLoading()
        })
        // Text('点我啊\n'+this.message)
        Text('点我啊\n'/*+json.stringify(loginModel.result)*/)
          .fontSize(20)
          .fontWeight(FontWeight.Bold).onClick(async () => {
          SmartDialog.showLoading()
          //登录
          let login = await PhoneService.login({
            'username': '鸿蒙',
            'password': '5.0'
          })
          console.log('xxxlogin--' + '' + json.stringify(login))
          if (login.data?.getSuccess()) {
            this.message = json.stringify(login.data.getData())
            console.log('xxxxxdata参数--' + '' + json.stringify(login.data.getData()))
          } else {
            console.log('xxx--' + login.data?.getMsg())
            ToastUtil.showToast(login.data?.getMsg())
          }
          // SmartDialog.dismiss()

        })

      }
      .width('100%')
      .height('100%')
    }.onBackPressed(OhosSmartDialog.onBackPressed())

  }
}


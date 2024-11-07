import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { ZRouter } from '@hzw/zrouter';
import BuildProfile from 'BuildProfile';
import { ResponseInterceptor } from 'network';
import { efRcp } from '@yunkss/ef_rcp';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    // 如果项目中存在hsp模块则传入true
    ZRouter.initialize((config) => {
      config.isLoggingEnabled = BuildProfile.DEBUG
      config.isHSPModuleDependent = false
    })
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });

    // 网络配置相关
    this.netConfig()

  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }


  async netConfig() {

    // if(运行环境===debug){
    efRcp
      .setBaseURL("https://www.wanandroid.com")//设置请求路径
      .enableLogInterceptor()//设置为false即可关闭
      .setLoadingContent('正在加载中...')//更改loading文本
      .disableLoading()
      .convertError(true)//表示如果response.toJSON()异常时将响应字符串返回,false则表示值返回异常提醒而不返回结果
      .addCommonHeaders({//设置公共头
        "version": `V1.0.0`
      })// .setLoadingImg(wrapBuilder(loadingImg)) //设置loading为gif图片
      .addCustomInterceptors([new ResponseInterceptor()])
      .addSysCodeEvent({//添加统一系统框架级别编码处理逻辑,如超时等
        listener: (code: number) => {
          // Log.d('---------addSysCodeEvent监听事件-----' + code)
          switch (code) {
            case -1001:
            case 401:
              console.log(`xxx ： ---跳转登录页面，清空一些数据等`)
              //跳转登录页面，清空一些数据等
              // ZRouter.replacePathByName('LoginPage')
              break;
          }
        }
      })//创建session对象,需要再设置为一系列操作后再调用，否则设置不生效,可在特殊情况处设置其他操作后重新创建session
      .create()//获取统一的session对象，必须在create后调用 .设置了全局的配置比如拦截器  超时时间  session本身的配置 ，需要再次create
      .builder();
    // }

  }
}

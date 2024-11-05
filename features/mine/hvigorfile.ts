import { harTasks } from '@ohos/hvigor-ohos-plugin';
// // 1、导入
// import { routerRegisterPlugin, PluginConfig } from 'router-register-plugin'
//
// // 2、初始化配置
// const config: PluginConfig = {
//   //scanDirs: ['src/main/ets/pages', 'src/main/ets/views'],  // 扫描的目录，如果不设置，默认是扫描src/main/ets目录
//   logEnabled: true, // 日志记录开关
//   viewNodeInfo: false, // 查看节点信息
//   isAutoDeleteHistoryFiles: true // 删除无用编译产物
//
// }

export default {
  system: harTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  // 3、添加插件
  plugins: [/*routerRegisterPlugin(config)*/] /* Custom plugin to extend the functionality of Hvigor. */
}

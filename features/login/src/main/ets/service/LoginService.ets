import { efRcpClientApi } from "@yunkss/ef_rcp";
import { BaseResponse } from "network/src/main/ets/model/BaseResponse";


export class LoginService {
  /**
   * 登录
   * 方法： POST
   * 参数：
   * username，password
   * 登录后会在cookie中返回账号密码，只要在客户端做cookie持久化存储即可自动登录验证。
   */
  static login(query: Record<string, Object>) {
    return efRcpClientApi.postForm<BaseResponse<object>>({
      url: 'user/login',
      query: query,
    });
  }
}


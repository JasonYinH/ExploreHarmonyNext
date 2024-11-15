import { rcp } from '@kit.RemoteCommunicationKit';
import { ToastUtil } from '@pura/harmony-utils';
import { BaseResponse } from '../model/BaseResponse';

/**
 * Author:J
 * Describe:  响应内容拦截器
 */
export class ResponseInterceptor implements rcp.Interceptor {
  /**
   * 拦截核心
   * @param context
   * @param next
   * @returns
   */
  async intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    try {
      //获取响应结果
      const response = await next.handle(context);
      //转换成object
      let result = response.toJSON();

      //考虑几种常见数据返回的
      // {"code":200,"message":"success","data":{"isCheck":"0"}}
      // {"status":"1","msg":"success","result":{"data":{"ticket":"xxxx"}}}
      // {"data": ..., "errorCode": 0, "errorMsg": ""} errorCode = 0 代表执行成功.errorCode = -1001 代表登录失效，需要重新登录

      //1.成功失败标识
      let success: boolean = true;
      //2.返回的消息提示
      let message: string = '';
      //3.返回的数据
      let data: Record<string, Object> = {};
      //4.返回请求状态码
      let code = response.statusCode + '';

      if (result) {
        Object.entries(result).forEach((item: object) => {

          if (["errorCode", "code", "status"].includes(String(item[0]))) {
            code = String(item[1])
            success = disposeCode(String(item[1]));
          }
          if (["errorMsg", "message", "msg"].includes(String(item[0]))) {
            message = String(item[1]);
          }
          if (["data", "result"].includes(String(item[0]))) {
            data = item[1];
          }
        })
      }
      // HTTP status code
      if (response.statusCode != 200) {
        success = false;
        message = (response.toString() as string) ? response.toString() as string : "网络错误";
      }
      //返回统一格式
      let baseResponse = new BaseResponse(success, disposeMsg(code, message), data, code);
      // console.log(`xxx转换后Response ： ---` + JSON.stringify(baseResponse))

      //对响应修改
      const toReturn: rcp.Response = {
        request: response.request,
        statusCode: response.statusCode,
        headers: response.headers,
        effectiveUrl: response.effectiveUrl,
        body: response.body,
        downloadedTo: response.downloadedTo,
        timeInfo: response.timeInfo,
        httpVersion: response.httpVersion,
        reasonPhrase: response.reasonPhrase,
        toString: () => response.toString(),
        toJSON: () => baseResponse
      };
      return toReturn;
    } catch (error) {
      //抛出
      return Promise.reject(error);
    }
  }
}

/** 处理不同接口返回的码.errorCode = 0 || code==200 || status==1 为成功 */
export function disposeCode(s: string): boolean {
  let isSuccess: boolean = false;
  if ("0" == s || "200" == s || "1" == s) {
    isSuccess = true;
  }
  return isSuccess;
}


/** 处理信息 */
export function disposeMsg(code: string, msg: string): string {
  let message = "";
  switch (code) {
    case '-1001':
    case '401':
      message = "登陆信息过期，请重新登陆";
      break;
    case '403':
      message = "账号异常，请联系客服";
      break;
    case '429':
      message = "您的操作过于频繁，请稍后再试！";
      break;
    case '500':
      message = "服务器错误(500)";
      break;
    default:
      message = `${msg}`;
  }
  const errorCodes = ['401', '403', '429', '500'];
  if (errorCodes.includes(code)) {
    //吐司
    ToastUtil.showToast(message);
  }
  return message;
}


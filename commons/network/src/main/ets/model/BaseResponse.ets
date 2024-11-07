/**
 * Author:J
 * Describe: 输出对象
 */
export class BaseResponse<T> {
  //成功失败标识
  private success: boolean;
  //返回提示信息
  private msg: string;
  //响应编码
  private code: string | number;
  //返回数据
  private data: T;

  /**
   * 构造函数
   * @param success  是否成功标识
   * @param msg   提示消息
   * @param data  数据
   */
  constructor(success: boolean, msg: string, data: T, code: string | number) {
    this.msg = msg;
    this.success = success;
    this.code = code;
    this.data = data;
  }

  /**
   * 创建空实例
   * @returns
   */
  static create(): BaseResponse<string> {
    let baseResponse = new BaseResponse<string>(true, '', '', 200);
    return baseResponse;
  }


  /**
   * 成功-只包含消息
   * @param msg   提示消息
   * @returns
   */
  static OK(msg: string): BaseResponse<string> {
    let baseResponse = new BaseResponse<string>(true, msg, '', 200);
    return baseResponse;
  }

  /**
   * 成功-包含单行数据
   * @param msg  提示消息
   * @param data  单行数据
   * @returns
   */
  static OKByData<T>(msg: string, data: T): BaseResponse<T> {
    let dto = new BaseResponse<T>(true, msg, data, 200);
    return dto;
  }


  /**
   * 失败-包含提示消息
   * @param msg 提示消息
   * @returns
   */
  static Error(msg: string): BaseResponse<string> {
    let dto = new BaseResponse<string>(false, msg, '', 400);
    return dto;
  }

  /**
   * 失败-包含单行数据
   * @param msg 提示消息
   * @param data 单行数据
   * @returns
   */
  static ErrorByData<T>(msg: string, data: T): BaseResponse<T> {
    let dto = new BaseResponse<T>(false, msg, data, 400);
    return dto;
  }

  public setSuccess(success: boolean) {
    this.success = success;
  }

  public getSuccess(): boolean {
    return this.success;
  }


  public getCode(): string | number {
    return this.code;
  }

  public setCode(code: string | number) {
    this.code = code;
  }


  public getMsg(): string {
    return this.msg;
  }

  public setMsg(msg: string) {
    this.msg = msg;
  }


  public getData(): T {
    return this.data;
  }

  public setData(data: T) {
    this.data = data;
  }
}

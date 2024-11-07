import { efRcpClientApi, EfRcpResponse } from "@yunkss/ef_rcp";
import { BaseResponse } from "network/src/main/ets/model/BaseResponse";


export class PhoneService {
  static login(query: Record<string, Object>): Promise<EfRcpResponse<BaseResponse<object>>> {
    return efRcpClientApi.post<BaseResponse<object>>({
      url: 'user/login',
      query: query,
    });
  }
}



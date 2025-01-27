// 1.导入封装的http请求
import { Http } from 'basic'
import { AccountFormModel, UserInfoModel, UserTaskInfoModel, UserTaskInfoParamsModel } from '../models'

// 2.导出并创建对应接口方法
// 3.给参数以及返回的数据指定类型

/*
 * 登录接口
 * */
export const loginApi = (data: AccountFormModel): Promise<string> => {
  return Http.post<string>("login/account", data)
}

/*
 * 获取用户信息接口
 *  1.封装用户信息的API接口
 *  2.定义接口返回的数据类型
 *  3.在我的页面创建一个变量，保存获取到的用户信息
 *  4.调用获取用户信息接口
 *  5.渲染用户信息接口数据
 *  6.根据业务需求优化接口请求
 * */
export const getUserInfoApi = (): Promise<UserInfoModel> => {
  return Http.get<UserInfoModel>("/users")
}


/*
 * 获取任务数据的接口
 *
 * */
export const getUserTaskInfoApi = (params: UserTaskInfoParamsModel): Promise<UserTaskInfoModel> => {
  return Http.get<UserTaskInfoModel>("/users/taskReport", params)
}



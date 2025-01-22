// 封装http
//  1.安装axios
//  2.引入axios
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import { UserSettingClass } from '../../../../Index';
import { BASE_URL } from '../constants';

//  3.创建axios实例对象
const service = axios.create({
  baseURL: BASE_URL,
  timeout: 10000
})

//  4.创建请求拦截器
service.interceptors.request.use((config: InternalAxiosRequestConfig) => {

  // token 本地 首选项当中
  // 获取token
  const setting = new UserSettingClass(getContext())
  const token = setting.getUserToken()
  // 如果token存在
  if (token) {
    // 将token通过请求头(headers)发送给后台
    config.headers.Authorization = token
  }

  return config;
}, (error: AxiosError) => {
  return Promise.reject(error);
});

//  5.创建响应拦截器
service.interceptors.response.use((response: AxiosResponse) => {
  // 状态码为200且业务码的状态也为200时再返回数据
  if (response.status === 200 && response.data.code === 200) {
    return response.data.data
  }
  // return response
}, (error: AxiosError) => {
  return Promise.reject(error);
});

//  6.创建自定义的请求方式
class Http {
  static get<T>(url: string, params?: object) {
    return service.get<null, T>(url, { params })
  }

  static post<T>(url: string, data?: object) {
    return service.post<null, T>(url, data)
  }

  static put<T>(url: string, data?: object) {
    return service.put<null, T>(url, data)
  }

  static delete<T>(url: string, data?: object) {
    return service.delete<null, T>(url, data)
  }
}

//  7.导出自定义的请求方法
export {
  Http
}
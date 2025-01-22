// 如果只是某些页面使用而不是公共的，那么就放在hap包里面
// 登录接口
export interface AccountFormModel {
  // 登陆账号
  account: string
  // 登陆密码
  password: string
}

// 用户信息接口返回的数据类型
export interface UserInfoModel {
  // 头像
  avatar: string
  // 姓名
  name: string
  // 司机编号
  number: string
  // 手机号
  phone: string
}
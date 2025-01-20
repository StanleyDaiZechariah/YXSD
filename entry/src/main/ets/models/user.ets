// 如果只是某些页面使用而不是公共的，那么就放在hap包里面
export interface AccountFormModel {
  // 登陆账号
  account: string
  // 登陆密码
  password: string
}
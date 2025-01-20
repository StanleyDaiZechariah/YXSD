import { loginApi } from '../../api/user'
import { AccountFormModel } from '../../models/user'
import { router } from '@kit.ArkUI'
import { UserSettingClass } from 'basic'

/*
 * 我们在按钮这里做了几件事情：
 *  1、给按钮绑定点击事件
 *  2、定义保存账号与密码变量
 *  3、将变量与输入框进行双向绑定
 *  4、进行账号与密码的表单校验
 * */

@Entry
@Component
struct Login {
  // 控制加载功能
  @State showLoading: boolean = false
  // 存储用户账户信息
  @State
  accountForm: AccountFormModel = {
    account: '',
    password: ''
  }

  // 登录方法
  async submitLogin() {
    // 控制显示loading
    this.showLoading = true

    // 调用登录接口
    try {
      const res = await loginApi(this.accountForm)

      // TODO: 将token存储到本地（首选项）
      // 调用存储token的方法
      const setting = new UserSettingClass(getContext())
      setting.setUserToken(res)

      // TODO:跳转到首页
      router.pushUrl({
        url: "pages/Index"
      })
    } catch (e) {
      AlertDialog.show({
        message: "登陆失败！"
      })
    } finally {
      this.showLoading = false
    }
  }

  // 账号与密码非空状态处理
  getFormValidate() {
    // 如果账号或者密码为空则返回false，否则返回true
    if (this.accountForm.account && this.accountForm.password) {
      return true
    } else {
      return false
    }
  }

  @Styles
  loginStyles() {
    .backgroundColor("#fff")
    .height(58)
    .border({
      width: {
        bottom: 1
      },
      color: $r('app.color.background_divider')
    })
    .borderRadius(0)
  }

  build() {
    Column() {
      // 顶部标题
      Text('小时达')
        .fontSize(18)
        .height(28)
        .fontColor($r('app.color.text_primary'))
        .fontWeight(FontWeight.Bold)


      // 账号登录的标题
      Row() {
        Text('账号登录')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)

        Row() {
          Text('手机号登陆')
            .fontSize(16)
            .fontWeight(600)
            .fontColor($r('app.color.primary'))

          Image($r('app.media.ic_angle'))
            .width(10)
            .aspectRatio(1)
            .margin({ left: 5 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 50, bottom: 50 })

      // 账号输入框
      TextInput({ placeholder: '请输入账号', text: $$this.accountForm.account })// 此处使用了api12支持的双向绑定
        .loginStyles()
      // .onChange((value) => { // 倘若不能使用双向绑定的，那么使用另一个onChange方法
      //   this.accountForm.account = value
      // })

      // 密码输入框
      TextInput({ placeholder: '请输入密码', text: $$this.accountForm.password })
        .loginStyles()
        .type(InputType.Password)
        .showPasswordIcon((this.accountForm.password != '') ? true : false)

      // 登录按钮
      Button({ type: ButtonType.Capsule }) {
        Row() {
          if (this.showLoading) {
            LoadingProgress()
              .width(20)
              .height(20)
              .color($r('app.color.white'))
              .margin({
                right: 12
              })
          }

          Text('登录')
            .fontColor($r('app.color.white'))
        }
      }
      .width('100%')
      .height(50)
      .backgroundColor(this.getFormValidate() ? $r('app.color.primary') : $r('app.color.primary_disabled'))
      .margin({
        top: 50
      })
      .enabled(this.getFormValidate() ? true : false)
      .onClick(() => {
        this.submitLogin()
      })

    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32 })
    .margin({ top: 40 })
  }
}
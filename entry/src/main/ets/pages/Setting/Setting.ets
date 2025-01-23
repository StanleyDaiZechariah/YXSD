import { ICard, ICardItem, IConfirm, INavBar } from 'basic'

@Entry
@Component
struct Setting {
  // 模拟以后可能从后端接收的数据，采用循环渲染
  @State
  cardTitle: string[] = ["换绑手机", "修改密码", "消息通知设置", "清理缓存"]
  // 1.实例化弹窗对象
  controller: CustomDialogController = new CustomDialogController({
    // 2.定义弹窗的内容
    builder: IConfirm({
      message: '确定删除弹窗吗？'
    }),
    // 取消默认弹窗样式
    customStyle: true
  })

  build() {
    Column() {
      // 系统设置标题栏
      INavBar({
        title: "系统设置",
      })
        .margin({ bottom: 20 })

      // 选项列表
      ICard() {
        ForEach(this.cardTitle, (item: string) => {
          ICardItem({
            leftText: item
          })
        })
      }

      // 退出按钮
      Row() {
        Button('退出登录', { type: ButtonType.Normal })
          .width('100%')
          .height(60)
          .backgroundColor($r('app.color.white'))
          .fontColor($r('app.color.text_primary'))
          .borderRadius(8)
          .onClick(() => {
            // 3.打开弹窗
            this.controller.open()
          })

      }
      .width('100%')
      .padding({
        left: 15,
        right: 15
      })
      .margin({
        top: 20
      })

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}
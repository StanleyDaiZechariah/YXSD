import { CustomDialogModel } from '../models'


@CustomDialog
@Component
export struct IConfirm {
  // 自定义弹窗的控制器
  controller: CustomDialogController
  // 弹窗的文本
  message: string = '确定退出登陆吗？'
  // 弹出框的按钮列表
  buttonList: CustomDialogModel[] = [
    {
      text: "取消",
      fontColor: $r('app.color.primary'),
      fontSize: 18

    },
    {
      text: "确定",
      fontColor: $r('app.color.primary'),
      action: () => {
        AlertDialog.show({
          message: "aaa"
        })
      },
      fontSize: 18
    }
  ]

  build() {
    Row() {
      Column() {
        Row() {
          Text(this.message)
            .fontSize(16)
            .fontColor($r('app.color.text_primary'))
            .fontWeight(400)
        }
        .width('100%')
        .height(88)
        .justifyContent(FlexAlign.Center)
        .border({
          width: {
            bottom: 1
          },
          color: $r('app.color.background_divider')
        })

        Row() {

          ForEach(this.buttonList, (item: CustomDialogModel, index: number) => {
            Text(item.text)
              .fontSize(item.fontSize || 16)
              .fontColor(item.fontColor || $r('app.color.text_secondary'))
              .height('100%')
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
              .border({
                width: {
                  // 如果按钮列表不为空且不是最后一个按钮就令按钮右边出现分割线
                  right: this.buttonList.length > 1 && index !== this.buttonList.length - 1 ? 1 : 0
                },
                color: $r('app.color.background_divider')
              })
              .onClick(() => {
                if (item.action) {
                  item.action()
                }
                this.controller.close()
              })
          })

        }
        .width('100%')
        .height(50)
      }
      .width('100%')
      .backgroundColor($r('app.color.white'))
      .borderRadius(12)

    }
    .width('100%')
    .padding({
      left: 25,
      right: 25
    })
  }
}
import { ICard, ICardItem, INavBar } from 'basic'

@Entry
@Component
struct Setting {
  // 模拟以后可能从后端接收的数据，采用循环渲染
  @State
  cardTitle: string[] = ["换绑手机", "修改密码", "消息通知设置", "清理缓存"]
  // 1.实例化弹窗对象
  controller: CustomDialogController = new CustomDialogController({
    builder: this.IConfirm,
    // 取消默认弹窗样式
    customStyle: true
  })

  // 2.定义弹窗的内容
  @Builder
  IConfirm() {
    Row() {
      Column() {
        Row() {
          Text('确定退出登陆吗？')
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
          Text('取消')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .height('100%')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
            .border({
              width: {
                right: 1
              },
              color: $r('app.color.background_divider')
            })

          Text('确定')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .height('100%')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
            .border({
              width: {
                right: 1
              },
              color: $r('app.color.background_divider')
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
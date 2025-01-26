@Component
export struct TaskItemCard {
  build() {
    Column() {
      // 任务编号
      Row() {
        Text("任务编号：123123")
          .fontSize(16)
          .fontWeight(500)
          .lineHeight(24)
          .fontColor($r('app.color.text_primary'))

        Text("已延迟")
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // 起始点与终点的地址
      Row() {
        Text('起')
          .width(22)
          .height(22)
          .fontColor($r('app.color.white'))
          .fontSize(12)
          .textAlign(TextAlign.Center)
          .backgroundColor($r('app.color.text_primary'))
          .borderRadius(11)

        Text('我爱你你爱我')
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .margin({
            left: 12
          })

      }
      .width('100%')
      .margin({
        top: 20
      })
      .alignItems(VerticalAlign.Top)

      Row() {
        Text('终')
          .width(22)
          .height(22)
          .fontColor($r('app.color.white'))
          .fontSize(12)
          .textAlign(TextAlign.Center)
          .backgroundColor($r('app.color.primary'))
          .borderRadius(11)

        Text('我爱果汁')
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .margin({
            left: 12
          })

      }
      .width('100%')
      .margin({
        top: 20,
        bottom: 20
      })
      .alignItems(VerticalAlign.Center)

      Divider()
        .strokeWidth(1)
        .color($r('app.color.background_divider'))
        .margin({
          bottom: 20
        })

      // 提货时间与提货按钮
      Row() {
        Column({ space: 5 }) {
          Text('提货时间')
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))

          Text('2022.05.04 13:00')
            .fontColor($r('app.color.text_primary'))
            .fontSize(14)
        }
        .alignItems(HorizontalAlign.Start)

        Button('提货', { type: ButtonType.Capsule })
          .backgroundColor($r('app.color.primary'))
          .fontColor($r('app.color.white'))
          .fontSize(14)
          .height(32)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .width('100%')
    .backgroundColor($r('app.color.white'))
    .borderRadius(10)
    .padding(20)
  }
}
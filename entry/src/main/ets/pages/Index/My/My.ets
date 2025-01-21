@Entry
@Component
struct My {
  build() {
    Column() {
      // 用户信息模块
      Column() {
        // 汽车图标
        Image($r('app.media.ic_avatar_driver'))
          .width(67)
          .aspectRatio(1)
          .borderRadius(34)

        Text('李立明')
          .fontSize(18)
          .fontWeight(400)
          .fontColor($r('app.color.white'))
          .lineHeight(25)
          .margin({
            top: 9,
            bottom: 9
          })

        Text("司机编号：666666")
          .fontSize(14)
          .fontWeight(400)
          .fontColor($r('app.color.white'))
          .lineHeight(20)

        Text("手机号：178090802342")
          .fontSize(14)
          .fontWeight(400)
          .fontColor($r('app.color.white'))
          .lineHeight(20)
          .margin({ top: 10 })
      }
      .width('100%')
      .height(292)
      .backgroundImage($r('app.media.bg_page_my'))
      .backgroundImageSize(ImageSize.Cover)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // 本月任务
      Column() {
        Text("- 本月任务 -")
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .lineHeight(20)

        Row() {
          Column() {
            Text("18")
              .fontSize(18)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(25)
              .margin({ bottom: 17 })

            Text("任务总量")
              .fontSize(12)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(17)
          }

          Column() {
            Text("18")
              .fontSize(18)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(25)
              .margin({ bottom: 17 })

            Text("完成任务量")
              .fontSize(12)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(17)
          }

          Column() {
            Text("3987")
              .fontSize(18)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(25)
              .margin({ bottom: 17 })

            Text("运输里程")
              .fontSize(12)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(17)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.SpaceAround)
      }
      .height(134)
      .borderRadius(8)
      .margin({
        left: 16,
        right: 16,
        top: -55
      })
      .padding({ top: 14, bottom: 14 })
      .backgroundColor($r('app.color.white'))
      .justifyContent(FlexAlign.SpaceBetween)


      // 选项列表

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}

export default My
@Component
export struct IUpLoad {
  @State
  title: string = ''

  build() {
    Column() {
      if (this.title) {
        Text(this.title)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .margin({
            top: 16,
            bottom: 16
          })
      }

      Row() {
        Image($r('app.media.ic_add_img'))
          .width(30)
          .aspectRatio(1)
      }
      .width(95)
      .height(95)
      .backgroundColor("#f2f2f2")
      .justifyContent(FlexAlign.Center)

    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
@Component
export struct IToggleCard {
  // 是否展示卡片的详细信息
  @State
  toggleCard: boolean = true
  @State
  title: string = '基本信息'
  @BuilderParam
  CardContent: () => void

  build() {
    Column() {
      Row() {
        Text(this.title)
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .fontWeight(500)

        Image(this.toggleCard ? $r('app.media.ic_btn_cut') : $r('app.media.ic_btn_add'))
          .width(24)
          .aspectRatio(1)
          .onClick(() => {
            animateTo({ duration: 300 }, () => {
              this.toggleCard = !this.toggleCard
            })
          })
      }
      .width('100%')
      .height(20)
      .justifyContent(FlexAlign.SpaceBetween)

      if (this.toggleCard && this.CardContent) {
        this.CardContent()
      }
    }
    .padding(18)
    .margin({
      top: 10,
      left: 18,
      right: 18
    })
    .borderRadius(10)
    .backgroundColor($r('app.color.white'))
  }
}
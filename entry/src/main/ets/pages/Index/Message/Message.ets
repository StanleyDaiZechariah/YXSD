@Entry
@Component
struct Message {
  @State message: string = 'Message';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('MessageHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}

export default Message
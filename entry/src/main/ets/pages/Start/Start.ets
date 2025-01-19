@Entry
@Component
struct Start {
  @State message: string = 'Hello World';

  build() {
    Stack({alignContent:Alignment.TopEnd}){
      Image($r("app.media.start")) // 之前导入了静态资源暴力的资源
        .objectFit(ImageFit.Cover)

      Text("5秒后跳过")
        .padding({left: 10, right: 10})
        .height(30)
        .margin({right:20, top:20})
        .fontSize(14)
        .borderRadius(15)
        .textAlign(TextAlign.Center)
        .backgroundColor($r("app.color.background_page"))
    }
    .height('100%')
    .width('100%')
    .backgroundColor("red")
  }
}
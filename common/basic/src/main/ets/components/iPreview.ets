@CustomDialog
@Component
export struct IPreView {
  @Prop
  urls: string[] = []
  controller: CustomDialogController
  @Prop
  selectedIndex: number = 0

  build() {
    Column() {
      Swiper() {
        ForEach(this.urls, (item: string) => {
          Image(item)
            .width('100%')
            .onClick(() => {
              this.controller.close()
            })
        })
      }
      .index(this.selectedIndex)
    }
    .width('100%')
    .height('100%')
  }
}
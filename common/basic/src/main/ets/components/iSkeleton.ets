@Preview
@Component
struct ISkeleton {
  @State
  // 骨架屏是否显示左边的圆形
  showAvatar: boolean = true
  // 需要生成的骨架组件的个数
  @State
  count: number = 4
  // 控制组件颜色的属性
  @State
  currentColor: string = "#f60"
  // 用于销毁定时器
  @State
  timer: number = -1

  aboutToAppear(): void {
    this.splashScreen()
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  // 实现闪屏效果的方法
  splashScreen() {
    setInterval(() => {
      if (this.currentColor === "#f60") {
        this.currentColor = "#ccc"
      } else {
        this.currentColor = "#f60"
      }
    }, 100)
  }

  @Builder
  getSingleItem() {
    // 主要部分分左右两个部分
    Row({ space: 10 }) {

      if (this.showAvatar) {
        // 左边的圆形
        Row()
          .width(40)
          .height(40)
          .backgroundColor(this.currentColor)
          .borderRadius(20)
      }


      // 右边的矩形集合
      Column({ space: 10 }) {
        Row()
          .width("30%")
          .height(26)
          .backgroundColor(this.currentColor)

        Row()
          .width('100%')
          .height(26)
          .backgroundColor(this.currentColor)

        Row()
          .width('100%')
          .height(26)
          .backgroundColor(this.currentColor)

        Row()
          .width('50%')
          .height(26)
          .backgroundColor(this.currentColor)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Top)
  }

  build() {
    // 整体按列分布
    Column({ space: 30 }) {
      ForEach(Array.from(Array(this.count)), () => {
        this.getSingleItem()
      })

    }
    .width('100%')
    .height('100%')
    .padding({ top: 20, bottom: 20 })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.white'))
  }
}

export default ISkeleton
@Component
export struct ISkeletonNew {
  // 组件的宽度和高度
  customWidth: number | string = ""
  customHeight: number | string = ""
  // 是否为圆形
  circle: boolean = false
  // 组件的背景颜色
  @Prop
  bgColor: string = "#fff"
  // 设置组建的圆角
  bdRadius: number | string | BorderRadiuses = ""
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
      if (this.bgColor === "#fff") {
        this.bgColor = "#eee"
      } else {
        this.bgColor = "#fff"
      }
    }, 300)
  }

  build() {
    Row() {

    }
    .width(this.customWidth)
    .height(this.circle ? this.customWidth : this.customHeight)
    .borderRadius(this.circle ? this.customWidth : this.bdRadius)
    .backgroundColor(this.bgColor)

  }
}
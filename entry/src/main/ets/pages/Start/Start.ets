import { AdvertClass } from 'basic'
import { window } from '@kit.ArkUI'

@Entry
@Component
struct Start {
  @State
  adObj: AdvertClass = {
    showAd: false,
    adTime: 5
  }
  @State
  timer: number = -1

  // 页面开始加载的时候就会触发当前生命周期方法
  aboutToAppear(): void {

    // 调用倒计时方法
    this.countDown()
  }

  // 销毁子窗口的方法
  closeWin() {
    // 1.查找到销毁的窗口
    // 2.进行销毁
    window.findWindow("ad_window").destroyWindow()
  }

  // 倒计时的方法
  countDown() {
    this.timer = setInterval(() => { // 开启定时器
      if (this.adObj.adTime === 0) { // 当倒计时为0的时候
        clearInterval(this.timer) // 清楚定时器
        this.closeWin() // 销毁子窗口（广告窗口）
        return // 阻止代码继续执行
      }
      this.adObj.adTime-- // 倒计时--
    }, 1000)
  }

  // 当前页面销毁的时候，一定要销毁定时器,否则会导致内存泄漏
  aboutToDisappear(): void {
    // 清楚定时器
    clearInterval(this.timer)
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image($r("app.media.start"))// 之前导入了静态资源暴力的资源
        .objectFit(ImageFit.Cover)

      Text(`${this.adObj.adTime}秒后自动跳过`)
        .padding({ left: 10, right: 10 })
        .height(30)
        .margin({ right: 20, top: 40 })
        .fontSize(14)
        .borderRadius(15)
        .textAlign(TextAlign.Center)
        .backgroundColor($r("app.color.background_page"))
        .onClick(() => {
          this.closeWin()
        })
    }
    .height('100%')
    .width('100%')
    .backgroundColor("red")
  }
}
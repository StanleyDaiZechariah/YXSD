import { RouterParamsModel } from 'basic'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct TaskDetail {
  @State
  params: RouterParamsModel = {} as RouterParamsModel

  aboutToAppear(): void {
    this.getParamsData()
  }

  // 获取任务页面传递过来的司机id
  getParamsData() {
    this.params = router.getParams() as RouterParamsModel
  }

  build() {
    Column() {
      Text('任务详情')
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}
import { BaseBuilderClass, INavBar, IToggleCard, RouterParamsModel } from 'basic'
import { router } from '@kit.ArkUI'
import { getTaskDetailInfoApi } from '../../api/task_detail'
import { TaskDetailInfoModel } from '../../models/task_detail'

@Extend(Text)
function baseTextIconStyle() {
  .width(22)
  .height(22)
  .fontColor($r('app.color.white'))
  .fontSize(12)
  .borderRadius(11)
  .textAlign(TextAlign.Center)
}

@Extend(Text)
function baseTextStyle() {
  .fontSize(14)
  .lineHeight(20)
  .fontColor($r('app.color.text_secondary'))
  .margin({ left: 12 })
}


@Entry
@Component
struct TaskDetail {
  @State
  params: RouterParamsModel = {} as RouterParamsModel
  @State
  taskDetailInfo: TaskDetailInfoModel = {} as TaskDetailInfoModel

  aboutToAppear(): void {
    this.getParamsData()
    this.getTaskDetailInfo()
  }

  // 获取任务页面传递过来的司机id
  getParamsData() {
    this.params = router.getParams() as RouterParamsModel
  }

  //获取任务详情的数据
  async getTaskDetailInfo(): Promise<void> {
    try {
      this.taskDetailInfo = await getTaskDetailInfoApi(this.params.id)
    } catch (e) {
      console.log('error', e)
    }
  }

  // 基本信息栏下面的其他项目
  @Builder
  getBaseContentItem(item: BaseBuilderClass) {
    Row() {
      Text(item.title)
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .lineHeight(20)

      Row() {
        Text(item.value)
          .fontSize(14)
          .fontColor($r('app.color.text_primary'))
          .lineHeight(20)

        if (item.icon) {
          Image(item.icon)
            .width(24)
            .aspectRatio(1)
            .margin({ left: 6 })
        }
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({
      top: 14
    })
  }

  // 基本信息
  @Builder
  getBaseContent() {
    Column() {
      Row() {
        Text('起')
          .baseTextIconStyle()
          .backgroundColor($r('app.color.text_primary'))

        Text('北京市昌平区回龙观街道西三旗桥东金燕龙写字楼8877号')
          .baseTextStyle()
      }
      .margin({ top: 18 })

      Row() {
        Text('止')
          .baseTextIconStyle()
          .backgroundColor($r('app.color.primary'))

        Text('河南省郑州市路北区北青路99号')
          .baseTextStyle()
      }
      .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
    .margin({ right: 20 })

    Divider()
      .width('100%')
      .strokeWidth(2)
      .color($r('app.color.background_divider'))
      .margin({
        top: 20,
        bottom: 20
      })

    this.getBaseContentItem({
      title: '任务编号',
      value: '1557211886558850'
    })

    this.getBaseContentItem({
      title: '联系人',
      value: '张三'
    })

    this.getBaseContentItem({
      title: '联系电话',
      value: '13512345678',
      icon: $r('app.media.ic_phone')
    })

    this.getBaseContentItem({
      title: '提货时间',
      value: '2022.05.04 13:00'
    })

    this.getBaseContentItem({
      title: '预计送达时间',
      value: '2022.05.04 10:00'
    })
  }

  build() {
    Column() {
      INavBar({
        title: '任务详情',
        rightText: '取消任务'
      })

      Scroll() {
        Column() {
          IToggleCard({ title: '基本信息' }) {
            this.getBaseContent()
          }

          IToggleCard({ title: '车辆司机信息', toggleCard: false }) {

          }

          IToggleCard({ title: '运输路线', toggleCard: false }) {

          }

          IToggleCard({ title: '物品信息', toggleCard: false }) {

          }

          IToggleCard({ title: '提货信息', toggleCard: false }) {

          }
        }
        .padding({
          bottom: 40
        })
        .height('100%')
      }
      .height('100%')
      .backgroundColor($r('app.color.background_page'))

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}
import { BaseBuilderClass, INavBar, IToggleCard, IUpLoad, RouterParamsModel } from 'basic'
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

        Text(this.taskDetailInfo.startAddress)
          .baseTextStyle()
      }
      .margin({ top: 18 })

      Row() {
        Text('止')
          .baseTextIconStyle()
          .backgroundColor($r('app.color.primary'))

        Text(this.taskDetailInfo.endAddress)
          .baseTextStyle()
      }
      .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ left: 20, right: 20 })

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
      value: this.taskDetailInfo.transportTaskId
    })

    this.getBaseContentItem({
      title: '联系人',
      value: this.taskDetailInfo.startHandoverName
    })

    this.getBaseContentItem({
      title: '联系电话',
      value: this.taskDetailInfo.startHandoverPhone,
      icon: $r('app.media.ic_phone')
    })

    this.getBaseContentItem({
      title: '提货时间',
      value: this.taskDetailInfo.planDepartureTime
    })

    this.getBaseContentItem({
      title: '预计送达时间',
      value: this.taskDetailInfo.planArrivalTime
    })
  }

  // 车辆司机信息
  @Builder
  getDriverContent() {
    Column() {
      this.getBaseContentItem({
        title: '车牌号',
        value: this.taskDetailInfo.licensePlate
      })

      this.getBaseContentItem({
        title: '司机姓名',
        value: this.taskDetailInfo.driverName
      })
    }
  }

  // 运输路线
  @Builder
  getTransLineContent() {
    Row() {
      Column() {
        Text(this.taskDetailInfo.startProvince)
          .fontSize(16)
          .lineHeight(22)
          .fontColor($r('app.color.text_primary'))
          .fontWeight(600)

        Text(this.taskDetailInfo.startCity)
          .fontSize(14)
          .lineHeight(22)
          .fontColor($r('app.color.text_secondary'))
      }
      .width(50)

      Image($r('app.media.ic_right_arrow'))
        .width(36)
        .height(16)

      Column() {
        Text(this.taskDetailInfo.endProvince)
          .fontSize(16)
          .lineHeight(22)
          .fontColor($r('app.color.text_primary'))
          .fontWeight(600)

        Text(this.taskDetailInfo.endCity)
          .fontSize(14)
          .lineHeight(22)
          .fontColor($r('app.color.text_secondary'))
      }
      .width(50)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left: 60,
      right: 60
    })
    .margin({
      top: 20
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
            this.getDriverContent()
          }

          IToggleCard({ title: '运输路线', toggleCard: false }) {
            this.getTransLineContent()
          }

          IToggleCard({ title: '物品信息', toggleCard: false }) {
            // 后端暂时没有数据
          }

          IToggleCard({ title: '提货信息', toggleCard: false }) {
            IUpLoad({ title: '请拍照上传回单凭证' })

            IUpLoad({ title: '请拍照上传货品照片' })
          }
        }
        .padding({
          bottom: 40
        })
      }
      .height('100%')
      .backgroundColor($r('app.color.background_page'))

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}
import { ICard } from 'basic/src/main/ets/components/iCard'
import { ICardItem } from 'basic/src/main/ets/components/iCardItem'
import { getUserInfoApi, getUserTaskInfoApi } from '../../../api'
import { UserInfoModel, UserTaskInfoModel, UserTaskInfoParamsModel } from '../../../models'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct My {
  // 保存从后台获取的用户信息
  @State
  userInfo: UserInfoModel = {
    avatar: $r('app.media.ic_avatar_driver'),
    name: "",
    phone: "",
    number: ""
  } as UserInfoModel
  @Consume
  @Watch("initUserInfo")
  currentName: string
  // 定义获取任务数据接口的参数
  @State
  queryTaskParams: UserTaskInfoParamsModel = {
    month: (new Date().getMonth() + 1).toString(),
    year: new Date().getFullYear().toString()
  }
  // 初始化一个变量，用来保存请求到的任务数据
  @State
  userTaskInfo: UserTaskInfoModel = {} as UserTaskInfoModel

  // 页面第一次加载的时候，才会执行当前方法
  /*aboutToAppear(): void {
    // 调用获取用户信息接口
    this.getUserInfo()
  }*/

  // 只要切换到”我的“就更新任务数据和用户数据
  initUserInfo() {
    this.getUserInfo()
    this.getUserTaskInfo()
  }

  // 获取用户信息方法
  async getUserInfo() {
    try {
      /*AlertDialog.show({
        message: "222"
      })*/
      if (this.currentName === "my") {
        this.userInfo = await getUserInfoApi()
        /*AlertDialog.show({
          message: "333" + JSON.stringify(this.userInfo)
        })*/
      }
    } catch (e) {
      console.log("error", e)
    }
  }

  // 获取任务数据的方法
  async getUserTaskInfo() {
    try {
      this.userTaskInfo = await getUserTaskInfoApi(this.queryTaskParams)
      /*AlertDialog.show({
        message: JSON.stringify(this.userTaskInfo, null, 2)
      })*/
    } catch (e) {
      console.log("error", e)
    }
  }

  build() {
    Column() {
      if (this.userInfo.name) {
        // 用户信息模块
        Column() {
          // 汽车图标
          Image(this.userInfo?.avatar)
            .width(67)
            .aspectRatio(1)
            .borderRadius(34)

          // 用户名
          Text(this.userInfo?.name)
            .fontSize(18)
            .fontWeight(400)
            .fontColor($r('app.color.white'))
            .lineHeight(25)
            .margin({
              top: 9,
              bottom: 9
            })

          // 司机编号
          Text(`司机编号：${this.userInfo?.number}`)
            .fontSize(14)
            .fontWeight(400)
            .fontColor($r('app.color.white'))
            .lineHeight(20)

          // 手机号
          Text(`手机号：${this.userInfo?.phone}`)
            .fontSize(14)
            .fontWeight(400)
            .fontColor($r('app.color.white'))
            .lineHeight(20)
            .margin({ top: 10 })
        }
        .width('100%')
        .height(292)
        .backgroundImage($r('app.media.bg_page_my'))
        .backgroundImageSize(ImageSize.Cover)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }

      // 本月任务
      Column() {
        Text("- 本月任务 -")
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .lineHeight(20)

        Row() {
          // 任务总量
          Column() {
            Text(this.userTaskInfo.taskAmounts?.toString() || '')
              .fontSize(18)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(25)
              .margin({ bottom: 17 })

            Text("任务总量")
              .fontSize(12)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(17)
          }

          // 完成任务量
          Column() {
            Text(this.userTaskInfo.completedAmounts?.toString() || '')
              .fontSize(18)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(25)
              .margin({ bottom: 17 })

            Text("完成任务量")
              .fontSize(12)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(17)
          }

          // 运输历程
          Column() {
            Text(this.userTaskInfo.transportMileage?.toString() || '')
              .fontSize(18)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(25)
              .margin({ bottom: 17 })

            Text("运输里程(km)")
              .fontSize(12)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(17)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.SpaceAround)
      }
      .height(134)
      .borderRadius(8)
      .margin({
        left: 16,
        right: 16,
        top: -45,
        bottom: 15
      })
      .padding({ top: 14, bottom: 14 })
      .backgroundColor($r('app.color.white'))
      .justifyContent(FlexAlign.SpaceBetween)


      // 选项列表
      ICard() {
        // 尾随闭包的写法
        ICardItem({
          leftText: "车辆信息"
        })

        ICardItem({
          leftText: "任务数据",
        })

        ICardItem({
          leftText: "系统设置",
          onRightClick: () => {
            router.pushUrl({
              url: "pages/Setting/Setting"
            })
          }
        })
      }

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}

export default My
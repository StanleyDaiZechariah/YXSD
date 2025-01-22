import { ICard } from 'basic/src/main/ets/components/iCard'
import { ICardItem } from 'basic/src/main/ets/components/iCardItem'

@Entry
@Component
struct My {
  build() {
    Column() {
      // 用户信息模块
      Column() {
        // 汽车图标
        Image($r('app.media.ic_avatar_driver'))
          .width(67)
          .aspectRatio(1)
          .borderRadius(34)

        // 用户名
        Text('李立明')
          .fontSize(18)
          .fontWeight(400)
          .fontColor($r('app.color.white'))
          .lineHeight(25)
          .margin({
            top: 9,
            bottom: 9
          })

        // 司机编号
        Text("司机编号：666666")
          .fontSize(14)
          .fontWeight(400)
          .fontColor($r('app.color.white'))
          .lineHeight(20)

        // 手机号
        Text("手机号：178090802342")
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

      // 本月任务
      Column() {
        Text("- 本月任务 -")
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .lineHeight(20)

        Row() {
          // 任务总量
          Column() {
            Text("18")
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
            Text("18")
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
            Text("3987")
              .fontSize(18)
              .fontColor($r('app.color.text_primary'))
              .lineHeight(25)
              .margin({ bottom: 17 })

            Text("运输里程")
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
          leftText: "系统数据"
        })
      }

      /*Column() {
        // 车辆信息
        Row() {
          Text('车辆信息')
            .fontSize(16)
            .fontWeight(400)
            .fontColor($r('app.color.text_primary'))

          Image($r('app.media.ic_btn_more'))
            .width(24)
            .aspectRatio(1)
        }
        .width('100%')
        .height(60)
        .border({
          width: {
            bottom: 1
          },
          color: $r('app.color.background_page')
        })
        .justifyContent(FlexAlign.SpaceBetween)

        // 任务数据
        Row() {
          Text('任务数据')
            .fontSize(16)
            .fontWeight(400)
            .fontColor($r('app.color.text_primary'))

          Image($r('app.media.ic_btn_more'))
            .width(24)
            .aspectRatio(1)
        }
        .width('100%')
        .height(60)
        .border({
          width: {
            bottom: 1
          },
          color: $r('app.color.background_page')
        })
        .justifyContent(FlexAlign.SpaceBetween)

        // 系统设置
        Row() {
          Text('系统设置')
            .fontSize(16)
            .fontWeight(400)
            .fontColor($r('app.color.text_primary'))

          Image($r('app.media.ic_btn_more'))
            .width(24)
            .aspectRatio(1)
        }
        .width('100%')
        .height(60)
        .border({
          width: {
            bottom: 1
          },
          color: $r('app.color.background_page')
        })
        .justifyContent(FlexAlign.SpaceBetween)

      }
      .margin({ left: 16, right: 16 })
      .backgroundColor($r('app.color.white'))
      .borderRadius(8)
      .padding({
        left: 18,
        right: 18
      })*/

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}

export default My
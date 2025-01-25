import { ISkeletonNew } from 'basic'

@Component
export struct My_Skeleton {
  build() {
    Column() {
      // 用户信息
      Row() {
        ISkeletonNew({
          customWidth: '100%',
          customHeight: '100%',
          bgColor: '#eee',
          bdRadius: {
            bottomLeft: 20,
            bottomRight: 20
          }
        })
      }
      .width('100%')
      .height(292)

      // 本月任务
      Row() {
        ISkeletonNew({
          customWidth: '100%',
          customHeight: '100%',
          bdRadius: 10
        })
      }
      .width('100%')
      .height(134)
      .padding({
        left: 15,
        right: 15
      })
      .margin({
        top: -20
      })

      // 选项列表
      Column({ space: 3 }) {
        ForEach(Array.from(Array(3)), () => {
          ISkeletonNew({
            customWidth: '100%',
            customHeight: 50,
            bdRadius: 8
          })
        })
      }
      .margin({
        top: 20
      })
      .padding({
        left: 15,
        right: 15
      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.white'))
  }
}
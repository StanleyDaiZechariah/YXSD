import { INavBar, ISkeletonNew } from 'basic'


@Preview
@Component
export struct TaskDetail_Skeleton {
  build() {
    Column() {
      INavBar({
        title: '任务详情',
        rightText: '取消任务'
      })

      Column({ space: 20 }) {

        ISkeletonNew({
          customWidth: '100%',
          customHeight: 320,
          bgColor: '#fff',
          bdRadius: 10
        })

        ISkeletonNew({
          customWidth: '100%',
          customHeight: 50,
          bgColor: '#fff',
          bdRadius: 10
        })

        ISkeletonNew({
          customWidth: '100%',
          customHeight: 50,
          bgColor: '#fff',
          bdRadius: 10
        })

        ISkeletonNew({
          customWidth: '100%',
          customHeight: 50,
          bgColor: '#fff',
          bdRadius: 10
        })

        ISkeletonNew({
          customWidth: '100%',
          customHeight: 50,
          bgColor: '#fff',
          bdRadius: 10
        })

      }
      .padding(20)
      .layoutWeight(1)

      ISkeletonNew({
        customWidth: '100%',
        customHeight: 60,
        bgColor: '#fff'
      })

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}
import { TableClass } from 'basic'
import Message from './Message/Message'
import My from './My/My'
import Task from './Task/Task'

@Entry
@Component
struct Index {
  // tabBar的数据
  @State
  tabsData: TableClass[] = [
    {
      title: "任务",
      icon: $r('app.media.ic_tab_btn_task'),
      name: "task"
    },
    {
      title: "消息",
      icon: $r('app.media.ic_tab_btn_mess_nor'),
      name: "message"
    },
    {
      title: "我的",
      icon: $r('app.media.ic_tab_btn_mine_nor'),
      name: "my"
    }
  ]
  // 初始化一个变量保存选中的tabContent
  @State currentIndex: number = 0

  // 自定义tabBar的布局
  @Builder
  getTabBar(item: TableClass) {
    Column() {
      Image(item.icon)
        .width(22)
        .aspectRatio(1)
        .fillColor(item.name == this.tabsData[this.currentIndex].name ? $r('app.color.primary') :
        $r('app.color.text_secondary'))

      Text(item.title)
        .fontSize(12)
        .fontWeight(400)
        .fontColor(item.name == this.tabsData[this.currentIndex].name ? $r('app.color.primary') :
        $r('app.color.text_secondary'))
        .margin({ top: 5 })
    }
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: $$this.currentIndex }) {
        ForEach(this.tabsData, (item: TableClass) => {
          TabContent() {
            if (item.name === "task") {
              Task()
            } else if (item.name === "message") {
              Message()
            } else {
              My()
            }
          }.tabBar(this.getTabBar(item)) // 因为在内部所以需要用this指明
        })
      }
      .animationDuration(200)
    }
    .width('100%')
    .height('100%')
  }
}
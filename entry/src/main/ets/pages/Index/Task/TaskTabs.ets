import { TableClass } from 'basic'
import { TaskList } from './TaskList'


@Component
export struct TaskTabs {
  // 顶部导航栏的数据
  @State
  tabsData: TableClass[] = [
    {
      title: '待提货',
      name: 'waiting'
    },
    {
      title: '在途',
      name: 'line'
    },
    {
      title: '已完成',
      name: 'finish'
    }
  ]
  // 导航栏下角标
  @State
  currentIndex: number = 0
  // 导航栏控制器对象
  controller: TabsController = new TabsController()

  @Builder
  getTabBar(item: TableClass, index: number) {
    Column() {
      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentIndex === index ? $r('app.color.text_primary') : $r('app.color.text_secondary'))
        .margin({
          bottom: 8
        })
        .animation({
          duration: 100
        })

      Divider()
        .color($r('app.color.primary'))
        .strokeWidth(4)// 调整分割线的高度
        .width(this.currentIndex === index ? 24 : 0)
        .lineCap(LineCapStyle.Round)
        .animation({
          duration: 100
        })
    }
    .onClick(() => {
      this.controller.changeIndex(index)
    })
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Tabs({ controller: this.controller, index: $$this.currentIndex }) {
        // 循环渲染导航栏数据
        ForEach(this.tabsData, (item: TableClass) => {
          TabContent() {
            if (item.name === "waiting") {
              TaskList()
            } else if (item.name === "line") {

            } else if (item.name === "finish") {

            }
          }.tabBar(item.title)
        })
      }

      Row({ space: 30 }) {
        ForEach(this.tabsData, (item: TableClass, index: number) => {
          this.getTabBar(item, index)
        })

      }
      .width('100%')
      .padding({
        left: 40,
        right: 40
      })
      .height(50)
      .backgroundColor($r('app.color.white'))
    }

  }
}
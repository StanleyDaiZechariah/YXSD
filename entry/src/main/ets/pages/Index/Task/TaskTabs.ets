import { TableClass } from 'basic'


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

  build() {
    Tabs() {
      // 循环渲染导航栏数据
      ForEach(this.tabsData, (item: TableClass) => {
        TabContent() {
          Text(item.name)
        }.tabBar(item.title)
      })
    }
  }
}
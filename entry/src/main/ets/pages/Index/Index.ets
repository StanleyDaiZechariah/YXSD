import { TableClass } from 'basic'

@Entry
@Component
struct Index {
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
      name: "mine"
    }
  ]

  build() {
    
  }
}
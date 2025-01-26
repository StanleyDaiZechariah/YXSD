import { getTaskListApi } from '../../../api/task'
import {
  TaskListDataModel,
  TaskListItemDataModel,
  TaskListParamsModel,
  TaskTypeEnum
} from '../../../models/task_page'
import { TaskItemCard } from './TaskItemCard'

@Component
export struct TaskList {
  // 保存任务列表的数据
  @State
  taskList: TaskListItemDataModel[] = []
  // 任务列表接口传递的参数
  @State
  queryParams: TaskListParamsModel = {
    page: 1,
    pageSize: 5,
    status: TaskTypeEnum.Waiting
  }
  // 初始化一个变量保存请求的状态，法拉瑟表示未上拉加载，true上拉加载中
  @State
  loading: boolean = false
  // 初始化一个变量，保存数据是否全部请求到
  @State
  finished: boolean = false
  // 创建一个变量保存下拉刷新的状态
  @State
  refresh: boolean = false

  // 请求数据的方法
  async onLoad() {
    try {
      // 开始上拉加载
      this.loading = true
      // 请求任务列表数据
      const res: TaskListDataModel = await getTaskListApi(this.queryParams)
      // 如果当前数据的页码大于总页码，就停止请求
      if (this.queryParams.page >= res.pages) {
        this.finished = true
      }
      // 页码++
      this.queryParams.page++
      console.log("pppp", JSON.stringify(res))
      // 数据进行追加
      this.taskList.push(...res.items)
      // 结束上拉加载
      this.loading = false
    } catch (e) {
      console.log("error", e)
    }
  }

  // list组件优化
  @Builder
  getBottom() {
    Row() {
      if (this.finished) {
        Text('数据请求完毕！')
          .fontSize(12)
          .fontColor($r('app.color.text_secondary'))
      } else {
        LoadingProgress()
          .width(20)
          .aspectRatio(1)
          .color($r('app.color.text_secondary'))

        Text('数据加载中...')
          .fontSize(12)
          .fontColor($r('app.color.text_secondary'))
      }
    }
    .width('100%')
    .padding(10)
    .justifyContent(FlexAlign.Center)
  }

  // 自定义下拉刷新的文本
  @Builder
  getRefreshBuilder() {
    Row() {
      LoadingProgress()
        .width(20)
        .aspectRatio(1)
        .color($r('app.color.primary'))

      Text('刷新中')
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Refresh({ refreshing: $$this.refresh, builder: this.getRefreshBuilder() }) {
      List({ space: 10 }) {
        ForEach(this.taskList, (item: TaskListItemDataModel) => {
          ListItem() { // 任务信息
            TaskItemCard({
              taskItem: item
            })
          }
        })
        ListItem() { // 列表底部
          this.getBottom()
        }
      }
      .width('100%')
      .height('100%')
      .padding(10)
      .backgroundColor($r('app.color.background_page'))
      .onReachEnd(() => {
        if (this.loading) {
          return
        }
        if (this.finished) {
          return
        }
        this.onLoad()

      })
    }

  }
}
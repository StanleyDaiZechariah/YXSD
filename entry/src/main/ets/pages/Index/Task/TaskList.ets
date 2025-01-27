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
  // 创建一个变量决定是否显示下拉刷新相关的组件和方法
  @State
  refresh: boolean = false
  // 存储下拉手势的状态，默认为为没有下拉
  @State
  refreshStatus: number = RefreshStatus.Inactive

  // 请求数据的方法
  // 参数表示是否接收下拉刷新的逻辑
  async onLoad(flag?: boolean) {
    try {
      // 开始上拉加载
      this.loading = true

      // 请求任务列表数据
      const res: TaskListDataModel = await getTaskListApi(this.queryParams)

      // 数据进行追加
      if (flag) {
        // 如果是下拉刷新就重置任务列表
        this.taskList = res.items
      } else {
        // 如果是上拉刷新就追加数据
        this.taskList.push(...res.items)
      }

      // 如果当前数据的页码大于总页码，就停止请求
      if (this.queryParams.page >= res.pages) {
        this.finished = true
      }

      // 页码++
      this.queryParams.page++
      console.log('pppp', JSON.stringify(res))

      // 结束上拉加载
      this.loading = false
    } catch (e) {
      console.log("error", e)
    }
  }

  // 获取下拉刷新文本
  getRefreshText() {
    // 如果下拉的距离小于刷新距离，提示文本未继续下拉
    // 如果下拉的距离超过刷新距离，松手刷新
    // 如果当前的状态是刷新中：正在刷新
    switch (this.refreshStatus) {
      case RefreshStatus.Inactive:
        return ""
      case RefreshStatus.Drag:
        return "继续下拉"
      case RefreshStatus.OverDrag:
        return "松手刷新"
      case RefreshStatus.Refresh:
        return "正在刷新中"
      default:
        return ""
    }

  }

  // 下拉刷新的方法
  async onRefresh() {
    // 将页面大小重置为1
    this.queryParams.page = 1
    // 没有接收完数据
    this.finished = false
    // 重置任务列表
    await this.onLoad(true)
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

      Text(this.getRefreshText())
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
    .onStateChange(async (state) => {
      // 下拉刷新状态发生变化时进行触发
      this.refreshStatus = state
      // 当下拉结束，回弹至刷新距离，进入刷新中状态时调用下拉刷新相关逻辑
      if (this.refreshStatus === RefreshStatus.Refresh) {
        // 调用下拉刷新相关函数
        await this.onRefresh()
        // 取消下拉刷新的相关内容
        this.refresh = false
      }
    })

  }
}
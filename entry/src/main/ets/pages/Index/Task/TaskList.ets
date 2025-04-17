import { IList } from 'basic'
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
  // 初始化一个变量保存请求的状态，false表示未上拉加载，true上拉加载中
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
  // 参数表示是否下拉刷新
  onLoad = async (flag?: boolean) => {
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
  // 下拉刷新的方法
  onRefresh = async () => {
    // 将页面大小重置为1
    this.queryParams.page = 1
    // 重置数据接收状态
    this.finished = false
    // 重置任务列表
    await this.onLoad(true)
  }

  // 请求数据的方法
  @Builder
  renderItem(item: object) {
    TaskItemCard({
      taskItem: item as TaskListItemDataModel
    })
  }

  build() {
    IList({
      finishedText: '数据传输完毕',
      loadingText: '数据加载中~',
      dataSource: this.taskList,
      renderItem: this.renderItem,
      onLoad: this.onLoad,
      onRefresh: this.onRefresh,
      finished: this.finished,
      loading: this.loading,
      refresh: this.refresh,
      refreshStatus: this.refreshStatus
    })
  }
}
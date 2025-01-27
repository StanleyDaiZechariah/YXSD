@Component
export struct IList {
  // 接收数据完成时显示的文本
  @Prop
  finishedText: string = "没有更多数据了"
  // 加载数据时显示的文本
  @Prop
  loadingText: string = "拼命加载中！"
  // 保存任务列表的数据
  // 动态的，需要父组件传递进来
  @Prop
  dataSource: object[] = []
  // 初始化一个变量保存请求的状态，false表示未上拉加载，true上拉加载中
  @Prop
  loading: boolean = false
  // 初始化一个变量，保存数据是否全部请求到
  @Prop
  finished: boolean = false
  // 创建一个变量决定是否显示下拉刷新相关的组件和方法
  @Prop
  refresh: boolean = false
  // 存储下拉手势的状态，默认为为没有下拉
  @Prop
  refreshStatus: number = RefreshStatus.Inactive
  // 请求数据的方法
  @BuilderParam
  renderItem: (item: object) => void
  // 下拉刷新的方法
  onRefresh: () => Promise<void> = async () => {
  }
  // 参数表示是否下拉刷新
  onLoad: (flag?: boolean) => void = () => {
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

  // list组件优化
  @Builder
  getBottom() {
    Row() {
      if (this.finished) {
        Text(this.finishedText)
          .fontSize(12)
          .fontColor($r('app.color.text_secondary'))
      } else {
        LoadingProgress()
          .width(20)
          .aspectRatio(1)
          .color($r('app.color.text_secondary'))

        Text(this.loadingText)
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
        ForEach(this.dataSource, (item: object) => {
          ListItem() { // 任务信息
            this.renderItem(item)
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
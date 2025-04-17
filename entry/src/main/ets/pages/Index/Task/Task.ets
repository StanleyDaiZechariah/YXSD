import { TaskTabs } from './TaskTabs'

@Entry
@Component
struct Task {
  build() {
    Column() {
      TaskTabs()
    }
    .height('100%')
    .width('100%')
  }
}

export default Task
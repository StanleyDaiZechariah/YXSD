// 任务列表接口请求参数的类型
export interface TaskListParamsModel {
  // 结束时间
  endTime?: string
  // 页码
  page: number
  // 页面大小
  pageSize: number
  // 开始时间
  startTime?: string
  // 作业状态：1为待提货、2为在途（在途和已提交）、3为改派、5为已作废、6为已完成（已回车登记）
  status: TaskTypeEnum
  // 运输ID
  transportTaskId?: string
}

// 作业状态的枚举
export enum TaskTypeEnum {
  Waiting = 1,
  Line = 2,
  Finish = 6
}

// 任务列表接口返回数据的参数的类型
export interface TaskListDataModel {
  // 总条目数
  counts: number
  // 数据列表
  items: TaskListItemDataModel[]
  // 页码
  page: number
  // 总页数
  pages: number
  // 页尺寸
  pageSize: number
}

// 任务列表的数据类型
export interface TaskListItemDataModel {
  // 实际到达时间
  actualArrivalTime: string
  // 实际出发时间
  actualDepartureTime: string
  // 创建时间
  created: string
  // 司机Id
  driverId: string
  // 是否可提货
  enablePickUp: boolean
  // 目的地址
  endAddress: string
  // 目的机构id
  endAgencyId: number
  // 交付对接人
  finishHandOver: string
  // 司机作业单id
  id: string
  // 计划到达时间
  planArrivalTime: string
  // 计划出发时间
  planDepartureTime: string
  // 起始机构地址
  startAddress: string
  // 起始机构Id
  startAgencyId: number
  // 提货对接人
  startHandOver: string
  // 作业状态
  status: string
  // 运输任务Id
  transportTaskId: string
}
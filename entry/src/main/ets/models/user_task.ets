// 任务数据接口请求的参数类型
export interface UserTaskInfoParamsModel {
  // 年
  month: string
  // 月
  year: string
}

// 任务数据接口返回的数据类型
export interface UserTaskInfoModel {
  // 完成的任务数量
  completedAmounts: number
  // 每日里程
  dailyMileage: DailyMileage[]
  // 任务数量
  taskAmounts: number
  // 运输里程
  transportMileage: number
}

// 运输里程
export interface DailyMileage {
  // 日期
  dataTime?: string
  // 里程
  mileage?: number
}
// 封装存储数据的方法
import { preferences } from '@kit.ArkData';
import { AdvertClass } from '../models/advert';


// 广告的默认配置(后台返回的广告配置)
export const defaultAd: AdvertClass = {
  // 广告的时长
  adTime: 5,
  // 显示广告
  showAd: true,
  // 广告图片
  adImage: $r('app.media.start')
}


export class UserSettingClass {
  context: Context

  constructor(context: Context) {
    // 初始化上下文对象
    this.context = context
  }

  // 创建仓库
  getStore() {
    // 创建仓库
    return preferences.getPreferencesSync(this.context, {
      name: "advertisement"
    })
  }

  // 存储仓库
  setUserAd(ad: AdvertClass) {
    // 获取到了仓库
    const store = this.getStore()
    // 给仓库中存储数据
    store.putSync("setting_ad", JSON.stringify(ad))
    // 将数据写入到磁盘中
    store.flush()
  }

  // 获取数据
  getUserAd(): AdvertClass {
    // 获取创建的仓库
    const store = this.getStore()
    // 获取广告的数据
    return JSON.parse(store.getSync("setting_ad", JSON.stringify(defaultAd)) as string)
  }
}
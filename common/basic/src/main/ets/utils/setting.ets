// 封装存储数据的方法
import { preferences } from '@kit.ArkData';
import { USER_TOKEN, XSD_SETTING, XSD_SETTING_AD } from '../constants';
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
      name: XSD_SETTING
    })
  }

  // 存储仓库
  setUserAd(ad: AdvertClass) {
    // 获取到了仓库
    const store = this.getStore()
    // 给仓库中存储数据
    store.putSync(XSD_SETTING_AD, JSON.stringify(ad))
    // 将数据写入到磁盘中
    store.flush()
  }

  // 获取数据
  getUserAd(): AdvertClass {
    // 获取创建的仓库
    const store = this.getStore()
    // 获取广告的数据
    return JSON.parse(store.getSync(XSD_SETTING_AD, JSON.stringify(defaultAd)) as string)
  }


  // 存储token的数据
  setUserToken(token: string) {
    // 获取仓库
    const store = this.getStore()
    // 给仓库添加数据
    store.put(USER_TOKEN, token)
    // 写入磁盘
    store.flush()
  }

  // 获取token的数据
  getUserToken(): string {
    // 获取仓库
    const store = this.getStore()
    // 获取数据
    return store.getSync(USER_TOKEN, "") as string
  }

  // 你也可以专门设置一个删除token的方法
  deleteUserToken() {
    // 获取仓库
    const store = this.getStore()
    // 删除数据
    store.deleteSync(USER_TOKEN)
    // 写入磁盘
    store.flush()
  }
}


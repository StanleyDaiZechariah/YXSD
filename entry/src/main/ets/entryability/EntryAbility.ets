import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { AdvertClass, defaultAd, UserSettingClass } from 'basic';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  // 通过生命周期函数来产生广告子页面
  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 进入应用的时候，调用后台接口获取广告配置
    const ad = await new Promise<AdvertClass>((resolve) => {
      setTimeout(() => {
        resolve(defaultAd)
      }, 500)
    })

    // 将广告的配置存储到本地
    const setting = new UserSettingClass(this.context)
    setting.setUserAd(ad)

    // 通过广告的配置来决定是否显示广告
    if (ad.showAd) {
      // 创建子窗口
      const win = await windowStage.createSubWindow("ad_window")
      // 显示子窗口
      await win.showWindow()
      // 加载广告页面
      win.setUIContent("pages/Start/Start")
    }

    /*
     *  页面鉴权的思路
     *  本处实现的是全局页面鉴权
     * 可以试试部分页面鉴权
     * */
    // 1.获取本地存储的token
    const token = setting.getUserToken()
    // 2.判断token是否存在，如果存在直接跳转到主页
    let path: string = ""
    if (token) {
      path = "pages/Index/Index"
      // 3.如果不存在则跳转到登陆页面
    } else {
      path = "pages/Login/Login"
    }

    windowStage.loadContent(path);
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}

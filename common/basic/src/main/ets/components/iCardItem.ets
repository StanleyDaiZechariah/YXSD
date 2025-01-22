@Component
export struct ICardItem {
  // 左侧文本属性
  leftText: string = ""
  // 是否展示右侧图标
  showRightIcon?: boolean = true
  // 右侧图标的图片资源
  rightIcon?: ResourceStr = $r('app.media.ic_btn_more')
  // 与父组件绑定的右侧文本属性
  @Prop rightText?: string = ""
  // 是否展示列表项底部的边框
  showBottomBorder: boolean = true
  // 右侧子组件的点击事件
  onRightClick: () => void = () => {
  }

  build() {
    Row() {
      // 左侧文本
      Text(this.leftText)
        .fontSize(16)
        .fontWeight(400)
        .fontColor($r('app.color.text_primary'))

      // 右侧子组件
      Row() {
        if (this.rightText) {
          Text(this.rightText)
            .fontSize($r('app.color.text_secondary'))
            .fontSize(14)
            .fontWeight(400)
            .margin({ right: 5 })
        }

        if (this.showRightIcon) {
          Image(this.rightIcon)
            .width(24)
            .aspectRatio(1)
        }
      }
      .onClick(() => {
        this.onRightClick()
      })

    }
    .width('100%')
    .height(60)
    .border({
      width: {
        bottom: this.showBottomBorder ? 1 : 0
      },
      color: $r('app.color.background_divider')
    })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}


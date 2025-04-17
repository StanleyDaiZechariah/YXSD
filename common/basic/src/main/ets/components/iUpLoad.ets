import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { ImageListModel } from '../models';
import { IPreView } from './iPreview';

@Component
export struct IUpLoad {
  @State
  title: string = ''
  @State
  imageList: ImageListModel[] = []
  @State
  index: number = 0
  @Prop
  maxNumber: number = 3
  customDialogController: CustomDialogController = new CustomDialogController({
    builder: IPreView({
      urls: this.imageList.map((item: ImageListModel) => item.url),
      selectedIndex: this.index
    })
  })

  // 唤醒系统相册
  async selectImage() {
    // 创建图库选择实例
    const photoViewPicker = new photoAccessHelper.PhotoViewPicker();
    // 打开系统相册
    const result = await photoViewPicker.select({
      // 在相册中一次选择的图像的最大个数
      maxSelectNumber: this.maxNumber - this.imageList.length,
      // 表明选择的文件的类型
      MIMEType: photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE
    })
    // 将选择的图片保存到imageList里面
    const data = result.photoUris.map((item: string) => {
      return { url: item } as ImageListModel
    })

    this.imageList.push(...data)
  }

  build() {
    Column() {
      if (this.title) {
        Text(this.title)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .margin({
            top: 16,
            bottom: 16
          })
      }

      Grid() {
        ForEach(this.imageList, (item: ImageListModel, index: number) => {
          GridItem() {
            Image(item.url)
              .width(95)
              .aspectRatio(1)
              .borderRadius(5)
              .onClick(() => {
                this.customDialogController.open()
                this.index = index
              })
          }
        })

        if (this.imageList.length < 3) {
          GridItem() {
            Row() {
              Image($r('app.media.ic_add_img'))
                .width(30)
                .aspectRatio(1)
            }
            .width(95)
            .height(95)
            .backgroundColor("#f2f2f2")
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.selectImage()
            })
          }
        }


      }
      .columnsTemplate("1fr 1fr 1fr")
      .columnsGap(10)
      .rowsGap(10)

    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
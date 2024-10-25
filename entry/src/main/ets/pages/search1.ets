import cityCard from '../view/cityCard'
import { router } from '@kit.ArkUI';
import Preferences from '../view/Preference'

@Entry
@Component
struct Search1 {
  @State message: string = 'Hello World';
  @State Name: string = ''
  @State citys: string[] = [];

  onPageShow(): void {
    interface ParamsType {
      citys: string[];
      names: string;
    }

    const params = router.getParams() as ParamsType | null;

    // 检查 params 是否为非空对象并且包含 'names' 属性
    if (params&&params.citys&&params.names) {
      this.Name = params.names
      this.citys = params.citys
    }
  }

  build() {
    Column() {
      Row() {


        Text(this.Name)
          .width('95%')
          .padding(20)
          .backgroundColor(Color.White)
          .borderRadius(15)
          .shadow({
            radius: 6,
            color: '#1F000000',
            offsetX: 2,
            offsetY: 4
          })

          .onClick(() => {
            this.citys.push(this.Name)

            router.replaceUrl({
              url:'pages/AddCity',
              params :{
              CITYS:this.citys
              }
            })
          })
      }
      .height('10%')
      .width('100%')
    }
    .height('100%')
    .width('100%')
  }
}



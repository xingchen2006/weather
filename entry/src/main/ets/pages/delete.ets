import { router } from '@kit.ArkUI';
@Entry
@Component
struct Delete {
  @State message: string = 'Hello World';
  @State Name:string[]=[]
  onPageShow() {
    interface ParamsType {
      //codes: number[];
      names: string[];
    }

    const params = router.getParams() as ParamsType | null;

    if (params) {
      // this.cityCodeList = params.codes;
      this.Name = params.names;
    }

  }
    build() {
    Column() {
      Row(){
        Image($r('app.media.ic_public_back'))
          .height(16)
          .width(16)
          .onClick(()=>{
            router.replaceUrl({
              url:'pages/Index',

              params: {

                CITYS: this.Name
              }

            })
          })
        Text('    删除城市')
        //Blank()
      }
      List({space:10}){
        ForEach(this.Name,(name:string,index)=>{
          ListItem(){
            Row(){
              Text(name)
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

            }

          }
          .swipeAction({end: this.DeleteButton(index)})
        })
      }
    }
    .height('100%')
    .width('100%')
  }
  @Builder DeleteButton(index: number){
    Button(){
      Image($r('app.media.ic_public_delete_filled'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
    .onClick(() => {
      this.Name.splice(index, 1)

    })
  }
}
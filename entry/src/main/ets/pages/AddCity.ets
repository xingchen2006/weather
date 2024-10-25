import { promptAction, router } from '@kit.ArkUI'

import searchCity from '../view/searchCIty'
@Entry
@Component
struct AddCity {
  @State message: string = 'Hello World';
  @State cityCodeList: number[] = [];
  @State cityNameList: string[] = [];
  @State sousuo:string=''
  //@State params:any = router.getParams();

  onPageShow(){
    interface ParamsType {
      //codes: number[];
      names: string[];
    }
    const params = router.getParams() as ParamsType | null;

    if (params&&params.names) {
     // this.cityCodeList = params.codes;
      this.cityNameList = params.names;
    }


    //const params = router.getParams();
    // let params: { codes: number[], names: string[] }  = router.getParams();
    // this.cityCodeList = params['codes'];
    // this.cityNameList = params['names'];
   // console.log('Received params:', params);



  }
  aboutToAppear(){
    interface ParamsType {
      //citys: string[];
      CITYS: string[];
    }

    const Params = router.getParams() as ParamsType | null;

    // 检查 params 是否为非空对象并且包含 'names' 属性
    if (Params&&Params.CITYS) {
      //this.Name = params.names
      this.cityNameList = Params.CITYS
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

                CITYS: this.cityNameList
              }

            })
          })
        Text('    城市查询')
        //Blank()
      }
      .height('2%')
      .justifyContent(FlexAlign.Start)
      Row() {
        Search({ placeholder: '搜索城市天气' })
          .textFont({ size: 25 })
          .onChange((value) => {
            this.sousuo = value
            console.log('搜索:',this.sousuo)
          })
          .width('85%')
        Text('搜索')
          .onClick(()=>{
            if(this.sousuo===null){
              promptAction.showToast({message:'搜索城市天气'})
              return
            }
            router.pushUrl({
              url:'pages/search1',
              params:{
                names:this.sousuo,
                citys:this.cityNameList
              }
            })



          })
      }
      .width('100%')
      .height('10%')
      .backgroundColor(Color.White)
    }
    .height('100%')
    .width('100%')
  }
}
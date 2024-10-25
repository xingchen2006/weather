
import { promptAction, router } from '@kit.ArkUI'

@Component
export default struct searchCity{
  @State sousuo:string=''
  @State citylist:string[]=[]
  build() {
  Row(){
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
              citys:this.citylist
            }
          })



       })
    }
    .width('100%')
    .height('10%')
    .backgroundColor(Color.White)
  }
  }
}
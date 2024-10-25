
import weathermodel from './weatherhttp'
import citymodel from './cityhttp'
import weatherInfo from '../util/weatherInfo'
import { cityView } from '../view/cityView'
import cityInfo from '../util/cityInfo';
import { CityWeather7Day } from '../util/CityWeather7Day'
import { now } from '../util/weatherInfo';
import { router } from '@kit.ArkUI';
import Preferences from '../view/Preference'

@Entry
@Component

struct Index {
  @State cityWeatherList : Array<weatherInfo> = []
  @State cityWeathernowList : Array<now> = []
  @State cityNameList : string[] = ["beijing",'wenan']
  @State cityCodeList:string[] = []
  @State cityIndex: number = 0
  @State test :string ='2'
  @State test1 :string ='2'
  @State cityWeatherList7 : Array<CityWeather7Day> = []
  @State cityNameDeleteList : string[] = []

  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  tabController : TabsController = new TabsController()
  // about() {
  //   interface ParamsType {
  //     //codes: number[];
  //     names: string[];
  //   }
  //
  //   const params = router.getParams() as ParamsType | null;
  //
  //   if (params) {
  //     // this.cityCodeList = params.codes;
  //     this.cityNameList = params.names;
  //   }
  // }
  @Builder tabBuild(index:number){
    Circle({width:5,height:5})
      .fill(this.cityIndex === index ? Color.White:Color.Gray)
      .opacity(0.4)
  }

 async aboutToAppear() {
    if(await Preferences.getPreference('MyPreference','IndexCity',['beijing'])) {
      this.cityNameList = await Preferences.getPreference('MyPreference', 'IndexCity', ['beijing']) as string[]
      console.log('读取3',this.cityNameList);
    }

    interface ParamsType {
      //codes: number[];
      names: string[];
    }

    const params = router.getParams() as ParamsType | null;

    if (params&&params.names) {
      // this.cityCodeList = params.codes;
      this.cityNameList = params.names;
      Preferences.putPreference('MyPreference','IndexCity',this.cityNameList)
    }
    interface ParamsTypeDelete {
      //codes: number[];
      CITYS: string[];
    }

    const param = router.getParams() as ParamsTypeDelete | null;

    if (param&&param.CITYS) {
      // this.cityCodeList = params.codes;
      this.cityNameList = param.CITYS;
     Preferences.putPreference('MyPreference','IndexCity',this.cityNameList)
    }

    if(this.cityNameList.length>0) {
      this.initDate()

    }

  }
  // onPageShow(): void {
  //   this.initDate()
  // }
  async initDate(){
    let citycode:cityInfo[] = await citymodel.getcitys(this.cityNameList)
    console.log('1111111111'+citycode[0]);
    for(let j=0;j<citycode.length;j++){
      this.cityCodeList[j]=String(citycode[j].location[0].id)
      console.log('222222 '+this.cityCodeList)
    }

   for(let h = 0;h<this.cityCodeList.length;h++){
     let result7 = await weathermodel.getWeather7Day(this.cityCodeList[h].toString())
     let result = await weathermodel.getweather(this.cityCodeList[h])
     this.cityWeatherList7.push(result7)
     this.cityWeatherList.push(result)
    console.log('这个循坏的数据长度为：'+this.cityCodeList.length)
     console.log(`这个循坏的数据第${h}个：`+this.cityWeatherList7[h].daily[h].fxDate)
   }

    // for (let i = 0; i < result.length; i++) {
    //
    //   //let ACityWeather = new now()
    //   //ACityWeather = result[i].now
    //   console.log('result[i].now:',JSON.stringify(result[i].now))
    //   //this.cityWeatherList.push(ACityWeather)
    //   // let cityName = result[i]
    //   // this.cityNameList.push(cityName)
    //
    // }
  }
  build() {
Column(){
  Row() {

    Button('添加')
      .fontSize(25)
      .fontColor(Color.Gray)
      .opacity(0.7)
      .backgroundColor("#87CEEB")
      .margin({bottom:15})
      .onClick(()=>{
        router.pushUrl({
          url:"pages/AddCity",
          params:{
            //codes:this.cityCodeList,
            names:this.cityNameList
          }
        })

        })

    Text(this.cityNameList[this.cityIndex])
      .fontColor(Color.Orange)
      .fontSize(25)
    Button('删除')
      .fontSize(25)
      .fontColor(Color.Gray)
      .opacity(0.7)
      .backgroundColor("#87CEEB")
      .margin({bottom:15})
      .onClick(()=>{
        router.pushUrl({
          url:"pages/delete",
          params:{
            //codes:this.cityCodeList,
            names:this.cityNameList
          }
        })
        this.cityNameList=this.cityNameDeleteList
      })

  }
  .width('100%')
  .height('10%')
  .justifyContent(FlexAlign.SpaceBetween)

  Tabs({barPosition:BarPosition.Start,controller:this.tabController}){
    ForEach(this.cityWeatherList,(cityWeather:weatherInfo,index)=>{

        TabContent(){
            cityView({ casts: cityWeather.now, Casts: this.cityWeatherList7[index].daily })
              .layoutWeight(1)
            //Text(this.cityNameList).fontSize(40)
        }
        .tabBar(this.tabBuild(this.cityWeatherList.findIndex(obj=>obj===cityWeather)))




    })
  }
  .barWidth(20)
  .barHeight(40)
  .onChange((index:number)=>{
    this.cityIndex = index
  })
}
 .padding({ top: this.topRectHeight/2, bottom: this.bottomRectHeight/2 })
    .height('100%')
    .width('100%')
.layoutWeight(1)
    .backgroundColor("#87CEEB")
    .justifyContent(FlexAlign.Start)
  }
}




//   Button('测试')
//     .onClick(async () =>{
//       let data1:cityInfo = await citymodel.getcity('北京')
//
//       let citycode = await citymodel.getcitys(this.cityNameList)
//       for(let j=0;j<citycode.length;j++){
//         this.cityCodeList[j]=Number(citycode[j].location[0].id)
//       }
//       let result = await weathermodel.getweathers(this.cityCodeList)
//       for(let h = 0;h<this.cityCodeList.length;h++){
//         let result7 = await weathermodel.getWeather7Day(this.cityCodeList[h].toString())
//         this.cityWeatherList7.push(result7)
//       }
//       for (let i = 0; i < result.length; i++) {
//
//        // let ACityWeather = new now()
//         this.cityWeatherList.push(result[i])
//         let ACityWeather:now = result[i].now
//         //console.log('result[i].now:',JSON.stringify(result[i].now))
//         this.cityWeathernowList.push(ACityWeather)
//         // let cityName = result[i]
//         // this.cityNameList.push(cityName)
//
//       }
//       //this.test=JSON.stringify(result[0].now)
//       this.test=JSON.stringify(this.cityWeatherList[0])
//     })
//
//   Text(this.test)
// Button('测试1')  JSON.stringify(this.cityWeatherList[0])
//   .onClick(async () =>{
//     let data:weatherInfo = await weathermodel.getweather(101010100)
//     this.test1=JSON.stringify(data)
//   })
// Text(JSON.stringify(this.cityWeatherList7[0]))
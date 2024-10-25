import { now } from '../util/weatherInfo'
import {Daily} from '../util/CityWeather7Day'
import weathermodel from '../pages/weatherhttp'
import citymodel from '../pages/cityhttp'

@Preview
@Component
export struct cityView{


  @State casts:now ={
    obsTime: '',
    temp: '',
    feelsLike: '',
    icon: '',
    text: '',
    wind360: '',
    windDir: '',
    windScale: '',
    windSpeed: '',
    humidity: '',
    precip: '',
    pressure: '',
    vis: '',
    cloud: '',
    dew: ''
  };

  @State Casts:Daily[]=[]
  // aboutToAppear(): void {
  //   console.log('这个cast数据为：'+this.Casts[0].fxDate)
  //   console.log('这个cast数据为：'+this.Casts[1].fxDate)
  //   console.log('这个cast数据为：'+this.Casts[2].fxDate)
  //   console.log('这个cast数据为：'+this.Casts[3].fxDate)
  //   console.log('这个cast数据为：'+this.Casts[4].fxDate)
  //   console.log('这个cast数据为：'+this.Casts[5].fxDate)
  //   console.log('这个cast数据为：'+this.Casts[6].fxDate)
  // }
  // async test(){
  //   this.casts= (await weathermodel.getweather(101010100)).now
  //   this.Casts= (await weathermodel.getWeather7Day('101010100')).daily
  // }

  build() {
    //Scroll() {
      Column() {
        //if(this.casts&&this.Casts){

        Row() {

          Text(`${this.casts.temp}`)
            .fontSize(100)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
          Column() {
            Text('℃')
              .fontSize(40)
              .fontColor(Color.White)
            Blank()
            Text('体感')
              .fontSize(20)
              .fontColor(Color.Gray)
              .opacity(0.7)
            Text(this.casts.feelsLike + '℃')
              .fontSize(20)
              .fontColor(Color.Gray)
              .opacity(0.7)

          }
          // Text("刘子豪征婚启示：13107546018")
          //Image()
        }
        .height("30%")
        .width("100%")
        .justifyContent(FlexAlign.Center)

        Row() {
          Text(this.casts.text)
            .fontSize(30)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
          Text(' ' + this.Casts[0].tempMin + '~' + this.Casts[0].tempMax + '℃')
            .fontSize(30)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
          Text(this.casts.windDir)
            .fontSize(30)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
          Text(this.casts.windScale + '级')
            .fontSize(30)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
        .height("10%")
        .width("100%")
        .justifyContent(FlexAlign.Center)
      List({space:15}){
        ForEach(this.Casts, (cast: Daily) => {
          ListItem() {
            Row() {
              Text(cast.fxDate)
                .fontWeight(FontWeight.Bold)
                .fontSize(25)
                .fontColor(Color.White)
                .layoutWeight(1)
              Blank()
              Image($r(`app.media.${cast.iconDay}`)).width(25)
              Text('    '+cast.tempMin+'  ')
              .opacity(0.7)
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            Text(cast.tempMax)
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            }
            //.margin({bottom:100})
            .width('100%')
            .height(100)
          }
        })

      }
      .width("100%")
      .layoutWeight(1)
      // .justifyContent(FlexAlign.Start)
      // .alignItems(HorizontalAlign.Center)
    }
   // }.edgeEffect(EdgeEffect.Spring)
  }

}
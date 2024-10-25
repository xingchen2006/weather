// import http from '@ohos.net.http';
// import weatherInfo from '../util/weatherInfo'
// class weatherModel{
//   getweather(): Promise<weatherInfo> {
//     return new Promise((resolve, reject) => {
//       let httpRequest = http.createHttp()
//       httpRequest.request(
//         'https://devapi.qweather.com/v7/weather/now?location=101010100&key=86f0b7efe94248279d998825315b6beb',
//         {
//           method: http.RequestMethod.GET
//         }
//       )
//         .then(resp => {
//           if (resp.responseCode === 200) {
//
//             resolve(JSON.parse(resp.result.toString()))
//             console.log(resp.result.toString())
//           }
//           // else {(error:Error)=>
//           //   console.log('查询天气信息失败：error:', JSON.stringify(error))
//           //   reject('查询天气信息失败')
//           //   }
//         })
//         .catch((error: Error) => {
//          console.log( JSON.stringify(error))
//           reject('查询天气信息失败')
//         })
//
//
//     })
//   }
//
// }

















import { CityWeather7Day } from '../util/CityWeather7Day'
import http from '@ohos.net.http';
import weatherInfo from '../util/weatherInfo'; // 确保这个类型定义正确



class weatherModel {
  getweather(cityCode:string): Promise<weatherInfo> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      let url=`https://devapi.qweather.com/v7/weather/now?location=${cityCode}&key=86f0b7efe94248279d998825315b6beb`
      httpRequest.request(
        url,
        {
          method: http.RequestMethod.GET,
          // 可以添加其他必要的请求头
        }
      )
        .then(resp => {
          if (resp.responseCode == 200) {
            try {
              const data = JSON.parse(resp.result.toString()) as weatherInfo;
              resolve(data);
              console.info('Weather data:', resp.responseCode);
            } catch (parseError) {
              console.error('Failed to parse weather data:', parseError);
              reject('Failed to parse weather data');
            }
          } else {
            reject('Invalid response code or missing response data');
          }
        })
        .catch((error: Error) => {
          console.error('Error fetching weather data:', error);
          reject('Error fetching weather data');
        });
    });
  }

  async getweathers(cityCodes:Array<string>){

  let promises:Array<Promise<weatherInfo>> = []
  let weathermodel:Array<weatherInfo> = []
    for (let i = 0; i < cityCodes.length; i++) {
      promises.push(this.getweather(cityCodes[i]))
    }
    await Promise.all(promises).then(result=>{
     // for(const element of result){
     //   console.log(element)
     // }
      weathermodel = result
    })
  return weathermodel
  }

  public getWeather7Day(cityCode:string): Promise<CityWeather7Day> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      let url=`https://devapi.qweather.com/v7/weather/7d?location=${cityCode}&key=b4db6695147a45bcb7f1d114f24fea22`
      httpRequest.request(url, { method: http.RequestMethod.GET})
        .then(resp => {
          if (resp.responseCode == 200) {
            try {
              const result = JSON.parse(resp.result.toString()) as CityWeather7Day;
              resolve(result);
            } catch (parseError) {
              console.error('Failed to parse weather data:', parseError);
              reject('Failed to parse weather data');
            }
          } else {
            reject('Invalid response code or missing response data');
          }
        })
        .catch((error: Error) => {
          console.error('Error fetching weather data:', error);
          reject('Error fetching weather data');
        });
    });
  }
}
const weathermodel =new weatherModel()
export default weathermodel as weatherModel

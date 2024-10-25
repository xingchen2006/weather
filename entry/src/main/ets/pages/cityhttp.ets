import cityInfo from '../util/cityInfo'
import http from '@ohos.net.http';

class cityModel{
  getcity(code:string) :Promise<cityInfo>{
    return new Promise((resolve, reject) => {
      let httpRequest1 = http.createHttp();

      let newaddr=encodeURI(code)
      let url=`https://geoapi.qweather.com/v2/city/lookup?location=${newaddr}&key=86f0b7efe94248279d998825315b6beb`
      httpRequest1.request(
        url,
        {
          method: http.RequestMethod.GET,
          // 可以添加其他必要的请求头
        }
      )
        .then(resp => {
          if (resp.responseCode == 200) {
            try {
              const data = JSON.parse(resp.result.toString()) as cityInfo;
              resolve(data);
              console.info('resp.responseCode:', resp.responseCode);
            } catch (parseError) {
              console.error('Failed to parse city data:', parseError);
              reject('Failed to parse city data');
            }
          } else {
            reject('Invalid response code or missing response data');
          }
        })
        .catch((error: Error) => {
          console.error('Error fetching city data:', error);
          reject('Error fetching city data');
        });
    });
  }

  async getcitys(cityCodes:Array<string>){

    let promises:Array<Promise<cityInfo>> = []
    let citymodel:Array<cityInfo> = []
    for (let i = 0; i < cityCodes.length; i++) {
      promises.push(this.getcity(cityCodes[i]))
    }
    await Promise.all(promises).then(result=>{
      // for(const element of result){
      //   console.log(element)
      // }
      citymodel = result
    })
    return citymodel
  }
}
const citymodel =new cityModel()
export default citymodel as cityModel



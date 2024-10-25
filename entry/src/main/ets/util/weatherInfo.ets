

export interface now{
  obsTime: string
  temp: string
  feelsLike: string
  icon: string
  text: string
  wind360: string
  windDir:string
  windScale: string
  windSpeed:string
  humidity: string
  precip: string
  pressure: string
  vis: string
  cloud:string|null
  dew: string|null
}

interface refer{
  source:Array<string>|null
  license:Array<string>|null
}
export default class weatherInfo{
  code: number=0
  updateTime:  string =''
  fxLin:  string =''
  now: now = {
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
  refer: refer = {
    source: [],
    license: []
  };
}
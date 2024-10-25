// interface Name{
//   name: string
//   id: string
//   lat:  string
//   lon:  string
//   adm2: string
//   adm1:string
//   country: string
//   tz: string
//   utcOffset: string
//   isDst: string
//   type: string
//   rank:  string
//   fxLink: string
// }
// class NAME{
//   ame: string=''
//   id: string=''
//   lat:  string=''
//   lon:  string=''
//   adm2: string=''
//   adm1:string=''
//   country: string=''
//   tz: string=''
//   utcOffset: string=''
//   isDst: string=''
//   type: string=''
//   rank:  string=''
//   fxLink: string=''
// }
// interface refer{
//   source:Array<string>|null
//   license:Array<string>|null
// }
// export default class cityInfo {
//   code:number = 0
//   location:NAME[]= [{
//     ame:'',
//     id:'',
//     lat:'',
//     lon: '',
//     adm2: '',
//     adm1:'',
//     country:'',
//     tz: '',
//     utcOffset:'',
//     isDst:'',
//     type:'',
//     rank: '',
//     fxLink:''
//   }]
//   Refer: refer = {
//     source: [],
//     license: []
//   };
// }




class NAME{
    name: string=''
    id: string=''
    lat:  string=''
    lon:  string=''
    adm2: string=''
    adm1:string=''
    country: string=''
    tz: string=''
    utcOffset: string=''
    isDst: string=''
    type: string=''
    rank:  string=''
    fxLink: string=''
  }
class Refer{
    sources:Array<string>|null=null
    license:Array<string>|null=null
  }
export default class  cityInfo {
    code:number = 0
    location:NAME[]= []
    refer: Refer = {
      sources: [],
      license: []
    };
  }
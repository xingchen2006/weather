import  Preferences from  '@ohos.data.preferences'
//import UIAbility from '@ohos.app.ability.UIAbility';

import { JSON } from '@kit.ArkTS';
import {Context} from '@kit.AbilityKit'
class Preference{

  prefMap:Map<string,Preferences.Preferences> = new Map()

  async loadpreference(context:Context,name:string){
    try {
      let pref = await Preferences.getPreferences(context,name)
      this.prefMap.set(name,pref)
    } catch (e) {
      console.log('加载失败',JSON.stringify(e));
    }

  }
  async putPreference(name:string,key:string,value:Preferences.ValueType){
    // if(!this.prefMap.has(name)){
    //   return
    // }
    try{
      let pref= this.prefMap.get(name)
      await pref?.put('key',value)
      await pref?.flush()
      console.log(`保存${name}成功`)
    } catch (e) {
    console.log(`保存${name}失败`,JSON.stringify(e))
  }

  }

  async getPreference(name:string,key:string,defaultValue:Preferences.ValueType):Promise<Preferences.ValueType | undefined>{
    // if(!this.prefMap.has(name)&&!defaultValue){
    //   return
    // }
    try{
      let pref= this.prefMap.get(name)
      console.log(`读取1${name}成功`,defaultValue)
      let value=  await pref?.get('key',defaultValue)
      console.log(`读取${name}成功`,defaultValue)
      return value
      //let value=  await pref?.get(key,defaultValue)
      //console.log(`保存${name}成功`)
      //return value
    } catch (e) {
      console.log(`读取${name}失败`, JSON.stringify(e))
      return defaultValue;
    }
  }
}
const preference = new Preference()
export default preference as Preference
@Preview
@Component
export default struct  cityCard{
 @State cityName:string=''
  @State cityNameList:string[]=[]
  build() {
    Row(){


          Text(this.cityName)
            .width('95%')
            .padding(20)
            .backgroundColor(Color.White)
            .borderRadius(15)
            .shadow({radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4})

        .onClick(()=>{
          this.cityNameList.push(this.cityName)
        })
      }



  }
  // @Builder addButton(city:string){
  //   Button(){
  //     Text('添加')
  //       .backgroundColor(Color.Blue)
  //       .fontSize(10)
  //
  //   }
  //   .width(40)
  //   .height(40)
  //   .type(ButtonType.Circle)
  //   .backgroundColor(Color.Red)
  //   .margin(5)
  //   .onClick(() => {
  //     this.cityNameList.push(city)
  //   })
  // }

}
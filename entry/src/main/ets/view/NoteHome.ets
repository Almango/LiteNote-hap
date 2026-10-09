import common from '@ohos.app.ability.common';
import {GetAllNoteFunction} from "ets/viewmodel/Note";
import {GET} from "ets/model/Note";


@ComponentV2
export struct NoteHome {
  @Local Context:common.UIAbilityContext  = getContext(this) as common.UIAbilityContext;
  @Consumer('NavPathStack') MainStack: NavPathStack = new NavPathStack();
  @Local List: GET[] = []

  async aboutToAppear(): Promise<void> {
    this.List = await GetAllNoteFunction(this.Context)
  }
  build() {
    Column(){
      Scroll(){
        WaterFlow() {
          ForEach(this.List, (item: GET) => {
            FlowItem() {
              Column() {
                Text(item.title).fontSize(16).fontColor('#333').fontWeight(FontWeight.Medium)
                Text(item.content).fontSize(13).fontColor('#666').margin({top:8}).maxLines(4).textOverflow({ overflow: TextOverflow.Ellipsis })
                // Text(item.update).fontSize(10).fontColor('#999').margin({top:8})
              }
              .width('100%')
              .padding(12)
              .borderRadius(12)
              .backgroundColor(Color.White)
              .alignItems(HorizontalAlign.Start)
              .clip(true)
            }.onClick(()=>{
              this.MainStack.pushPath({ name: 'NoteContent', param: item.id});
              console.log(`你点击了id：${item.id}`)
            })
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .padding(12)
      }.edgeEffect(EdgeEffect.Spring)


      Button(){
        Image($r('app.media.plus')).width(26).fillColor('#333')
      }.width(50).height(50).borderRadius(50).position({right:12, bottom: 12})
      .backgroundColor('#fff')
      .shadow({ radius: 12, color: '#33000000', offsetX: 0, offsetY: 0 })
      .onClick(()=>{
        this.MainStack.pushPath({ name: 'NoteContent', param: -1 });
      })

    }
    .width('100%')
    .height('100%')
  }
}

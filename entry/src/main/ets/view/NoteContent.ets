import common from '@ohos.app.ability.common';
import {GET} from "ets/model/Note";
import {CreateNoteFunction, UpdateNoteFunction, GetNoteFunction} from "ets/viewmodel/Note";


@ComponentV2
export struct NoteContent {
  @Local Param:number = 0
  @Local TempTitle: string = ''
  @Local TempContent: string = ''
  @Local TempCategory: string = ''
  @Local NoteData:GET = {}
  @Local Context:common.UIAbilityContext  = getContext(this) as common.UIAbilityContext;

  build() {
    NavDestination() {
      if (this.Param == -1){
        Column() {
          Column({ space: 4 }) {
            TextInput({placeholder: '未命名' })
              .type(InputType.Normal)
              .fontSize(24)
              .placeholderFont({ size: 24, weight: FontWeight.Bold })
              .fontWeight(FontWeight.Bold)
              .padding(0)
              .borderRadius(0)
              .backgroundColor(Color.Transparent)
              .onChange((value)=>{
                this.TempTitle = value
              })

            Row() {
              Text() {
                Span('2026/10/16').fontColor('#999')
                Span(' · ')
              }.fontSize(14)
              Text() {
                Span(`999字`).fontColor('#999')
                Span(' · ')
              }.fontSize(14)
              Text() {
                Span('未分类').fontColor('#999')
              }.fontSize(14)
            }.width('100%')
          }.padding({ left: 20, right: 20 })

          TextArea({ placeholder: '正文输入处...' })
            .fontSize(16)
            .padding(0)
            .margin({ top: 6 })
            .padding({ left: 20, right: 20 })
            .borderRadius(0)
            .backgroundColor(Color.Transparent)
            .layoutWeight(1)
            .defaultFocus(true)
            .textAlign(TextAlign.JUSTIFY)
            .onChange((value)=>{
              this.TempContent = value
            })
        }.width('100%').height('100%')
      }
      else {
        Column() {
          Column({ space: 4 }) {
            TextInput({text: this.NoteData.title })
              .type(InputType.Normal)
              .fontSize(24)
              .placeholderFont({ size: 24, weight: FontWeight.Bold })
              .fontWeight(FontWeight.Bold)
              .padding(0)
              .borderRadius(0)
              .backgroundColor(Color.Transparent)
              .onChange((value)=>{
                this.TempTitle = value
              })

            Row() {
              Text() {
                Span('2026/10/16').fontColor('#999')
                Span(' · ')
              }.fontSize(14)
              Text() {
                Span(`999字`).fontColor('#999')
                Span(' · ')
              }.fontSize(14)
              Text() {
                Span(this.NoteData.category).fontColor('#999')
              }.fontSize(14)
            }.width('100%')
          }.padding({ left: 20, right: 20 })

          TextArea({ text: this.NoteData.content })
            .fontSize(16)
            .padding(0)
            .margin({ top: 6 })
            .padding({ left: 20, right: 20 })
            .borderRadius(0)
            .backgroundColor(Color.Transparent)
            .layoutWeight(1)
            .defaultFocus(true)
            .textAlign(TextAlign.JUSTIFY)
            .onChange((value)=>{
              this.TempContent = value
            })
        }
        .width('100%')
        .height('100%')
      }
    }
    .hideTitleBar(false)
    .onReady(async (ctx: NavDestinationContext) => {
      this.Param = ctx.pathInfo.param as number;
      if (this.Param > 0) {
        this.NoteData = await GetNoteFunction(this.Context, this.Param)
      }
    })
    .onDisAppear(async ()=>{
      if (this.Param > 0) {
        await UpdateNoteFunction(this.Context, this.Param, {title:this.TempTitle, content:this.TempContent})
      }
      else {
        if (this.TempTitle || this.TempContent) {
          CreateNoteFunction(this.Context, {title:this.TempTitle, content:this.TempContent})
        }
      }
    })
  }
}

@Builder
export function NoteContentBuilder() {
  NoteContent()
}
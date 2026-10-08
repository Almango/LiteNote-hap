@ComponentV2
export struct NoteContent {

  build() {
    NavDestination() {
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
      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(false)
    .title('')
    .backgroundColor(Color.White)
  }
}

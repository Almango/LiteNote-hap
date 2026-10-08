interface NoteItem {
  title: string
  content: string
  update: string
}

@ComponentV2
export struct NoteHome {

  @Consumer('NavPathStack') MainStack: NavPathStack = new NavPathStack();

  @Local list: NoteItem[] = [
    {title:"桌面整理计划", content:"今天计划整理桌面，把文件分类存放", update: '今天9:23'},
    {title:"周末户外散心", content:"周末打算出门散步，去公园看看花草，放松一下", update: '昨天10:00'},
    {title:"ArkUI学习笔记", content:"学习ArkUI开发，练习WaterFlow瀑布流组件，熟悉FlowItem使用，掌握卡片布局和文本截断相关API。", update: '昨天15:50'},
    {title:"生活用品采购清单", content:"采购生活用品，纸巾、洗衣液、饮用水，记得对比价格，优先挑选性价比高的商品，不要冲动消费。", update: '昨天18:00'},
    {title:"读书笔记复盘", content:"阅读读书笔记，回顾之前摘抄的句子，思考里面表达的含义，沉淀自己的想法，方便后续复盘。", update: '前天08:10'},
    {title:"番茄炖牛腩食谱", content:"练习做饭，准备尝试番茄炖牛腩", update: '前天14:30'},
    {title:"相册整理归档", content:"整理相册", update: '前天20:15'},
    {title:"月度收支规划", content:"规划下个月开销，统计各项支出，缩减不必要花费，预留一部分存款，养成储蓄习惯。", update: '3天前09:40'},
    {title:"运动健身打卡", content:"健身打卡，慢跑三十分钟，拉伸放松肌肉，坚持规律运动，改善久坐带来的身体酸痛问题。", update: '3天前16:20'},
    {title:"人文纪录片观看", content:"看一部高分纪录片。", update: '4天前19:00'},
    {title:"耳机故障排查", content:"维修耳机，检查故障来源，尝试自行排查问题。", update: '4天前11:35'},
    {title:"学习任务清单", content:"写一份学习清单，划分每日任务，设定阶段性目标，稳步推进，避免拖延，按时完成计划。", update: '5天前10:10'}
  ]

  build() {
    Column(){
      Scroll(){
        WaterFlow() {
          ForEach(this.list, (item: NoteItem) => {
            FlowItem() {
              Column() {
                Text(item.title).fontSize(16).fontColor('#333').fontWeight(FontWeight.Medium)
                Text(item.content).fontSize(13).fontColor('#666').margin({top:8}).maxLines(4).textOverflow({ overflow: TextOverflow.Ellipsis })
                Text(item.update).fontSize(10).fontColor('#999').margin({top:8})
              }
              .width('100%')
              .padding(12)
              .borderRadius(12)
              .backgroundColor(Color.White)
              .alignItems(HorizontalAlign.Start)
              .clip(true)
            }
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
        this.MainStack.pushPath({ name: 'NoteContent' });
      })

    }
    .width('100%')
    .height('100%')
  }
}

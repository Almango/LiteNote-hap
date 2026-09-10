import { Note } from "../view/Note";
import { Todo } from "../view/Todo";

interface TabItem {
  title: string,
  icon: Resource
}

@Entry
@ComponentV2
struct Index {
  @Local tabItem: TabItem[] = [
    { title: '笔记', icon: $r('app.media.text') },
    { title: '代办', icon: $r('app.media.todo') },
    { title: '日程', icon: $r('app.media.calendar') },
    { title: '设置', icon: $r('app.media.adjust') }
  ]
  @Local currentTabIndex: number = 0;

  @Builder
  CustomTabBars(index: number, title: string, icon: Resource) {
    Column({ space: 5 }) {
      Image(icon)
        .width(24)
        .height(24)
        .fillColor(this.currentTabIndex === index ? '#333' : '#999')
      Text(title)
        .fontColor(this.currentTabIndex === index ? '#333' : '#999')
        .fontSize(12)
    }
  }

  build() {
    Column() {
      Row() {
        Text(this.tabItem[this.currentTabIndex].title)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
        Row({ space: 12 }) {
          Image($r('app.media.search')).width(26)
          Image($r('app.media.sort')).width(26)
        }
      }
      .width('100%')
      .height(60)
      .padding({ left: 12, right: 12 })
      .justifyContent(FlexAlign.SpaceBetween)

      Tabs({ barPosition: BarPosition.End }) {
        TabContent() { Note() }
        .tabBar(this.CustomTabBars(0, this.tabItem[0].title, this.tabItem[0].icon))
        .backgroundColor('#f7f7f7')

        TabContent() { Todo() }
        .tabBar(this.CustomTabBars(1, this.tabItem[1].title, this.tabItem[1].icon))
        .backgroundColor('#fffafafa')

        TabContent() { Todo() }
        .tabBar(this.CustomTabBars(2, this.tabItem[2].title, this.tabItem[2].icon))
        .backgroundColor('#fffafafa')

        TabContent() { Todo() }
        .tabBar(this.CustomTabBars(3, this.tabItem[3].title, this.tabItem[3].icon))
        .backgroundColor('#fffafafa')
      }
      .layoutWeight(1)
      .width("100%")
      .height("100%")
      .vertical(false)
      .scrollable(false)
      .animationDuration(0)
      .onChange((index: number) => {
        this.currentTabIndex = index;
      })
    }
    .height('100%')
    .width('100%')
  }
}

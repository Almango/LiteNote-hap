import relationalStore from '@ohos.data.relationalStore';
import common from '@ohos.app.ability.common';

const DB_NAME = 'LiteNote.db';
const DB_VERSION = 1;


/*
* id：备忘录的唯一标识
* title：备忘录的标题
* content：备忘录的正文
* category：备忘录的分类
* create_time：备忘录创建时间（系统自动更改）
* update_time：备忘录最后更新时间（系统自动更改）
*/

const CREATE_NOTE_TABLE = `CREATE TABLE IF NOT EXISTS Note (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT,
  category TEXT,
  create_time TEXT DEFAULT CURRENT_TIMESTAMP,
  update_time TEXT DEFAULT CURRENT_TIMESTAMP
)`;

let RDBStore: relationalStore.RdbStore | null = null;

export async function getStore(context: common.UIAbilityContext): Promise<relationalStore.RdbStore> {
  if (RDBStore) {
    return RDBStore;
  }

  const config: relationalStore.StoreConfig = {
    name: DB_NAME,
    securityLevel: relationalStore.SecurityLevel.S1
  };

  RDBStore = await relationalStore.getRdbStore(context, config);
  await RDBStore.executeSql(CREATE_NOTE_TABLE);
  console.log('[DB] Note表就绪, version:', DB_VERSION.toString());
  return RDBStore;
}

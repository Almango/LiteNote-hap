import common from '@ohos.app.ability.common';
import relationalStore from '@ohos.data.relationalStore';
import { getStore } from '../DB/DBManager';
import { CREATE, UPTATE, GET } from '../model/Note';


export async function CreateNoteFunction(context: common.UIAbilityContext, data: CREATE): Promise<number> {
  try {
    const Store = await getStore(context);
    const values: relationalStore.ValuesBucket = {
      title: data.title ?? '未命名',
      content: data.content ?? '',
    };
    const rowId = await Store.insert('Note_Table', values);
    console.log('[NOTE] 创建成功:', rowId.toString());
    return rowId;
  } catch (err) {
    console.error('[NOTE] 创建失败:', JSON.stringify(err));
    return -1;
  }
}

// 获取所有分组
export async function GetAllNoteFunction(context: common.UIAbilityContext): Promise<GET[]>{
  try {
    const Store = await getStore(context);

    const predicates = new relationalStore.RdbPredicates('Note_Table');
    const resultSet = await Store.query(predicates, ['id','title','content']);
    const list: GET[] = [];
    while (resultSet.goToNextRow()) {
      list.push({
        id: resultSet.getLong(resultSet.getColumnIndex('id')),
        title: resultSet.getString(resultSet.getColumnIndex('title')),
        content: resultSet.getString(resultSet.getColumnIndex('content')),
        category: resultSet.getString(resultSet.getColumnIndex('content')),
      });
    }
    resultSet.close();
    console.log('[NOTE] 获取成功:', JSON.stringify(list))
    return list;
  } catch (err) {
    console.error('[NOTE] 获取失败:', JSON.stringify(err))
    return []
  }
}

// 根据 id 获取指定笔记（调用方保证 id 一定存在）
export async function GetNoteFunction(context: common.UIAbilityContext, id: number): Promise<GET> {
  const Store = await getStore(context);

  const predicates = new relationalStore.RdbPredicates('Note_Table');
  predicates.equalTo('id', id);
  const resultSet = await Store.query(predicates, ['id', 'title', 'content', 'category']);

  resultSet.goToFirstRow();   // 直接去第一行，不管返回啥
  const note: GET = {
    id: resultSet.getLong(resultSet.getColumnIndex('id')),
    title: resultSet.getString(resultSet.getColumnIndex('title')),
    content: resultSet.getString(resultSet.getColumnIndex('content')),
    category: resultSet.getString(resultSet.getColumnIndex('category')),
  };
  resultSet.close();
  console.log('[NOTE] 获取成功:', JSON.stringify(note));
  return note;
}


// 更新指定 id 的笔记
export async function UpdateNoteFunction(context: common.UIAbilityContext, id: number, data: UPTATE): Promise<boolean> {
  try {
    const Store = await getStore(context);

    const values: relationalStore.ValuesBucket = {};
    // 只更新传进来的字段，没传的保持原值
    if (data.title !== undefined) {
      values.title = data.title;
    }
    if (data.content !== undefined) {
      values.content = data.content;
    }
    if (data.category !== undefined) {
      values.category = data.category;
    }

    // 没有任何字段要更新，直接返回
    if (Object.keys(values).length === 0) {
      console.warn('[NOTE] 没有需要更新的字段');
      return false;
    }

    const predicates = new relationalStore.RdbPredicates('Note_Table');
    predicates.equalTo('id', id);

    const rows = await Store.update(values, predicates);
    console.log('[NOTE] 更新成功, 影响行数:', rows);
    return rows > 0;
  } catch (err) {
    console.error('[NOTE] 更新失败:', JSON.stringify(err));
    return false;
  }
}
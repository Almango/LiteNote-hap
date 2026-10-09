export interface GET{
  id?: number
  title?: string
  content?: string
  category?: string
}

export interface CREATE {
  title?: string
  content?: string
  category?: string
}

export interface UPTATE{
  title?: string
  content?: string
  category?: string
}


export interface NoteNavParam {
  id: number
}

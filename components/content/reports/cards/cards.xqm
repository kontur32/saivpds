module namespace cards = 'content/reports/cards';

declare function cards:main( $params ){
  
  let $dataRaw :=
    $params?_getFile( 'Аттестация/ДО_набор.xlsx', '.' )
    /file/table
  
  let $группа :=
    if( request:parameter( 'группа' ) )
    then( request:parameter( 'группа' ) )
    else( $dataRaw[ 1 ]/@label/data() )
  
  let $год := 
    if( request:parameter( 'год' ) )
    then( request:parameter( 'год' ) )
    else( 1 )

  let $данныеГруппы := 
    $dataRaw[ @label = $группа ]/row
 
  let $названияГрупп := 
    for $i in $dataRaw/@label/data()
    return
      if( $i = $группа )
      then(
        <b>{ $i }</b>
      )
      else(
        <a href = "?группа={ $i }&amp;год={ $год }">{ $i }</a>
      )
        
  let $годыОбучения := 
    for $i in ( 1, 2, 3, 4 )
    return
      if( $i = $год )
      then(
        <b>{ $i }</b>
      )
      else(
        <a href = "?группа={ $группа }&amp;год={ $i }">{ $i }</a>
      )
      
  let $таблица :=
    <table>
      <tr>
        <th>Студент</th>
        <th>Карточка</th>
      </tr>
    {
      for $i in $данныеГруппы[ 1 ]/cell[ position() > 1 ]
      where $i/text()
      let $href := '/saivpds/api/v01/print/groups/' ||  $группа  || '/students/' ||  $i/text() || '/card/years/' || $год
      return
        <tr>
          <td>{ $i/@label/data() }</td>
          <td><a href = "{ $href }">скачать</a></td>
        </tr>
    }</table>  
  
  return
    map{
      "группы" : $названияГрупп,
      "годыОбучения" : $годыОбучения,
      "год" : $год,
      "группа" : $группа,
      "карточкиЗаГод" : $таблица
    }
};
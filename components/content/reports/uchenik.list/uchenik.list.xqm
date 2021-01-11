module namespace uchenik.list = 'content/reports/uchenik.list';

declare function uchenik.list:main( $params ){
  
  let $data := $params?_getFile( 'students.xlsx', 'store.yandex.jornal' )
    
  let $строкиТаблицы :=
    uchenik.list:строкиТаблицы( $data//table[@label = "ППС"]/row )
    
  return
    map{
      'строкиТаблицы' : $строкиТаблицы
    }
};

declare function uchenik.list:строкиТаблицы( $data ){
  <tbody>
    {
      for $i in $data
      let $годПоступления := $i/cell[ @label = 'Год РУПа' ]/text()
      let $фамилия := $i/cell[ @label = 'Фамилия' ]/text()
      order by $фамилия
      order by $годПоступления
      return
        <tr>
          <td>{ $фамилия }</td>
          <td>{
            $i/cell[ @label = 'Имя' ]/text()
          }</td>
          <td>{
            $i/cell[ @label = 'Отчество' ]/text()
          }</td>
          <td align='center'>{ $годПоступления }</td>
        </tr>
    }
  </tbody>
};
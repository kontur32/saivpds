module namespace uchenik.list = 'content/reports/uchenik.list';

declare function uchenik.list:main( $params ){
  
  let $data := $params?_getFile( 'students.xlsx', '.' )
    
  let $строкиТаблицы :=
    uchenik.list:строкиТаблицы( $data//table[ @label = "ОЗО 2017" ]/row )
    
  return
    map{
      'строкиТаблицы' : $строкиТаблицы
    }
};

declare function uchenik.list:строкиТаблицы( $data ){
  <tbody>
    {
      for $i in $data
      count $c
      let $фамилия := $i/cell[ @label = 'Фамилия' ]/text()
      order by $фамилия
      count $п
      let $href :=
        for $страницы in ( '1', '2', '3' )
        return
          web:create-url(
            '/saivpds/api/v01/print.diploma/' || $страницы,
            map{
              'id' : $i/cell[ @label = 'номер личного дела' ]/text(),
              'group' : 'ОЗО 2017'
            }
          )
      return
        <tr>
          <td class = "text-center">{ $п }.</td>
          <td>{ $фамилия }</td>
          <td>{
            $i/cell[ @label = 'Имя' ]/text()
          }</td>
          <td>{
            $i/cell[ @label = 'Отчество' ]/text()
          }</td>
          <td align='center'><a href = "{ $href[ 1 ] }">лист 1</a></td>
          <td align='center'><a href = "{ $href[ 2 ] }">лист 2</a></td>
          <td align='center'><a href = "{ $href[ 3 ] }">лист 3</a></td>
        </tr>
    }
  </tbody>
};
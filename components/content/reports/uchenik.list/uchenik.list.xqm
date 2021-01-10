module namespace uchenik.list = 'content/reports/uchenik.list';

declare function uchenik.list:main( $params ){
  
  let $data := $params?_getFile( '/students.xlsx', 'store.yandex.jornal' )
    
  let $table :=
    <table class = 'table-striped'>
      <tr>
        <th>Фамилия</th>
        <th>Имя</th>
        <th>Отчество</th>
      </tr>
      {
        for $i in $data//table[@label = "ППС"]/row
        return
          <tr>
            <td>{
              $i/cell[ @label = 'Фамилия' ]/text()
            }</td>
            <td>{
              $i/cell[ @label = 'Имя' ]/text()
            }</td>
            <td>{
              $i/cell[ @label = 'Отчество' ]/text()
            }</td>
          </tr>
      }
    </table>
  return
  map{
    'содержание' : $table
  }
};
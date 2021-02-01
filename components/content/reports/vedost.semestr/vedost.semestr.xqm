module namespace vedost.semestr = 'content/reports/vedost.semestr';

declare function vedost.semestr:main( $params ){
  
  let $семестр := request:parameter( 'семестр', 4 )
  
  let $data := 
    fetch:text(
      web:create-url(
        'http://localhost:9984/trac/api/v0.1/u/data/stores/' || $params?_config('store.yandex.jornal'),
        map{
          'access_token' : session:get('access_token'),
          'path' : 'Аттестация/ДО_набор_2018-tmp.xlsx',
          'xq' : 'http://localhost:9984/static/saivpds/funct/ocenkiZaSemestr.xq',
          'sem' : $семестр
        }
      )
    )
    
  let $строкиТаблицы :=
    vedost.semestr:строкиТаблицы( json:parse( $data ) )
  let $семестры := 
    for $i in 1 to 4
    return
      if( $i = $семестр )
      then(
        <span class="ml-2">{ $i }</span>
      )
      else(
        <a class="ml-2" href = "{'?семестр=' || $i }"> { $i } </a>
      )
      
  return
    map{
      'семестры' : $семестры,
      'семестр' : $семестр,
      'таблица' : $строкиТаблицы
    }
};

declare function vedost.semestr:строкиТаблицы( $data ){
  <div>
    <table class = 'table-striped'>
        <thead>
          <tr>
            <th>ФИО</th>
            <th>Количество оценок</th>
            <th>Средний балл</th>
          </tr>
        </thead>
        <tbody>
         {
           for $i in $data//студент
           return
             <tr>
               <td>{ $i/фио/text() }</td>
               <td>{ $i/количествоОценок/text() }</td>
               <td>{ $i/средняяОценка/text() }</td>
             </tr>
         }
        </tbody>
      </table>
    </div>
  
};
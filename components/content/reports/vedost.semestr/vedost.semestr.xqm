module namespace vedost.semestr = 'content/reports/vedost.semestr';

declare function vedost.semestr:main( $params ){
  
  let $семестр := request:parameter( 'семестр', 4 )
  let $группа := request:parameter( 'группа', "ДО 2018" )
  
  let $dataRaw := 
    fetch:text(
      web:create-url(
        'http://localhost:9984/trac/api/v0.1/u/data/stores/' || $params?_config('store.yandex.jornal'),
        map{
          'access_token' : session:get('access_token'),
          'path' : 'Аттестация/ДО_набор_2018-tmp.xlsx',
          'xq' : 'http://localhost:9984/static/saivpds/funct/ocenkiZaSemestr.xq',
          'семестр' : $семестр
        }
      )
    )
  let $dataParsed := json:parse( $dataRaw )/json/группа
  let $data := $dataParsed[ номерГруппы = $группа ]
  let $списокСеместров := $data/семестры/семестр/номерСеместра/text()
  
  let $строкиТаблицы :=
    vedost.semestr:строкиТаблицы(
       $data/семестры/семестр[номерСеместра/text() = $семестр ]/студенты/студент
      )
  let $среднийБаллПоСеместрам := 
    vedost.semestr:среднийБаллПоСеместрам(
      $data/семестры/семестр
    )
  
  let $группы := 
    for $i in $dataParsed/номерГруппы/text()
    return
      if( $i = $группа )
      then(
        <span class="ml-2">{ $i }</span>
      )
      else(
        <a class="ml-2" href = "{'?группа=' || $i || '&amp;семестр=' || $семестр }"> { $i }</a>
      )
  
  let $семестры := 
    for $i in $data/семестры/семестр[ студенты ]/номерСеместра/text()
    return
      if( $i = $семестр )
      then(
        <span class="ml-2">{ $i }</span>
      )
      else(
        <a class="ml-2" href = "{'?семестр=' || $i || '&amp;группа=' || $группа}"> { $i }</a>
      )
      
  return
    map{
      'семестры' : $семестры,
      'группы' : $группы,
      'семестр' : $семестр,
      'таблица' : $строкиТаблицы,
      'среднийБаллПоСеместрам' : $среднийБаллПоСеместрам
    }
};

declare function vedost.semestr:строкиТаблицы( $data as element( студент )* ){
  <div>
    <table class = 'table-striped'>
        <thead>
          <tr class = "text-center">
            <th>Студент</th>
            <th>Количество оценок</th>
            <th>Средний балл</th>
          </tr>
        </thead>
        <tbody>
         {  
           for $i in $data
           return
             <tr>
               <td>{ $i/фио/text() }</td>
               <td class = "text-center">{ $i/количествоОценок/text() }</td>
               <td class = "text-center">{ $i/средняяОценка/text() }</td>
             </tr>
         }
          <tr>
            <th colspan='2' >Срений балл группы</th>
            <th class = "text-center">{
              round(
                avg( $data/средняяОценка/text() ), 2
             )
            }</th>
          </tr>
        </tbody>
      </table>
    </div>
};

declare function vedost.semestr:среднийБаллПоСеместрам( $data as element( семестр )* ){
  <div>
    <table class = 'table-striped'>
        <thead>
          <tr class = "text-center">
            <th>Номер семестра</th>
            <th>Количество оценок</th>
            <th>Средний балл</th>
          </tr>
        </thead>
        <tbody>
          {
            for $i in $data
            return
              <tr class = "text-center">
                <td >{ $i/номерСеместра/text() }</td>
                <td>{ max( $i/студенты/студент/количествоОценок ) }</td>
                <td>{ round( avg( $i/студенты/студент/средняяОценка ), 2 ) }</td>
              </tr>
          }
          <tr>
            <th colspan='2' >Срений за весь период</th>
            <th class = "text-center">{
              round(
                avg( $data/студенты/студент/средняяОценка ), 2
             )
            }</th>
          </tr>
        </tbody>
    </table>
 </div>
};
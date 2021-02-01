module namespace vedost.semestr = 'content/reports/vedost.semestr';

declare function vedost.semestr:main( $params ){
  let $dataRaw :=
    $params?_getFile(
      'Аттестация/ДО_набор.xlsx',
      $params?_config( "api.functions.path" ) || 'vedost.semestr.xq'
    )
  
  let $всеГруппы := json:parse( $dataRaw )/json/группа
  let $списокГрупп := $всеГруппы/номерГруппы/text()
  let $текущаяГруппа := request:parameter( 'группа', $списокГрупп[ 1 ] )
  
  let $группа := $всеГруппы[ номерГруппы = $текущаяГруппа ]
  let $всеСеместры := $группа/семестры/семестр
  let $списокСеместров := $всеСеместры[ студенты ]/номерСеместра/text()
  
  let $текущийСеместр := request:parameter( 'семестр', $списокСеместров[ 1 ] )

  let $строкиТаблицы :=
    vedost.semestr:успеваемостьЗаСеместр(
       $всеСеместры[ номерСеместра/text() = $текущийСеместр ]/студенты/студент
      )
  let $среднийБаллПоСеместрам := 
    vedost.semestr:среднийБаллПоСеместрам(
      $всеСеместры
    )
  
  let $группыМеню := 
    for $i in $списокГрупп
    return
      if( $i = $текущаяГруппа )
      then( <span class="ml-2">{ $i }</span> )
      else( <a class="ml-2" href = "{'?группа=' || $i }"> { $i }</a> )
  
  let $семестрыМеню := 
    for $i in $списокСеместров
    return
      if( $i = $текущийСеместр )
      then( <span class="ml-2">{ $i }</span> )
      else(
        <a class="ml-2" href = "{'?семестр=' || $i || '&amp;группа=' || $текущаяГруппа}"> { $i }</a>
      )
      
  return
    map{
      'семестры' : $семестрыМеню,
      'группы' : $группыМеню,
      'семестр' : $текущийСеместр,
      'успеваемостьЗаСеместр' : $строкиТаблицы,
      'среднийБаллПоСеместрам' : $среднийБаллПоСеместрам
    }
};

declare function vedost.semestr:успеваемостьЗаСеместр( $студенты as element( студент )* ){
  <div>
    <table class = 'table-striped'>
        <thead>
          <tr class = "text-center">
            <th>Студент</th>
            <th>Оценок</th>
            <th>Средний балл</th>
          </tr>
        </thead>
        <tbody>
         {  
           for $i in $студенты
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
                avg( $студенты/средняяОценка/text() ), 2
             )
            }</th>
          </tr>
        </tbody>
      </table>
    </div>
};

declare function vedost.semestr:среднийБаллПоСеместрам( $семестры as element( семестр )* ){
    <table class = 'table-striped'>
        <thead>
          <tr class = "text-center">
            <th>Семестр</th>
            <th>Оценок</th>
            <th>Средний балл</th>
          </tr>
        </thead>
        <tbody>
          {
            for $i in $семестры
            return
              <tr class = "text-center">
                <td >{ $i/номерСеместра/text() }</td>
                <td>{ max( $i/студенты/студент/количествоОценок ) }</td>
                <td>{ round( avg( $i/студенты/студент/средняяОценка ), 2 ) }</td>
              </tr>
          }
          <tr>
            <th colspan='2' >Средний за весь период</th>
            <th class = "text-center">{
              round(
                avg( $семестры/студенты/студент/средняяОценка ), 2
             )
            }</th>
          </tr>
        </tbody>
    </table>
};
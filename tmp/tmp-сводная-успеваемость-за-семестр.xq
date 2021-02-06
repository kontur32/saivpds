import module namespace funct = "funct" at '../functions/functions.xqm';

declare function local:соводнаяЗаСеместр( $data as element( table )*, $семестр as xs:string ){
   let $rows := 
     for $i in $data//row[ position() > 1 ][ cell [ @label = 'Семестр' ] = $семестр ]/cell[ position() > 5 ]
    let $fio := $i/@label
    let $val := $i/number( text() )
    where $val
    group by $fio
    return
     <студент type = "object">
       <фио type = "string">{ $fio }</фио>
       <количествоОценок type = "number">{ count( $i ) }</количествоОценок>
       <средняяОценка type = "number">{ round( avg( $val ), 2 ) }</средняяОценка>
     </студент>
   return
     <json type = "object">{ $rows }</json>
      
};

let $token :=
  'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9wb3J0YWwudGl0dWwyNC5ydSIsImlhdCI6MTYxMjE2MDExOSwibmJmIjoxNjEyMTYwMTE5LCJleHAiOjE2MTI3NjQ5MTksImRhdGEiOnsidXNlciI6eyJpZCI6IjUifX19.HwtXz8hOqiZIws6OoxC0TZvFuZoMmaiz_md9Df5-rGA'

let $data :=
  funct:getFile(
   'Аттестация/ДО_набор_2018-tmp.xlsx',
   funct:param( 'store.yandex.jornal' ), 
   $token
  )/file/table
return
(
  json:serialize(
    local:соводнаяЗаСеместр( $data, '4' )
  )
)
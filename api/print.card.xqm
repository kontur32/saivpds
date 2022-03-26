module namespace card = "/saivpds/api/v01/print.diploma";

import module namespace diploma = "/saivpds/api/v01/print.diploma" at 'print.diploma.xqm';
import module namespace funct = "funct" at '../functions/functions.xqm';
import module namespace config = "app/config"  at '../functions/config.xqm';

declare 
  %rest:GET
  %rest:path( "/saivpds/api/v01/print/groups/{ $group }/students/{ $id }/card/years/{ $year }" )
function card:main( $id, $group, $year ){
let $host := $config:param('host')
let $templatePath := 
    'http://dbx.iro37.ru/zapolnititul/api/v2/forms/f2928d8c-39a6-4996-977d-ed842930ee1b/template'

let $номерСеместраОсень := xs:string( ( $year - 1 ) * 2 + 1 )
let $номерСеместраВесна :=  xs:string( ( $year - 1 ) * 2 + 2 )

let $оценки1 :=
    funct:getFileWithParams( 
        'Аттестация/ДО_набор.xlsx',
        '.',
        map{ }
      )

let $оценки :=
    funct:getFileWithParams( 
        'Аттестация/ДО_набор.xlsx',
        'http://localhost:9984/static/saivpds/funct/ocenki.student.xq',
        map{
          'id' : $id,
          'group' : $group
        }
      )
      /json/оценки/дисциплина
   
let $fields := 
  let $студент :=
    funct:getFile( 'students.xlsx', '.'
    )/file/table[ @label = $group ]/row[cell[@label="номер личного дела"] = $id ]
  
  return  
    <table>
      <row  id = 'fields'>
        <cell id = 'Фамилия студента'>{ $студент/cell[@label = 'Фамилия']/text() }</cell>
        <cell id = 'Имя студента'>{ $студент/cell[@label = 'Имя']/text() }</cell>
        <cell id = 'Отчество студента'>{ $студент/cell[@label = 'Отчество']/text() }</cell>
        <cell id = 'годРУПа'>{ replace( $group, '\D', '' ) }</cell>
        <cell id = 'номерСеместраВесна'>{ $номерСеместраОсень }</cell>
        <cell id = 'номерСеместраОсень'>{ $номерСеместраВесна }</cell>
      </row>
      <row id = 'tables'>
        <cell id = 'Оценки_осень'>
          <table>{ card:оценкиЗаСеместр( $оценки, $номерСеместраОсень ) }</table>
        </cell>
        <cell id = 'Оценки_весна'>
          <table>{ card:оценкиЗаСеместр( $оценки, $номерСеместраВесна ) }</table>
        </cell>
        <cell id = 'Курсовые_осень'>
          <table>{ card:курсовыеЗаСеместр( $оценки, $номерСеместраОсень ) }</table>
        </cell>
        <cell id = 'Курсовые_весна'>
          <table>{ card:курсовыеЗаСеместр( $оценки, $номерСеместраВесна ) }</table>
        </cell>
      </row>
    </table>
    
  return
    diploma:fillTemplate( $fields, $templatePath, 'card.docx',  $host)
};

declare function card:курсовыеЗаСеместр( $оценки, $номерСеместра ){
   for $i in $оценки
    where $i/семестр = $номерСеместра
    where $i/формаОтчетности/text() = 'курсовая работа'
    count $c
    let $дата := 
      replace(
          xs:string( $i/дата/text() ),
         '(\d{4})-(\d{2})-(\d{2})',
         '$3.$2.$1'
       )
    return
      <row>
        <cell>{ $c }</cell>
        <cell>{ $i/название/text() }</cell>
        <cell>{ $i/ЗЕТ/text() }</cell>
        <cell>{ $i/оценкаПрописью/text() }</cell>
        <cell></cell>
        <cell>{ $дата }</cell>
      </row>
};

declare function card:оценкиЗаСеместр( $оценки, $номерСеместра ){
  for $i in $оценки
    where $i/семестр/text() = $номерСеместра
    where $i/формаОтчетности/text() = ('экзамен', 'зачет', 'диф.зачет' )
    count $c
    let $дата := 
      replace(
          xs:string( $i/дата/text() ),
         '(\d{4})-(\d{2})-(\d{2})',
         '$3.$2.$1'
       )
    return
      <row>
       <cell>{ $c }</cell>
        <cell>{ $i/название/text() }</cell>
        <cell>{ $i/ЗЕТ/text() }</cell>
        {
          if( $i/формаОтчетности/text() = 'экзамен' )
          then(
            <cell>{ $i/оценкаПрописью/text() }</cell>,
            <cell>-</cell>
          )
          else(
            <cell>-</cell>,
            <cell>{ $i/оценкаПрописью/text() }</cell>
          )
        }
        <cell>{ $дата }</cell>
      </row>
};
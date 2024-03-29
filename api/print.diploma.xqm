module namespace diploma = "/saivpds/api/v01/print.diploma";

import module namespace funct = "funct" at '../functions/functions.xqm';
import module namespace dateTime = 'dateTime' at 'http://iro37.ru/res/repo/dateTime.xqm';
import module namespace config = "app/config"  at '../functions/config.xqm';

declare 
  %rest:GET
  %rest:query-param( "id", "{ $id }" )
  %rest:query-param( "group", "{ $group }" )
  %rest:path( "/saivpds/api/v01/print.diploma/{ $page }" )
function diploma:main0( $page, $id, $group ){
  let $host := 'http://iro37.ru:9984/'
  let $fields := 
    switch ( $page )
    case '1'
      return
        [
          diploma:getDipolma.1( $id, $group, $host ),
          'f734020a-8355-4903-aaaa-f5ddb1a97042'
        ]
    case '2'
      return
        [
          diploma:getDipolma.2( $id, $group, $host ),
          (:fa2ea490-35df-4395-bfd7-0129affa1617 4d902444-d4d0-4b89-86d1-da9548d3e765:)
          '4d902444-d4d0-4b89-86d1-da9548d3e765'
        ]
    case '3'
      return
        [
          diploma:getDipolma.3( $id, $group ),
          '920f1a57-92c3-4fcc-a40c-270b2dae1928'
        ]
    default
      return ()
  
  let $templatePath := 
    'http://dbx.iro37.ru/zapolnititul/api/v2/forms/' || $fields?2 || '/template'
    
  let $fileName := 'diplom-' || $page || '.docx'  
  return
     diploma:fillTemplate( $fields?1, $templatePath, $fileName, $host )
};

declare function diploma:getDipolma.3( $id, $group ){
  let $data :=
    funct:getFile( 'students.xlsx', '.'
    )/file/table[ @label = $group ]/row[cell[@label="номер личного дела"] = $id ]
  
return
    <table>
      <row  id = 'fields'>
        <cell id = 'Фамилия студента'>{ $data/cell[@label = 'Фамилия']/text() }</cell>
        <cell id = 'Имя студента'>{ $data/cell[@label = 'Имя']/text() }</cell>
        <cell id = 'Отчество студента'>{ $data/cell[@label = 'Отчество']/text() }</cell>
        <cell id = 'регистрационный номер диплома'>{ $data/cell[ @label = 'Номер диплома' ]/text() }</cell>
        <cell id = 'номер'>
          { $data/cell[ @label = 'Номер протокола' ]/text() }
        </cell>
        <cell id = 'число'>
          { tokenize( $data/cell[ @label = 'Дата протокола' ]/text(), '-' )[ 3 ] }
        </cell>
        <cell id = 'месяц'>
          { tokenize( $data/cell[ @label = 'Дата протокола' ]/text(), '-' )[ 2 ] }
        </cell>
        <cell id = 'год'>
          { substring( tokenize( $data/cell[ @label = 'Дата протокола' ]/text(), '-' )[ 1 ], 3, 2) }
        </cell>
        <cell id = 'Дата выдачи диплома'>{
          replace(
             $data/cell[ @label = 'Дата диплома' ]/text(),
             '(\d{4})-(\d{2})-(\d{2})',
             '$3.$2.$1'
           )
        }</cell>
      </row>
    </table>
};

declare function diploma:getDipolma.2( $id, $group, $host ){
  let $формыОтчетности := ( 'экзамен', 'диф.зачет', 'зачет' )
  let $data := 
    funct:getFileWithParams( 
        'Аттестация/ДО_набор.xlsx',
        'http://iro37.ru:9984/static/saivpds/funct/ocenki.student.xq',
        map{
          'id' : $id,
          'group' : $group
        }
      )
     
  let $notes := $data/json/оценки/дисциплина

let $оценкиПоПредметам := 
      <table>
        {
          for $i in $notes
          where $i[ формаОтчетности/text() = ( 'экзамен', 'диф.зачет', 'зачет' ) ]
          order by $i/семестр/text()
          let $название := $i/название/text()
          group by $название
          return
            <row>
              <cell>{ $название }</cell>
              <cell>{ $i[ last() ]/ЗЕТ/text() } з.е.</cell>
              <cell>{ $i[ last() ]/оценкаПрописью/text() }</cell>
            </row>
        }
      </table>

  let $ВКР :=
    $notes[ формаОтчетности/text() = "выпускная квалификационная работа"]
  return
    <table>
      <row  id = 'fields'>
        <cell id = "названиеВКР" contentType = 'field'>{ $ВКР/название/text()}</cell>
        <cell id = "оцВКР" contentType = 'field'>{ $ВКР/оценкаПрописью/text() }</cell>
      </row>
      <row id = 'tables'>
        <cell id = 'Оценки1'>
          <table>
            { $оценкиПоПредметам/row[position()<=42] }
          </table>
        </cell>
        <cell id = 'Оценки2'>
          <table>
            { $оценкиПоПредметам/row[position()>42] }
            <row><cell/><cell/><cell/></row>
            <row><cell/><cell/><cell/></row>
           </table>
        </cell>
        <cell id = 'Оценки3'>
          <table>
            <row>
              <cell>Итоговая аттестация:</cell>
              <cell>6 з.е.</cell>
              <cell>X</cell>
            </row>
            <row>
              <cell>в том числе:</cell>
              <cell></cell>
              <cell></cell>
            </row>
            <row>
              <cell>Итоговый комплексный экзамен по направлению подготовки</cell>
              <cell></cell>
              <cell></cell>
            </row>
            <row>
              <cell>выпускная квалификационная работа (дипломная работа)</cell>
              <cell></cell>
              <cell>хорошо</cell>
            </row>
            <row>
              <cell>«{ $ВКР/название/text()}»</cell>
              <cell></cell>
              <cell></cell>
            </row>
            <row><cell/><cell/><cell/></row>
            <row><cell/><cell/><cell/></row>
            <row>
              <cell>Объем образовательной программы</cell>
              <cell>240 з.е.</cell>
              <cell>Х</cell>
            </row>
            <row>
              <cell>в том числе объем работы обучающихся во взаимодействии с</cell>
              <cell></cell>
              <cell></cell>
            </row>
            <row>
              <cell>преподавателем:</cell>
              <cell>5444 час.</cell>
              <cell>Х</cell>
            </row>
          </table>
        </cell>
      </row>
    </table>
};

declare function diploma:getDipolma.1( $id, $group, $host ){
  let $data :=
    funct:getFile( 'students.xlsx', '.'
    )/file/table[ @label = $group ]/row[cell[@label="номер личного дела"] = $id ]
  
  let $курсовые := 
    funct:getFileWithParams( 
        'Аттестация/ДО_набор.xlsx',
        'http://iro37.ru:9984/static/saivpds/funct/ocenki.student.xq',
        map{
          'id' : $id,
          'group' : $group
        }
      )
      /json/оценки/дисциплина[ формаОтчетности/text() = "курсовая работа" ]

return
    <table>
      <row  id = 'fields'>
        <cell id = 'ФамилияСтудента' contentType = 'field'>{ $data/cell[@label = 'Фамилия']/text() }</cell>
        <cell id = 'ИмяСтудента' contentType = 'field'>{ $data/cell[@label = 'Имя']/text() }</cell>
        <cell id = 'ОтчествоСтудента' contentType = 'field'>{ $data/cell[@label = 'Отчество']/text() }</cell>
        <cell id = 'сан' contentType = 'field'>{ $data/cell[@label = 'Сан']/text() }</cell>
        <cell id = 'имяХиротонии' contentType = 'field'>{ $data/cell[@label = 'Имя в монашестве']/text() }</cell>
        <cell id = 'ДатаРождения' contentType = 'field'>{
          replace(
              xs:string(
                dateTime:dateParse(
                  $data/cell[ @label = 'дата рождения' ]/text()
                )
              ),
             '(\d{4})-(\d{2})-(\d{2})',
             '$3.$2.$1'
           )
         
        }</cell>
        <cell id = 'РегистрационныйНомерДиплом' contentType = 'field'>{ $data/cell[@label = 'Номер диплома']/text() }</cell>
        <cell id = 'ДатаВыдачиДиплом' contentType = 'field'>{
          replace(
             $data/cell[ @label = 'Дата диплома' ]/text(),
             '(\d{4})-(\d{2})-(\d{2})',
             '$3.$2.$1'
           )
        }</cell>
        <cell id = 'предыдущий документ об образовании' contentType = 'field'>{ $data/cell[@label = 'Предыдущий документ об образовании' ]/text() }</cell>
      </row>
      <row id="tables">
        <cell id="курсовые">
          <table>
            {
              for $i in $курсовые
              return
                <row>
                  <cell>{ $i/название/text() }</cell>
                  <cell>{ $i/оценкаПрописью/text() }</cell>
                </row>
            }            
          </table>
        </cell>
      </row>
    </table>
};

declare function diploma:fillTemplate( $fields, $templatePath, $fileName, $host ){
  let $template :=
    fetch:binary(
      $templatePath
    )
  let $request :=
      <http:request method='post'>
        <http:multipart media-type = "multipart/form-data" >
            <http:header name="Content-Disposition" value= 'form-data; name="template";'/>
            <http:body media-type = "application/octet-stream" >
              { $template }
            </http:body>
            <http:header name="Content-Disposition" value= 'form-data; name="data";'/>
            <http:body media-type = "application/xml">
              { $fields }
            </http:body>
        </http:multipart> 
      </http:request>
    
  let $ContentDispositionValue := 
      "attachment; filename=" || iri-to-uri( $fileName  )
  let $response := 
     http:send-request (
        $request,
        'http://iro37.ru:9984/api/v1/ooxml/docx/template/complete'
      )
  return
     (
        <rest:response>
          <http:response status="200">
            <http:header name="Content-Disposition" value="{ $ContentDispositionValue }" />
            <http:header name="Content-type" value="application/octet-stream"/>
          </http:response>
        </rest:response>,
        $response[2]
      )
};
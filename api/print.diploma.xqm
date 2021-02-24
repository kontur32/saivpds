module namespace diploma = "/saivpds/api/v01/print.diploma";

import module namespace config = "app/config" at '../functions/config.xqm';
import module namespace funct = "funct" at '../functions/functions.xqm';

declare 
  %rest:GET
  %rest:query-param( "id", "{ $id }" )
  %rest:path( "/saivpds/api/v01/print.diploma" )
function diploma:main( $id ){
  diploma:getDipolma( $id )
};

declare function diploma:getDipolma( $id ){
  let $оценки := ( 'удовл.', 'хорошо', 'отлично' )
  
  let $data :=
    funct:getFile( 'students.xlsx', '.'
    )/file/table[ @label = 'ОЗО 2016' ]/row[cell[@label="номер личного дела"] = $id ]
  
  let $оценкиСтудента :=
    funct:getFile( 'Аттестация/ДО_набор.xlsx', '.'
    )/file/table[ @label = 'ОЗО 2016' ]/row
  
  let $номер := count( $оценкиСтудента[ 1 ]/cell[ text() = $id ]/preceding-sibling::* ) + 1
  
  let $курсовые := 
    $оценкиСтудента[ cell[ @label = "Форма отчетности" ] = "курсовая работа" ]
  
  let $fields := 
    <table>
      <row  id = 'fields'>
        <cell id = 'ФамилияСтудента' contentType = 'field'>{ $data/cell[@label = 'Фамилия']/text() }</cell>
        <cell id = 'ИмяСтудента' contentType = 'field'>{ $data/cell[@label = 'Имя']/text() }</cell>
        <cell id = 'ОтчествоСтудента' contentType = 'field'>{ $data/cell[@label = 'Отчество']/text() }</cell>
        <cell id = 'сан' contentType = 'field'>{ $data/cell[@label = 'Сан']/text() }</cell>
        <cell id = 'ДатаРождения' contentType = 'field'>{
          replace(
             $data/cell[ @label = 'дата рождения' ]/text(),
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
        <cell id = 'Предыдущий документ об образовании' contentType = 'field'>{ $data/cell[@label = 'Предыдущий документ об образовании' ]/text() }</cell>
      </row>
      <row id="tables">
        <cell id="курсовые">
          <table>
            {
              for $i in $курсовые
              return
                <row>
                  <cell>{ $i/cell[ 1 ]/text() }</cell>
                  <cell>{ $оценки[ $i/cell[ $номер ]/number() - 2 ] }</cell>
                </row>
            }            
          </table>
        </cell>
      </row>
    </table>
  
  let $template :=
    fetch:binary(
      'http://dbx.iro37.ru/zapolnititul/api/v2/forms/f734020a-8355-4903-aaaa-f5ddb1a97042/template'
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
    
  let $fileName := 'diplom.docx'
  
  let $ContentDispositionValue := 
      "attachment; filename=" || iri-to-uri( $fileName  )
  let $response := 
     http:send-request (
        $request,
        'http://localhost:9984/api/v1/ooxml/docx/template/complete'
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
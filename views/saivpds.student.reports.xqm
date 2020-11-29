module namespace saivpds = "saivpds/student/отчеты";

import module namespace funct="funct" at "../functions/functions.xqm";

declare 
  %rest:GET
  %rest:path( "/saivpds/s/reports/{ $отчет }" )
  %output:method( "xhtml" )
  %output:doctype-public( "www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" )
function saivpds:main( $отчет as xs:string ){
    
    let $содержание :=
      map{ 'раздел' : 'content/reports', 'страница' : $отчет }
    
    let $params :=    
       map{
        'header' : funct:tpl( 'header', map{ 'area' : 'student' } ),
        'content' : funct:tpl( 'content', $содержание ),
        'footer' : funct:tpl( 'footer', map{} )
       }
    return
      funct:tpl( 'main', $params )
};
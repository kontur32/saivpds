module namespace saivpds = "saivpds/teacher";

import module namespace funct="funct" at "../functions/functions.xqm";

declare 
  %rest:GET
  %rest:path( "/saivpds/s" )
  %output:method( "xhtml" )
  %output:doctype-public( "www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" )
function saivpds:main(){
  let $params :=    
     map{
      'header' : funct:tpl( 'header', map{ 'area' : 'student' } ),
      'content' : funct:tpl( 'content/student', map{} ),
      'footer' : funct:tpl( 'footer', map{} )
    }
  return
    funct:tpl( 'main', $params )
};
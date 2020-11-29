module namespace inkwi = "inkwi";

import module namespace funct="funct" at "../functions/functions.xqm";

declare 
  %rest:GET
  %rest:path( "/saivpds" )
  %output:method( "html" )
  %output:doctype-public( "www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" )
function inkwi:main(){
       let $params :=    
       map{
        'header' : funct:tpl( 'header0', map{} ),
        'content' : funct:tpl( 'login', map{ 'параметр2' : 'ДРУГОЕ ЗНАЧЕНИЕ' } ),
        'footer' : funct:tpl( 'footer', map{} )
      }
    return
      funct:tpl( 'main', $params )
};
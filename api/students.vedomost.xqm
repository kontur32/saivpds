module namespace vedomost = "/saivpds/api/v01/students/notes";

import module namespace funct = "funct" at '../functions/functions.xqm';

declare 
  %rest:GET
  %rest:query-param( "id", "{ $id }" )
  %rest:query-param( "group", "{ $group }" )
  %output:method( 'text' )
  %rest:path( "/saivpds/api/v01/students/vedomost" )
function vedomost:main( $id, $group ){
  let $result := 
    funct:getFileWithParams( 
      'Аттестация/ДО_набор.xlsx',
      'http://localhost:9984/static/saivpds/funct/vedomost.semestr.xq',
      map{ }
    )
  return
    $result
};
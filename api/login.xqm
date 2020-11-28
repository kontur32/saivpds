module namespace login = "login";

declare 
  %rest:GET
  %rest:query-param( "login", "{ $login }" )
  %rest:query-param( "password", "{ $password }" )
  %rest:path( "/saivpds/api/v01/login" )
function login:main( $login as xs:string, $password as xs:string ){
  if( $login = "saivpds" )
  then(
    session:set( "login", "unoi" ),
    web:redirect( "/saivpds/u" )
  )
  else( web:redirect( "/saivpds" ) )
};
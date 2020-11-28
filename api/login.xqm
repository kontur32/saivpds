module namespace login = "login";

declare 
  %rest:GET
  %rest:query-param( "login", "{ $login }" )
  %rest:query-param( "password", "{ $password }" )
  %rest:path( "/saivpds/api/v01/login" )
function login:main( $login as xs:string, $password as xs:string ){
  let $роль := 
    fetch:xml(
      web:create-url(
        'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/46777b16-9b46-4658-a0ca-5a49279dfdf7',
        map{
          'login' : $login,
          'password' : $password
        }
      )
    )/user/должность/text()
  return
    if( $роль != "" )
    then(
      session:set( "login", $login ),
      session:set( "роль", $роль ),
      web:redirect( "/saivpds/t" )
    )
    else( web:redirect( "/saivpds" ) )
};
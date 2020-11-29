module namespace login = "login";

declare 
  %rest:GET
  %rest:query-param( "login", "{ $login }" )
  %rest:query-param( "password", "{ $password }" )
  %rest:path( "/saivpds/api/v01/login" )
function login:main( $login as xs:string, $password as xs:string ){
  let $преподаватель := 
    fetch:xml(
      web:create-url(
        'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/46777b16-9b46-4658-a0ca-5a49279dfdf7',
        map{
          'login' : $login,
          'password' : $password
        }
      )
    )/user/должность/text()
  
  let $студент := 
    fetch:xml(
      web:create-url(
        'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/e2e1eb88-f1c5-4f78-8a15-e845d7710690',
        map{
          'login' : $login,
          'password' : $password
        }
      )
    )/user
  
  let $роль := 
    if( $преподаватель != "" )
    then( map{ 'label' : $преподаватель, 'grants' : 'teacher', 'redirect' : '/saivpds/t' } )
    else(
      if( $студент/ФИО/text() != "" )
      then(  map{ 'label' : $студент/ФИО/text(), 'grants' : 'student', 'redirect' : '/saivpds/s', 'номерЛичногоДела' : $студент/номерЛичногоДела/text() } )
      else( map{} )
    )
  return
    if( $роль?grants != "" )
    then(
      session:set( "login", $login ),
      session:set( "grants", $роль?grants ),
      session:set( "роль", $роль?label ),
      session:set( "номерЛичногоДела", $роль?номерЛичногоДела ),
      web:redirect(  $роль?redirect )
    )
    else( web:redirect( "/saivpds" ) )
};
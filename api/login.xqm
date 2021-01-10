module namespace login = "login";

import module namespace config = "app/config" at '../functions/config.xqm';

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
    )/user
  
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
    then(
      map{
        'label' : $преподаватель/ФИО/text(),
        'grants' : 'teacher', 
        'redirect' : '/saivpds/t',
        'должность' : $преподаватель/Должность/text(),
        'номерЛичногоДела' : $преподаватель/номерЛичногоДела/text()
      }
    )
    else(
      if( $студент/ФИО/text() != "" )
      then(
        map{
          'label' : $студент/ФИО/text(),
          'grants' : 'student', 
          'redirect' : '/saivpds/s',
          'номерЛичногоДела' : $студент/номерЛичногоДела/text()
        }
      )
      else( map{} )
    )
  return
    if( $роль?grants != "" )
    then(
      session:set( "login", $login ),
      session:set( "grants", $роль?grants ),
      session:set( "роль", $роль?label ),
      session:set( "номерЛичногоДела", $роль?номерЛичногоДела ),
      session:set(
        'access_token', login:getToken( $config:param( 'authHost' ), $config:param( 'login' ), $config:param( 'password' ) )
      ),
      web:redirect(  $роль?redirect )
    )
    else( web:redirect( "/saivpds" ) )
};



declare
  %private
function login:getToken( $host, $username, $password ) as xs:string*
{
  let $request := 
    <http:request method='post'>
        <http:multipart media-type = "multipart/form-data" >
            <http:header name="Content-Disposition" value= 'form-data; name="username";'/>
            <http:body media-type = "text/plain" >{ $username }</http:body>
            <http:header name="Content-Disposition" value= 'form-data; name="password";' />
            <http:body media-type = "text/plain">{ $password }</http:body>
        </http:multipart> 
      </http:request>
  
  let $response := 
      http:send-request(
        $request,
        $host || "/wp-json/jwt-auth/v1/token"
    )
    return
      if ( $response[ 1 ]/@status/data() = "200" )
      then(
        $response[ 2 ]//token/text()
      )
      else( )
};
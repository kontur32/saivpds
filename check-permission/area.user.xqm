module namespace check = "check";


declare 
  %perm:check( "/saivpds/u" )
function check:userArea(){
  let $user := session:get( "login" )
  where empty( $user )
  return
    web:redirect("/saivpds")
};
module namespace logout = "logout";

declare 
  %rest:GET
  %rest:path( "/saivpds/api/v01/logout" )
function logout:main(){
  session:close(),
  web:redirect( "/saivpds" )
};

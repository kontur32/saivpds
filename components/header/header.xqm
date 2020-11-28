module namespace header = "header";

declare function header:main( $params as map(*) ){
  map{
    'mainMenu' : $params?_tpl( 'header/mainMenu', $params ),
    'avatar' : $params?_tpl( 'header/avatar', map{} )
  }  
};
module namespace content = 'content/student';

declare function content:main( $params ){
  
  let $личнаяКарточка := 
    $params?_tpl( 'content/reports/uchenik.profil', map{} )
  
  let $result := 
    <div>
      <div class = 'h4'>Это главная страница студента </div>
      <div>{ $личнаяКарточка }</div>
    </div>
  
  return
    map{
      'содержание' : $result
    }
};
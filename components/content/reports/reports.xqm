module namespace reports = 'content/reports';

declare function reports:main( $params ){
  let $адресЗапросаСтраницы := 
    switch ( $params?страница )
    case "teachers.konduit"
      return
        let $url := 
          web:create-url(
            'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/3a61d3a6-1984-4891-afd3-4c1f9750633a',
            map{
              'page' : 'teachers.konduit',
              'mode' : 'iframe'
            }
          )
        return
          reports:getData( $url )
    case "uchenik.jour.ail-new"
      return
        let $url := 
         web:create-url(
            'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/a2aa28dc-7a83-4a6e-aff6-679f1c9a9ab7',
            map{
              'page' : 'uchenik.jour.ail-new',
              'номерЛичногоДела' :  session:get( "номерЛичногоДела" ),
              'mode' : 'iframe'
            }
          )
        return
          reports:getData( $url )
    
    case "uchenik.profil"
      return
        $params?_tpl( 'content/reports/uchenik.profil', map{} )
    
    case "journal"
      return
        let $url := 
          web:create-url(
            'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/065edfb3-7f4c-4f67-8ff3-640070b36290',
            map{
              'date' : '2020-11-23',
              'mode' : 'iframe'
            }
          )
        return
          reports:getData( $url )
    default
      return
        $params?_tpl( 'content/reports/uchenik.profil', map{} )
  
  return
    map{
      'отчет' : $адресЗапросаСтраницы
    }
};

declare function reports:getData( $адресЗапросаСтраницы ){
  <iframe width = '100%' height = "600px" src = '{ $адресЗапросаСтраницы }' ></iframe>
};
module namespace reports = 'content/reports';

declare function reports:main( $params ){
  let $адресЗапросаСтраницы := 
    switch ( $params?страница )
    case "teachers.konduit"
      return
        web:create-url(
          'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/3a61d3a6-1984-4891-afd3-4c1f9750633a',
          map{
            'page' : 'teachers.konduit',
            'mode' : 'iframe'
          }
        )
    case "uchenik.jour.ail"
      return
       web:create-url(
          'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/a2aa28dc-7a83-4a6e-aff6-679f1c9a9ab7',
          map{
            'page' : 'uchenik.jour.ail',
            'номерЛичногоДела' :  session:get( "номерЛичногоДела" ),
            'mode' : 'iframe'
          }
        )
    default 
      return
        'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/031fefd3-e1b6-4ce6-885b-601429101680'
  
  return
    map{
      'отчет' : <iframe width = '100%' height = "600px" src = '{ $адресЗапросаСтраницы }' ></iframe>
    }
};
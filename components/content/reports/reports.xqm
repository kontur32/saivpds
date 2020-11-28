module namespace reports = 'content/reports';

declare function reports:main( $params ){
  let $адресЗапросаСтраницы := 
    switch ( $params?страница )
    case "сводная"
      return
        'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/3a61d3a6-1984-4891-afd3-4c1f9750633a?page=teachers.konduit'
    case "календарный-план"
      return
       'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/031fefd3-e1b6-4ce6-885b-601429101680'
    default 
      return
        'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/031fefd3-e1b6-4ce6-885b-601429101680'
  
 (:let $страница :=
    fetch:xml( $адресЗапросаСтраницы ):) 
  
  return
    map{
      'отчет' : <iframe width = '100%' height = "600px" src = '{ $адресЗапросаСтраницы }' ></iframe>
    }
};
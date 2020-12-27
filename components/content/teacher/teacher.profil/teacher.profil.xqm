module namespace teacher.profil = 'content/teacher/teacher.profil';

declare function teacher.profil:main( $params ){
  let $данные :=
      fetch:xml(
        web:create-url(
          'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/07dffd43-b033-4e12-9867-976b220a6b78',
          map{
            'номерЛичногоДела' : session:get( 'номерЛичногоДела' )
          }
        )
    )/table/row
  return
    map{ 
      'фото' :  $данные/cell[ @label = "Фотография" ]/text(),
      'фамилия' : $данные/cell[ @label = "Фамилия" ]/text(),
      'отчество' : $данные/cell[ @label = "Отчество" ]/text()
    }
};
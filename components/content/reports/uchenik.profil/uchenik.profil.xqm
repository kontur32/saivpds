module namespace uchenik.profil = 'content/reports/uchenik.profil';

declare function uchenik.profil:main( $params ){
  let $данные :=
      fetch:xml(
        web:create-url(
          'http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/0f93d1c5-613e-4c11-8542-0b96047ba427',
          map{
            'номерЛичногоДела' : session:get( 'номерЛичногоДела' )
          }
        )
    )
  return
    map{ 'отчет' : $данные/table/row/cell[ @label = "Фамилия" ]/text() }
};
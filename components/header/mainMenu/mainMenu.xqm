module namespace mainMenu = "header/mainMenu";

declare function mainMenu:main( $params as map(*) ){
  let $пункты :=
    switch ( $params?area )
    case 'teacher'
      return
        let $items := 
          (
            [ 'Журнал пропусков', 'teachers.konduit' ],
            [ 'Форма 2', '#' ]
          )
        return
           [ $items, 't', 'Форма для преподавателя' ]
    case 'student'
      return
        let $items := 
          (
            [ 'Пропущенные темы', 'uchenik.jour.ail-new' ],
            [ 'Форма 2', '#' ]
          )
        return
          [ $items, 's', 'Форма для студента' ]
    default
      return
        <ul></ul>

  let $меню :=
    map{
      'главная' : '/saivpds/' || $пункты?2,
      'названиеРаздела' : $пункты?3,
      'пункты' : mainMenu:items( $пункты?1, $пункты?2, $пункты?3 )
    }
  return
     $меню
};

declare function mainMenu:items( $items, $area, $mainLabel ){
  for $i in $items
  let $href := '/saivpds/' || $area || '/reports/' || $i?2
  return
   <a class="dropdown-item" href="{ $href }">{ $i?1 }</a>       
};
module namespace mainMenu = "header/mainMenu";


declare function mainMenu:main( $params as map(*) ){
  
  let $меню :=
    switch ( $params?area )
    case 'teacher'
      return
        mainMenu:teacher()
    case 'student'
      return
        mainMenu:student()
    default
      return
        <ul></ul>
  return
    map{
      'меню' : $меню
    }
};


declare function mainMenu:student(){
  <ul class="navbar-nav mr-auto" >
      <li class="nav-item dropdown" >
          <a class="nav-link" href="/saivpds/s/" >
              Главная
          </a>
      </li>
      <li class="nav-item dropdown" >
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Формы для студента
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
             <a class="dropdown-item" href="/saivpds/s/reports/uchenik.jour.ail">Пропущенные темы</a>
             <a class="dropdown-item" href="#">Форма 2</a>
          </div>
      </li>
   </ul>
};

declare function mainMenu:teacher(){
 <ul class="navbar-nav mr-auto" >
      <li class="nav-item dropdown" >
          <a class="nav-link" href="/saivpds/t/" >
              Главная
          </a>
      </li>
      <li class="nav-item dropdown" >
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Формы для преподавателя
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
             <a class="dropdown-item" href="/saivpds/t/reports/teachers.konduit">Журнал пропусков</a>
             <a class="dropdown-item" href="#">Форма 2</a>
          </div>
      </li>
   </ul>
};
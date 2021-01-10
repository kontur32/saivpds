module namespace inkwi = "inkwi";

import module namespace funct="funct" at "../functions/functions.xqm";

declare 
  %rest:GET
  %rest:path( "/saivpds" )
  %output:method( "html" )
  %output:doctype-public( "www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" )
function inkwi:main(){
  let $params :=    
     map{
        'header' : funct:tpl( 'header', map{} ),
        'content' : 
		(
		<div class="container-fluid">
		 
		 <div class="row" border="1">

			<div class="col-6">
			
			<p>
			<center>
  
  <a class="btn btn-primary" data-toggle="collapse" href="#multiCollapseExample1" role="button" aria-expanded="false" aria-controls="multiCollapseExample1">Очное отделение</a>
  
  <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#multiCollapseExample2" aria-expanded="false" aria-controls="multiCollapseExample2">Заочное отделение</button>
  
  <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#multiCollapseExample3" aria-expanded="false" aria-controls="multiCollapseExample2">Повышение квалификации</button>
  
			</center>
			</p>

<div class="row">
  <div class="col">
    <div class="collapse multi-collapse" id="multiCollapseExample1">

      <div class="btn-group-vertical">
			
			<button type="button" class="btn btn-secondary, btn btn-light">
			<a href="">Расписание семестра</a>
			</button>
			<button type="button" class="btn btn-secondary, btn btn-light">
			<a href="http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/53d6ebcb-fa4c-450a-b99f-b8b62cc0bc5d?page=1">Расписание сессии</a>
			</button>
			<button type="button" class="btn btn-secondary, btn btn-light">
			<a href="">Календарный план-график</a>
			</button>

	   </div>

    </div>
  </div>
 
 <div class="col">
    <div class="collapse multi-collapse" id="multiCollapseExample2">
      <div class="btn-group-vertical">
			
			<button type="button" class="btn btn-secondary, btn btn-light">
			<a href="http://iro37.ru:9984/zapolnititul/api/v2.1/data/publication/7d4075e0-9f61-46f2-ae8e-598d65624f17">Расписание сессии</a>
			</button>

	   </div>
    </div>
  </div>
  
   <div class="col">
    <div class="collapse multi-collapse" id="multiCollapseExample3">
      
	  <div class="btn-group-vertical">
			
			<button type="button" class="btn btn-secondary, btn btn-light">
			<a href="">Расписание КПК</a>
			</button>

	   </div>
	  
    </div>
  </div>

</div>
			
			</div>
	
			<div class="col-6">
			{ funct:tpl( 'login', map{} ) }
			</div>

		</div>
			
			
			
		
		</div>
		),
        'footer' : funct:tpl( 'footer', map{} )
      }
  return
    funct:tpl( 'main', $params )
};
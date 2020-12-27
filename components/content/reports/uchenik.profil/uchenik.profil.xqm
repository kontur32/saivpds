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
    map{ 
	
	'отчет' : 
	(
<HTML>
<HEAD>
	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="text/html; charset=utf-8">
	<META NAME="HyperlinksChanged" CONTENT="false"/>
	<META NAME="LinksUpToDate" CONTENT="false"/>
	<META NAME="ScaleCrop" CONTENT="false"/>
	<META NAME="ShareDoc" CONTENT="false"/>
	<STYLE TYPE="text/css"/>  
  
<TABLE WIDTH='100%' CELLPADDING='auto' CELLSPACING='0' STYLE="page-break-before: always" cursor="pointer">
	<COL WIDTH='199'/>
	<COL WIDTH='199'/>
	<COL WIDTH='199'/>
	<TR VALIGN='TOP'>
		<TD ROWSPAN='23' WIDTH='199' HEIGHT='23' STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><A NAME="_GoBack"></A><BR><img src= "{$данные/table/row/cell[ @label = "Фотография" ]/text()}" width="50%" height="auto" display="block"/></BR>
			</P> 
  <div>
  <form action="{$данные/table/row/cell[ @label = "Портфолио" ]/text()}" method="GET">  <p style="text-align: center" title='Здесь можно сохранять сканы своих достижений: грамоты, сертификаты, справки-подтверждения'> <button type="submit" class="btn btn-info"  width="50%" height="auto" display="block">Портфолио</button>  </p>
  </form>          
  <form action="{$данные/table/row/cell[ @label = "Важные документы" ]/text()}" method="GET">  <p style="text-align: center" title='Здесь можно сохранять сканы своих документов, чтобы они были под рукой в любой момент'> <button type="submit" class="btn btn-info"  width="50%" height="auto" display="block">Важные документы</button>  </p>
  </form>
  </div>
		</TD>
		<TD COLSPAN='2' WIDTH='411' BGCOLOR="#f2dbdb" STYLE="border: none; padding: 0in" class="header">
			<P ALIGN='CENTER' title='Раздел заполняется специалистами Учебной части'><SPAN STYLE="text-transform: uppercase"><FONT COLOR="#1f497d"><FONT SIZE='default'><I><B>Персональные данные</B></I></FONT></FONT></SPAN></P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' BGCOLOR="#dbe5f1" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Фамилия</I></FONT></P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#dbe5f1" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Фамилия" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Имя</I></FONT></P>
		</TD>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Имя" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' BGCOLOR="#dbe5f1" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Отчество</I></FONT></P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#dbe5f1" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Отчество" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Имя в хиротонии</I></FONT></P>
		</TD>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Имя в хиротонии" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' BGCOLOR="#dbe5f1" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Сан</I></FONT></P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#dbe5f1" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Сан" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Дата рождения</I></FONT></P>
		</TD>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Дата рождения" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' BGCOLOR="#dbe5f1" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Именины</I></FONT></P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#dbe5f1" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Именины" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD COLSPAN='2' WIDTH='411' BGCOLOR="#f2dbdb" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER' STYLE="margin-'TOP': 0.08in"><SPAN STYLE="text-transform: uppercase"><FONT COLOR="#1f497d"><FONT SIZE='3'><I><B>СТУДЕНЧЕСКИЙ
			ПРОФИЛЬ</B></I></FONT></FONT></SPAN></P>
		</TD>
	</TR>
	<TR VALIGN='TOP' class="header">
		<TD WIDTH='199' BGCOLOR="#daeef3" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Номер зачетной книжки</I></FONT></P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#daeef3" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR></BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Номер личного дела</I></FONT></P>
		</TD>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "номер личного дела" ]/text()}</BR>
			</P>
		</TD>
			<TR VALIGN='TOP'>
      <TD WIDTH='199' BGCOLOR="#daeef3" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Логин и пароль в "Прометее"</I></FONT></P>
		</TD>
          <TD WIDTH='199' BGCOLOR="#daeef3" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><FONT SIZE='3'><BR>{ $данные/table/row/cell[ @label = "логин и пароль в Прометее" ]/text()}</BR></FONT></P>
		</TD>
    </TR>
  </TR>
    	<TR VALIGN='TOP'>
		<TD WIDTH='199' BGCOLOR="#ffffff" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Дата поступления</I></FONT></P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#ffffff" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><FONT SIZE='3'><BR>{ $данные/table/row/cell[ @label = "дата поступления в ОО" ]/text()}</BR>
      </FONT>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' BGCOLOR="#daeef3" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Форма обучения</I></FONT></P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#daeef3" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Форма обучения" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' BGCOLOR="#ffffff" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Дата окончания</I></FONT></P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#ffffff" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "дата выбытия из ОО" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD COLSPAN='2' WIDTH='411' BGCOLOR="#f2dbdb" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER' STYLE="margin-'TOP': 0.08in"><SPAN STYLE="text-transform: uppercase"><FONT COLOR="#1f497d"><FONT SIZE='3'><I><B>Контактная
			информация</B></I></FONT></FONT></SPAN></P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' BGCOLOR="#e5dfec" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Номер телефона (1) </I></FONT>
			</P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#e5dfec" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Контактный телефон" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Номер телефона (2)</I></FONT></P>
		</TD>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Контактный телефон2" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' BGCOLOR="#e5dfec" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Номер телефона (3)</I></FONT></P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#e5dfec" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Контактный телефон3" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><SPAN LANG="en-US"><I>e-mail</I></SPAN></FONT></P>
		</TD>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "e-mail" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' BGCOLOR="#e5dfec" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><SPAN LANG="en-US"><I>Skype</I></SPAN></FONT></P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#e5dfec" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Skype" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Место проживания</I></FONT></P>
		</TD>
		<TD WIDTH='199' STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Место проживания" ]/text()}</BR>
			</P>
		</TD>
	</TR>
	<TR VALIGN='TOP'>
		<TD WIDTH='199' BGCOLOR="#e5dfec" STYLE="border: none; padding: 0in">
			<P><FONT SIZE='3'><I>Адрес регистрации</I></FONT></P>
		</TD>
		<TD WIDTH='199' BGCOLOR="#e5dfec" STYLE="border: none; padding: 0in">
			<P ALIGN='CENTER'><BR>{ $данные/table/row/cell[ @label = "Адрес регистрации" ]/text()}</BR>
			</P>
		</TD>
	</TR>
</TABLE>
<P STYLE="margin-bottom: 0.14in"><BR></BR>

</P>
</META>
</HEAD>

</HTML>
	)
	}
};
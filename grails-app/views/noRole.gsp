<!DOCTYPE html>
<html>
	<head>
		<title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
		<meta name="layout" content="main">
		<g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
	</head>
	<body>
		<h1> ¡Error! Usuario ${sec.username()} no posee rol o no es ninguno de los admitidos. A continuación, cierre sesión e intente de nuevo iniciar sesión.
		Si el motivo persiste, contacte al email ..... indicando el motivo: Usuario no presenta rol. </h1>

	<form name="logout" method="POST" action="${createLink(controller:'logout') }">
		<input type="submit" value="logout">
	</form>

	</body>
</html>

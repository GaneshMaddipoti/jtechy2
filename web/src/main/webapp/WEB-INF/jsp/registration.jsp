<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<%@ page isELIgnored="false"%>
<html>
<head>
<link rel="icon" href="img/jtechy1.ico">
<title>Jtechy - Tutorials, Web/Application Development, Projects</title>
<link rel="stylesheet"
	href="css/materialize.min.css">
<link type="text/css" rel="stylesheet" href="css/custom.css"
	media="screen,projection" />
</head>
<body onload='document.registerForm.username.focus();'>
	<br />
	<br />
	<div class="container">
		<div class="row">
			<div class="col s12 m6 offset-m3">
				<form name='registerForm' action="<c:url value='/register' />"
					method='POST'>
					<div class="card">
						<div class="card-content">
							<span class="card-title black-text">Registration</span>
							<c:if test="${not empty error}">
								<div class="error">${error}</div>
							</c:if>
							<c:if test="${not empty msg}">
								<div class="msg">${msg}</div>
							</c:if>
							<div class="row">
								<div class="input-field col s12">
									<input id="userName" type="text" name="userName"
										class="validate"> <label for="userName" class="active">User
										Name</label>
								</div>
							</div>
							<div class="row">
								<div class="input-field col s12">
									<input id="password" type="password" name="password"
										class="validate"> <label for="lastname" class="active">Password</label>
								</div>
							</div>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</div>
						<div class="card-action">
							<input type="submit" class="btn" value="Register" />
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/materialize.min.js"></script>
</body>
</html>
<%@ page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="bgcolor">
	<div class="container nav-wrapper">
		<a href="#!" class="flow-text logo" id="jtechy"><strong>Jtechy</strong></a>
		<a href="#" data-activates="slide-out" class="button-collapse"><i
			class="material-icons" style="color: white">menu</i></a>
	</div>
	<ul id="slide-out" class="side-nav fixed" style="width: 250px">
		<li><div class="user-view">
				<div class="background bgcolor"></div>
				<i class="material-icons iconlarge" id="userPic">person_pin</i>
				<c:if test="${pageContext.request.userPrincipal.name != null}">
					<a href="#!" id="userID"><span class="logo name">${pageContext.request.userPrincipal.name}</span></a>
					<a href="logout">Logout</a>
				</c:if>
				<c:if test="${pageContext.request.userPrincipal.name == null}">
					<a href="login">Login</a>
				</c:if>
			</div></li>
		<li><a class="waves-effect logo" href="#!" id="dashboard"><i
				class="material-icons">dashboard</i>Dashboard</a></li>
		<li><a class="waves-effect logo" href="#!" id="projects"><i
				class="material-icons">device_hub</i>Projects</a></li>
		<li><a class="waves-effect logo" href="#!" id="tools"><i
				class="material-icons">power</i>Tools</a></li>
		<li><a class="waves-effect logo" href="#!" id="tutorials"><i
				class="material-icons">book</i>Tutorials</a></li>
		<li><a class="waves-effect logo" href="#!" id="java"><i
				class="material-icons">book</i>java</a></li>
		<li><div class="divider"></div></li>
		<li><a class="waves-effect logo" href="#!" id="blog"><i
				class="material-icons">rss_feed</i>blog</a></li>
		<li><a class="waves-effect logo" href="#!" id="profile"><i
				class="material-icons">account_box</i>Profile</a></li>
	</ul>
</nav>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".button-collapse").sideNav();
		$("#dashboard").click(function() {
			$('#modal1').modal('open');
			$("main").load("dashboard");
		})
		$("#projects").click(function() {
			$('#modal1').modal('open');
			$("main").load("project/listproject");
		})
		$("#tools").click(function() {
			$('#modal1').modal('open');
			$("main").load("tool/listtool");
		})
		$("#tutorials").click(function() {
			$('#modal1').modal('open');
			$("main").load("course/common/get/list/0");
		})
		$("#java").click(function() {
			$('#modal1').modal('open');
			$("main").load("concept/readconcept/java/0");
		})
		$("#blog").click(function() {
			$('#modal1').modal('open');
			$("main").load("blog/listblog");
		})
		$("#profile").click(function() {
			$('#modal1').modal('open');
			$("main").load("entity");
		})
		$("#userPic").click(function() {
			$('#modal1').modal('open');
			$("main").load("entity");
		})
		$("#userID").click(function() {
			$('#modal1').modal('open');
			$("main").load("entity");
		})
	});
</script>

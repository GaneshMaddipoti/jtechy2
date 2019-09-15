<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html>
<link type="text/css" rel="stylesheet" href="css/custom.css"
	media="screen,projection" />
<div class="container">
	<br />
	<c:if test="${resultMap.size() gt 0}">
		<c:forEach items="${resultMap}" var="entry">
			<ul class="collection with-header">
				<li class="collection-header"><b>${entry.key}</b></li>
				<li class="collection-item">
					<div class="row">
						<c:forEach items="${entry.value}" var="course">
							<div class="col s12 m6 l4">
								<a href="#" onclick="load('course/common/details/${course.id}')">
									<div class="valign-wrapper">
										<i class="material-icons">chevron_right</i>${course.name}
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
				</li>
			</ul>
		</c:forEach>
	</c:if>
	<c:if test="${resultMap.size() eq 0}">
		<div class="card-panel">No Courses Found.</div>
	</c:if>

	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<input type="button" class="btn" value="Add Course"
			onclick="load('course/common/get/add/0')" />
	</sec:authorize>

</div>
<script>
	$(document).ready(function() {
		$('#modal1').modal('close');
	});
	function load(arg) {
		$('#modal1').modal('open');
		$("main").load(arg);
	}
</script>
</html>

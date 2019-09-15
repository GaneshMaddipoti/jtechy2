<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page isELIgnored="false"%>
<div class="container" id="softdev">
	<br />
	<div class="row">
		<br /> <a href="#!" id="toolsLink">Tools</a> -
		${tool.category} - ${tool.name}
	</div>

	<div class="row">
		<ul class="collapsible">
			<c:forEach var="field" items="${tool.fields}" varStatus="loop">
				<li>
					<div class="collapsible-header">
						<div class="valign-wrapper">
							<i class="material-icons">chevron_right</i> ${field.fieldName}
						</div>
					</div>
					<div class="collapsible-body">
						<span style="white-space: pre-wrap;">${field.fieldValue}</span>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>

	<div class="row">
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<div class="row">
				<div class="col s4">
					<input type="button" value="Edit Tool" class="btn"
						id="saveToolButton" onclick="gotoDetail('${tool.id}')" />
				</div>
			</div>
		</sec:authorize>

	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('#modal1').modal('close');
		$('.collapsible').collapsible();
		$("#toolsLink").click(function() {
			$('#modal1').modal('open');
			$("main").load("tool/listtool");
		})
	});
	$(function() {
		$('textarea').each(function() {
			$(this).height($(this).prop('scrollHeight'));
		});
	});
	function gotoDetail(arg) {
		$("main").load("tool/modifytool/" + arg);
	}
	function addToolField(arg) {
		$("main").load("tool/addtoolfield?id=" + arg);
	}
</script>
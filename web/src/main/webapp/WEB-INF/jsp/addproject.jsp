<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false"%>
<script>
	//callback handler for form submit
	$(document).ready(function() {
		$("#saveProjectButton").click(function(e) {
			var postData = $("#project").serializeArray();
			var formURL = $("#project").attr("action");
			$.ajax({
				url : formURL,
				type : "POST",
				data : postData,
				success : function(data, textStatus, jqXHR) {
					$("main").html(data);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					$("main").html(textStatus);
				}
			});
		});
	});
</script>
<div class="container" id="projectCreate">
	<div class="row">
		<div class="col s12">
			<div class="card">
				<div class="card-content">
					<form:form method="POST" action="project/saveproject"
						modelAttribute="project">

						<form:hidden path="id" />

						<div id="projectContent">
							<div class="row">
								<div class="col s4">Project Name :</div>
								<div class="col s8">
									<form:input path="name" />
								</div>
							</div>
							<div class="row">
								<div class="col s4">Project Description :</div>
								<div class="col s8">
									<form:input path="description" />
								</div>
							</div>
							<div class="row">
								<div class="col s4">Project Category :</div>
								<div class="col s8">
									<form:input path="category" />
								</div>
							</div>
							<input type="hidden" id="fieldCount"
								value="${fn:length(project.fields)}" />
							<c:forEach var="field" items="${project.fields}" varStatus="loop">
								<div id="row${loop.index}">
									<div class="row">
										<div class="col s12">
											<div class="row">
												<div class="col">
													<a href="#!" onclick="removeField(${loop.index})"><i
														class="material-icons">remove</i></a>
												</div>
												<div class="col">
													<input type="text" name="fields[${loop.index}].fieldName"
														value="${field.fieldName}" />
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col s12">
											<textarea class="materialize-textarea"
												name="fields[${loop.index}].fieldValue">${field.fieldValue}</textarea>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<a href="#!" id="projectContentAddButton"><i
							class="material-icons">add</i></a>
						<div class="row">
							<div class="col s12">
								<input type="button" value="Save Project" class="btn"
									id="saveProjectButton" />
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$('#modal1').modal('close');
		$("#softdev1").click(function() {
			$("#body").load("softdev");
		});
		var count = $("#fieldCount").val();
		$("#projectContentAddButton").click(function() {
			var template = '<div id="row'+count+'"><div class="row">'
			+ '<div class="col s12"><div class="col"><a href="#!" onclick="removeField('+count+')"><i class="material-icons">remove</i></a></div>'
			+'<div class="col"><div class="input-field"><input name="fields['+count+'].fieldName" placeholder="Field Name"/></div></div></div></div><div class="row">'
			+ '<div class="col s12"><div class="input-field"><textarea class="materialize-textarea" name="fields['+count+'].fieldValue"></textarea></div></div>'
			+ '</div>';
			$("#projectContent").append(template);
			count++;
		});
	});
	function removeField(arg){
		$("#row"+arg).remove();
	}
	$(function() {
	    $('textarea').each(function() {
	        $(this).height($(this).prop('scrollHeight'));
	    });
	});
</script>
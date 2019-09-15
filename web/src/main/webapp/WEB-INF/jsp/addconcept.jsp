<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false"%>
<script>
	//callback handler for form submit
	$(document).ready(function() {
		$("#saveConceptButton").click(function(e) {
			var postData = $("#concept").serializeArray();
			var formURL = $("#concept").attr("action");
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
					<form:form method="POST" action="concept/saveconcept"
						modelAttribute="concept">

						<form:hidden path="id" />

						<div id="projectContent">
							<div class="row">
								<div class="col s4">Concept Name :</div>
								<div class="col s8">
									<form:input path="name" />
								</div>
							</div>
							<div class="row">
								<div class="col s4">Concept Description :</div>
								<div class="col s8">
									<form:input path="description" />
								</div>
							</div>
							<div class="row">
								<div class="col s4">Concept Category :</div>
								<div class="col s8">
									<form:input path="category" />
								</div>
							</div>
							<div class="row">
								<div class="col s4">Concept Rank :</div>
								<div class="col s8">
									<form:input path="rank" />
								</div>
							</div>
							<input type="hidden" id="fieldCount"
								value="${fn:length(concept.fields)}" />
							<c:forEach var="field" items="${concept.fields}" varStatus="loop">
								<div id="row${loop.index}">
									<div class="row">
										<div class="col s12">
											<div class="row">
												<div class="col s1">
													<a href="#!" onclick="removeField(${loop.index})"><i
														class="material-icons">remove</i></a>
												</div>
												<div class="col s3">
													<input type="text" name="fields[${loop.index}].type"
														value="${field.type}" />
												</div>
												<div class="col s8">
													<input type="text" name="fields[${loop.index}].name"
														value="${field.name}" />
												</div>
											</div>
											<div class="row">
												<div class="col s12">
													<input type="text" name="fields[${loop.index}].desc" value="${field.desc}" />
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col s12">
											<textarea class="materialize-textarea"
												name="fields[${loop.index}].value">${field.value}</textarea>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<a href="#!" id="projectContentAddButton"><i
							class="material-icons">add</i></a>
						<div class="row">
							<div class="col s12">
								<input type="button" value="Save Concept" class="btn"
									id="saveConceptButton" />
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
			+ '<div class="col s1"><a href="#!" onclick="removeField('+count+')"><i class="material-icons">remove</i></a></div>'
			+'<div class="col s3"><div class="input-field"><input name="fields['+count+'].type" placeholder="Field Type"/></div></div>'
			+'<div class="col s8"><div class="input-field"><input name="fields['+count+'].name" placeholder="Field Name"/></div></div>'
			+'</div>'
			+'<div class="row"><div class="col s12"><input type="text" name="fields['+count+'].desc" value="${field.desc}" placeholder="Field Description"/></div></div>'
			+'<div class="row">'
			+ '<div class="col s12"><div class="input-field"><textarea class="materialize-textarea" name="fields['+count+'].value" placeholder="Field Value"></textarea></div></div>'
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
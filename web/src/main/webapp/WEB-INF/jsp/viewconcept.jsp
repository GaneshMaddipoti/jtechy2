<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page isELIgnored="false"%>
<%@ page import="web.data.model.Concept"%>
<%@ page import="web.data.model.Field"%>
<%@ page import="java.util.*"%>

<style>
.container{
	width: 95% !important;
}

.fc-title{
	text-transform: uppercase; 
	font-weight: bold;"
}

.fc-history{
	border-left: 10px solid #ddd; 
	border-right: 10px solid #ddd; 
	padding: 10px !important; 
	border-bottom:1px solid #ddd;
	border-top:1px solid #ddd;
 	background-color: #efebe9; 
}

.fc-start{
	border: 1px solid #ddd; 
	border-radius: 100px / 50px; 
	padding: 10px !important;
	background-color: #a5d6a7;
}

.fc-notes{
	border: 1px solid #ddd; 
	padding: 10px !important;
	background-color: #D6EAF8;
}

.fc-comment{
	border: 1px solid #ddd; 
	padding: 10px !important;
	background-color: #fff59d;
	background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAABZJREFUeNpi2r9//38gYGAEESAAEGAAasgJOgzOKCoAAAAASUVORK5CYII=);
}

.fc-init{
	border: 1px solid #ddd; 
	transform: skew(-20deg);
	padding: 10px !important;
	margin: 5px;
	background-color: #ffb74d;
}

.fc-feature{
	border: 1px solid #ddd;
	padding: 10px !important;
	margin: 5px;
	background-color: #c5cae9;
}

.fc-test{
	border: 1px solid #ddd; 
	height: 100px; 
	width: 100px; 
	transform: rotate(-45deg);
	margin: 5px;
}

.fc-process{
	border: 1px solid #ddd;
	padding: 10px !important;
	margin: 5px;
	background-color: #E8DAEF;
}

.fc-content{
	white-space: pre-wrap;
}

.fc-end{
	border: 1px solid #ddd; 
	border-radius: 100px / 50px; 
	padding: 10px !important;
	background-color: #ef9a9a;
}

#overlay { 
	background:rgba(0,0,0,0.3); 
	display:none; width:100%; 
	height:100%; 
	position:absolute; 
	top:0; 
	left:0; 
	z-index:99998; 
	pointer-events:none
}

</style>

<div id="overlay"></div>

<div class="container" id="softdev">

	<c:if test="${empty concept}">
		Concept not found! Please add the concept
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<input type="button" class="btn" value="Add Concept"
				onclick="load('concept/createconcept')" />
		</sec:authorize>
	</c:if>
	<c:if test="${not empty concept}">
	
		<div class="row center-align fc-title" >
				<br />${concept.description}
			</div>
		<br/>	
		
		<% 	Concept concept = (Concept) request.getAttribute("concept"); %>
		
		
		<% for(int i=0; i<concept.getFields().size(); i++) { 
			Field field = concept.getFields().get(i);
			
			if(i!=0 && !"init".equals(field.getType()) && !"init-end".equals(field.getType()) 
					&& !"feature".equals(field.getType()) && !"feature-end".equals(field.getType())){
				%>
					<div class="row">
						<div class="col s12 m3 l3 center-align">&darr;</div>
					</div>
				<%
			}

					switch (field.getType()) {
					case "history":
		%>												    
						<div class="row">
							<div class="col s12 m3 l3 symbol${depth} center-align fc-history z-depth-1" data-field-id="<%=field.getName() %>">
									<%=field.getDesc() %>
							</div>
						</div>
						<div class="row">
							<div class="col s12 card-panel" id="<%=field.getName() %>Value" hidden="true" style="padding: 10px">
								<span class="fc-content"><%=field.getValue() %></span>
							</div>		
						</div>					
					<%
					break;
				case "start" :
					%>						
						<div class="row">
							<div class="col s12 m3 l3 symbol${depth} center-align fc-start z-depth-1" data-field-id="<%=field.getName() %>">
									<%=field.getDesc() %>
							</div>
						</div>
						<div class="row">
							<div class="col s12 card-panel" id="<%=field.getName() %>Value" hidden="true" style="padding: 10px">
								<span class="fc-content"><%=field.getValue() %></span>
							</div>	
						</div>
					<%
					break;
				case "comment" :
					%>
						<div class="row">
							<div class="col s12 m3 l3 symbol${depth} center-align fc-comment z-depth-1" data-field-id="<%=field.getName() %>">
									<%=field.getDesc() %>
							</div>
						</div>
						<div class="row">
							<div class="col s12 card-panel" id="<%=field.getName() %>Value" hidden="true" style="padding: 10px">
								<span class="fc-content"><%=field.getValue() %></span>
							</div>	
						</div>	
					<%
					break;
				case "notes" :
					%>
						<div class="row">
							<div class="col s12 m3 l3 symbol${depth} center-align fc-notes z-depth-1" data-field-id="<%=field.getName() %>">
									<%=field.getDesc() %>
							</div>
						</div>
						<div class="row">
							<div class="col s12 card-panel" id="<%=field.getName() %>Value" hidden="true" style="padding: 10px">
								<span class="fc-content"><%=field.getValue() %></span>
							</div>	
						</div>	
					<%
					break;
				case "init-start" :
				case "init" :
				case "init-one" :
				case "init-end" :
					if("init-start".equals(field.getType()) || "init-one".equals(field.getType())){
						%><div class="row"><%
					}
					%>	
						<div class="col symbol${depth} fc-init z-depth-1" data-field-id="<%=field.getName() %>" data-field-name="initValue${depth}">
							<%=field.getDesc() %>
						</div>
						<input type="hidden" id="<%=field.getName() %>Text" value="<%=field.fetchEncodedValue() %>"/>
					<%
					if("init-end".equals(field.getType()) || "init-one".equals(field.getType())){
						%></div>
						<div class="row">
							<div class="col s12 card-panel" id="initValue${depth}" hidden="true" style="padding: 10px"></div>
						</div>
						<%
					}
					break;
				case "test" :
					%>						
						<div class="row">
							<div class="col fc-test z-depth-1">
								<div style="transform: rotate(45deg); padding: 25px;">
									<%=field.getDesc() %>
								</div>
							</div>
						</div>
					<%
					break;
				case "feature-start" :
				case "feature" :
				case "feature-one" :
				case "feature-end" :
					if("feature-start".equals(field.getType()) || "feature-one".equals(field.getType())){
						%><div class="row"><%
					}
					%>						
						<div class="col symbol${depth} fc-feature z-depth-1" data-field-id="<%=field.getName() %>" data-field-name="featureValue${depth}">
							<%=field.getDesc() %>
						</div>
						<input type="hidden" id="<%=field.getName() %>Text" value="<%=field.fetchEncodedValue() %>"/>
					<%
					if("feature-end".equals(field.getType()) || "feature-one".equals(field.getType())){
						%></div>
						<div class="row">
							<div class="col s12 card-panel" id="featureValue${depth}" hidden="true" style="padding: 10px"></div>
						</div>
						<%
					}
					break;
				case "process" :
						%>
						<div class="row">
							<div class="col s12 m3 l3 symbol${depth} center-align fc-process z-depth-1" data-field-id="<%=field.getName() %>" data-field-name="processValue${depth}">
								<%=field.getDesc() %>
							</div>
							<input type="hidden" id="<%=field.getName() %>Text" value="<%=field.fetchEncodedValue() %>"/>
						</div>
						<div class="row">
							<div class="col s12 card-panel" id="processValue${depth}" hidden="true" style="padding: 10px"></div>
						</div>
						<%					
					break;
				case "end" :
					%>						
						<div class="row">
							<div class="col s12 m3 l3 symbol${depth} center-align fc-end z-depth-1" data-field-id="<%=field.getName() %>">
									<%=field.getDesc() %>
							</div>
						</div>
						<div class="row">
							<div class="col s12 card-panel" id="<%=field.getName() %>Value" hidden="true" style="padding: 10px">
								<span class="fc-content"><%=field.getValue() %></span>
							</div>	
						</div>
					<%
					break;
				default :
					%>						
						<div class="row">
							<div class="col s6 m4" style="border: 1px solid #ddd;">
								Features
							</div>
						</div>
					<%
			}
		%>
		<% } %>
		
		
		<br/>
		<br/>	
		
		<div id="textToSpeech" style="display: none;">
			${concept.textToSpeech}
		</div>	

		<div class="row">		
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div class="row">
					<div class="col s12">
						<button type="button" class="btn" id="editBtn" onclick="gotoDetail('${concept.id}')"><i class="material-icons">edit</i> </button>
						<input type="button" class="btn" value="Add Concept" onclick="addConcept('concept/createconcept')" /> 
					</div>
				</div>
			</sec:authorize>
		</div>
	</c:if>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('#modal1').modal('close');
		$('.collapsible').collapsible();
		$("#conceptsLink").click(function() {
			$("main").load("concept/listconcept");
		})
	});
	$(function() {
		$('textarea').each(function() {
			$(this).height($(this).prop('scrollHeight'));
		});
	});
	
	$(document).ready(function() {
		var pageDepth = ${depth};
		$(".symbol"+pageDepth).click(function() {
			var depth = ${depth} + 1;
			var valueDivId = "#"+$(this).data('field-id')+"Value";
			var textInputId = "#"+$(this).data('field-id')+"Text";
			var nameDivId = "#"+$(this).data('field-name');
			
			if($(valueDivId).length){
				$(valueDivId).toggle();
			}else{
				if($(textInputId).val().length === 0){
					var conceptName1 = $(this).data('field-id');
					$(nameDivId).load("/jtechy/concept/readconcept/" + conceptName1 + "/" + depth);
					$(nameDivId).toggle();
				}else{
					$(nameDivId).empty().append('<span style="white-space: pre-wrap;">' + atob($(textInputId).val()) + "</span>");
					$(nameDivId).toggle();
				}				
			}		
		});
	});
	function addConcept(arg){
		$("main").load(arg);
	}
	function gotoDetail(arg) {
		$("main").load("concept/updateconcept/" + arg);
	}
	function addconceptField(arg) {
		$("main").load("concept/addconceptfield?id=" + arg);
	}
</script>
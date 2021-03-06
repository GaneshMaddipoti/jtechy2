<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page isELIgnored="false"%>
<div class="container" id="softdev">

	<div class="row">
		<br /> <a href="#!" id="coursesLink">Tutorials</a> -
		${course.category} - ${course.name}
	</div>

	<div class="row">
		<ul class="collapsible">
			<c:forEach var="field" items="${course.fields}" varStatus="loop">
				<li>
					<div class="collapsible-header">
						<div class="valign-wrapper">
							<i class="material-icons" onclick="speakField('${loop.count}')">chevron_right</i> 
							<span id="fieldName${loop.count}">${field.fieldName}</span>							
						</div>
					</div>
					<div class="collapsible-body">
						<span style="white-space: pre-wrap;" id="fieldValue${loop.count}">${field.fieldValue}</span>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div id="textToSpeech" style="display: none;">
		${course.textToSpeech}
	</div>

	<div class="row">
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<div class="row">
				<div class="col s12">
					<button type="button" class="btn" id="editBtn" onclick="gotoDetail('${course.id}')"><i class="material-icons">edit</i> </button>
					<button type="button" class="btn" id="speakBtn"><i class="material-icons">play_arrow</i> </button>
					<button type="button" class="btn" id="stopBtn"><i class="material-icons">stop</i></button>
					<button type="button" class="btn" id="pauseBtn"><i class="material-icons">pause</i></button>
					<button type="button" class="btn" id="resumeBtn"><i class="material-icons">replay</i></button>
					<button type="button" class="btn" id="speakSelectedBtn"><i class="material-icons">play_circle_outline</i></button>
				</div>
			</div>
		</sec:authorize>
	</div>

</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('#modal1').modal('close');
		$('.collapsible').collapsible();
		$("#coursesLink").click(function() {
			$('#modal1').modal('open');
			$("main").load("course/listcourse");
		})
		// Speech
		$("#speakBtn").on("click", function () {
			var textCount = 0;
			for( ;textCount < $("#textToSpeech").html().length; ){
				var message = new SpeechSynthesisUtterance(($("#textToSpeech").html()).substring(textCount, textCount + 2000));
				speechSynthesis.speak(message);
				textCount = textCount + 2000;
			}
		});
		$("#speakSelectedBtn").on("click", function () {
			var selObj = window.getSelection();
			var selectedText = selObj.toString(); 
			var message = new SpeechSynthesisUtterance(selectedText);
		    speechSynthesis.speak(message);
		});
		$("#stopBtn").on("click", function () {
		    speechSynthesis.cancel();
		});
		$("#pauseBtn").on("click", function () {
		    speechSynthesis.pause();
		});
		$("#resumeBtn").on("click", function () {
		    speechSynthesis.resume();
		});
	});
	$(function() {
		$('textarea').each(function() {
			$(this).height($(this).prop('scrollHeight'));
		});
	});
	function gotoDetail(arg) {
		$("main").load("course/common/get/modify/" + arg);
	}
	function addCourseField(arg) {
		$("main").load("course/addcoursefield?id=" + arg);
	}
	var flag = true;
	function speakField(arg){
		if(flag){
			var tempStr= "#fieldValue" + arg;
			var textCount = 0;
			for( ;textCount < $(tempStr).html().length; ){
				var message = new SpeechSynthesisUtterance(($(tempStr).html()).substring(textCount, textCount + 2000));
				speechSynthesis.speak(message);
				textCount = textCount + 2000;
			}
		    flag = false;
		}else{
			speechSynthesis.cancel();
			flag = true;
		}
	}
	
</script>
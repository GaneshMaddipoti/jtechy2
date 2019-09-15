<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="img/icon.ico">
<title>Jtechy - Tutorials, Projects, Development and Support</title>
<link href="css/icon.css" rel="stylesheet">
<link rel="stylesheet" href="css/materialize.min.css">
<link type="text/css" rel="stylesheet" href="css/custom.css"
	media="screen,projection" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
	<p>
		<label>Message <input type="text" id="text"
			value="Your package has been recorded."></input>
		</label>
	</p>
	<p>
		<label>Volume <input type="number" id="volume" value="1"></input>
		</label>
	</p>
	<p>
		<label>Rate <input type="number" id="rate" value="1"></input>
		</label>
	</p>
	<p>
		<label>Pitch <input type="number" id="pitch" value="1"></input>
		</label>
	</p>
	<p>
		<label>Voice <select id="voice"></select>
		</label>
	</p>
	<p>
		<button type="button">Speak!</button>
	</p>
	<script type="text/javascript" src="js/jquery.js"></script>
	<script src="js/materialize.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var message = new SpeechSynthesisUtterance($("#text").val());
			var voices = speechSynthesis.getVoices();

			$("input").on("change", function () {
			    console.log($(this).attr("id"), $(this).val());
			    message[$(this).attr("id")] = $(this).val();
			});

			$("select").on("change", function () {
			    message.voice = voices[$(this).val()];
			});

			$("button").on("click", function () {
				alert("ddd")
			    speechSynthesis.speak(message);
			});

			// Hack around voices bug
			var interval = setInterval(function () {
			    voices = speechSynthesis.getVoices();
			    if (voices.length) clearInterval(interval); else return;

			    for (var i = 0; i < voices.length; i++) {
			        $("select").append("<option value=\"" + i + "\">" + voices[i].name + "</option>");
			    }
			}, 10);
		});
	</script>
</body>
</html>
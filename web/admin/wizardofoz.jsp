<%
boolean isValidUser=false;
Object userVal=session.getAttribute("adminLoginSuccesfull");
try{
	if(userVal!=null){
		isValidUser=Boolean.parseBoolean(userVal.toString().trim());
	}
}catch(Exception e){	
}
if(!isValidUser){
	response.sendRedirect(response.encodeRedirectURL("/DeepTutorAppReArch/adminLogin"));		
}

%>

<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://java.sun.com/jsf/html">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/Styles.css" />
<title>DeepTutor - Wizard of Oz</title>

<script type="text/javascript" charset="utf-8" src="admin/jquery-1.7.2.js"></script>

<script type="text/javascript">
	var ws;

	$(document).ready(
			function() {
				/**
					enter your ip iddress here if you want to use the chat on many pc's
				**/
				ws = new WebSocket('ws://' + document.location.host + '/DeepTutorAppReArch/h5ws');
				ws.onopen = function(event)  {
					ws.send("\\woz-getusers");
				};
				ws.onerror = function (error) {
					console.log('WebSocket Error ' + error);
				};
				ws.onmessage = function(event) {
					var servermessage = event.data;
					
					if (servermessage.substring(0,6)=='Users:')
					{
						var selectIDList = "<hr/>Please select the student ID that you wish to tutor and press Connect: ";
						selectIDList += "<select id=\"selectStudent\"><option>Select given ID...</option>";
						var users = servermessage.substring(6).split(" ");
						for (var i=0;i<users.length;i++)
						{
							selectIDList+="<option>"+users[i]+"</option>";
						}
						selectIDList += "</select><input type=\"button\" value=\"Connect\" onclick=\"TutorStudent();\">";
						
						$('#selectUserList').html(selectIDList);
						return;
					}
					
					if (servermessage.substring(0,10 )=='Connected:')
					{
						var connectedStatus = "<hr/>You are now tutoring student ID: " + servermessage.substring(10);
						connectedStatus += " <input type=\"button\" value=\"Disconnect\" onclick=\"DisconnectStudent();\">";
						$('#selectUserList').html(connectedStatus);
						
						return;	
					}
					
					if (servermessage=='MessageReceived')
					{
						$('#msgReceived').html("Message received.");
						return;	
					}

					if (servermessage.substring(0,14 )=='TutorResponse:')
					{
						var tutorMessage = servermessage.substring(14);
						$('#messageTutor').val(tutorMessage);

						return;	
					}

					var $textarea = $('#messages');

					if (servermessage.substring(0,8)=='Problem:')
					{
						servermessage = servermessage.substring(9);
						var $problemarea = $('#problem');
						$problemarea.val(servermessage);
						
						$textarea.val($textarea.val() + "Student began working on a new problem...\n");
						return;
					}

					$textarea.val($textarea.val() + event.data + "\n");
					$textarea.animate({
						scrollTop : $textarea.height()
					}, 1000);
				};
				ws.onclose = function(event) {
					
				};
		
			});
	
	$(window).onbeforeunload = function() {
		alert("Connection is closed...");
	    websocket.onclose = function () {}; // disable onclose handler first
	    websocket.close();
	};
	
	function TutorStudent()
	{
		var e = document.getElementById("selectStudent");
		if (e.selectedIndex == 0) alert("You must choose a valid Student ID before pressing Connect.");
		else
		{
			ws.send("\\woz-connect " + e.options[e.selectedIndex].text);
		}
	}

	function DisconnectStudent()
	{
		ws.send("\\woz-getusers"); //this will automatically disconnect the tutor from its current student
	}
	
	function sendMessage() {
		var message = $('#username').val() + ": " + $('#message').val();
		//console.log('WS Ready State = ' + ws.readyState);
		ws.send("\\woz-response " + message);
		$('#message').val('');
		$('#messageTutor').val('');
		$('#msgReceived').html("Sending Message...");
	}

	function sendMessageTutor() {
		if ($('#messageTutor').val()!='') 
		{
			ws.send("\\woz-tutorResponse");
			$('#messageTutor').val('');
			$('#msgReceived').html("Sending Message...");
		}
	}

	function closeWS() {
		ws.close();
		console.log('WS Ready State = ' + ws.readyState);
	}
	
	function backToAdmin(){
		ws.close();
		window.location = "admin.jsp";		
	}

		</script>

</head>
<body id="body">
  <div id="container">
        <div id="header">
                <table width="100%"><tr>
                        <td width="200px" height="120px">
                            <div style="width:160px; height:120px;" align="center">
                                <div id="logo" style="display: dock" align="center"><img src="images/logo_site.png" width="150px" height="120px" hspace="10" border="0"/></div>
                                &nbsp;</div>
                        </td>
                        <td height="100px"><h1><font color="#FFFFFF">&nbsp; DeepTutor - Wizard of Oz</font></h1></td>
                    </tr></table>
                </div>

	<div id="navigation">
		<ul>
			<li><a href="../DeepTutorAppReArch/dtadminHomepage">Home</a></li>
		</ul>
	</div>
	<div id="content-container">
	  <div id="content-files">

		<div id="menu">
			<p class="welcome">
				Welcome, Tutor,<p/>
				On this page you will disguise yourself as an virtual tutor and temporarily replace the real tutoring system, in a guided conversation with the learner.<br/>
				Below, you can see the student output in the chat history box, to which you can give your own feedback, but not before you received at least some message from the other party, i.e. the student.
				<div id="selectUserList">Loading users. Please wait...</div> 
				<input type="hidden" id="username" value="Tutor" readonly="readonly"/>
			</p>
			<div style="clear: both"></div>
		</div>
		<table><tr><td>
		<b>Chat History Box: </b><label id="msgReceived"></label><br/>
		<div id="chatbox">
			<textarea id="messages" rows="16" cols="52" readonly="readonly"></textarea>
		</div>

		<form name="message" action="">
			<b>Your Feedback:</b><br/>
			<input name="usermsg" type="text" id="message" size="55" /> 
			<input type="button" name="submitmsg" value="Send Mine" onclick="sendMessage();" />
			<!--input type="button" name="submitmsg" value="Close..." onclick="closeWS();" /-->
			<br/><b>Tutor recommends:</b><br/>
			<textarea name="tutormsg" id="messageTutor" rows="4" cols="42" readonly="readonly"></textarea>
			<input type="button" name="submittutormsg" value="Send Tutor's" onclick="sendMessageTutor();" />
			<!--input type="button" name="submitmsg" value="Close..." onclick="closeWS();" /-->
		</form>
		</td><td>
		<b>Current Learning Task:</b><br/>
		<div id="problembox">
			<textarea id="problem" rows="16" cols="45" readonly="readonly"></textarea>
		</div>
		</td></tr></table>
	</div>
		<div id="aside">
			<h3>&nbsp;</h3><br/>
    </div>
		<div id="footer">
			Copyright © DeepTutor.org, 2013
		</div>
	</div>
</div>
</body>
</html>
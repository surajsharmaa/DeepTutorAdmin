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


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/Styles.css" />

<title>Student LP</title>

<script type="text/javascript" charset="utf-8" src="admin/jquery-1.7.2.js"></script>

<script type="text/javascript">
	$(document).ready(
			function() {
				if ($("#students").length > 0)
				{
					var selectIDList = "Please select the student ID for which you wish to view LP: ";
					selectIDList += "<select id=\"selectStudent\"><option>Select given ID...</option>";
					var users = $("#students").val().split(" ");
					for (var i=0;i<users.length;i++)
					{
						selectIDList+="<option>"+users[i]+"</option>";
					}
					selectIDList += "</select><input type=\"button\" value=\"View LP\" onclick=\"TutorStudent();\">";
					
					$('#selectUserList').html(selectIDList);
				}
			});
	
	function TutorStudent()
	{
		var e = document.getElementById("selectStudent");
		if (e.selectedIndex == 0) alert("You must choose a valid Student ID before pressing View LP.");
		else
		{
			$("#command").val("viewlp");
			$("#viewid").val(e.options[e.selectedIndex].text);
			$("#lpviewForm").submit();
		}
	}
	
	function ViewCell(topicIndex, lpLevel, evaluationId)
	{
		$("#command").val("viewcell " + topicIndex + " " + lpLevel + " " + evaluationId);
		$("#lpviewForm").submit();
	}

	function ViewCellAllFCI(topicIndex, lpLevel, evaluationId)
	{
		$("#command").val("viewcellallfci " + topicIndex + " " + lpLevel + " " + evaluationId);
		$("#lpviewForm").submit();
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
            <td height="100px"><h1><font color="#FFFFFF">&nbsp; DeepTutor - View Students' LP Model </font></h1></td>
	</tr></table>
</div>

<div id="navigation">
	<ul>
		<li><a href="../DeepTutorAppReArch/dtadminHomepage">Back</a></li>
	</ul>
</div>
<div id="content-container">
<div id="content-files">
<form action="lpview"  method="post" id="lpviewForm">
	
	<input type="hidden" id="students" name="students" value="${students}"/>
	<input type="hidden" id="viewid" name="viewid" value="${viewid}"/>
	<input type="hidden" id="command" name="command" value=""/>
	<input type="hidden" id="lpcell" name="command" value=""/>
	
	<!-- h2>Things to do:</h2-->
	<br/>
	<div id="selectUserList">Loading student list. Please wait...</div>
	Response from the system: <label style="color:red" id="feedback">${feedback}</label><br/>
	<br/>
	<h2>Pre-test</h2>
	${matrixpre}
	<br/>
	<h2>Post test</h2>
	${matrixpost}
	<br/>
	<h2>LP Details</h2>
	${lpdetail}
	<h2>Question and LP map</h2>
	${questionLPTable}
	<br/>
	${topicHitsTables}
	<br/>
</form>
</div>
<div id="aside">
</div>
<div id="footer">Copyright © DeepTutor.org, 2013</div>
</div>
</div>
</body>
</html>

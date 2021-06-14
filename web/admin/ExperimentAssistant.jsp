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
<title>DeepTutor- Admin Experiment Manager</title>

<script type="text/javascript" src="jquery-1.7.2.js"></script>
<script type="text/javascript">
function confirmUpdate(){
	return confirm("Do you really want to transfer these files ? ");
}
function confirmUpload(){
	return confirm("Are you sure you want to upload the experimentConfig file ?");
}
	$(document).ready(function() {

		// Great code. works even for dynamically added buttons
		$('input[type="submit"]').live("click", function(event) {
			process_form_submission(event);
			return false;
		});

	});
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
                        <td height="100px"><h1><font color="#FFFFFF">&nbsp; DeepTutor - Experiment Manager</font></h1></td>
                    </tr></table>
                </div>

		<div id="navigation">
			<ul>
				<li><a href="../DeepTutorAppReArch/dtadminHomepage">Back</a></li>
			</ul>
		</div>
		<div id="content-container">
			<div id="content-files">
			 	<c:if test="${status!=null}">
				<center><font color="blue"> ${status}</font></center>
				</c:if>
				<%
					session.removeAttribute("status");
				%>
				<h3>Section 1: Upload Files</h3>
				<hr />
				<br />
				<form action="uploadTaskSeq" enctype="multipart/form-data" method="post" onsubmit="return confirmUpload(this);">
					<input type="hidden" name="action" value="upload task config"></input>
					A. Task Sequence File (experimentConfig.xml) : <input type="file" name="myFile" /> <input
						type="submit" name="btnUploadTask" value="Upload" />
				</form>

				<br /> <br /> <br />

				<h3>Section 2: Transfer Tasks</h3>
				<hr />

				<%
					String[][] taskInfo = (String[][]) session
							.getAttribute("expAssistantTasks");
					int tasksCount = 0;
					String tableRows = "";
					
					if (taskInfo != null) {
						tasksCount = taskInfo.length;

						
						for (int i = 0; i < taskInfo.length; i++) {
							
							//out.print(i+","+taskInfo[i][0]+","+taskInfo[i][1]+","+taskInfo[i][2]+"<br>");

							String eName = taskInfo[i][0];
							String tName = taskInfo[i][1];

							String color = taskInfo[i][2];
							String colorCode1 = "#CCCCCC",colorCode2="#CCCCCC";
							if (color.equalsIgnoreCase("RED")) {
								colorCode1 = "#FF0000";
								colorCode2 = "#00FF00";

							} else if (color.equalsIgnoreCase("GREEN1")) {
								colorCode1 = "#00FF00";
							} else if (color.equalsIgnoreCase("GREEN2")) {
								tName = "";
								colorCode1 = "#00FF00";
							}

							tableRows += "<tr><td align=\"center\"><input type=\"checkbox\" name=\"f" + i
									+ "\" value=\"" + eName + "\" /></td>"
									+ "<td bgcolor=\"" + colorCode1 + "\" >" + eName
									+ "</td><td bgcolor=\"" + colorCode2 + "\">" + tName
									+ "</td></tr>";
						}
					}

				%>

				<form name="frm" method="get" action="experiment" onsubmit="return confirmUpdate();">
					<input type="hidden" name="action" value="transfer"></input>

					<table border="0" align="center" cellpadding="1" cellspacing="1">
						<tr bgcolor="#5978b3">
							<th scope="col">&nbsp;</th>
							<th scope="col">Edited Tasks</th>
							<th scope="col">Tasks</th>
						</tr>
						<%
							out.print(tableRows);
						%>

						<tr>
							<td colspan="3" align="center">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="3" align="center"><input type="submit"
								value="Update Tasks" /></td>
						</tr>
					</table>
				</form>



			</div>
			<div id="aside"></div>
			<div id="footer">Copyright © DeepTutor.org, 2013</div>
		</div>
	</div>
</body>
</html>

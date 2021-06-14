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
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/Styles.css" />
<title>DeepTutor - admin</title>

<script type="text/javascript" src="admin/scroll-sneak.js"></script>
<script>
function downloadLog(filename) {
 top.consoleRef=window.open('','myconsole',
  'width=600,height=500'
   +',menubar=0'
   +',toolbar=1'
   +',status=0'
   +',scrollbars=1'
   +',resizable=1');
 top.consoleRef.document.writeln(document.getElementById('content').innerHTML);
 top.consoleRef.document.close();
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
                        <td height="100px"><h1><font color="#FFFFFF">&nbsp; DeepTutor - admin</font></h1></td>
                    </tr></table>
        </div>

	<div id="navigation">
		<ul>
			<li><a href="../DeepTutorAppReArch/dtadminHomepage">Home</a></li>
			<li><a href="todo">Developer TODO List</a></li>
			<li><a href="experiment">Experiment Manager</a></li>
			<li><a href="wizardofoz">Wizard of Oz</a></li>
			<li><a href="dtadminTasks">Create A Task</a></li>
			<li><a href="lpview">Student LP</a></li>
			<li><a href="adminContactUs">Contact us</a></li>
                        <li><a href="adminLogout">Logout</a></li>
		</ul>
	</div>
	<div id="content-container">
	  <div id="content-files">
		<table><tr>
		<td><h2>Upload Tasks and Media</h2><br/>
		<form action="taskUploader" enctype="multipart/form-data" method="post">
		<table border="0">
		    <tr>
		      <td width="66">File Name:</td>
		      <td width="400"><input name="myFile" type="file" size="50" /></td>
	        </tr>
		    <tr>
		      <td>&nbsp;</td>
		      <td><input type="submit" value="Upload Task Resource" /></td>
	        </tr>
	        <tr><td></td><td><font color="green">${upload_status}</font>&nbsp;</td></tr>
	      </table>
	    </form>
	    </td><td>
	    <h2>Upload Edited Tasks</h2><br/>
		<form action="editedTaskUploader" enctype="multipart/form-data" method="post">
		<table border="0">
		    <tr>
		      <td width="66">Task Name:</td>
		      <td width="400"><input name="editedFile" type="file" size="50" /></td>
	        </tr>
		    <tr>
		      <td>&nbsp;</td>
		      <td><input type="submit" value="Upload to Edited Tasks" /></td>
	        </tr>
	        <tr><td></td><td><font color="green">${upload_status2}</font>&nbsp;</td></tr>
	      </table>
	    </form></td>
	    </tr>
	    </table>
		<h2>Existing Files:</h2>
		<table><tr><td>
		<form method="post" action="getFilesOnClick">
			<input type="hidden" id="get_files" name="get_files" value="logs"/>
			<input type="submit" id="btnGetLogs" value="Get Logs"/>
		</form> 
		</td><td>
		<form method="post" action="getFilesOnClick">
			<input type="hidden" id="get_files" name="get_files" value="tasks"/>
			<input type="submit" id="btnGetTasks" value="Get Tasks" onclick=""/>
		</form>
		</td><td>
		<form method="post" action="getFilesOnClick">
			<input type="hidden" id="get_files" name="get_files" value="media"/>
			<input type="submit" id="btnGetMedia"value="Get Media" onclick=""/>
		</form>
		</td></tr></table>
		<hr/>
		<table>
			<tr valign="top"><td width="250px" style="white-space: nowrap">
			<ol>
			  <c:forEach var="f" items="${files}">
			   	<li>
			   		<form method="post" action="getFiles">
		   				<input type="hidden" id="get_files" name="get_files" value="${get_files}"/>
		   				<input type="hidden" id="view_file" name="view_file" value="${f.key}"/>
	   					<c:set var = "TR1" value="${f.value}"/>
	   					<c:set var = "TR2" value="${file_name}"/>
		   				<c:choose>
		  					<c:when test="${(TR1 eq TR2) && !fn:startsWith(TR2,'Log-')}">
			  					<input type="button" name="Download" value="Download" onclick="window.open('${file_name}','Download_File','')"/>
			  				</c:when>
		  					<c:when test="${TR1 eq TR2 && fn:startsWith(TR2,'Log-')}">
			  					<input type="button" name="Download" value="Download" onclick="downloadLog('${TR1}')"/>
			  				</c:when>
			  				<c:otherwise>
			  					<input type="submit" name="View" value="View"/>
			  				</c:otherwise>
			  			</c:choose>
			   			${f.key}
					</form> 
	    		</li>
		  	</c:forEach>
			</ol>
			</td>
			<td id="content" width="600px">${file_content}</td></tr>
		</table>
      <br />
		
</div>
		<div id="aside">
			<h3>&nbsp;</h3><br/>
    </div>
		<div id="footer">
			Copyright © DeepTutor.org, 2013
		</div>
	</div>
</div>

<!-- SCROLL SNEAK JS: you can change `location.hostname` to any unique string or leave it as is -->
<script>
(function() {
    var sneaky = new ScrollSneak(location.hostname), tabs = document.getElementsByName('View'), i = 0, len = tabs.length;
    for (; i < len; i++) {
        tabs[i].onclick = sneaky.sneak;
    }
    document.getElementById('btnGetLogs').onclick = sneaky.sneak;
    document.getElementById('btnGetTasks').onclick = sneaky.sneak;
    document.getElementById('btnGetMedia').onclick = sneaky.sneak;
})();
</script>

</body>
</html>

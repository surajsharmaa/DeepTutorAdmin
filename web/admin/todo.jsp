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
<title>Developer TODO List</title>

<script type="text/javascript" src="admin/jquery-1.7.2.js"></script>
<script type="text/javascript">
  $(document).ready(function() {

	// Great code. works even for dynamically added buttons
	$('input[type="submit"]').live("click", function(event) {
		process_form_submission(event);
		return false;
	});

  });

  function addNewTodoItem() {

	var rowID = $('#myTable tr').length;
	var aNewTextRow = '<tr id="'+rowID+'" style="background-color:#aaf;"><td>..</td><td><input type="text" id="assignee'+rowID+'" value="" size="8"></td>'+
					  '<td><textarea id="description'+rowID+'" rows="4" cols="40"></textarea></td>'+
					  '<td></td>'+
					  '<td><input type="submit" id="save'+rowID+'" value=" Save  Task "/><br/></td></tr>';
	$("#btnCreate").attr("disabled", "disabled");
	$("#rowAddTodoTask").after(aNewTextRow);
  }
  
  function process_form_submission(event) {
    event.preventDefault();
    //var input = $(event.currentTarget);
    var which_button = event.currentTarget.id;

    if (which_button.substring(0, 4) == 'save') {

      var id=which_button.substring(4);
    	
      if ($('#assignee'+id).val() == "")
      {
    	  alert("You must assign the task to someone. Please fill in the assignee input field.");
    	  return;
      }
      if ($('#description'+id).val() == "")
      {
    	  alert("The task that you want to create does not have any description. Please fill in the Task Description input field.");
    	  return;
      }

      var fname=prompt("Please enter your name for aproval:","");
  	
  	  if (fname==null || fname=="") return;
  	
	  $("#command").val("create");
	  $("#creator").val(fname);
	  $("#assignee").val($('#assignee'+id).val());
	  $("#textItem").val($('#description'+id).val());
	
	  $("#todoForm").submit();
    }
    else if (which_button.substring(0, 6) == 'update') {
        var id=which_button.substring(6);
	    $("#command").val("update");
	    $("#itemID").val(id);
	    $("#responseItem").val($('#response'+id).val());

	    $("#todoForm").submit();
    }
    else if (which_button.substring(0, 5) == 'close') {
    	var fname=prompt("Please enter your name for aproval:","");
    	  	
      	if (fname==null || fname=="") return;
        
      	var id=which_button.substring(5);
	    $("#command").val("close");
	    $("#itemID").val(id);
	    $("#creator").val(fname);

	    $("#todoForm").submit();
    }
  }
</script>

</head>

<body id="body">
<div id="container">
<div id="header">
    
        <table width="100%">
            <tr>
                <td width="200px" height="120px">
                    <div style="width:160px; height:120px;" align="center">
                        <div id="logo" style="display: dock" align="center"><img src="images/logo_site.png" width="150px" height="120px" hspace="10" border="0"/></div>
                        &nbsp;</div>
                </td>
                <td height="100px"><h1><font color="#FFFFFF">&nbsp; DeepTutor - Developer TODO List </font></h1></td>
            </tr>
        </table>	
</div>

<div id="navigation">
	<ul>
		<li><a href="../DeepTutorAppReArch/dtadminHomepage">Back</a></li>
	</ul>
</div>
<div id="content-container">
<div id="content-files">
<form action="todo"  method="post" id="todoForm">
	<h2>Things to do:</h2>
	<br/>
	Response from the system: <label style="color:red" id="feedback">${feedback}</label>
	<input type="hidden" id="command" name="command" value=""/>
	<input type="hidden" id="creator" name="creator" value=""/>
	<input type="hidden" id="assignee" name="assignee" value=""/>
	<input type="hidden" id="textItem" name="textItem" value=""/>
	<input type="hidden" id="responseItem" name="responseItem" value=""/>
	<input type="hidden" id="itemID" name="itemID" value=""/>

	<p/>
	<table id="itemsTable" border="1" cellpadding="5px" style="border-spacing:0px">
		<tr id="rowAddTodoTask"><td> ID </td><td> Assignee____ </td><td> Task Description </td><td> Response Resolution </td><td><input type="button" id="btnCreate" value=" Create Task" onclick="addNewTodoItem()"/></td></tr>
		<c:set var="expCount" value="0" /> 
		<c:forEach var="exp" items="${todoItems}">
			<c:choose>
				<c:when test="${exp.response == ''}">
					<tr style="background-color:#faa;">
				</c:when>
				<c:otherwise>
					<tr style="background-color:#afa;">
				</c:otherwise>
			</c:choose>
			<td>${exp.todoID}</td><td >${exp.assignee}</td><td><textarea id="description" rows="4" cols="40" readonly="readonly" style="background-color:#eee;">${exp.text}</textarea></td>
			<td><textarea id="response${exp.todoID}" rows="4" cols="40" >${exp.response}</textarea></td>
			<td><input type="submit" id="update${exp.todoID}" value="Update Task"/><br/><input type="submit" id="close${exp.todoID}" value=" Close Task "/></td></tr>
		</c:forEach> 
		
	</table>
</form>
</div>
<div id="aside">
</div>
<div id="footer">Copyright © DeepTutor.org, 2013</div>
</div>
</div>
</body>
</html>

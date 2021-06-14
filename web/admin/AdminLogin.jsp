<%
boolean isValidUser=false;
Object userVal=session.getAttribute("adminLoginSuccesfull");
try{
	if(userVal!=null){
		isValidUser=Boolean.parseBoolean(userVal.toString().trim());
	}
}catch(Exception e){	
}
if(isValidUser){
	response.sendRedirect(response.encodeRedirectURL("/DeepTutorAppReArch/dtadminHomepage"));		
}

%>

<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/Styles.css" />

    <title>DeepTutor Admin</title>
    <script type="text/javascript">
            function validateForm() {
                var id = document.forms["loginForm"]["userName"].value;
                var password = document.forms["loginForm"]["password"].value;

                if (id == null || id == "") {
                    alert("Please provide Id to proceed");
                    return false;
                }
                if (id != "guest" && id != "wozguest" && id.toLowerCase().indexOf("bill")!=0) {
                    if (password == null || password == "") {
                        alert("Please provide Password to proceed");
                        return false;
                    }
                }
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
		<td height="100px"><h1><font color="#FFFFFF">&nbsp; DeepTutor Admin Tool Login </font></h1></td>
		</tr></table>
</div>
<div id="content-terms">
	Please enter your credentials before accessing the admin pages:<br/>
	 <form id="form1" name="loginForm" onsubmit="return validateForm();"
                          method="post" action="verifyAdmin">
                        <table border="0">
                            <tr>
                                <td>Id:</td>
                                <td><input type="text" name="userName" id="userName"
                                           value="<s:property value="userName"/>" /></td>
                            </tr>
                            <tr>
                                <td>Password:</td>
                                <td><input type="password" name="password" id="password"
                                           value="<s:property value="password"/>" /></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <br/>
                                   
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td><input type="submit" name="btnSubmit" id="btnSubmit"
                                           value="Submit" /></td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                        </table>
                        <!-- show error message if any.. -->
                        <font color="red"> <s:property value="message"/></font>
             </form>
</div>
<div id="aside">
</div>
<div id="footer">Copyright © DeepTutor.org, 2013</div>
</div>
</body> 
<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib prefix="s" uri="/struts-tags" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="css/Styles.css" />
        <title>Login</title>
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
                <table width="100%">
                    <tr>
                        <td width="200px" height="120px">
                            <div style="width: 160px; height:120px" align="center">
                                <!--     disable flash for now:  <script language="javascript">
                                                                    AC_FL_RunContent = 0;
                                                                </script>
                                                                <script src="../DTAvatar/AC_RunActiveContent.js"
                                                                type="text/javascript"></script> -->
                                <div id="logo" style="display: dock" align="center">
                                    <img src="images/logo_site.png" width="150px" height="120px"
                                         hspace="10" border="0" />
                                </div>
                                &nbsp;
                            </div>
                        </td>
                        <td height="100px"><h1>
                                <font color="#FFFFFF">&nbsp; DeepTutor</font>
                            </h1></td>
                    </tr>
                </table>
            </div>
            <div id="navigation">
                <ul>
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Help</a></li>
                    <li><a href="#">Contact us</a></li>
                </ul>
            </div>
            <div id="content-container">
                <div id="content">
                    <h2>Instructions</h2>
                    <p>Please use given Id, your first name and last name in the
                        right panel to get access to the DeepTutor.</p>
                    <p>If you are a first time user, you need to provide some
                        demographic information (e.g. your school name, your grade, your
                        familiarity with physics etc. ) once you log in to the system.</p>
                    <p>If you were in the middle of the tutoring, your session will
                        be resumed so that you start from the point you left the tutoring.</p>
                    
                     
                    <!--nice image-->
                    <p>
                        <img src="images/dtWorld.small.png" />
                    </p>
                    <p>&nbsp;</p>

                </div>
                <div id="aside">
                    <h3>Login</h3>
                    <br />
                    <form id="form1" name="loginForm" onsubmit="return validateForm();"
                          method="post" action="authenticateAction">
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
                                    <!-- 
                                    <input type="checkbox" name="enterDemographics" id="enterDemographics" />
                                     
                            <label for="enterDemographics">Let me update my demographics (only available for registered accounts)</label>
                            <p/>
                                    -->

                                    <!--                                    <input type="checkbox" name="watchTutorial" id="watchTutorial" />
                                                                        <label for="watchTutorial">Watch the introductory tutorial</label>-->

                                    <!-- 
                                    <p/>
                                            <input type="checkbox" name="html5Mode" id="html5Mode" />
                                    <label for="html5Mode">Use HTML5 (default is Flash)</label>
                                    -->
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
                <div id="footer">Copyright © DeepTutor.org, 2013</div>
            </div>
        </div>
    </body>
</html>


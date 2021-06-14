<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="dt.config.ConfigManager"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
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

<%
    ConfigManager.init(ServletActionContext.getServletContext());
    String editedTasksPath = ConfigManager.GetEditedTasksPath();
	System.out.println("The path is:" + editedTasksPath);
	File dir = new File(editedTasksPath);
	File[] f = dir.listFiles();
	String result = "";
	if (f.length > 0) {
		for (File fi : f) {
			result += "<option value=\""
					+ fi.getName().replace(".xml", "") + "\">"
					+ fi.getName() + "</option>";
		}
	}
	/*
	 String result ="";
	 if(f.length<=0){
	 result = "<br> No files are found to be edited." ;
	 }else{
	 result = "<ol>";
	 for (File fi : f) {
	 result += "<li> <a href=\""+request.getContextPath()+"/authoring?commandType=loadData&tskFileName="+fi.getName().replace(".xml", "")+"\">" + fi.getName() + "</a></li>";
	 }
	 result += "</ol>";
	 }
	
	 */
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/Styles.css" />
<script type="text/javascript" src="admin/jquery-1.7.2.js"></script>
<script type="text/javascript" src="admin/scroll-sneak.js"></script>
<script src='admin/jquery.autosize-min.js'></script>
<script type="text/javascript" src="admin/tasks.js"></script>
<script type="text/javascript">
    var currentTaskId="1";
    var misConceptionTextsCount=0;
    var expTextsCount=0;
    var hintsCount=0;
    var gwfCount = 0;
    var currentTab="${currentTabId}";
  
<c:choose>
	<c:when test="${currentTabId == 2}">
		currentTab=2;
	</c:when>
	<c:otherwise>
		currentTab=1;
	</c:otherwise>
</c:choose>
    <c:if test="${!empty t.taskID}">
		currentTaskId="${t.taskID}";
	</c:if>
    
    <c:if test="${!empty misConceptionTextsCount}">
   		misConceptionTextsCount=${misConceptionTextsCount};
	</c:if>
	
	<c:if test="${!empty expTextsCount}">
	   expTextsCount=${expTextsCount};
	</c:if>
	
	<c:if test="${!empty hintsCount}">
		hintsCount=${hintsCount};
	</c:if>  

	<c:if test="${!empty gwfCount}">
	gwfCount=${gwfCount};
	</c:if>  
   var editedTaskerViewer=<%="'" + request.getContextPath() + "/showEditedTasks'"%>;

</script>
<script src="admin/tabs.js"></script>

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
                            <td height="100px"><h1><font color="#FFFFFF">&nbsp; DeepTutor - Create a Task </font></h1></td>
                        </tr>
                    </table>
                </div>
		

		<div id="navigation">
			<ul>
				<li><a href="../DeepTutorAppReArch/dtadminHomepage">Back</a></li>
				<li><center><font color="yellow">${authoringMsg}</font></center></li>
			</ul>
		</div>
		<div id="wrapper">
			<form action="../DeepTutorAppReArch/authoring" method="get" id="authoringForm">
				<input type="hidden" name="currentTask" id="currentTask"
					value="${t.taskID}"> <input type="hidden" name="currentTab"
					id="currentTab" value="${currentTabId}"> <input
					type="hidden" name="commandType" id="commandType" value="">
				<input type="hidden" name="expIdToBeLoaded" id="expIdToBeLoaded"
					value=""> <input type="hidden" name="miscIdToBeLoaded"
					id="miscIdToBeLoaded" value="">
				<input type="hidden" name="tskFileName" id="tskFileName"
								value="${t.taskID}.xml" readonly="readonly" style="background-color:lightgray;border:none"/>
								
				<input type="submit" id="btnSwitch" name="btnSwitch"
					value="<c:if test="${!expertMode}">Switch to Expert Mode</c:if><c:if test="${expertMode}">Switch to Simple Mode</c:if>"/>
				
				<div id="tabContainer" style="background-color: #A8ABFF">
					<div style="float: right; size: 10">
					Load Existing: <select name="sel_task" id="sel_task">
									<option value="">&nbsp;&nbsp;&nbsp;&nbsp;</option>
									<%=result%>
							</select> <input type="submit" name="button6" id="btnLoad" value="Load" />
							&nbsp;&nbsp;&nbsp;<b>OR</b>&nbsp;&nbsp;&nbsp;
						<input type="submit" name="btnNewTsk" id="btnNewTsk"
							value="Create a New" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<!-- input type="submit" name="btnMakeFinal" id="btnMakeFinal"
							value="Finalize" /-->
						<input type="submit" name="button7" id="btnSave" value="Save" ${btnSaveDisabled} />&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="submit" name="btnView" id="btnView" value="View XML" />
					</div>

					<table border="0">
						<tr>
							<td width="76" height="27" align="right">Task ID:</td>
							<td width="144"><label for="tskMultimedia"></label> <input
								type="text" name="tskId" id="tskId" value="${t.taskID}" /></td>
						</tr>
						<tr>
							<td height="27" align="right">Text 1:</td>
							<td><label for="tskMultimedia"></label> <textarea
									name="tskText1" cols="60" id="tskText1">${t.problemText1}</textarea></td>
						</tr>
						<tr>
							<td height="30" align="right">Text 2:</td>
							<td><label for="misId"></label> <textarea name="tskText2"
									cols="60" id="tskText2">${t.problemText2}</textarea></td>
						</tr>
						<tr>
							<td height="27" align="right">Image:</td>
							<td valign="middle"><textarea name="tskImage" cols="60"
									rows="1" id="tskImage">${t.image}</textarea></td>
						</tr>
						<tr>
							<td height="27" align="right">Multimedia:</td>
							<td valign="middle"><textarea name="tskMultimedia" cols="60"
									rows="1" id="tskMultimedia">${t.multimedia}</textarea></td>
						</tr>
						<tr>
							<td height="27" align="right">Introduction:</td>
							<td><textarea name="tskIntroduction" cols="60"
									id="tskIntroduction">${t.introduction}</textarea></td>
						</tr>
						<tr>
							<td height="27" align="right">Summary:</td>
							<td><textarea name="tskSummary" cols="60"
									id="tskSummary"><c:choose><c:when test="${empty t.summary}">#EMPTY_SUMMARY</c:when><c:otherwise>${t.summary}</c:otherwise></c:choose>
									</textarea>
							</td>
						</tr>	
					</table>

					<br>
					<hr>
					<br>

					<div class="tabs">
						<ul >
							<li id="tabHeader_1">Expectations</li>
							<li id="tabHeader_2">Misconceptions</li>
						</ul>
					</div>
					<div class="tabscontent">
						<div class="tabpage" id="tabpage_1">
							<p>
							<table border="0">
								<tr>
									<td>&nbsp;</td>
									<td colspan="2" id="exp-keep-scroll"><c:set var="expCount" value="0" /> <c:forEach
											var="exp" items="${t.expectations}">
											<c:choose>
												<c:when test="${currentExp.id == exp.id}">
													${currentExp.id}  &nbsp;&nbsp;&nbsp; |
												</c:when>
												<c:otherwise>
													<input name="miscBtnLoadExp_${expCount}" type="submit"
														id="miscBtnLoadExp_${expCount}"
														value="&nbsp;&nbsp;&nbsp;${exp.id} &nbsp;&nbsp;&nbsp;"> |
												</c:otherwise>
											</c:choose>
											<c:set var="expCount" value="${expCount+1}" />
										</c:forEach> <input type="submit" name="newExpectation"
										id="newExpectation" value="New Expectation" /></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>[Exp,Order]:</td>
											<td colspan="3"> <c:forEach
											var="exp" items="${t.expectations}"> [${exp.id},${exp.order}]&nbsp; </c:forEach></td>
								</tr>
								<tr>
									<td colspan="4"><br>
										<hr width="80%"> <br></td>
								</tr>
								<tr>
									<td width="67" align="right">Id:</td>
									<td colspan="2" id="exp1-keep-scroll">
									  <c:choose>
										<c:when test="${currentExp.id eq ''}">
											<input type="text" name="expId" id="expId" value="" />&nbsp;&nbsp;&nbsp;&nbsp; 
											<input type="submit" name="saveExpectation"	id="saveExpectation" value="Add Expectation" />
										</c:when>
										<c:otherwise>
											<input type="text" name="expId" id="expId" value="${currentExp.id}" readonly="readonly"
												style="background-color:lightGray"/>&nbsp;&nbsp;&nbsp;&nbsp; 
											<input type="submit" name="remExpectation" id="remExpectation" value="Remove Expectation" />
										</c:otherwise>
									  </c:choose>
									</td>
									<td width="89">&nbsp;</td>
								</tr>
								<tr>
									<td align="right">Order:</td>
									<td colspan="2">
									<input
								type="text" name="expOrder" id="expOrder" value="${currentExp.order}"/></td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">Type:</td>
									<td colspan="2"><label for="Form"></label> <select
										name="expType" id="expType">
											<option value="SHORT"
												<c:if test="${currentExp.type=='SHORT'}">selected</c:if>>Short Answer</option>
											<option value="CONCRETE"
												<c:if test="${currentExp.type=='CONCRETE'}">selected</c:if>>Concrete</option>
											<option value="ABSTRACT"
												<c:if test="${currentExp.type=='ABSTRACT'}">selected</c:if>>Abstract</option>
											<option value="OPTIONAL"
												<c:if test="${currentExp.type=='OPTIONAL'}">selected</c:if>>Optional</option>
									</select></td>
									<td>&nbsp;</td>
								</tr>

								<tr>
									<td align="right">Description:</td>
									<td colspan="2"><textarea name="expDesc" cols="60"
											id="expDesc">${currentExp.description}</textarea></td>
									<td>&nbsp;</td>
								</tr>

								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">Bonus:</td>
									<td colspan="2"><textarea name="expBonus" cols="60"
											id="expBonus">${currentExp.bonus}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">Required:</td>
									<td colspan="2"><textarea name="expRequired" cols="60"
											id="expRequired">${currentExp.required.acceptedAnswer}</textarea></td>
									<td>&nbsp;</td>
								</tr>

								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">Wrong:</td>
									<td colspan="2"><textarea name="expWrong" cols="60"
											id="expWrong">${currentExp.required.wrongAnswer}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								
								<tr id="rowReqGwF_exp" <c:if test="${!expertMode}">style="display:none;"</c:if>><td>&nbsp;</td><td>&nbsp;</td><td><table style="background-color:#ddf;">
								
									<c:if test="${(fn:length(currentExp.required.goodAnswerVariants))>0}">
									  <c:forEach var="i" begin="0" end="${fn:length(currentExp.required.goodAnswerVariants)-1}" step="1"
										varStatus="status">
										<tr id="row1GwF_exp${i}">
											<td valign="top">If answer is: <textarea name="gwfText_exp${i}" cols="33" 
													id="gwfText_exp${i}">${currentExp.required.goodAnswerVariants[i]}</textarea> <input type="submit" 
													name="removeGwF_exp${i}" id="removeGwF_exp${i}" value="Remove" /></td>
											<td>&nbsp;</td>
										</tr>
									
										<tr id="row2GwF_exp${i}">
											<td>Then respond: <textarea name="gwfFeedback_exp${i}" cols="38" 
													id="gwfFeedback_exp${i}">${currentExp.required.goodFeedbackVariants[i]}</textarea><br/>&nbsp;<hr/></td>
											<td>&nbsp;</td>
										</tr>
									  </c:forEach>
									</c:if>
																	
									<tr id="rowAddGwF_exp">
										<td><input type="submit" name="addGwF_exp" id="addGwF_exp" value=" Add Good with Feedback " /></td>
									</tr>
									
								</table></td></tr>
								
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">Forbidden:</td>
									<td colspan="2"><textarea name="expForbidden" cols="60"
											id="expForbidden">${currentExp.forbidden}</textarea></td>
									<td>&nbsp;</td>
								</tr>

								<c:choose>
									<c:when test="${expTextsCount > 1}">
										<c:forEach var="i" begin="0" end="${fn:length(currentExp.variants)-1}" step="1"
											varStatus="status">
											<tr id="rowTxtExp_${i}" <c:if test="${!expertMode}">style="display:none;"</c:if>>
												<td align="right">Text:</td>
												<td colspan="2"><textarea name="expText_${i}" cols="60"
														id="expText_${i}">${currentExp.variants[i]}</textarea></td>
												<td><input type="submit" name="remBtnExpTxt_${i}"
													id="remBtnExpTxt_${i}" value="Remove" /></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr id="rowTxtExp_a1" <c:if test="${!expertMode}">style="display:none;"</c:if>>
											<td align="right">Text:</td>
											<td colspan="2"><textarea name="expText_a1" cols="60"
													id="expText_a1"></textarea></td>
											<td><input type="submit" name="remBtnExpTxt_a1"
												id="remBtnExpTxt_a1" value="Remove" /></td>
										</tr>
									</c:otherwise>
								</c:choose>

								<tr id="rowExpAddText" <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right"><input type="submit" name="expAddText"
										id="expAddText" value="Add Text" /></td>
									<td colspan="2">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								
								<tr>
									<td align="right">Assertion:</td>
									<td colspan="2"><textarea name="expAssertion" cols="60"
											id="expAssertion">${currentExp.assertion}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td align="right">Post Image:</td>
									<td colspan="2"><textarea name="expPostImg" cols="60"
											rows="1" id="expPostImg">${currentExp.postImage}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">Pump:</td>
									<td colspan="2"><textarea name="expPump" cols="60"
											id="expPump"><c:choose><c:when test="${empty currentExp.pump}">#EMPTY_PUMP</c:when><c:otherwise>${currentExp.pump}</c:otherwise></c:choose></textarea></td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">Alt. Pump:</td>
									<td colspan="2"><textarea name="expAltPump" cols="60"
											id="expAltPump">${currentExp.alternatePump}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">&nbsp;</td>
									<td colspan="2" align="left">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">Prompt:</td>
									<td colspan="2" align="left">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">&nbsp;</td>
									<td align="right">Text:</td>
									<td><textarea name="expPromptTxt" cols="50"
											id="expPromptTxt">${currentExp.prompt}</textarea>
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">&nbsp;</td>
									<td align="right">Answer:</td>
									<td><textarea name="expPromptAns" cols="50"
											id="expPromptAns">${currentExp.promptAnswer.acceptedAnswer}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">&nbsp;</td>
									<td align="right">Wrong:</td>
									<td><textarea name="expPromptWrong" cols="50"
											id="expPromptWrong">${currentExp.promptAnswer.wrongAnswer}</textarea></td>
									<td>&nbsp;</td>
								</tr>

								<tr id="rowPromptGwF_exp" <c:if test="${!expertMode}">style="display:none;"</c:if>><td>&nbsp;</td><td>&nbsp;</td><td><table style="background-color:#ddf;">
								
									<c:if test="${(fn:length(currentExp.promptAnswer.goodAnswerVariants))>0}">
									  <c:forEach var="i" begin="0" end="${fn:length(currentExp.promptAnswer.goodAnswerVariants)-1}" step="1"
										varStatus="status">
										<tr id="row1GwF_pexp${i}">
											<td valign="top">If answer is: <textarea name="gwfText_pexp${i}" cols="33" 
													id="gwfText_pexp${i}">${currentExp.promptAnswer.goodAnswerVariants[i]}</textarea> <input type="submit" 
													name="removeGwF_pexp${i}" id="removeGwF_pexp${i}" value="Remove" /></td>
											<td>&nbsp;</td>
										</tr>
									
										<tr id="row2GwF_pexp${i}">
											<td>Then respond: <textarea name="gwfFeedback_pexp${i}" cols="38" 
													id="gwfFeedback_pexp${i}">${currentExp.promptAnswer.goodFeedbackVariants[i]}</textarea><br/>&nbsp;<hr/></td>
											<td>&nbsp;</td>
										</tr>
									  </c:forEach>
									</c:if>
																	
									<tr id="rowAddGwF_pexp">
										<td><input type="submit" name="addGwF_pexp" id="addGwF_pexp" value=" Add Good with Feedback " /></td>
									</tr>
									
								</table></td></tr>
								
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">&nbsp;</td>
									<td align="right">Negative:</td>
									<td><textarea name="expPromptNeg" cols="50"
											id="expPromptNeg">${currentExp.promptCorrection}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">&nbsp;</td>
									<td colspan="2">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>

								<c:choose>
									<c:when test="${hintsCount > 1}">
										<c:forEach var="i" begin="0" end="${hintsCount-2}" step="1"
											varStatus="status">
											<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
												<td align="right">&nbsp;</td>
												<td colspan="3" align="right">&nbsp;</td>
											</tr>
											<tr id="row1Hint_${i}" <c:if test="${!expertMode}">style="display:none;"</c:if>>
												<td align="right">Hint:</td>
												<td colspan="2" align="left">&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											<tr id="row2Hint_${i}" <c:if test="${!expertMode}">style="display:none;"</c:if>>
												<td align="right">&nbsp;</td>
												<td align="right">Type:</td>
												<td><select name="expHintType_${i}"
													id="expHintType_${i}">
														<option value="conditional" <c:if test="${currentExp.hintsType[i]=='conditional'}">selected</c:if>>Conditional</option>
														<option value="final" <c:if test="${currentExp.hintsType[i]=='final'}">selected</c:if>>Final</option>
														<option value="sequence" <c:if test="${currentExp.hintsType[i]=='sequence'}">selected</c:if>>Sequence</option>
												</select></td>
												<td><input type="submit" name="expRemHint_${i}"
													id="expRemHint_${i}" value="Remove Hint" /></td>
											</tr>
											<tr id="row3Hint_${i}" <c:if test="${!expertMode}">style="display:none;"</c:if>>
												<td align="right">&nbsp;</td>
												<td align="right">Text:</td>
												<td><textarea name="expHintText_${i}" cols="50"
														id="expHintText_2">${currentExp.hints[i]}</textarea></td>
												<td>&nbsp;</td>
											</tr>
											<tr id="row4Hint_${i}" <c:if test="${!expertMode}">style="display:none;"</c:if>>
												<td align="right">&nbsp;</td>
												<td align="right">Answer:</td>
												<td><textarea name="expHintAns_${i}" cols="50"
														id="expHintAns_${i}">${currentExp.hintsAnswer[i].acceptedAnswer}</textarea></td>
												<td>&nbsp;</td>
											</tr>
											<tr id="row5Hint_${i}" <c:if test="${!expertMode}">style="display:none;"</c:if>>
												<td align="right">&nbsp;</td>
												<td align="right">Wrong:</td>
												<td><textarea name="expHintWrong_${i}" cols="50"
														id="expHintWrong_${i}">${currentExp.hintsAnswer[i].wrongAnswer}</textarea></td>
												<td>&nbsp;</td>
											</tr>
											
											<tr id="rowHintGwF_${i}" <c:if test="${!expertMode}">style="display:none;"</c:if>><td>&nbsp;</td><td>&nbsp;</td><td><table style="background-color:#ddf;">
											
												<c:if test="${(fn:length(currentExp.hintsAnswer[i].goodAnswerVariants))>0}">
												  <c:forEach var="j" begin="0" end="${fn:length(currentExp.hintsAnswer[i].goodAnswerVariants)-1}" step="1"
													varStatus="status">
													<tr id="row1GwF_H${i}I${j}">
														<td valign="top">If answer is: <textarea name="gwfText_H${i}I${j}" cols="35" 
																id="gwfText_H${i}I${j}">${currentExp.hintsAnswer[i].goodAnswerVariants[j]}</textarea> <input type="submit" 
																name="removeGwF_H${i}I${j}" id="removeGwF_H${i}I${j}" value="Remove" /></td>
														<td>&nbsp;</td>
													</tr>
												
													<tr id="row2GwF_H${i}I${j}">
														<td>Then respond: <textarea name="gwfFeedback_H${i}I${j}" cols="40" 
																id="gwfFeedback_H${i}I${j}">${currentExp.hintsAnswer[i].goodFeedbackVariants[j]}</textarea><br/>&nbsp;<hr/></td>
														<td>&nbsp;</td>
													</tr>
												  </c:forEach>
												</c:if>
																				
												<tr id="rowAddGwF_${i}">
													<td><input type="submit" name="addGwF_${i}" id="addGwF_${i}" value=" Add Good with Feedback " /></td>
												</tr>
												
											</table></td></tr>
											
											<tr id="row6Hint_${i}" <c:if test="${!expertMode}">style="display:none;"</c:if>>
												<td align="right">&nbsp;</td>
												<td align="right">Negative:</td>
												<td><textarea name="expHintNeg_${i}" cols="50"
														id="expHintNeg_2">${currentExp.hintsCorrection[i]} </textarea></td>
												<td>&nbsp;</td>
											</tr>
											<tr id="row7Hint_${i}" <c:if test="${!expertMode}">style="display:none;"</c:if>>
												<td align="right">&nbsp;</td>
												<td colspan="3" align="right">&nbsp;</td>
											</tr>

										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr id="row1Hint_a1" <c:if test="${!expertMode}">style="display:none;"</c:if>>
											<td align="right">Hint:</td>
											<td colspan="2" align="left">&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr id="row2Hint_a1" <c:if test="${!expertMode}">style="display:none;"</c:if>>
											<td align="right">&nbsp;</td>
											<td width="44" align="right">Type:</td>
											<td width="363"><select name="expHintType_a1"
												id="expHintType_1">
													<option value="conditional">Conditional</option>
													<option value="final">Final</option>
													<option value="sequence">Sequence</option>
											</select></td>
											<td><input type="submit" name="expRemHint_a1"
												id="expRemHint_a1" value="Remove Hint" /></td>
										</tr>
										<tr id="row3Hint_a1" <c:if test="${!expertMode}">style="display:none;"</c:if>>
											<td align="right">&nbsp;</td>
											<td align="right">Text:</td>
											<td><textarea name="expHintText_a1" cols="50"
													id="expHintText_1"></textarea></td>
											<td>&nbsp;</td>
										</tr>
										<tr id="row4Hint_a1" <c:if test="${!expertMode}">style="display:none;"</c:if>>
											<td align="right">&nbsp;</td>
											<td align="right">Answer:</td>
											<td><textarea name="expHintAns_a1" cols="50"
													id="expHintAns_1"></textarea></td>
											<td>&nbsp;</td>
										</tr>
										<tr id="row5Hint_a1" <c:if test="${!expertMode}">style="display:none;"</c:if>>
											<td align="right">&nbsp;</td>
											<td align="right">Wrong:</td>
											<td><textarea name="expHintWrong_a1" cols="50"
													id="expHintWrong_1"></textarea></td>
											<td>&nbsp;</td>
										</tr>
										
										<tr id="rowHintGwF_a1" <c:if test="${!expertMode}">style="display:none;"</c:if>>
											<td>&nbsp;</td><td>&nbsp;</td><td><table style="background-color:#ddf;">
												<tr id="rowAddGwF_a1">
												<td><input type="submit" name="addGwF_a1" id="addGwF_a1" value=" Add Good with Feedback " /></td>
										</tr></table></td></tr>
										
										<tr id="row6Hint_a1" <c:if test="${!expertMode}">style="display:none;"</c:if>>
											<td align="right">&nbsp;</td>
											<td align="right">Negative:</td>
											<td><textarea name="expHintNeg_a1" cols="50"
													id="expHintNeg_1"></textarea></td>
											<td>&nbsp;</td>
										</tr>
										<tr id="row7Hint_a1" <c:if test="${!expertMode}">style="display:none;"</c:if>>
											<td align="right">&nbsp;</td>
											<td colspan="3" align="right">&nbsp;</td>
										</tr>
									</c:otherwise>
								</c:choose>

								<tr id="rowAddHint" <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right"><input type="submit" name="addHint"
										id="addHint" value="Add Hint" /></td>
									<td align="right">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td align="right">&nbsp;</td>
									<td align="right">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>
						</div>
						<div class="tabpage" id="tabpage_2">
							<p>
							<table border="0">
								<tr>
									<td>&nbsp;</td>
									<td id="misc-keep-scroll"><c:set var="miscCount" value="0" /> <c:forEach
											var="misc" items="${t.misconceptions}">
											<c:choose>
												<c:when test="${currentMisc.id == misc.id}">
													${currentMisc.id}  &nbsp;&nbsp;&nbsp; |
												</c:when>
												<c:otherwise>
													<input name="miscBtnLoadMisc_${miscCount}" type="submit"
														id="miscBtnLoadMisc_${miscCount}"
														value="&nbsp;&nbsp;&nbsp;${misc.id} &nbsp;&nbsp;&nbsp;"> |
												</c:otherwise>
											</c:choose>
											<c:set var="miscCount" value="${miscCount+1}" />
										</c:forEach> <input type="submit" name="newBtnMisc" id="newBtnMisc"
										value="New Misconception" /></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td colspan="3"><br>
										<hr width="80%"> <br></td>
								</tr>
								<tr>
									<td>Id:</td>
									<td id="misc1-keep-scroll"><c:choose>
										<c:when test="${currentMisc.id eq ''}">
											<input type="text" name="miscid" id="miscid" value="" />&nbsp;&nbsp;&nbsp; 
											<input type="submit" name="addBtnMisc" id="addBtnMisc" value="Add Misconception" />
										</c:when>
										<c:otherwise>
											<input type="text" name="miscid" id="miscid" value="${currentMisc.id}" readonly="readonly"
												style="background-color:lightGray"/>&nbsp;&nbsp;&nbsp; 
											<input type="submit" name="remMisc" id="remMisc" value="Remove Misconception" />
										</c:otherwise>
									</c:choose></td>
									<td>&nbsp;</td>
								</tr>
								<c:choose>
									<c:when test="${misConceptionTextsCount > 1}">
										<c:forEach var="i" begin="0"
											end="${misConceptionTextsCount-2}" step="1"
											varStatus="status">
											<tr id="rowTxtMisc_${i}">
												<td>Text:</td>
												<td><textarea name="txtMiscText_${i}" cols="60"
														id="txtMiscText_${i}">${currentMisc.variants[i]}</textarea></td>
												<td><input type="submit" name="remBtnExpTxt_${i}"
													id="remBtnMiscTxt_${i}" value="Remove" /></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr id="rowTxtMisc_a1">
											<td height="21">Text:</td>
											<td><label for="Form"> <textarea id="txtMiscText_a1"
														name="txtMiscText_a1" cols="60"></textarea>
											</label></td>
											<td><input type="submit" name="remBtnMisc_a1"
												id="remBtnMisc_a1" value="Remove" /></td>
										</tr>
									</c:otherwise>
								</c:choose>



								<tr id="idMiscAddTxt">
									<td><input type="submit" name="btnAddMiscTxt"
										id="btnAddMiscTxt" value="Add Text" /><br></td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>Correction:</td>
									<td><textarea name="txtMiscAssert" cols="60" id="tskId19">${currentMisc.assertion}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td>Pump:</td>
									<td><textarea name="txtMiscBump" cols="60" id="tskId20">${currentMisc.pump}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td>Bonus:</td>
									<td><textarea name="txtMiscBonus" cols="60" id="tskId21">${currentMisc.bonus}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td>Required:</td>
									<td><textarea name="txtMiscReqd" cols="60" id="tskId4">${currentMisc.required.acceptedAnswer}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td>Forbidden:</td>
									<td><textarea name="txtMiscForbidden" cols="60"
											id="tskId7">${currentMisc.forbidden}</textarea></td>
									<td>&nbsp;</td>
								</tr>
								<tr <c:if test="${!expertMode}">style="display:none;"</c:if>>
									<td>Yoked Expectation:</td>
									<td><textarea name="txtMiscYoked" cols="60"	id="tskId8">${currentMisc.yokedExpectation}</textarea></td>
									<td>&nbsp;</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</form>
		</div>
		<div id="footer">Copyright © DeepTutor.org, 2013</div>
	</div>

<!-- SCROLL SNEAK JS: you can change `location.hostname` to any unique string or leave it as is -->
<script>
(function() {
    var sneaky = new ScrollSneak(location.hostname), tabs = document.getElementById('exp-keep-scroll').getElementsByTagName('input'), i = 0, len = tabs.length;
    for (; i < len; i++) {
        tabs[i].onclick = sneaky.sneak;
    }

    tabs = document.getElementById('misc-keep-scroll').getElementsByTagName('input'); i = 0; len = tabs.length;
    for (; i < len; i++) {
        tabs[i].onclick = sneaky.sneak;
    }
    document.getElementById('misc1-keep-scroll').getElementsByTagName('input')[0].onclick = sneaky.sneak;
    document.getElementById('exp1-keep-scroll').getElementsByTagName('input')[0].onclick = sneaky.sneak;
    
})();
</script>
<!-- END OF SCROLL SNEAK JS -->


</body>
</html>

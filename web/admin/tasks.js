//Nobal likes this site: http://jsfiddle.net/PzSYM/36/
//where you can check your program easily wow, nice!

//var myCounters=1;
// <![CDATA[
$(document).ready(function() {

	$('textarea').autosize();  
	
	// Counter example
	$("#txtMisc1").click(function() {
		alert("Hello world! " + myCounters);
		myCounters++;
		$("#rowToRem").remove();
	});

	/*
	 * //Submit button click event. Works except for dynamically added buttons
	 * $('input[type="submit"]').click( function(event){
	 * process_form_submission(event); } );
	 */

	// Great code. works even for dynamically added buttons
	$('input[type="submit"]').live("click", function(event) {
		var which_button = event.currentTarget.id;
		// var which_button = $(this).attr("id");
		process_form_submission(event);
		return false;
	});

});

function process_form_submission(event) {
	event.preventDefault();
	// var target = $(event.target);
	var input = $(event.currentTarget);
	var which_button = event.currentTarget.id;
	// var data = input.parents("form")[0].data.value;
	// var which_button = '?'; // <-- this is what I want to know
	// alert( 'data: ' + data + ', button: ' + which_button );
	// $("#rowToRem").remove();

	// When Remove task butten is pressed in Misconception tab
	// remBtnMisc1_3
	if (which_button.substring(0, 10) == 'remBtnMisc') {
		removeMisconceptionText(which_button);
	}

	else if (which_button == 'btnAddMiscTxt') {
		addMisconceptionText(which_button);
	} else if (which_button == 'btnSave') {
		saveData();
	}else if (which_button == 'btnView') {
		viewData();
	} else if (which_button == 'btnLoad') {
		loadData(which_button);
	} else if (which_button == 'btnSwitch') {
		$("#commandType").val("switchMode");
		submitForm();
	}
	
	else if (which_button == 'expAddText') {
		addExpectationText(which_button);
	}

	else if (which_button.substring(0, 12) == 'remBtnExpTxt') {
		removeExpectationText(which_button);
	}

	else if (which_button == 'addHint') {
		addHint(which_button);
	} else if (which_button.substring(0, 10) == 'expRemHint') {
		removeHint(which_button);
	}

	else if (which_button.substring(0, 6) == 'addGwF') {
		addGwF(which_button);
	}
	else if (which_button.substring(0, 9) == 'removeGwF') {
		removeGwF(which_button);
	}

	if (which_button == 'newExpectation') {
		newExpectation(which_button);
	} else if (which_button == 'saveExpectation') {
		addExpectation(which_button);
	} else if (which_button == 'remExpectation') {
		remExpectation(which_button);
	} else if (which_button == 'remMisc') {
		remMisconception(which_button);
	} else if (which_button == 'addBtnMisc') {
		addMisconception(which_button);
	} else if (which_button == 'newBtnMisc') {
		newMisconception(which_button);
	} else if (which_button.substring(0, 15) == 'miscBtnLoadMisc') {
		loadMisconception(which_button);
	} else if (which_button.substring(0, 14) == 'miscBtnLoadExp') {
		loadExpectation(which_button);
	} else if (which_button == 'btnNewTsk') {
		createNewTask(which_button);
	}

}

// miscBtnLoadMisc_1
// miscBtnLoadExp_2

function loadMisconception(buttonId) {
	$("#commandType").val("loadMisconception");
	var subStrs = buttonId.split("_");
	var IdToBeLoaded = subStrs[1];
	$("#miscIdToBeLoaded").val(IdToBeLoaded);
	submitForm();
}
function loadExpectation(buttonId) {
	$("#commandType").val("loadExpectation");
	var subStrs = buttonId.split("_");
	var IdToBeLoaded = subStrs[1];
	$("#expIdToBeLoaded").val(IdToBeLoaded);
	submitForm();
}

function addMisconception(buttonId) {
	if ($.trim($("#miscid").val())=='')
	{
		alert("Please fill in the Id first.");
		return;
	}

	if ($.trim($('[name^="txtMiscText_"]').val())=='')
	{
		alert("You must define at least one text for the misconception.");
		return;
	}

	var found = false;
	var i = 0;
	while ($("#miscBtnLoadMisc_"+i).length)
	{
		if ($.trim($("#miscBtnLoadMisc_"+i).val()) == $.trim($("#miscid").val()))	found = true;
		i++;
	}
	
	if (found) alert("A misconception with the same ID already exists.");
	else
	{
		$("#commandType").val("addMisconception");
		submitForm();
	}
}

function newMisconception(buttonId) {
	$("#commandType").val("newMisconception");
	submitForm();
}

function remMisconception(buttonId) {
	var choice = confirm("Press press OK to DELETE this Misconception.");
	if (choice) {
		$("#commandType").val("remMisconception");
		submitForm();
	} else {
		return false;
	}
}

function addExpectation(buttonId) {
	if ($.trim($("#expId").val())==''){
		alert("Please fill in the Id first.");
		return;
	}
	
	if ($.trim($("#expAssertion").val())=='')
	{
		alert("You must define the assertion for the expectation.");
		return;
	}
	
	if ($.trim($("#expPromptTxt").val())!="" && $.trim($("#expPromptAns").val())=="")
	{
		alert("If you have a prompt, then you must also define an answer for it.");
		return;
	}
	
	else{
		var found = false;
		var i = 0;
		while ($("#miscBtnLoadExp_"+i).length)
		{
			if ($.trim($("#miscBtnLoadExp_"+i).val()) == $.trim($("#expId").val()))	found = true;
			i++;
		}
		
		if (found) alert("An expectation with the same ID already exists.");
		else
		{
			$("#commandType").val("addExpectation");
			submitForm();
		}
	}
}

function newExpectation(buttonId) {
	$("#commandType").val("newExpectation");
	submitForm();
}

function remExpectation(buttonId) {
	var choice = confirm("Press press OK to DELETE this Expectation.");
	if (choice) {
		$("#commandType").val("remExpectation");
		submitForm();
	} else {
		return false;
	}
}

function removeExpectationText(buttonId) {
	var subStrs = buttonId.split("_");
	var rowIdToBeRemoved = subStrs[1];
	// currentTaskId variable is initialized in tasks.jsp
	var tblRowID = "rowTxtExp" + "_" + rowIdToBeRemoved; // rowTxtExp1_2
	$("#" + tblRowID).remove();
}

function addExpectationText(buttonId) {
	// currentTaskId variable is initialized in tasks.jsp
	var taskPlusCounter = "_" + expTextsCount;
	var newRowId = "rowTxtExp" + taskPlusCounter;
	var newTextAreaId = "expText" + taskPlusCounter;
	var newRemoveBtnId = "remBtnExpTxt" + taskPlusCounter;

	var aNewTextRow = '<tr  id="' + newRowId
			+ '"><td align="right">Text:</td><td colspan="2"><textarea name="'
			+ newTextAreaId + '" cols="60" id="' + newTextAreaId
			+ '"></textarea></td><td><input type="submit" name="'
			+ newRemoveBtnId + '" id="' + newRemoveBtnId
			+ '" value="Remove" /></td></tr>"';

	$("#rowExpAddText").before(aNewTextRow);
	expTextsCount++;
}

function saveData() {
	var taskId = $.trim($("#tskId").val());
	if (taskId.length > 0) {
		var choice = confirm("Confirm Save");
		if (choice) {
			$("#commandType").val("saveData");
			submitForm();
		}
	}
	else{
		alert("The task must have an ID before you can save it.");
	}
}

function viewData() {
    console.log("Viewing xml data")
	var taskId = $.trim($("#currentTask").val());
	if (taskId.length == 0) alert("You must save current task before you can view it.");
	else{
		window.open('../DeepTutorAppReArch/DTResources/EditedTasks/' + taskId + ".xml"); 
	}
}

function loadData(which_button) {
	var selectedFile = $("#sel_task").val();
	if (selectedFile.length > 0) {
		var r = confirm("Are you sure want to load " + selectedFile + ".xml ?");
		if (r == true) {
			$("#commandType").val("loadData");
			$("#tskFileName").val(selectedFile);
			submitForm();
		}
	} else {
		alert("There is no task to load!");
	}

}

function removeMisconceptionText(buttonId) {
	var subStrs = buttonId.split("_");
	var rowIdToBeRemoved = subStrs[1];
	// currentTaskId variable is initialized in tasks.jsp
	var tblRowID = "rowTxtMisc" + "_" + rowIdToBeRemoved; // rowTxtMisc1_2
	$("#" + tblRowID).remove();
}

function addMisconceptionText(buttonId) {
	// currentTaskId variable is initialized in tasks.jsp
	var taskPlusCounter = "_" + misConceptionTextsCount;
	var newRowId = "rowTxtMisc" + taskPlusCounter;
	var newTextAreaId = "txtMiscText" + taskPlusCounter;
	var newRemoveBtnId = "remBtnMisc" + taskPlusCounter;
	var aNewTextRow = '<tr id="' + newRowId
			+ '"> <td>Text:</td><td><textarea name="' + newTextAreaId
			+ '" cols="60" id="' + newTextAreaId
			+ '"></textarea></td><td><input type="submit" name="'
			+ newRemoveBtnId + '" id="' + newRemoveBtnId
			+ '" value="Remove" /></td> </tr>';
	$("#idMiscAddTxt").before(aNewTextRow);
	misConceptionTextsCount++;
}

function addHint(buttonId) {

	var hintId = "" + hintsCount;
	
	var HintRow1 = '<tr id="row1Hint_'
			+ hintId
			+ '"><td align="right">Hint:</td><td colspan="2" align="left">&nbsp;</td><td>&nbsp;</td></tr>';

	var HintRow2 = '<tr id="row2Hint_'
			+ hintId
			+ '"><td align="right">&nbsp;</td><td width="44" align="right">Type:</td> <td width="363"><select name="expHintType_'
			+ hintId
			+ '" id="expHintType_'
			+ hintId
			+ '"><option>Conditional</option><option>Final</option><option>Sequence</option></select></td><td><input type="submit" name="expRemHint_'
			+ hintId + '" id="expRemHint_' + hintId
			+ '" value="Remove Hint" /></td></tr>';

	var HintRow3 = '<tr id="row3Hint_'
			+ hintId
			+ '"><td align="right">&nbsp;</td><td align="right">Text:</td><td><textarea name="expHintText_'
			+ hintId + '" cols="50" id="expHintText_' + hintId
			+ '"></textarea></td><td>&nbsp;</td></tr>';

	var HintRow4 = '<tr  id="row4Hint_'
			+ hintId
			+ '"><td align="right">&nbsp;</td><td align="right">Answer:</td><td><textarea name="expHintAns_'
			+ hintId
			+ '" cols="50" id="expHintAns_1"></textarea></td><td>&nbsp;</td></tr>';

	var HintRow5 = '<tr  id="row5Hint_'
		+ hintId
		+ '"><td align="right">&nbsp;</td><td align="right">Wrong:</td><td><textarea name="expHintWrong_'
		+ hintId
		+ '" cols="50" id="expHintWrong_1"></textarea></td><td>&nbsp;</td></tr>';

	var HintRowGwF = '<tr id="rowHintGwF_' + hintId 
		+ '"><td>&nbsp;</td><td>&nbsp;</td><td><table style="background-color:#ddf;"><tr id="rowAddGwF_'+hintId+'">'
		+ '<td><input type="submit" name="addGwF_'+hintId+'" id="addGwF_'
		+ hintId+'" value=" Add Good with Feedback " /></td></tr></table></td></tr>';

	var HintRow6 = '<tr  id="row5Hint_' + hintId
			+ '"><td align="right">&nbsp;</td><td align="right">Negative: </td><td><textarea name="expHintNeg_'
			+ hintId + '" cols="50" id="expHintNeg_' + hintId
			+ '"></textarea></td><td>&nbsp;</td></tr>';

	var HintRow7 = ' <td align="right">&nbsp;</td><td align="right">&nbsp;</td><td align="right">&nbsp;</td><td align="right">&nbsp;</td>';

	$("#rowAddHint").before(HintRow1);
	$("#rowAddHint").before(HintRow2);
	$("#rowAddHint").before(HintRow3);
	$("#rowAddHint").before(HintRow4);
	$("#rowAddHint").before(HintRow5);
	$("#rowAddHint").before(HintRowGwF);
	$("#rowAddHint").before(HintRow6);
	$("#rowAddHint").before(HintRow7);

	hintsCount++;

}

function removeHint(buttonId) {
	var subStrs = buttonId.split("_");
	var hintId = subStrs[1];

	var tblRowID1 = "row1Hint" + "_" + hintId;
	var tblRowID2 = "row2Hint" + "_" + hintId;
	var tblRowID3 = "row3Hint" + "_" + hintId;
	var tblRowID4 = "row4Hint" + "_" + hintId;
	var tblRowID5 = "row5Hint" + "_" + hintId;
	var tblRowID6 = "row6Hint" + "_" + hintId;
	var tblRowID7 = "row7Hint" + "_" + hintId;
	var tblRowGwF = "rowHintGwF" + "_" + hintId;

	$("#" + tblRowID1).remove();
	$("#" + tblRowID2).remove();
	$("#" + tblRowID3).remove();
	$("#" + tblRowID4).remove();
	$("#" + tblRowGwF).remove();
	$("#" + tblRowID5).remove();
	$("#" + tblRowID6).remove();
	$("#" + tblRowID7).remove();
}


function addGwF(buttonId) {

	var subStrs = buttonId.split("_");
	var hintId = subStrs[1];
	
	var gwfId = "" + gwfCount;
	
	var gwfRow1 = '<tr id="row1GwF_' + gwfId
			+ '"><td valign="top">If answer is: <textarea name="gwfText_'+ hintId + "_" + gwfId + '" cols="33" id="gwfText_' 
			+ hintId + "_" + gwfId 
			+ '"></textarea> <input type="submit" name="removeGwF_' + gwfId + '" id="removeGwF_' + gwfId
			+ '" value="Remove" /></td><td>&nbsp;</td></tr>';

	var gwfRow2 = '<tr id="row2GwF_' + gwfId
	+ '"><td>Then respond: <textarea name="gwfFeedback_' + hintId + "_" + gwfId + '" cols="38" id="gwfFeedback_' 
	+ hintId + "_" + gwfId
	+ '"></textarea><br/>&nbsp;<hr/></td><td>&nbsp;</td></tr>';

	$("#rowAddGwF_"+hintId).before(gwfRow1);
	$("#rowAddGwF_"+hintId).before(gwfRow2);

	gwfCount++;

}

function removeGwF(buttonId)
{
	var subStrs = buttonId.split("_");
	var gwfId = subStrs[1];
	
	var tblRowID1 = "row1GwF" + "_" + gwfId;
	var tblRowID2 = "row2GwF" + "_" + gwfId;

	$("#" + tblRowID1).remove();
	$("#" + tblRowID2).remove();
}

function createNewTask(buttonId) {
	var choice = confirm("Have you saved existing task and want to create a new task ?");
	if (choice) {
		$("#commandType").val("createNewTask");
		submitForm();
	} else {
		return false;
	}

}

function submitForm() {
	$("#currentTab").val(currentTab);
	$("#authoringForm").submit();
}

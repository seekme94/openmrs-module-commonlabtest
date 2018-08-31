<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<openmrs:require privilege="View labTestResult" otherwise="/login.htm" redirect="/module/commonlabtest/addLabTestResult.form" />

<link type="text/css" rel="stylesheet"
	href="/openmrs/moduleResources/commonlabtest/css/commonlabtest.css" />
<link
	href="/openmrs/moduleResources/commonlabtest/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" />
<link
	href="/openmrs/moduleResources/commonlabtest/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="/openmrs/moduleResources/commonlabtest/css/dataTables.bootstrap4.min.css"
	rel="stylesheet" />
<link type="text/css" rel="stylesheet"
	href="/openmrs/moduleResources/commonlabtest/css/hover.css" />
<link type="text/css" rel="stylesheet"
	href="/openmrs/moduleResources/commonlabtest/css/hover-min.css" />

	

 <style>
body {
	font-size: 12px;
}
hr.style-three {
	height: 30px;
	border-style: solid;
	border-color: black;
	border-width: 1px 0 0 0;
	border-radius: 20px;
}
hr.style-three:before {
	display: block;
	content: "";
	height: 30px;
	margin-top: -31px;
	border-style: solid;
	border-color: black;
	border-width: 0 0 1px 0;
	border-radius: 20px;
}
input[type=submit] {
	background-color: #1aac9b;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	
}
input[type=button] {
	background-color: #1aac9b;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	
}

#saveUpdateButton {
    text-align: center;
}
fieldset.scheduler-border {
    border: 1px groove #ddd !important;
    padding: 0 1.4em 1.4em 1.4em !important;
    margin: 0 0 1.5em 0 !important;
    -webkit-box-shadow:  0px 0px 0px 0px #1aac9b;
             box-shadow: 0px 0px 14px 0px #1aac9b61;
}

legend.scheduler-border {
        font-size: 1.2em !important;
        font-weight: bold !important;
        text-align: left !important;
        width:auto;
        padding:0 10px;
        border-bottom:none;
    }
 .row{
     margin-bottom:15px;
 
 }


</style>

<body>
	
<div class="container"> 

	 <fieldset  class="scheduler-border" >
		<legend  class="scheduler-border"><spring:message code="commonlabtest.result.add" /></legend>
		   <div id="resultContainer">
		   
		   </div> 
		
	 </fieldset>
 </div>

</body>

<!--JAVA SCRIPT  -->
<script
	src="${pageContext.request.contextPath}/moduleResources/commonlabtest/bootstrap/js/jquery-3.3.1.min.js"></script>
<script
	src="${pageContext.request.contextPath}/moduleResources/commonlabtest/bootstrap/js/popper.min.js"></script>
<script
	src="${pageContext.request.contextPath}/moduleResources/commonlabtest/bootstrap/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/moduleResources/commonlabtest/js/jquery-ui.min.js"></script>
<script
	src="${pageContext.request.contextPath}/moduleResources/commonlabtest/js/jquery.dataTables.min.js"></script>
<script
	src="${pageContext.request.contextPath}/moduleResources/commonlabtest/js/dataTables.bootstrap4.min.js"></script>


<script type="text/javascript">
var local_source;
var testOrder ;
var update;
var filepath ="";

var testTypeName="";
$(document).ready(function () {
	local_source = getAttributeTypes();
	testOrder = ${testOrderId};
	testTypeName = '${testTypeName}';
	filepath = '${filepath}';
     update ='${update}'
	if(local_source.length > 0){
		 populateResultForm();
	}	
	

});

//get all concepts
function getAttributeTypes(){
   	return JSON.parse(JSON.stringify(${attributeTypeList}));
   }
//get all concepts
function getTestOrderId(){
   	return ${testOrderId};
   }
function navigatedToPatientDashboard(){
	  window.location.href ="${pageContext.request.contextPath}/patientDashboard.form?patientId=${patientId}";  
}
   
   function populateResultForm(){
	   
     var resultsItems ="";
  
     resultsItems = resultsItems.concat('<form method="post" id="entryForm" action="${pageContext.request.contextPath}/module/commonlabtest/addLabTestResult.form" enctype="multipart/form-data">');
     resultsItems = resultsItems.concat('<input hidden="true" id="testOrderId" name ="testOrderId" value="'+testOrder+'" />');  
     resultsItems = resultsItems.concat('<center><h4>'+testTypeName+'</h4></center><hr class="style-three">');   
     resultsItems = resultsItems.concat('<input  hidden="true" id="update" name ="update" value="'+update+'" />'); 

     jQuery(local_source).each(function() {
    	   
    	    if(this.testAttributeId != 'undefined')
    	    	{
                 resultsItems = resultsItems.concat('<input  hidden="true" id="testAttributeId.'+this.id+'" name ="testAttributeId.'+this.id+'" value="'+this.testAttributeId+'" />'); 
    	    	}
    	    else{
                 resultsItems = resultsItems.concat('<input  hidden="true" id="testAttributeId.'+this.id+'" name ="testAttributeId.'+this.id+'" value="" />'); 
    	      }
			 if(this.dataType == 'coded'){
				  	 resultsItems = resultsItems.concat('<div class="row"><div class="col-md-3">');
					 resultsItems = resultsItems.concat(' <label class="control-label">'+this.name+'</label>');
					 resultsItems = resultsItems.concat('</div><div class ="col-md-4">');
					 resultsItems = resultsItems.concat('<select class="form-control" id="concept.'+this.id+'" name="concept.'+this.id+'" ><options />');
					 jQuery(this.conceptOptions).each(function() {
						 if(this.value == 'undefined'){
							  resultsItems =resultsItems.concat( '<option>'+this.value+'</option>'); 
							  resultsItems =resultsItems.concat( '<option value="'+this.conceptId+'">'+this.conceptName+'</option>'); 
						 }
						 else{
							  resultsItems =resultsItems.concat( '<option value="'+this.conceptId+'">'+this.conceptName+'</option>');
						 }
					  });
					 resultsItems =resultsItems.concat('</select></div></div>');
			 }
			 else if(this.dataType == 'Text'){
					 resultsItems = resultsItems.concat('<div class="row"><div class="col-md-3">');
					 resultsItems = resultsItems.concat(' <label class="control-label">'+this.name+'</label>');
					 resultsItems = resultsItems.concat('</div><div class ="col-md-4">');
					 if(this.value == 'undefined'){
						 resultsItems = resultsItems.concat('<input class="form-control" type="text" size="100" id="valueText.'+this.id+'" name="valueText.'+this.id+'" value="" required  data-error-msg="This field cannot be empty" />');
					 }else{
						 resultsItems = resultsItems.concat('<input class="form-control" type="text" size="100" id="valueText.'+this.id+'" name="valueText.'+this.id+'" value="'+this.value+'" required  data-error-msg="This field cannot be empty" />'); 
					 }
					 resultsItems =resultsItems.concat('</div></div>');
			 }
			 else if(this.dataType == 'Numeric'){
				 
					 resultsItems = resultsItems.concat('<div class="row"><div class="col-md-3">');
					 resultsItems = resultsItems.concat(' <label class="control-label">'+this.name+'</label>');
					 resultsItems = resultsItems.concat('</div><div class ="col-md-4">');
					 resultsItems = resultsItems.concat('<input class="form-control" type="number" id="float.'+this.id+'" name="float.'+this.id+'" value="'+this.value+'" required />');
					 resultsItems =resultsItems.concat('</div></div>');
		 	}
			 else if(this.dataType == 'Boolean'){
				 
					 resultsItems = resultsItems.concat('<div class="row"><div class="col-md-3">');
					 resultsItems = resultsItems.concat('<label class="control-label">'+this.name+'</label>');
					 resultsItems = resultsItems.concat('</div><div class ="col-md-4">');
					 resultsItems = resultsItems.concat('<input type="checkbox" class="form-check-input"  value="true" checked id="bool.'+this.id+'" name="bool.'+this.id+'" onchange="setValue(this)" />');
					 resultsItems =resultsItems.concat('</div></div>');
					
		   }else if(this.dataType == 'Date'){
			     resultsItems = resultsItems.concat('<div class="row"><div class="col-md-3">');
				 resultsItems = resultsItems.concat('<label class="control-label">'+this.name+'</label>');
				 resultsItems = resultsItems.concat('</div><div class ="col-md-4">');
				 if(this.value == 'undefined'){
					 resultsItems = resultsItems.concat('<input  id="date.'+this.id+'" name="date.'+this.id+'" type="date" value="">');
				 }else{
					 resultsItems = resultsItems.concat('<input id="date.'+this.id+'" name="date.'+this.id+'" type="date" value="'+this.value+'" required>');
				 }
				 resultsItems =resultsItems.concat('</div></div>');
		   }/* else if(this.dataType == 'Datetime'){
			     resultsItems = resultsItems.concat('<div class="row"><div class="col-md-3">');
				 resultsItems = resultsItems.concat('<label class="control-label">'+this.name+'</label>');
				 resultsItems = resultsItems.concat('</div><div class ="col-md-4">');
				 if(this.value == 'undefined'){
					 resultsItems = resultsItems.concat('<input  id="datetime.'+this.id+'" name="datetime.'+this.id+'" type="datetime-local" value="">');
				 }else{
					 resultsItems = resultsItems.concat('<input id="datetime.'+this.id+'" name="datetime.'+this.id+'" type="datetime-local" value="'+this.value+'" required>');
				 }
				 resultsItems =resultsItems.concat('</div></div>');
		   } */
		  			 
	     });               
	   				 resultsItems = resultsItems.concat('<div class="row"><div class="col-md-3">');
	   				 resultsItems = resultsItems.concat('<label class="control-label">Attachment</label>');
	   				 resultsItems = resultsItems.concat('</div><div class="col-md-4">');
	   				 resultsItems = resultsItems.concat('<input type="file" name="documentTypeFile" id="documentTypeFile" accept="*image/*" />');
	   				 if(filepath != ""){
	   					 console.log("File : "+filepath);
	   					 resultsItems = resultsItems.concat('</div><div class="col-md-4">');
		   				 resultsItems = resultsItems.concat('<a style="text-decoration:none"  href="file:///'+filepath+'" target="_blank" title="Image" class="hvr-icon-grow" ><i class="fa fa-paperclip hvr-icon"></i> Attached report file</a>'); 					 
	   				 }
	   			     resultsItems = resultsItems.concat('</div></div>');
				     resultsItems = resultsItems.concat('<div class="row"><div class="col-md-2">');
				     resultsItems = resultsItems.concat('<input type="submit" value="Save Test Result" ></input>');
				     resultsItems = resultsItems.concat('</div><div class="col-md-2">');
				     resultsItems = resultsItems.concat('<input type="button" onclick="navigatedToPatientDashboard();" value="Cancel"></input>');
				     resultsItems = resultsItems.concat('</div></div></form>');

	    $("#resultContainer").append(resultsItems);
	   
   }
   function setValue(checkboxElem) {
	   $(checkboxElem).val(checkboxElem.checked ? "true" : "false");
	   
	  /*  if (checkboxElem.checked) {
	      alert ("hi");
	   } else {
	     alert ("bye");
	   } */
	 }
   
   function textValidation(textElem){
	   if($(textElem).val() == "" && $(textElem).val() == null){
		   console.log("Text Input : "+$(textElem).val()); 
	   }
	   
	  
   }
   
</script>


<%@ include file="/WEB-INF/template/footer.jsp"%>
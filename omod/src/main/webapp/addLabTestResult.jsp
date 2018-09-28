<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<openmrs:require privilege="View labTestResult" otherwise="/login.htm" redirect="/module/commonlabtest/addLabTestResult.form" />
<openmrs:portlet url="patientHeader" id="patientDashboardHeader" patientId="${patientId}"/>

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
	 
	 	<c:choose>
	         <c:when test = "${update == false}">
	         	  <legend  class="scheduler-border"><spring:message code="commonlabtest.result.add" /></legend>        
	         </c:when>
	         <c:otherwise>
	            <legend  class="scheduler-border"><spring:message code="commonlabtest.result.edit" /></legend>
	         </c:otherwise>
        </c:choose>
		   <div id="resultContainer">
		   </div> 
	</fieldset>
	<br>
	  <c:if test="${update == true}">
		 <fieldset  class="scheduler-border">
      	   <legend  class="scheduler-border"><spring:message code="commonlabtest.result.void" /></legend>
					<form method="post" action="${pageContext.request.contextPath}/module/commonlabtest/voidlabtestresult.form" >
						 <!-- UUID -->
						 <div class="row">
						   <div class="col-md-2">
								<input value="${testOrderId}" hidden="true"  id="testOrderId" name="testOrderId"></input>
								<input value="${patientId}" hidden="true"  id="patientId" name="patientId"></input>
								<label  class="control-label" path="voidReason"><spring:message code="general.reason" /><span class="required">*</span></label>
						   </div>
						   <div class="col-md-6">
						   		<input class="form-control" value="" id="voidReason" name="voidReason" required="required">
						   </div>
						 </div>
						 <!-- Retire -->
						 <div class="row">
						   <div class="col-md-2" >
						 		 <input type="submit" value="<spring:message code="commonlabtest.result.void" />"></input>
						   </div>
						 </div>
				</form>
        </fieldset>
	</c:if>
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
var resultComments="";
var patientId ;
var testTypeName="";
var fileExtensions ="";
var fileExtensionsArr =[];
var fileExtensionArray = [];
var booleanSubmitted = false;
//check for the integer 
function isNumber(event) {
	 var key = window.event ? event.keyCode : event.which;
	    if (event.keyCode === 8 || event.keyCode === 46) {
	        return true;
	    } else if ( key < 48 || key > 57 ) {
	        return false;
	    } else {
	    	return true;
	    }
}


$(document).ready(function () {
	fileExtensions = '${fileExtensions}';
	fileExtensionsArr =  JSON.stringify(fileExtensions).split(",");
	fileExtensionArray = JSON.stringify(fileExtensions).split(",");
	local_source = getAttributeTypes();
	testOrder = ${testOrderId};
	testTypeName = '${testTypeName}';
	filepath = '${filepath}';
	resultComments = '${resultComments}';
    update ='${update}';
    patientId ='${patientId}';
    
    populateResultForm();

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
  
     resultsItems = resultsItems.concat('<form method="post" id="entryForm" onsubmit="return validation()" action="${pageContext.request.contextPath}/module/commonlabtest/addLabTestResult.form" enctype="multipart/form-data">');
     resultsItems = resultsItems.concat('<input hidden="true" id="testOrderId" name ="testOrderId" value="'+testOrder+'" />');  
     resultsItems = resultsItems.concat('<input hidden="true" id="patientId" name ="patientId" value="'+patientId+'" />');
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
			 if(this.dataType == 'Coded'){
				  	 resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
					 resultsItems = resultsItems.concat(' <label class="control-label">'+this.name+'</label>');
					 resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
					 resultsItems = resultsItems.concat('<select class="form-control" id="concept.'+this.id+'" name="concept.'+this.id+'" ><options />');
					 let values = this.value;
					 jQuery(this.conceptOptions).each(function() {
						  if(values === undefined || values === 'undefined'){
							  resultsItems =resultsItems.concat( '<option value="'+this.conceptId+'">'+this.conceptName+'</option>'); 
						  }else{
							  if(values == this.conceptId)
							  	 resultsItems =resultsItems.concat( '<option  value="'+this.conceptId+'" selected >'+this.conceptName+'</option>'); 
							  else
							  	 resultsItems =resultsItems.concat( '<option value="'+this.conceptId+'">'+this.conceptName+'</option>');  
						  }
					  });
					 resultsItems =resultsItems.concat('</select></div></div>');
			 }
			 else if(this.dataType == 'Text'){
				 
					 resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
					 resultsItems = resultsItems.concat(' <label class="control-label">'+this.name+'</label>');
					 resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
					 console.log("values : "+ this.value);
					 if(this.value === undefined || this.value === 'undefined'){
							     resultsItems = resultsItems.concat('<input maxlength="255"  class="form-control" type="text"  id="valueText.'+this.id+'" name="valueText.'+this.id+'" value="" ><span id="error.'+this.id+'" class="text-danger "></span>');
							     resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
								 resultsItems = resultsItems.concat('<span id="hint.'+this.id+'" class="text-info">'+this.hint+'</span>'); 
					 }else{
							     resultsItems = resultsItems.concat('<input maxlength="255"  class="form-control" type="text"  id="valueText.'+this.id+'" name="valueText.'+this.id+'" value="'+this.value+'"  ><span id="error.'+this.id+'" class="text-danger "></span>');
							     resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
								 resultsItems = resultsItems.concat('<span id="hint.'+this.id+'" class="text-info">'+this.hint+'</span>'); 
						}
					 resultsItems =resultsItems.concat('</div></div>');
			 }
			 else if(this.dataType == 'TextArea'){
				 resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
				 resultsItems = resultsItems.concat(' <label class="control-label">'+this.name+'</label>');
				 resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
				 console.log("values txt erea : "+ this.value);
				 if(this.value === undefined || this.value === 'undefined'){
							  resultsItems = resultsItems.concat('<textarea  maxlength="512" class="form-control"  id="valueText.'+this.id+'" name="valueText.'+this.id+'" value="" /><span id="error.'+this.id+'" class="text-danger "></span>');
                              resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
							  resultsItems = resultsItems.concat('<span id="hint.'+this.id+'" class="text-info">'+this.hint+'</span>'); 
				 }else{
							  resultsItems = resultsItems.concat('<textarea   maxlength="512" class="form-control"  id="valueText.'+this.id+'" name="valueText.'+this.id+'" value="'+this.value+'" >'+this.value+'</textarea><span id="error.'+this.id+'" class="text-danger "></span>'); 
                              resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
							  resultsItems = resultsItems.concat('<span id="hint.'+this.id+'" class="text-info">'+this.hint+'</span>'); 
					
					}
				 resultsItems =resultsItems.concat('</div></div>');
			 }
			 else if(this.dataType == 'Numeric'){
				     console.log("Config : "+this.config);
					 resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
					 resultsItems = resultsItems.concat(' <label class="control-label">'+this.name+'</label>');
					 resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
					 console.log("values : "+ this.value);
					 if(this.value === 'undefined' || this.value == undefined){
								    resultsItems = resultsItems.concat('<input class="form-control" type="input"  id="float.'+this.id+'" name="float.'+this.id+'" ><span id="error.'+this.id+'" class="text-danger "></span>'); 
								    resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
								    resultsItems = resultsItems.concat('<span id="hint.'+this.id+'" class="text-info">'+this.hint+'</span>'); 
					 }
					 else{
								    resultsItems = resultsItems.concat('<input class="form-control" type="input" value ="'+this.value+'" id="float.'+this.id+'" name="float.'+this.id+'"  ><span id="error.'+this.id+'" class="text-danger "></span>');
								    resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
								    resultsItems = resultsItems.concat('<span id="hint.'+this.id+'" class="text-info">'+this.hint+'</span>'); 			
					 }
					 resultsItems =resultsItems.concat('</div></div>');
		 	}
			 else if(this.dataType == 'Boolean'){
				 
					 resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
					 resultsItems = resultsItems.concat('<label class="control-label">'+this.name+'</label>');
					 resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
					 resultsItems = resultsItems.concat('<select class="form-control" id="bool.'+this.id+'" name="bool.'+this.id+'">');
					 if(this.value == 'undefined'){
							 resultsItems = resultsItems.concat('<option value="true" selected>Yes</option>');
							 resultsItems = resultsItems.concat('<option value="false" >No</option>');
					 }else{
						 
						 if(this.value == "true"){
							  resultsItems = resultsItems.concat('<option value="true" selected>Yes</option>');
							  resultsItems = resultsItems.concat('<option value="false" >No</option>'); 
						 }else{
						      resultsItems = resultsItems.concat('<option value="true" >Yes</option>');
							  resultsItems = resultsItems.concat('<option value="false" selected >No</option>'); 
						 }	 
					 }
				 resultsItems =resultsItems.concat('</select></div></div>');
					
		   }else if(this.dataType == 'Date'){
			     var currentDate = $.datepicker.formatDate('yy-mm-dd', new Date()); 
			     var orderActivatedDate = '${encounterdate}';
			     console.log("currentDate : "+currentDate);
			     console.log("orderActivatedDate : "+orderActivatedDate);
			     resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
				 resultsItems = resultsItems.concat('<label class="control-label">'+this.name+'</label>');
				 resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
				 if(this.value == 'undefined'){
							 resultsItems = resultsItems.concat('<input  id="date.'+this.id+'"  class="form-control" name="date.'+this.id+'" type="date" value="" min="'+orderActivatedDate+'" max="'+currentDate+'" ><span id="error.'+this.id+'" class="text-danger "></span>');
				 }else{
						     resultsItems = resultsItems.concat('<input id="date.'+this.id+'"  class="form-control"  name="date.'+this.id+'" type="date" value="'+this.value+'" min="'+orderActivatedDate+'" max="'+currentDate+'" ><span id="error.'+this.id+'" class="text-danger "></span>');			
				 }
				 resultsItems =resultsItems.concat('</div></div>');
		   } 
		   else if(this.dataType == 'Regex'){
				 resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
				 resultsItems = resultsItems.concat(' <label class="control-label">'+this.name+'</label>');
				 resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
				 if(this.value === 'undefined' || this.value == undefined){
					      resultsItems = resultsItems.concat('<input class="form-control" type="text"  id="regex.'+this.id+'" name="regex.'+this.id+'" ><span id="error.'+this.id+'" class="text-danger "></span>'); 
					      resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
					      resultsItems = resultsItems.concat('<span id="hint.'+this.id+'" class="text-info">'+this.hint+'</span>'); 
				 }
				 else{
					    resultsItems = resultsItems.concat('<input class="form-control" type="text" value ="'+this.value+'" id="regex.'+this.id+'" name="regex.'+this.id+'" ><span id="error.'+this.id+'" class="text-danger "></span>'); 
					    resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
					    resultsItems = resultsItems.concat('<span id="hint.'+this.id+'" class="text-info">'+this.hint+'</span>'); 			
				 }
				 resultsItems =resultsItems.concat('</div></div>');
		   }
	     });             
				  /* resultsItems = resultsItems.concat('<div class="row"><div class="col-md-3">');
					resultsItems = resultsItems.concat('<label class="control-label">Comments</label>');
					resultsItems = resultsItems.concat('</div><div class="col-md-4">');
					  if(resultComments != ""){
						  resultsItems = resultsItems.concat('<textarea class="form-control"  maxlength="512"  name="resultComments" id="resultComments" value ="'+resultComments+'" >'+resultComments+'</textarea>');
					  }else {
						  resultsItems = resultsItems.concat('<textarea  class="form-control"  maxlength="512"  name="resultComments" id="resultComments" value ="" />'); 
					  }
					 resultsItems = resultsItems.concat('</div></div>'); */
					 if(local_source.length > 0){
		   				 resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
		   				 resultsItems = resultsItems.concat('<label class="control-label">Attachment</label>');
		   				 resultsItems = resultsItems.concat('</div><div class="col-sm-4 col-md-4 col-lg-4">');
		   				 resultsItems = resultsItems.concat('<input type="file" name="documentTypeFile" id="documentTypeFile" accept="image/*,audio/*,video/*,application/pdf,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document" />');
		   				 if(filepath != ""){
		   					 resultsItems = resultsItems.concat('</div><div class="col-sm-4 col-md-4 col-lg-4">');
			   				 resultsItems = resultsItems.concat('<a style="text-decoration:none"  href="'+filepath+'" target="_blank" title="Image" class="hvr-icon-grow" ><i class="fa fa-paperclip hvr-icon"></i> Attached report file</a>'); 					 
		   				 }
		   			     resultsItems = resultsItems.concat('</div></div>');
		   			     resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3"></div><div class="col-sm-6 col-md-6 col-lg-6">');
		   				 resultsItems = resultsItems.concat('<label class="control-label text-danger" id="documenttypefile"></label>');
		   			     resultsItems = resultsItems.concat('</div></div>');
		   			    
		   			     //extension 
		   			     resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3"></div><div class="col-sm-6 col-md-6 col-lg-6">');
		   				 resultsItems = resultsItems.concat('<label class="control-label text-danger" id="documenttypefileextension"></label>');
		   			     resultsItems = resultsItems.concat('</div></div>');
					 }else{
						    resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3"></div><div class="col-sm-6 col-md-6 col-lg-6">');
			   				resultsItems = resultsItems.concat('<label class="control-label" id=""><spring:message code="error.message.noAttributeType.found" /></label>');
			   			    resultsItems = resultsItems.concat('</div></div>'); 
					 }
	   			     //end
				     resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-2 col-md-2 col-lg-2">');
	   			     if(local_source.length > 0){
					     resultsItems = resultsItems.concat('<input type="submit" class ="btn" value="Save Test Result" id="submitBttn" ></input>');
					     resultsItems = resultsItems.concat('</div><div class="col-sm-2 col-md-2 col-lg-2">');
   						}
				     resultsItems = resultsItems.concat('<input type="button" class ="btn" onclick="navigatedToPatientDashboard();" value="Cancel"></input>');
				     resultsItems = resultsItems.concat('</div></div></form>');
			         console.log("Resultan String : "+resultsItems);
				     $("#resultContainer").append(resultsItems);
		  
				
	   
   }

   function validateBlur(ref) {
	   console.log("is called ");
	 booleanSubmitted = true;
	}
   
   function setValue(checkboxElem) {
	   $(checkboxElem).val(checkboxElem.checked ? true : false);
	 }
   
   function textValidation(textElem){
	   if($(textElem).val() == "" && $(textElem).val() == null){
		   console.log("Text Input : "+$(textElem).val()); 
	   }
   }
   function numberValidation(val){
	   alert(val);
   }  
  // var _validFileExtensions = fileExtensionArray;  //[".exe",".zip",".msi",".sql"]; 
   $(function() {
	     $("input:file").change(function (){
	    	 var fileName = $(this).val();
	    	 if (fileName.length > 0) {
                 var blnValid = false;
                 var fileExt = "."+fileName.split('.').pop();
                 console.log("include : " +fileExtensionsArr.includes(fileExt));
                 blnValid = fileExtensionsArr.includes(fileExt);
         			   document.getElementById("documenttypefile").style.display= 'none';	
         			    document.getElementById("documenttypefileextension").style.display= 'none';	  
            }
	     });
	  });
   
   function validation(){
	        console.log("is called");
		    var emptyErrorMessage ="This field cannot be empty";
    		 let isValid =true;
		    jQuery(local_source).each(function() {
		    	 var minOccurs = this.minOccurs; 
	    		 var config = this.config;
		    	  if(this.dataType == 'Text'){
		    		 let id =  "valueText."+this.id;
		    		 let errorId  = "error."+this.id;
		    		 let textVal=   document.getElementById(id).value;
			    		 if(textVal == "" && minOccurs !=0){
			    				document.getElementById(errorId).style.display= 'block';	
			    				document.getElementById(errorId).innerHTML =emptyErrorMessage;
			    			    isValid = false;
			    			    return false; //break the loop 
				    	  }else if(textVal != "" && config != "" && config != null){
			    			  let configArray = configParser(config);
			    			 // isValid = ;
			    			  if(!configValidation(errorId,textVal,configArray)){
			    				  return false; //break the loop 
			    			   }
			    	 	 }else{
				    		   document.getElementById(errorId).style.display= 'none';	
				    	 }
			    		 console.log(" text isValid : "+isValid);  
		    	  }
		    	  else if(this.dataType == 'Numeric'){
		    		  let id =  "float."+this.id;
		    		  let errorId  = "error."+this.id;
			    	  let textNumericVal=   document.getElementById(id).value;
			    		  if(textNumericVal == "" && minOccurs !=0){
			    			     document.getElementById(errorId).style.display= 'block';	
			    				 document.getElementById(errorId).innerHTML =emptyErrorMessage;
			    			    isValid = false;
			    		  }else if(textNumericVal != "" && config != "" && config != null){
			    			  let configArray = configParser(config);
			    			  isValid = configValidation(errorId,textNumericVal,configArray);
			    		  }else{
				    		   document.getElementById(errorId).style.display= 'none';	  
			    		  }
			    		  console.log(" numeric isValid : "+isValid); 
		    	  }
		    	  else if(this.dataType == 'TextArea'){
		    		  let id =  "valueText."+this.id;
		    		  let errorId  = "error."+this.id;
			    	  let textAreaVal = document.getElementById(id).value;
				    		  if(textAreaVal == "" && minOccurs !=0){
				    			      document.getElementById(errorId).style.display= 'block';	
				    				  document.getElementById(errorId).innerHTML =emptyErrorMessage;
				    			     isValid = false;
				    		  }else if(textAreaVal != "" && config != "" && config != null){
					    			  let configArray = configParser(config);
					    			  isValid = configValidation(errorId,textAreaVal,configArray);
				    		  }else{
					    		   document.getElementById(errorId).style.display= 'none';	   
				    		  }
					    console.log(" textarea isValid : "+isValid);  
		    	  }
		    	  else if(this.dataType == 'Regex'){
		    		  let id =  "regex."+this.id;
		    		  let errorId  = "error."+this.id;
			    	  let textRegexVal=   document.getElementById(id).value;
			    		  if(textRegexVal == "" && minOccurs !=0){
			    			    console.log(" regex Input field doesn't empty");
			    				document.getElementById(errorId).style.display= 'block';	
			    				document.getElementById(errorId).innerHTML ="Invalid pattern";
			    			    isValid = false;
			    		  }
			    		   else if(textRegexVal != "" && config != "" && config != null){
			    			   console.log("config is not : "+config);
			    			  let configArray = configParser(config);
			    			  isValid = configValidation(errorId,textRegexVal,configArray);
		    		      }
		    		      else{
				    		   document.getElementById(errorId).style.display= 'none';	
		    		      }
			    	console.log(" regex isValid : "+isValid);  
		    	  }else if(this.dataType == 'Date'){
		    		  let id =  "date."+this.id;
		    		  let errorId  = "error."+this.id;
		    		  let textRegexVal=   document.getElementById(id).value;
		    		  if(textRegexVal == "" && minOccurs !=0){
		    			    console.log(" regex Input field doesn't empty");
		    				document.getElementById(errorId).style.display= 'block';	
		    				document.getElementById(errorId).innerHTML = emptyErrorMessage;
		    			    isValid = false;
		    		  }else{
			    		   document.getElementById(errorId).style.display= 'none';	
	    		      }
		    		  
		    	  }
		    	
		    });
		  console.log("isValid : "+isValid);  
	   return isValid;
   }
   
   function configParser(configStr){
	   var resultConfig = [];
	   let index = configStr.indexOf("=");  //Split the type (Length ,Regex and range)and value
	   let type = configStr.substr(0, index); // Type 
	   let value = configStr.substr(index + 1);   //value 
	   resultConfig.push(type);
	   resultConfig.push(value);
	  return resultConfig; 
    }
   
   function configValidation(errorId,inputVal,configArr){
	   
	   let isValidate =true;
	   let type = configArr[0].trim();
	   let value =configArr[1];
	   console.log("Config Type : " +type );
	   console.log("Value : " +value );
	   if(value != "" && value != null ){
		   if(type === 'Length'){
			   if( inputVal.length > value){
				    console.log("Length field doesn't empty");
	   				document.getElementById(errorId).style.display= 'block';	
	   				document.getElementById(errorId).innerHTML ="Max text length not greater then "+value;
				    isValidate =false;
			   }else{
	    		   document.getElementById(errorId).style.display= 'none';	 
			   }
		   }else if(type === 'Regex'){
			  console.log("Inside Regex : "+value); 
			 let regex = new RegExp(value);   
		     if(!regex.test(inputVal)){
	    	    console.log("Regex field doesn't empty");
   				document.getElementById(errorId).style.display= 'block';	
   				document.getElementById(errorId).innerHTML ="Invalide pattern";
	    	    isValidate =false;
		     }else{
	    		   document.getElementById(errorId).style.display= 'none';	 
			   }
		   }else if(type == 'Range'){
			   let index = value.indexOf("-");
			   let startPoint = value.substr(0, index); 
			   let endPoint = value.substr(index + 1);
			   if(!betweenRange(inputVal,startPoint,endPoint)){
				    console.log("Range field doesn't empty");
	   				document.getElementById(errorId).style.display= 'block';	
	   				document.getElementById(errorId).innerHTML ="Input value does not lie in between the range "+value;
		    	    isValidate =false;
			   }else{
				   document.getElementById(errorId).style.display= 'none';	
			   }
		   }   
	   } 
		   
     return isValidate;
   }
   
   function betweenRange(x, min, max) {
	   return x >= min && x <= max;
	 }
   
   
   
</script>


<%@ include file="/WEB-INF/template/footer.jsp"%>

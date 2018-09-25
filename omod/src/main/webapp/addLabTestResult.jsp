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
	/* if(local_source.length > 0){
		
	}	 */
	

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
							 console.log("Called");
							 console.log("min : " + this.minOccurs);
		
							if(this.minOccurs == 0){
								 resultsItems = resultsItems.concat('<input class="form-control" type="text" size="100" id="valueText.'+this.id+'" name="valueText.'+this.id+'" value=""  data-error-msg="This field cannot be empty" />');<c:choose><c:when test="{this.minOccurs > 0}"> required="required"</c:when></c:choose>
							 }else{
								 resultsItems = resultsItems.concat('<input class="form-control" type="text" size="100" id="valueText.'+this.id+'" name="valueText.'+this.id+'" value=""  data-error-msg="This field cannot be empty" required />');
							 } 
					 }else{
						     console.log("min : " + this.minOccurs);
							 /*this condition for required  */
							 if(this.minOccurs == 0){
							 resultsItems = resultsItems.concat('<input class="form-control" type="text" size="100" id="valueText.'+this.id+'" name="valueText.'+this.id+'" value="'+this.value+'"  data-error-msg="This field cannot be empty" />'); 
							 }else{
								 resultsItems = resultsItems.concat('<input class="form-control" type="text" size="100" id="valueText.'+this.id+'" name="valueText.'+this.id+'" value="'+this.value+'"  data-error-msg="This field cannot be empty"  required/>');  
							 } 
						}
					
					 //this.minOccurs == 0 ? $(""+id+"").prop('required',false) : $(""+id+"").prop('required',true);
					 resultsItems =resultsItems.concat('</div></div>');
			 }
			 else if(this.dataType == 'Numeric'){
				     console.log("Config : "+this.config);
					 resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
					 resultsItems = resultsItems.concat(' <label class="control-label">'+this.name+'</label>');
					 resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
					 console.log("values : "+ this.value);
					 if(this.value === 'undefined'){
						  if(this.config === "" || this.config == null ){
								  if(this.minOccurs == 0){
									    resultsItems = resultsItems.concat('<input class="form-control" type="input"  id="float.'+this.id+'" name="float.'+this.id+'" onkeypress="return isNumber(event)"  />'); 
								   }else{
									    resultsItems = resultsItems.concat('<input class="form-control" type="input"  id="float.'+this.id+'" name="float.'+this.id+'" onkeypress="return isNumber(event)" required />'); 
								   }
							}else{
								    resultsItems = resultsItems.concat('<input class="form-control" type="input"  id="float.'+this.id+'" name="float.'+this.id+'" pattern= "'+this.config+'" title="The input is invalid" onkeypress="return isNumber(event)" required />'); 
						 } 
					 }
					 else{
							 if(this.config === "" || this.config == null ){
									 if(this.minOccurs == 0){
										    resultsItems = resultsItems.concat('<input class="form-control" type="input" value ="'+this.value+'"  id="float.'+this.id+'" name="float.'+this.id+'" onkeypress="return isNumber(event)"  />');
									  }
									  else {
										    resultsItems = resultsItems.concat('<input class="form-control" type="input" value ="'+this.value+'"  id="float.'+this.id+'" name="float.'+this.id+'" onkeypress="return isNumber(event)" required />'); 
									  }							
							}else{
								    resultsItems = resultsItems.concat('<input class="form-control" type="input" value ="'+this.value+'" id="float.'+this.id+'" name="float.'+this.id+'" pattern= "'+this.config+'" title="The input is invalid" onkeypress="return isNumber(event)" required />'); 
							 }	 			
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
			     resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
				 resultsItems = resultsItems.concat('<label class="control-label">'+this.name+'</label>');
				 resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
				 if(this.value == 'undefined'){
					  if(this.minOccurs == 0){
						
							 resultsItems = resultsItems.concat('<input  id="date.'+this.id+'" name="date.'+this.id+'" type="date" value="" >');
					  }
					  else{
							 resultsItems = resultsItems.concat('<input  id="date.'+this.id+'" name="date.'+this.id+'" type="date" value="" required >');
					  }
				 }else{
					  if(this.minOccurs == 0){
							 resultsItems = resultsItems.concat('<input id="date.'+this.id+'" name="date.'+this.id+'" type="date" value="'+this.value+'" >'); 
					  }else{
							 resultsItems = resultsItems.concat('<input id="date.'+this.id+'" name="date.'+this.id+'" type="date" value="'+this.value+'" required>');			
						}
				 }
				 resultsItems =resultsItems.concat('</div></div>');
		   } 
		   else if(this.dataType == 'Regex'){
			    console.log("Config : "+this.config);
				 resultsItems = resultsItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
				 resultsItems = resultsItems.concat(' <label class="control-label">'+this.name+'</label>');
				 resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
				 console.log("values : "+ this.value);
				 if(this.value === 'undefined' || this.value == undefined){
					      console.log("if condition und");
					      resultsItems = resultsItems.concat('<input class="form-control" type="input"  id="regex.'+this.id+'" name="regex.'+this.id+'" pattern= "'+this.config+'" title="The input is invalid"  required />'); 
					      resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
					      resultsItems = resultsItems.concat('<span id="hint.'+this.id+'" class="text-info">Hint:'+this.hint+'</span>'); 
						/*  if(this.config === "" || this.config == null ){
							    resultsItems = resultsItems.concat('<input class="form-control" type="input"  id="regex.'+this.id+'" name="regex.'+this.id+'"  required />');
						 }else{
							    resultsItems = resultsItems.concat('<input class="form-control" type="input"  id="regex.'+this.id+'" name="regex.'+this.id+'" pattern= "'+this.config+'" title="The input is invalid"  required />'); 
						 } */
				 }
				 else{
					    resultsItems = resultsItems.concat('<input class="form-control" type="input" value ="'+this.value+'" id="regex.'+this.id+'" name="regex.'+this.id+'" pattern= "'+this.config+'" title="The input is invalid"  required />'); 
					    resultsItems = resultsItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
					    resultsItems = resultsItems.concat('<span id="hint.'+this.id+'" class="text-info">Hint:'+this.hint+'</span>'); 

					 /* 
						 if(this.config === "" || this.config == null ){
							    resultsItems = resultsItems.concat('<input class="form-control" type="input" value ="'+this.value+'"  id="regex.'+this.id+'" name="regex.'+this.id+'"  required />');
						 }else{
							    resultsItems = resultsItems.concat('<input class="form-control" type="input" value ="'+this.value+'" id="regex.'+this.id+'" name="regex.'+this.id+'" pattern= "'+this.config+'" title="The input is invalid"  required />'); 
						 }	 */				
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
					     resultsItems = resultsItems.concat('<input type="submit" value="Save Test Result" id="submitBttn" ></input>');
					     resultsItems = resultsItems.concat('</div><div class="col-sm-2 col-md-2 col-lg-2">');
   						}
				     resultsItems = resultsItems.concat('<input type="button" onclick="navigatedToPatientDashboard();" value="Cancel"></input>');
				     resultsItems = resultsItems.concat('</div></div></form>');
			         console.log("Resultan String : "+resultsItems);
				     $("#resultContainer").append(resultsItems);
		  
				
	   
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
                /*  if (!blnValid) {
                	    console.log("True : "+blnValid);
         			    document.getElementById("documenttypefile").style.display= 'block';
         				document.getElementById('documenttypefile').innerHTML = "<b>"+ fileName.split('.').pop().toUpperCase()+"</b> file extension is not allowed.You can only upload files with extensions: ";
         				document.getElementById('documenttypefileextension').innerHTML = ""+fileExtensionArray.join(", ");
         			
         				$("#documentTypeFile" ).val("");
         				//document.getElementById('submitBttn').disabled = true;
                 }else if(blnValid){ */
                	  console.log("False : "+blnValid);
         			   document.getElementById("documenttypefile").style.display= 'none';	
         			  document.getElementById("documenttypefileextension").style.display= 'none';	
         			  // document.getElementById('submitBttn').disabled = false;
                 
            }
	     });
	  });
   
   function validation(){
	   
	   
	   return true;
   }
   
   
   
</script>


<%@ include file="/WEB-INF/template/footer.jsp"%>

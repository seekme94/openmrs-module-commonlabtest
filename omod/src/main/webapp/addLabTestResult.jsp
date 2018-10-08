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
	<link
			href="/openmrs/moduleResources/commonlabtest/css/style.css"
			rel="stylesheet" />	
	

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
/*Collapse  */
/* FANCY COLLAPSE PANEL STYLES */
	.fancy-collapse-panel .panel-default > .panel-heading {
	padding: 0;
	size: 12px;
	
	}
	.fancy-collapse-panel .panel-heading a {
		padding: 10px 35px 10px 15px;
		display: inline-block;
		width: 100%;
		background-color: #1aac9b;
		color: white !important;
		position: relative;
		text-decoration: none;
		font-size: 16px;
	}
	
	.fancy-collapse-panel .panel-heading a:hover {
         color: white !important;
		}
	.fancy-collapse-panel .panel-heading a:after {
		font-family: "FontAwesome";
		content: "\f147";
		position: absolute;
		right: 20px;
		font-size: 20px;
		font-weight: 400;
		top: 50%;
		line-height: 1;
		color: white;
		margin-top: -10px;
	}



/* The container */
.container-box {
    display: block;
    position: relative;
    margin-bottom: 12px;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

/* Hide the browser's default checkbox */
.container-box input {
    position: absolute;
    opacity: 0;
    cursor: pointer;
    height: 0;
    width: 0;
}

/* Create a custom checkbox */
.checkmark {
    position: absolute;
    top: 0;
    left: 0;
    height: 25px;
    width: 25px;
    background-color: #eee;
}

/* On mouse-over, add a grey background color */
.container-box:hover input ~ .checkmark {
    background-color: #ccc;
}

/* When the checkbox is checked, add a #1aac9b background */
.container-box input:checked ~ .checkmark {
    background-color: #1aac9b;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
    content: "";
    position: absolute;
    display: none;
}

/* Show the checkmark when checked */
.container-box input:checked ~ .checkmark:after {
    display: block;
}

/* Style the checkmark/indicator */
.container-box .checkmark:after {
    left: 9px;
    top: 5px;
    width: 5px;
    height: 10px;
    border: solid white;
    border-width: 0 3px 3px 0;
    -webkit-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    transform: rotate(45deg);
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
             <div class="row">
                <div class="col-md-12 col-md-offset-12 col-sm-12col-sm-offset-12">
			  	 <div id="resultContainer">
			   </div>
			   </div> 
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
var localTestGroups;
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

function getTestGrouptList(){
   	return JSON.parse(JSON.stringify(${groupList}));
   }

$(document).ready(function () {
	fileExtensions = '${fileExtensions}';
	fileExtensionsArr =  JSON.stringify(fileExtensions).split(",");
	fileExtensionArray = JSON.stringify(fileExtensions).split(",");
	local_source = getAttributeTypes();
	localTestGroups = getTestGrouptList();
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
			 resultsItems = resultsItems.concat(codedTags(this.conceptOptions,this.value,this.id,this.name));
			 }
			 else if(this.dataType == 'Text'){
				 resultsItems = resultsItems.concat(textTags(this.value,this.id,this.name,this.hint));
			 }
			 else if(this.dataType == 'TextArea'){
				 
				 resultsItems =resultsItems.concat( textAreaTags(this.value,this.id,this.name,this.hint));
			 }
			 else if(this.dataType == 'Numeric'){
				 resultsItems =resultsItems.concat( numericTags(this.value,this.name,this.id,this.hint));
		 	}
			 else if(this.dataType == 'Boolean'){
				 resultsItems = resultsItems.concat(booleanTags(this.value,this.name,this.id));
					
		   }else if(this.dataType == 'Date'){
			   resultsItems = resultsItems.concat(dateTags(this.value,this.name,this.id));			  
		   } 
		   else if(this.dataType == 'Regex'){
			   resultsItems = resultsItems.concat(regexTags(this.value,this.name,this.id,this.hint));
		   }
	     });          

				  	resultsItems = resultsItems.concat('<div class="row">');
					resultsItems = resultsItems.concat('<div class="col-md-12 col-md-offset-12 col-sm-12 col-sm-offset-12">');
					resultsItems = resultsItems.concat('<div class="fancy-collapse-panel">');
					resultsItems = resultsItems.concat('<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">'); 
					resultsItems = resultsItems.concat('<div id="panel-container"></div>'); 
					resultsItems = resultsItems.concat('</div></div></div></div>'); 
					 if(local_source.length > 0 || localTestGroups.length > 0){
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
	   			     if(local_source.length > 0 || localTestGroups.length > 0){
					     resultsItems = resultsItems.concat('<input type="submit" class ="btn" value="Save Test Result" id="submitBttn" ></input>');
					     resultsItems = resultsItems.concat('</div><div class="col-sm-2 col-md-2 col-lg-2">');
   						}
				     resultsItems = resultsItems.concat('<input type="button" class ="btn" onclick="navigatedToPatientDashboard();" value="Cancel"></input>');
				     resultsItems = resultsItems.concat('</div></div></form>');
			         console.log("Resultan String : "+resultsItems);
				     $("#resultContainer").append(resultsItems);
		   			 //Generate all teh groups;	
				     generateTestGroup();
	   
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
    		 let txtBool=true,numBool=true,regexBool=true,txtAreaBool =true,dateBool =true;
    		 
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
			    				txtBool = false;
			    			    //return false; //break the loop 
				    	  }else if(textVal != "" && config != "" && config != null){
			    			  let configArray = configParser(config);
			    			 // isValid = ;
			    			  if(!configValidation(id,errorId,textVal,configArray)){
			    				  txtBool = false;
			    				 // return false; //break the loop 
			    			   }
			    	 	 }else{
				    		   document.getElementById(errorId).style.display= 'none';	
				    	 }
			    		 console.log(" text isValid : "+txtBool);  
		    	  }
		    	  else if(this.dataType == 'Numeric'){
		    		  let id =  "float."+this.id;
		    		  let errorId  = "error."+this.id;
			    	  let textNumericVal=   document.getElementById(id).value;
			    		  if(textNumericVal == "" && minOccurs !=0){
			    			     document.getElementById(errorId).style.display= 'block';	
			    				 document.getElementById(errorId).innerHTML =emptyErrorMessage;
			    				 numBool =false;
			    				 // isValid = false;
			    		  }else if(textNumericVal != "" && config != "" && config != null){
			    			  let configArray = configParser(config);
			    			    if(!configValidation(id,errorId,textNumericVal,configArray)){
			    			    	 numBool =false;
			    			    }
			    		  }else{
				    		   document.getElementById(errorId).style.display= 'none';
				    		  
			    		  }
			    		  console.log(" numeric isValid : "+numBool); 
		    	  }
		    	  else if(this.dataType == 'TextArea'){
		    		  let id =  "valueText."+this.id;
		    		  let errorId  = "error."+this.id;
			    	  let textAreaVal = document.getElementById(id).value;
				    		  if(textAreaVal == "" && minOccurs !=0){
				    			      document.getElementById(errorId).style.display= 'block';	
				    				  document.getElementById(errorId).innerHTML =emptyErrorMessage;
				    				  txtAreaBool =false;
				    		  }else if(textAreaVal != "" && config != "" && config != null){
					    			  let configArray = configParser(config);
					    			  if(!configValidation(id,errorId,textAreaVal,configArray)){
					    				  txtAreaBool =false;
					    			  }
				    		  }else{
					    		   document.getElementById(errorId).style.display= 'none';
					  
				    		  }
					    console.log(" textarea isValid : "+txtAreaBool);  
		    	  }
		    	  else if(this.dataType == 'Regex'){
		    		  let id =  "regex."+this.id;
		    		  let errorId  = "error."+this.id;
			    	  let textRegexVal=   document.getElementById(id).value;
			    		  if(textRegexVal == "" && minOccurs !=0){
			    			    console.log(" regex Input field doesn't empty");
			    				document.getElementById(errorId).style.display= 'block';	
			    				document.getElementById(errorId).innerHTML ="Invalid pattern";
			    				regexBool =false;
			    		  }
			    		   else if(textRegexVal != "" && config != "" && config != null){
			    			   console.log("config is not : "+config);
			    			  let configArray = configParser(config);
			    			  if(!configValidation(id,errorId,textRegexVal,configArray)){
			    				  regexBool =false;
			    			  }
		    		      }
		    		      else{
				    		   document.getElementById(errorId).style.display= 'none';	
				    
		    		      }
			    	console.log(" regex isValid : "+regexBool);  
		    	  }else if(this.dataType == 'Date'){
		    		  let id =  "date."+this.id;
		    		  let errorId  = "error."+this.id;
		    		  let textRegexVal=   document.getElementById(id).value;
		    		  if(textRegexVal == "" && minOccurs !=0){
		    			    console.log(" regex Input field doesn't empty");
		    				document.getElementById(errorId).style.display= 'block';	
		    				document.getElementById(errorId).innerHTML = emptyErrorMessage;
		    				dateBool =false;
		    		  }else{
			    		   document.getElementById(errorId).style.display= 'none';	
	    		      }
		    		  
		    	  }
		    	
		    });
		   if(txtBool  && numBool && regexBool && txtAreaBool && dateBool){
			   return true;
		   }else{
			   return false;
		   }     
		 // console.log("isValid : "+isValid);  
	   //return false;
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
   
   function configValidation(id,errorId,inputVal,configArr){
	   
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
			   let setFixedVal = parseFloat(inputVal).toFixed(3);
			   document.getElementById(id).value = setFixedVal;
			   if(!betweenRange(setFixedVal,startPoint,endPoint)){
				    console.log("Range field doesn't empty");
	   				document.getElementById(errorId).style.display= 'block';	
	   				document.getElementById(errorId).innerHTML ="Input value does not lie in between the range "+value;
		    	    isValidate =false;
			   }else{
				   document.getElementById(errorId).style.display= 'none';	
			   }
		   } else{
				document.getElementById(errorId).style.display= 'block';	
   				document.getElementById(errorId).innerHTML ="Data Type configuration invalide.Please select one pattern.";
	    	    isValidate =false;  
		   }  
	   } 
		   
     return isValidate;
   }
   
   function betweenRange(x, min, max) {
	   //return x >= min && x <= max;
	   return ((x-min)*(x-max) <= 0);
	 }
   
   /*Generate Group List  */
   function generateTestGroup(){
 	  var requestItems ="";
 	  jQuery(this.localTestGroups).each(function() {
 		 requestItems = requestItems.concat('<div class="panel panel-default">');
	      requestItems = requestItems.concat('<div class="panel-heading" role="tab" id="heading'+this.groupName+'">');
	      requestItems = requestItems.concat('<h4 class="panel-title">');
	      requestItems = requestItems.concat('<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapse'+this.groupId+'" aria-expanded="false" aria-controls="collapse'+this.groupId+'">'+this.groupName+'</a>');
	      requestItems = requestItems.concat('</h4></div>');
			       requestItems = requestItems.concat('<div id="collapse'+this.groupId+'" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading'+this.groupName+'">');
			       requestItems = requestItems.concat('<div class="panel-body">');
			       jQuery(this.details).each(function() {
			      	   
				    	    if(this.testAttributeId != 'undefined')
				    	    	{
				    	    	requestItems = requestItems.concat('<input  hidden="true" id="testAttributeId.'+this.id+'" name ="testAttributeId.'+this.id+'" value="'+this.testAttributeId+'" />'); 
				    	    	}
				    	    else{
				    	    	requestItems = requestItems.concat('<input  hidden="true" id="testAttributeId.'+this.id+'" name ="testAttributeId.'+this.id+'" value="" />'); 
				    	      }
				   		 if(this.dataType == 'Coded'){
				   			requestItems = requestItems.concat(codedTags(this.conceptOptions,this.value,this.id,this.name));
				   		 }
				   		 else if(this.dataType == 'Text'){
				   			requestItems = requestItems.concat(textTags(this.value,this.id,this.name,this.hint));
				   		 }
				   		 else if(this.dataType == 'TextArea'){
				   			requestItems =requestItems.concat( textAreaTags(this.value,this.id,this.name,this.hint));
				   		 }
				   		 else if(this.dataType == 'Numeric'){
				   			requestItems =requestItems.concat( numericTags(this.value,this.name,this.id,this.hint));
				   		 }
				   		 else if(this.dataType == 'Boolean'){
				   			requestItems = requestItems.concat(booleanTags(this.value,this.name,this.id));
				   		 }
				   		 else if(this.dataType == 'Date'){
				   			requestItems = requestItems.concat(dateTags(this.value,this.name,this.id));
				   		 }
				   		 else if(this.dataType == 'Regex'){
				   			requestItems = requestItems.concat(regexTags(this.value,this.name,this.id,this.hint));
				   		 }
			   		 });
			       requestItems = requestItems.concat('</div></div>');
    requestItems = requestItems.concat('</div>');
 	  });
    
 	  console.log("Result items group : " +requestItems);
 	  $("#panel-container").append(requestItems); 
 	  // document.getElementById("sortweightList").innerHTML = resultsItems;
    }	
   
   
   
   ///Htmle tags
   
   function codedTags(options,value,id,question){
	   let codedTagItems ="";
	   codedTagItems = codedTagItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
	   codedTagItems = codedTagItems.concat(' <label class="control-label">'+question+'</label>');
	   codedTagItems = codedTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
	   codedTagItems = codedTagItems.concat('<select class="form-control" id="concept.'+id+'" name="concept.'+id+'" ><options />');
		 jQuery(options).each(function() {
			  if(value === undefined || value === 'undefined'){
				  codedTagItems =codedTagItems.concat( '<option value="'+this.conceptId+'">'+this.conceptName+'</option>'); 
			  }else{
				  if(values == this.conceptId)
					  codedTagItems =codedTagItems.concat( '<option  value="'+this.conceptId+'" selected >'+this.conceptName+'</option>'); 
				  else
					  codedTagItems =codedTagItems.concat( '<option value="'+this.conceptId+'">'+this.conceptName+'</option>');  
			  }
		  });
		 codedTagItems =codedTagItems.concat('</select></div></div>'); 
		 
	 return codedTagItems;  
   }
   function textTags(value,id,question,hint){
	   let txtTagItems ="";
	   txtTagItems = txtTagItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
	   txtTagItems = txtTagItems.concat(' <label class="control-label">'+question+'</label>');
	   txtTagItems = txtTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
		 console.log("values : "+ value);
		 if(value === undefined || value === 'undefined'){
			 txtTagItems = txtTagItems.concat('<input maxlength="255"  class="form-control" type="text"  id="valueText.'+id+'" name="valueText.'+id+'" value="" ><span id="error.'+id+'" class="text-danger "></span>');
			 txtTagItems = txtTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
			 txtTagItems = txtTagItems.concat('<span id="hint.'+id+'" class="text-info">'+hint+'</span>'); 
		 }else{
			 txtTagItems = txtTagItems.concat('<input maxlength="255"  class="form-control" type="text"  id="valueText.'+id+'" name="valueText.'+id+'" value="'+value+'"  ><span id="error.'+id+'" class="text-danger "></span>');
			 txtTagItems = txtTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
			 txtTagItems = txtTagItems.concat('<span id="hint.'+id+'" class="text-info">'+hint+'</span>'); 
			}
		 txtTagItems =txtTagItems.concat('</div></div>');
		 
	return 	 txtTagItems;
   }
   
   function textAreaTags(value,id,question,hint){
	   let txtAreaTagItems ="";
	   txtAreaTagItems = txtAreaTagItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
	   txtAreaTagItems = txtAreaTagItems.concat(' <label class="control-label">'+question+'</label>');
	   txtAreaTagItems = txtAreaTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
		 console.log("values txt erea : "+ value);
		 if(value === undefined || value === 'undefined'){
			 txtAreaTagItems = txtAreaTagItems.concat('<textarea  maxlength="512" class="form-control"  id="valueText.'+id+'" name="valueText.'+id+'" value="" /><span id="error.'+id+'" class="text-danger "></span>');
			 txtAreaTagItems = txtAreaTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
			 txtAreaTagItems = txtAreaTagItems.concat('<span id="hint.'+id+'" class="text-info">'+hint+'</span>'); 
		 }else{
			 txtAreaTagItems = txtAreaTagItems.concat('<textarea   maxlength="512" class="form-control"  id="valueText.'+id+'" name="valueText.'+id+'" value="'+value+'" >'+value+'</textarea><span id="error.'+id+'" class="text-danger "></span>'); 
			 txtAreaTagItems = txtAreaTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
			 txtAreaTagItems = txtAreaTagItems.concat('<span id="hint.'+id+'" class="text-info">'+hint+'</span>'); 
			
			}
		 txtAreaTagItems =txtAreaTagItems.concat('</div></div>');
		 
	return txtAreaTagItems;	 
   }
   
   function numericTags(value,question,id,hint){
	   let numericTagItems ="";
	   numericTagItems = numericTagItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
	   numericTagItems = numericTagItems.concat(' <label class="control-label">'+question+'</label>');
	   numericTagItems = numericTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
		 console.log("values : "+ value);
		 if(value === 'undefined' || value == undefined){
			 numericTagItems = numericTagItems.concat('<input class="form-control" type="input"  id="float.'+id+'" name="float.'+id+'" ><span id="error.'+id+'" class="text-danger "></span>'); 
					    numericTagItems = numericTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
					    numericTagItems = numericTagItems.concat('<span id="hint.'+id+'" class="text-info">'+hint+'</span>'); 
		 }
		 else{
			 numericTagItems = numericTagItems.concat('<input class="form-control" type="input" value ="'+value+'" id="float.'+id+'" name="float.'+id+'"  ><span id="error.'+id+'" class="text-danger "></span>');
			 numericTagItems = numericTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
			 numericTagItems = numericTagItems.concat('<span id="hint.'+id+'" class="text-info">'+hint+'</span>'); 			
		 }
		 numericTagItems =numericTagItems.concat('</div></div>');  
		 
	return 	numericTagItems;	 
   }
   
   function booleanTags(value,question,id){
 		let booleanTagItems ="";
 		booleanTagItems = booleanTagItems.concat('<label class="container-box">');
 		booleanTagItems = booleanTagItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
 		booleanTagItems = booleanTagItems.concat('<span>'+question+'</span>');
 		booleanTagItems = booleanTagItems.concat('</div><div class="col-sm-1 col-md-1 col-lg-1"></div><div class ="col-sm-4 col-md-4 col-lg-4 centered">');
 		 if(this.value == 'undefined'){
 	 		booleanTagItems = booleanTagItems.concat('<input type="checkbox" value="false" id="bool.'+id+'" name="bool.'+id+'" onchange="handleChange(this);">');
 			 }else{
 				 if(value == "true"){
 			 		booleanTagItems = booleanTagItems.concat('<input type="checkbox" value="false" id="bool.'+id+'" name="bool.'+id+'" checked="checked" onchange="handleChange(this);">');
 				 }else{
 			 		booleanTagItems = booleanTagItems.concat('<input type="checkbox" value="false" id="bool.'+id+'" name="bool.'+id+'" onchange="handleChange(this);">');
 				 }
 		 }
 		booleanTagItems = booleanTagItems.concat('<span class="checkmark"></span>');
 		booleanTagItems = booleanTagItems.concat('</div></div></label>');
 		
 		/* 	booleanTagItems = booleanTagItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
 		booleanTagItems = booleanTagItems.concat('<label class="control-label container-checkbox">'+question+'</label>');
 		booleanTagItems = booleanTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
 		booleanTagItems = booleanTagItems.concat('<input class="form-control" type="checkbox"  id="bool.'+id+'" name="bool.'+id+'"  value="true" ><span id="error.'+id+'" class="text-danger">'); 
 		booleanTagItems =booleanTagItems.concat('</div></div>'); 
 			booleanTagItems = booleanTagItems.concat('<select class="form-control" id="bool.'+id+'" name="bool.'+id+'">');
		 if(this.value == 'undefined'){
			 booleanTagItems = booleanTagItems.concat('<option value="true" selected>Yes</option>');
			 booleanTagItems = booleanTagItems.concat('<option value="false" >No</option>');
		 }else{
			 
			 if(value == "true"){
				 booleanTagItems = booleanTagItems.concat('<option value="true" selected>Yes</option>');
				 booleanTagItems = booleanTagItems.concat('<option value="false" >No</option>'); 
			 }else{
				 booleanTagItems = booleanTagItems.concat('<option value="true" >Yes</option>');
				 booleanTagItems = booleanTagItems.concat('<option value="false" selected >No</option>'); 
			 }	 
		 }
		 booleanTagItems =booleanTagItems.concat('</select></div></div>'); */
	   
	  return booleanTagItems; 	   
   }  
   function handleChange(checkbox) {
	   $(checkbox).val(checkbox.checked ? true : false);
	   /*  if(checkbox.checked == true){
	    	
	    }else{
	   } */
	}
   
   function dateTags(value,question,id){ 
	   let dateTagItems ="";
	     var currentDate = $.datepicker.formatDate('yy-mm-dd', new Date()); 
	     var orderActivatedDate = '${encounterdate}';
	     console.log("currentDate : "+currentDate);
	     console.log("orderActivatedDate : "+orderActivatedDate);
	     dateTagItems = dateTagItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
	     dateTagItems = dateTagItems.concat('<label class="control-label">'+question+'</label>');
		 dateTagItems = dateTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
		 if(value == 'undefined'){
			 dateTagItems = dateTagItems.concat('<input  id="date.'+id+'"  class="form-control" name="date.'+id+'" type="date" value="" min="'+orderActivatedDate+'" max="'+currentDate+'" ><span id="error.'+id+'" class="text-danger "></span>');
		 }else{
			 dateTagItems = dateTagItems.concat('<input id="date.'+id+'"  class="form-control"  name="date.'+id+'" type="date" value="'+value+'" min="'+orderActivatedDate+'" max="'+currentDate+'" ><span id="error.'+id+'" class="text-danger "></span>');			
		 }
		 dateTagItems =dateTagItems.concat('</div></div>');
	   return dateTagItems;
   }
   
   function regexTags(value,question,id,hint){
	   let regexTagItems =""; 
	   regexTagItems = regexTagItems.concat('<div class="row"><div class="col-sm-3 col-md-3 col-lg-3">');
	   regexTagItems = regexTagItems.concat(' <label class="control-label">'+question+'</label>');
	   regexTagItems = regexTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
		 if(value === 'undefined' || value == undefined){
			 regexTagItems = regexTagItems.concat('<input class="form-control" type="text"  id="regex.'+id+'" name="regex.'+id+'" ><span id="error.'+id+'" class="text-danger "></span>'); 
			 regexTagItems = regexTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
			 regexTagItems = regexTagItems.concat('<span id="hint.'+id+'" class="text-info">'+hint+'</span>'); 
		 }
		 else{
			 regexTagItems = regexTagItems.concat('<input class="form-control" type="text" value ="'+value+'" id="regex.'+id+'" name="regex.'+id+'" ><span id="error.'+id+'" class="text-danger "></span>'); 
			 regexTagItems = regexTagItems.concat('</div><div class ="col-sm-4 col-md-4 col-lg-4">');
			 regexTagItems = regexTagItems.concat('<span id="hint.'+id+'" class="text-info">'+hint+'</span>'); 			
		 }
		 regexTagItems =regexTagItems.concat('</div></div>');
	   
	   
	   return regexTagItems;
   }
   
   
   
</script>


<%@ include file="/WEB-INF/template/footer.jsp"%>

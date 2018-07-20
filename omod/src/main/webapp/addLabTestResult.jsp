<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>


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

<style>
body {
	font-size: 12px;
}
input[type=submit] {
	background-color: #1aac9b;
	color: white;
	padding: 8px 22px;
	border: none;
	border-radius: 2px;
	cursor: pointer;
	
}
fieldset.scheduler-border {
    border: 1px groove #ddd !important;
    padding: 0 1.4em 1.4em 1.4em !important;
    margin: 0 0 1.5em 0 !important;
    -webkit-box-shadow:  0px 0px 0px 0px #1aac9b;
            box-shadow:  0px 0px 0px 0px #1aac9b;
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
    <fieldset  class="scheduler-border">
			<legend  class="scheduler-border"><spring:message code="commonlabtest.result.add" /></legend>
			<br>
			<h3 style="text-align:center">CHEST X-RAY</h3>
			<br>
		<form id="form">
		    <div class="row" >
				   <div class="col-md-4">
				        <label  class="control-label" for="specimenType">CAD4TB Score<span class="required">*</span></label>
				   </div>
				   <div class="col-md-6">
				   		<input for="cadtbScore" class="form-control" required="required" ></input>
				   </div>
			 </div>
			  <div class="row" >
				   <div class="col-md-4">
				        <label  class="control-label" for="specimenType">X-Ray Result<span class="required">*</span></label>
				   </div>
				   <div class="col-md-6">
				   		<select class="form-control">
						  <option >NORMAL</option>
						  <option >ABNORMAL</option>
						  <option >NOT DONE</option>
						</select>
				   </div>
			 </div>
			  <div class="row" >
				   <div class="col-md-4">
				        <label  class="control-label" for="specimenType">Radiologist Remarks <span class="required">*</span></label>
				   </div>
				   <div class="col-md-6">
				   		<input for="radiologiest" class="form-control" required="required" ></input>
				   </div>
			 </div>
			 <!--   <div class="row" >
				   <div class="col-md-4">
				        <label  class="control-label" for="specimenType">Upload Attachment </label>
				   </div>
				   <div class="col-md-6">
				   		<input type="file" name="pic" accept="image/*">
				   </div>
			 </div> -->
		    <!-- Save -->
			 <div class="row">
			   <div class="col-md-2">
					<input type="submit" value="SAVE"></input>
			   </div>
			    <div class="col-md-2">
					<input type="submit" value="DELETE"></input>
			   </div>
			 </div>		 
	   </form>
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
$(document).ready(function () {
	
});
</script>


<%@ include file="/WEB-INF/template/footer.jsp"%>
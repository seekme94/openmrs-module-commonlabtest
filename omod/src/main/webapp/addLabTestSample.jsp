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

  	<c:if test="${not empty error}">
		<div class="alert alert-danger">
			 <a href="#" class="close" data-dismiss="alert">&times;</a>
	 		<strong>Error!</strong> <c:out value="${error}" />
		</div>
	</c:if>	 
	<c:set var="testSample" scope="session" value="${testSample}" />
    <fieldset  class="scheduler-border">
		<c:if test="${empty testSample.specimenType}">
			<legend  class="scheduler-border"><spring:message code="commonlabtest.labtestsample.add" /></legend>
		</c:if>
		<c:if test="${not empty testSample.specimenType}">
			<legend  class="scheduler-border"><spring:message code="commonlabtest.labtestsample.edit" /></legend>
		</c:if>
		<form:form modelAttribute="testSample" id="testSampleform">
			<form:input  path="collector.providerId" hidden="true" value="${provider.providerId}"></form:input>	
		    <form:input  path="labTest.order.patient.patientId" hidden="true" value="${patientId}"></form:input>
		   
		    <div class="row" >
				   <div class="col-md-4">
				        <form:label  class="control-label" path="specimenType"><spring:message code="general.specimenType" /><span class="required">*</span></form:label>
				   </div>
				   <div class="col-md-6">
				   		<form:input path="specimenType" class="form-control" required="required" ></form:input>
				   </div>
			 </div>
			 <div class="row" >
			   <div class="col-md-4">
		     	   <form:label  class="control-label" path="specimenSite"><spring:message code="general.specimenSite" /><span class="required">*</span></form:label>
			   </div>
			   <div class="col-md-6">
			   		<form:input path="specimenSite" class="form-control" required="required" ></form:input>
			   </div>
			 </div>
			 <!-- status -->
			 <div class="row">
			   <div class="col-md-4">
			   		<form:label  class="control-label" path="status"><spring:message code="general.status" /></form:label>
			   </div>
			   <div class="col-md-6">
			   		<form:select class="form-control" path="status" id="status" >
								<form:options items="${LabTestSampleStatus}" />
								<c:forEach items="${LabTestSampleStatus}">
									<option value="${LabTestSampleStatus}">${LabTestSampleStatus}</option>
								</c:forEach>
					</form:select>
			  </div>
			 </div>
			 <!--collectionDate  -->
			  <div class="row">
			   <div class="col-md-4">
			   		<form:label  class="control-label" path="collectionDate"><spring:message code="commonlabtest.labtestsample.collectionDate" /></form:label>
			   </div>
			   <div class="col-md-6">
					 <form:input class="form-control" path="collectionDate" type="text" id="datepicker"></form:input>
				</div>
			 </div> 
		    <!-- Save -->
			 <div class="row">
			   <div class="col-md-4">
					<input type="submit" value="Save Test Sample"></input>
			   </div>
			 </div>		 
		</form:form>

    </fieldset>
	<br>
	<c:if test="${not empty testSample.specimenType}">
	
		 <fieldset  class="scheduler-border">
      	   <legend  class="scheduler-border"><spring:message code="commonlabtest.labtestsample.void" /></legend>
					<form id="form" >
						 <!-- UUID -->
						 <div class="row">
						   <div class="col-md-2">
								<input value="" hidden="true"  id="uuid" name="uuid"></input>
								<label  class="control-label" path="voidReason"><spring:message code="general.reason" /><span class="required">*</span></label>
						   </div>
						   <div class="col-md-6">
						   		<input class="form-control" value="" id="voidReason" name="retireReason" required="required">
						   </div>
						 </div>
						 <!-- Retire -->
						 <div class="row">
						   <div class="col-md-2" >
						 		 <input type="submit" value="Void Test Sample"></input>
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
$(document).ready(function () {
	$("#datepicker").datepicker({
    dateFormat: 'yy-dd-mm',
    onSelect: function(datetext){
        var d = new Date(); // for now
        var h = d.getHours();
    		h = (h < 10) ? ("0" + h) : h ;

    		var m = d.getMinutes();
        m = (m < 10) ? ("0" + m) : m ;

        var s = d.getSeconds();
        s = (s < 10) ? ("0" + s) : s ;

    		datetext = datetext + " " + h + ":" + m + ":" + s;
        $('#datepicker').val(datetext);
    },
	});

});
</script>


<%@ include file="/WEB-INF/template/footer.jsp"%>
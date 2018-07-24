<%@ include file="/WEB-INF/template/include.jsp"%>

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
	<br>
	<c:set var="testOrder" scope="session" value="${testOrder}" />
	<div>
	 <a href="${pageContext.request.contextPath}/module/commonlabtest/addLabTestOrder.form?patientId=${model.patient.patientId}"><i class="fa fa-plus"></i> <spring:message code="commonlabtest.order.add" /> </a>
	</div>
	<br>
	<!--List of Test Order  -->
	<div class=" boxHeader" style="background-color: #1aac9b">
			<span></span> <b><spring:message code="commonlabtest.order.list" /></b>
	 </div>
	 <div class="box">
		 <table id="testOrderTable" class="table table-striped table-bordered" style="width:100%">
	        <thead>
	            <tr>
					<th>Test Type</th>
					<th>Lab Reference Number</th>
					<th>Edit</th>
					<th>View</th>
					<th>Manage Test Sample</th>
					<th>Test Result</th>
				</tr>
	        </thead>
	        <tbody>
		        <c:forEach var="order" items="${testOrder}">
							<tr>
								<td><a
									href="${pageContext.request.contextPath}/module/commonlabtest/addLabTestAttributeType.form?uuid=${order.uuid}">${order.labTestType.name}</a></td>
								<td>${order.labReferenceNumber}</td>
								 <td> <span class="table-edit"><i class="fa fa-edit fa-2x"></i></span></td>
					             <td> <span class="table-view"><i class="fa fa-eye fa-2x" aria-hidden="true"></i></span></td>
					             <td> <span class="table-sample"><img class="manImg" src="/openmrs/moduleResources/commonlabtest/img/testSample.png"></img></span></span></td>
					             <td> <span class="table-result"><img class="manImg" src="/openmrs/moduleResources/commonlabtest/img/testResult.png"></img></span></span></td>
					             
							</tr>
				 </c:forEach>
				<!--  <tr>
			            <td>AFB SMEAR</td>
			             <td>AFB-4NRL9876543100-52</td>
 						 <td> <span class="table-edit"><i class="fa fa-edit fa-2x"></i></span></td>
			             <td> <span class="table-view"><i class="fa fa-eye fa-2x" aria-hidden="true"></i></span></td>
			             <td> <span class="table-sample"><img class="manImg" src="/openmrs/moduleResources/commonlabtest/img/testSample.png"></img></span></span></td>
			             <td> <span class="table-result"><img class="manImg" src="/openmrs/moduleResources/commonlabtest/img/testResult.png"></img></span></span></td>
			             
			             </tr>
			        <tr>
			            <td>Chest X-Ray</td>
			             <td>CXR-NRL9876543100-52</td>
 						 <td> <span class="table-edit"><i class="fa fa-edit fa-2x"></i></span></td>
			             <td> <span class="table-view"><i class="fa fa-eye fa-2x" aria-hidden="true"></i></span></td>
			       	     <td> <span class="table-sample"><img class="manImg" src="/openmrs/moduleResources/commonlabtest/img/testSample.png"></img></span></span></td>
			             <td> <span class="table-result"><img class="manImg" src="/openmrs/moduleResources/commonlabtest/img/testResult.png"></img></span></span></td>
			             
			        </tr>
			         <tr>
			             <td>GeneXpert</td>
			             <td>GXP-IRS12345</td>
			             <td> <span class="table-edit"><i class="fa fa-edit fa-2x"></i></span></td>
			             <td> <span class="table-view"><i class="fa fa-eye fa-2x" aria-hidden="true"></i></span></td>
			             <td> <span class="table-sample"><img class="manImg" src="/openmrs/moduleResources/commonlabtest/img/testSample.png"></img></span></span></td>
			             <td> <span class="table-result"><img class="manImg" src="/openmrs/moduleResources/commonlabtest/img/testResult.png"></img></span></span></td>
			             
			       </tr>
			        <tr>
			             <td>SEDIMENTATION</td>
			             <td>SED-6AIRS12345</td>
			             <td> <span class="table-edit"><i class="fa fa-edit fa-2x"></i></span></td>
			             <td> <span class="table-view"><i class="fa fa-eye fa-2x" aria-hidden="true"></i></span></td>
			             <td> <span class="table-sample"><img class="manImg" src="/openmrs/moduleResources/commonlabtest/img/testSample.png"></img></span></span></td>
			             <td> <span class="table-result"><img class="manImg" src="/openmrs/moduleResources/commonlabtest/img/testResult.png"></img></span></span></td>
			             
			       </tr> -->
	        </tbody>
	    </table>
	 </div>
	 
	 <!-- View Modal -->
	<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="viewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title w-100 font-weight-bold">View Test Order</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
            
               <fieldset  class="scheduler-border">
      	 		  <legend  class="scheduler-border"><spring:message code="commonlabtest.order.detail" /></legend>
			
	     			<form:form commandName="testOrder" id="form">
		     			 <div class="form-group">
	                        <label ><font color="#D0D0D0"><sub><spring:message code="commonlabtest.order.id" /></sub></font></label>
				   			<font color="#D0D0D0"><sub><c:out value="${testOrder.id}" /></sub></font>
	                    </div>
	                    <div class="form-group">
	                        <label><font color="#000000"><sub><spring:message code="general.testGroup" /></sub></font></label>
				   			<font color="#D0D0D0"><sub><c:out value="${testOrder.labTestType.testGroup}" /></sub></font>
	                    </div>
	                     <div class="form-group">
	                        <label><font color="#000000"><sub><spring:message code="general.testType" /></sub></font></label>
				   			<font color="#D0D0D0"><sub><c:out value="${testOrder.labTestType}" /></sub></font>
	                    </div>
	                     <div class="form-group">
	                        <label><font color="#000000"><sub><spring:message code="commonlabtest.order.labReferenceNo" /></sub></font></label>
				   			<font color="#D0D0D0"><sub><c:out value="${testOrder.labReferenceNumber}" /></sub></font>
	                    </div>
	                    <div class="form-group">
	                        <label><font color="#000000"><sub><spring:message code="general.requiresSpecimen" /></sub></font></label>
				   			<font color="#D0D0D0"><sub><c:out value="${testOrder.labTestType.requiresSpecimen}" /></sub></font>
	                    </div>
	                     <div class="form-group">
	                        <label><font color="#000000"><sub><spring:message code="general.createdBy" /></sub></font></label>
				   			<font color="#D0D0D0"><sub><c:out value="${testOrder.labTestType.dateCreated}" /></sub></font>
	                    </div>
	                     <div class="form-group">
	                        <label><font color="#000000"><sub><spring:message code="general.changedBy" /></sub></font></label>
				   			<font color="#D0D0D0"><sub><c:out value="${testOrder.labTestType.changedBy}" /></sub></font>
	                    </div>
	                     <div class="form-group">
	                        <label>	<font color="#D0D0D0"><sub><spring:message code="general.uuid" /></sub></font></label>
				   			<font color="#D0D0D0"><sub><c:out value="${testOrder.uuid}" /></sub></font>
	                    </div>
	    
	                </form:form>
	            </fieldset>    
               
               <!--Test Sample Details -->
               <fieldset  class="scheduler-border">
      	 		  <legend  class="scheduler-border"><spring:message code="commonlabtest.labtestsample.detail" /></legend>
						<table  class="table table-striped table-responsive-md btn-table table-hover mb-0" id="tb-test-type">
									<thead>
										<tr>
											 <th><a>Test Order</a></th>
											 <th><a>Spacimen Type</a></th>
											 <th><a>Spacimen Site</a></th>
											 <th><a>Status</a></th>
										</tr>
									</thead>
									<tbody>
										 <tr>
									            <td>1</td>
									            <td>dummy data</td>
									            <td>dummy data</td>
									            <td>Collected</td>
								        </tr>
								         <tr>
									            <td>1</td>
									            <td>dummy data</td>
									            <td>dummy data</td>
									            <td>Collected</td>
								        </tr>
									</tbody>
							</table>
       			 </fieldset>
       			 
       			  <!--Test Sample Details -->
               <fieldset  class="scheduler-border">
      	 		  <legend  class="scheduler-border"><spring:message code="commonlabtest.result.detail" /></legend>
					
       			 </fieldset>
               
                <fieldset  class="scheduler-border">
      	 		  <legend  class="scheduler-border"><spring:message code="general.test.retire" /></legend>
					<form method="post" action="${pageContext.request.contextPath}/module/commonlabtest/retirelabtesttype.form" >
						 <!-- UUID -->
						 <div class="row">
						   <div class="col-md-4">
								<input value="${labTestType.uuid}" hidden="true"  id="uuid" name="uuid"></input>
								<label  class="control-label" path="retireReason"><spring:message code="general.retireReason" /><span class="required">*</span></label>
						   </div>
						   <div class="col-md-6">
						   		<input class="form-control" value="${labTestType.retireReason}" id="retireReason" name="retireReason" required="required">
						   </div>
						 </div>
						 <!-- Retire -->
						 <div class="row">
						   <div class="col-md-4">
						 		 <input type="submit" value="Retire Test Order"></input>
						   </div>
						 </div>
						
						<%-- <table>						
							<tr>
								<input value="${labTestType.uuid}" hidden="true"  id="uuid" name="uuid"></input>
								<td><label  class="control-label" path="retireReason"><spring:message code="general.retireReason" /></label></td>
								<td><input class="form-control" value="${labTestType.retireReason}" id="retireReason" name="retireReason" required="required"></input></td>
							</tr>
							<tr>
								<td>
									<div id="retireButton" style="margin-top: 15px">
										<input type="submit" value="Retire Test Type"></input>
									</div>
								</td>
							</tr>
						</table> --%>
					</form>
       			 </fieldset>

                
            </div>
        </div>
    </div>
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
	
	$('#testOrderTable').dataTable({
		 "bPaginate": true
	  });
	  $('.dataTables_length').addClass('bs-select');
	  
	/*View Test Order */
	  $('.table-sample').click(function () {
		 
		  window.location = "${pageContext.request.contextPath}/module/commonlabtest/manageLabTestSamples.form?patientId="+${model.patient.patientId};  
		  
		  
		    //$('#addModal').modal('show'); 
		  
		    //$(this).parents('tr').detach();
		 	 var $row = $(this).closest("tr");    // Find the row
		     var $tds = $row.find("td:first");
		     console.log($(this).text());
		    $.each($tds, function() {
		        console.log($(this).text());
		    });
		});
	  $('.table-view').click(function () {
			 
		    $('#viewModal').modal('show'); 
		  
		});
	  
	  $('.table-edit').click(function () {
			 
		  window.location = "${pageContext.request.contextPath}/module/commonlabtest/addLabTestOrder.form?patientId="+${model.patient.patientId}; //+"&testOrderId="+2;  
		  
		});
	  
	  $('.table-result').click(function () {
			 
		  window.location = "${pageContext.request.contextPath}/module/commonlabtest/addLabTestResult.form?patientId="+${model.patient.patientId};  
		  
		});
	  
});
</script>

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
input[type=button] {
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
	<!-- <div>
		<a href="" class="btn btn-default btn-rounded mb-4" data-toggle="modal" data-target="#addModal"><i class="fa fa-plus"></i> <spring:message code="commonlabtest.order.add" /> </a>
	</div> -->
	<div>
	 <a href="${pageContext.request.contextPath}/module/commonlabtest/addLabTestSample.form?patientId=${patientId}"><i class="fa fa-plus"></i> <spring:message code="commonlabtest.labtestsample.add" /> </a>
	</div>
	<br>
	<!--List of Test Order  -->
	<div class=" boxHeader" style="background-color: #1aac9b">
			<span></span> <b><spring:message code="commonlabtest.labtestsample.list" /></b>
	 </div>
	 <div class="box">
		 <table id="testOrderTable" class="table table-striped table-bordered" style="width:100%">
	        <thead>
	            <tr>
					<th>Sample ID</th>
					<th>Specimen Type</th>
					<th>Specimen Site</th>
					<th>Collected On</th>
					<th>Status</th>
					<th></th>
					<th></th>
				</tr>
	        </thead>
	        <tbody>
		       <%--  <c:forEach var="order" items="${testOrder}">
							<tr>
								<td><a
									href="${pageContext.request.contextPath}/module/commonlabtest/addLabTestAttributeType.form?uuid=${order.uuid}">${order.labTestType.name}</a></td>
								<td>${order.labReferenceNumber}</td>
								<td>
								    <span class="table-remove"><i class="fa fa-edit"></i></span>
								</td>
							</tr>
				 </c:forEach> --%>
				 <tr>
			            <td>11825613065</td>
			            <td>SPUTUM</td>
			            <td>dummy data</td>
			            <td>13-July-2018</td>
			            <td>COLLECTED</td>
						<td><button type="button" class="btn  reject" >Reject</button></td> 
 						<td><button type="button" class="btn  accept" >Accept</button></td> 		
 				</tr>
			    
			     <tr style="color: red;">
			            <td>11825613023</td>
			            <td>BLOOD</td>
			            <td>dummy data</td>
			            <td>10-July-2018</td>
			            <td>EXPIRED</td>
			            <td><button type="button" class="btn  reject" >Reject</button></td> 
 						<td><button type="button" class="btn  accept" >Accept</button></td> 
 				</tr>		
	        </tbody>
	    </table>
	 </div>
	 
	  <!-- Rejected Reason Modal -->
	<div class="modal fade" id="rejectModal" tabindex="-1" role="dialog" aria-labelledby="viewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title w-100 font-weight-bold">Enter Reject Reason</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                 <!-- UUID -->
						 <div class="row">
						   <div class="col-md-4">
								<label  class="control-label">Reason<span class="required">*</span></label>
						   </div>
						   <div class="col-md-6">
						   		<input class="form-control" value="" id="retireReason" required="required">
						   </div>
						 </div>
						 <!-- Retire -->
						 <div class="row">
						    <div class="col-md-4">
						    </div>
						   <div class="col-md-4">
						 		 <input type="submit" data-dismiss="modal"  value="Submit"></input>
						   </div>
						 </div>
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
	  
	  $('.accept').click(function () {
		   
		});
	  $('.reject').click(function () {
		  $('#rejectModal').modal('show'); 
		});
	  
});
</script>




<%@ include file="/WEB-INF/template/footer.jsp"%>
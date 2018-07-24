<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="/WEB-INF/view/module/commonlabtest/include/localHeader.jsp"%>

<link type="text/css" rel="stylesheet" href="/openmrs/moduleResources/commonlabtest/css/commonlabtest.css" />
<link   href="/openmrs/moduleResources/commonlabtest/font-awesome/css/font-awesome.min.css" rel="stylesheet" /> 
<link   href="/openmrs/moduleResources/commonlabtest/css/bootstrap.min.css" rel="stylesheet" />

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
 body{
    font-size: 12px;
 }
 
 .btn {
    background-color: #1aac9b;
    border: none;
    color: white;
    padding: 12px 16px;
    font-size: 16px;
    cursor: pointer;
}
.btn:hover {
    background-color: #1aac9be6;
}

.table-striped tbody tr:nth-of-type(odd) {
    background-color: #E2E4FF;
}
.table-striped tbody tr:hover {
	background-color: #ddd;
}
/*continer  */
.container {
  margin: 0 auto;
  max-width: 100%
}
</style>

	<!-- Heading -->
	<div>
		<h2>
			<b><spring:message code="commonlabtest.labtestattributetype.manage" /></b>
		</h2>
	</div>
	<br>
	<c:if test="${not empty status}">
		<div class="alert alert-success">
			 <a href="#" class="close" data-dismiss="alert">&times;</a>
	 		<strong>Success!</strong> <c:out value="${status}" />
		</div>
	</c:if>
	<div>
	 <a href="addLabTestAttributeType.form" ><i class="fa fa-plus"></i> <spring:message code="commonlabtest.labtestattributetype.add" /> </a>
	</div>
	<br>
		<div class="boxHeader" style="background-color: #1aac9b">
			<span><i class="fa fa-list"></i> </span> <b><spring:message code="commonlabtest.labtestattributetype.list" /></b>
		</div>
		<div  class="box">
		  <table id="manageTestAttributeTypeTable" class="table table-striped table-bordered" style="width:100%">
				<thead>
					<tr>
						 <th hidden="true"></th>
						 <th>Name</th>
						 <th>Description</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="tt" items="${labTestAttributeTypes}">
						<tr>
						    <td hidden="true" id="uuid">${tt.uuid}</td>
							<td><a href="${pageContext.request.contextPath}/module/commonlabtest/addLabTestAttributeType.form?uuid=${tt.uuid}">${tt.name}</a></td>
							<td>${tt.description}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

<%@ include file="/WEB-INF/template/footer.jsp"%>

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


<script>
function relocate_home()
{
     location.href = "addLabTestAttributeType.form";
} 

$(document).ready(function() {
	console.log("${status}");
	$('#manageTestAttributeTypeTable').dataTable({
		 "bPaginate": true
	  });
	  $('.dataTables_length').addClass('bs-select');
	  
	
	
	
	 $('#manageTestAttributeTypeTable td').click(function() {
    	 //$(this).parents('tr').detach();
	 	
    	 var $row = $(this).closest("tr");    // Find the row
	     var $tds = $row.find("td:first");
	 	 var uuid =$tds.text();
		 window.location = "${pageContext.request.contextPath}/module/commonlabtest/addLabTestType.form?uuid="+uuid;
	     
	     
    });
	
});


</script>
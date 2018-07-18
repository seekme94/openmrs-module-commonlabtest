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


<!-- Container  -->
<div class="container">

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
	<div class="card card-cascade narrower">
		<div class="card-header boxHeader" style="background-color: #1aac9b">
			<span><i class="fa fa-list"></i> </span> <b><spring:message code="commonlabtest.labtestattributetype.list" /></b>
		</div>
		<form  class="box">
			<table  class="table table-striped table-responsive-md btn-table table-hover mb-0" id="tb-test-type">
				<thead>
					<tr>
						 <th class="th-lg"><a> Name <i class="fa fa-sort ml-1"></i></a></th>
						 <th class="th-lg"><a> Description <i class="fa fa-sort ml-1"></i></a></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="tt" items="${labTestAttributeTypes}">
						<tr>
							<td><a href="${pageContext.request.contextPath}/module/commonlabtest/addLabTestAttributeType.form?uuid=${tt.uuid}">${tt.name}</a></td>
							<td>${tt.description}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</div>
</div>

<%@ include file="/WEB-INF/template/footer.jsp"%>

<!-- JavaScript Code  -->

<script src="${pageContext.request.contextPath}/moduleResources/commonlabtest/bootstrap/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/moduleResources/commonlabtest/bootstrap/js/popper.min.js" ></script>
<script src="${pageContext.request.contextPath}/moduleResources/commonlabtest/bootstrap/js/bootstrap.min.js" ></script>


<script>
function relocate_home()
{
     location.href = "addLabTestAttributeType.form";
} 

$(document).ready(function() {
	console.log("${status}");
	
	
});


</script>
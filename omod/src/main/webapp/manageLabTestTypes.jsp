<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="/WEB-INF/view/module/commonlabtest/include/localHeader.jsp"%>

<link type="text/css" rel="stylesheet" href="/openmrs/moduleResources/commonlabtest/css/commonlabtest.css" />
<link   href="/openmrs/moduleResources/commonlabtest/font-awesome/css/font-awesome.min.css" rel="stylesheet" /> 
<link   href="/openmrs/moduleResources/commonlabtest/css/bootstrap.min.css" rel="stylesheet" />

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
			<b><spring:message code="commonlabtest.labtesttype.manage" /></b>
		</h2>
	</div>
	<br>

	<div>
	 <a href="addLabTestType.form" ><i class="fa fa-plus"></i> <spring:message code="commonlabtest.labtesttype.add" /> </a>
	</div>
	<br>
	<div class="card card-cascade narrower">
		<div class="card-header boxHeader" style="background-color: #1aac9b">
			<span><i class="fa fa-list"></i> </span> <b><spring:message code="commonlabtest.labtesttype.list" /></b>
		</div>
		<form  class="box">
			<table  class="table table-striped table-responsive-md btn-table table-hover mb-0" id="tb-test-type">
				<thead>
					<tr>
						 <th class="th-lg"><a> Name <i class="fa fa-sort ml-1"></i></a></th>
						 <th class="th-lg"><a> Short Name <i class="fa fa-sort ml-1"></i></a></th>
						 <th class="th-lg"><a> Test Group <i class="fa fa-sort ml-1"></i></a></th>
						 <th class="th-lg"><a> Reference Concept <i class="fa fa-sort ml-1"></i></a></th> 	 
					</tr>
				</thead>
				<tbody>
					<c:forEach var="tt" items="${labTestTypes}">
						<tr>
							<td><a href="${pageContext.request.contextPath}/module/commonlabtest/addLabTestType.form?uuid=${tt.uuid}">${tt.name}</a></td>
							<td>${tt.shortName}</td>
							<td>${tt.testGroup}</td>
							<td>${tt.referenceConcept.name}</td>
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
     location.href = "addLabTestType.form";
} 

$(document).ready(function() {

    $('#tb-test-type tr').click(function() {
       alert("is ca,");
    });

});


</script>
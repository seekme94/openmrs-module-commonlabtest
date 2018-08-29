<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="/WEB-INF/view/module/commonlabtest/include/localHeader.jsp"%>
<openmrs:require privilege="View labTestType" otherwise="/login.htm" redirect="/module/commonlabtest/manageLabTestTypes.form" />

<link type="text/css" rel="stylesheet" href="/openmrs/moduleResources/commonlabtest/css/commonlabtest.css" />
<link   href="/openmrs/moduleResources/commonlabtest/font-awesome/css/font-awesome.min.css" rel="stylesheet" /> 
<link   href="/openmrs/moduleResources/commonlabtest/css/bootstrap.min.css" rel="stylesheet" />
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
 
;table.display tbody tr:nth-child(even):hover td{
    background-color: #1aac9b !important;
}

</style>

	<!-- Heading -->
	<div>
		<h2>
			<b><spring:message code="commonlabtest.labtesttype.manage" /></b>
		</h2>
	</div>
	<br>
	<c:if test="${not empty status}">
		<div class="alert alert-success" id="success-alert">
			 <a href="#" class="close" data-dismiss="alert">&times;</a>
	 		<strong>Success!</strong> <c:out value="${status}" />
		</div>
	</c:if>
	<div>
	 <a style="text-decoration:none" href="addLabTestType.form" class="hvr-icon-grow" ><i class="fa fa-plus hvr-icon"></i> <spring:message code="commonlabtest.labtesttype.add" /> </a>
	</div>
	<br>
	<div class="boxHeader" style="background-color: #1aac9b">
			<span><i class="fa fa-list"></i> </span> <b><spring:message code="commonlabtest.labtesttype.list" /></b>
	</div>
	 <div class="box">
		 <table id="manageTestTypeTable" class="table table-striped table-bordered" style="width:100%">
	        <thead>
	            <tr>
	            	<th hidden="true"></th>
					<th>Name</th>
					<th>Short Name</th>
					<th>Test Group</th>
					<th>Reference Concept</th>
				</tr>
	        </thead>
	        <tbody>
		       <c:forEach var="tt" items="${labTestTypes}">
						<tr>
							<td hidden="true" id="uuid">${tt.uuid}</td>
							<td><a style="text-decoration:none" href="${pageContext.request.contextPath}/module/commonlabtest/addLabTestType.form?uuid=${tt.uuid}" class="hvr-icon-grow"><span><i class="fa fa-edit hvr-icon"></i></span> ${tt.name}</a></td>
							<td>${tt.shortName}</td>
							<td>${tt.testGroup}</td>
							<td>${tt.referenceConcept.name}</td>
						</tr>
					</c:forEach>
	        </tbody>
	    </table>
	 </div>
		
	<%-- 
		
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
			</table> --%>

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
     location.href = "addLabTestType.form";
} 

$(document).ready(function() {

	//status auto closs..		
	   $("#success-alert").fadeTo(2000, 500).slideUp(500, function(){
            $("#success-alert").slideUp(500);
             }); 
	
	$('#manageTestTypeTable').dataTable({
		 "bPaginate": true
	  });
	  $('.dataTables_length').addClass('bs-select');
	  
	
    $('#manageTestTypeTable td').click(function() {
    	 //$(this).parents('tr').detach();
	 	
    	 var $row = $(this).closest("tr");    // Find the row
	     var $tds = $row.find("td:first");
	 	 var uuid =$tds.text();
		 window.location = "${pageContext.request.contextPath}/module/commonlabtest/addLabTestType.form?uuid="+uuid;
	     
	     
    });

});


</script>
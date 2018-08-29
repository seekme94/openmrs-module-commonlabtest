<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<openmrs:require privilege="View labTestType" otherwise="/login.htm" redirect="/module/commonlabtest/manageLabTestSamples.form" />
<openmrs:portlet url="patientHeader" id="patientDashboardHeader" patientId="${patientId}"/>

<link type="text/css" rel="stylesheet"
	href="/openmrs/moduleResources/commonlabtest/css/commonlabtest.css" />
<link type="text/css" rel="stylesheet"
	href="/openmrs/moduleResources/commonlabtest/css/hover.css" />
<link type="text/css" rel="stylesheet"
	href="/openmrs/moduleResources/commonlabtest/css/hover-min.css" />
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
	   <div class="row" >
		    <div class="col-md-3">
		    	 <a style="text-decoration:none" onclick="navigatedToPatientDashboard();" id="addTestSamples" class="hvr-icon-back"><i class="fa fa-chevron-circle-left hvr-icon"></i> <spring:message code="general.backToDashboard" /> </a>
		   </div>
		   <div class="col-md-2">
		    	<a style="text-decoration:none" onclick="navigatedToLabTestSample();" id="addTestSamples" class="hvr-icon-grow"  ><i class="fa fa-plus hvr-icon"></i> <spring:message code="commonlabtest.labtestsample.add" /> </a>
		   </div>
	</div>
	<br>
	<c:if test="${not empty status}">
		<div class="alert alert-success" id="success-alert">
			 <a href="#" class="close" data-dismiss="alert">&times;</a>
	 		<strong>Success!</strong> <c:out value="${status}" />
		</div>
	</c:if>
	<!--List of Test Order  -->
	<div class=" boxHeader" style="background-color: #1aac9b">
			<span></span> <b><spring:message code="commonlabtest.labtestsample.list" /></b>
	 </div>
	 <div class="box">
		 <table id="testSampleTable" class="table table-striped table-bordered" style="width:100%">
	        <thead>
	            <tr>         
					<th>Sample ID</th>
					<th>Specimen Type</th>
					<th>Specimen Site</th>
					<th>Collected On</th>
					<th>Status</th>
					<th hidden="true"></th>
					<th></th>
					<th></th>
				</tr>
	        </thead>
	        <tbody>
	        
		       <c:forEach var="testSample" items="${labSampleTest}">
		          <c:if test="${! empty labSampleTest}">
						<tr>
						   <td><a style="text-decoration:none"  href="${pageContext.request.contextPath}/module/commonlabtest/addLabTestSample.form?testSampleId=${testSample.labTestSampleId}&patientId=${patientId}&orderId=${orderId}" class="hvr-icon-grow"  ><span><i class="fa fa-edit hvr-icon"></i></span>  ${testSample.labTestSampleId}</a></td>
						    <td>${testSample.getSpecimenType().getName()}</td>
						    <td>${testSample.getSpecimenSite().getName()}</td>
						    <td> <fmt:formatDate value="${testSample.collectionDate}" pattern="yyyy-mm-dd" /></td>
						    <td>${testSample.getStatus()}</td>
						    <td hidden ="true" class ="uuid">${testSample.uuid}</td>
							<td>
							<button type="button" onclick="rejection(this)" class="btn  reject" >Reject</button> 
							<%-- <c:choose>
									 <c:when test="${testSample.getStatus()}== 'REJECTED'">
									    <button type="button" class="btn  reject" >Reject</button> 
								        <br />
								    </c:when>    
								    <c:otherwise>
								    	 <button type="button" disabled class="btn  reject" >Reject</button> 
								         <br />
								    </c:otherwise>
							 </c:choose>    --%>
							</td> 
							<td><button type="button" onclick="accept(this)" class="btn  accept" >Accept</button></td> 	
						</tr>
					</c:if>	
				 </c:forEach>
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
              <form method="post" action="${pageContext.request.contextPath}/module/commonlabtest/statuslabtestsample.form" >            
						 <div class="row">
						   <div class="col-md-4">
						   	   <input value="${patientId}" hidden="true"  id="patientId" name="patientId"></input>
						   	   <input value="" hidden="true"  id="uuidReject" name="uuid"></input>
						   	   <input value="0" hidden="true"  id="isAccepted" name="isAccepted"></input>
								<label  class="control-label">Reason<span class="required">*</span></label>
						   </div>
						   <div class="col-md-6">
						   		<input class="form-control" value="" name="rejectedReason" id="rejectedReason" required="required">
						   </div>
						 </div>
						 <!-- Retire -->
						 <div class="row">
						    <div class="col-md-4">
						    </div>
						   <div class="col-md-4">
						 		 <input type="submit"  ></input>
						   </div>
						 </div>
			   </form>			 
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
		
		  $("#success-alert").fadeTo(2000, 1000).slideUp(1000, function(){
              $("#success-alert").slideUp(1000);
               }); 
		
			
	/* 	 $('#testSampleTable td').click(function() {
	    	 //$(this).parents('tr').detach();
		 	
	    	 var $row = $(this).closest("tr");    // Find the row
		     var $tds = $row.find("td:first");
		 	 var id =$tds.text();
			 window.location = "${pageContext.request.contextPath}/module/commonlabtest/addLabTestSample.form?testSampleId="+id +"&pa";
		     
		     
	    }); */
		  
		  
		$('#testSampleTable').dataTable({
			 "bPaginate": true
		  });
		  $('.dataTables_length').addClass('bs-select');
		  
		  
		  /*  
			  $('.accept').click(function () {
				  var uuid = $(this).closest("tr")  
					          .find(".uuid")   
					          .text(); 
				  console.log("UUID : "+uuid);
				  if(uuid != "" || uuid != null){  
						
						  var url = "${pageContext.request.contextPath}/module/commonlabtest/statuslabtestsample.form?patientId="+${patientId}+"&uuid="+uuid; 
						/*   jQuery.getJSON(url, function(result) {
						  console.log(result.length);
						 
						  if(result.length > 0) {
							  jQuery(result).each(function() {
							  });
						  	}
					  });
					  
					  
					  $.ajax({
			                url: '${pageContext.request.contextPath}/module/commonlabtest/statuslabtestsample.form?patientId='+${patientId}+"&isAccepted=1"+"&uuid="+uuid,
			                dataType: 'text',
			                type: 'post',
			                contentType: 'application/json',
			                success: function( data, textStatus, jQxhr ){
			                	 console.log("Success : "+ data ); 
			                	window.location.reload();
			                },
			                error: function( jqXhr, textStatus, errorThrown ){
			                    console.log( errorThrown );
			                }
			            }); 
				  }
				});
			   $('.reject').click(function () {
				 /*  var uuid = $(this).closest("tr")  
								          .find(".uuid")   
								          .text(); 
				  if(uuid != "" || uuid != null){
					  document.getElementById('uuidReject').value = uuid;
					  $('#rejectModal').modal('show'); 
				  }		 
				
				});
		   */
		 
		  
	});
	//Reject the Test S
	function  rejection(rowEl){
		
		 var uuid = $(rowEl).closest("tr")  
					         .find(".uuid")   
					         .text(); 
			if(uuid != "" || uuid != null){
				document.getElementById('uuidReject').value = uuid;
				$('#rejectModal').modal('show'); 
			}		
	}
	
	//Request for accept Test Sample 
	function accept(rowEl){
			var uuid = $(rowEl).closest("tr")  
			          .find(".uuid")   
			          .text(); 
			console.log("UUID : "+uuid);
			if(uuid != "" || uuid != null){  
				
				  var url = "${pageContext.request.contextPath}/module/commonlabtest/statuslabtestsample.form?patientId="+${patientId}+"&uuid="+uuid; 
			  
			  
			  $.ajax({
			        url: '${pageContext.request.contextPath}/module/commonlabtest/statuslabtestsample.form?patientId='+${patientId}+"&isAccepted=1"+"&uuid="+uuid,
			        dataType: 'text',
			        type: 'post',
			        contentType: 'application/json',
			        success: function( data, textStatus, jQxhr ){
			        	 console.log("Success : "+ data ); 
			        	window.location.reload();
			        },
			        error: function( jqXhr, textStatus, errorThrown ){
			            console.log( errorThrown );
			        }
			    }); 
			}
					
	}
	
  function navigatedToLabTestSample(){
	  window.location.href ="${pageContext.request.contextPath}/module/commonlabtest/addLabTestSample.form?patientId="+${patientId}+"&orderId=${orderId}";
  }	
  function navigatedToPatientDashboard(){
	  window.location.href ="${pageContext.request.contextPath}/patientDashboard.form?patientId=${patientId}";  
  }
  
  //On Refereshing the parameter value ...
 	jQuery(function() {

		 if (performance.navigation.type == 1) {
			 window.location.href = "${pageContext.request.contextPath}/module/commonlabtest/manageLabTestSamples.form?patientId="+${patientId}+"&testOrderId="+${orderId};
		 }

		 jQuery("body").keydown(function(e){

		 if(e.which==116){
			 window.location.href = "${pageContext.request.contextPath}/module/commonlabtest/manageLabTestSamples.form?patientId="+${patientId}+"&testOrderId="+${orderId};
		 }

		 });
	 });	

  
</script>




<%@ include file="/WEB-INF/template/footer.jsp"%>
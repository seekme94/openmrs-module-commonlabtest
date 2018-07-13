<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include
	file="/WEB-INF/view/module/commonlabtest/include/localHeader.jsp"%>
<!-- <link type="text/css" rel="stylesheet" href="/openmrs/moduleResources/commonlabtest/css/commonlabtestform.css" /> -->
<link type="text/css" rel="stylesheet"
	href="/openmrs/moduleResources/commonlabtest/css/commonlabtest.css" />
<link
	href="/openmrs/moduleResources/commonlabtest/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" />
<link
	href="/openmrs/moduleResources/commonlabtest/css/bootstrap.min.css"
	rel="stylesheet" />

<style>
body {
	font-size: 12px;
}
</style>

<body>
   
	<c:set var="testAttributeType" scope="session" value="${attributeType}" />

	<c:if test="${empty testAttributeType.name}">
		<div>
			<h2>
				<spring:message code="commonlabtest.labtestattributetype.add" />
			</h2>
		</div>
	</c:if>
	<c:if test="${not empty testAttributeType.name}">
		<div>
			<h2>
				<spring:message code="commonlabtest.labtestattributetype.edit" />
			</h2>
		</div>
	</c:if>
	<div class="box">
		<form:form commandName="attributeType">
			<table>
				<tr> <form:input path="labTestAttributeTypeId"  hidden="true" id="labTestAttributeTypeId"></form:input>				
					<td><form:label path="labTestType"><spring:message code="general.labTestType" /></form:label></td>
					<td><input  placeholder="Search test type..." id="lab_test_type" /></td>
					<td><form:input path="labTestType.labTestTypeId"  hidden="true" id="labTestType" /></td>
				
				</tr>
				<tr>
					<td><form:label path="name"><spring:message code="general.name" /><span class="required">*</span></form:label></td>
					<td><form:input path="name" id="name"></form:input></td>
				</tr>
				<tr>
					<td><form:label path="description"><spring:message code="general.description" /></form:label></td>
					<td><form:textarea path="description" id="description"></form:textarea></td>
				</tr>
				<tr>
					<td><form:label path="minOccurs"><spring:message code="general.minOccurs" /></form:label></td>
					<td><form:input path="minOccurs" id="min_occurs"></form:input></td>
				</tr>
				<tr>
					<td><form:label path="maxOccurs"><spring:message code="general.maxOccurs" /></form:label></td>
					<td><form:input path="maxOccurs" id="max_occurs"></form:input></td>
				</tr>
				<tr>
					<td><form:label path="datatypeClassname"><spring:message code="general.dataType" /></form:label></td>
					<td><form:select path="datatypeClassname" id="data_type_name">
							<form:options items="${datatypes}" />
							<c:forEach items="${datatypes}"  var="datatype">
								<option value="${datatype}" <c:if test="${datatype == status.value}">selected</c:if>><spring:message code="${datatype}.name"/></option>
							</c:forEach>
						</form:select></td>
						<td><span id="datatypeDescription"></span></td>						
				</tr>
				<tr>
					<td><form:label path="datatypeConfig"><spring:message code="general.datatypeConfiguration" /></form:label></td>
					<td><form:textarea path="datatypeConfig" id="datatypeConfig"></form:textarea></td>
				</tr>
				
				<tr>
					<td><form:label path="preferredHandlerClassname"><spring:message code="general.preferredHandler" /></form:label></td>
					<td><form:select path="preferredHandlerClassname" id="preferred_handler_name">
							<form:options items="${handlers}" />
							<c:forEach items="${handlers}"  var="handler">
								<option value="${handler}" <c:if test="${handler == status.value}">selected</c:if>><spring:message code="${handler}.name"/></option>
							</c:forEach>
						</form:select></td>
						<td><span id="handlerDescription"></span></td>
				</tr>
				<tr>
					<td><form:label path="handlerConfig"><spring:message code="general.handlerConfiguration" /></form:label></td>
					<td><form:textarea path="handlerConfig" id="handlerConfig"></form:textarea></td>
				</tr>
				
				
				<c:if test="${not empty testAttributeType.name}">
					<tr>
						<td><form:label path="creator"><spring:message code="general.createdBy" /></form:label></td>
						<td><c:out value="${testAttributeType.creator.personName}" /> - <c:out
								value="${testAttributeType.dateCreated}" /></td>
					</tr>
					<tr>
						<td><font color="#D0D0D0"><sub><spring:message
										code="general.uuid" /></sub></font></td>
						<td><font color="#D0D0D0"><sub><c:out
										value="${testAttributeType.uuid}" /></sub></font></td>
					</tr>
				</c:if>
				<tr>
					<td>
						<div id="saveUpdateButton" style="margin-top: 15px">
							<input type="submit" value="<spring:message code="commonlabtest.labtestattributetype.save" />"></input>
						</div>
					</td>
				</tr>

			</table>

		</form:form>

	</div>
	<br>
	
	<c:if test="${not empty testAttributeType.name}">
		<div class="box">
					<form method="post" action="${pageContext.request.contextPath}/module/commonlabtest/retirelabtestattributetype.form"  >

						<table>
							<tr>
								<td><h2><spring:message code="general.test.retire" /></h2></td>
							</tr>
							<tr>
								<input value="${testAttributeType.uuid}" hidden="true"  id="uuid" name="uuid"></input>

								<td><label path="retireReason"><spring:message code="general.retireReason" /></label></td>
								<td><input value="${testAttributeType.retireReason}" id="retireReason" name="retireReason"></input></td>
							</tr>
							<tr>
								<td>
									<div id="retireButton" style="margin-top: 15px">
										<input type="submit" value="<spring:message code="general.test.retire" />"></input>
									</div>
								</td>
							</tr>
						</table>
				</form>
		</div>	
	</c:if>
	
	<br>
    <c:if test="${not empty testAttributeType.name}">
		<div class="box">
			<form  method="post" action ="${pageContext.request.contextPath}/module/commonlabtest/deletelabtestattributetype.form" onsubmit="return confirmDelete()">
				<table>
				<tr>
					<td><h2><spring:message code="general.foreverDelete" /></h2></td>
				</tr>
				<tr>
					<td>
						<input value="${labTestType.uuid}" hidden="true"  id="uuid" name="uuid"></input>
						<div id="delete" style="margin-top: 15px">
							<input type="submit" value="<spring:message code="general.foreverDelete" />" />
						</div>
					</td>
				</tr>
				</table>
			</form>
		 </div>
	</c:if>
  
</body>

<script
	src="${pageContext.request.contextPath}/moduleResources/commonlabtest/bootstrap/js/jquery-3.3.1.min.js"></script>
<script
	src="${pageContext.request.contextPath}/moduleResources/commonlabtest/bootstrap/js/popper.min.js"></script>
<script
	src="${pageContext.request.contextPath}/moduleResources/commonlabtest/bootstrap/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/moduleResources/commonlabtest/js/jquery-ui.min.js"></script>


<script>
	var local_source;

	jQuery(document).ready(function() {
		 
		local_source = new Array();
	        <c:if test="${not empty listTestType}">
		        <c:forEach var="testType" items="${listTestType}" varStatus="status">
		        	local_source.push({value:"${testType.name}",id:"${testType.labTestTypeId}"});
		        </c:forEach>
	        </c:if>     
	        
	});
	/*autocomplete ...  */
	$(function() {
		 $("#lab_test_type").autocomplete({
			 source : function(request, response) {
				response($.map(local_source, function(item) {
					return {
						value : item.value,
						id:item.id
					}
				}))
			},
			select : function(event, ui) {
				$(this).val(ui.item.value);
				alert(ui.item.id);
				$("#labTestType").val(ui.item.id);
			},
			minLength : 0,
			autoFocus : true
		});	     
	 });
	
	/*Confirmation  Dialog Box  */
	function confirmRetire() {
		//onsubmit="return confirmRetire()"
		if (confirm("Are you sure you want to retire this Test Type? It will be permanently removed from the system.")) {
			return true;
		} else {
			return false;
		}
	}
	
	/*  */
	function confirmDelete() {
		//onsubmit="return confirmDelete()"
		if (confirm("Are you sure you want to retire this Test Type? It will be permanently removed from the system.")) {
			return true;
		} else {
			return false;
		}
	}
	
	
	$j(function() {
		$j('select[name="datatypeClassname"]').change(function() {
			$j('#datatypeDescription').load(openmrsContextPath + '/q/message.form', { key: $j(this).val() + '.description' });
		});
		$j('select[name="preferredHandlerClassname"]').change(function() {
			$j('#handlerDescription').load(openmrsContextPath + '/q/message.form', { key: $j(this).val() + '.description' });  
		});
		<c:if test="${ not empty attributeType.datatypeClassname }">
			$j('#datatypeDescription').load(openmrsContextPath + '/q/message.form', { key: '${ attributeType.datatypeClassname }.description' });
		</c:if>
		<c:if test="${ not empty attributeType.preferredHandlerClassname }">
			$j('#handlerDescription').load(openmrsContextPath + '/q/message.form', { key: '${ attributeType.preferredHandlerClassname }.description' });
		</c:if>
	});
	

</script>
<%@ include file="/WEB-INF/template/footer.jsp"%>
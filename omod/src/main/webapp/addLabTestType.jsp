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

	<c:set var="testType" scope="session" value="${labTestType}" />

	<c:if test="${empty testType.shortName}">
		<div>
			<h2>
				<spring:message code="commonlabtest.labtesttype.add" />
			</h2>
		</div>
	</c:if>
	<c:if test="${not empty testType.shortName}">
		<div>
			<h2>
				<spring:message code="commonlabtest.labtesttype.edit" />
			</h2>
		</div>
	</c:if>
	<div class="box">
		<form:form commandName="labTestType">
			<table>
				<tr>
					<form:input path="labTestTypeId"  hidden="true" id="labTestTypeId"></form:input>
					<td><form:label path="referenceConcept">Reference Concept</form:label></td>

					<td><form:input path="referenceConcept"   id="referenceConcept"></form:input></td>
				</tr>
				<tr>
					<td><form:label path="name">Test Name</form:label></td>
					<td><form:input path="name" id="name"></form:input></td>
				</tr>
				<tr>
					<td><form:label path="shortName">Short Name</form:label></td>
					<td><form:input path="shortName" id="short_name"></form:input></td>
				</tr>
				<tr>
					<td><form:label path="description">Description</form:label></td>
					<td><form:textarea path="description" id="description"></form:textarea></td>
				</tr>
				<tr>
					<td><form:label path="testGroup">Test Group</form:label></td>
					<td><form:select path="testGroup" id="testGroup">
							<form:options items="${LabTestGroup}" />
							<c:forEach items="${LabTestGroup}">
								<option value="${LabTestGroup}">${LabTestGroup}</option>
							</c:forEach>
						</form:select></td>
				</tr>
				<tr>
					<td><form:label path="requiresSpecimen">Requires Specimen</form:label></td>
					<td><form:radiobutton path="requiresSpecimen" value="true" />Yes
						<form:radiobutton path="requiresSpecimen" value="false" />No</td>
				</tr>

				<c:if test="${not empty testType.shortName}">

					<tr>
						<td><form:label path="creator">Created By </form:label></td>
						<td><c:out value="${testType.creator.personName}" /> - <c:out
								value="${testType.dateCreated}" /></td>
					</tr>
					<tr>
						<td><font color="#D0D0D0"><sub><spring:message
										code="general.uuid" /></sub></font></td>
						<td><font color="#D0D0D0"><sub><c:out
										value="${testType.uuid}" /></sub></font></td>
					</tr>
				</c:if>

				<tr>
					<td>
						<div id="saveDeleteButtons" style="margin-top: 15px">
							<input type="submit" value="Submit Test Type"></input>
						</div>
					</td>
				</tr>

			</table>

		</form:form>

	</div>
	<br>
	
	<c:if test="${not empty testType.shortName}">
		<div class="box">
					<form method="post" action="${pageContext.request.contextPath}/module/commonlabtest/retirelabtesttype.form" >

						<table>
							<tr>
								<td><h2>Retire Test Type</h2></td>
							</tr>
							<tr>

								<input value="${labTestType.uuid}" hidden="true"  id="uuid" name="uuid"></input>

								<td><label path="retireReason">Retire Reason</label></td>
								<td><input value="${labTestType.retireReason}" id="retireReason" name="retireReason"></input></td>
							</tr>
							<tr>
								<td>
									<div id="retireButton" style="margin-top: 15px">
										<input type="submit" value="Retire Encounter Type"></input>
									</div>
								</td>
							</tr>
						</table>
				</form>
		</div>	
	</c:if>
	
	<br>
    <c:if test="${not empty testType.shortName}">
		<div class="box">
			<form:form  method="post">
				<table>
				<tr>
					<td><h2>Delete Test Type forever</h2></td>
				</tr>
				<tr>
					<td>
						<div id="delete" style="margin-top: 15px">
							<input type="submit" value="Delete Test Type forever">
						</div>
					</td>
				</tr>
				</table>
			</form:form>
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
	        <c:if test="${empty concepts}">
	        	local_source.push("No customers Found"); 
	        </c:if>         
	        <c:forEach var="concept" items="${concepts}" varStatus="status">
	        	local_source.push({id:"${concept.id}",value:"${concept.name}",description:"${concept.description}" ,shortName : "${concept.shortName}"});
	        </c:forEach>
	        
	       /*  var i;
	        for (i = 0; i < local_source.length; i++) { 
	           alert(local_source[i].description);
	        } */
	        
	});
	/*autocomplete ...  */
	$(function() {
		 $("#referenceConcept").autocomplete({
			 source : function(request, response) {
				response($.map(local_source, function(item) {
					return {
						id : item.id,
						value : item.value,
						shortName: item.shortName,
						description :item.description
					}
				}))
			},
			select : function(event, ui) {
				$(this).val(ui.item.value)
				$("#referenceConcept").val(ui.item.id);
				$("#short_name").val(ui.item.shortName);
				$("#name").val(ui.item.value);
				$("#description").val(ui.item.description);
			},
			minLength : 0,
			autoFocus : true
		});	     
	});
</script>

<%@ include file="/WEB-INF/template/footer.jsp"%>



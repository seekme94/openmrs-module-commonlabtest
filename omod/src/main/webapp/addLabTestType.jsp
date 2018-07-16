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
				    <td><form:label path="referenceConcept"><spring:message code="general.referenceConcept" /></form:label></td>
				    <td><form:input id="conceptSuggestBox" path="referenceConcept" class="capitalize" list="conceptOptions" placeholder="Search Concept..." ></form:input>
						<datalist class="lowercase" id="conceptOptions"></datalist>
				    </td>
				<%-- 	
					<td><input value="${testType.referenceConcept.conceptId}"  id="reference_concept"></input></td>
					<td><form:input path="referenceConcept"  hidden="true"  id="referenceConcept"></form:input></td> --%>
				</tr>
				<tr>
					<td><form:label path="name"><spring:message code="general.testName" /></form:label></td>
					<td><form:input path="name" id="name"></form:input></td>
				</tr>
				<tr>
					<td><form:label path="shortName"><spring:message code="general.shortName" /></form:label></td>
					<td><form:input path="shortName" id="short_name"></form:input></td>
				</tr>
				<tr>
					<td><form:label path="description"><spring:message code="general.description" /></form:label></td>
					<td><form:textarea path="description" id="description"></form:textarea></td>
				</tr>
				<tr>
					<td><form:label path="testGroup"><spring:message code="general.testGroup" /></form:label></td>
					<td><form:select path="testGroup" id="testGroup">
							<form:options items="${LabTestGroup}" />
							<c:forEach items="${LabTestGroup}">
								<option value="${LabTestGroup}">${LabTestGroup}</option>
							</c:forEach>
						</form:select></td>
				</tr>
				<tr>
					<td><form:label path="requiresSpecimen"><spring:message code="general.requiresSpecimen" /></form:label></td>
					<td><form:radiobutton path="requiresSpecimen" value="true" />Yes
						<form:radiobutton path="requiresSpecimen" value="false" />No</td>
				</tr>

				<c:if test="${not empty testType.shortName}">

					<tr>
						<td><form:label path="creator"><spring:message code="general.createdBy" /></form:label></td>
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
						<div id=""saveUpdateButton"" style="margin-top: 15px">
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
								<td><h2><spring:message code="general.test.retire" /></h2></td>
							</tr>
							<tr>
								<input value="${labTestType.uuid}" hidden="true"  id="uuid" name="uuid"></input>

								<td><label path="retireReason"><spring:message code="general.retireReason" /></label></td>
								<td><input value="${labTestType.retireReason}" id="retireReason" name="retireReason"></input></td>
							</tr>
							<tr>
								<td>
									<div id="retireButton" style="margin-top: 15px">
										<input type="submit" value="Retire Test Type"></input>
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
			<form  method="post" action ="${pageContext.request.contextPath}/module/commonlabtest/deletelabtesttype.form" onsubmit="return confirmDelete()">
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
		
		local_source = getConcepts();
	/* 	 console.log(getConcepts());
	
	        <c:if test="${not empty concepts}">
		        <c:forEach var="concept" items="${concepts}" varStatus="status">
		       /*    var conceptDescriptionContainingNewLine = "'${concept.description}'";
		          var conceptDescription =conceptDescriptionContainingNewLine.replace(/(\r\n|\n|\r)/gm, "");
		          alert(conceptDescription); */
		      /*   local_source.push({id:"${concept.id}",value: '${concept.name}' ,description: '${concept.description}' ,shortName : '${concept.shortName}'});
		        </c:forEach>
	        </c:if>      */
	        
	        var datalist = document.getElementById("conceptOptions");
			var dataListLength = datalist.options.length;
			if(dataListLength > 0 ) {
				jQuery("#conceptOptions option").remove();
			}
			
			if(local_source.length > 0) {
				conceptObject = {};
				jQuery(local_source).each(function() {
					var conceptName = toTitleCase(this.name.toLowerCase());
					var shortName = toTitleCase(this.shortName.toLowerCase());
					var description = toTitleCase(this.description.toLowerCase()); 
			            conceptOption = "<option value=\"" + this.id + "\">" + conceptName + "</option>";
			            jQuery('#conceptOptions').append(conceptOption);
			            conceptId = this.id; 
			            conceptObject = {id:conceptId,name: conceptName ,description: description ,shortName : shortName};
			            //conceptObject[conceptId] = drugName;
				});
			}
			
			jQuery('#conceptSuggestBox').on('input', function(){
				
				var val = this.value;
				if(jQuery('#conceptOptions option').filter(function(){
			        return this.value === val;        
			    }).length) {
					var datalist = document.getElementById("conceptOptions");
					var options = datalist.options;
				    jQuery("#name").val(conceptObject["name"]);
				    jQuery("#short_name").val(conceptObject["shortName"]);
				    jQuery("#description").val(conceptObject["description"]);
				}
			});
			
		/* 	jQuery('#drugSetList').change(function() {
				alert("change is called");
			}); */
	        
	        
	        
	});
	
	function toTitleCase(str) {
	    return str.replace(/(?:^|\s)\w/g, function(match) {
	        return match.toUpperCase();
	    });
	}
	
	 //get all concepts
	 function getConcepts(){
	    	return JSON.parse(JSON.stringify(${conceptsJson}));
	    }
	
	/* /*autocomplete ...  */
	/* $(function() {
		 $("#reference_concept").autocomplete({
			 source : function(request, response) {
				response($.map(local_source, function(item) {
					console.log(item);
					return {
						id : item.id,
						value : item.name,
						/* shortName: item.shortName,
						description :item.description  
					}
				}))
			},
	   	select : function(event, ui) {
				$(this).val(ui.item.value)
				//document.getElementById('referenceConcept').value = '';
				/* $("#referenceConcept").val(ui.item.id);
				$("#short_name").val(ui.item.shortName);
				$("#name").val(ui.item.value);
				$("#description").val(ui.item.description); */
				/*  event.preventDefault();
			},
			minLength : 3,
			autoFocus : false
		});	     
	});   */
	
	/*  */
	function confirmDelete() {
		//onsubmit="return confirmDelete()"
		if (confirm("Are you sure you want to Delete this Test Type? It will be permanently removed from the system.")) {
			return true;
		} else {
			return false;
		}
	}
	
</script>

<%@ include file="/WEB-INF/template/footer.jsp"%>



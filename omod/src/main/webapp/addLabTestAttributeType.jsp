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
input[type=submit] {
	background-color: #1aac9b;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	
}
#saveUpdateButton {
    text-align: center;
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
</style>

<body>
 <div class="container">
    
	<c:set var="testAttributeType" scope="session" value="${attributeType}" />
	<fieldset  class="scheduler-border">
	   <c:if test="${empty testAttributeType.name}">
		 <legend  class="scheduler-border"><spring:message code="commonlabtest.labtestattributetype.add" /></legend>
	   </c:if>
	   <c:if test="${not empty testAttributeType.name}">
		 <legend  class="scheduler-border">	<spring:message code="commonlabtest.labtestattributetype.edit" /></legend>
	   </c:if>
 	   <form:form commandName="attributeType">
			<table>
				 <div class="form-group">
				     <tr> <form:input path="labTestAttributeTypeId"  hidden="true" id="labTestAttributeTypeId"></form:input>				
					   <td><form:label path="labTestType" class="control-label"><spring:message code="general.labTestType" /></form:label></td>
					   <div class="col-md-6">
					    <td><form:input class="form-control"  id="testTypeSuggestBox" path="labTestType.labTestTypeId" list="testTypeOptions" placeholder="Search Test Type..." ></form:input>
						<datalist class="lowercase" id="testTypeOptions"></datalist>
				   		 </td>		  
						<%-- 	<td><input class="form-control"  value="${testAttributeType.labTestType.labTestTypeId}" required="required" placeholder="Search test type..." id="lab_test_type"  /></td>
							<td><form:input path="labTestType.labTestTypeId"  hidden="true" id="labTestType"  /></td>
					  --%>     
						</div>
					 </tr>
				 </div>
				 <div class="form-group">
					<tr>
						<td><form:label path="name" class="control-label"><spring:message code="general.name" /><span class="required">*</span></form:label></td>
						  <div class="col-md-6">
							<td><form:input class="form-control" path="name" id="name" required="required" ></form:input></td>
						  </div>
					</tr>
				</div>
				<div class="form-group">	
					<tr>
						<td><form:label path="description" class="control-label"><spring:message code="general.description" /></form:label></td>
						<td><form:textarea class="form-control" path="description" id="description" required="required"></form:textarea></td>
					</tr>
				</div>
				<div class="form-group">	
					<tr>
						<td><form:label path="minOccurs" class="control-label"><spring:message code="general.minOccurs" /></form:label></td>
						<td><form:input class="form-control" path="minOccurs" id="min_occurs" required="required"></form:input></td>
					</tr>
				</div>
				<div class="form-group">	
					<tr>
						<td><form:label path="maxOccurs" class="control-label"><spring:message code="general.maxOccurs" /></form:label></td>
						<td><form:input  class="form-control" path="maxOccurs" id="max_occurs" required="required"></form:input></td>
					</tr>
				</div>
				<div class="form-group">	
					<tr>
						<td><form:label path="datatypeClassname" class="control-label"><spring:message code="general.dataType" /></form:label></td>
						<td><form:select class="form-control" path="datatypeClassname" id="data_type_name">
								<form:options items="${datatypes}" />
								<c:forEach items="${datatypes}"  var="datatype">
									<option value="${datatype}" <c:if test="${datatype == status.value}">selected</c:if>><spring:message code="${datatype}.name"/></option>
								</c:forEach>
							</form:select></td>
							<td><span id="datatypeDescription"></span></td>						
					</tr>
				</div>
				<div class="form-group">	
				<tr>
					<td><form:label path="datatypeConfig" class="control-label"><spring:message code="general.datatypeConfiguration" /></form:label></td>
					<td><form:textarea class="form-control" path="datatypeConfig" id="datatypeConfig" required="required"></form:textarea></td>
				</tr>
				</div>
				<div class="form-group">	
				<tr>
					<td><form:label path="preferredHandlerClassname" class="control-label"><spring:message code="general.preferredHandler" /></form:label></td>
					<td><form:select class="form-control" path="preferredHandlerClassname" id="preferred_handler_name">
							<form:options items="${handlers}" />
							<c:forEach items="${handlers}"  var="handler">
								<option value="${handler}" <c:if test="${handler == status.value}">selected</c:if>><spring:message code="${handler}.name"/></option>
							</c:forEach>
						</form:select></td>
						<td><span id="handlerDescription"></span></td>
				</tr>
				</div>
				<div class="form-group">	
				<tr>
					<td><form:label class="control-label" path="handlerConfig"><spring:message code="general.handlerConfiguration" /></form:label></td>
					<td><form:textarea class="form-control" path="handlerConfig" id="handlerConfig" required="required"></form:textarea></td>
				</tr>
				</div>
				
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
						<div id="saveUpdateButton"  style="margin-top: 15px;text-align: center;">
							<input type="submit" value="<spring:message code="commonlabtest.labtestattributetype.save" />"></input>
						</div>
					</td>
				</tr>

			</table>

		 </form:form>
    </fieldset>
	<br>
	<c:if test="${not empty testAttributeType.name}">
		 <fieldset  class="scheduler-border">
      	   <legend  class="scheduler-border"><spring:message code="general.test.retire" /></legend>
      	 		<form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/module/commonlabtest/retirelabtestattributetype.form"  >

						<table>
							 <div class="form-group">
								<tr>
									<input value="${testAttributeType.uuid}" hidden="true"  id="uuid" name="uuid"></input>
									<td><label class="control-label" value="retireReason"><spring:message code="general.retireReason" /></label></td>
									<td><input class="form-control" value="${testAttributeType.retireReason}" id="retireReason" name="retireReason" required="required"></input></td>
								</tr>
							</div>
							<tr>
								<td>
									<div id="retireButton" style="margin-top: 15px">
										<input type="submit" value="<spring:message code="general.test.retire" />"></input>
									</div>
								</td>
							</tr>
						</table>
				</form>
        </fieldset>
	</c:if>
	
	<br>
    <c:if test="${not empty testAttributeType.name}">
		 <fieldset  class="scheduler-border">
      	   <legend  class="scheduler-border"><spring:message code="general.foreverDelete" /></legend>
				<form  method="post" action ="${pageContext.request.contextPath}/module/commonlabtest/deletelabtestattributetype.form" onsubmit="return confirmDelete()">
					<table>
					<tr>
						<td>
							<input value="${testAttributeType.uuid}" hidden="true"  id="uuid" name="uuid"></input>
							<div id="delete" style="margin-top: 15px">
								<input type="submit" value="<spring:message code="general.foreverDelete" />" />
							</div>
						</td>
					</tr>
					</table>
				</form>
      </fieldset>
	</c:if>
 </div>
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
		        	local_source.push({name:"${testType.name}",id:"${testType.labTestTypeId}"});
		        </c:forEach>
	        </c:if>     
	      
	        var datalist = document.getElementById("testTypeOptions");
			var dataListLength = datalist.options.length;
			if(dataListLength > 0 ) {
				jQuery("#testTypeOptions option").remove();
			}
			
			if(local_source.length > 0) {
				testTypeObject = {};
				jQuery(local_source).each(function() {
					var testTypeName = toTitleCase(this.name.toLowerCase());
			            testTypeOption = "<option value=\"" + this.id + "\">" + testTypeName + "</option>";
			            jQuery('#testTypeOptions').append(testTypeOption);
			            testTypeId = this.id; 
			            testTypeObject = {testTypeId,name: testTypeName};
			            //testTypeObject[conceptId] = drugName;
				});
			}
			
			jQuery('#testTypeSuggestBox').on('input', function(){
				
				var val = this.value;
				if(jQuery('#testTypeOptions option').filter(function(){
			        return this.value === val;        
			    }).length) {
					var datalist = document.getElementById("testTypeOptions");
					var options = datalist.options;
				}
			});   
	        
	        
   
	        
	});
	
	function toTitleCase(str) {
	    return str.replace(/(?:^|\s)\w/g, function(match) {
	        return match.toUpperCase();
	    });
	}
	
	/* /*autocomplete ...  */
	/* $(function() {
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
				$("#labTestType").val(ui.item.id);
			},
			minLength : 0,
			autoFocus : true
		});	     
	 }); */
	
	
	
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
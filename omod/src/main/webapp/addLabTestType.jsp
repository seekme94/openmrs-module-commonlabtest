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

<div>
    <h2>
        <spring:message code="commonlabtest.labtesttype.add" />
    </h2>
</div>
<br>
<div class="card-header boxHeader" style="background-color: #1aac9b">
    <b><spring:message code="commonlabtest.labtesttype.add" /></b>
</div>
<div class="box">
    <form:form commandName="labTestType">
        <table>
            <tr>
                <td><form:label path="referenceConcept">Reference Concept</form:label></td>
                <td><form:input path="referenceConcept" id="ref_concept"></form:input></td>
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
                <td><form:textarea path="description"></form:textarea></td>
            </tr>
            <tr>
                <td><form:label path="testGroup">Test Group</form:label></td>
                <td><form:select path="testGroup" id="testGroup">
                    <form:options items="${LabTestGroup}" />
                    <%--  <c:forEach items="${LabTestGroup}">
                        <option value="${LabTestGroup}">${LabTestGroup}</option>
                      </c:forEach> --%>
                </form:select></td>
            </tr>
            <tr>
                <td><form:label path="requiresSpecimen">Requires Specimen</form:label></td>
                <td><form:radiobutton path="requiresSpecimen" value="true" />Yes
                    <form:radiobutton path="requiresSpecimen" value="false" />No</td>
            </tr>
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

<%--

<c:set var="testType" scope="session" value="${labTestType}"/>

<p>Your test Type is : <c:out value="${labTestType}"/></p>
<c:choose>
    <c:when test="${ empty labTestType}">

		<div>
			<h2>
				<spring:message code="commonlabtest.labtesttype.add" />
			</h2>
		</div>
		<br>
		<div class="card-header boxHeader" style="background-color: #1aac9b">
			<b><spring:message code="commonlabtest.labtesttype.add" /></b>
		</div>
		<div class="box">
			<form:form commandName="labTestType">
				<table>
					<tr>
						<td><form:label path="referenceConcept">Reference Concept</form:label></td>
						<td><form:input path="referenceConcept" id="ref_concept"></form:input></td>
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
						<td><form:textarea path="description"></form:textarea></td>
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
    </c:when>
    <c:when test="${not empty labTestType}">
	       <div>
				<h2>
					<spring:message code="commonlabtest.labtesttype.edit" />
				</h2>
			</div>
			<br>
	        <div class="card-header boxHeader" style="background-color: #1aac9b">
				<b><spring:message code="commonlabtest.labtesttype.edit" /></b>
			</div>
	        <div class="box">
	        	<form:form commandName="labTestType">
					<table>
						<tr>
							<td><form:label path="referenceConcept">Reference Concept</form:label></td>
							<td><form:input path="referenceConcept" id="ref_concept"></form:input></td>
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
							<td><form:textarea path="description"></form:textarea></td>
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
    </c:when>
    <c:otherwise>
       test Type is undetermined...
    </c:otherwise>
</c:choose>

 --%>

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
    var local_list = [ {
        id : 1,
        value : "aggg"
    }, {
        id : 2,
        value : "bgg"
    }, {
        id : 3,
        value : "vg"
    }, {
        id : 4,
        value : "cf"
    }, {
        id : 5,
        value : "se"
    }, {
        id : 6,
        value : "tf"
    } ];

    $(function() {
        $("#ref_concept").autocomplete({
            source : function(request, response) {
                response($.map(local_list, function(item) {
                        return {
                            id : item.id,
                            value : item.value
                        }
                    }
                ))
            },
            select : function(event, ui) {
                $(this).val(ui.item.value)
                $("#short_name").val(ui.item.id);
            },
            minLength : 0,
            autoFocus : true
        });
    });
</script>

<%@ include file="/WEB-INF/template/footer.jsp"%>



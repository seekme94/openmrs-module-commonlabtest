<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="/WEB-INF/view/module/commonlabtest/include/localHeader.jsp"%>


<!-- <link type="text/css" rel="stylesheet" href="/openmrs/moduleResources/commonlabtest/css/commonlabtestform.css" /> -->
<link type="text/css" rel="stylesheet" href="/openmrs/moduleResources/commonlabtest/css/commonlabtest.css" />
<link   href="/openmrs/moduleResources/commonlabtest/font-awesome/css/font-awesome.min.css" rel="stylesheet" /> 
<link   href="/openmrs/moduleResources/commonlabtest/css/bootstrap.min.css" rel="stylesheet" />

<style>
 body{
    font-size: 12px;
 }

</style>
 
<div>
	<h2>
      <spring:message code="commonlabtest.labtesttype.add" />
	</h2>
</div>
<br>

 <!--Form -->
 
 
	<div class="container">
	<div class="card-header boxHeader" style="background-color: #1aac9b">
   			 <b><spring:message code="commonlabtest.labtesttype.add" /></b>
	 </div>
	 <div class="box">

	<frm:form commandName="schema" method="post">
	<%-- <form id="saveTestType" name="saveTestType" method="post" >
	--%>		<table>
				<tr>
					<td><label for ="referenceconcept">Reference Concept</label></td>
					<td> <frm:input path="form.referenceConcept.name" size="50"/></td>
					<td><input type="text" id="referenceConcept" name="referenceConcept" placeholder="Concept..." value="${labTestType.referenceConcept.name}" required > </td>
				</tr>
				
				<tr>
				  <td><label for="testname">Test Name</label></td>
					<td> <frm:input path="form.name" size="50"/></td>
				  <td><input type="text" id="testName" name="testName"  value="${labTestType.name}" placeholder="Test name.." required > </td>
				</tr>
				<tr>
				  <td><label for="shortname">Short Name</label></td>
					<td> <frm:input path="form.shortName" size="50"/></td>
				  <td><input type="text" id="shortname" name="shortName" value="${labTestType.shortName}" placeholder="Short name.." required > </td>
				</tr>
				<tr>
				  <td><label for="description">Description</label></td>
					<td> <frm:input path="form.discription" size="50"/></td>
				  <td><textarea class="form-control" rows="3" id="discription" value="${labTestType.description}"></textarea> </td>
				</tr>
				<tr>
				  <td><label for="testgroup">Test Group</label></td>
				  <td>
				<%--	<select name="testGroup" id="testGroup">
				              <c:forEach items="${labTestType.listTestGroup}" var="q">
								<option value="${q}">${q}</option>
							  </c:forEach>
				    </select>--%>
				   </td>
				</tr>
				<tr>
					<td><label for="requirespecimen">Requires Specimen</label></td>
					<td><input type="radio" name="addSpecimen" id="specimen-Y" value="Yes" ><label for="specimen-Y"> Yes </label>
					<input type="radio" name="addSpecimen" id="specimen-N" value="No" ><label for="specimen-N"> No </label>

					</td>
				</tr>
				
				<tr>
					 <td>
						 <div id="saveDeleteButtons" style="margin-top: 15px">
							<input type="submit" value="Submit Test Type">
						 </div>
					 </td>
				</tr>
			
		  </table>
	    
		</frm:form>
	</div> 
</div>
<%@ include file="/WEB-INF/template/footer.jsp"%>



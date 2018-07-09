<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include
	file="/WEB-INF/view/module/commonlabtest/include/localHeader.jsp"%>
<link type="text/css" rel="stylesheet" href="/openmrs/moduleResources/commonlabtest/css/commonlabtest.css" />
<link type="text/css" rel="stylesheet" href="/openmrs/moduleResources/commonlabtest/css/commonlabtestform.css" />
<link   href="/openmrs/moduleResources/commonlabtest/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
<style>
 body{
    font-size: 12px;
 }

</style>
<script type="text/javascript">
    jQuery(document).ready(function() {
    });
</script>


<h2>
	<b><spring:message code="commonlabtest.labtestattributetype.manage" /></b>
</h2>
<br>
<div>
  <a href="addLabTestAttributeType.form"> <spring:message code="commonlabtest.labtestattributetype.view" /></a>
</div>
<br>
<div class="boxHeader">
	<b><spring:message code="commonlabtest.labtestattributetype.list" /></b>
</div>

<form  class="box">
	<table id="labtesttype_tb">
		<thead>
			<tr>
				<th>Attribute Type</th>
				<th>Datatype</th>
				<th>Description</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${labTestAttributeTypes}" var="at">
				<tr>
					<td>${at.name}</td>
					<td>${at.datatype}</td>
					<td>${at.description}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</form>


<%@ include file="/WEB-INF/template/footer.jsp"%>
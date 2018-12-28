package org.openmrs.module.commonlabtest;

import static org.junit.Assert.*;
import static org.hamcrest.core.Is.is;

import org.apache.commons.beanutils.PropertyUtils;
import org.junit.Before;
import org.junit.Test;
import org.openmrs.api.context.Context;
import org.openmrs.module.commonlabtest.api.CommonLabTestService;
import org.openmrs.module.webservices.rest.SimpleObject;
import org.openmrs.module.webservices.rest.web.v1_0.controller.MainResourceControllerTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

public class LabTestAttributeResourceControllerTemp extends
		MainResourceControllerTest {

	@Autowired
	CommonLabTestService commonLabTestService;

	@Before
	public void setUp() throws Exception {
		// executeDataSet("CommonLabTestService-initialData.xml");
	}

	@Override
	public long getAllCount() {
		return 2;
	}

	@Override
	public String getURI() {
		return "commonlab/labtestattribute";
	}

	@Override
	public String getUuid() {
		return "ecf166e5-478e-11e8-943c-40b034c3cfee";
	}

	@Test
	public void shouldSave() throws Exception {
		String valueReference = "New description";
		// SimpleObject post = new SimpleObject().add("valueReference",
		// valueReference).add("testOrderId",
		// "53f4f719-4357-4af2-9c97-613bf668b61c").add("attributeTypeId",
		// "baff7cbc-a54d-4db9-993e-6472c3572bbe");

		String labTestAttributeTestData = "{\"labTest\":\"53f4f719-4357-4af2-9c97-613bf668b61c\","
				+ "\"labTestAttributeType\":\"baff7cbc-a54d-4db9-993e-6472c3572bbe\","
				+ "\"valueReference\":\"Test Data ref\"}";

		String uri = getURI();
		MockHttpServletRequest newPostRequest = newPostRequest(uri, labTestAttributeTestData);
		MockHttpServletResponse handle = handle(newPostRequest);
		Object objectCreated = deserialize(handle);

		LabTestAttribute labTestAttribute = new LabTestAttribute();
		LabTest labTest = Context.getService(CommonLabTestService.class)
				.getLabTest(200);
		LabTestAttributeType labTestAttributeType = Context.getService(
				CommonLabTestService.class).getLabTestAttributeType(2);
		labTestAttribute.setLabTest(labTest);
		labTestAttribute.setAttributeTypeId(labTestAttributeType);
		MockHttpServletRequest request = newPostRequest(getURI(),
				labTestAttribute);
		SimpleObject result = deserialize(handle(request));
		assertThat((String) result.get("valueReference"), is(valueReference));

	}

}

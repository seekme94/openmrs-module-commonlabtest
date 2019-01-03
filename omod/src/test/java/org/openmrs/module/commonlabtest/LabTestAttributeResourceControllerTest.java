package org.openmrs.module.commonlabtest;

import org.junit.Before;
import org.openmrs.api.context.Context;
import org.openmrs.module.commonlabtest.api.CommonLabTestService;
import org.openmrs.module.commonlabtest.web.resource.LabTestAttributeResourceController;
import org.openmrs.module.webservices.rest.web.resource.impl.BaseDelegatingResourceTest;

public class LabTestAttributeResourceControllerTest extends BaseDelegatingResourceTest<LabTestAttributeResourceController, LabTestAttribute> {
	
	@Before
	public void setup() throws Exception {
		executeDataSet("CommonLabTestService-initialData.xml");
	}
	
	@Override
	public String getDisplayProperty() {
		return "1301";
	}
	
	@Override
	public String getUuidProperty() {
		return "2c9737d9-47c2-11e8-943c-40b034c3cfee";
	}
	
	@Override
	public LabTestAttribute newObject() {
		return Context.getService(CommonLabTestService.class).getLabTestAttributeByUuid(getUuidProperty());
	}
	
	@Override
	public void validateRefRepresentation() throws Exception {
		super.validateRefRepresentation();
		assertPropEquals("voided", null);
	}
	
	@Override
	public void validateDefaultRepresentation() throws Exception {
		super.validateDefaultRepresentation();
		/*	assertPropEquals("labTestAttributeId", getObject().getAttributeType());
			assertPropEquals("testOrderId", getObject().getTestOrderId());
			assertPropEquals("valueReference", getObject().getValueReference());*/
	}
	
	@Override
	public void validateFullRepresentation() throws Exception {
		super.validateFullRepresentation();
		/*		assertPropEquals("labTestAttributeId", getObject().getAttributeTypeId());
				assertPropEquals("testOrderId", getObject().getTestOrderId());
				assertPropEquals("valueReference", getObject().getValueReference());
				
				assertPropEquals("dateCreated", getObject().getDateCreated());
				
				assertPropEquals("changedBy", getObject().getChangedBy());
				assertPropEquals("dateChanged", getObject().getDateChanged());
				
				assertPropEquals("voided", getObject().getVoided());*/
		
	}
	
}

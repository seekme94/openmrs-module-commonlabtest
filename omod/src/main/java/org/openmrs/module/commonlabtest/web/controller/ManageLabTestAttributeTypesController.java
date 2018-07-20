package org.openmrs.module.commonlabtest.web.controller;

import java.util.List;

import javax.naming.Context;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.CareSetting;
import org.openmrs.Concept;
import org.openmrs.Encounter;
import org.openmrs.Patient;
import org.openmrs.TestOrder;
import org.openmrs.api.OrderContext;
import org.openmrs.module.commonlabtest.LabTestAttributeType;
import org.openmrs.module.commonlabtest.api.CommonLabTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value = "/module/commonlabtest/manageLabTestAttributeTypes.form")
public class ManageLabTestAttributeTypesController {
	
	/** Success form view name */
	private final String SUCCESS_FORM_VIEW = "/module/commonlabtest/manageLabTestAttributeTypes";
	
	/** Logger for this class */
	protected final Log log = LogFactory.getLog(getClass());
	
	@Autowired
	CommonLabTestService commonLabTestService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String showLabTestAttributeTypes(@RequestParam(required = false) String status, ModelMap model) {
		List<LabTestAttributeType> list = commonLabTestService.getAllLabTestAttributeTypes(Boolean.FALSE);
		//saveOrder();
		model.put("labTestAttributeTypes", list);
		model.addAttribute("status", status);
		return SUCCESS_FORM_VIEW;
	}
	
	public void saveOrder() {
		System.out.println("Sa=============================================");
		Patient patient = org.openmrs.api.context.Context.getPatientService().getPatient(1299);
		
		System.out.println("Patient Name : " + patient.getGivenName());
		OrderContext context = new OrderContext();
		TestOrder testOrder = new TestOrder();
		testOrder.setPatient(patient);
		
		Concept conceptncept = org.openmrs.api.context.Context.getConceptService().getConcept(12);
		System.out.println("Concept Name : " + conceptncept.getDisplayString());
		//testOrder.setSpecimenSource(conceptncept);
		List<Encounter> encounter = org.openmrs.api.context.Context.getEncounterService().getEncountersByPatient(patient);
		testOrder.setEncounter(encounter.get(0));
		
		testOrder.setOrderer(org.openmrs.api.context.Context.getProviderService().getProvider(7));
		//CareSetting careSetting = new CareSetting();
		CareSetting carConcept = org.openmrs.api.context.Context.getOrderService().getCareSettingByName("Inpatient");
		System.out.println("Care Settting  : " + carConcept.getName());
		
		testOrder.setOrderId(2);
		testOrder.setConcept(conceptncept);//test Type Id ..
		testOrder.setCareSetting(carConcept);
		testOrder.setOrderReason(conceptncept);//Test Type 
		System.out.println("Save : " + org.openmrs.api.context.Context.getOrderService().saveOrder(testOrder, context));
		
	}
	
}

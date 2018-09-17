package org.openmrs.module.commonlabtest.web.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Encounter;
import org.openmrs.api.context.Context;
import org.openmrs.module.commonlabtest.LabTest;
import org.openmrs.module.commonlabtest.LabTestType;
import org.openmrs.module.commonlabtest.LabTestType.LabTestGroup;
import org.openmrs.module.commonlabtest.api.CommonLabTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Controller
public class LabTestRequestController {
	
	protected final Log log = LogFactory.getLog(getClass());
	
	private final String SUCCESS_ADD_FORM_VIEW = "/module/commonlabtest/addLabTestRequest";
	
	CommonLabTestService commonLabTestService;
	
	@Autowired
	public LabTestRequestController(CommonLabTestService commonLabTestService) {
		this.commonLabTestService = commonLabTestService;
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/module/commonlabtest/addLabTestRequest.form")
	public String showForm(HttpServletRequest request, @RequestParam(required = false) String error,
	        @RequestParam(required = false) Integer patientId, ModelMap model) {
		
		JsonArray testParentArray = new JsonArray();
		
		for (LabTestGroup labTestGroup : LabTestGroup.values()) {
			JsonObject labTestGroupObj = new JsonObject();
			JsonArray jsonChildArray = new JsonArray();
			if (labTestGroup.equals(LabTestGroup.OTHER)) {
				continue;
			}
			List<LabTestType> labTestTypeList = commonLabTestService.getLabTestTypes(null, null, labTestGroup, null, null,
			    Boolean.FALSE);
			if (labTestTypeList.equals("") || labTestTypeList.isEmpty()) {
				continue; //skip the current iteration.
			}
			labTestGroupObj.addProperty("testGroup", labTestGroup.name());
			for (LabTestType labTestType : labTestTypeList) {
				JsonObject labTestTyeChild = new JsonObject();
				labTestTyeChild.addProperty("testTypeId", labTestType.getId());
				labTestTyeChild.addProperty("testTypeName", labTestType.getName());
				jsonChildArray.add(labTestTyeChild);
			}
			labTestGroupObj.add("testType", jsonChildArray);
			testParentArray.add(labTestGroupObj);
		}
		List<Encounter> encounterList = Context.getEncounterService().getEncountersByPatientId(patientId);
		if (encounterList.size() > 0) {
			Collections.sort(encounterList, new Comparator<Encounter>() {
				
				@Override
				public int compare(Encounter o1, Encounter o2) {
					return o2.getEncounterDatetime().compareTo(o1.getEncounterDatetime());
				}
			});
		}
		
		if (encounterList.size() > 10) {
			model.addAttribute("encounters", encounterList.subList(0, encounterList.size() - 1));
		} else {
			model.addAttribute("encounters", encounterList);
		}
		model.addAttribute("labTestTypes", testParentArray);
		model.addAttribute("patientId", patientId);
		
		return SUCCESS_ADD_FORM_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/addLabTestRequest.form")
	public String onSubmit(ModelMap model, HttpSession httpSession,
	        @ModelAttribute("anyRequestObject") Object anyRequestObject, HttpServletRequest request,
	        @ModelAttribute("labTest") LabTest labTest, String json) {
		
		System.out.println(json);
		Object generalObj = anyRequestObject;
		String status = "";
		try {
			
			/*			LabTestType lbTestType =  Context.getService(CommonLabTestService.class).getLabTestType(labTest.getLabTestType().getLabTestTypeId());
					Concept referConcept = lbTestType.getReferenceConcept();
					
					TestOrder testOrder;
					if (labTest.getOrder().getId() != null) {
						testOrder = (TestOrder) labTest.getOrder();
					} else {
						
						testOrder = new TestOrder();
					}
					
					// execute this when order and lab test are null
					testOrder.setCareSetting(labTest.getOrder().getCareSetting());
					testOrder.setConcept(referConcept);
					testOrder.setEncounter(labTest.getOrder().getEncounter());
					testOrder.setPatient(labTest.getOrder().getPatient());
					testOrder.setOrderer(labTest.getOrder().getOrderer());
					testOrder.setOrderType(labTest.getOrder().getOrderType());
					testOrder.setDateActivated(new java.util.Date());
					testOrder.setOrderId(labTest.getOrder().getOrderId());
					
					Order testParentOrder = testOrder;
					labTest.setOrder(testParentOrder);
					if (labTest.getTestOrderId() == null) {
						Order testParentOrder = labTest.getOrder();
						testParentOrder.setDateActivated(new java.util.Date());
						labTest.setOrder(testParentOrder);
					}
					commonLabTestService.saveLabTest(labTest);
					StringBuilder sb = new StringBuilder();
					sb.append("Lab Test Order with Uuid :");
					sb.append(labTest.getUuid());
					sb.append(" is  saved!");
					status = sb.toString();*/
		}
		catch (Exception e) {
			status = "could not save Lab Test Order";
			e.printStackTrace();
			model.addAttribute("error", status);
			if (labTest.getTestOrderId() == null) {
				return "redirect:addLabTestOrder.form?patientId=" + labTest.getOrder().getPatient().getPatientId();
			} else {
				return "redirect:addLabTestOrder.form?patientId=" + labTest.getOrder().getPatient().getPatientId()
				        + "&testOrderId=" + labTest.getTestOrderId();
			}
		}
		//request.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR, "Test order saved successfully");
		//model.addAttribute("status", status);
		return SUCCESS_ADD_FORM_VIEW; //"redirect:../../patientDashboard.form?patientId=" + labTest.getOrder().getPatient().getPatientId();
	}
	
}

package org.openmrs.module.commonlabtest.web.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Concept;
import org.openmrs.Encounter;
import org.openmrs.Order;
import org.openmrs.TestOrder;
import org.openmrs.api.context.Context;
import org.openmrs.module.commonlabtest.LabTest;
import org.openmrs.module.commonlabtest.LabTestType;
import org.openmrs.module.commonlabtest.api.CommonLabTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Controller
public class LabTestOrderController {
	
	protected final Log log = LogFactory.getLog(getClass());
	
	private final String SUCCESS_ADD_FORM_VIEW = "/module/commonlabtest/addLabTestOrder";
	
	@Autowired
	CommonLabTestService commonLabTestService;
	
	@RequestMapping(method = RequestMethod.GET, value = "/module/commonlabtest/addLabTestOrder.form")
	public String showLabTestTypes(@RequestParam(required = true) Integer patientId,
	        @RequestParam(required = false) Integer testOrderId, ModelMap model) {
		LabTest test;
		if (testOrderId == null) {
			test = new LabTest();
		} else {
			test = commonLabTestService.getLabTest(testOrderId);
		}
		//Patient patient =Context.getPatientService().getPatient(patientId);
		
		List<Encounter> list = Context.getEncounterService().getEncountersByPatientId(patientId);
		list.get(0).getEncounterType().getName();
		if (list.size() > 0) {
			Collections.sort(list, new Comparator<Encounter>() {
				
				@Override
				public int compare(Encounter o1, Encounter o2) {
					return o2.getEncounterDatetime().compareTo(o1.getEncounterDatetime());
				}
			});
			/*for (Encounter e : list.subList(0, list.size() - 1)) {
				System.out.println(e.getEncounterDatetime());
			}*/
		}
		List<LabTestType> testType = commonLabTestService.getAllLabTestTypes(Boolean.FALSE);
		
		model.addAttribute("labTest", test);
		model.addAttribute("patientId", patientId);
		model.addAttribute("testTypes", testType);
		model.addAttribute("provider",
		    Context.getProviderService().getProvidersByPerson(Context.getAuthenticatedUser().getPerson(), false).iterator()
		            .next());
		if (list.size() > 10) {
			model.addAttribute("encounters", list.subList(0, list.size() - 1));
		} else {
			model.addAttribute("encounters", list);
		}
		
		return SUCCESS_ADD_FORM_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/addLabTestOrder.form")
	public String onSubmit(ModelMap model, HttpSession httpSession,
	        @ModelAttribute("anyRequestObject") Object anyRequestObject, HttpServletRequest request,
	        @ModelAttribute("labTest") LabTest labTest, BindingResult result) {
		String status = "";
		/*try {
			if (result.hasErrors()) {
				
			} else {*/
		
		/*	Encounter encounter = labTest.getOrder().getEncounter();
			Order order = new Order();
			order.setConcept(Context.getConceptService().getConcept(165737));
			order.setOrderer(Context.getProviderService()
			        .getProvidersByPerson(Context.getAuthenticatedUser().getPerson(), false).iterator().next());
			order.setCareSetting(Context.getOrderService().getCareSetting(1));
			order.setEncounter(encounter);
			order.set
			
			labTest.setOrder(order);
			labTest.setLabTestType(commonLabTestService.getLabTestType(3));
			*/
		System.out.println("============ ORDER ==========");
		System.out.println("Encounter : " + labTest.getOrder().getEncounter().getEncounterId());
		
		System.out.println("============ ORDER 2==========");
		System.out.println("Care Setting : " + labTest.getOrder().getCareSetting());
		
		System.out.println("============ ORDER 3 ==========");
		System.out.println("lab Test Type: " + labTest.getLabTestType());
		
		System.out.println("============ ORDER 4 ==========");
		//System.out.println("Order Type: " + labTest.getOrder().getOrderType());
		
		LabTestType lbTestType = commonLabTestService.getLabTestType(labTest.getLabTestType().getLabTestTypeId());
		Concept referConcept = lbTestType.getReferenceConcept();
		System.out.println("Checking referece concept :::: " + referConcept.getDisplayString() + "   "
		        + referConcept.getId());
		
		TestOrder testOrder = new TestOrder();
		testOrder.setCareSetting(labTest.getOrder().getCareSetting());
		testOrder.setConcept(referConcept);
		testOrder.setEncounter(labTest.getOrder().getEncounter());
		testOrder.setPatient(labTest.getOrder().getPatient());
		testOrder.setOrderer(labTest.getOrder().getOrderer());
		Order testParentOrder = testOrder;
		
		labTest.setOrder(testParentOrder);
		
		commonLabTestService.saveLabTest(labTest);
		StringBuilder sb = new StringBuilder();
		sb.append("Lab Test Order with Uuid :");
		sb.append(labTest.getUuid());
		sb.append(" is  saved!");
		status = sb.toString();
		/*	}
		}
		catch (Exception e) {
			status = e.getLocalizedMessage();
			//e.printStackTrace();
			model.addAttribute("status", status);
			//model.addAttribute("uuid", attributeType == null ? "" : attributeType.getUuid());
			return SUCCESS_ADD_FORM_VIEW;//"redirect:addLabTestAttributeType.form";//"redirect:manageLabTestAttributeTypes.form";
			
		}*/
		//model.addAttribute("status", status);
		return "redirect:../../patientDashboard.form?patientId=" + labTest.getOrder().getPatient().getPatientId();
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/retirelabtestorder.form")
	public String onRetire(ModelMap model, HttpSession httpSession, HttpServletRequest request,
	        @RequestParam("uuid") String uuid, @RequestParam("retireReason") String retireReason) {
		LabTest labTest = commonLabTestService.getLabTestByUuid(uuid);
		String status;
		try {
			commonLabTestService.voidLabTest(labTest, retireReason);
			StringBuilder sb = new StringBuilder();
			sb.append("Lab Test order with Uuid :");
			sb.append(labTest.getUuid());
			sb.append(" is  retired!");
			status = sb.toString();
		}
		catch (Exception e) {
			status = e.getLocalizedMessage();
			e.printStackTrace();
			
		}
		model.addAttribute("status", status);
		//  model.addAttribute("patientId", labTest.get);
		//model.addAttribute("status", status);
		return "redirect:labTestOrder.form";
		
	}
	
}

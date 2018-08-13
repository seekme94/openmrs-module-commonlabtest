package org.openmrs.module.commonlabtest.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Concept;
import org.openmrs.api.context.Context;
import org.openmrs.module.commonlabtest.LabTest;
import org.openmrs.module.commonlabtest.LabTestSample;
import org.openmrs.module.commonlabtest.LabTestSample.LabTestSampleStatus;
import org.openmrs.module.commonlabtest.api.CommonLabTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LabTestSampleController {
	
	protected final Log log = LogFactory.getLog(getClass());
	
	private final String SUCCESS_ADD_FORM_VIEW = "/module/commonlabtest/addLabTestSample";
	
	public static String DEFAULT_DATE_PATTERN = "MM/dd/yyyy HH:mm:ss";
	
	@Autowired
	CommonLabTestService commonLabTestService;
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yy-mm-dd"), true));
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/module/commonlabtest/addLabTestSample.form")
	public String showLabTestTypes(ModelMap model, @RequestParam(required = true) Integer patientId,
	        @RequestParam(required = false) Integer testSampleId, @RequestParam(required = false) Integer orderId,
	        @RequestParam(value = "error", required = false) String error) {
		
		//CommonLabTestService commonLabTestService = (CommonLabTestService) Context.getService(CommonLabTestService.class);
		LabTestSample test;
		if (testSampleId == null) {
			test = new LabTestSample();
		} else {
			
			test = commonLabTestService.getLabTestSample(testSampleId);
		}
		
		//get Specimen Type .
		String specimenTypeUuid = Context.getAdministrationService().getGlobalProperty(
		    "commonlabtest.specimenTypeConceptUuid");
		Concept specimenType = Context.getConceptService().getConceptByUuid(specimenTypeUuid);
		if (specimenType != null && specimenType.getSetMembers().size() > 0) {
			List<Concept> specimenTypeConcepts = specimenType.getSetMembers();
			model.put("specimenType", specimenTypeConcepts);
		}
		//get Specimen Site 
		String specimenSiteUuid = Context.getAdministrationService().getGlobalProperty(
		    "commonlabtest.specimenSiteConceptUuid");
		Concept specimenSiteSet = Context.getConceptService().getConceptByUuid(specimenSiteUuid);
		if (specimenSiteSet != null && specimenSiteSet.getSetMembers().size() > 0) {
			List<Concept> specimenSiteConcepts = specimenSiteSet.getSetMembers();
			System.out.println("=========Specimen Site ===================");
			System.out.println("Specimen Site : " + specimenSiteConcepts.size());
			model.put("specimenSite", specimenSiteConcepts);
		}
		
		model.addAttribute("testSample", test);
		model.addAttribute("patientId", patientId);
		model.addAttribute("orderId", orderId);
		model.addAttribute("error", error);
		model.addAttribute("provider",
		    Context.getProviderService().getProvidersByPerson(Context.getAuthenticatedUser().getPerson(), false).iterator()
		            .next());
		return SUCCESS_ADD_FORM_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/addLabTestSample.form")
	public String onSubmit(ModelMap model, HttpSession httpSession,
	        @ModelAttribute("anyRequestObject") Object anyRequestObject, HttpServletRequest request,
	        @ModelAttribute("testSample") LabTestSample labTestSample, BindingResult result) {
		String status = "";
		try {
			if (result.hasErrors()) {
				///If we get any exception while binding it should be redirected to same page with binding error		
				if (labTestSample.getLabTestSampleId() == null) {
					return "redirect:addLabTestSample.form?patientId="
					        + labTestSample.getLabTest().getOrder().getPatient().getPatientId();
				} else {
					return "redirect:addLabTestSample.form?patientId="
					        + labTestSample.getLabTest().getOrder().getPatient().getPatientId() + "&testSampleId="
					        + labTestSample.getLabTest().getTestOrderId();
				}
			} else {
				//   labTest.set
				labTestSample.setStatus(LabTestSampleStatus.COLLECTED);
				commonLabTestService.saveLabTestSample(labTestSample);
				StringBuilder sb = new StringBuilder();
				sb.append("Lab Test Order with Uuid :");
				sb.append(labTestSample.getUuid());
				sb.append(" is  saved!");
				status = sb.toString();
			}
		}
		catch (Exception e) {
			status = "Lab Test sample could not be saved due to exceptions";
			e.printStackTrace();
			model.addAttribute("error", status);
			if (labTestSample.getLabTestSampleId() == null) {
				return "redirect:addLabTestSample.form?patientId="
				        + labTestSample.getLabTest().getOrder().getPatient().getPatientId();
			} else {
				return "redirect:addLabTestSample.form?patientId="
				        + labTestSample.getLabTest().getOrder().getPatient().getPatientId() + "&testSampleId="
				        + labTestSample.getLabTest().getTestOrderId();
			}
		}
		model.addAttribute("save", status);
		return "redirect:manageLabTestSamples.form?patientId="
		        + labTestSample.getLabTest().getOrder().getPatient().getPatientId() + "&testOrderId="
		        + labTestSample.getLabTest().getTestOrderId();
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/retirelabtestsample.form")
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
			status = "Lab Test sample could not be saved due to exceptions";
			e.printStackTrace();
			
		}
		model.addAttribute("save", status);
		return "redirect:labTestOrder.form";
		
	}
	
}

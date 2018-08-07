package org.openmrs.module.commonlabtest.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.context.Context;
import org.openmrs.module.commonlabtest.LabTest;
import org.openmrs.module.commonlabtest.LabTestSample;
import org.openmrs.module.commonlabtest.api.CommonLabTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LabTestSampleController {
	
	protected final Log log = LogFactory.getLog(getClass());
	
	private final String SUCCESS_ADD_FORM_VIEW = "/module/commonlabtest/addLabTestSample";
	
	@Autowired
	CommonLabTestService commonLabTestService;
	
	@ModelAttribute
	public void specimenSite() {
		
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/module/commonlabtest/addLabTestSample.form")
	public String showLabTestTypes(ModelMap model, @RequestParam(required = true) Integer patientId,
	        @RequestParam(required = false) Integer testSampleId,
	        @RequestParam(value = "error", required = false) String error) {
		
		//CommonLabTestService commonLabTestService = (CommonLabTestService) Context.getService(CommonLabTestService.class);
		LabTestSample test;
		if (testSampleId == null) {
			test = new LabTestSample();
		} else {
			
			test = commonLabTestService.getLabTestSample(testSampleId);
		}
		model.addAttribute("testSample", test);
		model.addAttribute("patientId", patientId);
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
				throw new Exception();
			} else {
				//   labTest.set
				commonLabTestService.saveLabTestSample(labTestSample);
				StringBuilder sb = new StringBuilder();
				sb.append("Lab Test Order with Uuid :");
				sb.append(labTestSample.getUuid());
				sb.append(" is  saved!");
				status = sb.toString();
			}
		}
		catch (Exception e) {
			status = e.getLocalizedMessage();
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
		model.addAttribute("status", status);
		
		return "redirect:manageLabTestSamples.form";
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
			status = e.getLocalizedMessage();
			e.printStackTrace();
			
		}
		model.addAttribute("status", status);
		//  model.addAttribute("patientId", labTest.get);
		model.addAttribute("status", status);
		return "redirect:labTestOrder.form";
		
	}
	
}

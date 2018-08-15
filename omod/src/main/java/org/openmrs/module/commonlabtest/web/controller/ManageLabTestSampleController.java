package org.openmrs.module.commonlabtest.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.module.commonlabtest.LabTest;
import org.openmrs.module.commonlabtest.LabTestSample;
import org.openmrs.module.commonlabtest.LabTestSample.LabTestSampleStatus;
import org.openmrs.module.commonlabtest.api.CommonLabTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ManageLabTestSampleController {
	
	protected final Log log = LogFactory.getLog(getClass());
	
	private final String SUCCESS_ADD_FORM_VIEW = "/module/commonlabtest/manageLabTestSamples";
	
	@Autowired
	CommonLabTestService commonLabTestService;
	
	@RequestMapping(method = RequestMethod.GET, value = "/module/commonlabtest/manageLabTestSamples.form")
	public String showLabTestTypes(@RequestParam(required = true) Integer patientId,
	        @RequestParam(required = false) Integer testOrderId, @RequestParam(required = false) String save, ModelMap model) {
		
		//CommonLabTestService commonLabTestService = (CommonLabTestService) Context.getService(CommonLabTestService.class);
		List<LabTestSample> testSample;
		if (testOrderId == null) {
			testSample = new ArrayList<LabTestSample>();
		} else {
			LabTest labTest = commonLabTestService.getLabTest(testOrderId);
			testSample = commonLabTestService.getLabTestSamples(labTest, Boolean.FALSE);//need to check this get sample method...
		}
		
		model.addAttribute("labSampleTest", testSample);
		model.addAttribute("orderId", testOrderId);
		model.addAttribute("patientId", patientId);
		model.addAttribute("status", save);
		
		return SUCCESS_ADD_FORM_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/statuslabtestsample.form")
	public String onStatus(ModelMap model, HttpSession httpSession, HttpServletRequest request,
	        @RequestParam("uuid") String uuid, @RequestParam("patientId") String patientId,
	        @RequestParam(value = "rejectedReason", required = false) String rejectedReason) {
		LabTestSample labTestSample = commonLabTestService.getLabTestSampleByUuid(uuid);
		String status;
		try {
			if (rejectedReason == "") {
				labTestSample.setStatus(LabTestSampleStatus.ACCEPTED);
				
			} else {
				labTestSample.setStatus(LabTestSampleStatus.REJECTED);
				labTestSample.setComments(rejectedReason);
			}
			commonLabTestService.saveLabTestSample(labTestSample);
			StringBuilder sb = new StringBuilder();
			/*	sb.append("Lab Sample Test is update with Uuid :");
				sb.append(labTestSample.getUuid());*/
			sb.append("Lab Sample Test status is updated");
			status = sb.toString();
		}
		catch (Exception e) {
			status = e.getLocalizedMessage();
			e.printStackTrace();
			
		}
		model.addAttribute("save", status);
		
		return "redirect:manageLabTestSamples.form?patientId=" + patientId + "&testOrderId="
		        + labTestSample.getLabTest().getTestOrderId();
	}
	
}

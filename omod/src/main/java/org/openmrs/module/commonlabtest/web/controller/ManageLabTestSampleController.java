package org.openmrs.module.commonlabtest.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
public class ManageLabTestSampleController {
	
	protected final Log log = LogFactory.getLog(getClass());
	
	private final String SUCCESS_ADD_FORM_VIEW = "/module/commonlabtest/manageLabTestSamples";
	
	@Autowired
	CommonLabTestService commonLabTestService;
	
	@RequestMapping(method = RequestMethod.GET, value = "/module/commonlabtest/manageLabTestSamples.form")
	public String showLabTestTypes(@RequestParam(required = true) Integer patientId,
	        @RequestParam(required = false) Integer testOrderId, ModelMap model) {
		
		//CommonLabTestService commonLabTestService = (CommonLabTestService) Context.getService(CommonLabTestService.class);
		List<LabTestSample> testSample;
		if (testOrderId == null) {
			testSample = new ArrayList<LabTestSample>();
		} else {
			LabTest labTest = commonLabTestService.getLabTest(testOrderId);
			testSample = commonLabTestService.getLabTestSamples(labTest, Boolean.FALSE);//need to check this get sample method...
		}
		model.addAttribute("labSampleTest", testSample);
		model.addAttribute("patientId", patientId);
		
		return SUCCESS_ADD_FORM_VIEW;
	}
	
}

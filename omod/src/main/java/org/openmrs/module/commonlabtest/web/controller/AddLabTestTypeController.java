package org.openmrs.module.commonlabtest.web.controller;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Concept;
import org.openmrs.module.commonlabtest.LabTestType;
import org.openmrs.module.commonlabtest.api.CommonLabTestService;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
@RequestMapping(value = "/module/commonlabtest/addLabTestType.form")
public class AddLabTestTypeController {
	
	private final String SUCCESS_ADD_FORM_VIEW = "/module/commonlabtest/addLabTestType";
	
	/** Logger for this class */
	protected final Log log = LogFactory.getLog(getClass());
	
	@Autowired
	CommonLabTestService commonLabTestService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String showForm(ModelMap model) {
	   LabTestType testType =commonLabTestService.getLabTestType(1);
		model.addAttribute("labTestType", commonLabTestService.getLabTestType(1));
		return SUCCESS_ADD_FORM_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public void onSubmit(HttpSession httpSession, @ModelAttribute("anyRequestObject") Object anyRequestObject,
	        HttpServletRequest request, @ModelAttribute("labTestType") LabTestType labTestType, BindingResult result) {
		if (result.hasErrors()) {
			///error show 
		} else {
			
			labTestType.setUuid(UUID.randomUUID().toString());
			Concept concept = new Concept();
			concept.setConceptId(2);
			labTestType.setReferenceConcept(concept);
			commonLabTestService.saveLabTestType(labTestType);
		}
		
	}
	
}

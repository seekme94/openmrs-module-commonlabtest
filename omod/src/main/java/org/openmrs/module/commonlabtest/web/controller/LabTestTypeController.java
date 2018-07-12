package org.openmrs.module.commonlabtest.web.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.util.JSONPObject;
import org.openmrs.Concept;
import org.openmrs.ConceptClass;
import org.openmrs.api.context.Context;
import org.openmrs.module.commonlabtest.LabTestType;
import org.openmrs.module.commonlabtest.api.CommonLabTestService;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class LabTestTypeController {
	
	private final String SUCCESS_ADD_FORM_VIEW = "/module/commonlabtest/addLabTestType";
	
	/**
	 * Logger for this class
	 */
	protected final Log log = LogFactory.getLog(getClass());
	
	/*@Autowired
	@Qualifier("labTestTypeValidator")
	private Validator validator;
	*/
	@Autowired
	CommonLabTestService commonLabTestService;
	
	/*@InitBinder
	private void initBinder(WebDataBinder binder) {
		binder.setValidator(validator);
	}*/
	
	@RequestMapping(method = RequestMethod.GET, value = "/module/commonlabtest/addLabTestType.form")
	public String showForm(ModelMap model, @RequestParam(value = "uuid", required = false) String uuid) {
		LabTestType testType;
		if (uuid == null || uuid.equalsIgnoreCase("")) {
			testType = new LabTestType();
		} else {
			testType = commonLabTestService.getLabTestTypeByUuid(uuid);
		}
		ConceptClass conceptClass = Context.getConceptService().getConceptClassByName("Test");
		List<Concept> conceptlist = Context.getConceptService().getConceptsByClass(conceptClass);
		model.addAttribute("labTestType", testType);
		
		List<Map<String, String>> mapConceptList = new ArrayList<Map<String, String>>();
		for (Concept c : conceptlist) {
			Map<String, String> obj = new HashMap<String, String>();
			obj.put("id", c.getId() + "");
			obj.put("name", c.getName() != null ? c.getName().getName() : "");
			obj.put("shortName", c.getShortNameInLocale(Locale.ENGLISH) != null ? c.getShortNameInLocale(Locale.ENGLISH)
			        .getName() : "");
			obj.put("description", c.getDescription() != null ? c.getDescription().getDescription() : "");
			mapConceptList.add(obj);
		}
		model.addAttribute("concepts", mapConceptList);
		return SUCCESS_ADD_FORM_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/addLabTestType.form")
	public String onAdd(HttpSession httpSession, @ModelAttribute("anyRequestObject") Object anyRequestObject,
	        HttpServletRequest request, @ModelAttribute("labTestType") LabTestType labTestType, BindingResult result) {
		
		if (result.hasErrors()) {
			///error show
			//result.error
			System.out.println("------------------------------------");
			System.out.println("Errors");
			System.out.println(result.getFieldError());
			//return;
		} else {
			System.out.println("------------------------------------");
			System.out.println("Test Type ID:: " + labTestType.getId());
			commonLabTestService.saveLabTestType(labTestType);
		}
		return "redirect:manageLabTestTypes.form";
		//return "/module/commonlabtest/manageLabTestTypes.form";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/retirelabtesttype.form")
	public String onRetire(HttpSession httpSession, HttpServletRequest request, @RequestParam("uuid") String uuid,
	        @RequestParam("retireReason") String retireReason) {
		LabTestType labTestType = commonLabTestService.getLabTestTypeByUuid(uuid);
		labTestType.setRetired(true);
		labTestType.setDateRetired(new Date());
		labTestType.setRetiredBy(Context.getAuthenticatedUser());
		labTestType.setRetireReason(retireReason);
		commonLabTestService.saveLabTestType(labTestType);
		return "redirect:manageLabTestTypes.form";
		//return "/module/commonlabtest/manageLabTestTypes.form";
	}

	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/deletelabtesttype.form")
	public String onRetire(HttpSession httpSession, HttpServletRequest request, @RequestParam("uuid") String uuid
						   ) {
		LabTestType labTestType = commonLabTestService.getLabTestTypeByUuid(uuid);

		commonLabTestService.deleteLabTestType(labTestType);
		return "redirect:manageLabTestTypes.form";

	}
}

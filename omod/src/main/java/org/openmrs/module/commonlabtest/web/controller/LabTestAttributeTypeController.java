package org.openmrs.module.commonlabtest.web.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.context.Context;
import org.openmrs.customdatatype.CustomDatatypeUtil;
import org.openmrs.module.commonlabtest.LabTestAttributeType;
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
import java.util.Collection;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/module/commonlabtest/addLabTestAttributeType.form")
public class LabTestAttributeTypeController {
	
	private final String SUCCESS_ADD_FORM_VIEW = "/module/commonlabtest/addLabTestAttributeType";

	@ModelAttribute("datatypes")
	public Collection<String> getDatatypes() {
		return CustomDatatypeUtil.getDatatypeClassnames();
	}

	@ModelAttribute("handlers")
	public Collection<String> getHandlers() {
		return CustomDatatypeUtil.getHandlerClassnames();
	}
	/** Logger for this class */
	protected final Log log = LogFactory.getLog(getClass());
	
	@Autowired
	CommonLabTestService commonLabTestService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String showForm(ModelMap model, @RequestParam(value = "uuid", required = false) String uuid) {
		LabTestAttributeType attributeType;
		if (uuid == null || uuid.equalsIgnoreCase("")) {
			attributeType = new LabTestAttributeType();
		} else {
			attributeType = commonLabTestService.getLabTestAttributeTypeByUuid(uuid);
		}
		
		return SUCCESS_ADD_FORM_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public void onSubmit(HttpSession httpSession, @ModelAttribute("anyRequestObject") Object anyRequestObject,
	        HttpServletRequest request, @ModelAttribute("attributeType") LabTestAttributeType attributeType,
	        @RequestParam("formType") int formType, BindingResult result) {
		if (result.hasErrors()) {
			///error show
		} else {
			if (formType == 1) {
				attributeType.setCreator(Context.getAuthenticatedUser());
				attributeType.setDateCreated(new Date());
			} else if (formType == 2) {
				
				attributeType.setChangedBy(Context.getAuthenticatedUser());
				attributeType.setDateChanged(new Date());
			} else if (formType == 3) {
				attributeType.setRetiredBy(Context.getAuthenticatedUser());
				attributeType.setDateRetired(new Date());
			}
			commonLabTestService.saveLabTestAttributeType(attributeType);
		}
		
	}
}

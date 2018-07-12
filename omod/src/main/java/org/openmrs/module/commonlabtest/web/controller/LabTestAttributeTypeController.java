package org.openmrs.module.commonlabtest.web.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.APIException;
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
	
	@RequestMapping(method = RequestMethod.GET,value="/module/commonlabtest/addLabTestAttributeType.form")
	public String showForm(ModelMap model, @RequestParam(value = "uuid", required = false) String uuid) {
		LabTestAttributeType attributeType;
		if (uuid == null || uuid.equalsIgnoreCase("")) {
			attributeType = new LabTestAttributeType();
		} else {
			attributeType = commonLabTestService.getLabTestAttributeTypeByUuid(uuid);
		}
        model.addAttribute("attributeType",attributeType);
		return SUCCESS_ADD_FORM_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.POST,value = "/module/commonlabtest/addLabTestAttributeType.form")
	public String onSubmit(ModelMap model,HttpSession httpSession, @ModelAttribute("anyRequestObject") Object anyRequestObject,
	        HttpServletRequest request, @ModelAttribute("attributeType") LabTestAttributeType attributeType,
	        BindingResult result) {
        String status="";
	    if (result.hasErrors()) {

		} else {

            try {
			commonLabTestService.saveLabTestAttributeType(attributeType);
                StringBuilder sb=new StringBuilder();
                sb.append("Lab Test Attribute with Uuid :");
                sb.append(attributeType.getUuid());
                sb.append(" is  saved!");
                status=sb.toString();
            }catch (Exception e){
                e.printStackTrace();
                status=e.getLocalizedMessage();
            }

		}
        model.addAttribute("status",status);
        return "redirect:manageLabTestAttributeTypes.form";
		
	}

	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/retirelabtestattributetype.form")
	public String onRetire(ModelMap model,HttpSession httpSession, HttpServletRequest request, @RequestParam("uuid") String uuid,
						   @RequestParam("retireReason") String retireReason) {
		LabTestAttributeType attributeType = commonLabTestService.getLabTestAttributeTypeByUuid(uuid);
        String status;
        try {
            commonLabTestService.retireLabTestAttributeType(attributeType, retireReason);
            StringBuilder sb=new StringBuilder();
            sb.append("Lab Test Attribute with Uuid :");
            sb.append(attributeType.getUuid());
            sb.append(" is  retired!");
            status=sb.toString();
        }catch (Exception e){
            e.printStackTrace();
            status=e.getLocalizedMessage();
        }
        model.addAttribute("status",status);
		return "redirect:manageLabTestAttributeTypes.form";
		//return "/module/commonlabtest/manageLabTestTypes.form";
	}

	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/deletelabtestattributetype.form")
	public String onDelete(ModelMap model,HttpSession httpSession, HttpServletRequest request, @RequestParam("uuid") String uuid
	) {
		LabTestAttributeType attributeType = commonLabTestService.getLabTestAttributeTypeByUuid(uuid);
		String status;
        try {
            commonLabTestService.deleteLabTestAttributeType(attributeType);
            StringBuilder sb=new StringBuilder();
            sb.append("Lab Test Attribute with Uuid :");
            sb.append(attributeType.getUuid());
            sb.append(" is permanently deleted!");
            status=sb.toString();
        }catch (Exception exception){
            exception.printStackTrace();
            status=exception.getLocalizedMessage();
        }
        model.addAttribute("status",status);
		return "redirect:manageLabTestAttributeTypes.form";

	}
}

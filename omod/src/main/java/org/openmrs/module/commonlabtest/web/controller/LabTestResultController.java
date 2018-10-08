package org.openmrs.module.commonlabtest.web.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.api.context.Context;
import org.openmrs.module.commonlabtest.LabTest;
import org.openmrs.module.commonlabtest.LabTestAttribute;
import org.openmrs.module.commonlabtest.LabTestAttributeType;
import org.openmrs.module.commonlabtest.LabTestSample;
import org.openmrs.module.commonlabtest.LabTestSample.LabTestSampleStatus;
import org.openmrs.module.commonlabtest.api.CommonLabTestService;
import org.openmrs.web.WebConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Controller
public class LabTestResultController {
	
	protected final Log log = LogFactory.getLog(getClass());
	
	private final String SUCCESS_ADD_FORM_VIEW = "/module/commonlabtest/addLabTestResult";
	
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	@Autowired
	CommonLabTestService commonLabTestService;
	
	@RequestMapping(method = RequestMethod.GET, value = "/module/commonlabtest/addLabTestResult.form")
	public String showForm(HttpServletRequest request, @RequestParam(required = false) Integer testOrderId,
	        @RequestParam(required = false) Integer patientId, ModelMap model) {
		
		LabTest labTest = commonLabTestService.getLabTest(testOrderId);
		if (labTest == null) {
			request.getSession().setAttribute(WebConstants.OPENMRS_ERROR_ATTR, "Test Order does not exist");
			return "redirect:../../patientDashboard.form?patientId=" + patientId;
		} else if (labTest.getVoided()) {
			request.getSession().setAttribute(WebConstants.OPENMRS_ERROR_ATTR, "Test Order is voided");
			return "redirect:../../patientDashboard.form?patientId=" + patientId;
		}
		
		List<LabTestAttributeType> attributeTypeList = new ArrayList<LabTestAttributeType>();
		attributeTypeList = commonLabTestService.getLabTestAttributeTypes(labTest.getLabTestType(), Boolean.FALSE);
		
		List<LabTestAttributeType> nonGroupTestAttributeType = new ArrayList<LabTestAttributeType>();
		List<LabTestAttributeType> groupTestAttributeType = new ArrayList<LabTestAttributeType>();
		
		for (LabTestAttributeType labTestAttributeType : attributeTypeList) {
			if (labTestAttributeType.getGroupId() == null) {
				nonGroupTestAttributeType.add(labTestAttributeType);
			} else {
				groupTestAttributeType.add(labTestAttributeType);
			}
		}
		
		JsonArray attributeTypeArray = new JsonArray();
		List<LabTestAttribute> testAttributes = commonLabTestService.getLabTestAttributes(testOrderId);
		
		// Context.getService(CommonLabTestService.class).getLabTestAttributes(patient, labTestAttributeType, includeVoided);
		Collections.sort(nonGroupTestAttributeType, new Comparator<LabTestAttributeType>() {
			
			@Override
			public int compare(LabTestAttributeType o1, LabTestAttributeType o2) {
				return o1.getSortWeight().compareTo(o2.getSortWeight());
			}
		});
		
		for (LabTestAttributeType labTestAttributeType : nonGroupTestAttributeType) {
			attributeTypeArray.add(getAttributeTypeJsonObj(labTestAttributeType, testAttributes));
		}
		
		model.addAttribute("attributeTypeList", attributeTypeArray);
		if (groupTestAttributeType.size() > 0) {
			model.addAttribute("groupList", getGroupArrayList(groupTestAttributeType, testAttributes));
		}
		//check the voided values ..
		if (testAttributes.size() > 0 && attributeTypeList.size() > 0) {
			boolean updateMode = false;
			for (LabTestAttribute labTestAttribute : testAttributes) {
				if (!labTestAttribute.getVoided()) {
					updateMode = true;
					break;
				}
			}
			if (updateMode) {
				model.addAttribute("update", Boolean.TRUE);
				model.addAttribute("filepath", labTest.getFilePath());
			} else {
				model.addAttribute("update", Boolean.FALSE);
				model.addAttribute("filepath", "");
			}
		} else {
			model.addAttribute("update", Boolean.FALSE);
			model.addAttribute("filepath", "");
		}
		String fileExtensions = Context.getAdministrationService().getGlobalProperty("commonlabtest.fileExtensions");
		model.addAttribute("fileExtensions", fileExtensions);
		model.addAttribute("testOrderId", testOrderId);
		if (attributeTypeList.size() > 0) {
			model.addAttribute("testTypeName", attributeTypeList.get(0).getLabTestType().getName());
		} else {
			model.addAttribute("testTypeName", "Unknown"); //This lines need to be discuss.
		}
		model.addAttribute("patientId", labTest.getOrder().getPatient().getPatientId());
		model.addAttribute("encounterdate", simpleDateFormat.format(labTest.getOrder().getDateActivated()));
		
		return SUCCESS_ADD_FORM_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/addLabTestResult.form")
	public String onSubmit(HttpServletRequest request, @RequestParam(required = true) Integer testOrderId,
	        @RequestParam(required = false) Integer testAttributeId,
	        @RequestParam(required = false) MultipartFile documentTypeFile, @RequestParam(required = false) Boolean update) {
		
		LabTest labTest = commonLabTestService.getLabTest(testOrderId);
		List<LabTestAttributeType> attributeTypeList = Context.getService(CommonLabTestService.class)
		        .getLabTestAttributeTypes(labTest.getLabTestType(), false);
		String conceptValue = "", textValue = "", boolValue = "", floatValue, testAtrrId, regexValue, dateValue;
		
		List<LabTestAttribute> labTestAttributes = new ArrayList<LabTestAttribute>();
		
		for (LabTestAttributeType labTestAttributeType : attributeTypeList) {
			LabTestAttribute testAttribute = new LabTestAttribute();
			
			conceptValue = request.getParameter("concept." + labTestAttributeType.getId());
			textValue = request.getParameter("valueText." + labTestAttributeType.getId());
			boolValue = request.getParameter("bool." + labTestAttributeType.getId());
			floatValue = request.getParameter("float." + labTestAttributeType.getId());
			dateValue = request.getParameter("date." + labTestAttributeType.getId());
			regexValue = request.getParameter("regex." + labTestAttributeType.getId());
			testAtrrId = request.getParameter("testAttributeId." + labTestAttributeType.getId());
			if (update && (!testAtrrId.equals("undefined") && !testAtrrId.equals(""))) {
				testAttribute = commonLabTestService.getLabTestAttribute(Integer.parseInt(testAtrrId));
			} else {
				testAttribute.setLabTest(labTest);
				testAttribute.setAttributeTypeId(labTestAttributeType);
			}
			//set the value reference 
			if (conceptValue != null && !conceptValue.equals("") && !conceptValue.isEmpty()) {
				testAttribute.setValueReference(conceptValue);
				labTestAttributes.add(testAttribute);
			} else if (textValue != null && !textValue.equals("") && !textValue.isEmpty()) {
				testAttribute.setValueReference(textValue);
				labTestAttributes.add(testAttribute);
			} else if (boolValue != null && !boolValue.equals("") && !boolValue.isEmpty()) {
				testAttribute.setValueReference(boolValue);
				labTestAttributes.add(testAttribute);
			} else if (floatValue != null && !floatValue.equals("") && !floatValue.isEmpty()) {
				testAttribute.setValueReference(floatValue);
				labTestAttributes.add(testAttribute);
			} else if (dateValue != null && !dateValue.equals("") && !dateValue.isEmpty()) {
				testAttribute.setValueReference(dateValue);
				labTestAttributes.add(testAttribute);
			} else if (regexValue != null && !regexValue.equals("") && !regexValue.isEmpty()) {
				testAttribute.setValueReference(regexValue);
				labTestAttributes.add(testAttribute);
			}
		}
		//save the file
		if (documentTypeFile.isEmpty()) {} else {
			
			try {
				String fileDirectory = Context.getAdministrationService().getGlobalProperty("commonlabtest.fileDirectory");
				
				FileCopyUtils.copy(documentTypeFile.getBytes(), new FileOutputStream(fileDirectory + "/"
				        + documentTypeFile.getOriginalFilename().replace(" ", "-")));
				
				String name = documentTypeFile.getOriginalFilename().replace(" ", "-");
				labTest.setFilePath(fileDirectory + "/" + name);
				Context.getService(CommonLabTestService.class).saveLabTest(labTest); //need to review this lines
			}
			catch (IOException e) {
				e.printStackTrace();
			}
		}
		//change the sample status ... 
		List<LabTestSample> labTestSampleList = commonLabTestService.getLabTestSamples(labTest, Boolean.FALSE);
		for (LabTestSample labTestSample : labTestSampleList) {
			if (labTestSample.getStatus().equals(LabTestSampleStatus.ACCEPTED)) {
				labTestSample.setStatus(LabTestSampleStatus.PROCESSED);
				labTestSample.setProcessedDate(new Date());
				Context.getService(CommonLabTestService.class).saveLabTestSample(labTestSample);
			}
		}
		
		/*String resultComments = request.getParameter("resultComments");
		if (!resultComments.equals("") && resultComments != null) {
			labTest.setResultComments(resultComments);
			 Context.getService(CommonLabTestService.class).saveLabTest(labTest);//need to review this lines
		}*/
		
		commonLabTestService.saveLabTestAttributes(labTestAttributes);
		request.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR, "Test Result saved successfully");
		return "redirect:../../patientDashboard.form?patientId=" + labTest.getOrder().getPatient().getPatientId();
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/voidlabtestresult.form")
	public String onVoid(ModelMap model, HttpSession httpSession, HttpServletRequest request,
	        @RequestParam("testOrderId") Integer testOrderId, @RequestParam("patientId") Integer patientId,
	        @RequestParam("voidReason") String voidReason) {
		//List<LabTestAttribute> labTestAttributes =  Context.getService(CommonLabTestService.class).getLabTestAttributes(testOrderId);
		String status;
		try {
			LabTest labTest = commonLabTestService.getLabTest(testOrderId);
			commonLabTestService.voidLabTestAttributes(labTest, voidReason);
			StringBuilder sb = new StringBuilder();
			sb.append("Lab Test Result ");
			sb.append(" is  voided!");
			status = sb.toString();
		}
		catch (Exception e) {
			status = "Could not save Lab Test Result";
			e.printStackTrace();
			model.addAttribute("error", status);
		}
		request.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR, "Test Result voided successfully");
		return "redirect:../../patientDashboard.form?patientId=" + patientId;
		
	}
	
	public String getDataType(String dataTypeName) {
		
		if (dataTypeName.equals("org.openmrs.customdatatype.datatype.BooleanDatatype") || dataTypeName.equals("Boolean")) {
			return "Boolean";
		} else if (dataTypeName.equals("org.openmrs.customdatatype.datatype.FreeTextDatatype")
		        || dataTypeName.equals("Text")) {
			return "Text";
		} else if (dataTypeName.equals("org.openmrs.customdatatype.datatype.ConceptDatatype")
		        || dataTypeName.equals("Coded")) {
			return "Coded";
		} else if (dataTypeName.equals("org.openmrs.customdatatype.datatype.LocationDatatype")) {
			return "location";
		} else if (dataTypeName.endsWith("org.openmrs.customdatatype.datatype.DateDatatype") || dataTypeName.equals("Date")
		        || dataTypeName.equals("Datetime")) {
			return "Date";
		} else if (dataTypeName.equals("org.openmrs.customdatatype.datatype.FloatDatatype")
		        || dataTypeName.equals("Numeric")) {
			return "Numeric";
		} else if (dataTypeName.equals("org.openmrs.customdatatype.datatype.RegexValidatedTextDatatype")) {
			return "Regex";
		} else if (dataTypeName.equals("org.openmrs.customdatatype.datatype.LongFreeTextDatatype")) {
			return "TextArea";
		}
		
		return "N/A";
	}
	
	public JsonArray getGroupArrayList(List<LabTestAttributeType> listAttributeTypes, List<LabTestAttribute> testAttributes) {
		JsonArray parentArray = new JsonArray();
		
		List<Integer> holderGroupId = new ArrayList<Integer>();
		if (listAttributeTypes.size() > 0) {
			List<LabTestAttributeType> childListAttributeTypes = listAttributeTypes;
			JsonObject labTestGroupObj;
			for (LabTestAttributeType labTestAttributeType : listAttributeTypes) {
				labTestGroupObj = new JsonObject();
				JsonArray jsonChildArray = new JsonArray();
				Integer groupId = labTestAttributeType.getGroupId();
				if (holderGroupId.contains(groupId)) {
					continue;
				}
				holderGroupId.add(groupId);
				labTestGroupObj.addProperty("groupName", labTestAttributeType.getGroupName());
				labTestGroupObj.addProperty("groupId", labTestAttributeType.getGroupId());
				for (LabTestAttributeType labTestAttributeTypechld : childListAttributeTypes) {
					if (labTestAttributeTypechld.getGroupId() == groupId) {
						jsonChildArray.add(getAttributeTypeJsonObj(labTestAttributeTypechld, testAttributes));
					}
				}
				labTestGroupObj.add("details", jsonChildArray);
				parentArray.add(labTestGroupObj);
			}
		}
		System.out.println("Result Array : " + parentArray.toString());
		return parentArray;
	}
	
	public JsonObject getAttributeTypeJsonObj(LabTestAttributeType labTestAttributeType,
	        List<LabTestAttribute> testAttributes) {
		JsonObject objAttrType = new JsonObject();
		objAttrType.addProperty("name", labTestAttributeType.getName());
		objAttrType.addProperty("minOccurs", labTestAttributeType.getMinOccurs());
		objAttrType.addProperty("maxOccurs", labTestAttributeType.getMaxOccurs());
		objAttrType.addProperty("sortWeight", labTestAttributeType.getSortWeight());
		objAttrType.addProperty("config", labTestAttributeType.getDatatypeConfig());
		objAttrType.addProperty("hint", labTestAttributeType.getHint());
		
		if (testAttributes.size() > 0) {
			for (LabTestAttribute labTestAttribute : testAttributes) {
				if (!labTestAttribute.getVoided()) {
					if (labTestAttribute.getAttributeTypeId() == labTestAttributeType.getLabTestAttributeTypeId()) {
						objAttrType.addProperty("value", labTestAttribute.getValueReference());
						objAttrType.addProperty("testAttributeId", labTestAttribute.getId());
					}
				}
			}
		} else {
			objAttrType.addProperty("value", "");
			objAttrType.addProperty("testAttributeId", "");
		}
		objAttrType.addProperty("id", labTestAttributeType.getId());
		if (labTestAttributeType.getDatatypeClassname().equalsIgnoreCase(
		    "org.openmrs.customdatatype.datatype.ConceptDatatype")) {
			if (labTestAttributeType.getDatatypeConfig() != null && labTestAttributeType.getDatatypeConfig() != ""
			        && !labTestAttributeType.getDatatypeConfig().isEmpty()) {
				System.out.println("Data Conf :" + labTestAttributeType.getDatatypeConfig());
				Concept concept = Context.getConceptService().getConcept(
				    Integer.parseInt(labTestAttributeType.getDatatypeConfig()));
				
				if (concept.getDatatype().getName().equals("Coded")) {
					JsonArray codedArray = new JsonArray();
					Collection<ConceptAnswer> ans = concept.getAnswers();
					for (ConceptAnswer ca : ans) {
						JsonObject jo = new JsonObject();
						jo.addProperty("conceptName", ca.getAnswerConcept().getName().getName());
						jo.addProperty("conceptId", ca.getAnswerConcept().getConceptId());
						codedArray.add(jo);
					}
					objAttrType.add("conceptOptions", codedArray);
					objAttrType.addProperty("dataType", getDataType(labTestAttributeType.getDatatypeClassname()));
					
				} else {
					objAttrType.addProperty("dataType", getDataType(concept.getDatatype().getName()));
				}
			}
		} else {
			objAttrType.addProperty("dataType", getDataType(labTestAttributeType.getDatatypeClassname()));
		}
		return objAttrType;
	}
	
}

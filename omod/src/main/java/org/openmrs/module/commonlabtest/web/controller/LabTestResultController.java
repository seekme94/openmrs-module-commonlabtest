package org.openmrs.module.commonlabtest.web.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.velocity.runtime.directive.Parse;
import org.hibernate.annotations.Parameter;
import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.api.context.Context;
import org.openmrs.module.commonlabtest.LabTest;
import org.openmrs.module.commonlabtest.LabTestAttribute;
import org.openmrs.module.commonlabtest.LabTestAttributeType;
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
	
	@Autowired
	CommonLabTestService commonLabTestService;
	
	@Autowired
	ServletContext context;
	
	@RequestMapping(method = RequestMethod.GET, value = "/module/commonlabtest/addLabTestResult.form")
	public String showLabTestTypes(@RequestParam(required = false) Integer testOrderId, ModelMap model) {
		LabTest labTest = commonLabTestService.getLabTest(testOrderId);
		//CommonLabTestService commonLabTestService = (CommonLabTestService) Context.getService(CommonLabTestService.class);
		
		List<LabTestAttributeType> attributeTypeList;
		attributeTypeList = commonLabTestService.getLabTestAttributeTypes(labTest.getLabTestType(), false);
		JsonArray attributeTypeArray = new JsonArray();
		List<LabTestAttribute> testAttributes = commonLabTestService.getLabTestAttributes(testOrderId);
		
		//commonLabTestService.getLabTestAttributes(patient, labTestAttributeType, includeVoided);
		Collections.sort(attributeTypeList,new Comparator<LabTestAttributeType>() {

			@Override
			public int compare(LabTestAttributeType o1, LabTestAttributeType o2) {
				// TODO Auto-generated method stub
				return o1.getSortWeight().compareTo(o2.getSortWeight());
			}
		} );
		for (LabTestAttributeType lta : attributeTypeList) {
			JsonObject objAttrType = new JsonObject();
			objAttrType.addProperty("name", lta.getName());
			objAttrType.addProperty("dataConfig", lta.getDatatypeConfig());
			objAttrType.addProperty("minOccurs", lta.getMinOccurs());
			objAttrType.addProperty("maxOccurs", lta.getMaxOccurs());
			objAttrType.addProperty("sortWeight", lta.getSortWeight());
			
			if (testAttributes.size() > 0) {
				for (LabTestAttribute labTestAttribute : testAttributes) {
					if (labTestAttribute.getAttributeTypeId() == lta.getLabTestAttributeTypeId()) {
						objAttrType.addProperty("value", labTestAttribute.getValueReference());
						objAttrType.addProperty("testAttributeId", labTestAttribute.getId());
					}
				}
			} else {
				objAttrType.addProperty("value", "");
				objAttrType.addProperty("testAttributeId", "");
			}
			objAttrType.addProperty("id", lta.getId());
			if (lta.getDatatypeClassname().equalsIgnoreCase("org.openmrs.customdatatype.datatype.ConceptDatatype")) {
				if (lta.getDatatypeConfig() != null && lta.getDatatypeConfig() != "" && !lta.getDatatypeConfig().isEmpty()) {
					System.out.println("Data Conf :" + lta.getDatatypeConfig());
					Concept concept = Context.getConceptService().getConcept(Integer.parseInt(lta.getDatatypeConfig()));
					
					if (concept.getDatatype().getName().equals("Coded")) {
						JsonArray codedArray = new JsonArray();
						Collection<ConceptAnswer> ans = concept.getAnswers();
						for (ConceptAnswer ca : ans) {
							JsonObject jo = new JsonObject();
							jo.addProperty("conceptName", ca.getAnswerConcept().getName().getName());
							jo.addProperty("conceptId", ca.getConceptAnswerId());
							codedArray.add(jo);
						}
						objAttrType.add("conceptOptions", codedArray);
						objAttrType.addProperty("dataType", lta.getDatatypeClassname());
						
					} else {
						objAttrType.addProperty("dataType", concept.getDatatype().getName());
					}
				}
			}/* else if (lta.getDatatypeClassname().equalsIgnoreCase("org.openmrs.customdatatype.datatype.BooleanDatatype")) {
			 if (lta.getDatatypeConfig() != null && lta.getDatatypeConfig() != "" && !lta.getDatatypeConfig().isEmpty()) {
			 	System.out.println("Data Conf :" + lta.getDatatypeConfig());
			 	Concept concept = Context.getConceptService().getConcept(Integer.parseInt(lta.getDatatypeConfig()));
			 	
			 	if (concept.getDatatype().getName().equals("Coded")) {
			 		JsonArray codedArray = new JsonArray();
			 		Collection<ConceptAnswer> ans = concept.getAnswers();
			 		for (ConceptAnswer ca : ans) {
			 			JsonObject jo = new JsonObject();
			 			jo.addProperty("conceptName", ca.getAnswerConcept().getName().getName());
			 			jo.addProperty("conceptId", ca.getConceptAnswerId());
			 			codedArray.add(jo);
			 		}
			 		objAttrType.add("booleanOptions", codedArray);
			 		objAttrType.addProperty("dataType", lta.getDatatypeClassname());
			 		
			 	} else {
			 		objAttrType.addProperty("dataType", concept.getDatatype().getName());
			 	}
			 }
			 }*/else {
				objAttrType.addProperty("dataType", lta.getDatatypeClassname());
			}
			attributeTypeArray.add(objAttrType);
		}
		
		model.addAttribute("attributeTypeList", attributeTypeArray);
		if (testAttributes.size() > 0) {
			model.addAttribute("update", Boolean.TRUE);
			model.addAttribute("filepath", labTest.getFilepath());
		} else {
			model.addAttribute("update", Boolean.FALSE);
			model.addAttribute("filepath", "");
			
		}
		model.addAttribute("testOrderId", testOrderId);
		model.addAttribute("testTypeName", attributeTypeList.get(0).getLabTestType().getName());
		model.addAttribute("patientId", labTest.getOrder().getPatient().getPatientId());
		
		return SUCCESS_ADD_FORM_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/module/commonlabtest/addLabTestResult.form")
	public String onSubmit(HttpServletRequest request, @RequestParam(required = true) Integer testOrderId,
	        @RequestParam(required = false) Integer testAttributeId,
	        @RequestParam(required = false) MultipartFile documentTypeFile, @RequestParam(required = false) Boolean update) {
		
		System.out.println("Document File : " + documentTypeFile);
		LabTest labTest = commonLabTestService.getLabTest(testOrderId);
		List<LabTestAttributeType> attributeTypeList = commonLabTestService.getLabTestAttributeTypes(
		    labTest.getLabTestType(), false);
		String conceptValue = "", textValue = "", boolValue = "", floatValue, testAtrrId;
		List<LabTestAttribute> labTestAttributes = new ArrayList<LabTestAttribute>();
		
		for (LabTestAttributeType labTestAttributeType : attributeTypeList) {
			LabTestAttribute testAttribute = new LabTestAttribute();
			
			conceptValue = request.getParameter("concept." + labTestAttributeType.getId());
			textValue = request.getParameter("valueText." + labTestAttributeType.getId());
			boolValue = request.getParameter("bool." + labTestAttributeType.getId());
			floatValue = request.getParameter("float." + labTestAttributeType.getId());
			testAtrrId = request.getParameter("testAttributeId." + labTestAttributeType.getId());
			if (update && testAtrrId != "") {
				testAttribute = commonLabTestService.getLabTestAttribute(Integer.parseInt(testAtrrId));
				
				if (conceptValue != null && conceptValue != "" && !conceptValue.isEmpty()) {
					testAttribute.setValueReference(conceptValue);
					
					labTestAttributes.add(testAttribute);
				} else if (textValue != null && textValue != "" && !textValue.isEmpty()) {
					testAttribute.setValueReference(textValue);
					
					labTestAttributes.add(testAttribute);
				} else if (boolValue != null && boolValue != "" && !boolValue.isEmpty()) {
					testAttribute.setValueReference(boolValue);
					
					labTestAttributes.add(testAttribute);
				} else if (floatValue != null && floatValue != "" && !floatValue.isEmpty()) {
					testAttribute.setValueReference(floatValue);
					
					labTestAttributes.add(testAttribute);
				}
			} else {
				testAttribute.setLabTest(labTest);
				testAttribute.setAttributeTypeId(labTestAttributeType);
				if (conceptValue != null && conceptValue != "" && !conceptValue.isEmpty()) {
					testAttribute.setValueReference(conceptValue);
					
					labTestAttributes.add(testAttribute);
				} else if (textValue != null && textValue != "" && !textValue.isEmpty()) {
					testAttribute.setValueReference(textValue);
					
					labTestAttributes.add(testAttribute);
				} else if (boolValue != null && boolValue != "" && !boolValue.isEmpty()) {
					testAttribute.setValueReference(boolValue);
					
					labTestAttributes.add(testAttribute);
				} else if (floatValue != null && floatValue != "" && !floatValue.isEmpty()) {
					testAttribute.setValueReference(floatValue);
					
					labTestAttributes.add(testAttribute);
				}
			}
			
		}
		if (documentTypeFile.isEmpty()) {} else {
			
			try {
				/*	this.context = servletContext.se;
					String relativeWebPath = "/WEB-INF/resources/testResults";
					String absoluteFilePath = context.getRealPath("") + File.separator + relativeWebPath;
					 */
				/*	File dir = OpenmrsUtil.getDirectoryInApplicationDataDirectory(Context.getAdministrationService()
					        .getGlobalProperty(OpenmrsConstants.GLOBAL_PROPERTY_COMPLEX_OBS_DIR));*/
				
				String fileDirectory = Context.getAdministrationService().getGlobalProperty("commonlabtest.fileDirectory");
				
				FileCopyUtils.copy(documentTypeFile.getBytes(), new FileOutputStream(fileDirectory + "/"
				        + documentTypeFile.getOriginalFilename().replace(" ", "-")));
				
				String name = documentTypeFile.getOriginalFilename().replace(" ", "-");
				labTest.setFilepath(fileDirectory + "/" + name);
				commonLabTestService.saveLabTest(labTest);
			}
			catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		/*	List<String> uploadedFiels = new ArrayList<String>();
			Iterator<String> itr = documentTypeFile.getFileNames();
			MultipartFile mpf = null;
			while (itr.hasNext()) {
				mpf = documentTypeFile.getFile(itr.next());
				try {
					
					FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(context.getRealPath("/resources") + "/"
					        + mpf.getOriginalFilename().replace(" ", "-")));
					uploadedFiels.add(mpf.getOriginalFilename().replace(" ", "-"));
				}
				catch (Exception e) {
					e.printStackTrace();
				}
			}*/
		
		/*	
			if (documentTypeFile != null && documentTypeFile.length > 0 && documentTypeCurrentThread < documentTypeFile.length) {
				
				try {
					System.out.println("Document : " + documentTypeFile[0]);
					FileCopyUtils.copy(documentTypeFile[0].getBytes(), new FileOutputStream(context.getRealPath("/resources")
					        + "/" + documentTypeFile[documentTypeCurrentThread].getOriginalFilename().replace(" ", "-")));
					
					File convFile = new File(documentTypeFile[documentTypeCurrentThread].getOriginalFilename());
					documentTypeCurrentThread++;
						System.out.println("in try block !");
						//documentTypeFile[documentTypeCurrentThread].transferTo(convFile);
						documentValue = FileUtils.readFileToString(convFile);
					System.out.println("Document ::: " + convFile);
				}
				catch (IOException e) {
					e.printStackTrace();
				}
			}*/
		
		commonLabTestService.saveLabTestAttributes(labTestAttributes);
		request.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR, "Test Result saved successfully");
		return "redirect:../../patientDashboard.form?patientId=" + labTest.getOrder().getPatient().getPatientId();
	}
	
}

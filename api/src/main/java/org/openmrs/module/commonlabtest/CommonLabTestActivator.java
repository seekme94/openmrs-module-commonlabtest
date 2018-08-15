/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.commonlabtest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.GlobalProperty;
import org.openmrs.api.AdministrationService;
import org.openmrs.api.ConceptService;
import org.openmrs.api.context.Context;
import org.openmrs.module.BaseModuleActivator;

/**
 * This class contains the logic that is run every time this module is either started or shutdown
 */
public class CommonLabTestActivator extends BaseModuleActivator {
	
	private Log log = LogFactory.getLog(this.getClass());
	
	public static final String SPECIMEN_TYPE_CONCEPT_UUID = "commonlabtest.specimenTypeConceptUuid";
	
	public static final String SPECIMEN_SITE_CONCEPT_UUID = "commonlabtest.specimenSiteConceptUuid";
	
	ConceptService conceptService;
	
	/**
	 * @see #started()
	 */
	public void started() {
		log.info("Started Common Lab Test");
		
		conceptService = Context.getConceptService();
		AdministrationService administrationService = Context.getAdministrationService();
		setGlobalProperty(administrationService, SPECIMEN_TYPE_CONCEPT_UUID, "162476AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
		setGlobalProperty(administrationService, SPECIMEN_SITE_CONCEPT_UUID, "159959AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
		
	}
	
	private void setGlobalProperty(AdministrationService service, String prop, String val) {
		GlobalProperty gp = service.getGlobalPropertyObject(prop);
		if (gp == null) {
			service.saveGlobalProperty(new GlobalProperty(prop, val));
		} else if (StringUtils.isEmpty(gp.getPropertyValue())) {
			gp.setPropertyValue(val);
			service.saveGlobalProperty(gp);
		}
	}
	
	/**
	 * @see #shutdown()
	 */
	public void shutdown() {
		log.info("Shutdown Common Lab Test");
	}
	
	public void contextRefreshed() {
		log.info("========================== Common Lab Test Lab contextRefreshed called ======");
		
		conceptService = Context.getConceptService();
		
		AdministrationService administrationService = Context.getAdministrationService();
		setGlobalProperty(administrationService, SPECIMEN_TYPE_CONCEPT_UUID, "162476AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
		setGlobalProperty(administrationService, SPECIMEN_SITE_CONCEPT_UUID, "159959AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
	}
	
}

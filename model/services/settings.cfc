component accessors="true" extends="model.base.baseget"    {
	
	public any function getSettings( ){
		
		// if the settings are in the app scope load from there
		// this should only happen when called from app.before()
		if (! structKeyExists(application, 'systemSettings') ){
			return entityload('system', {}, true);
		} else {
			// settings will normally come from ehre.
			return application.systemSettings;
		}
			
		
	}

	public any function saveSettings( settings ){
					
		var system = getSettings();		
			
		system = put(system);
		
		return true;
	}


	public any function put(settingsObj) {
		
		entitysave(settingsObj);
		ormflush(); // need to persist this change immediately
			
		// set new system object to application scope
		application.systemSettings = settingsObj;		
		return settingsObj;
	}


	

}
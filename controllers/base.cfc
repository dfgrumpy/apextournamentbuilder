component accessors="true"    {


	property framework;
    property beanFactory;
	property settingsService;
	property sessionService;
	property securityService;
	property configService;
	property errorhandlerService;

	property uiHelperService;
	property ValidatorUtil;

	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}


	
	public any function before( rc ) {
		arguments.rc.uihelper = getuiHelperService();
	}

	

	public void function after( rc ) {
		/*
			We need to check if we're expected to return data in a specific format,
			instead of fully rendering the request using a normal view.
		*/
		// if we've requested data be returned in a specific format


		if( structKeyExists(rc, "returnType") && len(rc.returnType) ){

			// make sure the requested return type is allowed if not switch return to json
			if (! getValidatorUtil().canRenderReturn(rc.returnType)){
				rc.returnType = 'json';
			}

			// can the data be returned as the requested type.. if not return json.
			if (! getValidatorUtil().checkDataType(rc.returnData, rc.returnType)){
				rc.returnType = 'json';
			}

			try {
				variables.fw.renderData(rc.returnType, rc.returnData);
			} catch(Any e) {
				variables.fw.renderData("json", getErrorHandlerService().generateAjaxErrorReturn(0, "Unable to convert data to requested to #uCase(rc.returnType)#."), 500);
			}
		}

	}


}
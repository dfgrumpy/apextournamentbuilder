component accessors="true" extends="model.base.baseget"    {

	
	property fileReaderUtil;
	
	variables.config = "";
	variables.environment = "";
	variables.configDefaultIni = "default_config.ini";
	variables.configOverrideIni = "";
	variables.configPath = "/config/";
	
	
	
	public function init(required string environment, string configIni){
		

		// the file paths need to be expanded and the variables must be updated with expanded paths		
	
		// allow the default to be overridden
		if (structKeyExists(arguments,'configIni') && len(arguments.configIni)){
			variables.configDefaultIni = expandPath(variables.configPath & arguments.configIni);
		} else {
			variables.configDefaultIni = expandPath(variables.configPath & variables.configDefaultIni);
		}
		
		// do we have a config for the domain?
		// this will contain overrides that will replace settings in the default config
		// the override config may only contain a small subset of the main config
		if (fileExists(expandPath(variables.configpath & '#arguments.environment#_config.ini'))) {			
			variables.configOverrideIni = expandPath(variables.configPath & "#arguments.environment#_config.ini");
		}
		
	}

	public any function setConfigFromFile(required string environment) {
		
		var overrideConfig = '';
		variables.config = getfileReaderUtil().readConfigIni(variables.configDefaultIni);
		
		if (len(variables.configOverrideIni)){
			overrideConfig  = getfileReaderUtil().readConfigIni(variables.configOverrideIni);
		}
		
		if (isStruct(overrideConfig) && ! structIsEmpty(overrideConfig)){
			updateBaseConfig(overrideConfig);		
		}
		
		
		this.setenvironment(arguments.environment);
		
				
		
	}

	
	public any function getMemento() {
		return this;
	}
	
	
	public any function getBaseConfig() {
		return variables.config;
	}


	
	public any function getProcessedConfig() {
		
		var processed = {};		
		for (src in variables.config) {
			processed["#src#"] = get(src); 			
		}
		return processed;
	}
	
	public any function getVar(string configKey, any configValue){
		return get(argumentCollection=arguments);
	}
		
	private function get(required string configKey, any configValue){
		// set config argument
		arguments.source = variables.config;
	
		// check to see if we're lazy loading a property -- lazy loaded properties are not defined by default
		if( !structKeyExists(arguments.source, arguments.configKey) && structKeyExists(variables, "lazyLoad" & arguments.configKey) && isCustomFunction(variables["lazyLoad" & arguments.configKey]) ){
			var invoker = variables["lazyLoad" & arguments.configKey];
			// update the value and mark as default
			set(arguments.configKey, invoker(), true);
		}

		// by passing in the argument collection, we bypass making the configValue required
		return super.get(argumentCollection=arguments);
	}

	private function set(required string configKey, required any configValue, boolean setdefault = false){

		if (arguments.setdefault) {
			if (! structkeyExists(variables.config,arguments.configKey)){
				variables.config["#arguments.configKey#"] = arguments.configValue;
			}
		} else {
			variables.config["#arguments.configKey#"] = arguments.configValue;
		}

		return this;
	}
	
	private function getStructValue(any sourceStruct, string item, string configVar){
		if (! StructKeyExists(sourceStruct, arguments.item)){
			doErrorThrow(arguments.item, arguments.configVar,  sourceStruct);
		}
		return structfind(sourceStruct, arguments.item);
	}


	private function doErrorThrow(string key, string structName, any sourceStruct){
		getErrorService().throwFatailError('Key of "#arguments.key#" was not found in config item "#arguments.structName#".<br/><br/>Available keys are:<br/> #structKeyList(arguments.sourceStruct)#');	
	}
	
	
	private function updateBaseConfig(required struct updateConfig) {
		for ( var x in arguments.updateConfig ) {
			set(x, arguments.updateConfig["#x#"]);
		}
	}
	
	

	public string function getCurrentHttpBase() {
		
		if (! len(this.gethttpBase())) {		
			var base = (cgi.https == "on")? "https://" : "http://";
			set('httpBase', base);		
		}
		
		return this.gethttpBase();	
			
	}
	

	public string function getBaseFilePath() {
		
		var base = replace(CF_TEMPLATE_PATH, "/index.cfm", "");
		
		return base;
		
			
	}

	public string function getConfigEnvironment(){

		if (
			cgi.server_name contains "local" ||
			cgi.server_name contains "dev" ||
			cgi.dev_mode == true ||
			( application.keyExists( "javaProps" ) ? application.javaProps?.environment : createObject( "java", "java.lang.System" ).getProperties()?.environment ) == "dev"
		) {
			return 'dev';
		}
		return 'prod';
	}


}
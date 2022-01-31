component accessors="true" {
	
	
	public any function readConfigIni(required any filePath)  {

		var environmentProperties = {};
		var configIni = arguments.filePath;
		var configVar = {};
		var x = "";
		var thisLine = "";
		var thisVal = "";
		var varName = "";
		var varVal = "";
		var commentPos = 0;

		var configFile = fileOpen(configIni, "read");

		while( !fileisEOF(configFile) ){
			x = fileReadLine(configFile);

			thisLine = trim(x);// trim(listFirst(x, " "));

			// line is blank skip
			if( !len(thisLine) ) {
				continue;
			}
			// line just contains a comment skip
			if( left(listfirst(thisLine, '='), 2) eq "//" ){
				continue;
			}

			varName = trim(listFirst(thisLine, '='));
			varVal = trim(listRest(thisLine, "="));

			// attempt to grab email formatted value
			thisVal = rematch('\"([^\>]*?\>)', varVal);

			// not a complex email value
			if( arrayisEmpty(thisVal) ){
				// look for comments
				commentPos = reFind("(^//)|(\s+//)", varVal);

				// if comment is start of line, blank line
				if( commentPos == 1 ){
					thisVal = "";
				// else strip comments off end of line
				} else if( commentPos > 1 ){
					thisVal = trim(left(varVal, commentPos-1));
				} else {
					thisVal = varVal;
				}
			} else  {
				// if is email value an array is returned.. grab first element
				thisVal = thisVal[1];
			}
			if (isJson(trim(thisVal))){
				configVar["#varName#"] = deserializeJSON(trim(thisVal));				
			} else {
				configVar["#varName#"] = trim(thisVal);				
			}
		}

		fileClose(configFile);
		return configVar;
	}
	public any function loadTemplateFile(templateName, templatePath){
		
		
		var filePath = arguments.templatePath & '/ui/templates/' & arguments.templateName & '.html';
		
		if (fileExists(filePath)){			
			return fileread(filePath);
		} else {
			return '';
		}
		
		
	}
	public any function loadJSONFile(templatePath, filename){
		
		
		var filePath = arguments.templatePath & '/model/data/' & arguments.filename & '.json';
		
		if (fileExists(filePath)){			
			return fileread(filePath);
		} else {
			return '';
		}
		
		
	};
	
}
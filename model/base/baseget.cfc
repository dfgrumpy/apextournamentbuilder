component accessors="true"   {

	public function onMissingMethod(string missingMethodName, struct missingMethodArguments){

		var func = "";
		var methodName = '';
		var args = {};



		if (lcase(left(arguments.missingMethodName, 3)) == "get") {
			methodName = right(arguments.missingMethodName, len(arguments.missingMethodName)-3);
			func = "get";
		} if (lcase(left(arguments.missingMethodName, 3)) == "set")  {
			methodName = right(arguments.missingMethodName, len(arguments.missingMethodName)-3);
			func = "set";
		} if (lcase(left(arguments.missingMethodName, 3)) == "has")  {
			methodName = right(arguments.missingMethodName, len(arguments.missingMethodName)-3);
			
			func = "has";
		} else if (lcase(left(arguments.missingMethodName, 7)) == "default") {
			methodName = right(arguments.missingMethodName, len(arguments.missingMethodName)-7);
			func = "setdefault";
		}

		args = (StructIsEmpty(arguments.missingMethodArguments)) ? "":arguments.missingMethodArguments[1];

		if (func == "get"){
			return get(methodName, args);
		}  else if (func == 'set'){
			if (StructIsEmpty(arguments.missingMethodArguments)){
				throw 'No value passed in for set method';
			}
			return set(methodName, args);
		} else if (func == 'has'){
			return has(methodName, args);
		} else if (func == 'setdefault'){
			return set(methodName, args, true);
		} else {
			throw "Unknown function called: #missingMethodName#";
		}

	}

	public any function getVariablesScope() {
		return variables;
	}


	private function get(required struct source, string configKey, any configValue){


		var thisVar = "";
		var keyPath = arguments.configKey;
		var node = "";
		var subStrVar = "";
		var replacement = "";

		// resolve the dot notation
		while( find(".", keyPath) ){
			node = listFirst(keyPath, ".");
			// if the node doesn't exist in the current source or the next node isn't a struct, stop processing
			if( !structKeyExists(arguments.source, node) || !isStruct(arguments.source[node]) ){
				// stop processing the loop, since the key doesn't exist
				break;
			}

			// climb up the struct
			arguments.source = arguments.source[node];
			// remove the node form the path
			keyPath = listRest(keyPath, ".");
		}

	
		if( structKeyExists(arguments.source, keyPath) ){
			thisVar = arguments.source[keyPath];
			
			// var is object return
			if (isobject(thisVar)){
				return thisVar;	
			}
			
			// var is struct object with no value.  Return full struct
			if (isstruct(thisVar) && structKeyExists(arguments, "configValue") && ! len(arguments.configValue)) {
				return thisvar;
			}

			if (isstruct(thisVar)){
				try {
					if( structKeyExists(arguments, "configValue") ){
	        			thisVar = thisVar[arguments.configValue];
					}
		        } catch(Any e) {
		        	return JavaCast( "null", 0 );
		        }
			}

		} else {
			// if no default value supplied and we couldn't find the value, return null
			if( !structKeyExists(arguments, "configValue") ){
				return JavaCast( "null", 0 );
			// return the specified default value
			} else {
				return arguments.configValue;
			}
		}
		
		// base config may contain dynamic var.. lets try and replace it
		if (isSimpleValue(thisvar)) { // make sure we only do this against simple vars
			while (isDynamc(thisVar)) {				
				subStrVar = reMatch('\${\S*?}',thisVar);
				thisVarName = mid(subStrVar[1], 3, len(subStrVar[1])-3);
				
				replacement = isArray(subStrVar) ? get(thisVarName): '';		
				
				if (! isDefined('replacement')) {
					// might be a function call.. lets try that							
					try {
                    	replacement = myStaticFunction(thisVarName);
                    } catch(Any e) {
                    	replacement = '';
                    }
				}
				thisVar = replace(thisVar,subStrVar[1],replacement);
          
			}
			if (len(replacement)){
				set(arguments.configKey, thisVar);				
			}
			
			while (isSystemScope(thisVar)) {				
				subStrVar = reMatch('\&{\S*?}',thisVar);				
				thisVarName = mid(subStrVar[1], 3, len(subStrVar[1])-3);
				replacement = isArray(subStrVar) ? structGet(thisVarName) : '';				
				thisVar = replace(thisVar,subStrVar[1],replacement);
			}
		}

		
		return thisVar;
	}
	
	private function set(required string thisKey, required any thisValue, boolean setdefault = false){

		if (arguments.setdefault) {
			if (! structkeyExists(variables, arguments.thisKey)){
				variables["#arguments.thisKey#"] = arguments.thisValue;
			}
		} else {
			variables["#arguments.thisKey#"] = arguments.thisValue;
		}

		return this;
	}
	
	
	private any function isDynamc(required string source){
		return find("${", source)? true:false;				
	}

	private any function isSystemScope(required string source){		
		return find("&{", source)? true:false;
	}
	
	function myStaticFunction(methodName) {
	    var method = variables[methodName];
	    return method();
	}
	
	
	public any function getMemento() {
		return this;
	}
	
	public any function getVariables() {
		return variables;
	}
	

}
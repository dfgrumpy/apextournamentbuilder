component accessors="true" hint="service for dealing with error reporting"  {
	
	
	public struct function generateAjaxErrorReturn( required any errorCode, required string errorMessage )
		hint="normalizes return errors for ajax requests so they all follow the same format"  {
		
		var errorStruct = {errorCode = arguments.errorCode, errorMessage = arguments.errorMessage};
		
		return errorStruct;
		
	}
	
	public function logError(required exception) {
		
		var data = {};
		data.errorMessage = arguments.exception?.exception?.rootcause?.message ?: '';
		data.errorException = arguments.exception?.exception?.rootcause?.StackTrace ?: '';
		data.failedaction = arguments.exception.failedaction;
		data.failedcfcname = arguments.exception.failedcfcname;
		data.failedmethod = arguments.exception.failedmethod;
		
		
		var	err = entitynew("errorLog", data);
		entitysave(err);
		
		return err.getguid();
	}
}
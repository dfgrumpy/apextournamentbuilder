component accessors="true" hint="service for dealing with error reporting"  {
	
	
	public struct function generateAjaxErrorReturn( required any errorCode, required string errorMessage )
		hint="normalizes return errors for ajax requests so they all follow the same format"  {
		
		var errorStruct = {errorCode = arguments.errorCode, errorMessage = arguments.errorMessage};
		
		return errorStruct;
		
	}
	

}
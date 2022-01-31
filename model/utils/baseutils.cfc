component accessors="true" {

	


	public string function getDomainFromEmail(required string baseString) {
		
		//return replaceNoCase(listlast(arguments.baseString, "@"), ".com", '');
		return listlast(arguments.baseString, "@");
		
	}

}
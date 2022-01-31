component accessors="true" hint="utility for validating data"
{

	public string function checkDataType(required any source, required string expected) hint="checks source var against expected data type to make sure they match"
	{
	
		switch(arguments.expected)
		{
			case "xml":
				if(!isSimpleValue(arguments.source))
				{
					return false;
				}
				return isXML(arguments.source);
				break;
			case "json":
				return isjSON(arguments.source);
				break;
			case "numeric":
				return isNumeric(arguments.source);
				break;
			case "string":
				return isSimpleValue(arguments.source);
				break;
			default:
				return isValid(arguments.expected, arguments.source);
		}
		
	}
	
	public string function canRenderReturn(required any returnType) hint="validates that fw/1 renderData() can return requested type"
	{
	
		var allowedReturns = 'json,string,xml';
		
		return listfindnocase(allowedReturns, arguments.returnType);
	}
	
}
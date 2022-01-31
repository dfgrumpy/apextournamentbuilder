component persistent="true" object="errorlog" extends="base" {

	
	property name="guid" ormtype="text" ;
	property name="failedaction" ormtype="string";
	property name="failedcfcname" ormtype="string";
	property name="failedmethod" ormtype="string";
	property name="errorMessage" ormtype="text";
	property name="errorException" ormtype="text";
	property name="usererrordetail" ormtype="text";
		
	
	function init() {
		
		variables.guid = createuuid();
		
	}

}
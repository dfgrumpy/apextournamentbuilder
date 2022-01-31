component persistent="true" object="maillog" extends="base" {

	
	property name="guid" ormtype="string" ;
	property name="emailevent" ormtype="string";
	property name="eventid" ormtype="integer";
	property name="recipient" ormtype="string";
	property name="subject" ormtype="string";
	property name="body" ormtype="text";
		
	
	function init() {		
		variables.guid = createuuid();
	}




}


component persistent="true" object="user" extends="base" table="users" {

	property name="firstname" ormtype="string";
	property name="lastname" ormtype="string";
	property name="email" ormtype="string";
	property name="lastlogin" ormtype="timestamp";
	property name="password" ormtype="string";
	property name="salt" ormtype="string";
	property name="customurl" ormtype="string" hint="For using custom url to get to tournament list";
	property name="status" ormtype="int" default="0";
	property name="resetlockout" ormtype="boolean" default="0"   ;
	property name="notificationExlude" ormtype="boolean" default="0";
	
	property name="securityrole" fieldtype="many-to-one" fkcolumn="roleid" cfc="role";
	property name="tournament" fieldtype="one-to-many" cfc="tournament" fkcolumn="userid" lazy="true" ;



	public any function getFullName() {
		return getFirstname() & ' ' & getLastname();
	}



	public any function getloginShort() {
		return listFirst(getemail(), "@");
	}
	public any function getStatusString() {

		var statusArray = ['Inactive','Active'];

		if ( getStatus() == -1) {
			return 'Unverified'	;
		} else {
			// need to add 1 to element because we can't have a "0" as an array element
			return statusArray[getStatus()+1];
		}

	}
	
	public any function PreUpdate(){

	}
	
	public any function preInsert(){
	
	}
	


	public any function PostUpdate(){

	}

}
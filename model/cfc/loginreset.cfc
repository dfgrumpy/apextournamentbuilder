component persistent="true" object="loginreset" extends="base" {
	property name="resetlink" ormtype="string" ;
	property name="user" fieldtype="one-to-one" fkcolumn="userid" cfc="user" ;
	
}


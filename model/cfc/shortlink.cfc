component persistent="true" object="shortlink" extends="base" table="shortlink" {

	property name="shortlink" ormtype="string" unique="true" length="15" ;
	property name="linkkey" ormtype="string" length="5000";

}
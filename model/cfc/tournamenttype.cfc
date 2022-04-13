component persistent="true" object="tournamenttype" extends="base" table="tournamenttype" {

	property name="name" ormtype="string";

	property name="hasteams" ormtype="integer" default="1" ;   

}
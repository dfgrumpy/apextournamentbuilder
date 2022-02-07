component persistent="true" object="team" extends="base" table="team" {

	property name="name" ormtype="string";
	property name="status" ormtype="integer" default="1" ;   

	
	property name="tournament" fieldtype="many-to-one" cfc="tournament";  
	property name="player" fieldtype="one-to-many" cfc="player" fkcolumn="teamid" lazy="true";	

}

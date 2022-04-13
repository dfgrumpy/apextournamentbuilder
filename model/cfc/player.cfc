component persistent="true" object="player" extends="base" table="player" {

	property name="gamername" ormtype="string";
	property name="originname" ormtype="string" hint="use by api to pull player stats for pc players";
	property name="steamname" ormtype="string" hint="use by api to pull player stats for pc players";
	property name="email" ormtype="string";
	property name="discord" ormtype="string";
	property name="twitter" ormtype="string";
	property name="twitch" ormtype="string";
	property name="platform" ormtype="string" hint="pc, xbl, psn";
	property name="streaming" ormtype="boolean" default="0";
	property name="alternate" ormtype="boolean" default="0";
	property name="approved" ormtype="integer" default="0";

	property name="playerrank" ormtype="string";
	property name="level" ormtype="integer";
	property name="kills" ormtype="float";
	property name="invitekey" ormtype="string";
	property name="tracker" ormtype="boolean" default="0";
	

	property name="tournament" fieldtype="many-to-one" cfc="tournament";  

	property name="team" fieldtype="many-to-one" fkcolumn="teamid" cfc="team" lazy="true";


	public any function getTrackerPlatform(){

		if (this.getplatform() eq "pc"){ 
			return 'origin';
		} else {
			return this.getplatform();
		}

	}
	


}
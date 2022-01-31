component persistent="true" object="tournament" extends="base" table="tournament" {

	property name="tournamentname" ormtype="string";
	property name="eventdate" ormtype="string";
	property name="registrationstart" ormtype="timestamp";
	property name="registrationend" ormtype="timestamp";
	property name="registrationkey" ormtype="string";
	property name="adminkey" ormtype="string";
	property name="allowlate" ormtype="boolean" default="0";
	property name="teamsize" ormtype="integer" default="3" ;
	property name="registrationtype" ormtype="integer" default="1" hint="1 = invitational, 2 = self reg";
	property name="details" ormtype="text";

	property name="player" fieldtype="one-to-many" cfc="player" fkcolumn="tournamentid" lazy="true";	
	property name="team" fieldtype="one-to-many" cfc="team" fkcolumn="tournamentid" lazy="true";
	property name="owner" fieldtype="many-to-one" cfc="user" lazy="true";  

	property name="type" fieldtype="many-to-one" fkcolumn="tournamenttypeid" cfc="tournamenttype";


	public any function countStreamersForTournament(){

		var data =  queryexecute('select 1 from player where streaming = 1 and tournamentid = :tid', {tid: this.getid()});
		return data.recordcount;
	}

	public any function filledTeamsForTournament(){

		var data =  queryexecute('select teamid, count(teamid) as playercount
									from player
									where tournamentid = :tid
									group by teamid
									having playercount = :size', {tid: this.getid(), size: this.getteamsize()});
		return data.recordcount;

	}

	public any function countStreamersForTournament2(){

		var data =  queryexecute('select 1 from player where streaming = 1 and tournamentid = :tid', {tid: this.getid()});
		return data.recordcount;
	}
	
	public any function PreUpdate(){
		super.PreUpdate();
	}
	
	public any function preInsert(){
	
		super.preInsert();
	}
	


	public any function PostUpdate(){

	}

}
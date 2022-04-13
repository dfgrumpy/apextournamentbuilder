component persistent="true" object="tournament" extends="base" table="tournament" {

	property name="tournamentname" ormtype="string";
	property name="eventdate" ormtype="timestamp";
	property name="timezone" ormtype="string";
	property name="registrationstart" ormtype="date";
	property name="registrationend" ormtype="date";
	property name="registrationcutoff" ormtype="date";
	property name="registrationkey" ormtype="string";
	property name="viewkey" ormtype="string";
	property name="adminkey" ormtype="string";
	property name="allowlate" ormtype="boolean" default="0";
	property name="individual" ormtype="boolean" default="0";
	property name="emailrequired" ormtype="boolean" default="0";
	property name="lockonfull" ormtype="boolean" default="0";
	property name="registrationenabled" ormtype="boolean" default="1";
	property name="teamsize" ormtype="integer" default="3" ;
	property name="registrationtype" ormtype="integer" default="1" hint="1 = invitational, 2 = open";
	property name="details" ormtype="text";
	property name="rules" ormtype="text";
	property name="contactemail" ormtype="string" default="";
	property name="player" fieldtype="one-to-many" cfc="player" fkcolumn="tournamentid" lazy="true";	
	property name="team" fieldtype="one-to-many" cfc="team" fkcolumn="tournamentid" lazy="true";
	property name="owner" fieldtype="many-to-one" cfc="user" lazy="true";  

	property name="type" fieldtype="many-to-one" fkcolumn="tournamenttypeid" cfc="tournamenttype";


	public any function countStreamersForTournament(){

		var data =  queryexecute('select 1 from player where streaming = 1 and tournamentid = :tid', {tid: this.getid()});
		return data.recordcount;
	}
	
	public any function countPlayersInTournament(approved = 1, team=true){
		
		if (arguments.approved eq 'all'){
			appr = '';
		} else {
			appr = ' and approved = #arguments.approved#';
		}
		if (arguments.team) {
			team = ' and teamid is not null';
		} else {
			team = ' and teamid is null';
		}

		var data =  queryexecute('select 1 from player where tournamentid = :tid #team# #appr#', {tid: this.getid()});
		return data.recordcount;
	}

	
	public any function filledTeamsForTournament(approved = 1){
		if (arguments.approved eq 'all'){
			appr = '';
		} else {
			appr = ' and approved = #arguments.approved#';
		}
		var data =  queryexecute('select teamid, count(teamid) as playercount
									from player
									where tournamentid = :tid #appr#
									group by teamid
									having playercount = :size', {tid: this.getid(), size: this.getteamsize()});
		return data.recordcount;

	}

	public any function geteventdateForForm(){
		return this.geteventdate().dateformat('yyyy-mm-dd') & 'T' & this.geteventdate().timeformat('HH:nn');
	}

	


	public any function getviewkeyShort(){
		var data =  queryexecute('select shortlink from shortlink where linkkey = :lk', {lk: this.getviewkey()});
		return data.shortlink;
	}

	public any function getadminkeyShort(){
		var data =  queryexecute('select shortlink from shortlink where linkkey = :lk', {lk: this.getadminkey()});
		return data.shortlink;
	}
	


	public any function PostUpdate(){

	}

}
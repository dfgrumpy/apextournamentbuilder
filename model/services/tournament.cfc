component accessors="true" hint="for tournament items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	property userService;
	

	public any function getTournamentsForOwner(){
		return entityload("tournament", {owner=getSessionService().getloginuser()});
	}

	public any function getPlayerListForTournament(required numeric tournamentid){

		return entityload("player", {tournament= entityLoadByPK('tournament', arguments.tournamentid)});

	}

	public any function getTournamentByKey(required numeric tournamentid){

		return entityLoadByPK('tournament', arguments.tournamentid);

	}

	public any function getTournamentTypes(){
		return entityLoad('tournamenttype');
	}


	public any function getTournamentPlayersNoTeam (required numeric tournamentid){

		return ormExecuteQuery('from player where tournament = #arguments.tournamentid# and team is null');

	}





	public any function saveNewTournament(required struct data) {
        var tdata = arguments.data;
		var owner = getSessionService().getloginuser();

		
		var regkey = getSecurityService().generateKey();
		var adminkey = getSecurityService().generateKey();

		var tourneyStruct = {
			'tournamentname': tdata.tourneyname,
			'eventdate': tdata.eventdate,
			'registrationstart': data.regstart  ?: '',
			'registrationend': data?.regend ?: '',
			'registrationkey': regkey,
			'adminkey': adminkey,
			'allowlate': data?.latereg ?: 0,
			'details': tdata.tourneydetail,
			'registrationtype': data.regtype,
			'owner' : owner
		};
        

		var thisTourney = entityNew("tournament", tourneyStruct);
		entitysave(thisTourney);
		ormflush();

	}

	public any function editTournament(required struct data) {
        

		//writeDump(arguments);abort;

		var thisTourney = getTournamentByKey(arguments.data.tournamentid);

		if (arguments.data.tournamentname.len() gte 5){
			thisTourney.settournamentname( arguments.data.tournamentname );
		}
		if (arguments.data.eventdate.len()){
			thisTourney.seteventdate( arguments.data.eventdate );
		}
		thisTourney.setregistrationstart( arguments.data.registrationstart );
		thisTourney.setregistrationend( arguments.data.registrationend );
		thisTourney.setallowlate( arguments.data.allowlate );
		thisTourney.setdetails( arguments.data.details );

		if (arguments.data.teamsize NEQ 0){
			thisTourney.setteamsize( arguments.data.teamsize );
		}
		thisTourney.settype( entityLoadByPK('tournamenttype', data.type ));
    
		entitysave(thisTourney);
		ormflush();

	}


	public any function deleteTournament(required any data){

		// delete players
		queryexecute('delete from player where tournamentid = :tid', {tid: arguments.data});
		
		// delete teams
		queryexecute('delete from team where tournamentid = :tid', {tid: arguments.data});

		// delete tournament
		var tourney = getTournamentByKey(arguments.data);
		entityDelete(tourney);
		ormflush();
		return true;


	}


}
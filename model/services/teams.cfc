component accessors="true" hint="for tournament items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	property userService;
	property tournamentService;
	property playerService;
	


	public any function getTeamPlayerCountsForTournament(required numeric tournamentid){
		var data =  queryexecute('select t.id, t.name, count(p.id) AS playercount
									from team t
									left join player p on t.id = p.teamid
									where t.tournamentid = ?
									group by t.id, t.name', [arguments.tournamentid]);
	
		return data;
	}

	public any function getEmptyTeamsForTourney(tournamentdata){

		var data =  queryexecute('select * from arguments.tournamentdata where playercount = 0', {}, { dbtype="query" } );
	
		return data;

	}

	public any function createTeam(required string teamname, required numeric tournamentid){

		var exists = checkForTeamByName(arguments.teamname, arguments.tournamentid);

		if (! exists) {
			var teamStruct = {
				'name': arguments.teamname,
				'tournament': entityLoadByPK('tournament', arguments.tournamentid),
				'status': 1
			};
				
			var thisTourney = entityNew("team", teamStruct);
			entitysave(thisTourney);
			ormflush();
			return 1;
		}
		return 0;

	}


		
	public any function deleteTeam( required string teamid, required numeric tournamentid ) {

		var teamdata = getTeamByidTournament(arguments.teamid, arguments.tournamentid);

		if (isNull(teamdata)) {
			return 0;
		}

		queryexecute('update player set teamid = 0 where teamid = :tid', {tid: arguments.teamid});
		queryexecute('delete from team where id = :tid', {tid: arguments.teamid});

		return 1;
	}


	public any function checkForTeamByName(required string teamname, required numeric tournamentid){

		res = entityload("team", {name = arguments.teamname, tournament= entityLoadByPK('tournament', arguments.tournamentid)}, true);
		return isNull(res) ? false:true;

	}

	public any function getTeamByidTournament(required string teamid, required numeric tournamentid){
		return entityload("team", {id = arguments.teamid, tournament= entityLoadByPK('tournament', arguments.tournamentid)}, true);
	}



	public any function updateTeamPlayer(required string playerid, required string teamid, required numeric type, required numeric tournamentid){

		if (!getplayerservice().isPlayerinTournament(arguments.playerid, arguments.tournamentid)){
			writeDump('failed here');abort;
			return false;
		}

		if (arguments.type == 0 ) { // remove player from team
			queryexecute('update player set teamid = NULL where id = :player and tournamentid = :tourney', {player: arguments.playerid, tourney: arguments.tournamentid});
		}

		if (arguments.type == 1 ) { // add player from team
			queryexecute('update player set teamid = :team where id = :player and tournamentid = :tourney', {player: arguments.playerid, team: arguments.teamid, tourney: arguments.tournamentid});
		}



		return true;
	}

	



}
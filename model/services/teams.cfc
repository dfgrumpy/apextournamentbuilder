component accessors="true" hint="for team items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	property userService;
	property tournamentService;
	property playerService;
	property notificationService;
	


	public any function getTeamByKey(required numeric teamid){

		return entityLoadByPK('team', arguments.teamid);

	}

	
	public any function getTeamByKeyTournament(required numeric teamid, required numeric tournamentid){

		return entityload("team", {id : arguments.teamid, tournament : entityLoadByPK('tournament', arguments.tournamentid)}, true);

	}

	
	public any function getTeamPlayerCountsForTournament(required numeric tournamentid, required approvedonly = 1, required showalternate = 0){

		if ( arguments.approvedonly) {
			appr = ' and t.approved = 1 ';
		} else {
			appr = '';
		}
		if ( !arguments.showalternate) {
			alt = ' and t.alternate = 0 ';
		} else {
			alt = '';
		}

		var data =  queryexecute('select t.id, t.name, t.alternate, t.approved, count(p.id) AS playercount
									from team t
									left join player p on t.id = p.teamid
									where t.tournamentid = ? #appr# #alt#
									group by t.id, t.name, t.alternate, t.approved', [arguments.tournamentid]);
		
		return data;
	}


	public any function getTeamPlayerCountsForTournamentAlt(required numeric tournamentid, required approved = 1, required showalternate = 0, required fullonly = 1){

		if ( arguments.approved eq 1) {
			appr = ' and t.approved = 1 ';
		} else if ( arguments.approved eq -1) {
			appr = ' and t.approved = -1 ';
		} else {
			appr = ' and t.approved = 0 ';
		}
		if ( !arguments.showalternate) {
			alt = ' and t.alternate = 0 ';
		} else {
			alt = '';
		}

		var data =  queryexecute('select t.id, t.name, t.alternate, t.approved, count(p.id) AS playercount
									from team t
									left join player p on t.id = p.teamid
									where t.tournamentid = ? #appr# #alt#
									group by t.id, t.name, t.alternate, t.approved
									', [arguments.tournamentid]);
		
		return data;
	}

	public any function getApprovedTeamsForTournament(required numeric tournamentid){


		var data =  queryexecute('select 1
									from team t
									where t.tournamentid = ? and approved = 1', [arguments.tournamentid]);

		return data.recordcount;
	}


	public any function getUnApprovedTeamsForTournament(required numeric tournamentid){


		var data =  queryexecute('select 1
									from team t
									where t.tournamentid = ? and approved = 0', [arguments.tournamentid]);

		return data.recordcount;
	}
	

	public any function getEmptyTeamsForTourney(tournamentdata){

		var data =  queryexecute('select * from arguments.tournamentdata where playercount = 0', {}, { dbtype="query" } );
		return data;

	}
	public any function createTeam(required string teamname, required numeric tournamentid, required numeric returnid = false, required approved = 1, required alternate = 0){

		var exists = checkForTeamByName(arguments.teamname, arguments.tournamentid);

		if (! exists) {
			var teamStruct = {
				'name': arguments.teamname,
				'tournament': entityLoadByPK('tournament', arguments.tournamentid),
				'status': 1,
				'approved' : arguments.approved,
				'alternate' : arguments.alternate
			};
				
			var thisTeam = entityNew("team", teamStruct);
			entitysave(thisTeam);
			ormflush();
			return arguments.returnid ? thisTeam.getid() : 1;
		}
		return 0;

	}
		
	public any function deleteTeam( required string teamid, required numeric tournamentid ) {

		var teamdata = getTeamByidTournament(arguments.teamid, arguments.tournamentid);

		if (isNull(teamdata)) {
			return 0;
		}

		// deleting unapproved team... delete players
		if (!teamdata.getapproved()) {
			queryexecute('delete from player where teamid = :tid', {tid: arguments.teamid});			
		} else {
			queryexecute('update player set teamid = 0 where teamid = :tid', {tid: arguments.teamid});
		}

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



	public any function updateTeamPlayer(required string playerid, required string teamid, required numeric type, required numeric tournamentid, required boolean precheck = false){
		
		if (! arguments.precheck) {
			if (!getplayerservice().isPlayerinTournament(arguments.playerid, arguments.tournamentid)){
				return false;
			}
		}

		if (arguments.type == 0 ) { // remove player from team
			queryexecute('update player set teamid = NULL where id = :player and tournamentid = :tourney', {player: arguments.playerid, tourney: arguments.tournamentid});
		}

		if (arguments.type == 1 ) { // add player from team
			queryexecute('update player set teamid = :team where id = :player and tournamentid = :tourney', {player: arguments.playerid, team: arguments.teamid, tourney: arguments.tournamentid});
		}

		return true;
	}



	public any function fillTeams(required string teamprefix, required numeric tournamentid){

		var tourney = gettournamentService().getTournamentByKey(arguments.tournamentid);

		var totalTeams = 60/tourney.getteamsize();

		for (i = tourney.getteam().len()+1; i <= totalTeams; i++) {
			thisName = '#arguments.teamprefix# #i#';
			thisteam = entityNew("team", {name: '#thisname#', tournament: tourney});
			entitysave(thisteam);
			ormflush();
		}

	}

	public any function editTeam(required string teamname, required numeric teamid, required numeric tournamentid){

		var team = getTeamByKeyTournament(arguments.teamid, arguments.tournamentid );
		if (! isNull(team)) {
			var exists = checkForTeamByName(arguments.teamname, arguments.tournamentid);
			if (! exists) {
				if (arguments.teamname.len()) {
					team.setname(arguments.teamname);
					entitysave(team);
					ormflush();
					return true;
				}

			}
	
		}
		return false;
	}
	
	
	public any function clearAllTeamsForTournament( required numeric tournamentid ) {

		queryexecute('update player set teamid = null where tournamentid = :aid', {aid: arguments.tournamentid});

	}


	public any function approveTeam( required string teamid, required numeric tournamentid ) {

		var teamdata = getTeamByidTournament(arguments.teamid, arguments.tournamentid);
		
		if (isNull(teamdata)) {
			return 0;
		} 

		queryexecute('update player set approved = 1 where teamid = :tid', {tid: arguments.teamid});		
		
		teamdata.setApproved(1);
		//teamdata.setAlternate(0);
		entitysave(teamdata);
		ormflush();

		getNotificationService().sendTeamApproved(teamdata.getid(), teamdata.getTournament());

		return 1;
	}
	public any function rejectTeam( required string teamid, required numeric tournamentid ) {

		var teamdata = getTeamByidTournament(arguments.teamid, arguments.tournamentid);

		if (isNull(teamdata)) {
			return 0;
		}

		queryexecute('update player set approved = -1 where teamid = :tid', {tid: arguments.teamid});		
		
		teamdata.setApproved(-1);
		entitysave(teamdata);
		ormflush();

		getNotificationService().sendTeamRejected(teamdata.getid(), teamdata.getTournament());

		return 1;
	}
	public any function rescindteam( required string teamid, required numeric tournamentid ) {

		var teamdata = getTeamByidTournament(arguments.teamid, arguments.tournamentid);

		if (isNull(teamdata)) {
			return 0;
		} 
		queryexecute('update player set approved = 0 where teamid = :tid', {tid: arguments.teamid});		
	
		teamdata.setApproved(0);
		entitysave(teamdata);
		ormflush();


		getNotificationService().sendTeamPending(teamdata.getid(), teamdata.getTournament());

		return 1;
	}

}
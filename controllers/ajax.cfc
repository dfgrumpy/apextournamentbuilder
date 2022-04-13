component accessors="true" extends="base"       {


	property tournamentService;
	property playerService;
	property teamsService;
	property matchmakerService;
	property userService;

	public any function before( rc ) {
		super.before(rc);

		rc.returnType = 'ajax';
		rc.RETURNDATA = '';

	}


	public any function modal( fw ) {

		rc.uihelper = getuiHelperService();

		if (rc.content is 'playerdetail' || rc.content is 'playeredit') {
			// TODO:  need to secure this to can't load player outside of current tournament
			rc.player = getPlayerService().getPlayerByKey(rc.playerid);
			getsessionservice().seteditplayerid(rc.playerid);
			
		} else if (rc.content is 'playernew') {
			rc.tournament = getTournamentService().getTournamentByKey(rc.tournamentid);
			getsessionservice().setNewPlayerTID(rc.tournamentid);
						
		} else if (rc.content is 'tournamentedit') {
			getsessionservice().setedittournamentid(rc.tournamentid);
			rc.tournament = getTournamentService().getTournamentByKey(rc.tournamentid);	
			rc.tournamenttypes = getTournamentService().getTournamentTypes();			
		} else if (rc.content is 'teamnew' || rc.content is 'teamfill') {
			getsessionservice().setedittournamentid(rc.tournamentid);				
		} else if (rc.content is 'teamedit') {
			rc.team = getTeamsService().getTeamByKeyTournament(rc.teamid, getsessionservice().gettournamentmanageid() );
		} else if (rc.content is 'teammembers') {

			if (! getsessionservice().gettournamentmanageid().len() && (session.keyExists('AnonTournamentID') && session.publicAcessType eq 3)) {
				rc.tournament = getTournamentService().getTournamentByKey(getsessionservice().getAnonTournamentID());
			} else {
				rc.tournament = getTournamentService().getTournamentByKey(getsessionservice().gettournamentmanageid());
			}

			rc.players = getPlayerService().getPlayerByTeam(rc.tournament.getid(), rc.teamid);

		} else if (rc.content is "tournamentrules") {
			rc.tournament = getTournamentService().getTournamentByKey(rc.tournamentid);				
		}

		// modal ui is handed via onmissingview in app cfc
		structDelete(rc, "returnType");
		
	}


	public any function savedata( fw ) {
		if (structKeyExists(rc, 'item') && rc.item == 'forgotlogin'){

			var forgotUser = getuserService().getUserByEmail(rc.accountEmail);
			if (isNull(forgotUser) || forgotuser.getStatus() == 0) {
				// unknown email don't process
				rc.RETURNDATA = false;
			} else {
				if (forgotUser.getStatus()) {
					getUserService().forgotpassword(forgotUser, rc.accountEmail);
					rc.RETURNDATA = true;
				} 
				rc.RETURNDATA = false;
			}
			

		} else if (structKeyExists(rc, 'item') && rc.item == 'playeredit'){
			var playerdata = {
				playerid: getsessionservice().geteditplayerid(),
				playername: rc.playername,
				discord: rc.discord,
				Twitter: rc.Twitter, 
				twitch: rc.twitch, 
				Platform: rc.Platform,
				PlayerRank: rc.rank,
				Level: rc.Level,
				Kills: rc.Kills,
				Originname: rc.Originname,
				Streaming: rc?.Streaming ?: 0,
				alternate: rc?.alternate ?: 0
			};
			getplayerService().savePlayerEdit(playerdata);
			rc.RETURNDATA = true;
		} else if (structKeyExists(rc, 'item') && rc.item == 'playernew'){
			var playerdata = {
				tournamentid : getsessionservice().getNewPlayerTID(),
				playername: rc.playername,
				discord: rc.discord,
				Twitter: rc.Twitter, 
				twitch: rc.twitch, 
				Platform: rc.Platform,
				PlayerRank: rc.rank,
				Level: rc.Level,
				Kills: rc.Kills,
				Originname: rc.Originname,
				Streaming: rc?.Streaming ?: 0,
				tracker: rc?.trackerLoad ?: 0,
				alternate: rc?.alternate ?: 0
			};
			
			var newplayer = getplayerService().saveNewPlayer(playerdata);

			if (isObject(newplayer)) {
				rc.RETURNDATA = true;
			} else {
				rc.RETURNDATA = newplayer;
			}


		} else if (structKeyExists(rc, 'item') && rc.item == 'deleteplayer'){
			getplayerService().deleteplayer(rc.playerid);
			rc.RETURNDATA = true;
		} else if (structKeyExists(rc, 'item') && rc.item == 'deleteTournament'){
			getTournamentService().deleteTournament(rc.tournamentid);
			rc.RETURNDATA = true;
		} else if (structKeyExists(rc, 'item') && rc.item == 'tournamentedit'){

			var tournamentData = {
				tournamentid: getsessionservice().getedittournamentid(),
				tournamentname : rc.tourneyname,
				contactemail : rc.contactemail,
				eventdate : rc?.eventdate ?: 0,
				teamsize : rc?.teamsize ?: 0,
				registrationstart : rc?.regstart ?: '',
				registrationend : rc?.regend ?: '',
				allowlate: rc?.latereg ?: 0,
				details : rc.tourneydetail,
				rules : rc.tourneyrules,
				type : rc.tourneytype
			};

			getTournamentService().editTournament(tournamentData);
			rc.RETURNDATA = true;
		} else if (structKeyExists(rc, 'item') && rc.item == 'teamnew') {
			saved = getTeamsService().createTeam(rc.teamname, getsessionservice().gettournamentmanageid());
			rc.RETURNDATA = saved;
		} else if (structKeyExists(rc, 'item') && rc.item == 'deleteTeam'){
			saved = getTeamsService().deleteTeam(rc.teamid, getsessionservice().gettournamentmanageid());
			rc.RETURNDATA = saved;
		} else if (structKeyExists(rc, 'item') && rc.item == 'playerteamupdate'){
			result = getteamsService().updateTeamPlayer(rc.playerid, rc.teamid, rc.type, getsessionservice().gettournamentmanageid());
			rc.RETURNDATA = result;
		} else if (structKeyExists(rc, 'item') && rc.item == 'teamfill'){			
			saved = getTeamsService().fillTeams(rc.teamnameprefix, getsessionservice().getedittournamentid());
			rc.RETURNDATA = true;
		} else if (structKeyExists(rc, 'item') && rc.item == 'teamedit'){		
			saved = getTeamsService().editTeam(rc.teamname, rc.teamid, getsessionservice().gettournamentmanageid());
			rc.RETURNDATA = saved;
		} else if (structKeyExists(rc, 'item') && rc.item == 'teammatchmaking'){	

			if (rc.tournamentid != getsessionservice().gettournamentmanageid()) {
				rc.RETURNDATA = false;
			} else {
				data = {
					'filltype': rc.filltype,
					'console': rc.console,
					'reset': rc.reset,
					'tournamentid': rc.tournamentid
				}		
				saved = getmatchmakerService().teammatchmaking(data, getsessionservice().gettournamentmanageid());
				rc.RETURNDATA = saved;
			}
		} else if (structKeyExists(rc, 'item') && rc.item == 'approveteam'){
			saved = getTeamsService().approveTeam(rc.teamid, getsessionservice().gettournamentmanageid());
			rc.RETURNDATA = saved;
		} else if (structKeyExists(rc, 'item') && rc.item == 'rejectteam'){
			saved = getTeamsService().rejectTeam(rc.teamid, getsessionservice().gettournamentmanageid());
			rc.RETURNDATA = saved;
		} else if (structKeyExists(rc, 'item') && rc.item == 'rescindteam'){
			saved = getTeamsService().rescindteam(rc.teamid, getsessionservice().gettournamentmanageid());
			rc.RETURNDATA = saved;
		} else if (structKeyExists(rc, 'item') && rc.item == 'approvePlayer'){
			saved = getPlayerService().setPlayerApprovalState(rc.playerid, getsessionservice().gettournamentmanageid(), 1, true);
			rc.RETURNDATA = saved;
		} else if (structKeyExists(rc, 'item') && rc.item == 'rejectplayer'){
			saved = getPlayerService().setPlayerApprovalState(rc.playerid, getsessionservice().gettournamentmanageid(), -1, true);
			rc.RETURNDATA = saved;
		} else if (structKeyExists(rc, 'item') && rc.item == 'rescindplayer'){
			saved = getPlayerService().setPlayerApprovalState(rc.playerid, getsessionservice().gettournamentmanageid(), 0, true);
			rc.RETURNDATA = saved;
		} 
		



		
		
	}
	public any function trackerload( fw ) {
		getplayerService().getTrackerData(rc.playerid);
		rc.RETURNDATA = true;
	}
}




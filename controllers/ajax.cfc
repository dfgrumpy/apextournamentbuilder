component accessors="true" extends="base"       {


	property tournamentService;
	property playerService;

	public any function before( rc ) {
		super.before(rc);

		rc.returnType = 'ajax';
		rc.RETURNDATA = '';

	}


	public any function modal( fw ) {

		rc.uihelper = getuiHelperService();

		if (rc.content is 'playerdetail') {

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
		} 

		// modal ui is handed via onmissingview in app cfc
		structDelete(rc, "returnType");
		
	}


	public any function savedata( fw ) {

	
		if (structKeyExists(rc, 'item') && rc.item == 'playeredit'){
			var playerdata = {
				playerid: getsessionservice().geteditplayerid(),
				playername: rc.playername,
				discord: rc.discord,
				Twitter: rc.Twitter, 
				twitch: rc.twitch, 
				Platform: rc.Platform,
				rank: rc.rank,
				Level: rc.Level,
				Kills: rc.Kills,
				Originname: rc.Originname,
				Streaming: rc?.Streaming ?: 0
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
				rank: rc.rank,
				Level: rc.Level,
				Kills: rc.Kills,
				Originname: rc.Originname,
				Streaming: rc?.Streaming ?: 0,
				tracker: rc?.trackerLoad ?: 0
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
				eventdate : rc?.eventdate ?: 0,
				teamsize : rc?.teamsize ?: 0,
				registrationstart : rc?.regstart ?: '',
				registrationend : rc?.regend ?: '',
				allowlate: rc?.latereg ?: 0,
				details : rc.tourneydetail,
				type : rc.tourneytype
			};

			getTournamentService().editTournament(tournamentData);
			rc.RETURNDATA = true;
		}
	}


	public any function trackerload( fw ) {
		getplayerService().getTrackerData(rc.playerid);
		rc.RETURNDATA = true;
	}
}




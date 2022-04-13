component accessors="true" hint="for player items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	property userService;
	property apexaipService;
	property tournamentService;
	property notificationService;
	
	public any function getPlayerByKey(required numeric playerid){
		return entityLoadByPK('player', arguments.playerid);
	}

	public any function getPlayerByName(required numeric playername, required numeric tournamentid){
		return entityload("player", {gamername = arguments.playername, tournament= entityLoadByPK('tournament', arguments.tournamentid)});
	}

	public any function getPlayerByTeam(required numeric tournamentid, required numeric teamID){

		return ormExecuteQuery('from player where team = #arguments.teamID# and tournament = #arguments.tournamentid# ');
	}

	public any function countplayerswithoutteam(required numeric tournamentid){

		var data =  queryexecute('select count(1) as playercount from player where tournamentid = ? and teamid is null', [arguments.tournamentid]);
		return data.playercount;
	}
	public any function isPlayerinTournament(playerid, tournamentid){

		var data =  queryexecute('select 1 from player where id = :playerid and tournamentid = :tourney', {playerid: arguments.playerid, tourney : arguments.tournamentid});
	
		return data.recordcount;

	}


	public any function checkForPlayerByName(required string playername, required string Originname, required numeric tournamentid){
		var orig = '';
		if (arguments.Originname.len()) {
			orig = 'or Originname = :oname';
		}
		return queryexecute('select 1 from player where gamername = :player #orig# and tournamentid = :tid', {player: arguments.playername, oname: arguments.Originname, tid: arguments.tournamentid});
	}

	public any function deleteplayer(required numeric playerid){
		entitydelete(entityLoadByPK('player', arguments.playerid));
		ormflush();
		return true;
	}

	

	public any function savePlayerEdit(required struct data){

		var thisPlayer  = entityLoadByPK('player', arguments.data.playerid);
		thisPlayer.setgamername( arguments.data.playername );
		thisPlayer.setdiscord( arguments.data.discord );
		thisPlayer.setTwitter( arguments.data.Twitter ); 
		thisPlayer.settwitch( arguments.data.twitch ); 
		thisPlayer.setPlatform( arguments.data.Platform );
		thisPlayer.setPlayerRank( arguments.data.PLAYERRANK );
		thisPlayer.setLevel( arguments.data.Level );
		thisPlayer.setKills( arguments.data.Kills );
		thisPlayer.setOriginname( arguments.data.Originname );
		thisPlayer.setStreaming( arguments.data.Streaming ); 
		thisPlayer.setAlternate( arguments.data.alternate ); 

		entitysave(thisPlayer);
		ormflush();
		
		return thisPlayer;
		

	}

	public any function saveNewPlayer(required any data, required prevalidate = false) {


		if (arguments.data.keyexists('tournament') && isObject(arguments.data.tournament)) {
			thisTournament = arguments.data.tournament;
		} else {
			thisTournament = gettournamentService().getTournamentByKey(arguments.data.tournamentid);
		}

		if (! prevalidate) {
			checkplayer = checkForPlayerByName(arguments.data.playername, arguments.data.Originname, thisTournament.getid());
			if (checkplayer.recordcount){
				return {'error': 'failure', 'detail': 'Player / Origin name already exists in tournament'};
			}
		}


		thisdata = {
			'tournament' : thisTournament,
			'gamername' : arguments.data.playername,
			'discord' : arguments.data.discord,
			'Twitter' : arguments.data.Twitter ,
			'twitch' : arguments.data.twitch ,
			'Platform' : arguments.data.Platform,
			'Playerrank' : arguments.data.playerrank,
			'Level' : arguments.data.Level,
			'Kills' : arguments.data.Kills,
			'Originname' : arguments.data.Originname,
			'Streaming' : arguments.data.Streaming,
			'alternate' : arguments.data?.alternate ?: 0,
			'approved' : arguments.data?.approved ?: 1,
			'email' : arguments.data?.playeremail ?: ''
		};
		
				
		var player = entitynew("player", thisdata);
		entitysave(player);
		ormflush();
		if (arguments.data.tracker){
			try {
				getTrackerData(player);
			} catch(any e){ }
		}
	
		return player;
	}

	public any function getTrackerData(required any player) {

		if (! isObject(arguments.player)){
			var thisPlayer  = entityLoadByPK('player', arguments.player);
			if (isNull(thisPlayer)) {
				return false;
			}
		} else {
			var thisPlayer = arguments.player;			
		}

		// need a platform and if pc make sure we have an origin name
		if (thisPlayer.getPlatform() eq '') {
			return;
		} else if (thisPlayer.getPlatform() eq 'pc' && !thisplayer.getoriginname().len()) {
			return;
		}  
		var playerName = thisplayer.getplatform() eq 'PC' ? thisplayer.getoriginname() : thisplayer.getgamername();

		try {
			var profile = getapexaipService().getPlayerProfile(playerName, thisplayer.getTrackerPlatform().lcase());
			var stats = getapexaipService().getTrackedDataFromAPIResult(profile);

			thisplayer.setPlayerRank(REReplaceNoCase(stats.rank,'([^0-9]+).*','\1','ALL'));
			thisplayer.setlevel(stats.level);
			thisplayer.setkills(stats.kills);
			thisplayer.settracker(1);

			entitysave(thisPlayer);
			ormflush();

		} catch(any e){ }

		return true;

	}

	
	public any function setPlayerApprovalState(required any playerid, required any tournamentid, required any approvalValue, required boolean sendNotification = false) {

		queryexecute('update player set approved = :apr where id = :id and tournamentid = :tid', {id: arguments.playerid, tid: arguments.tournamentid, apr: arguments.approvalValue});		
		

		if (arguments.sendNotification) {
			if (arguments.approvalValue == 1) {
				getNotificationService().sendPlayerApproved(arguments.playerid, arguments.tournamentid);
			} else if (arguments.approvalValue == -1) {
				getNotificationService().sendPlayerRejected(arguments.playerid, arguments.tournamentid);				
			} else if (arguments.approvalValue == 0) {
				getNotificationService().sendPlayerPending(arguments.playerid, arguments.tournamentid);				
			}
		}

		return 1;

	}


}
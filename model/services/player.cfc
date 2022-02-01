component accessors="true" hint="for player items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	property userService;
	property apexaipService;
	property tournamentService;
	
	public any function getPlayerByKey(required numeric playerid){
		return entityLoadByPK('player', arguments.playerid);
	}

	public any function getPlayerByName(required numeric playername, required numeric tournamentid){
		return entityload("player", {gamername = arguments.playername, tournament= entityLoadByPK('tournament', arguments.tournamentid)});
	}

	public any function getPlayerByTeam(required numeric tournamentid, required numeric teamID){

		return ormExecuteQuery('from player where team = #arguments.teamID# and tournament = #arguments.tournamentid# ');
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
		thisPlayer.setrank( arguments.data.rank );
		thisPlayer.setLevel( arguments.data.Level );
		thisPlayer.setKills( arguments.data.Kills );
		thisPlayer.setOriginname( arguments.data.Originname );
		thisPlayer.setStreaming( arguments.data.Streaming ); 


		entitysave(thisPlayer);
		ormflush();
		
		return thisPlayer;
		

	}

	public any function saveNewPlayer(required any data) {
		

		checkplayer = checkForPlayerByName(arguments.data.playername, arguments.data.Originname, arguments.data.tournamentid);
		if (checkplayer.recordcount){
			return {'error': 'failure', 'detail': 'Player / Origin name already exists in tournament'};
		}

		thisdata = {
			tournament : gettournamentService().getTournamentByKey(arguments.data.tournamentid),
			gamername : arguments.data.playername,
			discord : arguments.data.discord,
			Twitter : arguments.data.Twitter ,
			twitch : arguments.data.twitch ,
			Platform : arguments.data.Platform,
			rank : arguments.data.rank,
			Level : arguments.data.Level,
			Kills : arguments.data.Kills,
			Originname : arguments.data.Originname,
			Streaming : arguments.data.Streaming 
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

			thisplayer.setrank(stats.rank);
			thisplayer.setlevel(stats.level);
			thisplayer.setkills(stats.kills);

			entitysave(thisPlayer);
			ormflush();

		} catch(any e){ }

		return true;

	}


}
component accessors="true" hint="for tournament items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	property userService;
	property utilsService;
	property externalService;
	property teamsService;
	property playerService;
	property emailService;
	property customfields;

	public any function getTournamentsForOwner(){
		return entityload("tournament", {owner=getSessionService().getloginuser()});
	}
	public any function getNextTournamentsForOwner(){

		return ormExecuteQuery('from tournament where  eventdate >= :ed and owner = :o', {ed:#now()#, o:getSessionService().getloginuser()}, true, {maxResults = 1});
	}

	public any function getPlayerListForTournament(required numeric tournamentid){

		return entityload("player", {tournament= entityLoadByPK('tournament', arguments.tournamentid)});

	}

	public any function getTournamentByKey(required numeric tournamentid){

		return entityLoadByPK('tournament', arguments.tournamentid);

	}


	public any function getTournamentByAccessKey(required string accesskey){
		
		return ormExecuteQuery('from tournament where registrationkey = :rk or adminkey = :rk or viewkey = :rk', {rk: arguments.accesskey}, true);

	}
	
	

	public any function getTournamentTypes(){
		return entityLoad('tournamenttype');
	}


	public any function getTournamentPlayersNoTeam (required numeric tournamentid){

		return ormExecuteQuery('from player where tournament = #arguments.tournamentid# and approved = 1 and team is null');

	}





	public any function saveNewTournament(required struct data) {
        var tdata = arguments.data;
		var owner = getSessionService().getloginuser();

		
		var regkey = getSecurityService().generateKey();
		var adminkey = getSecurityService().generateKey();
		var viewkey = getSecurityService().generateKey();

		var customFields = getUtilsService().getCustomFromData(tdata);
				

		var tourneyStruct = {
			'tournamentname': tdata.tourneyname,
			'contactemail' : tdata.contactemail,
			'eventdate': tdata.eventdate,
			'registrationstart': data.regstart  ?: '',
			'registrationend': data?.regend ?: '',
			'registrationcutoff': data.cutoff  ?: '',
			'registrationkey': regkey,
			'adminkey': adminkey,
			'viewkey': viewkey,
			'allowlate': data?.latereg ?: 0,
			'individual': data?.individual ?: 0,
			'emailrequired': data?.emailrequired ?: 0,
			'lockonfull': data?.lockonfull ?: 0,
			'registrationenabled': data?.regenabled ?: 0,
			'teamsize': data?.teamsize ?: 0,			
			'details': tdata.tourneydetail,
			'rules': tdata.tourneyrules,
			'registrationtype': data.regtype,
			'timezone': data.timezone,
			'owner' : owner,
			'type' : entityLoadByPK('tournamenttype', data.tourneytype )
		};
        

		getUtilsService().buildShortLink(tourneyStruct.viewkey);
		getUtilsService().buildShortLink(tourneyStruct.adminkey);


		var thisTourney = entityNew("tournament", tourneyStruct);
		entitysave(thisTourney);
		ormflush();

		// save custom fields
		if (arrayLen(customFields)) {
			getcustomfields().saveCustomFields(customFields ,thisTourney);
			ormflush();
		}
	


	}


	public any function regenerateKeys(required any tournament) {


		queryExecute("delete from shortlink where linkkey = '#arguments.tournament.getviewkey()#' ");
		queryExecute("delete from shortlink where linkkey = '#arguments.tournament.getadminkey()#' ");
		queryExecute("delete from shortlink where linkkey = '#arguments.tournament.getregistrationkey()#' ");


		var regkey = getSecurityService().generateKey();
		var adminkey = getSecurityService().generateKey();
		var viewkey = getSecurityService().generateKey();

		arguments.tournament.setviewkey(viewkey);
		arguments.tournament.setadminkey(adminkey);
		arguments.tournament.setregistrationkey(regkey);


		getUtilsService().buildShortLink(viewkey);
		getUtilsService().buildShortLink(adminkey);
		getUtilsService().buildShortLink(regkey);

		entitysave(arguments.tournament);
		ormflush();

	}



	public any function editTournament(required struct data) {
        
		tdata = arguments.data;
		var thisTourney = getTournamentByKey(tdata.tournamentid);

		if (tdata.tourneyname.len() gte 5){
			thisTourney.settournamentname( tdata.tourneyname );
		}

		thisTourney.seteventdate(tdata.eventdate );

		if (tdata.keyExists('regstart')) {
			thisTourney.setregistrationstart( tdata.regstart );			
		}
		if (tdata.keyExists('regend')) {
			thisTourney.setregistrationend( tdata.regend );			
		}
		if (tdata.keyExists('cutoff')) {
			thisTourney.setregistrationcutoff( tdata.cutoff );			
		}

		thisTourney.setallowlate(  tdata?.latereg ?: 0 );			
		thisTourney.setlockonfull(  tdata?.lockonfull ?: 0 );			
		thisTourney.setregistrationenabled(  tdata?.regenabled ?: 0 );			
		thisTourney.setemailrequired(  tdata?.emailrequired ?: 0 );		
		thisTourney.setindividual(  tdata?.individual ?: 0 );			

		thisTourney.setcontactemail( tdata.contactemail );
		thisTourney.settimezone( tdata.timezone );

	
		thisTourney.setdetails( tdata.tourneydetail );
		thisTourney.setrules( tdata.tourneyrules );

		if (tdata.keyExists('teamsize')) {
			thisTourney.setteamsize( tdata.teamsize );
		}

		thisTourney.settype( entityLoadByPK('tournamenttype', tdata.tourneytype ));
    
		
		entitysave(thisTourney);
		ormflush();

		var customFields = getUtilsService().getCustomFromData(tdata);


		// save custom fields
		if (arrayLen(customFields)) {
			getcustomfields().updateCustomFields(customFields,thisTourney);
			ormflush();
		}
	
		if ( tdata.keyExists('linkreset') ) {
			regenerateKeys(thisTourney);
		}	


		ormflush();
		return;

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


	public any function isRegOpenToday(required any data) {

		
		var thisTourney = arguments.data;
	
		var daysToClose  = datediff('d', now(), thisTourney?.getregistrationend() ?: thisTourney?.geteventdate());
		var daysSinceOpen  =  datediff('d', thisTourney?.getregistrationstart() ?: dateadd('d', 1, now()), now() );
		var daysToCutoff  =  datediff('d', now(), thisTourney?.getregistrationcutoff() ?: dateadd('d', 1, now()) );

		if (daysSinceOpen lt 0) { // not opened yet
			return 0;
		}	

		// before close date 
		if (daysToClose gte 0){
			return 1;
		} else if (thisTourney.getallowlate() && daysToCutoff gte 0) { // after close date but before cutoff and late enabled
			return 2
		}
		
		// failsafe  shoudn't get here
		return 0;


	}


	public any function isRegOpenPlayerCount(required any data) {

		thisTourney = arguments.data;
		// reg rules
		// individual
		// 	! 60 players
		// 	or lock on full - off

		// team
		// 	teams in tourney < 60/teamsize 
		// 	or lock on full - off 

		// 2 = full not locked, will be alternate
		// 1 = good to reg
		// 0 = reg locked

		if (thisTourney.getindividual()) {

			if (thisTourney.getplayer().len() gte 60 && ! thisTourney.getlockonfull() ) {
				return 2; 
			} else if (thisTourney.getplayer().len() gte 60 && thisTourney.getlockonfull() ) {
				return 0;
			} else if (thisTourney.getplayer().len() lt 60 ) {
				return 1;
			}

		} else if (!thisTourney.getindividual()) {

			if ((thisTourney.getTeam().len() gte 60 / thisTourney.getteamsize()) && ! thisTourney.getlockonfull()) {
				return 2;
			} else if ((thisTourney.getTeam().len() gte 60 / thisTourney.getteamsize()) && thisTourney.getlockonfull()) { 
				return 0;
			} else if (thisTourney.getTeam().len() lt 60 / thisTourney.getteamsize()) {
				return 1;
			}
		}	

		// failsafe  shoudn't get here
		return 0;

	}


	public any function registerplayers(required any data)  {

		var teamemail = arguments.data.playeremail;
		var thisTourney = arguments.data.tournament;			
		var nosaveteam = {};
		var player = [];
		var alternateReg = data?.alternate ?: 0;
		var thisTeam = 0;


		// extract players from rc and validate
		for (var i = 1; i <= thistourney.getteamsize(); i++ ){
			
			pdata = getutilsService().getPlayerFromFormFields(arguments.data, i);

			if (!pdata.playername.len()) {
				continue; // no name for player.. skip.
			}
			player[i] = pdata;
			player[i].alternate = alternateReg;
			player[i].tournament = thisTourney;
			player[i].approved = 0;
			if (getPlayerservice().checkForPlayerByName(player[i].playername, player[i].originname, thisTourney.getid()).recordcount){
				player[i].playerexists = true;
				nosaveteam = {'error': 'failure', 'detail': 'Player / Origin name already exists in tournament'};
				player[i].saveerror = nosaveteam;
			} else {
				if (player[i].originname.len()){
					player[i].tracker = true;
				}
			}
						
		}
		// error checks passed. Save team and player.
		if (nosaveteam.isempty()) {
			if (arguments.data.keyExists('teamname') && arguments.data.teamname.len()) {
				// profanity filter for team name.
				// if name has profanty it is replaced with a random team name
				var teamName = getexternalService().badwordcheck(arguments.data.teamname) ? 'Unknown Team #randrange(111,999)#' : arguments.data.teamname;
				var thisTeam = getTeamsService().createTeam(teamName, thisTourney.getid(), true, 0, alternateReg);
				//if team name already exists just create random name and continue.
				if (!thisTeam) {
					teamName = 'Random Name #randrange(111,999)#';
					thisTeam = getTeamsService().createTeam(teamName, thisTourney.getid(), true, 0, alternateReg);
				}
		
			} 


			for (var z = 1; z <= player.len(); z++ ){
				if (z == 1) {
					player[z].playeremail = teamemail; // registration email is saved against the first player
				}
				player[z].savedplayer = getplayerService().saveNewPlayer(player[z], true);

				if (thisTeam) {
					// add players to team
					getTeamsService().updateTeamPlayer(player[z].savedplayer.getid(),thisTeam, 1, thisTourney.getid(), true )
				}

			}
			// if an email was entered send reg email
			if (player[1].playeremail.len() ){
				getEmailService().sendRegistrationPending(player[1].savedplayer, thisTourney);
			}

		}
		// debug only to remove tourney object from array
		for (var j = 1; j lte player.len(); j++ ){
			player[j].tournament = '';

		}

		return player;

	}


}
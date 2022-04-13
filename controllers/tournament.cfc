component accessors="true" extends="base" {

	property uiHelperService;
	property userService;
	property sessionService;
	property securityService;
	property tournamentService;
	property apexaipService;
	property teamsService;
	property playerService;
	property matchmakerService;
	property emailService;
	

	public void function view( rc ){

		var foundkey = findkeyInURL( rc );


		if (!foundkey.len()){ 
			variables.fw.redirect('main');
		}

		rc.viewtype = rc['#foundkey[1]#'].len() ? rc['#foundkey[1]#'] : 'detail';
		rc.foundkey = foundkey[1];
		rc.tournament = getTournamentService().getTournamentByAccessKey(foundkey[1]);



		if (rc.tournament.getadminkey() eq foundkey[1]) {
			getsessionservice().setpublicAcessType(3);
		} else if (rc.tournament.getregistrationkey() eq foundkey[1]) {
			getsessionservice().setpublicAcessType(2);
		} else if (rc.tournament.getviewkey() eq foundkey[1]) {
			getsessionservice().setpublicAcessType(1);
		}
		getsessionservice().setAnonTournamentID(rc.tournament.getid());

		if (rc.viewtype == 'detail') {
			variables.fw.setview('tournament.detail');		
		} else if (rc.viewtype  == 'teams') {
			variables.fw.setview('tournament.teamview');		
		}


	}


	public void function register( rc ) {



		var foundkey = findkeyInURL( rc );

		if (!foundkey.len()){ 
			variables.fw.redirect('main');
		}

		rc.foundkey = foundkey[1];
		rc.tournament = getTournamentService().getTournamentByAccessKey(foundkey[1]);

		if (rc.keyexists('processregistration')) {

			rc.playerreg = getTournamentService().registerplayers(rc);
			rc.saveerror = '';
			playersaveerror = ArrayFind(rc.playerreg, function(struct){ 
				if (struct.keyexists('saveerror')) {
					rc.saveerror = struct['saveerror'];
				}
				return struct.keyexists('saveerror');
			 });

			if (playersaveError) {				
				variables.fw.setview('tournament.registeredit');	
			} else {
				variables.fw.redirect('tournament.registerdone/#rc.foundkey#');
			}

		}

		rc.canregisterpc = getTournamentService().isRegOpenPlayerCount(rc.tournament);
		rc.canregisterdate = getTournamentService().isRegOpenToday(rc.tournament);

		getsessionservice().setAnonTournamentID(rc.tournament.getid());


	}


	public void function registerdone( rc ) {

		var foundkey = findkeyInURL( rc );

		if (!foundkey.len()){ 
			variables.fw.redirect('main');
		}

		rc.foundkey = foundkey[1];
		rc.tournament = getTournamentService().getTournamentByAccessKey(foundkey[1]);

		rc.canregisterpc = getTournamentService().isRegOpenPlayerCount(rc.tournament);
		rc.canregisterdate = getTournamentService().isRegOpenToday(rc.tournament);

		getsessionservice().setAnonTournamentID(rc.tournament.getid());


	}


	public void function create( rc ) {

		if (structkeyExists(rc, 'step') ){

			rc.tournamenttypes = getTournamentService().getTournamentTypes();	
			
			switch(rc.step)
			{
				case "start":
					getsessionservice().settourneycreationtype(rc.type);
					variables.fw.setview('tournament.start');
					break;
				case "tourney":
					variables.fw.setview('tournament.tourneycreate');			
					break;
			}


		}



	}

	public void function userregister( rc ) {


		var newuser = getuserservice().saveUserRegistration(rc);

		if (! isNull(newuser)) {
			getsessionService().createSession(newuser);
			rc.owner = newuser.getid();
			getEmailService().sendVerification(newuser);
			variables.fw.redirect('tournament.create?step=tourney&type=#getsessionservice().gettourneycreationtype()#')
		} else {
			variables.fw.redirect('main.login?exists');
		}

	}
	
	public void function createtourney( rc ) {

		getTournamentService().saveNewTournament(rc);
	
		variables.fw.redirect('tournament.mytournaments');


	}


	
	public void function mytournaments( rc ) {

		rc.tourneylist = getTournamentService().getTournamentsForOwner();
		rc.nextTournament = getTournamentService().getNextTournamentsForOwner();
		variables.fw.setview('tournament.dashboard');

	}
	
	public void function edit( rc ) {

		// can user manage this tournament?
		if (! getSecurityService().canUserManageTournament(rc.tournament)){
			variables.fw.redirect('main');
		}
		// var path = CF_TEMPLATE_PATH.replace('/index.cfm', "");
		// rc.timezones = getfileReaderUtil().loadJSONFile(path, 'timezones').deserializeJSON();
		rc.tournamenttypes = getTournamentService().getTournamentTypes();	
		rc.tournament = getTournamentService().getTournamentByKey(rc.tournament);
	}
	

	public void function saveedit( rc ) {

		// can user manage this tournament?
		if (! getSecurityService().canUserManageTournament(rc.tournamentid)){
			variables.fw.redirect('main');
		}


		rc.editSave  = getTournamentService().editTournament(rc);

		getSessionservice().setTourneySaved(true);
		
		variables.fw.redirect('tournament.detail?tournament=#rc.tournamentid#');
	}




	public void function detail( rc ) {

		// can user manage this tournament?
		if (! getSecurityService().canUserManageTournament(rc.tournament)){
			variables.fw.redirect('main');
		}
		
		if (getSessionService().hasTourneySaved()) {
			getSessionService().deleteVar('TourneySaved');
			rc.showeditsave = true;
		}

		rc.tournament = getTournamentService().getTournamentByKey(rc.tournament);


	}

	public void function manageplayers( rc ) {

		// can user manage this tournament?
		if (! getSecurityService().canUserManageTournament(rc.tournament)){
			variables.fw.redirect('main');
		}

		rc.tournament = getTournamentService().getTournamentByKey(rc.tournament);

	}



	public void function manageapprovals( rc ) {

		rc.viewtype = rc?.viewtype ?: 0;
		// can user manage this tournament?
		if (! getSecurityService().canUserManageTournament(rc.tournament)){
			variables.fw.redirect('main');
		}

		rc.tournament = getTournamentService().getTournamentByKey(rc.tournament);
				
		if (rc.tournament.getteamsize() eq 1) {
			
			rc.section = 'player';

		} else {
			rc.teamcounts = getteamsservice().getTeamPlayerCountsForTournamentAlt(rc.tournament.getid(), rc.viewtype, 1);
			rc.teamcountunapproved = getteamsservice().getUnApprovedTeamsForTournament(rc.tournament.getid());
			rc.teamcountapproved = getteamsservice().getApprovedTeamsForTournament(rc.tournament.getid());

			rc.teamcountsEmpty = getteamsservice().getEmptyTeamsForTourney(rc.teamcounts);
			rc.missingteams = 60/rc.tournament.getteamsize() - rc.teamcounts.recordcount;
		}

		rc.section = rc?.section ?: 'team';

		getSessionService().settournamentmanageid(rc.tournament.getid());



	}

	
	public void function teambuilder( rc ) {

		// can user manage this tournament?
		if (! getSecurityService().canUserManageTournament(rc.tournament)){
			variables.fw.redirect('main');
		}

		getSessionService().settournamentmanageid(rc.tournament);
		rc.tournament = getTournamentService().getTournamentByKey(rc.tournament);
		rc.noTeamPlayers = getTournamentService().getTournamentPlayersNoTeam(rc.tournament.getid());
		rc.teamcounts = getteamsservice().getTeamPlayerCountsForTournament(rc.tournament.getid());
		rc.teamcountapproved = getteamsservice().getApprovedTeamsForTournament(rc.tournament.getid());

		rc.missingteams = 60/rc.tournament.getteamsize() - rc.teamcountapproved;

		rc.maxteams = 60/rc.tournament.getteamsize();
		rc.teamprogress = (rc.tournament.filledTeamsForTournament() / (60/rc.tournament.getteamsize())) * 100;


	}
	public void function teamsoverview( rc ) {

		// can user manage this tournament?
		if (! getSecurityService().canUserManageTournament(rc.tournament)){
			variables.fw.redirect('main');
		}

		rc.tournament = getTournamentService().getTournamentByKey(rc.tournament);

		if (cgi.http_referer contains "teamsoverview") {
			if (! rc.keyExists('approvedonly') && ! rc.keyExists('showalternate')){
				rc.approvedonly = 0;
				rc.showalternate = 0;
			}
		} else {

			rc.approvedonly = 1;
			rc.showalternate = 1;

		}


		rc.showalternate = rc?.showalternate ?: 0;

		if (rc.showalternate && ! rc.keyExists('approvedonly')) {
			rc.approvedonly = 0;			
		} else {
			rc.approvedonly = rc?.approvedonly ?: 1
		}
		


		rc.teamcounts = getteamsservice().getTeamPlayerCountsForTournament(rc.tournament.getid(), rc.approvedonly, rc.showalternate);
		rc.teamcountapproved = getteamsservice().getApprovedTeamsForTournament(rc.tournament.getid());
		rc.teamcountsEmpty = getteamsservice().getEmptyTeamsForTourney(rc.teamcounts);
		getSessionService().settournamentmanageid(rc.tournament.getid());
		rc.missingteams = 60/rc.tournament.getteamsize() - rc.teamcounts.recordcount;


		rc.players = getPlayerService().getPlayerByTeam(5,4);




	}




}
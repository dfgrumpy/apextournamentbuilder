component accessors="true" {

	property uiHelperService;
	property userService;
	property sessionService;
	property securityService;
	property tournamentService;
	property apexaipService;
	property teamsService;
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}
	
	public any function before( fw ) {
		rc.uihelper = getuiHelperService();
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
			variables.fw.redirect('tournament.create?step=tourney&type=#getsessionservice().gettourneycreationtype()#')
		} else {
			// need to handle user already exists here.
		}

	}
	
	public void function createtourney( rc ) {

		getTournamentService().saveNewTournament(rc);

		
		variables.fw.redirect('tournament.mytournaments');


	}


	
	public void function mytournaments( rc ) {

		rc.tourneylist = getTournamentService().getTournamentsForOwner();
		variables.fw.setview('tournament.list');

	}
	
	public void function edit( rc ) {

		// can user manage this tournament?
		if (! getSecurityService().canUserManageTournament(rc.tournament)){
			variables.fw.redirect('main');
		}

		rc.tournament = getTournamentService().getTournamentByKey(rc.tournament);


	}
	
	public void function detail( rc ) {

		// can user manage this tournament?
		if (! getSecurityService().canUserManageTournament(rc.tournament)){
			variables.fw.redirect('main');
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

	public void function manageteams( rc ) {

		// can user manage this tournament?
		if (! getSecurityService().canUserManageTournament(rc.tournament)){
			variables.fw.redirect('main');
		}

		rc.tournament = getTournamentService().getTournamentByKey(rc.tournament);

		rc.teamcounts = getteamsservice().getTeamPlayerCountsForTournament(rc.tournament.getid());

	}




}
component accessors="true" hint="for notification items" extends="model.base.baseget" {

   	property securityService;
	property settingsService;
	property sessionService;
	property userService;
	property tournamentService;
	property playerService;
	property emailService;
	


	public any function sendTeamPending(required numeric teamid, required any tournament){

		var player = ormExecuteQuery("from player where team = #arguments.teamID# and tournament = #arguments.tournament.getid()# and email !='' ", true);
		
		if (! isNull(player)) {
			getemailService().sendRegistrationPending(player, arguments.tournament);
		}

	}


	public any function sendTeamRejected(required numeric teamid, required any tournament){

		var player = ormExecuteQuery("from player where team = #arguments.teamID# and tournament = #arguments.tournament.getid()# and email !='' ", true);
		if (! isNull(player)) {
			getemailService().sendRegistrationRejected(player, arguments.tournament);
		}

	}

	public any function sendTeamApproved(required numeric teamid, required any tournament){
		
		var player = ormExecuteQuery("from player where team = #arguments.teamID# and tournament = #arguments.tournament.getid()# and email !='' ", true);
		if (! isNull(player)) {
			getemailService().sendRegistrationApproved(player, arguments.tournament);
		}


	}


	public any function sendPlayerPending(required numeric playerid, required any tournamentid){

		var player = ormExecuteQuery("from player where id = #arguments.playerid# and email !='' ", true);
		
		if (! isNull(player)) {
			var thisTourney = gettournamentService().getTournamentByKey(arguments.tournamentid);
			getemailService().sendRegistrationPending(player, thisTourney);
		}

	}


	public any function sendPlayerRejected(required numeric playerid, required any tournamentid){

		var player = ormExecuteQuery("from player where id = #arguments.playerid# and email !='' ", true);
		if (! isNull(player)) {
			var thisTourney = gettournamentService().getTournamentByKey(arguments.tournamentid);
			getemailService().sendRegistrationRejected(player, thisTourney);
		}

	}

	public any function sendPlayerApproved(required numeric playerid, required any tournamentid){
		
		var player = ormExecuteQuery("from player where id = #arguments.playerid# and email !='' ", true);
		if (! isNull(player)) {
			var thisTourney = gettournamentService().getTournamentByKey(arguments.tournamentid);
			getemailService().sendRegistrationApproved(player, thisTourney);
		}


	}

}
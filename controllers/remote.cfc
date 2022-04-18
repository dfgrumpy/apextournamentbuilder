component accessors="true" extends="base"       {

	property utilsService;
	property configService;
	property uihelperService;
	property tournamentService;
	property errorHandlerService;
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}

	public any function before( rc ) {
		super.before(rc);
		rc.returnType = 'text';

	}


	public void function mytournament(rc){


		rc.returnType = 'text';
		var linkdata = getUtilsService().verifyShortLink(rc.t);

		if (isNull(linkdata)) {
			rc.returndata = 'ERROR: Unknown Tournament';
			return;
		}
		
		var tournament = getTournamentService().getTournamentByAccessKey(linkdata.getLinkKey());

		if (isNull(tournament)) {
			rc.returndata = 'ERROR: Unknown Tournament';
			return;
		}

		var tourneyString = getuihelperservice().buildInfoString(tournament);
				
		rc.RETURNDATA = tourneyString;


	}
}

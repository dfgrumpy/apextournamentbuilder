component accessors="true" {

    property beanFactory;
    property formatterService;
	property securityService;
	property sessionService;
	property userService;
	property tournamentService;
	property teamService;
	property playerService;
	property uiHelperService;
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}
	
	public any function before( fw ) {
		rc.uihelper = getuiHelperService();
	}


	public void function members( rc ) {

		// show no layout for this.
		variables.fw.disableLayout();

		rc.tournament = getTournamentService().getTournamentByKey(getsessionservice().gettournamentmanageid());
		rc.players = getPlayerService().getPlayerByTeam(getsessionservice().gettournamentmanageid(), rc.teamid);
		
	}



}

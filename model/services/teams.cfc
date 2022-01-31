component accessors="true" hint="for tournament items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	property userService;
	property tournamentService;
	


	public any function getTeamPlayerCountsForTournament(required numeric tournamentid){


		var data =  queryexecute('select t.id, t.name, count(p.id) AS playercount
									from team t
									left join player p on t.id = p.teamid
									where t.tournamentid = ?
									group by t.id, t.name', [arguments.tournamentid]);


		
		return data;


	}


}
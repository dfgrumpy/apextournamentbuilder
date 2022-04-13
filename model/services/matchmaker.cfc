component accessors="true" hint="for team/player items" extends="model.base.baseget"      {

    property securityService;
    property configService;
    property settingsService;
    property sessionService;
    property userService;
    property tournamentService;
    property playerService;
    property teamsService;
    



	public void function teammatchmaking( data, tournamentid ) {

        data = {
            'filltype': arguments.data.filltype,
            'console': arguments.data.console,
            'reset': arguments.data.reset,
            'tournamentid': arguments.data.tournamentid
        }		

		rc.tournament = getTournamentService().getTournamentByKey(arguments.tournamentid);

        if (data.reset) {
            // remove players from teams first
            getTeamsService().clearAllTeamsForTournament(arguments.tournamentid);
        }

		if (data.filltype == 1)  {
			// fill teams using full randomization
			result = fillteamsFullRandom(rc.tournament);
		} if (data.filltype == 2) {
			// fill teams using random by rank
			result = fillteamsFullRank(rc.tournament);
		} if (data.filltype == 3) {
			// fill teams using random by rank groups
			result = fillteamsFullRankGroup(rc.tournament);
		}

        return 1;
	}


    public any function fillteamsFullRandom(required any tournament) {

        playerlist= getRandomAvailablePlayersAll(arguments.tournament.getid());

        for (player in playerlist) {            
            team = getRandomAvailableTeam(arguments.tournament.getid());            
            getteamsService().updateTeamPlayer(player.id, team.id, 1, arguments.tournament.getid());
        }
        
        return 1;

    }


    public any function fillteamsFullRank(required any tournament) {

        // fill using pred - bronze
        // get list of players needing teams by rank
        // find team without that rank, if not any random

        var ranks = getConfigService().getapexranks().listtoarray().reverse();
        var thisTourney = arguments.tournament;

        ranks.each(function(item, idx){
            
            playerlist = getRandomAvailablePlayersRank(thisTourney.getid(), item); // get players in rank without team
            

            for (player in playerlist) {   
                randteam = getRandomAvailableTeamForRank(thisTourney.getid(), item);   // find team for player
                getteamsService().updateTeamPlayer(player.id, randteam, 1, thisTourney.getid()); // updateplayer
            }

        });

        // unranked players are used to fill teams up after all ranked players are distributed
        playerlist = getRandomAvailablePlayersUnranked(thisTourney.getid()); // get players in rank without team
        for (player in playerlist) {   
            randteam = getRandomAvailableTeam(thisTourney.getid());   // find team for player  
            getteamsService().updateTeamPlayer(player.id, randteam.id, 1, thisTourney.getid()); // updateplayer
        }

        return 1;
    }
    public any function fillteamsFullRankGroup(required any tournament) {

        // fill using rank groups
        // get list of players needing teams by rank
        // find team without that rank, if not any random

        var ranks = getConfigService().getapexrankgroups();
        var thisTourney = arguments.tournament;

        ranks.each(function(item, idx){
            group = ListQualify(ranks[item], "'", ",", "ALL");
            playerlist = getRandomAvailablePlayersRankGroup(thisTourney.getid(), group); // get players in rank without team
            
            for (player in playerlist) {   
                randteam = getRandomAvailableTeamForRank(thisTourney.getid(), item);   // find team for player
                getteamsService().updateTeamPlayer(player.id, randteam, 1, thisTourney.getid()); // updateplayer
            }

        });
        // unranked players are used to fill teams up after all ranked players are distributed
        playerlist = getRandomAvailablePlayersUnranked(thisTourney.getid()); // get players in rank without team
        
        for (player in playerlist) {   
            randteam = getRandomAvailableTeam(thisTourney.getid());   // find team for player  
            getteamsService().updateTeamPlayer(player.id, randteam.id, 1, thisTourney.getid()); // updateplayer
        }

        return 1;
    }



	public any function getRandomAvailablePlayer(required numeric tournamentid){
        var player =  queryexecute('select id from player where tournamentid = ? and approved = 1 and teamid is null and alternate = 0 order by rand()', [arguments.tournamentid], {maxrows: 1});
       
        return player;
	}

	public any function getRandomAvailablePlayersAll(required numeric tournamentid){
        var players =  queryexecute('select id from player where tournamentid = ? and approved = 1 and teamid is null and alternate = 0 order by rand()', [arguments.tournamentid]);
        
        return players;
	}

	public any function getRandomAvailablePlayersRank(required numeric tournamentid, required string rank){
        var players =  queryexecute('select id from player where tournamentid = ? and approved = 1 and teamid is null and PlayerRank = ? and alternate = 0 order by rand()', [arguments.tournamentid, arguments.rank]);
        
        return players;
	}	
    public any function getRandomAvailablePlayersRankGroup(required numeric tournamentid, required string rank){
        var players =  queryexecute('select id from player where tournamentid = ? and approved = 1 and teamid is null and PlayerRank in ( #preservesinglequotes(arguments.rank)# )  and alternate = 0 order by rand()', [arguments.tournamentid]);
        
        return players;
	}
	public any function getRandomAvailablePlayersUnRanked(required numeric tournamentid){
        var players =  queryexecute('select id from player where tournamentid = ? and approved = 1 and teamid is null and IfNull(PlayerRank, 0) = 0 and alternate = 0 order by rand();', [arguments.tournamentid]);
        
        return players;
	}
	public any function getRandomAvailablePlayersPlatform(required numeric tournamentid, required string platform){
        if (arguments.platform eq "1") {
            sqladdl =  "and platform = 'PC'";
        } else {
            sqladdl =  "and platform != 'PC'";
        }        
        var players =  queryexecute('select id , platform from player where tournamentid = ? and approved = 1 and teamid is null and alternate = 0 #sqladdl# order by rand()', [arguments.tournamentid]);
      
        return players;
	}


	public any function getRandomAvailableTeam(required numeric tournamentid){


		var data =  queryexecute('select t.id, count(p.id) AS playercount
									from team t
									left join player p on t.id = p.teamid
									where t.tournamentid = :A and t.approved = 1
									group by t.id
                                    having playercount <  (select teamsize from tournament where id = :A)
                                    order by rand()', {A:arguments.tournamentid}, {maxrows: 1});
	
       return data;
	}


	public any function getRandomAvailableTeamForRank(required numeric tournamentid, required string playerrank){

    	var data =  queryexecute('call sp_getTeamByRank(?, ?)', [arguments.tournamentid, arguments.playerrank]);
        
        if (data.randomteam == 0) { // if no team for player / rank just get any random team
            return getRandomAvailableTeam(arguments.tournamentid).id;
        } else {
            return data.randomteam;
        }       
	}



    



}
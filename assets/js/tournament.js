
/*
    Primary system wide JS file for tournament specific items
*/

// tournament function
tourneyNS = {


    init: function () {
       


    },

    processPlayerTeamUpdate: function (player, team, type) {        
        payload = {'playerid': player, 'teamid': team, 'type': type};
        siteAjax.savePlayerTeamUpdate(payload);
    },


};

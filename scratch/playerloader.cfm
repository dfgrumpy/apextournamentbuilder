


<cfscript>
    abort;
    playerCount = 20; // how many players are we loading?

    tournamentid = 10; // what tourney we loading into?


    ranks = 'Bronze,Silver,Gold,Platinum,Diamond,Master,Apex Predator';
    rankCount = ranks.listlen();

    platform = 'PC,XBL,PSN';
    platformCount = platform.listlen();


    forcerank = '';
    forceplatform = '';


    for (i = 1; i <= playerCount; i++) {

        thisRank = forcerank.len() ? forcerank : listGetAt(ranks, randrange(1, rankcount));
        thisPlatform = forceplatform.len() ? forceplatform : listGetAt(platform, randrange(1, platformCount));

        RandPlayerNum = randrange(1000, 9999);


        queryExecute("
            insert into player
            (`gamername`, `twitter`, `platform`, `playerrank`, `streaming`, `discord`,`tournamentid`) 
            values
            ('Test Player #RandPlayerNum#', 'testplayer_#RandPlayerNum#', '#thisplatform#', '#thisRank#', #randrange(0,1)#, 'testplayer###RandPlayerNum#', #tournamentid#)
        ");




    }




</cfscript>



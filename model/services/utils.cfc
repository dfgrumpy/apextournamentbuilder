component accessors="true" hint="for team items" extends="model.base.baseget"      {

   	property securityService;
	property settingsService;
	property sessionService;
	property userService;
	property tournamentService;
	property playerService;
	





	public any function getPlayerFromFormFields( required data, required number playernum = 1 ) {

		num = arguments.playernum;
		var player = {
			'playername' : arguments.data.keyExists('playername_#num#') ? arguments.data['playername_#num#'] : '',
			'platform' : arguments.data.keyExists('platform_#num#') ? arguments.data['platform_#num#'] :'',
			'Playerrank' : arguments.data.keyExists('rank_#num#') ? arguments.data['rank_#num#'] :'',
			'originname' : arguments.data.keyExists('originname_#num#') ? arguments.data['originname_#num#'] :'',
			'discord' : arguments.data.keyExists('discordname_#num#') ? arguments.data['discordname_#num#'] :'',
			'Twitter' : arguments.data.keyExists('twittername_#num#') ? arguments.data['twittername_#num#'] :'',
			'twitch' : arguments.data.keyExists('twitchname_#num#') ? arguments.data['twitchname_#num#'] :'',
			'streaming' : arguments.data.keyExists('streaming_#num#') ? arguments.data['streaming_#num#'] :'0',
			'Level' : '',
			'Kills' : '',
			'tracker' : false,
			'playerexists' : false,
			'playersaved' : false,
			'alternate' : arguments.data.keyExists('alternate') ? arguments.data.alternate : 0,
			'approved' : 0
		};


		return player;

	}


	public any function buildShortLink(required string sourcekey){

		for (var i = 1; i lte 1000; i++) {

			try {
				var shortlink = generateShortLink();

				var data = {'shortlink': shortlink, 'linkkey' : arguments.sourcekey};
				
				var thisShort = entityNew("shortlink", data);
				entitysave(thisShort);
				ormflush();
				break;
				
			} catch(any e){ }
		}

		return shortlink;

	}


	private any function generateShortLink(){

		var chars="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9";
  		//<!--- our radix is the total number of possible characters --->   
  		var radix=listlen(chars);
		var shortlink="";

		for (x = 1; x lte 8; x++){
			randnum=RandRange(1, radix);
         	shortlink= shortlink & listGetAt(chars,randnum);
		}

		return shortlink;

	}



	public any function verifyShortLink(required string shortlink){

		return  entityload("shortlink", {shortlink=arguments.shortlink}, true);

	}

}			
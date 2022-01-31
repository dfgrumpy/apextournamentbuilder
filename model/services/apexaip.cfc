component accessors="true" hint="for tournament items" extends="model.base.baseget"      {


    property configService;


	public any function getPlayerProfile( required any player, required string platform){
		

		var payload= {
				properties : {
					url: '#getConfigService().gettrackerapiurl()#/profile/#lcase(arguments.platform)#/#arguments.player#',
					method: 'get'
				}
			};

		var result = doApiCall(payload);
        return result;

	}




    public any function doApiCall( required data, retry = false ){
	
		var callData = arguments.data;
		
        cfhttp(method="#callData.properties.method#", charset="utf-8", url="#callData.properties.url#", result="result") {
           cfhttpparam(type="header", name="Content-Type", value="application/json");
           cfhttpparam(type="header", name="TRN-Api-Key", value="#getconfigservice().gettrackeraipkey()#");	
            if (structKeyExists(callData, 'body')) {
		    	body = replacenocase(serializeJson(callData.body), "||", "", "ALL");
    			cfhttpparam(type="body", value="#body#");
        	}
        }

		return result.filecontent;
		
	}


	public andy function getTrackedDataFromAPIResult(required any data) {

		var baseStats = deserializeJson(arguments.data).data.segments[1];
		
		stats = {
			'rank' : baseStats.stats.rankscore.metadata.rankName,
			'level' : baseStats.stats.level.value,
			'kills' : baseStats.stats.kills.value
		};

		return stats;

	}


}


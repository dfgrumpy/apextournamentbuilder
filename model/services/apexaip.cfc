component accessors="true" hint="for tournament items" extends="model.base.baseget"      {


    property configService;

	public any function buildBaseApiuri(){

		return "#getConfigService().getalapiurl()#?auth=#getConfigService().getalapikey()#&merge=true&removeMerged=true";
	}



	public any function getPlayerProfile( required any player, required string platform){
		

		var payload= {
				properties : {
					url: '#getConfigService().getalapiurl()#/profile/#lcase(arguments.platform)#/#arguments.player#',
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

	public any function getPlayerProfilev2( required any player, required string platform){
		

		var payload= {
				properties : {
					url: '#buildBaseApiuri()#&player=#arguments.player#&platform=#ucase(arguments.platform)#',
					method: 'get'
				}
			};

			var result = doApiCallv2(payload);
        return result;

	}
	


    public any function doApiCallv2( required data, retry = false ){
	
		var callData = arguments.data;
		
        cfhttp(method="#callData.properties.method#", charset="utf-8", url="#callData.properties.url#", result="result") {
           cfhttpparam(type="header", name="Content-Type", value="application/json");
            if (structKeyExists(callData, 'body')) {
		    	body = replacenocase(serializeJson(callData.body), "||", "", "ALL");
    			cfhttpparam(type="body", value="#body#");
        	}
        }

		return result.filecontent;
		
	}

	public any function getTrackedDataFromAPIResult(required any data) {

		var baseStats = deserializeJson(arguments.data).data.segments[1];
		
		stats = {
			'rank' : baseStats.stats.rankscore.metadata.rankName,
			'level' : baseStats.stats.level.value,
			'kills' : baseStats.stats.kills.value
		};

		return stats;

	}

	public any function getTrackedDataFromAPIResultv2(required any data) {

		var baseStats = deserializeJson(arguments.data);
		stats = {
			'rank' : baseStats.global.rank.rankName,
			'ranklevel' : baseStats.global.rank.rankDiv,
			'level' : baseStats.global.level,
			'kills' : baseStats.total.kills.value
		};

		return stats;

	}

}


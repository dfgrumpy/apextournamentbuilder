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

	/*  SanitizeFilename - Sanitize a string to be safe for use as a filename by removing directory paths and invalid characters.	
		SanitizeFilename(filename, rulesList, replacementCharacter);
		rulesList: convertspacestounderscores, convertspacestodashes, convertdashtounderscore, convertunderscoretodash
		rulesList: nodash, forcelowercase, forceuppercase
		replacementCharacter: default = ""
		NOTE: Lowercases extension
		Written by SunStar Media https://www.sunstarmedia.com/
		3/18/2015 Initial UDF
		4/25/2018 Updated w/optional ICU4J support (to convert foreign characters to Latin-ASCII)
			https://gist.github.com/JamoCA/ec4617b066fc4bb601f620bc93bacb57
			Tested to pass NaughtyStrings test https://github.com/minimaxir/big-list-of-naughty-strings
		3/11/2021 Modernized, added maxLength, default unsafeCharRegex and fixed some bugs on edge cases;
		returns empty string if filename is "unrepairably safe".
	*/
	public string function localSanitizeFileName(
		string s="",
		string rules="",
		string replacementCharacter="",
		numeric maxLength=255,
		string unsafeCharRegex="[^A-Za-z0-9\-_]"unsafeCharRegex="[^A-Za-z0-9\-_]"
	) output=false hint="Sanitize a string to be safe for use as a filename by removing directory paths and invalid characters." {
		local.windowsReservedRe = "^(con|prn|aux|nul|com[0-9]|lpt[0-9])(\.[^.]*)?$";
		local.response = trim(javacast("string", arguments.s));
		local.response = listLast(listLast(local.response, "/"), "\").replaceAll("(?ms)\<[^>]*\>", "");
		if (left(local.response,1) is "." and listlen(local.response,".") is 1){
			return "";
		}

		/* Transliterate ICU4J CFC (optional; converts foreign characters to latin equivalents
			if (NOT structkeyExists(server, "Transliterator")){
				server.transliterator = createObject("component","transliterator");
			}
			local.response = server.Transliterator.transliterate('Latin-ASCII; [:Nonspacing Mark:] Remove; NFC;', local.response);
		*/
		/* JUnidecode https://github.com/gcardone/junidecode
			if (not structkeyExists(server, "jUnidecodeLib")){
				server.jUnidecodeLib = createObject("java", "net.gcardone.junidecode.Junidecode");
			}
			local.response = server.jUnidecodeLib.unidecode( local.response );
			local.response = trim(replaceNoCase(local.response, "[?]", "", "all"));
		*/
		
		local.ext = "";
		if (listLen(local.response,".") gt 1){
			local.ext = trim(listLast(local.response, "."));
		}
		local.response = trim(reReplaceNoCase(local.response, local.windowsReservedRe, "", "one"));
		if (ListLen(local.response,".") gt 1){
			if ((len(local.response) - len(local.ext)-1) gt 0){
				local.response = left(local.response, len(local.response) - len(local.ext)-1);
			}
			local.ext = trim(reReplaceNoCase(local.ext, local.windowsReservedRe, "", "one"));
			local.ext = rereplace(local.ext, "[^A-Za-z0-9]", "", "all");
		}

		if (len(arguments.unsafeCharRegex)){
			local.response = local.response.replaceAll(arguments.unsafeCharRegex, arguments.replacementCharacter);
		}

		if (listFindNoCase(arguments.rules, "convertSpacesToUnderscores")){
			local.response = local.response.replaceAll(" ", "_");
		} else if (listFindNoCase(arguments.rules, "convertSpacesToDashes")){
			local.response = local.response.replaceAll(" ", "-");
		}
		if (listFindNoCase(arguments.rules, "convertDashToUnderscore")){
			local.response = local.response.replaceAll("[\-]", "_");
		} else 	if (listFindNoCase(arguments.rules, "convertUnderscoreToDash")){
			local.response = local.response.replaceAll("[\_]", "-");
		} else {
			if (listFindNoCase(arguments.rules, "noDash")){
				local.response = local.response.replaceAll("[\-]", arguments.replacementCharacter);
			}
			if (listFindNoCase(arguments.rules, "noUnderscore")){
				local.response = local.response.replaceAll("[\_]", arguments.replacementCharacter);
			}
		}
		if (listFindNoCase(arguments.rules, "forceLowercase")){
			local.response = lCase(local.response);
		} else if (listFindNoCase(arguments.rules, "forceUppercase")){
			local.response = uCase(local.response);
		}
		local.extLength = len( local.ext );
		if (local.extLength) local.extLength += 1;
		if (arguments.maxLength gt 0 and (len(local.response)+local.extLength) gt arguments.maxLength){
			local.response = left(local.response, arguments.maxLength - local.extLength);
		}
		if (not local.extLength and not len(local.response)){
			local.response = "";
		} else if (not local.extLength){
			/* no extension */
		} else {
			local.response = local.response & "." & lCase(local.ext);
		}
		return local.response;
	}

}			